# AtomicMegaNerd's NixOS Flake

This is my core flake for my NixOS machines as well as any other machines that
use Nix as a package manager.

Right now we have one host:

- blahaj

## Run OS Upgrade

Run the build against the host that you are interested in:

```bash
sudo nixos-rebuild switch --flake .#
```

## Run Home-Manager Upgrade

```bash
home-manager switch -- flake .#USERNAME
```

## Next Steps

- [ ] Get this working on my Mac
- [ ] Merge this with my core dotfiles repo so I have 1 repo for all my
      configurations regardless of OS.
