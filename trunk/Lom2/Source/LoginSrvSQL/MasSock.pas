unit MasSock;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, JSocket;

type
  TMsgServerInfo = record
    sReceiveMsg: string;
    Socket:      TCustomWinSocket;
    sServerName: string;                //0x08
    nServerIndex: integer;              //0x0C
    nOnlineCount: integer;              //0x10
    dwKeepAliveTick: longword;          //0x14
    sIPaddr:     string;
  end;
  pTMsgServerInfo = ^TMsgServerInfo;

  TLimitServerUserInfo = record
    sServerName: string;
    sName: string;
    nLimitCountMin: integer;
    nLimitCountMax: integer;
  end;
  pTLimitServerUserInfo = ^TLimitServerUserInfo;

  TFrmMasSoc = class(TForm)
    MSocket: TServerSocket;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure MSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure MSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: integer);
    procedure MSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    procedure SortServerList(nIndex: integer);
    procedure RefServerLimit(sServerName: string);
    function LimitName(sServerName: string): string;
    procedure LoadUserLimit;
    { Private declarations }
  public
    m_ServerList: TList;
    procedure LoadServerAddr();
    function CheckReadyServers(): boolean;
    procedure SendServerMsg(wIdent: word; sServerName, sMsg: string);
    procedure SendServerMsgA(wIdent: word; sMsg: string);
    function IsNotUserFull(sServerName: string): boolean;
    function ServerStatus(sServerName: string): integer;
    function GetOnlineHumCount(): integer;
    { Public declarations }
  end;

var
  FrmMasSoc:  TFrmMasSoc;
  nUserLimit: integer;
  UserLimit:  array[0..99] of TLimitServerUserInfo;

implementation

uses LSShare, LMain, HUtil32, Grobal2;

{$R *.DFM}
//00465934
procedure TFrmMasSoc.FormCreate(Sender: TObject);
var
  Config: pTConfig;
begin
  Config := @g_Config;
  m_ServerList := TList.Create;
  MSocket.Address := Config.sServerAddr;
  MSocket.Port := Config.nServerPort;
  MSocket.Active := True;
  LoadServerAddr();
  LoadUserLimit();
end;
//00465B08
procedure TFrmMasSoc.MSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  I: integer;
  sRemoteAddr: string;
  boAllowed: boolean;
  MsgServer: pTMsgServerInfo;
begin
  sRemoteAddr := Socket.RemoteAddress;
  boAllowed   := False;
  for I := Low(ServerAddr) to High(ServerAddr) do
    if sRemoteAddr = ServerAddr[I] then begin
      boAllowed := True;
      break;
    end;
  if boAllowed then begin
    New(MsgServer);
    FillChar(MsgServer^, SizeOf(TMsgServerInfo), #0);
    MsgServer.sReceiveMsg := '';
    MsgServer.Socket      := Socket;
    m_ServerList.Add(MsgServer);
  end else begin
    MainOutMessage('非法地址连接:' + sRemoteAddr);
    Socket.Close;
  end;
end;
//00465C54
procedure TFrmMasSoc.MSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
var
  I: integer;
  MsgServer: pTMsgServerInfo;
begin
  for I := 0 to m_ServerList.Count - 1 do begin
    MsgServer := m_ServerList.Items[I];
    if MsgServer.Socket = Socket then begin
      Dispose(MsgServer);
      m_ServerList.Delete(I);
      break;
    end;
  end;
end;

procedure TFrmMasSoc.MSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;
//0046611C
procedure TFrmMasSoc.MSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  I:      integer;
  MsgServer: pTMsgServerInfo;
  sReviceMsg: string;
  sMsg:   string;
  sCode:  string;
  sAccount: string;
  sServerName: string;
  sIndex: string;
  sOnlineCount: string;
  nCode:  integer;
  Config: pTConfig;
begin
  Config := @g_Config;
  for I := 0 to m_ServerList.Count - 1 do begin
    MsgServer := m_ServerList.Items[I];
    if MsgServer.Socket = Socket then begin
      sReviceMsg := MsgServer.sReceiveMsg + Socket.ReceiveText;
      while (Pos(')', sReviceMsg) > 0) do begin
        sReviceMsg := ArrestStringEx(sReviceMsg, '(', ')', sMsg);
        if sMsg = '' then break;
        sMsg  := GetValidStr3(sMsg, sCode, ['/']);
        nCode := Str_ToInt(sCode, -1);
        case nCode of
          SS_SOFTOUTSESSION: begin
            sMsg := GetValidStr3(sMsg, sAccount, ['/']);
            CloseUser(Config, sAccount, Str_ToInt(sMsg, 0));
          end;
          SS_SERVERINFO: begin
            sMsg := GetValidStr3(sMsg, sServerName, ['/']);
            sMsg := GetValidStr3(sMsg, sIndex, ['/']);
            sMsg := GetValidStr3(sMsg, sOnlineCount, ['/']);
            MsgServer.sServerName := sServerName;
            MsgServer.nServerIndex := Str_ToInt(sIndex, 0);
            MsgServer.nOnlineCount := Str_ToInt(sOnlineCount, 0);
            MsgServer.dwKeepAliveTick := GetTickCount();
            SortServerList(I);
            nOnlineCountMin := GetOnlineHumCount();
            if nOnlineCountMin > nOnlineCountMax then
              nOnlineCountMax := nOnlineCountMin;
            SendServerMsgA(SS_KEEPALIVE, IntToStr(nOnlineCountMin));
            RefServerLimit(sServerName);
          end;
          UNKNOWMSG: SendServerMsgA(UNKNOWMSG, sMsg);
          else begin
            FrmMain.Memo1.Lines.Add('MsgServer Ident: '+IntToStr(nCode)); //Damian - Debugging purposes
          end;
        end;
      end;
    end;
    MsgServer.sReceiveMsg := sReviceMsg;
  end;
end;

procedure TFrmMasSoc.FormDestroy(Sender: TObject);
begin
  m_ServerList.Free;
end;

//00465CF8
procedure TFrmMasSoc.RefServerLimit(sServerName: string);
var
  I:      integer;
  nCount: integer;
  MsgServer: pTMsgServerInfo;
begin
  try
    nCount := 0;
    for I := 0 to m_ServerList.Count - 1 do begin
      MsgServer := m_ServerList.Items[I];
      if (MsgServer.nServerIndex <> 99) and (MsgServer.sServerName = sServerName) then
        Inc(nCount, MsgServer.nOnlineCount);
    end;
    for I := Low(UserLimit) to High(UserLimit) do begin
      if UserLimit[I].sServerName = sServerName then begin
        UserLimit[I].nLimitCountMin := nCount;
        break;
      end;
    end;
  except
    MainOutMessage('TFrmMasSoc.RefServerLimit');
  end;
end;


//00465E78
function TFrmMasSoc.IsNotUserFull(sServerName: string): boolean;
var
  I: integer;
begin
  Result := True;
  for I := Low(UserLimit) to High(UserLimit) do begin
    if UserLimit[I].sServerName = sServerName then begin
      if UserLimit[I].nLimitCountMin > UserLimit[I].nLimitCountMax then
        Result := False;
      break;
    end;
  end;
end;
//00465F18
procedure TFrmMasSoc.SortServerList(nIndex: integer);
var
  nC, n10, n14:  integer;
  MsgServerSort: pTMsgServerInfo;
  MsgServer:     pTMsgServerInfo;
  nNewIndex:     integer;
begin
  try
    if m_ServerList.Count <= nIndex then exit;
    MsgServerSort := m_ServerList.Items[nIndex];
    m_ServerList.Delete(nIndex);
    for nC := 0 to m_ServerList.Count - 1 do begin
      MsgServer := m_ServerList.Items[nC];
      if MsgServer.sServerName = MsgServerSort.sServerName then begin
        if MsgServer.nServerIndex < MsgServerSort.nServerIndex then begin
          m_ServerList.Insert(nC, MsgServerSort);
          exit;
        end else begin //00465FD8
          nNewIndex := nC + 1;
          if nNewIndex < m_ServerList.Count then begin   //Jacky 增加
            for n10 := nNewIndex to m_ServerList.Count - 1 do begin
              MsgServer := m_ServerList.Items[n10];
              if MsgServer.sServerName = MsgServerSort.sServerName then
              begin
                if MsgServer.nServerIndex < MsgServerSort.nServerIndex then
                begin
                  m_ServerList.Insert(n10, MsgServerSort);
                  for n14 := n10 + 1 to m_ServerList.Count - 1 do begin
                    MsgServer := m_ServerList.Items[n14];
                    if (MsgServer.sServerName = MsgServerSort.sServerName) and
                      (MsgServer.nServerIndex = MsgServerSort.nServerIndex) then
                    begin
                      m_ServerList.Delete(n14);
                      exit;
                    end;
                  end;
                  exit;
                end else begin //004660D1
                  nNewIndex := n10 + 1;
                end;
              end;
            end; //00465FF1
            m_ServerList.Insert(nNewIndex, MsgServerSort);
            exit;
          end;
        end;
      end;
    end;
    m_ServerList.Add(MsgServerSort);
  except
    MainOutMessage('TFrmMasSoc.SortServerList');
  end;
end;


//004665BD
procedure TFrmMasSoc.SendServerMsg(wIdent: word; sServerName, sMsg: string);
var
  I:   integer;
  MsgServer: pTMsgServerInfo;
  sSendMsg: string;
  s18: string;
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  try
    s18      := LimitName(sServerName);
    sSendMsg := format(sFormatMsg, [wIdent, sMsg]);
    for I := 0 to m_ServerList.Count - 1 do begin
      MsgServer := pTMsgServerInfo(m_ServerList.Items[I]);
      if MsgServer.Socket.Connected then begin
        if (s18 = '') or (MsgServer.sServerName = '') or
          (CompareText(MsgServer.sServerName, s18) = 0) or
          (MsgServer.nServerIndex = 99) then begin
          MsgServer.Socket.SendText(sSendMsg);
        end;
      end;
    end;
  except
    MainOutMessage('TFrmMasSoc.SendServerMsg');
  end;
end;
//004659BC
procedure TFrmMasSoc.LoadServerAddr();
var
  sFileName:     string;
  LoadList:      TStringList;
  I, nServerIdx: integer;
  sLineText:     string;
begin
  sFileName  := '.\!ServerAddr.txt';
  nServerIdx := 0;
  FillChar(ServerAddr, SizeOf(ServerAddr), #0);
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := Trim(LoadList.Strings[i]);
      if (sLineText <> '') and (sLineText[I] <> ';') then begin
        if TagCount(sLineText, '.') = 3 then begin
          ServerAddr[nServerIdx] := sLineText;
          Inc(nServerIdx);
          if nServerIdx >= 100 then break;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;


//00466460
function TFrmMasSoc.GetOnlineHumCount(): integer;
var
  i, nCount: integer;
  MsgServer: pTMsgServerInfo;
begin
  Result := 0;
  nCount := 0;

  try
    for i := 0 to m_ServerList.Count - 1 do begin
      MsgServer := m_ServerList.Items[i];
      if MsgServer.nServerIndex <> 99 then Inc(nCount, MsgServer.nOnlineCount);
    end;
    Result := nCount;
  except
    MainOutMessage('TFrmMasSoc.GetOnlineHumCount');
  end;
end;
//00465AD8
function TFrmMasSoc.CheckReadyServers: boolean;
var
  Config: pTConfig;
begin
  Config := @g_Config;
  Result := False;
  if m_ServerList.Count >= Config.nReadyServers then Result := True;
end;

//004664B0
procedure TFrmMasSoc.SendServerMsgA(wIdent: word; sMsg: string);
var
  I: integer;
  sSendMsg: string;
  MsgServer: pTMsgServerInfo;
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  try
    sSendMsg := format(sFormatMsg, [wIdent, sMsg]);
    for I := 0 to m_ServerList.Count - 1 do begin
      MsgServer := pTMsgServerInfo(m_ServerList.Items[I]);
      if MsgServer.Socket.Connected then MsgServer.Socket.SendText(sSendMsg);
    end;
  except
    on e: Exception do begin
      MainOutMessage('TFrmMasSoc.SendServerMsgA');
      MainOutMessage(E.Message);
    end;
  end;
end;
//00465DE0
function TFrmMasSoc.LimitName(sServerName: string): string;
var
  i: integer;
begin
  try
    Result := '';
    for i := Low(UserLimit) to High(UserLimit) do begin
      if CompareText(UserLimit[i].sServerName, sServerName) = 0 then begin
        Result := UserLimit[i].sName;
        break;
      end;
    end;
  except
    MainOutMessage('TFrmMasSoc.LimitName');
  end;
end;
//00465730
procedure TFrmMasSoc.LoadUserLimit();
var
  LoadList:  TStringList;
  sFileName: string;
  i, nC:     integer;
  sLineText, sServerName, s10, s14: string;

begin
  nC := 0;
  sFileName := '.\!UserLimit.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for i := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[i];
      sLineText := GetValidStr3(sLineText, sServerName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, s10, [' ', #9]);
      sLineText := GetValidStr3(sLineText, s14, [' ', #9]);
      if sServerName <> '' then begin
        UserLimit[nC].sServerName := sServerName;
        UserLimit[nC].sName := s10;
        UserLimit[nC].nLimitCountMax := Str_ToInt(s14, 3000);
        UserLimit[nC].nLimitCountMin := 0;
        Inc(nC);
      end;
    end;
    nUserLimit := nC;
    LoadList.Free;
  end else
    ShowMessage('[Critical Failure] file not found. .\!UserLimit.txt');
end;

function TFrmMasSoc.ServerStatus(sServerName: string): integer;
var
  I: integer;
  nStatus: integer;
  MsgServer: pTMsgServerInfo;
  boServerOnLine: boolean;
begin
  nStatus := 0;
  Result := 0;
  boServerOnLine := False;
  
  try
    for I := 0 to m_ServerList.Count - 1 do begin
      MsgServer := m_ServerList.Items[I];
      if (MsgServer.nServerIndex <> 99) and (MsgServer.sServerName = sServerName) then
      begin
        boServerOnLine := True;
      end;
    end;
    if not boServerOnLine then exit;

    for I := Low(UserLimit) to High(UserLimit) do begin
      if UserLimit[I].sServerName = sServerName then begin
        if UserLimit[I].nLimitCountMin <= UserLimit[I].nLimitCountMax div 2 then
        begin
          nStatus := 1; //空闲
          break;
        end;

        if UserLimit[I].nLimitCountMin <= UserLimit[I].nLimitCountMax -
        (UserLimit[I].nLimitCountMax div 5) then begin
          nStatus := 2; //良好
          break;
        end;
        if UserLimit[I].nLimitCountMin < UserLimit[I].nLimitCountMax then begin
          nStatus := 3; //繁忙
          break;
        end;
        if UserLimit[I].nLimitCountMin >= UserLimit[I].nLimitCountMax then begin
          nStatus := 4; //满员
          break;
        end;
      end;
    end;
    Result := nStatus;
  except
    MainOutMessage('TFrmMasSoc.ServerStatus');
  end;
end;

end.
