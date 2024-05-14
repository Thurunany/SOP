#!/bin/bash

if [ ! -d "$HOME/.lixeira" ]; then
    mkdir "$HOME/.lixeira"
fi

mover_para_lixeira() {
    arquivo="$1"
    mv "$arquivo" "$HOME/.lixeira"
    echo "$arquivo movido pra lixeira."
}

listar_lixeira() {
    ls -la "$HOME/.lixeira"
}

esvaziar_lixeira() {
    rm -rf "$HOME/.lixeira"/*
    echo "lixeira vazia"
}

if [ "$1" = "--esvaziar" ]; then
    esvaziar_lixeira
    exit 0
elif [ "$1" = "--listar" ]; then
    listar_lixeira
    exit 0
else
    mover_para_lixeira "$1"
fi
