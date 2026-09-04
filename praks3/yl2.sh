#!/bin/bash
# Skript arvutab expr abil küpsisetordi jaoks vajalike küpsisepakkide arvu

echo -n "Sisesta kandiku pikkus (cm): "
read kandik_pikkus
echo -n "Sisesta kandiku laius (cm): "
read kandik_laius

echo -n "Sisesta küpsise pikkus (cm): "
read kypsis_pikkus
echo -n "Sisesta küpsise laius (cm): "
read kypsis_laius

echo -n "Sisesta kihtide arv: "
read kihid
echo -n "Sisesta küpsiste arv ühes pakis: "
read paki_suurus

pikkusesse=$(expr $kandik_pikkus / $kypsis_pikkus)
laiusesse=$(expr $kandik_laius / $kypsis_laius)
kypsiseid_kihis=$(expr $pikkusesse \* $laiusesse)
kypsiseid_kokku=$(expr $kypsiseid_kihis \* $kihid)

pakkide_arv=$(expr \( $kypsiseid_kokku + $paki_suurus - 1 \) / $paki_suurus)

echo "Tordi jaoks on kokku vaja $kypsiseid_kokku küpsist."
echo "Poest tuleb osta $pakkide_arv pakki küpsiseid."
