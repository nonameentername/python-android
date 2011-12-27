#!/usr/bin/env sh

if [ $# -ne 1 ]; then
    echo "Usage: ./package.sh <namespace>"
    exit 0
fi

export ROOTDIR=$(dirname $(readlink -f $0))
export PACKAGE=$1

yes | rm -r $ROOTDIR/release/$PACKAGE

mkdir -p $ROOTDIR/release/$PACKAGE/files/python/bin
mkdir -p $ROOTDIR/release/$PACKAGE/files/python/include
mkdir -p $ROOTDIR/release/$PACKAGE/files/python/lib/python2.7/lib-dynload
mkdir -p $ROOTDIR/release/$PACKAGE/files/python/lib/python2.7/config
mkdir -p $ROOTDIR/release/$PACKAGE/extras/python

cat $ROOTDIR/standalone_python.sh | sed -e s"/<PACKAGE>/$PACKAGE/g" > $ROOTDIR/release/$PACKAGE/files/python/bin/standalone_python.sh
cp -r $ROOTDIR/build/bin/python $ROOTDIR/release/$PACKAGE/files/python/bin/python
cp -r $ROOTDIR/build/include/* $ROOTDIR/release/$PACKAGE/files/python/include/
cp -r $ROOTDIR/build/lib/libpython2.7.so $ROOTDIR/release/$PACKAGE/files/python/lib/libpython2.7.so
cp -r $ROOTDIR/libs/armeabi/libsqlite3.so $ROOTDIR/release/$PACKAGE/files/python/lib/libsqlite3.so
cp -r $ROOTDIR/build/lib/python2.7/lib-dynload/* $ROOTDIR/release/$PACKAGE/files/python/lib/python2.7/lib-dynload/
cp -r $ROOTDIR/build/lib/python2.7/config/* $ROOTDIR/release/$PACKAGE/files/python/lib/python2.7/config/
cp -r $ROOTDIR/build/lib/python2.7/* $ROOTDIR/release/$PACKAGE/extras/python/

#virtualenv
cp -r $VIRTUAL_ENV/lib/python2.7/site-packages $ROOTDIR/release/$PACKAGE/files/python/lib/python2.7/site-packages

cd $ROOTDIR/release/$PACKAGE/extras/python/
rm `find . | grep -v "so$\|py$"`
rm -r `find . | grep test`

adb push $ROOTDIR/release/$PACKAGE/files/ /data/data/$PACKAGE/files
adb push $ROOTDIR/release/$PACKAGE/extras/ /mnt/sdcard/$PACKAGE/extras
