#! /bin/bash

tput sgr0
clear
rm temp_usuarios
rm temp_grupos
rm temp_usu

dia=`date +"%d/%m/%Y"`
hora=`date +"%H:%M"`

#MENU PRINCIPAL
opcmenupri=1
while [ "$opcmenupri" != 0 ]
do
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
	echo "ABM Grupos"
	tput sgr0
	tput cup 12 52
	echo "1. Alta nuevo Grupo"
	tput cup 13 52
	echo "2. Administrar Grupo"
	tput cup 14 52
	echo "3. Eliminar Grupo"
	tput cup 15 52
	echo "4. Listar Grupos"
	tput cup 16 52
	echo "0. Salir"
	tput cup 22 48
	echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
	tput sgr0
	tput cup 20 52
	tput bold #negrita
	read -p "Ingrese opcion:" opcmenupri

	case $opcmenupri in

		0)
		bash AdminUsers.sh
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
		echo   "<< Administracion de Usuarios >>" 
		tput sgr0
		tput cup 6 50
		echo ""
		tput sgr0
		tput rev
		tput cup 7 58
		echo "ABM Grupos"
		tput sgr0
		tput cup 10 50
		echo "> Alta nuevo grupo"
		tput cup 12 50
		echo "-Grupo:"
		tput cup 15 0
		read -p "Ingrese nombre de grupo a crear:" group
		cat /etc/group | cut -d: -f1 > temp_grupos
		if grep -iw ^"$group" ./temp_grupos > null #comprueba si existe el grupo-iw comprueba la palabra entera
		then
			echo "ERROR: El grupo ya existe"
			read
			rm temp_grupos
		else
			tput cup 12 50
			echo "-Grupo: $group"
			sudo groupadd $group
			tput cup 14 50
			echo "Se creo el grupo de forma exitosa!"
			tput cup 15 0
			read -p "Desea agregar usuarios al grupo creado? s/n" sn
			case $sn in
				s)
				#llamar script agregar usuario a grupo
				;;
				n)
				tput cup 16 0
				echo "Presione Enter para regresar al menu"
				read
				i=0
				;;
				*)
				tput cup 16 0
				echo "ERROR: opcion invalida!"
				read
				;;
			esac
			
			
		fi
		done
		;;
#menu ADMINISTRAR GRUPOS
		2)
		tput sgr0
		clear
		t=1
		while [ "$t" != 0 ]
		do
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
		echo "Administrar Grupos"
		tput sgr0
		tput cup 12 52
		echo "1. Agregar usuario a un grupo"
		tput cup 13 52
		echo "2. Eliminar usuario de un grupo "
		tput cup 14 52
		echo "3. Modificar nombre de un grupo "
		tput cup 15 52
		echo "4. Eliminar un grupo"
		tput cup 16 52
		echo "0. Volver"
		tput cup 22 48
		echo "<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
		tput sgr0
		tput cup 20 52
		tput bold #negrita
		read -p "Ingrese opcion:" opcmenugrupo	

		case $opcmenugrupo in
			0)
			break
			;;

			1)
#agregar usuario a un grupo
				tput sgr0
				clear
				r=1
				while [ "$r" != 0 ]
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
				echo "Administrar grupos"
				tput sgr0
				tput cup 10 50
				echo "> Agregar usuario a un grupo (q/salir)"
				tput cup 12 50
				echo "-Usuario:"
				tput cup 13 50
				echo "-Grupo actual:"
				tput cup 14 50
				echo "-Grupo nuevo:"	
				tput cup 15 0
				echo "(Presione l + Enter para listar usuarios)"
				tput cup 16 0
				read -p "Ingrese nombre de usuario:" user
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
					r=0
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
					#g=`grep -iw ^"$user" /etc/passwd | cut -d: -f4` #guardo el id de grupo del usuario
					#p=`id $user | cut -d= -f4`  #guarda las grupos del usuario en la variable
					#p=`grep $user /etc/group | cut -d: -f1 | paste -s -d "\|"`
					p=`id $user | cut -d= -f4`
					tput cup 15 0
					echo "(Presione l + Enter para listar grupos)"
					tput cup 16 0
					read -p "Ingrese el nuevo grupo a la cual quiere pertenecer: " group
					if [ $group == "l" ]
					then
					less temp_grupos
