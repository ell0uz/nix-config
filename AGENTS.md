# AGENTS.md

Instructions for AI coding agents (Claude Code, Copilot, Codex, Cursor, Gemini CLI, ...) working in this repository.

## What this repo is

A Nix flake that manages this user's Nix configuration, structured after the [dendritic pattern](#dendritic-configuration-pattern). [flake.nix](flake.nix) is a thin entrypoint — it wires [flake-parts](https://flake.parts/) with [import-tree](https://github.com/vic/import-tree), which auto-imports every `.nix` file under [modules/](modules/) as a flake-parts module. The configuration grows feature-by-feature as dendritic aspects.

- Do **not** invent or scaffold a directory structure ahead of time. Follow the user's lead as they add pieces, and follow the dendritic conventions below when adding modules.
- When the flake gains outputs, verify changes with `nix flake check` and `nix build .#<output>` before committing. Format Nix files with `nix fmt` once a formatter is configured.

## Dendritic configuration pattern

[Dendritic](https://dendrix.denful.dev/Dendritic.html) is a configuration *pattern* — a way of doing things, not a library or framework. It is aspect-oriented: configuration is organized around cross-cutting features ("aspects") rather than hosts, built on flake-parts' `flake.modules` option. [denful.dev](https://denful.dev) is the home of the ecosystem around it.

### How this repo wires it

- [flake.nix](flake.nix) calls `mkFlake` with `inputs.import-tree ./modules` — every `.nix` file under `modules/` is loaded automatically as a flake-parts module. Keep `flake.nix` minimal: dependency manifest and entrypoint only, with logic in modules.
- [modules/systems.nix](modules/systems.nix) sets the supported `systems`. Nothing else in the repo is special — the structure emerges from the aspect files.

### Aspects

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

### Hosts

- Host modules are thin registries: a file defines `flake.nixosConfigurations.<name>` (or `flake.darwinConfigurations.<name>`) and imports aspects **by name** from `inputs.self.modules.<class>`, not by file path:

  ```nix
  # modules/hosts.nix
  { inputs, ... }: {
    flake.nixosConfigurations.my-host = inputs.nixpkgs.lib.nixosSystem {
      modules = with inputs.self.modules.nixos; [
        ssh
        fonts
      ];
    };
  }
  ```

- Importing by name (rather than path) means files can be moved and reorganized without breaking references.

### Sharing values

- Within a file, use `let` bindings.
- Across files, prefer flake-parts options or a constants aspect in a `generic` class. Prefer avoiding `specialArgs`/`extraSpecialArgs` — it is the pattern's known anti-pattern, and modules already receive `inputs`.
- A nixos aspect that has a home-manager half wires it through `home-manager.sharedModules`:

  ```nix
  flake.modules.nixos.sway = {
    programs.sway.enable = true;
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.sway
    ];
  };
  ```

### perSystem and practical notes

- Packages, devshells, and checks go in `perSystem` blocks inside the aspect files that own them; [modules/systems.nix](modules/systems.nix) controls which systems they are evaluated for.
- `import-tree` skips any path containing `/_` — use that for partial or library files that should not be auto-imported.
- Do not gate `imports` lists with conditionals; Nix evaluates them unconditionally. If configurability is needed, expose a flake-parts option instead.
- Keep non-Nix files that support a feature (templates, scripts) next to it — `import-tree` only loads `.nix` files, so they are harmless there.
- Make cross-aspect data flow explicit through flake-parts options rather than implicit coupling.

### denful ecosystem

The hand-rolled pattern above needs only `flake-parts` and `import-tree` (already inputs). As the configuration grows, reach for denful tooling when it becomes limiting — do not add these preemptively:

| Project | What it does |
| --- | --- |
| [den](https://github.com/denful/den) | Context-aware configuration framework with declarative pipelines and schemas for host and user configuration |
| [flake-aspects](https://github.com/denful/flake-aspects) | Zero-dependency aspect composition; transposes `aspect.class` into standard Nix module layouts |
| [flake-file](https://github.com/denful/flake-file) | Generates `flake.nix` from typed Nix modules |
| [dendrix](https://github.com/denful/dendrix) | Community-driven distribution of dendritic configurations |

### References

- [Dendritic — Dendrix docs](https://dendrix.denful.dev/Dendritic.html) — the canonical statement of the pattern
- [Exploring the Dendritic Nix Pattern](https://britter.dev/blog/2026/05/11/exploring-the-dendritic-nix-pattern/) — practical walkthrough with worked examples
- [denful.dev](https://denful.dev) — ecosystem overview

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

### Detailed Conventional Commits Guidelines

All commit messages MUST follow the [Conventional Commits 1.0.0 specification](https://www.conventionalcommits.org/en/v1.0.0/), which standardises the format and meaning of commit messages. Below is a detailed breakdown of the rules and structure.

#### Commit Message Structure

A conventional commit message has the following structure:

```
<type>[optional scope]: <description>

[optional body]

[optional footer]
```

1. **Type** (required): A lowercase keyword indicating the *nature* of the change. Allowed types in this repo:
   - `feat`: New features or enhancements
   - `fix`: Bug fixes
   - `docs`: Documentation changes
   - `refactor`: Code restructuring without functional changes
   - `style`: Formatting, whitespace, or code style changes
   - `test`: Adding or modifying tests
   - `chore`: Maintenance tasks (e.g., updating lock files, repo housekeeping)
   - `perf`: Performance improvements
   - `build`: Build system or external dependency changes
   - `ci`: CI/CD pipeline changes

2. **Scope** (optional): A hyphen-separated lowercase identifier (e.g., `home-manager`, `nixos`) added in parentheses after the type if the change affects a specific part of the system. Omit if the change is general.

3. **Description** (required): A concise, lowercase, imperative sentence summarising the change. Start with a verb (e.g., "add", "fix", "update"). Max 72 characters.

4. **Body** (optional): A detailed explanation of *why* the change was made, ideally in a new paragraph starting with "Why:". Use bullet points for lists. Wrap at 72 characters.

5. **Footer** (optional): Metadata like:
   - `Closes: #123` or `Fixes: #123` to link issues
   - `BREAKING CHANGE: description` for backwards-incompatible changes (forces a major version bump)
   - `Co-authored-by: Name <email>` for collaborative commits

#### Core Rules

- **Lowercase everything**: Types, scopes, descriptions, and body text must be lowercase (except URLs, code, or proper nouns in footers).
- **Imperative mood**: Write descriptions as commands (e.g., "add config module", not "added config module").
- **No trailing punctuation**: Avoid periods or other punctuation at the end of the description.
- **Wrap lines**: Hard-wrap the body and footer at 72 columns.
- **Separate body paragraphs**: Use a blank line between paragraphs in the body.
- **Breaking changes**: Mention them explicitly in the footer, not just the description.

#### Examples

**Valid commits**:

```
feat(home-manager): add git config module
```

```
fix: correct path for nix-darwin configuration

Why: The previous path assumed a Linux structure, breaking macOS builds.
```

```
chore: update flake.lock

Why: Resolve dependency conflicts after adding a new package.
```

**Invalid commits**:

```
Feat: Add New Feature (wrong case, punctuation)
```

```
fix(scope): description with capital letters (scope must be lowercase)
```

```
refactor: some changes. (trailing punctuation)
```

#### Why follow this spec?

- Enables automated tools to generate changelogs and version bumps (using `convco` or similar).
- Makes git history skimmable and consistent across contributors.
- Explicitly flags breaking changes for consumers of the configuration.

For the full specification, see [conventionalcommits.org](https://www.conventionalcommits.org/en/v1.0.0/).


### Git hygiene

- Never add editor- or system-specific entries to [.gitignore](.gitignore) — those belong in the user's global gitignore at `$XDG_CONFIG_HOME/git/ignore` (see the note at the top of that file).

### EditorConfig

This repository uses [EditorConfig](https://editorconfig.org/) for consistent formatting across editors and IDEs. The [.editorconfig](.editorconfig) file defines:

- **Line endings**: LF (Unix-style) for cross-platform compatibility
- **Indentation**: 2 spaces for Nix, Markdown, JSON, and shell scripts
- **Trailing whitespace**: Trimmed for code files; preserved for Markdown (where 2+ trailing spaces create hard line breaks)
- **Final newline**: Added to all text files except JSON/lock files (where it's not required)
- **Character encoding**: UTF-8

Editors with EditorConfig support (VS Code, IntelliJ, Vim, Emacs, etc.) will automatically apply these settings. No additional tooling is required.

## Getting oriented with Nix

If you need to ground answers in Nix documentation, prefer these official sources:

- [nix.dev](https://nix.dev) — concepts, tutorials, and patterns
- [Nix manual](https://nixos.org/manual/nix/unstable/) — the Nix language and `nix` CLI, including flakes
- [NixOS manual](https://nixos.org/manual/nixos/unstable/) — NixOS module system
- [Home Manager manual](https://nix-community.github.io/home-manager/) and [nix-darwin manual](https://nix-darwin.github.io/nix-darwin/manual/) — as those are added
- [Dendritic — Dendrix docs](https://dendrix.denful.dev/Dendritic.html) — the configuration pattern this repo follows

## License

This project is MIT-licensed — see [LICENSE.md](LICENSE.md).
