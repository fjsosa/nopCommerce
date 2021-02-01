#!/bin/bash


#FTP ACCESS
HOST='vps-1757984-x.dattaweb.com'
USER='supermix'
PASSWD='SOPORTE00@mag'
REMOTEPATH='/deploy'
FILE='deploy.tar.gz'
OUTPUT='./publish'

rm -dr ./publish
mkdir publish

echo $'Paso 1: Generando Archivos de publicación\n'
dotnet publish -f netcoreapp3.1 -c Release -r linux-x64 -o $OUTPUT
echo "done"



echo "Paso 2: Comprimiendo archivos a publicar en ./deploy.tar.gz"
cd $OUTPUT
echo "done"



echo $'Paso 3 Comprimiendo Arvhivos\n'
tar -czvf $FILE *
echo "done"

echo $'Paso 4: Subiendo a FTP\n'
ftp -p -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
cd $REMOTEPATH
put $FILE
quit
END_SCRIPT
echo "done"

echo $'Paso 7: Removiendo Binarios Publicados\n'
rm -vrf !($FILE)
cd ..


echo $'El Proceso ha finalizado \n'
echo "bye."
exit 
