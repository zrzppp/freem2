unit PlayUser;

interface
uses
  Windows, Classes, SysUtils, StrUtils, ExtCtrls, EngineAPI, EngineType;
const
  MAXBAGITEM = 46;

  RM_MENU_OK = 10309;
type
  TMyTimer = class(TObject)
    Timer: TTimer;
    procedure OnTimer(Sender: TObject);
  end;

procedure InitPlayUser();
procedure UnInitPlayUser();
procedure LoadCheckItemList();
procedure UnLoadCheckItemList();

procedure InitMsgFilter();
procedure UnInitMsgFilter();
procedure LoadMsgFilterList();
procedure UnLoadMsgFilterList();

procedure InitAttack();
procedure UnInitAttack();
function IsFilterMsg(var sMsg: string): Boolean;
procedure FilterMsg(PlayObject: TObject; pszSrcMsg: PChar; pszDestMsg: PChar; nDestLen: Integer); stdcall;

function CheckCanDropItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
function CheckCanDealItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
function CheckCanStorageItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
function CheckCanRepairItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;

procedure TRunSocketObject_Open(GateIdx, nSocket: Integer; sIPaddr: PChar); stdcall;
procedure TRunSocketObject_Close(GateIdx, nSocket: Integer); stdcall;
procedure TRunSocketObject_Eeceive_OK(); stdcall;
procedure TRunSocketObject_Data(GateIdx, nSocket: Integer; MsgBuff: PChar); stdcall;
var
  MyTimer: TMyTimer;
implementation

uses HUtil32, PlugShare;

procedure InitPlayUser();
begin
  LoadCheckItemList();
  TPlayObject_SetCheckClientDropItem(CheckCanDropItem);
  TPlayObject_SetCheckClientDealItem(CheckCanDealItem);
  TPlayObject_SetCheckClientStorageItem(CheckCanStorageItem);
  TPlayObject_SetCheckClientRepairItem(CheckCanRepairItem);
end;

procedure UnInitPlayUser();
begin
  TPlayObject_SetCheckClientDropItem(nil);
  TPlayObject_SetCheckClientDealItem(nil);
  TPlayObject_SetCheckClientStorageItem(nil);
  TPlayObject_SetCheckClientRepairItem(nil);
  UnLoadCheckItemList();
end;

procedure LoadCheckItemList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sItemName: string;
  sCanDrop: string;
  sCanDeal: string;
  sCanStorage: string;
  sCanRepair: string;
  CheckItem: pTCheckItem;
begin
  sFileName := '.\CheckItemList.txt';

  if g_CheckItemList <> nil then begin
    UnLoadCheckItemList();
  end;
  g_CheckItemList := Classes.TList.Create;
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create();
    LoadList.Add(';引擎插件禁止物品配置文件');
    LoadList.Add(';物品名称'#9'扔'#9'交易'#9'存'#9'修');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanDrop, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanDeal, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanStorage, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sCanRepair, [' ', #9]);
      if (sItemName <> '') then begin
        New(CheckItem);
        CheckItem.szItemName := sItemName;
        CheckItem.boCanDrop := sCanDrop = '1';
        CheckItem.boCanDeal := sCanDeal = '1';
        CheckItem.boCanStorage := sCanStorage = '1';
        CheckItem.boCanRepair := sCanRepair = '1';
        g_CheckItemList.Add(CheckItem);
      end;
    end;
  end;
  LoadList.Free;
end;
procedure UnLoadCheckItemList();
var
  I: Integer;
  CheckItem: pTCheckItem;
begin
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if CheckItem <> nil then
      Dispose(CheckItem);
  end;
  g_CheckItemList.Free;
  g_CheckItemList := nil;
end;
function CheckCanDropItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
resourcestring
  sMsg = '此物品禁止扔在地上！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
  NormNpc: TNormNpc;
begin
  Result := TRUE;
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanDrop) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
      NormNpc := TNormNpc_GetManageNpc();
      TBaseObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));
      Result := False;
      break;
    end;
  end;
