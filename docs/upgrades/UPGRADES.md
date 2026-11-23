# NixOS Version Policy

## Current Target

- **Version**: 26.11 (or current nixpkgs branch)
- **Branch**: `nixos-unstable` (tracking via flake input)

## Upgrade Procedure

1. Update `nixpkgs` input in `flake.nix`
1. Run `nix flake update nixpkgs`
1. Test with `nix flake check` and `nix build .#<host>`
1. Check for breaking changes in [NixOS release notes](https://nixos.org/manual/nixos/stable/index.html#sec-upgrading)
1. Update this document with any new quirks

## Known Quirks by Version

### 26.11

- [ ] Document any module renames, option changes, etc.

### 24.11

- [ ] Historical reference

## Version-Aware Aspects

When creating aspects that need version-specific config, use the pattern in \[Dendritic Patterns\](../DENDRITIC_PATTERNS.md#Sharing Values):

```nix
# modules/nixos-version.nix
{ inputs, pkgs, lib, ... }: {
  flake.modules.nixos.nixos-version = {
    options.nixos-version = lib.mkOption {
      type = lib.types.str;
      default = "26.11";
    };
    config = lib.mkIf (cfg.nixos-version == "26.11") {
      # version-specific config
    };
  };
}
```

Hosts select version via `specialArgs` or flake-parts options.

---

**See also:** [Dendritic Patterns](../DENDRITIC_PATTERNS.md) · [Adding Features](../ADDING_FEATURES.md) · [Glossary](../GLOSSARY.md)
