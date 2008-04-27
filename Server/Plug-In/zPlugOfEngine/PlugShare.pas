unit PlugShare;

interface
uses
  Windows, Classes, EngineAPI, EngineType;
type
  TCheckItem = record
    szItemName: string[14];
    boCanDrop: Boolean;
    boCanDeal: Boolean;
    boCanStorage: Boolean;
    boCanRepair: Boolean;
  end;
  pTCheckItem = ^TCheckItem;

  TUserCommand = record
    nIndex: Integer;
    sCommandName: string[100];
  end;
  pTUserCommand = ^TUserCommand;

  TFilterMsg = record
    sFilterMsg: string[100];
    sNewMsg: string[100];
  end;
  pTFilterMsg = ^TFilterMsg;

  TSockaddr = record
    nGateIdx: Integer;
    nSocket: Integer;
    sIPaddr: string[15];
    nAttackCount: Integer;
    dwStartAttackTick: LongWord;
  end;
  pTSockaddr = ^TSockaddr;

  TSessionInfo = record
    nGateIdx: Integer;
    nSocket: Integer;
    sRemoteAddr: string;
    dwConnctCheckTick: LongWord;
    dwReceiveTick: LongWord;
    dwReceiveTimeTick: LongWord;
    nReceiveLength: Integer;
  end;
  pTSessionInfo = ^TSessionInfo;

var
  PlugHandle: Integer;
  CurrIPaddrList: Classes.TList;
  AttackIPaddrList: Classes.TList;
  g_SessionList: Classes.TList;
  nIPCountLimit: Integer = 50;
  dwAttackTick: LongWord = 200;
  nAttackCount: Integer = 10;
  nReviceMsgLength: Integer = 100; //每MS允许接受的长度，超过即认为是攻击
  dwReviceTick: LongWord = 1000;
  nAttackLevel: Integer = 1;
  nMaxConnOfIPaddr: Integer = 50;
  dwKeepConnectTimeOut: LongWord = 1000 * 60 * 3;
  boKeepConnectTimeOut: Boolean = False;
  boCCAttack: Boolean = False;
  boDataAttack: Boolean = False;
  boStartAttack: Boolean = False;

  g_CheckItemList: Classes.TList;
  g_UserCmdList: Classes.TStringList;
  g_MsgFilterList: Classes.TList;
  nStartHPRock: Integer = 10;
  nStartMPRock: Integer = 10;
  nHPRockSpell: Integer = 3;
  nMPRockSpell: Integer = 3;
  nRockAddHP: Integer = 10;
  nRockAddMP: Integer = 10;
  nHPRockDecDura: Integer = 1000;
  nMPRockDecDura: Integer = 1000;
  boStartHPRockMsg: Boolean = TRUE;
  boStartMPRockMsg: Boolean = TRUE;
  dwRockAddHPTick: LongWord;
  dwRockAddMPTick: LongWord;
  sStartHPRockMsg: string = '气血石启动！！！';
  sStartMPRockMsg: string = '魔血石启动！！！';
  PlugClass: string = 'Config';
implementation

end.
