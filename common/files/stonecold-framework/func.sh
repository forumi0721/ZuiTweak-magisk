#!/sbin/sh

run_jar() {
    local dalvikvm file main
    #Inspired in the osm0sis method
    if /system/bin/dalvikvm -showversion >/dev/null 2>&1; then 
       dalvikvm=/system/bin/dalvikvm
    elif dalvikvm -showversion >/dev/null 2>&1; then
       dalvikvm=dalvikvm
    else
       [ -z "$ANDROID_ART_ROOT" ] && ANDROID_ART_ROOT=$(find /apex -type d -name "com.android.art*" 2>/dev/null | head -n1)
       if [ -n "$ANDROID_ART_ROOT" ]; then
          dalvikvm=$(readlink -f "$(find "$ANDROID_ART_ROOT" \( -type f -o -type l \) -name "dalvikvm")")
          if [ -z "$dalvikvm" ]; then if $is64bit; then dalvikvm=$(find "$ANDROID_ART_ROOT" \( -type f -o -type l \) -name "dalvikvm64"); else dalvikvm=$(find "$ANDROID_ART_ROOT" \( -type f -o -type l \) -name "dalvikvm32"); fi; fi
       fi
       if ! $dalvikvm -showversion >/dev/null 2>&1; then
          echo "--------DALVIKVM LOGGING--------"
          if [ -f "$(readlink -f "$dalvikvm")" ]; then
             echo "$($dalvikvm -Xuse-stderr-logger -verbose:class,collector,compiler,deopt,gc,heap,interpreter,jdwp,jit,jni,monitor,oat,profiler,signals,simulator,startup,threads,verifier,verifier-debug,image,systrace-locks,plugin,agents,dex -showversion 2>&1)"
          else
             echo "Unable to find dalvikvm!"
             [ -d /apex ] && echo "$(find /apex -type f -name "dalvikvm*")"
          fi
          echo "--------------------------------"
          echo "CANT LOAD DALVIKVM " && return 1
       fi
    fi
    file="$1"
    if [ ! -f "$file" ]; then echo "CANT FIND: $file" && return 1; fi
    main=$(unzip -qp "$file" "META-INF/MANIFEST.MF" 2>/dev/null | grep -m1 "^Main-Class:" | cut -f2 -d: | tr -d " " | dos2unix)
    if [ -z "$main" ]; then
       echo "Cant get main: $file " && return 1
    fi
    shift 1;
    if ! $dalvikvm -Djava.io.tmpdir=. -Xnodex2oat -cp "$file" $main "$@" 2>/dev/null; then 
		$dalvikvm -Djava.io.tmpdir=. -Xnoimage-dex2oat -cp "$file" $main "$@"
	fi
}

apktool() {
   if [ ! -e /system/framework/framework-res.apk ]; then auto_mount_partitions; fi
   [ ! -f "$TMP/1.apk" ] && cp -f /system/framework/framework-res.apk "$TMP/1.apk"
   if [ ! -e "$TMP/apktool.jar" ]; then ui_print " Cant find apktool.jar " && return 1; fi
   run_jar "$TMP/apktool.jar" --aapt "$TMP/aapt" -p "$TMP" "$@"
}

