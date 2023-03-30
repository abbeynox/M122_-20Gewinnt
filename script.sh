#!/bin/bash

#
# convertData.sh
# ---------------
# 1.12.2010 P.Rutschmann
#
# Dieses Script fordert den Benutzer solange zur Eingabe
# einer Zahl auf, bis er die Richtige erraten hat.
#
# Dieses Script filter aus einer speziellen Liste die 
# deutschsprachigen Hauptarbeitsbezeichnungen heraus
#
# a) Zuerst werden die deutschsprachigen Text gefiltert. 
#   : im ersten Feld muss eine 2 stehen
#   : im zweiten Feld kann eine beliebige Zahl aber nicht
#     eine 26 stehen 
#
# b) Dann werden die Felder 1 und 2 weggefiltert.
#   : Diese Felder werden nicht mehr benoetigt
#
# c) Nun werden die Hauptarbeitsbezeichnungen gefiltert.
#   : Deren Zeilen beginnen mit einer Zahl mit 6 Ziffern.
#
currentVal=0

while [ "$currentVal" -lt "19" ];
do
    read -p "Bitte geben Sie eine Zahl ein: " userVal
        if [ $userVal = 1 ] || [ $userVal = 2 ]; 
    then
        # pc randomizer
        currentVal=$(($currentVal + $userVal))
        if [ $currentVal = 20 ];
        then
            echo "You won!"
            break
        fi
        pcVal=$(( ( RANDOM % 2 )  + 1 ))
        echo -e "\x1b[38;5;13m🤖 PcVal is: $pcVal"
        currentVal=$(($currentVal + $pcVal))
        if [ $currentVal = 20 ];
        then
            echo "You lost!"
            break
        fi
        echo "the currentVal is: $currentVal"
        continue
    fi
    if [ $userVal > 2 ];
    then 
        echo "Falsche Eingabe"
    fi
done

