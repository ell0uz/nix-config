# Dendritic Configuration Pattern

[Dendritic](https://dendrix.denful.dev/Dendritic.html) is a configuration _pattern_ — a way of doing things, not a library or framework. It is aspect-oriented: configuration is organized around cross-cutting features ("aspects") rather than hosts, built on flake-parts' `flake.modules` option. [denful.dev](https://denful.dev) is the home of the ecosystem around it.

## How This Repo Wires It

- [flake.nix](../flake.nix) calls `mkFlake` with `inputs.import-tree ./modules` — every `.nix` file under `modules/` is loaded automatically as a flake-parts module. Keep `flake.nix` minimal: dependency manifest and entrypoint only, with logic in modules.
- [flake.nix](flake.nix) defines `systems` directly in `mkFlake`. Nothing else in the repo is special — the structure emerges from the aspect files.

## Aspects

- Default to one feature or concern per file, named after the capability rather than the tool or host (e.g. `ssh.nix`, `fonts.nix`, not `openssh-config.nix` or `my-laptop.nix`).

- A file may contribute the same aspect to several configuration **classes** — `nixos`, `darwin`, `homeManager`, or custom classes — by registering each under `flake.modules.<class>.<aspect>`:

  ```nix
  # modules/ssh.nix
  { inputs, ... }: {
    flake.modules.nixos.ssh = { ... };
    flake.modules.homeManager.ssh = { ... };
  }
  ```

- Features activate by being imported, not by `enable = true` flags. An aspect only takes effect when a host (or another module) imports it.

## Hosts

- Host modules define `flake.nixosConfigurations.<name>` (or `flake.darwinConfigurations.<name>`) and import aspects via `config.flake.modules`:

  ```nix
  # modules/hosts.nix
  { config, inputs, lib, ... }:
  let
    nixosModules = builtins.attrValues (config.flake.modules.nixos or {});
  in {
    flake.nixosConfigurations.my-host = inputs.nixpkgs.lib.nixosSystem {
      modules = with nixosModules; [
        ssh
        fonts
      ];
    };
  }
  ```

- Importing via `config.flake.modules` avoids infinite recursion that would occur with `inputs.self.modules` (circular dependency).

## Sharing Values

- Within a file, use `let` bindings.

- Across files, prefer flake-parts options or a constants aspect in a `generic` class. Prefer avoiding `specialArgs`/`extraSpecialArgs` — it is the pattern's known anti-pattern, and modules already receive `inputs`.

- A nixos aspect that has a home-manager half wires it through `home-manager.sharedModules`:

  ```nix
  flake.modules.nixos.sway = {
    programs.sway.enable = true;
    home-manager.sharedModules = [
      # Import aspect by name via flake.modules
      # (accessed in hosts.nix via config.flake.modules.homeManager)
    ];
  };
  ```

- Aspects are auto-imported by import-tree, so references can use the module name directly when combined with `builtins.attrValues config.flake.modules.<class>` in hosts.nix.

---

**See also:** [Adding Features](ADDING_FEATURES.md) · [Ecosystem](ECOSYSTEM.md) · [Version Policy](upgrades/UPGRADES.md) · [Glossary](GLOSSARY.md)
