#!/bin/sh

VENDOR=htc
DEVICE=flounder

echo "Please wait..."
wget -nc -q https://dl.google.com/dl/android/aosp/volantis-lrx21q-factory-10521789.tgz
tar zxf volantis-lrx21q-factory-10521789.tgz
rm volantis-lrx21q-factory-10521789.tgz
cd volantis-lrx21q
unzip image-volantis-lrx21q.zip
rm image-volantis-lrx21q.zip
cd ../
./simg2img volantis-lrx21q/vendor.img vendor.ext4.img
mkdir vendor
sudo mount -o loop -t ext4 vendor.ext4.img vendor
./simg2img volantis-lrx21q/system.img system.ext4.img
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
rm -rf volantis-lrx21q
rm vendor.ext4.img
rm system.ext4.img
