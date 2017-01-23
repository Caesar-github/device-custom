#! /bin/sh

TOP_DIR=$(pwd)
BUILDROOT_TARGET_PATH=$(pwd)/../../../buildroot/output/target/

#gpu
rm $BUILDROOT_TARGET_PATH/usr/lib/libwayland-egl.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libgbm.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libEGL.so*
rm $BUILDROOT_TARGET_PATH/usr/lib/libGLESv*
cp -d lib/gpu/* $BUILDROOT_TARGET_PATH/usr/lib/

#sd udisk..
mkdir -p $BUILDROOT_TARGET_PATH/mnt/sdcard/
mkdir -p $BUILDROOT_TARGET_PATH/mnt/udisk/
cp $(pwd)/etc/mount-sdcard.sh $BUILDROOT_TARGET_PATH/etc/
cp $(pwd)/etc/mount-udisk.sh $BUILDROOT_TARGET_PATH/etc/
cp $(pwd)/etc/umount-sdcard.sh $BUILDROOT_TARGET_PATH/etc/
cp $(pwd)/etc/umount-udisk.sh $BUILDROOT_TARGET_PATH/etc/
cp $(pwd)/etc/udev/rules.d/add-sdcard-udisk.rules  $BUILDROOT_TARGET_PATH/etc/udev/rules.d/
cp $(pwd)/etc/udev/rules.d/remove-sdcard-udisk.rules  $BUILDROOT_TARGET_PATH/etc/udev/rules.d/

#adb
cp $(pwd)/adb/adbd $BUILDROOT_TARGET_PATH/usr/bin/
cp $(pwd)/adb/adb_config $BUILDROOT_TARGET_PATH/usr/bin/
cp $(pwd)/adb/S30adbd $BUILDROOT_TARGET_PATH/etc/init.d/
cp $(pwd)/adb/adb-udev.rules $BUILDROOT_TARGET_PATH/etc/udev/rules.d/
cp $(pwd)/adb/libcutils.so $BUILDROOT_TARGET_PATH/usr/lib/

cp S50rk3399init $BUILDROOT_TARGET_PATH/etc/init.d/
cp alsa_conf/rt5651/alsa.conf $BUILDROOT_TARGET_PATH/usr/share/alsa/alsa.conf

#wifi firmware
mkdir -p $BUILDROOT_TARGET_PATH/system/etc
cp -rf firmware $BUILDROOT_TARGET_PATH/system/etc/
cp -rf etc/dnsmasq.conf $BUILDROOT_TARGET_PATH/etc/

#libs for vpudec plugin,mpp decoder
cp bin/mpp_test/* $BUILDROOT_TARGET_PATH/usr/bin/
cp lib/mpp/* $BUILDROOT_TARGET_PATH/usr/lib/
cp lib/gst-rk/librockchip_mpp.so* $BUILDROOT_TARGET_PATH/usr/lib
cp lib/gst-rk/librockchip_vpu.so* $BUILDROOT_TARGET_PATH/usr/lib
cp lib/gst-rk/libgstvpudec.so $BUILDROOT_TARGET_PATH/usr/lib/gstreamer-1.0/
cp lib/gst-rk/libgstrkvideo.so $BUILDROOT_TARGET_PATH/usr/lib/gstreamer-1.0/
