#!/bin/bash
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
RAM=$(free | awk '/Mem:/ {printf "%d", $3/$2*100}')
TEMP=$(cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | sort -n | tail -1)
GPU_DATA=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

if [ "$CPU" -gt 80 ]; then CPU_COLOR="#f07178"
elif [ "$CPU" -gt 50 ]; then CPU_COLOR="#f9c859"
else CPU_COLOR="#4db8d4"; fi

if [ "$RAM" -gt 80 ]; then RAM_COLOR="#f07178"
elif [ "$RAM" -gt 60 ]; then RAM_COLOR="#f9c859"
else RAM_COLOR="#a6e3a1"; fi

TEXT="<span foreground='${CPU_COLOR}'>󰻠 ${CPU}%</span>  <span foreground='${RAM_COLOR}'> ${RAM}%</span>"

if [ -n "$TEMP" ]; then
    TEMP=$((TEMP / 1000))
    TEXT="${TEXT}  󰔏 ${TEMP}°"
fi

if [ -n "$GPU_DATA" ]; then
    GPU_USE=$(echo "$GPU_DATA" | awk -F',' '{print int($1)}')
    GPU_TEMP=$(echo "$GPU_DATA" | awk -F',' '{print int($2)}')
    if [ "$GPU_USE" -gt 80 ]; then GPU_COLOR="#f07178"
    elif [ "$GPU_USE" -gt 40 ]; then GPU_COLOR="#f9c859"
    else GPU_COLOR="#a6e3a1"; fi
    TEXT="${TEXT}  <span foreground='${GPU_COLOR}'>󰍛 ${GPU_USE}%</span> ${GPU_TEMP}°"
fi

TOOLTIP="CPU: ${CPU}%  RAM: ${RAM}%"
echo "{\"text\": \"${TEXT}\", \"tooltip\": \"${TOOLTIP}\"}"
