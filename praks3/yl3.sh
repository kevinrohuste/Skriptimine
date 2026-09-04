#!/bin/bash
# Skript arvutab täielikult täidetud busside arvu ja mahajäänud reisijate arvu

echo -n "Sisesta reisijate arv: "
read reisijad
echo -n "Sisesta kohtade arv bussis: "
read kohad

tais_bussid=$(expr $reisijad / $kohad)
maha_jaanud=$(expr $reisijad % $kohad)

echo "Täielikult täidetud busse: $tais_bussid"
echo "Maha jäänud inimesi: $maha_jaanud"
