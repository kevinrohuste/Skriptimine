#!/bin/bash
# Skript arvutab täielikult täidetud busside arvu ja mahajäänud reisijate arvu

echo -n "Sisesta reisijate arv: "
read reisijad
echo -n "Sisesta kohtade arv bussis: "
read kohad

täis_bussid=$(expr $reisijad / $kohad)
maha_jäänud=$(expr $reisijad % $kohad)

echo "Täielikult täidetud busse: $täis_bussid"
echo "Maha jäänud inimesi: $maha_jäänud"
