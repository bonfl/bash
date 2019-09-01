#! /bin/bash

#calcular fecha 1 mes antes del dia actual

fecha_menos_mes=`date --date "-1 month" +%d%m%Y`
usuario=`id | gawk -F '[=()]' '{ print $3 }'`


cd /home/german/respaldos/database/
if ls -d $fecha_menos_mes >>./null
then
	cd /home/german/respaldos/database/$fecha_menos_mes/
	if ls full_dir_admin_"$fecha_menos_mes"_*
	then

		bash /home/german/Proyecto/resp_dir_admin.sh
	else
		echo "ERROR: No existe respaldo full_dir_admin_"$fecha_menos_mes"_* o esta inutilizable ----- `date` (usuario: $usuario)">>/home/german/respaldos/log

	fi

else
	echo "ERROR: Intento de respaldo full_dir_admin_`date +%d%m%Y` fuera de fecha o respaldo con antiguedad a 1 mes no existe ----- `date` (usuario: $usuario)">>/home/german/respaldos/log 
	

fi

