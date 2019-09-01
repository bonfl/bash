#! /bin/bash


#MENU PRINCIPAL
opcmenupri=1
while [ "$opcmenupri" != 0 ]
do
	rm temp_usuarios
	rm temp_grupos
	rm temp1

	clear
	tput cup 4 48 #posicion del cursos
	echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
	tput cup 5 50
	tput setaf 6 #color de letra
	echo   "<< Administracion de Backup >>" 
	tput sgr0 #borra conf de tput anterior
	tput cup 6 50
	echo ""
	tput sgr0
	tput rev
	tput cup 7 58
	echo "Menu Principal"
	tput sgr0
	tput cup 12 52
	echo "1. Respaldos Base de datos"
	tput cup 13 52
	echo "2. Respaldo Full Usuario Administrador"
	tput cup 14 52
	echo "3. Respaldo Full Scripts"
	tput cup 15 52
	echo "4. Respaldo Full Archivos de Configuracion"
	tput cup 16 52
	echo "5. Respaldos Server"
	tput cup 17 52
	echo "0. Salir"
	tput cup 22 48
	echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
	tput sgr0
	tput cup 20 52
	tput bold #negrita
	read -p "Ingrese opcion:" opcmenupri

	case $opcmenupri in

		0)
		clear
		break
		;;

		1)
		
		tput sgr0
		clear
		i=1
		while [ "$i" != 0 ]
		do
		clear
		tput cup 4 48
		echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
		tput cup 5 50
		tput setaf 6 #color de letra
		echo   "<< Administracion de Backup >>" 
		tput sgr0
		tput cup 6 50
		echo ""
		tput sgr0
		tput rev
		tput cup 7 52
		echo "Respaldos de Base de datos"
		tput sgr0
		tput cup 12 52
		echo "1. Full (resp_bd_full.sh)"
		tput cup 13 52
		echo "2. Incremental (resp_bd_incr.sh)"
		tput cup 14 52
		echo "3. Diferencial (resp_bd_dife.sh)"
		tput cup 17 52
		echo "0. Volver"
		tput cup 22 48
		echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
		tput sgr0
		tput cup 20 52
		tput bold #invertir color
		read -p "Ingrese opcion:" opcmenulist

		
		case $opcmenulist in
			1)
			tput sgr0
			clear
			i=1
			while [ "$i" != 0 ]
			do
			clear
			tput cup 4 48
			echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
			tput cup 5 50
			tput setaf 6 #color de letra
			echo   "<< Administracion de Backup >>" 
			tput sgr0
			tput cup 6 50
			echo ""
			tput sgr0
			tput rev
			tput cup 7 52
			echo "Respaldos base de datos Full"
			tput cup 8 57
			echo "(resp_bd_full.sh)"
			tput sgr0
			tput cup 12 52
			echo "1. Respaldar"
			tput cup 13 52
			echo "2. Restaurar"
			tput cup 14 52
			echo "0. Volver"
			tput sgr0
			tput cup 20 52
			tput bold #invertir color
			read -p "Ingrese opcion:" opcmenulist

				case $opcmenulist in
				
				1)
				tput sgr0
				tput cup 23 52
				bash ./resp_bd_full.sh
				;;

				2)
				s=1
				while [ "$s" != 0 ]
				do
					tput sgr0
					tput cup 23 52
					echo "Los respaldos disponibles son los siguientes..."
					tput cup 25 52
					cd /home/german/respaldos/database/
					tput cup 27 52
					find -name full_bd_*
					echo ""
					echo ""
					read -p "Ingrese nombre completo del respaldo a restaurar: " resp_restaurar
					usuario=`id | gawk -F '[=()]' '{ print $3 }'`
					if find $resp_restaurar
					then
						s=0
						tar -xvf $resp_restaurar -C /
						read -p "Se restauro el respaldo correctamente! `date`"
						echo "EXITO: Se restauro el respaldo correctamente! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
					else
						echo "ERROR: El nombre del respaldo en incorrecto o no existe!"
						echo "ERROR: El nombre del respaldo en incorrecto o no existe! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log		
					fi
				done	
				;;

				0)
				break
				;;

				esac
			done
			;;

			
		

			2)
			tput sgr0
			clear
			i=1
			while [ "$i" != 0 ]
			do
			clear
			tput cup 4 48
			echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
			tput cup 5 50
			tput setaf 6 #color de letra
			echo   "<< Administracion de Backup >>" 
			tput sgr0
			tput cup 6 50
			echo ""
			tput sgr0
			tput rev
			tput cup 7 50
			echo "Respaldo Base de datos incremental"
			tput cup 8 57
			echo "(resp_bd_incr.sh)"
			tput sgr0
			tput cup 12 52
			echo "1. Respaldar"
			tput cup 13 52
			echo "2. Restaurar"
			tput cup 14 52
			echo "0. Volver"
			tput sgr0
			tput cup 20 52
			tput bold #invertir color
			read -p "Ingrese opcion:" opcmenulist

				case $opcmenulist in
				
				1)
				tput sgr0
				tput cup 23 52
				bash ./resp_bd_incr.sh
				;;

				2)
				s=1
				while [ "$s" != 0 ]
				do
					tput sgr0
					tput cup 23 52
					echo "Los respaldos disponibles son los siguientes..."
					tput cup 25 52
					cd /home/german/respaldos/database/
					tput cup 27 52
					find -name inc_bd_*
					echo ""
					echo ""
					read -p "Ingrese nombre completo del respaldo a restaurar: " resp_restaurar
					usuario=`id | gawk -F '[=()]' '{ print $3 }'`
					if find $resp_restaurar
					then
						s=0
						tar -xvf $resp_restaurar -C /
						read -p "Se restauro el respaldo correctamente! `date`"
						echo "EXITO: Se restauro el respaldo correctamente! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
					else
						echo "ERROR: El nombre del respaldo en incorrecto o no existe!"
						echo "ERROR: El nombre del respaldo en incorrecto o no existe! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log		
					fi
				done	
				;;

				0)
				break
				;;

				esac
			done
			;;


			3)
			tput sgr0
			clear
			i=1
			while [ "$i" != 0 ]
			do
			clear
			tput cup 4 48
			echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
			tput cup 5 50
			tput setaf 6 #color de letra
			echo   "<< Administracion de Backup >>" 
			tput sgr0
			tput cup 6 50
			echo ""
			tput sgr0
			tput rev
			tput cup 7 50
			echo "Respaldos Base de datos Diferencial"
			tput cup 8 57
			echo "(resp_bd_dife.sh)"
			tput sgr0
			tput cup 12 52
			echo "1. Respaldar"
			tput cup 13 52
			echo "2. Restaurar"
			tput cup 14 52
			echo "0. Volver"
			tput sgr0
			tput cup 20 52
			tput bold #invertir color
			read -p "Ingrese opcion:" opcmenulist

				case $opcmenulist in
				
				1)
				tput sgr0
				tput cup 23 52
				bash ./resp_bd_dife.sh
				;;

				2)
				s=1
				while [ "$s" != 0 ]
				do
					tput sgr0
					tput cup 23 52
					echo "Los respaldos disponibles son los siguientes..."
					tput cup 25 52
					cd /home/german/respaldos/database/
					tput cup 27 52
					find -name dif_bd_*
					echo ""
					echo ""
					read -p "Ingrese nombre completo del respaldo a restaurar: " resp_restaurar
					usuario=`id | gawk -F '[=()]' '{ print $3 }'`
					if find $resp_restaurar
					then
						s=0
						tar -xvf $resp_restaurar -C /
						read -p "Se restauro el respaldo correctamente! `date`"
						echo "EXITO: Se restauro el respaldo correctamente! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
					else
						echo "ERROR: El nombre del respaldo en incorrecto o no existe!"
						echo "ERROR: El nombre del respaldo en incorrecto o no existe! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log		
					fi
				done	
				;;

				0)
				break
				;;

				esac
			done
			;;

			0)
			break
			break
			;;


		esac
		done
		;;

		2)

		tput sgr0
		clear
		i=1
		while [ "$i" != 0 ]
		do
		clear	
		tput cup 4 48
		echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
		tput cup 5 50
		tput setaf 6 #color de letra
		echo   "<< Administracion de Backup >>" 
		tput sgr0
		tput cup 6 50
		echo ""
		tput sgr0
		tput rev
		tput cup 7 50
		echo "Respaldo Full de Directorio de Aministrador "
		tput cup 8 57
		echo "(resp_dir_admin.sh)"
		tput sgr0
		tput cup 12 52
		echo "1. Respaldar"
		tput cup 13 52
		echo "2. Restaurar"
		tput cup 14 52
		echo "0. Volver"
		tput sgr0
		tput cup 20 52
		tput bold #invertir color
		read -p "Ingrese opcion:" opcmenulist
			case $opcmenulist in
			
			1)
			tput sgr0
			tput cup 23 52
			bash ./resp_dir_admin.sh
			;;
			2)
			s=1
				while [ "$s" != 0 ]
				do
					tput sgr0
					tput cup 23 52
					echo "Los respaldos disponibles son los siguientes..."
					tput cup 25 52
					cd /home/german/respaldos/Dir_Admin/
					tput cup 27 52
					find -name full_dir_admin*
					echo ""
					echo ""
					read -p "Ingrese nombre completo del respaldo a restaurar: " resp_restaurar
					usuario=`id | gawk -F '[=()]' '{ print $3 }'`
					if find $resp_restaurar
					then
						s=0
						tar -xvf $resp_restaurar -C /
						read -p "Se restauro el respaldo correctamente! `date`"
						echo "EXITO: Se restauro el respaldo correctamente! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
					else
						echo "ERROR: El nombre del respaldo en incorrecto o no existe!"
						echo "ERROR: El nombre del respaldo en incorrecto o no existe! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log		
					fi
				done		
			;;

			0)
			break
			;;

			esac
		done
		;;

		3)

		tput sgr0
		clear
		i=1
		while [ "$i" != 0 ]
		do
		clear
		tput cup 4 48
		echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
		tput cup 5 50
		tput setaf 6 #color de letra
		echo   "<< Administracion de Backup >>" 
		tput sgr0
		tput cup 6 50
		echo ""
		tput sgr0
		tput rev
		tput cup 7 40
		echo "Respaldo Full Scripts (resp_scri_full.sh)"
		tput sgr0
		tput cup 12 52
		echo "1. Respaldar"
		tput cup 13 52
		echo "2. Restaurar"
		tput cup 14 52
		echo "0. Volver"
		tput sgr0
		tput cup 20 52
		tput bold #invertir color
		read -p "Ingrese opcion:" opcmenulist

			case $opcmenulist in
			
			1)
			tput sgr0
			tput cup 23 52
			bash ./resp_scri_full.sh
			;;
			2)
			s=1
				while [ "$s" != 0 ]
				do
					tput sgr0
					tput cup 23 52
					echo "Los respaldos disponibles son los siguientes..."
					tput cup 25 52
					cd /home/german/respaldos/scripts/
					tput cup 27 52
					find -name full_scri_*
					echo ""
					echo ""
					read -p "Ingrese nombre completo del respaldo a restaurar: " resp_restaurar
					usuario=`id | gawk -F '[=()]' '{ print $3 }'`
					if find $resp_restaurar
					then
						s=0
						tar -xvf $resp_restaurar -C /
						read -p "Se restauro el respaldo correctamente! `date`"
						echo "EXITO: Se restauro el respaldo correctamente! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
					else
						echo "ERROR: El nombre del respaldo es incorrecto o no existe!"
						echo "ERROR: El nombre del respaldo es incorrecto o no existe! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log		
					fi
				done
			;;

			0)
			break
			;;

			esac
		done
		;;

		4)
		
		tput sgr0
		clear
		i=1
		while [ "$i" != 0 ]
		do
		clear
		tput cup 4 48
		echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
		tput cup 5 50
		tput setaf 6 #color de letra
		echo   "<< Administracion de Backup >>" 
		tput sgr0
		tput cup 6 50
		echo ""
		tput sgr0
		tput rev
		tput cup 7 50
		echo "Respaldo Full Archivos de Configuracion"
		tput cup 8 57
		echo "(resp_conf_full.sh)"
		tput sgr0
		tput cup 12 52
		echo "1. Respaldar"
		tput cup 13 52
		echo "2. Restaurar"
		tput cup 14 52
		echo "0. Volver"
		tput sgr0
		tput cup 20 52
		tput bold #invertir color
		read -p "Ingrese opcion:" opcmenulist
			case $opcmenulist in
			
			1)
			tput sgr0
			tput cup 23 52
			bash ./resp_conf_full.sh
			;;
			2)
			s=1
				while [ "$s" != 0 ]
				do
					tput sgr0
					tput cup 23 52
					echo "Los respaldos disponibles son los siguientes..."
					tput cup 25 52
					cd /home/german/respaldos/archivos_config/
					tput cup 27 52
					find -name full_*
					echo ""
					echo ""
					read -p "Ingrese nombre completo del respaldo a restaurar: " resp_restaurar
					usuario=`id | gawk -F '[=()]' '{ print $3 }'`
					if find $resp_restaurar
					then
						s=0
						tar -xvf $resp_restaurar -C /
						read -p "Se restauro el respaldo correctamente! `date`"
						echo "EXITO: Se restauro el respaldo correctamente! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
					else
						echo "ERROR: El nombre del respaldo es incorrecto o no existe!"
						echo "ERROR: El nombre del respaldo es incorrecto o no existe! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log		
					fi
				done
			;;

			0)
			break
			;;

			esac
		done
		;;
	
	
		5)

		tput sgr0
		clear
		i=1
		while [ "$i" != 0 ]
		do
		clear
		tput cup 4 48
		echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
		tput cup 5 50
		tput setaf 6 #color de letra
		echo   "<< Administracion de Backup >>" 
		tput sgr0
		tput cup 6 50
		echo ""
		tput sgr0
		tput rev
		tput cup 7 50
		echo "Respaldos Server full"
		tput cup 8 57
		echo "(resp_scri_full.sh)"
		tput sgr0
		tput cup 12 52
		echo "1. Respaldar"
		tput cup 13 52
		echo "2. Restaurar"
		tput cup 14 52
		echo "0. Volver"
		tput sgr0
		tput cup 20 52
		tput bold #invertir color
		read -p "Ingrese opcion:" opcmenulist
			case $opcmenulist in
			
			1)
			tput sgr0
			tput cup 23 52
			bash ./resp_serv_full.sh
			;;
			2)
			s=1
				while [ "$s" != 0 ]
				do
					tput sgr0
					tput cup 23 52
					echo "Los respaldos disponibles son los siguientes..."
					tput cup 25 52
					cd /home/german/respaldos/server/
					tput cup 27 52
					find -name full_serv_*
					echo ""
					echo ""
					read -p "Ingrese nombre completo del respaldo a restaurar: " resp_restaurar
					usuario=`id | gawk -F '[=()]' '{ print $3 }'`
					if find $resp_restaurar
					then
						s=0
						tar -xvf $resp_restaurar -C /
						read -p "Se restauro el respaldo correctamente! `date`"
						echo "EXITO: Se restauro el respaldo correctamente! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log
					else
						echo "ERROR: El nombre del respaldo en incorrecto o no existe!"
						echo "ERROR: El nombre del respaldo en incorrecto o no existe! $resp_restaurar  ----- `date` (usuario: $usuario)">>/home/german/respaldos/log		
					fi
				done
			;;

			0)
			break
			;;

			esac
			done
		;;

	esac
done
