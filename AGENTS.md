# AGENTS.md

Instructions for AI coding agents (Claude Code, Copilot, Codex, Cursor, Gemini CLI, ...) working in this repository.

## What This Repo Is

A Nix flake that manages this user's Nix configuration, structured after the [dendritic pattern](docs/DENDRITIC_PATTERNS.md). [flake.nix](flake.nix) is a thin entrypoint — it wires [flake-parts](https://flake.parts/) with [import-tree](https://github.com/denful/import-tree), which auto-imports every `.nix` file under [modules/](modules/) as a flake-parts module. The configuration grows feature-by-feature as dendritic aspects.

- Do **not** invent or scaffold a directory structure ahead of time. Follow the user's lead as they add pieces, and follow the dendritic conventions below when adding modules.
- When the flake gains outputs, verify changes with `nix flake check` and `nix build .#<output>` before committing. Format Nix (and Markdown, YAML, shell script) files with `nix fmt`, backed by [modules/formatter.nix](modules/formatter.nix).

## Documentation

For detailed guidance, see the modular documentation in `docs/`:

| File                                                | Description                                                                 |
| --------------------------------------------------- | --------------------------------------------------------------------------- |
| [DENDRITIC_PATTERNS.md](docs/DENDRITIC_PATTERNS.md) | Pattern explanation, how this repo wires it, aspects, hosts, sharing values |
| [ADDING_FEATURES.md](docs/ADDING_FEATURES.md)       | How modules work, adding new features, perSystem notes                      |
| [CONVENTIONS.md](docs/CONVENTIONS.md)               | Conventional Commits, Git hygiene, EditorConfig                             |
| [NIX_REFERENCE.md](docs/NIX_REFERENCE.md)           | Common commands, WSL usage, Nix resources                                   |
| [UPGRADES.md](docs/upgrades/UPGRADES.md)            | NixOS version targets, upgrade procedure, quirks                            |
| [ECOSYSTEM.md](docs/ECOSYSTEM.md)                   | Denful ecosystem tools and references                                       |

For a quick reference, see [CLAUDE.md](CLAUDE.md).

## License

This project is MIT-licensed — see [LICENSE.md](LICENSE.md).
