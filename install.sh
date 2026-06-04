#!/bin/bash

# ═══════════════════════════════════════════════════════════════
# GT INSTALLER - Professional Terminal Application
# Version: 2.0.0
# Author: PratikGamer11
# Repository: https://github.com/PratikGamer11/installer-pro
# ═══════════════════════════════════════════════════════════════

# ----------------------------------------------------------------------------
# COLOR DEFINITIONS
# ----------------------------------------------------------------------------
CLR_RESET='\033[0m'
CLR_RED='\033[0;31m'
CLR_GREEN='\033[0;32m'
CLR_YELLOW='\033[1;33m'
CLR_BLUE='\033[0;34m'
CLR_PURPLE='\033[0;35m'
CLR_CYAN='\033[0;36m'
CLR_WHITE='\033[1;37m'
CLR_BOLD='\033[1m'

# ----------------------------------------------------------------------------
# UTILITY FUNCTIONS
# ----------------------------------------------------------------------------

clear_screen() {
    clear 2>/dev/null || printf "\033c"
}

# Print centered text
print_center() {
    local text="$1"
    local color="${2:-$CLR_WHITE}"
    local cols
    cols=$(tput cols 2>/dev/null || echo 80)
    local text_len=${#text}
    # Remove color codes for length calculation
    local plain_text=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
    local plain_len=${#plain_text}
    local padding=$(( (cols - plain_len) / 2 ))
    [[ $padding -lt 0 ]] && padding=0
    printf "%${padding}s" ""
    echo -e "${color}${text}${CLR_RESET}"
}

# Draw centered box
draw_box() {
    local title="$1"
    local color="${2:-$CLR_CYAN}"
    local box_width=42
    local cols
    cols=$(tput cols 2>/dev/null || echo 80)
    local padding=$(( (cols - box_width) / 2 ))
    [[ $padding -lt 0 ]] && padding=0
    
    echo ""
    printf "%${padding}s" ""
    echo -e "${color}╔══════════════════════════════════════════╗${CLR_RESET}"
    printf "%${padding}s" ""
    printf "${color}║${CLR_RESET}"
    local title_padding=$(( (40 - ${#title}) / 2 ))
    printf "%${title_padding}s" ""
    echo -ne "${CLR_BOLD}${CLR_WHITE}${title}${CLR_RESET}"
    printf "%$(( 40 - ${#title} - title_padding ))s" ""
    echo -e "${color}║${CLR_RESET}"
    printf "%${padding}s" ""
    echo -e "${color}╚══════════════════════════════════════════╝${CLR_RESET}"
    echo ""
}

# Draw horizontal line
draw_line() {
    local color="${1:-$CLR_CYAN}"
    local cols
    cols=$(tput cols 2>/dev/null || echo 80)
    echo -ne "${color}"
    printf '%*s\n' "$cols" '' | tr ' ' '─'
    echo -ne "${CLR_RESET}"
}

# Wait for Enter key
press_enter() {
    echo ""
    echo -ne "${CLR_CYAN}Press [Enter] to continue...${CLR_RESET}"
    read -r
}

# Check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo ""
        print_center "⚠️  Root privileges required!" "$CLR_YELLOW"
        echo ""
        print_center "Please run with: sudo bash install.sh" "$CLR_CYAN"
        echo ""
        print_center "Or login as root user" "$CLR_CYAN"
        echo ""
        press_enter
        return 1
    fi
    return 0
}

# ----------------------------------------------------------------------------
# MULTI-COLOR PROGRESS BAR (0-25% RED, 26-50% PURPLE, 51-75% CYAN, 76-100% GREEN)
# ----------------------------------------------------------------------------

draw_progress_bar() {
    local percent=0
    local bar_length=34
    local delay=0.02
    
    echo ""
    
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
        
        local filled=$(( percent * bar_length / 100 ))
        local empty=$(( bar_length - filled ))
        
        printf "\r  ${color}["
        for ((i=0; i<filled; i++)); do printf "█"; done
        for ((i=0; i<empty; i++)); do printf " "; done
        printf "] %3d%%${CLR_RESET}" "$percent"
        
        sleep "$delay"
        ((percent++))
    done
    
    echo ""
    echo ""
}

# ----------------------------------------------------------------------------
# STAGE PROGRESS DISPLAY
# ----------------------------------------------------------------------------

show_stage_progress() {
    local message="$1"
    local bar_length=34
    local delay=0.03
    
    echo -ne "\r  ${CLR_GREEN}["
    for ((i=0; i<bar_length; i++)); do
        echo -ne "█"
        sleep "$delay"
    done
    echo -ne "] 100% ${message}${CLR_RESET}"
    sleep 0.3
    echo ""
    echo -e "  ${CLR_GREEN}✓ Complete${CLR_RESET}"
    sleep 0.4
}

# ----------------------------------------------------------------------------
# BOOT SCREEN
# ----------------------------------------------------------------------------

boot_screen() {
    clear_screen
    
    # Title Box
    echo ""
    draw_box "GT INSTALLER" "$CLR_CYAN"
    
    echo ""
    print_center "Initializing System..." "$CLR_YELLOW"
    echo ""
    
    # Animated multi-color progress bar
    draw_progress_bar
    
    echo ""
    print_center "✓ Loading Complete!" "$CLR_GREEN"
    echo ""
    
    sleep 1.5
}

# ----------------------------------------------------------------------------
# ASCII LOGO
# ----------------------------------------------------------------------------

display_logo() {
    echo ""
    echo -e "${CLR_GREEN}"
    echo "  ██████╗ ████████╗"
    echo "  ██╔════╝ ╚══██╔══╝"
    echo "  ██║  ███╗   ██║"
    echo "  ██║   ██║   ██║"
    echo "  ╚██████╔╝   ██║"
    echo "   ╚═════╝    ╚═╝"
    echo -e "${CLR_RESET}"
    echo ""
    print_center "G T   I N S T A L L E R" "$CLR_CYAN"
    echo ""
}

# ----------------------------------------------------------------------------
# MAIN MENU
# ----------------------------------------------------------------------------

main_menu() {
    while true; do
        clear_screen
        display_logo
        draw_line "$CLR_CYAN"
        
        echo ""
        echo -e "  ${CLR_GREEN}[1]${CLR_RESET}  ${CLR_BOLD}Panel${CLR_RESET}        ${CLR_CYAN}📦  Browse Installers${CLR_RESET}"
        echo ""
        echo -e "  ${CLR_RED}[0]${CLR_RESET}  ${CLR_BOLD}Exit${CLR_RESET}         ${CLR_CYAN}🚪  Close Application${CLR_RESET}"
        echo ""
        draw_line "$CLR_CYAN"
        echo ""
        
        echo -ne "${CLR_CYAN}❯ Select option: ${CLR_RESET}"
        read -r opt
        
        case $opt in
            1)
                panel_menu
                ;;
            0)
                clear_screen
                echo ""
                print_center "╔════════════════════════════════════════╗" "$CLR_GREEN"
                print_center "║   Thank you for using GT Installer!    ║" "$CLR_GREEN"
                print_center "╚════════════════════════════════════════╝" "$CLR_GREEN"
                echo ""
                exit 0
                ;;
            *)
                echo ""
                print_center "⚠️  Invalid option! Please try again." "$CLR_RED"
                sleep 1
                ;;
        esac
    done
}

# ----------------------------------------------------------------------------
# PANEL MENU
# ----------------------------------------------------------------------------

panel_menu() {
    while true; do
        clear_screen
        display_logo
        draw_box "PANELS" "$CLR_CYAN"
        
        echo -e "  ${CLR_GREEN}[1]${CLR_RESET}  Crispy Adventure    ${CLR_CYAN}🚀  Adventure Game Server${CLR_RESET}"
        echo ""
        echo -e "  ${CLR_YELLOW}[2]${CLR_RESET}  Coming Soon         ${CLR_CYAN}🔒  More Soon...${CLR_RESET}"
        echo ""
        echo -e "  ${CLR_YELLOW}[3]${CLR_RESET}  Coming Soon         ${CLR_CYAN}🔒  More Soon...${CLR_RESET}"
        echo ""
        echo -e "  ${CLR_RED}[0]${CLR_RESET}  Back to Main Menu"
        echo ""
        draw_line "$CLR_CYAN"
        echo ""
        
        echo -ne "${CLR_CYAN}❯ Select panel: ${CLR_RESET}"
        read -r opt
        
        case $opt in
            1)
                install_crispy_adventure
                ;;
            2|3)
                clear_screen
                draw_box "COMING SOON" "$CLR_YELLOW"
                echo ""
                print_center "🚧  This installer is under development" "$CLR_YELLOW"
                echo ""
                print_center "Check back soon for updates!" "$CLR_CYAN"
                echo ""
                press_enter
                ;;
            0)
                return
                ;;
            *)
                echo ""
                print_center "⚠️  Invalid option! Please try again." "$CLR_RED"
                sleep 1
                ;;
        esac
    done
}

