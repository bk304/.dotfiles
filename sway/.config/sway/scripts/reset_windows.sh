#!/bin/bash

# Regras: app_id ou class → workspace
declare -A rules
rules["zen"]="3"
rules["Brave-browser"]="3"
rules["foot"]="1"
rules["thunar"]="4"

# Percorre a árvore e pega janelas com app_id ou class
swaymsg -t get_tree | jq -c '
  recurse(.nodes[]?, .floating_nodes[]?) |
  select(.app_id or .window_properties.class) |
  {
    id: .id,
    app_id: .app_id,
    class: .window_properties.class
  }
' | while read -r window; do
    id=$(echo "$window" | jq -r '.id')
    app_id=$(echo "$window" | jq -r '.app_id // empty')
    class=$(echo "$window" | jq -r '.class // empty')

    key="${app_id:-$class}"
    workspace="${rules[$key]}"

    if [[ -n "$workspace" ]]; then
        swaymsg "[con_id=$id]" move to workspace number "$workspace"
    fi
done
