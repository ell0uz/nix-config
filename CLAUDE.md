# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Nix flake configuration using the **dendritic configuration pattern** - a feature-oriented, aspect-based approach to managing Nix configurations. See [AGENTS.md](AGENTS.md) for detailed documentation.

## Architecture

### Key Concepts

**Dendritic Pattern**: Configuration is organized around cross-cutting features ("aspects") rather than hosts. Each feature is its own file under `modules/`.

**Auto-import**: [import-tree](https://github.com/denful/import-tree) automatically loads every `.nix` file under `modules/` as a flake-parts module.

**Aspects**: One file per feature/concern (e.g., `ssh.nix`, `fonts.nix`), not per tool or per-host.

### File Structure

```
flake.nix          # Entrypoint - flake-parts + import-tree wiring only
modules/
  systems.nix      # Supported systems: x86_64-linux, aarch64-linux, aarch64-darwin
  formatter.nix    # Code formatting (nixfmt, mdformat, prettier, shfmt)
```

### How Modules Work

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

### Windows/WSL

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

## Adding New Features

1. Create a new aspect file in `modules/` (e.g., `modules/ssh.nix`)
2. Define your aspect in `flake.modules.<class>` for each class you support
3. Import the aspect in host configurations by name: `[ inputs.self.modules.nixos.ssh ]`

## Commit Messages

All commits follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>
```

Types: `feat`, `fix`, `chore`, `docs`, `refactor`, `style`, `test`, `perf`, `build`, `ci`

Example: `feat(home-manager): add git config module`

## Formatting

Files are formatted using treefmt (configured in `modules/formatter.nix`):
- `nixfmt` for Nix files
- `mdformat` for Markdown
- `prettier` for YAML/JSON
- `shfmt` for shell scripts

Run `nix fmt` to format all files.