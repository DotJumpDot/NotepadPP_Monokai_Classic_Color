# AGENTS.md

Guidance for AI agents (and humans) working in this repository.

## What this repo is

A Notepad++ colour theme (`DJD_Classic_Monokai.xml`) implementing the **classic Monokai palette** (Wimer Hazenberg), forked from mnmlize's "One Monokai". It also maintains companion **User Defined Languages (UDLs)** for file types Notepad++ has no lexer for (currently Path of Exile loot filters and dotenv/`.env`). Live on the maintainer's machine at `%AppData%\Notepad++\` — repo copies are the source of truth.

## Files

| File | Purpose |
| --- | --- |
| `DJD_Classic_Monokai.xml` | The theme itself (Notepad++ theme-XML format) |
| `DJD_PoE_Filter.udl.xml` | UDL for Path of Exile / PoE2 `.filter` loot filters, hardcoded to this palette |
| `DJD_Env.udl.xml` | UDL for dotenv `.env` files, hardcoded to this palette (keys red via DEFAULT-style trick, values green, quotes yellow — see State Changes §8) |
| `State Changes.md` | **Change log — update it for every change**, with numbered sections explaining what + why |
| `README.md` | User-facing install instructions + credits |
| `screenshot.png` | Shows the YAML styling (regenerating it requires manual Notepad++ screenshots) |

## Palette rules

Classic Monokai hexes used throughout; priority hierarchy is **red > orange > green > yellow**, background `272822`, default foreground `F8F8F2`:

| Role | Hex |
| --- | --- |
| Background / current line | `272822` / `3E3D32` |
| Foreground (default) | `F8F8F2` |
| Keywords, operators, structural tokens | `F92672` (red) |
| Type words, numbers | `FD971F` (orange) |
| Strings, "doing" tokens | `A6E22E` (green) |
| Regex / literal values | `E6DB74` (yellow) |
| Comments | `75715E` (olive, italic) |
| Cyan `66D9EF` | Chrome only (brace highlight, smart highlight) — intentionally **0 uses in lexer styles**. Documented exceptions: Markdown emphasis in the preinstalled UDL (user request), nothing else without a stated reason. |

## How Notepad++ colouring actually works (hard-won facts)

1. **Theme XML** (`themes\*.xml`) styles only the **built-in lexers** via `<LexerType>` blocks. `ext="..."` on a LexerType registers file extensions for that lexer.
2. **UDLs** (`userDefineLangs\*.xml`) are completely independent of themes — their colours are hardcoded in the UDL file (`colorStyle="1"` = use the style's own fg/bg and bypass the theme). If a file type is highlighted by a UDL, editing the theme cannot affect it.
3. **Markdown is a UDL**, not a lexer (Notepad++ ≥ 8.4.3): the preinstalled `markdown._preinstalled.udl.xml` (light mode) and `markdown._preinstalled_DM.udl.xml` (dark mode). The light one ships with navy `000080` emphasis — on this dark theme it must be changed to `66D9EF` (see State Changes §6; the file lives outside this repo in `%AppData%`, so reinstalls revert it).
4. The **active** styles live in `%AppData%\Notepad++\stylers.xml` — Notepad++ copies the selected theme into it when you pick a theme in Style Configurator. Editing a theme file does nothing until the theme is re-selected.
5. **Notepad++ caches themes/UDLs at startup.** Apply file edits only while Notepad++ is fully closed (check `tasklist`), then restart. Notepad++ also rewrites the installed theme file with its own normalization (extra substyles, changed header attrs) — never copy that normalized file back into the repo; diff should ignore it.
6. To find what's styling a token: check `stylers.model.xml` in the Notepad++ install dir for lexer defaults, `userDefineLangs\` for UDLs, and the theme for LexerType blocks. `grep` is your friend; the maintainer's Notepad++ is at `C:\Program Files\Notepad++`.

## Deployment (to the maintainer's machine)

- Theme → `%AppData%\Notepad++\themes\DJD_Classic_Monokai.xml`
- UDLs (`DJD_PoE_Filter.udl.xml`, `DJD_Env.udl.xml`) → `%AppData%\Notepad++\userDefineLangs\`
- Notepad++ must be restarted afterwards; Dark Mode must be **off** (config `DarkMode enable="no"`) — in Dark Mode Notepad++ switches to a different theme + the `_DM` Markdown UDL, which this repo doesn't manage.

## Conventions

- Log every change in `State Changes.md` as a new numbered section (what, why, exact hexes). This file is the repo's memory.
- Match the existing XML formatting of the theme file (attribute order, spacing) when editing it.
- UDL colour assignments follow the same hierarchy as the theme; UDL files carry a header comment documenting their colour map.
- Commits: single comprehensive commit with a summary-style message (see `git log` for the pattern). Push to `origin master`.
- `.gitattributes` forces LF in the theme XML; keep new XML files UTF-8.
