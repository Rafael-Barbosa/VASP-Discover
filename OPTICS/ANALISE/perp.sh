awk 'BEGIN{i=1} /imag/,\
                /\/imag/ \
                 {a[i]=$2 ; b[i]=$5 ; i=i+1} \
     END{for (j=12;j<i-3;j++) print a[j],b[j]}' vasprun.xml > imag.dat

awk 'BEGIN{i=1} /real/,\
               /\/real/ \
               {a[i]=$2 ; b[i]=$5 ; i=i+1} \
     END{for (j=12;j<i-3;j++) print a[j],b[j]}' vasprun.xml > real.dat
