#!/usr/bin/env sh

pkill polybar

# Check if xrandr is available and use it to find connected monitors
if type "xrandr" > /dev/null 2>&1; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "$m" = "eDP1" ]; then
      MONITOR=$m polybar --reload main &
    elif [ "$m" = "HDMI2" ]; then
      MONITOR=$m polybar --reload secondary &
    else
      # Default fallback
      MONITOR=$m polybar --reload main &
    fi
  done
else
  # Fallback for when xrandr is not available
  polybar --reload secondary &
fi
