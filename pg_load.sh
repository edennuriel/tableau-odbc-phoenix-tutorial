#!/usr/bin/env bash
export host=enchla-8-master-3
export user=admin
export pass=admin1234
export db=corp

pg() {
	psql -h ${host} -U ${user} -d ${db} "$@"
}

pgf() {
	pg -f "$1"
}


psql -h ${host} -U postgres postgres  << EOF 2>>stderr 1>>stdout
drop database if exists $db;
create database $db;
create user $user password 'admin1234';
grant all privileges on database $db to $user;
EOF

pg -e << EOF2 
create schema $db;
SET search_path TO "$user",public,$db;
EOF2

for i in `ls sql/*.sql`; do cat $i | sed 's/VARCHAR/VARCHAR(255)/' > tmp/ct.sql ; pgf tmp/ct.sql 2>>stderr 1>>stdout; done 
cat /dev/null > tmp/lt.sql
for i in `ls data/*.csv` 
do 
	tn=${i##*_};tn=${tn%%.csv}
	echo loading $i
	cmd="\copy $db.$tn FROM "
	cmd=$cmd"'"
	cmd=$cmd"$i"
	cmd=$cmd"'"
	cmd=$cmd'( FORMAT CSV, DELIMITER(","));'
	echo "$cmd" >> tmp/lt.sql
done
echo pg -f tmp/lt.sql
