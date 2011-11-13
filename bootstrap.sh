#!/usr/bin/env sh

ROOTDIR=`pwd`

if [ ! -e 'Python-2.7.2.tgz' ]; then
    wget http://www.python.org/ftp/python/2.7.2/Python-2.7.2.tgz
fi

if [ ! -e 'Python-host' ]; then
    tar zxvf Python-2.7.2.tgz
    mv Python-2.7.2 Python-host
fi

if [ ! -e 'Python' ]; then
    tar zxvf Python-2.7.2.tgz
    mv Python-2.7.2 Python
    cd $ROOTDIR/Python
    patch -p1 < ../patch/Python-2.7.2-xcompile.patch
    patch -p1 < ../patch/Python-2.7.2-android.patch
fi

cd $ROOTDIR/Python-host
./configure --prefix=$ROOTDIR/prebuilt
make -j4
make install
mv python $ROOTDIR/hostpython
mv Parser/pgen $ROOTDIR/hostpgen
make distclean
