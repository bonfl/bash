#! /bin/bash
			
read -p "Presione Enter para continuar con el respaldo"
				cd /home/german
				if find "/home/german/Proyecto" >>./null 
				then
					cd /home/german/respaldos/scripts
					fecha=`date +%d%m%Y_%H%M%S`
					usuario=`id | gawk -F '[=()]' '{ print $3 }'`


					tar -cpvzf "full_scri_$fecha.tgz" /home/german/Proyecto 
					if find "full_scri_$fecha.tgz" /home/german/respaldos/scripts
					then
						read -p "Se creo el archivo de respaldo de forma exitosa: `date +%d%m%Y_%H%M%S`"
						echo "EXITO: Se creo el archivo de respaldo de forma exitosa: full_scri_$fecha.tgz ----- `date` (usuario: $usuario)">>/home/german/respaldos/log

					else	
					read -p "El respaldo fallo!: full_scri_$fecha.tgz"
					echo "ERROR: El respaldo fallo!: full_scri_$fecha.tgz ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
					fi
				else
					read -p "El directorio a respaldar no existe"
					echo "ERROR: El directorio a respaldar no existe `date` (usuario: $usuario)">>/home/german/respaldos/log
				fi
