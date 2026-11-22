# AGENTS.md

Instructions for AI coding agents (Claude Code, Copilot, Codex, Cursor, Gemini CLI, ...) working in this repository.

## What this repo is

A Nix flake that manages this user's Nix configuration. It is intentionally minimal right now — [flake.nix](flake.nix) contains only an empty outputs attribute as a starting point, and the structure (hosts, modules, packages, etc.) will emerge as the configuration grows.

- Do **not** invent or scaffold a directory structure ahead of time. Follow the user's lead as they add pieces.
- When the flake gains outputs, verify changes with `nix flake check` and `nix build .#<output>` before committing. Format Nix files with `nix fmt` once a formatter is configured.

## Conventions

### Conventional Commits

All commit messages MUST follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<optional scope>): <description>
```

Allowed types:

| Type | Purpose |
| --- | --- |
| `feat` | New configuration feature or module |
| `fix` | Bug fix in the configuration |
| `chore` | Maintenance (lock file updates, repo housekeeping) |
| `docs` | Documentation changes |
| `refactor` | Restructuring without behavior change |
| `style` | Formatting changes |
| `test` | Adding or changing checks/tests |
| `perf` | Performance-related changes |
| `build` | Build system or flake input changes |
| `ci` | CI configuration changes |

Examples from this repo's history:

- `chore: initialize Nix configuration`
- `chore: rename LICENSE to LICENSE.md`

Keep the description lowercase and imperative, and omit the scope unless it adds clarity (e.g. `feat(home-manager): add git config module`).

### Git hygiene

- Never add editor- or system-specific entries to [.gitignore](.gitignore) — those belong in the user's global gitignore at `$XDG_CONFIG_HOME/git/ignore` (see the note at the top of that file).

## Getting oriented with Nix

If you need to ground answers in Nix documentation, prefer these official sources:

- [nix.dev](https://nix.dev) — concepts, tutorials, and patterns
- [Nix manual](https://nixos.org/manual/nix/unstable/) — the Nix language and `nix` CLI, including flakes
- [NixOS manual](https://nixos.org/manual/nixos/unstable/) — NixOS module system
- [Home Manager manual](https://nix-community.github.io/home-manager/) and [nix-darwin manual](https://nix-darwin.github.io/nix-darwin/manual/) — as those are added

## License

This project is MIT-licensed — see [LICENSE.md](LICENSE.md).
