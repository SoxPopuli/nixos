{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-23_11.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles.url = "git+file:///etc/nixos/dotfiles";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-23_11, home-manager, dotfiles, ... }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs; 
          pkgs-23_11 = nixpkgs-23_11.legacyPackages.${system};
        };
        modules = [
          ./laptop/configuration.nix
          ./dotnet.nix
          ./packages.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.users.charlotte = import ./home.nix {
              config = self.nixosConfigurations.nixos-laptop.config;
              pkgs = self.nixosConfigurations.nixos-laptop.pkgs;
              inputs = inputs;
            };
          }
        ];
      };
    };
}
