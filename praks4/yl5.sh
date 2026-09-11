#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Kaivita see skript koos arvuga mille paarsus soovid kontrollida. Näiteks: ./paarsus 3"
else
    
    if [ $(($1 % 2)) -eq 0 ]; then
        echo "Antud arv on paaris"
    else
        echo "Antud arv on paaritu"
    fi
fi
