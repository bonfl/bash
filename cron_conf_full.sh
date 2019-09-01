#! /bin/bash

#calcular fecha 15 dias antes del dia actual

fecha_menos_mes=`date --date "-1 month" +%d%m%Y`
usuario=`id | gawk -F '[=()]' '{ print $3 }'`


cd /home/german/respaldos/archivos_config/
if ls -d $fecha_menos_mes >>./null
then
	cd /home/german/respaldos/archivos_config/$fecha_menos_mes/
	if ls full_etc_"$fecha_menos_mes"_* full_bin_"$fecha_menos_mes"_*
	then

		bash /home/german/Proyecto/resp_conf_full.sh
	else
		echo "ERROR: No existe respaldo full_etc_"$fecha_menos_mes"_* / full_bin_"$fecha_menos_mes"_* o esta inutilizable ----- `date` (usuario: $usuario)">>/home/german/respaldos/log

	fi

else
	echo "ERROR: Intento de respaldo full_etc_"$fecha_menos_mes"_`date +%d%m%Y` / full_bin_"$fecha_menos_mes"_`date +%d%m%Y` fuera de fecha o respaldo con antiguedad a 1 mes no existe ----- `date` (usuario: $usuario)">>/home/german/respaldos/log 
	

fi


