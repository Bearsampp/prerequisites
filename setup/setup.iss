#define appId = "@PREREQ_ID@"
#define appName "@PREREQ_NAME@"
#define appVersion "@PREREQ_RELEASE@"
#define appPublisher "N6REJ"
#define appURL "https://bearsampp.com/"
#define currentYear GetDateTimeString('yyyy', '', '');

[Setup]
AppId={{b7cff8a2-a8e1-4c2b-a5b4-33d8e777c214}
AppName={#appName}
AppVersion={#appVersion}
;AppVerName={#appName} {#appVersion}
AppPublisher={#appPublisher}
AppPublisherURL={#appURL}
AppSupportURL={#appURL}
AppUpdatesURL={#appURL}

WizardImageFile=prerequisites.bmp
WizardSmallImageFile=bearsampp.bmp
DisableWelcomePage=no
ShowLanguageDialog=yes
InfoBeforeFile=before.txt
SetupIconFile=bearsampp.ico

Compression=lzma/max
SolidCompression=yes

CreateAppDir=no
Uninstallable=no
AlwaysRestart=yes
PrivilegesRequired=admin
ChangesEnvironment=yes

VersionInfoCompany={#appPublisher}
VersionInfoCopyright={#appPublisher} {#currentYear}
VersionInfoProductName={#appName}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "src\*"; DestDir: "{tmp}\{#appId}"; Flags: ignoreversion recursesubdirs createallsubdirs deleteafterinstall

[Run]
Filename: "{tmp}\{#appId}\vcredist_2013\vcredist_x86.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2013 Runtimes x86 (VC13)...; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2013\vcredist_x64.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2013 Runtimes x64 (VC13)...; Check: IsWin64; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2015_2019\vc_redist.x86.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2015-2019 Runtimes x86 (VC14 VC15 VC16)...; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2015_2019\vc_redist.x64.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2015-2019 Runtimes x64 (VC14 VC15 VC16)...; Check: IsWin64; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2015_2022\vc_redist.x64.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2015-2022 Runtimes x64 (VC14 VC15 VC16 VC17)...; Check: IsWin64; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist\VisualCppRedist_AIO_x86_x64.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2022 Redistributable - 14.40.33721.2...; Check: IsWin64; Flags: runhidden waituntilterminated

[Code]

function IsKBInstalled(KB: string): Boolean;
var
  WbemLocator: Variant;
  WbemServices: Variant;
  WQLQuery: string;
  WbemObjectSet: Variant;
begin
  WbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
  WbemServices := WbemLocator.ConnectServer('', 'root\CIMV2');
  WQLQuery := 'select * from Win32_QuickFixEngineering where HotFixID = ''' + KB + '''';
  WbemObjectSet := WbemServices.ExecQuery(WQLQuery);
  Result := (not VarIsNull(WbemObjectSet)) and (WbemObjectSet.Count > 0);
end;
