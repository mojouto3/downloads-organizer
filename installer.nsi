; Downloads Organizer - NSIS Installer Script
; Build with: makensis installer.nsi

!define APP_NAME "Downloads Organizer"
!define APP_VERSION "1.0"
!define INSTALL_DIR "$PROGRAMFILES\Downloads Organizer"
!define PUBLISHER "mojo"

Name "${APP_NAME}"
OutFile "Downloads Organizer Setup.exe"
InstallDir "${INSTALL_DIR}"
RequestExecutionLevel admin
SetCompressor lzma

; Modern UI
!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
!define MUI_WELCOMEPAGE_TITLE "Welcome to Downloads Organizer Setup"
!define MUI_WELCOMEPAGE_TEXT "This will install Downloads Organizer on your computer.$\r$\n$\r$\nA shortcut will be placed on your Desktop so anyone can organize their Downloads folder with a single click.$\r$\n$\r$\nClick Next to continue."

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

Section "Install"
    SetOutPath "${INSTALL_DIR}"

    ; Copy the PowerShell script
    File "Organize-Downloads.ps1"

    ; Create the launcher batch file
    FileOpen $0 "${INSTALL_DIR}\Run.bat" w
    FileWrite $0 "@echo off$\r$\n"
    FileWrite $0 "powershell.exe -ExecutionPolicy Bypass -File $\"${INSTALL_DIR}\Organize-Downloads.ps1$\"$\r$\n"
    FileClose $0

    ; Create Desktop shortcut pointing to the batch launcher
    CreateShortcut "$DESKTOP\Downloads Organizer.lnk" \
        "${INSTALL_DIR}\Run.bat" \
        "" \
        "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico" \
        0 \
        SW_SHOWNORMAL \
        "" \
        "Organize your Downloads folder"

    ; Write uninstall registry info
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DownloadsOrganizer" \
        "DisplayName" "${APP_NAME}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DownloadsOrganizer" \
        "UninstallString" "${INSTALL_DIR}\Uninstall.exe"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DownloadsOrganizer" \
        "DisplayVersion" "${APP_VERSION}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DownloadsOrganizer" \
        "Publisher" "${PUBLISHER}"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DownloadsOrganizer" \
        "DisplayIcon" "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"

    WriteUninstaller "${INSTALL_DIR}\Uninstall.exe"

    MessageBox MB_OK "Downloads Organizer installed successfully!$\r$\nA shortcut has been added to your Desktop."
SectionEnd

Section "Uninstall"
    Delete "${INSTALL_DIR}\Organize-Downloads.ps1"
    Delete "${INSTALL_DIR}\Run.bat"
    Delete "${INSTALL_DIR}\Uninstall.exe"
    RMDir "${INSTALL_DIR}"
    Delete "$DESKTOP\Downloads Organizer.lnk"
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DownloadsOrganizer"
    MessageBox MB_OK "Downloads Organizer has been uninstalled."
SectionEnd
