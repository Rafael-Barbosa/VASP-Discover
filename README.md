# VASP

## BandOffSet 

Basta compilar har3.f90 ou Har3.x e executar na pasta DM.

![alt text](https://github.com/Rafael-Barbosa/VASP/blob/main/BandOffSet/Bandoffset.png)

## KPS 
Adaptado do Script Dexter (https://github.com/RafaelDexter)
Script para gerar os KP1, KP2 e KP3 (2D) ou 3D, para cálculo das estruturas de bandas eletrônicas no VASP. Os Pontos K se encontram em KPOINTS.

## OPTICS

Gerar as absorções opticas a partir do vasprun.xml

![alt text](https://github.com/Rafael-Barbosa/VASP/blob/main/OPTICS/optics.png)

## Utilidades

### kpoints-vasp.x
Programa em C para gerar os pontos K

### SendMail.sh

Funciona no QE e VASP
Quando o job finaliza o script manda um email avisando!
Necessário instalar o ssmtp



