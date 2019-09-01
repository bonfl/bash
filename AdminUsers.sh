#! /bin/bash

tput sgr0
clear
rm temp_usuarios temp_grupos temp1 temp_grup temp_grupos2 temp_usu temp_gru temp_busqueda temp_grupouser 2>>./null
dia=`date +"%d/%m/%Y"`
hora=`date +"%H:%M"`

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
	echo   "<< Administracion de Usuarios >>" 
	tput sgr0 #borra conf de tput anterior
	tput cup 6 50
	echo ""
	tput sgr0
	tput rev
	tput cup 7 58
	echo "Menu Principal"
	tput sgr0
	tput cup 12 52
	echo "1. ABM Usuarios"
	tput cup 13 52
	echo "2. ABM Grupos"
	tput cup 14 52
	echo "3. Listar y buscar usuarios/grupos"
	#tput cup 15 52
	#echo "4. Administracion de archivos y directorios"
	tput cup 15 52
	echo "4. Limpiar archivos temporales del script"
	tput cup 17 52
	echo "0. Salir"
	tput cup 22 48
	echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
	tput sgr0
	tput cup 20 52
	tput bold #negrita
	read -p "Ingrese opcion:" opcmenupri

	case $opcmenupri in
		
		2)
		tput sgr0
		bash adm_grupos.sh
		;;		
		
		# 4)
		#bash adm_arch.sh
		#;;
#Menu listar y buscar
		3)
		rm temp_usuarios
		rm temp_grupos
		rm temp1

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
		echo   "<< Administracion de Usuarios >>" 
		tput sgr0
		tput cup 6 50
		echo ""
		tput sgr0
		tput rev
		tput cup 7 58
		echo "Listar y buscar"
		tput sgr0
		tput cup 12 52
		echo "1. Listar solo usuarios"
		tput cup 13 52
		echo "2. Listar solo usuarios y sus respectivos grupos"
		tput cup 14 52
		echo "3. Listar usuarios, grupos, /home e interprete de comando"
		tput cup 15 52
		echo "4. Realizar busqueda por usuario"
		tput cup 16 52
		echo "5. Realizar busqueda por grupo"
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
			clear
			cat /etc/passwd | cut -d: -f1 > temp_usuarios
			less temp_usuarios
			rm temp_usuarios
					
			;;
			
			2)
			clear
			q=1
			while [ "$q" != 0 ]
			do 
			tput cup 4 48
			echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
			tput cup 5 50
			tput setaf 6 #color de letra
			echo   "<< Administracion de Usuarios >>" 
			tput sgr0
			tput cup 6 50
			echo ""
			tput sgr0
			tput rev
			tput cup 7 50
			echo "Listar solo usuarios y sus  grupos"
			tput sgr0
			tput cup 10 50
			echo "> Buscar por usuario"
			tput cup 15 0
			read -p "BUSCAR:" buscar
			if grep $buscar /etc/passwd > temp_busqueda
			then
				tput cup 17 0
				echo "-Usuario:x:UID:GID::Directorio:Shell-"
				echo "-------------------------------------"
				tput cup 20 0
				cat temp_busqueda
				read -p "Presione una tecla..."
				q=0
			else
				tput cup 15 0
				echo "BUSCAR:                                                                             "
				read -p "ERROR: no se encuentra usuario"
				tput cup 16 0
				echo "                                                                                 "
			fi
			done
			;;
			
			3)
			clear
			cat /etc/passwd > temp_usuarios
			less temp_usuarios
			rm temp_usuarios
			;;
			
			4)
			clear
			tput cup 4 48
			echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
			tput cup 5 50
			tput setaf 6 #color de letra
			echo   "<< Administracion de Usuarios >>" 
			tput sgr0
			tput cup 6 50
			echo ""
			tput sgr0
			tput rev
			tput cup 7 58
			echo "Listar y buscar"
			tput sgr0
			tput cup 10 50
			echo "> Buscar usuario"
			tput cup 15 0
			read -p "BUSCAR:" buscar
			cat /etc/passwd | cut -d: -f1 > temp_usuarios
			tput cup 16 0
			grep -i $buscar ./temp_usuarios
			read
			rm temp_usuarios
			;;
	
			5)
			clear
			tput cup 4 48
			echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
			tput cup 5 50
			tput setaf 6 #color de letra
			echo   "<< Administracion de Usuarios >>" 
			tput sgr0
			tput cup 6 50
			echo ""
			tput sgr0
			tput rev
			tput cup 7 58
			echo "Listar y buscar"
			tput sgr0
			tput cup 10 50
			echo "> Buscar grupo"
			tput cup 15 0
			read -p "BUSCAR:" buscar
			cat /etc/group | cut -d: -f1 > temp_grupos
			tput cup 16 0
			grep -i $buscar ./temp_grupos
			read
			rm temp_grupos
			;;

			0)
			i=0
		esac
		done
		;;	
		
