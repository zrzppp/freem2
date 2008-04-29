unit ClMain;

interface

uses
  svn, nixtime, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DXDraws, DirectX, DXClass, DrawScrn,
  IntroScn, PlayScn, MapUnit, WIL, Grobal2, SDK,
  Actor, DIB, StdCtrls, CliUtil, HUtil32, EdCode, CLIParser,
  DWinCtl, ClFunc, magiceff, SoundUtil, DXSounds, clEvent, IniFiles,
  Spin, ComCtrls, Grids, Mpeg, Menus, Mask, MShare, Share, StrUtils;

const
   BO_FOR_TEST = FALSE;
   EnglishVersion = TRUE;
   BoNeedPatch = TRUE;
   NEARESTPALETTEINDEXFILE = 'Data\npal.idx';
   MonImageDir = '.\Graphics\Monster\';
   NpcImageDir = '.\Graphics\Npc\';
   ItemImageDir = '.\Graphics\Items\';
   WeaponImageDir = '.\Graphics\Weapon\';
   HumImageDir = '.\Graphics\Human\';

type
  TKornetWorld = record
    CPIPcode:  string;
    SVCcode:   string;
    LoginID:   string;
    CheckSum:  string;
  end;

  TOneClickMode = (toNone, toKornetWorld);

  TfrmMain = class(TDxForm)
    CSocket: TClientSocket;
    Timer1: TTimer;
    MouseTimer: TTimer;
    WaitMsgTimer: TTimer;
    SelChrWaitTimer: TTimer;
    CmdTimer: TTimer;
    MinTimer: TTimer;
    SpeedHackTimer: TTimer;
    DXDraw: TDXDraw;
    WMonImg: TWMImages;
    WMon2Img: TWMImages;
    WMon3Img: TWMImages;
    WMon4Img: TWMImages;
    WMon5Img: TWMImages;
    WMon6Img: TWMImages;
    WMon7Img: TWMImages;
    WMon8Img: TWMImages;
    WMon9Img: TWMImages;
    WMon10Img: TWMImages;
    WMon11Img: TWMImages;
    WMon12Img: TWMImages;
    WMon13Img: TWMImages;
    WMon14Img: TWMImages;
    WMon15Img: TWMImages;
    WMon16Img: TWMImages;
    WMon17Img: TWMImages;
    WMon18Img: TWMImages;
    WMon19Img: TWMImages;
    WMon20Img: TWMImages;
    WMon21Img: TWMImages;
    WMon22Img: TWMImages;
    WMon23Img: TWMImages;
    WMon24Img: TWMImages;
    WMon25Img: TWMImages;
    WMon26Img: TWMImages;
    WMon27Img: TWMImages;
    WMon28Img: TWMImages;
    WMon29Img: TWMImages;
    WEffectImg: TWMImages;
    WDragonImg: TWMImages;
    WPrgUse3: TWMImages;
    AutoRunTimer: TTimer;
    DXDIB: TDXDIB;

    procedure DXDrawInitialize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CMDialogKey(var Msg:TWMKey);
    message CM_DIALOGKEY;
    procedure DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DXDrawFinalize(Sender: TObject);
    procedure CSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
    procedure DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MouseTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DXDrawDblClick(Sender: TObject);
    procedure WaitMsgTimerTimer(Sender: TObject);
    procedure SelChrWaitTimerTimer(Sender: TObject);
    procedure DXDrawClick(Sender: TObject);
    procedure CmdTimerTimer(Sender: TObject);
    procedure MinTimerTimer(Sender: TObject);
    procedure CheckHackTimerTimer(Sender: TObject);
    procedure SendTimeTimerTimer(Sender: TObject);
    procedure SpeedHackTimerTimer(Sender: TObject);
    procedure AutoRunTimerTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    SocStr, BufferStr: string;
    WarningLevel: Integer;
    TimerCmd: TTimerCommand;
    MakeNewId: string;
    ActionLockTime: LongWord;
    LastHitTick: LongWord;
    ActionFailLock: Boolean;
    ActionFailLockTime:LongWord;
    FailAction, FailDir: integer;
    ActionKey: word;
    CursorSurface: TDirectDrawSurface;
    mousedowntime: longword;
    WaitingMsg: TDefaultMessage;
    WaitingStr: string;
    WhisperName: string;

    procedure AutoPickUpItem();
    procedure ProcessKeyMessages;
    procedure ProcessActionMessages;
    procedure CheckSpeedHack (rtime: Longword);
    procedure DecodeMessagePacket (datablock: string);
    procedure ActionFailed;
    procedure UseMagic (tx, ty: integer; pcm: PTClientMagic);
    procedure UseMagicSpell (who, effnum, targetx, targety, magic_id: integer);
    procedure UseMagicFire (who, efftype, effnum, targetx, targety, target: integer);
    procedure UseMagicFireFail (who: integer);
    procedure CloseAllWindows;
    procedure ClearDropItems;
    procedure ResetGameVariables;
    procedure ChangeServerClearGameVariables;
    procedure _DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AttackTarget (target: TActor);
    function  CheckDoorAction (dx, dy: integer): Boolean;
    procedure ClientGetPasswdSuccess (body: string);
    procedure ClientGetNeedUpdateAccount (body: string);
    procedure ClientGetSelectServer;
    procedure ClientGetPasswordOK(Msg:TDefaultMessage;sBody:String);
    procedure ClientGetReceiveChrs (body: string);
    procedure ClientGetStartPlay (body: string);
    procedure ClientGetReconnect (body: string);
    procedure ClientGetServerConfig(Msg:TDefaultMessage;sBody:String);
    procedure ClientGetMapDescription (Msg:TDefaultMessage;sBody:String);
    procedure ClientGetGameGoldName (Msg:TDefaultMessage;sBody:String);
//    procedure ClientGetAttatckMode (Msg:TDefaultMessage;sBody:String);
    procedure ClientGetAdjustBonus (bonus: integer; body: string);
    procedure ClientGetAttatckMode (mode: integer; body: string);
    procedure ClientGetAddItem (body: string);
    procedure ClientGetAddStore (body: string);
    procedure ClientGetUpdateItem (body: string);
    procedure ClientGetDelItem (body: string);
    procedure ClientGetDelItems (body: string);
    procedure ClientGetBagItmes (body: string; boCheckPosition: boolean);
    procedure ClientGetBagItems2 (body: string);
    procedure ClientGetStoreItems (body: string; boCheckPosition: boolean);
    procedure ClientGetStoreItems2 (body: string);
    procedure ClientAuctionItems (body: string);
    procedure ClientGTList (body: string);
    procedure ClientDecoList (body: string);
    procedure ClientGameShopList (body: string);
    procedure ClientBBSList (body: string);
    procedure ClientBBSMsg (body: string);
    procedure ClientGetDropItemFail (iname: string; sindex: integer);
    procedure ClientGetShowItem (itemid, x, y, looks: integer; itmname: string);
    procedure ClientGetHideItem (itemid, x, y: integer);
    procedure ClientGetSenduseItems (body: string);
    procedure ClientGetSendAddUseItems (body: string);
    procedure ClientGetAddMagic (body: string);
    procedure ClientGetDelMagic (magid: integer);
    procedure ClientGetMyMagics (body: string);
    procedure ClientGetMagicLvExp (magid, maglv, magtrain: integer);
    procedure ClientGetDuraChange (uidx, newdura, newduramax: integer);
    procedure ClientGetMerchantSay (merchant, face: integer; saying: string);
    procedure ClientGetSendGoodsList (merchant, count: integer; body: string);
    procedure ClientGetSendMakeDrugList (merchant: integer; body: string);
    procedure ClientGetSendGameShopList (merchant, count: integer; body: string);
    
//    procedure ClientGetSendGemItemList (merchant, count: integer; body: string);
    procedure ClientGetSendUserSell (merchant: integer);
    procedure ClientGetSendUserRepair (merchant: integer);
    procedure ClientGetSendUserStorage (merchant: integer);
    procedure ClientGetSendUserConsign (merchant: integer);
    procedure ClientGetSaveItemList (merchant: integer; bodystr: string);
    procedure ClientGetSendDetailGoodsList (merchant, count, topline: integer; bodystr: string);
    procedure ClientGetSendNotice (body: string);
    procedure ClientGetGroupMembers (bodystr: string);
    procedure ClientGetOpenGuildDlg (bodystr: string);
    procedure ClientGetSendGuildMemberList (body: string);
    procedure ClientGetDealRemoteAddItem (body: string);
    procedure ClientGetDealRemoteDelItem (body: string);
    procedure ClientGetChangeGuildName (body: string);
    procedure ClientGetSendUserState (body: string);
    procedure ClientAddFriend(body: string);
    procedure ClientAddFriendFail(body: string);
    procedure ClientDelFriend(body: string);
    procedure ClientUpdateMemo(body: string);
    procedure ClientFriendStatus(status: byte; body: string);
    procedure ClientFriendList(body: string);
    procedure ClientGetNeedPassword(Body:String);
    procedure ClientGetPasswordStatus(Msg:pTDefaultMessage;Body:String);
    procedure ClientGetRegInfo(Msg:pTDefaultMessage;Body:String);
    procedure ClientMailList(msg: TDefaultMessage; body: string);
    procedure ClientMailItem(msg: TDefaultMessage; body: string);
    procedure ClientMailSent(msg: TDefaultMessage; body: string);
    procedure ClientMailFailed(msg: TDefaultMessage; body: string);
    procedure ClientMailStatus(msg: TDefaultMessage; body: string);
    procedure ClientBlockList(msg: TDefaultMessage; body: string);
    procedure ClientBlockListFail(msg: TDefaultMessage; body: string);        
    procedure ClientBlockListItem(msg: TDefaultMessage; body: string);
    procedure ClientBlockListAdded(msg: TDefaultMessage; body: string);
    procedure ClientBlockListDeleted(msg: TDefaultMessage; body: string);
    procedure SetInputStatus();
    procedure ShowHumanMsg(Msg: pTDefaultMessage);
    procedure SendPowerBlock;
  public
    LoginId, LoginPasswd, CharName: string;
    Certification: integer;
    ActionLock: Boolean;
    //MainSurface: TDirectDrawSurface;
    NpcImageList:TList;
    ItemImageList:TList;
    WeaponImageList:TList;
    HumImageList:TList;

    procedure CmdShowHumanMsg(sParam1, sParam2, sParam3, sParam4, sParam5: String);    
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure ProcOnIdle;
    procedure AppOnIdle (Sender: TObject; var Done: Boolean);
    procedure AppLogout;
    procedure AppExit;
    procedure PrintScreenNow;
    procedure EatItem (idx: integer);
    procedure DrawEffectHum(nType,nX,nY:Integer);
    procedure DrawEffectHumEx(nType: integer;ObjectID:TActor);
    procedure SendLogin (uid, passwd: string);
    procedure SendNewAccount (ue: TUserEntry; ua: TUserEntryAdd);
    procedure SendUpdateAccount (ue: TUserEntry; ua: TUserEntryAdd);
    procedure SendSelectServer (svname: string);
    procedure SendChgPw (id, passwd, newpasswd: string);
    procedure SendNewChr (uid, uname, shair, sjob, ssex: string);
    procedure SendQueryChr;
    procedure SendDelChr (chrname: string);
    procedure SendSelChr (chrname: string);
    procedure SendRunLogin;
    procedure SendSay (str: string);
    procedure SendActMsg (ident, x, y, dir: integer);
    procedure SendSpellMsg (ident, x, y, dir, target: integer);
    procedure SendQueryUserName (targetid, x, y: integer);
    procedure SendDropItem (name: string; itemserverindex: integer;Amount:Integer);
    procedure SendPickup;
    procedure SendTakeOnItem (where: byte; itmindex: integer; itmname: string);
    procedure SendTakeOffItem (where: byte; itmindex: integer; itmname: string);
    procedure SendEat (itmindex: integer; itmname: string);
    procedure SendButchAnimal (x, y, dir, actorid: integer);
    procedure SendMagicKeyChange (magid: integer; keych: char);
    procedure SendMerchantDlgSelect (merchant: integer; rstr: string);
    procedure SendQueryPrice (merchant, itemindex: integer; itemname: string; Amount:Integer);
    procedure SendQueryRepairCost (merchant, itemindex: integer; itemname: string);
    procedure SendSellItem (merchant, itemindex: integer; itemname: string; Amount:Integer);
    procedure SendRepairItem (merchant, itemindex: integer; itemname: string);
    procedure SendStorageItem (merchant, itemindex: integer; itemname: string; Amount:Integer);
    procedure SendConsignItem (merchant, itemindex: integer; cost: string);
    procedure SendGetDetailItem (merchant, menuindex: integer; itemname: string);
    procedure SendBuyItem (merchant, itemserverindex: integer; itemname: string);
    procedure SendTakeBackStorageItem (merchant, itemserverindex: integer; itemname: string);
    procedure SendMakeDrugItem (merchant: integer; itemname: string);
    procedure SendDropGold (dropgold: integer);
    procedure SendGroupMode (onoff: Boolean);
    procedure SendCreateGroup (withwho: string);
    procedure SendDealTry;
    procedure SendGuildDlg;
    procedure SendCancelDeal;
    procedure SendAddDealItem (ci: TClientItem);
    procedure SendDelDealItem (ci: TClientItem);
    procedure SendChgStorePw (storepasswd, newstorepasswd: string);
    procedure SendAddRefineItem (ci: TClientItem);
    procedure SendDelRefineItem (ci: TClientItem);
    procedure SendCanceRefine;
    procedure SendChangeDealGold (gold: integer);
    procedure SendDealEnd;
    procedure SendAddGroupMember (withwho: string);
    procedure SendDelGroupMember (withwho: string);
    procedure SendGuildHome;
    procedure SendGuildMemberList;
    procedure SendGuildAddMem (who: string);
    procedure SendGuildDelMem (who: string);
    procedure SendGuildUpdateNotice (notices: string);
    procedure SendGuildUpdateGrade (rankinfo: string);
    procedure SendSpeedHackUser;
    procedure SendAdjustBonus (remain: integer; babil: TNakedAbility);
    procedure SendPassword(sPassword:String;nIdent:Integer);
    procedure SendGTListRequest(merchant: integer; menuindex: integer);
    procedure SendBuyGT(merchant: integer; GTNumber: integer);
    procedure SendDecoListRequest(merchant: integer; menuindex: integer);
    procedure SendBuyDeco(merchant: integer; Appr: integer);
    procedure SendTradeGT(Answer:integer);
    procedure SendBBSListRequest(merchant: integer; menuindex: integer);
    procedure SendBBSMsgRequest(Merchant: integer; Index: integer);
    procedure SendBBSPost(Merchant,sticky,MasterPost: integer; sMsg: String);
    procedure SendBBSDelete(Merchant,index: integer);
    procedure SendOpenGameShop;
    function  GetMagicByKey (Key: char): PTClientMagic;
    function  TargetInSwordLongAttackRange (ndir: integer): Boolean;
    function  TargetInSwordWideAttackRange (ndir: integer): Boolean;
    function  TargetInSwordCrsAttackRange(ndir: integer): Boolean;
    procedure OnProgramException (Sender: TObject; E: Exception);
    procedure SendSocket (sendstr: string);
    function  ServerAcceptNextAction: Boolean;
    function  CanNextAction: Boolean;
    function  CanNextHit: Boolean;
    function  IsUnLockAction (action, adir: integer): Boolean;
    procedure ActiveCmdTimer (cmd: TTimerCommand);
    function  IsGroupMember (uname: string): Boolean;
    procedure SelectChr(sChrName:String);
    function  GetNpcImg(wAppr: Word; var WMImage: TWMImages): Boolean;
    function  GetWStateImg(Idx:Integer): TDirectDrawSurface;overload;
    function  GetWStateImg(Idx:Integer;var ax,ay:integer): TDirectDrawSurface;overload;
    function  GetWWeaponImg(Weapon,m_btSex,nFrame:Integer;var ax,ay:integer): TDirectDrawSurface;
    function  GetWHumImg(Dress,m_btSex,nFrame:Integer;var ax,ay:integer): TDirectDrawSurface;
    function  GetWHum2Img(Dress,m_btSex,nFrame:Integer;var ax,ay:integer): TDirectDrawSurface;
    function  GetHelmetImg(Helmet,m_btSex,nFrame:Integer;var ax,ay:integer): TDirectDrawSurface;
    procedure ToggleAutoRun;
    procedure ProcessCommand(sData:String);
  end;
  function IsDebug():Boolean;
  function IsDebugA():Boolean;
  function  CheckMirProgram: Boolean;
  procedure PomiTextOut (dsurface: TDirectDrawSurface; x, y: integer; str: string);
  procedure WaitAndPass (msec: longword);
  function  GetRGB (c256: byte): integer;
  procedure DebugOutStr (msg: string);

var
  nLeft            :integer = 10;
  nTop             :integer = 10;
  nWidth           :integer;
  nHeight          :integer;
  g_boShowMemoLog  :Boolean = False;
  g_boShowRecog    :Integer = 0;
  frmMain          :TfrmMain;
  DScreen          :TDrawScreen;
  IntroScene       :TIntroScene;
  LoginScene       :TLoginScene;
  SelectChrScene   :TSelectChrScene;
//  LoadingScene     :TLoading;
//  LoginNoticeScene :TLoginNotice;
  PlayScene        :TPlayScene;
  LocalLanguage    :TImeMode = imChinese;
  MP3              :TMPEG;
  TestServerAddr   :String = '127.0.0.1';
  BGMusicList      :TStringList;
  //DObjList         :TList;
  EventMan         :TClEventManager;
  KornetWorld      :TKornetWorld;
  Map              :TMap;
  BoOneClick       :Boolean;
  OneClickMode     :TOneClickMode;
  m_boPasswordIntputStatus:Boolean = False;
  CLI              :TCLIParser;
  
implementation

uses
  FState, DlgConfig{, gShare};

{$R *.DFM}
var
  ShowMsgActor:TActor;

function  CheckMirProgram: Boolean;
var
   pstr, cstr: array[0..255] of char;
   mirapphandle: HWnd;
begin
   Result := FALSE;
   StrPCopy (pstr, 'legend of mir');
   mirapphandle := FindWindow (nil, pstr);
   if (mirapphandle <> 0) and (mirapphandle <> Application.Handle) then begin
{$IFNDEF COMPILE}
      SetActiveWindow(mirapphandle);
      Result := TRUE;
{$ENDIF}
      exit;
   end;
end;

procedure PomiTextOut (dsurface: TDirectDrawSurface; x, y: integer; str: string);
var
   i, n: integer;
   d: TDirectDrawSurface;
begin
   for i:=1 to Length(str) do begin
      n := byte(str[i]) - byte('0');
      if n in [0..9] then begin
         d := g_WMainImages.Images[30 + n];
         if d <> nil then
            dsurface.Draw (x + i*8, y, d.ClientRect, d, TRUE);
      end else begin
         if str[i] = '-' then begin
            d := g_WMainImages.Images[40];
            if d <> nil then
               dsurface.Draw (x + i*8, y, d.ClientRect, d, TRUE);
         end;
      end;
   end;
end;

procedure WaitAndPass (msec: longword);
var
   start: longword;
begin
   start := GetTickCount;
   while GetTickCount - start < msec do begin
      Application.ProcessMessages;
   end;
end;

function GetRGB (c256: byte): integer;
begin
  with frmMain.DxDraw do
    Result:=RGB(DefColorTable[c256].rgbRed,
                DefColorTable[c256].rgbGreen,
                DefColorTable[c256].rgbBlue);
end;

procedure DebugOutStr (msg: string);
var
   flname: string;
   fhandle: TextFile;
begin
//DScreen.AddChatBoardString(msg,clWhite, clBlack);
   exit;
   flname := '.\!debug.txt';
   if FileExists(flname) then begin
      AssignFile (fhandle, flname);
      Append (fhandle);
   end else begin
      AssignFile (fhandle, flname);
      Rewrite (fhandle);
   end;
   WriteLn (fhandle, TimeToStr(Time) + ' ' + msg);
   CloseFile (fhandle);
end;

function KeyboardHookProc (Code: Integer; WParam: Longint; var Msg: TMsg): Longint; stdcall;
begin
   Result:=0;
   if ((WParam = 9){ or (WParam = 13)}) and (g_nLastHookKey = 18) and (GetTickCount - g_dwLastHookKeyTime < 500) then begin
      if FrmMain.WindowState <> wsMinimized then begin
         FrmMain.WindowState := wsMinimized;
      end else
         Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, Longint(@Msg));
      exit;
   end;
   g_nLastHookKey := WParam;
   g_dwLastHookKeyTime := GetTickCount;

   Result := CallNextHookEx(g_ToolMenuHook, Code, WParam, Longint(@Msg));
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  flname, str: string;
  ini: TIniFile;
begin
  CLI := TCLIParser.Create;
  if (CLI.Exists('ini') = -1) then CLI.ParseArgs('--ini .\mir2.ini');
  if not FileExists(CLI.Get(CLI.Exists('ini')).sValue) then CLI.ParseArgs('--ini .\mir2.ini');
  ini := nil;

  g_AutoPickupList :=TList.Create;
  g_ShowItemList   :=TGList.Create;

  g_DWinMan:=TDWinManager.Create(Self);
  g_DXDraw:=DXDraw;
   Randomize;
   ini := TIniFile.Create (CLI.Get(CLI.Exists('ini')).sValue);
   if ini <> nil then begin
       g_sServerAddr := ini.ReadString ('Setup', 'ServerAddr', g_sServerAddr);
       g_nServerPort := ini.ReadInteger ('Setup', 'ServerPort', g_nServerPort);
       LocalLanguage := imOpen;

      g_boWindowTest := False;//ini.ReadBool ('Setup', 'WindowTest', g_boWindowTest);
      g_boDisableFlip := ini.ReadBool ('Setup', 'DisableFlip', g_boDisableFlip);
      g_boFullScreen := ini.ReadBool ('Setup', 'FullScreen', g_boFullScreen);
      g_sCurFontName := ini.ReadString ('Setup', 'FontName', g_sCurFontName);
      g_boForceAddr := ini.ReadBool ('Setup', 'ForceAddr', g_boForceAddr);
      g_sSelectServerAddr := ini.ReadString ('Setup', 'SelectServerAddr', g_sSelectServerAddr);
      g_nSelectServerPort := ini.ReadInteger ('Setup', 'SelectServerPort', g_nSelectServerPort);
      g_sGameServerAddr := ini.ReadString ('Setup', 'GameServerAddr', g_sGameServerAddr);
      g_nGameServerPort := ini.ReadInteger ('Setup', 'GameServerPort', g_nGameServerPort);
      g_boAutoLogin := ini.ReadBool ('Auto', 'AutoLogin', g_boAutoLogin);
      g_boAutoServer := ini.ReadBool ('Auto', 'AutoServer', g_boAutoServer);
      g_sAutoID := ini.ReadString ('Auto', 'AutoID', g_sAutoID);
      g_sAutoPass := ini.ReadString ('Auto', 'AutoPass', g_sAutoPass);
      g_sAutoServerName := ini.ReadString ('Auto', 'AutoServerName', g_sAutoServerName);
      g_boSkillSetting := ini.ReadBool ('Option', 'SkillKeyMode', g_boSkillSetting);
      g_boSkillBarNum := ini.ReadBool ('Option', 'SkillBarNum', g_boSkillBarNum);
      g_boShowSkillBar := ini.ReadBool ('Option', 'SkillBarView', g_boShowSkillBar);
      g_boEffect := ini.ReadBool ('Option', 'ViewEffect', g_boEffect);
      g_boSound := ini.ReadBool ('Option', 'Sound', g_boSound);
      g_boShowAllItem := ini.ReadBool ('Option', 'DropItemView', g_boShowAllItem);
      g_boNameAllView := ini.ReadBool ('Option', 'ViewAllName', g_boNameAllView);
      g_boHPView := ini.ReadBool ('Option', 'ViewHPType', g_boHPView);

      if g_boFullScreen or not g_boWindowTest then begin
        frmMain.BorderStyle := bsNone;
        g_boDisableFlip := True;
        frmMain.Left := 0;
        frmMain.Top := 0;        
      end
      else begin
        frmMain.BorderStyle := bsSingle;
        frmMain.Left := ini.ReadInteger('Positions', 'Left', 100);
        frmMain.Top := ini.ReadInteger('Positions', 'Top', 100);
      end;
      ini.Free;
   end;

{$IF CLIENTTYPE = RMCLIENT}
//    g_sLogoText:=RMCLIENTTITLE;
{$IFEND}

   Caption:=DecodeString(DecodeString(RMCLIENTTITLE));
   if g_boFullScreen then
     DXDraw.Options:=DXDraw.Options + [doFullScreen];
   LoadWMImagesLib(nil);
   NpcImageList:=TList.Create;
   ItemImageList:=TList.Create;
   WeaponImageList:=TList.Create;
   HumImageList:=TList.Create;
   g_DXSound:=TDXSound.Create(Self);
   g_DXSound.Initialize;
   DXDraw.Display.Width:=SCREENWIDTH;
   DXDraw.Display.Height:=SCREENHEIGHT;

  if g_DXSound.Initialized then begin
    g_Sound:= TSoundEngine.Create (g_DXSound.DSound);
    MP3:=TMPEG.Create(nil);
  end else begin
    g_Sound:= nil;
    MP3:=nil;
  end;
  LoadDecoList();

   g_ToolMenuHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardHookProc, 0, GetCurrentThreadID);

   g_SoundList := TStringList.Create;
   BGMusicList:=TStringList.Create;

   flname := '.\wav\mirsound.lst';
   LoadSoundList (flname);
   flname := '.\wav\BGList.lst';
   LoadBGMusicList(flname);
   //if FileExists (flname) then
   //   SoundList.LoadFromFile (flname);

   DScreen := TDrawScreen.Create;
   IntroScene := TIntroScene.Create;
   LoginScene := TLoginScene.Create;
   SelectChrScene := TSelectChrScene.Create;
