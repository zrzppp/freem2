unit DBShare;

interface

uses
  Windows, Messages, Classes, Dialogs, SysUtils, JSocket, IniFiles,
  Grobal2, MudUtil;

type
  TGateInfo = record
    Socket:    TCustomWinSocket;
    sGateaddr: string;   //0x04
    sText:     string;   //0x08
    UserList:  TList;    //0x0C
    dwTick10:  longword; //0x10
    nGateID:   integer;  //网关ID
  end;
  pTGateInfo = ^TGateInfo;

  TUserInfo = record
    sAccount: string;        //0x00
    sUserIPaddr: string;     //0x0B
    sGateIPaddr: string;
    sConnID:  string;       //0x20
    nSessionID: integer;    //0x24
    Socket:   TCustomWinSocket;
    s2C:      string;          //0x2C
    boChrSelected: boolean;    //0x30
    boChrQueryed: boolean;     //0x31
    dwTick34: longword;        //0x34
    dwChrTick: longword;       //0x38
    nSelGateID: shortint;      //角色网关ID
  end;
  pTUserInfo = ^TUserInfo;

  TRouteInfo = record
    nGateCount:    integer;
    sSelGateIP:    string[15];
    sGameGateIP:   array[0..7] of string[15];
    nGameGatePort: array[0..7] of integer;
  end;
  pTRouteInfo = ^TRouteInfo;

procedure LoadConfig();
procedure LoadIPTable();
procedure LoadGateID();
function GetGateID(sIPaddr: string): integer;
function CheckChrName(sChrName: string): boolean;
function InClearMakeIndexList(nIndex: integer): boolean;
procedure OutMainMessage(sMsg: string);
procedure WriteLogMsg(sMsg: string);
function CheckServerIP(sIP: string): boolean;

var
  g_nMaxCreateChar    :Integer = 3;

  g_sSQLDatabase:     String[50] = 'mir2';
  g_sSQLHost:         String[30] = '127.0.0.1';
  g_nSQLPort:         Integer = 3306;
  g_sSQLUserName:     String[20] = 'mir2';
  g_sSQLPassword:     String[20] = 'mir2';

  sHumDBFilePath: string = '.\FDB\';
  sDataDBFilePath: string = '.\FDB\';
  sFeedPath:    string = '.\FDB\';
  sBackupPath:  string = '.\FDB\';
  sConnectPath: string = '.\Connection\';
  sLogPath:     string = '.\Log\';

  nServerPort:   integer = 6000;
  sServerAddr:   string = '0.0.0.0';
  g_nGatePort:   integer = 5100;
  g_sGateAddr:   string = '0.0.0.0';
  nIDServerPort: integer = 5600;
  sIDServerAddr: string = '127.0.0.1';

  g_boEnglishNames: boolean = False;

  boViewHackMsg: boolean = False;

  HumDB_CS: TRTLCriticalSection; //0x004ADACC

  n4ADAE4:      integer;
  n4ADAE8:      integer;
  n4ADAEC:      integer;
  n4ADAF0:      integer;
  boDataDBReady: boolean;  //0x004ADAF4
  n4ADAFC:      integer;
  n4ADB00:      integer;
  n4ADB04:      integer;
  boHumDBReady: boolean;  //0x4ADB08
  n4ADBF4:      integer;
  n4ADBF8:      integer;
  n4ADBFC:      integer;
  n4ADC00:      integer;
  n4ADC04:      integer;
  boAutoClearDB: boolean;       //0x004ADC08
  g_nQueryChrCount: integer;    //0x004ADC0C
  nHackerNewChrCount: integer;  //0x004ADC10
  nHackerDelChrCount: integer;  //0x004ADC14
  nHackerSelChrCount: integer;  //0x004ADC18
  n4ADC1C:      integer;
  n4ADC20:      integer;
  n4ADC24:      integer;
  n4ADC28:      integer;
  n4ADC2C:      integer;
  n4ADB10:      integer;
  n4ADB14:      integer;
  n4ADB18:      integer;
  n4ADBB8:      integer;
  bo4ADB1C:     boolean;

  sServerName:   string = 'ktest';
  sConfFileName: string = '.\Dbsrc.ini';
  sGateConfFileName: string = '.\!ServerInfo.txt';
  sServerIPConfFileNmae: string = '.\!AddrTable.txt';
  sGateIDConfFileName: string = '.\SelectID.txt';

  sMapFile:     string;
  DenyChrNameList: TStringList;
  ServerIPList: TStringList;
  GateIDList:   TStringList;
  {
  nClearIndex        :Integer;   //当前清理位置（记录的ID）
  nClearCount        :Integer;   //当前已经清量数量
  nRecordCount       :Integer;   //当前总记录数
  }
  {
  boClearLevel1      :Boolean = True;
  boClearLevel2      :Boolean = True;
  boClearLevel3      :Boolean = True;
  }
  dwInterval:   longword = 3000;    //清理时间间隔长度

  nLevel1: integer = 1;        //清理等级 1
  nLevel2: integer = 7;        //清理等级 2
  nLevel3: integer = 14;       //清理等级 3

  nDay1: integer = 14;       //清理未登录天数 1
  nDay2: integer = 62;       //清理未登录天数 2
  nDay3: integer = 124;      //清理未登录天数 3

  nMonth1: integer = 0;      //清理未登录月数 1
  nMonth2: integer = 0;      //清理未登录月数 2
  nMonth3: integer = 0;      //清理未登录月数 3

  g_nClearRecordCount: integer;
  g_nClearIndex: integer; //0x324
  g_nClearCount: integer; //0x328
  g_nClearItemIndexCount: integer;

  boOpenDBBusy:     boolean;  //0x350
  g_dwGameCenterHandle: THandle;
  g_boDynamicIPMode: boolean = False;
  g_CheckCode:      TCheckCode;
  g_ClearMakeIndex: TStringList;

  g_RouteInfo: array [0..19] of TRouteInfo;