#menu ABM USUARIOS		
		1)

		clear
		tput sgr0
		opcmenuuser=1
		while [ "$opcmenuuser" != 0 ]
		do
			clear
		

			tput cup 4 48
			echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
			tput cup 5 50
			tput setaf 6 #color de letra
			echo   "<< Administracion de Usuarios >>" 
			tput sgr0
			tput cup 6 50
			echo ""
			tput sgr0
			tput rev
			tput cup 7 58
			echo "ABM Ususarios"
			tput sgr0
			tput cup 12 52
			echo "1. Alta nuevo usuario"
			tput cup 13 52
			echo "2. Cambiar contrasena"
			tput cup 14 52
			echo "3. Modificar nombre de usuario"
			tput cup 15 52
			echo "4. Eliminar usuario"
			tput cup 16 52
			echo "5. Cambiar permisos de usuario (grupo primario)"
			tput cup 17 52
			echo "0. Volver"
			tput cup 22 48
			echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
			tput sgr0
			tput cup 20 52
			tput bold #invertir color
			read -p "Ingrese opcion:" opcmenuuser


			case $opcmenuuser in
			
#alta nuevo usuario	
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
				echo   "<< Administracion de Usuarios >>" 
				tput sgr0
				tput cup 6 50
				echo ""
				tput sgr0
				tput rev
				tput cup 7 58
				echo "ABM Ususarios"
				tput sgr0
				tput cup 10 50
				echo "> Alta nuevo usuario (q/salir)"
				tput cup 12 50
				echo "-Usuario:"
				tput cup 13 50
				echo "-Grupo:"	
				tput cup 15 0
				read -p "Ingrese nombre de usuario a crear:" user
				if [ $user == "q" ]
				then
					tput cup 17 0
					echo "Regresando al menu."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu.."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu..."
					i=0
				else

				cat /etc/passwd | cut -d: -f1 > temp_usuarios
				if grep -iw ^"$user" ./temp_usuarios > null #comprueba si existe el usuario -iw comprueba la palabra entera
				then
					echo "ERROR: El usuario ya existe"
					read
					rm temp_usuarios
				else
					e=1
					while [ "$e" != 0 ]
					do
					echo ""
					echo "- Grupos -"
					echo ""
					echo "> root"
					echo "> normal_1"
					echo "> normal_2"
					echo "> especial"
					#echo "> 5. listar todos"
					tput cup 12 50
					echo "-Usuario: $user"
					#tput sgr0
					
					tput cup 15 0
					echo "                                                                        "
					tput cup 15 0
					read -p "Ingrese el grupo al cual desea pertenecer:" group
					tput cup 15 0
					echo "                                                                      "
					tput cup 16 0
					echo "                                                                      "
					tput cup 17 0
					echo "                                                                      "
					tput cup 18 0
					echo "                                                                      " #limpia pantalla
					tput cup 19 0
					echo "                                                                      "
					tput cup 20 0
					echo "                                                                      "
					tput cup 21 0
					echo "                                                                      "
					tput cup 22 0
					echo "                                                                      "
					tput cup 23 0
					echo "                                                                      "
					tput cup 24 0
					echo "                                                                      "
					tput sgr0
					cat /etc/group | cut -d: -f1 > temp_grupos
					case $group in
