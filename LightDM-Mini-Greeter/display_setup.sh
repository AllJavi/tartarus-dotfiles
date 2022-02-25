#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --auto
xrandr --dpi 96
if [[ $(xrandr -q | grep 'HDMI-1-2 connected') ]]; then
	xrandr --output eDP-1-1 --primary --auto --output HDMI-1-2 --auto --right-of eDP-1-1
else
	xrandr --output eDP-1-1 --primary --auto --output HDMI-1-2 --off
fi
