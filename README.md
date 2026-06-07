# Downloads Organizer

A simple, lightweight Windows tool that automatically sorts your Downloads folder into organized subfolders by file type — with a single double-click.

---

## Features

- Sorts files into: Images, Videos, Audio, Documents, Archives, Code, Installers, Fonts, Torrents
- Handles duplicate filenames automatically (no files ever overwritten)
- Works for any Windows user account
- Safe: only moves files, never deletes anything
- Easy installer with Desktop shortcut
- Shows up in Add/Remove Programs for clean uninstall

---

## Installation

1. Download the latest `Downloads Organizer Setup.exe` from [Releases](../../releases)
2. Double-click it and follow the installer
3. A **"Downloads Organizer"** shortcut will appear on your Desktop

---

## Usage

Just double-click the **Downloads Organizer** shortcut on your Desktop.  
A window will open, sort your files, and tell you what it moved. Press Enter to close.

---

## Folder Structure After Organizing

```
Downloads/
├── Images/
├── Videos/
├── Audio/
├── Documents/
├── Archives/
├── Code/
├── Installers/
├── Fonts/
└── Torrents/
```

---

## Building from Source

### Requirements
- [NSIS](https://nsis.sourceforge.io/Download) (free installer compiler)

### Steps
1. Clone this repository
2. Place `Organize-Downloads.ps1` and `installer.nsi` in the same folder
3. Right-click `installer.nsi` → **Compile NSIS Script**
4. `Downloads Organizer Setup.exe` will be created in the same folder

---

## Contributing

Pull requests are welcome! If you want to add new file types or features, edit `Organize-Downloads.ps1` and update the `CHANGELOG.md`.

---

## License

MIT License — free to use, modify, and share. See [LICENSE](LICENSE) for details.

---

## Author 

Made by mojo
