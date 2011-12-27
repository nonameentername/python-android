#!/bin/bash

ROOTDIR=$(cd `dirname $BASH_SOURCE` && pwd)

PYTHONHOME="$ROOTDIR/prebuilt"
PYTHONPATH="$PYTHONHOME:$PYTHONHOME/lib/python2.7:$PYTHONHOME/lib/python2.7/site-packages"
LD_LIBRARY_PATH="$PYTHONHOME/lib/python2.7/lib-dynload"
export PATH="$ROOTDIR:$PYTHONHOME/bin:$PATH"

. virtualenvwrapper.sh