implementation

uses DBSMain, HUtil32;

procedure LoadGateID();
var
  I:   integer;
  LoadList: TStringList;
  sLineText: string;
  sID: string;
  sIPaddr: string;
  nID: integer;
begin
  GateIDList.Clear;
  if FileExists(sGateIDConfFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sGateIDConfFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText = '') or (sLineText[1] = ';') then Continue;
      sLineText := GetValidStr3(sLineText, sID, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sIPaddr, [' ', #9]);
      nID := Str_ToInt(sID, -1);
      if nID < 0 then Continue;
      GateIDList.AddObject(sIPaddr, TObject(nID));
    end;
    LoadList.Free;
  end;
end;

function GetGateID(sIPaddr: string): integer;
var
  I: integer;
begin
  Result := 0;
  for I := 0 to GateIDList.Count - 1 do begin
    if GateIDList.Strings[I] = sIPaddr then begin
      Result := integer(GateIDList.Objects[I]);
      break;
    end;

  end;
end;

procedure LoadIPTable();
begin
  ServerIPList.Clear;
  try
    ServerIPList.LoadFromFile(sServerIPConfFileNmae);
  except
    OutMainMessage('IP table ' + sServerIPConfFileNmae + ' failed to load!');
  end;
end;

procedure LoadConfig();
var
  Conf: TIniFile;
  LoadInteger: integer;
begin
  Conf := TIniFile.Create(sConfFileName);
  if Conf <> nil then begin
    g_sSQLDatabase := Conf.ReadString('SQL', 'DatabaseName', g_sSQLDatabase);
    g_sSQLHost := Conf.ReadString('SQL', 'Host', g_sSQLHost);
    g_nSQLPort := Conf.ReadInteger('SQL', 'Port', g_nSQLPort);
    g_sSQLUserName := Conf.ReadString('SQL', 'UserName', g_sSQLUserName);
    g_sSQLPassword := Conf.ReadString('SQL', 'UserPassword', g_sSQLPassword);

    sDataDBFilePath := Conf.ReadString('DB', 'Dir', sDataDBFilePath);
    sHumDBFilePath := Conf.ReadString('DB', 'HumDir', sHumDBFilePath);
    sFeedPath    := Conf.ReadString('DB', 'FeeDir', sFeedPath);
    sBackupPath  := Conf.ReadString('DB', 'Backup', sBackupPath);
    sConnectPath := Conf.ReadString('DB', 'ConnectDir', sConnectPath);
    sLogPath     := Conf.ReadString('DB', 'LogDir', sLogPath);

    nServerPort := Conf.ReadInteger('Setup', 'ServerPort', nServerPort);
    sServerAddr := Conf.ReadString('Setup', 'ServerAddr', sServerAddr);

    g_nGatePort := Conf.ReadInteger('Setup', 'GatePort', g_nGatePort);
    g_sGateAddr := Conf.ReadString('Setup', 'GateAddr', g_sGateAddr);

    sIDServerAddr := Conf.ReadString('Server', 'IDSAddr', sIDServerAddr);
    nIDServerPort := Conf.ReadInteger('Server', 'IDSPort', nIDServerPort);

    boViewHackMsg := Conf.ReadBool('Setup', 'ViewHackMsg', boViewHackMsg);
    sServerName := Conf.ReadString('Setup', 'ServerName', sServerName);
    {
    boClearLevel1:=Conf.ReadBool('DBClear','ClearLevel1',boClearLevel1);
    boClearLevel2:=Conf.ReadBool('DBClear','ClearLevel2',boClearLevel2);
    boClearLevel3:=Conf.ReadBool('DBClear','ClearLevel3',boClearLevel3);
    }
    dwInterval := Conf.ReadInteger('DBClear', 'Interval', dwInterval);
    nLevel1 := Conf.ReadInteger('DBClear', 'Level1', nLevel1);
    nLevel2 := Conf.ReadInteger('DBClear', 'Level2', nLevel2);
    nLevel3 := Conf.ReadInteger('DBClear', 'Level3', nLevel3);
    nDay1   := Conf.ReadInteger('DBClear', 'Day1', nDay1);
    nDay2   := Conf.ReadInteger('DBClear', 'Day2', nDay2);
    nDay3   := Conf.ReadInteger('DBClear', 'Day3', nDay3);
    nMonth1 := Conf.ReadInteger('DBClear', 'Month1', nMonth1);
    nMonth2 := Conf.ReadInteger('DBClear', 'Month2', nMonth2);
    nMonth3 := Conf.ReadInteger('DBClear', 'Month3', nMonth3);

    LoadInteger := Conf.ReadInteger('Setup', 'DynamicIPMode', -1);
    if LoadInteger < 0 then begin
      Conf.WriteBool('Setup', 'DynamicIPMode', g_boDynamicIPMode);
    end else
      g_boDynamicIPMode := LoadInteger = 1;

    g_boEnglishNames := Conf.ReadBool('Setup', 'EnglishNameOnly', g_boEnglishNames);

    Conf.Free;
  end;
  LoadIPTable();
  LoadGateID();
end;

function CheckChrName(sChrName: string): boolean;
  //0x0045BE60
var
  I:   integer;
  Chr: char;
  boIsTwoByte: boolean;
  FirstChr: char;
begin
  Result      := True;
  boIsTwoByte := False;
  FirstChr    := #0;
  for I := 1 to length(sChrName) do begin
    Chr := (sChrName[i]);
    if boIsTwoByte then begin
      //if Chr < #$A1 then Result:=False; //如果小于就是非法字符
      //      if Chr < #$81 then Result:=False; //如果小于就是非法字符

      if not ((FirstChr <= #$F7) and (Chr >= #$40) and (Chr <= #$FE)) then
        if not ((FirstChr > #$F7) and (Chr >= #$40) and (Chr <= #$A0)) then
          Result := False;




      boIsTwoByte := False;
    end else begin //0045BEC0
      //if (Chr >= #$B0) and (Chr <= #$C8) then begin
      if (Chr >= #$81) and (Chr <= #$FE) then begin
        boIsTwoByte := True;
        FirstChr    := Chr;
      end else begin //0x0045BED2
        if not ((Chr >= '0'{#30}) and (Chr <= '9'{#39})) and not
          ((Chr >= 'a'{#61}) and (Chr <= 'z'){#7A}) and not
          ((Chr >= 'A'{#41}) and (Chr <= 'Z'{#5A})) then Result := False;
      end;
    end;
    if not Result then break;
  end;

end;

function InClearMakeIndexList(nIndex: integer): boolean;
var
  I: integer;
begin
  Result := False;
  for I := 0 to g_ClearMakeIndex.Count - 1 do begin
    if nIndex = integer(g_ClearMakeIndex.Objects[I]) then begin
      Result := True;
      break;
    end;
  end;
end;

procedure OutMainMessage(sMsg: string);
begin
  WriteLogMsg(sMsg);
  FrmDBSrv.MemoLog.Lines.Add(sMsg);
end;

procedure WriteLogMsg(sMsg: string);
begin

end;

function CheckServerIP(sIP: string): boolean;
var
  i: integer;
begin
  Result := False;
  for I := 0 to ServerIPList.Count - 1 do begin
    if CompareText(sIP, ServerIPList.Strings[i]) = 0 then begin
      Result := True;
      break;
    end;
  end;
end;


initialization
begin
  InitializeCriticalSection(HumDB_CS);
  DenyChrNameList := TStringList.Create;
  ServerIPList    := TStringList.Create;
  GateIDList      := TStringList.Create;
  g_ClearMakeIndex := TStringList.Create;
end;

finalization
begin
  DenyChrNameList.Free;
  ServerIPList.Free;
  GateIDList.Free;
  g_ClearMakeIndex.Free;
end;

end.
