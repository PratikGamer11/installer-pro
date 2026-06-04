#!/bin/bash

# ==========================================
# GT INSTALLER - Professional Bash UI
# ==========================================

# ----------------------------------------------------------------------------
# CONFIG & CONSTANTS
# ----------------------------------------------------------------------------
# ANSI Color Codes
CLR_RESET="\033[0m"
CLR_RED="\033[0;31m"
CLR_GREEN="\033[0;32m"
CLR_YELLOW="\033[1;33m"
CLR_BLUE="\033[0;34m"
CLR_CYAN="\033[0;36m"
CLR_PURPLE="\033[0;35m"
CLR_WHITE="\033[1;37m"

# Box Characters
BOX_H="█"
BOX_EMPTY=" "

# Application State
APP_NAME="GT Installer"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ----------------------------------------------------------------------------
# UTILITY FUNCTIONS
# ----------------------------------------------------------------------------

# Function to clear screen and move cursor to top
clear_screen() {
    echo -ne "\033[H"
    clear
}

# Wait for user input (Enter key)
press_enter() {
    echo -ne "\n${CLR_CYAN}Press [Enter] to continue...${CLR_RESET}"
    read -r
}

# Print a centered line
print_center() {
    local text="$1"
    local width=$(tput cols)
    local padding=$(( (width - ${#text}) / 2 ))
    printf "%${padding}s%s%${padding}s\n" '' "$text" ''
}

# Draw a header box
draw_header() {
    local title="$1"
    echo -e "${CLR_CYAN}╔════════════════════════════════════╗${CLR_RESET}"
    printf "${CLR_CYAN}║${CLR_RESET}%*s${CLR_CYAN}%*s${CLR_RESET}\n" $(((47-${#title})/2)) '' "$title" $(((47-${#title})/2)) ''
    echo -e "${CLR_CYAN}╚════════════════════════════════════╝${CLR_RESET}"
}

# ----------------------------------------------------------------------------
# BOOT SCREEN ANIMATION
# ----------------------------------------------------------------------------
boot_sequence() {
    clear_screen
    
    # 1. Title Screen
    echo -e "${CLR_CYAN}"
    cat << 'EOF'
   ╔════════════════════════════╗
   ║       GT INSTALLER         ║
   ╚════════════════════════════╝
EOF
    echo -e "${CLR_RESET}"
    
    echo ""
    print_center "Initializing System..."
    echo ""

    # 2. Animated Progress Bar
    local total=40
    local percent=0
    
    while [ $percent -le 100 ]; do
        # Calculate color based on percentage
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

        # Draw Bar
        printf "\r${color}["
        local filled=$((percent * total / 100))
        local empty=$((total - filled))
        
        for ((i=0; i<filled; i++)); do printf "%s" "$BOX_H"; done
        for ((i=0; i<empty; i++)); do printf "%s" "$BOX_EMPTY"; done
        
        printf "] %d%%%s" "$percent" "$CLR_RESET"
        
        sleep 0.05 # Animation speed
        ((percent++))
    done

    echo ""
    echo ""
    print_center "${CLR_GREEN}✓ Loading Complete!${CLR_RESET}"
    sleep 1
}

# ----------------------------------------------------------------------------
# INSTALLATION EXECUTION LOGIC
# ----------------------------------------------------------------------------

run_installer_stages() {
    clear_screen
    draw_header "INSTALLATION PROCESS"

    # Stage 1
    echo -e "${CLR_WHITE}[${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}] 100% Preparing Installer${CLR_RESET}"
    echo -e "${CLR_GREEN}✓ Complete${CLR_RESET}"
    sleep 1
    echo ""

    # Stage 2
    echo -e "${CLR_WHITE}[${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}] 100% Loading Configuration${CLR_RESET}"
    echo -e "${CLR_GREEN}✓ Complete${CLR_RESET}"
    sleep 1
    echo ""

    # Stage 3
    echo -e "${CLR_WHITE}[${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}] 100% Finalizing Setup${CLR_RESET}"
    echo -e "${CLR_GREEN}✓ Complete${CLR_RESET}"
    sleep 1
    echo ""
    echo ""
}

# Logic for [1] Crispy Adventure
install_crispy() {
    run_installer_stages

    echo -e "${CLR_CYAN}Starting Crispy Adventure Setup...${CLR_RESET}"
    echo ""

    # Check for root (apt commands need root)
    if [ "$EUID" -ne 0 ]; then 
        echo -e "${CLR_RED}Error: This installation requires root privileges.${CLR_RESET}"
        echo -e "${CLR_YELLOW}Please run: sudo bash install.sh${CLR_RESET}"
        press_enter
        return
    fi

    echo "[1] Cloning repository..."
    if ! git clone https://github.com/pratikgamer11/crispy-adventure; then
        echo -e "${CLR_RED}Error: Git clone failed. Check internet connection.${CLR_RESET}"
        press_enter
        return
    fi

    echo "[2] Entering directory..."
    cd crispy-adventure || { echo "Error entering directory"; press_enter; return; }

    echo "[3] Updating apt..."
    if ! apt update -y; then
        echo "Warning: apt update failed. Continuing..."
    fi

    echo "[4] Installing Node.js..."
    if ! apt install nodejs -y; then
        echo "Warning: Node.js install failed. Checking if exists..."
    fi

    echo "[5] Installing dependencies (express, fer)..."
    npm install express
    npm install fer # Note: 'fer' is not a standard package, script runs exactly as requested

    echo "[6] Starting server..."
    echo ""
    echo -e "${CLR_GREEN}Crispy Adventure is running!${CLR_RESET}"
    echo -e "${CLR_YELLOW}Use Ctrl+C to stop the server and return to menu.${CLR_RESET}"
    
    node .
}

# Logic for Placeholders
install_placeholder() {
    run_installer_stages
    echo -e "${CLR_YELLOW}This service is currently under development.${CLR_RESET}"
    press_enter
}

# ----------------------------------------------------------------------------
# MENUS
# ----------------------------------------------------------------------------

# Panel Sub-Menu
panel_menu() {
    while true; do
        clear_screen
        draw_header "PANELS"
        echo ""
        echo -e " [1] ${CLR_GREEN}Crispy Adventure${CLR_RESET}"
        echo -e " [2] ${CLR_YELLOW}Coming Soon${CLR_RESET}"
        echo -e " [3] ${CLR_YELLOW}Coming Soon${CLR_RESET}"
        echo ""
        echo -e " [0] ${CLR_RED}Back${CLR_RESET}"
        echo ""
