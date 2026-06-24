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