# ----------------------------------------------------------------------------
# INSTALLER: CRISPY ADVENTURE
# ----------------------------------------------------------------------------

install_crispy_adventure() {
    clear_screen
    draw_box "INSTALLING: CRISPY ADVENTURE" "$CLR_CYAN"
    echo ""
    
    # Check root
    if ! check_root; then
        return
    fi
    
    # Stage 1: Preparing
    show_stage_progress "Preparing Installer"
    
    # Stage 2: Configuration
    show_stage_progress "Loading Configuration"
    
    # Stage 3: Finalizing
    show_stage_progress "Finalizing Setup"
    
    echo ""
    draw_line "$CLR_CYAN"
    echo ""
    print_center "Starting installation..." "$CLR_YELLOW"
    echo ""
    
    # Step 1: Clone repository
    echo -e "  ${CLR_CYAN}[1/5]${CLR_RESET} Cloning repository..."
    if git clone https://github.com/pratikgamer11/crispy-adventure 2>/dev/null; then
        echo -e "  ${CLR_GREEN}✓ Repository cloned successfully${CLR_RESET}"
    else
        echo -e "  ${CLR_YELLOW}⚠ Repository already exists or clone failed${CLR_RESET}"
    fi
    echo ""
    
    # Step 2: Update packages
    echo -e "  ${CLR_CYAN}[2/5]${CLR_RESET} Updating package lists..."
    if apt update -y > /dev/null 2>&1; then
        echo -e "  ${CLR_GREEN}✓ Package lists updated${CLR_RESET}"
    else
        echo -e "  ${CLR_YELLOW}⚠ Update failed (continuing...)${CLR_RESET}"
    fi
    echo ""
    
    # Step 3: Install Node.js
    echo -e "  ${CLR_CYAN}[3/5]${CLR_RESET} Installing Node.js..."
    if apt install nodejs -y > /dev/null 2>&1; then
        echo -e "  ${CLR_GREEN}✓ Node.js installed${CLR_RESET}"
    else
        echo -e "  ${CLR_YELLOW}⚠ Node.js may already be installed${CLR_RESET}"
    fi
    echo ""
    
    # Navigate to directory
    cd crispy-adventure 2>/dev/null || {
        echo -e "  ${CLR_RED}✗ Failed to enter directory${CLR_RESET}"
        press_enter
        return
    }
    
    # Step 4: Install Express
    echo -e "  ${CLR_CYAN}[4/5]${CLR_RESET} Installing Express.js..."
    if npm install express 2>/dev/null; then
        echo -e "  ${CLR_GREEN}✓ Express installed successfully${CLR_RESET}"
    else
        echo -e "  ${CLR_RED}✗ Failed to install Express${CLR_RESET}"
    fi
    echo ""
    
    # Step 5: Install Fer
    echo -e "  ${CLR_CYAN}[5/5]${CLR_RESET} Installing Fer..."
    if npm install fer 2>/dev/null; then
        echo -e "  ${CLR_GREEN}✓ Fer installed successfully${CLR_RESET}"
    else
        echo -e "  ${CLR_RED}✗ Failed to install Fer${CLR_RESET}"
    fi
    
    echo ""
    draw_line "$CLR_GREEN"
    echo ""
    print_center "✅  Installation Complete!" "$CLR_GREEN"
    echo ""
    draw_line "$CLR_GREEN"
    echo ""
    
    # Start application
    print_center "Starting application..." "$CLR_CYAN"
    print_center "Press Ctrl+C to stop the server" "$CLR_YELLOW"
    echo ""
    sleep 2
    
    node . 2>/dev/null || {
        echo ""
        echo -e "  ${CLR_RED}✗ Failed to start application${CLR_RESET}"
        echo -e "  ${CLR_YELLOW}Check if all dependencies are installed correctly${CLR_RESET}"
    }
    
    cd - > /dev/null 2>&1 || true
    
    press_enter
}

# ----------------------------------------------------------------------------
# TRAP CTRL+C
# ----------------------------------------------------------------------------

trap 'echo -e "\n\n${CLR_YELLOW}⚠ Interrupted by user${CLR_RESET}"; exit 1' INT

# ----------------------------------------------------------------------------
# START APPLICATION
# ----------------------------------------------------------------------------

# Show boot screen
boot_screen

# Launch main menu
main_menu
