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
      system = "x86_64-linux";
      # 22.11 Stable
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      # Unstable
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations = {
        useGlobalPkgs = true;
        useUserPackages = true;
        "rcd" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./blahaj/rcd.nix ];
          extraSpecialArgs = {
            inherit unstable;
          };
        };
      };
      nixosConfigurations = {
        blahaj = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./blahaj/configuration.nix
          ];
        };
      };
    };
}
