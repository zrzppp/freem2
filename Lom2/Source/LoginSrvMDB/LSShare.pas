unit LSShare;

interface

uses
  Windows, Messages, Classes, Dialogs, SysUtils, SyncObjs, IniFiles,
  MudUtil, SDK, Grobal2;

type
  TGateNet = record
    sIPaddr:  string;
    nPort:    integer;
    boEnable: boolean;
  end;

  TGateRoute = record
    sServerName: string;
    sTitle: string;
    sRemoteAddr: string;
    sPublicAddr: string;
    nSelIdx: integer;
    Gate: array [0..9] of TGateNet;
  end;

  TConfig = record
    IniConf:     TIniFile;
    boRemoteClose: boolean;
    sDBServer:   string[30];    //0x00475368
    nDBSPort:    integer;       //0x00475374
    sFeeServer:  string[30];    //0x0047536C
    nFeePort:    integer;       //0x00475378
    sLogServer:  string[30];    //0x00475370
    nLogPort:    integer;       //0x0047537C
    sGateAddr:   string[30];
    nGatePort:   integer;
    sServerAddr: string[30];
    nServerPort: integer;
    sMonAddr:    string[30];
    nMonPort:    integer;
    sGateIPaddr: string[30]; //当前处理的网关连接IP地址
    sWebLogDir:  string[50];
    sFeedIDList: string[50];
    sFeedIPList: string[50];
    sCountLogDir: string[50];
    sChrLogDir:  string[50];

    boTestServer: boolean;
    boEnableMakingID: boolean;
    boDynamicIPMode: boolean;
    nReadyServers: integer;

    GateCriticalSection: TRTLCriticalSection;
    GateList:    TList;
    SessionList: TGList;
    ServerNameList: TStringList;
    AccountCostList: TQuickList;
    IPaddrCostList: TQuickList;
    boShowDetailMsg: boolean;
    dwProcessGateTick: longword;          //0x00475380
    dwProcessGateTime: longword;          //0x00475384
    nRouteCount: integer;//0x47328C
    GateRoute:   array[0..59] of TGateRoute;
  end;
  pTConfig = ^TConfig;

function CheckAccountName(sName: string): boolean;
function GetSessionID(): integer;
procedure SaveGateConfig(Config: pTConfig);
function GetGatePublicAddr(Config: pTConfig; sGateIP: string): string;
function GenSpaceString(sStr: string; nSpaceCOunt: integer): string;
procedure MainOutMessage(sMsg: string);
//procedure LoadDBSetup;

var

  g_sVersion:string= 'OByiHiZdpgQOPPoF{WwYpksCu\';
  g_sUpDateTime:string= 'H_<lIxOfHO?Pl_CDqL';
  g_sProgram:string= 'OByiH^=HWrYeWaIaXcUaX^=IM@Flu_@jH<';
  g_sWebSite:string= 'o[_Qk_esYsXjWByiH^u_W\';
  
  g_Config: TConfig = (boRemoteClose: False;
  sDBServer: '127.0.0.1';
  nDBSPort: 16300;
  sFeeServer: '127.0.0.1';
  nFeePort: 16301;
  sLogServer: '127.0.0.1';
  nLogPort: 16301;
  sGateAddr: '0.0.0.0';
  nGatePort: 5500;
  sServerAddr: '0.0.0.0';
  nServerPort: 5600;
  sMonAddr: '0.0.0.0';
  nMonPort: 3000;

  sWebLogDir: '.\Share\';            //0x00470D08
  sFeedIDList: '.\FeedIDList.txt';   //0x00470D0C
  sFeedIPList: '.\FeedIPList.txt';   //0x00470D10
  sCountLogDir: '.\CountLog\';       //0x00470D14
  sChrLogDir: '.\ChrLog\';

  boTestServer: True;
  boEnableMakingID: True;
  boDynamicIPMode: False;
  nReadyServers: 0;
  boShowDetailMsg: False);


  g_sSQLString        :String = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\IDDB\Account.mdb;Persist Security Info=False';

  //nReadyServers     :Integer;           //0x00475388
  nOnlineCountMin: integer;           //0x00475390
  nOnlineCountMax: integer;           //0x00475394
  nMemoHeigh: integer;           //0x00475398
  g_OutMessageCS: TRTLCriticalSection;
  g_MainMsgList: TStringList;       //0x0047539C
  CS_DB:   TCriticalSection;  //0x004753A0
  n4753A4: integer;           //0x004753A4
  n4753A8: integer;           //0x004753A8
  n4753B0: integer;           //0x004753B0


  n47328C: integer;

  nSessionIdx: integer;          //0x00473294

  g_n472A6C: integer;
  g_n472A70: integer;
  g_n472A74: integer;
  g_boDataDBReady: boolean;         //0x00472A78
  bo470D20:  boolean;

  nVersionDate: integer = 20011006;


  ServerAddr: array[0..99] of string[15];

