#!/bin/bash

# Garante que a primeira palavra seja "workspace"
if [[ "$1" != "workspace" ]]; then
    echo "Uso: $0 workspace [workspace_name] [comando...]"
    exit 1
fi

TARGET_WS="$2"
shift 2
APP="$@"

# Verifica se o workspace tem janelas
if ! swaymsg -t get_tree | jq -r '.. | objects | select(.type? == "workspace" and .name == "'"$TARGET_WS"'") | .nodes | length' | grep -q '[^0]'; then
    $APP &
fi
