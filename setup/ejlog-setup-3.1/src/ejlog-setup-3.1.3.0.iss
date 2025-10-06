#define MyAppName "EjLog"
#define MyAppVersion "3.1.3.0"
#define MyAppPublisher "Wipro Ferretto Srl"
#define MyDefaultDir "C:\FG_WMS"
#define MyMainProg "WmsLauncher.exe"
#define MySubDir "Wms"
#define MyJDK "jdk17"
#define SourceBase "C:\Users\rraimondi\OneDrive - FERRETTO GROUP S.P.A\FG\wms"
#define SourceIcon "C:\Users\rraimondi\OneDrive - FERRETTO GROUP S.P.A\FG\jira\logo\ico"
#define OutputDir "C:\Users\rraimondi\OneDrive - FERRETTO GROUP S.P.A\FG\ambiente-lavoro\interno-fg\inno-setup\setup\output"
#define SourceTool "C:\Users\rraimondi\OneDrive - FERRETTO GROUP S.P.A\FG\wms\WMS sottocartelle extra\Util"
#define DefGroupName "EjLog WMS"

[Setup]
AppId={{7A4C5669-6796-4D36-AB8F-CAED9A636AD0}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName=C:\FG_WMS
DefaultGroupName={#DefGroupName}
; Uncomment the following line to run in non administrative install mode (install for current user only.)
; PrivilegesRequired=lowest
PrivilegesRequired=admin
OutputDir={#OutputDir}
OutputBaseFilename=ejlog-setup-{#MyAppVersion}
SetupIconFile={#SourceIcon}\wipro-0.ico
Password=fergrp_2012
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"

[Types]
Name: "client"; Description: "Installazione ambiente WMS Client"; Languages: "italian"
Name: "server"; Description: "Installazione ambiente WMS Server"; Languages: "italian"
Name: "custom"; Description: "Installazione Custom"; Flags: iscustom

[Components]
Name: "base"; Description: "Struttura di base"; Types: client server custom; Flags: fixed
Name: "server"; Description: "File e cartelle per ambiente Server"; Types: server
Name: "server\service"; Description: "Componenti per installazione come servizio"; Flags: checkablealone
Name: "util"; Description: "Installazione della cartella Utility"; Flags: checkablealone
Name: "Tools"; Description: "Installazione della cartella Tools"; Flags: checkablealone
Name: "Tools\eclipse"; Description: "Ambiente di sviluppo Eclipse"; Flags: checkablealone
;Name: "Tools\{#MyJDK}"; Description: "Ambiente Java JDK"; Flags: checkablealone
;Name: "Tools\visualvm"; Description: "Visualvm"; Flags: checkablealone 

[Files]
; Cartelle del Repository v3.0 
Source: "{#SourceBase}\WMS v2.5\Wms\*"; DestDir: "{code:GetInstallDir}\{#MySubDir}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*2.3.1.0*"
Source: "{#SourceBase}\WMS v3.0 upgrade\WmsRepository\1_WmsUpdateFolder\dll\*"; DestDir: "{code:GetInstallDir}\Wms\dll"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceBase}\WMS v3.0 upgrade\WmsRepository\1_WmsUpdateFolder\lib\*"; DestDir: "{code:GetInstallDir}\Wms\lib"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceBase}\WMS v3.0 upgrade\WmsRepository\1_WmsUpdateFolder\{#MyJDK}\*"; DestDir: "{code:GetInstallDir}\Wms\{#MyJDK}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceIcon}\wipro-0.ico"; DestDir: "{code:GetInstallDir}\Wms\tmp"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceTool}\7z1900-x64.exe"; DestDir: "{app}\Wms\tmp"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceTool}\7za.exe"; DestDir: "{app}\Wms\tmp"; Flags: ignoreversion recursesubdirs createallsubdirs

; Cartelle e file riservate al Server
Source: "{#SourceBase}\WMS v2.5\Backup\*"; DestDir: "{code:GetInstallDir}\Backup"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*2.3.1.0*"; Components: server
Source: "{#SourceBase}\WMS v3.0 upgrade\WmsRepository\*"; DestDir: "{code:GetInstallDir}\WmsRepository"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*2.3.1.0*"; Components: server
Source: "{#SourceBase}\WMS v2.5\Util\*"; DestDir: "{code:GetInstallDir}\Util"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*2.3.1.0*"; Components: server util
Source: "{#SourceBase}\WMS v2.5\RunAsService\*"; DestDir: "{code:GetInstallDir}\RunAsService"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: server\service
Source: "{#SourceBase}\WMS sottocartelle extra\Tools\eclipse.7z"; DestDir: "{code:GetInstallDir}\Tools\eclipse"; Flags: ignoreversion; Components: Tools\eclipse
//Source: "{#SourceBase}\WMS v2.5\WmsRepository\1_WmsUpdateFolder\jdk8\*"; DestDir: "{code:GetInstallDir}\Tools\jdk8"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Tools\jdk8
//Source: "{#SourceBase}\WMS sottocartelle extra\Tools\visualvm\*"; DestDir: "{code:GetInstallDir}\Tools\visualvm"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Tools\visualvm

[Icons]
Name: "{autoprograms}\startup\{#MyAppName}"; Filename: "{app}\{#MyMainProg}"; IconFilename: "{app}\Wms\tmp\wipro-0.ico"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyMainProg}"; IconFilename: "{app}\Wms\tmp\wipro-0.ico"; Comment: "EjLog WMS"
;Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyMainProg}"

[Run]
Filename: "{app}\Wms\tmp\7z1900-x64.exe"; Parameters: "/S"; Flags: runhidden waituntilterminated
Filename: "{app}\Wms\tmp\7za.exe"; Parameters: "x ""{tmp}\eclipse.7z"" -o""{code:GetInstallDir}\Tools\eclipse"" -y"; Flags: runhidden waituntilterminated; Components: Tools\eclipse

[Code]
function GetInstallDir(Param: String): String;
begin
  // Restituisce la directory selezionata dall'utente durante l'installazione
  Result := WizardForm.DirEdit.Text;
end;

