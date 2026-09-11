#!/bin/bash

echo "Sisesta suvaline  sõna: "
read sona1
echo "Sisesta teine sõna: "
read sona2

taht1=$(echo "$sona1" | rev | cut -c1)
taht2=$(echo "$sona2" | rev | cut -c1)

if [ "$taht1" = "$taht2" ]
then 
	echo "Mõlema Sõna viimane täht on sama"
else
	echo "Sõnade viimased tähed ei ole samad"
fi
