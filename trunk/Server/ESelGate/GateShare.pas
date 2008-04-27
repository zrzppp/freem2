unit GateShare;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket, WinSock, SyncObjs,Common;
resourcestring
  g_sProductName = '飘飘网络防攻击登陆网关 V 1.0';
  g_sUpDateTime = '更新日期: 2006/09/12';
  g_sProgram = '程序制作: 叶随风飘 QQ:240621028';
  g_sWebSite = '程序网站: http://www.51ggame.com';
type
  TGList = Class(TList)
  private
    GLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  TBlockIPMethod = (mDisconnect, mBlock, mBlockList);

  TSockaddr = record
    nIPaddr: Integer;
    dwStartAttackTick: LongWord;
    nAttackCount:Integer;
  end;
  pTSockaddr = ^TSockaddr;

procedure LoadBlockIPFile();
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: String);
procedure SaveBlockIPList();
var
  CS_MainLog: TCriticalSection;
  CS_FilterMsg: TCriticalSection;
  MainLogMsgList: TStringList;
  BlockIPList: TGList;
  TempBlockIPList: TGList;
  CurrIPaddrList: TGList;
  AttackIPaddrList: TGList;

  nShowLogLevel: Integer = 3;
  StringList456A14: TStringList;
  GateClass: String = 'SelGate';
  GateName: String = '角色网关';
  TitleName: string = '飘飘网络';
  ServerPort: Integer = 5100;
  ServerAddr: String = '127.0.0.1';
  GatePort: Integer = 7100;
  GateAddr: String = '0.0.0.0';

  boGateReady: Boolean = False;
  boShowMessage: Boolean;
  boStarted: Boolean = False;
  boClose: Boolean = False;
  boServiceStart: Boolean = False;
  dwKeepAliveTick: LongWord;
  boKeepAliveTimcOut: Boolean = False;
  nSendMsgCount: Integer;
  n456A2C: Integer;
  n456A30: Integer;
  boSendHoldTimeOut: Boolean;
  dwSendHoldTick: LongWord;
  boDecodeLock: Boolean;

  nMaxConnOfIPaddr: Integer = 10;

  BlockMethod: TBlockIPMethod = mDisconnect;
  dwKeepConnectTimeOut: LongWord = 60 * 1000;
  g_boDynamicIPDisMode: Boolean = False; //用于动态IP，分机放置登录网关用，打开此模式后，网关将会把连接登录服务器的IP地址，当为服务器IP，发给登录服务器，客户端将直接使用此IP连接角色网关

  g_dwGameCenterHandle: THandle;
  g_sNowStartGate: String = '正在启动角色网关...';
  g_sNowStartOK: String = '启动角色网关完成...';

  dwAttackTick: LongWord = 100;
  nAttackCount: Integer = 10;
  nReviceMsgLength: Integer = 350; //每MS允许接受的长度，超过即认为是攻击
  dwReviceTick: LongWord = 500;
  nAttackLevel: Integer = 2;
  nMaxClientMsgCount: Integer = 2;
const
  tLoginGate = 6;
implementation
uses Grobal2;

procedure LoadBlockIPFile();
var
  I: Integer;
  sFileName: String;
  LoadList: TStringList;
  sIPaddr: String;
  nIPaddr: Integer;
  IPaddr: pTSockaddr;
begin
  sFileName := '.\BlockIPList.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sIPaddr := Trim(LoadList.Strings[0]);
      if sIPaddr = '' then Continue;
      nIPaddr := inet_addr(PChar(sIPaddr));
      if nIPaddr = INADDR_NONE then Continue;
      New(IPaddr);
      FillChar(IPaddr^, SizeOf(TSockaddr), 0);
      IPaddr.nIPaddr := nIPaddr;
      BlockIPList.Add(IPaddr);
    end;
    LoadList.Free;
  end;
end;
procedure SaveBlockIPList();
var
  I: Integer;
  SaveList: TStringList;
begin
  SaveList := TStringList.Create;
  for I := 0 to BlockIPList.Count - 1 do begin
    SaveList.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
  end;
  SaveList.SaveToFile('.\BlockIPList.txt');
  SaveList.Free;
end;
procedure SendGameCenterMsg(wIdent: Word; sSendMsg: String);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tLoginGate), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

constructor TGList.Create;
begin
  inherited Create;
  InitializeCriticalSection(GLock);
end;

destructor TGList.Destroy;
begin
  DeleteCriticalSection(GLock);
  inherited;
end;

procedure TGList.Lock;
begin
  EnterCriticalSection(GLock);
end;

procedure TGList.UnLock;
begin
  LeaveCriticalSection(GLock);
end;

initialization
  begin
    CS_MainLog := TCriticalSection.Create;
    CS_FilterMsg := TCriticalSection.Create;
    StringList456A14 := TStringList.Create;
    MainLogMsgList := TStringList.Create;
  end;

finalization
  begin
    StringList456A14.Free;
    MainLogMsgList.Free;
    CS_MainLog.Free;
    CS_FilterMsg.Free;
  end;

end.

