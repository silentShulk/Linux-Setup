{ config, pkgs, nix-gaming-pkgs, ... }:

{
  home.username = "cmarco";
  home.homeDirectory = "/home/cmarco";
  home.stateVersion = "25.11";  # match your system stateVersion

  home.packages = with pkgs; [
    vscodium
    rustup
    python3
    uv
    clang
    cmake

    nix-gaming-pkgs.wine-discord-ipc-bridge
    nix-gaming-pkgs.faf-client
    nix-gaming-pkgs.mo2installer
  ];

  programs.fish = {
    enable = true;
    plugins = [
      { name = "done";    src = pkgs.fishPlugins.done.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "forgit";  src = pkgs.fishPlugins.forgit.src; }
      { name = "hydro";   src = pkgs.fishPlugins.hydro.src; }
      { name = "grc";     src = pkgs.fishPlugins.grc.src; }
    ];
  };
}
