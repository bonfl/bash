#! /bin/bash

#calcular fecha 15 dias antes del dia actual

fecha_menos_6meses=`date --date "-6 month" +%d%m%Y`
usuario=`id | gawk -F '[=()]' '{ print $3 }'`


cd /home/german/respaldos/server/
if ls -d $fecha_menos_6meses >>./null
then
	cd /home/german/respaldos/server/$fecha_menos_6meses/
	if ls full_serv_"$fecha_menos_6meses"_*
	then

		bash /home/german/Proyecto/resp_serv_full.sh
	else
		echo "ERROR: No existe respaldo full_serv_"$fecha_menos_mes"_* o esta inutilizable ----- `date` (usuario: $usuario)">>/home/german/respaldos/log

	fi

else
	echo "ERROR: Intento de respaldo full_serv_`date +%d%m%Y` fuera de fecha o respaldo con antiguedad a 1 mes no existe ----- `date` (usuario: $usuario)">>/home/german/respaldos/log 
	

fi

