#!/bin/bash

# Colors

RED='\033[1;91m'
GREEN='\033[1;92m'
CYAN='\033[1;96m'
PURPLE='\033[1;95m'
WHITE='\033[1;97m'
YELLOW='\033[1;93m'
NC='\033[0m'

loading() {
clear

```
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

    sleep 0.02
done

echo
echo
echo -e "${GREEN}✓ Loading Complete!${NC}"

sleep 1
```

}

panel_menu() {
while true; do
clear

```
echo -e "${GREEN}"
echo "╔════════════════════════════╗"
echo "║          PANELS            ║"
echo "╚════════════════════════════╝"
echo -e "${NC}"

echo -e "${CYAN}[1]${NC} Crispy Adventure"
echo -e "${CYAN}[2]${NC} Coming Soon"
echo -e "${CYAN}[3]${NC} Coming Soon"
echo
echo -e "${RED}[0]${NC} Back"
echo

read -p "Select Option: " panel

case $panel in

    1)
        clear
        echo -e "${GREEN}Launching Crispy Adventure...${NC}"
        echo
        read -p "Press Enter To Continue..."
        ;;

    2)
        echo "Coming Soon..."
        sleep 1
        ;;

    3)
        echo "Coming Soon..."
        sleep 1
        ;;

    0)
        return
        ;;

    *)
        echo "Invalid Option"
        sleep 1
        ;;

esac
```

done
}

main_menu() {
while true; do
clear

```
echo -e "${CYAN}"
```

cat << "EOF"

██████╗ ████████╗
██╔════╝ ╚══██╔══╝
██║  ███╗   ██║
██║   ██║   ██║
╚██████╔╝   ██║
╚═════╝    ╚═╝

```
  GT INSTALLER
```

EOF

```
echo -e "${NC}"

echo -e "${GREEN}[1] Panel${NC}"
echo
echo -e "${RED}[0] Exit${NC}"
echo

read -p "Select Option: " choice

case $choice in

    1)
        panel_menu
        ;;

    0)
        clear
        echo -e "${GREEN}Thanks For Using GT Installer!${NC}"
        exit 0
        ;;

    *)
        echo "Invalid Option"
        sleep 1
        ;;

esac
```

done
}

loading
main_menu
