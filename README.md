# AtomicMegaNerd's NixOS Flake

This is my core flake for my NixOS machines.

Right now we have two hosts:

- spork
- blahaj

## Run the Host Flake Build

Run the build against the host that you are interested in:

```bash
sudo nixos-rebuild switch --flake .#<HOSTNAME>
```
