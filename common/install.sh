# Device Compatibility Check
ui_print "==> Device Compatibility Check"
model="$(getprop ro.product.model | tr '[:lower:]' '[:upper:]')"
if [ "${model}" = "LENOVO TB-J606F" ]; then
	model="TBJ606F"
fi
region="$(getprop ro.config.lgsi.region | tr '[:lower:]' '[:upper:]')"
version=$(getprop ro.com.zui.version)
major_version=$(getprop ro.com.zui.version | sed -e 's/\..*$//g')
fingerprint=$(getprop ro.build.fingerprint)
debloat=$(getprop ro.stonecold.debloat.enabled)
if [ "${model}" != "TB320FC" -a "${model}" != "TB371FC" ]; then
	ui_print "이 모듈은 Lenovo Legion Y700 2023(TB320FC)/Xiaoxin Pad Pro 12.7(TB371FC) 만 지원합니다. 다른 모델은 지원되지 않습니다."
	ui_print "This module only supports Lenovo Legion Y700 2023(TB320FC)/Xiaoxin Pad Pro 12(TB371FC). Other models are not supported."
	abort "Installation aborted due to incompatible device."
fi
#if [ "${model}" = "TB371FC" ] && [ "${fingerprint}" != "Lenovo/TB371FC_PRC/TB371FC:13/TKQ1.221013.002/ZUI_15.0.664_240414_PRC:user/release-keys" -a "${fingerprint}" != "Lenovo/TB371FC_PRC/TB371FC:14/UKQ1.231222.001/ZUI_16.0.474_241129_PRC:user/release-keys" ]; then
#	ui_print "이 모듈은 Xiaoxin Pad Pro 12.7 ZUI15 664, ZUI16 474 버전만 지원합니다. 다른 버전은 지원되지 않습니다."
#	ui_print "This module only supports Xiaoxin Pad Pro 12.7 version ZUI15 664 or ZUI16 474. Other versions are not supported."
#	abort "Installation aborted due to incompatible device."
#fi
ui_print "Device model : ${model}"
ui_print "Device region : ${region}"
ui_print "Device version : ${version}"
ui_print "Device major version : ${major_version}"
ui_print "Device fingerprint : ${fingerprint}"
ui_print "Device compatibility check passed."
ui_print ""


# Disclaimer
ui_print "==> Disclaimer"
ui_print "Warning: This script may modify system files. By proceeding, you accept that the authors of this script are not responsible for any damage or issues that may occur to your device. Use at your own risk."
ui_print "경고: 이 스크립트는 시스템 파일을 수정할 수 있습니다. 계속 진행하면 이 스크립트의 작성자는 장치에 발생할 수 있는 손상이나 문제에 대해 책임지지 않는다는 것에 동의하는 것입니다. 사용에 따른 책임은 본인에게 있습니다."
ui_print ""
ui_print "Do you want to continue?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if ! chooseport; then
	abort "Installation aborted by the user."
fi
ui_print ""


# Preparation Step
ui_print "==> Preparation Step"
ui_print "Preparation is being configured..."


# Detect root environment
rm_tmp=N
environment=
system_path=
system_ext_path=
product_path=
vendor_path=
if [ -f "/data/adb/magisk/magiskinit" ]; then
	environment="magisk"
	system_path=$MODPATH/system
	system_ext_path=$MODPATH/system/system_ext
	product_path=$MODPATH/system/product
	vendor_path=$MODPATH/system/vendor
elif [ -d "/data/adb/ksu/bin/ksud" ]; then
	environment="kernelsu"
	system_path=$MODPATH/system
	system_ext_path=$MODPATH/system_ext
	product_path=$MODPATH/product
	vendor_path=$MODPATH/vendor
elif [ -f "/data/adb/ap/bin/apd" ]; then
	environment="apatch"
	system_path=$MODPATH/system
	system_ext_path=$MODPATH/system/system_ext
	product_path=$MODPATH/system/product
	vendor_path=$MODPATH/system/vendor
else
	abort "Unkown rooting method."
fi

ui_print "Preparation has been configured successfully."
ui_print ""


# Initialize step counter
STEP=0

