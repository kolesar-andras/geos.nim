#!/bin/sh

mkdir -p lib
mkdir -p src

cat /usr/include/geos_c.h \
| sed 's/GEOS_DLL //' \
| sed 's/GEOS_VERSION /GEOS_VERSION_FULL /' \
| sed 's/typedef struct [^ ]\+/typedef void*/' \
> lib/geos_c.h

toast --pnim --dynlib libgeos_c.so lib/geos_c.h > src/geos.nim

nim r tests/test.nim

if [ $? -eq 0 ]
then
    echo "success"
else
    echo "failure"
fi
