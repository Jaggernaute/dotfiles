#!/usr/bin/env sh
xrandr --output eDP-1 --mode 1920x1080 --pos 0x1080 --rotate normal --output DP-1 --off --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-2 --off

notify-send "Welcome, $USER!" &