#if [ "${model}" = "TB371FC" -o "${model}" = "TB320FC" ]; then
#	# Framework Patch Installation
#	STEP=$((STEP + 1))
#	ui_print "==> Step ${STEP}: Framework Patch Installation"
#	ui_print " Applies Framework patch. (Framework-patcher-GO)"
#	ui_print " Framework 패치를 적용합니다. (Framework-patcher-GO)"
#	ui_print "Do you want to apply the Framework patch?"
#	ui_print " - Vol Up   = Yes"
#	ui_print " - Vol Down = No"
#	if chooseport; then
#		framework_patch_choice="Y"
#	else
#		framework_patch_choice="N"
#	fi
#	ui_print ""
#fi

if [ "${model}" = "TB371FC" -a "${region}" = "PRC" ]; then
	# Korean Patch Installation
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Korean Patch Installation"
	ui_print " Applies Korean patch."
	ui_print " 한국어 패치를 적용합니다."
	ui_print "Do you want to apply the Korean patch?"
	ui_print " - Vol Up   = Yes"
	ui_print " - Vol Down = No"
	if chooseport; then
		korean_patch_choice="Y"
	else
		korean_patch_choice="N"
	fi
	ui_print ""
fi

if [ "${model}" = "TB371FC" -a "${region}" = "PRC" ]; then
	# Google Play Activation
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Google Play Activation"
	ui_print " Activates Google Play Services and installs Play Store."
	ui_print " 구글 플레이 서비스를 활성화하고 플레이스토어를 설치합니다."
	ui_print "Do you want to activate Google Play?"
	ui_print " - Vol Up   = Yes"
	ui_print " - Vol Down = No"
	if chooseport; then
		google_play_choice="Y"
	else
		google_play_choice="N"
	fi
	ui_print ""
fi

if [ "${debloat}" != "true" ]; then
	# Disable/Uninstall Unused Apps
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Disable/Uninstall Unused Apps"
	ui_print " Disables or uninstalls unused apps."
	ui_print " 불필요한 앱을 비활성화하거나 제거합니다."
	ui_print "Do you want to disable/uninstall unused apps?"
	ui_print " - Vol Up   = Yes"
	ui_print " - Vol Down = No"
	if chooseport; then
		debloat_apps_choice="Y"
	else
		debloat_apps_choice="N"
	fi
	ui_print ""
fi

if [ "${model}" = "TB371FC" ]; then
	# Keyboard Mapping Change
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Keyboard Mapping Change"
	ui_print " Applies keyboard mapping change for BACK->ESC, DELETE->BACK."
	ui_print " 순정 키보드 BACK->ESC, DELETE->BACK 맵핑 변경을 적용합니다."
	ui_print "Do you want to apply the keyboard mapping change?"
	ui_print " - Vol Up   = Yes"
	ui_print " - Vol Down = No"
	if chooseport; then
		keyboard_mapping_choice="Y"
	else
		keyboard_mapping_choice="N"
	fi
	ui_print ""
fi

if [ "${model}" = "TB371FC" ]; then
	# Pen Service Activation
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Pen Service Activation"
	ui_print " Activates Pen Service."
	ui_print " AP500U 사용을 위해 펜 서비스를 활성화합니다."
	ui_print "Do you want to activate Pen Service?"
	ui_print " - Vol Up   = Yes"
	ui_print " - Vol Down = No"
	if chooseport; then
		pen_service_choice="Y"
	else
		pen_service_choice="N"
	fi
	ui_print ""
fi

if [ "${model}" = "TB320FC" -a "${region}" = "ROW" ] && [ "${major_version}" = "15" -o "${major_version}" = "16" ]; then
	# Multiple Space Activation
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Multiple Space Activation"
	ui_print " Activates Multiple Space."
	ui_print " 복제 공간(분신 공간)을 활성화합니다."
	ui_print "Do you want to activate Multiple Space?"
	ui_print " - Vol Up   = Yes"
	ui_print " - Vol Down = No"
	if chooseport; then
		multiple_space_choice="Y"
	else
		multiple_space_choice="N"
	fi
	ui_print ""
