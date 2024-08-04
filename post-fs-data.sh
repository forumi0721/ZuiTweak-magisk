#!/bin/sh

MODDIR=${0%/*}

{
    echo "[Device Compatibility Check] Start"

    #locale#fingerprint=$(getprop ro.build.fingerprint)
    #locale#if [ "$fingerprint" != "Lenovo/TB371FC_PRC/TB371FC:13/TKQ1.221013.002/ZUI_15.0.664_240414_PRC:user/release-keys" ]; then
    #locale#    echo "이 모듈은 Xiaoxin Pad Pro 12.7 664 버전만 지원합니다. 다른 버전은 지원되지 않습니다."
    #locale#    echo "This module only supports Xiaoxin Pad Pro 12.7 version 664. Other versions are not supported."

    #locale#    echo "Rolling back /system/framework..."
    #locale#    rm -rf $MODDIR/system/framework
    #locale#    echo "/system/framework has been rolled back."
    #locale#else
    #locale#    echo "Device compatibility check passed."
    #locale#fi

    echo "[Device Compatibility Check] End"
} > /data/local/tmp/ZuiTweak-post-fs-data.log 2>&1

