#!/bin/bash

file=env_mysql

if [ ! -e $file ]; then
	touch $file
else
	rm $file
	touch $file
fi

echo "export MYSQLU='salesadmin'" >> $file
echo "export MYSQLP='admin123'" >> $file
echo "export REPORTS='~/reports'" >> $file
echo "export ARCHIVE='~/archive'" >> $file

for i in {2..5}
do
	cd ../q0$i
	if [ ! -L $file ]; then
		ln -s ../q01/$file $file
	fi
done
