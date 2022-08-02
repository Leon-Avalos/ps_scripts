#!/bin/bash

# Name: inCore/Odoo server databases info 
# Description: Script for get database list in Postgres and for each database get the info about the company stored in a table-
#              Then export to CSV file for further processing
# Author: Leon-Avalos

# Databases list
databases=(dbname1...)


get_last_access(){
	su -c "psql -d $1 -c \"SELECT DISTINCT backend_start::date FROM pg_stat_activity;\"" postgres | awk 'FNR == 3 {print}'
}
# Obtiene la lista de bases de datos del catalogo de dbs
# Corta las 3 primeras lineas que son cabeceras, elimina los dos ultimos espacios y  filtra por las que no sean template o base

get_database_list(){
    su -c "psql -c \"SELECT datname FROM pg_database;\"" postgres | tail -n +3 | head -n -2 | egrep -v 'template0|template1|postgres'
}
# Obtiene el nombre de la compañia registrada en la tabla res_company
# Filtra las 3 primeras lineas que son de cabecera dejando solo los nombres, recibe como parametro el nombre de la base de datos  
get_company_name(){
    su -c "psql -d $1 -c \"SELECT name FROM res_company;\"" postgres | awk 'FNR == 3 {print}'
}

#Obtiene por cada base de datos el telefono registrado en res_company.phone
get_company_phone(){
    su -c "psql -d $1 -c \"SELECT phone FROM res_company;\"" postgres | awk 'FNR == 3 {print}'
}
# Obtiene la fecha de creacion de la tabla de compañia 
get_creation_date(){
    su -c "psql -d $1 -c \"SELECT create_date::date FROM res_company;\"" postgres | awk 'FNR == 3 {print}'
}
# Obtiene la informacion de las demas funciones iterando por cada base de datos en la lista
collect_info(){ 
    for database in "${databases[@]}"
    do  echo "Nombre DB - Nombre   -   Telefono  -  Ultimo acceso - Creacion"
        echo $database,$(get_company_name $database),$(get_company_phone $database), $(get_last_access $database), $(get_creation_date $database)
    done
}

collect_info
