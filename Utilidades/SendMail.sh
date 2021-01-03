#!/bin/bash

############################################################################
#                                                                          #             
# Nome do Script    : SendMail                                             #          
# Descrição         : Script para verificar a execução do QE e VASP        #                                     
# Args              : ./SendMail.sh <nome do job>                          #                           
# Autor             : Rafael Barbosa                                       #   
# Email             : barbosa90r@gmail.com                                 #                 
# Data de alteração : 24/02/2018                                           #       
#                                                                          #                
#                                                                          #              
############################################################################

TIME=10                                                                                                                                   
EMAIL=barbosa90r@gmail.com
if [ $# -eq 0 ]                                                                                                                            
     then
     echo "Favor informar o nome do job  como argumento."
     echo "./SendMail.sh <job>"
     exit 1
fi
while true
do   
    if  ps axu |grep mpirun |grep -v grep |grep -v $0 > /dev/null
    then
    sleep $TIME

     else
     PID=$$
     TIME=$(ps -p $PID -o etime | tail -1 | tr -d ' ')  
     echo "Subject: Job $1 -- Run Time_$TIME - CONTA FINALIZADA " > log.txt
     ssmtp $EMAIL < log.txt
     sleep 30
     rm -f log.txt
     break
fi
done
exit 0

