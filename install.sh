#!/bin/bash

# ===== COLORS =====
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
BLUE='\033[1;94m'
PURPLE='\033[1;95m'
CYAN='\033[1;96m'
WHITE='\033[1;97m'
NC='\033[0m'

# ===== SPINNER =====
spinner() {
    local pid=$1
    local delay=0.08
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'

    while ps -p $pid >/dev/null 2>&1; do
        for i in $(seq 0 9); do
            printf "\r${CYAN}[%s] Loading...${NC}" "${spin:$i:1}"
            sleep $delay
        done
    done

    printf "\r${GREEN}[✓] Complete!          ${NC}\n"
}

# ===== LOADING BAR =====
loading() {

    clear

    echo
    echo -e "${PURPLE}╔════════════════════════════════════════════╗"
    echo -e "║             GT INSTALLER BOOT             ║"
    echo -e "╚════════════════════════════════════════════╝${NC}"
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

        filled=$((i / 2))
        empty=$((50 - filled))

        bar=$(printf "%0.s█" $(seq 1 $filled))
        space=$(printf "%0.s░" $(seq 1 $empty))

        printf "\r${COLOR}[%s%s] %3d%%${NC}" \
        "$bar" "$space" "$i"

        sleep 0.015
    done

    echo
    echo
    echo -e "${GREEN}✓ GT Installer Loaded Successfully${NC}"

    sleep 1.5
}

# ===== LOGO =====
logo() {

echo -e "${PURPLE}"
cat << "EOF"

 ██████╗ ████████╗
██╔════╝ ╚══██╔══╝
██║  ███╗   ██║
██║   ██║   ██║
╚██████╔╝   ██║
 ╚═════╝    ╚═╝

EOF

echo -e "${CYAN}              GT INSTALLER v1.0${NC}"
echo
}

# ===== HEADER =====
header() {

clear

echo -e "${CYAN}╔════════════════════════════════════════════╗${NC}"
logo
echo -e "${CYAN}╚════════════════════════════════════════════╝${NC}"

echo -e "${YELLOW}┌──────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│ Status  : ${GREEN}ONLINE${YELLOW}                         │${NC}"
echo -e "${YELLOW}│ Theme   : ${PURPLE}RGB PRO${YELLOW}                        │${NC}"
echo -e "${YELLOW}│ Version : ${CYAN}1.0.0${YELLOW}                          │${NC}"
echo -e "${YELLOW}└──────────────────────────────────────────┘${NC}"

echo
}

# ===== PANEL MENU =====
panel_menu() {

while true; do

header

echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                 PANELS                     ║${NC}"
echo -e "${GREEN}╠════════════════════════════════════════════╣${NC}"
echo -e "${WHITE}║ ${GREEN}[1]${WHITE} ► Crispy Adventure                ║${NC}"
echo -e "${WHITE}║ ${YELLOW}[2]${WHITE} ► Coming Soon                     ║${NC}"
echo -e "${WHITE}║ ${YELLOW}[3]${WHITE} ► Coming Soon                     ║${NC}"
echo -e "${WHITE}║                                            ║${NC}"
echo -e "${WHITE}║ ${RED}[0]${WHITE} ► Back                            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"

echo
read -p "Select Option > " choice

case $choice in

1)
    clear

    echo -e "${CYAN}Launching Crispy Adventure...${NC}"

    (
        sleep 3
    ) &

    spinner $!

    echo
    echo -e "${GREEN}✓ Placeholder Installer Selected${NC}"
    echo
    read -p "Press Enter To Continue..."
    ;;

2)
    echo
    echo -e "${YELLOW}Coming Soon...${NC}"
    sleep 1.5
    ;;

3)
    echo
    echo -e "${YELLOW}Coming Soon...${NC}"
    sleep 1.5
    ;;

0)
    return
    ;;

*)
    echo
    echo -e "${RED}Invalid Option${NC}"
    sleep 1
    ;;

esac

done
}

# ===== MAIN MENU =====
main_menu() {

while true; do

header

echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                MAIN MENU                   ║${NC}"
echo -e "${GREEN}╠════════════════════════════════════════════╣${NC}"
echo -e "${WHITE}║ ${GREEN}[1]${WHITE} ► PANELS                          ║${NC}"
echo -e "${WHITE}║                                            ║${NC}"
echo -e "${WHITE}║ ${RED}[0]${WHITE} ► EXIT                           ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"

echo
read -p "Select Option > " choice

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
    echo
    echo -e "${RED}Invalid Option${NC}"
    sleep 1
    ;;

esac

done
}

loading
main_menu
