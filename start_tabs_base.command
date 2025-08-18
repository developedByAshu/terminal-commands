#!/bin/bash

osascript <<EOF
tell application "System Events"
    tell application process "iTerm2"
        keystroke "+" using {command down}
    end tell
end tell
EOF

# Paths
backend_path="$HOME/Documents/Office/integrtr/integrtr_platform_backend"
ui_path="$HOME/Documents/Office/integrtr/integrtr_platform_ui"

# Tab labels and corresponding shell commands
tabs=(
  "Core"
  "Sy"
  "Sy Wkr"
  "Sy PullPro"
  # "Sy RBP"
  # "AM"
  # "DF"
  # "DF Wkr"
  "BL"
  # "MDGen"
  # "MDGen Wkr"
  # "MDGen Pro"
  # "SL Lambda"
  "UI"
)
  
commands=(
  "cd \"$backend_path\" && yarn p:core nodemon"
  "cd \"$backend_path\" && yarn p:sy nodemon"
  "cd \"$backend_path\" && yarn p:sy nodemon:worker"
  "cd \"$backend_path\" && yarn p:sy nodemon:pullProcessor"
  # "cd \"$backend_path\" && yarn p:sy nodemon:rbpProcessor"
  # "cd \"$backend_path\" && yarn p:am nodemon"
  # "cd \"$backend_path\" && yarn p:df nodemon"
  # "cd \"$backend_path\" && yarn p:df nodemon:worker"
  "cd \"$backend_path\" && yarn p:bl nodemon"
  # "cd \"$backend_path\" && yarn p:mdg nodemon"
  # "cd \"$backend_path\" && yarn p:mdg nodemon:worker"
  # "cd \"$backend_path\" && yarn p:mdg nodemon:runProcessor"
  # "cd \"$backend_path\" && yarn p:mefp dev"
  "cd \"$ui_path\" && yarn start"
)

# Temporary AppleScript file
tmp_script=$(mktemp)

# Begin AppleScript block
echo 'tell application "iTerm"' >> "$tmp_script"
echo '  activate' >> "$tmp_script"
echo '  set currentWin to current window' >> "$tmp_script"

for i in "${!tabs[@]}"; do
  tab_name="${tabs[$i]}"
  cmd="${commands[$i]}"

  # ANSI escape to rename tab (works in shell)
  full_cmd="printf '\e]0;$tab_name\a'; $cmd"
  esc_cmd=$(printf '%s' "$full_cmd" | sed 's/\\/\\\\/g; s/"/\\"/g')

  echo '  tell currentWin' >> "$tmp_script"
  echo '    set newTab to (create tab with default profile)' >> "$tmp_script"
  echo '    delay 0.1' >> "$tmp_script"
  echo '    tell current session of newTab' >> "$tmp_script"
  echo "      write text \"$esc_cmd\"" >> "$tmp_script"
  echo '    end tell' >> "$tmp_script"
  echo '  end tell' >> "$tmp_script"
done

echo 'end tell' >> "$tmp_script"

# Execute the AppleScript
osascript "$tmp_script"
rm "$tmp_script"
