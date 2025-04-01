#!/bin/bash

# Nome do monitor
MONITOR_NAME="$1"

if [ -z "$MONITOR_NAME" ]; then
  echo "Erro: Nenhum monitor especificado."
  exit 1
fi

# Obter as informações do monitor especificado
MONITOR_INFO=$(swaymsg -t get_outputs | jq -r ".[] | select(.name == \"$MONITOR_NAME\")")

if [ -z "$MONITOR_INFO" ]; then
  echo "Erro: Monitor '$MONITOR_NAME' não encontrado ou não está conectado."
  exit 1
fi

# Extrair posição e resolução
X_POS=$(echo "$MONITOR_INFO" | jq -r '.rect.x')
Y_POS=$(echo "$MONITOR_INFO" | jq -r '.rect.y')
RESOLUCAO=$(echo "$MONITOR_INFO" | jq -r '.rect.width, .rect.height' | paste -sd'x' -)

# Calcular o centro
LARGURA=$(echo "$RESOLUCAO" | cut -d'x' -f1)
ALTURA=$(echo "$RESOLUCAO" | cut -d'x' -f2)
CENTRO_X=$((LARGURA / 2 + X_POS))
CENTRO_Y=$((ALTURA / 2 + Y_POS))

# Mover o cursor para o centro do monitor
swaymsg seat seat0 cursor set $CENTRO_X $CENTRO_Y
