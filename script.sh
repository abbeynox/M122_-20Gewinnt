#!/bin/bash

#
# convertData.sh
# ---------------
# 03.03.2023
#
#

# ASCII Art Stuff
# ANSI codes
# source https://www.shellhacks.com/bash-colors/
END="\033[0m"
BOLD="\033[1m"
GREEN="\033[32m"
RED="\033[31m"
CYAN="\033[36m"
PURPLE="\033[35m"
YELLOW="\033[1;33m"

A_WELCOME='
  ____   ___                      _             _
 |___ \ / _ \  __ _  _____      _(_)_ __  _ __ | |_
   __) | | | |/ _` |/ _ \ \ /\ / / | '\''_ \| '\''_ \| __|
  / __/| |_| | (_| |  __/\ V  V /| | | | | | | | |_
 |_____|\___/ \__, |\___| \_/\_/ |_|_| |_|_| |_|\__|
              |___/
\e[35mWer die 20 erreicht gewinnt!\e[0m
'

# Funktionen
# current_number() {
#   local PLAYER=$1
#   if [ -z "$PLAYER" ]; then
#     echo "Die Variable ist nicht gesetzt."
#   else
#     echo "Die Variable ist gesetzt: $VARIABLE"
#   fi
#   echo ""
#   echo -e "${CYAN}${PLAYER}${END} hat ${GREEN}${NUMBER}${END} hochgezählt"
#   echo -e "Aktuelle Zahl: ${BOLD}${GREEN}${CURRENT_NUMBER}${END}"
#   echo ""
# }
play_singleplayer() {
  echo -e "Du spielst im Singleplayer Modus"
  currentVal=0
  # Standard Gamelogik
  while [ "$currentVal" -lt "19" ]; do
    read -p "Wähle【1/2】》 " userVal
    if [ $userVal = 1 ] || [ $userVal = 2 ]; then
      currentVal=$(($currentVal + $userVal))
      # current_number
      if [ $currentVal = 20 ]; then
        echo -e "${YELLOW}You won 🌟${END}"
        break
      fi
      pcVal=$(((RANDOM % 2) + 1))
      echo -e "🤖 PcVal is: $pcVal"
      currentVal=$(($currentVal + $pcVal))
      if [ $currentVal = 20 ]; then
        echo -e "${RED}You lost ☠️${END}"
        break
      fi
      echo "the currentVal is: $currentVal"
      continue
    fi
    # shellcheck disable=SC2071
    if [ $userVal ] >2; then
      echo "Falsche Eingabe"
    fi
  done
}

play_multiplayer() {
  echo -e "Du spielst im Multiplayer Modus"
  currentVal=0
  # Standard Gamelogik
  while [ "$currentVal" -lt "19" ]; do
    read -p "Spieler1 Wähle【1/2】》 " userFirstVal
    if [ $userFirstVal = 1 ] || [ $userFirstVal = 2 ]; then
      currentVal=$(($currentVal + $userFirstVal))
      # current_number
      if [ $currentVal = 20 ]; then
        echo -e "${YELLOW}Spieler1 won 🌟${END}"
        break
      fi
      read -p "Spieler2 Wähle【1/2】》 " userSecondVal
      if [ $userSecondVal = 1 ] || [ $userSecondVal = 2 ]; then
        currentVal=$(($currentVal + $userSecondVal))
      else
        echo "Falsche Eingabe"
        while [ $userSecondVal ] >2; do
          read -p "Spieler2 Wähle【1/2】》 " userSecondVal
          if [ $userSecondVal = 1 ] || [ $userSecondVal = 2 ]; then
            currentVal=$(($currentVal + $userSecondVal))
            break
          fi
        done
      fi
      if [ $currentVal = 20 ]; then
        echo -e "${RED}Spieler2 won 🌟${END}"
        break
      fi
      echo "the currentVal is: $currentVal"
      continue
    fi
    # shellcheck disable=SC2071
    if [ $userVal ] >2; then
      echo "Falsche Eingabe"
    fi
  done
}

echo -e "$A_WELCOME"
echo -e "Welchen Spielmodus möchtest du spielen?"
echo -e "1. Singleplayer"
echo -e "2. Multiplayer"
echo -e "3. Exit"
read -p "Wähle【1/2/3】》 " spielmodus
if [ $spielmodus = 1 ]; then
  play_singleplayer
elif [ $spielmodus = 2 ]; then
  play_multiplayer
elif [ $spielmodus = 3 ]; then
  echo -e "Exit"
  exit 0
else
  echo -e "Falsche Eingabe"
  exit 1
fi
