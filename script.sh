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


 current_number() {
  local PLAYER=$1
  local PLAYERCOUNT=$2
  local CURRENT_NUMBER=$3
  local PLAYERCOLOR=$4
  local BAR_LENGTH=$((CURRENT_NUMBER))
  local REMAINDER=$((CURRENT_NUMBER % 5))
  local BAR=""
  for ((i=0; i<BAR_LENGTH; i++)); do
    BAR="${BAR}▓"
  done
  if (( CURRENT_NUMBER == 20 )); then
    BAR="████████████████"
  else
    local SPACES=$((20 - BAR_LENGTH - 1))
    local SPACER=""
    for ((i=0; i<SPACES; i++)); do
      SPACER="${SPACER}-"
    done
    local COLOR="${GREEN} "
    if (( CURRENT_NUMBER >= 9 && CURRENT_NUMBER <= 17 )); then
      COLOR="${YELLOW} "
    elif (( CURRENT_NUMBER >= 18 )); then
      COLOR="${RED} "
    fi
    echo -e "${COLOR}+=+=+=+=+=+=+=+=+=+=+=+=+${END}"
    echo -e "${PLAYERCOLOR}${PLAYER}${END} hat ${GREEN}${PLAYERCOUNT}${END} hochgezählt"
    echo -e "${BOLD}${COLOR}${CURRENT_NUMBER} ${BAR}${SPACER}|${END} 20"
    echo -e "${COLOR}+=+=+=+=+=+=+=+=+=+=+=+=+${END}"
  fi
}



play_multiplayer() {
  printf "\nDu spielst im Multiplayer-Modus\n\n"

  PLAYER1_COLOR="${CYAN}"
  PLAYER2_COLOR="${PURPLE}"

  echo -en "${PLAYER1_COLOR}Spieler 1${END}, wie heisst du? 》"
  read player1
  echo -en "${PLAYER2_COLOR}Spieler 2${END}, wie heisst du? 》"
  read player2

  currentVal=0
  # Standard-Gamelogik
  while [ "$currentVal" -lt "20" ]; do
    while true; do
      echo -en "${PLAYER1_COLOR}${player1}, wähle eine Zahl zwischen 1 und 2 》 ${END}"
      read userFirstVal
      if [ $userFirstVal = 1 ] || [ $userFirstVal = 2 ]; then
        break
      else
        echo -e "${RED}Falsche Eingabe! Bitte wähle eine Zahl zwischen 1 und 2.\n${END}"
      fi
    done
    currentVal=$(($currentVal + $userFirstVal))
    current_number "$player1" "$userFirstVal" "$currentVal" "$PLAYER1_COLOR"
    if [ $currentVal -gt 20 ]; then
      echo -e "${PLAYER1_COLOR}${player1} hat gewonnen! 🌟${END}"
      break
    fi

    while true; do
      echo -en "${PLAYER2_COLOR}${player2}, wähle eine Zahl zwischen 1 und 2 》 ${END}"
      read userSecondVal
      if [ $userSecondVal = 1 ] || [ $userSecondVal = 2 ]; then
        break
      else
        echo -e "${RED}Falsche Eingabe! Bitte wähle eine Zahl zwischen 1 und 2.\n${END}"
      fi
    done
    currentVal=$(($currentVal + $userSecondVal))
    current_number "$player2" "$userSecondVal" "$currentVal" "$PLAYER2_COLOR"
    if [ $currentVal -gt 20 ]; then
      echo -e "${PLAYER2_COLOR}${player2} hat gewonnen! 🌟 ${END}"
      break
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
