#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <host> <puerto>"
    exit 1
fi

HOST="$1"
PORT="$2"

if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
    echo "Error: el puerto debe ser un número."
    exit 1
fi

if [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
    echo "Error: el puerto debe estar entre 1 y 65535."
    exit 1
fi

if nc -z -w 2 "$HOST" "$PORT"; then
    echo "Puerto $PORT en $HOST: ABIERTO"
else
    echo "Puerto $PORT en $HOST: CERRADO"
fi