#creacion de usuario root
						root)
						tput cup 13 50
						echo "-Grupo: $group"	
						if grep -w ^"root" ./temp_grupos > null #comprueba si existe el grupo
						then	
							tput cup 16 0
							echo "                                                                            "
							tput cup 16 0
							read -p "Esta seguro que desea agregar al usuario $user al grupo root? s/n: " sn
							case $sn in
								s)
								sudo useradd -g "root" -d "/home/$user" -m -s "/bin/bash" $user #se crea usuario
								sudo passwd $user #cambio de contrasena
								echo "usuario dado de alta: $user $dia $hora">>./log
								tput cup 14 50
								echo "Usuario creado!"
								tput cup 28 0
								echo "Presione una tecla para volver al menu..."
								read
								rm temp_usuarios
								rm temp_grupos
								e=0
								i=0
								;;
								n)
								tput cup 16 0
								echo "                                                                      "
								
								rm temp_usuarios
								rm temp_grupos
								
								;;
								*)
								tput cup 17 0
								echo "ERROR: Opcion invalida!"
								sleep 1
								;;
							esac
						else	
							tput cup 22 0
							read -p "ERROR: El grupo seleccionado no existe, desea acceder al menu de grupos? s/n:" sn
							case $sn in
								s) bash adm_grupos
							 	;;
								n) read -p "Cancelando... " -t 2
								tput cup 15 0
								echo "                                                                      "
								tput cup 16 0
								echo "                                                                      "
								i=0
								;;
								*) echo "ERROR: Opcion invalida"
								sleep 1
								
							esac
						
						fi
					
						;;
#creacion de usuario normal_1				
						normal_1)
						tput cup 13 50
						echo "-Grupo: $group"
						if grep -w ^"normal_1" ./temp_grupos > null #comprueba si existe el grupo
						then	
							tput cup 15 0
							echo "                                                                             "
							tput cup 15 0
							read -p "Esta seguro que desea agregar al usuario $user al grupo normal_1? s/n: " sn
							case $sn in
								s)
								sudo useradd -r -d "/bin/null" -g "normal_1" -s "/bin/false" $user #se crea usuario
								sudo passwd $user #cambio de contrasena
								echo "usuario dado de alta: $user $dia $hora">>./log
								tput cup 14 50
								echo "Usuario creado!"
								tput cup 28 0
								echo "Presione una tecla para volver al menu..."
								read
								rm temp_usuarios
								rm temp_grupos
								e=0
								i=0
								;;
								n)
								tput cup 16 0
								echo "                                                                      "
								
								rm temp_usuarios
								rm temp_grupos
								
								;;
								*)
								tput cup 17 0
								echo "ERROR: Opcion invalida!"
								sleep 1
								;;
							esac
						else	
							tput cup 22 0
							read -p "ERROR: El grupo seleccionado no existe, desea acceder al menu de grupos? s/n:" sn
							case $sn in
								s) bash adm_grupos
							 	;;
								n) read -p "Cancelando... " -t 2
								tput cup 15 0
								echo "                                                                      "
								tput cup 16 0
								echo "                                                                      "
								;;
								*) echo "ERROR: Opcion invalida"
								sleep 1
								
							esac
						
						fi
					
						;;
#creacion de usuario normal_2	
						normal_2)
						tput cup 13 50
						echo "-Grupo: $group"
						if grep -w ^"normal_2" ./temp_grupos > null #comprueba si existe el grupo
						then	
							tput cup 15 0
							echo "                                                                            "
							tput cup 15 0
							read -p "Esta seguro que desea agregar al usuario $user al grupo normal_2? s/n: " sn
							case $sn in
								s)
								sudo useradd -g "normal_2" -d "/home/$user" -m -s "/bin/bash" $user #se crea usuario
								sudo passwd $user #cambio de contrasena
								echo "usuario dado de alta: $user $dia $hora">>./log
								tput cup 14 50
								echo "Usuario creado!"
								tput cup 28 0
								echo "Presione una tecla para volver al menu..."
								read
								rm temp_usuarios
								rm temp_grupos
								e=0
								i=0
								;;
								n)
								tput cup 16 0
								echo "                                                                      "
								tput cup 15 0
								echo "                                                                      "
								rm temp_usuarios
								rm temp_grupos
								
								;;
								*)
								tput cup 17 0
								echo "ERROR: Opcion invalida!"
								sleep 1
								;;
							esac
						else	
							tput cup 22 0
							read -p "ERROR: El grupo seleccionado no existe, desea acceder al menu de grupos? s/n:" sn
							case $sn in
								s) bash adm_grupos
							 	;;
								n) read -p "Cancelando... " -t 2
								tput cup 15 0
								echo "                                                                      "
								tput cup 16 0
								echo "                                                                      "
								;;
								*) echo "ERROR: Opcion invalida"
								sleep 1
								
							esac
						
						fi
					
						;;
