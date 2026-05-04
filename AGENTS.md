# Nix Config Repo

NixOS/nix-darwin configuration for two machines managed via flake.

## Machines

- `sleepy-turtle`: NixOS laptop (x86_64-linux), Hyprland desktop
- `MAC2022HJ49`: macOS work machine (aarch64-darwin), nix-darwin

## Key Commands

```bash
# Build and switch (NixOS)
sudo nixos-rebuild switch --flake .#sleepy-turtle

# Build and switch (macOS)
darwin-rebuild switch --flake .#MAC2022HJ49

# Update flake inputs
nix flake update

# Check what will change
nixos-rebuild dry-activate --flake .#sleepy-turtle
```

## Structure

- `flake.nix`: Entry point, defines both machines and imports
- `hosts/<name>/`: Per-machine NixOS/nix-darwin config and home.nix
- `user-config/`: Shared home-manager modules (neovim, git, hyprland, etc.)
- `secrets/`: SOPS-encrypted secrets (git credentials)
- `user-config/files/`: Static assets (scripts, CSS)

## Secrets

Secrets are encrypted with `sops-nix` using age. Files in `secrets/` are encrypted - do not edit directly. To decrypt locally for viewing:

```bash
sops -d secrets/git-config
```

The age key is stored in `~/.config/sops/age/keys.txt` on each machine.

## User Config Modules

Both machines import from `user-config/`. Key modules:
- `neovim.nix`: Neovim with LSP, cmp, treesitter (reads `neovim/*.lua` files)
- `git.nix`: Git config with aliases and includes for sops secrets
- `zsh.nix`: Zsh config with vi keymap, starship prompt

## Style

- 2-space indents in Nix files
- Prefer `with pkgs;` over explicit `pkgs.` prefix in package lists
- Use `lib.mkForce`, `lib.mkIf` for conditional overrides
