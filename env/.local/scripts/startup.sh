#!/bin/bash

# Função via socket - mais precisa
wait_for_window_socket() {
    local expected_class=$1
    local found=0
    
    # Monitorar eventos de nova janela
    hyprctl -j clients | jq -r '.[] | .class' | while read class; do
        if [ "$class" = "$expected_class" ]; then
            found=1
            break
        fi
    done
    
    # Fallback com polling
    while [ $found -eq 0 ]; do
        if hyprctl clients | grep -q "$expected_class"; then
            break
        fi
    done
}

hyprpaper &
waybar &

hyprctl dispatch exec "[workspace 1 silent] firefox"
wait_for_window_socket "firefox"

hyprctl dispatch exec "[workspace 2 silent] ghostty" 
wait_for_window_socket "com.mitchellh.ghostty"

hyprctl dispatch workspace 1
