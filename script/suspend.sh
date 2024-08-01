#!/bin/bash
swayidle -w \
  timeout 1 '/usr/bin/hyprctl dispatch dpms off' \
  resume '/usr/bin/hyprctl dispatch dpms on' \
  timeout 1 'sudo /usr/sbin/s2ram'
