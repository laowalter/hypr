#!/usr/bin/env bash

# Get current rotation state
monitor_state=$(hyprctl monitors -j | jq -r '.[] | select(.model=="DELL P2416D").transform')

# Check if monitor is already rotated (transform value is 1)
if [[ "$monitor_state" == "1" ]]; then
  # Set monitor to normal orientation
  hyprctl keyword monitor DP-1,preferred,auto
  echo "Monitor set to normal orientation."
else
  # Rotate monitor
  hyprctl keyword monitor DP-1,transform,1
  echo "Monitor rotated."
fi

