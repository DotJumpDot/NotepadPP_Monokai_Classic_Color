DJD Classic Monokai Theme for Notepad++
=============

Based on the classic Monokai palette by Wimer Hazenberg, this is a Notepad++ port that started from the "One Monokai" XML by mnmlize and has been re-themed to match the original Monokai look-and-feel (not the One-Dark derivative most people call "blue Monokai"). It also adds highlighting for `.yml` / `.yaml` files out of the box, plus a companion User Defined Language for Path of Exile loot filter (`.filter`) files.

Tested Languages
----------
PHP / CSS / HTML / JavaScript / XML / YAML / Ruby / C# / C++ / SQL / Perl / Pascal / Python / **PoE loot filters (`.filter`, via the bundled UDL)**

Installation
--------------------------

**Theme:**

1. Download [`DJD_Classic_Monokai.xml`](./DJD_Classic_Monokai.xml)
2. Open Notepad++ -> Settings -> Import -> Import style theme
 - OR
2. Start -> Run -> type `%APPDATA%/Notepad++`
3. Copy this file to `themes` folder then Restart Notepad++.
4. Open `Settings->Style Configurator`.
5. Select `DJD Classic Monokai` from the theme drop-down box.
6. Click *Save & Close*

**Path of Exile loot filter highlighting (optional):**

1. Download [`DJD_PoE_Filter.udl.xml`](./DJD_PoE_Filter.udl.xml)
2. Copy it to `%APPDATA%\Notepad++\userDefineLangs\`
3. Restart Notepad++. Any `.filter` file is now highlighted automatically:

   - `Show` / `Hide` — red, bold
   - conditions (`BaseType`, `ItemLevel`, `Rarity`, …) — orange
   - actions (`SetTextColor`, `PlayAlertSound`, `MinimapIcon`, …) — green
   - quoted names & value words (`"Orb of Alchemy"`, `Red`, `Star`, …) — yellow
   - numbers (RGB triplets, levels, font sizes) — orange
   - `#` comments — olive, italic

**Markdown fix (optional but recommended with this theme):**

Notepad++ highlights Markdown with a preinstalled User Defined Language whose emphasis styles (`**bold**`, `*italic*`) are navy `000080` — unreadable on this theme's dark background. To recolour them to Monokai cyan `66D9EF`, edit `%AppData%\Notepad++\userDefineLangs\markdown._preinstalled.udl.xml` and replace every `fgColor="000080"` with `fgColor="66D9EF"`, then restart Notepad++. (Details in [`State Changes.md`](./State%20Changes.md) section 6.)

Screenshot
----------
![Screenshot](https://raw.githubusercontent.com/DotJumpDot/NotepadPP_Monokai_Classic_Color/master/screenshot.png "Screenshot")

Credits
------
- Original XML scaffolding: "One Monokai" for Notepad++ by mnmlize (https://github.com/mnmlize/npp-one-monokai-theme), GPL V3.
- Color palette: classic Monokai by Wimer Hazenberg.

Change log
------
See [`State Changes.md`](./State%20Changes.md) for what was edited in this fork.
