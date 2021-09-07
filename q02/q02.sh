#!/bin/bash


### variables
year=$1
model=$2
type=$3

### validations
if [ $# -ne 3 ]; then
	echo "need to enter 3 parameters (year,model,type)"
	exit
fi

if [ ! -e env_mysql ]; then
	ln -s ../q01/env_mysql env_mysql
fi

source env_mysql

if [ ! -e q02.sql ]; then
	touch q02.sql
else
	rm q02.sql
fi

### if blocks
if [ $type == "all" ]; then
	cat > q02.sql <<SQL
	use sales;
	SELECT COUNT(*), SUM(dealer_cost), SUM(price_sold), SUM(price_list) FROM sales_$year WHERE model_name='$model';
SQL
elif [ $type == "new" ] || [ $type == "used" ]; then
	cat > q02.sql <<SQL
	use sales;
	SELECT COUNT(*), SUM(dealer_cost), SUM(price_sold), SUM(price_list) FROM sales_$year WHERE model_name='$model' AND sales_type='$type';
SQL
else
	echo "type needs to be new, used or all"
	exit
fi

salesdata=$(mysql -u $MYSQLU -p$MYSQLP < q02.sql 2>/dev/null | grep -iv count | grep -iv sum)

 
#
#for i in {0..4}
#do
#	if [ "${salesdata[$i]}" == "NULL" ]; then
#		salesdata[$i]=0
#	fi
#	echo "$year ${salesdata[@]}"
#done
#
# 

echo $year ${salesdata[@]}
