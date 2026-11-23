# Adding Features

## How Modules Work

- **Aspect modules** (e.g., `modules/ssh.nix`) contribute to configuration classes:

  ```nix
  { inputs, ... }: {
    flake.modules.nixos.ssh = { ... };
    flake.modules.homeManager.ssh = { ... };
  }
  ```

- **Host modules** import aspects by name from `inputs.self.modules.<class>`:

  ```nix
  flake.nixosConfigurations.my-host = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.modules.nixos; [ ssh fonts ];
  };
  ```

## Adding New Features

1. Create a new aspect file in `modules/` (e.g., `modules/ssh.nix`)
1. Define your aspect in `flake.modules.<class>` for each class you support
1. Import the aspect in host configurations by name: `[ inputs.self.modules.nixos.ssh ]`

## perSystem and Practical Notes

- Packages, devshells, and checks go in `perSystem` blocks inside the aspect files that own them; [modules/systems.nix](../modules/systems.nix) controls which systems they are evaluated for.
- `import-tree` skips any path containing `/_` — use that for partial or library files that should not be auto-imported.
- Do not gate `imports` lists with conditionals; Nix evaluates them unconditionally. If configurability is needed, expose a flake-parts option instead.
- Keep non-Nix files that support a feature (templates, scripts) next to it — `import-tree` only loads `.nix` files, so they are harmless there.
- Make cross-aspect data flow explicit through flake-parts options rather than implicit coupling.

---

**See also:** [Dendritic Patterns](DENDRITIC_PATTERNS.md) · [Ecosystem](ECOSYSTEM.md) · [Conventions](CONVENTIONS.md) · [Version Policy](upgrades/UPGRADES.md)
