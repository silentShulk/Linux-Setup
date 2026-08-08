#! /bin/bash

# General update
if ! arch-update; then
    echo "\n\nno-cachy :(\n\n"

    sudo pacman -Syu
    yay -Syu || paru -Syu
fi



# Pacman Packages

# Needed to install
sudo pacman -S --needed \
	neovim \
	paru



# Terminal, Web Browser(s), Game launcher, Internet Messanges
sudo pacman -S --needed \
	ghostty \
	zen-browser-bin \
	chromium \
	steam \
	discord \
  	wine

# Window manager / Desktop environment
sudo pacman -S --needed \
	hyprland \
	hyprsunset \
	hyprlock \
	hyprshot \
  	hyprpicker \
  	hyprpolkitagent \
	xdg-desktop-portal-hyprland \
  	swaync \
  	swww \
	waybar-cava \
	rofi \
  	wlogout \
  	cava

# Utils
sudo pacman -S --needed \
	imv \
	pipewire \
	alsa-utils \
	alsa-plugins \
	swaync \
	bottom \
  	protonplus

# Coding
sudo pacman -S --needed \
	zed \
	vscodium \
	github-cli \
	uv \
	texlive-bin \
	dvisvgm \
	texlive \
	cairo \
	pango \
	arduino-cli \
	arduino-language-server 

gh auth login	# Login with github after installing github cli

# GPU Tools substitutes
sudo pacman -S --needed \
	lact \
	mangohud \
  	goverlay \
	gamescope \
	gamemode \
	nvidia-settings \    # NVIDIA Specific
	nvidia-utils    # NVIDIA Specific

sudo systemctl enable --now lactd

# Other suff
sudo pacman -S --needed \
	nautilus \
	nwg-clipman \
	nwg-look \
	obs-studio \
	kdeconnect \
	obsidian 



# AUR packages

# Coding
paru -S --needed \
	visual-studio-code-bin \
	jetbrains-toolbox 



# Other packages
sh -c "$(curl -sS https://vencord.dev/install.sh)"    		      # Vencord
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh        # Rust
curl -sS https://starship.rs/install.sh | sh		              # Starship
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim    # NvChad