end;
function CheckCanDealItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
resourcestring
  sMsg = '此物品禁止交易！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
  NormNpc: TNormNpc;
begin
  Result := TRUE;
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanDeal) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
      NormNpc := TNormNpc_GetManageNpc();
      TBaseObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));
      Result := False;
      break;
    end;
  end;
end;
function CheckCanStorageItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
resourcestring
  sMsg = '此物品禁止存仓库！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
  NormNpc: TNormNpc;
begin
  Result := TRUE;
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanStorage) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
      NormNpc := TNormNpc_GetManageNpc();
      TBaseObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));
      Result := False;
      break;
    end;
  end;
end;
function CheckCanRepairItem(PlayObject: TPlayObject; pszItemName: PChar): Boolean; stdcall;
resourcestring
  sMsg = '此物品禁止修理！！！';
var
  I: Integer;
  CheckItem: pTCheckItem;
  NormNpc: TNormNpc;
begin
  Result := TRUE;
  if g_CheckItemList = nil then begin
    Result := False;
    Exit;
  end;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := g_CheckItemList.Items[I];
    if (CheckItem.boCanRepair) and (CompareText(CheckItem.szItemName, pszItemName) = 0) then begin
      NormNpc := TNormNpc_GetManageNpc();
      TBaseObject_SendMsg(PlayObject, NormNpc, RM_MENU_OK, 0, Integer(PlayObject), 0, 0, PChar(sMsg));
      Result := False;
      break;
    end;
  end;
end;

function IsFilterMsg(var sMsg: string): Boolean;
var
  I: Integer;
  nLen: Integer;
  sReplaceText: string;
  sFilterText: string;
  FilterMsg: pTFilterMsg;
begin
  Result := False;
  if g_MsgFilterList = nil then begin
    Result := TRUE;
    Exit;
  end;
  for I := 0 to g_MsgFilterList.Count - 1 do begin
    FilterMsg := g_MsgFilterList.Items[I];
    if (FilterMsg.sFilterMsg <> '') and (AnsiContainsText(sMsg, FilterMsg.sFilterMsg)) then begin
      { for nLen := 1 to Length(MsgFilter.sFilterMsg) do begin
         sReplaceText := sReplaceText + sReplaceWord;
       end;}
      if FilterMsg.sNewMsg = '' then begin
        sMsg := '';
      end else begin
        sMsg := AnsiReplaceText(sMsg, FilterMsg.sFilterMsg, FilterMsg.sNewMsg);
      end;
      Result := TRUE;
      break;
    end;
  end;
end;

procedure FilterMsg(PlayObject: TObject; pszSrcMsg: PChar; pszDestMsg: PChar; nDestLen: Integer);
var
  sSrcMsg: string;
begin
  sSrcMsg := StrPas(pszSrcMsg);
  IsFilterMsg(sSrcMsg);
  if sSrcMsg <> '' then begin
    nDestLen := length(sSrcMsg);
    Move(sSrcMsg[1], pszDestMsg^, nDestLen);
  end else begin
    pszDestMsg := nil;
  end;
end;

procedure LoadMsgFilterList();
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sFilterMsg: string;
  sNewMsg: string;
  FilterMsg: pTFilterMsg;
