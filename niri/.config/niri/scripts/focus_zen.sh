#!/bin/sh

zen_id=$(niri msg windows | awk '
  $1 == "Window" && $2 == "ID" {
    id = $3
    sub(":", "", id)
  }
  $1 == "App" && $2 == "ID:" && $3 == "\"zen\"" {
    print id
    exit
  }
')

if [ -n "$zen_id" ]; then
  niri msg action focus-window --id "$zen_id"
fi
