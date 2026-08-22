# State Changes

What was edited in this fork of mnmlize's **One Monokai** Notepad++ theme, and why.

## 1. Renamed the theme

| Before | After |
| --- | --- |
| `One Monokai.xml` | `DJD_Classic_Monokai.xml` |
| Header: `One Monokai - v2.0.0` | Header: `DJD Classic Monokai - v2.0.0` |
| Install step: `Select One Monokai from the theme drop-down box` | `Select DJD Classic Monokai from the theme drop-down box` |
| XML scaffolding version tag | `v2.0.0` |

The fork is now associated with `DotJumpDot/NotepadPP_Monokai_Classic_Color` instead of the upstream `mnmlize/npp-one-monokai-theme`. Notepad++'s Style Configurator reads the theme name from the file contents, so every reference was updated for consistency.

## 2. Re-themed to actual classic Monokai

The original "One Monokai" is really a **One Dark** palette with cyan keywords. Every colour was replaced with Wimer Hazenberg's classic Monokai palette so the theme looks like the real Monokai, not the blue "Monokai-but-actually-One-Dark" look.

| Role | Before (One Dark) | After (classic Monokai) |
| --- | --- | --- |
| Background | `282C34` | `272822` |
| Foreground | `E3E7F0` | `F8F8F2` |
| Identifier / light blue text | `ABB2BF` | `F8F8F2` |
| Comment | `646C7C` | `75715E` |
| Keywords / tags / classes (was cyan) | `56B6C2` | `F92672` (pink) |
| Strings (was mustard) | `E5C07B` | `A6E22E` (green) |
| Numbers (was bluish purple) | `C678DD` | `AE81FF` (Monokai purple) |
| Constants / special (was yellow) | `F1E309` | `E6DB74` (Monokai yellow) |
| Type words / attributes (was cyan) | `56B6C2` | `66D9EF` (Monokai cyan) |
| Function / date accent (was light green) | `9AC57B` / `9DF39F` | `A6E22E` |
| Section / label / tag accent (was salmon) | `E46972` | `F92672` |