#creacion de usuario especial							
						especial)
						tput cup 13 50
						echo "-Grupo: $group"
						if grep -w ^"especial" ./temp_grupos > null #comprueba si existe el grupo
						then	
							tput cup 15 0
							echo "                                                                            "
							tput cup 15 0
							read -p "Esta seguro que desea agregar al usuario $user al grupo especial? s/n: " sn
							case $sn in
								s)
								sudo useradd -r -g "especial" -d "/bin/null" -s "/bin/false" $user #se crea usuario
								sudo passwd $user #cambio de contrasena
								echo "usuario dado de alta: $user $dia $hora">>./log
								tput cup 14 50
								echo "Usuario creado!"
								tput cup 28 0
								echo "Presione una tecla para volver al menu..."
								read
								rm temp_usuarios
								rm temp_grupos
								e=0
								i=0
								;;
								n)
								tput cup 16 0
								echo "                                                                      "
								
								rm temp_usuarios
								rm temp_grupos
								
								;;
								*)
								tput cup 17 0
								echo "ERROR: Opcion invalida!"
								sleep 1
								;;
							esac
						else	
							tput cup 22 0
							read -p "ERROR: El grupo seleccionado no existe, desea acceder al menu de grupos? s/n:" sn
							case $sn in
								s) bash adm_grupos
							 	;;
								n) read -p "Cancelando... " -t 2
								tput cup 15 0
								echo "                                                                      "
								tput cup 16 0
								echo "                                                                      "
								;;
								*) echo "ERROR: Opcion invalida"
								sleep 1
								
							esac
						
						fi
					
						;;
					*)
					tput cup 15 0
					echo "                                                                                          "
					tput cup 15 0
					read -p "ERROR: El grupo seleccionado no existe, desea acceder al menu de grupos? s/n:" sn
					case $sn in
						s) bash adm_grupos.sh
						;;
						n)
						tput cup 15 0
						echo "                                                                                     "
						tput cup 16 0
						echo "                                                                                     "
						;;
						*) echo "ERROR: Opcion invalida"
						sleep 1
					esac
					
					esac #case $group in

				done
				fi
				fi
				done
				;;
#cambiar contrasena
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
				echo   "<< Administracion de Usuarios >>" 
				tput sgr0
				tput cup 6 50
				echo ""
				tput sgr0
				tput rev
				tput cup 7 58
				echo "ABM Ususarios"
				tput sgr0
				tput cup 10 50
				echo "> Cambiar contrasena (q/salir)"
				tput cup 12 50
				echo "-Usuario:"
				tput cup 15 0
				read -p "Ingrese nombre de usuario:" user
				tput cup 12 50
				echo "-Usuario: $user"
				if [ $user == "q" ]
				then
					tput cup 17 0
					echo "Regresando al menu."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu.."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu..."
					i=0
				else

				tput sgr0
				cat /etc/passwd | cut -d: -f1 > temp_usuarios
				if grep -iw ^"$user" ./temp_usuarios > null #comprueba si existe el usuario -iw comprueba la palabra entera
				then
					tput cup 15 0
					sudo passwd $user #cambio de contrasena
					echo "contrasena modificada: $user $dia $hora">>./log
					tput cup 14 50
					echo "Contrasena modificada!"
					read
					tput cup 24 0
					echo "Regresando al menu."
					sleep 1
					tput cup 24 0
					echo "Regresando al menu.."
					sleep 1
					tput cup 24 0
					echo "Regresando al menu..."
					sleep 1
					rm temp_usuarios
					i=0
				
				else
					
					echo "ERROR: El usuario no existe"
					read
					rm temp_usuarios
				fi
				fi
				done
				;;
