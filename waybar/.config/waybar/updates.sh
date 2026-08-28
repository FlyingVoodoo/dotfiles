#!/bin/bash
COUNT=$(dnf check-update -q 2>/dev/null | grep -v "^$\|^Last\|^Fedora\|^Updates" | wc -l)
if [ "$COUNT" -gt 0 ]; then
    echo "{\"text\": \"󰚰 ${COUNT}\", \"tooltip\": \"Доступно обновлений: ${COUNT}\", \"class\": \"has-updates\"}"
else
    echo "{\"text\": \"󰚰 0\", \"tooltip\": \"Система обновлена\", \"class\": \"updated\"}"
fi
