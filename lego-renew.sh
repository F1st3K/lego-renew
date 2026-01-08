#!/bin/bash

EMAIL="some@mail.com"
LEGO_PATH="/etc/lego"
CERT_DIR="$LEGO_PATH/certificates"
RENEWED=false

echo "🔁 Остановка nginx..."
systemctl stop nginx

# Получаем список доменов из файлов .crt (каждому соответствует свой .key)
for cert in "$CERT_DIR"/*.key; do
    domain=$(basename "$cert" .key)

    echo "🔄 Проверка домена: $domain"
    output=$(lego --email="$EMAIL" \
                  --domains="$domain" \
                  --path="$LEGO_PATH" \
                  --http renew --days 30 2>&1)

    echo "$output"

    if echo "$output" | grep -q "renewal is not needed"; then
        echo "ℹ️ Сертификат $domain не требует обновления"
    else
        RENEWED=true
        echo "✅ Сертификат $domain обновлён"
    fi
done

echo "🔁 Запуск nginx..."
systemctl start nginx

