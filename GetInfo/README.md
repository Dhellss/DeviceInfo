# Termux Hacker Menu

Harmless Termux menu project with hacker-style text effects, device info,
network info, Matrix mode, and an about screen.

This is for learning, demos, and personal use only. It does not steal data,
crack passwords, bypass security, or hack other devices.

## Install From GitHub

Replace `USERNAME` and `REPO` with your GitHub username and repository name.

```bash
pkg update
pkg install git -y
git clone https://github.com/USERNAME/REPO.git
cd REPO
chmod +x install.sh hacker.sh
./install.sh
./hacker.sh
```

## Run Again Later

```bash
cd REPO
./hacker.sh
```

## Features

- Hacker-style banner using `figlet`, `toilet`, and optional `lolcat`
- Device info screen
- Network info screen
- Matrix animation mode
- Clean menu navigation

## Notes

For battery info, install the Termux:API app from F-Droid and run:

```bash
pkg install termux-api -y
```

