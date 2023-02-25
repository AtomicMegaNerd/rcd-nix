{
  description = "AtomicMegaNerd Core Nix Flake";

  inputs = {
    # We are going to use both stable and unstable packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      # 22.11 Stable
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      # Unstable
      unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      # Home Manager configuration
      homeConfigurations = {
        useGlobalPkgs = true;
        useUserPackages = true;
        "rcd@blahaj" = home-manager.lib.homeManagerConfiguration {
          pkgs = unstable;
          modules = [ ./blahaj/rcd.nix ];
        };
        "root@blahaj" = home-manager.lib.homeManagerConfiguration {
          pkgs = unstable;
          modules = [ ./blahaj/rcd.nix ];
        };
      };
      # Nix OS core configuration
      nixosConfigurations = {
        blahaj = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./blahaj/configuration.nix
          ];
        };
      };
    };
}