<<comentar
					elif [ $group == "root" ]
					then
					tput cup 17 0
					echo "Alerta: Tome en cuenta que al cambiar el grupo primario cambian los permisos del usuario."
					read -p "Desea que este grupo sea primario? s/n :" sn
					tput cup 17 0
					echo "                                                                                          "
						case $sn in
							s)
							sudo usermod -g "root" -d "/home/$user" -m -s "/bin/bash" $user
							echo "Se cambio grupo primario!"
							read
							;;
							n)
							;;
							*)
							echo "ERROR: opcion erronea!" 
						esac
comentar
					else
					if grep -iw ^"$group" ./temp_grupos #busca si existe el grupo en el archivo temp
					then
						sudo gpasswd -a $user $group
						echo "usuario agregado a grupo: $user en $group $dia $hora">>./log
						tput cup 14 50
						echo "-Grupo Nuevo: $group"
						tput cup 18 0
#eliminarlo de otro grupo comprueba grupo primaro
						read -p "Se agrego el usuario de forma exitosa!, desea eliminarlo de otro grupo? s/n" sn
						case $sn in
							s)
							y=1
							while [ "$y" != 0 ]
							do
							tput cup 19 0
							read -p "Ingrese el grupo:" elimgrupo
							id $user | cut -d= -f4 > temp_grup #guardo el/los grupo/s del usuario en temporal
							cat ./temp_grup
							read
							if grep -iw "$elimgrupo" ./temp_grup > null
							then	
								primario=`id $user | gawk -F '[=()]' '{ print $6 }'` #guarda el primario
								if [ $elimgrupo == $primario ] #comparo el grupo a eliminar con el primario
								then
									w=1
									while [ "$w" != 0 ]
									do
									tput cup 21 0
									read -p "Alerta: Esta queriendo eliminar el grupo primario, ingrese un grupo secundario para setearlo como primario: " secundario
									grep $user /etc/group | cut -d: -f1 > temp_grupos2 #guardo los grupos
									if grep -iw ^"$secundario" ./temp_grupos2 #verifico q secund exista
									then
										sudo usermod -g $secundario $user #cambia el primario 
										tput cup 22 0
										echo "Se modifico grupo primario"
										echo "Se modifico grupo primario: $user en $secundario $dia $hora">>./log
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar).."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)..."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)...."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)....."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)......"
										sudo gpasswd -d $user $elimgrupo #desasocio user del grupo
										echo "se elimino usuario de grupo: $user en $group $dia $hora">>./log
										rm temp_grup
										rm temp_grupos2
										rm temp_grupos
										w=0
										
									else
										tput cup 21 0
										read -p "ERROR: Grupo secundario incorrecto!"
									fi
									done
								else
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar).."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)..."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)...."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)....."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)......"
									sudo gpasswd -d $user $elimgrupo #desasocio user del grupo
									echo "se elimino usuario de grupo: $user en $group $dia $hora">>./log
									rm temp_grup temp_grupos2 tempo_grupos 2>>./null
									
								fi
							else
								tput cup 21 0
								read -p "ERROR:El grupo que ingreso es incorrecto!"	
							fi
							tput cup 27 0
							read -p "Presione una tecla para volver al menu"

							rm temp_usuarios temp_grupos temp_usu temp_gru 2>>./null
							y=0
							r=0
							break
				break
							done
							;;

							n)
							sleep 1
							tput cup 24 0
							echo "Regresando al menu."
							sleep 1
							tput cup 24 0
							echo "Regresando al menu.."
							sleep 1
							tput cup 24 0
							echo "Regresando al menu..."
							rm temp_usuarios temp_grupos temp_usu temp_gru 2>>./null
							break
				break
						esac
					else
						tput cup 17 0
						echo "ERROR: El grupo  que ingreso no existe!"
						read
					fi
					fi
				else
				tput cup 17 0
				echo "ERROR: Usuario no existe"
				read
				fi
				fi
				fi
				done
			;;
				
			2)
