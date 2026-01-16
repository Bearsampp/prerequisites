#define appId = "@PREREQ_ID@"
#define appName "@PREREQ_NAME@"
#define appVersion "@PREREQ_RELEASE@"
#define appPublisher "Bearsampp"
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
Source: "src\*"; DestDir: "{tmp}\{#appId}"; Flags: ignoreversion recursesubdirs createallsubdirs deleteafterinstall; Excludes: "fonts\*,vcredist_2015_2022\*"
Source: "src\fonts\*.ttf"; DestDir: "{autofonts}"; FontInstall: "Cascadia Cove Nerd Font"; Flags: onlyifdoesntexist uninsneveruninstall

[Run]
Filename: "{tmp}\{#appId}\vc_redist.x86.exe"; Parameters: "/passive /norestart"; StatusMsg: Installing Visual C++ 2015-2022 Runtimes x86 (VC15 VC16 VC17)...; Flags: runhidden waituntilterminated
Filename: "{tmp}\{#appId}\vc_redist.x64.exe"; Parameters: "/passive /norestart"; StatusMsg: Installing Visual C++ 2015-2022 Runtimes x64 (VC15 VC16 VC17)...; Check: IsWin64; Flags: runhidden waituntilterminated


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

function DownloadFile(const URL, FileName: string): Boolean;
var
  WinHttpReq: Variant;
  Stream: TFileStream;
  ErrorCode: Integer;
begin
  Result := False;
  try
    WinHttpReq := CreateOleObject('WinHttp.WinHttpRequest.5.1');
    WinHttpReq.Open('GET', URL, False);
    WinHttpReq.Send();
    
    if WinHttpReq.Status = 200 then
    begin
      Stream := TFileStream.Create(FileName, fmCreate);
      try
        Stream.WriteBuffer(WinHttpReq.ResponseBody, VarArrayHighBound(WinHttpReq.ResponseBody, 1) + 1);
        Result := True;
      finally
        Stream.Free;
      end;
    end;
  except
    Result := False;
  end;
end;

procedure InitializeWizard();
var
  DownloadPath: string;
  X86URL: string;
  X64URL: string;
  X86File: string;
  X64File: string;
  DownloadSuccess: Boolean;
begin
  DownloadPath := ExpandConstant('{tmp}\{#appId}');
  X86URL := 'https://aka.ms/vc14/vc_redist.x86.exe';
  X64URL := 'https://aka.ms/vc14/vc_redist.x64.exe';
  X86File := DownloadPath + '\vc_redist.x86.exe';
  X64File := DownloadPath + '\vc_redist.x64.exe';
  
  // Create temp directory if it doesn't exist
  if not DirExists(DownloadPath) then
    CreateDir(DownloadPath);
  
  // Download x86 redistributable
  if not FileExists(X86File) then
  begin
    MsgBox('Downloading Visual C++ 2015-2022 Runtimes x86...', mbInformation, MB_OK);
    DownloadSuccess := DownloadFile(X86URL, X86File);
    if not DownloadSuccess then
      MsgBox('Warning: Failed to download x86 redistributable. Installation may fail.', mbWarning, MB_OK);
  end;
  
  // Download x64 redistributable if on 64-bit Windows
  if IsWin64 and not FileExists(X64File) then
  begin
    MsgBox('Downloading Visual C++ 2015-2022 Runtimes x64...', mbInformation, MB_OK);
    DownloadSuccess := DownloadFile(X64URL, X64File);
    if not DownloadSuccess then
      MsgBox('Warning: Failed to download x64 redistributable. Installation may fail.', mbWarning, MB_OK);
  end;
end;
