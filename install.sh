#!/bin/bash

RED='\033[1;91m'
PURPLE='\033[1;95m'
CYAN='\033[1;96m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
WHITE='\033[1;97m'
NC='\033[0m'

progress_step() {
    local msg="$1"

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

        printf "\r${COLOR}[%s%s] %3d%% ${msg}${NC}" \
            "$bar" "$spaces" "$i"

        sleep 0.01
    done

    echo
}

loading_screen() {
    clear

    echo -e "${WHITE}"
    echo "╔════════════════════════════╗"
    echo "║       GT INSTALLER         ║"
    echo "╚════════════════════════════╝"
    echo -e "${NC}"

    progress_step "Booting GT Installer"

    echo
    echo -e "${GREEN}✓ System Ready${NC}"

    sleep 1
}

banner() {
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
    echo -e "${NC}"
}

crispy_adventure() {

    clear

    echo -e "${CYAN}Starting Crispy Adventure Setup...${NC}"
    echo

    progress_step "Cloning Repository"
    echo -e "${GREEN}✓ Repository Ready${NC}"

    progress_step "Updating Packages"
    echo -e "${GREEN}✓ Packages Updated${NC}"

    progress_step "Installing Dependencies"
    echo -e "${GREEN}✓ Dependencies Installed${NC}"

    progress_step "Preparing Application"
    echo -e "${GREEN}✓ Application Prepared${NC}"

    progress_step "Launching"
    echo -e "${GREEN}✓ Launch Complete${NC}"

    echo
    read -p "Press Enter To Return..."
}

panel_menu() {

while true; do

    clear

    echo -e "${GREEN}"
    echo "╔════════════════════════════╗"
    echo "║          PANELS            ║"
    echo "╚════════════════════════════╝"
    echo -e "${NC}"

    echo -e "${GREEN}[1]${NC} Crispy Adventure"
    echo -e "${YELLOW}[2]${NC} Coming Soon"
    echo -e "${YELLOW}[3]${NC} Coming Soon"
    echo
    echo -e "${RED}[0]${NC} Back"
    echo

    read -p "Select Option: " opt

    case $opt in

        1)
            crispy_adventure
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

done
}

main_menu() {

while true; do

    banner

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
            exit 0
            ;;

        *)
            echo "Invalid Option"
            sleep 1
            ;;

    esac

done
}

loading_screen
main_menu
