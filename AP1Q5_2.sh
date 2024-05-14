#!/bin/bash
processo="$1"

if pgrep -x "$processo" > /dev/null; then
    pid=$(pgrep -x "$processo")
    estado=$(ps axo stat,pid | grep "$pid" | cut -b 1)
    echo "$processo ENCONTRADO"
    echo "PID: $pid"
    echo "ESTADO: $estado"
else
    echo "PROCESSO NÃO ENCONTRADO"
fi
