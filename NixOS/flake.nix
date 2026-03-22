{
  description = "NixOS flake for my system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs"; # shares your system's nixpkgs
    };

    procon2d-rs.url = "github:Joshua265/procon2d-rs";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";  # don't fetch a second nixpkgs
    };
  };



  outputs = { self, nixpkgs, nix-gaming, procon2d-rs, home-manager, ... }@inputs: {
    nixosConfigurations.cmarco = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix

	nix-gaming.nixosModules.pipewireLowLatency
  	nix-gaming.nixosModules.platformOptimizations

        procon2d-rs.nixosModules.default



	home-manager.nixosModules.home-manager
	{
  	  home-manager.users.cmarco = import ./home.nix;
  	  home-manager.useGlobalPkgs = true;
  	  home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
	  home-manager.extraSpecialArgs = {
    	    nix-gaming-pkgs = nix-gaming.packages.x86_64-linux;
  	  };
	}
      ];
    };
  };
}
