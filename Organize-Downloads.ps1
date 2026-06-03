# Downloads Organizer
# Sorts C:\Users\Public\Downloads and current user's Downloads into subfolders by file type

$source = [Environment]::GetFolderPath("UserProfile") + "\Downloads"

$categories = @{
    "Images"     = @("*.jpg","*.jpeg","*.png","*.gif","*.bmp","*.webp","*.svg","*.ico","*.tiff","*.heic","*.raw")
    "Videos"     = @("*.mp4","*.mkv","*.avi","*.mov","*.wmv","*.flv","*.webm","*.m4v","*.mpg","*.mpeg")
    "Audio"      = @("*.mp3","*.wav","*.flac","*.aac","*.ogg","*.m4a","*.wma","*.opus","*.aiff")
    "Documents"  = @("*.pdf","*.doc","*.docx","*.xls","*.xlsx","*.ppt","*.pptx","*.odt","*.ods","*.odp","*.txt","*.rtf","*.pages","*.numbers","*.key","*.epub","*.mobi")
    "Archives"   = @("*.zip","*.rar","*.7z","*.tar","*.gz","*.bz2","*.xz","*.iso","*.dmg","*.cab")
    "Code"       = @("*.py","*.js","*.ts","*.html","*.css","*.json","*.xml","*.yaml","*.yml","*.sh","*.bat","*.ps1","*.java","*.cpp","*.c","*.h","*.cs","*.go","*.rb","*.php","*.sql","*.md","*.ipynb")
    "Installers" = @("*.exe","*.msi","*.msix","*.appx","*.apk","*.deb","*.rpm","*.pkg")
    "Fonts"      = @("*.ttf","*.otf","*.woff","*.woff2","*.eot")
    "Torrents"   = @("*.torrent")
}

$moved = 0
$errors = 0

Write-Host ""
Write-Host "  Downloads Organizer" -ForegroundColor Cyan
Write-Host "  Organizing: $source" -ForegroundColor Gray
Write-Host "  -------------------------------------" -ForegroundColor DarkGray
Write-Host ""

foreach ($category in $categories.Keys) {
    $destFolder = Join-Path $source $category
    $extensions = $categories[$category]
    $categoryMoved = 0

    foreach ($ext in $extensions) {
        $files = Get-ChildItem -Path $source -Filter $ext -File -ErrorAction SilentlyContinue
        foreach ($file in $files) {
            if ($file.DirectoryName -ne $source) { continue }
            try {
                if (-not (Test-Path $destFolder)) {
                    New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
                }
                $dest = Join-Path $destFolder $file.Name
                if (Test-Path $dest) {
                    $base = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                    $extension = $file.Extension
                    $counter = 1
                    do {
                        $dest = Join-Path $destFolder "${base}_${counter}${extension}"
                        $counter++
                    } while (Test-Path $dest)
                }
                Move-Item -Path $file.FullName -Destination $dest
                $categoryMoved++
                $moved++
            } catch {
                Write-Host "  ERROR: $($file.Name)" -ForegroundColor Red
                $errors++
            }
        }
    }
    if ($categoryMoved -gt 0) {
        Write-Host ("  " + $category.PadRight(14) + ": $categoryMoved file(s) moved") -ForegroundColor Green
    }
}

$remaining = (Get-ChildItem -Path $source -File | Where-Object { $_.DirectoryName -eq $source }).Count

Write-Host ""
Write-Host "  -------------------------------------" -ForegroundColor DarkGray
Write-Host "  Done! $moved file(s) organized." -ForegroundColor Cyan
if ($remaining -gt 0) {
    Write-Host "  $remaining file(s) left unsorted (unknown types)." -ForegroundColor Yellow
}
if ($errors -gt 0) {
    Write-Host "  $errors error(s) occurred." -ForegroundColor Red
}
Write-Host ""
Read-Host "  Press Enter to close"
