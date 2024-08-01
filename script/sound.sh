#!/usr/bin/env bash

eval "$(dbus-launch --sh-syntax --exit-with-session)"
sleep 2
dbus-launch --exit-with-session
sleep 3
gentoo-pipewire-launcher restart
