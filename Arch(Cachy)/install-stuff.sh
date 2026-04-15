#! /bin/bash

# General update
if ! arch-update; then
    echo "no-cachy :("
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
	discord 

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
	waybar \
	rofi \
  wlogout \
  cava

# Utils
sudo pacman -S --needed \
	imv \
	pipewire \
	alsa-utils \
	alsa-plugins \
	amberol \
	swaync \
	bottom 

# Coding
sudo pacman -S --needed \
	zed \
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

# AMD Adrenalin substitutes
sudo pacman -S --needed \
	lact \
	mangohud \
	gamescope 

sudo systemctl enable --now lactd

# Nvidia App substitutes
sudo pacman -S --needed \
	nvidia-settings \
	nvidia-utils 

# Other suff
sudo pacman -S --needed \
	nautilus \
	nwg-clipman \
	nwg-look \
	obs-studio \
	kdeconnect \
	obsidian \
	gemini-cli



# AUR packages

# Coding
paru -S --needed \
	visual-studio-code-bin \
	jetbrains-toolbox 



# Other packages
sh -c "$(curl -sS https://vencord.dev/install.sh)"    			          # Vencord
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh    	  # Rust
curl -sS https://starship.rs/install.sh | sh				                  # Starship
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim	  # NvChad
