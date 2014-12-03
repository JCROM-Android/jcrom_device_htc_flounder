#!/bin/sh

VENDOR=htc
DEVICE=flounder

echo "Please wait..."
wget -nc -q https://dl.google.com/dl/android/aosp/volantis-lrx22c-factory-8d83cd9b.tgz
tar zxf volantis-lrx22c-factory-8d83cd9b.tgz
rm volantis-lrx22c-factory-8d83cd9b.tgz
cd volantis-lrx22c
unzip image-volantis-lrx22c.zip
rm image-volantis-lrx22c.zip
cd ../
./simg2img volantis-lrx22c/vendor.img vendor.ext4.img
mkdir vendor
sudo mount -o loop -t ext4 vendor.ext4.img vendor
./simg2img volantis-lrx22c/system.img system.ext4.img
mkdir system
sudo mount -o loop -t ext4 system.ext4.img system

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*

for FILE in `cat proprietary-vendor-blobs.txt | grep -v ^# | grep -v ^$ | sed -e 's#^/system/##g'| sed -e "s#^-/system/##g"`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    cp ./$FILE $BASE/$FILE

done

for FILE in `cat proprietary-system-blobs.txt | grep -v ^# | grep -v ^$ | sed -e 's#^/system/##g'| sed -e "s#^-/system/##g"`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    cp ./$FILE $BASE/$FILE

done

./setup-makefiles.sh

sudo umount vendor
rm -rf vendor
sudo umount system
rm -rf system
rm -rf volantis-lrx22c
rm vendor.ext4.img
rm system.ext4.img
