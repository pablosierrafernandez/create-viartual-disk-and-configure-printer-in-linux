#!/bin/bash
# AUTOR: PABLO SIERRA VERSION: 1.0
#--------------------------------------------
# montar.sh 
#--------------------------------------------
#############################################
#Script para crear dos discos virtuales en 
#memoria uno de tamaño 100 MB, que está 
#montado en directorio Baixades del usuario 
#y un disco con formato tmpfs que esté montado
#en /mnt/mem. El disco montado en a /mnt/mem 
#se cargará automáticamente siempre que 
#arranque la máquina y puedan escribir y leer
#todos los usuarios del sistema, y el disco
#montado en Baixades se monta en el momento 
#en que el usuario entre en el sistema, y habrá
#uno por cada usuario conectado, cuando el 
#usuario salga del sistema, el disco se puede
#borrar.
#############################################

# AYUDA
Help()
{
echo -e "\e[32mMODO DE EMPLEO: montar.sh\e[0m"
echo -e "\e[36mFUNCIÓN:\e[0m Script para crear dos discos virtuales en memoria uno de tamaño 100 MB, que está montado en directorio Baixades del usuario y un disco con formato tmpfs que esté montado en /mnt/mem. El disco montado en a /mnt/mem se cargará automáticamente siempre que arranque la máquina y puedan escribir y leer todos los usuarios del sistema, y el disco montado en Baixades se monta en el momento en que el usuario entre en el sistema, y habrá uno por cada usuario conectado, cuando el usuario salga del sistema, el disco se puede borrar."
echo -e "\e[36mOPCIONES:\e[0m NONE"
echo -e "\e[36mPARÁMETROS:\e[0m NONE"
echo -e "\e[36mCONDICIONES:\e[0m Ejecutar como root"


}
while getopts ":h" option; do
	case $option in
		h)Help
		exit;;
	esac
done

##SI NO SE ES ROOT SALIR

if [ "$EUID" -ne 0 ]
then
	echo -e "\e[1;32mPor favor, ejecute como ROOT\e[0m" >&2
	exit 1
  Help
  exit
fi

## Creacion del disco 'mem'

if [ ! -d "/mnt/mem" ] 
then
    mkdir -p /mnt/mem
    echo "Se ha creado el directorio /mnt/mem"
fi

## Equivalente a rw,suid,dev,exec,auto,nouser,async

echo -e "tmpfs\t/mnt/mem\ttmpfs\tdefaults\t0\t0" >> /etc/fstab

## Creación del disco 'Baixades'

for user in $(ls /home)
  do
    if [ ! -d "/home/$user/Baixades" ] 
    then
      mkdir -p /home/$user/Baixades
      echo "Se ha creado el directorio /home/$user/Baixades"
    fi
	  echo -e "tmpfs\t/home/$user/Baixades\ttmpfs\tdefaults,user,auto,size=100M\t0\t0" >> /etc/fstab
		echo -e "mount /home/$user/Baixades" >> /etc/profile
done
mount -a

## Comprobamos

df -l

exit 0
	



