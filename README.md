# AtomicMegaNerd's NixOS Flake

This is my core flake for my Nix-managed machines as well as any other machines that
use Nix as a package manager.

Right now we have two hosts:

| Host      | OS    | Platform      |
|-----------|-------|---------------|
| blahaj    | NixOS | x86-64-linux  |
| discovery | MacOS | arch64-darwin |

## Run OS Upgrade

Run the build against the host that you are interested in. This only applies to
NixOS machines:

```bash
sudo nixos-rebuild switch --flake .#
```

## Run Home-Manager Upgrade

We use home-manager on all of our Nix managed machines.

```bash
home-manager switch -- flake .#USERNAME@HOST
```
