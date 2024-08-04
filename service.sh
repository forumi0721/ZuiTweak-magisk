#!/system/bin/sh

MODDIR=${0%/*}

{
    echo "Start at $(date '+%Y-%m-%d %H:%M:%S')"

    until [[ "$(getprop sys.boot_completed)" == "1" ]]; do
        sleep 1
    done

    echo "Boot completed at $(date '+%Y-%m-%d %H:%M:%S')"

    #locale#settings put system system_locales 'ko-KR'

    #locale#rm -rf /data/data/com.zui.desktoplauncher/databases/global_search.db
    #locale#rm -rf /data/data/com.zui.launcher/databases/global_search.db
    #locale#rm -rf /data/user/*/com.zui.desktoplauncher/databases/global_search.db
    #locale#rm -rf /data/user/*/com.zui.launcher/databases/global_search.db

    #penservice#[ -z "$(resetprop -v persist.sys.lenovo.pen.sn)" ] && resetprop -v -n persist.sys.lenovo.pen.sn 00000000
    #penservice#[ -z "$(resetprop -v persist.vendor.pen)" ] && resetprop -v -n persist.vendor.pen 1,1

    echo "End at $(date '+%Y-%m-%d %H:%M:%S')"
} > /data/local/tmp/ZuiTweak-service.log 2>&1

