#!/bin/bash

CURRENT=$(cat /sys/class/power_supply/BAT0/charge_control_end_threshold)

if [ "$CURRENT" -le 80 ]; then
    echo 100 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
else
    echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
fi