implementation

uses
  HUtil32;



function CheckAccountName(sName: string): boolean; //00454384
var
  i:    integer;
  nLen: integer;
begin
  Result := False;
  if sName = '' then exit;
  Result := True;
  nLen   := length(sName);
  i      := 1;
  while (True) do begin
    if i > nLen then break;
    if (sName[i] < '0') or (sName[i] > 'z') then begin
      ;
      Result := False;
      if (sName[i] >= #$B0) and (sName[i] <= #$C8) then begin
        Inc(i);
        if i <= nLen then if (sName[i] >= #$A1) and (sName[i] <= #$FE) then
            Result := True;
      end;
      if not Result then break;
    end;
    Inc(i);
  end;
end;
//00468BDC
function GetSessionID(): integer;
begin
  Inc(nSessionIdx);
  if nSessionIdx >= High(integer) then begin
    nSessionIdx := 2;
  end;
  Result := nSessionIdx;
end;
//0046D4F4
procedure SaveGateConfig(Config: pTConfig);
var
  SaveList: TStringList;
  i, n8:    integer;
  s10, sC:  string;
begin
  SaveList := TStringList.Create;
  SaveList.Add(';No space allowed');
  SaveList.Add(GenSpaceString(';Server', 15) + GenSpaceString('Title', 15) +
    GenSpaceString('Remote', 17) + GenSpaceString('Public', 17) + 'Gate...');
  for i := 0 to Config.nRouteCount - 1 do begin
    sC := GenSpaceString(Config.GateRoute[i].sServerName, 15) +
      GenSpaceString(Config.GateRoute[i].sTitle, 15) +
      GenSpaceString(Config.GateRoute[i].sRemoteAddr, 17) +
      GenSpaceString(Config.GateRoute[i].sPublicAddr, 17);
    n8 := 0;
    while (True) do begin
      s10 := Config.GateRoute[i].Gate[n8].sIPaddr;
      if s10 = '' then break;
      if not Config.GateRoute[i].Gate[n8].boEnable then s10 := '*' + s10;
      s10 := s10 + ':' + IntToStr(Config.GateRoute[i].Gate[n8].nPort);
      sC := sC + GenSpaceString(s10, 17);
      Inc(n8);
      if n8 >= 10 then break;
    end;
    SaveList.Add(sC);
  end;
  SaveList.SaveToFile('.\!addrtable.txt');
  SaveList.Free;
end;
//0046D7F8
function GetGatePublicAddr(Config: pTConfig; sGateIP: string): string;
var
  I: integer;
begin
  Result := sGateIP;
  for I := 0 to Config.nRouteCount - 1 do begin
    if Config.GateRoute[I].sRemoteAddr = sGateIP then begin
      Result := Config.GateRoute[I].sPublicAddr;
      break;
    end;
  end;
end;
//004541C4
function GenSpaceString(sStr: string; nSpaceCount: integer): string;
var
  I: integer;
begin
  Result := sStr + ' ';
  for I := 1 to nSpaceCount - Length(sStr) do begin
    Result := Result + ' ';
  end;
end;
//00468F00
procedure MainOutMessage(sMsg: string);
begin
  EnterCriticalSection(g_OutMessageCS);
  try
    g_MainMsgList.Add(sMsg)
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
end;

{procedure LoadDBSetup;
var
  LoadList        :TStringList;
  sFileName       :string;
  i               :Integer;
  sLineText, sTmp :string;
begin
  sFileName := '.\!DBSetup.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[i]);

      if (sLineText <> '') then begin
        if sLineText[1] = ';' then Continue;
        //sTmp holds Connect=
        //sLineText holds SQL
        sLineText := GetValidStr3(sLineText, sTmp, ['=']);

        if (sLineText <> '') then g_sSQLString := sLineText;
      end;
    end;
    LoadList.Free;
  end else
    ShowMessage('[Critical Failure] file not found. .\!DBSetup.txt');
end;}

initialization
begin
  InitializeCriticalSection(g_OutMessageCS);
  g_MainMsgList := TStringList.Create;
end;

finalization
begin
  g_MainMsgList.Free;
  DeleteCriticalSection(g_OutMessageCS);
end;

end.
