# Nix Reference

## Common Commands

```bash
# Build outputs
nix build .#<output-name>

# Check the flake
nix flake check

# Format all files
nix fmt

# Show flake metadata
nix flake metadata

# Build default output (usually the formatter)
nix build .
```

## Windows/WSL

If Nix is not available natively on Windows, use WSL:

```bash
# Start WSL (Ubuntu)
wsl

# Inside WSL, run Nix commands
nix build .#<output-name>
nix flake check
nix fmt

# Or from PowerShell/Bash, run WSL with command:
wsl nix build .#<output-name>
wsl nix flake check
wsl nix fmt
```

## Getting Oriented with Nix

If you need to ground answers in Nix documentation, prefer these official sources:

- [nix.dev](https://nix.dev) — concepts, tutorials, and patterns
- [Nix manual](https://nixos.org/manual/nix/unstable/) — the Nix language and `nix` CLI, including flakes
- [NixOS manual](https://nixos.org/manual/nixos/unstable/) — NixOS module system
- [Home Manager manual](https://nix-community.github.io/home-manager/) and [nix-darwin manual](https://nix-darwin.github.io/nix-darwin/manual/) — as those are added
- [Dendritic — Dendrix docs](https://dendrix.denful.dev/Dendritic.html) — the configuration pattern this repo follows

## License

This project is MIT-licensed — see [LICENSE.md](../LICENSE.md).

---

**See also:** [Dendritic Patterns](DENDRITIC_PATTERNS.md) · [Adding Features](ADDING_FEATURES.md) · [Version Policy](upgrades/UPGRADES.md) · [Glossary](GLOSSARY.md)
