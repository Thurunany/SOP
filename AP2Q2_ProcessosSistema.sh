#!/bin/bash

#Daniel Alexsandro Abrão e Thuany Muraro Soares

pegar_usuario() {
    if [ -z "$1" ]; then
        usuario=$(whoami)
    else
        if id "$1" >/dev/null 2>&1; then
            usuario=$1
        else
            echo "Usuario '$1' não existe!"
            exit 1
        fi
    fi
}

a_pegar_processos_ativos() {
    processos=$(ps -e | wc -l)
    echo "a: $processos"
}

b_pegar_processos_ativos_usuario() {
    processos_usuario=$(ps -U "$usuario" -o pid= | wc -l)
    echo "b: $processos_usuario"
}

c_pegar_threads_usuario() {
    threads_usuario=$(ps -U "$usuario" -L | grep -v '^ *PID' | wc -l)
    echo "c: $threads_usuario"
}

d_pegar_processo_antigo() {
    primeiro_processo=$(ps -U "$usuario" -o pid,etime,cmd --sort=start_time | grep -v '^ *PID' | head -n 1)
    echo "d:'$primeiro_processo'"
}

e_pegar_usuario_atual(){
    usuario_atual=$(whoami)
    echo "e: '$usuario_atual'"
}

f_processos_menos_usuario() {
    processos_menos_usuario=$(ps -eo user= | grep -v "^$usuario_atual$" | wc -l)
    echo "f: $processos_menos_usuario"
}

g_processos_root() {
    processos_root=$(ps -U root | wc -l)
    echo "g: $processos_root"
}

pegar_usuario "$1"
questao_a=$(a_pegar_processos_ativos)
questao_b=$(b_pegar_processos_ativos_usuario)
questao_c=$(c_pegar_threads_usuario)
questao_d=$(d_pegar_processo_antigo)
questao_e=$(e_pegar_usuario_atual)
questao_f=$(f_processos_menos_usuario)
questao_g=$(g_processos_root) 

data=$(date +%Y%m%d)
data_arquivo=$(date +"%d/%m/%Y")
saida="${data}_Processos_${usuario}.csv"

if [ ! -e "$saida" ]; then
    echo "Informações coletadas em: $data_arquivo, pelo usuario: $usuario" > "$saida"
fi

echo "\n$questao_a\n$questao_b\n$questao_c\n$questao_d\n$questao_e\n$questao_f\n$questao_g" >> "$saida"