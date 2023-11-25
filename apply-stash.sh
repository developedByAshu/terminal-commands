#!/bin/bash

# Function to apply a stash by name
apply_stash_by_name() {
  local stash_name="$1"

  # Get a list of all stashes
  local stash_list=$(git stash list)

  # Iterate through each line in the stash list
  while IFS= read -r stash_entry; do
    # Extract the stash index (e.g., stash@{0}) and stash message
    local stash_index=$(echo "$stash_entry" | awk -F': ' '{print $1}')
    local stash_message=$(echo "$stash_entry" | awk -F': ' '{print $3}')

    # Check if the stash message matches the provided name
    if [[ "$stash_message" == "$stash_name" ]]; then
      # Apply the stash
      git stash apply "$stash_index"
      echo "[Applied Stash ==> $stash_entry]"
      return 0
    fi
  done <<< "$stash_list"

  # Stash with the provided name not found
  echo "Stash not found: $stash_name"
  return 1
}

# Check if a stash name was provided as an argument
if [ $# -eq 0 ]; then
  echo "Please provide the name of the stash to apply."
  exit 1
fi

apply_stash_by_name "$1"

