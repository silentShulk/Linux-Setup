#! /bin/bash

# Folder for external repos
mkdir ~/Repos

# Copying my own repos
cd ~/Projects/
gh repo clone silentShulk/MyZed
gh repo clone silentShulk/Accord-Timeline-Alterer
gh repo clone silentShulk/Linux-Setup
gh repo clone silentShulk/Hyprland-Dots

# Setting up manim venv
uv python install
cd ~/
uv init --python 3.13 ManimProjects
cd ManimProjects
uv add manim opencv-python pillow
