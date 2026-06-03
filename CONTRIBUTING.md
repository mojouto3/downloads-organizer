# Contributing to Downloads Organizer

Thank you for wanting to improve this project! Here's how to get started.

---

## How to Contribute

1. **Fork** this repository
2. **Create a branch** for your change: `git checkout -b feature/my-improvement`
3. **Make your changes** (see guidelines below)
4. **Test** that the script runs correctly on Windows
5. **Update** `CHANGELOG.md` with what you changed
6. **Submit a Pull Request** with a clear description

---

## Adding New File Types

Open `Organize-Downloads.ps1` and find the `$categories` hashtable.  
Add your extension to an existing category, or create a new one:

```powershell
$categories = @{
    "Images" = @("*.jpg", "*.jpeg", "*.png", ...)  # Add new extensions here
    "MyNewCategory" = @("*.abc", "*.xyz")            # Or add a new category
}
```

Then update `README.md` to reflect the new category.

---

## Versioning

This project uses [Semantic Versioning](https://semver.org/):
- **Patch** (1.0.x): Bug fixes
- **Minor** (1.x.0): New file types or categories
- **Major** (x.0.0): Big changes (new UI, new installer, etc.)

Always update `CHANGELOG.md` and the version number in `installer.nsi` when releasing.

---

## Reporting Issues

Open an issue and include:
- Your Windows version
- What happened vs what you expected
- Any error messages from the PowerShell window
