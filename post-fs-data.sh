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

    #multispace#fingerprint=$(getprop ro.build.fingerprint)
    #multispace#if [ "$fingerprint" != "Lenovo/TB320FC/TB320FC:14/UKQ1.231025.001/ZUI_16.0.324_240718_ROW:user/release-keys" ]; then
    #multispace#    echo "이 모듈은 Lenovo Y700 2023 16.0 324 버전만 지원합니다. 다른 버전은 지원되지 않습니다."
    #multispace#    echo "This module only supports Lenovo 2023 16.0 version 324. Other versions are not supported."
    #multispace#    echo "Rolling back /system/framework..."
    #multispace#    rm -rf $MODDIR/system/framework
    #multispace#    echo "/system/framework has been rolled back."
    #multispace#else
    #multispace#    echo "Device compatibility check passed."
    #multispace#fi

    echo "[Device Compatibility Check] End"
} > /data/local/tmp/ZuiTweak-post-fs-data.log 2>&1

