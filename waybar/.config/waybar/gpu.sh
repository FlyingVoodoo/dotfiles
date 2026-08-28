#!/bin/bash
DATA=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits 2>/dev/null)
if [ -z "$DATA" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"\"}"
    exit
fi
GPU_USE=$(echo "$DATA" | awk -F',' '{print int($1)}')
GPU_TEMP=$(echo "$DATA" | awk -F',' '{print int($2)}')

if [ "$GPU_USE" -gt 80 ]; then COLOR="#f07178"
elif [ "$GPU_USE" -gt 40 ]; then COLOR="#f9c859"
else COLOR="#a6e3a1"; fi

echo "{\"text\": \"<span foreground='${COLOR}'>󰍛 ${GPU_USE}%</span>  󰔏 ${GPU_TEMP}°\", \"tooltip\": \"GPU: ${GPU_USE}%\nТемпература: ${GPU_TEMP}°C\"}"
