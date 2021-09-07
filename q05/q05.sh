#!/bin/bash


### validation for soft link
if [ ! -e env_mysql ]; then
	ln -s ~/class/a07/q01/env_mysql env_mysql
fi
source env_mysql

### sql
cat > q05.sql << SQL
	use sales;
	select distinct(model_name) from sales_2010;
SQL

### array the models
model_name=($(mysql -u $MYSQLU -p$MYSQLP < q05.sql 2> /dev/null | grep -v model_name))
	for model in "${model_name[@]}"
	do
	(
		cd ~/class/a07/q04
		./q04.sh $model
		if [ -e report.tmp ]; then
			cp report.tmp "../../../reports/$model"".txt"
			rm report.tmp
		fi
	)
	done
	(
		cd ~/reports
		reports=( $(ls *.txt) )
		tar -cf models.tar ${reports[@]}
		mv models.tar ~/archive
	)

