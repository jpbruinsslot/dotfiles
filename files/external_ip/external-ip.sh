#/bin/bash
IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

if [ ! -z "$IP" ]; then
    echo "🌍  $IP"
else
    echo "⛔ "
fi
