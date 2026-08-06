DJD Classic Monokai Theme for Notepad++
=============

Based on the classic Monokai palette by Wimer Hazenberg, this is a Notepad++ port that started from the "One Monokai" XML by mnmlize and has been re-themed to match the original Monokai look-and-feel (not the One-Dark derivative most people call "blue Monokai"). It also adds highlighting for `.yml` / `.yaml`, `.json`, and `.maki` (Maki Cutting plugin) files out of the box.

Tested Languages
----------
PHP / CSS / HTML / JavaScript / XML / YAML / Ruby / C# / C++ / SQL / Perl / Pascal / Python / JSON / .maki (Maki Cutting)

`.maki` note
------------
`.maki` files (Maki Cutting plugin collections) are JSON, and this theme
now ships with a full JSON lexer styled in Monokai. **However**, importing
this theme alone is not enough — Notepad++ binds file extensions to
lexers via `langs.model.xml`, and the JSON lexer only knows about `.json`.

To make `.maki` files actually receive the Monokai/JSON highlighting,
you have two options (pick one):

### Option 1 — Run the included PowerShell patcher (recommended)

1. Double-click `install_maki_json.ps1`, or run from PowerShell:
   ```
   powershell -ExecutionPolicy Bypass -File .\install_maki_json.ps1
   ```
2. It creates a backup of `%APPDATA%\Notepad++\langs.xml` as
   `langs.xml.bak`, then changes `<Language name="json" ext="json" …/>`
   to `ext="json maki" …/>`.
3. Reopen any `.maki` file — it now uses the JSON lexer + Monokai styles.

To undo later, run `uninstall_maki_json.ps1` (same way).

### Option 2 — Edit `%APPDATA%\Notepad++\langs.xml` by hand

1. Open `%APPDATA%\Notepad++\langs.xml` in Notepad++.
2. Find the line:
   ```xml
   <Language name="json" ext="json" commentLine="" commentStart="" commentEnd="">
   ```
3. Change `ext="json"` to `ext="json maki"`.
4. Save and restart Notepad++.

Note: if Notepad++ updates `langs.model.xml` in the future, your
`langs.xml` may be regenerated and lose the change — just re-run the
patcher (or re-edit) in that case.

Installation
--------------------------

1. Download [`DJD_Classic_Monokai.xml`](./DJD_Classic_Monokai.xml)
2. Open Notepad++ -> Settings -> Import -> Import style theme
 - OR
2. Start -> Run -> type `%APPDATA%/Notepad++`
3. Copy this file to `themes` folder then Restart Notepad++.
4. Open `Settings->Style Configurator`.
5. Select `DJD Classic Monokai` from the theme drop-down box.
6. Click *Save & Close*

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
