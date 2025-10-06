#define MyAppName "EjLog 2.5"
#define MyAppVersion "2.5.0.3"
#define MyAppPublisher "Wipro Ferretto Srl"
#define MyDefaultDir "C:\WF_WMS"
#define MyMainProg "WmsLauncher.exe"
#define MySubDir "Wms"
#define MyJDK "jdk8"
#define OutputDir "..\output"
#define SourceBase "C:\Users\rraimondi\OneDrive - FERRETTO GROUP S.P.A\FG\wms"
#define MyIconFile "C:\Users\rraimondi\OneDrive - FERRETTO GROUP S.P.A\FG\jira\logo\ico\wipro-0.ico"
#define SourceTool "C:\Users\rraimondi\OneDrive - FERRETTO GROUP S.P.A\FG\wms\WMS sottocartelle extra\Util"
#define DefGroupName "EjLog WMS"

[Setup]
AppId={{F47AC10B-58CC-4372-A567-0E02B2C3D479}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName=C:\WF_WMS
DefaultGroupName={#DefGroupName}
; Uncomment the following line to run in non administrative install mode (install for current user only.)
; PrivilegesRequired=lowest
PrivilegesRequired=admin
OutputDir={#OutputDir}
OutputBaseFilename=ejlog-setup-{#MyAppVersion}
SetupIconFile={#MyIconFile}
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
Name: "Tools\{#MyJDK}"; Description: "Ambiente Java JDK"; Flags: checkablealone

[Files]
Source: "{#SourceBase}\WMS v2.5\Wms\*"; DestDir: "{code:GetInstallDir}\Wms"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*2.3.1.0*"
Source: "{#SourceBase}\WMS v2.5\WmsRepository\1_WmsUpdateFolder\dll\*"; DestDir: "{code:GetInstallDir}\{#MySubDir}\dll"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceBase}\WMS v2.5\WmsRepository\1_WmsUpdateFolder\lib\*"; DestDir: "{code:GetInstallDir}\{#MySubDir}\lib"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceBase}\WMS v2.5\WmsRepository\1_WmsUpdateFolder\{#MyJDK}\*"; DestDir: "{code:GetInstallDir}\{#MySubDir}\{#MyJDK}"; Flags: ignoreversion recursesubdirs createallsubdirs

; Cartelle e file riservate al Server
Source: "{#SourceBase}\WMS v2.5\Backup\*"; DestDir: "{code:GetInstallDir}\Backup"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*2.3.1.0*"; Components: server
Source: "{#SourceBase}\WMS v2.5\WmsRepository\*"; DestDir: "{code:GetInstallDir}\WmsRepository"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*2.3.1.0*"; Components: server
Source: "{#SourceBase}\WMS v2.5\Util\*"; DestDir: "{code:GetInstallDir}\Util"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*2.3.1.0*"; Components: server util
Source: "{#SourceBase}\WMS v2.5\WmsRepository\1_WmsUpdateFolder\{#MyJDK}\*"; DestDir: "{code:GetInstallDir}\Tools\{#MyJDK}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Tools\{#MyJDK}
Source: "{#SourceBase}\WMS v2.5\RunAsService\*"; DestDir: "{code:GetInstallDir}\RunAsService"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: server\service

[Icons]
Name: "{autoprograms}\startup\{#MyAppName}"; Filename: "{app}\{#MyMainProg}"; IconFilename: "{#MyIconFile}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyMainProg}"; IconFilename: "{#MyIconFile}"; Comment: "EjLog WMS"

[Code]
function GetInstallDir(Param: String): String;
begin
  // Restituisce la directory selezionata dall'utente durante l'installazione
  Result := WizardForm.DirEdit.Text;
end;

