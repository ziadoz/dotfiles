#!/bin/bash

# Read JSON input once
input=$(cat)

# Extract current directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Extract usage percentages
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // 0' | cut -d. -f1)

# Extract model display name
model_name=$(echo "$input" | jq -r '.model.display_name // ""')

# Fallback: extract version from model ID if display_name is empty
if [ -z "$model_name" ] || [ "$model_name" = "null" ]; then
  model_name=$(echo "$input" | jq -r '.model.id // ""' \
    | sed -n 's/claude-\([a-z]*\)-\([0-9]*\)-\([0-9]*\)/Claude \u\1 \2.\3/p')
fi

model="$model_name"

# Pick a colour for a percentage based on usage thresholds
pct_color() {
  local pct=$1
  if [ "$pct" -ge 60 ]; then
    printf '\033[01;31m' # red
  elif [ "$pct" -ge 40 ]; then
    printf '\033[01;33m' # yellow
  else
    printf '\033[01;32m' # green
  fi
}

ctx_color=$(pct_color "$ctx_pct")
five_color=$(pct_color "$five_pct")
week_color=$(pct_color "$week_pct")

usage=$(printf 'ctx: %b%s%%\033[00m | 5h: %b%s%%\033[00m | 7d: %b%s%%\033[00m' \
  "$ctx_color" "$ctx_pct" \
  "$five_color" "$five_pct" \
  "$week_color" "$week_pct")

# Git information
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  repo_name=$(basename "$cwd")
  branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)

  printf '\033[01;36m%s\033[00m (%s) | %s | %b' \
    "$repo_name" "$branch" "$model" "$usage"
else
  printf '\033[01;36m%s\033[00m | %s | %b' \
    "$cwd" "$model" "$usage"
fi
