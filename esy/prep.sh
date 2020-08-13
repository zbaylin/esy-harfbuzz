cp -rp harfbuzz-2.6.8 _build

cd _build

# Create harfbuzz.def to skip generating python definitions
touch src/harfbuzz.def
touch src/*.hh
