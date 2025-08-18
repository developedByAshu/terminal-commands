#!/bin/bash

# Changing terminal name
# echo -ne "\033]0;🔥 Main Terminal 🔥\007"

# Wait for some time
sleep 0.5

# Maximize terminal
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz

# CD into project directory
cd /home/devslane/Documents/Office/integrtr/integrtr_platform_backend/

# Declare two parallel arrays for tab titles and commands
tabs=("Core" "Sy" "Sy Wkr" "Sy Pscr" "Sy RBP" "AM" "DF" "DF Wkr" "BL" "MDGen" "MDGen Wkr" "MDGen Pscr" "SL Lambda")
commands=("yarn p:core nodemon"
          "yarn p:sy nodemon"
          "yarn p:sy nodemon:worker"
          "yarn p:sy nodemon:processor"
          "yarn p:sy nodemon:rbpProcessor"
          "yarn p:am nodemon"
          "yarn p:df nodemon"
          "yarn p:df nodemon:worker"
          "yarn p:bl nodemon"
          "yarn p:mdg nodemon"
          "yarn p:mdg nodemon:worker"
          "yarn p:mdg nodemon:runProcessor"
          "yarn p:mefp dev")

# Loop through the arrays and open each command in a new tab with a custom title
for i in "${!tabs[@]}"; do
  gnome-terminal --tab --title="${tabs[i]}" -- bash -c "echo -ne '\033]0;${tabs[i]}\007'; ${commands[i]}; exec bash"
  sleep 0.5  # Small delay to ensure proper tab creation
done

# Running the Platform UI
gnome-terminal --tab --title="UI" --active -- bash -c "cd ~/Documents/Office/integrtr/integrtr_platform_ui; yarn start; exec bash"
