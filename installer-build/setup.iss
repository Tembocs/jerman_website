[Setup]
AppName=LindAV
AppVersion=1.0.0
AppVerName=LindAV v1.0.0
AppPublisher=JERMAN
AppPublisherURL=https://jerman.com
AppSupportURL=https://jerman.com/pages/help.html
AppUpdatesURL=https://jerman.com/pages/download.html
DefaultDirName={autopf}\LindAV
DefaultGroupName=LindAV
OutputDir=..\downloads
OutputBaseFilename=LindAV-Setup
SetupIconFile=icon.ico
UninstallDisplayIcon={app}\lindav.exe
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
WizardStyle=modern
WizardImageFile=wizard-image.bmp
WizardSmallImageFile=wizard-small.bmp
WizardSizePercent=100
DisableProgramGroupPage=yes
LicenseFile=
InfoBeforeFile=
PrivilegesRequired=lowest
SetupMutex=LindAVSetupMutex
AppMutex=LindAVAppMutex
VersionInfoVersion=1.0.0.0
VersionInfoCompany=JERMAN
VersionInfoDescription=LindAV Security Suite Setup
VersionInfoCopyright=Copyright (C) 2026 JERMAN
VersionInfoProductName=LindAV
VersionInfoProductVersion=1.0.0

[Messages]
WelcomeLabel1=Welcome to LindAV Setup
WelcomeLabel2=This will install [name/ver] on your computer.%n%nLindAV provides enterprise-grade security protection for your device — real-time threat detection, privacy protection, and performance optimization.%n%nIt is recommended that you close all other applications before continuing.
FinishedHeadingLabel=LindAV is Ready
FinishedLabel=Setup has finished installing LindAV on your computer.%n%nYour device is now protected by JERMAN security technology.
FinishedLabelNoIcons=Setup has finished installing LindAV on your computer.%n%nYour device is now protected by JERMAN security technology.
ClickFinish=Click Finish to exit Setup and start protecting your device.
SelectDirLabel3=LindAV will be installed into the following folder.
SelectDirBrowseLabel=To continue, click Next. If you would like to select a different folder, click Browse.

[Files]
Source: "lindav-files\lindav.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "lindav-files\*.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "lindav-files\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\LindAV"; Filename: "{app}\lindav.exe"; IconFilename: "{app}\lindav.exe"
Name: "{group}\Uninstall LindAV"; Filename: "{uninstallexe}"
Name: "{autodesktop}\LindAV"; Filename: "{app}\lindav.exe"; IconFilename: "{app}\lindav.exe"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop shortcut"; GroupDescription: "Additional shortcuts:"

[Run]
Filename: "{app}\lindav.exe"; Description: "Launch LindAV"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
