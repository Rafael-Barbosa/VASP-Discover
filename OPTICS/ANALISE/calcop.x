mkdir Perpendicular
./perp.sh
cp imag.dat eps.dat
./smooth.x
cp eps-smo.dat img.dat
cp real.dat eps.dat
./smooth.x
cp eps-smo.dat rel.dat
./program.x
mv *.dat Perpendicular

mkdir Parallel
./paral.sh
cp imag.dat eps.dat
./smooth.x
cp eps-smo.dat img.dat
cp real.dat eps.dat
./smooth.x
cp eps-smo.dat rel.dat
./program.x
mv *.dat Parallel
source sedPar.sh
source sedPer.sh
