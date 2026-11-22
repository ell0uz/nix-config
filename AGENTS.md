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

## Getting oriented with Nix

If you need to ground answers in Nix documentation, prefer these official sources:

- [nix.dev](https://nix.dev) — concepts, tutorials, and patterns
- [Nix manual](https://nixos.org/manual/nix/unstable/) — the Nix language and `nix` CLI, including flakes
- [NixOS manual](https://nixos.org/manual/nixos/unstable/) — NixOS module system
- [Home Manager manual](https://nix-community.github.io/home-manager/) and [nix-darwin manual](https://nix-darwin.github.io/nix-darwin/manual/) — as those are added

## License

This project is MIT-licensed — see [LICENSE.md](LICENSE.md).
