# Denful Ecosystem

The hand-rolled pattern above needs only `flake-parts` and `import-tree` (already inputs). As the configuration grows, reach for denful tooling when it becomes limiting — do not add these preemptively:

| Project                                                  | What it does                                                                                                 |
| -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| [den](https://github.com/denful/den)                     | Context-aware configuration framework with declarative pipelines and schemas for host and user configuration |
| [flake-aspects](https://github.com/denful/flake-aspects) | Zero-dependency aspect composition; transposes `aspect.class` into standard Nix module layouts               |
| [flake-file](https://github.com/denful/flake-file)       | Generates `flake.nix` from typed Nix modules                                                                 |
| [dendrix](https://github.com/denful/dendrix)             | Community-driven distribution of dendritic configurations                                                    |

---

## References

- [Dendritic — Dendrix docs](https://dendrix.denful.dev/Dendritic.html) — the canonical statement of the pattern
- [Exploring the Dendritic Nix Pattern](https://britter.dev/blog/2026/05/11/exploring-the-dendritic-nix-pattern/) — practical walkthrough with worked examples
- [denful.dev](https://denful.dev) — ecosystem overview

---

**See also:** [Dendritic Patterns](DENDRITIC_PATTERNS.md) · [Adding Features](ADDING_FEATURES.md)
