cd _build

INSTALL_PATH="$(cygpath -u $cur__install)"

echo "Install: $INSTALL_PATH"

cmake -G "Unix Makefiles" ../harfbuzz-1.9.0 -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++ -DCMAKE_LINKER=/usr/bin/x86_64-w64-mingw32-ld -DCMAKE_AR=/usr/bin/x86_64-w64-mingw32-ar -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH
