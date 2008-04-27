unit DBSMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JSocket, Buttons, IniFiles,
  Menus, Grobal2;

type
  pTServerInfo = ^TServerInfo;
  TServerInfo = record
    nSckHandle: integer;           //0x00
    sStr:   string;                //0x04
    bo08:   boolean;               //0x08
    Socket: TCustomWinSocket;      //0x0C
  end;

  pTHumSession = ^THumSession;
  THumSession = record
    sChrName: string;
    nIndex:   integer;
    Socket:   TCustomWinSocket; //0x20
    bo24:     boolean;
    bo2C:     boolean;
    dwTick30: longword;
  end;

  TFrmDBSrv = class(TForm)
    ServerSocket: TServerSocket;
    Timer1: TTimer;
    AniTimer: TTimer;
    StartTimer: TTimer;
    Timer2: TTimer;
    MemoLog: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LbAutoClean: TLabel;
    Panel2: TPanel;
    BtnUserDBTool: TSpeedButton;
    LbTransCount: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LbUserCount: TLabel;
    BtnReloadAddr: TButton;
    BtnEditAddrs: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CkViewHackMsg: TCheckBox;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    V1:    TMenuItem;
    MENU_OPTION: TMenuItem;
    MENU_MANAGE: TMenuItem;
    MENU_OPTION_GENERAL: TMenuItem;
    MENU_OPTION_GAMEGATE: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    N1:    TMenuItem;
    G1:    TMenuItem;
    MENU_MANAGE_DATA: TMenuItem;
    MENU_MANAGE_TOOL: TMenuItem;
    MENU_TEST: TMenuItem;
    MENU_TEST_SELGATE: TMenuItem;
    Exit1: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure AniTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure BtnUserDBToolClick(Sender: TObject);
    procedure BtnReloadAddrClick(Sender: TObject);
    procedure BtnEditAddrsClick(Sender: TObject);
    procedure CkViewHackMsgClick(Sender: TObject);
    procedure WriteLogMsg(sMsg: string);
    procedure OutMainMessageA(sMsg: string);
    procedure ServerSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: integer);
    procedure ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure MENU_MANAGE_DATAClick(Sender: TObject);
    procedure MENU_MANAGE_TOOLClick(Sender: TObject);
    procedure V1Click(Sender: TObject);
    procedure MENU_TEST_SELGATEClick(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    n334:     integer;
    m_DefMsg: TDefaultMessage;
    n344:     integer;
    n348:     integer;
    s34C:     string;

    ServerList:      TList; //0x354
    HumSessionList:  TList; //0x358
    m_boRemoteClose: boolean;
    procedure MainOutMessage(sMsg: string);
    procedure ProcessServerPacket(ServerInfo: pTServerInfo);
    procedure ProcessServerMsg(sMsg: string; nLen: integer;
      Socket: TCustomWinSocket);
    procedure SendSocket(Socket: TCustomWinSocket; sMsg: string);
    procedure LoadHumanRcd(sMsg: string; Socket: TCustomWinSocket);
    procedure SaveHumanRcd(nRecog: integer; sMsg: string; Socket: TCustomWinSocket);
    procedure SaveHumanRcdEx(sMsg: string; nRecog: integer;
      Socket: TCustomWinSocket);
    procedure ClearSocket(Socket: TCustomWinSocket);

    { Private declarations }
  public
    function CopyHumData(sSrcChrName, sDestChrName, sUserID: string): boolean;
    procedure DelHum(sChrName: string);
    { Public declarations }
  end;

var
  FrmDBSrv: TFrmDBSrv;

implementation

uses HumDB, DBShare, FIDHum, UsrSoc, AddrEdit, HUtil32, EDcode,
  IDSocCli, DBTools, TestSelGate, RouteManage;

{$R *.DFM}

procedure TFrmDBSrv.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  ServerInfo: pTServerInfo;
  sIPaddr:    string;
begin
  sIPaddr := Socket.RemoteAddress;
  if not CheckServerIP(sIPaddr) then begin
    OutMainMessage('Invalid connection: ' + sIPaddr);
    Socket.Close;
    exit;
  end;

  if not boOpenDBBusy then begin
    New(ServerInfo);
    ServerInfo.bo08   := True;
    ServerInfo.nSckHandle := Socket.SocketHandle;
    ServerInfo.sStr   := '';
    ServerInfo.Socket := Socket;
    ServerList.Add(ServerInfo);
  end else begin
    Socket.Close;
  end;
end;

procedure TFrmDBSrv.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: integer;
  ServerInfo: pTServerInfo;
begin
  for i := 0 to ServerList.Count - 1 do begin
    ServerInfo := ServerList.Items[i];
    if ServerInfo.nSckHandle = Socket.SocketHandle then begin
      Dispose(ServerInfo);
      ServerList.Delete(i);
      ClearSocket(Socket);
      break;
    end;
  end;
end;

procedure TFrmDBSrv.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmDBSrv.ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  i:   integer;
  ServerInfo: pTServerInfo;
  s10: string;
begin
  g_CheckCode.dwThread0 := 1001000;
  for i := 0 to ServerList.Count - 1 do begin
    g_CheckCode.dwThread0 := 1001001;
    ServerInfo := ServerList.Items[i];
    g_CheckCode.dwThread0 := 1001002;
    if ServerInfo.nSckHandle = Socket.SocketHandle then begin
      g_CheckCode.dwThread0 := 1001003;
      s10 := Socket.ReceiveText;
      Inc(n4ADBF4);
      if s10 <> '' then begin
        g_CheckCode.dwThread0 := 1001004;
        ServerInfo.sStr := ServerInfo.sStr + s10;
        g_CheckCode.dwThread0 := 1001005;
        if Pos('!', s10) > 0 then begin
          g_CheckCode.dwThread0 := 1001006;
          ProcessServerPacket(ServerInfo);
          g_CheckCode.dwThread0 := 1001007;
          Inc(n4ADBF8);
          Inc(n348);
          Break;
        end else begin//004A7DC7
          if Length(ServerInfo.sStr) > 81920 then begin
            ServerInfo.sStr := '';
            Inc(n4ADC2C);
          end;
        end;
      end;
      Break;
    end;
  end;
  g_CheckCode.dwThread0 := 1001008;
end;

procedure TFrmDBSrv.ProcessServerPacket(ServerInfo: pTServerInfo);
var
  bo25:     boolean;
  sC, s1C, s20, s24: string;
  n14, n18: integer;
  wE, w10:  word;
begin
  g_CheckCode.dwThread0 := 1001100;
  if boOpenDBBusy then exit;
  try
    bo25 := False;
    s1C  := ServerInfo.sStr;
    ServerInfo.sStr := '';
    s20  := '';
    g_CheckCode.dwThread0 := 1001101;
    s1C  := ArrestStringEx(s1C, '#', '!', s20);
    g_CheckCode.dwThread0 := 1001102;
    if s20 <> '' then begin
      g_CheckCode.dwThread0 := 1001103;
      s20 := GetValidStr3(s20, s24, ['/']);
      n14 := length(s20);
      if (n14 >= DEFBLOCKSIZE) and (s24 <> '') then begin
        wE   := Str_ToInt(s24, 0) xor 170;
        w10  := n14;
        n18  := MakeLong(wE, w10);
        sC   := EncodeBuffer(@n18, SizeOf(integer));
        s34C := s24;
        if CompareBackLStr(s20, sC, Length(sC)) then begin
          g_CheckCode.dwThread0 := 1001104;
          ProcessServerMsg(s20, n14, ServerInfo.Socket);
          g_CheckCode.dwThread0 := 1001105;
          bo25 := True;
        end;
      end; //0x004A7F7B
    end; //0x004A7F7B
    if s1C <> '' then begin
      Inc(n4ADC00);
      Label4.Caption := 'Error ' + IntToStr(n4ADC00);
    end; //0x004A7FB5
    if not bo25 then begin
      m_DefMsg := MakeDefaultMsg(DBR_FAIL, 0, 0, 0, 0);
      {
      DefMsg:=MakeDefaultMsg(DBR_FAIL,0,0,0,0);
      n338:=DefMsg.Recog;
      n33C:=DefMsg.Ident;
      n340:=DefMsg.Tag;
      }
      SendSocket(ServerInfo.Socket, EncodeMessage(m_DefMsg));
      Inc(n4ADC00);
      Label4.Caption := 'Error ' + IntToStr(n4ADC00);
    end; //0x004A8048
  finally
  end;
  g_CheckCode.dwThread0 := 1001106;
end;

procedure TFrmDBSrv.SendSocket(Socket: TCustomWinSocket; sMsg: string);//0x004A8764
var
  n10: integer;
  s18: string;
begin
  Inc(n4ADBFC);
  n10 := MakeLong(Str_ToInt(s34C, 0) xor 170, Length(sMsg) + 6);
  s18 := EncodeBuffer(@n10, SizeOf(integer));
  Socket.SendText('#' + s34C + '/' + sMsg + s18 + '!');
end;

procedure TFrmDBSrv.ProcessServerMsg(sMsg: string; nLen: integer;
  Socket: TCustomWinSocket);
//0x004A9278
var
  sDefMsg, sData: string;
  DefMsg: TDefaultMessage;
begin
  if nLen = DEFBLOCKSIZE then begin
    sDefMsg := sMsg;
    sData   := '';
  end else begin
    sDefMsg := Copy(sMsg, 1, DEFBLOCKSIZE);
    sData   := Copy(sMsg, DEFBLOCKSIZE + 1, Length(sMsg) - DEFBLOCKSIZE - 6);
  end; //0x004A9304
  DefMsg := DecodeMessage(sDefMsg);
  case DefMsg.Ident of
    DB_LOADHUMANRCD: begin
      LoadHumanRcd(sData, Socket);
    end;
    DB_SAVEHUMANRCD: begin
      SaveHumanRcd(DefMsg.Recog, sData, Socket);
    end;
    DB_SAVEHUMANRCDEX: begin
      SaveHumanRcdEx(sData, DefMsg.Recog, Socket);
    end;
    else begin
      m_DefMsg := MakeDefaultMsg(DBR_FAIL, 0, 0, 0, 0);
      SendSocket(Socket, EncodeMessage(m_DefMsg));
      Inc(n4ADC04);
    end;
  end;
  g_CheckCode.dwThread0 := 1001216;
end;

procedure TFrmDBSrv.LoadHumanRcd(sMsg: string; Socket: TCustomWinSocket);
var
  sHumName:   string;
  sAccount:   string;
  sIPaddr:    string;
  nIndex:     integer;
  nSessionID: integer;
  nCheckCode: integer;
  HumanRCD:   THumDataInfo;
  LoadHuman:  TLoadHuman;
  boFoundSession: boolean;
begin
  DecodeBuffer(sMsg, @LoadHuman, SizeOf(TLoadHuman));
  sAccount   := LoadHuman.sAccount;
  sHumName   := LoadHuman.sChrName;
  sIPaddr    := LoadHuman.sUserAddr;
  nSessionID := LoadHuman.nSessionID;
  nCheckCode := -1;
  if (sAccount <> '') and (sHumName <> '') then begin
    if (FrmIDSoc.CheckSessionLoadRcd(sAccount, sIPaddr, nSessionID, boFoundSession)) then
    begin
      nCheckCode := 1;
    end else begin
      if boFoundSession then begin
        OutMainMessage('[非法重复请求] ' + '帐号: ' + sAccount +
          ' IP: ' + sIPaddr + ' 标识: ' + IntToStr(nSessionID));
      end else begin
        OutMainMessage('[非法请求] ' + '帐号: ' + sAccount + ' IP: ' +
          sIPaddr + ' 标识: ' + IntToStr(nSessionID));
      end;
      //nCheckCode:= 1; //测试用，正常去掉
    end;
  end;
  if nCheckCode = 1 then begin
    try
      if HumDataDB.Open then begin
        nIndex := HumDataDB.Index(sHumName);
        if nIndex >= 0 then begin
          if HumDataDB.Get(nIndex, HumanRCD) < 0 then nCheckCode := -2;
        end else
          nCheckCode := -3;
      end else
        nCheckCode := -4;
    finally
      HumDataDB.Close();
    end;
  end;

  if nCheckCode = 1 then begin
    m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, 1, 0, 0, 1);
    SendSocket(Socket, EncodeMessage(m_DefMsg) + EncodeString(sHumName) +
      '/' + EncodeBuffer(@HumanRCD.Data, SizeOf(THumData)));
  end else begin //0x004A8C7E
    m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, nCheckCode, 0, 0, 0);
    SendSocket(Socket, EncodeMessage(m_DefMsg));
  end;
end;
//004A8D38
procedure TFrmDBSrv.SaveHumanRcd(nRecog: integer; sMsg: string;
  Socket: TCustomWinSocket);
var
  sChrName: string;
  sUserID: string;
  sHumanRCD: string;
  I:      integer;
  nIndex: integer;
  bo21:   boolean;
  HumData: THumData;
  HumanRCD: THumDataInfo;
  HumSession: pTHumSession;
begin
  sHumanRCD := GetValidStr3(sMsg, sUserID, ['/']);
  sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
  sUserID   := DecodeString(sUserID);
  sChrName  := DecodeString(sChrName);
  bo21      := False;
  FillChar(HumData, SizeOf(THumData), #0);
  FillChar(HumanRCD, SizeOf(THumDataInfo), #0);
  if Length(sHumanRCD) = GetCodeMsgSize(SizeOf(THumData) * 4 / 3) then
    DecodeBuffer(sHumanRCD, @HumData, SizeOf(THumData))
  else
    bo21 := True;
  if not bo21 then begin
    bo21 := True;
    try
      if HumDataDB.Open then begin
        nIndex := HumDataDB.Index(sChrName);
        if nIndex < 0 then begin
          HumanRCD.Header.sChrName := sChrName;
          HumanRCD.Data := HumData;
          HumDataDB.Add(HumanRCD);
          nIndex := HumDataDB.Index(sChrName);
        end;
        if nIndex >= 0 then begin
          HumDataDB.Get(nIndex, HumanRCD);

          HumanRCD.Header.sChrName := sChrName;
          HumanRCD.Data := HumData;
          HumDataDB.Update(nIndex, HumanRCD);
          bo21 := False;
        end;
      end;
    finally
      HumDataDB.Close;
    end;
    FrmIDSoc.SetSessionSaveRcd(sUserID);
  end;
  if not bo21 then begin
    for i := 0 to HumSessionList.Count - 1 do begin
      HumSession := HumSessionList.Items[i];
      if (HumSession.sChrName = sChrName) and (HumSession.nIndex = nRecog) then
      begin
        HumSession.dwTick30 := GetTickCount();
        break;
      end;
    end;
    m_DefMsg := MakeDefaultMsg(DBR_SAVEHUMANRCD, 1, 0, 0, 0);
    SendSocket(Socket, EncodeMessage(m_DefMsg));
  end else begin
    m_DefMsg := MakeDefaultMsg(DBR_LOADHUMANRCD, 0, 0, 0, 0);
    SendSocket(Socket, EncodeMessage(m_DefMsg));
  end;
end;
//004A9104
procedure TFrmDBSrv.SaveHumanRcdEx(sMsg: string; nRecog: integer;
  Socket: TCustomWinSocket);
var
  sChrName: string;
  sUserID: string;
  sHumanRCD: string;
  I:      integer;
  HumSession: pTHumSession;
begin
  sHumanRCD := GetValidStr3(sMsg, sUserID, ['/']);
  sHumanRCD := GetValidStr3(sHumanRCD, sChrName, ['/']);
  sUserID   := DecodeString(sUserID);
  sChrName  := DecodeString(sChrName);
  for i := 0 to HumSessionList.Count - 1 do begin
    HumSession := HumSessionList.Items[i];
    if (HumSession.sChrName = sChrName) and (HumSession.nIndex = nRecog) then begin
      HumSession.bo24     := False;
      HumSession.Socket   := Socket;
      HumSession.bo2C     := True;
      HumSession.dwTick30 := GetTickCount();
      break;
    end;
  end;
  SaveHumanRcd(nRecog, sMsg, Socket);
end;

procedure TFrmDBSrv.Timer1Timer(Sender: TObject);
begin
  LbTransCount.Caption := IntToStr(n348);
  n348 := 0;
  if ServerList.Count > 0 then Label1.Caption := 'Ready...'
  else
    Label1.Caption := 'Not Ready !!';
  Label2.Caption := 'ServerCount: ' + IntToStr(ServerList.Count);
  LbUserCount.Caption := IntToStr(FrmUserSoc.GetUserCount);
  if boOpenDBBusy then begin
    if n4ADB18 > 0 then begin
      if not bo4ADB1C then begin
        Label4.Caption := '[1/4] ' + IntToStr(ROUND((n4ADB10 / n4ADB18) * 1.0e2)) +
          '% ' + IntToStr(n4ADB14) + '/' + IntToStr(n4ADB18);
      end;//004A82CA
    end;//004A82CA
    if n4ADB04 > 0 then begin
      if not boHumDBReady then begin
        Label4.Caption := '[3/4] ' + IntToStr(ROUND((n4ADAFC / n4ADB04) * 1.0e2)) +
          '% ' + IntToStr(n4ADB00) + '/' + IntToStr(n4ADB04);
      end;//004A835B
    end;//004A835B
    if n4ADAF0 > 0 then begin
      if not boDataDBReady then begin
        Label4.Caption := '[4/4] ' + IntToStr(ROUND((n4ADAE4 / n4ADAF0) * 1.0e2)) +
          '% ' + IntToStr(n4ADAE8) + '/' + IntToStr(n4ADAEC) +
          '/' + IntToStr(n4ADAF0);
      end;
    end;
  end;//004A8407

  LbAutoClean.Caption := IntToStr(g_nClearIndex) + '/(' + IntToStr(g_nClearCount) +
    '/' + IntToStr(g_nClearItemIndexCount) + ')/' + IntToStr(g_nClearRecordCount);

  Label8.Caption  := 'H-QyChr=' + IntToStr(g_nQueryChrCount);
  Label9.Caption  := 'H-NwChr=' + IntToStr(nHackerNewChrCount);
  Label10.Caption := 'H-DlChr=' + IntToStr(nHackerDelChrCount);
  Label11.Caption := 'Dubb-Sl=' + IntToStr(nHackerSelChrCount);
  if MemoLog.Lines.Count > 500 then MemoLog.Lines.Clear;
end;

procedure TFrmDBSrv.FormCreate(Sender: TObject);
var
  nX, nY: integer;
begin
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top  := nY;
  end;

  m_boRemoteClose := False;

  // SendGameCenterMsg(SG_FORMHANDLE,IntToStr(Self.Handle));

  boOpenDBBusy := True;
  label4.Caption := '';
  LbAutoClean.Caption := '-/-';
  HumChrDB  := nil;
  HumDataDB := nil;

  LoadConfig();
  ServerList := TList.Create;
  HumSessionList := TList.Create;
  Label5.Caption := 'FDB: ' + sDataDBFilePath + 'Mir.DB  ' + 'Backup: ' + sBackupPath;
  n334    := 0;
  ServerSocket.Address := sServerAddr;
  ServerSocket.Port := nServerPort;
  ServerSocket.Active := True;
  n4ADBF4 := 0;
  n4ADBF8 := 0;
  n4ADBFC := 0;
  n4ADC00 := 0;
  n4ADC04 := 0;
  n344    := 2;
  n348    := 0;
  nHackerNewChrCount := 0;
  nHackerDelChrCount := 0;
  nHackerSelChrCount := 0;
  n4ADC1C := 0;
  n4ADC20 := 0;
  n4ADC24 := 0;
  n4ADC28 := 0;
end;

procedure TFrmDBSrv.FormDestroy(Sender: TObject);
var
  i: integer;
  ServerInfo: pTServerInfo;
  HumSession: pTHumSession;
begin
  if HumDataDB <> nil then HumDataDB.Free;
  if HumChrDB <> nil then HumChrDB.Free;
  for i := 0 to ServerList.Count - 1 do begin
    ServerInfo := ServerList.Items[i];
    Dispose(ServerInfo);
  end;
  ServerList.Free;

  for i := 0 to HumSessionList.Count - 1 do begin
    HumSession := HumSessionList.Items[i];
    Dispose(HumSession);
  end;

  HumSessionList.Free;
end;

procedure TFrmDBSrv.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if m_boRemoteClose then exit;

  if MessageDlg('Do you want to quit DBServer?', mtConfirmation, [mbYes, mbNo], 0) =
    mrYes then begin
    CanClose := True;
    ServerSocket.Active := False;
    MainOutMessage('Server Closing...');
  end else begin
    CanClose := False;
  end;
end;

procedure TFrmDBSrv.AniTimerTimer(Sender: TObject);
begin
  if n334 > 7 then n334 := 0
  else
    Inc(n334);

  case n334 of
    0: Label3.Caption := '|';
    1: Label3.Caption := '/';
    2: Label3.Caption := '--';
    3: Label3.Caption := '\';
    4: Label3.Caption := '|';
    5: Label3.Caption := '/';
    6: Label3.Caption := '--';
    7: Label3.Caption := '\';
  end;
end;

procedure TFrmDBSrv.FormShow(Sender: TObject);
begin
  StartTimer.Enabled := True;
end;

procedure TFrmDBSrv.StartTimerTimer(Sender: TObject);
begin
  StartTimer.Enabled := False;
  boOpenDBBusy  := True;
  InitializeSQL;
  HumChrDB      := TFileHumDB.Create(sHumDBFilePath + 'Hum.DB');
  HumDataDB     := TFileDB.Create;
  boOpenDBBusy  := False;
  boAutoClearDB := True;
  Label4.Caption := '';
  FrmIDSoc.OpenConnect();
  OutMainMessage('Server Started...');

{  try
    if HumDataDB.Open then begin
      HumDataDB.Test;
    end;
  finally
    HumDataDB.Close;
  end;}
end;

procedure TFrmDBSrv.Timer2Timer(Sender: TObject);
var
  i: integer;
  HumSession: pTHumSession;
begin
  i := 0;

  while (True) do begin
    if HumSessionList.Count <= i then break;
    HumSession := HumSessionList.Items[i];
    if not HumSession.bo24 then begin
      if HumSession.bo2C then begin
        if (GetTickCount - HumSession.dwTick30) > 20 * 1000 then begin
          Dispose(HumSession);
          HumSessionList.Delete(i);
          Continue;
        end;
      end else begin//004A868F
        if (GetTickCount - HumSession.dwTick30) > 2 * 60 * 1000 then begin
          Dispose(HumSession);
          HumSessionList.Delete(i);
          Continue;
        end;
      end;
    end;//004A86D2
    if (GetTickCount - HumSession.dwTick30) > 40 * 60 * 1000 then begin
      Dispose(HumSession);
      HumSessionList.Delete(i);
      Continue;
    end;
    Inc(i);
  end;

end;

procedure TFrmDBSrv.BtnUserDBToolClick(Sender: TObject);
begin
  if boHumDBReady and boDataDBReady then FrmIDHum.Show;
end;

procedure TFrmDBSrv.BtnReloadAddrClick(Sender: TObject);
begin
  FrmUserSoc.LoadServerInfo();
  LoadIPTable();
  LoadGateID();
end;

procedure TFrmDBSrv.BtnEditAddrsClick(Sender: TObject);
begin
  FrmEditAddr.Open();
end;

procedure TFrmDBSrv.CkViewHackMsgClick(Sender: TObject);
var
  Conf: TIniFile;
begin
  Conf := TIniFile.Create(sConfFileName);
  if Conf <> nil then begin
    Conf.WriteBool('Setup', 'ViewHackMsg', CkViewHackMsg.Checked);
    Conf.Free;
  end;
end;

procedure TFrmDBSrv.WriteLogMsg(sMsg: string);
begin
//
end;

procedure TFrmDBSrv.OutMainMessageA(sMsg: string);
begin
//
end;

procedure TFrmDBSrv.MainOutMessage(sMsg: string);
begin
  MemoLog.Lines.Add(sMsg);
end;
//004A80DC
procedure TFrmDBSrv.ClearSocket(Socket: TCustomWinSocket);

var
  nIndex:     integer;
  HumSession: pTHumSession;
begin
  nIndex := 0;

  while (True) do begin
    if HumSessionList.Count <= nIndex then break;
    HumSession := HumSessionList.Items[nIndex];
    if HumSession.Socket = Socket then begin
      Dispose(HumSession);
      HumSessionList.Delete(nIndex);
      Continue;
    end;
    Inc(nIndex);
  end;

end;

function TFrmDBSrv.CopyHumData(sSrcChrName, sDestChrName, sUserID: string): boolean;
  //0x004A8864
var
  n14:      integer;
  bo15:     boolean;
  HumanRCD: THumDataInfo;
begin
  Result := False;
  bo15   := False;
  try
    if HumDataDB.Open then begin
      n14 := HumDataDB.Index(sSrcChrName);
      if (n14 >= 0) and (HumDataDB.Get(n14, HumanRCD) >= 0) then bo15 := True;
      if bo15 then begin
        n14 := HumDataDB.Index(sDestChrName);
        if (n14 >= 0) then begin
          HumanRCD.Header.sChrName  := sDestChrName;
          HumanRCD.Data.sChrName := sDestChrName;
          HumanRCD.Data.sAccount := sUserID;
          HumDataDB.Update(n14, HumanRCD);
          Result := True;
        end;
      end;
    end;
  finally
    HumDataDB.Close;
  end;
end;

procedure TFrmDBSrv.DelHum(sChrName: string);
//0x004A89F4
begin
  try
    if HumChrDB.Open then HumChrDB.Delete(sChrName);
  finally
    HumChrDB.Close;
  end;
end;



procedure TFrmDBSrv.MENU_MANAGE_DATAClick(Sender: TObject);
begin
  if boHumDBReady and boDataDBReady then FrmIDHum.Show;
end;

procedure TFrmDBSrv.MENU_MANAGE_TOOLClick(Sender: TObject);
begin
  frmDBTool.Top  := Self.Top + 20;
  frmDBTool.Left := Self.Left;
  frmDBTool.Open();
end;

procedure TFrmDBSrv.V1Click(Sender: TObject);
begin
  //showmessage(BoolToStr(CheckChrName('江湖浪客')));
end;

procedure TFrmDBSrv.MENU_TEST_SELGATEClick(Sender: TObject);
begin
  frmTestSelGate := TfrmTestSelGate.Create(Owner);
  frmTestSelGate.ShowModal;
  frmTestSelGate.Free;
end;

procedure TFrmDBSrv.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  if Sender = MENU_CONTROL_START then begin

  end else if Sender = MENU_OPTION_GAMEGATE then begin
    frmRouteManage.Open;
  end;

end;

procedure TFrmDBSrv.Exit1Click(Sender: TObject);
begin
  Close;
end;

end.
