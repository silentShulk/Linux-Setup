#! /bin/bash

# Downloading repos
mkdir ~/Repos
mkdir ~/MyRepos

cd ~/MyRepos

gh repo clone silentShulk/MyZed
gh repo clone silentShulk/Accord-Timeline-Alterer
gh repo clone silentShulk/Linux-Setup

# Downloading dotfiles repo
gh repo clone silentShulk/Hyprland-Dots

# Setting up manim venv
uv python install

cd ~/

uv init --python 3.13 ManimProjects
cd ManimProjects
uv add manim opencv-python pillow
