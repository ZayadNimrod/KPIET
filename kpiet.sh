cd bitmapper
cargo run ../$1 ../temp.kpiet
cd ..
cd specification
krun ../temp.kpiet --output NONE
cd ..

