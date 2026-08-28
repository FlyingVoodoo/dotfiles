#!/bin/bash
UP=$(uptime -p | sed 's/up //' | sed 's/ hours\?/h/' | sed 's/ minutes\?/m/' | sed 's/ days\?/d/' | sed 's/, / /')
echo "{\"text\": \"󰅐 ${UP}\", \"tooltip\": \"Аптайм системы: ${UP}\"}"