These substitutions were applied per `WordsStyle` across all 47 lexers (C, C++, Java, C#, RC, TCL, Objective-C, SQL, HTML, PHP, JavaScript, ASP, XML, INI, Properties, DIFF, NFO, Makefile, VB, CSS, Pascal, Perl, Python, Batch, Lua, TeX, NSIS, ActionScript, Bash, Fortran, Fortran77, LISP, ASM, Ruby, PostScript, VHDL, Smalltalk, Caml, Verilog, KiXtart, AutoIt, ADA, Matlab, Haskell, InnoSetup, CMake, SearchResult).

### Global styles

The chrome (caret, selection, current line, fold margin, indent guides, mark styles, smart-highlighting, search-result header / file header / line number / hit word / selected line) was also repainted on the new palette:

- `Global override` and `Default Style` use `F8F8F2` on `272822`.
- Current-line background: `3E3D32` (Monokai darker olive), foreground `F92672`.
- Brace highlight: `66D9EF` bold.
- Bad brace colour: `F92672`.
- Selected text: `49483E` on `F8F8F2`.
- Indent guideline / edge colour / fold margin: `3E3D32` on `272822`.
- Line-number margin: `75715E` (Monokai comment olive).
- Mark styles 1-5 use the full accent set: `F8F8F2 / A6E22E / E6DB74 / AE81FF / F92672`.
- Search-result `Hit Word` keeps the pink-on-yellow legacy look (`E6DB74` on `F92672`).

## 3. Added YAML support

A brand new `<LexerType name="yaml" desc="YAML" ext="yml yaml">` block was inserted, registering both `.yml` and `.yaml` extensions with the Scintilla YAML lexer and applying the Monokai palette to every token.

| StyleID | Token | Colour | Notes |
| --- | --- | --- | --- |
| 0 | DEFAULT | `F8F8F2` | plain text |
| 1 | COMMENT | `75715E` | italic, comments start with `#` |
| 2 | IDENTIFIER | `66D9EF` | map keys |
| 3 | KEYWORD | `F92672` | `true false yes no on off null ~` (all-caps variants included) |
| 4 | NUMBER | `AE81FF` | integer / float / hex |
| 5 | REFERENCE | `FD971F` | `&anchor` / `*alias` |
| 6 | DOCUMENT | `F92672` | `---` / `...` separators |
| 7 | TEXT | `A6E22E` | quoted and block scalar values |
| 8 | ERROR | `F92672` | lexer errors |
| 9 | OPERATOR | `F92672` | `:`, `-`, `>`, `|`, `?`, etc. |

The `ext="yml yaml"` attribute is what triggers Notepad++ to use this lexer automatically when you open a `.yml` or `.yaml` file.

## 4. House-keeping

- The leftover "TEST" strings (`if else for while`, `bool long int char`, `ooooo`, etc.) that were sprinkled in keyword / string / number slots in the original fork were left in place so the diff vs. upstream stays minimal; they don't affect rendering because Notepad++ only uses the colour of those styles, not their (unused) keyword list.
- Header comment now credits the classic Monokai palette by Wimer Hazenberg.
- README rewritten to reflect the new name, the YAML language, and the change log.

## 5. Re-prioritised colour hierarchy (focus on red and orange)

After the first re-theme the result still felt too blue — cyan was sitting on TYPE WORD in C-family, ATTRIBUTE in HTML/XML, PSEUDOCLASS in CSS, plus brace highlight and smart-highlight chrome. The new priority is **red > orange > green > blue**.

Across the whole theme:

| Token | Before | After |
| --- | --- | --- |
| `NUMBER` (every lexer) | `AE81FF` purple | `FD971F` **orange** |
| `TYPE WORD` / `TYPEWORD` (C, C++, Java, C#, RC, Tcl, ObjC) | `66D9EF` cyan | `FD971F` **orange** |
| `ATTRIBUTE` / `ATTRIBUTEUNKNOWN` (HTML, XML) | `66D9EF` | `F92672` **red** |
| `XMLSTART` / `XMLEND` | `66D9EF` | `F92672` **red** |
| `ENTITY` | `66D9EF` | `FD971F` **orange** |
| `CDATA` | `66D9EF` | `E6DB74` yellow |
| `PSEUDOCLASS` / `UNKNOWN_PSEUDOCLASS` (CSS) | `66D9EF` | `FD971F` **orange** |
| `CSS VALUE` | `66D9EF` | `A6E22E` green |
| `DEFNAME` (Python) | `66D9EF` | `FD971F` **orange** |
| `WORD` (JavaScript) | `66D9EF` | `F92672` red |
| `INSTRUCTION WORD` (everywhere) | `fontStyle="0"` | `fontStyle="1"` **bold** so red really pops |
| Brace highlight / Smart highlight / Incremental highlight | `66D9EF` | unchanged (kept cyan only on chrome that needs it) |

Resulting cyan count in lexer styles: **0**. The GlobalStyles block still keeps cyan on a few chrome items (brace highlight, smart highlight, selected line background, incremental highlight) because those are not code tokens.

### YAML (the file in the screenshot)

The YAML lexer specifically was pushed to scream Monokai:

| StyleID | Token | Colour | Style | Notes |
| --- | --- | --- | --- | --- |
| 0 | DEFAULT | `A6E22E` green | regular | plain scalars like `GRASS_BLOCK` |
| 1 | COMMENT | `75715E` olive | italic | `# this is a comment` |
| 2 | IDENTIFIER | `F92672` red | regular | map keys (`game:`, `area:`, `x1:`) |
| 3 | KEYWORD | `F92672` red | **bold** | `true` `false` `null` `yes` `no` `on` `off` `~` |
| 4 | NUMBER | `FD971F` orange | regular | `-56`, `100`, `1.5` |
| 5 | REFERENCE | `FD971F` orange | regular | `&anchor` `*alias` |
| 6 | DOCUMENT | `F92672` red | **bold** | `---` `...` |
| 7 | TEXT | `A6E22E` green | regular | quoted strings |
| 8 | ERROR | `F92672` red | regular | lexer errors |
| 9 | OPERATOR | `E6DB74` yellow | regular | `:` `-` `>` `|` `?` |

So the YAML file will now read as: **red keys, red-bold booleans, orange numbers, green plain values, yellow colons/hyphens, olive-italic comments** on the dark `272822` background.

## 6. Fixed Markdown bold/italic being dark blue on the dark background

**Symptom:** in `.md` files, emphasis like `**เขียนใหม่ทั้งการ์ด**` rendered as navy `000080` (bold) on the theme's brown-ish `272822` background — nearly unreadable.

**Root cause:** Notepad++ (8.4.3+) does not highlight Markdown through theme lexers at all. It ships a preinstalled **User Defined Language** ("Markdown (preinstalled)" from the markdown-plus-plus project), whose colours live in their own file and are therefore invisible to any theme XML — including this one. The light-mode variant of that UDL was designed for white backgrounds, so its emphasis family (KEYWORDS3–7 / DELIMITERS3–7: `**bold**`, `*italic*`, `***both***`, `__underline-bold__`) was all `000080`.

**Fix (outside the repo):** in `%AppData%\Notepad++\userDefineLangs\markdown._preinstalled.udl.xml`, all ten emphasis styles were changed from `fgColor="000080"` to the theme's Monokai cyan `66D9EF`. Bold / italic / bold-italic stay distinguishable via their font styles. Deliberate exception to the "cyan count in lexer styles: 0" rule from section 5 — Markdown emphasis isn't a lexer style, and cyan-on-dark is exactly what it needs.

Notes:

- Applies while Notepad++ **Dark Mode is off** (`markdown._preinstalled.udl.xml`). With Dark Mode on, Notepad++ switches to `markdown._preinstalled_DM.udl.xml`, whose emphasis is already a readable light tan (`E3CEAB`) for that context.
- A UDL reset/reinstall of Notepad++ will restore the navy colours — re-apply this edit if Markdown ever goes dark blue again.

## 7. Added highlighting for Path of Exile loot filters (`.filter`)

**Problem:** `.filter` files (Path of Exile / Path of Exile 2 loot filters) opened as plain default text — Notepad++ ships no lexer for them, and neither did this theme.

**Mechanism:** a User Defined Language, [`DJD_PoE_Filter.udl.xml`](./DJD_PoE_Filter.udl.xml), registered for the `filter` extension. As with Markdown (section 6), UDL colours are invisible to theme XMLs, so the palette is hardcoded in the UDL file itself. Install: copy it to `%AppData%\Notepad++\userDefineLangs\` and restart Notepad++.

Colour assignments follow the red > orange > green > yellow hierarchy:

| Token | Examples | Colour | Style |
| --- | --- | --- | --- |
| Block starters | `Show` `Hide` | `F92672` red | **bold** |
| Conditions | `BaseType` `ItemLevel` `Rarity` `Quality` `AreaLevel` `GemLevel` `MapTier` … | `FD971F` orange | regular |
| Actions | `SetTextColor` `SetBorderColor` `SetFontSize` `PlayAlertSound` `PlayEffect` `MinimapIcon` `CustomAlertSound` `DisableDropSound` … | `A6E22E` green | regular |
| Value words | `True` `False`, effect colours (`Red` `Aquamarine` …), icon shapes (`Star` `Circle` …) | `E6DB74` yellow | regular |
| Quoted strings | `"Expert Dualstring Bow"`, `"Jewelllll.mp3"` | `E6DB74` yellow | regular |
| Numbers | `200 200 200`, `>= 60`, font sizes (via Numbers prefix/extras = digits) | `FD971F` orange | regular |
| Operators | `>= <= > < =` | `F92672` red | regular |
| `#` comments (incl. Thai text, whole- or end-of-line) | | `75715E` olive | italic |

So a typical block reads as: **red Show**, orange conditions, green actions, yellow quoted names, orange numbers, olive comments — on the `272822` background. `caseIgnored="yes"` so `show`/`SHOW` also highlight; keyword matching is whole-word (no prefix matching) so e.g. `Class` never bleeds into a longer word.
