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

## Next Steps

There is some code repetition happening here (for example the neovim config).
I want to better learn how Nix works so I can refactor that out.

I also want to get this working on my personal and my work Mac.
