#!/bin/bash

# Function to perform a soft reset by n commits
soft_reset() {
  local n="$1"

  if [[ -z "$n" ]]; then
    echo "Usage: soft_reset <number_of_commits>"
    return 1
  fi

  git reset --soft HEAD~"$n"
}

# Function to perform a hard reset by n commits
hard_reset() {
  local n="$1"

  if [[ -z "$n" ]]; then
    echo "Usage: hard_reset <number_of_commits>"
    return 1
  fi

  git reset --hard HEAD~"$n"
}

# Main: if script is run directly, parse arguments
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  # Check for command and count
  if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <soft|hard> <number_of_commits>"
    exit 1
  fi

  cmd="$1"
  count="$2"

  case "$cmd" in
    soft)
      soft_reset "$count"
      ;;
    hard)
      hard_reset "$count"
      ;;
    *)
      echo "Unknown command: $cmd"
      echo "Usage: $0 <soft|hard> <number_of_commits>"
      exit 1
      ;;
  esac
fi

