#!/bin/bash

# Wait for some time
sleep 1

# Maximize terminal
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
sleep 2 # Wait for some time

# Open three tabs in terminal, setting the backend as the directory
gnome-terminal --tab --tab -- bash -c "cd /home/devslane/Documents/Office/rove/backend; exec bash"

# Open another tab, for argoCD directory
gnome-terminal --tab --active -- bash -c "cd ~/Documents/Office/rove/argocd; exec bash"

# Open VS Code directly without typing
code /home/devslane/Documents/Office/rove/backend
sleep 1 # Wait for some time

# These will run in the first tab
# Open Google Chrome with specified URLs and suppress output logs
(google-chrome "https://outlook.office365.com/mail/" "https://app.slack.com/client/T02FVE04XN1/C05ENV5TXRV" "https://argdevco.atlassian.net/jira/software/c/projects/RP/boards/2/backlog" --profile-directory="Profile 3") & disown;
sleep 3

# Open backend directory
(xdg-open "/home/devslane/Documents/Office/rove/backend/") & disown;
sleep 1

# Close extra bash sessions in the first tab
# This can be done in the same terminal instance where the backend is running
# Execute `exit` in the new terminal
gnome-terminal -- bash -c "cd /home/devslane/Documents/Office/rove/backend; exit"
sleep 1 # Wait for a moment to ensure the session is closed

# Switch to the first terminal tab
# wmctrl -a gnome-terminal
xdotool search --onlyvisible --class gnome-terminal windowactivate
sleep 1 # Give time for focus switch

# Switch to the first tab
xdotool key alt+1
sleep 2 # Wait for the tab to activate

# Close running process in first tab
xdotool key Ctrl+C
sleep 1 # Adjust delay as needed
xdotool key Return  # Press Enter to confirm closing if prompted

# Switch to backend directory
xdotool type "cd /home/devslane/Documents/Office/rove/backend"
xdotool key Return

# Clear the terminal in the new session
xdotool type "clear"
xdotool key Return

# Run git status in the new session
xdotool type "git status"
xdotool key Return
sleep 1.5 # Wait for the output to stabilize

# Minimize all tabs
xdotool key Super+d

: '''
# Close first tab
xdotool key Ctrl+Shift+W
sleep 1 # Adjust delay as needed
xdotool key Return  # Press Enter to confirm closing if prompted

# Give some time to process
sleep 5

# Switch to the first terminal tab
wmctrl -a gnome-terminal
xdotool search --onlyvisible --class gnome-terminal windowactivate

# Give time for focus switch
sleep 1

# Switching to tab 2, then back to tab 1, to get tab 1 into focus
xdotool key alt+2
# xdotool key alt+1

###################################################################

# Switch to the first tab
xdotool key alt 1

# Wait for the tab to activate
sleep 2

# Switch to the first terminal tab
xdotool search --onlyvisible --class gnome-terminal windowactivate

# Give time for focus switch
sleep 1

# Close extra bash sessions in the first tab
xdotool type "exit"
xdotool key Return

# Wait for the session to close
sleep 2

# Open a new session in the first tab after closing previous bash sessions
xdotool key ctrl shift t  # This opens a new terminal tab within the current terminal window

# Wait for the new terminal tab to be ready
sleep 2

# Run git status in a new terminal
gnome-terminal -- bash -c "cd /home/devslane/Documents/Office/rove/backend; clear; git status; exec bash"
'''
