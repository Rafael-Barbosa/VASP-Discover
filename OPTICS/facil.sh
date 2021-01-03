#/bin/bash!

rm -rf Perpendicular/ Parallel/
rm vasprun.xml
cp ../OPTICA/vasprun.xml .
ifort -o program.x program.f
ifort -o smooth.x smooth.f


