cd bitmapper
cargo run ../$1 ../temp.kpiet &>/dev/null
cd ..
cd specification
krun ../temp.kpiet --output NONE
cd ..

