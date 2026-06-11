# Nix Config Repo

NixOS/nix-darwin configuration for two machines managed via flake.

## Machines

- `sleepy-turtle`: NixOS laptop (x86_64-linux), Hyprland desktop
- `MAC2022HJ49`: macOS work machine (aarch64-darwin), nix-darwin

## Key Commands

Switches are run via `nh`, which handles privilege elevation itself — do
**not** prefix with `sudo` (it elevates only the activation step and refuses to
run as root). The flake is resolved from `$NH_FLAKE`.

```bash
# Build and switch (NixOS)
nh os switch -H sleepy-turtle

# Build and switch (macOS)
nh darwin switch -H MAC2022HJ49

# Update flake inputs
nix flake update

# Check what will change (dry activation)
nh os switch -n -H sleepy-turtle
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
