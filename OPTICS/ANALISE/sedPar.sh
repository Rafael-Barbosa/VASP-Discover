cd Parallel
sed '/NaN/d' abor.dat > abornew.dat
mv abornew.dat abor.dat
sed '/NaN/d' extinction.dat > extinctionnew.dat
mv extinctionnew.dat extinction.dat
sed '/NaN/d' reflectivity.dat >  reflectivitynew.dat
mv reflectivitynew.dat reflectivity.dat
cd ..