fi

# Force Apply Widevine L3 for DRM Playback
STEP=$((STEP + 1))
ui_print "==> Step ${STEP}: Force Apply Widevine L3 for DRM Playback"
ui_print " Applies Widevine L3 for DRM content playback."
ui_print " Bootloader unlock 상태에서 DRM 콘텐츠 재생을 위해 Widevine L3를 적용합니다."
ui_print "Do you want to apply Widevine L3?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if chooseport; then
	widevine_choice="Y"
else
	widevine_choice="N"
fi
ui_print ""

# Bootanimation Replacement
STEP=$((STEP + 1))
ui_print "==> Step ${STEP}: Bootanimation Replacement"
ui_print " Replaces the boot animation."
ui_print " 부트 애니메이션을 교체합니다."
ui_print "Do you want to replace the Bootanimation?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if chooseport; then
	bootanimation_choice="Y"
else
	bootanimation_choice="N"
fi
ui_print ""


# Summary of Choices
ui_print "==> Summary of Choices"
if [ ! -z "${framework_patch_choice}" ]; then
	ui_print "$(printf " %-50s : %s\n" "Framework Patch Installation" "${framework_patch_choice}")"
fi
if [ ! -z "${korean_patch_choice}" ]; then
	ui_print "$(printf " %-50s : %s\n" "Korean Patch Installation" "${korean_patch_choice}")"
fi
if [ ! -z "${google_play_choice}" ]; then
	ui_print "$(printf " %-50s : %s\n" "Google Play Activation" "${google_play_choice}")"
fi
if [ ! -z "${debloat_apps_choice}" ]; then
	ui_print "$(printf " %-50s : %s\n" "Disable/Uninstall Unused Apps" "${debloat_apps_choice}")"
fi
if [ ! -z "${keyboard_mapping_choice}" ]; then
	ui_print "$(printf " %-50s : %s\n" "Keyboard Mapping Change" "${keyboard_mapping_choice}")"
fi
if [ ! -z "${pen_service_choice}" ]; then
	ui_print "$(printf " %-50s : %s\n" "Pen Service Activation" "${pen_service_choice}")"
fi
if [ ! -z "${multiple_space_choice}" ]; then
	ui_print "$(printf " %-50s : %s\n" "Multiple Space Activation" "${multiple_space_choice}")"
fi
if [ ! -z "${widevine_choice}" ]; then
	ui_print "$(printf " %-50s : %s\n" "Force Apply Widevine L3 for DRM Playback" "${widevine_choice}")"
fi
if [ ! -z "${bootanimation_choice}" ]; then
	ui_print "$(printf " %-50s : %s\n" "Bootanimation Replacement" "${bootanimation_choice}")"
fi
ui_print ""
ui_print "Are these choices correct?"
ui_print " - Vol Up   = Yes"
ui_print " - Vol Down = No"
if ! chooseport; then
	abort "Installation aborted by the user."
fi
ui_print ""


# Configuration based on choices
ui_print "==> Applying configurations based on your choices"
ui_print ""


# Initialize step counter
STEP=0


# Framework Patch Installation
if [ ! -z "${framework_patch_choice}" ]; then
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Framework Patch Installation"
	if [ "${framework_patch_choice}" = "Y" ]; then
		ui_print "Installing Framework Patch..."
		ui_print "Framework patch installation complete."
	else
		ui_print "Framework patch installation skipped."
	fi
	ui_print ""
fi