begin
  sFileName := '.\MsgFilterList.txt';
  if g_MsgFilterList <> nil then begin
    UnLoadMsgFilterList();
  end;
  g_MsgFilterList := Classes.TList.Create;
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create;
    LoadList.Add(';引擎插件消息过滤配置文件');
    LoadList.Add(';过滤消息'#9'替换消息');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      sLineText := GetValidStr3(sLineText, sFilterMsg, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sNewMsg, [' ', #9]);
      if (sFilterMsg <> '') then begin
        New(FilterMsg);
        FilterMsg.sFilterMsg := sFilterMsg;
        FilterMsg.sNewMsg := sNewMsg;
        g_MsgFilterList.Add(FilterMsg);
      end;
    end;
  end;
  LoadList.Free;
end;

procedure UnLoadMsgFilterList();
var
  I: Integer;
begin
  for I := 0 to g_MsgFilterList.Count - 1 do begin
    Dispose(g_MsgFilterList.Items[I]);
  end;
  g_MsgFilterList.Free;
  g_MsgFilterList := nil;
end;

procedure InitMsgFilter();
begin
  LoadMsgFilterList();
  TPlayObject_SetHookFilterMsg(FilterMsg);
end;

procedure UnInitMsgFilter();
begin
  TPlayObject_SetHookFilterMsg(nil);
  UnLoadMsgFilterList();
end;
////////////////////////////////////////////////////////////////////////////////
procedure InitTimer();
begin
  MyTimer := TMyTimer.Create;
  MyTimer.Timer := TTimer.Create(nil);
  MyTimer.Timer.Enabled := False;
  MyTimer.Timer.Interval := 10;
  MyTimer.Timer.OnTimer := MyTimer.OnTimer;
  MyTimer.Timer.Enabled := TRUE;
end;

procedure UnInitTimer();
begin
  MyTimer.Timer.Enabled := False;
  MyTimer.Timer.Free;
  MyTimer.Destroy;
end;

procedure InitAttack();
begin
  CurrIPaddrList := Classes.TList.Create;
  AttackIPaddrList := Classes.TList.Create;
  g_SessionList := Classes.TList.Create;
  TRunSocket_SetHookExecGateMsgOpen(TRunSocketObject_Open);
  TRunSocket_SetHookExecGateMsgClose(TRunSocketObject_Close);
  TRunSocket_SetHookExecGateMsgEeceive_OK(TRunSocketObject_Eeceive_OK);
  TRunSocket_SetHookExecGateMsgData(TRunSocketObject_Data);
  InitTimer();
end;

procedure UnInitAttack();
var
  IPList: Classes.TList;
  I, II: Integer;
begin
  UnInitTimer();
  TRunSocket_SetHookExecGateMsgOpen(nil);
  TRunSocket_SetHookExecGateMsgClose(nil);
  TRunSocket_SetHookExecGateMsgEeceive_OK(nil);
  TRunSocket_SetHookExecGateMsgData(nil);
  for I := 0 to g_SessionList.Count - 1 do begin
    Dispose(g_SessionList.Items[I]);
  end;
  g_SessionList.Free;
  for I := 0 to CurrIPaddrList.Count - 1 do begin
    IPList := Classes.TList(CurrIPaddrList.Items[I]);
    if IPList <> nil then begin
      for II := 0 to IPList.Count - 1 do begin
        if pTSockaddr(IPList.Items[II]) <> nil then
          Dispose(pTSockaddr(IPList.Items[II]));
      end;
      IPList.Free;
    end;
  end;
  CurrIPaddrList.Free;
  for I := 0 to AttackIPaddrList.Count - 1 do begin
    Dispose(AttackIPaddrList.Items[I]);
  end;
  AttackIPaddrList.Free;
end;

function AddAttackIP(GateIdx, nSocket: Integer; sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr, AddIPaddr: pTSockaddr;
  nIPaddr: Integer;
  bo01: Boolean;
begin
  Result := False;
  if nAttackLevel > 0 then begin
    bo01 := False;
    for I := AttackIPaddrList.Count - 1 downto 0 do begin
      IPaddr := pTSockaddr(AttackIPaddrList.Items[I]);
      if CompareText(sIPaddr, IPaddr.sIPaddr) = 0 then begin
        if (GetTickCount - IPaddr.dwStartAttackTick) <= dwAttackTick * nAttackLevel then begin
          IPaddr.dwStartAttackTick := GetTickCount;
          Inc(IPaddr.nAttackCount);
          if IPaddr.nAttackCount >= nAttackCount * nAttackLevel then begin
            Dispose(IPaddr);
            AttackIPaddrList.Delete(I);
            Result := TRUE;
          end;
        end else begin
          if IPaddr.nAttackCount > nAttackCount * nAttackLevel then begin
            Result := TRUE;
          end;
          Dispose(IPaddr);
          AttackIPaddrList.Delete(I);
        end;
        bo01 := TRUE;
        break;
      end;
    end;
    if not bo01 then begin
      New(AddIPaddr);
      FillChar(AddIPaddr^, SizeOf(TSockaddr), 0);
      AddIPaddr^.nGateIdx := GateIdx;
      AddIPaddr^.nSocket := nSocket;
      AddIPaddr^.sIPaddr := sIPaddr;
      AddIPaddr^.dwStartAttackTick := GetTickCount;
      AddIPaddr^.nAttackCount := 0;
      AttackIPaddrList.Add(AddIPaddr);
    end;
  end;
end;

function IsConnLimited(GateIdx, nSocket: Integer; sIPaddr: string): Boolean;
var
  I: Integer;
  IPaddr, AttackIPaddr: pTSockaddr;
  bo01: Boolean;
  IPList: Classes.TList;
begin
  Result := False;
  if nAttackLevel > 0 then begin
    bo01 := False;
    for I := 0 to CurrIPaddrList.Count - 1 do begin
      IPList := Classes.TList(CurrIPaddrList.Items[I]);
      if IPList <> nil then begin
        IPaddr := pTSockaddr(IPList.Items[0]);
        if IPaddr <> nil then begin
          if CompareText(sIPaddr, IPaddr.sIPaddr) = 0 then begin
            bo01 := TRUE;
            Result := AddAttackIP(GateIdx, nSocket, sIPaddr);
            New(AttackIPaddr);
            FillChar(AttackIPaddr^, SizeOf(TSockaddr), 0);
            AttackIPaddr^.nGateIdx := GateIdx;
            AttackIPaddr^.nSocket := nSocket;
            AttackIPaddr^.sIPaddr := sIPaddr;
            IPList.Add(AttackIPaddr);
            if IPList.Count > nMaxConnOfIPaddr * nAttackLevel then Result := TRUE;
            break;
          end;
        end;
      end;
    end;
    if not bo01 then begin
      IPList := nil;
      New(IPaddr);
      FillChar(IPaddr^, SizeOf(TSockaddr), 0);
      IPaddr^.nGateIdx := GateIdx;
      IPaddr^.nSocket := nSocket;
      IPaddr^.sIPaddr := sIPaddr;
      IPList := Classes.TList.Create;
      IPList.Add(IPaddr);
      CurrIPaddrList.Add(IPList);
    end;
  end;
end;

procedure TRunSocketObject_Open(GateIdx, nSocket: Integer; sIPaddr: PChar);
var
  SessionInfo: pTSessionInfo;
  sUserIPaddr: string;
begin
  sUserIPaddr := StrPas(sIPaddr);
  if boCCAttack and IsConnLimited(GateIdx, nSocket, sUserIPaddr) then begin
    TRunSocket_CloseUser(GateIdx, nSocket);
    MainOutMessage(PChar('端口攻击：' + sUserIPaddr));
    Exit;
  end;
  New(SessionInfo);
  SessionInfo.nGateIdx := GateIdx;
  SessionInfo.nSocket := nSocket;
  SessionInfo.sRemoteAddr := StrPas(sIPaddr);
  SessionInfo.dwReceiveTimeTick := GetTickCount;
  SessionInfo.nReceiveLength := 0;
  SessionInfo.dwConnctCheckTick := GetTickCount;
  SessionInfo.dwReceiveTick := GetTickCount;
  g_SessionList.Add(SessionInfo);
end;

procedure TRunSocketObject_Close(GateIdx, nSocket: Integer);
var
  I: Integer;
  IPList: Classes.TList;
  SessionInfo: pTSessionInfo;
begin
  for I := CurrIPaddrList.Count - 1 downto 0 do begin
    IPList := Classes.TList(CurrIPaddrList.Items[I]);
    if IPList <> nil then begin
      if pTSockaddr(IPList.Items[0]) <> nil then begin
        if (pTSockaddr(IPList.Items[0]).nGateIdx = GateIdx) and (pTSockaddr(IPList.Items[0]).nSocket = nSocket) then begin
          Dispose(pTSockaddr(IPList.Items[0]));
          IPList.Delete(0);
          if IPList.Count <= 0 then begin
            IPList.Free;
            CurrIPaddrList.Delete(I);
          end;
          break;
        end;
      end;
    end;
  end;
  for I := g_SessionList.Count - 1 downto 0 do begin
    SessionInfo := pTSessionInfo(g_SessionList.Items[I]);
    if (SessionInfo.nGateIdx = GateIdx) and (SessionInfo.nSocket = nSocket) then begin
      Dispose(SessionInfo);
      g_SessionList.Delete(I);
      break;
    end;
  end;
end;

procedure DelNoLineUser(GateIdx, nSocket: Integer);
var
  I: Integer;
  IPList: Classes.TList;
begin
  for I := CurrIPaddrList.Count - 1 downto 0 do begin
    IPList := Classes.TList(CurrIPaddrList.Items[I]);
    if IPList <> nil then begin
      if pTSockaddr(IPList.Items[0]) <> nil then begin
        if (pTSockaddr(IPList.Items[0]).nGateIdx = GateIdx) and (pTSockaddr(IPList.Items[0]).nSocket = nSocket) then begin
          Dispose(pTSockaddr(IPList.Items[0]));
          IPList.Delete(0);
          if IPList.Count <= 0 then begin
            IPList.Free;
            CurrIPaddrList.Delete(I);
          end;
          break;
        end;
      end;
    end;
  end;
end;

procedure TRunSocketObject_Eeceive_OK();
begin

end;

procedure TRunSocketObject_Data(GateIdx, nSocket: Integer; MsgBuff: PChar);
var
  I: Integer;
  SessionInfo: pTSessionInfo;
  sData: string;
begin
  sData := StrPas(MsgBuff);
  for I := 0 to g_SessionList.Count - 1 do begin
    SessionInfo := pTSessionInfo(g_SessionList.Items[I]);
    if (SessionInfo.nGateIdx = GateIdx) and (SessionInfo.nSocket = nSocket) then begin
      SessionInfo.dwReceiveTimeTick := GetTickCount;
      Inc(SessionInfo.nReceiveLength, length(sData));
      break;
    end;
  end;
end;

procedure TMyTimer.OnTimer(Sender: TObject);
var
  I: Integer;
  SessionInfo: pTSessionInfo;
  sData: string;
begin
  I := 0;
  while I <= g_SessionList.Count - 1 do begin
    SessionInfo := pTSessionInfo(g_SessionList.Items[I]);
    if (GetTickCount - SessionInfo.dwReceiveTick) > dwReviceTick * nAttackLevel then begin
      SessionInfo.dwReceiveTick := GetTickCount;
      if SessionInfo.nReceiveLength > nReviceMsgLength * nAttackLevel then begin
        if boDataAttack then begin
          TRunSocket_CloseUser(SessionInfo.nGateIdx, SessionInfo.nSocket);
          DelNoLineUser(SessionInfo.nGateIdx, SessionInfo.nSocket);
          MainOutMessage(PChar('端口攻击数据包长度：' + IntToStr(SessionInfo.nReceiveLength)));
          Dispose(SessionInfo);
          g_SessionList.Delete(I);
        end else SessionInfo.nReceiveLength := 0;
      end else begin
        SessionInfo.nReceiveLength := 0;
      end;
    end;
    if boKeepConnectTimeOut then begin
      if (GetTickCount - SessionInfo.dwReceiveTimeTick) > dwKeepConnectTimeOut then begin
        TRunSocket_CloseUser(SessionInfo.nGateIdx, SessionInfo.nSocket);
        DelNoLineUser(SessionInfo.nGateIdx, SessionInfo.nSocket);
        Dispose(SessionInfo);
        MainOutMessage(PChar('端口空连接攻击'));
        g_SessionList.Delete(I);
      end;
    end;
    Inc(I);
  end;
end;

end.

