#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Kasutamine: $0 A B C"
    exit 1
fi

A="$1"
B="$2"
C="$3"

if [ $(echo "($A) == 0" | bc -l) -eq 1 ]; then
    echo "Viga: Kordaja A ei tohi olla 0 (tegemist pole ruutvõrrandiga)."
    exit 1
fi

D=$(echo "($B)^2 - 4 * ($A) * ($C)" | bc -l)

IS_NEGATIVE=$(echo "$D < 0" | bc -l)
IS_ZERO=$(echo "$D == 0" | bc -l)

if [ "$IS_NEGATIVE" -eq 1 ]; then
    echo "Reaalarvulisi lahendeid ei ole."
elif [ "$IS_ZERO" -eq 1 ]; then
    X=$(echo "scale=10; (0 - ($B)) / (2 * ($A))" | bc -l)
    printf "Võrrandil on üks lahend:\nx = %.5f\n" "$X"
else
    X1=$(echo "scale=10; (0 - ($B) + sqrt($D)) / (2 * ($A))" | bc -l)
    X2=$(echo "scale=10; (0 - ($B) - sqrt($D)) / (2 * ($A))" | bc -l)
    printf "Võrrandil on kaks lahendit:\nx1 = %.5f\nx2 = %.5f\n" "$X1" "$X2"
fi
