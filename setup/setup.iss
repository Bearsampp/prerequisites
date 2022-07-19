#define appId = "@PREREQ_ID@"
#define appName "@PREREQ_NAME@"
#define appVersion "@PREREQ_RELEASE@"
#define appPublisher "N6REJ"
#define appURL "https://bearsampp.com/"
#define currentYear GetDateTimeString('yyyy', '', '');

[Setup]
AppId={{8547d731-4a07-40c8-b6f8-7badf8f8a780}
AppName={#appName}
AppVersion={#appVersion}
;AppVerName={#appName} {#appVersion}
AppPublisher={#appPublisher}
AppPublisherURL={#appURL}
AppSupportURL={#appURL}
AppUpdatesURL={#appURL}

WizardImageFile=prerequisites.png
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
Filename: "{tmp}\{#appId}\vcredist_2012_UPD4\vcredist_x86.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2012 UPD4 Runtimes x86 (VC11)...; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2012_UPD4\vcredist_x64.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2012 UPD4 Runtimes x64 (VC11)...; Check: IsWin64; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2013\vcredist_x86.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2013 Runtimes x86 (VC13)...; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2013\vcredist_x64.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2013 Runtimes x64 (VC13)...; Check: IsWin64; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2015_2019\vc_redist.x86.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2015-2019 Runtimes x86 (VC14 VC15 VC16)...; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2015_2019\vc_redist.x64.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2015-2019 Runtimes x64 (VC14 VC15 VC16)...; Check: IsWin64; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vcredist_2015_2022\vc_redist.x64.exe"; Parameters: "/quiet /norestart"; StatusMsg: Installing Visual C++ 2015-2022 Runtimes x64 (VC14 VC15 VC16 VC17)...; Check: IsWin64; Flags: runhidden waituntilterminated
Filename: "wusa.exe"; Parameters: """{tmp}\{#appId}\KB2731284\Windows6.1-KB2731284-v3-x86.msu"" /quiet /norestart"; StatusMsg: Installing KB2731284 x86...; Check: InstallKB2731284x86; Flags: runhidden waituntilterminated
Filename: "wusa.exe"; Parameters: """{tmp}\{#appId}\KB2731284\Windows6.1-KB2731284-v3-x86.msu"" /quiet /norestart"; StatusMsg: Installing KB2731284 x64...; Check: InstallKB2731284x64; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\KB838079\WindowsXP-KB838079-SupportTools-ENU.exe"; Parameters: "/Q /C:""msiexec.exe /qb /i suptools.msi REBOOT=ReallySuppress ADDLOCAL=ALL"""; StatusMsg: Installing KB838079...; Check: InstallKB838079; Flags: runhidden waituntilterminated

[Code]

function IsWinXP: boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  if (Version.Major = 5) and (Version.Minor = 1) then
     result := true;
end;

function IsWin7: boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  if (Version.Major = 6) and (Version.Minor = 1) then
     result := true;
end;

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

function InstallKB2731284x86: boolean;
begin
  if IsWin7 and not IsKBInstalled('KB2731284') then
    result := true;
end;

function InstallKB2731284x64: boolean;
begin
  if IsWin7 and IsWin64 and not IsKBInstalled('KB2731284') then
    result := true;
end;

function InstallKB838079: boolean;
begin
  if IsWinXP and not IsKBInstalled('KB838079') then
    result := true;
end;