#eliminar usuario de un grupo
				tput sgr0
				clear
				r=1
				while [ "$r" != 0 ]
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
				echo "Administrar grupos"
				tput sgr0
				tput cup 10 50
				echo "> Eliminar usuario de un grupo (q/salir)"
				tput cup 12 50
				echo "-Usuario:"
				tput cup 13 50
				echo "-Grupo actual:"	
				tput cup 15 0
				echo "(Presione l + Enter para listar usuarios)"
				tput cup 16 0
				read -p "Ingrese nombre de usuario: " user
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
					r=0
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
					#g=`grep -iw ^"$user" /etc/passwd | cut -d: -f4` #guardo el id de grupo del usuario
					#id $user | cut -d= -f4 > temp_grup #guardo el/los grupo/s del usuario
					#p=`grep $user /etc/group | cut -d: -f1 | paste -s -d "\|"`  #guarda las grupos del usuario en la variable
					p=`id $user | cut -d= -f4`
					tput cup 15 0
					echo "(Presione l + Enter para listar grupos)"
					tput cup 16 0
					read -p "Ingrese el grupo al que desea dejar de pertenecer: " elimgrupo
					id $user | cut -d= -f4 > temp_grup #guardo el/los grupo/s del usuario en temporal
							cat ./temp_grup
							read
							if grep -iw "$elimgrupo" ./temp_grup > null
							then	
								primario=`id $user | gawk -F '[=()]' '{ print $6 }'` #guarda el primario
								if [ $elimgrupo == $primario ] #comparo el grupo a eliminar con el primario
								then
									w=1
									while [ "$w" != 0 ]
									do
									tput cup 21 0
									read -p "Alerta: Esta queriendo eliminar el grupo primario, ingrese un grupo secundario para setearlo como primario: " secundario
									grep $user /etc/group | cut -d: -f1 > temp_grupos2 #guardo los grupos
									if grep -iw ^"$secundario" ./temp_grupos2 #verifico q secund exista
									then
										sudo usermod -g $secundario $user #cambia el primario 
										tput cup 22 0
										echo "Se modifico el grupo primario"
										echo "se modifico el grupo primario: $user primario: $secundario $dia $hora">>./log
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar).."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)..."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)...."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)....."
										sleep 1
										tput cup 23 0
										echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)......"
										sudo gpasswd -d $user $elimgrupo #desasocio user del grupo
										echo "se elimino usuario de grupo: $user de $elimgrupo $dia $hora">>./log
										rm temp_grup temp_grupo2 temp_grupos 2>>./null
										w=0
										
									else
										tput cup 21 0
										read -p "ERROR: Grupo secundario incorrecto!"
									fi
									done
								else
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar).."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)..."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)...."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)....."
									sleep 1
									tput cup 23 0
									echo "Se procede a eliminar $user del grupo $elimgrupo (presione ctrol+c para 	cancelar)......"
									sudo gpasswd -d $user $elimgrupo #desasocio user del grupo
									echo "se elimino usuario de grupo: $user en $elimgrupo $dia $hora">>./log
									rm temp_grup temp_grupos2 temp_grupos
								fi
							else
								tput cup 21 0
								read -p "ERROR:El grupo que ingreso es incorrecto!"	
							fi
							tput cup 27 0
							read -p "Presione una tecla para volver al menu"
