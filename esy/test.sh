
INCLUDE=$cur__install/include/harfbuzz

ROOTDIR=$(pwd)

if which x86_64-w64-mingw32-gcc; then
    CC=x86_64-w64-mingw32-gcc
    # Copy runtime mingw files
    BUILDDIR=$(pwd)/esy
    cp /usr/x86_64-w64-mingw32/sys-root/mingw/bin/*.dll $BUILDDIR/.
else
    CC=gcc
    BUILDDIR=$(pwd)/_build
fi

echo "Using build directory: $BUILDDIR"
echo "Root directory: $ROOTDIR"

cd $BUILDDIR
pwd

echo "Using compiler: $CC"

echo "Include Path: $INCLUDE"
echo "Lib Path: $cur__lib"
echo "Bin Path: $cur__bin"

cp $cur__bin/*.dll .

# Augment path to pick up libs
export PATH=$PATH:$cur__bin:$cur__lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$cur__lib

$CC $ROOTDIR/esy/test.c -o test.exe -std=c99 -I$INCLUDE -L$cur__lib -lharfbuzz
./test.exe $ROOTDIR/esy/Roboto-Regular.ttf "test=>text"
