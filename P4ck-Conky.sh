#!/bin/bash
pretoCinza="\033[1;30m" 
vermelhoClaro="\033[1;31m"
verdeClaro="\033[1;32m" 
amarelo="\033[1;33m" 
azulClaro="\033[1;34m"
purpleClaro="\033[1;35m" 
cyanClaro="\033[1;36m"
branco="\033[1;37m"
corPadrao="\033[0m"

######################################################################
#                            (Msfc0d3r)                              #
#                                                                    #
#                  para agradecer inscreva-se no                     #
#             canal e siga-nos na fan-page no facebook               #
#                   wwww.chmodsecurity.com.br                        #
######################################################################
pessonalizar(){
	cat<<!
##################################################################
____ _  _ _  _ ____ ___     ____ ____ ____ _  _ ____ _ ___ _   _ 
|    |__| |\/| |  | |  \    [__  |___ |    |  | |__/ |  |   \_/  
|___ |  | |  | |__| |__/    ___] |___ |___ |__| |  \ |  |    |   
                                                                 
##################################################################

!
echo " ************* chmod Security  ****************";
echo " ************************************************";
echo " ************* Msfc0d3r_3xp10it  ****************";
echo -e $cyanClaro"você deseja instalar o conky + temas? (yes/no)$corpadrao";
echo -e $amarelo"{+}Msfc0d3r_chmod>$corPadrao\c"; 
read escolher

if [ $escolher = "yes" ]; then
echo -e  $verdeClaro"Instalando requesitos!!!$corpadrao";
sudo apt-get install conky
sudo apt-get install conky-all
echo -e  $verdeClaro"Configurando!!!$corpadrao";
echo -e  $vermelhoClaro"Instalando o Conky-maneger$corpadrao";
echo -e  $vermelhoClaro"Importando receptório$corpadrao";
sudo apt-add-repository -y ppa:teejee2008/ppa
echo -e  $vermelhoClaro"configurado!!$corpadrao";
sudo apt-get update
echo -e $branco"Intalando o conky-maneger $corpadrao";
sudo apt-get install conky-manager
echo -e $branco" conky-maneger instalado $corpadrao";
wget https://dl.dropboxusercontent.com/u/97321327/themes.tar.7z
7z x themes.tar.7z
tar -xvf  themes.tar
echo -e $vermelhorClaro" Agora é só copiar a pasta e colar dentro de .conky/themes $corpadrao";
echo -e "Chmod Security | Tools ";
fi 


	}
	
pessonalizar;
