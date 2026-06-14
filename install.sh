#!/data/data/com.termux/files/usr/bin/bash

set -u

green="\033[1;32m"
cyan="\033[1;36m"
yellow="\033[1;33m"
reset="\033[0m"

echo -e "${cyan}"
echo "============================================================"
echo " Termux Hacker Menu Installer"
echo "============================================================"
echo -e "${reset}"

echo -e "${yellow}[*] Updating packages...${reset}"
pkg update -y

echo -e "${yellow}[*] Installing tools...${reset}"
pkg install figlet toilet ruby cmatrix termux-api -y

if ! command -v lolcat >/dev/null 2>&1; then
  echo -e "${yellow}[*] Installing lolcat...${reset}"
  gem install lolcat
fi

chmod +x hacker.sh

echo ""
echo -e "${green}[+] Done.${reset}"
echo "Run it with:"
echo "./hacker.sh"

