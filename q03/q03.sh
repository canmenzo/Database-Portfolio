#!/bin/bash

### variables
model=$1
rep="report.tmp"
match=0

### validations and soft links
if [ $# -ne 1 ]; then
	echo "Enter model name"
fi

if [ ! -e model.sh ]; then
	ln -s ~/class/a07/q02/q02.sh model.sh
fi

if [ ! -e env_mysql ]; then
	ln -s ~/class/a07/q01/env_mysql env_mysql
fi
source env_mysql

if [ -e $rep ]; then
	rm $rep
	touch $rep
fi


### sql code
cat > q03.sql <<SQL
	use sales;
	select distinct(model_name) from sales_2016;
SQL


### model names into a models array
models=($(mysql -u $MYSQLU -p$MYSQLP < q03.sql 2> /dev/null | grep -iv model_name))


### model name validation
for m in "${models[@]}"
do
	if [ "$m" == "$model" ]; then
		match=1
	fi
done

if [ "$match" == "0" ]; then
	echo "Invalid model name: $model"
	if [ -e $rep ]; then
		rm $rep
	fi
	exit
fi

echo "Sales, Profit and Discount Report: $model" >> $rep
echo " " >> $rep

for type in all new used
do
	echo "Type=$type" >> $rep
	echo "Number 	Dealer	 Sales	 List 			" >> $rep
	echo "Year 	Sold	 Cost 	 Value	  Price		" >> $rep
	echo "=====	=====	 =====	 =====	  =====		" >> $rep

	for year in {2010..2016}
	do
		salesdata=$(./model.sh $year $model $type)
		number=${salesdata[1]}
		dcost=${salesdata[2]}
		psold=${salesdata[3]}
		plist=${salesdata[4]}
		printf "%4s %9s %13s %13s %13s \n" ${salesdata[@]} >> $rep
	done
	echo " ================================================ " >> $rep
	echo " " >> $rep
done
