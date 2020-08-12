cd _build

INSTALL_PATH="$(cygpath -u $cur__install)"

./configure --prefix=$cur__install --host=x86_64-w64-mingw32
