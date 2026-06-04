#!/bin/bash

# ==========================================
# GT INSTALLER - Professional Bash UI
# ==========================================

# ----------------------------------------------------------------------------
# CONFIG & CONSTANTS
# ----------------------------------------------------------------------------

CLR_RESET="\033[0m"
CLR_RED="\033[0;31m"
CLR_GREEN="\033[0;32m"
CLR_YELLOW="\033[1;33m"
CLR_CYAN="\033[0;36m"
CLR_PURPLE="\033[0;35m"
CLR_WHITE="\033[1;37m"

BOX_H="█"
BOX_EMPTY=" "

# ----------------------------------------------------------------------------
# UTILITY FUNCTIONS
# ----------------------------------------------------------------------------

clear_screen() {
    echo -ne "\033[H"
    clear
}

press_enter() {
    echo -ne "\n${CLR_CYAN}Press [Enter] to continue...${CLR_RESET}"
    read -r
}

print_center() {
    local text="$1"
    local width=$(tput cols 2>/dev/null || echo 80)
    local padding=$(( (width - ${#text}) / 2 ))
    printf "%${padding}s%s%${padding}s\n" '' "$text" ''
}

draw_box() {
    local title="$1"
    local col="$2"
    if [ -z "$col" ]; then col="$CLR_CYAN"; fi
    echo -e "${col}╔════════════════════════════════════╗${CLR_RESET}"
    printf "${col}║${CLR_RESET}%*s${col}%*s${CLR_RESET}\n" $(((47-${#title})/2)) '' "$title" $(((47-${#title})/2)) ''
    echo -e "${col}╚════════════════════════════════════╝${CLR_RESET}"
}

# ----------------------------------------------------------------------------
# SINGLE MULTI-COLOR PROGRESS BAR
# ----------------------------------------------------------------------------

draw_progress() {
    local percent=0
    while [ $percent -le 100 ]; do
        local color="$CLR_RESET"
        if [ $percent -le 25 ]; then
            color="$CLR_RED"
        elif [ $percent -le 50 ]; then
            color="$CLR_PURPLE"
        elif [ $percent -le 75 ]; then
            color="$CLR_CYAN"
        else
            color="$CLR_GREEN"
        fi

        printf "\r${color}["
        local total=20
        local filled=$((percent * total / 100))
        local empty=$((total - filled))
        
        for ((i=0; i<filled; i++)); do printf "%s" "$BOX_H"; done
        for ((i=0; i<empty; i++)); do printf "%s" "$BOX_EMPTY"; done
        
        printf "] %d%%%s" "$percent" "$CLR_RESET"
        
        sleep 0.03
        ((percent++))
    done
}

# ----------------------------------------------------------------------------
# BOOT SCREEN
# ----------------------------------------------------------------------------

boot_screen() {
    clear_screen
    echo -e "${CLR_CYAN}"
    cat << 'EOF'
   ╔════════════════════════════╗
   ║       GT INSTALLER         ║
   ╚════════════════════════════╝
EOF
    echo -e "${CLR_RESET}"
    echo ""
    print_center "Initializing..."
    echo ""
    echo -ne "  "
    draw_progress
    echo ""
    echo ""
    print_center "${CLR_GREEN}✓ Loading Complete!${CLR_RESET}"
    sleep 1
}

# ----------------------------------------------------------------------------
# MAIN MENU
# ----------------------------------------------------------------------------

main_menu() {
    while true; do
        clear_screen
        draw_box "GT INSTALLER"
        
        echo -e "${CLR_CYAN}"
        cat << 'EOF'
██████╗ ████████╗
██╔════╝ ╚══██╔══╝
██║  ███╗   ██║
██║   ██║   ██║
╚██████╔╝   ██║
╚═════╝    ╚═╝
EOF
        echo -e "${CLR_RESET}"
        echo ""
        echo -e " [1] ${CLR_GREEN}Panel${CLR_RESET}"
        echo -e " [0] ${CLR_RED}Exit${CLR_RESET}"
        echo ""
        
        printf "Select: "
        read -r opt
        
        case $opt in
            1) panel_menu ;;
            0) clear_screen; exit 0 ;;
            *) ;;
        esac
    done
}

# ----------------------------------------------------------------------------
# PANEL MENU
# ----------------------------------------------------------------------------

panel_menu() {
    while true; do
        clear_screen
        draw_box "PANELS"
        
        echo ""
        echo -e " [1] ${CLR_GREEN}Crispy Adventure${CLR_RESET}"
        echo -e " [2] ${CLR_YELLOW}Coming Soon${CLR_RESET}"
        echo -e " [3] ${CLR_YELLOW}Coming Soon${CLR_RESET}"
        echo ""
        echo -e " [0] ${CLR_RED}Back${CLR_RESET}"
        echo ""
        
        printf "Select: "
        read -r opt
        
        case $opt in
            1) install_crispy ;;
            2) install_coming_soon ;;
            3) install_coming_soon ;;
            0) return ;;
            *) ;;
        esac
    done
}

# ----------------------------------------------------------------------------
# INSTALLATION PROCESS
# ----------------------------------------------------------------------------

run_progress() {
    clear_screen
    draw_box "INSTALLING"
    echo ""
    echo -ne "  "
    draw_progress
    echo ""
    echo ""
    print_center "${CLR_GREEN}✓ Complete!${CLR_RESET}"
    sleep 1
}

# ----------------------------------------------------------------------------
# INSTALL FUNCTIONS
# ----------------------------------------------------------------------------

install_crispy() {
    run_progress
    
    if [ "$EUID" -ne 0 ]; then 
        echo ""
        echo -e "${CLR_RED}Error: Root required. Run with sudo.${CLR_RESET}"
        press_enter
        return
    fi
    
    echo ""
    echo "Installing Crispy Adventure..."
    echo ""
    
    git clone https://github.com/pratikgamer11/crispy-adventure
    cd crispy-adventure || { echo "Error"; press_enter; return; }
    
    apt update -y
    apt install nodejs -y
    npm install express
    npm install fer
    
    echo ""
    echo -e "${CLR_GREEN}✓ Running Server...${CLR_RESET}"
    node .
}

install_coming_soon() {
    run_progress
    echo ""
    echo -e "${CLR_YELLOW}Coming Soon!${CLR_RESET}"
    press_enter
}

# ----------------------------------------------------------------------------
# START
# ----------------------------------------------------------------------------

boot_screen
main_menu