# Korean Patch Installation
if [ ! -z "${korean_patch_choice}" ]; then
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Korean Patch Installation"
	if [ "${korean_patch_choice}" = "Y" ]; then
		ui_print "Installing Korean Patch..."
		ui_print " - system.prop"
		cat $MODPATH/common/files/stonecold-kr/system.prop >> $MODPATH/system.prop
		ui_print " - post-fs-data.sh"
		sed -i -e 's/#locale#//g' $MODPATH/post-fs-data.sh
		ui_print " - service.sh"
		sed -i -e 's/#locale#//g' $MODPATH/service.sh
		#mkdir -p ${system_path}/framework
		#for framework in $MODPATH/common/files/stonecold-kr/*.jar
		#do
		#	ui_print " - $(basename "${framework}")"
		#	cp -a ${framework} ${system_path}/framework/
		#done
		if [ -e $MODPATH/common/files/stonecold-kr/${major_version} ]; then
			mkdir -p ${product_path}/overlay
			for rro in $MODPATH/common/files/stonecold-kr/${major_version}/*.apk
			do
				ui_print " - /product/overlay/$(basename "${rro}")"
				bn=$(basename "${rro}")
				to_name=StoneColdOverlay${bn/.apk/}.apk
				if [ "${bn}" = "framework-res.apk" ]; then
					to_name=StoneColdOverlayFrameworkRes.apk
				fi
				cp -a ${rro} ${product_path}/overlay/${to_name}
			done
		fi
		ui_print "Korean patch installation complete."
	else
		ui_print "Korean patch installation skipped."
	fi
	ui_print ""
fi
sed -i '/#locale#/d' $MODPATH/post-fs-data.sh
sed -i '/#locale#/d' $MODPATH/service.sh

# Google Play Activation
STEP=$((STEP + 1))
if [ ! -z "${google_play_choice}" ]; then
	ui_print "==> Step ${STEP}: Google Play Activation"
	if [ "${google_play_choice}" = "Y" ]; then
		ui_print "Activating Google Play..."
		#pm list packages -d | grep -E 'com.google.android.gsf|com.android.vending|com.google.android.partnersetup|com.google.android.printservice.recommendation|com.google.android.ext.shared|com.google.android.onetimeinitializer|com.google.android.configupdater|com.google.android.gms|com.android.vending' | sed -e 's/^.*package://g' | while read -r pkg
		pm list packages -d | grep -E 'com.google.android.gsf|com.android.vending|com.google.android.printservice.recommendation|com.google.android.ext.shared|com.google.android.onetimeinitializer|com.google.android.configupdater|com.google.android.gms|com.android.vending' | sed -e 's/^.*package://g' | while read -r pkg
		do
			ui_print " - ${pkg}"
			pm enable ${pkg}
		done
		#sleep 2
		#if [ "$(pm path com.android.vending)" = "package:/product/priv-app/GooglePlayServicesUpdater/GooglePlayServicesUpdater.apk" ]; then
		#	ui_print " - com.android.vending"
		#	#if [ "${environment}" = "apatch" ]; then
		#	#	pm install -r $MODPATH/common/files/stonecold-playstore/com.android.vending.apk
		#	#else
		#	#	mkdir -p ${product_path}/priv-app/GooglePlay
		#	#	cp $MODPATH/common/files/stonecold-playstore/com.android.vending.apk ${product_path}/priv-app/GooglePlay/GooglePlay.apk
		#	#	if [ "${environment}" = "magisk" ]; then
		#	#		mkdir -p ${product_path}/priv-app/GooglePlayServicesUpdater
		#	#		touch ${product_path}/priv-app/GooglePlayServicesUpdater/.replace
		#	#	else
		#	#		mkdir -p ${product_path}/priv-app
		#	#		mknod ${product_path}/priv-app/GooglePlayServicesUpdater c 0 0
		#	#		#touch ${product_path}/priv-app/GooglePlayServicesUpdater
		#	#		#chmod 000 ${product_path}/priv-app/GooglePlayServicesUpdater
		#	#	fi
		#	#fi
		#	pm install -r $MODPATH/common/files/stonecold-playstore/com.android.vending.apk
		#fi
		ui_print " - com.android.vending"
		if [ "${environment}" = "magisk" ]; then
			mkdir -p ${product_path}/priv-app/GooglePlayServicesUpdater
			touch ${product_path}/priv-app/GooglePlayServicesUpdater/.replace
		else
			mkdir -p ${product_path}/priv-app
			mknod ${product_path}/priv-app/GooglePlayServicesUpdater c 0 0
		fi
		#mkdir -p ${product_path}/priv-app/Phonesky
		cp $MODPATH/common/files/stonecold-playstore/com.android.vending.apk /sdcard/Phonesky.apk
		#cp $MODPATH/common/files/stonecold-playstore/com.android.vending.apk ${product_path}/priv-app/Phonesky/Phonesky.apk
		#dex2oat64 --dex-file=${product_path}/priv-app/Phonesky/Phonesky.apk --oat-file=${product_path}/priv-app/Phonesky/Phonesky.odex
		#mkdir -p ${product_path}/priv-app/Phonesky/oat/arm64
		#mv ${product_path}/priv-app/Phonesky/Phonesky.odex ${product_path}/priv-app/Phonesky/Phonesky.vdex ${product_path}/priv-app/Phonesky/oat/arm64/
		#mkdir -p ${product_path}/priv-app/Phonesky/lib/arm64
		#cp -a $MODPATH/common/files/stonecold-playstore/lib/arm64/* ${product_path}/priv-app/Phonesky/lib/arm64/
		#chmod 644 ${product_path}/priv-app/Phonesky/lib/arm64/*
		ui_print " - /product/etc/permissions/services.cn.google.xml"
		mkdir -p ${product_path}/etc/permissions
		cp $MODPATH/common/files/stonecold-playstore/services.cn.google.xml ${product_path}/etc/permissions/
		ui_print "Google Play activation complete."
	else
		ui_print "Google Play activation skipped."
	fi
	ui_print ""
fi

# Disable/Uninstall Unused Apps
if [ ! -z "${debloat_apps_choice}" ]; then
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Disable/Uninstall Unused Apps"
	if [ "${debloat_apps_choice}" = "Y" ]; then
		#User Packages (visible)
		ui_print "Disabling/Uninstalling Unused Apps..."
		ui_print " - system.prop"
		cat $MODPATH/common/files/stonecold-debloat/system.prop >> $MODPATH/system.prop
		pkgs3="cn.wps.moffice_eng com.baidu.netdisk com.google.android.apps.books com.google.android.apps.youtube.kids com.google.android.play.games com.lenovo.club.app com.lenovo.hyperengine com.lenovo.menu_assistant com.motorola.mobiledesktop com.myscript.calculator.lenovo com.myscript.nebo.lenovo com.newskyer.draw com.qiyi.video.pad com.sina.weibo com.smile.gifmaker com.sohu.inputmethod.sogou.oem com.tencent.qqmusic com.zui.calculator com.zui.calendar com.zui.calendar.overlay.avengers com.zui.calendar.overlay.blue com.zui.calendar.overlay.golden com.zui.calendar.overlay.grace com.zui.calendar.overlay.mains com.zui.calendar.overlay.mostbeautiful com.zui.calendar.overlay.paintingr com.zui.calendar.overlay.pink com.zui.calendar.overlay.superhero com.zui.recorder com.zui.weather io.moreless.tide net.huanci.hsjpro"
		pm list packages -3 | grep -E "$(echo "${pkgs3}" | sed -e 's/ /|/g')" | sed -e 's/^.*package://g' | while read -r pkg
		do
			ui_print " - ${pkg} (user)"
			pm uninstall ${pkg}
		done

		pkgs=
		if [ "${model}" = "TB320FC" ]; then
			pkgs="com.android.dreams.phototable com.google.android.apps.nbu.files com.google.android.calendar com.google.android.contacts com.google.android.accessibility.switchaccess com.google.android.gm com.google.android.apps.tachyon com.lenovo.weathercenter com.google.android.apps.youtube.kids com.lenovo.hec.lenovoextend com.google.android.apps.mediahome.launcher com.google.android.partnersetup com.google.android.videos com.google.android.feedback com.google.android.apps.maps com.google.android.apps.docs com.tblenovo.center com.google.android.apps.safetyhub com.lenovo.rt com.google.android.apps.messaging com.google.android.apps.kids.home com.motorola.mobiledesktop"
		elif [ "${model}" = "TB371FC" ]; then
			pkgs="com.lenovo.lsf.device com.lenovo.leos.cloud.sync com.zui.udevice com.tblenovo.lenovowhatsnew com.zui.clone com.zui.contacts com.zui.engine com.google.android.partnersetup com.lenovo.browser.hd com.lenovo.lfh.tianjiao.tablet com.lenovo.lsf com.baidu.map.location com.zui.filemanager com.lenovo.leos.appstore com.lenovo.levoice.caption com.motorola.readyforsignature.app com.zui.xlog android.autoinstalls.config.Lenovo.tablet com.lenovo.levoice_agent com.lenovo.levoice.trigger"
		elif [ "${model}" = "TBJ606F" ]; then
			pkgs="com.google.android.apps.subscriptions.red com.google.android.gm com.google.android.apps.tachyon com.google.android.apps.docs com.google.android.apps.maps com.google.android.apps.kids.home com.google.android.contacts com.google.android.partnersetup com.google.android.videos com.netflix.mediaclient com.google.android.calendar com.google.android.apps.books com.google.android.keep com.google.android.apps.mediahome.launcher com.tblenovo.center com.google.android.apps.googleassistant"
		fi

		pm list packages | grep -E "$(echo "${pkgs}" | sed -e 's/ /|/g')" | sed -e 's/^.*package://g' | while read -r pkg
		do
			ui_print " - ${pkg} (system)"
			pm_path="$(pm path "${pkg}")"
			if [ "${pm_path}" != "$(echo "${pm_path}" | sed -e 's/^\/data\//g')" ]; then
				pm uninstall ${pkg}
			fi
			pm_path="$(pm path "${pkg}")"
			if [ "${pm_path}" = "$(echo "${pm_path}" | sed -e 's/^\/data\//g')" ]; then
				pm uninstall --user 0 ${pkg}
				pm disable-user --user 0 ${pkg}
			fi
		done

		ui_print "Unused apps disable/uninstall complete."
	else
		ui_print "Unused apps disable/uninstall skipped."
	fi
	ui_print ""
fi

# Keyboard Mapping Change
if [ ! -z "${keyboard_mapping_choice}" ]; then
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Keyboard Mapping Change"
	if [ "${keyboard_mapping_choice}" = "Y" ]; then
		ui_print "Applying keyboard mapping change..."
		ui_print " - /system/usr/keylayout/Vendor_17ef_Product_6175.kl"
		mkdir -p ${system_path}/usr/keylayout
		cp -a $MODPATH/common/files/stonecold-keylayout/Vendor_17ef_Product_6175.kl ${system_path}/usr/keylayout/Vendor_17ef_Product_6175.kl
		ui_print "Keyboard mapping change applied."
	else
		ui_print "Keyboard mapping change skipped."
	fi
	ui_print ""
fi

# Pen Service Activation
if [ ! -z "${pen_service_choice}" ]; then
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Pen Service Activation"
	if [ "${pen_service_choice}" = "Y" ]; then
		ui_print "Activating Pen Service..."
		ui_print " - system.prop"
		cat $MODPATH/common/files/stonecold-penservice/system.prop >> $MODPATH/system.prop
		ui_print " - service.sh"
		sed -i -e 's/#penservice#//g' $MODPATH/service.sh
		ui_print "Pen Service activation complete."
	else
		ui_print "Pen Service activation skipped."
	fi
	ui_print ""
fi
sed -i '/#penservice#/d' $MODPATH/service.sh

# Multiple Space Activation
if [ ! -z "${multiple_space_choice}" ]; then
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Multiple Space Activation"
	if [ "${multiple_space_choice}" = "Y" ]; then
		ui_print "Activating Multiple Space..."
		ui_print " - system.prop"
		cat $MODPATH/common/files/stonecold-multiplespace/system.prop >> $MODPATH/system.prop
		if [ "${major_version}" = "15" ]; then
			cat $MODPATH/common/files/stonecold-multiplespace/ZUI_15.0.prop >> $MODPATH/system.prop
			mkdir -p ${product_path}/overlay
			ui_print " - /product/overlay/ZuiSettingsMultipleSpace.apk"
			cp -a $MODPATH/common/files/stonecold-multiplespace/ZuiSettingsMultipleSpace.apk ${product_path}/overlay/
		else
			ui_print " - post-fs-data.sh"
			sed -i -e 's/#multispace#//g' $MODPATH/post-fs-data.sh
		fi
		ui_print "Multiple Space activation complete."
	else
		ui_print "Multiple Space activation skipped."
	fi
	ui_print ""
fi
sed -i '/#multispace#/d' $MODPATH/post-fs-data.sh

# Force Apply Widevine L3 for DRM Playback
if [ ! -z "${widevine_choice}" ]; then
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Force Apply Widevine L3 for DRM Playback"
	if [ "${widevine_choice}" = "Y" ]; then
		ui_print "Applying Widevine L3..."
		if [ -e /vendor/lib/liboemcrypto.so -o -e /system/vendor/lib/liboemcrypto.so ]; then
			ui_print " - /vendor/lib/liboemcrypto.so"
			mkdir -p ${vendor_path}/lib
			touch ${vendor_path}/lib/liboemcrypto.so
		fi
		if [ -e /vendor/lib64/liboemcrypto.so -o -e /system/vendor/lib64/liboemcrypto.so ]; then
			ui_print " - /vendor/lib64/liboemcrypto.so"
			mkdir -p ${vendor_path}/lib64
			touch ${vendor_path}/lib64/liboemcrypto.so
		fi
		ui_print "Widevine L3 applied."
	else
		ui_print "Widevine L3 application skipped."
	fi
	ui_print ""
fi

# Bootanimation Replacement
if [ ! -z "${bootanimation_choice}" ]; then
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Bootanimation Replacement"
	if [ "${bootanimation_choice}" = "Y" ]; then
		ui_print "Replacing bootanimation..."
		if [ -e "/product/media/bootanimation.zip" ]; then
			ui_print " - /product/media/bootanimation.zip"
			mkdir -p ${product_path}/media
			cp -a $MODPATH/common/files/stonecold-bootanimation/bootanimation.zip ${product_path}/media/
		else
			ui_print " - /system/media/bootanimation.zip"
			mkdir -p ${system_path}/media
			cp -a $MODPATH/common/files/stonecold-bootanimation/bootanimation.zip ${system_path}/media/
		fi
		ui_print "Bootanimation replacement complete."
	else
		ui_print "Bootanimation replacement skipped."
	fi
	ui_print ""
fi

# Framework patcher
if [ "${framework_patch_choice}" = "Y" ] || [ "${major_version}" = "15" -a "${korean_patch_choice}" = "Y" ] || [ "${multiple_space_choice}" = "Y" -a "${model}" = "TB320FC" -a "${region}" = "ROW" -a "${major_version}" = "16" ]; then
	STEP=$((STEP + 1))
	ui_print "==> Step ${STEP}: Framework patch"
	ui_print "Installing Framework Patch..."
	framework_patched=N
	if [ "${framework_patch_choice}" = "Y" ] || [ "${major_version}" = "15" -a "${korean_patch_choice}" = "Y" ] || [ "${multiple_space_choice}" = "Y" -a "${model}" = "TB320FC" -a "${region}" = "ROW" -a "${major_version}" = "16" ]; then
		ui_print " - /system/framework/framework.jar"
		multispace_patch="$([ "${multiple_space_choice}" = "Y" -a "${model}" = "TB320FC" -a "${region}" = "ROW" -a "${major_version}" = "16" ] && echo "Y" || echo "N")"
		korean_patch="$([ "${major_version}" = "15" -a "${korean_patch_choice}" = "Y" ] && echo "Y" || echo "N")"
		rm -rf /data/local/tmp/framework-patch
		cp -a $MODPATH/common/files/stonecold-framework /data/local/tmp/framework-patch
		. /data/local/tmp/framework-patch/framework-go ${korean_patch:-N} ${multispace_patch:-N} ${framework_patch_choice:-N}
		if [ -e /data/local/tmp/framework-patch/framework-patched.jar ]; then
			framework_patched=Y
			mkdir -p ${system_path}/framework
			cp -a /data/local/tmp/framework-patch/framework-patched.jar ${system_path}/framework/framework.jar
		fi
		if [ "${rm_tmp}" = "Y" ]; then
			rm -rf /data/local/tmp/framework-patch
		fi
	fi
	if [ "${korean_patch}" = "Y" ]; then
		ui_print " - /system/framework/services.jar"
		rm -rf /data/local/tmp/services-patch
		cp -a $MODPATH/common/files/stonecold-framework /data/local/tmp/services-patch
		. /data/local/tmp/services-patch/services-go ${korean_patch:-N}
		if [ -e /data/local/tmp/services-patch/services-patched.jar ]; then
			framework_patched=Y
			mkdir -p ${system_path}/framework
			cp -a /data/local/tmp/services-patch/services-patched.jar ${system_path}/framework/services.jar
		fi
		if [ "${rm_tmp}" = "Y" ]; then
			rm -rf /data/local/tmp/services-patch
		fi
	fi
	if [ "${framework_patched}" = "Y" ]; then
		rm -rf /data/dalvik-cache/arm64/system@framework@*
		rm -rf /data/dalvik-cache/arm/system@framework@*
		rm -rf /data/dalvik-cache/arm64/system@services@*
		rm -rf /data/dalvik-cache/arm/system@services@*
		mkdir -p $MODPATH/system/framework $MODPATH/system/framework/arm64 $MODPATH/system/framework/arm
		if [ "${environment}" = "magisk" ]; then
			touch $MODPATH/system/framework/boot-framework.vdex
			touch $MODPATH/system/framework/arm64/boot-framework.art
			touch $MODPATH/system/framework/arm64/boot-framework.oat
			touch $MODPATH/system/framework/arm/boot-framework.art
			touch $MODPATH/system/framework/arm/boot-framework.oat
		else
			mknod $MODPATH/system/framework/boot-framework.vdex c 0 0
			mknod $MODPATH/system/framework/arm64/boot-framework.art c 0 0
			mknod $MODPATH/system/framework/arm64/boot-framework.oat c 0 0
			mknod $MODPATH/system/framework/arm64/boot-framework.vdex c 0 0
			mknod $MODPATH/system/framework/arm/boot-framework.art c 0 0
			mknod $MODPATH/system/framework/arm/boot-framework.oat c 0 0
			mknod $MODPATH/system/framework/arm/boot-framework.vdex c 0 0
		fi
		find /system/framework -type f -name 'boot-framework.*' | while read -r l
		do
			if [ -e $MODPATH/${l} ]; then
				continue
			fi
			mkdir -p $(dirname ${MODPATH}/${l})
			if [ "${environment}" = "magisk" ]; then
				touch $MODPATH/${l}
			else
				mknod $MODPATH/${l} c 0 0
			fi
		done
	fi
	ui_print "Framework patch installation complete."
	ui_print ""
fi


# Finalization Step
ui_print "==> Finalization Step"
ui_print "Finalizing the setup..."
rm -rf $MODPATH/zygisk $MODPATH/Makefile $MODPATH/update.json
chmod 755 $MODPATH/*.sh
if [ "${korean_patch_choice}" = "Y" ]; then
	settings put system system_locales 'ko-KR'
	settings put global device_name "Xiaoxin Pad Pro 12.7"
fi
if [ "${navbar_button_choice}" = "Y" ]; then
	rm -rf /data/dalvik-cache/arm64/system_ext@priv-app@SystemUI@SystemUI.apk@*
fi
if [ "${debloat}" = "true" ]; then
	cat $MODPATH/common/files/stonecold-debloat/system.prop >> $MODPATH/system.prop
fi
ui_print "Setup has been finalized successfully."
ui_print ""


# Additional Information
ui_print "==> Additional Information"
ui_print " To ensure all features work correctly, please install the Xposed module ZuiTweak."
ui_print " 모든 기능이 정상적으로 동작하려면 Xposed 모듈 ZuiTweak을 설치해야 합니다."
ui_print ""

if [ "${google_play_choice}" = "Y" ]; then
	ui_print " Please manually install /sdcard/Phonesky.apk to install the Google Play Store."
	ui_print " Google Play Store 설치를 위하여 /sdcard/Phonesky.apk를 수동으로 설치하세요."
	ui_print ""
fi


# Configuration complete
ui_print "All configurations have been applied successfully."
ui_print "모든 설정이 성공적으로 적용되었습니다."