<<comentar
					if [ $group == "l" ]
					then
					less temp_grupos
					else
					if grep -iw ^"$group" ./temp_grupos #busca si existe el grupo en el archivo temp
					then
						tput cup 23 0
						echo "Se procede a eliminar $user del grupo $group (presione ctrol+c para cancelar)."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar $user del grupo $group (presione ctrol+c para cancelar).."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar $user del grupo $group (presione ctrol+c para cancelar)..."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar $user del grupo $group (presione ctrol+c para cancelar)...."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar $user del grupo $group (presione ctrol+c para cancelar)....."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar $user del grupo $group (presione ctrol+c para cancelar)......"
						sudo gpasswd -d $user $group
						rm temp_grupos
						rm temp_grup
						rm temp_usuarios
						tput cup 26 0
						read -p "Presione una tecla para volver..."
				break
					else
						tput cup 21 0
						read -p "ERROR:El grupo que ingreso no existe!"
					fi
					fi
comentar
				else
					read -p "ERROR: El usuario no existe!"	
				fi
				fi
				fi
			
				done
			;;
#modificar nombre de un grupo			
			3)
				
				tput sgr0
				clear
				r=1
				while [ "$r" != 0 ]
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
				echo "Administrar grupos"
				tput sgr0
				tput cup 10 50
				echo "> Modificar nombre de un grupo (q/salir)"
				tput cup 12 50
				echo "-Nombre actual del grupo:"
				tput cup 13 50
				echo "-Nombre nuevo del grupo:"	
				tput cup 15 0
				echo "(Presione l + Enter para listar grupos)"
				tput cup 16 0
				read -p "Ingrese nombre de grupo a modificar: " group
				if [ $group == "q" ]
				then
					tput cup 17 0
					echo "Regresando al menu."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu.."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu..."
					r=0
				else
				cat /etc/group | cut -d: -f1 > temp_grupos
				if [ $group == "l" ]
				then
				less temp_grupos
				else	 
				if grep -iw ^"$group" ./temp_grupos > null #comprueba si existe el grupo -iw comprueba la palabra entera
				then
					tput cup 12 50
					echo "-Nombre actual del grupo: $group"
					tput cup 16 0
					read -p "Ingrese el nuevo nombre del grupo a modificar: " nuevogroup
					if grep -iw ^"$nuevogroup" ./temp_grupos > null #comprueba si existe el grupo -iw comprueba la palabra entera
					then
						tput cup 17 0
						read -p "ERROR: El nuevo nombre ya existe!"
					else						
						tput cup 13 50
						echo "-Nombre nuevo del grupo: $nuevogroup"	
						tput cup 23 0
						echo "Se procede a modificar el nombre del grupo " $group " por " $nuevogroup "  (presione ctrol+c para cancelar)."
						sleep 1
						tput cup 23 0
						echo "Se procede a modificar el nombre del grupo " $group " por " $nuevogroup "  (presione ctrol+c para cancelar).."
						sleep 1
						tput cup 23 0
						echo "Se procede a modificar el nombre del grupo " $group " por " $nuevogroup "  (presione ctrol+c para cancelar)..."
						sleep 1
						tput cup 23 0
						echo "Se procede a modificar el nombre del grupo " $group " por " $nuevogroup "  (presione ctrol+c para cancelar)...."
						sleep 1
						tput cup 23 0
						echo "Se procede a modificar el nombre del grupo " $group " por " $nuevogroup "  (presione ctrol+c para cancelar)....."
						sleep 1
						tput cup 23 0
						echo "Se procede a modificar el nombre del grupo " $group " por " $nuevogroup "  (presione ctrol+c para cancelar)......"
						sudo groupmod -n $nuevogroup $group
						tput cup 25 0
						echo "Se modifico el nombre de grupo de manera exitosa!"
						echo "se modifico el nombre de grupo: $group cambia por $nuevogroup $dia $hora">>./log
						read -p "Presione una tecla para continuar..."
						
				
				break
					fi
				else
					tput cup 17 0
					echo "ERROR: el grupo que ingreso no existe!"
					read
				fi
				fi
				fi
				done
			;;
