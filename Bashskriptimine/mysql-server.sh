#!/bin/bash

# Peatame skripti vea korral
set -e

# Automaatne paigaldus ilma küsimusteta
export DEBIAN_FRONTEND=noninteractive

# Uuendame pakettide nimekirja ja paigaldame vajalikud tööriistad
apt update
apt install -y gnupg ca-certificates debconf-utils wget

# Määrame MySQL repositooriumi seaded (Debian 13 toetab mysql-8.4-lts)
echo "mysql-apt-config mysql-apt-config/select-server select mysql-8.4-lts" | debconf-set-selections
echo "mysql-apt-config mysql-apt-config/select-tools select Disabled"       | debconf-set-selections
echo "mysql-apt-config mysql-apt-config/select-product select Ok"          | debconf-set-selections

# Määrame root-kasutaja parooli
echo "mysql-community-server mysql-community-server/root-pass password qwerty"     | debconf-set-selections
echo "mysql-community-server mysql-community-server/re-root-pass password qwerty" | debconf-set-selections

# Valime tugeva paroolikrüpteeringu
echo "mysql-community-server mysql-server/default-auth-override select Use Strong Password Encryption (RECOMMENDED)" | debconf-set-selections

# Laeme alla ja paigaldame MySQL repositooriumi paketi
wget -O /tmp/mysql-apt-config_0.8.40-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.40-1_all.deb
dpkg -i /tmp/mysql-apt-config_0.8.40-1_all.deb

# Uuendame allikaid ja paigaldame MySQL serveri
apt update
apt install -y mysql-server

# Käivitame MySQL teenuse ja lubame automaatse käivituse
systemctl enable --now mysql

# Loome .my.cnf faili paroolita sisselogimiseks
cat >"$HOME/.my.cnf" <<'EOF'
[client]
host=localhost
user=root
password=qwerty
EOF
chmod 600 "$HOME/.my.cnf"

echo "Valmis: MySQL 8.4 on paigaldatud. Root-parool: qwerty"
mysql --version || true