#modificar nombre usuario	
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
				echo   "<< Administracion de Usuarios >>" 
				tput sgr0
				tput cup 6 50
				echo ""
				tput sgr0
				tput rev
				tput cup 7 58
				echo "ABM Ususarios"
				tput sgr0
				tput cup 10 50
				echo "> Modificar nombre (q/salir)"
				tput cup 12 50
				echo "-Usuario:"
				tput cup 15 0
				read -p "Ingrese nombre de usuario a modificar:" user
				tput cup 12 50
				echo "-Usuario: $user"
				if [ $user == "q" ]
				then
					tput cup 17 0
					echo "Regresando al menu."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu.."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu..."
					i=0
				else
				
				cat /etc/passwd | cut -d: -f1 > temp_usuarios
				if grep -iw ^"$user" ./temp_usuarios > null #comprueba si existe el usuario -iw comprueba la palabra entera
				then
					tput cup 15 0
					echo "                                                                        "
					tput cup 15 0
					read -p "Ingrese nuevo nombre de usuario:" usernew
					rm temp_usuarios
					cat /etc/passwd | cut -d: -f1 > temp_usuarios
					if grep -iw ^"$usernew" ./temp_usuarios > null #comprueba si existe el usuario 
					then
						tput cup 13 50
						echo "ERROR: el usuario nuevo ya esta en uso!"
						read
					else
						sleep 1
						read -p "Esta seguro que desea cambiar el nombre de usuario $user por $usernew? s/n: " sn
							case $sn in
								s)
								tput cup 15 0
								sudo usermod -l $usernew $user #cambio de login
								echo "Se modifico nombre de usuario: $user nuevo nombre $usernew $dia $hora">>./log
								tput cup 13 50
								echo "-Nuevo nombre de usuario: $usernew"
								tput cup 14 50
								echo "Se cambio nombre de forma exitosa!"
								read
								rm temp_usuarios
								i=0
								;;
								n)
								tput cup 17 0
								echo "Regresando al menu."
								sleep 1
								tput cup 17 0
								echo "Regresando al menu.."
								sleep 1
								tput cup 17 0
								echo "Regresando al menu..."
								sleep 1
								rm temp_usuarios
								i=0
								;;
								*)
								tput cup 17 0
								echo "ERROR: Opcion invalida!"
								sleep 1
								;;
							esac
						
					fi	
				else
					
					echo "ERROR: El usuario no existe"
					read
					rm temp_usuarios
				fi
				fi
				done
				;;
