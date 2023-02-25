{
  description = "AtomicMegaNerd Core Nix Flake";

  inputs = {
    # NixOS stable and unstable sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager sources
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      pkgs-linux = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      unstable-linux = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {

      # Nix OS core configuration
      nixosConfigurations = {
        blahaj = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./blahaj/configuration.nix
          ];
        };
      };

      # Home Manager configuration
      homeConfigurations = {
        useGlobalPkgs = true;
        useUserPackages = true;
        "rcd@blahaj" = home-manager.lib.homeManagerConfiguration {
          pkgs-linux = unstable-linux;
          modules = [ ./blahaj/rcd.nix ];
        };
        "root@blahaj" = home-manager.lib.homeManagerConfiguration {
          pkgs-linux = unstable-linux;
          modules = [ ./blahaj/rcd.nix ];
        };
      };
    };
}
