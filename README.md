# lego-renew
Devops automatisation for free certs (based Lego + Nginx)

1. Download lego:
```sh
cd /tmp
wget https://github.com/go-acme/lego/releases/latest/download/lego_v4.17.4_linux_amd64.tar.gz
tar -xzf lego_v4.17.4_linux_amd64.tar.gz
sudo mv lego /usr/local/bin/
sudo chmod +x /usr/local/bin/lego
```

2. Get first cert manual 
```sh
lego --email="$EMAIL" \
  --domains="$domain" \
  --path="$LEGO_PATH" \
  --http renew --days 30 
```

3. Download lego-renew.sh:
```sh
sudo wget -O /usr/local/bin/lego-renew https://raw.githubusercontent.com/F1st3K/lego-renew/main/lego-renew.sh
sudo chmod +x /usr/local/bin/lego-renew
```

4. Open crontab:
```sh
crontab -e
```

5. Add automation with logs:
```sh
0 0,12 * * * /usr/local/bin/lego-renew.sh >> /var/log/lego-renew.log 2>&1
```

SUCCESS!
