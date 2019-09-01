#! /bin/bash

#calcular fecha 15 dias antes del dia actual

fecha_menos_14=`date --date "-14 days" +%d%m%Y`
usuario=`id | gawk -F '[=()]' '{ print $3 }'`

cd /home/german/respaldos/database/
if ls -d $fecha_menos_14 >>./null
then
	cd /home/german/respaldos/database/$fecha_menos_14/
	if ls full_bd_"$fecha_menos_14"_* >>./null
	then

		bash /home/german/Proyecto/resp_bd_full.sh
	else
		echo "ERROR: No existe respaldo full_bd_"$fecha_menos_14"_* o esta inutilizable ----- `date` (usuario: $usuario)">>/home/german/respaldos/log

	fi

else
	echo "ERROR: Intento de respaldo full_bd_`date +%d%m%Y` fuera de fecha o respaldo con antiguedad a 14 dias no existe ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
	
fi