//   LoadingScene := TLoading.Create;
//   LoginNoticeScene := TLoginNotice.Create;
   PlayScene := TPlayScene.Create;
   Map              := TMap.Create;
   g_DropedItemList := TList.Create;
   g_MagicList        := TList.Create;
   g_FreeActorList    := TList.Create;
   //DObjList := TList.Create;
   EventMan := TClEventManager.Create;
   g_ChangeFaceReadyList := TList.Create;
   g_ServerList:=TStringList.Create;
   g_MySelf := nil;
   FillChar (g_UseItems, sizeof(TClientItem)*13, #0);
   FillChar (g_ItemArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
   FillChar (g_StoreItem, sizeof(TClientItem)*MAXSTORAGEITEMCL, #0);
   FillChar (g_DealItems, sizeof(TClientItem)*10, #0);
   FillChar (g_DealRemoteItems, sizeof(TClientItem)*20, #0);
   FillChar (g_RefineItems, sizeof(TClientItem)*16, #0);
   g_SaveItemList := TList.Create;
   g_MenuItemList := TList.Create;
   g_WaitingUseItem.Item.S.Name := '';
   g_EatingItem.S.Name := '';

   g_nTargetX := -1;
   g_nTargetY := -1;
   g_TargetCret := nil;
   g_FocusCret := nil;
   g_FocusItem := nil;
   g_MagicTarget := nil;
   g_nDebugCount := 0;
   g_nDebugCount1 := 0;
   g_nDebugCount2 := 0;
   g_nTestSendCount := 0;
   g_nTestReceiveCount := 0;
   g_boServerChanging := FALSE;
   g_boBagLoaded := FALSE;
   g_boStoreLoaded := FALSE;
   g_boAutoDig := FALSE;

   g_dwLatestClientTime2 := 0;
   g_dwFirstClientTime := 0;
   g_dwFirstServerTime := 0;
   g_dwFirstClientTimerTime := 0;
   g_dwLatestClientTimerTime := 0;
   g_dwFirstClientGetTime := 0;
   g_dwLatestClientGetTime := 0;

   g_nTimeFakeDetectCount := 0;
   g_nTimeFakeDetectTimer := 0;
   g_nTimeFakeDetectSum := 0;

   g_dwSHGetTime := 0;
   g_dwSHTimerTime := 0;
   g_nSHFakeCount := 0;

   g_nDayBright := 3;
   g_nAreaStateValue := 0;
   g_ConnectionStep := cnsLogin;
   g_boSendLogin:=False;
   g_boServerConnected := FALSE;
   SocStr := '';
   WarningLevel := 0;
   ActionFailLock := FALSE;
   g_boMapMoving := FALSE;
   g_boMapMovingWait := FALSE;
   g_boCheckBadMapMode := FALSE;
   g_boCheckSpeedHackDisplay := FALSE;
   g_boViewMiniMap := FALSE;
   g_boShowGreenHint := FALSE;
   g_boShowWhiteHint := FALSE;
   FailDir := 0;
   FailAction := 0;
   g_nDupSelection := 0;

   g_dwLastAttackTick := GetTickCount;
   g_dwLastMoveTick := GetTickCount;
   g_dwLatestSpellTick := GetTickCount;

   g_dwAutoPickupTick := GetTickCount;
   g_boFirstTime := TRUE;
   g_boItemMoving := FALSE;
   g_boDoFadeIn := FALSE;
   g_boDoFadeOut := FALSE;
   g_boDoFastFadeOut := FALSE;
   g_boAttackSlow := FALSE;
   g_boMoveSlow := FALSE;
   g_boFrozen := FALSE;
   g_boNextTimePowerHit := FALSE;
   g_boCanLongHit := FALSE;
   g_boCanWideHit := FALSE;
   g_boCanCrsHit   := False;
   g_boCanTwnHit   := False;

   g_boNextTimeFireHit := FALSE;

   g_boNoDarkness := FALSE;
   g_SoftClosed := FALSE;
   g_boQueryPrice := FALSE;
   g_sSellPriceStr := '';

   g_boAllowGroup := FALSE;
   g_GroupMembers := TStringList.Create;

   MainWinHandle := DxDraw.Handle;

   BoOneClick := False;
   OneClickMode := toNone;

   g_boSound:=True;
   g_boBGSound:=True;

   if g_sMainParam1 = '' then begin
     CSocket.Address:=g_sServerAddr;
     CSocket.Port:=g_nServerPort;
   end else begin
      if (g_sMainParam1 <> '') and (g_sMainParam2 = '') then
         CSocket.Address := g_sMainParam1;
      if (g_sMainParam2 <> '') and (g_sMainParam3 = '') then begin
         CSocket.Address := g_sMainParam1;
         CSocket.Port := Str_ToInt (g_sMainParam2, 0);
      end;
      if (g_sMainParam3 <> '') then begin
         if CompareText (g_sMainParam1, '/KWG') = 0 then begin
            {
            CSocket.Address := kornetworldaddress;  //game.megapass.net';
            CSocket.Port := 9000;
            BoOneClick := TRUE;
            OneClickMode := toKornetWorld;
            with KornetWorld do begin
               CPIPcode := MainParam2;
               SVCcode  := MainParam3;
               LoginID  := MainParam4;
               CheckSum := MainParam5; //'dkskxhdkslxlkdkdsaaaasa';
            end;
            }
         end else begin
            CSocket.Address := g_sMainParam2;
            CSocket.Port := Str_ToInt (g_sMainParam3, 0);
            BoOneClick := TRUE;
         end;
      end;
   end;
   if BO_FOR_TEST then
      CSocket.Address := TestServerAddr;

   CSocket.Active:=True;

   //MainSurface := nil;
   DebugOutStr ('----------------------- started ------------------------');

   Application.OnException := OnProgramException;
   Application.OnIdle := AppOnIdle;
end;

procedure TfrmMain.OnProgramException (Sender: TObject; E: Exception);
begin
   DebugOutStr (E.Message);
end;

procedure TfrmMain.WMSysCommand(var Message: TWMSysCommand);
begin
{   with Message do begin
      if (CmdType and $FFF0) = SC_KEYMENU then begin
         if (Key = VK_TAB) or (Key = VK_RETURN) then begin
            FrmMain.WindowState := wsMinimized;
         end else
            inherited;
      end else
         inherited;
   end;
}
   inherited;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  ClearShowItemList();
  g_ShowItemList.Free;
  g_ShowItemList:=nil;
  g_AutoPickupList.Free;
  g_AutoPickupList:=nil;
   if g_ToolMenuHook <> 0 then UnhookWindowsHookEx(g_ToolMenuHook);
   //SoundCloseProc;
   //DXTimer.Enabled := FALSE;
   Timer1.Enabled := FALSE;
   MinTimer.Enabled := FALSE;
   UnLoadWMImagesLib();
   {
   WObjects1.Finalize;
   WObjects2.Finalize;
   WObjects3.Finalize;
   WObjects4.Finalize;
   WObjects5.Finalize;
   WObjects6.Finalize;
   WObjects7.Finalize;
   WObjects8.Finalize;
   WObjects9.Finalize;
   WObjects10.Finalize;
   }
//   WTiles.Finalize;
//   WHumWing.Finalize;
//   WSmTiles.Finalize;
//   WHumImg.Finalize;
//   WHairImg.Finalize;
//   WWeapon.Finalize;
//   WMagic.Finalize;
//   WMagic2.Finalize;
//   WMagIcon.Finalize;
//   WNpcImg.Finalize;
//   WChrSel.Finalize;
//   WMMap.Finalize;
//   WBagItem.Finalize;
//   WStateItem.Finalize;
//   WDnItem.Finalize;
//   FrmMain.WPrgUse.Finalize;
   WDragonImg.Finalize;
   WPrgUse3.Finalize;
   WMonImg.Finalize;
   WMon2Img.Finalize;
   WMon3Img.Finalize;
   WMon4Img.Finalize;
   WMon5Img.Finalize;
   WMon6Img.Finalize;
   WMon7Img.Finalize;
   WMon8Img.Finalize;
   WMon9Img.Finalize;
   WMon10Img.Finalize;
   WMon11Img.Finalize;
   WMon12Img.Finalize;
   WMon13Img.Finalize;
   WMon14Img.Finalize;
   WMon15Img.Finalize;
   WMon16Img.Finalize;
   WMon17Img.Finalize;
   WMon18Img.Finalize;
   WMon19Img.Finalize;
   WMon20Img.Finalize;
   WMon21Img.Finalize;
   WMon22Img.Finalize;
   WMon23Img.Finalize;
   WMon24Img.Finalize;
   WMon25Img.Finalize;
   WMon26Img.Finalize;
   WMon27Img.Finalize;
   WMon28Img.Finalize;
   WMon29Img.Finalize;
   WEffectImg.Finalize;

   for I := 0 to NpcImageList.Count - 1 do begin
     TWMImages(NpcImageList.Items[I]).Finalize;
   end;
   for I := 0 to ItemImageList.Count - 1 do begin
     TWMImages(ItemImageList.Items[I]).Finalize;
   end;
   for I := 0 to WeaponImageList.Count - 1 do begin
     TWMImages(WeaponImageList.Items[I]).Finalize;
   end;
   for I := 0 to HumImageList.Count - 1 do begin
     TWMImages(HumImageList.Items[I]).Finalize;
   end;

   DScreen.Finalize;
   PlayScene.Finalize;
//   LoginNoticeScene.Finalize;
//   LoadingScene.Finalize;
   DScreen.Free;
   IntroScene.Free;
   LoginScene.Free;
   SelectChrScene.Free;
   PlayScene.Free;
//   LoginNoticeScene.Free;
//   LoadingScene.Free;
   g_SaveItemList.Free;
   g_MenuItemList.Free;

   DebugOutStr ('----------------------- closed -------------------------');
   Map.Free;
   g_DropedItemList.Free;
   g_MagicList.Free;
   g_FreeActorList.Free;
   g_ChangeFaceReadyList.Free;

   g_ServerList.Free;
   //if MainSurface <> nil then MainSurface.Free;

   g_Sound.Free;
   g_SoundList.Free;
   BGMusicList.Free;
   //DObjList.Free;
   EventMan.Free;
   NpcImageList.Free;
   ItemImageList.Free;
   WeaponImageList.Free;
   HumImageList.Free;

   g_DXSound.Free;
   g_DWinMan.Free;
end;

function ComposeColor(Dest, Src: TRGBQuad; Percent: Integer): TRGBQuad;
begin
  with Result do
  begin
    rgbRed := Src.rgbRed+((Dest.rgbRed-Src.rgbRed)*Percent div 256);
    rgbGreen := Src.rgbGreen+((Dest.rgbGreen-Src.rgbGreen)*Percent div 256);
    rgbBlue := Src.rgbBlue+((Dest.rgbBlue-Src.rgbBlue)*Percent div 256);
    rgbReserved := 0;
  end;
end;

procedure TfrmMain.DXDrawInitialize(Sender: TObject);
begin
   if g_boFirstTime then begin
      g_boFirstTime := FALSE;

      DxDraw.SurfaceWidth := SCREENWIDTH;
      DxDraw.SurfaceHeight := SCREENHEIGHT;

{$IF USECURSOR = DEFAULTCURSOR}
      DxDraw.Cursor:=crHourGlass;
{$ELSE}
      DxDraw.Cursor:=crNone;
{$IFEND}

      DxDraw.Surface.Canvas.Font.Assign (FrmMain.Font);

      FrmMain.Font.Name := g_sCurFontName;
      FrmMain.Canvas.Font.Name := g_sCurFontName;
      DxDraw.Surface.Canvas.Font.Name := g_sCurFontName;
      PlayScene.EdChat.Font.Name := g_sCurFontName;
      //MainSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      //MainSurface.SystemMemory := TRUE;
      //MainSurface.SetSize (SCREENWIDTH, SCREENHEIGHT);
      InitWMImagesLib(DxDraw);
      {
      WObjects1.DDraw := DxDraw.DDraw;
      WObjects2.DDraw := DxDraw.DDraw;
      WObjects3.DDraw := DxDraw.DDraw;
      WObjects4.DDraw := DxDraw.DDraw;
      WObjects5.DDraw := DxDraw.DDraw;
      WObjects6.DDraw := DxDraw.DDraw;
      WObjects7.DDraw := DxDraw.DDraw;
      WObjects8.DDraw := DxDraw.DDraw;
      WObjects9.DDraw := DxDraw.DDraw;
      WObjects10.DDraw := DxDraw.DDraw;
      }
//      WTiles.DDraw := DxDraw.DDraw;
//      WHumWing.DDraw := DxDraw.DDraw;
//      WSmTiles.DDraw := DxDraw.DDraw;
//      WChrSel.DDraw := DxDraw.DDraw;
//      WMMap.DDraw := DxDraw.DDraw;
//      WBagItem.DDraw := DxDraw.DDraw;
//      WStateItem.DDraw := DxDraw.DDraw;
//      WDnItem.DDraw := DxDraw.DDraw;
//      WHumImg.DDraw := DxDraw.DDraw;
//      WHairImg.DDraw := DxDraw.DDraw;
//      WWeapon.DDraw := DxDraw.DDraw;
//      WMagic.DDraw := DxDraw.DDraw;
//      WMagic2.DDraw := DxDraw.DDraw;
//      WMagIcon.DDraw := DxDraw.DDraw;
//      FrmMain.WPrgUse.DDraw := DxDraw.DDraw;
//      WNpcImg.DDraw := DxDraw.DDraw;
      WDragonImg.DDraw := DxDraw.DDraw;
      WMonImg.DDraw := DxDraw.DDraw;
      WPrgUse3.DDraw := DxDraw.DDraw;
      WMon2Img.DDraw := DxDraw.DDraw;
      WMon3Img.DDraw := DxDraw.DDraw;
      WMon4Img.DDraw := DxDraw.DDraw;
      WMon5Img.DDraw := DxDraw.DDraw;
      WMon6Img.DDraw := DxDraw.DDraw;
      WMon7Img.DDraw := DxDraw.DDraw;
      WMon8Img.DDraw := DxDraw.DDraw;
      WMon9Img.DDraw := DxDraw.DDraw;
      WMon10Img.DDraw := DxDraw.DDraw;
      WMon11Img.DDraw := DxDraw.DDraw;
      WMon12Img.DDraw := DxDraw.DDraw;
      WMon13Img.DDraw := DxDraw.DDraw;
      WMon14Img.DDraw := DxDraw.DDraw;
      WMon15Img.DDraw := DxDraw.DDraw;
      WMon16Img.DDraw := DxDraw.DDraw;
      WMon17Img.DDraw := DxDraw.DDraw;
      WMon18Img.DDraw := DxDraw.DDraw;
      WMon19Img.DDraw := DxDraw.DDraw;
      WMon20Img.DDraw := DxDraw.DDraw;
      WMon21Img.DDraw := DxDraw.DDraw;
      WMon22Img.DDraw := DxDraw.DDraw;
      WMon23Img.DDraw := DxDraw.DDraw;
      WMon24Img.DDraw := DxDraw.DDraw;
      WMon25Img.DDraw := DxDraw.DDraw;
      WMon26Img.DDraw := DxDraw.DDraw;
      WMon27Img.DDraw := DxDraw.DDraw;
      WMon28Img.DDraw := DxDraw.DDraw;
      WMon29Img.DDraw := DxDraw.DDraw;
      WEffectImg.DDraw := DxDraw.DDraw;
      {
      WObjects1.Initialize;
      WObjects2.Initialize;
      WObjects3.Initialize;
      WObjects4.Initialize;
      WObjects5.Initialize;
      WObjects6.Initialize;
      WObjects7.Initialize;
      WObjects8.Initialize;
      WObjects9.Initialize;
      WObjects10.Initialize;
      }
//      WTiles.Initialize;
//      WHumWing.Initialize;
//      WSmTiles.Initialize;
//      WChrSel.Initialize;
//      WMMap.Initialize;
//      WBagItem.Initialize;
//      WStateItem.Initialize;
//      WDnItem.Initialize;
//      WHumImg.Initialize;
//      WHairImg.Initialize;
//      WWeapon.Initialize;
//      WMagic.Initialize;
//      WMagic2.Initialize;
//      WMagIcon.Initialize;
//      FrmMain.WPrgUse.Initialize;
//      WNpcImg.Initialize;
      WDragonImg.Initialize;
      WPrgUse3.Initialize;
      WMonImg.Initialize;
      WMon2Img.Initialize;
      WMon3Img.Initialize;
      WMon4Img.Initialize;
      WMon5Img.Initialize;
      WMon6Img.Initialize;
      WMon7Img.Initialize;
      WMon8Img.Initialize;
      WMon9Img.Initialize;
      WMon10Img.Initialize;
      WMon11Img.Initialize;
      WMon12Img.Initialize;
      WMon13Img.Initialize;
      WMon14Img.Initialize;
      WMon15Img.Initialize;
      WMon16Img.Initialize;
      WMon17Img.Initialize;
      WMon18Img.Initialize;
      WMon19Img.Initialize;
      WMon20Img.Initialize;
      WMon21Img.Initialize;
      WMon22Img.Initialize;
      WMon23Img.Initialize;
      WMon24Img.Initialize;
      WMon25Img.Initialize;
      WMon26Img.Initialize;
      WMon27Img.Initialize;
      WMon28Img.Initialize;
      WMon29Img.Initialize;
      WEffectImg.Initialize;

      DxDraw.DefColorTable := g_WMainImages.MainPalette;
      DxDraw.ColorTable := DxDraw.DefColorTable;
      DxDraw.UpdatePalette;

      //256 Blend utility
      if not LoadNearestIndex (NEARESTPALETTEINDEXFILE) then begin
         BuildNearestIndex (DxDraw.ColorTable);
         SaveNearestIndex (NEARESTPALETTEINDEXFILE);
      end;
      BuildColorLevels (DxDraw.ColorTable);
      buildrealrgb(DxDraw.ColorTable);

      DScreen.Initialize;
      PlayScene.Initialize;
      FrmDlg.Initialize;

      if doFullScreen in DxDraw.Options then begin
         //Screen.Cursor := crNone;
      end else begin
         // DF WindowModeFix 1
         FrmMain.ClientWidth := SCREENWIDTH;
         FrmMain.ClientHeight := SCREENHEIGHT;
         g_boNoDarkness := TRUE;
         g_boUseDIBSurface := TRUE;
         //frmMain.BorderStyle := bsSingle;
      end;

      g_ImgMixSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_ImgMixSurface.SystemMemory := TRUE;
      g_ImgMixSurface.SetSize(700, 800);
      g_MiniMapSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_MiniMapSurface.SystemMemory := TRUE;
      g_MiniMapSurface.SetSize (540, 360);

      g_MapSurface := TDirectDrawSurface.Create (frmMain.DxDraw.DDraw);
      g_MapSurface.SystemMemory := TRUE;
      g_MapSurface.SetSize (600, 600);
      //DxDraw.Surface.SystemMemory := TRUE;
   end;
end;

procedure TfrmMain.DXDrawFinalize(Sender: TObject);
begin
   //DXTimer.Enabled := FALSE;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ini: TIniFile;
begin
   //Savebags ('.\Data\' + ServerName + '.' + CharName + '.itm', @ItemArr);
   //DxTimer.Enabled := FALSE;
   if g_boFullScreen then exit;
   ini := TIniFile.Create (CLI.Get(CLI.Exists('ini')).sValue);
   if ini <> nil then begin
     ini.WriteInteger ('Positions', 'Left', frmMain.Left);
     ini.WriteInteger ('Positions', 'Top', frmMain.Top);
     ini.Free;
   end;
end;

{------------------------------------------------------------}

procedure TfrmMain.ProcOnIdle;
var
   done: Boolean;
begin
   AppOnIdle (self, done);
   //DXTimerTimer (self, 0);
end;

procedure TfrmMain.AppOnIdle (Sender: TObject; var Done: Boolean);
//procedure TFrmMain.DXTimerTimer(Sender: TObject; LagCount: Integer);
var
   i, j: integer;
   p: TPoint;
   DF: TDDBLTFX;
   d: TDirectDrawSurface;
   nC:integer;
   Left,Top: Integer;
begin
   Done := TRUE;
   if not DxDraw.CanDraw then exit;

   if not g_boFullScreen then begin
      // DF WindowModeFix 2
     Left := (FrmMain.Width-frmMain.ClientWidth) Div 2;
     Top := FrmMain.Height-frmMain.ClientHeight-Left;
     g_nTopDrawPos := frmMain.Top+Top;
     g_nLeftDrawPos := frmMain.Left+Left;
   end;   

  // DxDraw.Surface.Fill(0);
  // BoldTextOut (DxDraw.Surface, 0, 0, clBlack, clBlack, 'test test ' + TimeToStr(Time));
  // DxDraw.Surface.Canvas.Release;

   ProcessKeyMessages;
   ProcessActionMessages;
   DScreen.DrawScreen (DxDraw.Surface);
   g_DWinMan.DirectPaint (DxDraw.Surface);
   DScreen.DrawScreenTop (DxDraw.Surface);
   DScreen.DrawHint (DxDraw.Surface);

{$IF USECURSOR = IMAGECURSOR}
   {Draw cursor}
   //=========================================
   CursorSurface := g_WMainImages.Images[0];
   if CursorSurface <> nil then begin
      GetCursorPos (p);
      DxDraw.Surface.Draw (p.x, p.y, CursorSurface.ClientRect, CursorSurface, TRUE);
   end;
   //==========================
{$IFEND}

   if g_boItemMoving then begin
      if (g_MovingItem.Item.S.Name <> g_sGoldName) then
         d := g_WBagItemImages.Images[g_MovingItem.Item.S.Looks]
      else d := g_WBagItemImages.Images[115];
      if d <> nil then begin
         GetCursorPos (p);
         DxDraw.Surface.Draw (p.x-(d.ClientRect.Right div 2),
                              p.y-(d.ClientRect.Bottom div 2),
                              d.ClientRect,
                              d,
                              TRUE);
        {if (g_MovingItem.Item.S.Name <> g_sGoldName) then
          with DxDraw.Surface.Canvas do begin
            SetBkMode (Handle, TRANSPARENT);
            Font.Color := clYellow;
            TextOut (p.X + 9, p.Y + 3,g_MovingItem.Item.S.Name);
            Release;
          end;}
      end;
   end;
   if g_boDoFadeOut then begin
      if g_nFadeIndex < 1 then g_nFadeIndex := 1;
      MakeDark (DxDraw.Surface, g_nFadeIndex);
      if g_nFadeIndex <= 1 then g_boDoFadeOut := FALSE
      else Dec (g_nFadeIndex, 2);
   end else
   if g_boDoFadeIn then begin
      if g_nFadeIndex > 29 then g_nFadeIndex := 29;
      MakeDark (DxDraw.Surface, g_nFadeIndex);
      if g_nFadeIndex >= 29 then g_boDoFadeIn := FALSE
      else Inc (g_nFadeIndex, 2);
   end else
   if g_boDoFastFadeOut then begin
      if g_nFadeIndex < 1 then g_nFadeIndex := 1;
      MakeDark (DxDraw.Surface, g_nFadeIndex);
      if g_nFadeIndex > 1 then Dec (g_nFadeIndex, 4);
   end;
   {
   for i:=0 to 15 do
      for j:=0 to 15 do begin
         DxDraw.Surface.FillRect(Rect (j*16, i*16, (j+1)*16, (i+1)*16), i*16 + j);
      end;

   for i:=0 to 15 do
      DxDraw.Surface.Canvas.TextOut (600, i*14,
                                    IntToStr(i) + ' ' +
                                    IntToStr(DxDraw.ColorTable[i].rgbRed) + ' ' +
                                    IntToStr(DxDraw.ColorTable[i].rgbGreen) + ' ' +
                                    IntToStr(DxDraw.ColorTable[i].rgbBlue));
   DxDraw.Surface.Canvas.Release;}

   //DxDraw.Flip;
   if g_ConnectionStep = cnsLogin then begin
     with DxDraw.Surface.Canvas do begin
       Brush.Color:=clGreen;
       nC:=64;
       RoundRect(SCREENWIDTH - nC,0,SCREENWIDTH,nC,nC,nC);
       Font.Color := clBlack;
       SetBkMode (Handle, TRANSPARENT);
       TextOut ((SCREENWIDTH - nC) + ((nC - TextWidth(DecodeString(DecodeString(g_sLogoText)))) div 2), (nC - TextHeight('W')) div 2,DecodeString(DecodeString(g_sLogoText)));
       Release;
     end;
     //显示文件版本号
     with DxDraw.Surface.Canvas do begin
       Font.Color := clWhite;
       SetBkMode (Handle, TRANSPARENT);
       TextOut (135, 15,DecodeString(DecodeString('K@UNiddisISexhQsb?UYLl')));
       TextOut (135, 25,DecodeString(DecodeString('CwPPaRgjy_rTCKFMqQDXMZuq`^ENV<')));
       Release;
     end;
   end;

   // DF WindowModeFix 3
   DxDraw.Primary.Draw (0+g_nLeftDrawPos, 0+g_nTopDrawPos, DxDraw.Surface.ClientRect, DxDraw.Surface, FALSE);
   // Needed for Drawing on monitors that are not the Primary Monitor (IE Dual Screen Systems)
   if not g_boDisableFlip then DxDraw.Flip;
   if g_MySelf <> nil then begin
   end;
end;

procedure TfrmMain.AppLogout;
var
  Msg: String;
begin
   if g_MySelf.m_boDeath then begin
   Msg:='你已经死亡,是否注销？'
   end else begin
   Msg:='你是否注销？'
   end;
   if mrOk = FrmDlg.DSimpleMessageDlg (Msg, [mbOk, mbCancel]) then begin
      SendClientMessage (CM_SOFTCLOSE, 0, 0, 0, 0);
      PlayScene.ClearActors;
      CloseAllWindows;
      FrmDlg.DSkillBar.Visible := false;
      if not BoOneClick then begin
         g_SoftClosed := TRUE;
         ActiveCmdTimer (tcSoftClose);
      end else begin
         ActiveCmdTimer (tcReSelConnect);
      end;
      if g_boBagLoaded then
         Savebags ('.\Data\' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
      g_boBagLoaded := FALSE;
      if g_boStoreLoaded then
         SaveStores ('.\Data\' + g_sServerName + '.' + CharName + '.sto', @g_StoreItem);
      g_boStoreLoaded := FALSE;
   end;
end;

procedure TfrmMain.AppExit;
begin
   if mrOk = FrmDlg.DSimpleMessageDlg ('你是否要退出龙的传说？', [mbOk, mbCancel]) then begin
     DScreen.ClearHint;

      if g_boBagLoaded then
         Savebags ('.\Data\' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
      g_boBagLoaded := FALSE;
      if g_boStoreLoaded then
         SaveStores ('.\Data\' + g_sServerName + '.' + CharName + '.sto', @g_StoreItem);
      g_boStoreLoaded := FALSE;
      FrmMain.Close;
   end;
end;

procedure TfrmMain.PrintScreenNow;
   function IntToStr2(n: integer): string;
   begin
      if n < 10 then Result := '0' + IntToStr(n)
      else Result := IntToStr(n);
   end;
var
   i, k, n, checksum: integer;
   flname: string;
   dib: TDIB;
   ddsd: TDDSurfaceDesc;
   sptr, dptr: PByte;
   lom2:string;
begin
 lom2:='K[GAolnrf_TH``T';

   if not DxDraw.CanDraw then exit;
   while TRUE do begin
      flname := '截图' + IntToStr2(g_nCaptureSerial) + '.bmp';
      if not FileExists (flname) then break;
      Inc (g_nCaptureSerial);
   end;
   dib := TDIB.Create;
   dib.BitCount := 8;
   dib.Width := SCREENWIDTH;
   dib.Height := SCREENHEIGHT;
   dib.ColorTable := g_WMainImages.MainPalette;
   dib.UpdatePalette;

   ddsd.dwSize := SizeOf(ddsd);
   checksum := 0;
   try
      DxDraw.Primary.Lock (TRect(nil^), ddsd);
      for i := (600-120) to SCREENHEIGHT-10 do begin
         sptr := PBYTE(integer(ddsd.lpSurface) + (SCREENHEIGHT - 1 - i)*ddsd.lPitch + 200);
         for k:=0 to 400-1 do begin
            checksum := checksum + byte(pbyte(integer(sptr) + k)^);
         end;
      end;
   finally
      DxDraw.Primary.Unlock();
   end;

   try
      SetBkMode (DxDraw.Primary.Canvas.Handle, TRANSPARENT);
      DxDraw.Primary.Canvas.Font.Color := clWhite;
      n := 0;
      if g_MySelf <> nil then begin
         DxDraw.Primary.Canvas.TextOut (0, 0, g_sServerName + ' ' + g_MySelf.m_sUserName);
         Inc (n, 1);
      end;
      DxDraw.Primary.Canvas.TextOut (0, (n)*12,   'CheckSum=' + IntToStr(checksum));
      DxDraw.Primary.Canvas.TextOut (0, (n+1)*12, DateToStr(Date));
      DxDraw.Primary.Canvas.TextOut (0, (n+2)*12, TimeToStr(Time));
      DxDraw.Primary.Canvas.TextOut (0, (n+3)*12, 'Ver '+ DecodeString(DecodeString(Lom2)));
      DxDraw.Primary.Canvas.Release;
      DxDraw.Primary.Lock (TRect(nil^), ddsd);
      for i := 0 to dib.Height-1 do begin
         sptr := PBYTE(integer(ddsd.lpSurface) + (dib.Height - 1 - i)*ddsd.lPitch);
         dptr := PBYTE(integer(dib.PBits) + i * SCREENWIDTH);
         Move (sptr^, dptr^, SCREENWIDTH);
      end;
   finally
      DxDraw.Primary.Unlock();
   end;
   dib.SaveToFile (flname);
   dib.Clear;
   dib.Free;
end;

{------------------------------------------------------------}

procedure TfrmMain.ProcessKeyMessages;
begin
   case ActionKey of
     VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8: begin
       UseMagic (g_nMouseX, g_nMouseY, GetMagicByKey (char ((ActionKey-VK_F1) + byte('1')) ));
       ActionKey := 0;
       g_nTargetX := -1;
       exit;
     end;
     12..19: begin
       UseMagic (g_nMouseX, g_nMouseY, GetMagicByKey (char ((ActionKey-12) + byte('1') + byte($14)) ));
       ActionKey := 0;
       g_nTargetX := -1;
       exit;
     end;
   end;
end;

procedure TfrmMain.ProcessActionMessages;
var
   mx, my, dx, dy, crun: integer;
   ndir, adir, mdir: byte;
   bowalk, bostop: Boolean;
label
   LB_WALK,TTTT;
begin
   if g_MySelf = nil then exit;
   //Move
   if (g_nTargetX >= 0) and CanNextAction and ServerAcceptNextAction then begin
      if (g_nTargetX <> g_MySelf.m_nCurrX) or (g_nTargetY <> g_MySelf.m_nCurrY) then begin
         TTTT:
         mx := g_MySelf.m_nCurrX;
         my := g_MySelf.m_nCurrY;
         dx := g_nTargetX;
         dy := g_nTargetY;
         ndir := GetNextDirection (mx, my, dx, dy);
         case g_ChrAction of
            caWalk: begin
               LB_WALK:
               {
               DScreen.AddSysMsg ('caWalk ' + IntToStr(Myself.XX) + ' ' +
                                              IntToStr(Myself.m_nCurrY) + ' ' +
                                              IntToStr(TargetX) + ' ' +
                                              IntToStr(TargetY));
                                              }
               crun := g_MySelf.CanWalk;
               if IsUnLockAction (CM_WALK, ndir) and (crun > 0) then begin
                  GetNextPosXY (ndir, mx, my);
                  bowalk := TRUE;
                  bostop := FALSE;
                  if not PlayScene.CanWalk (mx, my) then begin
                     bowalk := FALSE;
                     adir := 0;
                     if not bowalk then begin
                        mx := g_MySelf.m_nCurrX;
                        my := g_MySelf.m_nCurrY;
                        GetNextPosXY (ndir, mx, my);
                        if CheckDoorAction (mx, my) then
                           bostop := TRUE;
                     end;
                     if not bostop and not PlayScene.CrashMan(mx,my) then begin
                        mx := g_MySelf.m_nCurrX;
                        my := g_MySelf.m_nCurrY;
                        adir := PrivDir(ndir);
                        GetNextPosXY (adir, mx, my);
                        if not Map.CanMove(mx,my) then begin
                           mx := g_MySelf.m_nCurrX;
                           my := g_MySelf.m_nCurrY;
                           adir := NextDir (ndir);
                           GetNextPosXY (adir, mx, my);
                           if Map.CanMove(mx,my) then
                              bowalk := TRUE;
                        end else
                           bowalk := TRUE;
                     end;
                     if bowalk then begin
                        g_MySelf.UpdateMsg (CM_WALK, mx, my, adir, 0, 0, '', 0);
                        g_dwLastMoveTick := GetTickCount;
                     end else begin
                        mdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, dx, dy);
                        if mdir <> g_MySelf.m_btDir then
                           g_MySelf.SendMsg (CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, 0, 0, '', 0);
                        g_nTargetX := -1;
                     end;
                  end else begin
                     g_MySelf.UpdateMsg (CM_WALK, mx, my, ndir, 0, 0, '', 0);
                     g_dwLastMoveTick := GetTickCount;
                  end;
               end else begin
                  g_nTargetX := -1;
               end;
            end;
            caRun: begin
               //免助跑
               if g_boCanStartRun or (g_nRunReadyCount >= 1) then begin
                  crun := g_MySelf.CanRun;
//骑马开始
                  if (g_MySelf.m_btHorse <> 0)
                     and (GetDistance (mx, my, dx, dy) >= 3)
                     and (crun > 0)
                     and IsUnLockAction (CM_HORSERUN, ndir) then begin
                    GetNextHorseRunXY (ndir, mx, my);
                    if PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                      g_MySelf.UpdateMsg (CM_HORSERUN, mx, my, ndir, 0, 0, '', 0);
                      g_dwLastMoveTick := GetTickCount;
                     end else begin  //如果跑失败则跳回去走
                        g_ChrAction:=caWalk;
                        goto TTTT;
                     end;
                  end else begin
//骑马结束
                  if (GetDistance (mx, my, dx, dy) >= 2) and (crun > 0) then begin
                     if IsUnLockAction (CM_RUN, ndir) then begin
                        GetNextRunXY (ndir, mx, my);
                        if PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mx, my) then begin
                           g_MySelf.UpdateMsg (CM_RUN, mx, my, ndir, 0, 0, '', 0);
                           g_dwLastMoveTick := GetTickCount;
                        end else begin  //如果跑失败则跳回去走
                          g_ChrAction:=caWalk;
                          goto TTTT;
                        end;
                     end else
                        g_nTargetX := -1;
                  end else begin

                    mdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, dx, dy);
                    if mdir <> g_MySelf.m_btDir then
                       g_MySelf.SendMsg (CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, 0, 0, '', 0);
                    g_nTargetX := -1;

                     //if crun = -1 then begin
                        //DScreen.AddSysMsg ('瘤陛篮 钝 荐 绝嚼聪促.');
                        //TargetX := -1;
                     //end;
                     goto LB_WALK;
                     {if crun = -2 then begin
                        DScreen.AddSysMsg ('泪矫饶俊 钝 荐 乐嚼聪促.');
                        TargetX := -1;
                     end; }
                  end;
                  end;  //骑马结束
               end else begin
                  Inc (g_nRunReadyCount);
                  goto LB_WALK;
               end;
            end;
         end;
      end;
   end;
   g_nTargetX := -1;
   if g_MySelf.RealActionMsg.Ident > 0 then begin
      FailAction := g_MySelf.RealActionMsg.Ident;
      FailDir := g_MySelf.RealActionMsg.Dir;
      if g_MySelf.RealActionMsg.Ident = CM_SPELL then begin
         SendSpellMsg (g_MySelf.RealActionMsg.Ident,
                       g_MySelf.RealActionMsg.X,
                       g_MySelf.RealActionMsg.Y,
                       g_MySelf.RealActionMsg.Dir,
                       g_MySelf.RealActionMsg.State);
      end else
         SendActMsg (g_MySelf.RealActionMsg.Ident,
                  g_MySelf.RealActionMsg.X,
                  g_MySelf.RealActionMsg.Y,
                  g_MySelf.RealActionMsg.Dir);
      g_MySelf.RealActionMsg.Ident := 0;

      if g_nMDlgX <> -1 then
         if (abs(g_nMDlgX-g_MySelf.m_nCurrX) >= 8) or (abs(g_nMDlgY-g_MySelf.m_nCurrY) >= 8) then begin
            FrmDlg.CloseMDlg;
            g_nMDlgX := -1;
         end;
   end;
end;

procedure TfrmMain.CMDialogKey(var Msg: TWMKEY);
begin
  if (Msg.CharCode = VK_TAB) then
    if (g_MySelf <> nil) and (DScreen.CurrentScene = PlayScene) then
      if g_boShowAllItem then
        FrmDlg.DOptionsDropViewOffClick(Nil,0,0)
      else
        FrmDlg.DOptionsDropViewOnClick(Nil,0,0);
  inherited
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  msg, wc, dir, mx, my: integer;
  ini: TIniFile;
begin
  case Key of
    VK_PAUSE: begin
      Key:=0;
      PrintScreenNow();
    end;
  end;

  if (ssAlt in Shift) and (Key=VK_RETURN) then
  begin
    DXDraw.Finalize;
    if doFullScreen in DXDraw.Options then
    begin
      RestoreWindow;
      BorderStyle := bsSizeable;
      DXDraw.Options := DXDraw.Options - [doFullScreen];
    end else
    begin
      StoreWindow;
      DXDraw.Cursor := crNone;
      BorderStyle := bsNone;
      DXDraw.Options := DXDraw.Options + [doFullScreen];
    end;
    DXDraw.Initialize;
  end;

  if g_DWinMan.KeyDown (Key, Shift) then exit;

  if (ssCtrl in Shift) and not(g_boSkillSetting) then
    FrmDlg.DSkillBar.SetImgIndex (g_WMainImages, 712);

  if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then exit;
  mx:=g_MySelf.m_nCurrX;
  my:=g_MySelf.m_nCurrY;
  case Key of
    VK_F1, VK_F2, VK_F3, VK_F4,
    VK_F5, VK_F6, VK_F7, VK_F8: begin
      if (GetTickCount - g_dwLatestSpellTick > (g_dwSpellTime + g_dwMagicDelayTime)) then begin
        if frmdlg.DSkillBar.FaceIndex = 712 then begin
          ActionKey:=Key - 100;
        end else begin
          ActionKey:=Key;
        end;
      end;
      Key:=0;
    end;
    VK_F9: begin
      FrmDlg.OpenItemBag;
    end;
    VK_F10: begin
      FrmDlg.StatePage := 0;
      FrmDlg.OpenMyStatus;
    end;
    VK_F11: begin
      FrmDlg.StatePage := 3;
      FrmDlg.OpenMyStatus;
    end;
    VK_F12: begin
      if (ssCtrl in Shift) and (ssAlt in Shift) then begin
        frmDlgConfig.Top:= (SCREENHEIGHT - frmDlgConfig.Height) div 2;
        frmDlgConfig.Left:= (SCREENWIDTH - frmDlgConfig.Width) div 2;
        frmDlgConfig.Open;
      end;
    end;
    //窗口测试专用
    VK_HOME: begin
     //FrmDlg.DAddBag3.Visible := True;
     //FrmDlg.DRefineDlg.Visible := True;
     //FrmDlg.DStoragePass.Visible := True;
     //FrmDlg.EnterPasswd.Visible := true;
     FrmDlg.DBank.Visible := true;
    end;
//    VK_ESCAPE: begin
//      CloseAllWindows;
//    end;
    word('H'): begin
      if ssCtrl in Shift then begin
        SendSay ('@AttackMode');
        end else begin
        if not PlayScene.EdChat.Visible then begin
          FrmDlg.OpenHelpWin();
        end
      end;
    end;

    word('Y'): begin
      if not PlayScene.EdChat.Visible then
        FrmDlg.OpenItemShopDlg();
    end;
    
    word('A'): begin
      if ssCtrl in Shift then begin
        SendSay ('@Rest');
      end else begin
        if not PlayScene.EdChat.Visible then begin
          FrmDlg.DAbout.Visible:=not FrmDlg.DAbout.Visible;
        end
      end;
    end;
    
    word('F'): begin
      if ssCtrl in Shift then begin
        if g_nCurFont < MAXFONT-1 then Inc(g_nCurFont)
        else g_nCurFont := 0;
        g_sCurFontName := g_FontArr[g_nCurFont];
        FrmMain.Font.Name := g_sCurFontName;
        FrmMain.Canvas.Font.Name := g_sCurFontName;
        DxDraw.Surface.Canvas.Font.Name := g_sCurFontName;
        PlayScene.EdChat.Font.Name := g_sCurFontName;

        ini := TIniFile.Create (CLI.Get(CLI.Exists('ini')).sValue);
        if ini <> nil then begin
          ini.WriteString ('Setup', 'FontName', g_sCurFontName);
          ini.Free;
        end;
      end;
    end;

    word('X'):
         begin
            if g_MySelf = nil then exit;
            if ssAlt in Shift then begin
               if (GetTickCount - g_dwLatestStruckTick > 10000) and
                  (GetTickCount - g_dwLatestMagicTick > 10000) and
                  (GetTickCount - g_dwLatestHitTick > 10000) or
                  (g_MySelf.m_boDeath) then
               begin
                  AppLogOut;
               end else
                  DScreen.AddChatBoardString ('你在战斗期间不能结束游戏.', clYellow, clRed);
            end;
         end;
      word('D'):
          begin
            if not(PlayScene.EdChat.Visible) then
              ToggleAutoRun;
          end;
      word('Q'):
          begin
            if g_MySelf = nil then exit;
            if ssAlt in Shift then begin
              if (GetTickCount - g_dwLatestStruckTick > 10000) and
                 (GetTickCount - g_dwLatestMagicTick > 10000) and
                 (GetTickCount - g_dwLatestHitTick > 10000) or
                 (g_MySelf.m_boDeath) then AppExit
              else
                DScreen.AddChatBoardString ('你在战斗期间不能结束游戏.', clYellow, clRed);
            end else begin
              if not PlayScene.EdChat.Visible then begin
                FrmDlg.OpenQuestAccept();
              end;
            end;
          end;

      word('V'):
          begin
            if not(PlayScene.EdChat.Visible) then
              FrmDlg.DBotMiniMapClick(Nil,0,0);
          end;
    word('B'): begin
        if not PlayScene.EdChat.Visible then begin


  if (g_nMapIndex < 1) then
    DScreen.AddChatBoardString('没有大地图信息.', clWhite, clRed)
  else begin

    if not g_boViewMap then begin
      g_nViewMapLv := 1;
      g_boViewMap := TRUE;
    end else begin
      if g_nViewMapLv >= 2 then begin
        g_nViewMapLv:=0;
       g_boViewMap := FALSE;
       end else Inc(g_nViewMapLv);
     end;
  end;
        end;
      end;
      word('T'): begin
        if not PlayScene.EdChat.Visible then begin
          if GetTickCount > g_dwQueryMsgTick then begin
            g_dwQueryMsgTick := GetTickCount + 3000;
            FrmMain.SendDealTry;
          end;
        end;
      end;
      word('G'): begin
         if ssCtrl in Shift then begin
           if g_FocusCret <> nil then begin
             if g_GroupMembers.Count = 0 then
               SendCreateGroup(g_FocusCret.m_sUserName)
             else SendAddGroupMember(g_FocusCret.m_sUserName);
             PlayScene.EdChat.Text:=g_FocusCret.m_sUserName;
           end;
         end else begin
           if ssAlt in Shift then begin
             if g_FocusCret <> nil then
               SendDelGroupMember(g_FocusCret.m_sUserName)
           end else begin
             if not PlayScene.EdChat.Visible then begin
               if FrmDlg.DGuildDlg.Visible then begin
                 FrmDlg.DGuildDlg.Visible := FALSE;
               end else
                if GetTickCount > g_dwQueryMsgTick then begin
                  g_dwQueryMsgTick := GetTickCount + 3000;
                  FrmMain.SendGuildDlg;
               end;
             end;
           end;
         end;
      end;

      word('O'): begin
        if not PlayScene.EdChat.Visible then
          FrmDlg.DOptionClick;
      end;

      word('P'): begin
        if not PlayScene.EdChat.Visible then
          FrmDlg.ToggleShowGroupDlg;
      end;

      word('Z'): begin
        if not PlayScene.EdChat.Visible then begin
          if ssCtrl in Shift then FrmDlg.DBeltSwapClick(Nil,0,0)
          else FrmDlg.DBeltCloseClick(Nil,0,0);
        end;
      end;

      word('L'): begin
        if not PlayScene.EdChat.Visible then
          FrmDlg.DBotLoverClick(Nil,0,0);
      end;

      word('C'): begin
        if not PlayScene.EdChat.Visible then begin
          FrmDlg.StatePage := 0;
          FrmDlg.OpenMyStatus;
        end;
      end;

      word('I'): begin
        if not PlayScene.EdChat.Visible then
          FrmDlg.OpenItemBag;
      end;

      word('S'): begin
        if not PlayScene.EdChat.Visible then begin
          FrmDlg.StatePage := 3;
          FrmDlg.OpenMyStatus;
        end;
      end;

      word('W'): begin
        if not PlayScene.EdChat.Visible then
          FrmDlg.OpenFriendDlg();
      end;

     word('M'): begin
        if not PlayScene.EdChat.Visible then
          FrmDlg.OpenMailDlg;
      end;

     word('R'): begin
        if not PlayScene.EdChat.Visible then
          if FrmDlg.DSkillbar.Visible then
            FrmDlg.DOptionsSkillBarOffClick(Nil,0,0)
          else
            FrmDlg.DOptionsSkillBarOnClick(Nil,0,0)
      end;
      
   end;

   case Key of
      VK_UP:
         with DScreen do begin
            if ChatBoardTop > 0 then Dec (ChatBoardTop);
         end;
      VK_DOWN:
         with DScreen do begin
            if ChatBoardTop < ChatStrs.Count-1 then
               Inc (ChatBoardTop);
         end;
      VK_PRIOR:
         with DScreen do begin
            if ChatBoardTop > VIEWCHATLINE then
               ChatBoardTop := ChatBoardTop - VIEWCHATLINE
            else ChatBoardTop := 0;
         end;
      VK_NEXT:
         with DScreen do begin
            if ChatBoardTop + VIEWCHATLINE < ChatStrs.Count-1 then
               ChatBoardTop := ChatBoardTop + VIEWCHATLINE
            else ChatBoardTop := ChatStrs.Count-1;
            if ChatBoardTop < 0 then ChatBoardTop := 0;
         end;
   end;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin

   if (DScreen.CurrentScene = SelectChrScene) then begin
     if (key = #13) and (FrmDlg.DCreateChr.Visible = false) then
       SelectChrScene.SelChrStartClick;
   end;

   if g_DWinMan.KeyPress (Key) then exit;

   if DScreen.CurrentScene = PlayScene then begin
      if PlayScene.EdChat.Visible then begin
         exit;
      end;
      case byte(key) of
         byte('1')..byte('6'):
            begin
               EatItem (byte(key) - byte('1'));
            end;
         byte('`'):
            if not PlayScene.EdChat.Visible then begin
             if not(g_boSkillSetting) then exit;
             if g_boSkillBarNum and (FrmDlg.DSkillBar.FaceIndex = 711) then
                FrmDlg.DSkillBar.SetImgIndex (g_WMainImages, 712)
             else
             FrmDlg.DSkillBar.SetImgIndex (g_WMainImages, 711);
            end;
         27: //ESC
            begin
            end;
         byte(' '), 13:
            begin
               PlayScene.EdChat.Visible := TRUE;
               PlayScene.EdChat.SetFocus;
               SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
               if FrmDlg.BoGuildChat then begin
                  PlayScene.EdChat.Text := '!~';
                  PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
                  PlayScene.EdChat.SelLength := 0;
               end else begin
                  PlayScene.EdChat.Text := '';
               end;
            end;
         byte('@'),
         byte('!'),
         byte('/'):
            begin
               PlayScene.EdChat.Visible := TRUE;
               PlayScene.EdChat.SetFocus;
               SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
               if key = '/' then begin
                  if WhisperName = '' then PlayScene.EdChat.Text := key
                  else if Length(WhisperName) > 2 then PlayScene.EdChat.Text := '/' + WhisperName + ' '
                  else PlayScene.EdChat.Text := key;
                  PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
                  PlayScene.EdChat.SelLength := 0;
               end else begin
                  PlayScene.EdChat.Text := key;
                  PlayScene.EdChat.SelStart := 1;
                  PlayScene.EdChat.SelLength := 0;
               end;
            end;
      end;
      key := #0;
   end;
end;

function  TfrmMain.GetMagicByKey (Key: char): PTClientMagic;
var
   i: integer;
   pm: PTClientMagic;
begin
   Result := nil;
   for i:=0 to g_MagicList.Count-1 do begin
      pm := PTClientMagic (g_MagicList[i]);
      if pm.Key = Key then begin
         Result := pm;
         break;
      end;
   end;
end;

procedure TfrmMain.UseMagic (tx, ty: integer; pcm: PTClientMagic);
var
   tdir, targx, targy, targid: integer;
   pmag: PTUseMagicInfo;
begin
   if pcm = nil then exit;
   if (pcm.Def.wSpell + pcm.Def.btDefSpell <= g_MySelf.m_Abil.MP) or (pcm.Def.btEffectType = 0) then begin
      if pcm.Def.btEffectType = 0 then begin
         //if CanNextAction and ServerAcceptNextAction then begin
         if pcm.Def.wMimicID = 26 then begin
            if GetTickCount - g_dwLatestFireHitTick < 10 * 1000 then begin
               exit;
            end;
         end;
         if pcm.Def.wMimicID = 27 then begin
            if GetTickCount - g_dwLatestRushRushTick < 3 * 1000 then begin
               exit;
            end;
         end;

         if pcm.Def.wMimicID = 38 then begin //tdb
           DrawEffectHum(8,g_Myself.m_nCurrX,g_Myself.m_nCurrY);
         end;
         if GetTickCount - g_dwLatestSpellTick > g_dwSpellTime{500} then begin
            g_dwLatestSpellTick := GetTickCount;
            g_dwMagicDelayTime := 0; //pcm.Def.DelayTime;
            SendSpellMsg (CM_SPELL, g_MySelf.m_btDir{x}, 0, pcm.Def.wMagicId, 0);
         end;
      end else begin
         tdir := GetFlyDirection (390, 175, tx, ty);
//         MagicTarget := FocusCret;
//魔法锁定
//ugly code but does the trick: this disables magic lock for these spells
         if (pcm.Def.wMimicID in [2,14,15,19,9,10,22,23,29,33,46,49,40,20,44,45,54])
            then begin
           g_MagicTarget:=g_FocusCret;
         end else begin
         if not g_boMagicLock or (PlayScene.IsValidActor (g_FocusCret) and (not g_FocusCret.m_boDeath)) then begin
           g_MagicLockActor:=g_FocusCret;
           end;
           g_MagicTarget:=g_MagicLockActor;
         end;

         if not PlayScene.IsValidActor (g_MagicTarget) then
            g_MagicTarget := nil;

         if g_MagicTarget = nil then begin
            PlayScene.CXYfromMouseXY (tx, ty, targx, targy);
            targid := 0;
         end else begin
            targx := g_MagicTarget.m_nCurrX;
            targy := g_MagicTarget.m_nCurrY;
            targid := g_MagicTarget.m_nRecogId;
         end;
         if CanNextAction and ServerAcceptNextAction then begin
            g_dwLatestSpellTick := GetTickCount;
            new (pmag);
            FillChar (pmag^, sizeof(TUseMagicInfo), #0);
            pmag.EffectNumber := pcm.Def.btEffect;
            pmag.MagicSerial := pcm.Def.wMagicID;
            pmag.MimicSerial := pcm.Def.wMimicID;
            pmag.ServerMagicCode := 0;
            g_dwMagicDelayTime := 200 + pcm.Def.dwDelayTime;

            case pmag.MimicSerial of
               2, 14, 15, 16, 17, 18, 19, 21,
               12, 25, 26, 28, 29, 30, 31..57: ;
               else g_dwLatestMagicTick := GetTickCount;
            end;

            g_dwMagicPKDelayTime := 0;
            if g_MagicTarget <> nil then
               if g_MagicTarget.m_btRace = 0 then
                  g_dwMagicPKDelayTime := 300 + Random(1100); //(600+200 + MagicDelayTime div 5);

            g_MySelf.SendMsg (CM_SPELL, targx, targy, tdir, Integer(pmag), targid, '', 0);
         end;
         if (g_MagicTarget <> nil) and (g_MagicTarget <> g_Myself) and (not g_MagicTarget.m_boDeath) then begin
          if (g_MagicTarget.m_btRace <> RCC_MERCHANT) and (g_MagicTarget.m_btRace <> 45) and (g_MagicTarget.m_btRace <> RCC_GUARD) and (g_MagicTarget.m_Abil.Level < 50) then begin
            if g_MagicTarget.m_Abil.HP > 5 then begin
              g_MagicTarget.m_noInstanceOpenHealth:=TRUE;
              g_MagicTarget.m_dwOpenHealthTime:=3*1000;
              g_MagicTarget.m_dwOpenHealthStart:=GetTickCount;
            end;
          end;
         end;
         // else
            //Dscreen.AddSysMsg ('泪矫饶俊 荤侩且 荐 乐嚼聪促.');
         //Inc (SpellCount);
      end;
   end else
      Dscreen.AddSysMsg ('没有足够的魔法值！');
      //Dscreen.AddSysMsg ('魔法值不够！！！' + IntToStr(pcm.Def.wSpell) + '+' + IntToStr(pcm.Def.btDefSpell) + '/' +IntToStr(g_MySelf.m_Abil.MP));
end;

procedure TfrmMain.UseMagicSpell (who, effnum, targetx, targety, magic_id: integer);
var
   actor: TActor;
   adir: integer;
   UseMagic: PTUseMagicInfo;
begin
   actor := PlayScene.FindActor (who);
   if actor <> nil then begin
      adir := GetFlyDirection (actor.m_nCurrX, actor.m_nCurrY, targetx, targety);
      new (UseMagic);
      FillChar (UseMagic^, sizeof(TUseMagicInfo), #0);
      UseMagic.EffectNumber := effnum; //magnum;
      UseMagic.ServerMagicCode := 0;
      UseMagic.MagicSerial := magic_id;
      actor.SendMsg (SM_SPELL, 0, 0, adir, Integer(UseMagic), 0, '', 0);
      Inc (g_nSpellCount);
   end else
      Inc (g_nSpellFailCount);
end;

procedure TfrmMain.UseMagicFire (who, efftype, effnum, targetx, targety, target: integer);
var
   actor: TActor;
   adir, sound: integer;
   pmag: PTUseMagicInfo;
begin
   sound:=0;
   actor := PlayScene.FindActor (who);
   if actor <> nil then begin

      actor.SendMsg (SM_MAGICFIRE, target{111magid}, efftype, effnum, targetx, targety, '', sound);
      //efftype = EffectType
      //effnum = Effect

      //if actor = Myself then Dec (SpellCount);
      if g_nFireCount < g_nSpellCount then
         Inc (g_nFireCount);
   end;
   g_MagicTarget := nil;
end;

procedure TfrmMain.UseMagicFireFail (who: integer);
var
   actor: TActor;
begin
   actor := PlayScene.FindActor (who);
   if actor <> nil then begin
      actor.SendMsg (SM_MAGICFIRE_FAIL, 0, 0, 0, 0, 0, '', 0);
   end;
   g_MagicTarget := nil;
end;

procedure TfrmMain.EatItem (idx: integer);
begin
   if idx in [0..MAXBAGITEMCL-1] then begin
      if (g_EatingItem.S.Name <> '') and (GetTickCount - g_dwEatTime > 5 * 1000) then begin
         g_EatingItem.S.Name := '';
      end;
      if (g_EatingItem.S.Name = '') and (g_ItemArr[idx].S.Name <> '') and (g_ItemArr[idx].S.StdMode <= 3) then begin
         g_EatingItem := g_ItemArr[idx];
         g_ItemArr[idx].S.Name := '';
         if (g_ItemArr[idx].S.StdMode = 4) and (g_ItemArr[idx].S.Shape < 100) then begin
            if g_ItemArr[idx].S.Shape < 50 then begin
               if mrYes <> FrmDlg.DMessageDlg ('你需要开始学习"' + g_ItemArr[idx].S.Name + '"吗？', [mbYes, mbNo]) then begin
                  g_ItemArr[idx] := g_EatingItem;
                  exit;
               end;
            end else begin
               if mrYes <> FrmDlg.DMessageDlg ('你会使用"' + g_ItemArr[idx].S.Name + '"吗？', [mbYes, mbNo]) then begin
                  g_ItemArr[idx] := g_EatingItem;
                  exit;
               end;
            end;
         end;
         g_dwEatTime := GetTickCount;
         SendEat (g_ItemArr[idx].MakeIndex, g_ItemArr[idx].S.Name );
         ItemUseSound (g_ItemArr[idx].S.StdMode);
         Fillquickslots(g_EatingItem.S.Name,idx);
      end;
   end else begin
      if (idx = -1) and g_boItemMoving then begin
         g_boItemMoving := FALSE;
         g_EatingItem := g_MovingItem.Item;
         g_MovingItem.Item.S.Name := '';
         if (g_EatingItem.S.StdMode = 4) and (g_EatingItem.S.Shape < 100) then begin
            if g_EatingItem.S.Shape < 50 then begin
               if mrYes <> FrmDlg.DMessageDlg ('你需要开始学习"' + g_EatingItem.S.Name + '"吗？', [mbYes, mbNo]) then begin
                  AddItemBag (g_EatingItem);
                  exit;
               end;
            end else begin
               if mrYes <> FrmDlg.DMessageDlg ('你会使用"' + g_EatingItem.S.Name + '"吗？', [mbYes, mbNo]) then begin
                  AddItemBag (g_EatingItem);
                  exit;
               end;
            end;
         end;
         g_dwEatTime := GetTickCount;
         SendEat (g_EatingItem.MakeIndex, g_EatingItem.S.Name );
         ItemUseSound (g_EatingItem.S.StdMode);
         if g_MovingItem.Index in [0..5] then
           Fillquickslots(g_EatingItem.S.Name,g_MovingItem.Index);
      end;
   end;
end;

function  TfrmMain.TargetInSwordLongAttackRange (ndir: integer): Boolean;
var
   nx, ny: integer;
   actor: TActor;
begin
   Result := FALSE;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nx, ny);
   GetFrontPosition (nx, ny, ndir, nx, ny);
   if (abs(g_MySelf.m_nCurrX - nx) = 2) or (abs(g_MySelf.m_nCurrY-ny) = 2) then begin
      actor := PlayScene.FindActorXY (nx, ny);
      if actor <> nil then
         if not actor.m_boDeath then
            Result := TRUE;
   end;
end;

function  TfrmMain.TargetInSwordWideAttackRange (ndir: integer): Boolean;
var
   nx, ny, rx, ry, mdir: integer;
   actor, ractor: TActor;
begin
   Result := FALSE;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nx, ny);
   actor := PlayScene.FindActorXY (nx, ny);

   mdir := (ndir + 1) mod 8;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
   ractor := PlayScene.FindActorXY (rx, ry);
   if ractor = nil then begin
      mdir := (ndir + 2) mod 8;
      GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;
   if ractor = nil then begin
      mdir := (ndir + 7) mod 8;
      GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;

   if (actor <> nil) and (ractor <> nil) then
      if not actor.m_boDeath and not ractor.m_boDeath then
         Result := TRUE;
end;
function  TfrmMain.TargetInSwordCrsAttackRange (ndir: integer): Boolean;
var
   nx, ny, rx, ry, mdir: integer;
   actor, ractor: TActor;
begin
   Result := FALSE;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, ndir, nx, ny);
   actor := PlayScene.FindActorXY (nx, ny);

   mdir := (ndir + 1) mod 8;
   GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
   ractor := PlayScene.FindActorXY (rx, ry);
   if ractor = nil then begin
      mdir := (ndir + 2) mod 8;
      GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;
   if ractor = nil then begin
      mdir := (ndir + 7) mod 8;
      GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, mdir, rx, ry);
      ractor := PlayScene.FindActorXY (rx, ry);
   end;

   if (actor <> nil) and (ractor <> nil) then
      if not actor.m_boDeath and not ractor.m_boDeath then
         Result := TRUE;
end;

{--------------------- Mouse Interface ----------------------}

procedure TfrmMain.DXDrawMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   i, mx, my, msx, msy, sel: integer;
   target: TActor;
   itemnames: string;
begin
   if g_DWinMan.MouseMove (Shift, X, Y) then exit;
   if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then exit;
   g_boSelectMyself := PlayScene.IsSelectMyself (X, Y);

   target := PlayScene.GetAttackFocusCharacter (X, Y, g_nDupSelection, sel, FALSE);
   if g_nDupSelection <> sel then g_nDupSelection := 0;
   if target <> nil then begin
      if (target.m_sUserName = '') and (GetTickCount - target.m_dwSendQueryUserNameTime > 10 * 1000) then begin
         target.m_dwSendQueryUserNameTime := GetTickCount;
         SendQueryUserName (target.m_nRecogId, target.m_nCurrX, target.m_nCurrY);
      end;
      g_FocusCret := target;
   end else
      g_FocusCret := nil;

   g_FocusItem := PlayScene.GetDropItems (X, Y, itemnames);
   if g_FocusItem <> nil then begin
      PlayScene.ScreenXYfromMCXY (g_FocusItem.X, g_FocusItem.Y, mx, my);
      DScreen.ShowHint (mx-20,
                        my-2{10},
                        itemnames, //PTDropItem(ilist[i]).Name,
                        clWhite,
                        TRUE);
   end else

   DScreen.ClearHint;

   PlayScene.CXYfromMouseXY (X, Y, g_nMouseCurrX, g_nMouseCurrY);
   g_nMouseX := X;
   g_nMouseY := Y;
   g_MouseItem.S.Name := '';
   g_MouseStateItem.S.Name := '';
   g_MouseUserStateItem.S.Name := '';
//   g_MouseShopItem.S.Name := '';
   if ((ssLeft in Shift) or (ssRight in Shift)) and (GetTickCount - mousedowntime > 300) then
      _DXDrawMouseDown(self, mbLeft, Shift, X, Y);

end;

procedure TfrmMain.DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   mousedowntime := GetTickCount;
   g_nRunReadyCount := 0;
   _DXDrawMouseDown (Sender, Button, Shift, X, Y);
end;

procedure TfrmMain.AttackTarget (target: TActor);
var
   tdir, dx, dy, nHitMsg: integer;
begin
   nHitMsg := CM_HIT;
   if g_UseItems[U_WEAPON].S.StdMode = 6 then nHitMsg := CM_HEAVYHIT;

   tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, target.m_nCurrX, target.m_nCurrY);
   if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 1) and (abs(g_MySelf.m_nCurrY-target.m_nCurrY) <= 1) and (not target.m_boDeath) then begin
      if CanNextAction and ServerAcceptNextAction and CanNextHit then begin

         if g_boNextTimeFireHit and (g_MySelf.m_Abil.MP >= 7) then begin
            g_boNextTimeFireHit := FALSE;
            nHitMsg := CM_FIREHIT;
         end else
         if g_boNextTimePowerHit then begin
            g_boNextTimePowerHit := FALSE;
            nHitMsg := CM_POWERHIT;
         end else
         if g_boCanTwnHit and (g_MySelf.m_Abil.MP >= 10) then begin
            g_boCanTwnHit := FALSE;
            nHitMsg := CM_TWINHIT;
         end else
         if g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3) then begin //and (TargetInSwordWideAttackRange (tdir)) then begin
            nHitMsg := CM_WIDEHIT;
         end else
         if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) then begin
            nHitMsg := CM_CRSHIT;
         end else
         if g_boCanLongHit and (TargetInSwordLongAttackRange (tdir)) then begin
            nHitMsg := CM_LONGHIT;
         end;

         //if ((target.m_btRace <> RCC_USERHUMAN) and (target.m_btRace <> RCC_GUARD)) or (ssShift in Shift) then
         g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
         g_dwLatestHitTick := GetTickCount;
         if (Target.m_btRace <> RCC_MERCHANT) and (Target.m_btRace <> 45) and (target.m_btRace <> RCC_GUARD) and (target.m_Abil.Level < 50) then begin
          if target.m_Abil.HP > 5 then begin
            target.m_noInstanceOpenHealth:= TRUE;
            target.m_dwOpenHealthTime:=3*1000;
            target.m_dwOpenHealthStart:=GetTickCount;
          end;
         end;
      end;
      g_dwLastAttackTick := GetTickCount;
   end else begin
      //if (UseItems[U_WEAPON].S.Shape = 6) and (target <> nil) then begin
      //   Myself.SendMsg (CM_THROW, Myself.XX, Myself.m_nCurrY, tdir, integer(target), 0, '', 0);
      //   TargetCret := nil;  //
      //end else begin
      if (abs(g_MySelf.m_nCurrX - target.m_nCurrX) <= 2) and (abs(g_MySelf.m_nCurrY-target.m_nCurrY) <= 2) and (not target.m_boDeath) then
         g_ChrAction := caWalk
      else g_ChrAction := caWalk;//跑步砍
      GetBackPosition (target.m_nCurrX, target.m_nCurrY, tdir, dx, dy);
      g_nTargetX := dx;
      g_nTargetY := dy;
      //end;
   end;
end;

procedure TfrmMain._DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   tdir, nx, ny, nHitMsg, sel: integer;
   target: TActor;
begin
   ActionKey := 0;
   g_nMouseX := X;
   g_nMouseY := Y;
   g_boAutoDig := FALSE;

   if (Button = mbRight) and g_boItemMoving then begin      //是否当前在移动物品
      FrmDlg.CancelItemMoving;
      exit;
   end;
   if g_DWinMan.MouseDown (Button, Shift, X, Y) then exit; //鼠标移到窗口上了则跳过
   if (g_MySelf = nil) or (DScreen.CurrentScene <> PlayScene) then exit;  //如果人物退出则跳过

   if ssRight in Shift then begin       //鼠标右键
      if Shift = [ssRight] then Inc (g_nDupSelection);
      target := PlayScene.GetAttackFocusCharacter (X, Y, g_nDupSelection, sel, FALSE); //取指定坐标上的角色
      if g_nDupSelection <> sel then g_nDupSelection := 0;
      if target <> nil then begin
         if ssCtrl in Shift then begin //CTRL + 鼠标右键 = 显示角色的信息
            if GetTickCount - g_dwLastMoveTick > 1000 then begin
               if (target.m_btRace = 0) and (not target.m_boDeath) then begin
                  //取得人物信息
                  SendClientMessage (CM_QUERYUSERSTATE, target.m_nRecogId, target.m_nCurrX, target.m_nCurrY, 0);
                  exit;
               end;
            end;
         end;
      end else
         g_nDupSelection := 0;
      //按鼠标右键，并且鼠标指向空位置
      PlayScene.CXYfromMouseXY (X, Y, g_nMouseCurrX, g_nMouseCurrY);

      if (abs(g_MySelf.m_nCurrX - g_nMouseCurrX) <= 2) and (abs(g_MySelf.m_nCurrY - g_nMouseCurrY) <= 2) then begin //目标座标
         tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
         if CanNextAction and ServerAcceptNextAction then begin
            g_MySelf.SendMsg (CM_TURN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
         end;
      end else begin
         g_ChrAction := caRun;
         g_nTargetX := g_nMouseCurrX;
         g_nTargetY := g_nMouseCurrY;
         exit;
      end;

{
      if CanNextAction and ServerAcceptNextAction then begin
        //人物座标与目标座标之间是否小于2，小于则走操作
        if (abs(Myself.XX-MCX) <= 2) and (abs(Myself.m_nCurrY-MCY) <= 2) then begin
           ChrAction := caWalk;
        end else begin //跑操作
           ChrAction := caRun;
        end;
           TargetX := MCX;
           TargetY := MCY;
           exit;
      end;
 }
   end;

   if ssLeft in Shift {Button = mbLeft} then begin
      target := PlayScene.GetAttackFocusCharacter (X, Y, g_nDupSelection, sel, TRUE);
      PlayScene.CXYfromMouseXY (X, Y, g_nMouseCurrX, g_nMouseCurrY);
      g_TargetCret := nil;

      if (g_UseItems[U_WEAPON].S.Name <> '') and (target = nil)
//骑马状态不可以操作
        and (g_MySelf.m_btHorse = 0) then begin
         //挖矿
         if g_UseItems[U_WEAPON].S.Shape = 19 then begin //鹤嘴锄
            tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
            GetFrontPosition (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, nx, ny);
            if not Map.CanMove(nx, ny) or (ssShift in Shift) then begin  //不能移动或强行挖矿
               if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
                  g_MySelf.SendMsg (CM_HIT+1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
               end;
               g_boAutoDig := TRUE;
               exit;
            end;
         end;
      end;

      if (ssAlt in Shift)
//骑马状态不可以操作
        and (g_MySelf.m_btHorse = 0) then begin
         //挖物品
         tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
         if CanNextAction and ServerAcceptNextAction then begin
            target := PlayScene.ButchAnimal (g_nMouseCurrX, g_nMouseCurrY);
            if target <> nil then begin
               SendButchAnimal (g_nMouseCurrX, g_nMouseCurrY, tdir, target.m_nRecogId);
               g_MySelf.SendMsg (CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
               exit;
            end;
            g_MySelf.SendMsg (CM_SITDOWN, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
         end;
         g_nTargetX := -1;
      end else begin
         if (target <> nil) or (ssShift in Shift) then begin
            g_nTargetX := -1;
            if target <> nil then begin
               if GetTickCount - g_dwLastMoveTick > 1500 then begin
                  if target.m_btRace = RCC_MERCHANT then begin
                     SendClientMessage (CM_CLICKNPC, target.m_nRecogId, 0, 0, 0);
                     exit;
                  end;
               end;

               if (not target.m_boDeath)
//骑马不允许操作
                 and (g_MySelf.m_btHorse = 0) then begin
                  g_TargetCret := target;
                  if ((target.m_btRace <> RCC_USERHUMAN) and
                      (target.m_btRace <> RCC_GUARD) and
                      (target.m_btRace <> RCC_MERCHANT) and
                      (pos('(', target.m_sUserName) = 0) //包括'('的角色名称为召唤的宝宝
                     )
                     or (ssShift in Shift) //SHIFT + 鼠标左键
                     or (target.m_nNameColor = ENEMYCOLOR)
                  then begin
                     AttackTarget (target);
                     g_dwLatestHitTick := GetTickCount;
                  end;
               end;
            end else begin
//骑马不允许操作
               if (g_MySelf.m_btHorse = 0) then begin
               tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
               if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
                  nHitMsg := CM_HIT+Random(3);
                  if g_boCanLongHit and (TargetInSwordLongAttackRange (tdir)) then begin  //是否可以使用刺杀
                     nHitMsg := CM_LONGHIT;
                  end;
                  if g_boCanWideHit and (g_MySelf.m_Abil.MP >= 3) and (TargetInSwordWideAttackRange (tdir)) then begin  //是否可以使用半月
                     nHitMsg := CM_WIDEHIT;
                  end;
                  if g_boCanCrsHit and (g_MySelf.m_Abil.MP >= 6) and (TargetInSwordCrsAttackRange (tdir)) then begin  //是否可以使用半月
                     nHitMsg := CM_CRSHIT;
                  end;
                  g_MySelf.SendMsg (nHitMsg, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, tdir, 0, 0, '', 0);
               end;
               g_dwLastAttackTick := GetTickCount;
               end;
            end;
         end else begin
//            if (MCX = Myself.XX) and (MCY = Myself.m_nCurrY) then begin
            if (g_nMouseCurrX = (g_MySelf.m_nCurrX)) and (g_nMouseCurrY = (g_MySelf.m_nCurrY)) then begin
               tdir := GetNextDirection (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_nMouseCurrX, g_nMouseCurrY);
               if CanNextAction and ServerAcceptNextAction then begin
                  SendPickup; //捡物品
               end;
            end else
               if GetTickCount - g_dwLastAttackTick > 1000 then begin //最后攻击操作停留指定时间才能移动
                  if ssCtrl in Shift then begin
                     g_ChrAction := caRun;
                  end else begin
                     g_ChrAction := caWalk;
                  end;
                  g_nTargetX := g_nMouseCurrX;
                  g_nTargetY := g_nMouseCurrY;
               end;
         end;
      end;
   end;
   if (Button = mbMiddle) then
     ToggleAutoRun;
end;

procedure TfrmMain.DXDrawDblClick(Sender: TObject);
var
   pt: TPoint;
begin
   GetCursorPos (pt);
   if g_DWinMan.DblClick (pt.X, pt.Y) then exit;
end;

function  TfrmMain.CheckDoorAction (dx, dy: integer): Boolean;
var
   nx, ny, ndir, door: integer;
begin
   Result := FALSE;
   //if not Map.CanMove (dx, dy) then begin
      //if (Abs(dx-Myself.XX) <= 2) and (Abs(dy-Myself.m_nCurrY) <= 2) then begin
         door := Map.GetDoor (dx, dy);
         if door > 0 then begin
            if not Map.IsDoorOpen (dx, dy) then begin
               SendClientMessage (CM_OPENDOOR, door, dx, dy, 0);
               Result := TRUE;
            end;    
         end;
      //end;
   //end;
end;

procedure TfrmMain.DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if g_DWinMan.MouseUp (Button, Shift, X, Y) then exit;
   g_nTargetX := -1;
end;

procedure TfrmMain.DXDrawClick(Sender: TObject);
var
   pt: TPoint;
begin
   GetCursorPos (pt);
   if g_DWinMan.Click (pt.X, pt.Y) then exit;
end;

procedure TfrmMain.MouseTimerTimer(Sender: TObject);
var
  I: Integer;
   pt: TPoint;
   keyvalue: TKeyBoardState;
   shift: TShiftState;

begin

   GetCursorPos (pt);
   SetCursorPos (pt.X, pt.Y);

   if g_TargetCret <> nil then begin
      if ActionKey > 0 then begin
         ProcessKeyMessages;
      end else begin
         if not g_TargetCret.m_boDeath and PlayScene.IsValidActor(g_TargetCret) then begin
            FillChar(keyvalue, sizeof(TKeyboardState), #0);
            if GetKeyboardState (keyvalue) then begin
               shift := [];
               if ((keyvalue[VK_SHIFT] and $80) <> 0) then shift := shift + [ssShift];
               if ((g_TargetCret.m_btRace <> RCC_USERHUMAN) and
                   (g_TargetCret.m_btRace <> RCC_GUARD) and
                   (g_TargetCret.m_btRace <> RCC_MERCHANT) and
                   (pos('(', g_TargetCret.m_sUserName) = 0)
                  )
                  or (g_TargetCret.m_nNameColor = ENEMYCOLOR)
                  or ((ssShift in Shift) and (not PlayScene.EdChat.Visible)) then begin
                  AttackTarget (g_TargetCret);
               end; //else begin
                  //TargetCret := nil;
               //end
            end;
         end else
            g_TargetCret := nil;
      end;
   end;
   if g_boAutoDig then begin
      if CanNextAction and ServerAcceptNextAction and CanNextHit then begin
         g_MySelf.SendMsg (CM_HIT+1, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, g_MySelf.m_btDir, 0, 0, '', 0);
      end;
   end;
   //动自捡取
   if g_boAutoPuckUpItem and
      (g_MySelf <> nil) and
      ((GetTickCount() - g_dwAutoPickupTick) > g_dwAutoPickupTime) then begin

     g_dwAutoPickupTick:=GetTickCount();
     AutoPickUpItem();
   end;
end;
procedure TfrmMain.AutoPickUpItem;
var
  I: Integer;
  ItemList:TList;
  DropItem:pTDropItem;
  ShowItem:pTShowItem;
begin
  if CanNextAction and ServerAcceptNextAction then begin
    if g_AutoPickupList = nil then exit;
      
    g_AutoPickupList.Clear;
    PlayScene.GetXYDropItemsList(g_MySelf.m_nCurrX,g_MySelf.m_nCurrY,g_AutoPickupList);
    for I := 0 to g_AutoPickupList.Count - 1 do begin
      DropItem:=g_AutoPickupList.Items[I];
      ShowItem:=GetShowItem(DropItem.Name);
      if (ShowItem <> nil) and (ShowItem.boAutoPickup) then
        SendPickup;        
    end;
  end;
end;

procedure TfrmMain.WaitMsgTimerTimer(Sender: TObject);
begin
   if g_MySelf = nil then exit;
   if g_MySelf.ActionFinished then begin
      WaitMsgTimer.Enabled := FALSE;
//      PlayScene.MemoLog.Lines.Add('WaitingMsg: ' + IntToStr(WaitingMsg.Ident));
      case WaitingMsg.Ident of
         SM_CHANGEMAP:
            begin
               g_boMapMovingWait := FALSE;
               g_boMapMoving := FALSE;
               //
               if g_nMDlgX <> -1 then begin
                  FrmDlg.CloseMDlg;
                  g_nMDlgX := -1;
               end;
               ClearDropItems;
               PlayScene.CleanObjects;
               g_sMapTitle := '';
               g_MySelf.CleanCharMapSetting (WaitingMsg.Param, WaitingMsg.Tag);
               PlayScene.SendMsg (SM_CHANGEMAP, 0,
                                    WaitingMsg.Param{x},
                                    WaitingMsg.tag{y},
                                    WaitingMsg.Series{darkness},
                                    0, 0,
                                    WaitingStr{mapname});

               //DScreen.AddSysMsg (IntToStr(WaitingMsg.Param) + ' ' +
               //                   IntToStr(WaitingMsg.Tag) + ' : My ' +
               //                   IntToStr(Myself.XX) + ' ' +
               //                   IntToStr(Myself.m_nCurrY) + ' ' +
               //                   IntToStr(Myself.RX) + ' ' +
               //                   IntToStr(Myself.RY) + ' '
               //                  );
               g_nTargetX := -1;
               g_TargetCret := nil;
               g_FocusCret := nil;

            end;
      end;
   end;
end;

{----------------------- Socket -----------------------}

procedure TfrmMain.SelChrWaitTimerTimer(Sender: TObject);
begin
   SelChrWaitTimer.Enabled := FALSE;
   SendQueryChr;
end;

procedure TfrmMain.ActiveCmdTimer (cmd: TTimerCommand);
begin
   CmdTimer.Enabled := TRUE;
   TimerCmd := cmd;
end;

procedure TfrmMain.CmdTimerTimer(Sender: TObject);
begin
   CmdTimer.Enabled := FALSE;
   CmdTimer.Interval := 2000;
   case TimerCmd of
      tcSoftClose:
         begin
            CmdTimer.Enabled := FALSE;
            CSocket.Socket.Close;
         end;
      tcReSelConnect:
         begin
            ResetGameVariables;
            DScreen.ChangeScene (stSelectChr);
            g_ConnectionStep := cnsReSelChr;

            if not BoOneClick then begin
              with CSocket do begin
                  Active := FALSE;
                  Address := g_sSelChrAddr;
                  Port := g_nSelChrPort;
                  Active := TRUE;
               end;

            end else begin
               if CSocket.Socket.Connected then
                  CSocket.Socket.SendText ('$S' + g_sSelChrAddr + '/' + IntToStr(g_nSelChrPort) + '%');
               CmdTimer.Interval := 1;
               ActiveCmdTimer (tcFastQueryChr);
            end;

         end;
      tcFastQueryChr:
         begin
            SendQueryChr;
         end;
   end;
end;

procedure TfrmMain.CloseAllWindows;
begin
   with FrmDlg do begin
      DItemBag.Visible := FALSE;
      DMsgDlg.Visible := FALSE;
      DStateWin.Visible := FALSE;
      DMerchantDlg.Visible := FALSE;
      DSellDlg.Visible := FALSE;
      DMenuDlg.Visible := FALSE;
      DGemMakeItem.Visible := FALSE;
      DKeySelDlg.Visible := FALSE;
      DGroupDlg.Visible := FALSE;
      DDealDlg.Visible := FALSE;
      DDealRemoteDlg.Visible := FALSE;
      DGuildDlg.Visible := FALSE;
      DGuildEditNotice.Visible := FALSE;
      DUserState1.Visible := FALSE;
      DAdjustAbility.Visible := FALSE;
      DFriendDlg.Visible := FALSE;
      DLoverWindow.Visible := FALSE;
      DMailListDlg.Visible := FALSE;
      DBlockListDlg.Visible := FALSE;
      DMailRead.Visible := FALSE;
      DMailDlg.Visible := FALSE;
      DMemo.Visible := FALSE;
      DSales.Visible := FALSE;
      DOptions.Visible := FALSE;
      DBottom.Visible := FALSE;
      DQuestAccept.Visible := FALSE;
      DShopMenuDlg.Visible := FALSE;
      DItemStore.Visible := FALSE;
      DItemShopDlg.Visible := FALSE;
      DRefineDlg.Visible := FALSE;
      DHelpWin.Visible := FALSE;
      DWemadeBuff.Visible := FALSE;
   end;
   if g_nMDlgX <> -1 then begin
      FrmDlg.CloseMDlg;
      g_nMDlgX := -1;
   end;
   g_boItemMoving := FALSE;
end;

procedure TfrmMain.ClearDropItems;
var
  I:Integer;
begin
  for I:=0 to g_DropedItemList.Count - 1 do begin
    Dispose (PTDropItem(g_DropedItemList[I]));
  end;
  g_DropedItemList.Clear;
end;

procedure TfrmMain.ResetGameVariables;
var
   i: integer;
   ClientMagic:pTClientMagic;
begin
try
   SilenceSound;
   CloseAllWindows;
   ClearDropItems;
   ClearShowItemList();
   for i:=0 to g_MagicList.Count - 1  do begin
    Dispose(pTClientMagic(g_MagicList[i]));
   end;
   g_MagicList.Clear;

   DScreen.ClearHint;
   while frmDlg.FriendList[F_GOOD].Count > 0 do dispose(frmDlg.FriendList[F_GOOD].Items[0]);
   while frmDlg.FriendList[F_BAD].Count > 0 do dispose(frmDlg.FriendList[F_BAD].Items[0]);
   frmDlg.FriendList[F_GOOD].Clear;
   frmDlg.FriendList[F_BAD].Clear;
   frmDlg.FriendIndex[F_GOOD] := -1;
   frmDlg.FriendIndex[F_BAD] := -1;

   while frmDlg.MailList.Count > 0 do dispose(frmDlg.MailList.Items[0]);
   while frmDlg.BlockList.Count > 0 do dispose(frmDlg.BlockList.Items[0]);   
   frmDlg.MailList.Clear;
   frmDlg.BlockList.Clear;

   frmDlg.MailIndex := -1;
   frmDlg.BlockIndex := -1;      

   g_boItemMoving := FALSE;
   g_WaitingUseItem.Item.S.Name := '';
   g_EatingItem.S.name := '';
   g_nTargetX := -1;
   g_TargetCret := nil;
   g_FocusCret := nil;
   g_MagicTarget := nil;
   ActionLock := FALSE;
   g_GroupMembers.Clear;
   g_sGuildRankName := '';
   g_sGuildName := '';

   g_boMapMoving := FALSE;
   WaitMsgTimer.Enabled := FALSE;
   g_boMapMovingWait := FALSE;
   DScreen.ChatBoardTop := 0;
   g_boNextTimePowerHit := FALSE;
   g_boCanLongHit := FALSE;
   g_boCanWideHit := FALSE;
   g_boCanCrsHit   := False;
   g_boCanTwnHit   := False;

   g_boNextTimeFireHit := FALSE;

   FillChar (g_UseItems, sizeof(TClientItem)*13, #0);
   FillChar (g_ItemArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
   FillChar (g_StoreItem, sizeof(TClientItem)*MAXSTORAGEITEMCL, #0);

   with SelectChrScene do begin
      FillChar (ChrArr, sizeof(TSelChar)*3, #0);
      ChrArr[0].FreezeState := TRUE;
      ChrArr[1].FreezeState := TRUE;
      ChrArr[2].FreezeState := TRUE;      
   end;
   PlayScene.ClearActors;
   ClearDropItems;
   EventMan.ClearEvents;
   PlayScene.CleanObjects;
   //DxDrawRestoreSurface (self);
   g_MySelf := nil;

except
//  on e: Exception do
//    PlayScene.MemoLog.Lines.Add(e.Message);
end;
end;

procedure TfrmMain.ChangeServerClearGameVariables;
var
   i: integer;
begin
   CloseAllWindows;
   ClearDropItems;
   for i:=0 to g_MagicList.Count-1 do
      Dispose (PTClientMagic (g_MagicList[i]));
   g_MagicList.Clear;
   g_boItemMoving := FALSE;
   g_WaitingUseItem.Item.S.Name := '';
   g_EatingItem.S.name := '';
   g_nTargetX := -1;
   g_TargetCret := nil;
   g_FocusCret := nil;
   g_MagicTarget := nil;
   ActionLock := FALSE;
   g_GroupMembers.Clear;
   g_sGuildRankName := '';
   g_sGuildName := '';

   g_boMapMoving := FALSE;
   WaitMsgTimer.Enabled := FALSE;
   g_boMapMovingWait := FALSE;
   g_boNextTimePowerHit := FALSE;
   g_boCanLongHit := FALSE;
   g_boCanWideHit := FALSE;
   g_boCanCrsHit   := False;
   g_boCanTwnHit   := False;

   ClearDropItems;
   EventMan.ClearEvents;
   PlayScene.CleanObjects;
end;

procedure TfrmMain.CSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
   packet: array[0..255] of char;
   strbuf: array[0..255] of char;
   str: string;
begin
   g_boServerConnected := TRUE;
   if g_ConnectionStep = cnsLogin then begin
      if OneClickMode = toKornetWorld then begin
         FillChar (packet, 256, #0);
         str := 'KwGwMGS';             StrPCopy (strbuf, str);  Move (strbuf, (@packet[0])^, Length(str));
         str := 'CONNECT';             StrPCopy (strbuf, str);  Move (strbuf, (@packet[8])^, Length(str));
         str := KornetWorld.CPIPcode;  StrPCopy (strbuf, str);  Move (strbuf, (@packet[16])^, Length(str));
         str := KornetWorld.SVCcode;   StrPCopy (strbuf, str);  Move (strbuf, (@packet[32])^, Length(str));
         str := KornetWorld.LoginID;   StrPCopy (strbuf, str);  Move (strbuf, (@packet[48])^, Length(str));
         str := KornetWorld.CheckSum;  StrPCopy (strbuf, str);  Move (strbuf, (@packet[64])^, Length(str));
         Socket.SendBuf (packet, 256);
      end;
      DScreen.ChangeScene (stLogin);
{$IF USECURSOR = DEFAULTCURSOR}
      DxDraw.Cursor:=crDefault;
{$IFEND}
   end;

   if g_ConnectionStep = cnsSelChr then begin
      LoginScene.OpenLoginDoor;
      SelChrWaitTimer.Enabled := TRUE;
   end;
   if g_ConnectionStep = cnsReSelChr then begin
      CmdTimer.Interval := 1;
      ActiveCmdTimer (tcFastQueryChr);
   end;
   if g_ConnectionStep = cnsPlay then begin
      if not g_boServerChanging then begin
         ClearBag;
         ClearStore;
         DScreen.ClearChatBoard;
         //DScreen.ChangeScene (stLoading);
         //DScreen.ChangeScene (stLoginNotice);
      end else begin
         ChangeServerClearGameVariables;
      end;
      SendRunLogin;
   end;
   SocStr := '';
   BufferStr := '';
end;

procedure TfrmMain.CSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
   g_boServerConnected := FALSE;
   if (g_ConnectionStep = cnsLogin) and not g_boSendLogin then begin
     FrmDlg.DMessageDlg ('连接关闭...', [mbOk]);
     Close;
   end;
   if g_SoftClosed then begin
//      PlayScene.MemoLog.Lines.Add('CSocketDisconnect - tcSoftClose');
      g_SoftClosed := FALSE;
      ActiveCmdTimer (tcReSelConnect);
   end;
end;

procedure TfrmMain.CSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
   ErrorCode := 0;
   Socket.Close;
end;

procedure TfrmMain.CSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
   n: integer;
   data, data2: string;
begin
   data := Socket.ReceiveText;
   //if pos('GOOD', data) > 0 then DScreen.AddSysMsg (data);

   n := pos('*', data);
   if n > 0 then begin
      data2 := Copy (data, 1, n-1);
      data := data2 + Copy (data, n+1, Length(data));
      //SendSocket ('*');
      CSocket.Socket.SendText ('*');
   end;
   SocStr := SocStr + data;
end;

{-------------------------------------------------------------}

procedure TfrmMain.SendSocket (sendstr: string);
const
   code: byte = 1;
var
   sSendText:String;
begin
   if CSocket.Socket.Connected then begin
      CSocket.Socket.SendText ('#' + IntToStr(code) + sendstr + '!');
     Inc (code);
     if code >= 10 then code := 1;
   end;
end;

procedure TfrmMain.SendLogin (uid, passwd: string);
begin
   LoginId := uid;
   LoginPasswd := passwd;
   SendClientMessage(CM_IDPASSWORD, 0, 0, 0, 0, uid + '/' + passwd);
   g_boSendLogin:=True;
end;

procedure TfrmMain.SendNewAccount (ue: TUserEntry; ua: TUserEntryAdd);
var
  msg: TDefaultMessage;
begin
   MakeNewId := ue.sAccount;
   msg := MakeDefaultMsg (CM_ADDNEWUSER, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeBuffer(@ue, sizeof(TUserEntry)) + EncodeBuffer(@ua, sizeof(TUserEntryAdd)));
end;

procedure TfrmMain.SendUpdateAccount (ue: TUserEntry; ua: TUserEntryAdd);
var
  msg: TDefaultMessage;
begin
   MakeNewId := ue.sAccount;
   msg := MakeDefaultMsg (CM_UPDATEUSER, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeBuffer(@ue, sizeof(TUserEntry)) + EncodeBuffer(@ua, sizeof(TUserEntryAdd)));
end;

procedure TfrmMain.SendSelectServer (svname: string);
begin
   SendClientMessage(CM_SELECTSERVER, 0, 0, 0, 0, svname);
end;

procedure TfrmMain.SendChgPw (id, passwd, newpasswd: string);
begin
   SendClientMessage(CM_CHANGEPASSWORD, 0, 0, 0, 0, id + #9 + passwd + #9 + newpasswd);
end;

procedure TfrmMain.SendNewChr (uid, uname, shair, sjob, ssex: string);
begin
   SendClientMessage(CM_NEWCHR, 0, 0, 0, 0, uid + '/' + uname + '/' + shair + '/' + sjob + '/' + ssex);
end;

procedure TfrmMain.SendQueryChr;
begin
   SendClientMessage(CM_QUERYCHR, 0, 0, 0, 0, LoginId + '/' + IntToStr(Certification));
end;

procedure TfrmMain.SendDelChr (chrname: string);
begin
   SendClientMessage(CM_DELCHR, 0, 0, 0, 0,chrname);
end;

procedure TfrmMain.SendSelChr (chrname: string);
begin
   CharName := chrname;
   SendClientMessage(CM_SELCHR, 0, 0, 0, 0, LoginId + '/' + chrname);
   PlayScene.EdAccountt.Visible:=False;
   PlayScene.EdChrNamet.Visible:=False;
end;

procedure TfrmMain.SendRunLogin;
var
   str: string;
   sSendMsg:String;
begin
   //强行登录
   {
   str := '**' +
          PlayScene.EdAccountt.Text + '/' +
          PlayScene.EdChrNamet.Text + '/' +
          IntToStr(Certification) + '/' +
          IntToStr(VERSION_NUMBER) + '/';
  }

(*   str := '**' +
          LoginId + '/' +
          CharName + '/' +
          IntToStr(Certification) + '/' +
          IntToStr(VERSION_NUMBER) + '/';

//          IntToStr(VERSION_NUMBER_0522) + '/';

   //if NewGameStart then begin
   //   str := str + '0';
   //   NewGameStart := FALSE;
   //end else str := str + '1';
   str := str + '9';*)
   sSendMsg:=format('**%s/%s/%d/%d/%d',[LoginId,CharName,Certification,CLIENT_VERSION_NUMBER,RUNLOGINCODE]);
   SendSocket (EncodeString (sSendMsg));

end;

procedure TfrmMain.SendSay (str: string);
var
   boEFFY:boolean;
begin
   if str <> '' then begin
     if m_boPasswordIntputStatus then begin
       m_boPasswordIntputStatus      := False;
       PlayScene.EdChat.PasswordChar := #0;
       PlayScene.EdChat.Visible      := False;
       SendPassword(str,1);
       exit;
     end;
     if CompareLstr(str,'/cmd',length('/cmd')) or CompareLstr(str,'@svninfo',length('@svninfo')) then begin
       ProcessCommand(str);
       exit;
     end;

      if str = '/debug check' then begin
        g_boShowMemoLog:=not g_boShowMemoLog;
        PlayScene.MemoLog.Clear;
        PlayScene.MemoLog.Visible:=g_boShowMemoLog;
        exit;
      end;
      if str = '/debug powerblock' then begin
        SendPowerBlock();
        exit;
      end;

      if str = '/debug screen' then begin
         g_boCheckBadMapMode := not g_boCheckBadMapMode;
         if g_boCheckBadMapMode then DScreen.AddSysMsg ('On')
         else DScreen.AddSysMsg ('Off');
         exit;
      end;
 {     if str = '/run' then begin
       if autoruntimer.Enabled then begin
       AutoRunTimer.Enabled:=False;
       end else begin
       AutoRunTimer.Enabled:=True;
       end;
      exit;
      end; }
      if str = '/check speedhack' then begin
         g_boCheckSpeedHackDisplay := not g_boCheckSpeedHackDisplay;
         exit;
      end;
      if str = '/hungry' then begin
         Inc(g_nMyHungryState);
         if g_nMyHungryState > 4 then g_nMyHungryState:=1;
         exit;
      end;
      if str = '/hint screen' then begin
         g_boShowGreenHint := not g_boShowGreenHint;
         g_boShowWhiteHint := not g_boShowWhiteHint;
         exit;
      end;

      {if str = 'tdb' then begin
      dscreen.AddSysMsg('tdb');
       frmmain.DrawEffectHum(8,g_Myself.m_nCurrX,g_Myself.m_nCurrY);
       exit;
      end;  }

      if str = '@password' then begin
         if PlayScene.EdChat.PasswordChar = #0 then
            PlayScene.EdChat.PasswordChar := '*'
         else PlayScene.EdChat.PasswordChar := #0;
         exit;   
      end;
      if PlayScene.EdChat.PasswordChar = '*' then
        PlayScene.EdChat.PasswordChar:= #0;

      SendClientMessage(CM_SAY, 0, 0, 0, 0, str);
      if str[1] = '/' then begin
         DScreen.AddChatBoardString (str, GetRGB(180), clWhite);
         GetValidStr3 (Copy(str,2,Length(str)-1), WhisperName, [' ']);
      end;
   end;
end;

procedure TfrmMain.SendActMsg (ident, x, y, dir: integer);
var
  msg: TDefaultMessage;
begin
   SendClientMessage(ident, MakeLong(x,y), 0, dir, 0);
   ActionLock := TRUE;
   ActionLockTime := GetTickCount;
   Inc (g_nSendCount);
end;

procedure TfrmMain.SendSpellMsg (ident, x, y, dir, target: integer);
begin
   SendClientMessage(ident, MakeLong(x,y), Loword(target), dir, Hiword(target));
   ActionLock := TRUE;
   ActionLockTime := GetTickCount;
   Inc (g_nSendCount);
end;

procedure TfrmMain.SendQueryUserName (targetid, x, y: integer);
begin
   SendClientMessage(CM_QUERYUSERNAME, targetid, x, y, 0);
end;

procedure TfrmMain.SendDropItem (name: string; itemserverindex: integer;Amount:Integer);
begin
  SendClientMessage(CM_DROPITEM, itemserverindex, Amount, 0, 0, name);
end;

procedure TfrmMain.SendPickup;
begin
   SendClientMessage(CM_PICKUP, 0, g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, 0);
end;

procedure TfrmMain.SendTakeOnItem (where: byte; itmindex: integer; itmname: string);
begin
   SendClientMessage(CM_TAKEONITEM, itmindex, where, 0, 0, itmname);
end;

procedure TfrmMain.SendTakeOffItem (where: byte; itmindex: integer; itmname: string);
begin
   SendClientMessage(CM_TAKEOFFITEM, itmindex, where, 0, 0, itmname);
end;

procedure TfrmMain.SendEat (itmindex: integer; itmname: string);
begin
   SendClientMessage(CM_EAT, itmindex, 0, 0, 0, itmname);
end;

procedure TfrmMain.SendButchAnimal (x, y, dir, actorid: integer);
begin
   SendClientMessage(CM_BUTCH, actorid, x, y, dir);
end;

procedure TfrmMain.SendMagicKeyChange (magid: integer; keych: char);
begin
   SendClientMessage(CM_MAGICKEYCHANGE, magid, byte(keych), 0, 0);
end;

procedure TfrmMain.SendMerchantDlgSelect (merchant: integer; rstr: string);
var
   param: string;
begin
   if Length(rstr) >= 2 then begin
      if (rstr[1] = '@') and (rstr[2] = '@') then begin
         if rstr = '@@buildguildnow' then
            FrmDlg.DMessageDlg ('请为你的新公会取个名字。', [mbOk, mbAbort])
         else FrmDlg.DMessageDlg ('Please input.', [mbOk, mbAbort]);
         param := Trim (FrmDlg.DlgEditText);
         rstr := rstr + #13 + param;
      end;
   end;
   SendClientMessage(CM_MERCHANTDLGSELECT, merchant, 0, 0, 0, rstr);
end;

procedure TfrmMain.SendQueryPrice (merchant, itemindex: integer; itemname: string; Amount:Integer);
begin
   SendClientMessage(CM_MERCHANTQUERYSELLPRICE, merchant, Loword(itemindex), Hiword(itemindex), Amount, itemname);
end;

procedure TfrmMain.SendQueryRepairCost (merchant, itemindex: integer; itemname: string);
begin
   SendClientMessage(CM_MERCHANTQUERYREPAIRCOST, merchant, Loword(itemindex), Hiword(itemindex), 0, itemname);
end;

procedure TfrmMain.SendSellItem (merchant, itemindex: integer; itemname: string; Amount: Integer);
begin
  SendClientMessage(CM_USERSELLITEM, merchant, Loword(itemindex), Hiword(itemindex), Amount, itemname);
end;

procedure TfrmMain.SendRepairItem (merchant, itemindex: integer; itemname: string);
begin
   SendClientMessage(CM_USERREPAIRITEM, merchant, Loword(itemindex), Hiword(itemindex), 0, itemname);
end;

procedure TfrmMain.SendStorageItem (merchant, itemindex: integer; itemname: string; Amount:Integer);
begin
   SendClientMessage(CM_USERSTORAGEITEM, merchant, Loword(itemindex), Hiword(itemindex), Amount, itemname);
end;

procedure TfrmMain.SendConsignItem (merchant, itemindex: integer; cost: string);
begin
   SendClientMessage(CM_CONSIGNITEM, merchant, Loword(itemindex), Hiword(itemindex), 0, cost);
end;

procedure TfrmMain.SendGetDetailItem (merchant, menuindex: integer; itemname: string);
begin
   SendClientMessage(CM_USERGETDETAILITEM, merchant, menuindex, 0, 0, itemname);
end;

procedure TfrmMain.SendBuyItem (merchant, itemserverindex: integer; itemname: string);
begin
   SendClientMessage(CM_USERBUYITEM, merchant, Loword(itemserverindex), Hiword(itemserverindex), 0, itemname);
end;

procedure TfrmMain.SendTakeBackStorageItem (merchant, itemserverindex: integer; itemname: string);
begin
  SendClientMessage(CM_USERTAKEBACKSTORAGEITEM, merchant, Loword(itemserverindex), Hiword(itemserverindex), 0, itemname);
end;

procedure TfrmMain.SendMakeDrugItem (merchant: integer; itemname: string);
begin
   SendClientMessage(CM_USERMAKEDRUGITEM, merchant, 0, 0, 0, itemname);
end;

procedure TfrmMain.SendDropGold (dropgold: integer);
begin
  SendClientMessage(CM_DROPGOLD, dropgold, 0, 0, 0);
end;

procedure TfrmMain.SendGroupMode (onoff: Boolean);
begin
   if onoff then SendClientMessage(CM_GROUPMODE, 0, 1, 0, 0)   //on
   else SendClientMessage(CM_GROUPMODE, 0, 0, 0, 0);  //off
end;

procedure TfrmMain.SendCreateGroup (withwho: string);
begin
   if withwho <> '' then begin
      SendClientMessage(CM_CREATEGROUP, 0, 0, 0, 0, withwho);
   end;
end;

procedure TfrmMain.SendOpenGameShop;
begin
  SendClientMessage(CM_OPENGAMESHOP, 0, 0, 0, 0);
end;


procedure TfrmMain.SendDealTry;
var
   i, fx, fy: integer;
   actor: TActor;
   who: string;
   proper: Boolean;
begin
   (*proper := FALSE;
   GetFrontPosition (Myself.XX, Myself.m_nCurrY, Myself.Dir, fx, fy);
   with PlayScene do
      for i:=0 to ActorList.Count-1 do begin
         actor := TActor (ActorList[i]);
         if {(actor.m_btRace = 0) and} (actor.XX = fx) and (actor.m_nCurrY = fy) then begin
            proper := TRUE;
            who := actor.UserName;
            break;
         end;
      end;
   if proper then begin*)
      SendClientMessage(CM_DEALTRY, 0, 0, 0, 0, who);
   //end;
end;

procedure TfrmMain.SendGuildDlg;
begin
   SendClientMessage(CM_OPENGUILDDLG, 0, 0, 0, 0);
end;

procedure TfrmMain.SendCancelDeal;
begin
   SendClientMessage(CM_DEALCANCEL, 0, 0, 0, 0);
end;

procedure TfrmMain.SendAddDealItem (ci: TClientItem);
begin
   SendClientMessage(CM_DEALADDITEM, ci.MakeIndex, ci.Amount, 0, 0, ci.S.Name);
end;

procedure TfrmMain.SendDelDealItem (ci: TClientItem);
begin
   SendClientMessage(CM_DEALDELITEM, ci.MakeIndex, 0, 0, 0, ci.S.Name);
end;

procedure TfrmMain.SendAddRefineItem (ci: TClientItem);
begin
   SendClientMessage(CM_REFINEADDITEM, ci.MakeIndex, ci.Amount, 0, 0, ci.S.Name);
end;

procedure TfrmMain.SendDelRefineItem (ci: TClientItem);
begin
   SendClientMessage(CM_REFINEDELITEM, ci.MakeIndex, 0, 0, 0, ci.S.Name);
end;

procedure TfrmMain.SendCanceRefine;
begin
   SendClientMessage(CM_REFINECANCEL, 0, 0, 0, 0);
end;

procedure TfrmMain.SendChangeDealGold (gold: integer);
begin
   SendClientMessage(CM_DEALCHGGOLD, gold, 0, 0, 0);
end;

procedure TfrmMain.SendDealEnd;
begin
   SendClientMessage(CM_DEALEND, 0, 0, 0, 0);
end;

procedure TfrmMain.SendAddGroupMember (withwho: string);
begin
   if withwho <> '' then begin
      SendClientMessage(CM_ADDGROUPMEMBER, 0, 0, 0, 0, withwho);
   end;
end;

procedure TfrmMain.SendDelGroupMember (withwho: string);
begin
   if withwho <> '' then begin
      SendClientMessage(CM_DELGROUPMEMBER, 0, 0, 0, 0, withwho);
   end;
end;

procedure TfrmMain.SendGuildHome;
begin
   SendClientMessage(CM_GUILDHOME, 0, 0, 0, 0);
end;

procedure TfrmMain.SendGuildMemberList;
begin
   SendClientMessage(CM_GUILDMEMBERLIST, 0, 0, 0, 0);
end;

procedure TfrmMain.SendGuildAddMem (who: string);
begin
   if Trim(who) <> '' then begin
      SendClientMessage(CM_GUILDADDMEMBER, 0, 0, 0, 0, who);
   end;
end;

procedure TfrmMain.SendGuildDelMem (who: string);
begin
   if Trim(who) <> '' then begin
      SendClientMessage(CM_GUILDDELMEMBER, 0, 0, 0, 0, who);
   end;
end;

procedure TfrmMain.SendGuildUpdateNotice (notices: string);
begin
   SendClientMessage(CM_GUILDUPDATENOTICE, 0, 0, 0, 0, notices);
end;

procedure TfrmMain.SendGuildUpdateGrade (rankinfo: string);
begin
   SendClientMessage(CM_GUILDUPDATERANKINFO, 0, 0, 0, 0, rankinfo);
end;

procedure TfrmMain.SendSpeedHackUser;
begin
   SendClientMessage(CM_SPEEDHACKUSER, 0, 0, 0, 0);
end;

procedure TfrmMain.SendAdjustBonus (remain: integer; babil: TNakedAbility);
var
  msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_ADJUST_BONUS, remain, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeBuffer (@babil, sizeof(TNakedAbility)));
end;

procedure TfrmMain.SendPowerBlock();
var
  msg: TDefaultMessage;
begin
   msg := MakeDefaultMsg (CM_POWERBLOCK, 0, 0, 0, 0);
   SendSocket (EncodeMessage (msg) + EncodeBuffer (@g_PowerBlock, sizeof(TPowerBlock)));
end;

procedure TfrmMain.SendGTListRequest(merchant, menuindex: integer);
begin
   SendClientMessage(CM_REQUESTGTLIST , merchant, menuindex, 0, 0, '');
end;

procedure TfrmMain.SendBuyGT(merchant, GTNumber: integer);
begin
   SendClientMessage(CM_BUYGT , merchant, GTNumber, 0, 0, '');
end;

procedure TfrmMain.SendDecoListRequest(merchant, menuindex: integer);
begin
   SendClientMessage(CM_REQUESTDECOLIST , merchant, menuindex, 0, 0, '');
end;

procedure TfrmMain.SendBuyDeco(merchant, Appr: integer);
begin
   SendClientMessage(CM_BUYDECOITEM , merchant, Appr, 0, 0, '');
end;

procedure TfrmMain.SendTradeGT(Answer:integer);
begin
  SendClientMessage(CM_TRADEGT , Answer, 0, 0, 0, '');
end;

procedure TfrmMain.SendBBSListRequest(merchant: integer; menuindex: integer);
begin
   SendClientMessage(CM_BBSLIST , merchant, menuindex, 0, 0, '');
end;

procedure TfrmMain.SendBBSMsgRequest(merchant: integer; index:integer);
begin
   SendClientMessage(CM_BBSMSG , merchant, index, 0, 0, '');
end;

procedure TfrmMain.SendBBSPost(merchant,Sticky,MasterPost: integer; sMsg:String);
begin
   SendClientMessage(CM_BBSPOST , merchant, Sticky, LoWord(MasterPost), HiWord(MasterPost), sMsg);
end;

procedure TfrmMain.SendBBSDelete(merchant,index:integer);
begin
   SendClientMessage(CM_BBSDELETE , merchant, index, 0, 0, '');
end;

procedure TfrmMain.SendChgStorePw (storepasswd, newstorepasswd: string);
begin
//   SendClientMessage(CM_CHANGEPASSWORD, 0, 0, 0, 0, storepasswd + #9 + newstorepasswd);
end;
{---------------------------------------------------------------}


function  TfrmMain.ServerAcceptNextAction: Boolean;
begin
   Result := TRUE;
   if ActionLock then begin
      if GetTickCount - ActionLockTime > 10 * 1000 then begin
         ActionLock := FALSE;
         //Dec (WarningLevel);
      end;
      Result := FALSE;
   end;
end;

function  TfrmMain.CanNextAction: Boolean;
begin
   if (g_MySelf.IsIdle) and
      (g_MySelf.m_nState and $04000000 = 0) and
      (GetTickCount - g_dwDizzyDelayStart > g_dwDizzyDelayTime)
   then begin
      Result := TRUE;
   end else
      Result := FALSE;
end;
//是否可以攻击，控制攻击速度
function  TfrmMain.CanNextHit: Boolean;
var
   NextHitTime, LevelFastTime:Integer;
begin
   LevelFastTime:= _MIN (370, (g_MySelf.m_Abil.Level * 14));
   LevelFastTime:= _MIN (800, LevelFastTime + g_MySelf.m_nHitSpeed * g_nItemSpeed{60});

   if (g_boAttackSlow) or (g_boFrozen) then
      NextHitTime:= g_nHitTime{1400} - LevelFastTime + 1500 //腕力超过时，减慢攻击速度
   else NextHitTime:= g_nHitTime{1400} - LevelFastTime;

   if NextHitTime < 0 then NextHitTime:= 0;

   if GetTickCount - LastHitTick > LongWord(NextHitTime) then begin
      LastHitTick:=GetTickCount;
      Result:=True;
   end else Result:=False;
end;

procedure TfrmMain.ActionFailed;
begin
   g_nTargetX := -1;
   g_nTargetY := -1;
   ActionFailLock := TRUE;
   ActionFailLockTime :=GetTickCount();
   g_MySelf.MoveFail;
end;

function  TfrmMain.IsUnLockAction (action, adir: integer): Boolean;
begin
   if ActionFailLock then begin //如果操作被锁定，则在指定时间后解锁
     if GetTickCount() - ActionFailLockTime > 1000 then ActionFailLock:=False;
   end;
   if (ActionFailLock) or (g_boMapMoving) or (g_boServerChanging) then begin
      Result := FALSE;
   end else Result := TRUE;

{
   if (ActionFailLock and (action = FailAction) and (adir = FailDir))
      or (MapMoving)
      or (BoServerChanging) then begin
      Result := FALSE;
   end else begin
      ActionFailLock := FALSE;
      Result := TRUE;
   end;
}
end;

function TfrmMain.IsGroupMember (uname: string): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to g_GroupMembers.Count-1 do
      if g_GroupMembers[i] = uname then begin
         Result := TRUE;
         break;
      end;
end;

{-------------------------------------------------------------}

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
   str, data: string;
   len, i, n, mcnt : integer;
const
   busy: Boolean = FALSE;
begin
   if busy then exit;
   //if ServerConnected then
   //   DxTimer.Enabled := TRUE
   //else
   //   DxTimer.Enabled := FALSE;

   busy := TRUE;
   try
      BufferStr := BufferStr + SocStr;
      SocStr := '';
      if BufferStr <> '' then begin
         mcnt := 0;
         while Length(BufferStr) >= 2 do begin
            if g_boMapMovingWait then break;
            if Pos('!', BufferStr) <= 0 then break;
            BufferStr := ArrestStringEx (BufferStr, '#', '!', data);
            if data = '' then break;
            DecodeMessagePacket (data);
            if Pos('!', BufferStr) <= 0 then break;
         end;
      end;
   finally
      busy := FALSE;
   end;

   if WarningLevel > 30 then
      FrmMain.Close;

   if g_boQueryPrice then begin
      if GetTickCount - g_dwQueryPriceTime > 500 then begin
         g_boQueryPrice := FALSE;
         case FrmDlg.SpotDlgMode of
            dmSell: SendQueryPrice (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name, g_SellDlgItem.Amount);
            dmRepair: SendQueryRepairCost (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
         end;
      end;
   end;

   if g_nBonusPoint > 0 then begin
      FrmDlg.DBotPlusAbil.Visible := TRUE;
   end else begin

      FrmDlg.DBotPlusAbil.Visible := FALSE;
   end;

end;

procedure TfrmMain.SpeedHackTimerTimer(Sender: TObject);
var
   gcount, timer: longword;
   ahour, amin, asec, amsec: word;
begin
   DecodeTime (Time, ahour, amin, asec, amsec);
   timer := ahour * 1000 * 60 * 60 + amin * 1000 * 60 + asec * 1000 + amsec;
   gcount := GetTickCount;
   if g_dwSHGetTime > 0 then begin
      if abs((gcount - g_dwSHGetTime) - (timer - g_dwSHTimerTime)) > 70 then begin
         Inc (g_nSHFakeCount);
      end else
         g_nSHFakeCount := 0;
      if g_nSHFakeCount > 4 then begin
         FrmDlg.DMessageDlg ('网络出现不稳定情况，游戏已被中止。代码=10001\' +
                             '如有问题请联系游戏管理员。',
                             [mbOk]);
         FrmMain.Close;
      end;
      if g_boCheckSpeedHackDisplay then begin
         DScreen.AddSysMsg ('->' + IntToStr(gcount - g_dwSHGetTime) + ' - ' +
                                   IntToStr(timer - g_dwSHTimerTime) + ' = ' +
                                   IntToStr(abs((gcount - g_dwSHGetTime) - (timer - g_dwSHTimerTime))) + ' (' +
                                   IntToStr(g_nSHFakeCount) + ')');
      end;
   end;
   g_dwSHGetTime := gcount;
   g_dwSHTimerTime := timer;
end;

procedure TfrmMain.CheckSpeedHack (rtime: Longword);
var
   cltime, svtime: integer;
   str: string;
begin
   if g_dwFirstServerTime > 0 then begin
      if (GetTickCount - g_dwFirstClientTime) > 1 * 60 * 60 * 1000 then begin
         g_dwFirstServerTime := rtime;
         g_dwFirstClientTime := GetTickCount;
         //ServerTimeGap := rtime - int64(GetTickCount);
      end;
      cltime := GetTickCount - g_dwFirstClientTime;
      svtime := rtime - g_dwFirstServerTime + 3000;

      if cltime > svtime then begin
         Inc (g_nTimeFakeDetectCount);
         if g_nTimeFakeDetectCount > 6 then begin
            str := 'Bad';
            //SendSpeedHackUser;
            FrmDlg.DMessageDlg ('网络出现不稳定情况，游戏已被中止。代码=10000\' +
                                '如有问题请联系游戏管理员。',
                                [mbOk]);
            FrmMain.Close;
         end;
      end else begin
         str := 'Good';
         g_nTimeFakeDetectCount := 0;
      end;
      if g_boCheckSpeedHackDisplay then begin
         DScreen.AddSysMsg (IntToStr(svtime) + ' - ' +
                            IntToStr(cltime) + ' = ' +
                            IntToStr(svtime-cltime) +
                            ' ' + str);
      end;
   end else begin
      g_dwFirstServerTime := rtime;
      g_dwFirstClientTime := GetTickCount;
      //ServerTimeGap := int64(GetTickCount) - longword(msg.Recog);
   end;
end;

procedure TfrmMain.DecodeMessagePacket (datablock: string);
var
   head, body, body2, tagstr, data, rdstr, str, errorstr: String;
   msg : TDefaultMessage;
   smsg: TShortMessage;
   mbw: TMessageBodyW;
   desc: TCharDesc;
   wl: TMessageBodyWL;
   featureEx: word;
   L, i, j, n, BLKSize, param, sound, cltime, svtime: integer;
   tempb: boolean;
   actor: TActor;
   event: TClEvent;
   boEFFY:boolean;
   Lover:TLover;
begin
   if datablock[1] = '+' then begin  //checkcode
      data := Copy (datablock, 2, Length(datablock)-1);
      data := GetValidStr3 (data, tagstr, ['/']);
      if tagstr = 'PWR'  then g_boNextTimePowerHit := True;  //打开攻杀
      if tagstr = 'LNG'  then g_boCanLongHit := True;        //打开刺杀
      if tagstr = 'ULNG' then g_boCanLongHit := False;       //关闭刺杀
      if tagstr = 'WID'  then g_boCanWideHit := True;        //打开半月
      if tagstr = 'UWID' then g_boCanWideHit := False;       //关闭半月
      if tagstr = 'CRS'  then g_boCanCrsHit := True;         //打开狂风斩
      if tagstr = 'UCRS' then g_boCanCrsHit := False;        //关闭狂风斩
      if tagstr = 'TWN'  then g_boCanTwnHit := True;         //打开双龙斩
      if tagstr = 'UTWN' then g_boCanTwnHit := False;        //关闭双龙斩
      if tagstr = 'STN'  then g_boCanStnHit := True;
      if tagstr = 'USTN' then g_boCanStnHit := False;
      if tagstr = 'AKC'  then g_boCanAkcHit := True;
      if tagstr = 'UAKC' then g_boCanAkcHit := False;
      if tagstr = 'FIR'  then begin
         g_boNextTimeFireHit := TRUE;
         //PlaySound (s_firehit_ready);//播放烈火装备声音
         g_dwLatestFireHitTick := GetTickCount;
         g_MySelf.SendMsg (SM_READYFIREHIT, g_Myself.m_nCurrX, g_Myself.m_nCurrY, g_Myself.m_btDir, 0, 0, '', 0);
      end;
      if tagstr = 'UFIR' then g_boNextTimeFireHit := False; 
      if tagstr = 'GOOD' then begin
         ActionLock := FALSE;
         Inc(g_nReceiveCount);
      end;
      if tagstr = 'FAIL' then begin
         ActionFailed;
         ActionLock := FALSE;
         Inc(g_nReceiveCount);
      end;
      //DScreen.AddSysmsg (data);
      if data <> '' then begin
         CheckSpeedHack (Str_ToInt(data, 0));
      end;
      exit;
   end;
   if Length(datablock) < DEFBLOCKSIZE then begin
      if datablock[1] = '=' then begin
         data := Copy (datablock, 2, Length(datablock)-1);
         if data = 'DIG' then begin
            g_MySelf.m_boDigFragment := TRUE;
         end;
      end;
      exit;
   end;

   head := Copy (datablock, 1, DEFBLOCKSIZE);
   body := Copy (datablock, DEFBLOCKSIZE+1, Length(datablock)-DEFBLOCKSIZE);
   msg  := DecodeMessage (head);

   //DScreen.AddSysMsg (IntToStr(msg.Ident));

   if (msg.Ident <> SM_HEALTHSPELLCHANGED) and
      (msg.Ident <> SM_HEALTHSPELLCHANGED)
      then begin

     if g_boShowMemoLog then begin
       ShowHumanMsg(@Msg);
       //PlayScene.MemoLog.Lines.Add('Ident: ' + IntToStr(msg.Recog) + '/' + IntToStr(msg.Ident));
     end;
   end;
//   PlayScene.MemoLog.Lines.Add('datablock: ' + datablock);
   if g_MySelf = nil then begin
      case msg.Ident of
         SM_NEWID_SUCCESS:
            begin
               FrmDlg.DMessageDlg ('您的帐号创建成功。\' +
                                   '请妥善保管您的帐号和密码，\并且不要因任何原因把帐号和密码告诉任何其他人。\' +
                                   '如果忘记了密码,\你可以通过我们的主页重新找回。\' +
                                   '(http://www.lom2.net)', [mbOk]);
            end;
         SM_NEWID_FAIL:
            begin
               case msg.Recog of
                  0: begin
                        FrmDlg.DMessageDlg ('帐号 "' + MakeNewId + '" 已被其他的玩家使用了。\',
                                            [mbOk]);
                        LoginScene.NewIdRetry (FALSE);  
                     end;
                  -2: FrmDlg.DMessageDlg ('此帐号名被禁止使用！', [mbOk]);
                  else FrmDlg.DMessageDlg ('帐号创建失败，请确认帐号是否包括空格、及非法字符！代码: ' + IntToStr(msg.Recog), [mbOk]);
               end;
            end;
         SM_PASSWD_FAIL:
            begin
               case msg.Recog of
                  -1: errorstr := '密码错误。';
                  -2: errorstr := '密码输入错误超过3次，此帐号被暂时锁定，请稍候再登录！';
                  -3: errorstr := '此帐号已经登录或被异常锁定，请稍候再登录！';
                  -4: errorstr := '这个帐号访问失败！\请使用其他帐号登录，\或者申请付费注册。';
                  -5: errorstr := '这个帐号被锁定！';
                  else errorstr := '此帐号不存在或出现未知错误！';
               end;

               if (not g_boAutoLogin) then begin
                 FrmDlg.DMessageDlg (errorstr, [mbOk]);
               end
               else begin
                 g_boAutoLogin := False;
                 FrmDlg.DMessageDlg ('自动登陆失败\ \原因:\'+errorstr, [mbOk]);
               end;
               LoginScene.PassWdFail;
            end;
         SM_NEEDUPDATE_ACCOUNT:
            begin
               ClientGetNeedUpdateAccount (body);
            end;
         SM_UPDATEID_SUCCESS:
            begin
               FrmDlg.DMessageDlg ('你的帐户现在被更新。\' +
                                   '请在一个安全的地方中保存你的帐户和密码\' +
                                   '而且不要把账号密码随便告诉任何人。\' +
                                   '如果你忘记你的密码，你能经过我们的主页找回密码。\(http://www.lom2.net)', [mbOk]);
               ClientGetSelectServer;
            end;
         SM_UPDATEID_FAIL:
            begin
               FrmDlg.DMessageDlg ('更新帐户失败。', [mbOk]);
               ClientGetSelectServer;
            end;
         SM_PASSOK_SELECTSERVER: begin
           ClientGetPasswordOK(msg,body);
         end;
         SM_SELECTSERVER_OK: begin
           ClientGetPasswdSuccess (body);
         end;
         SM_QUERYCHR: begin
           ClientGetReceiveChrs (body);
         end;
         SM_QUERYCHR_FAIL: begin
           g_boDoFastFadeOut := FALSE;
           g_boDoFadeIn := FALSE;
           g_boDoFadeOut := FALSE;
           FrmDlg.DMessageDlg ('错误信息！服务器认证失败。', [mbOk]);
           Close;
         end;
         SM_NEWCHR_SUCCESS: begin
           SendQueryChr;
         end;
         SM_NEWCHR_FAIL: begin
           case msg.Recog of
             0: FrmDlg.DMessageDlg ('[错误信息] 这个角色名字包含非法字符或长期正确，至少4个字符。', [mbOk]);
             2: FrmDlg.DMessageDlg ('[错误信息] 这个角色名字已被其他人使用！', [mbOk]);
             3: FrmDlg.DMessageDlg ('[错误信息] 您只能创建三个游戏角色！如果创建请删除你当前的一个角色。', [mbOk]);
             4: FrmDlg.DMessageDlg ('[错误信息] 角色创建失败，请保证你有最新的客户端，\如果正确请与游戏管理员联系。', [mbOk]);
            else FrmDlg.DMessageDlg ('[错误信息] 未知错误，请联系管理员 Email: support@lom2.net', [mbOk]);
           end;
         end;
         SM_CHGPASSWD_SUCCESS: begin
           FrmDlg.DMessageDlg ('密码修改成功。', [mbOk]);
         end;
         SM_CHGPASSWD_FAIL: begin
           case msg.Recog of
             -1: FrmDlg.DMessageDlg ('错误密码，不能修改密码。', [mbOk]);
             -2: FrmDlg.DMessageDlg ('此帐号被锁定，请过一段时间再试一次。', [mbOk]);
             else FrmDlg.DMessageDlg ('输入的新密码长度小于四位。', [mbOk]);
           end;
         end;
         SM_DELCHR_SUCCESS: begin
           SendQueryChr;
         end;
         SM_DELCHR_FAIL: begin
           FrmDlg.DMessageDlg ('[失败] 删除角色失败，Email: support@lom2.net', [mbOk]);
         end;
         SM_STARTPLAY: begin
           ClientGetStartPlay (body);
           exit;
         end;
         SM_STARTFAIL: begin
           FrmDlg.DMessageDlg ('此服务器满员！', [mbOk]);
               FrmMain.Close;
//               frmSelMain.Close;
           ClientGetSelectServer();
           exit;
         end;
         SM_FRIENDLIST: begin
           ClientFriendList(DecodeString(Body));
           exit;
         end;
         SM_VERSION_FAIL: begin
//           FrmDlg.DMessageDlg ('版本错误，请下载最新版本。(http://www.lom2.net)', [mbOk]);
//               FrmMain.Close;
//               frmSelMain.Close;
           exit;
         end;
         SM_OUTOFCONNECTION,
         SM_NEWMAP,
         SM_LOGON,
         SM_RECONNECT,
         SM_SENDNOTICE: ;
         else
            exit;
      end;
   end;
   if g_boMapMoving then begin
      if msg.Ident = SM_CHANGEMAP then begin
         WaitingMsg := msg;
         WaitingStr := DecodeString (body);
         g_boMapMovingWait := TRUE;
         WaitMsgTimer.Enabled := TRUE;
      end;
      exit;
   end;

  case msg.Ident of

    SM_VERSION_FAIL: begin
      i := MakeLong(msg.Param,msg.Tag);
      DecodeBuffer (body, @j, sizeof(Integer));
      if (msg.Recog <> g_nThisCRC) and
         (i <> g_nThisCRC) and
         (j <> g_nThisCRC) then begin

//        DScreen.AddChatBoardString ('版本错误，请下载最新版本。', clYellow, clRed);
//        FrmDlg.DMessageDlg ('版本错误，请下载最新版本。', [mbOk]);
//        CSocket.Close;
//        FrmMain.Close;
//        frmSelMain.Close;
        exit;
//        FrmDlg.DMessageDlg ('版本错误，请下载最新版本。(http://www.lom2.net)', [mbOk]);
//        Close;
        exit;
      end;
    end;
      SM_NEWMAP: begin
        g_sMapTitle := '';
        str := DecodeString (body); //mapname
//        PlayScene.MemoLog.Lines.Add('X: ' + IntToStr(msg.Param) + 'Y: ' + IntToStr(msg.tag) + ' Map: ' + str);
        PlayScene.SendMsg (SM_NEWMAP, 0,
                           msg.Param{x},
                           msg.tag{y},
                           msg.Series{darkness},
                           0, 0,
                           str{mapname});
      end;

      SM_LOGON: begin
        SendClientMessage (CM_REQUESTMAILLIST, 0, 0, 0, 0);
        g_dwFirstServerTime := 0;
        g_dwFirstClientTime := 0;
        with msg do begin
          DecodeBuffer (body, @wl, sizeof(TMessageBodyWL));
          PlayScene.SendMsg (SM_LOGON, msg.Recog,
                             msg.Param{x},
                             msg.tag{y},
                             msg.Series{dir},
                             wl.lParam1, //desc.Feature,
                             wl.lParam2, //desc.Status,
                             '');
          DScreen.ChangeScene (stPlayGame);
          SendClientMessage (CM_QUERYBAGITEMS, 0, 0, 0, 0);
          SendClientMessage (CM_QUERYSTORAGEITEMS, 0, 0, 0, 0);
          if Lobyte(Loword(wl.lTag1)) = 1 then g_boAllowGroup := TRUE
          else g_boAllowGroup := FALSE;
          g_boServerChanging := FALSE;
        end;
        if g_wAvailIDDay > 0 then begin
          DScreen.AddChatBoardString ('您当前通过包月帐号充值。', clGreen, clWhite)
        end else if g_wAvailIPDay > 0 then begin
          DScreen.AddChatBoardString ('您当前通过包月IP充值。', clGreen, clWhite)
        end else if g_wAvailIPHour > 0 then begin
          DScreen.AddChatBoardString ('您当前通过计时IP充值。', clGreen, clWhite)
        end else if g_wAvailIDHour > 0 then begin
          DScreen.AddChatBoardString ('您当前通过计时帐号充值。', clGreen, clWhite)
        end;
        LoadUserConfig(CharName);
        DScreen.AddChatBoardString ('当前服务器信息: ' + g_sRunServerAddr + ':' + IntToStr(g_nRunServerPort), clGreen, clWhite)
      end;
      SM_SERVERCONFIG: ClientGetServerConfig(Msg,Body);

      SM_RECONNECT: begin
        ClientGetReconnect (body);
      end;
      SM_LOVERNAME: g_LoverNameClient := body;

      SM_TIMECHECK_MSG:
         begin
            CheckSpeedHack (msg.Recog);
         end;

      SM_AREASTATE:
         begin
            g_nAreaStateValue := msg.Recog;
         end;

      SM_MAPDESCRIPTION: begin
        ClientGetMapDescription(Msg,body);
      end;
      SM_GAMEGOLDNAME: begin
        ClientGetGameGoldName(msg,body);
      end;

      SM_ADJUST_BONUS: begin
        ClientGetAdjustBonus (msg.Recog, body);
      end;
      SM_MYSTATUS: begin
        g_nMyHungryState:=msg.Param;
      end;
      SM_ATTATCKMODE: begin
        ClientGetAttatckMode (msg.Recog, body);
      end;
      SM_TURN:
         begin
            if Length(body) > GetCodeMsgSize(sizeof(TCharDesc)*4/3) then begin
               Body2 := Copy (Body, GetCodeMsgSize(sizeof(TCharDesc)*4/3)+1, Length(body));
               data := DecodeString (body2);
               str := GetValidStr3 (data, data, ['/']);
            end else data := '';
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            PlayScene.SendMsg (SM_TURN, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir + light},
                                 desc.Feature,
                                 desc.Status,
                                 '');
            if data <> '' then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.m_sDescUserName := GetValidStr3(data, actor.m_sUserName, ['\']);
                  //actor.UserName := data;
                  actor.m_nNameColor := GetRGB(Str_ToInt(str, 0));
               end;
            end;
         end;

      SM_BACKSTEP:
         begin
            if Length(body) > GetCodeMsgSize(sizeof(TCharDesc)*4/3) then begin
               Body2 := Copy (Body, GetCodeMsgSize(sizeof(TCharDesc)*4/3)+1, Length(body));
               data := DecodeString (body2);
               str := GetValidStr3 (data, data, ['/']);
            end else data := '';
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            PlayScene.SendMsg (SM_BACKSTEP, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir + light},
                                 desc.Feature,
                                 desc.Status,
                                 '');
            if data <> '' then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.m_sDescUserName := GetValidStr3(data, actor.m_sUserName, ['\']);
                  //actor.UserName := data;
                  actor.m_nNameColor := GetRGB(Str_ToInt(str, 0));
               end;
            end;
         end;

      SM_SPACEMOVE_HIDE,
      SM_SPACEMOVE_HIDE2:
         begin
            if msg.Recog <> g_MySelf.m_nRecogId then begin
               PlayScene.SendMsg (msg.Ident, msg.Recog, msg.Param{x}, msg.tag{y}, 0, 0, 0, '')
            end;
         end;

      SM_SPACEMOVE_SHOW,
      SM_SPACEMOVE_SHOW2:
         begin
            if Length(body) > GetCodeMsgSize(sizeof(TCharDesc)*4/3) then begin
               Body2 := Copy (Body, GetCodeMsgSize(sizeof(TCharDesc)*4/3)+1, Length(body));
               data := DecodeString (body2);
               str := GetValidStr3 (data, data, ['/']);

            end else data := '';
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> g_MySelf.m_nRecogId then begin
              PlayScene.NewActor (msg.Recog, msg.Param, msg.tag, msg.Series, desc.feature, desc.Status);
            end;
            PlayScene.SendMsg (msg.Ident, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir + light},
                                 desc.Feature,
                                 desc.Status,
                                 '');
            if data <> '' then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.m_sDescUserName := GetValidStr3(data, actor.m_sUserName, ['\']);
                  //actor.UserName := data;
                  actor.m_nNameColor := GetRGB(Str_ToInt(str, 0));
               end;
            end;
         end;

      SM_WALK, SM_RUSH, SM_RUSHKUNG:
         begin
            //DScreen.AddSysMsg ('WALK ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if (msg.Recog <> g_MySelf.m_nRecogId) or (msg.Ident = SM_RUSH) or (msg.Ident = SM_RUSHKUNG) then
               PlayScene.SendMsg (msg.Ident, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir+light},
                                 desc.Feature,
                                 desc.Status, '');
            if msg.Ident = SM_RUSH then
               g_dwLatestRushRushTick := GetTickCount;                      
         end;

      SM_RUN,SM_HORSERUN:
         begin
            //DScreen.AddSysMsg ('RUN ' + IntToStr(msg.Param) + ':' + IntToStr(msg.Tag));
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> g_MySelf.m_nRecogId then
               PlayScene.SendMsg (msg.Ident, msg.Recog,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir+light},
                                    desc.Feature,
                                    desc.Status, '');
               (*
               PlayScene.SendMsg (SM_RUN, msg.Recog,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir+light},
                                    desc.Feature,
                                    desc.Status, '');
               *)
         end;

      SM_CHANGELIGHT:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.m_nChrLight := msg.Param;
            end;
         end;

      SM_LAMPCHANGEDURA:
         begin
            if g_UseItems[U_RIGHTHAND].S.Name <> '' then begin
               g_UseItems[U_RIGHTHAND].Dura := msg.Recog;
            end;
         end;

      SM_MOVEFAIL: begin
        ActionFailed;
        DecodeBuffer (body, @desc, sizeof(TCharDesc));
        PlayScene.SendMsg (SM_TURN, msg.Recog,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir},
                                 desc.Feature,
                                 desc.Status, '');
      end;
      SM_BUTCH:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> g_MySelf.m_nRecogId then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then
                  actor.SendMsg (SM_SITDOWN,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '', 0);
            end;
         end;
      SM_SITDOWN:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            if msg.Recog <> g_MySelf.m_nRecogId then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then
                  actor.SendMsg (SM_SITDOWN,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '', 0);
            end;
         end;

      SM_HIT,           //14
      SM_HEAVYHIT,      //15
      SM_POWERHIT,      //18
      SM_LONGHIT,       //19
      SM_WIDEHIT,       //24
      SM_BIGHIT,        //16
      SM_FIREHIT,       //8
      SM_CRSHIT,
      SM_TWINHIT:
         begin
            if msg.Recog <> g_MySelf.m_nRecogId then begin
               actor := PlayScene.FindActor (msg.Recog);
               if actor <> nil then begin
                  actor.SendMsg (msg.Ident,
                                    msg.Param{x},
                                    msg.tag{y},
                                    msg.Series{dir},
                                    0, 0, '',
                                    0);
                  if msg.ident = SM_HEAVYHIT then begin
                     if body <> '' then
                        actor.m_boDigFragment := TRUE;
                  end;
               end;
            end;
         end;
      SM_FLYAXE,
      SM_81,
      SM_82,
      SM_83:
         begin
            DecodeBuffer (body, @mbw, sizeof(TMessageBodyW));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.SendMsg (msg.Ident,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir},
                                 0, 0, '',
                                 0);
               actor.m_nTargetX := mbw.Param1;  //x
               actor.m_nTargetY := mbw.Param2;    //y
               actor.m_nTargetRecog := MakeLong(mbw.Tag1, mbw.Tag2);
            end;
         end;

      SM_LIGHTING:
         begin

            DecodeBuffer (body, @wl, sizeof(TMessageBodyWL));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.SendMsg (msg.Ident,
                                 msg.Param{x},
                                 msg.tag{y},
                                 msg.Series{dir},
                                 0, 0, '',
                                 0);
               actor.m_nTargetX := wl.lParam1;  //x
               actor.m_nTargetY := wl.lParam2;    //y
               actor.m_nTargetRecog := wl.lTag1;
               actor.m_nMagicNum := wl.lTag2;
            end;
         end;

      SM_SPELL: begin
        UseMagicSpell (msg.Recog{who}, msg.Series{effectnum}, msg.Param{tx}, msg.Tag{y}, Str_ToInt(body,0));
      end;
      SM_MAGICFIRE: begin
        DecodeBuffer (body, @param, sizeof(integer));
        UseMagicFire (msg.Recog{who}, Lobyte(msg.Series){efftype}, Hibyte(msg.Series){effnum}, msg.Param{tx}, msg.Tag{y}, param);
        //Lobyte(msg.Series) = EffectType
        //Hibyte(msg.Series) = Effect
      end;
      SM_MAGICFIRE_FAIL:
         begin
            UseMagicFireFail (msg.Recog{who});
         end;

      SM_OUTOFCONNECTION:
         begin
            g_boDoFastFadeOut := FALSE;
            g_boDoFadeIn := FALSE;
            g_boDoFadeOut := FALSE;
            FrmDlg.DMessageDlg ('服务器连接被强行中断。\' +
                                '连接时间可能超过限制或\' +
                                '再重新登陆游戏。', [mbOk]);
            Close;
         end;

      SM_DEATH,
      SM_NOWDEATH:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.SendMsg (msg.Ident,
                              msg.param{x}, msg.Tag{y}, msg.Series{damage},
                              desc.Feature, desc.Status, '',
                              0);
               actor.m_Abil.HP := 0;
            end else begin
               PlayScene.SendMsg (SM_DEATH, msg.Recog, msg.param{x}, msg.Tag{y}, msg.Series{damage}, desc.Feature, desc.Status, '');
            end;
         end;
      SM_SKELETON:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            PlayScene.SendMsg (SM_SKELETON, msg.Recog, msg.param{HP}, msg.Tag{maxHP}, msg.Series{damage}, desc.Feature, desc.Status, '');
         end;
      SM_ALIVE:
         begin
            DecodeBuffer (body, @desc, sizeof(TCharDesc));
            PlayScene.SendMsg (SM_ALIVE, msg.Recog, msg.param{HP}, msg.Tag{maxHP}, msg.Series{damage}, desc.Feature, desc.Status, '');
         end;

      SM_ABILITY:
         begin
            g_MySelf.m_nGold := msg.Recog;
            g_MySelf.m_btJob := msg.Param;
            g_MySelf.m_nGameGold:=MakeLong(msg.Tag,msg.Series);
            DecodeBuffer (body, @g_MySelf.m_Abil, sizeof(TAbility));
         end;

      SM_SUBABILITY: begin
        g_nMyHitPoint      := Lobyte(Msg.Param);
        g_nMySpeedPoint    := Hibyte(Msg.Param);
        g_nMyAntiPoison    := Lobyte(Msg.Tag);
        g_nMyPoisonRecover := Hibyte(Msg.Tag);
        g_nMyHealthRecover := Lobyte(Msg.Series);
        g_nMySpellRecover  := Hibyte(Msg.Series);
        g_nMyAntiMagic     := LoByte(LongWord(Msg.Recog));
      end;

      SM_DAYCHANGING:
         begin
            g_nDayBright := msg.Param;
            DarkLevel := msg.Tag;
            if DarkLevel = 0 then g_boViewFog := FALSE
            else g_boViewFog := TRUE;
         end;

      SM_WINEXP:
         begin
            g_MySelf.m_Abil.Exp := msg.Recog;

            if LongWord(MakeLong(msg.Param,msg.Tag)) = 1 then
              DScreen.AddChatBoardString ('已获得 1 点经验值。',clWhite, clRed)
            else
              DScreen.AddChatBoardString ('已获得 ' + IntToStr(LongWord(MakeLong(msg.Param,msg.Tag))) +' 点经验值。',clWhite, clRed)
         end;

      SM_LEVELUP:
         begin
            //看其他玩家升级效果.
            i := MakeLong(msg.Tag, msg.Series);
            Actor := PlayScene.FindActor (i);
            if Actor <> nil then begin
              DrawEffectHumEx(12,Actor);

              if Actor = g_MySelf then begin
                g_MySelf.m_Abil.Level:=msg.Param;
                DScreen.AddChatBoardString ('恭喜！您的等级已升级。',clWhite, clPurple);
              end;
            end;
         end;

      SM_HEALTHSPELLCHANGED: begin
        Actor := PlayScene.FindActor (msg.Recog);
        if Actor <> nil then begin
          Actor.m_Abil.HP    := msg.Param;
          Actor.m_Abil.MP    := msg.Tag;
          Actor.m_Abil.MaxHP := msg.Series;
        end;
      end;

      SM_STRUCK:
         begin
            //wl: TMessageBodyWL;
            DecodeBuffer (body, @wl, sizeof(TMessageBodyWL));
            Actor := PlayScene.FindActor (msg.Recog);
            if Actor <> nil then begin
               if Actor = g_MySelf then begin
                  g_nRunReadyCount:= 0;
                  if g_MySelf.m_nNameColor = 249 then
                     g_dwLatestStruckTick := GetTickCount;
               end else begin
                  if Actor.CanCancelAction then
                     Actor.CancelAction;
               end;
               Actor.UpdateMsg (SM_STRUCK, wl.lTag2, 0,
                           msg.Series{damage}, wl.lParam1, wl.lParam2,
                           '', wl.lTag1);
               Actor.m_Abil.HP := msg.param;
               Actor.m_Abil.MaxHP := msg.Tag;
            end;
         end;

      SM_CHANGEFACE:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               DecodeBuffer (body, @desc, sizeof(TCharDesc));
               actor.m_nWaitForRecogId := MakeLong(msg.Param, msg.Tag);
               actor.m_nWaitForFeature := desc.Feature;
               actor.m_nWaitForStatus := desc.Status;
               AddChangeFace (actor.m_nWaitForRecogId);
            end;
         end;
      SM_PASSWORD: begin
        //PlayScene.EdChat.PasswordChar:='*';
        SetInputStatus();
      end;
      SM_OPENHEALTH:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               if actor <> g_MySelf then begin
                  actor.m_Abil.HP := msg.Param;
                  actor.m_Abil.MaxHP := msg.Tag;
               end;
               actor.m_boOpenHealth := TRUE;
               //actor.OpenHealthTime := 999999999;
               //actor.OpenHealthStart := GetTickCount;
            end;
         end;
      SM_CLOSEHEALTH:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.m_boOpenHealth := FALSE;
            end;
         end;
      SM_INSTANCEHEALGUAGE:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.m_Abil.HP := msg.param;
               actor.m_Abil.MaxHP := msg.Tag;
               actor.m_noInstanceOpenHealth := TRUE;
               actor.m_dwOpenHealthTime := 2 * 1000;
               actor.m_dwOpenHealthStart := GetTickCount;
            end;
         end;

      SM_BREAKWEAPON:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               if actor is THumActor then
                  THumActor(actor).DoWeaponBreakEffect;
            end;
         end;

      SM_CRY,
      SM_GROUPMESSAGE,
      SM_GUILDMESSAGE,
      SM_WHISPER,
      SM_SYSMESSAGE:
         begin
            str := DecodeString (body);
            DScreen.AddChatBoardString (str, GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)));
            if msg.Ident = SM_GUILDMESSAGE then
               FrmDlg.AddGuildChat (str);
         end;

      SM_HEAR:
         begin
            str := DecodeString (body);
            DScreen.AddChatBoardString (str, GetRGB(Lobyte(msg.Param)), GetRGB(Hibyte(msg.Param)));
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then
               actor.Say (str);
         end;

      SM_USERNAME:
         begin
            str := DecodeString (body);
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.m_sDescUserName := GetValidStr3(str, actor.m_sUserName, ['\']);
               //actor.UserName := str;
               actor.m_nNameColor := GetRGB (msg.Param);
            end;
         end;
      SM_CHANGENAMECOLOR:
         begin
            actor := PlayScene.FindActor (msg.Recog);
            if actor <> nil then begin
               actor.m_nNameColor := GetRGB (msg.Param);
            end;
         end;

      SM_HIDE,
      SM_GHOST,
      SM_DISAPPEAR:
         begin
            if g_MySelf.m_nRecogId <> msg.Recog then
               PlayScene.SendMsg (SM_HIDE, msg.Recog, msg.Param{x}, msg.tag{y}, 0, 0, 0, '');
         end;

      SM_DIGUP:
         begin
            DecodeBuffer (body, @wl, sizeof(TMessageBodyWL));
            actor := PlayScene.FindActor (msg.Recog);
            if actor = nil then
               actor := PlayScene.NewActor (msg.Recog, msg.Param, msg.tag, msg.Series, wl.lParam1, wl.lParam2);
            actor.m_nCurrentEvent := wl.lTag1;
            actor.SendMsg (SM_DIGUP,
                           msg.Param{x},
                           msg.tag{y},
                           msg.Series{dir + light},
                           wl.lParam1,
                           wl.lParam2, '', 0);
         end;
      SM_DIGDOWN:
         begin
            PlayScene.SendMsg (SM_DIGDOWN, msg.Recog, msg.Param{x}, msg.tag{y}, msg.series, 0, 0, '');
         end;
      SM_SHOWEVENT:
         begin
            DecodeBuffer (body, @smsg, sizeof(TShortMessage));
            event := TClEvent.Create (msg.Recog, Loword(msg.Tag){x}, msg.Series{y}, msg.Param{e-type});
            event.m_nDir := 0;
            event.m_nEventParam := smsg.Ident;
            EventMan.AddEvent (event);
         end;
      SM_HIDEEVENT:
         begin
            EventMan.DelEventById (msg.Recog);
         end;
      //物品
      SM_ADDITEM:
         begin
            ClientGetAddItem (body);
         end;
      SM_BAGITEMS:
         begin
            ClientGetBagItmes (body, TRUE);
         end;
      SM_BAGITEMS2:
        begin
          ClientGetBagItems2 (body);
        end;
      SM_STORAGEITEMS:
        begin
          ClientGetStoreItems (body, TRUE);
        end;
      SM_STORAGEITEMS2:
        begin
          ClientGetStoreItems2 (body);
        end;
      SM_ADDSTORAGE:
        begin
          ClientGetAddStore (body);
        end;
      {SM_SENGGAMESHOPITEMS:
        begin
          FrmDlg.ClearGameShoplist;
          g_ItemShopCurrPage:= msg.Param;
          g_ItemShopAmountofPages:=msg.Tag;
          g_ItemShopTotalPage:=msg.Series;
          ClientGameShopList(body);
        end; }
      SM_AUCTIONITEMS:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            FrmDlg.ClearAuctionDlg;

            g_AuctionCurrPage := msg.Param;
            g_AuctionAmountofPages := msg.Tag;
            g_AuctionCurrSection := msg.Series;

            if g_AuctionCurrSection = 17 then begin
              FrmDlg.DSalesBuy.SetImgIndex (g_WMainImages, 650);
              FrmDlg.DSalesMail.Visible := false;
            end else begin
              FrmDlg.DSalesBuy.SetImgIndex (g_WMainImages, 678);
              FrmDlg.DSalesMail.Visible := true;
            end;

            ClientAuctionItems (body);
         end;
      SM_GTList:
        begin
          FrmDlg.ClearGTlist;
          g_GTCurrPage:= msg.Param;
          g_GTAmountOnPage:=msg.Tag;
          ClientGTList(body);
        end;
      SM_GTDECOLIST:
        begin
          FrmDlg.ClearDecoList;
          g_GTCurrPage:= msg.Param;
          g_GTAmountOnPage:=msg.Tag;
          G_GTTotalPage:=msg.Series;
          ClientDecoList(body);
        end;
      SM_GTTRADE:
        begin
          if mrOk = FrmDlg.DMessageDlg ('你愿意以' +
            IntToStr(msg.Recog) + '金币购买公会领土吗？', [mbOk, mbCancel])
          then begin
            self.SendTradeGT(1);
          end else
            self.SendTradeGT(0);
        end;
      SM_BBSMSGLIST:
        begin
          FrmDlg.ClearBBSList;
          g_GTCurrPage:= msg.Param;
          g_GTAmountOnPage:=msg.Tag;
          G_GTTotalPage:=msg.Series;
          ClientBBSList(body);
        end;
      SM_BBSMSG:
        begin
          g_MasterPost:= msg.Recog;
          ClientBBSMsg(body);
          FrmDlg.GuildCommanderMode := False;
          if msg.param = 1 then FrmDlg.GuildCommanderMode := True;
        end;
      SM_UPDATEITEM:
         begin
            ClientGetUpdateItem (body);
         end;
      SM_DELITEM:
         begin
            ClientGetDelItem (body);
         end;
      SM_DELITEMS:
         begin
            ClientGetDelItems (body);
         end;

      SM_DROPITEM_SUCCESS:
         begin
            DelDropItem (DecodeString(body), msg.Recog);
         end;
      SM_DROPITEM_FAIL:
         begin
            ClientGetDropItemFail (DecodeString(body), msg.Recog);
         end;

      SM_ITEMSHOW       :ClientGetShowItem (msg.Recog, msg.param{x}, msg.Tag{y}, msg.Series{looks}, DecodeString(body));
      SM_ITEMHIDE       :ClientGetHideItem (msg.Recog, msg.param, msg.Tag);
      SM_OPENDOOR_OK    :Map.OpenDoor (msg.param, msg.tag);
      SM_OPENDOOR_LOCK  :DScreen.AddSysMsg ('此门被锁定！');
      SM_CLOSEDOOR      :Map.CloseDoor (msg.param, msg.tag);

      SM_TAKEON_OK:
         begin
            g_MySelf.m_nFeature := msg.Recog;
            g_MySelf.FeatureChanged;
//            if WaitingUseItem.Index in [0..8] then
            if g_WaitingUseItem.Index in [0..12] then
               g_UseItems[g_WaitingUseItem.Index] := g_WaitingUseItem.Item;
            g_WaitingUseItem.Item.S.Name := '';
         end;
      SM_TAKEON_FAIL:
         begin
            AddItemBag (g_WaitingUseItem.Item);
            g_WaitingUseItem.Item.S.Name := '';
         end;
      SM_TAKEOFF_OK:
         begin
            g_MySelf.m_nFeature := msg.Recog;
            g_MySelf.FeatureChanged;
            g_WaitingUseItem.Item.S.Name := '';
         end;
      SM_TAKEOFF_FAIL:
         begin
            if g_WaitingUseItem.Index < 0 then begin
               n := -(g_WaitingUseItem.Index+1);
               g_UseItems[n] := g_WaitingUseItem.Item;
            end;
            g_WaitingUseItem.Item.S.Name := '';
         end;
      SM_EXCHGTAKEON_OK:       ;
      SM_EXCHGTAKEON_FAIL:     ;

      SM_SENDUSEITEMS:
         begin
            ClientGetSenduseItems (body);
         end;
      SM_WEIGHTCHANGED:
         begin
            g_MySelf.m_Abil.Weight := msg.Recog;
            g_MySelf.m_Abil.WearWeight := msg.Param;
            g_MySelf.m_Abil.HandWeight := msg.Tag;
         end;
      SM_GOLDCHANGED:
         begin
            SoundUtil.PlaySound (s_money);
            if msg.Recog > g_MySelf.m_nGold then begin
               DScreen.AddSysMsg ('获得 ' + GetGoldStr(msg.Recog-g_MySelf.m_nGold) + ' ' + g_sGoldName);
            end;
            g_MySelf.m_nGold := msg.Recog;
            g_MySelf.m_nGameGold:=MakeLong(msg.Param,msg.Tag);
         end;
      SM_BANKGOLDCHANGED:
         begin
            SoundUtil.PlaySound (s_money);
           // if msg.Recog > g_MySelf.m_nGold then begin
           //    DScreen.AddSysMsg ('获得 ' + GetGoldStr(msg.Recog-g_MySelf.m_nGold) + ' ' + g_sGoldName);
          //  end;
            g_MySelf.m_nBankGold := msg.Recog;
            g_MySelf.m_nGameGold:=MakeLong(msg.Param,msg.Tag);
         end;
      SM_FEATURECHANGED: begin
        PlayScene.SendMsg (msg.Ident, msg.Recog, 0, 0, 0, MakeLong(msg.Param, msg.Tag), MakeLong(msg.Series,0), '');
      end;
      SM_CHARSTATUSCHANGED: begin
        PlayScene.SendMsg (msg.Ident, msg.Recog, 0, 0, 0, MakeLong(msg.Param, msg.Tag), msg.Series, '');
      end;
      SM_CLEAROBJECTS:
         begin
            PlayScene.CleanObjects;
            g_boMapMoving := TRUE;
         end;

      SM_EAT_OK:
         begin
            g_EatingItem.S.Name := '';
            ArrangeItembag;
         end;
      SM_EAT_FAIL:
         begin
            AddItemBag (g_EatingItem);
            g_EatingItem.S.Name := '';
         end;

      SM_ADDMAGIC:
         begin
            if body <> '' then
               ClientGetAddMagic (body);
         end;
      SM_SENDMYMAGIC: if body <> '' then ClientGetMyMagics (body);

      SM_DELMAGIC:
         begin
            ClientGetDelMagic (msg.Recog);
         end;
      SM_MAGIC_LVEXP:
         begin
            ClientGetMagicLvExp (msg.Recog{magid}, msg.Param{lv}, MakeLong(msg.Tag, msg.Series));
         end;
      SM_DURACHANGE:
         begin
            ClientGetDuraChange (msg.Param{useitem index}, msg.Recog, MakeLong(msg.Tag, msg.Series));
         end;

      SM_MERCHANTSAY:
         begin
            ClientGetMerchantSay (msg.Recog, msg.Param, DecodeString (body));
         end;
      SM_MERCHANTDLGCLOSE:
         begin
            FrmDlg.CloseMDlg;
         end;
      SM_SENDGOODSLIST:
         begin
            ClientGetSendGoodsList (msg.Recog, msg.Param, body);
         end;
      SM_SENGGAMESHOPITEMS:
         begin
            ClientGetSendGameShopList (msg.Recog, msg.Param, body);
         end;
      SM_SENDUSERMAKEDRUGITEMLIST:
         begin
            ClientGetSendMakeDrugList (msg.Recog, body);
         end;
      SM_SENDUSERSELL:
         begin
            ClientGetSendUserSell (msg.Recog);
         end;
      SM_SENDUSERREPAIR:
         begin
            ClientGetSendUserRepair (msg.Recog);
         end;
      SM_SENDBUYPRICE:
         begin
            if g_SellDlgItem.S.Name <> '' then begin
               if msg.Recog > 0 then
                  g_sSellPriceStr := IntToStr(msg.Recog) + ' ' + g_sGoldName
               else g_sSellPriceStr := '???? ' + g_sGoldName;
            end;
         end;
      SM_USERSELLITEM_OK:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            g_MySelf.m_nGold := msg.Recog;
            g_SellDlgItemSellWait.S.Name := '';
         end;

      SM_USERSELLITEM_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            AddItemBag (g_SellDlgItemSellWait);
            g_SellDlgItemSellWait.S.Name := '';
            FrmDlg.DMessageDlg ('您不能卖这个物品。', [mbOk]);
         end;

      SM_SENDREPAIRCOST:
         begin
            if g_SellDlgItem.S.Name <> '' then begin
               if msg.Recog >= 0 then
                  g_sSellPriceStr := IntToStr(msg.Recog) + ' ' + g_sGoldName
               else g_sSellPriceStr := '???? ' + g_sGoldName;
            end;
         end;
      SM_USERREPAIRITEM_OK:
         begin
            if g_SellDlgItemSellWait.S.Name <> '' then begin
               FrmDlg.LastestClickTime := GetTickCount;
               g_MySelf.m_nGold := msg.Recog;
               g_SellDlgItemSellWait.Dura := msg.Param;
               g_SellDlgItemSellWait.DuraMax := msg.Tag;
               AddItemBag (g_SellDlgItemSellWait);
               g_SellDlgItemSellWait.S.Name := '';
            end;
         end;
      SM_USERREPAIRITEM_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            AddItemBag (g_SellDlgItemSellWait);
            g_SellDlgItemSellWait.S.Name := '';
            FrmDlg.DMessageDlg ('您不能修理这个物品。', [mbOk]);
         end;
      SM_STORAGE_OK,
      SM_STORAGE_FULL,
      SM_STORAGE_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            if msg.Ident <> SM_STORAGE_OK then begin
               if msg.Ident = SM_STORAGE_FULL then
                  FrmDlg.DMessageDlg ('您的个人仓库已满，您不能存放。', [mbOk])
               else
                  FrmDlg.DMessageDlg ('您不能存放。', [mbOk]);
               AddItemBag (g_SellDlgItemSellWait);
            end;
            g_SellDlgItemSellWait.S.Name := '';
         end;
      SM_CONSIGN_OK:
        begin
          FrmDlg.LastestClickTime := GetTickCount;
          Dscreen.AddChatBoardString('您的物品被寄售了。',clwhite,clgreen);
          g_SellDlgItemSellWait.S.Name := '';
          g_SellDlgItem.S.Name := ''
        end;
      SM_CONSIGN_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            case msg.Recog of
               1: FrmDlg.DMessageDlg ('卖的物品最低价是1000金币。', [mbOk]);
               2: FrmDlg.DMessageDlg ('卖的物品最高价是50000000金币。', [mbOk]);
               3: FrmDlg.DMessageDlg ('商人没找到。', [mbOk]);
               4: FrmDlg.DMessageDlg ('物品没找到。', [mbOk]);
               5: FrmDlg.DMessageDlg ('您需要1000金币寄售物品。', [mbOk]);
            end;
            AddItemBagst(g_SellDlgItemSellWait);
            g_SellDlgItemSellWait.S.Name := '';
         end;
      SM_GETAUCTIONITEMS_FAIL:
        begin
          FrmDlg.LastestClickTime := GetTickCount;
          FrmDlg.ClearAuctionDlg;

          //Dscreen.AddChatBoardString(format('%d/%d/%d/%d/%d',[msg.Recog,msg.Ident,msg.Param,msg.Tag,msg.Series]),clwhite,clgreen);

          g_AuctionCurrSection := msg.Param;
          g_AuctionCurrPage := 0;
          g_AuctionAmountofPages := 0;

          if FrmDlg.DSales.Visible = false then
            FrmDlg.ToggleAuctionWindow;
        end;
      SM_CLOSEAUCTION:
        begin
          FrmDlg.LastestClickTime := GetTickCount;
          DScreen.ClearHint;
          FrmDlg.CloseDSellDlg;
          if FrmDlg.DSales.Visible = true then
            FrmDlg.ToggleAuctionWindow;
        end;
      SM_SAVEITEMLIST:
         begin
            ClientGetSaveItemList (msg.Recog, body);
         end;
      SM_TAKEBACKSTORAGEITEM_OK,
      SM_TAKEBACKSTORAGEITEM_FAIL,
      SM_TAKEBACKSTORAGEITEM_FULLBAG:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            if msg.Ident <> SM_TAKEBACKSTORAGEITEM_OK then begin
               if msg.Ident = SM_TAKEBACKSTORAGEITEM_FULLBAG then
                  FrmDlg.DMessageDlg ('您无法携带更多物品了。', [mbOk])
               else
                  FrmDlg.DMessageDlg ('您无法取回物品。', [mbOk]);
            end else
               FrmDlg.DelStorageItem (msg.Recog); //itemserverindex
         end;

      SM_AUCTIONGIVE:
         begin
            FrmDlg.LastestClickTime := GetTickCount;

            if msg.Param <> 1 then
              g_MySelf.m_nGold := msg.Recog;

            FrmDlg.DSalesRefreshClick(Self,0,0);
         end;
         
      SM_BUYITEM_SUCCESS:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            g_MySelf.m_nGold := msg.Recog;
            FrmDlg.SoldOutGoods (MakeLong(msg.Param, msg.Tag));
         end;
      SM_BUYITEM_FAIL:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            case msg.Recog of
               1: FrmDlg.DMessageDlg ('此物品被卖出。', [mbOk]);
               2: FrmDlg.DMessageDlg ('您无法携带更多物品了。', [mbOk]);
               3: FrmDlg.DMessageDlg ('您没有足够的金币来购买此物品.', [mbOk]);
            end;
         end;
      SM_MAKEDRUG_SUCCESS:
         begin
            FrmDlg.LastestClickTime := GetTickCount;
            g_MySelf.m_nGold := msg.Recog;
            FrmDlg.DMessageDlg ('您要的物品已经搞定了。', [mbOk]);
         end;
      SM_MAKEDRUG_FAIL: begin
        FrmDlg.LastestClickTime := GetTickCount;
        case msg.Recog of
          1: FrmDlg.DMessageDlg ('物品不存在。', [mbOk]);
          2: FrmDlg.DMessageDlg ('包袱已满。', [mbOk]);
          3: FrmDlg.DMessageDlg (g_sGoldName + '不足。', [mbOk]);
          4: FrmDlg.DMessageDlg ('你缺乏所必需的物品。', [mbOk]);
        end;
      end;
      SM_716: begin
        if (Msg.Series = 13) or (Msg.Series = 14) or (Msg.Series = 15) then begin
          actor := PlayScene.FindActor (msg.Recog);
          if actor <> nil then
            DrawEffectHumEx(Msg.Series{type},actor)
        end else
          DrawEffectHum(Msg.Series{type},Msg.Param{x},Msg.Tag{y});
      end;
      SM_SENDDETAILGOODSLIST: begin
        ClientGetSendDetailGoodsList (msg.Recog, msg.Param, msg.Tag, body);
      end;
      SM_TEST:
         begin
            Inc (g_nTestReceiveCount);
         end;

      SM_SENDNOTICE: begin
        ClientGetSendNotice (body);
      end;
      SM_GROUPMODECHANGED:
         begin
            if msg.Param > 0 then g_boAllowGroup := TRUE
            else g_boAllowGroup := FALSE;
            g_dwChangeGroupModeTick := GetTickCount;
         end;
      SM_CREATEGROUP_OK:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            g_boAllowGroup := TRUE;
            {GroupMembers.Add (Myself.UserName);
            GroupMembers.Add (DecodeString(body));}
         end;
      SM_CREATEGROUP_FAIL:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            case msg.Recog of
               -1: FrmDlg.DMessageDlg ('编组还未成立或者你还不够等级创建。', [mbOk]);
               -2: FrmDlg.DMessageDlg ('增加小组人物的名字不是正确的。', [mbOk]);
               -3: FrmDlg.DMessageDlg ('您在小组想要邀请的用户已经入另一个小组。', [mbOk]);
               -4: FrmDlg.DMessageDlg ('对方不允许编组。', [mbOk]);
            end;
         end;
      SM_GROUPADDMEM_OK:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            //GroupMembers.Add (DecodeString(body));
         end;
      SM_GROUPADDMEM_FAIL:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            case msg.Recog of
               -1: FrmDlg.DMessageDlg ('编组还未成立或者你还不够等级创建！', [mbOk]);
               -2: FrmDlg.DMessageDlg ('输入的人物名称不正确！', [mbOk]);
               -3: FrmDlg.DMessageDlg ('已经加入编组！', [mbOk]);
               -4: FrmDlg.DMessageDlg ('对方不允许编组！', [mbOk]);
               -5: FrmDlg.DMessageDlg ('您想邀请加入编组的人已经加入了其它组！', [mbOk]);
            end;
         end;
      SM_GROUPDELMEM_OK:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            {data := DecodeString (body);
            for i:=0 to GroupMembers.Count-1 do begin
               if GroupMembers[i] = data then begin
                  GroupMembers.Delete (i);
                  break;
               end;
            end; }
         end;
      SM_GROUPDELMEM_FAIL:
         begin
            g_dwChangeGroupModeTick := GetTickCount;
            case msg.Recog of
               -1: FrmDlg.DMessageDlg ('编组还未成立或者您还不够等级创建。', [mbOk]);
               -2: FrmDlg.DMessageDlg ('输入的人物名称不正确！', [mbOk]);
               -3: FrmDlg.DMessageDlg ('此人不在本组中！', [mbOk]);
            end;
         end;
      SM_GROUPCANCEL: begin
        g_GroupMembers.Clear;
      end;
      SM_GROUPMEMBERS:
         begin
            ClientGetGroupMembers (DecodeString(Body));
         end;

      SM_OPENGUILDDLG:
         begin
            g_dwQueryMsgTick := GetTickCount;
            ClientGetOpenGuildDlg (body);
         end;

      SM_SENDGUILDMEMBERLIST:
         begin
            g_dwQueryMsgTick := GetTickCount;
            ClientGetSendGuildMemberList (body);
         end;

      SM_OPENGUILDDLG_FAIL:
         begin
            g_dwQueryMsgTick := GetTickCount;
            FrmDlg.DMessageDlg ('您还没有加入公会。', [mbOk]);
         end;

      SM_DEALTRY_FAIL: begin
        g_dwQueryMsgTick := GetTickCount;
        FrmDlg.DMessageDlg ('只有二人面对面才能进行交易。', [mbOk]);
      end;
      SM_DEALMENU:
         begin
            g_dwQueryMsgTick := GetTickCount;
            g_sDealWho := DecodeString (body);
            FrmDlg.OpenDealDlg;
         end;
      SM_DEALCANCEL: begin
        MoveDealItemToBag;
        if g_DealDlgItem.S.Name <> '' then begin
          AddItemBag (g_DealDlgItem);
          g_DealDlgItem.S.Name := '';
        end;
        if g_nDealGold > 0 then begin
          g_MySelf.m_nGold := g_MySelf.m_nGold + g_nDealGold;
          g_nDealGold := 0;
        end;
        FrmDlg.CloseDealDlg;
      end;
      SM_DEALADDITEM_OK:
         begin
            g_dwDealActionTick := GetTickCount;
            if g_DealDlgItem.S.Name <> '' then begin
               AddDealItem (g_DealDlgItem);
               g_DealDlgItem.S.Name := '';
            end;
         end;
      SM_DEALADDITEM_FAIL: begin
        g_dwDealActionTick:=GetTickCount;
        if g_DealDlgItem.S.Name <> '' then begin
          AddItemBag(g_DealDlgItem);
          g_DealDlgItem.S.Name:= '';
        end;
      end;
      SM_DEALDELITEM_OK: begin
        g_dwDealActionTick:=GetTickCount;
        if g_DealDlgItem.S.Name <> '' then begin
               //AddItemBag (DealDlgItem);
          g_DealDlgItem.S.Name := '';
        end;
      end;
      SM_DEALDELITEM_FAIL: begin
        g_dwDealActionTick := GetTickCount;
        if g_DealDlgItem.S.Name <> '' then begin
          DelItemBag (g_DealDlgItem.S.Name, g_DealDlgItem.MakeIndex);
          AddDealItem (g_DealDlgItem);
          g_DealDlgItem.S.Name := '';
        end;
      end;
      SM_DEALREMOTEADDITEM: ClientGetDealRemoteAddItem (body);
      SM_DEALREMOTEDELITEM: ClientGetDealRemoteDelItem (body);
      SM_DEALCHGGOLD_OK: begin
        g_nDealGold:=msg.Recog;
        g_MySelf.m_nGold:=MakeLong(msg.param, msg.tag);
        g_dwDealActionTick:=GetTickCount;
      end;
      SM_DEALCHGGOLD_FAIL: begin
        g_nDealGold:=msg.Recog;
        g_MySelf.m_nGold:=MakeLong(msg.param, msg.tag);
        g_dwDealActionTick:=GetTickCount;
      end;
      SM_DEALREMOTECHGGOLD: begin
        g_nDealRemoteGold:=msg.Recog;
        SoundUtil.PlaySound(s_money);
      end;
      SM_DEALSUCCESS: begin
        FrmDlg.CloseDealDlg;
      end;

      SM_REFINECANCEL: begin
        MoveRefineItemToBag;
        if g_DealDlgItem.S.Name <> '' then begin
          AddItemBag (g_DealDlgItem);
          g_DealDlgItem.S.Name := '';
        end;
        FrmDlg.CloseDealDlg;
      end;

      SM_SENDUSERSTORAGEITEM: begin
        ClientGetSendUserStorage(msg.Recog);
      end;
      SM_SENDUSERCONSIGNITEM: begin
        ClientGetSendUserConsign(msg.Recog);
      end;
      SM_CHANGEGUILDNAME: begin
        ClientGetChangeGuildName(DecodeString (body));
      end;
      SM_SENDUSERSTATE: begin
        ClientGetSendUserState(body);
      end;
      SM_GUILDADDMEMBER_OK: begin
        SendGuildMemberList;
      end;
      SM_GUILDADDMEMBER_FAIL: begin
        case msg.Recog of
          1: FrmDlg.DMessageDlg ('你没有权利使用这个命令', [mbOk]);
          2: FrmDlg.DMessageDlg ('想加入进来的成员应该来面对领袖', [mbOk]);
          3: FrmDlg.DMessageDlg ('对方已经加入我们的公会', [mbOk]);
          4: FrmDlg.DMessageDlg ('对方已经加入其他公会', [mbOk]);
          5: FrmDlg.DMessageDlg ('对方不允许加入公会', [mbOk]);
        end;
      end;
      SM_GUILDDELMEMBER_OK: begin
        SendGuildMemberList;
      end;
      SM_GUILDDELMEMBER_FAIL: begin
        case msg.Recog of
          1: FrmDlg.DMessageDlg('您不是公会领袖', [mbOk]);
          2: FrmDlg.DMessageDlg('这个人不是这个公会的成员', [mbOk]);
          3: FrmDlg.DMessageDlg('你是公会领袖不能开除自己', [mbOk]);
          4: FrmDlg.DMessageDlg('这个人不是这个公会的成员', [mbOk]);
        end;
      end;
      SM_GUILDRANKUPDATE_FAIL: begin
        case msg.Recog of
          -2: FrmDlg.DMessageDlg('[提示信息] 你不可以删除公会领袖位置', [mbOk]);
          -3: FrmDlg.DMessageDlg('[提示信息] 你不能删除所有公会领袖', [mbOk]);
          -4: FrmDlg.DMessageDlg('[提示信息] 一个公会最能只能两个领袖', [mbOk]);
          -5: FrmDlg.DMessageDlg('[提示信息] 不能这样删除或增加成员', [mbOk]);
          -6: FrmDlg.DMessageDlg('[提示信息] 你没有改变名单', [mbOk]);
          -7: FrmDlg.DMessageDlg('[提示信息] 您只能在0和99之间调整职位', [mbOk]);
        end;
      end;
      SM_GUILDMAKEALLY_OK,
      SM_GUILDMAKEALLY_FAIL: begin
        case msg.Recog of
          -1: FrmDlg.DMessageDlg ('你需要面对另一个玩家', [mbOk]);
          -2: FrmDlg.DMessageDlg ('你正与这个公会发生战争', [mbOk]);
          -3: FrmDlg.DMessageDlg ('你需要面对公会领袖', [mbOk]);
          -4: FrmDlg.DMessageDlg ('对方公会领袖不允许结盟！', [mbOk]);
        end;
      end;
      SM_GUILDBREAKALLY_OK,
      SM_GUILDBREAKALLY_FAIL: begin
        case msg.Recog of
          -1: FrmDlg.DMessageDlg ('你不是公会领袖', [mbOk]);
          -2: FrmDlg.DMessageDlg ('您与这个公会没有结盟', [mbOk]);
          -3: FrmDlg.DMessageDlg ('公会不存在', [mbOk]);
        end;
      end;
      SM_BUILDGUILD_OK: begin
        FrmDlg.LastestClickTime := GetTickCount;
        FrmDlg.DMessageDlg ('公会创建成功。', [mbOk]);
      end;
      SM_BUILDGUILD_FAIL: begin
        FrmDlg.LastestClickTime := GetTickCount;
        case msg.Recog of
          -1: FrmDlg.DMessageDlg('你已加入其他公会', [mbOk]);
          -2: FrmDlg.DMessageDlg('缺少创建费用', [mbOk]);
          -3: FrmDlg.DMessageDlg('你需要沃玛号角才能创建公会', [mbOk]);
          else FrmDlg.DMessageDlg('公会名字必须在1至16个字符之间', [mbOk]);
        end;
      end;
      SM_MENU_OK: begin
        FrmDlg.LastestClickTime:=GetTickCount;
        if body <> '' then
          FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
      end;
      SM_DLGMSG: begin
        if body <> '' then
          FrmDlg.DMessageDlg(DecodeString(body), [mbOk]);
      end;
      SM_DONATE_OK: begin
        FrmDlg.LastestClickTime:=GetTickCount;
      end;
      SM_DONATE_FAIL: begin
        FrmDlg.LastestClickTime:=GetTickCount;
      end;

      SM_PLAYDICE: begin
        Body2:=Copy(Body,GetCodeMsgSize(sizeof(TMessageBodyWL)*4/3) + 1, Length(body));
        DecodeBuffer(body,@wl,SizeOf(TMessageBodyWL));
        data:=DecodeString(Body2);
        FrmDlg.m_nDiceCount:=Msg.Param;       //QuestActionInfo.nParam1
        FrmDlg.m_Dice[0].nDicePoint:=LoByte(LoWord(Wl.lParam1)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[1].nDicePoint:=HiByte(LoWord(Wl.lParam1)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[2].nDicePoint:=LoByte(HiWord(Wl.lParam1)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[3].nDicePoint:=HiByte(HiWord(Wl.lParam1)); //UserHuman.m_DyVal[0]

        FrmDlg.m_Dice[4].nDicePoint:=LoByte(LoWord(Wl.lParam2)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[5].nDicePoint:=HiByte(LoWord(Wl.lParam2)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[6].nDicePoint:=LoByte(HiWord(Wl.lParam2)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[7].nDicePoint:=HiByte(HiWord(Wl.lParam2)); //UserHuman.m_DyVal[0]

        FrmDlg.m_Dice[8].nDicePoint:=LoByte(LoWord(Wl.lTag1)); //UserHuman.m_DyVal[0]
        FrmDlg.m_Dice[9].nDicePoint:=HiByte(LoWord(Wl.lTag1)); //UserHuman.m_DyVal[0]
        FrmDlg.DialogSize:=0;
        FrmDlg.DMessageDlg('',[]);
        SendMerchantDlgSelect(Msg.Recog,data);
      end;
      SM_NEEDPASSWORD: begin
        ClientGetNeedPassword(Body);
      end;
      SM_ADDFRIENDFAIL: begin
        ClientAddFriendFail(Body);
      end;
      SM_ADDFRIEND: begin
        ClientAddFriend(Body);
      end;
      SM_DELFRIEND: begin
        ClientDelFriend(Body);
      end;
      SM_MEMOFRIEND: begin
        ClientUpdateMemo(Body);
      end;
      SM_FRIENDSTATUS: begin
        ClientFriendStatus(Msg.Recog, DecodeString(Body));
      end;

      SM_MAILLIST: begin
        ClientMailList(Msg,Body);
      end;
      SM_MAILITEM: begin
        ClientMailItem(Msg,Body);
      end;
      SM_MAILSENT: begin
        ClientMailSent(Msg,Body);
      end;
      SM_MAILFAILED: begin
        ClientMailFailed(Msg,Body);
      end;
      SM_MAILSTATUS: begin
        ClientMailStatus(Msg,Body);
      end;
      SM_BLOCKLIST: begin
        ClientBlockList(Msg,Body);
      end;
      SM_BLOCKLISTITEM: begin
        ClientBlockListItem(Msg,Body);
      end;
      SM_BLOCKLISTFAIL: begin
        ClientBlockListFail(Msg,Body);
      end;
      SM_BLOCKLISTADDED: begin
        ClientBlockListAdded(Msg,Body);
      end;
      SM_BLOCKLISTDELETED: begin
        ClientBlockListDeleted(Msg,Body);
      end;
      SM_LOVERINFO: begin
        DecodeBuffer(body,@Lover,SizeOf(TLover));
        g_LoverName := Lover.Lover;
        g_StartDate := Lover.StartDate;
        g_TotalDays := Lover.TotalDays;
        FrmDlg.DLoverWindow.Visible := True;
      end;
      SM_LOVERSUCCESS: begin
        PlaySound(154); //Married success
      end;
      SM_REQUESTRELAY: begin
        if mrOk = FrmDlg.DMessageDlg (body + ' 邀请你结婚，一旦关系建立, \' +
                                           '离婚需要100,000金币作为费用。\' +
                                           '你需要结婚吗？', [mbOk, mbCancel]) then begin
          SendClientMessage(CM_REQUESTRELAYOK,0,0,0,0);
        end else begin
          SendClientMessage(CM_REQUESTRELAYFAIL,0,0,0,0, g_Myself.m_sUserName);
        end;
      end;
      SM_REQUESTRELAYFAIL: begin
        FrmDlg.DMessageDlg(body + ' 不接受了您的结婚请求！',[mbOK]);
      end;
      SM_GEMSYSTEMFAIL: begin
        FrmDlg.CancelGemMaking();
      end;
      SM_PASSWORDSTATUS: begin
        ClientGetPasswordStatus(@Msg,Body);
      end;
      SM_REPAIRITEMOK: begin
        g_boItemMoving := FALSE;
      end;
      SM_GETREGINFO: ClientGetRegInfo(@Msg,Body);
      else begin
        if g_MySelf = nil then exit;     //在未进入游戏时不处理下面

//            DScreen.AddSysMsg (IntToStr(msg.Ident) + ' : ' + body);
        PlayScene.MemoLog.Lines.Add('Ident: ' + IntToStr(msg.Ident));
        PlayScene.MemoLog.Lines.Add('Recog: ' + IntToStr(msg.Recog));
        PlayScene.MemoLog.Lines.Add('Param: ' + IntToStr(msg.Param));
        PlayScene.MemoLog.Lines.Add('Tag: ' + IntToStr(msg.Tag));
        PlayScene.MemoLog.Lines.Add('Series: ' + IntToStr(msg.Series));
      end;
   end;

   if Pos('#', datablock) > 0 then
      DScreen.AddSysMsg (datablock);
end;


procedure TfrmMain.ClientGetPasswdSuccess (body: string);
var
   str, runaddr, runport, uid, certifystr: string;
begin
   str := DecodeString (body);
   str := GetValidStr3 (str, runaddr, ['/']);
   str := GetValidStr3 (str, runport, ['/']);
   str := GetValidStr3 (str, certifystr, ['/']);
   Certification := Str_ToInt(certifystr, 0);

   if g_boForceAddr then begin
     runaddr := g_sSelectServerAddr;
     runport := inttostr(g_nSelectServerPort);
   end;

   if not BoOneClick then begin
      CSocket.Active:=False;
      CSocket.Host:='';
      CSocket.Port:=0;
      FrmDlg.DSelServerDlg.Visible := FALSE;
      WaitAndPass (500); //0.5秒
      g_ConnectionStep := cnsSelChr;
      with CSocket do begin
         g_sSelChrAddr := runaddr;
         g_nSelChrPort := Str_ToInt (runport, 0);
         Address := g_sSelChrAddr;
         Port := g_nSelChrPort;
         Active := TRUE;
      end;
   end else begin
      FrmDlg.DSelServerDlg.Visible := FALSE;
      g_sSelChrAddr := runaddr;
      g_nSelChrPort := Str_ToInt (runport, 0);
      if CSocket.Socket.Connected then
         CSocket.Socket.SendText ('$S' + runaddr + '/' + runport + '%');
      WaitAndPass (500); //0.5秒
      g_ConnectionStep := cnsSelChr;
      LoginScene.OpenLoginDoor;
      SelChrWaitTimer.Enabled := TRUE;
   end;
end;
procedure TfrmMain.ClientGetPasswordOK(Msg: TDefaultMessage;
  sBody: String);
var
  I: Integer;
  sServerName:String;
  sServerStatus:String;
  nCount:Integer;
begin
  sBody:=DeCodeString(sBody);
//  FrmDlg.DMessageDlg (sBody + '/' + IntToStr(Msg.Series), [mbOk]);
  nCount:=_MIN(8,msg.Series);
  g_ServerList.Clear;
  for I := 0 to nCount - 1 do begin
    sBody:=GetValidStr3(sBody,sServerName,['/']);
    sBody:=GetValidStr3(sBody,sServerStatus,['/']);
    g_ServerList.AddObject(sServerName,TObject(Str_ToInt(sServerStatus,0)));
  end;
  //if g_ServerList.Count = 0 then begin
//    g_ServerList.InsertObject(0,'龙之传奇',TObject(Str_ToInt(sServerStatus,0)));
//  end;
    


               g_wAvailIDDay := Loword(msg.Recog);
               g_wAvailIDHour := Hiword(msg.Recog);
               g_wAvailIPDay := msg.Param;
               g_wAvailIPHour := msg.Tag;

               if g_wAvailIDDay > 0 then begin
                  if g_wAvailIDDay = 1 then
                     FrmDlg.DMessageDlg ('您当前ID费用到今天为止。', [mbOk])
                  else if g_wAvailIDDay <= 3 then
                     FrmDlg.DMessageDlg ('您当前IP费用还剩: ' + IntToStr(g_wAvailIDDay) + ' 天。', [mbOk]);
               end else if g_wAvailIPDay > 0 then begin
                  if g_wAvailIPDay = 1 then
                     FrmDlg.DMessageDlg ('您当前IP费用到今天为止。', [mbOk])
                  else if g_wAvailIPDay <= 3 then
                     FrmDlg.DMessageDlg ('您当前IP费用还剩 ' + IntToStr(g_wAvailIPDay) + ' 天。', [mbOk]);
               end else if g_wAvailIPHour > 0 then begin
                  if g_wAvailIPHour <= 100 then
                     FrmDlg.DMessageDlg ('您当前IP费用还剩 ' + IntToStr(g_wAvailIPHour) + ' 小时。', [mbOk]);
               end else if g_wAvailIDHour > 0 then begin
                  FrmDlg.DMessageDlg ('您当前ID费用还剩 ' + IntToStr(g_wAvailIDHour) + ' 小时。', [mbOk]);;
               end;

               if not LoginScene.m_boUpdateAccountMode then
                  ClientGetSelectServer;
end;

procedure TfrmMain.ClientGetSelectServer;
var
  sname: string;
begin
  LoginScene.HideLoginBox;
  FrmDlg.ShowSelectServerDlg;
end;

procedure TfrmMain.ClientGetNeedUpdateAccount (body: string);
var
   ue: TUserEntry;
begin
   DecodeBuffer (body, @ue, sizeof(TUserEntry));
   LoginScene.UpdateAccountInfos (ue);
end;

procedure TfrmMain.ClientGetReceiveChrs (body: string);
var
   i, select: integer;
   str, uname, sjob, shair, slevel, ssex: string;
begin
   SelectChrScene.ClearChrs;
   str := DecodeString (body);
   for i:=0 to 2 do begin
      str := GetValidStr3 (str, uname, ['/']);
      str := GetValidStr3 (str, sjob, ['/']);
      str := GetValidStr3 (str, shair, ['/']);
      str := GetValidStr3 (str, slevel, ['/']);
      str := GetValidStr3 (str, ssex, ['/']);
      select := 0;
      if (uname <> '') and (slevel <> '') and (ssex <> '') then begin
         if uname[1] = '*' then begin
            select := i;
            uname := Copy (uname, 2, Length(uname)-1);
         end;
         SelectChrScene.AddChr (uname, Str_ToInt(sjob, 0), Str_ToInt(shair, 0), Str_ToInt(slevel, 0), Str_ToInt(ssex, 0));
      end;
      with SelectChrScene do begin
         if select = 0 then begin
            ChrArr[0].FreezeState := FALSE;
            ChrArr[0].Selected := TRUE;
            ChrArr[1].FreezeState := TRUE;
            ChrArr[1].Selected := FALSE;
            ChrArr[2].FreezeState := TRUE;
            ChrArr[2].Selected := FALSE;
         end
         else if select = 1 then begin
            ChrArr[0].FreezeState := TRUE;
            ChrArr[0].Selected := FALSE;
            ChrArr[1].FreezeState := FALSE;
            ChrArr[1].Selected := TRUE;
            ChrArr[2].FreezeState := TRUE;
            ChrArr[2].Selected := FALSE;
         end
         else begin
            ChrArr[0].FreezeState := TRUE;
            ChrArr[0].Selected := FALSE;
            ChrArr[1].FreezeState := TRUE;
            ChrArr[1].Selected := FALSE;
            ChrArr[2].FreezeState := FALSE;
            ChrArr[2].Selected := TRUE;
         end;
      end;
   end;
   PlayScene.EdAccountt.Text:=LoginId;
   //强行登录
   {
   if SelectChrScene.ChrArr[0].Valid and SelectChrScene.ChrArr[0].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[0].UserChr.Name;
   if SelectChrScene.ChrArr[1].Valid and SelectChrScene.ChrArr[1].Selected then PlayScene.EdChrNamet.Text := SelectChrScene.ChrArr[1].UserChr.Name;
   PlayScene.EdAccountt.Visible:=True;
   PlayScene.EdChrNamet.Visible:=True;
   }
end;

procedure TfrmMain.ClientGetStartPlay (body: string);
var
   str, addr, sport: string;
begin
   str := DecodeString (body);
   sport := GetValidStr3 (str, g_sRunServerAddr, ['/']);
   g_nRunServerPort:=Str_ToInt (sport, 0);

   if g_boForceAddr then begin
     g_sRunServerAddr := g_sGameServerAddr;
     g_nRunServerPort := g_nGameServerPort;
   end;

   if not BoOneClick then begin
      CSocket.Active := FALSE;
      CSocket.Host:='';
      CSocket.Port:=0;
      WaitAndPass (500); //0.5秒

      g_ConnectionStep := cnsPlay;
      with CSocket do begin
         Address := g_sRunServerAddr;
         Port := g_nRunServerPort;
         Active := TRUE;
      end;
   end else begin
      SocStr := '';
      BufferStr := '';
      if CSocket.Socket.Connected then
         CSocket.Socket.SendText ('$R' + addr + '/' + sport + '%');

      g_ConnectionStep := cnsPlay;
      ClearBag;
      ClearStore;
      DScreen.ClearChatBoard;
      //DScreen.ChangeScene (stLoading);
      //DScreen.ChangeScene (stLoginNotice);

      WaitAndPass (500); //0.5秒
      SendRunLogin;
   end;
end;

procedure TfrmMain.ClientGetReconnect (body: string);
var
   str, addr, sport: string;
begin
   str := DecodeString (body);
   sport := GetValidStr3 (str, addr, ['/']);

   if not BoOneClick then begin
      if g_boBagLoaded then
         Savebags ('.\Data\' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
      g_boBagLoaded := FALSE;

      if g_boStoreLoaded then
         SaveStores ('.\Data\' + g_sServerName + '.' + CharName + '.sto', @g_StoreItem);
      g_boStoreLoaded := FALSE;

      g_boServerChanging := TRUE;
      CSocket.Active := FALSE;
      CSocket.Host:='';
      CSocket.Port:=0;

      WaitAndPass (500); //0.5秒

      g_ConnectionStep := cnsPlay;
      with CSocket do begin
         Address := addr;
         Port := Str_ToInt (sport, 0);
         Active := TRUE;
      end;

   end else begin
      if g_boBagLoaded then
         Savebags ('.\Data\' + g_sServerName + '.' + CharName + '.itm', @g_ItemArr);
      g_boBagLoaded := FALSE;

      if g_boStoreLoaded then
         SaveStores ('.\Data\' + g_sServerName + '.' + CharName + '.sto', @g_StoreItem);
      g_boStoreLoaded := FALSE;

      SocStr := '';
      BufferStr := '';
      g_boServerChanging := TRUE;

      if CSocket.Socket.Connected then
         CSocket.Socket.SendText ('$C' + addr + '/' + sport + '%');

      WaitAndPass (500); //0.5秒
      if CSocket.Socket.Connected then
         CSocket.Socket.SendText ('$R' + addr + '/' + sport + '%');

      g_ConnectionStep := cnsPlay;
      ClearBag;
      ClearStore;
      DScreen.ClearChatBoard;
      //DScreen.ChangeScene (stLoading);
      //DScreen.ChangeScene (stLoginNotice);

      WaitAndPass (300); //0.5秒
      ChangeServerClearGameVariables;

      SendRunLogin;
   end;
end;

procedure TfrmMain.ClientGetMapDescription(Msg:TDefaultMessage;sBody:String);
var
  sTitle:String;
begin
  sBody:=DecodeString(sBody);
  sBody:=GetValidStr3(sBody, sTitle, [#13]);

  g_nMiniMapIndex := Msg.Param - 1;
  g_nMapIndex := Msg.Tag - 1;
  if ((g_nMiniMapIndex < 0) and g_boViewMiniMap)then
    DScreen.AddChatBoardString('没有小地图信息.', clWhite, clRed);
  if ((g_nMapIndex < 0) and g_boViewMap) then
    Dscreen.AddChatBoardString('没有大地图信息.', clWhite, clRed);

  g_sMapTitle:=sTitle;
  g_nMapMusic:=Msg.Recog;
  PlayMapMusic(True);
end;

procedure TfrmMain.ClientGetGameGoldName(Msg:TDefaultMessage;sBody: String);
var
  sData:String;
begin
  if sBody <> '' then begin
    sBody:=DecodeString(sBody);
    sBody:=GetValidStr3(sBody, sData, [#13]);
    g_sGameGoldName:=sData;
    g_sGamePointName:=sBody;
  end;
  g_MySelf.m_nGameGold:=Msg.Recog;
  g_MySelf.m_nGamePoint:=MakeLong(Msg.Param,Msg.Tag);
end;

{procedure TfrmMain.ClientGetAttatckMode(Msg:TDefaultMessage;sBody: String);
var
  sData:String;
begin
  if sBody <> '' then begin
    sBody:=DecodeString(sBody);
    sBody:=GetValidStr3(sBody, sData, [#13]);
    g_sGameGoldName:=sData;
    g_sGamePointName:=sBody;
  end;
  g_MySelf.m_btAttatckMode:=Msg.Recog;
  g_MySelf.m_nGamePoint:=MakeLong(Msg.Param,Msg.Tag);
end;}

procedure TfrmMain.ClientGetAdjustBonus (bonus: integer; body: string);
var
   str1, str2, str3: string;
begin
   g_nBonusPoint := bonus;
   body := GetValidStr3 (body, str1, ['/']);
   str3 := GetValidStr3 (body, str2, ['/']);
   DecodeBuffer (str1, @g_BonusTick, sizeof(TNakedAbility));
   DecodeBuffer (str2, @g_BonusAbil, sizeof(TNakedAbility));
   DecodeBuffer (str3, @g_NakedAbil, sizeof(TNakedAbility));
   FillChar (g_BonusAbilChg, sizeof(TNakedAbility), #0);
end;

procedure TfrmMain.ClientGetAttatckMode (mode: integer; body: string);
var
   str1, str2, str3: string;
begin
   g_nAttatckMode := mode;
   {body := GetValidStr3 (body, str1, ['/']);
   str3 := GetValidStr3 (body, str2, ['/']);
   DecodeBuffer (str1, @g_BonusTick, sizeof(TNakedAbility));
   DecodeBuffer (str2, @g_BonusAbil, sizeof(TNakedAbility));
   DecodeBuffer (str3, @g_NakedAbil, sizeof(TNakedAbility));
   FillChar (g_BonusAbilChg, sizeof(TNakedAbility), #0); }
end;

procedure TfrmMain.ClientGetAddItem (body: string);
var
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      AddItemBag (cu);
      DScreen.AddSysMsg (cu.S.Name + ' 被发现。');
   end;
end;

procedure TfrmMain.ClientGetAddStore (body: string);
var
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      AddItemStore (cu);
      DScreen.AddSysMsg (cu.S.Name + ' 已保存。');
   end;
end;

procedure TfrmMain.ClientGetUpdateItem (body: string);
var
   i: integer;
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      UpdateItemBag (cu);
      for i:=0 to 12 do begin
         if (g_UseItems[i].S.Name = cu.S.Name) and (g_UseItems[i].MakeIndex = cu.MakeIndex) then begin
            g_UseItems[i] := cu;
         end;
      end;
   end;
end;

procedure TfrmMain.ClientGetDelItem (body: string);
var
   i: integer;
   cu: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @cu, sizeof(TClientItem));
      DelItemBag (cu.S.Name, cu.MakeIndex);
      for i:=0 to 12 do begin
         if (g_UseItems[i].S.Name = cu.S.Name) and (g_UseItems[i].MakeIndex = cu.MakeIndex) then begin
            g_UseItems[i].S.Name := '';
         end;
      end;
   end;
end;

procedure TfrmMain.ClientGetDelItems (body: string);
var
   i, iindex: integer;
   str, iname: string;
   cu: TClientItem;
begin
   body := DecodeString (body);
   while body <> '' do begin
      body := GetValidStr3 (body, iname, ['/']);
      body := GetValidStr3 (body, str, ['/']);
      if (iname <> '') and (str <> '') then begin
         iindex := Str_ToInt(str, 0);
         DelItemBag (iname, iindex);
         for i:=0 to 12 do begin
            if (g_UseItems[i].S.Name = iname) and (g_UseItems[i].MakeIndex = iindex) then begin
               g_UseItems[i].S.Name := '';
            end;
         end;
      end else
         break;
   end;
end;

procedure TfrmMain.ClientGetBagItmes (body: string; boCheckPosition: boolean);
var
   str: string;
   cu: TClientItem;
   ItemSaveArr: array[0..MAXBAGITEMCL-1] of TClientItem;

   function CompareItemArr: Boolean;
   var
      i, j: integer;
      flag: Boolean;
   begin
      flag := TRUE;
      for i:=0 to MAXBAGITEMCL-1 do begin
         if ItemSaveArr[i].S.Name <> '' then begin
            flag := FALSE;
            for j:=0 to MAXBAGITEMCL-1 do begin
               if (g_ItemArr[j].S.Name = ItemSaveArr[i].S.Name) and
                  (g_ItemArr[j].MakeIndex = ItemSaveArr[i].MakeIndex) then begin
                  if (g_ItemArr[j].Dura = ItemSaveArr[i].Dura) and
                     (g_ItemArr[j].DuraMax = ItemSaveArr[i].DuraMax) then begin
                    if (g_ItemArr[j].Amount = ItemSaveArr[i].Amount) then begin
                      flag := TRUE;
                    end;
                   break;
                  end;
               end;
            end;
            if not flag then break;
         end;
      end;
      if flag then begin
         for i:=0 to MAXBAGITEMCL-1 do begin
            if g_ItemArr[i].S.Name <> '' then begin
               flag := FALSE;
               for j:=0 to MAXBAGITEMCL-1 do begin
                  if (g_ItemArr[i].S.Name = ItemSaveArr[j].S.Name) and
                     (g_ItemArr[i].MakeIndex = ItemSaveArr[j].MakeIndex) then begin
                     if (g_ItemArr[i].Dura = ItemSaveArr[j].Dura) and
                        (g_ItemArr[i].DuraMax = ItemSaveArr[j].DuraMax) then begin
                        if (g_ItemArr[i].Amount = ItemSaveArr[j].Amount) then begin
                          flag := TRUE;
                       end;
                       break;
                     end;
                  end;
               end;
               if not flag then break;
            end;
         end;
      end;
      Result := flag;
   end;
begin
   //ClearBag;
   FillChar (g_ItemArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TClientItem));
      AddItemBag (cu);
   end;
   if bocheckposition then begin
     FillChar (ItemSaveArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
     Loadbags ('.\Data\' + g_sServerName + '.' + CharName + '.itm', @ItemSaveArr);
     if CompareItemArr then begin
        Move (ItemSaveArr, g_ItemArr, sizeof(TClientItem) * MAXBAGITEMCL);
     end;

    ArrangeItembag;
    g_boBagLoaded := TRUE;
   end;
end;

procedure TfrmMain.ClientGetBagItems2 (body: string);
var
  str: string;
  cu: TClientItem;
  ItemSaveArr: array[0..MAXBAGITEMCL-1] of TClientItem;
  function CompareItemArr: Boolean;
   var
      i, j: integer;
      flag: Boolean;
   begin
      flag := TRUE;
      for i:=0 to MAXBAGITEMCL-1 do begin
         if ItemSaveArr[i].S.Name <> '' then begin
            flag := FALSE;
            for j:=0 to MAXBAGITEMCL-1 do begin
               if (g_ItemArr[j].S.Name = ItemSaveArr[i].S.Name) and
                  (g_ItemArr[j].MakeIndex = ItemSaveArr[i].MakeIndex) then begin
                  if (g_ItemArr[j].Dura = ItemSaveArr[i].Dura) and
                     (g_ItemArr[j].DuraMax = ItemSaveArr[i].DuraMax) then begin
                    if (g_ItemArr[j].Amount = ItemSaveArr[i].Amount) then begin
                      flag := TRUE;
                    end;
                   break;
                  end;
               end;
            end;
            if not flag then break;
         end;
      end;
      if flag then begin
         for i:=0 to MAXBAGITEMCL-1 do begin
            if g_ItemArr[i].S.Name <> '' then begin
               flag := FALSE;
               for j:=0 to MAXBAGITEMCL-1 do begin
                  if (g_ItemArr[i].S.Name = ItemSaveArr[j].S.Name) and
                     (g_ItemArr[i].MakeIndex = ItemSaveArr[j].MakeIndex) then begin
                     if (g_ItemArr[i].Dura = ItemSaveArr[j].Dura) and
                        (g_ItemArr[i].DuraMax = ItemSaveArr[j].DuraMax) then begin
                        if (g_ItemArr[j].Amount = ItemSaveArr[i].Amount) then begin
                          flag := TRUE;
                       end;
                       break;
                     end;
                  end;
               end;
               if not flag then break;
            end;
         end;
      end;
      Result := flag;
   end;
begin
  while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TClientItem));
      AddItemBag (cu);
   end;
   FillChar (ItemSaveArr, sizeof(TClientItem)*MAXBAGITEMCL, #0);
   Loadbags ('.\Data\' + g_sServerName + '.' + CharName + '.itm', @ItemSaveArr);
   if CompareItemArr then begin
      Move (ItemSaveArr, g_ItemArr, sizeof(TClientItem) * MAXBAGITEMCL);
   end;

   ArrangeItembag;
   g_boBagLoaded := TRUE;
end;

procedure TfrmMain.ClientGetStoreItems (body: string; boCheckPosition: boolean);
var
  str: string;
  cu: TClientItem;
  ItemSaveStore: array[0..MAXSTORAGEITEMCL-1] of TClientItem;
  function CompareItemStore: Boolean;
   var
      i, j: integer;
      flag: Boolean;
   begin
      flag := TRUE;
      for i:=0 to MAXSTORAGEITEMCL-1 do begin
         if ItemSaveStore[i].S.Name <> '' then begin
            flag := FALSE;
            for j:=0 to MAXSTORAGEITEMCL-1 do begin
               if (g_StoreItem[j].S.Name = ItemSaveStore[i].S.Name) and
                  (g_StoreItem[j].MakeIndex = ItemSaveStore[i].MakeIndex) then begin
                  if (g_StoreItem[j].Dura = ItemSaveStore[i].Dura) and
                     (g_StoreItem[j].DuraMax = ItemSaveStore[i].DuraMax) then begin
                    if (g_StoreItem[j].Amount = ItemSaveStore[i].Amount) then begin
                      flag := TRUE;
                    end;
                   break;
                  end;
               end;
            end;
            if not flag then break;
         end;
      end;
      if flag then begin
         for i:=0 to MAXSTORAGEITEMCL-1 do begin
            if g_StoreItem[i].S.Name <> '' then begin
               flag := FALSE;
               for j:=0 to MAXSTORAGEITEMCL-1 do begin
                  if (g_StoreItem[i].S.Name = ItemSaveStore[j].S.Name) and
                     (g_StoreItem[i].MakeIndex = ItemSaveStore[j].MakeIndex) then begin
                     if (g_StoreItem[i].Dura = ItemSaveStore[j].Dura) and
                        (g_StoreItem[i].DuraMax = ItemSaveStore[j].DuraMax) then begin
                        if (g_StoreItem[j].Amount = ItemSaveStore[i].Amount) then begin
                          flag := TRUE;
                       end;
                       break;
                     end;
                  end;
               end;
               if not flag then break;
            end;
         end;
      end;
      Result := flag;
   end;
begin
  while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TClientItem));
      AddItemStore (cu);
   end;
   if bocheckposition then begin
   FillChar (ItemSaveStore, sizeof(TClientItem)*MAXSTORAGEITEMCL, #0);
   LoadStores ('.\Data\' + g_sServerName + '.' + CharName + '.sto', @ItemSaveStore);
   if CompareItemStore then begin
      Move (ItemSaveStore, g_StoreItem, sizeof(TClientItem) * MAXSTORAGEITEMCL);
   end;
   ArrangeItemStore;
   g_boStoreLoaded := TRUE;
   end;
end;

procedure TfrmMain.ClientGetStoreItems2  (body: string);
var
  str: string;
  cu: TClientItem;
  ItemSaveStore: array[0..MAXSTORAGEITEMCL-1] of TClientItem;
  function CompareItemStore: Boolean;
   var
      i, j: integer;
      flag: Boolean;
   begin
      flag := TRUE;
      for i:=0 to MAXSTORAGEITEMCL-1 do begin
         if ItemSaveStore[i].S.Name <> '' then begin
            flag := FALSE;
            for j:=0 to MAXSTORAGEITEMCL-1 do begin
               if (g_StoreItem[j].S.Name = ItemSaveStore[i].S.Name) and
                  (g_StoreItem[j].MakeIndex = ItemSaveStore[i].MakeIndex) then begin
                  if (g_StoreItem[j].Dura = ItemSaveStore[i].Dura) and
                     (g_StoreItem[j].DuraMax = ItemSaveStore[i].DuraMax) then begin
                    if (g_StoreItem[j].Amount = ItemSaveStore[i].Amount) then begin
                      flag := TRUE;
                    end;
                   break;
                  end;
               end;
            end;
            if not flag then break;
         end;
      end;
      if flag then begin
         for i:=0 to MAXSTORAGEITEMCL-1 do begin
            if g_StoreItem[i].S.Name <> '' then begin
               flag := FALSE;
               for j:=0 to MAXSTORAGEITEMCL-1 do begin
                  if (g_StoreItem[i].S.Name = ItemSaveStore[j].S.Name) and
                     (g_StoreItem[i].MakeIndex = ItemSaveStore[j].MakeIndex) then begin
                     if (g_StoreItem[i].Dura = ItemSaveStore[j].Dura) and
                        (g_StoreItem[i].DuraMax = ItemSaveStore[j].DuraMax) then begin
                        if (g_StoreItem[j].Amount = ItemSaveStore[i].Amount) then begin
                          flag := TRUE;
                       end;
                       break;
                     end;
                  end;
               end;
               if not flag then break;
            end;
         end;
      end;
      Result := flag;
   end;
begin
  while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TClientItem));
      AddItemStore (cu);
   end;
   FillChar (ItemSaveStore, sizeof(TClientItem)*MAXSTORAGEITEMCL, #0);
   LoadStores ('.\Data\' + g_sServerName + '.' + CharName + '.sto', @ItemSaveStore);
   if CompareItemStore then begin
      Move (ItemSaveStore, g_StoreItem, sizeof(TClientItem) * MAXSTORAGEITEMCL);
   end;

   ArrangeItemStore;
   g_boStoreLoaded := TRUE;
end;

procedure TfrmMain.ClientAuctionItems (body: string);
var
   str: string;
   cu: TAuctionItem;
   i: integer;
begin
  i:= 0;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TAuctionItem));
      g_AuctionItems[i] := cu;
      inc(i);
   end;
   if FrmDlg.DSales.Visible = false then
     FrmDlg.ToggleAuctionWindow;
end;

procedure TfrmMain.ClientGameShopList (body: string);
var
   str: string;
   cu: TItemShopItem;
   i: integer;
begin
  i:= 0;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TItemShopItem));
      g_ItemShopItems[i] := cu;
      inc(i);
   end;
   //if FrmDlg.DDecoListDlg.Visible = false then
   //  FrmDlg.ToggleDecoListWindow;
end;

procedure TfrmMain.ClientGTList (body: string);
var
   str: string;
   cu: TClientGT;
   i: integer;
begin
  i:= 0;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TClientGT));

      g_GTItems[i] := cu;
      inc(i);
   end;
   if FrmDlg.DGTList.Visible = false then
     FrmDlg.ToggleGTListWindow;
end;

procedure TfrmMain.ClientDecoList (body: string);
var
   str: string;
   cu: TDecoItem;
   i: integer;
begin
  i:= 0;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TDecoItem));
      g_DecoItems[i] := cu;
      inc(i);
   end;
   if FrmDlg.DDecoListDlg.Visible = false then
     FrmDlg.ToggleDecoListWindow;
end;

procedure TfrmMain.ClientBBSList (body: string);
var
   str: string;
   cu: TBBSMSG;
   i: integer;
begin
  i:= 0;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      DecodeBuffer (str, @cu, sizeof(TBBSMSG));
      g_BBSMsgList[i] := cu;
      inc(i);
   end;
   if FrmDlg.DBBSListDlg.Visible = false then
     FrmDlg.ToggleBBSListWindow;
end;

procedure TfrmMain.ClientBBSMsg (body: string);
var
   str: string;
   cu: TBBSMSG;
   i: integer;
begin
  if (body = '') then exit;
  body := GetValidStr3 (body, str, ['/']);
  if (str = '') then exit;
  g_BBSPoster := DecodeString(str);
  body := GetValidStr3 (body, str, ['/']);
  if (str = '') then exit;
  g_BBSMSG := DecodeString(str);
  FrmDlg.ToggleBBSMsgWindow;
end;

procedure TfrmMain.ClientGetDropItemFail (iname: string; sindex: integer);
var
   pc: PTClientItem;
begin
   pc := GetDropItem (iname, sindex);
   if pc <> nil then begin
      AddItemBag (pc^);
      DelDropItem (iname, sindex);
   end;
end;

procedure TfrmMain.ClientGetShowItem (itemid, x, y, looks: integer; itmname: string);
var
  I:Integer;
  DropItem:PTDropItem;
begin
  for i:=0 to g_DropedItemList.Count-1 do begin
    if PTDropItem(g_DropedItemList[i]).Id = itemid then
      exit;
  end;
  New(DropItem);
  DropItem.Id := itemid;
  DropItem.X := x;
  DropItem.Y := y;
  DropItem.Looks := looks;
  DropItem.Name := itmname;
  DropItem.FlashTime := GetTickCount - LongWord(Random(3000));
  DropItem.BoFlash := FALSE;
  g_DropedItemList.Add(DropItem);
end;

procedure TfrmMain.ClientGetHideItem (itemid, x, y: integer);
var
  I:Integer;
  DropItem:PTDropItem;
begin
  for I:=0 to g_DropedItemList.Count - 1 do begin
    DropItem:=g_DropedItemList[I];
    if DropItem.Id = itemid then begin
      Dispose (DropItem);
      g_DropedItemList.Delete(I);
      break;
    end;
  end;
end;

procedure TfrmMain.ClientGetSendAddUseItems (body: string);
var
   index: integer;
   str, data: string;
   cu: TClientItem;
begin
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      body := GetValidStr3 (body, data, ['/']);
      index := Str_ToInt (str, -1);
      if index in [9..12] then begin
         DecodeBuffer (data, @cu, sizeof(TClientItem));
         g_UseItems[index] := cu;
      end;
   end;
end;
procedure TfrmMain.ClientGetSenduseItems (body: string);
var
   index: integer;
   str, data: string;
   cu: TClientItem;
begin
   FillChar (g_UseItems, sizeof(TClientItem)*13, #0);
//   FillChar (UseItems, sizeof(TClientItem)*9, #0);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, str, ['/']);
      body := GetValidStr3 (body, data, ['/']);
      index := Str_ToInt (str, -1);
      if index in [0..12] then begin
         DecodeBuffer (data, @cu, sizeof(TClientItem));
         g_UseItems[index] := cu;
      end;
   end;
end;

procedure TfrmMain.ClientGetAddMagic (body: string);
var
   pcm: PTClientMagic;
begin
   new (pcm);
   DecodeBuffer (body, @(pcm^), sizeof(TClientMagic));
   g_MagicList.Add (pcm);
end;

procedure TfrmMain.ClientGetDelMagic (magid: integer);
var
   i: integer;
begin
   for i:=g_MagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_MagicList[i]).Def.wMagicId = magid then begin
         Dispose (PTClientMagic(g_MagicList[i]));
         g_MagicList.Delete (i);
         break;
      end;
   end;
end;

procedure TfrmMain.ClientGetMyMagics (body: string);
var
   i: integer;
   data: string;
   pcm: PTClientMagic;
begin
   for i:=0 to g_MagicList.Count-1 do
      Dispose (PTClientMagic (g_MagicList[i]));
   g_MagicList.Clear;
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, ['/']);
      if data <> '' then begin
         new (pcm);
         DecodeBuffer (data, @(pcm^), sizeof(TClientMagic));
         g_MagicList.Add (pcm);
//    PlayScene.MemoLog.Lines.Add(pcm.Def.sMagicName + IntToStr(MagicList.Count));
      end else
         break;
   end;
end;

procedure TfrmMain.ClientGetMagicLvExp (magid, maglv, magtrain: integer);
var
   i: integer;
begin
   for i:=g_MagicList.Count-1 downto 0 do begin
      if PTClientMagic(g_MagicList[i]).Def.wMagicId = magid then begin
         PTClientMagic(g_MagicList[i]).Level := maglv;
         PTClientMagic(g_MagicList[i]).CurTrain := magtrain;
         break;
      end;
   end;
end;

procedure TfrmMain.ClientGetDuraChange (uidx, newdura, newduramax: integer);
begin
   if uidx in [0..12] then begin
      if g_UseItems[uidx].S.Name <> '' then begin
        if newdura < 0 then begin
          g_UseItems[uidx].Dura :=0;
        end else
         g_UseItems[uidx].Dura := newdura;
        g_UseItems[uidx].DuraMax := newduramax;
      end;
   end;
end;

procedure TfrmMain.ClientGetMerchantSay (merchant, face: integer; saying: string);
var
   npcname: string;
begin
   g_nMDlgX := g_MySelf.m_nCurrX;
   g_nMDlgY := g_MySelf.m_nCurrY;
   if g_nCurMerchant <> merchant then begin
      g_nCurMerchant := merchant;
      FrmDlg.ResetMenuDlg;
      FrmDlg.CloseMDlg;
   end;
//   ShowMessage(saying);
   saying := GetValidStr3 (saying, npcname, ['/']);
   FrmDlg.ShowMDlg (face, npcname, saying);
end;

procedure TfrmMain.ClientGetSendGoodsList (merchant, count: integer; body: string);
var
   i: integer;
   data, gname, gsub, gprice, gstock, glooks: string;
   pcg: PTClientGoods;
begin
   FrmDlg.ResetMenuDlg;
   g_nCurMerchant := merchant;
   with FrmDlg do begin
      //deocde body received from server
      body := DecodeString (body);
      if body[1] = '~' then begin
      body:=copy(body,2,length(body));
      FrmDlg.BoMakeGem := True;
      end else begin
       FrmDlg.BoMakeGem := False;
      end;
      while body <> '' do begin
         body := GetValidStr3 (body, gname, ['/']);
         body := GetValidStr3 (body, gsub, ['/']);
         body := GetValidStr3 (body, gprice, ['/']);
         body := GetValidStr3 (body, gstock, ['/']);
         body := GetValidStr3 (body, glooks, ['/']);
         if (gname <> '') and (gprice <> '') and (gstock <> '') then begin
            new (pcg);
            pcg.Name := gname;
            pcg.SubMenu := Str_ToInt (gsub, 0);
            pcg.Price := Str_ToInt (gprice, 0);
            pcg.Stock := Str_ToInt (gstock, 0);
            pcg.Looks := Str_ToInt (glooks, 0);
            pcg.Grade := -1;
            MenuList.Add (pcg);
         end else
            break;
      end;
      FrmDlg.ShowNewShopMenuDlg;
      FrmDlg.CurDetailItem := '';
   end;
end;

procedure TfrmMain.ClientGetSendGameShopList (merchant, count: integer; body: string);
var
   i: integer;
   data, gname, gprice, glooks: string;
   pisi: pTItemShopItem;
begin
   FrmDlg.ResetMenuDlg;
   g_nCurMerchant := merchant;
   with FrmDlg do begin
      body := DecodeString (body);
      while body <> '' do begin
         body := GetValidStr3 (body, gname, ['/']);
         body := GetValidStr3 (body, gprice, ['/']);
         body := GetValidStr3 (body, glooks, ['/']);
         if (gname <> '') and (gprice <> '') then begin
            new (pisi);
            pisi.Name := gname;
            pisi.Price := Str_ToInt (gprice, 0);
            pisi.Looks := Str_ToInt (glooks, 0);
            MenuList.Add (pisi);
         end else
            break;
      end;
//      FrmDlg.ShowNewShopMenuDlg;
//      FrmDlg.CurDetailItem := '';
   end;
end;

procedure TfrmMain.ClientGetSendMakeDrugList (merchant: integer; body: string);
var
   i: integer;
   data, gname, gsub, gprice, gstock: string;
   pcg: PTClientGoods;
begin
   FrmDlg.ResetMenuDlg;
   g_nCurMerchant := merchant;
   with FrmDlg do begin
      //clear shop menu list
      //deocde body received from server
      body := DecodeString (body);
      while body <> '' do begin
         body := GetValidStr3 (body, gname, ['/']);
         body := GetValidStr3 (body, gsub, ['/']);
         body := GetValidStr3 (body, gprice, ['/']);
         body := GetValidStr3 (body, gstock, ['/']);
         if (gname <> '') and (gprice <> '') and (gstock <> '') then begin
            new (pcg);
            pcg.Name := gname;
            pcg.SubMenu := Str_ToInt (gsub, 0);
            pcg.Price := Str_ToInt (gprice, 0);
            pcg.Stock := Str_ToInt (gstock, 0);
            pcg.Grade := -1;
            MenuList.Add (pcg);
         end else
            break;
      end;
      FrmDlg.ShowShopMenuDlg;
      FrmDlg.CurDetailItem := '';
      FrmDlg.BoMakeDrugMenu := TRUE;
   end;
end;

procedure TfrmMain.ClientGetSendUserSell (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmSell;
   FrmDlg.ShowShopSellDlg;
end;

procedure TfrmMain.ClientGetSendUserRepair (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmRepair;
   FrmDlg.ShowShopSellDlg;
end;
//保存物品到仓库
procedure TfrmMain.ClientGetSendUserStorage (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmStorage;
   FrmDlg.ShowStoreDlg;
//   FrmDlg.ShowShopSellDlg;
end;
//从仓库取回物品
procedure TfrmMain.ClientGetSendUserConsign (merchant: integer);
begin
   FrmDlg.CloseDSellDlg;
   g_nCurMerchant := merchant;
   FrmDlg.SpotDlgMode := dmConsign;
   FrmDlg.ShowShopSellDlg;
end;

procedure TfrmMain.ClientGetRegInfo(Msg: pTDefaultMessage; Body: String);
begin
  DecodeBuffer(Body,@g_RegInfo,SizeOf(TRegInfo));
end;

procedure TfrmMain.ClientGetSaveItemList (merchant: integer; bodystr: string);
var
   i: integer;
   data: string;
   pc: PTClientItem;
   pcg: PTClientGoods;
begin
   FrmDlg.ResetMenuDlg;

   for i:=0 to g_SaveItemList.Count-1 do
      Dispose(PTClientItem(g_SaveItemList[i]));
   g_SaveItemList.Clear;

   while TRUE do begin
      if bodystr = '' then break;
      bodystr := GetValidStr3 (bodystr, data, ['/']);
      if data <> '' then begin
         new (pc);
         DecodeBuffer (data, @(pc^), sizeof(TClientItem));
         g_SaveItemList.Add (pc);
      end else
         break;
   end;

   g_nCurMerchant := merchant;
   with FrmDlg do begin
      //deocde body received from server
      for i:=0 to g_SaveItemList.Count-1 do begin
         new (pcg);
         pcg.Name := PTClientItem(g_SaveItemList[i]).S.Name;
         pcg.SubMenu := 0;
         pcg.Price := PTClientItem(g_SaveItemList[i]).MakeIndex;
         pcg.Stock := Round(PTClientItem(g_SaveItemList[i]).Dura / 1000);
         pcg.Grade := Round(PTClientItem(g_SaveItemList[i]).DuraMax / 1000);
         //pcg.Looks := PTClientItem(g_SaveItemList[i]).S.Looks;
         MenuList.Add (pcg);
      end;
      //FrmDlg.ShowShopMenuDlg;
      FrmDlg.BoStorageMenu := TRUE;
   end;
end;

procedure TfrmMain.ClientGetSendDetailGoodsList (merchant, count, topline: integer; bodystr: string);
var
   i: integer;
   body, data, gname, gprice, gstock, ggrade, glooks: string;
   pcg: PTClientGoods;
   pc: PTClientItem;
begin
   FrmDlg.ResetMenuDlg;

   g_nCurMerchant := merchant;

   bodystr := DecodeString(bodystr);
   while TRUE do begin
      if bodystr = '' then break;
      bodystr := GetValidStr3 (bodystr, data, ['/']);
      if data <> '' then begin
         new (pc);
         DecodeBuffer (data, @(pc^), sizeof(TClientItem));
         g_MenuItemList.Add (pc);
      end else
         break;
   end;

   with FrmDlg do begin
      //clear shop menu list
      for i:=0 to g_MenuItemList.Count-1 do begin
         new (pcg);
         pcg.Name := PTClientItem(g_MenuItemList[i]).S.Name;
         pcg.SubMenu := 0;
         pcg.Price := PTClientItem(g_MenuItemList[i]).DuraMax;
         pcg.Stock := PTClientItem(g_MenuItemList[i]).MakeIndex;
         pcg.Grade := Round(PTClientItem(g_MenuItemList[i]).Dura/1000);
         pcg.Looks := PTClientItem(g_MenuItemList[i]).s.Looks;
         MenuList.Add (pcg);
      end;
      FrmDlg.ShowNewShopMenuDlg;
      FrmDlg.BoDetailMenu := TRUE;
      FrmDlg.MenuTopLine := topline;
   end;
end;

procedure TfrmMain.ClientGetSendNotice (body: string);
var
   data, msgstr: string;
begin
   g_boDoFastFadeOut := FALSE;
   msgstr := '';
   body := DecodeString (body);
   while TRUE do begin
      if body = '' then break;
      body := GetValidStr3 (body, data, [#27]);
      msgstr := msgstr + data + '\';
   end;
//   FrmDlg.DialogSize := 2;
//   if FrmDlg.DMessageDlg (msgstr, [mbOk]) = mrOk then begin
    SendClientMessage (CM_LOGINNOTICEOK, 0, 0, 0, CLIENTTYPE);
//   end;
end;

procedure TfrmMain.ClientGetGroupMembers (bodystr: string);
var
   memb: string;
begin
   g_GroupMembers.Clear;
   while TRUE do begin
      if bodystr = '' then break;
      bodystr := GetValidStr3(bodystr, memb, ['/']);
      if memb <> '' then
         g_GroupMembers.Add (memb)
      else
         break;
   end;
end;

procedure TfrmMain.ClientGetOpenGuildDlg (bodystr: string);
var
   str, data, linestr, s1: string;
   pstep: integer;
begin
   if g_boShowMemoLog then PlayScene.MemoLog.Lines.Add('ClientGetOpenGuildDlg');
     
   str := DecodeString (bodystr);
   str := GetValidStr3 (str, FrmDlg.Guild, [#13]);
   str := GetValidStr3 (str, FrmDlg.GuildFlag, [#13]);
   str := GetValidStr3 (str, data, [#13]);
   if data = '1' then FrmDlg.GuildCommanderMode := TRUE
   else FrmDlg.GuildCommanderMode := FALSE;

   FrmDlg.GuildStrs.Clear;
   FrmDlg.GuildNotice.Clear;
   pstep := 0;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, [#13]);
      if data = '<Notice>' then begin
         FrmDlg.GuildStrs.AddObject (char(7) + '公告', TObject(clWhite));
         FrmDlg.GuildStrs.Add (' ');
         pstep := 1;
         continue;
      end;
      if data = '<KillGuilds>' then begin
         FrmDlg.GuildStrs.Add (' ');
         FrmDlg.GuildStrs.AddObject (char(7) + '敌对公会', TObject(clWhite));
         FrmDlg.GuildStrs.Add (' ');
         pstep := 2;
         linestr := '';
         continue;
      end;
      if data = '<AllyGuilds>' then begin
         if linestr <> '' then FrmDlg.GuildStrs.Add (linestr);
         linestr := '';
         FrmDlg.GuildStrs.Add (' ');
         FrmDlg.GuildStrs.AddObject (char(7) + '联盟公会', TObject(clWhite));
         FrmDlg.GuildStrs.Add (' ');
         pstep := 3;
         continue;
      end;

      if pstep = 1 then
         FrmDlg.GuildNotice.Add (data);

      if data <> '' then begin
         if data[1] = '<' then begin
            ArrestStringEx (data, '<', '>', s1);
            if s1 <> '' then begin
               FrmDlg.GuildStrs.Add (' ');
               FrmDlg.GuildStrs.AddObject (char(7) + s1, TObject(clWhite));
               FrmDlg.GuildStrs.Add (' ');
               continue;
            end;
         end;
      end;
      if (pstep = 2) or (pstep = 3) then begin
         if Length(linestr) > 80 then begin
            FrmDlg.GuildStrs.Add (linestr);
            linestr := '';
         end else
            linestr := linestr + fmstr (data, 18);
         continue;
      end;

      FrmDlg.GuildStrs.Add (data);
   end;

   if linestr <> '' then FrmDlg.GuildStrs.Add (linestr);

   FrmDlg.ShowGuildDlg;
end;

procedure TfrmMain.ClientGetSendGuildMemberList (body: string);
var
   str, data, rankname, members: string;
   rank: integer;
begin
   str := DecodeString (body);
   FrmDlg.GuildStrs.Clear;
   FrmDlg.GuildMembers.Clear;
   rank := 0;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, ['/']);
      if data <> '' then begin
         if data[1] = '#' then begin
            rank := Str_ToInt (Copy(data, 2, Length(data)-1), 0);
            continue;
         end;
         if data[1] = '*' then begin
            if members <> '' then FrmDlg.GuildStrs.Add (members);
            rankname := Copy(data, 2, Length(data)-1);
            members := '';
            FrmDlg.GuildStrs.Add (' ');
            if FrmDlg.GuildCommanderMode then
               FrmDlg.GuildStrs.AddObject (fmStr('(' + IntToStr(rank) + ')', 3) + '<' + rankname + '>', TObject(clWhite))
            else
               FrmDlg.GuildStrs.AddObject ('<' + rankname + '>', TObject(clWhite));
            FrmDlg.GuildMembers.Add ('#' + IntToStr(rank) + ' <' + rankname + '>');
            continue;
         end;
         if Length (members) > 80 then begin
            FrmDlg.GuildStrs.Add (members);
            members := '';
         end;
         members := members + FmStr(data, 18);
         FrmDlg.GuildMembers.Add (data);
      end;
   end;
   if members <> '' then
      FrmDlg.GuildStrs.Add (members);
end;

procedure TfrmMain.MinTimerTimer(Sender: TObject);
var
   i: integer;
   timertime: longword;
begin
  //邮件按钮
  if FrmDlg.DBottom.Visible and (g_MySelf <> nil) then begin
    if g_boHasMail then begin
      if FrmDlg.DBotMemo.FaceIndex = 532 then FrmDlg.DBotMemo.SetImgIndex (g_WMainImages,533)
      else FrmDlg.DBotMemo.SetImgIndex (g_WMainImages,532);
    end
    else begin
      FrmDlg.DBotMemo.SetImgIndex (g_WMainImages,532);
    end;
  end;

   // I Haxed MinTimer to be 500 not 1000 so this makes it function as before
   // g_boIsMinTimerTime starts off as false, and is alternated every time this
   // timer fires (see end of proc).
   // Every 1000 (2 fires of this 500 proc) g_boIsMinTimerTime will be true.
   // This saved me adding another timer when one already exists that constantly
   // runs
   if g_boIsMinTimerTime then begin
     with PlayScene do
        for i:=0 to m_ActorList.Count-1 do begin
           if IsGroupMember (TActor (m_ActorList[i]).m_sUserName) then begin
              TActor (m_ActorList[i]).m_boGrouped := TRUE;
           end else
              TActor (m_ActorList[i]).m_boGrouped := FALSE;
        end;
     for i:=g_FreeActorList.Count-1 downto 0 do begin
        if GetTickCount - TActor(g_FreeActorList[i]).m_dwDeleteTime > 60000 then begin
           TActor(g_FreeActorList[i]).Free;
           g_FreeActorList.Delete (i);
        end;
     end;
   end;

   g_boIsMinTimerTime := Not g_boIsMinTimerTime;
end;

procedure TfrmMain.CheckHackTimerTimer(Sender: TObject);
const
   busy: boolean = FALSE;
var
   ahour, amin, asec, amsec: word;
   tcount, timertime: longword;
begin
(*   if busy then exit;
   busy := TRUE;
   DecodeTime (Time, ahour, amin, asec, amsec);
   timertime := amin * 1000 * 60 + asec * 1000 + amsec;
   tcount := GetTickCount;

   if BoCheckSpeedHackDisplay then begin
      DScreen.AddSysMsg (IntToStr(tcount - LatestClientTime2) + ' ' +
                         IntToStr(timertime - LatestClientTimerTime) + ' ' +
                         IntToStr(abs(tcount - LatestClientTime2) - abs(timertime - LatestClientTimerTime)));
                         // + ',  ' +
                         //IntToStr(tcount - FirstClientGetTime) + ' ' +
                         //IntToStr(timertime - FirstClientTimerTime) + ' ' +
                         //IntToStr(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)));
   end;

   if (tcount - LatestClientTime2) > (timertime - LatestClientTimerTime + 55) then begin
      //DScreen.AddSysMsg ('**' + IntToStr(tcount - LatestClientTime2) + ' ' + IntToStr(timertime - LatestClientTimerTime));
      Inc (TimeFakeDetectTimer);
      if TimeFakeDetectTimer > 3 then begin

         SendSpeedHackUser;
         FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                             '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                             '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                             '[巩狼] mir2master@wemade.com\' +
                             '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
//         FrmMain.Close;
         frmSelMain.Close;
      end;
   end else
      TimeFakeDetectTimer := 0;


   if FirstClientTimerTime = 0 then begin
      FirstClientTimerTime := timertime;
      FirstClientGetTime := tcount;
   end else begin
      if (abs(timertime - LatestClientTimerTime) > 500) or
         (timertime < LatestClientTimerTime)
      then begin
         FirstClientTimerTime := timertime;
         FirstClientGetTime := tcount;
      end;
      if abs(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)) > 5000 then begin
         Inc (TimeFakeDetectSum);
         if TimeFakeDetectSum > 25 then begin

            SendSpeedHackUser;
            FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                                '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                                '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                                '[巩狼] mir2master@wemade.com\' +
                                '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
//            FrmMain.Close;
            frmSelMain.Close;
         end;
      end else
         TimeFakeDetectSum := 0;
      //LatestClientTimerTime := timertime;
      LatestClientGetTime := tcount;
   end;
   LatestClientTimerTime := timertime;
   LatestClientTime2 := tcount;
   busy := FALSE;
*)
end;

(**
const
   busy: boolean = FALSE;
var
   ahour, amin, asec, amsec: word;
   timertime, tcount: longword;
begin
   if busy then exit;
   busy := TRUE;
   DecodeTime (Time, ahour, amin, asec, amsec);
   timertime := amin * 1000 * 60 + asec * 1000 + amsec;
   tcount := GetTickCount;

   //DScreen.AddSysMsg (IntToStr(tcount - FirstClientGetTime) + ' ' +
   //                   IntToStr(timertime - FirstClientTimerTime) + ' ' +
   //                   IntToStr(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)));

   if FirstClientTimerTime = 0 then begin
      FirstClientTimerTime := timertime;
      FirstClientGetTime := tcount;
   end else begin
      if (abs(timertime - LatestClientTimerTime) > 2000) or
         (timertime < LatestClientGetTime)
      then begin
         FirstClientTimerTime := timertime;
         FirstClientGetTime := tcount;
      end;
      if abs(abs(tcount - FirstClientGetTime) - abs(timertime - FirstClientTimerTime)) > 2000 then begin
         Inc (TimeFakeDetectSum);
         if TimeFakeDetectSum > 10 then begin
            //矫埃 炼累...
            SendSpeedHackUser;
            FrmDlg.DMessageDlg ('秦欧 橇肺弊伐 荤侩磊肺 扁废 登菌嚼聪促.\' +
                                '捞矾茄 辆幅狼 橇肺弊伐阑 荤侩窍绰 巴篮 阂过捞哥,\' +
                                '拌沥 拘幅殿狼 力犁 炼摹啊 啊秦龙 荐 乐澜阑 舅妨靛赋聪促.\' +
                                '[巩狼] mir2master@wemade.com\' +
                                '橇肺弊伐阑 辆丰钦聪促.', [mbOk]);
//            FrmMain.Close;
            frmSelMain.Close;
         end;
      end else
         TimeFakeDetectSum := 0;
      LatestClientTimerTime := timertime;
      LatestClientGetTime := tcount;
   end;
   busy := FALSE;
end;
//**)

procedure TfrmMain.ClientGetDealRemoteAddItem (body: string);
var
   ci: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @ci, sizeof(TClientItem));
      AddDealRemoteItem (ci);
   end;
end;

procedure TfrmMain.ClientGetDealRemoteDelItem (body: string);
var
   ci: TClientItem;
begin
   if body <> '' then begin
      DecodeBuffer (body, @ci, sizeof(TClientItem));
      DelDealRemoteItem (ci);
   end;
end;

procedure TfrmMain.ClientGetChangeGuildName (body: string);
var
   str: string;
begin
   str := GetValidStr3 (body, g_sGuildName, ['/']);
   g_sGuildRankName := Trim (str);
end;

procedure TfrmMain.ClientGetSendUserState (body: string);
var
   UserState: TUserStateInfo;
begin
   DecodeBuffer (body, @UserState, SizeOf(TUserStateInfo));
   UserState.NameColor := GetRGB(UserState.NameColor);
   g_LoverNameState := UserState.LoverName;
   FrmDlg.OpenUserState(UserState);
end;

procedure TfrmMain.ClientFriendList(body: string);
var
  Online,Offline,Parts: TStringList;
  Current: ^TStringList;
  A,I: Integer;
  List: Byte;
  Friend: PTClientFriends;
begin
  if body <> '' then begin
    Parts := Split('#',Body);
    Online := Split('/',Parts[0]);
    if Parts.Count > 1 then Offline := Split('/',Parts[1])
    else Offline := TStringList.Create;

    for A := 0 to 1 do begin
      case A of
        0: Current := @Offline;
        1: Current := @Online;
      end;
      for I := 0 to Current.Count-1 do begin
        new(friend);
        Friend.Name := Current.Strings[I];
        if AnsiPos(#1, Friend.Name) <> 0 then List := F_BAD
        else List := F_GOOD;
        Friend.Name := StringReplace(Friend.Name, #1, '', [rfReplaceAll]);
        Friend.Status := A; // 0 = Offline | 1 = Online
        if Friend.Name <> '' then begin
          frmDlg.FriendList[List].Add(Friend);
//          DScreen.AddChatBoardString('Found Friend: '+Friend.Name+' ('+inttostr(List)+')',clWhite, clBlack);

          //Request Memo for Friend from server
          SendClientMessage(CM_REQMEMOFRIEND, 0, 0, 0, 0, Friend.Name);
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientFriendStatus(status: byte;body: string);
var
  Current: ^TStringList;
  A,I: Integer;
  Friend: PTClientFriends;
begin
  if body <> '' then begin
    for A := 0 to 1 do begin
      for I := 0 to FrmDlg.FriendList[A].Count-1 do begin
        Friend := PTClientFriends(FrmDlg.FriendList[A].Items[I]);
        if Friend <> nil then begin
          if Lowercase(Friend.Name) = LowerCase(Body) then begin
            Friend.Status := status;
            if (status = 1) and (Not Friend.Blacklist) then DScreen.AddChatBoardString('=> 好友'+Friend.Name+'上线了！',clBlack, clLime)
            else if (Not Friend.Blacklist) then DScreen.AddChatBoardString('=> 好友'+Friend.Name+'下线了！',clWhite, clRed);
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientAddFriendFail(body: string);
var
  sFriendName,sReason: String;
  p: Integer;
begin
  if body <> '' then begin
    body := DecodeString(body);
    p := AnsiPos(#1, body);
    sFriendName := Copy(body, 0, p-1);
    sReason := Copy(body, p+1, 100);
    FrmDlg.DMessageDlg('增加好友 '''+sFriendName+''' 失败。\原因: '+sReason,[mbOK]);
  end;
end;

procedure TfrmMain.ClientAddFriend(body: string);
var
  Friend:PTClientFriends;
  List: Byte;
begin
  if body <> '' then begin
    body := DecodeString(body);
    new (Friend);
    Friend.Name := body;
    Friend.Memo := '';
    Friend.Status := 1;
    if AnsiPos(#1, Friend.Name) <> 0 then List := F_BAD
    else List := F_GOOD;
    Friend.Name := StringReplace(Friend.Name, #1, '', [rfReplaceAll]);
    frmDlg.FriendList[List].Add(Friend);

    //Request Memo for Friend from server
    SendClientMessage(CM_REQMEMOFRIEND, 0, 0, 0, 0, Friend.Name);
  end;
end;

procedure TfrmMain.ClientDelFriend(body: string);
var
  Current: ^TStringList;
  A,I: Integer;
  Friend: PTClientFriends;
begin
  if body <> '' then begin
    body := DecodeString(body);

    for A := 0 to 1 do begin
      for I := 0 to FrmDlg.FriendList[A].Count-1 do begin
        Friend := PTClientFriends(FrmDlg.FriendList[A].Items[I]);
        if Friend <> nil then begin
          if Lowercase(Friend.Name) = LowerCase(Body) then begin
            if (FrmDlg.DMemo.Visible) and (LowerCase(FrmDlg.DMemo.sMisc) = LowerCase(Friend.Name)) then begin
              FrmDlg.DMemoCloseClick(Nil,0,0);
            end;
//            FrmDlg.DFriendDlg.Visible := False;
            FrmDlg.FriendIndex[A] := -1;
            FrmDlg.FriendList[A].Remove(Friend);
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.ClientUpdateMemo(body: string);
var
  Parts: TStringList;
  Current: ^TStringList;
  A,I: Integer;
  Friend: PTClientFriends;
begin
  if body <> '' then begin
    body := DecodeString(body);
    Parts := Split(#1,Body);
    if Parts.Count < 2 then Parts.Add('');
    for A := 0 to 1 do begin
      for I := 0 to FrmDlg.FriendList[A].Count-1 do begin
        Friend := PTClientFriends(FrmDlg.FriendList[A].Items[I]);
        if Friend <> nil then begin
          if LowerCase(Friend.Name) = LowerCase(Parts[0]) then begin
            Friend.Memo := Parts[1];
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.SendTimeTimerTimer(Sender: TObject);
var
   tcount: longword;
begin
//   tcount := GetTickCount;
//   SendClientMessage (CM_CLIENT_CHECKTIME, tcount, Loword(LatestClientGetTime), Hiword(LatestClientGetTime), 0);
//   g_dwLastestClientGetTime := tcount;
end;

procedure TfrmMain.DrawEffectHumex(nType: Integer;ObjectID:TActor);
var
  Effect :TMagicEff;
  boFly:Boolean;
begin
  Effect:=nil;
  case nType of
    12: begin //等级提升
     Effect:=TObjectEffects.Create(ObjectID,g_WMagic2Images,1190,17,100,TRUE);
     PlaySound(156);
    end;
    13: begin
      Effect:=TObjectEffects.Create(ObjectID,g_WMagic2Images,1090,10,50,TRUE);
      PlaySound(10485);
    end;
    14: begin // yimoogi 使用魔法攻击
      Effect:=TObjectEffects.Create(ObjectID,g_WMagic2Images,1250,15,80,TRUE);
    end;
    15: begin // UltimateEnhancer
      Effect:=TObjectEffects.Create(ObjectID,g_WMagic2Images,165,10,70,TRUE);
    end;
    16: begin // 复活效果
      Effect:=TObjectEffects.Create(ObjectID,g_WMagic2Images,1220,20,115,TRUE);
      PlaySound(10543);
      SilenceSound;
    end;
  end;
  if Effect <> nil then begin
    Effect.MagOwner:=ObjectID;
    PlayScene.m_EffectList.Add(Effect);
  end;
end;
procedure TfrmMain.DrawEffectHum(nType, nX, nY: Integer);
var
  Effect :TMagicEff;
  boFly:Boolean;
begin
  Effect:=nil;

  case nType of
    0: begin
    end;
    1: Effect:=TNormalDrawEffect.Create(nX,nY,WMon14Img,410,6,120,False);
    2: begin
      Effect:=TNormalDrawEffect.Create(nX,nY,g_WMagic2Images,670,10,150,TRUE);
    end;
    3: begin
      Effect:=TNormalDrawEffect.Create(nX,nY,g_WMagic2Images,690,10,150,TRUE);
      PlaySound(48);
    end;
    4: begin
      PlayScene.NewMagic (nil,70,70,nX,nY,nX,nY,0,mtThunder,False,30,boFly);
      PlaySound(8301);
    end;
    5: begin
      PlayScene.NewMagic (nil,71,71,nX,nY,nX,nY,0,mtThunder,False,30,boFly);
      PlayScene.NewMagic (nil,72,72,nX,nY,nX,nY,0,mtThunder,False,30,boFly);
      PlaySound(8302);
    end;
    6: begin
      PlayScene.NewMagic (nil,73,73,nX,nY,nX,nY,0,mtThunder,False,30,boFly);
      PlaySound(8207);
    end;
    7: begin
      PlayScene.NewMagic (nil,74,74,nX,nY,nX,nY,0,mtThunder,False,30,boFly);
      PlaySound(8226);
    end;
    8: begin
      Effect:=THumanEffects.Create(nX,nY,g_WMagic2Images,210,5,150,TRUE);
    end;
    9: begin
      Effect:=TNormalDrawEffect.Create(nX,nY,g_WMagic2Images,380,5,150,TRUE);
    end;
    10: begin
      PlayScene.NewMagic (nil,80,80,nx,ny,nx,ny,0,mtRedThunder,False,30,boFly);
      PlaySound(8301);
    end;
    11: begin
      PlayScene.NewMagic (nil,91,91,nx,ny,nx,ny,0,mtLava,False,30,boFly);
      PlaySound(8302);
    end;
    12: begin // 毒云
      Effect:=TNormalDrawEffect.Create(nX,nY,g_WMagic2Images,1280,10,100,TRUE);
    end;
    17: begin
      Effect:=TNormalDrawEffect.Create(nX,nY,g_WMagic2Images,1920,4,120,False);
    end;
    18: begin
      Effect:=THumanEffects.Create(nX,nY,WMon26Img,3790,10,120,TRUE);
      PlaySound(2956);
    end;
    19: begin
      Effect:=THumanEffects.Create(nX,nY,WMon24Img,780,10,120,TRUE);
      PlaySound(2516);
    end;
    20: begin
      Effect:=THumanEffects.Create(nX,nY,WMon24Img,790,10,120,TRUE);
      PlaySound(2517);
    end;
    21: begin
      Effect:=THumanEffects.Create(nX,nY,WMon24Img,1320,10,120,TRUE);
      PlaySound(2526);
    end;
    22: begin
      Effect:=THumanEffects.Create(nX,nY,WMon24Img,1330,20,120,TRUE);
      PlaySound(2527);
    end;
    23: begin
      Effect:=THumanEffects.Create(nX,nY,g_WMagic2Images,1410,10,120,TRUE);
      PlaySound(2547);
    end;
    24: begin
      Effect:=THumanEffects.Create(nX,nY,WMon24Img,1440,10,120,TRUE);
      PlaySound(2546);
    end;
    25: begin
      Effect:=THumanEffects.Create(nX,nY,g_WMagic2Images,0,10,120,TRUE);
      PlaySound(2528);
    end;
    26: begin
      Effect:=THumanEffects.Create(nX,nY,WMon24Img,2120,20,120,TRUE);
      PlaySound(2577);
    end;
    27: begin
      Effect:=THumanEffects.Create(nX,nY,WMon24Img,2140,20,120,TRUE);
      PlaySound(2578);
    end;
  end;
  if Effect <> nil then begin
    Effect.MagOwner:=g_MySelf;
    PlayScene.m_EffectList.Add(Effect);
  end;
end;
function IsDebugA():Boolean;
var
  isDebuggerPresent: function:Boolean;
  DllModule: THandle;
begin
  DllModule := LoadLibrary('kernel32.dll');
  isDebuggerPresent := GetProcAddress(DllModule, PChar(DecodeString('io@^LIefGNq<K@TxL?A<ACP')));    //'IsDebuggerPresent'
  Result:=isDebuggerPresent;
end;

function IsDebug():Boolean;
var
  isDebuggerPresent: function:Boolean;
  DllModule: THandle;
begin
  DllModule := LoadLibrary('kernel32.dll');
  isDebuggerPresent := GetProcAddress(DllModule, PChar(DecodeString('io@^LIefGNq<K@TxL?A<ACP')));    //'IsDebuggerPresent'
  Result:=isDebuggerPresent;
end;

procedure TfrmMain.SelectChr(sChrName: String);
begin
  PlayScene.EdChrNamet.Text:=sChrName;
end;

function TfrmMain.GetNpcImg(wAppr: Word; var WMImage: TWMImages): Boolean;
var
  I: Integer;
  FileName:String;
begin
  Result:=False;
  for I := 0 to NpcImageList.Count - 1 do begin
    WMImage:=TWMImages(NpcImageList.Items[I]);
    if WMImage.Appr = wAppr then begin
      Result:=True;
      exit;
    end;
  end;
  FileName:=NpcImageDir + IntToStr(wAppr) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=wAppr;
    WMImage.Initialize;
    NpcImageList.Add(WMImage);
    Result:=True;
  end;
end;

function TfrmMain.GetWStateImg(Idx:Integer;var ax,ay:integer): TDirectDrawSurface;
var
  I:Integer;
  FileName:String;
  FileIdx:Integer;
  WMImage:TWMImages;
begin
  Result:=nil;
  if Idx < 10000 then begin
    Result:=g_WStateItemImages.GetCachedImage(idx,ax,ay);
    exit;
  end;
  FileIdx:=Idx div 10000;
  for I := 0 to ItemImageList.Count - 1 do begin
    WMImage:=TWMImages(ItemImageList.Items[I]);
    if WMImage.Appr = FileIdx then begin
      Result:=WMImage.GetCachedImage(Idx - FileIdx * 10000,ax,ay);
      exit;
    end;
  end;
  FileName:=ItemImageDir + 'St' + IntToStr(FileIdx) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=FileIdx;
    WMImage.Initialize;
    ItemImageList.Add(WMImage);
    Result:=WMImage.GetCachedImage(Idx - FileIdx * 10000,ax,ay);
  end;
end;

function TfrmMain.GetWStateImg(Idx: Integer): TDirectDrawSurface;
var
  I:Integer;
  FileName:String;
  FileIdx:Integer;
  WMImage:TWMImages;
begin
  Result:=nil;
  if Idx < 10000 then begin
    Result:=g_WStateItemImages.Images[idx];
    exit;
  end;
  FileIdx:=Idx div 10000;
  for I := 0 to ItemImageList.Count - 1 do begin
    WMImage:=TWMImages(ItemImageList.Items[I]);
    if WMImage.Appr = FileIdx then begin
      Result:=WMImage.Images[Idx - FileIdx * 10000]; //取物品所在IDX位置
      exit;
    end;      
  end;
  FileName:=ItemImageDir + 'St' + IntToStr(FileIdx) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=FileIdx;
    WMImage.Initialize;
    ItemImageList.Add(WMImage);
    Result:=WMImage.Images[Idx - FileIdx * 10000]; //取物品所在IDX位置
  end;
end;
function TfrmMain.GetWWeaponImg(Weapon,m_btSex,nFrame:Integer;var ax,ay:integer): TDirectDrawSurface;
var
  I:Integer;
  FileName:String;
  FileIdx:Integer;
  WMImage:TWMImages;
begin
  Result:=nil;
  FileIdx:=(Weapon - m_btSex) div 2;

  if (FileIdx < 100) then begin
    Result:=g_WWeaponImages.GetCachedImage(HUMANFRAME * Weapon + nFrame,ax,ay);
    exit;
  end;

  for I := 0 to WeaponImageList.Count - 1 do begin
    WMImage:=TWMImages(WeaponImageList.Items[I]);
    if WMImage.Appr = FileIdx then begin
      Result:=WMImage.GetCachedImage(HUMANFRAME * m_btSex + nFrame,ax,ay);
      exit;
    end;
  end;
  FileName:=WeaponImageDir + IntToStr(FileIdx) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=FileIdx;
    WMImage.Initialize;
    WeaponImageList.Add(WMImage);
    Result:=WMImage.GetCachedImage(HUMANFRAME * m_btSex + nFrame,ax,ay);
  end;
end;

function TfrmMain.GetWHumImg(Dress,m_btSex,nFrame:Integer;var ax,ay:integer): TDirectDrawSurface;
var
  I:Integer;
  FileName:String;
  FileIdx:Integer;
  WMImage:TWMImages;
begin
  Result:=nil;
  FileIdx:=(Dress - m_btSex) div 2;

  if (FileIdx < 16) then begin
    Result:=g_WHumImgImages.GetCachedImage(HUMANFRAME * Dress + nFrame,ax,ay);
    exit;
  end;

  for I := 0 to HumImageList.Count - 1 do begin
    WMImage:=TWMImages(HumImageList.Items[I]);
    if WMImage.Appr = FileIdx then begin
      Result:=WMImage.GetCachedImage(HUMANFRAME * m_btSex + nFrame,ax,ay);
      exit;
    end;
  end;

  FileName:=HumImageDir + IntToStr(FileIdx) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=FileIdx;
    WMImage.Initialize;
    HumImageList.Add(WMImage);
    Result:=WMImage.GetCachedImage(HUMANFRAME * m_btSex + nFrame,ax,ay);
  end;
end;

function TfrmMain.GetWHum2Img(Dress,m_btSex,nFrame:Integer;var ax,ay:integer): TDirectDrawSurface;
var
  I:Integer;
  FileName:String;
  FileIdx:Integer;
  WMImage:TWMImages;
begin
  Result:=nil;
  FileIdx:=(Dress - m_btSex) div 2;

  if (FileIdx < 16) then begin
    Result:=g_WHum2ImgImages.GetCachedImage(HUMANFRAME2 * Dress + nFrame,ax,ay);
    exit;
  end;

  for I := 0 to HumImageList.Count - 1 do begin
    WMImage:=TWMImages(HumImageList.Items[I]);
    if WMImage.Appr = FileIdx then begin
      Result:=WMImage.GetCachedImage(HUMANFRAME2 * m_btSex + nFrame,ax,ay);
      exit;
    end;
  end;

  FileName:=HumImageDir + IntToStr(FileIdx) + '.wil';
  if FileExists(FileName) then begin
    WMImage:=TWMImages.Create(nil);
    WMImage.FileName:=FileName;
    WMImage.LibType:=ltUseCache;
    WMImage.DDraw:=DXDraw.DDraw;
    WMImage.Appr:=FileIdx;
    WMImage.Initialize;
    HumImageList.Add(WMImage);
    Result:=WMImage.GetCachedImage(HUMANFRAME2 * m_btSex + nFrame,ax,ay);
  end;
end;


function TfrmMain.GetHelmetImg(Helmet,m_btSex,nFrame:Integer;var ax,ay:integer): TDirectDrawSurface;
var
  FileName:String;
  FileIdx:Integer;
  WMImage:TWMImages;
begin
  Result:=nil;
  FileIdx:=(Helmet - m_btSex) div 2;

  if (FileIdx < 100) then begin
    Result:=g_WHelmetImgImages.GetCachedImage(HUMANFRAME * Helmet + nFrame,ax,ay);
    exit;
  end;
end;

procedure TfrmMain.ClientGetNeedPassword(Body: String);
begin
  FrmDlg.DChgGamePwd.Visible:=True;
end;

procedure TfrmMain.ClientGetPasswordStatus(Msg: pTDefaultMessage;
  Body: String);
begin

end;

procedure TfrmMain.SendPassword(sPassword: String;nIdent:Integer);
begin
   SendClientMessage(CM_PASSWORD,0,nIdent,0,0,sPassword);
end;

procedure TfrmMain.SetInputStatus;
begin
  if m_boPasswordIntputStatus then begin
    m_boPasswordIntputStatus:=False;
    PlayScene.EdChat.PasswordChar:=#0;
    PlayScene.EdChat.Visible:=False;
  end else begin
    m_boPasswordIntputStatus:=True;
    PlayScene.EdChat.PasswordChar:='*';
    PlayScene.EdChat.Visible:=True;
    PlayScene.EdChat.SetFocus;
  end;
end;

procedure TfrmMain.ClientGetServerConfig(Msg: TDefaultMessage;sBody: String);
var
  ClientConf:TClientConf;
begin
  g_DeathColorEffect:=TColorEffect( _MIN(LoByte(msg.Param),8) );
  g_boCanRunHuman:=LoByte(LoWord(msg.Recog)) = 1;
  g_boCanRunMon:=HiByte(LoWord(msg.Recog)) = 1;
  g_boCanRunNpc:=LoByte(HiWord(msg.Recog)) = 1;
  g_boCanRunAllInWarZone:=HiByte(HiWord(msg.Recog)) = 1;
  {
  DScreen.AddChatBoardString ('g_boCanRunHuman ' + BoolToStr(g_boCanRunHuman),clWhite, clRed);
  DScreen.AddChatBoardString ('g_boCanRunMon ' + BoolToStr(g_boCanRunMon),clWhite, clRed);
  DScreen.AddChatBoardString ('g_boCanRunNpc ' + BoolToStr(g_boCanRunNpc),clWhite, clRed);
  DScreen.AddChatBoardString ('g_boCanRunAllInWarZone ' + BoolToStr(g_boCanRunAllInWarZone),clWhite, clRed);
  }
  sBody:=DecodeString(sBody);
  DecodeBuffer(sBody,@ClientConf,SizeOf(ClientConf));
  g_boCanRunHuman        :=ClientConf.boRunHuman;
  g_boCanRunMon          :=ClientConf.boRunMon;
  g_boCanRunNpc          :=ClientConf.boRunNpc;
  g_boCanRunAllInWarZone :=ClientConf.boWarRunAll;
  g_DeathColorEffect     :=TColorEffect(_MIN(8,ClientConf.btDieColor));
  g_nHitTime             :=ClientConf.wHitIime;
  g_dwSpellTime          :=ClientConf.wSpellTime;
  g_nItemSpeed           :=ClientConf.btItemSpeed;
  g_boCanStartRun        :=ClientConf.boCanStartRun;
  g_boParalyCanRun       :=ClientConf.boParalyCanRun;
  g_boParalyCanWalk      :=ClientConf.boParalyCanWalk;
  g_boParalyCanHit       :=ClientConf.boParalyCanHit;
  g_boParalyCanSpell     :=ClientConf.boParalyCanSpell;
  g_boShowRedHPLable     :=ClientConf.boShowRedHPLable;
  g_boShowHPNumber       :=ClientConf.boShowHPNumber;
  g_boShowJobLevel       :=ClientConf.boShowJobLevel;
  g_boDuraAlert          :=ClientConf.boDuraAlert;
//  g_boMagicLock          :=ClientConf.boMagicLock; //commented by thedeath
  g_boMagicLock          :=True;
  g_boAutoPuckUpItem     :=ClientConf.boAutoPuckUpItem;
end;

procedure TfrmMain.ProcessCommand(sData: String);
var
  sCmd,sCmd1,sParam1,sParam2,sParam3,sParam4,sParam5:String;
  I: Integer;
begin
  sData:=GetValidStr3(sData,sCmd1,[' ',':',#9]);
  sData:=GetValidStr3(sData,sCmd,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam1,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam2,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam3,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam4,[' ',':',#9]);
  sData:=GetValidStr3(sData,sParam5,[' ',':',#9]);

  if CompareText(sCmd1,'@svninfo') = 0 then begin
    if CompareText(sCmd,'client') = 0 then begin
      // SVN数据
      if (SVN_ISTracking) and (SVN_DETAILS.Count > 0) then begin
        DScreen.AddChatBoardString ('SVN信息:', clRed, clWhite);
        for I := 0 to SVN_DETAILS.Count-1 do DScreen.AddChatBoardString (' ['+inttostr(I+1)+'] '+SVN_DETAILS.Strings[I], clRed, clWhite);
        DScreen.AddChatBoardString ('SVN修正: '+inttostr(SVN_REVISION), clWhite, clGreen);
      end
      else begin
        DScreen.AddChatBoardString ('没有SVN修正数据', clWhite, clRed);
      end;
      DScreen.AddChatBoardString ('修改时间: '+FormatDateTime('dd mmm yyyy/hh:nn:ss',UnixToDateTime(BUILDTIME))+' ('+inttostr(BUILDTIME)+')', clWhite, clGreen);
    end
    else if CompareText(sCmd,'server') = 0 then begin
      DScreen.AddChatBoardString ('请求服务器信息..', clRed, clWhite);
      SendClientMessage(CM_SAY, 0, 0, 0, 0,'@svninfo '+sCmd);
    end
    else begin
      DScreen.AddChatBoardString ('!!请指定(client/server) (例如:@svninfo client)', clWhite, clRed);
    end;
  end
  else if CompareText(sCmd,'ShowHumanMsg') = 0 then begin
    CmdShowHumanMsg(sParam1,sParam2,sParam3,sParam4,sParam5);
    exit;
  end;
  {
  g_boShowMemoLog:=not g_boShowMemoLog;
  PlayScene.MemoLog.Clear;
  PlayScene.MemoLog.Visible:=g_boShowMemoLog;
  }
end;
procedure TfrmMain.CmdShowHumanMsg(sParam1,sParam2,sParam3,sParam4,sParam5: String);
var
  sHumanName:String;
begin
  sHumanName:=sParam1;
  if (sHumanName <> '') and (sHumanName[1] = 'C') then begin
    PlayScene.MemoLog.Clear;
    exit;
  end;

//  if sHumanName <> '' then begin
//    ShowMsgActor:=PlayScene.FindActor(sHumanName);
//    if ShowMsgActor = nil then begin
//      DScreen.AddChatBoardString(format('%s没找到！！！',[sHumanName]),clWhite,clRed);
//      exit;
//    end;
//  end;
  g_boShowMemoLog := not g_boShowMemoLog;
  PlayScene.MemoLog.Clear;
  PlayScene.MemoLog.Visible:=g_boShowMemoLog;
end;

procedure TfrmMain.ShowHumanMsg(Msg:pTDefaultMessage);
  function GetIdent(nIdent:Integer):String;
  begin
    case nIdent of  
      SM_RUSH       : Result:='SM_RUSH';
      SM_RUSHKUNG   : Result:='SM_RUSHKUNG';
      SM_FIREHIT    : Result:='SM_FIREHIT';
      SM_BACKSTEP   : Result:='SM_BACKSTEP';
      SM_TURN       : Result:='SM_TURN';
      SM_WALK       : Result:='SM_WALK';
      SM_SITDOWN    : Result:='SM_SITDOWN';
      SM_RUN        : Result:='SM_RUN';
      SM_HIT        : Result:='SM_HIT';
      SM_HEAVYHIT   : Result:='SM_HEAVYHIT';
      SM_BIGHIT     : Result:='SM_BIGHIT';
      SM_SPELL      : Result:='SM_SPELL';
      SM_POWERHIT   : Result:='SM_POWERHIT';
      SM_LONGHIT    : Result:='SM_LONGHIT';
      SM_DIGUP      : Result:='SM_DIGUP';
      SM_DIGDOWN    : Result:='SM_DIGDOWN';
      SM_FLYAXE     : Result:='SM_FLYAXE';
      SM_LIGHTING   : Result:='SM_LIGHTING';
      SM_WIDEHIT    : Result:='SM_WIDEHIT';
      SM_ALIVE      : Result:='SM_ALIVE';
      SM_MOVEFAIL   : Result:='SM_MOVEFAIL';
      SM_HIDE       : Result:='SM_HIDE';
      SM_DISAPPEAR  : Result:='SM_DISAPPEAR';
      SM_STRUCK     : Result:='SM_STRUCK';
      SM_DEATH      : Result:='SM_DEATH';
      SM_SKELETON   : Result:='SM_SKELETON';
      SM_NOWDEATH   : Result:='SM_NOWDEATH';
      SM_CRSHIT     : Result:='SM_CRSHIT';
      SM_TWINHIT    : Result:='SM_TWINHIT';
      SM_HEAR           : Result:='SM_HEAR';
      SM_FEATURECHANGED : Result:='SM_FEATURECHANGED';
      SM_USERNAME          : Result:='SM_USERNAME';
      SM_WINEXP            : Result:='SM_WINEXP';
      SM_LEVELUP           : Result:='SM_LEVELUP';
      SM_DAYCHANGING       : Result:='SM_DAYCHANGING';
      SM_ITEMSHOW          : Result:='SM_ITEMSHOW';
      SM_ITEMHIDE          : Result:='SM_ITEMHIDE';
      SM_MAGICFIRE         : Result:='SM_MAGICFIRE';
      SM_CHANGENAMECOLOR   : Result:='SM_CHANGENAMECOLOR';
      SM_CHARSTATUSCHANGED : Result:='SM_CHARSTATUSCHANGED';
      SM_READYFIREHIT      : Result:='SM_READYFIREHIT';
      SM_SPACEMOVE_HIDE    : Result:='SM_SPACEMOVE_HIDE';
      SM_SPACEMOVE_SHOW    : Result:='SM_SPACEMOVE_SHOW';
      SM_SHOWEVENT         : Result:='SM_SHOWEVENT';
      SM_HIDEEVENT         : Result:='SM_HIDEEVENT';
      else Result:=IntToStr(nIdent);
    end;
  end;
var
  sLineText:String;

begin
  if (ShowMsgActor = nil) or (ShowMsgActor <> nil) and (ShowMsgActor.m_nRecogId = Msg.Recog) then begin
    sLineText:=format('ID:%d Ident:%s',[Msg.Recog,GetIdent(Msg.Ident)]);
    PlayScene.MemoLog.Lines.Add(sLineText);
  end;
end;

procedure TFrmMain.ClientMailList(msg: TDefaultMessage; body: string);
begin
  if Msg.Recog = 0 then begin
    //清除在preperation的邮件名单被再寄的所有项目的
    while frmDlg.MailList.Count > 0 do dispose(frmDlg.MailList.Items[0]);    
    frmDlg.MailList.Clear;
  end
  else if Msg.Recog = 1 then begin
    //被接受的邮件列表，请求屏蔽列表
    SendClientMessage(CM_REQUESTBLOCKLIST, 0, 0, 0, 0);
  end;
end;

procedure TFrmMain.ClientMailItem(msg: TDefaultMessage; body: string);
var
  Item: pTMailItem;
begin
  //向我们求爱有邮件项目!
  New(Item);
  Body := DecodeString(Body);
  Item := StringToMailItem(Body);
//  DScreen.AddSysMsg ('ID: '+inttostr(Item.ID));
//  DScreen.AddSysMsg ('Sender: '+Item.Sender);
//  DScreen.AddSysMsg ('Recipient: '+Item.Recipient);
//  DScreen.AddSysMsg ('Content: '+Item.Content);
//  if Item.Read then DScreen.AddSysMsg ('Read: Yes')
//  else begin
//    DScreen.AddSysMsg ('Read: No');
//    g_boHasMail := True;
//  end;
//  DScreen.AddSysMsg ('Status: '+inttostr(Item.Status));
//  DScreen.AddSysMsg ('Time: '+inttostr(Item.Time));

  if not Item.Read then g_boHasMail := True;
  if Msg.Recog = 1 then DScreen.AddChatBoardString('[*]你有新邮件',clWhite,clRed);
  FrmDlg.MailList.Add(Item);
end;

procedure TFrmMain.ClientMailSent(msg: TDefaultMessage; body: string);
begin
  Body := DecodeString(Body);
  frmDlg.DMessageDlg('邮件发送到 '+body+'.',[mbok]);
end;

procedure TFrmMain.ClientMailStatus(msg: TDefaultMessage; body: string);
begin
  //不再实际上使用
end;

procedure TFrmMain.ClientMailFailed(msg: TDefaultMessage; body: string);
var
  Parts: TStringList;
begin
  Body := DecodeString(Body);
  Parts := Split(#1,Body);
  frmDlg.DMessageDlg('发送邮件给 '+Parts.Strings[0]+'失败。\原因:'+Parts.Strings[1],[mbok]);
end;

procedure TFrmMain.ClientBlockListItem(msg: TDefaultMessage; body: string);
var
  Item: ptBlockItem;
  Parts: TStringList;
begin
  New(Item);
  Body := DecodeString(Body);
  Parts := Split(#1,body);
  Item.Id := strtoint(Parts.Strings[0]);
  Item.Name := Parts.Strings[1];
  frmDlg.BlockList.Add(Item);
end;

procedure TFrmMain.ClientBlockListAdded(msg: TDefaultMessage; body: string);
var
  Item: ptBlockItem;
begin
  Body := DecodeString(Body);
  New(Item);
  Item.Id := -1;
  Item.Name := Body;
  frmDlg.BlockList.Add(Item);
  frmDlg.DMessageDlg(body+' 需要增加到黑名单？',[mbok]);
end;

procedure TFrmMain.ClientBlockListFail(msg: TDefaultMessage; body: string);
var
  Parts: TStringList;
begin
  Body := DecodeString(Body);
  Parts := Split(#1,Body);
  frmDlg.DMessageDlg('增加 '+Parts.Strings[0]+' 到黑名单失败。\原因:'+Parts.Strings[1],[mbok]);
end;

procedure TFrmMain.ClientBlockListDeleted(msg: TDefaultMessage; body: string);
begin
  Body := DecodeString(Body);
  frmDlg.DMessageDlg(body+' 从黑名单中删除？.',[mbok]);
end;

procedure TFrmMain.ClientBlockList(msg: TDefaultMessage; body: string);
begin
  if Msg.Recog = 0 then begin
    // Clear the block list in preperation for all items being resent.
    while frmDlg.BlockList.Count > 0 do dispose(frmDlg.BlockList.Items[0]);
    frmDlg.BlockList.Clear;
  end
  else if Msg.Recog = 1 then begin
    // blocklist recieved
  end;
end;

procedure TfrmMain.AutoRunTimerTimer(Sender: TObject);
begin
  g_ChrAction := caRun;
  g_nTargetX := g_nMouseCurrX;
  g_nTargetY := g_nMouseCurrY;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  ClientWidth := SCREENWIDTH;
  ClientHeight := SCREENHEIGHT;
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not(ssCtrl in Shift) and not(g_boSkillSetting) then
    FrmDlg.DSkillBar.SetImgIndex (g_WMainImages, 711);
end;

procedure TfrmMain.ToggleAutoRun;
begin
  if AutoRunTimer.Enabled Then begin
    AutoRunTimer.Enabled:=False;
    DScreen.AddChatBoardString ('<自动跑步关闭>', clGreen, clWhite);
  end else begin
    AutoRunTimer.Enabled:=True;
    DScreen.AddChatBoardString ('<自动跑步开启>', clGreen, clWhite);
  end;
end;

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: ClMain.pas 597 2007-04-11 19:46:11Z sean $');
end.
