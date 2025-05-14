#!/bin/sh

# Espera até conseguir pingar 8.8.8.8
while ! ping -q -c 1 -W 1 8.8.8.8 >/dev/null; do
    echo "Aguardando conexão de rede..."
    sleep 1
done

# Executa o comando passado como parâmetro
exec "$@"
