{
  description = "AtomicMegaNerd Core Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        spork = lib.nixosSystem {
          inherit system;
          modules = [ ./spork/configuration.nix ];
        };
        blahaj = lib.nixosSystem {
          inherit system;
          modules = [ ./blahaj/configuration.nix ];
        };
      };
    };
}
