cp -rp harfbuzz-1.9.0 _build

cd _build

# Create harfbuzz.def to skip generating python definitions
touch src/harfbuzz.def
