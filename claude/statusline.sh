#!/bin/bash

# Read JSON input once
input=$(cat)

# Extract current directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Extract context percentage
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Extract model name and version
model_name=$(echo "$input" | jq -r '.model.display_name // ""')
model_version=$(echo "$input" | jq -r '.model.id // ""' | sed 's/claude-[a-z]*-\([0-9]*\)-\([0-9]*\).*/\1.\2/')
model="${model_name} ${model_version}"

# Git information
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  repo_name=$(basename "$cwd")
  branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)

  # Color the context percentage based on usage
  if [ "$ctx_pct" -ge 60 ]; then
    ctx_color='\033[01;31m' # red
  elif [ "$ctx_pct" -ge 40 ]; then
    ctx_color='\033[01;33m' # yellow
  else
    ctx_color='\033[01;32m' # green
  fi

  printf '\033[01;36m%s\033[00m (%s) | %s | ctx: %b%s%%\033[00m' \
    "$repo_name" "$branch" "$model" "$ctx_color" "$ctx_pct"
else
  printf '\033[01;36m%s\033[00m | %s | ctx: %s%%' "$cwd" "$model" "$ctx_pct"
fi
