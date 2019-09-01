#! /bin/bash

i=1
				read -p "Presione Enter para continuar con el respaldo"
				cd /home/german
				if find "prueba4" 2>>./log 
				then
					cd /home/german/respaldos/database
					
					fecha_dir=`date +%d%m%Y`
					while [ "$i" != 0 ]
					do
					if find $fecha_dir 2>>./log
					then
						i=0
						cd /home/german/respaldos/database/$fecha_dir
						fecha_resp=`date +%d%m%Y_%H%M%S`
						usuario=`id | gawk -F '[=()]' '{ print $3 }'`

						tar -cpvzf "full_bd_$fecha_resp.tgz" -g /home/german/respaldos/backup.snap /home/german/prueba4
						if find "full_bd_$fecha_resp.tgz" /home/german/respaldos/database/$fecha_dir
						then
							read -p "Se creo el archivo de respaldo de forma exitosa: full_bd_$fecha_resp.tgz"
							echo "EXITO: Se creo el archivo de respaldo de forma exitosa: full_bd_$fecha_resp.tgz ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
						else	
						read -p "El respaldo fallo!: full_bd_$fecha_resp.tgz"
						echo "ERROR: El respaldo fallo!: full_bd_$fecha_resp.tgz ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
						fi
					else
						mkdir $fecha_dir
					fi
					done
				else
					read -p "El directorio a respaldar no existe `date`"
					echo "ERROR: El directorio a respaldar no existe `date` (usuario: $usuario)">>/home/german/respaldos/log
				fi
					

			

