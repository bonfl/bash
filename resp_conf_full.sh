#! /bin/bash


read -p "Presione Enter para continuar con el respaldo"

i=1
				cd /home/german
				
					cd /home/german/respaldos/archivos_config

					fecha_dir=`date +%d%m%Y`
					while [ "$i" != 0 ]
					do
					if find $fecha_dir 2>>./log
					then
						i=0
						cd /home/german/respaldos/archivos_config/$fecha_dir
						fecha_resp=`date +%d%m%Y_%H%M%S`
						usuario=`id | gawk -F '[=()]' '{ print $3 }'`

						tar -cpvzf "full_etc_$fecha_resp.tgz" /etc
						tar -cpvzf "full_bin_$fecha_resp.tgz" /bin
						if find "full_etc_$fecha_resp.tgz" "full_bin_$fecha_resp.tgz"
						then
							read -p "EXITO: Se creo el archivo de respaldo de forma exitosa: full_etc_$fecha_resp.tgz y full_bin_$fecha_resp.tgz"
							echo "EXITO: Se creo el archivo de respaldo de forma exitosa: full_etc_$fecha_resp.tgz y full_bin_$fecha_resp.tgz ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
						else	
						read -p "ERROR: El respaldo fallo!"
						echo "ERROR: El respaldo fallo!: ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
						fi
					else
						mkdir $fecha_dir
					fi
					done

