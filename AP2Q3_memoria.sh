#!/bin/bash

#Daniel Alexsandro Abrão e Thuany Muraro Soares

processos() {
    data=$(date +%Y%m%d)
    usuario=$(whoami)
    nomehost=$(hostname)
    memoria_total=$(free -h | awk '/Mem\:/ { print $2 }')
    memoria_usada=$(free -h | awk '/Mem\:/ { print $3 }')
    swap_total=$(free -h | awk '/Swap\:/ { print $2 }')
    swap_usada=$(free -h | awk '/Swap\:/ { print $3 }')
    processo_usuario=$(ps aux | awk '{print $1}' | grep -c "$usuario")
    memoria_processos=$(ps -U "$usuario" -o rss= | awk '{sum+=$1} END {print sum}')
    page_faults=$(grep -E 'pgfault|pgmajfault' /proc/vmstat | awk '{sum+=$2} END {print sum}')

    data_arquivo=$(date +"%d/%m/%Y %H:%M")
    saida="Daniel_Thuany_${data}_memoria_${usuario}.csv"

    if [ ! -e "$saida" ]; then
        echo "Informações coletadas em: $data_arquivo, pelo usuario: $usuario" > "$saida"
    fi

    echo -e "\\n$data, $usuario, $nomehost, $memoria_total, $memoria_usada, $swap_total, $swap_usada, $processo_usuario, $memoria_processos, $page_faults" >> "$saida"
}

main() {
    end=$((SECONDS + 300)) 
    while [ $SECONDS -lt $end ]; do
        processos
        sleep 20
    done
}

main
