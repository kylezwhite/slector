#!/bin/bash

# Define script directory
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/scripts"

# Banner
BANNER='
   ______   ___________________  ___
  / __/ /  / __/ ___/_  __/ __ \/ _ \
 _\ \/ /__/ _// /__  / / / /_/ / , _/
/___/____/___/\___/ /_/  \____/_/|_| '

# Footer
FOOTER=$(echo "$BANNER" | sed 's/./-/g')

# Colors
YELLOW='\033[1;33m'
NC='\033[0m'

# Display
function display_scripts {
    clear
    echo -e "${YELLOW}$BANNER${NC}\n"
    echo "Kyle White V1.0"
    echo "Select a script to run:"
    local scripts=()
    for script in "$SCRIPT_DIR"/*.sh; do
        if [ -f "$script" ] && [ -x "$script" ]; then
            scripts+=("$(basename "${script%.*}")")
        fi
    done
    select script in "${scripts[@]}" "Quit"; do
        if [ "$script" == "Quit" ]; then
            exit 0
        elif [ -n "$script" ]; then
            clear
            echo -e "${YELLOW}$BANNER${NC}\n"
            echo "Kyle White V1.0"
            echo "Running $script..."
            "$SCRIPT_DIR/$script.sh"
            read -rp "Press Enter to return to the main menu"
        fi
        display_scripts
    done
}

display_scripts

