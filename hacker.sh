#!/data/data/com.termux/files/usr/bin/bash

set -u

red="\033[1;31m"
green="\033[1;32m"
cyan="\033[1;36m"
yellow="\033[1;33m"
white="\033[1;37m"
reset="\033[0m"

paint() {
  if command -v lolcat >/dev/null 2>&1; then
    lolcat
  else
    cat
  fi
}

pause_screen() {
  echo ""
  read -r -p "Press Enter to return to menu..."
}

banner() {
  clear
  if command -v toilet >/dev/null 2>&1; then
    toilet -f big "SECRET CODE" | paint
  elif command -v figlet >/dev/null 2>&1; then
    figlet "SECRET CODE" | paint
  else
    echo "SECRET CODE" | paint
  fi

  echo -e "${green}============================================================${reset}"
  echo -e "${white}              Termux Cyber Lab Menu${reset}"
  echo -e "${green}============================================================${reset}"
  echo ""
}

loading() {
  echo -e "${cyan}[*] Initializing interface...${reset}"
  sleep 0.4
  echo -e "${cyan}[*] Loading modules...${reset}"
  sleep 0.4
  echo -e "${cyan}[*] Checking environment...${reset}"
  sleep 0.4
  echo -e "${green}[+] Ready.${reset}"
  sleep 0.6
}

device_info() {
  banner
  echo -e "${yellow}[ Device Info ]${reset}"
  echo ""
  echo "User: $(whoami)"
  echo "Host: $(hostname 2>/dev/null || echo unknown)"
  echo "Kernel: $(uname -a)"
  echo "Uptime: $(uptime 2>/dev/null || echo unknown)"
  echo "Shell: ${SHELL:-unknown}"
  echo "Home: ${HOME:-unknown}"
  echo ""

  if command -v getprop >/dev/null 2>&1; then
    echo -e "${cyan}Android Properties:${reset}"
    echo "Brand: $(getprop ro.product.brand)"
    echo "Model: $(getprop ro.product.model)"
    echo "Device: $(getprop ro.product.device)"
    echo "Android: $(getprop ro.build.version.release)"
    echo "SDK: $(getprop ro.build.version.sdk)"
    echo ""
  fi

  if command -v termux-battery-status >/dev/null 2>&1; then
    echo -e "${cyan}Battery:${reset}"
    termux-battery-status
    echo ""
  else
    echo -e "${yellow}Battery info needs Termux:API app + pkg install termux-api${reset}"
    echo ""
  fi

  echo -e "${cyan}Storage:${reset}"
  df -h 2>/dev/null | head -n 12
  pause_screen
}

network_info() {
  banner
  echo -e "${yellow}[ Network Info ]${reset}"
  echo ""

  echo -e "${cyan}IP Addresses:${reset}"
  if command -v ip >/dev/null 2>&1; then
    ip -o addr show 2>/dev/null | awk '{print $2, $3, $4}'
  else
    ifconfig 2>/dev/null
  fi

  echo ""
  echo -e "${cyan}Routes:${reset}"
  ip route 2>/dev/null || route 2>/dev/null || echo "Route command unavailable."

  echo ""
  echo -e "${cyan}DNS:${reset}"
  getprop net.dns1 2>/dev/null
  getprop net.dns2 2>/dev/null

  echo ""
  echo -e "${yellow}Note: This only shows your own device/network info.${reset}"
  pause_screen
}

matrix_mode() {
  clear
  echo -e "${green}Launching Matrix Mode...${reset}"
  sleep 1

  if command -v cmatrix >/dev/null 2>&1; then
    cmatrix
  else
    echo "cmatrix is not installed. Run ./install.sh first."
    pause_screen
  fi
}

about_screen() {
  banner
  echo -e "${yellow}[ About ]${reset}"
  echo ""
  echo "Termux Hacker Menu"
  echo "A harmless cyber-style terminal project for learning and demos."
  echo ""
  echo "What it does:"
  echo "- Shows your phone/device information"
  echo "- Shows your own network information"
  echo "- Runs Matrix-style terminal animation"
  echo ""
  echo "What it does not do:"
  echo "- No password stealing"
  echo "- No hacking other devices"
  echo "- No hidden background actions"
  pause_screen
}

main_menu() {
  while true; do
    banner
    echo -e "${cyan}[1]${reset} Device Info"
    echo -e "${cyan}[2]${reset} Network Info"
    echo -e "${cyan}[3]${reset} Matrix Mode"
    echo -e "${cyan}[4]${reset} About"
    echo -e "${cyan}[0]${reset} Exit"
    echo ""
    read -r -p "Select option: " choice

    case "$choice" in
      1) device_info ;;
      2) network_info ;;
      3) matrix_mode ;;
      4) about_screen ;;
      0)
        echo -e "${green}Goodbye, operator.${reset}"
        exit 0
        ;;
      *)
        echo -e "${red}Invalid option.${reset}"
        sleep 1
        ;;
    esac
  done
}

loading
main_menu