#Eliminar un grupo			
			4)

				tput sgr0
				clear
				r=1
				while [ "$r" != 0 ]
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
				echo "Administrar grupos"
				tput sgr0
				tput cup 10 50
				echo "> Eliminar un grupo (q/salir)"
				tput cup 12 50
				echo "-Nombre del grupo:"	
				tput cup 14 0
				tput bold
				echo ">Considere que para eliminar un grupo debera quitar sus usuarios anteriormente a este procedimiento<"
				tput sgr0
				tput cup 15 0
				echo "(Presione l + Enter para listar grupos)"
				tput cup 16 0
				read -p "Ingrese nombre de grupo a eliminar: " group
				if [ $group == "q" ]
				then
					tput cup 17 0
					echo "Regresando al menu."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu.."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu..."
					r=0
				else
				cat /etc/group | cut -d: -f1 > temp_grupos
				if [ $group == "l" ]
				then
				less temp_grupos
				else	 
				if grep -iw ^"$group" ./temp_grupos > null #comprueba si existe el grupo -iw comprueba la palabra entera
				then
					tput cup 12 50
					echo "-Nombre del grupo: $group"
					tput cup 16 0
					read -p "Si esta seguro que desea eliminar el grupo ingrese nuevamente nombre del mismo: " nomgroup
					if [ $group == $nomgroup ] #comprueba si existe el grupo -iw comprueba la palabra entera
					then					
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar).."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)..."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)...."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)....."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)......"
						sudo groupdel $group
						echo "se elimino grupo: $group $dia $hora">>./log
						tput cup 25 0
						read -p "Presione una tecla para continuar..."
						rm temp_grupos 2>>./null
						r=0
					else
						tput cup 17 0
						read -p "ERROR: El nombre no coincide!"
					fi
				else
					tput cup 17 0
					echo "ERROR: el grupo que ingreso no existe!"
					read
				fi
				fi
				fi
				done
			
		esac

		done
		;;
#eliminar un grupo
		3)
				tput sgr0
				clear
				r=1
				while [ "$r" != 0 ]
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
				echo "Administrar grupos"
				tput sgr0
				tput cup 10 50
				echo "> Eliminar un grupo (q/salir)"
				tput cup 12 50
				echo "-Nombre del grupo:"	
				tput cup 14 0
				tput bold
				echo ">Considere que para eliminar un grupo debera quitar sus usuarios anteriormente a este procedimiento<"
				tput sgr0
				tput cup 15 0
				echo "(Presione l + Enter para listar grupos)"
				tput cup 16 0
				read -p "Ingrese nombre de grupo a eliminar: " group
				if [ $group == "q" ]
				then
					tput cup 17 0
					echo "Regresando al menu."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu.."
					sleep 1
					tput cup 17 0
					echo "Regresando al menu..."
					r=0
				else
				cat /etc/group | cut -d: -f1 > temp_grupos
				if [ $group == "l" ]
				then
				less temp_grupos
				else	 
				if grep -iw ^"$group" ./temp_grupos > null #comprueba si existe el grupo -iw comprueba la palabra entera
				then
					tput cup 12 50
					echo "-Nombre del grupo: $group"
					tput cup 16 0
					read -p "Si esta seguro que desea eliminar el grupo ingrese nuevamente nombre del mismo: " nomgroup
					if [ $group == $nomgroup ] #comprueba si existe el grupo -iw comprueba la palabra entera
					then					
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar).."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)..."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)...."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)....."
						sleep 1
						tput cup 23 0
						echo "Se procede a eliminar el grupo $group (presione ctrol+c para cancelar)......"
						sudo groupdel $group
						echo "se elimino grupo: $group $dia $hora">>./log
						tput cup 25 0
						read -p "Presione una tecla para continuar..."
						rm temp_grupos 2>>./null
						r=0
					else
						tput cup 17 0
						read -p "ERROR: El nombre no coincide!"
					fi
				else
					tput cup 17 0
					echo "ERROR: el grupo que ingreso no existe!"
					read
				fi
				fi
				fi
				done
		;;

	esac
done