#eliminar usuario	
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
				echo   "<< Administracion de Usuarios >>" 
				tput sgr0
				tput cup 6 50
				echo ""
				tput sgr0
				tput rev
				tput cup 7 58
				echo "ABM Ususarios"
				tput sgr0
				tput cup 10 50
				echo "> Eliminar usuario (q/salir)"
				tput cup 12 50
				echo "-Usuario:"
				tput cup 15 0
				read -p "Ingrese nombre de usuario a Eliminar:" user
				tput cup 12 50
				echo "-Usuario: $user"
				
				if [ $user == "q" ]
				then
					tput cup 17 0
					echo "Regresando al menu."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu.."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu..."
					i=0
				else
				cat /etc/passwd | cut -d: -f1 > temp_usuarios
				if grep -iw ^"$user" ./temp_usuarios > null #comprueba si existe el usuario -iw comprueba la palabra entera
				then
					tput cup 15 0
					read -p "Ingrese nuevamente el nombre de usuario a eliminar para confirmar el proceso: " userconf
					if [ $user == $userconf ]
					then
					tput cup 16 0
					read -p "Desea eliminar tambien archivos y subdirectorios del usuario? s/n:" sn
						case $sn in
							s) 
							
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar)."
							sleep 1
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar).."
							sleep 1
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar)..."
							sleep 1
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar)...."
							sleep 1
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar)....."
							sleep 1
							sudo userdel -r $user 2>>./log
							echo "Se elimino usuario: $user $dia $hora">>./log
							tput cup 19 0
							echo "Se elimino usuario $user junto con sus archivos y directorios!"
							read
							rm temp_usuarios		
							i=0
							 ;;
							n) 
							
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar)."
							sleep 1
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar).."
							sleep 1
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar)..."
							sleep 1
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar)...."
							sleep 1
							tput cup 17 0
							echo "Se procede a eliminar usuario (presione ctrol+c para 	cancelar)....."
							sleep 1
							sudo userdel $user 2>>./log
							echo "Se elimino usuario: $user $dia $hora">>./log
							tput cup 19 0
							echo "Se elimino usuario $user, se mantienen sus archivos y directorios!"
							read
							tput cup 18 0
							echo "                                                                      "
							rm temp_usuarios
							i=0
								
					
						esac
					else
						tput cup 16 0
						read -p "ERROR: El usuario no coincide"
					fi
				else
					
					echo "ERROR: El usuario no existe"
					read
					rm temp_usuarios
				fi
				fi
				done
				;;
