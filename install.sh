#!/bin/bash

# Colors
RED='\033[1;91m'
PURPLE='\033[1;95m'
CYAN='\033[1;96m'
GREEN='\033[1;92m'
WHITE='\033[1;97m'
NC='\033[0m'

clear

echo
echo -e "${WHITE}╔════════════════════════════╗"
echo -e "║       GT INSTALLER         ║"
echo -e "╚════════════════════════════╝${NC}"
echo

echo -e "${WHITE}Loading...${NC}"
echo

for i in {0..100}; do

    if [ $i -le 25 ]; then
        COLOR=$RED
    elif [ $i -le 50 ]; then
        COLOR=$PURPLE
    elif [ $i -le 75 ]; then
        COLOR=$CYAN
    else
        COLOR=$GREEN
    fi

    filled=$((i / 5))
    empty=$((20 - filled))

    bar=$(printf "%0.s█" $(seq 1 $filled))
    spaces=$(printf "%0.s░" $(seq 1 $empty))

    printf "\r${COLOR}[%s%s] %3d%%${NC}" "$bar" "$spaces" "$i"

    sleep 0.03
done

echo
echo
echo -e "${GREEN}✓ Loading Complete!${NC}"

sleep 1

clear

echo -e "${CYAN}"
cat << "EOF"

 ██████╗ ████████╗
██╔════╝ ╚══██╔══╝
██║  ███╗   ██║
██║   ██║   ██║
╚██████╔╝   ██║
 ╚═════╝    ╚═╝

      GT INSTALLER

EOF

echo -e "${GREEN}System Ready.${NC}"
