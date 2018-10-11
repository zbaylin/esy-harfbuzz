cd _build

# Automake gets brought in unnecessarily for the release package - 
# force dependencies to be 'up-to-date' to skip automake...
touch aclocal.m4
touch Makefile.in
touch configure
touch config.h.in

# OS_WIN32 invokes a python def file generator for MVSC linking,
# which we don't need (it's implied by host - mingw)
touch src/harfbuzz.def
touch src/harfbuzz-subset.def
touch src/harfbuzz-icu.def
touch src/harfbuzz-gobject.def

echo "**BUILD STARTED**"
make
echo "**BUILD COMPLETE**"
make install

