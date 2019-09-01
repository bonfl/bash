#! /bin/bash

			read -p "Presione Enter para continuar con el respaldo"
				cd /home/german
				if find "/home/german" >>./null 
				then
					cd /home/german/respaldos/Dir_Admin
					fecha=`date +%d%m%Y_%H%M%S`
					usuario=`id | gawk -F '[=()]' '{ print $3 }'`


					tar -cpvzf "full_dir_admin_$fecha.tgz" /home/german 
					if find "full_dir_admin_$fecha.tgz" /home/german/respaldos/Dir_Admin
					then
						read -p "EXITO: Se creo el archivo de respaldo de forma exitosa: `date +%d%m%Y_%H%M%S`"
						echo "EXITO: Se creo el archivo de respaldo de forma exitosa: full_dir_admin_$fecha.tgz ----- `date` (usuario: $usuario)">>/home/german/respaldos/log

					else	
					read -p "ERROR: El respaldo fallo!: full_dir_admin_$fecha.tgz"
					echo "ERROR: El respaldo fallo!: full_dir_admin_$fecha.tgz ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
					fi
				else
					read -p "ERROR: El directorio a respaldar no existe"
					echo "ERROR: El directorio a respaldar no existe `date` (usuario: $usuario)">>/home/german/respaldos/log
				fi

			

