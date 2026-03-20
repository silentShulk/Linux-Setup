{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";  # don't fetch a second nixpkgs
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-gaming, ... }: {
    nixosConfigurations.cmarco = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix

	home-manager.nixosModules.home-manager
	{
  	  home-manager.useGlobalPkgs = true;
  	  home-manager.useUserPackages = true;
  	  home-manager.users.cmarco = import ./home.nix;
	  home-manager.extraSpecialArgs = {
    	    nix-gaming-pkgs = nix-gaming.packages.x86_64-linux;
  	  };
	}

	nix-gaming.nixosModules.pipewireLowLatency
  	nix-gaming.nixosModules.platformOptimizations
      ];
    };
  };
}