#cambiar permisos
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
				echo   "<< Administracion de Usuarios >>" 
				tput sgr0
				tput cup 6 50
				echo ""
				tput sgr0
				tput rev
				tput cup 7 58
				echo "ABM Ususarios"
				tput sgr0
				tput cup 10 50
				echo "> Modificar permisos de usuario (q/salir)"
				tput cup 12 50
				echo "-Usuario:"
				tput cup 15 0
				read -p "Ingrese nombre de usuario a modificar:" user
				tput cup 12 50
				echo "-Usuario: $user"
				tput cup 13 50
				echo "-Grupo/s:"
				
				if [ $user == "q" ]
				then
					tput cup 17 0
					echo "Regresando al menu."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu.."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu..."
					i=0
				else
				cat /etc/passwd | cut -d: -f1 > temp_usuarios
				cat /etc/group | cut -d: -f1 > temp_grupos
				if [ $user == "l" ]
				then
				less temp_usuarios
				else	 
				if grep -iw ^"$user" ./temp_usuarios > null #comprueba si existe el usuario -iw comprueba la palabra entera
				then
					tput cup 12 50
					echo "-Usuario: $user"
					tput cup 13 64
					p=`id $user | cut -d= -f4`
					id $user | cut -d= -f4 > temp_grupouser
					echo "$p"
					tput cup 16 0
					read -p "Ingrese el grupo que quiere configurar como primario: " group
					if grep "$group" ./temp_grupouser > null #comprueba si el grupo es parte de los del usuario
					then 
		#cambiar permisos para root			
						if [ $group == "root" ]
						then
						tput cup 17 0
						echo "Alerta: Se procede a modificar los permisos del usuario!"
						read -p "Esta seguro que desea que este grupo sea primario? s/n :" sn
						tput cup 17 0
						echo "                                                                                          "
							case $sn in
								s)
								primario=`cat temp_grupouser | gawk -F '[=()]' '{ print $2 }'`
								tput cup 20 0
								if [ -d /home/$user/ ]
								then
								sudo sudo usermod -g "root" -d "/home/$user" -s "/bin/bash" $user 2>>./log
								tput cup 25 0
								sudo usermod -G $primario $user 2>>./log
								else
								sudo usermod -g "root" -d "/home/$user" -m -s "/bin/bash" $user 2>>./log
								tput cup 25 0
								sudo usermod -G $primario $user 2>>./log
								fi
								echo "Se cambio grupo primario!"
								echo "Configuracion actual del usuario:"
								grep -w $user /etc/passwd
								echo "Se cambio permisos de usuario: `grep -w $user /etc/passwd` $dia $hora">>./log
								rm temp_grupouser
								echo "presione una tecla para volver..."
								read
								;;
								n)
								;;
								*)
								echo "ERROR: opcion erronea!" 
							esac
			#cambiar permisos para normal_1

						elif [ $group == "normal_1" ]
						then
						tput cup 17 0
						echo "Alerta: Se procede a modificar los permisos del usuario!"
						read -p "Esta seguro que desea que este grupo sea primario? s/n :" sn
						tput cup 17 0
						echo "                                                                                          "
							case $sn in
								s)
								primario=`cat temp_grupouser | gawk -F '[=()]' '{ print $2 }'`
								tput cup 20 0
								sudo usermod -g "normal_1" -d "/bin/null" -s "/bin/false" $user 2>>./log
								tput cup 25 0
								sudo usermod -G $primario $user 2>>./log
								echo "Se cambio grupo primario!"
								echo "Configuracion actual del usuario:"
								grep -w $user /etc/passwd
								echo "Se cambio permisos de usuario: `grep -w $user /etc/passwd` $dia $hora">>./log
								echo "presione una tecla para volver..."
								read
								;;
								n)
								;;
								*)
								echo "ERROR: opcion erronea!" 
							esac

			#cambiar permisos para normal_2

						elif [ $group == "normal_2" ]
						then
						tput cup 17 0
						echo "Alerta: Se procede a modificar los permisos del usuario!"
						read -p "Esta seguro que desea que este grupo sea primario? s/n :" sn
						tput cup 17 0
						echo "                                                                                          "
							case $sn in
								s)
								primario=`cat temp_grupouser | gawk -F '[=()]' '{ print $2 }'`
								tput cup 20 0
								if [ -d /home/$user/ ]
								then
								sudo sudo usermod -g "normal_2" -d "/home/$user" -s "/bin/bash" $user 2>>./log
								sudo usermod -G $primario $user 2>>./log
								else
								sudo usermod -g "normal_2" -d "/home/$user" -m -s "/bin/bash" $user 2>>./log
								tput cup 25 0
								sudo usermod -G $primario $user 2>>./log
								fi
								echo "Se cambio grupo primario!"
								echo "Configuracion actual del usuario:"
								grep -w $user /etc/passwd
								echo "Se cambio permisos de usuario: `grep -w $user /etc/passwd` $dia $hora">>./log
								echo "presione una tecla para volver..."
								read
								;;
								n)
								;;
								*)
								echo "ERROR: opcion erronea!" 
							esac

			#cambiar permisos para especial
						
						elif [ $group == "especial" ]
						then
						tput cup 17 0
						echo "Alerta: Se procede a modificar los permisos del usuario!"
						read -p "Esta seguro que desea que este grupo sea primario? s/n :" sn
						tput cup 17 0
						echo "                                                                                          "
							case $sn in
								s)
								primario=`cat temp_grupouser | gawk -F '[=()]' '{ print $2 }'`
								tput cup 20 0
								sudo usermod -g "especial" -d "/bin/null" -s "/bin/false" $user 2>>./log
								tput cup 25 0
								sudo usermod -G $primario $user 2>>./log
								echo "Se cambio grupo primario!"
								echo "Configuracion actual del usuario:"
								grep -w $user /etc/passwd
								echo "Se cambio permisos de usuario: `grep -w $user /etc/passwd` $dia $hora">>./log
								echo "presione una tecla para volver..."
								read
								;;
								n)
								;;
								*)
								echo "ERROR: opcion erronea!"
								sleep 2 
							esac
						else
							echo "ERROR: Grupo incorrecto!"
							read -p "Presione una tecla.."
						fi
					else
						echo "ERROR: El usuario no es parte de ese grupo!"
						read -p "Presione una tecla.."
					fi
				else
					echo "ERROR: El usuario no existe!"
					read -p "Presione una tecla.."
				fi
				fi
				fi
				done
			;;

			esac #case $opcmenuuser in
	

		done

	esac #case $opcmenulist in

done



tput rc





<<comentario

tput clear
tput setaf 10
echo "holaaaaaaaaaaaa"
tput sgr0

tput rev
tput cup 3 50
echo "asdasd"
echo "asdasdasdas"
tput sgr0

comentario



