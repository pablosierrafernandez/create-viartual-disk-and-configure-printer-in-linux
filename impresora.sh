#!/bin/bash
# AUTOR: PABLO SIERRA VERSION: 1.0
#--------------------------------------------
# impresora.sh 
#--------------------------------------------
#############################################
#Script para configurar el sistema de 
#impresión con el sistema CUPS 2.3.3
#También configura una impresora virtual 
#llamada impresoraV que convierte los
#documentos a imprimir en documentos PDF. 
#Por defecto, los guarda en un directorio 
#llamado DocsPDF seguido del login del usuario 
#que imprime.
#Este directorio colgará de /mnt/mem.
#Será la impresora por defecto y que además,
#cuyas opciones son: paginación horizontal, 
#blanco y negro y en dos páginas por página.
#############################################

# AYUDA
Help()
{
echo -e "\e[32mMODO DE EMPLEO: impresora.sh\e[0m"
echo -e "\e[36mFUNCIÓN:\e[0m Script para configurar el sistema de impresión con el sistema CUPS 2.3.3 También configura una impresora virtual llamada impresoraV que convierte los documentos a imprimir en documentos PDF. Por defecto, los guarda en un directorio llamado DocsPDF seguido del login del usuario que imprime. Este directorio colgará de /mnt/mem. Será la impresora por defecto y que además, cuyas opciones son: paginación horizontal, blanco y negro y en dos páginas por página."
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
## Comprobar si existe CUPS
dpkg -l cups &> /dev/null
if [ $? -ne 0 ]
then
  echo "Instalando CUPS..."
	apt-get install cups
  apt-get install cups-pdf
  echo "INSTALADO!"
fi
systemctl start cups >> /dev/null
systemctl enable cups >> /dev/null

## Configuramos la impresora con el comando lpadmin

lpadmin -p impressoraV -E -v cups-pdf:/ -m lsb/usr/cups-pdf/CUPS-PDF_opt.ppd

## Modificamos el archivo de configuracion para editar la salida del nombre del PDF

sed -i 's/Out ${HOME}\/PDF/Out \/mnt\/mem\/DocsPDF${USER}/g' /etc/cups/cups-pdf.conf

## Opciones de impresion

lpoptions -p impressoraV -o orientation-requested=4 -o ColorMode=Black -o number-up=2 	

exit 0

	



