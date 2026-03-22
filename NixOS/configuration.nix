{ inputs, config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;



  # ------------ #
  #   HARDWARE   #
  # ------------ #

  hardware.graphics = {
    enable = true;             # Enables 32-bit and 64-bit Mesa drivers

    enable32Bit = true;        # Also installs 32-bit libs (needed for Steam/Wine/Proton)

    extraPackages = with pkgs; [
      libva-vdpau-driver            # VDPAU → VA-API bridge
      libvdpau-va-gl        # VDPAU via OpenGL
    ];  
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;  # use open source kernel modules (recommended for RTX cards)
    nvidiaSettings = true;
    modesetting.enable = true;  # required for wayland/sddm to work properly

    powerManagement = {
      # Save/restore GPU state on suspend/hibernate (driver >= 430.09)
      enable = false;

      # RTD3: allow GPU to fully power off when idle (Turing+ only, experimental)
      # Best for laptops, requires powerManagement.enable = true
      finegrained = false;

      # Use kernel suspend notifiers instead of systemd (driver >= 595, open = true only)
      kernelSuspendNotifier = false;
    };
  };



  # ------------------- #
  #   ENABLE SERVICES   #
  # ------------------- #

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.pipewire.lowLatency.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "cmarco"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.logmein-hamachi.enable = true;

  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;  # helps with resolution/upscaling issues
    platformOptimizations.enable = true;
  };
  programs.gamemode.enable = true;  # boosts performance while a game runs
  hardware.steam-hardware.enable = true;

  services.procon2d-rs.enable = true;
  services.procon2d-rs.enableUdevRules = true;

  programs.fish.enable = true;
  services.flatpak.enable = true;

  services.udev.extraRules = ''
  KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
'';



  # ----------- #
  #   LOCALES   #
  # ----------- #

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
  };


  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;



  # ----------- #
  #   ACCOUNT   #
  # ----------- #

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cmarco = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Cottignoli Marco";
    extraGroups = [ "networkmanager" "wheel" "input" "dialog" "adbusers" ];
    packages = with pkgs; [
    ];
  };

  users.users.procon2d = {
    isSystemUser = true;
    group = "procon2d";
    extraGroups = [ "input" ];
  };

  users.groups.procon2d = {};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      neovim
      vesktop
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      ghostty

      usbutils

      git
      gh

      fzf
      grc

      mangohud

      arduino-ide      # Arduino IDE 2.x — for STM32 MCU sketch development
      arduino-cli      # CLI alternative for scripting/automation
      android-tools    # Provides `adb` — App Lab talks to the Dragonwing 
      appimage-run     # Wraps AppImages in an FHS environment 
  ];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
