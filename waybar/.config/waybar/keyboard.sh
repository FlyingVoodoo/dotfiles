#!/bin/bash
LAYOUT=$(hyprctl devices -j | python3 -c "
import sys, json
d = json.load(sys.stdin)
for kb in d.get('keyboards', []):
    if kb.get('main'):
        print(kb.get('active_keymap', '').split(' ')[0][:2].upper())
        break
" 2>/dev/null)
[ -z "$LAYOUT" ] && LAYOUT="EN"
echo "{\"text\": \"󰌌 ${LAYOUT}\", \"tooltip\": \"Раскладка: ${LAYOUT}\"}"
