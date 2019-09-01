#! /bin/bash

read -p "Presione Enter para continuar con el respaldo"

i=1
				
				
					cd /home/german/respaldos/server

					fecha_dir=`date +%d%m%Y`
					while [ "$i" != 0 ]
					do
					if find $fecha_dir 2>>./log
					then
						i=0
						cd /home/german/respaldos/server
						fecha_resp=`date +%d%m%Y_%H%M%S`
						usuario=`id | gawk -F '[=()]' '{ print $3 }'`

						tar -cpvzf "full_serv_$fecha_resp.tgz" /
						
						if find "full_serv_$fecha_resp.tgz"
						then
							read -p "EXITO: Se creo el archivo de respaldo de forma exitosa: full_serv_$fecha_resp.tgz"
							echo "EXITO: Se creo el archivo de respaldo de forma exitosa: full_serv_$fecha_resp.tgz ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
						else	
						read -p "ERROR: El respaldo fallo!"
						echo "ERROR: El respaldo fallo!: ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
						fi
					else
						mkdir $fecha_dir
					fi
					done
