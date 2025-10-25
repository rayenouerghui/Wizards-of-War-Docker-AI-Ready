#!/bin/bash
# Helper script to install dependencies and build the game on Debian/Kali
set -e
sudo apt update
sudo apt install -y build-essential libsdl1.2-dev libsdl-image1.2-dev libsdl-ttf2.0-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev
make
echo "Build finished. Run ./GAME to start the game."