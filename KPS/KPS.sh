#!/bin/bash
 
# created     : 2017/12/18
# last update : 2018/05/22
# author      : Rafael Dexter <dexter.nba@gmail.com>
# notes       : adapted by Barbosa

clear
HERE=$(pwd)
PONTOS='/home/padilha/Rafael/Scripts/KPOINTS/Layer'
# input
if [ "$#" != 1 ] ; then
  clear
  echo "Usage:"
  echo "      `basename $0` <material> "
  echo "Example:"
  echo "      `basename $0` GaSe"
  echo " "
  exit 1
else
  MAT=$1
fi

#Verification
FILES='INCAR POSCAR POTCAR KPOINTS IBZKPT'
if [[ -d DM ]] ; then
	cd DM/ 
# Files Verification
	for AA in $FILES ; do
		if ! [[ -e "$AA" ]] ; then
			echo -e "\033[0;31m It is missing the file "$AA" ! \033[m "; exit 1
		fi
	done
# ALGO
	ALGO=$(grep -m 1 "ALGO" INCAR | awk '{print $3}')
	if [[ "$ALGO" != 'Normal' ]] ; then
	echo -e "\033[0;31m The tag ALGO is diferent of Normal! \033[m" ; exit 1
	fi
# CONVERGENCE
	CONV=$(tail -n 1 saida.out | awk '{print $2}')
	if [[ "$CONV" != 'wavefunctions' ]] ; then
	echo -e "\033[0;31m The simulation is not converged! \033[m" ; exit 1
	fi
else
	echo -e "\033[0;31m The directory DM not found! \033[m" ; exit 1
fi

echo -e "\033[0;32m Verification complete \033[m"
echo " "

# IBZKPT
	cd "$HERE"
	cp "$HERE"/DM/IBZKPT "$HERE"/IBZKPT.dat
	NUM=$(wc -l IBZKPT.dat | awk '{print $1}')
	NUMIBZ=$(bc <<< $NUM+13) # -3 hader + 16 for add
	sed -i "2s/.*/      "$NUMIBZ"/" IBZKPT.dat

#Loop 
for NN in $(seq 1 1 3) ; do
	cd "$HERE"
	cp -r DM/ KP"$NN"
	if [[ -d KP"$NN" ]] ; then
		echo "Directory KP"$NN" copied ..."
	else
		echo -e "\033[0;31m Directory KP"$NN" not copied ! \033[m" ; exit 1
	fi
	if [[ -f "$PONTOS"/KPOINTS-"$NN" ]] ; then
		echo "Change the KPOINTS file:"
		cat "$HERE"/IBZKPT.dat "$PONTOS"/KPOINTS-"$NN" > KP"$NN"/KPOINTS
	else
		echo -e "\033[0;31m It's missing KPOINTS-$NN ! \033[m" ; exit 1
	fi

	cd KP"$NN"

	if [[ -e VASP.pbs ]] ; then
		NAME=$(echo ""$MAT"-KP"$NN"")
		sed -i "s/#PBS -N.*/#PBS -N "$NAME"/" VASP.pbs
		qsub VASP.pbs 
		echo " "
	else
		echo -e "\033[0;33m The submission should be manual.\033[m"
	fi
	echo " "
done
rm "$HERE"/IBZKPT.dat
