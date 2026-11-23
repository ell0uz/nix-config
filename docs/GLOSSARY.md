# Glossary

## Core Nix Concepts

| Term              | Definition                                                                       |
| ----------------- | -------------------------------------------------------------------------------- |
| **Flake**         | A reproducible Nix project with locked dependencies (`flake.nix` + `flake.lock`) |
| **flake.nix**     | Entry point defining inputs, outputs, and configuration                          |
| **flake.lock**    | Locked input revisions for reproducibility                                       |
| **nixpkgs**       | The Nix package collection; also provides NixOS modules                          |
| **nixosSystem**   | Function to build a NixOS configuration from modules                             |
| **homeManager**   | User-level configuration manager (dotfiles, packages, services)                  |
| **nix-darwin**    | NixOS-like module system for macOS                                               |
| **derivation**    | The build recipe Nix evaluates to produce a store path                           |
| **store path**    | Immutable path in `/nix/store/<hash>-<name>`                                     |
| **evaluation**    | Nix language interpretation phase (before building)                              |
| **instantiation** | Converting a derivation to a `.drv` file                                         |
| **realisation**   | Building/substituting a derivation to produce output                             |

## Flake-Parts Concepts

| Term                           | Definition                                                                     |
| ------------------------------ | ------------------------------------------------------------------------------ |
| **flake-parts**                | Library for structuring flakes with standardized outputs                       |
| **mkFlake**                    | Main flake-parts function: `inputs.flake-parts.lib.mkFlake`                    |
| **perSystem**                  | Block evaluated for each supported system (x86_64-linux, aarch64-darwin, etc.) |
| **flake.modules**              | Namespace for aspect modules: `flake.modules.nixos.<aspect>`                   |
| **flake.nixosConfigurations**  | Output: NixOS host configurations                                              |
| **flake.darwinConfigurations** | Output: nix-darwin host configurations                                         |
| **flake.homeConfigurations**   | Output: Home Manager user configurations                                       |
| **flake.packages**             | Output: Per-system packages                                                    |
| **flake.devShells**            | Output: Per-system development shells                                          |
| **flake.checks**               | Output: Per-system CI checks (e.g., formatting)                                |
| **flake.formatter**            | Output: Formatter derivation (treefmt)                                         |

## Dendritic Pattern Terms

| Term               | Definition                                                                                                     |
| ------------------ | -------------------------------------------------------------------------------------------------------------- |
| **Aspect**         | A cross-cutting feature/concern (e.g., `ssh`, `fonts`, `sway`) — one file per capability                       |
| **Aspect module**  | File under `modules/` registering `flake.modules.<class>.<aspect>`                                             |
| **Class**          | Configuration target: `nixos`, `darwin`, `homeManager`, `generic`, or custom                                   |
| **Host module**    | File defining `flake.nixosConfigurations.<name>` importing aspects by name                                     |
| **Import by name** | `with inputs.self.modules.nixos; [ ssh fonts ]` — not by file path                                             |
| **Auto-import**    | `import-tree` loads every `.nix` under `modules/` as a flake-parts module                                      |
| **Activation**     | Aspects take effect only when imported by a host, not via `enable = true`                                      |
| **Generic class**  | Shared constants/options via `flake.modules.generic.<name>`                                                    |
| **Shared modules** | Wiring nixos + homeManager halves: `home-manager.sharedModules = [ inputs.self.modules.homeManager.<aspect> ]` |

## Your Repo Structure

| Term                      | Definition                                                                                           |
| ------------------------- | ---------------------------------------------------------------------------------------------------- |
| **modules/**              | Directory auto-imported by `import-tree` — one `.nix` per aspect                                     |
| **modules/systems.nix**   | Defines `systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ]`                              |
| **modules/formatter.nix** | Configures treefmt (nixfmt, mdformat, prettier, shfmt)                                               |
| **flake.nix**             | Thin entrypoint: `inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)` |

## Denful Ecosystem

| Term                   | Definition                                                                       |
| ---------------------- | -------------------------------------------------------------------------------- |
| **den**                | Configuration framework with declarative pipelines & schemas                     |
| **flake-aspects**      | Zero-dep aspect composition; transposes `aspect.class` → standard module layouts |
| **flake-file**         | Generates `flake.nix` from typed Nix modules                                     |
| **dendrix**            | Community distribution of dendritic configurations (pre-built aspects)           |
| **dendrix.denful.dev** | Documentation site for the dendritic pattern                                     |

## Version & Upgrade Terms

| Term                     | Definition                                                               |
| ------------------------ | ------------------------------------------------------------------------ |
| **NixOS version**        | Major.minor release (e.g., `26.11`, `25.05`)                             |
| **nixos-unstable**       | Rolling branch tracking latest nixpkgs                                   |
| **nixos-<version>**      | Stable branch (e.g., `nixos-26.11`)                                      |
| **flake input**          | External dependency (nixpkgs, flake-parts, import-tree, etc.)            |
| **flake update**         | `nix flake update <input>` — updates lock file to latest                 |
| **Version-aware aspect** | Aspect using `lib.mkIf` on `nixos-version` option for conditional config |

## Git & Workflow

| Term                     | Definition                                                                                        |
| ------------------------ | ------------------------------------------------------------------------------------------------- |
| **Conventional Commits** | `<type>(<scope>): <description>` — feat, fix, chore, docs, refactor, style, test, perf, build, ci |
| **treefmt**              | Multi-language formatter runner (configured in `modules/formatter.nix`)                           |
| **nix fmt**              | Runs treefmt on all tracked files                                                                 |
| **nix flake check**      | Evaluates all flake outputs + runs checks (formatter, tests)                                      |

## Common Commands

| Command                    | Purpose                           |
| -------------------------- | --------------------------------- |
| `nix build .#<output>`     | Build a flake output              |
| `nix build .`              | Build default output (formatter)  |
| `nix flake check`          | Full flake validation             |
| `nix flake metadata`       | Show flake info (inputs, outputs) |
| `nix flake update <input>` | Update a locked input             |
| `nix fmt`                  | Format all files via treefmt      |
| `wsl nix <cmd>`            | Run Nix via WSL on Windows        |

---

**See also:** [DENDRITIC_PATTERNS.md](DENDRITIC_PATTERNS.md) · [ADDING_FEATURES.md](ADDING_FEATURES.md) · [UPGRADES.md](upgrades/UPGRADES.md)
