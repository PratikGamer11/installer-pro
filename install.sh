#!/bin/bash

# ═══════════════════════════════════════════════════════════
# GT INSTALLER - Professional Terminal Application
# Version: 1.0.0
# Description: Modular installer for various packages
# ═══════════════════════════════════════════════════════════

# Strict mode for better error handling
set -euo pipefail

# Color definitions
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[1;37m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# Clear screen function
clear_screen() {
    clear 2>/dev/null || printf "\033c"
}

# Print centered text
print_centered() {
    local text="$1"
    local color="${2:-$WHITE}"
    local term_width=$(tput cols 2>/dev/null || echo 80)
    local padding=$(( (term_width - ${#text}) / 2 ))
    [[ $padding -lt 0 ]] && padding=0
    printf "%${padding}s" ""
    echo -e "${color}${text}${NC}"
}

# Print horizontal line
print_line() {
    local char="${1:-═}"
    local color="${2:-$CYAN}"
    local term_width=$(tput cols 2>/dev/null || echo 80)
    echo -ne "${color}"
    printf "%${term_width}s" | tr " " "$char"
    echo -e "${NC}"
}

# Draw a box with title
draw_box() {
    local title="$1"
    local color="${2:-$CYAN}"
    local term_width=$(tput cols 2>/dev/null || echo 80)
    local box_width=42
    local padding=$(( (term_width - box_width) / 2 ))
    [[ $padding -lt 0 ]] && padding=0
    
    echo ""
    printf "%${padding}s" ""
    echo -e "${color}╔══════════════════════════════════════════╗${NC}"
    printf "%${padding}s" ""
    printf "${color}║${NC}"
    local title_padding=$(( (40 - ${#title}) / 2 ))
    printf "%${title_padding}s" ""
    echo -ne "${WHITE}${BOLD}${title}${NC}"
    printf "%$(( 40 - ${#title} - title_padding ))s" ""
    echo -e "${color}║${NC}"
    printf "%${padding}s" ""
    echo -e "${color}╚══════════════════════════════════════════╝${NC}"
    echo ""
}

# ═══════════════════════════════════════════════════════════
# BOOT SCREEN WITH ANIMATED PROGRESS BAR
# ═══════════════════════════════════════════════════════════
show_boot_screen() {
    clear_screen
    
    # Show title box
    draw_box "GT INSTALLER" "$CYAN"
    
    echo ""
    echo ""
    
    # Progress bar animation
    local bar_length=40
    local delay=0.03
    
    for i in $(seq 0 100); do
        # Determine color based on percentage
        local color
        if [ $i -le 25 ]; then
            color=$RED
        elif [ $i -le 50 ]; then
            color=$PURPLE
        elif [ $i -le 75 ]; then
            color=$CYAN
        else
            color=$GREEN
        fi
        
        # Calculate filled bars
        local filled=$(( i * bar_length / 100 ))
        local empty=$(( bar_length - filled ))
        
        # Build progress bar
        local bar="["
        for ((j=0; j<filled; j++)); do
            bar+="█"
        done
        for ((j=0; j<empty; j++)); do
            bar+=" "
        done
        bar+="]"
        
        # Print progress
        echo -ne "\r\033[K"
        print_centered "${bar} ${i}%" "$color"
        
        sleep $delay
    done
    
    echo ""
    echo ""
    print_centered "✓ Loading Complete!" "$GREEN"
    
    sleep 1
}

# ═══════════════════════════════════════════════════════════
# ASCII LOGO DISPLAY
# ═══════════════════════════════════════════════════════════
display_logo() {
    clear_screen
    echo ""
    echo -e "${GREEN}"
    echo "██████╗ ████████╗"
    echo "██╔════╝ ╚══██╔══╝"
    echo "██║  ███╗   ██║"
    echo "██║   ██║   ██║"
    echo "╚██████╔╝   ██║"
    echo " ╚═════╝    ╚═╝"
    echo -e "${NC}"
    echo ""
    print_centered "GT INSTALLER" "$CYAN"
    echo ""
}

# ═══════════════════════════════════════════════════════════
# MAIN MENU
# ═══════════════════════════════════════════════════════════
show_main_menu() {
    echo ""
    print_centered "════════════════════ MENU ════════════════════" "$CYAN"
    echo ""
    echo -e "  ${GREEN}[1]${NC} Panel"
    echo ""
    echo -e "  ${RED}[0]${NC} Exit"
    echo ""
    print_centered "══════════════════════════════════════════════" "$CYAN"
    echo ""
}

# ═══════════════════════════════════════════════════════════
# PANEL MENU
# ═══════════════════════════════════════════════════════════
show_panel_menu() {
    clear_screen
    display_logo
    draw_box "PANELS" "$CYAN"
    
    echo -e "  ${GREEN}[1]${NC} Crispy Adventure"
    echo -e "  ${YELLOW}[2]${NC} Coming Soon"
    echo -e "  ${YELLOW}[3]${NC} Coming Soon"
    echo ""
    echo -e "  ${RED}[0]${NC} Back"
    echo ""
    print_line "─" "$CYAN"
    echo ""
}

# ═══════════════════════════════════════════════════════════
# PROGRESS STAGE DISPLAY
# ═══════════════════════════════════════════════════════════
show_progress_stage() {
    local message="$1"
    local bar_length=34
    local delay=0.02
    
    echo -ne "\r\033[K"
    echo -ne "${GREEN}["
    for ((i=0; i<bar_length; i++)); do
        echo -ne "█"
        sleep $delay
    done
    echo -ne "] 100% ${message}${NC}"
    sleep 0.3
    echo ""
    echo -e "${GREEN}✓ Complete${NC}"
    sleep 0.5
}

# ═══════════════════════════════════════════════════════════
# INSTALLER: CRISPY ADVENTURE
# ═══════════════════════════════════════════════════════════
install_crispy_adventure() {
    clear_screen
    draw_box "INSTALLING CRISPY ADVENTURE" "$CYAN"
    echo ""
    
    # Stage 1: Preparing Installer
    show_progress_stage "Preparing Installer"
    
    # Stage 2: Loading Configuration
    show_progress_stage "Loading Configuration"
    
    # Stage 3: Finalizing Setup
    show_progress_stage "Finalizing Setup"
    
    echo ""
    print_centered "Starting installation..." "$YELLOW"
    echo ""
    
    # Execute installation commands
    echo -e "${CYAN}[1/4]${NC} Cloning repository..."
    if git clone https://github.com/pratikgamer11/crispy-adventure 2>/dev/null; then
        echo -e "${GREEN}✓ Repository cloned successfully${NC}"
    else
        echo -e "${RED}✗ Failed to clone repository (may already exist)${NC}"
    fi
    
    echo -e "${CYAN}[2/4]${NC} Updating package lists..."
    if apt update -y 2>/dev/null; then
        echo -e "${GREEN}✓ Package lists updated${NC}"
    else
        echo -e "${YELLOW}⚠ Package update failed (continuing anyway)${NC}"
    fi
    
    echo -e "${CYAN}[3/4]${NC} Installing Node.js..."
    if apt install nodejs -y 2>/dev/null; then
        echo -e "${GREEN}✓ Node.js installed${NC}"
    else
        echo -e "${YELLOW}⚠ Node.js installation failed (might be already installed)${NC}"
    fi
    
    echo -e "${CYAN}[4/4]${NC} Setting up application..."
    cd crispy-adventure 2>/dev/null || true
    
    if npm install express 2>/dev/null; then
        echo -e "${GREEN}✓ Express installed${NC}"
    else
        echo -e "${RED}✗ Failed to install Express${NC}"
    fi
    
    if npm install fer 2>/dev/null; then
        echo -e "${GREEN}✓ Fer installed${NC}"
    else
        echo -e "${RED}✗ Failed to install Fer${NC}"
    fi
    
    echo ""
    print_centered "════════════════════════════════════════════" "$GREEN"
    print_centered "✓ Installation Complete!" "$GREEN"
    print_centered "════════════════════════════════════════════" "$GREEN"
    echo ""
    
    # Start the application
    echo -e "${CYAN}Starting application...${NC}"
    echo -e "${YELLOW}Press Ctrl+C to stop and return to menu${NC}"
    echo ""
    sleep 2
    
    node . 2>/dev/null || {
        echo -e "${RED}Failed to start application${NC}"
        echo -e "${YELLOW}Please check if all dependencies are installed correctly${NC}"
    }
    
    cd - > /dev/null 2>&1 || true
    
    echo ""
    echo -ne "${CYAN}Press Enter to return to menu...${NC}"
    read -r
}

# ═══════════════════════════════════════════════════════════
# HANDLE USER INPUT
# ═══════════════════════════════════════════════════════════
get_user_choice() {
    local choice
    read -r -p "$(echo -e "${CYAN}Enter your choice: ${NC}")" choice
    echo "$choice"
}

# ═══════════════════════════════════════════════════════════
# MAIN APPLICATION LOOP
# ═══════════════════════════════════════════════════════════
main() {
    # Check for required commands
    for cmd in clear git apt node npm; do
        if ! command -v "$cmd" &> /dev/null; then
            echo -e "${YELLOW}Warning: $cmd is not installed. Some features may not work.${NC}"
        fi
    done
    
    # Show boot screen on startup
    show_boot_screen
    
    # Main menu loop
    while true; do
        clear_screen
        display_logo
        show_main_menu
        
        local choice=$(get_user_choice)
        
        case $choice in
            1)
                # Panel submenu
                while true; do
                    show_panel_menu
                    local panel_choice=$(get_user_choice)
                    
                    case $panel_choice in
                        1)
                            install_crispy_adventure
                            ;;
                        2|3)
                            echo ""
                            print_centered "Coming soon!" "$YELLOW"
                            sleep 1
                            ;;
                        0)
                            break
                            ;;
                        *)
                            echo ""
                            print_centered "Invalid choice. Please try again." "$RED"
                            sleep 1
                            ;;
                    esac
                done
                ;;
            0)
                clear_screen
                echo ""
                print_centered "════════════════════════════════════════════" "$GREEN"
                print_centered "Thank you for using GT Installer!" "$CYAN"
                print_centered "════════════════════════════════════════════" "$GREEN"
                echo ""
                exit 0
                ;;
            *)
                echo ""
                print_centered "Invalid choice. Please try again." "$RED"
                sleep 1
                ;;
        esac
    done
}

# ═══════════════════════════════════════════════════════════
# TRAP CTRL+C FOR GRACEFUL EXIT
# ═══════════════════════════════════════════════════════════
trap 'echo -e "\n\n${YELLOW}Interrupted by user${NC}"; exit 1' INT

# ═══════════════════════════════════════════════════════════
# RUN THE APPLICATION
# ═══════════════════════════════════════════════════════════
main "$@"
