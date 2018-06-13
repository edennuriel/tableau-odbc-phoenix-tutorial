#!/usr/bin/env bash
addpath() {
if [[ ! $(echo $PATH | grep $1) ]]
then
	echo "adding $1 (rc = $?)"
	echo export PATH="$1:$PATH"
	export PATH="$1:$PATH"
fi

}

#export JAVA_HOME="/usr/jdk64/jdk1.8.0_112"
[[ -z $JAVA_HOME ]] || export JAVA_HOME=$(dirname $(dirname $(alternatives --display java | awk '/curr/ {print $NF}' )))
[[ $(command -v java) ]] || addpath $JAVA_HOME/bin
addpath /usr/hdp/current/phoenix-client/bin
for i in $(ls data | grep .csv) ; do tn=${i%%.csv}; tn=${tn##*_};tn=CORP.${tn^^};  psql.py -t $tn sql/${i/.csv/.sql} data/$i ; done
