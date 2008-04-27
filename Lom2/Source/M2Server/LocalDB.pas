unit LocalDB;
// If you get an error on the next line, you need to reextract SourceFiles.rar
{$I defines.inc}
interface

uses
  svn, nixtime, Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, ActiveX, ExtCtrls,
  Dialogs, GuildTerritory, M2Share, ADODB, DB, HUtil32, Grobal2, SDK, ObjNpc, ItmUnit, DateUtils, EDcode,ObjBase, math;


type
  TDefineInfo = record
    sName:String;
    sText:String;
  end;
  pTDefineInfo = ^TDefineInfo;
  TQDDinfo = record
    n00     :Integer;
    s04     :String;
    sList   :TStringList;
  end;
  pTQDDinfo = ^TQDDinfo;
  TGoodFileHeader = record
    nItemCount    :Integer;
    Resv          :array[0..251] of Integer;
  end;
  TFrmDB = class
  private
    LastSQLTime: LongInt;
    procedure QMangeNPC;
    procedure QFunctionNPC;
    procedure RobotNPC();
    procedure DeCodeStringList(StringList:TStringList);
    { Private declarations }
  public
    SQLTimer: TTimer;
    Query: TADOQuery;
    QueryCommand: TADOCommand;    
//    SQLDBM: TADOQuery;

    constructor Create();
    destructor Destroy; override;
    procedure InitDBM();
    procedure DoSQLTimer(Sender: TObject);
    procedure UseSQL();
    function GetBoolean(MyQuery: TADOQuery; Field: String): boolean;
    function LoadMonitems(MonName:String;var ItemList:TList):Integer;
    function LoadItemsDB():Integer;
    {$IFDEF UseTXT}
      function LoadMinMap():Integer;
      function LoadBigMap():Integer;
    {$ELSE}
      function LoadMapRoute():Integer;
    {$ENDIF}
    function LoadMapInfo():Integer;
    function LoadMonsterDB():Integer;
    function LoadMagicDB():Integer;
    function LoadMonGen():Integer;
    function LoadUnbindList():Integer;
    function LoadMapQuest():Integer;
    function LoadQuestDiary():Integer;
    function LoadAdminList():Boolean;
    function LoadMerchant():Integer;
    function LoadGuardList():Integer;
    function LoadNpcs():Integer;
    function LoadMakeItem():Integer;
    function LoadStartPoint():Integer;
    function LoadNpcScript(NPC:TNormNpc;sPatch,sScritpName:String):Integer;
    function LoadScriptFile(NPC:TNormNpc;sPatch,sScritpName:String;boFlag:Boolean):Integer;
    function LoadGoodRecord(NPC:TMerchant;sFile:String):Integer;
    function LoadGoodPriceRecord(NPC:TMerchant;sFile:String):Integer;

    function SaveGoodRecord(NPC:TMerchant;sFile:String):Integer;
    function SaveGoodPriceRecord(NPC:TMerchant;sFile:String):Integer;

    function  LoadUpgradeWeaponRecord(sNPCName:String;DataList:TList):Integer;
    function  SaveUpgradeWeaponRecord(sNPCName:String;DataList:TList):Integer;
    procedure ReLoadMerchants();
    procedure ReLoadNpc();

    function ConsignItem(Useritem: pTUserItem; Cost: String; Name: string): boolean;
    procedure GetAuctionItems(Section: integer; CurrPage: Integer; SearchString: String; PlayObject: TPlayObject);
    procedure BuyAuctionItem(PlayObject: TPlayObject; AuctionID: Integer);
    procedure EndOfAuction(PlayObject: TPlayObject; AuctionID: Integer);

    function  SaveAdminList():Boolean;
    procedure LoadGT(Number,ListNumber:Integer);
    procedure LoadGTDecorations(GT:TTerritory);
    procedure SaveGT(GT:TTerritory);
    procedure SetupGT(GT:TTerritory);
    procedure SaveDeco(looks,GTNumber:Byte;x,y:integer;mapname:String; starttime:dword);
    procedure DeleteDeco(GTNumber:Byte; x,y: integer; mapname:String);
    function  LoadDecorationList():Integer;
    function  LoadGameShopItemList(PageCount:integer): TList;
    function  LoadBBSMsgList(GuildName:String;PageCount:integer):TList;
    function  LoadBBSMsg(Index:integer):pTBBSMSGL;
    procedure SaveBBSMsg(BBSMSGL:pTBBSMSGL;GuildName:String);
    procedure DeleteBBSMsg(index:integer);

    function LoadMapEvent(): Integer;
//    function LoadShopItemList(): Integer;
  end;
  
var
  FrmDB: TFrmDB;
  nDeCryptString:Integer= -1;
implementation

uses
  Envir, svMain;

{ TFrmDB }
//00487630
function TFrmDB.LoadAdminList():Boolean;
var
  sFileName :String;
  sLineText :String;
  sIPaddr   :String;
  sCharName :String;
  sData     :String;
  LoadList  :TStringList;
  AdminInfo :pTAdminInfo;
  I         :Integer;
  nLv       :Integer;
begin
    Result:=False;;
    sFileName:=g_Config.sEnvirDir + 'AdminList.txt';
  if not FileExists(sFileName) then exit;
    UserEngine.m_AdminList.Lock;
    try
      UserEngine.m_AdminList.Clear;
      LoadList:=TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      for I:=0 to LoadList.Count -1 do begin
        sLineText:=LoadList.Strings[i];
        nLv:=-1;
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          if sLineText[1] = '*' then nLv:=10
          else if sLineText[1] = '1' then nLv:=9
          else if sLineText[1] = '2' then nLv:=8
          else if sLineText[1] = '3' then nLv:=7
          else if sLineText[1] = '4' then nLv:=6
          else if sLineText[1] = '5' then nLv:=5
          else if sLineText[1] = '6' then nLv:=4
          else if sLineText[1] = '7' then nLv:=3
          else if sLineText[1] = '8' then nLv:=2
          else if sLineText[1] = '9' then nLv:=1;
          if nLv > 0 then begin
            sLineText:=GetValidStrCap(sLineText, sData, ['/','\',' ', #9]);
            sLineText:=GetValidStrCap(sLineText, sCharName, ['/','\',' ', #9]);
            sLineText:=GetValidStrCap(sLineText, sIPaddr, ['/','\',' ', #9]);
//{$IF VEROWNER = WL}
//            if (sCharName <= '') or (sIPaddr = '') then Continue;
//{$IFEND}
            New(AdminInfo);
            AdminInfo.nLv      := nLv;
            AdminInfo.sChrName := sCharName;
            AdminInfo.sIPaddr  := sIPaddr;
            UserEngine.m_AdminList.Add(AdminInfo);
          end;
        end;
      end;
      LoadList.Free;
    finally
      UserEngine.m_AdminList.UnLock;
    end;
    Result:=True;
end;
{
function TFrmDB.LoadAdminList():Boolean;
var
  i:Integer;
  AdminInfo :pTAdminInfo;
ResourceString
  sSQLString = 'SELECT * FROM TBL_ADMIN';
begin
  Result:=False;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
  try
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
    end;

    UserEngine.m_AdminList.Lock;
    try
      UserEngine.m_AdminList.Clear;
      for i:=0 to Query.RecordCount -1 do begin
        New(AdminInfo);
        AdminInfo.nLv         := Query.FieldByName('FLD_ADMINLEVEL').AsInteger;
        AdminInfo.sChrName    := Query.FieldByName('FLD_PLAYERNAME').AsString;
        AdminInfo.sIPaddr     := Query.FieldByName('FLD_IP').AsString;

        UserEngine.m_AdminList.Add(AdminInfo);

        Query.Next;
      end;
    finally
      UserEngine.m_AdminList.UnLock;
    end;
  finally
    Query.Close;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  Result:=True;
end; }

function TFrmDB.SaveAdminList():Boolean;
var
  I           :Integer;
  sFileName   :String;
  SaveList    :TStringList;
  sPerMission :String;
  nPerMission :Integer;
  AdminInfo   :pTAdminInfo;
begin
  sFileName := g_Config.sEnvirDir + 'AdminList.txt';
  SaveList  := TStringList.Create;
  UserEngine.m_AdminList.Lock;
  try
    for I := 0 to UserEngine.m_AdminList.Count - 1 do begin
      AdminInfo:=pTAdminInfo(UserEngine.m_AdminList.Items[I]);
      nPerMission:=AdminInfo.nLv;
      if nPerMission = 10 then sPerMission:='*';
      if nPerMission = 9 then sPerMission:='1';
      if nPerMission = 8 then sPerMission:='2';
      if nPerMission = 7 then sPerMission:='3';
      if nPerMission = 6 then sPerMission:='4';
      if nPerMission = 5 then sPerMission:='5';
      if nPerMission = 4 then sPerMission:='6';
      if nPerMission = 3 then sPerMission:='7';
      if nPerMission = 2 then sPerMission:='8';
      if nPerMission = 1 then sPerMission:='9';
//{$IF VEROWNER = WL}
//      SaveList.Add(sPerMission + #9 + AdminInfo.sChrName + #9 + AdminInfo.sIPaddr);
//{$ELSE}
      SaveList.Add(sPerMission + #9 + AdminInfo.sChrName);
//{$IFEND}
    end;
    SaveList.SaveToFile(sFileName);
  finally
    UserEngine.m_AdminList.UnLock;
  end;
  Result:=True;
end;
{
function TFrmDB.SaveAdminList():Boolean;
var
  i:Integer;
  AdminInfo :pTAdminInfo;
ResourceString
  sSQLString = 'DELETE * FROM TBL_ADMIN';
  sSQLString2= 'INSERT INTO TBL_ADMIN(FLD_ADMINLEVEL, FLD_PLAYERNAME, FLD_IP) VALUES( %d, ''%s'', ''%s'' )';
begin
  Result:=False;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
  try
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.ExecSQL;
    except
    end;

    try
      UserEngine.m_AdminList.Lock;
      Query.SQL.Clear;
      for I := 0 to UserEngine.m_AdminList.Count - 1 do begin
        AdminInfo:=pTAdminInfo(UserEngine.m_AdminList.Items[I]);

        Query.Close;
        Query.SQL.Text:=Format(sSQLString2, [AdminInfo.nLv, AdminInfo.sChrName, AdminInfo.sIPaddr]);

        if (Query.ExecSQL<=0) then begin
	  Break;
        end;
      end;

    finally
      UserEngine.m_AdminList.UnLock;
    end;
  finally
    Query.Close;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  Result:=True;
end; }


//00488A68
function TFrmDB.LoadGuardList(): Integer;
{$IFDEF UseTXT}
var
  sFileName,s14,s1C,s20,s24,s28,s2C:String;
  tGuardList:TStringList;
  i:Integer;
  tGuard   :TBaseObject;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    Result:= -1;
    sFileName:=g_Config.sEnvirDir + 'GuardList.txt';
    if FileExists(sFileName) then begin
      tGuardList:=TStringList.Create;
      tGuardList.LoadFromFile(sFileName);
      for i:=0 to tGuardList.Count -1 do begin
        s14:=tGuardList.Strings[i];
        if (s14 <> '') and (s14[1] <> ';') then begin
          s14:=GetValidStrCap(s14, s1C, [' ']);
          if (s1C <> '') and (s1C[1] = '"') then
            ArrestStringEx(s1C,'"','"',s1C);
          s14:=GetValidStr3(s14, s20, [' ']);
          s14:=GetValidStr3(s14, s24, [' ',',']);
          s14:=GetValidStr3(s14, s28, [' ',',',':']);
          s14:=GetValidStr3(s14, s2C, [' ',':']);
          if (s1C <> '') and (s20 <> '') and (s2C <> '') then begin
            tGuard:=UserEngine.RegenMonsterByName(s20,Str_ToInt(s24,0),Str_ToInt(s28,0),s1C);
              //sMapName,nX,nY,sName
            if tGuard <> nil then tGuard.m_btDirection:=Str_ToInt(s2C,0);
          end;
        end;
      end;
      tGuardList.Free;
      Result:=1;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
{$ELSE}
var
  i,nX,nY,nDir:Integer;
  sGuardName,sMap:String;
  tGuard:TBaseObject;
ResourceString
  sSQLString = 'SELECT * FROM TBL_GUARD';
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
  try
    Result := -1;
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
      Result:= -2;
    end;
    for i:=0 to Query.RecordCount -1 do begin
      sGuardName        := Query.FieldByName('FLD_GUARDNAME').AsString;
      sMap              := Query.FieldByName('FLD_MAPNAME').AsString;
      nX                := Query.FieldByName('FLD_X').AsInteger;
      nY                := Query.FieldByName('FLD_Y').AsInteger;
      nDir              := Query.FieldByName('FLD_DIRECTION').AsInteger;

      if (sGuardName <> '') and (sMap <> '') then begin
        tGuard:=UserEngine.RegenMonsterByName(sMap,nX,nY,sGuardName);
        //sMapName,nX,nY,sName
        if tGuard <> nil then tGuard.m_btDirection:=nDir;
      end;

      Result := 1;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
{$ENDIF}
end;
//004855E0
function TFrmDB.LoadItemsDB: Integer;
var
  i,Idx:Integer;
  Item:TItem;
ResourceString
  sSQLString = 'SELECT * FROM TBL_STDITEMS ORDER BY FLD_ID';
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
  try
    for I := 0 to UserEngine.StdItemList.Count - 1 do begin
      TItem(UserEngine.StdItemList.Items[I]).Free;
    end;
    UserEngine.StdItemList.Clear;
    Result := -1;
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
      Result:= -2;
    end;
    if Query.RecordCount = 0 then Result := -3;
    for i:=0 to Query.RecordCount -1 do begin
      Item := TItem.Create;
      Idx            := Query.FieldByName('FLD_ID').AsInteger;
      Item.Name      := Query.FieldByName('FLD_NAME').AsString;
      Item.StdMode   := Query.FieldByName('FLD_STDMode').AsInteger;
      Item.Shape     := Query.FieldByName('FLD_SHAPE').AsInteger;
      Item.Weight    := Query.FieldByName('FLD_WEIGHT').AsInteger;
      Item.AniCount  := Query.FieldByName('FLD_ANICOUNT').AsInteger;
      Item.Source    := Query.FieldByName('FLD_SOURCE').AsInteger;
      Item.Reserved  := Query.FieldByName('FLD_RESERVED').AsInteger;
      Item.Looks     := Query.FieldByName('FLD_IMGINDEX').AsInteger;
      Item.DuraMax   := Word(Query.FieldByName('FLD_DURAMAX').AsInteger);
      Item.AC        := ROUND(Query.FieldByName('FLD_AC').AsInteger * (g_Config.nItemsACPowerRate / 10));
      Item.AC2       := ROUND(Query.FieldByName('FLD_ACMAX').AsInteger * (g_Config.nItemsACPowerRate / 10));
      Item.MAC       := ROUND(Query.FieldByName('FLD_MAC').AsInteger * (g_Config.nItemsACPowerRate / 10));
      Item.MAC2      := ROUND(Query.FieldByName('FLD_MACMAX').AsInteger * (g_Config.nItemsACPowerRate / 10));
      Item.DC        := ROUND(Query.FieldByName('FLD_DC').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.DC2       := ROUND(Query.FieldByName('FLD_DCMAX').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.MC        := ROUND(Query.FieldByName('FLD_MC').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.MC2       := ROUND(Query.FieldByName('FLD_MCMAX').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.SC        := ROUND(Query.FieldByName('FLD_SC').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.SC2       := ROUND(Query.FieldByName('FLD_SCMAX').AsInteger * (g_Config.nItemsPowerRate / 10));
      Item.Need      := Query.FieldByName('FLD_NEED').AsInteger;
      Item.NeedLevel := Query.FieldByName('FLD_NEEDLEVEL').AsInteger;
      Item.Price     := Query.FieldByName('FLD_PRICE').AsInteger;
      Item.Unique    := Query.FieldByName('FLD_UNIQUEITEM').AsBoolean;
      Item.Light     := Query.FieldByName('FLD_LIGHT').AsInteger;
      Item.Tox       := Query.FieldByName('FLD_TOX').AsInteger;
      Item.ToxAvoid  := Query.FieldByName('FLD_TOXAVOID').AsInteger;
      Item.SlowDown  := Query.FieldByName('FLD_SLOWDOWN').AsInteger;
      Item.MagAvoid  := Query.FieldByName('FLD_MGAVOID').AsInteger;
      Item.HpAdd     := Query.FieldByName('FLD_HPADD').AsInteger;
      Item.MpAdd     := Query.FieldByName('FLD_MPADD').AsInteger;
      Item.boCanTrade := Query.FieldByName('FLD_CanTrade').AsBoolean;
      Item.boCanDrop  := Query.FieldByName('FLD_CanDrop').AsBoolean;
      Item.boCanDeathDrop := Query.FieldByName('FLD_CanDeathDrop').AsBoolean;
      Item.boCanRepair    := Query.FieldByName('FLD_CanRepair').AsBoolean;
      Item.boCanSpecialRepair := Query.FieldByName('FLD_CanSpecialRepair').AsBoolean;
      Item.boCanStore         := Query.FieldByName('FLD_CanStore').AsBoolean;
      Item.boCanSell          := Query.FieldByName('FLD_CanSell').AsBoolean;
      Item.boVanishDrop       := Query.FieldByName('FLD_VanishDrop').AsBoolean;
      Item.NeedIdentify :=GetGameLogItemNameList(Item.Name);

      if Item.StdMode = 48 then
        g_Config.sGTDeco:=Item.Name;//set the name of the gt decoration base item
      case Item.StdMode of
        5,6: Item.ItemType := ITEM_WEAPON;
        10,11,12: Item.ItemType := ITEM_ARMOR;
        15,19,20,21,22,23,24,26,62,63,64: Item.ItemType := ITEM_ACCESSORY;
        else Item.ItemType := ITEM_ETC;
      end;
      if UserEngine.StdItemList.Count = Idx-1 then begin
        UserEngine.StdItemList.Add(Item);
        Result := 1;
      end else begin
        Memo.Lines.Add(format('Error: Invalid Index found(Idx:%d Name:%s)..',[Idx,Item.Name]));
        Result := -100;
        exit;
      end;
      Query.Next;
    end;
    g_boGameLogGold:=GetGameLogItemNameList(sSTRING_GOLDNAME) = 1;
    g_boGameLogHumanDie:=GetGameLogItemNameList(g_sHumanDieEvent) = 1;
    g_boGameLogGameGold:=GetGameLogItemNameList(g_Config.sGameGoldName) = 1;
    g_boGameLogGamePoint:=GetGameLogItemNameList(g_Config.sGamePointName) = 1;
  finally
    Query.Close;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
//00486330
function TFrmDB.LoadMagicDB():Integer;
var
  i:Integer;
  Magic:pTMagic;
ResourceString
  sSQLString = 'SELECT * FROM TBL_MAGIC ORDER BY FLD_ID';
begin
  Result:= -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
  try
    UserEngine.SwitchMagicList();
    {
    for I := 0 to UserEngine.MagicList.Count - 1 do begin
      Dispose(pTMagic(UserEngine.MagicList.Items[I]));
    end;
    UserEngine.MagicList.Clear;
    }

    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
      Result:= -2;
    end;
    for i:=0 to Query.RecordCount -1 do begin
      New(Magic);
      Magic.wMagicId      := Query.FieldByName('FLD_ID').AsInteger;
      Magic.wMimicID      := Query.FieldByName('FLD_MIMICID').AsInteger;
      Magic.sMagicName    := Trim(Query.FieldByName('FLD_NAME').AsString);
      Magic.btEffectType  := Query.FieldByName('FLD_EFFECTTYPE').AsInteger;
      Magic.btEffect      := Query.FieldByName('FLD_EFFECT').AsInteger;
      Magic.wSpell        := Query.FieldByName('FLD_SPELL').AsInteger;
      Magic.wPower        := Query.FieldByName('FLD_POWER').AsInteger;
      Magic.wMaxPower     := Query.FieldByName('FLD_MAXPOWER').AsInteger;
      Magic.btJob         := Query.FieldByName('FLD_JOB').AsInteger;
      Magic.TrainLevel[0] := Query.FieldByName('FLD_NEEDL1').AsInteger;
      Magic.TrainLevel[1] := Query.FieldByName('FLD_NEEDL2').AsInteger;
      Magic.TrainLevel[2] := Query.FieldByName('FLD_NEEDL3').AsInteger;
      Magic.TrainLevel[3] := Magic.TrainLevel[2]; //Query.FieldByName('FLD_NEEDL3').AsInteger;
      Magic.MaxTrain[0]   := Query.FieldByName('FLD_L1TRAIN').AsInteger;
      Magic.MaxTrain[1]   := Query.FieldByName('FLD_L2TRAIN').AsInteger;
      Magic.MaxTrain[2]   := Query.FieldByName('FLD_L3TRAIN').AsInteger;
      Magic.MaxTrain[3]   := Magic.MaxTrain[2];
      Magic.btTrainLv     := MaxSkillLevel;
      Magic.dwDelayTime   := Query.FieldByName('FLD_DELAY').AsInteger;
      Magic.btDefSpell    := Query.FieldByName('FLD_DEFSPELL').AsInteger;
      Magic.btDefPower    := Query.FieldByName('FLD_DEFPOWER').AsInteger;
      Magic.btDefMaxPower := Query.FieldByName('FLD_DEFMAXPOWER').AsInteger;
      Magic.sDescr        := Trim(Query.FieldByName('FLD_DESCR').AsString);
      if Magic.wMagicId > 0 then begin
        UserEngine.m_MagicList.Add(Magic);
      end else begin
        Dispose(Magic);
      end;
      Result := 1;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMakeItem(): Integer; //00488CDC
var
  I,n14:Integer;
  s18,s20,s24:String;
  LoadList:TStringList;
  sFileName:String;
  List28:TStringList;
begin
  Result:= -1;
  sFileName:=g_Config.sEnvirDir + 'MakeItem.txt';
  if FileExists(sFileName) then begin
    LoadList:=TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    List28:=nil;
    s24:='';
    for I := 0 to LoadList.Count - 1 do begin
      s18:=Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        if s18[1] = '[' then begin
          if List28 <> nil then
            g_MakeItemList.AddObject(s24,List28);
          List28:=TStringList.Create;
          ArrestStringEx(s18,'[',']',s24);
        end else begin
          if List28 <> nil then begin
            s18:=GetValidStr3(s18,s20,[' ',#9]);
            n14:=Str_ToInt(Trim(s18),1);
            List28.AddObject(s20,TObject(n14));
          end;
        end;
      end;
    end;    // for
    if List28 <> nil then
      g_MakeItemList.AddObject(s24,List28);
    LoadList.Free;
    Result:=1;
  end;
end;


function TFrmDB.LoadMapInfo: Integer;
  function LoadMapQuest(sName:String):TMerchant;
  var
    QuestNPC:TMerchant;
  begin
    QuestNPC:=TMerchant.Create;
    QuestNPC.m_sMapName:='0';
    QuestNPC.m_nCurrX:=0;
    QuestNPC.m_nCurrY:=0;
    QuestNPC.m_sCharName:=sName;
    QuestNPC.m_nFlag:=0;
    QuestNPC.m_wAppr:=0;
    QuestNPC.m_sFilePath:='MapQuest_def\';
    QuestNPC.m_boIsHide:=True;
    QuestNPC.m_boIsQuest:=False;
    UserEngine.QuestNPCList.Add(QuestNPC);

    Result:=QuestNPC;
  end;

{$IFDEF UseTXT}
  procedure LoadSubMapInfo(LoadList:TStringList;sFileName:String);
  var
    I: Integer;
    sFilePatchName,sFileDir:String;
    LoadMapList:TStringList;
  begin
    sFileDir:=g_Config.sEnvirDir + 'MapInfo\';
    if not DirectoryExists(sFileDir) then begin
      CreateDir(sFileDir);
    end;
      
    sFilePatchName:=sFileDir + sFileName;
    if FileExists(sFilePatchName) then begin
      LoadMapList:=TStringList.Create;
      LoadMapList.LoadFromFile(sFilePatchName);
      for I := 0 to LoadMapList.Count - 1 do begin
        LoadList.Add(LoadMapList.Strings[I]);
      end;
      LoadMapList.Free;
    end;
  end;
{$ENDIF}

var
{$IFDEF UseTXT}
  sFileName:String;

  LoadList:TStringList;
  sLineText:String;

  sData,sMapNo,sMapNameLine,sMapFileName,sDMapNO,sServerIndex:String;
  nSMapX,nSMapY,nDMapX,nDMapY:Integer;

  sMapInfoFile:String;
{$ELSE}
  nIdx: Integer;
{$ENDIF}
  sCaption: String;
  i:Integer;
  sFlag,s34,s38,sMapName,sMapDesc,sReConnectMap:String;
  nServerIndex:Integer;
  MapFlag:TMapFlag;
  QuestNPC:TMerchant;
{$IFNDEF UseTXT}
ResourceString
  sSQLString = 'SELECT * FROM TBL_MAPINFO';
{$ENDIF}
begin
  sCaption := FrmMain.Caption;
  Result:= -1;
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
  {$IFDEF UseTXT}
    sFileName:=g_Config.sEnvirDir + 'MapInfo.txt';
    if FileExists(sFileName) then begin
      LoadList:=TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      if LoadList.Count < 0 then begin
        LoadList.Free;
        exit;
      end;
      I:=0;
      while (True) do begin
        if I >= LoadList.Count then break;
        if CompareLStr('loadmapinfo',LoadList.Strings[I],Length('loadmapinfo')) then begin
          sMapInfoFile:=GetValidStr3(LoadList.Strings[I], sLineText, [' ', #9]);
          LoadList.Delete(I);
          if sMapInfoFile <> '' then begin
            LoadSubMapInfo(LoadList,sMapInfoFile);
          end;
        end;
        Inc(I);
      end;
      Result:=1;

      for i:=0 to LoadList.Count -1 do begin
        sLineText:=LoadList.Strings[i];
        if (sLineText <> '') and (sLineText[1] = '[') then begin
          sMapName:='';
          MapFlag.boSAFE:=False;
          sLineText:=ArrestStringEx(sLineText,'[',']',sMapNameLine);
          sMapDesc:=GetValidStrCap(sMapNameLine,sMapFileName,[' ', ',', #9]);
          sMapFileName:=GetValidStr3(sMapFileName,sMapName,['|']);
          if sMapFileName = '' then sMapFileName:=sMapName;
            
          if (sMapDesc <> '') and (sMapDesc[1] = '"') then
              ArrestStringEx(sMapDesc,'"','"',sMapDesc);
          sServerIndex:=Trim(GetValidStr3(sMapDesc,sMapDesc,[' ', ',', #9]));
          nServerIndex:=Str_ToInt(sServerIndex,0);
          if sMapName = '' then Continue;


          FillChar(MapFlag,SizeOf(TMapFlag),#0);
          MapFlag.nL:=1;
          QuestNPC:=nil;
          MapFlag.nNEEDSETONFlag:= -1;
          MapFlag.nNeedONOFF:= -1;
          MapFlag.nMUSICID:=-1;
          MapFlag.nGuildTerritory:=-1; // Sergiu

          FrmMain.Caption:=sCaption + '[处理地图:'+sMapName+' ('+inttostr(I+1)+'/'+inttostr(LoadList.Count)+')';

          sFlag := sLineText;
    {$ELSE}
      try
      UseSQL();
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
      MiniMapList.Clear;
      BigMapList.Clear;
      try
        Query.Open;
      except
        Result:= -2;
      end;
      for i:=0 to Query.RecordCount -1 do begin
        sMapName      := Trim(Query.FieldByName('FLD_MAPFILENAME').AsString);
        sMapDesc      := Trim(Query.FieldByName('FLD_MAPNAME').AsString);
        sFlag         := Trim(Query.FieldByName('FLD_FLAGS').AsString);
        nServerIndex  := Query.FieldByName('FLD_SERVERINDEX').AsInteger;
        
        if sMapName = '' then begin
          Query.Next;
          Continue;
        end;
        FrmMain.Caption:=sCaption + '[处理地图:'+sMapName+' ('+inttostr(I+1)+'/'+inttostr(Query.RecordCount)+')';
  //      FrmMain.MemoLog.Lines.Add(' -> Adding Map: '+sMapName+' ('+inttostr(I+1)+'/'+inttostr(Query.RecordCount)+')');
        nIdx          := Query.FieldByName('FLD_MINIMAP').AsInteger;
        if nIdx > 0 then
          MiniMapList.AddObject(sMapName,TObject(nIdx));

     nIdx          := Query.FieldByName('FLD_BIGMAP').AsInteger;
      if nIdx > 0 then
        BigMapList.AddObject(sMapName,TObject(nIdx));

  
    {$ENDIF}

      FillChar(MapFlag,SizeOf(TMapFlag),#0);
      MapFlag.nL:=1;
      QuestNPC:=nil;
      MapFlag.boSAFE:=False;
      MapFlag.nNEEDSETONFlag:= -1;
      MapFlag.nNeedONOFF:= -1;
      MapFlag.nMUSICID:=-1;
      MapFlag.nGuildTerritory:=-1;

      while (True) do begin
        if sFlag = '' then break;
        sFlag:=GetValidStr3(sFlag,s34,[' ', ',', #9]);
        if s34 = '' then break;

        if CompareText(s34,'SAFE') = 0 then begin
          MapFlag.boSAFE:=True;
          Continue;
        end;
        if CompareText(s34,'DARK') = 0 then begin
          MapFlag.boDarkness:=True;
          Continue;
        end;
        if CompareText(s34,'FIGHT') = 0 then begin
          MapFlag.boFightZone:=True;
          Continue;
        end;
        if CompareText(s34,'FIGHT3') = 0 then begin
          MapFlag.boFight3Zone:=True;
          Continue;
        end;
        if CompareText(s34,'DAY') = 0 then begin
          MapFlag.boDayLight:=True;
          Continue;
        end;
        if CompareText(s34,'QUIZ') = 0 then begin
          MapFlag.boQUIZ:=True;
          Continue;
        end;
        if CompareLStr(s34,'NORECONNECT',length('NORECONNECT')) then begin
          MapFlag.boNORECONNECT:=True;
          ArrestStringEx(s34,'(',')',sReConnectMap);
          MapFlag.sNoReConnectMap:=sReConnectMap;
          if MapFlag.sNoReConnectMap = '' then Result:= -11;
          Continue;
        end;
        if CompareLStr(s34,'CHECKQUEST',length('CHECKQUEST')) then begin
          ArrestStringEx(s34,'(',')',s38);
          QuestNPC:=LoadMapQuest(s38);
          Continue;
        end;
        if CompareLStr(s34,'NEEDSET_ON',length('NEEDSET_ON')) then begin
          MapFlag.nNeedONOFF:=1;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nNEEDSETONFlag:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'NEEDSET_OFF',length('NEEDSET_OFF')) then begin
          MapFlag.nNeedONOFF:=0;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nNEEDSETONFlag:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'MUSIC',length('MUSIC')) then begin
          MapFlag.boMUSIC:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nMUSICID:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'EXPRATE',length('EXPRATE')) then begin
          MapFlag.boEXPRATE:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nEXPRATE:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'PKWINLEVEL',length('PKWINLEVEL')) then begin
          MapFlag.boPKWINLEVEL:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nPKWINLEVEL:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'PKWINEXP',length('PKWINEXP')) then begin
          MapFlag.boPKWINEXP:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nPKWINEXP:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'PKLOSTLEVEL',length('PKLOSTLEVEL')) then begin
          MapFlag.boPKLOSTLEVEL:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nPKLOSTLEVEL:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'PKLOSTEXP',length('PKLOSTEXP')) then begin
          MapFlag.boPKLOSTEXP:=True;
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nPKLOSTEXP:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'DECHP',length('DECHP')) then begin
          MapFlag.boDECHP:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nDECHPPOINT:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nDECHPTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'INCHP',length('INCHP')) then begin
          MapFlag.boINCHP:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nINCHPPOINT:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nINCHPTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'DECGAMEGOLD',length('DECGAMEGOLD')) then begin
          MapFlag.boDECGAMEGOLD:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nDECGAMEGOLD:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nDECGAMEGOLDTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'DECGAMEPOINT',length('DECGAMEPOINT')) then begin
          MapFlag.boDECGAMEPOINT:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nDECGAMEPOINT:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nDECGAMEPOINTTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'INCGAMEGOLD',length('INCGAMEGOLD')) then begin
          MapFlag.boINCGAMEGOLD:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nINCGAMEGOLD:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nINCGAMEGOLDTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'INCGAMEPOINT',length('INCGAMEPOINT')) then begin
          MapFlag.boINCGAMEPOINT:=True;
          ArrestStringEx(s34,'(',')',s38);

          MapFlag.nINCGAMEPOINT:=Str_ToInt(GetValidStr3(s38,s38,['/']),-1);
          MapFlag.nINCGAMEPOINTTIME:=Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareText(s34,'RUNHUMAN') = 0 then begin
          MapFlag.boRUNHUMAN:= True;
          Continue;
        end;
        if CompareText(s34,'RUNMON') = 0 then begin
          MapFlag.boRUNMON:= True;
          Continue;
        end;
        if CompareText(s34,'NEEDHOLE') = 0 then begin
          MapFlag.boNEEDHOLE := True;
          Continue;
        end;
        if CompareText(s34,'NORECALL') = 0 then begin
          MapFlag.boNORECALL := True;
          Continue;
        end;
        if CompareText(s34,'NOGUILDRECALL') = 0 then begin
          MapFlag.boNOGUILDRECALL := True;
          Continue;
        end;
        if CompareText(s34,'NODEARRECALL') = 0 then begin
          MapFlag.boNODEARRECALL := True;
          Continue;
        end;
        if CompareText(s34,'NOMASTERRECALL') = 0 then begin
          MapFlag.boNOMASTERRECALL := True;
          Continue;
        end;
        if CompareText(s34,'NORANDOMMOVE') = 0 then begin
          MapFlag.boNORANDOMMOVE := True;
          Continue;
        end;
        if CompareText(s34,'NODRUG') = 0 then begin
          MapFlag.boNODRUG := True;
          Continue;
        end;
        if CompareText(s34,'MINE') = 0 then begin
          MapFlag.boMINE := True;
          Continue;
        end;
        if CompareText(s34,'MINE2') = 0 then begin
          MapFlag.boMINE2 := True;
          Continue;
        end;
        if CompareText(s34,'MINE3') = 0 then begin
          MapFlag.boMINE3 := True;
          Continue;
        end;
        if CompareText(s34,'NOTHROWITEM') = 0 then begin
          MapFlag.boNOTHROWITEM := True;
          Continue;
        end;
        if CompareText(s34,'NODROPITEM') = 0 then begin
          MapFlag.boNODROPITEM := True;
          Continue;
        end;

        if CompareText(s34,'NOPOSITIONMOVE') = 0 then begin
          MapFlag.boNOPOSITIONMOVE := True;
          Continue;
        end;

        if CompareText(s34,'NOHORSE') = 0 then begin
          MapFlag.boNOHORSE := True;
          Continue;
        end;
        if CompareText(s34,'NOCHAT') = 0 then begin
          MapFlag.boNOCHAT := True;
          Continue;
        end;
        if (s34[1] = 'L') then begin
          MapFlag.nL:= Str_ToInt(Copy(s34,2,Length(s34) -1),1);
        end;
        if CompareLStr(s34,'THUNDER',length('THUNDER')) then begin
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nThunder := Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'LAVA',length('LAVA')) then begin
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nLava := Str_ToInt(s38,-1);
          Continue;
        end;
        if CompareLStr(s34,'GT',length('GT')) then begin
          ArrestStringEx(s34,'(',')',s38);
          MapFlag.nGuildTerritory := Str_ToInt(s38,-1);
          if g_GuildTerritory.FindGuildTerritory(MapFlag.nGuildTerritory) = nil then
            g_GuildTerritory.AddEmptyGT(MapFlag.nGuildTerritory);
          Continue;
        end;
      end;

      if g_MapManager.AddMapInfo(sMapName,sMapDesc,nServerIndex,@MapFlag,QuestNPC) = nil then Result:= -10;
      Result := 1;
{$IFDEF UseTXT}
        end;
      end;

      sData := s34;

      for i:=0 to LoadList.Count -1 do begin
        sLineText:=LoadList.Strings[i];
        if (sLineText <> '') and (sLineText[1] <> '[') and (sLineText[1] <> ';') then begin
            sLineText:=GetValidStr3(sLineText,sData,[' ', ',', #9]);
            sMapName:=sData;
            sLineText:=GetValidStr3(sLineText,sData,[' ', ',', #9]);
            nSMapX:=Str_ToInt(sData,0);
            sLineText:=GetValidStr3(sLineText,sData,[' ', ',', #9]);
            nSMapY:=Str_ToInt(sData,0);
            sLineText:=GetValidStr3(sLineText,sData,[' ', ',','-','>', #9]);
            sDMapNO:=sData;
            sLineText:=GetValidStr3(sLineText,sData,[' ', ',', #9]);
            nDMapX:=Str_ToInt(sData,0);
            sLineText:=GetValidStr3(sLineText,sData,[' ', ',',';', #9]);
            nDMapY:=Str_ToInt(sData,0);
            g_MapManager.AddMapRoute(sMapName,nSMapX,nSMapY,sDMapNO,nDMapX,nDMapY);
        end;
      end;
      LoadList.Free;
   end;
{$ELSE}
      Query.Next;
    end;
  finally
    Query.Close;
  end;

{$ENDIF}
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  FrmMain.Caption:=sCaption;
  {$IFNDEF UseTXT}
    LoadMapRoute();
  {$ENDIF}
end;

{$IFDEF UseTXT}
function TFrmDB.LoadMinMap():Integer;
var
  sFileName,tStr,sMapNO,sMapIdx:String;
  tMapList:TStringList;
  i,nIdx:Integer;
begin
  Result:=0;
  sFileName:=g_Config.sEnvirDir + 'MiniMap.txt';
  if FileExists(sFileName) then begin
    MiniMapList.Clear;
    tMapList:=TStringList.Create;
    tMapList.LoadFromFile(sFileName);
    for i:=0 to tMapList.Count -1 do begin
      tStr:=tMapList.Strings[i];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr:=GetValidStr3(tStr, sMapNO, [' ', #9]);
        tStr:=GetValidStr3(tStr, sMapIdx, [' ', #9]);
        nIdx:=Str_ToInt(sMapIdx,0);
        if nIdx > 0 then
          MiniMapList.AddObject(sMapNO,TObject(nIdx));
      end;
    end;
    g_MapManager.ReSetMinMap(); //Sergiu
    tMapList.Free;
  end;
end;

function TFrmDB.LoadBigMap():Integer;
var
  sFileName,tStr,sMapNO,sMapIdx:String;
  tMapList:TStringList;
  i,nIdx:Integer;
begin
  Result:=0;
  sFileName:=g_Config.sEnvirDir + 'BigMap.txt';
  if FileExists(sFileName) then begin
    BigMapList.Clear;
    tMapList:=TStringList.Create;
    tMapList.LoadFromFile(sFileName);
    for i:=0 to tMapList.Count -1 do begin
      tStr:=tMapList.Strings[i];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr:=GetValidStr3(tStr, sMapNO, [' ', #9]);
        tStr:=GetValidStr3(tStr, sMapIdx, [' ', #9]);
        nIdx:=Str_ToInt(sMapIdx,0);
        if nIdx > 0 then
          BigMapList.AddObject(sMapNO,TObject(nIdx));
      end;
    end;
    g_MapManager.ReSetBigMap();
    tMapList.Free;
  end;
end;

{$ELSE}
function TFrmDB.LoadMapRoute():Integer;
var
  i,nSMapX,nSMapY,nDMapX,nDMapY:Integer;
  sSMapNO,sDMapNO:String;
ResourceString
  sSQLString = 'SELECT * FROM TBL_MOVEMAPEVENT';
begin
  Result:= -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
  try
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
      Result:= -2;
    end;
    for i:=0 to Query.RecordCount -1 do begin
      sSMapNO       := Trim(Query.FieldByName('FLD_SMAPFILENAME').AsString);
      nSMapX        := Query.FieldByName('FLD_SX').AsInteger;
      nSMapY        := Query.FieldByName('FLD_SY').AsInteger;
      sDMapNO       := Trim(Query.FieldByName('FLD_DMAPFILENAME').AsString);
      nDMapX        := Query.FieldByName('FLD_DX').AsInteger;
      nDMapY        := Query.FieldByName('FLD_DY').AsInteger;

      g_MapManager.AddMapRoute(sSMapNO,nSMapX,nSMapY,sDMapNO,nDMapX,nDMapY);

      Result := 1;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
{$ENDIF}

procedure TFrmDB.QFunctionNPC;
var
  sScriptFile :String;
  sScritpDir  :String;
  SaveList    :TStringList;
  sShowFile   :String;
begin
try
  sScriptFile:=g_Config.sEnvirDir + sMarket_Def + 'QFunction-0.txt';
  sShowFile:=ReplaceChar(sScriptFile,'\','/');
  sScritpDir:=g_Config.sEnvirDir + sMarket_Def;
  if not DirectoryExists(sScritpDir) then
    mkdir(Pchar(sScritpDir));

  if not FileExists(sScriptFile) then begin
    SaveList:=TStringList.Create;
    SaveList.Add(';QFunctions');
    SaveList.SaveToFile(sScriptFile);
    SaveList.Free;
  end;
  if FileExists(sScriptFile) then begin
    g_FunctionNPC:=TMerchant.Create;
    g_FunctionNPC.m_sMapName  := '0';
    g_FunctionNPC.m_nCurrX    := 0;
    g_FunctionNPC.m_nCurrY    := 0;
    g_FunctionNPC.m_sCharName := 'QFunction';
    g_FunctionNPC.m_nFlag     := 0;
    g_FunctionNPC.m_wAppr     := 0;
    g_FunctionNPC.m_sFilePath := sMarket_Def;
    g_FunctionNPC.m_sScript   := 'QFunction';
    g_FunctionNPC.m_boIsHide  := True;
    g_FunctionNPC.m_boIsQuest := False;
    UserEngine.AddMerchant(g_FunctionNPC);
  end else begin
    g_FunctionNPC:=nil;
  end;
except
  g_FunctionNPC:=nil;
end;
end;

procedure TFrmDB.QMangeNPC();
var
  sScriptFile :String;
  sScritpDir  :String;
  SaveList    :TStringList;
  sShowFile   :String;
begin
try
  sScriptFile:=g_Config.sEnvirDir + 'MapQuest_def\' + 'QManage.txt';
  sShowFile:=ReplaceChar(sScriptFile,'\','/');
  sScritpDir:=g_Config.sEnvirDir + 'MapQuest_def\';
  if not DirectoryExists(sScritpDir) then
    mkdir(Pchar(sScritpDir));

  if not FileExists(sScriptFile) then begin
    SaveList:=TStringList.Create;
    SaveList.Add(';QManage');
    SaveList.SaveToFile(sScriptFile);
    SaveList.Free;
  end;
  if FileExists(sScriptFile) then begin
    g_ManageNPC:=TMerchant.Create;
    g_ManageNPC.m_sMapName:='0';
    g_ManageNPC.m_nCurrX:=0;
    g_ManageNPC.m_nCurrY:=0;
    g_ManageNPC.m_sCharName:='QManage';
    g_ManageNPC.m_nFlag:=0;
    g_ManageNPC.m_wAppr:=0;
    g_ManageNPC.m_sFilePath:='MapQuest_def\';
    g_ManageNPC.m_boIsHide:=True;
    g_ManageNPC.m_boIsQuest:=False;
    UserEngine.QuestNPCList.Add(g_ManageNPC);
  end else begin
    g_ManageNPC:=nil;
  end;
except
  g_ManageNPC:=nil;
end;
end;
procedure TFrmDB.RobotNPC();
var
  sScriptFile:String;
  sScritpDir :String;
  tSaveList:TStringList;
begin
try
  sScriptFile:=g_Config.sEnvirDir + 'Robot_def\' + 'RobotManage.txt';
  sScritpDir:=g_Config.sEnvirDir + 'Robot_def\';
  if not DirectoryExists(sScritpDir) then
    mkdir(Pchar(sScritpDir));

  if not FileExists(sScriptFile) then begin
    tSaveList:=TStringList.Create;
    tSaveList.Add(';Robot');
    tSaveList.SaveToFile(sScriptFile);
    tSaveList.Free;
  end;
  if FileExists(sScriptFile) then begin
    g_RobotNPC:=TMerchant.Create;
    g_RobotNPC.m_sMapName:='0';
    g_RobotNPC.m_nCurrX:=0;
    g_RobotNPC.m_nCurrY:=0;
    g_RobotNPC.m_sCharName:='RobotManage';
    g_RobotNPC.m_nFlag:=0;
    g_RobotNPC.m_wAppr:=0;
    g_RobotNPC.m_sFilePath:='Robot_def\';
    g_RobotNPC.m_boIsHide:=True;
    g_RobotNPC.m_boIsQuest:=False;
    UserEngine.QuestNPCList.Add(g_RobotNPC);
  end else begin
    g_RobotNPC:=nil;
  end;
except
  g_RobotNPC:=nil;
end;
end;

(*function LoadShopItemList(): Integer;
var
  I: Integer;
  sFileName: string;
  LoadList: Classes.TStringList;
  sLineText: string;
  sItemName: string;
  sPrice: string;
  sIntroduce: string;
  nPrice: Integer;
  StdItem: pTSTDITEM;
  ShopInfo: pTShopInfo;
  sName: string;
begin
  {if g_GameShopItemList <> nil then begin
    UnLoadShopItemList();
  end; }
  g_GameShopItemList := Classes.TList.Create();
  sFileName := '.\BuyItemList.txt';
  if not FileExists(sFileName) then begin
    LoadList := Classes.TStringList.Create();
    LoadList.Add(';引擎插件商铺配置文件');
    LoadList.Add(';物品名称'#9'出售价格'#9'描述');
    LoadList.SaveToFile(sFileName);
    LoadList.Free;
    Exit;
  end;
  g_GameShopItemList.Clear;
  LoadList := Classes.TStringList.Create();
  LoadList.LoadFromFile(sFileName);
  for I := 0 to LoadList.Count - 1 do begin
    sLineText := LoadList.Strings[I];
    if (sLineText <> '') and (sLineText[1] <> ';') then begin
      SetLength(sIntroduce, 50);
      sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sPrice, [' ', #9]);
      sLineText := GetValidStr3(sLineText, sIntroduce, [' ', #9]);
      nPrice := Str_ToInt(sPrice, -1);
      if (sItemName <> '') and (nPrice >= 0) and (sIntroduce <> '') then begin
        //StdItem := TUserEngine_GetStdItemByName(PChar(sItemName));
        if StdItem <> nil then begin
          New(ShopInfo);
          ShopInfo.StdItem := StdItem;
          ShopInfo.StdItem.Price := nPrice * 100;
          FillChar(ShopInfo.sIntroduce, SizeOf(ShopInfo.sIntroduce), 0);
          Move(sIntroduce[1], ShopInfo.sIntroduce, Length(sIntroduce));
          g_GameShopItemList.Add(ShopInfo);
        end;
      end;
    end;
  end;
  LoadList.Free;
end;
*)
function TFrmDB.LoadMapEvent(): Integer;
var
  sFileName, tStr: string;
  tMapEventList: TStringList;
  I: Integer;
  s18, s1C, s20, s24, s28, s2C, s30, s34, s36, s38, s40, s42, s44, s46, sRange: string;
  MapEvent: pTMapEvent;
  Map: TEnvirnoment;
begin
  Result := 1;
  sFileName := g_Config.sEnvirDir + 'MapEvent.txt';
  if FileExists(sFileName) then begin
    tMapEventList := TStringList.Create;
    tMapEventList.LoadFromFile(sFileName);
    for I := 0 to tMapEventList.Count - 1 do begin
      tStr := tMapEventList.Strings[I];
      if (tStr <> '') and (tStr[1] <> ';') then begin
        tStr := GetValidStr3(tStr, s18, [' ', #9]);
        tStr := GetValidStr3(tStr, s1C, [' ', #9]);
        tStr := GetValidStr3(tStr, s20, [' ', #9]);
        tStr := GetValidStr3(tStr, sRange, [' ', #9]);
        tStr := GetValidStr3(tStr, s24, [' ', #9]);
        tStr := GetValidStr3(tStr, s28, [' ', #9]);
        tStr := GetValidStr3(tStr, s2C, [' ', #9]);
        tStr := GetValidStr3(tStr, s30, [' ', #9]);
        if (s18 <> '') and (s1C <> '') and (s20 <> '') and (s30 <> '') then begin
          Map := g_MapManager.FindMap(s18);
          if Map <> nil then begin
            New(MapEvent);
            FillChar(MapEvent.m_MapFlag, SizeOf(TQuestUnitStatus), 0);
            FillChar(MapEvent.m_Condition, SizeOf(TMapCondition), #0);
            FillChar(MapEvent.m_StartScript, SizeOf(TStartScript), #0);
            MapEvent.m_sMapName := Trim(s18);
            MapEvent.m_nCurrX := Str_ToInt(s1C, 0);
            MapEvent.m_nCurrY := Str_ToInt(s20, 0);
            MapEvent.m_nRange := Str_ToInt(sRange, 0);
            s24 := GetValidStr3(s24, s34, [':', #9]);
            s24 := GetValidStr3(s24, s36, [':', #9]);
            MapEvent.m_MapFlag.nQuestUnit := Str_ToInt(s34, 0);
            if Str_ToInt(s36, 0) <> 0 then MapEvent.m_MapFlag.boOpen := True
            else MapEvent.m_MapFlag.boOpen := False;
            s28 := GetValidStr3(s28, s38, [':', #9]);
            s28 := GetValidStr3(s28, s40, [':', #9]);
            s28 := GetValidStr3(s28, s42, [':', #9]);
            MapEvent.m_Condition.nHumStatus := Str_ToInt(s38, 0);
            MapEvent.m_Condition.sItemName := Trim(s40);
            if Str_ToInt(s42, 0) <> 0 then MapEvent.m_Condition.boNeedGroup := True
            else MapEvent.m_Condition.boNeedGroup := False;
            MapEvent.m_nRandomCount := Str_ToInt(s2C, 999999);
            s30 := GetValidStr3(s30, s44, [':', #9]);
            s30 := GetValidStr3(s30, s46, [':', #9]);
            MapEvent.m_StartScript.nLable := Str_ToInt(s44, 0);
            MapEvent.m_StartScript.sLable := Trim(s46);
            case MapEvent.m_Condition.nHumStatus of
              1: g_MapEventListOfDropItem.Add(MapEvent);
              2: g_MapEventListOfPickUpItem.Add(MapEvent);
              3: g_MapEventListOfMine.Add(MapEvent);
              4: g_MapEventListOfWalk.Add(MapEvent);
              5: g_MapEventListOfRun.Add(MapEvent);
            else begin
                Dispose(MapEvent);
              end;
            end;
          end else Result := -I;
        end;
      end;
    end;
  end;
end;

//00489414
function TFrmDB.LoadMapQuest(): Integer;
var
  sFileName,tStr:String;
  tMapQuestList:TStringList;
  i:Integer;
  sMap,s1C,s20,sMonName,sItem,sQuest,s30,s34:String;
  n38,n3C:Integer;
  boGrouped:Boolean;
  Map:TEnvirnoment;
begin
    Result:=1;
    sFileName:=g_Config.sEnvirDir + 'MapQuest.txt';
    if FileExists(sFileName) then begin
      tMapQuestList:=TStringList.Create;
      tMapQuestList.LoadFromFile(sFileName);
      for i:=0 to tMapQuestList.Count -1 do begin
        tStr:=tMapQuestList.Strings[i];
        if (tStr <> '') and (tStr[1] <> ';') then begin
          tStr:=GetValidStr3(tStr, sMap, [' ', #9]);
          tStr:=GetValidStr3(tStr, s1C, [' ', #9]);
          tStr:=GetValidStr3(tStr, s20, [' ', #9]);
          tStr:=GetValidStr3(tStr, sMonName, [' ', #9]);
          if (sMonName <> '') and (sMonName[1] = '"') then
            ArrestStringEx(sMonName,'"','"',sMonName);
          tStr:=GetValidStr3(tStr, sItem, [' ', #9]);
          if (sItem <> '') and (sItem[1] = '"') then
            ArrestStringEx(sItem,'"','"',sItem);
          tStr:=GetValidStr3(tStr, sQuest, [' ', #9]);
          tStr:=GetValidStr3(tStr, s30, [' ', #9]);
          if (sMap <> '') and (sMonName <> '') and (sQuest <> '') then begin
            Map:=g_MapManager.FindMap(sMap);
            if Map <> nil then begin
              ArrestStringEx(s1C,'[',']',s34);
              n38:=Str_ToInt(s34,0);
              n3C:=Str_ToInt(s20,0);
              if CompareLStr(s30,'GROUP',length('GROUP')) then boGrouped:=True
              else boGrouped:=False;
              if not Map.CreateQuest(n38,n3C,sMonName,sItem,sQuest,boGrouped) then Result:= -i;
              //nFlag,boFlag,Monster,Item,Quest,boGrouped
            end else Result:= -i;
          end else Result:= -i;
        end;
      end;
      tMapQuestList.Free;
    end;
    QMangeNPC();
    QFunctionNPC();
    RobotNPC();
end;


function TFrmDB.LoadMerchant(): Integer;
var
{$IFDEF UseTXT}
  sFileName,sLineText,sScript,sMapName,sX,sY,sName,sFlag,sAppr,sIsCalste,sCanMove,sMoveTime:String;
  tMerchantList:TStringList;
  tMerchantNPC:TMerchant;
  i:Integer;
{$ELSE}
  i:Integer;
  boUse:Boolean;
  tMerchantNPC:TMerchant;
ResourceString
  sSQLString = 'SELECT * FROM TBL_MERCHANT';
{$ENDIF}
begin
  Result:= -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
{$IFDEF UseTXT}
    sFileName:=g_Config.sEnvirDir + 'Merchant.txt';
    if FileExists(sFileName) then begin
      tMerchantList:=TStringList.Create;
      tMerchantList.LoadFromFile(sFileName);
      for i:=0 to tMerchantList.Count -1 do begin
        sLineText:=Trim(tMerchantList.Strings[i]);
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sLineText:=GetValidStr3(sLineText, sScript, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sMapName, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sX, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sY, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sName, [' ', #9]);
          if (sName <> '') and (sName[1] = '"') then
            ArrestStringEx(sName,'"','"',sName);
          sLineText:=GetValidStr3(sLineText, sFlag, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sAppr, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sIsCalste, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sCanMove, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sMoveTime, [' ', #9]);

          if (sScript <> '') and (sMapName <> '') and (sAppr <> '') then begin
            tMerchantNPC:=TMerchant.Create;
            tMerchantNPC.m_sScript:=sScript;
            tMerchantNPC.m_sMapName:=sMapName;
            tMerchantNPC.m_nCurrX:=Str_ToInt(sX,0);
            tMerchantNPC.m_nCurrY:=Str_ToInt(sY,0);
            tMerchantNPC.m_sCharName:=sName;
            tMerchantNPC.m_nFlag:=Str_ToInt(sFlag,0);
            tMerchantNPC.m_wAppr:=Str_ToInt(sAppr,0);
            tMerchantNPC.m_dwMoveTime:=Str_ToInt(sMoveTime,0);
            if Str_ToInt(sIsCalste,0) <> 0 then
              tMerchantNPC.m_boCastle:=True;
            if (Str_ToInt(sCanMove,0) <> 0) and (tMerchantNPC.m_dwMoveTime > 0) then
              tMerchantNPC.m_boCanMove:=True;
            UserEngine.AddMerchant(tMerchantNPC); //00487B4D
          end;
        end;
      end;
      tMerchantList.Free;
    end;
    Result:= 1;
{$ELSE}
  try
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
      Result:= -2;
    end;
    for i:=0 to Query.RecordCount -1 do begin
      boUse                       := GetBoolean(Query,'FLD_ENABLED');
      if boUse then begin
        tMerchantNPC:=TMerchant.Create;

        tMerchantNPC.m_sScript      := Query.FieldByName('FLD_SCRIPTFILE').AsString;
        tMerchantNPC.m_sMapName     := Query.FieldByName('FLD_MAPNAME').AsString;
        tMerchantNPC.m_nCurrX       := Query.FieldByName('FLD_X').AsInteger;
        tMerchantNPC.m_nCurrY       := Query.FieldByName('FLD_Y').AsInteger;
        tMerchantNPC.m_sCharName    := Query.FieldByName('FLD_NAME').AsString;
        tMerchantNPC.m_nFlag        := Query.FieldByName('FLD_FLAG').AsInteger;
        tMerchantNPC.m_wAppr        := Query.FieldByName('FLD_APPEARANCE').AsInteger;
        tMerchantNPC.m_boCastle     := GetBoolean(Query,'FLD_ISCASTLE');
        tMerchantNPC.m_boCanMove    := GetBoolean(Query,'FLD_CANMOVE');
        tMerchantNPC.m_dwMoveTime   := Query.FieldByName('FLD_MOVETIME').AsInteger;
        
        if (tMerchantNPC.m_sScript <> '') and (tMerchantNPC.m_sMapName <> '') then
          UserEngine.AddMerchant(tMerchantNPC)
        else
          tMerchantNPC.Free;
      end;

      Result := 1;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
{$ENDIF}
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

//004867F4
function TFrmDB.LoadMonGen(): Integer;
{$IFDEF UseTXT}
  procedure LoadMapGen(MonGenList:TStringList;sFileName:String);
  var
    I: Integer;
    sFilePatchName:String;
    sFileDir:String;
    LoadList:TStringList;
  begin
    sFileDir:=g_Config.sEnvirDir + 'MonGen\';
    if not DirectoryExists(sFileDir) then begin
      CreateDir(sFileDir);
    end;
      
    sFilePatchName:=sFileDir + sFileName;
    if FileExists(sFilePatchName) then begin
      LoadList:=TStringList.Create;
      LoadList.LoadFromFile(sFilePatchName);
      for I := 0 to LoadList.Count - 1 do begin
        MonGenList.Add(LoadList.Strings[I]);
      end;
      LoadList.Free;
    end;
  end;
var
  sFileName,sLineText,sData:String;
  MonGenInfo:pTMonGenInfo;
  LoadList:TStringList;
  sMapGenFile:String;
  i:Integer;
{$ELSE}
var
  i:Integer;
  boLoads:Boolean;
  MonGenInfo:pTMonGenInfo;
ResourceString
  sSQLString = 'SELECT * FROM TBL_MONGEN ORDER BY FLD_MAPNAME';
  {$ENDIF}
begin
  Result:=0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    {$IFDEF UseTXT}
    sFileName:=g_Config.sEnvirDir + 'MonGen.txt';
    if FileExists(sFileName) then begin
      LoadList:=TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      I:=0;
      while (True) do begin
        if I >= LoadList.Count then break;
        if CompareLStr('loadgen',LoadList.Strings[I],Length('loadgen')) then begin
          sMapGenFile:=GetValidStr3(LoadList.Strings[I], sLineText, [' ', #9]);
          LoadList.Delete(I);
          if sMapGenFile <> '' then begin
            LoadMapGen(LoadList,sMapGenFile);
          end;
        end;
        Inc(I);
      end;
      for i:=0 to LoadList.Count -1 do begin
        sLineText:=LoadList.Strings[i];
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          New(MonGenInfo);
          sLineText:=GetValidStr3(sLineText, sData, [' ', #9]);
          MonGenInfo.sMapName:=sData;

          sLineText:=GetValidStr3(sLineText, sData, [' ', #9]);
          MonGenInfo.nX:=Str_ToInt(sData,0);

          sLineText:=GetValidStr3(sLineText, sData, [' ', #9]);
          MonGenInfo.nY:=Str_ToInt(sData,0);

          sLineText:=GetValidStrCap(sLineText, sData, [' ', #9]);
          if (sData <> '') and (sData[1] = '"') then
            ArrestStringEx(sData,'"','"',sData);
            
          MonGenInfo.sMonName:=sData;

          sLineText:=GetValidStr3(sLineText, sData, [' ', #9]);
          MonGenInfo.nRange:=Str_ToInt(sData,0);

          sLineText:=GetValidStr3(sLineText, sData, [' ', #9]);
          MonGenInfo.nCount:=Str_ToInt(sData,0);

          sLineText:=GetValidStr3(sLineText, sData, [' ', #9]);
          MonGenInfo.dwZenTime:=Str_ToInt(sData, -1) * 60 * 1000;

          sLineText:=GetValidStr3(sLineText, sData, [' ', #9]);
          MonGenInfo.nMissionGenRate:=Str_ToInt(sData,0); // 1-100
          if (MonGenInfo.sMapName <> '') and
             (MonGenInfo.sMonName <> '') and
             (MonGenInfo.dwZenTime <> 0) and
             (g_MapManager.GetMapInfo(nServerIndex,MonGenInfo.sMapName) <> nil) then begin

            MonGenInfo.CertList:=TList.Create;
            MonGenInfo.Envir:=g_MapManager.FindMap(MonGenInfo.sMapName);
            if MonGenInfo.Envir <> nil then begin
              UserEngine.m_MonGenList.Add(MonGenInfo);
            end else begin
              Dispose(MonGenInfo);
            end;
          end;
          //tMonGenInfo.nRace:=UserEngine.GetMonRace(tMonGenInfo.sMonName);

        end;//00486B5B
      end;//00486B67
      //00486B67
      New(MonGenInfo);
      MonGenInfo.sMapName:='';
      MonGenInfo.sMonName:='';
      MonGenInfo.CertList:=TList.Create;
      MonGenInfo.Envir:=nil;
      UserEngine.m_MonGenList.Add(MonGenInfo);

      LoadList.Free;
      Result:=1;
    end;      
    {$ELSE}
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
      Result:= -1;
    end;
    for i:=0 to Query.RecordCount -1 do begin
      boLoads                 := GetBoolean(Query,'FLD_LOAD');
      if boLoads then begin
        New(MonGenInfo);
        MonGenInfo.sMapName   := Trim(Query.FieldByName('FLD_MAPNAME').AsString);
        MonGenInfo.nX         := Query.FieldByName('FLD_X').AsInteger;
        MonGenInfo.nY         := Query.FieldByName('FLD_Y').AsInteger;
        MonGenInfo.sMonName   := Trim(Query.FieldByName('FLD_MONNAME').AsString);
        MonGenInfo.nRange     := Query.FieldByName('FLD_RANGE').AsInteger;
        MonGenInfo.nCount     := Query.FieldByName('FLD_COUNT').AsInteger;
        MonGenInfo.dwZenTime  := Query.FieldByName('FLD_GENTIME').AsInteger * 60 * 1000;
        MonGenInfo.nMissionGenRate  := Query.FieldByName('FLD_SMALLGENRATE').AsInteger;

        if (MonGenInfo.sMapName <> '') and
           (MonGenInfo.sMonName <> '') and
           (MonGenInfo.dwZenTime <> 0) and
           (g_MapManager.GetMapInfo(nServerIndex,MonGenInfo.sMapName) <> nil) then begin

          MonGenInfo.CertList:=TList.Create;
          MonGenInfo.Envir:=g_MapManager.FindMap(MonGenInfo.sMapName);
          if MonGenInfo.Envir <> nil then begin
            UserEngine.m_MonGenList.Add(MonGenInfo);
          end else begin
            Dispose(MonGenInfo);
          end;
        end;
      end;

      Result := 1;
      Query.Next;
    end;
    Query.Close;
  {$ENDIF}
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;


//00485E04
function TFrmDB.LoadMonsterDB():Integer;
var
  i:Integer;
  Monster:pTMonInfo;
ResourceString
  sSQLString = 'SELECT * FROM TBL_MONSTER';
begin
  Result:=0;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for I := 0 to UserEngine.MonsterList.Count - 1 do begin
      Dispose(pTMonInfo(UserEngine.MonsterList.Items[I]));
    end;
    UserEngine.MonsterList.Clear;
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
      Result:= -1;
    end;
    for i:=0 to Query.RecordCount -1 do begin
      New(Monster);
      Monster.ItemList     := TList.Create;
      Monster.sName        := Trim(Query.FieldByName('FLD_NAME').AsString);
      Monster.btRace       := Query.FieldByName('FLD_RACE').AsInteger;
      Monster.btRaceImg    := Query.FieldByName('FLD_RACEIMG').AsInteger;
      Monster.wAppr        := Query.FieldByName('FLD_IMGINDEX').AsInteger;
      Monster.wLevel       := Query.FieldByName('FLD_LV').AsInteger;
      Monster.btLifeAttrib := Query.FieldByName('FLD_UNDEAD').AsInteger;
      Monster.wCoolEye     := Query.FieldByName('FLD_COOLEYE').AsInteger;
      Monster.dwExp        := Query.FieldByName('FLD_EXP').AsInteger;

      if Monster.btRace in [110,111] then begin
        Monster.wHP          := Query.FieldByName('FLD_HP').AsInteger;
      end else begin
        Monster.wHP          := ROUND(Query.FieldByName('FLD_HP').AsInteger * (g_Config.nMonsterPowerRate / 10));
      end;

      Monster.wMP          := ROUND(Query.FieldByName('FLD_MP').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wAC          := ROUND(Query.FieldByName('FLD_AC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMAC         := ROUND(Query.FieldByName('FLD_MAC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wDC          := ROUND(Query.FieldByName('FLD_DC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMaxDC       := ROUND(Query.FieldByName('FLD_DCMAX').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wMC          := ROUND(Query.FieldByName('FLD_MC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSC          := ROUND(Query.FieldByName('FLD_SC').AsInteger * (g_Config.nMonsterPowerRate / 10));
      Monster.wSpeed       := Query.FieldByName('FLD_AGILITY').AsInteger;
      Monster.wHitPoint    := Query.FieldByName('FLD_ACCURATE').AsInteger;
      Monster.wWalkSpeed   := _MAX(200,Query.FieldByName('FLD_WALK_SPD').AsInteger);
      Monster.wWalkStep    := _MAX(1,Query.FieldByName('FLD_WALKSTEP').AsInteger);
      Monster.wWalkWait    := Query.FieldByName('FLD_WALKWAIT').AsInteger;
      Monster.wAttackSpeed := Query.FieldByName('FLD_ATTACK_SPD').AsInteger;
      Monster.wAntiPush    := Query.FieldByName('FLD_ATTACK_SPD').AsInteger;
      Monster.boAggro      := Query.FieldByName('FLD_AGGRO').AsBoolean;
      Monster.boTame       := Query.FieldByName('FLD_TAME').AsBoolean;

      if Monster.wWalkSpeed < 200 then Monster.wWalkSpeed:= 200;
      if Monster.wAttackSpeed < 200 then Monster.wAttackSpeed:= 200;
      Monster.ItemList:=nil;
      LoadMonitems(Monster.sName,Monster.ItemList);

      UserEngine.MonsterList.Add(Monster);
      Result := 1;
      Query.Next;
    end;
    Query.Close;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadMonitems(MonName:String;var ItemList:TList):Integer;//00485ABC
var
  I: Integer;
  s24:String;
  LoadList:TStringList;
  MonItem:pTMonItem;
  s28,s2C,s30:String;
  n18,n1C,n20:Integer;
begin
  Result:=0;
  s24:=g_Config.sEnvirDir + 'MonItems\' + MonName + '.txt';
  if FileExists(s24) then begin
    if ItemList <> nil then begin
      for I := 0 to Itemlist.Count - 1 do begin
        DisPose(pTMonItem(ItemList.Items[I]));
      end;
      ItemList.Clear;
    end; //00485B81
    LoadList:=TStringList.Create;
    LoadList.LoadFromFile(s24);
    for I := 0 to LoadList.Count - 1 do begin
      s28:=LoadList.Strings[I];
      if (s28 <> '') and (s28[1] <> ';') then begin
        s28:=GetValidStr3(s28,s30,[' ','/',#9]);
        n18:=Str_ToInt(s30,-1);
        s28:=GetValidStr3(s28,s30,[' ','/',#9]);
        n1C:=Str_ToInt(s30,-1);
        s28:=GetValidStr3(s28,s30,[' ',#9]);
        if s30 <> '' then begin
          if s30[1] = '"' then
            ArrestStringEx(s30,'"','"',s30);
        end;
        s2C:=s30;
        s28:=GetValidStr3(s28,s30,[' ',#9]);
        n20:=Str_ToInt(s30,1);
        if (n18 > 0) and (n1C > 0) and (s2C <> '') then begin
          if ItemList = nil then ItemList:=TList.Create;
          New(MonItem);
          MonItem.SelPoint:=n18 -1;
          MonItem.MaxPoint:=n1C;
          MonItem.ItemName:=s2C;
          MonItem.Count:=n20;
          ItemList.Add(MonItem);
          Inc(Result);
        end;
      end;
    end;
    LoadList.Free;
  end;
    
end;
//00488178
function TFrmDB.LoadNpcs(): Integer;
var
  NPC:TNormNpc;
  i:Integer;
{$IFDEF UseTXT}
  sFileName,s10,s18,s1C,s20,s24,s28,s2C,s30,s34,s38:String;
  LoadList:TStringList;
{$ELSE}
  nType:Integer;
  boUse:Boolean;
ResourceString
  sSQLString = 'SELECT * FROM TBL_NPC';
{$ENDIF}
begin
  Result:= -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
{$IFDEF UseTXT}
    sFileName:=g_Config.sEnvirDir + 'Npcs.txt';
    if FileExists(sFileName) then begin
      LoadList:=TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      for i:=0 to LoadList.Count -1 do begin
        s18:=Trim(LoadList.Strings[i]);
        if (s18 <> '') and (s18[1] <> ';') then begin
          s18:=GetValidStrCap(s18, s20, [' ', #9]);
          if (s20 <> '') and (s20[1] = '"') then
            ArrestStringEx(s20,'"','"',s20);

          s18:=GetValidStr3(s18, s24, [' ', #9]);
          s18:=GetValidStr3(s18, s28, [' ', #9]);
          s18:=GetValidStr3(s18, s2C, [' ', #9]);
          s18:=GetValidStr3(s18, s30, [' ', #9]);
          s18:=GetValidStr3(s18, s34, [' ', #9]);
          s18:=GetValidStr3(s18, s38, [' ', #9]);
          if (s20 <> '') and (s28 <> '') and (s38 <> '') then begin
            NPC:=nil;
            case Str_ToInt(s24,0) of
              0: NPC:=TMerchant.Create;
              1: NPC:=TGuildOfficial.Create;
              2: NPC:=TCastleOfficial.Create;
            end;
            if NPC <> nil then begin
              NPC.m_sMapName:=s28;
              NPC.m_nCurrX:=Str_ToInt(s2C,0);
              NPC.m_nCurrY:=Str_ToInt(s30,0);
              NPC.m_sCharName:=s20;
              NPC.m_nFlag:=Str_ToInt(s34,0);
              NPC.m_wAppr:=Str_ToInt(s38,0);
              UserEngine.QuestNPCList.Add(NPC); //0048847D
            end;
          end;
        end;
      end;
      LoadList.Free;
    end;
    Result:= 1;
{$ELSE}
  try
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
      Result:= -2;
    end;
    for i:=0 to Query.RecordCount -1 do begin
      boUse                       := GetBoolean(Query,'FLD_ENABLED');
      if boUse then begin
        NPC:=nil;

        nType := Query.FieldByName('FLD_TYPE').AsInteger;
        case nType of
          0: NPC:=TMerchant.Create;
          1: NPC:=TGuildOfficial.Create;
          2: NPC:=TCastleOfficial.Create;
        end;
        if NPC <> nil then begin
          NPC.m_sMapName            := Query.FieldByName('FLD_MAPNAME').AsString;
          NPC.m_nCurrX              := Query.FieldByName('FLD_X').AsInteger;
          NPC.m_nCurrY              := Query.FieldByName('FLD_Y').AsInteger;
          NPC.m_sCharName           := Query.FieldByName('FLD_NAME').AsString;
          NPC.m_nFlag               := Query.FieldByName('FLD_FLAG').AsInteger;
          NPC.m_wAppr               := Query.FieldByName('FLD_APPEARANCE').AsInteger;
          UserEngine.QuestNPCList.Add(NPC);
        end;
      end;

      Result := 1;
      Query.Next;
    end;
  finally
    Query.Close;
  end;
  {$ENDIF}
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
//00489840
function TFrmDB.LoadQuestDiary(): Integer;
  function sub_48978C(nIndex:Integer):String;
  begin
    if nIndex >= 1000 then begin
      Result:=IntToStr(nIndex);
      exit;
    end;
    if nIndex >= 100 then begin
      Result:=IntToStr(nIndex) + '0';
      exit;
    end;
    Result:=IntToStr(nIndex) + '00';
  end;
var
  i,ii:Integer;
  QDDinfoList:TList;
  QDDinfo:pTQDDinfo;
  s14,s18,s1C,s20:String;
  bo2D:Boolean;
  nC:Integer;
  LoadList:TStringList;
begin
    Result:=1;
    for i:=0 to QuestDiaryList.Count -1 do begin
       QDDinfoList:=QuestDiaryList.Items[i];
       for ii:=0 to QDDinfoList.Count -1 do begin
         QDDinfo:=QDDinfoList.Items[ii];
         QDDinfo.sList.Free;
         Dispose(QDDinfo);
       end;
       QDDinfoList.Free;
    end;
    QuestDiaryList.Clear;
    bo2D:=False;
    nC:=1;
    while (True) do begin
      QDDinfoList:=nil;
      s14:='QuestDiary\' + sub_48978C(nC) + '.txt';
      if FileExists(s14) then begin
        s18:='';
        QDDinfo:=nil;
        LoadList:=TStringList.Create;
        LoadList.LoadFromFile(s14);
        for i:=0 to LoadList.Count -1 do begin
          s1C:=LoadList.Strings[i];
          if (s1C <> '') and (s1C[1] <> ';') then begin
            if (s1C[1] = '[') and (length(s1C) > 2) then begin
              if s18 = '' then begin
                ArrestStringEx(s1C,'[',']',s18);
                QDDinfoList:=TList.Create;
                New(QDDinfo);
                QDDinfo.n00:=nC;
                QDDinfo.s04:=s18;
                QDDinfo.sList:=TStringList.Create;
                QDDinfoList.Add(QDDinfo);
                bo2D:=True;
              end else begin
                if s1C[1] <> '@' then begin
                  s1C:=GetValidStr3(s1C,s20,[' ',#9]);
                  ArrestStringEx(s20,'[',']',s20);
                  New(QDDinfo);
                  QDDinfo.n00:=Str_ToInt(s20,0);
                  QDDinfo.s04:=s1C;
                  QDDinfo.sList:=TStringList.Create;
                  QDDinfoList.Add(QDDinfo);
                  bo2D:=True;
                end else bo2D:=False;
              end;
            end else begin //00489AFD
              if bo2D then QDDinfo.sList.Add(s1C);
            end;
          end;//00489B11
        end;
        LoadList.Free;
      end;//00489B25
      if QDDinfoList <> nil then QuestDiaryList.Add(QDDinfoList)
      else QuestDiaryList.Add(nil);
      Inc(nC);
      if nC >= 105 then break;
    end;

end;
//00488EF0
function TFrmDB.LoadStartPoint(): Integer;
var
  i:Integer;
  StartPoint:pTStartPoint;
{$IFDEF UseTXT}
  sFileName,sLineText,sMapName,sX,sY:String;
  LoadList:TStringList;
{$ELSE}
  sMap:String;
ResourceString
  sSQLString = 'SELECT * FROM TBL_STARTPOINT';
  {$ENDIF}
begin
  Result:= -1;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
{$IFDEF UseTXT}
  sFileName:=g_Config.sEnvirDir + 'StartPoint.txt';
  if FileExists(sFileName) then begin
    g_StartPoint.Lock;
    try
      for I := 0 to g_StartPoint.Count - 1 do begin
        Dispose(pTStartPoint(g_StartPoint.Items[I]));
      end;
      g_StartPoint.Clear;
//      g_StartPointList.Lock;
//      g_StartPointList.Clear;
      LoadList:=TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      for i:=0 to LoadList.Count -1 do begin
        sLineText:=Trim(LoadList.Strings[i]);
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sLineText:=GetValidStr3(sLineText, sMapName, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sX, [' ', #9]);
          sLineText:=GetValidStr3(sLineText, sY, [' ', #9]);
          if (sMapName <> '')  and (sX <> '') and (sY <> '')then begin
            New(StartPoint);
            StartPoint.sMapName:=sMapName;
            StartPoint.nX:=Str_ToInt(sX,0);
            StartPoint.nY:=Str_ToInt(sY,0);
            StartPoint.Envir:=g_MapManager.FindMap(sMapName);
            StartPoint.dwWhisperTick:=GetTickCount();
            g_StartPoint.Add(StartPoint);
//            g_StartPointList.AddObject(sMapName,TObject(MakeLong(Str_ToInt(sX,0),Str_ToInt(sY,0))));
            Result:=1;
          end;
        end;
      end;
      LoadList.Free;
    finally
      g_StartPoint.UnLock;
//      g_StartPointList.UnLock;
    end;
  end;
{$ELSE}
    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    except
      Result:= -2;
    end;

    try
      g_StartPoint.Lock;
      for I := 0 to g_StartPoint.Count - 1 do begin
        Dispose(pTStartPoint(g_StartPoint.Items[I]));
      end;
      g_StartPoint.Clear;

      for i:=0 to Query.RecordCount -1 do begin
        sMap                          := Query.FieldByName('FLD_MAPNAME').AsString;
        if (sMap <> '') then begin
          New(StartPoint);
          StartPoint.sMapName         := sMap;
          StartPoint.nX               := Query.FieldByName('FLD_X').AsInteger;
          StartPoint.nY               := Query.FieldByName('FLD_Y').AsInteger;
          StartPoint.Envir            := g_MapManager.FindMap(sMap);
          StartPoint.btJob            := 99;
          StartPoint.dwWhisperTick    := GetTickCount();
          g_StartPoint.Add(StartPoint);
          Result:=1;
        end;
        Query.Next;
      end;
    finally
      g_StartPoint.UnLock;
    end;
    Query.Close;
  {$ENDIF}
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;
//00489240
function TFrmDB.LoadUnbindList(): Integer;
var
  sFileName,tStr,sData,s20:String;
  LoadList:TStringList;
  i:Integer;
  n10:Integer;
begin
    Result:=0;
    sFileName:=g_Config.sEnvirDir + 'UnbindList.txt';
    if FileExists(sFileName) then begin
      LoadList:=TStringList.Create;
      LoadList.LoadFromFile(sFileName);
      for i:=0 to LoadList.Count -1 do begin
        tStr:=LoadList.Strings[i];
        if (tStr <> '') and (tStr[1] <> ';') then begin
          tStr:=GetValidStr3(tStr, sData, [' ', #9]);
          tStr:=GetValidStrCap(tStr, s20, [' ', #9]);
          if (s20 <> '') and (s20[1] = '"') then
            ArrestStringEx(s20,'"','"',s20);

          n10:=Str_ToInt(sData,0);
          if n10 > 0 then g_UnbindList.AddObject(s20,TObject(n10))
          else begin
            Result:=-i;
            break;
          end;
        end;
      end;
      LoadList.Free;
    end;
end;

function TFrmDB.LoadNpcScript(NPC: TNormNpc; sPatch,
  sScritpName: String): Integer; //0048C4D8
begin
  if sPatch = '' then sPatch:=sNpc_def;
  Result:=LoadScriptFile(NPC,sPatch,sScritpName,False);
end;

function TFrmDB.LoadScriptFile(NPC: TNormNpc; sPatch, sScritpName: String;
  boFlag: Boolean): Integer; //0048B684
var
  nQuestIdx,I,n1C,n20,n24,nItemType,nPriceRate: Integer;
  n6C,n70:Integer;
  sScritpFileName,s30,s34,s38,s3C,s40,s44,s48,s4C,s50:String;
  LoadList:TStringList;
  DefineList:TList;
  s54,s58,s5C,sLabel:String;
  DefineInfo:pTDefineInfo;
  bo8D:Boolean;
  Script:pTScript;
  SayingRecord:pTSayingRecord;
  SayingProcedure:pTSayingProcedure;
  QuestConditionInfo:pTQuestConditionInfo;
  QuestActionInfo:pTQuestActionInfo;
  Goods:pTGoods;
  function LoadCallScript(sFileName,sLabel:String;List:TStringList):Boolean; //00489BD4
  var
    I: Integer;
    LoadStrList:TStringList;
    bo1D:Boolean;
    s18:String;
  begin
    Result:=False;
    if FileExists(sFileName) then begin
      LoadStrList:=TStringList.Create;
      LoadStrList.LoadFromFile(sFileName);
      DeCodeStringList(LoadStrList);
      sLabel:='[' + sLabel + ']';
      bo1D:=False;
      for I := 0 to LoadStrList.Count - 1 do begin
        s18:=Trim(LoadStrList.Strings[i]);
        if s18 <> '' then begin
          if not bo1D then begin
            if (s18[1] = '[') and (CompareText(s18,sLabel) = 0) then begin
              bo1D:=True;
              List.Add(s18);
            end;              
          end else begin //00489CBF
            if s18[1] <> '{'  then begin
              if s18[1] = '}'  then begin
                bo1D:=False;
                Result:=True;
                break;
              end else begin  //00489CD9
                List.Add(s18);
              end;
            end;
          end;
        end; //00489CE4 if s18 <> '' then begin
      end; // for I := 0 to LoadStrList.Count - 1 do begin
      LoadStrList.Free;
    end;
      
  end;
  procedure LoadScriptcall(LoadList:TStringList); //0048B138
  var
    I: Integer;
    s14,s18,s1C,s20,s34:String;
  begin
    for I := 0 to LoadList.Count - 1 do begin
      s14:=Trim(LoadList.Strings[i]);
      if (s14 <> '') and (s14[1] = '#') and (CompareLStr(s14,'#CALL',length('#CALL'))) then begin
        s14:=ArrestStringEx(s14,'[',']',s1C);
        s20:=Trim(s1C);
        s18:=Trim(s14);
        s34:=g_Config.sEnvirDir + 'QuestDiary\' + s20;
        if LoadCallScript(s34,s18,LoadList) then begin
          LoadList.Strings[i]:='#ACT';
          LoadList.Insert(i + 1,'goto ' + s18);
        end else begin
          MainOutMessage('script error, load fail: ' + s20 + s18);
        end;
      end;
    end;
  end;

  function LoadDefineInfo(LoadList:TStringList;List:TList):String; //0048B35C
  var
    I: Integer;
    s14,s28,s1C,s20,s24:String;
    DefineInfo:pTDefineInfo;
    LoadStrList:TStringList;
  begin
    for I := 0 to LoadList.Count - 1 do begin
      s14:=Trim(LoadList.Strings[i]);
      if (s14 <> '') and (s14[1] = '#') then begin
        if CompareLStr(s14,'#SETHOME',length('#SETHOME')) then begin
          Result:=Trim(GetValidStr3(s14,s1C,[' ',#9]));
          LoadList.Strings[i]:='';
        end;
        if CompareLStr(s14,'#DEFINE',length('#DEFINE')) then begin
          s14:=(GetValidStr3(s14,s1C,[' ',#9]));
          s14:=(GetValidStr3(s14,s20,[' ',#9]));
          s14:=(GetValidStr3(s14,s24,[' ',#9]));
          New(DefineInfo);
          DefineInfo.sName:=UpperCase(s20);
          DefineInfo.sText:=s24;
          List.Add(DefineInfo);
          LoadList.Strings[i]:='';
        end; //0048B505
        if CompareLStr(s14,'#INCLUDE',length('#INCLUDE')) then begin
          s28:=Trim(GetValidStr3(s14,s1C,[' ',#9]));
          s28:=g_Config.sEnvirDir + 'Defines\' + s28;
          if FileExists(s28) then begin
            LoadStrList:=TStringList.Create;
            LoadStrList.LoadFromFile(s28);
            Result:=LoadDefineInfo(LoadStrList,List);
            LoadStrList.Free;
          end else begin
            MainOutMessage('script error, load fail: ' + s28);
          end;
          LoadList.Strings[i]:='';
        end;
      end;
    end;
  end;
  function MakeNewScript():pTScript; //00489D74
  var
    ScriptInfo:pTScript;
  begin
    New(ScriptInfo);
    ScriptInfo.boQuest:=False;
    FillChar(ScriptInfo.QuestInfo,SizeOf(TQuestInfo),#0);
    nQuestIdx:=0;
    ScriptInfo.RecordList:=TList.Create;
    NPC.m_ScriptList.Add(ScriptInfo);
    Result:=ScriptInfo;
  end;
  function QuestCondition(sText:String;QuestConditionInfo:pTQuestConditionInfo):Boolean; //00489DDC
  var
    sCmd,sParam1,sParam2,sParam3,sParam4,sParam5,sParam6:String;
    nCMDCode:Integer;
  Label L001;
  begin
    Result:=False;
    sText:=GetValidStrCap(sText,sCmd,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam1,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam2,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam3,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam4,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam5,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam6,[' ',#9]);
    sCmd:=UpperCase(sCmd);
    nCMDCode:=0;
    if sCmd = sCHECK then begin
      nCMDCode:=nCHECK;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
      Goto L001;
    end;
    if sCmd = sCHECKOPEN then begin
      nCMDCode:=nCHECKOPEN;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
      Goto L001;
    end;

    if sCmd = sCHECKUNIT then begin
      nCMDCode:=nCHECKUNIT;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
      Goto L001;
    end;
    if sCmd = sCHECKPKPOINT then begin
      nCMDCode:=nCHECKPKPOINT;
      Goto L001;
    end;
    if sCmd = sCHECKGOLD then begin
      nCMDCode:=nCHECKGOLD;
      Goto L001;
    end;
    if sCmd = sCHECKLEVEL then begin
      nCMDCode:=nCHECKLEVEL;
      Goto L001;
    end;
    if sCmd = sCHECKJOB then begin
      nCMDCode:=nCHECKJOB;
      Goto L001;
    end;
    if sCmd = sRANDOM then begin //00489FB2
      nCMDCode:=nRANDOM;
      Goto L001;
    end;
    if sCmd = sCHECKITEM then begin
      nCMDCode:=nCHECKITEM;
      Goto L001;
    end;
    if sCmd = sGENDER then begin
      nCMDCode:=nGENDER;
      Goto L001;
    end;
    if sCmd = sCHECKBAGGAGE then begin
      nCMDCode:=nCHECKBAGGAGE;
      Goto L001;
    end;

    if sCmd = sCHECKNAMELIST then begin
      nCMDCode:=nCHECKNAMELIST;
      Goto L001;
    end;
    if sCmd = sSC_HASGUILD then begin
      nCMDCode:=nSC_HASGUILD;
      Goto L001;
    end;

    if sCmd = sSC_ISGUILDMASTER then begin
      nCMDCode:=nSC_ISGUILDMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEMASTER then begin
      nCMDCode:=nSC_CHECKCASTLEMASTER;
      Goto L001;
    end;
    if sCmd = sSC_ISNEWHUMAN then begin
      nCMDCode:=nSC_ISNEWHUMAN;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERTYPE then begin
      nCMDCode:=nSC_CHECKMEMBERTYPE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMEMBERLEVEL then begin
      nCMDCode:=nSC_CHECKMEMBERLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGAMEGOLD then begin
      nCMDCode:=nSC_CHECKGAMEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGAMEPOINT then begin
      nCMDCode:=nSC_CHECKGAMEPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKNAMELISTPOSITION then begin
      nCMDCode:=nSC_CHECKNAMELISTPOSITION;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGUILDLIST then begin
      nCMDCode:=nSC_CHECKGUILDLIST;
      Goto L001;
    end;
    if sCmd = sSC_CHECKRENEWLEVEL then begin
      nCMDCode:=nSC_CHECKRENEWLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSLAVELEVEL then begin
      nCMDCode:=nSC_CHECKSLAVELEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSLAVENAME then begin
      nCMDCode:=nSC_CHECKSLAVENAME;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCREDITPOINT then begin
      nCMDCode:=nSC_CHECKCREDITPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKOFGUILD then begin
      nCMDCode:=nSC_CHECKOFGUILD;
      Goto L001;
    end;
    if sCmd = sSC_CHECKPAYMENT then begin
      nCMDCode:=nSC_CHECKPAYMENT;
      Goto L001;
    end;

    if sCmd = sSC_CHECKUSEITEM then begin
      nCMDCode:=nSC_CHECKUSEITEM;
      Goto L001;
    end;
    if sCmd = sSC_CHECKBAGSIZE then begin
      nCMDCode:=nSC_CHECKBAGSIZE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKLISTCOUNT then begin
      nCMDCode:=nSC_CHECKLISTCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKDC then begin
      nCMDCode:=nSC_CHECKDC;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMC then begin
      nCMDCode:=nSC_CHECKMC;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSC then begin
      nCMDCode:=nSC_CHECKSC;
      Goto L001;
    end;
    if sCmd = sSC_CHECKHP then begin
      nCMDCode:=nSC_CHECKHP;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMP then begin
      nCMDCode:=nSC_CHECKMP;
      Goto L001;
    end;
    if sCmd = sSC_CHECKITEMTYPE then begin
      nCMDCode:=nSC_CHECKITEMTYPE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKEXP then begin
      nCMDCode:=nSC_CHECKEXP;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEGOLD then begin
      nCMDCode:=nSC_CHECKCASTLEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_PASSWORDERRORCOUNT then begin
      nCMDCode:=nSC_PASSWORDERRORCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_ISLOCKPASSWORD then begin
      nCMDCode:=nSC_ISLOCKPASSWORD;
      Goto L001;
    end;
    if sCmd = sSC_ISLOCKSTORAGE then begin
      nCMDCode:=nSC_ISLOCKSTORAGE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKBUILDPOINT then begin
      nCMDCode:=nSC_CHECKBUILDPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKAURAEPOINT then begin
      nCMDCode:=nSC_CHECKAURAEPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSTABILITYPOINT then begin
      nCMDCode:=nSC_CHECKSTABILITYPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKFLOURISHPOINT then begin
      nCMDCode:=nSC_CHECKFLOURISHPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCONTRIBUTION then begin
      nCMDCode:=nSC_CHECKCONTRIBUTION;
      Goto L001;
    end;
    if sCmd = sSC_CHECKRANGEMONCOUNT then begin
      nCMDCode:=nSC_CHECKRANGEMONCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKITEMADDVALUE then begin
      nCMDCode:=nSC_CHECKITEMADDVALUE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKINMAPRANGE then begin
      nCMDCode:=nSC_CHECKINMAPRANGE;
      Goto L001;
    end;
    if sCmd = sSC_CASTLECHANGEDAY then begin
      nCMDCode:=nSC_CASTLECHANGEDAY;
      Goto L001;
    end;
    if sCmd = sSC_CASTLEWARDAY then begin
      nCMDCode:=nSC_CASTLEWARDAY;
      Goto L001;
    end;
    if sCmd = sSC_ONLINELONGMIN then begin
      nCMDCode:=nSC_ONLINELONGMIN;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGUILDCHIEFITEMCOUNT then begin
      nCMDCode:=nSC_CHECKGUILDCHIEFITEMCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKNAMEDATELIST then begin
      nCMDCode:=nSC_CHECKNAMEDATELIST;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMAPHUMANCOUNT then begin
      nCMDCode:=nSC_CHECKMAPHUMANCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMAPMONCOUNT then begin
      nCMDCode:=nSC_CHECKMAPMONCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKVAR then begin
      nCMDCode:=nSC_CHECKVAR;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSERVERNAME then begin
      nCMDCode:=nSC_CHECKSERVERNAME;
      Goto L001;
    end;

    if sCmd = sSC_ISATTACKGUILD then begin
      nCMDCode:=nSC_ISATTACKGUILD;
      Goto L001;
    end;
    if sCmd = sSC_ISDEFENSEGUILD then begin
      nCMDCode:=nSC_ISDEFENSEGUILD;
      Goto L001;
    end;

    if sCmd = sSC_ISATTACKALLYGUILD then begin
      nCMDCode:=nSC_ISATTACKALLYGUILD;
      Goto L001;
    end;
    if sCmd = sSC_ISDEFENSEALLYGUILD then begin
      nCMDCode:=nSC_ISDEFENSEALLYGUILD;
      Goto L001;
    end;

    if sCmd = sSC_ISCASTLEGUILD then begin
      nCMDCode:=nSC_ISCASTLEGUILD;
      Goto L001;
    end;
    if sCmd = sSC_CHECKCASTLEDOOR then begin
      nCMDCode:=nSC_CHECKCASTLEDOOR;
      Goto L001;
    end;

    if sCmd = sSC_ISSYSOP then begin
      nCMDCode:=nSC_ISSYSOP;
      Goto L001;
    end;
    if sCmd = sSC_ISADMIN then begin
      nCMDCode:=nSC_ISADMIN;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGROUPCOUNT then begin
      nCMDCode:=nSC_CHECKGROUPCOUNT;
      Goto L001;
    end;

    if sCmd = sCHECKACCOUNTLIST then begin
      nCMDCode:=nCHECKACCOUNTLIST;
      Goto L001;
    end;
    if sCmd = sCHECKIPLIST then begin
      nCMDCode:=nCHECKIPLIST;
      Goto L001;
    end;
    if sCmd = sCHECKBBCOUNT then begin
      nCMDCode:=nCHECKBBCOUNT;
      Goto L001;
    end;
    if sCmd = sCHECKCREDITPOINT then begin
      nCMDCode:=nCHECKCREDITPOINT;
      Goto L001;
    end;

    if sCmd = sDAYTIME then begin
      nCMDCode:=nDAYTIME;
      Goto L001;
    end;
    if sCmd = sCHECKITEMW then begin
      nCMDCode:=nCHECKITEMW;
      Goto L001;
    end;
    if sCmd = sISTAKEITEM then begin
      nCMDCode:=nISTAKEITEM;
      Goto L001;
    end;
    if sCmd = sCHECKDURA then begin
      nCMDCode:=nCHECKDURA;
      Goto L001;
    end;
    if sCmd = sCHECKDURAEVA then begin
      nCMDCode:=nCHECKDURAEVA;
      Goto L001;
    end;
    if sCmd = sDAYOFWEEK then begin
      nCMDCode:=nDAYOFWEEK;
      Goto L001;
    end;
    if sCmd = sHOUR then begin
      nCMDCode:=nHOUR;
      Goto L001;
    end;
    if sCmd = sMIN then begin
      nCMDCode:=nMIN;
      Goto L001;
    end;
    if sCmd = sCHECKLUCKYPOINT then begin
      nCMDCode:=nCHECKLUCKYPOINT;
      Goto L001;
    end;
    if sCmd = sCHECKMONMAP then begin
      nCMDCode:=nCHECKMONMAP;
      Goto L001;
    end;
    if sCmd = sCHECKMONAREA then begin
      nCMDCode:=nCHECKMONAREA;
      Goto L001;
    end;
    if sCmd = sCHECKHUM then begin
      nCMDCode:=nCHECKHUM;
      Goto L001;
    end;
    if sCmd = sEQUAL then begin
      nCMDCode:=nEQUAL;
      Goto L001;
    end;

    if sCmd = sLARGE then begin
      nCMDCode:=nLARGE;
      Goto L001;
    end;

    if sCmd = sSMALL then begin
      nCMDCode:=nSMALL;
      Goto L001;
    end;

    if sCmd = sSC_CHECKPOSEDIR then begin
      nCMDCode:=nSC_CHECKPOSEDIR;
      Goto L001;
    end;

    if sCmd = sSC_CHECKPOSELEVEL then begin
      nCMDCode:=nSC_CHECKPOSELEVEL;
      Goto L001;
    end;

    if sCmd = sSC_CHECKPOSEGENDER then begin
      nCMDCode:=nSC_CHECKPOSEGENDER;
      Goto L001;
    end;

    if sCmd = sSC_CHECKLEVELEX then begin
      nCMDCode:=nSC_CHECKLEVELEX;
      Goto L001;
    end;

    if sCmd = sSC_CHECKBONUSPOINT then begin
      nCMDCode:=nSC_CHECKBONUSPOINT;
      Goto L001;
    end;

    if sCmd = sSC_CHECKMARRY then begin
      nCMDCode:=nSC_CHECKMARRY;
      Goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMARRY then begin
      nCMDCode:=nSC_CHECKPOSEMARRY;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMARRYCOUNT then begin
      nCMDCode:=nSC_CHECKMARRYCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMASTER then begin
      nCMDCode:=nSC_CHECKMASTER;
      Goto L001;
    end;
    if sCmd = sSC_HAVEMASTER then begin
      nCMDCode:=nSC_HAVEMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKPOSEMASTER then begin
      nCMDCode:=nSC_CHECKPOSEMASTER;
      Goto L001;
    end;
    if sCmd = sSC_POSEHAVEMASTER then begin
      nCMDCode:=nSC_POSEHAVEMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKISMASTER then begin
      nCMDCode:=nSC_CHECKISMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKPOSEISMASTER then begin
      nCMDCode:=nSC_CHECKPOSEISMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CHECKNAMEIPLIST then begin
      nCMDCode:=nSC_CHECKNAMEIPLIST;
      Goto L001;
    end;
    if sCmd = sSC_CHECKACCOUNTIPLIST then begin
      nCMDCode:=nSC_CHECKACCOUNTIPLIST;
      Goto L001;
    end;
    if sCmd = sSC_CHECKSLAVECOUNT then begin
      nCMDCode:=nSC_CHECKSLAVECOUNT;
      Goto L001;
    end;

    if sCmd = sSC_CHECKPOS then begin
      nCMDCode:=nSC_CHECKPOS;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMAP then begin
      nCMDCode:=nSC_CHECKMAP;
      Goto L001;
    end;
    if sCmd = sSC_REVIVESLAVE then begin
      nCMDCode:=nSC_REVIVESLAVE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKMAGIC then begin
      nCMDCode:=nSC_CHECKMAGIC;
      Goto L001;
    end;
    if sCmd = sSC_CHKMAGICLEVEL then begin
      nCMDCode:=nSC_CHKMAGICLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHECKHORSE then begin
      nCMDCode:=nSC_CHECKHORSE;
      Goto L001;
    end;
    if sCmd = sSC_CHECKRIDING then begin
      nCMDCode:=nSC_CHECKRIDING;
      Goto L001;
    end;
    if sCmd = sSC_CHECKGROUPCLASS then begin
      nCMDCode:=nSC_CHECKGROUPCLASS;
      Goto L001;
    end;
    if sCmd = sSC_RANDOMEX then begin
      nCMDCode:=nSC_RANDOMEX;
      Goto L001;
    end;
    if sCmd = sSC_INSAFEZONE then begin
      nCMDCode := nSC_INSAFEZONE;
      Goto L001;
    end;
    if sCmd = sSC_ISGROUPMASTER then begin
      nCMDCode := nSC_ISGROUPMASTER;
      Goto L001;
    end;
    //------------------------------


    L001:
    if nCMDCode > 0 then begin
      QuestConditionInfo.nCmdCode:=nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1,'"','"',sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2,'"','"',sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3,'"','"',sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4,'"','"',sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5,'"','"',sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6,'"','"',sParam6);
      end;
      QuestConditionInfo.sParam1:=sParam1;
      QuestConditionInfo.sParam2:=sParam2;
      QuestConditionInfo.sParam3:=sParam3;
      QuestConditionInfo.sParam4:=sParam4;
      QuestConditionInfo.sParam5:=sParam5;
      QuestConditionInfo.sParam6:=sParam6;
      if IsStringNumber(sParam1) then
        QuestConditionInfo.nParam1:=Str_ToInt(sParam1,0);
      if IsStringNumber(sParam2) then
        QuestConditionInfo.nParam2:=Str_ToInt(sParam2,0);
      if IsStringNumber(sParam3) then
        QuestConditionInfo.nParam3:=Str_ToInt(sParam3,0);
      if IsStringNumber(sParam4) then
        QuestConditionInfo.nParam4:=Str_ToInt(sParam4,0);
      if IsStringNumber(sParam5) then
        QuestConditionInfo.nParam5:=Str_ToInt(sParam5,0);
      if IsStringNumber(sParam6) then
        QuestConditionInfo.nParam6:=Str_ToInt(sParam6,0);
      Result:=True;
    end;
      
  end;
  function QuestAction(sText:String;QuestActionInfo:pTQuestActionInfo):Boolean; //0048A640
  var
    sCmd,sParam1,sParam2,sParam3,sParam4,sParam5,sParam6:String;
    nCMDCode:Integer;
  Label L001;
  begin
    Result:=False;
    sText:=GetValidStrCap(sText,sCmd,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam1,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam2,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam3,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam4,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam5,[' ',#9]);
    sText:=GetValidStrCap(sText,sParam6,[' ',#9]);
    sCmd:=UpperCase(sCmd);
    nCmdCode:=0;
    if sCmd = sSET then begin
      nCMDCode:=nSET;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;

    if sCmd = sRESET then begin
      nCMDCode:=nRESET;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;
    if sCmd = sSETOPEN then begin
      nCMDCode:=nSETOPEN;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;
    if sCmd = sSETUNIT then begin
      nCMDCode:=nSETUNIT;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;
    if sCmd = sRESETUNIT then begin
      nCMDCode:=nRESETUNIT;
      ArrestStringEx(sParam1,'[',']',sParam1);
      if not IsStringNumber(sParam1) then nCMDCode:=0;
      if not IsStringNumber(sParam2) then nCMDCode:=0;
    end;
    if sCmd = sTAKE then begin
      nCMDCode:=nTAKE;
      Goto L001;
    end;
    if sCmd = sSC_GIVE then begin
      nCMDCode:=nSC_GIVE;
      Goto L001;
    end;
    if sCmd = sCLOSE then begin
      nCMDCode:=nCLOSE;
      Goto L001;
    end;
    if sCmd = sBREAK then begin
      nCMDCode:=nBREAK;
      Goto L001;
    end;
    if sCmd = sGOTO then begin
      nCMDCode:=nGOTO;
      Goto L001;
    end;
    if sCmd = sADDNAMELIST then begin
      nCMDCode:=nADDNAMELIST;
      Goto L001;
    end;
    if sCmd = sDELNAMELIST then begin
      nCMDCode:=nDELNAMELIST;
      Goto L001;
    end;
    if sCmd = sADDGUILDLIST then begin
      nCMDCode:=nADDGUILDLIST;
      Goto L001;
    end;         
    if sCmd = sDELGUILDLIST then begin
      nCMDCode:=nDELGUILDLIST;
      Goto L001;
    end;
    if sCmd = sSC_MAPTING then begin
      nCMDCode:=nSC_MAPTING;
      Goto L001;
    end;
    if sCmd = sSC_LINEMSG then begin
      nCMDCode:=nSC_LINEMSG;
      Goto L001;
    end;

    if sCmd = sADDACCOUNTLIST then begin
      nCMDCode:=nADDACCOUNTLIST;
      Goto L001;
    end;
    if sCmd = sDELACCOUNTLIST then begin
      nCMDCode:=nDELACCOUNTLIST;
      Goto L001;
    end;
    if sCmd = sADDIPLIST then begin
      nCMDCode:=nADDIPLIST;
      Goto L001;
    end;
    if sCmd = sDELIPLIST then begin
      nCMDCode:=nDELIPLIST;
      Goto L001;
    end;
    if sCmd = sSENDMSG then begin
      nCMDCode:=nSENDMSG;
      Goto L001;
    end;
    if sCmd = sCHANGEMODE then begin
      nCMDCode:=nCHANGEMODE;
      Goto L001;
    end;
    if sCmd = sPKPOINT then begin
      nCMDCode:=nPKPOINT;
      Goto L001;
    end;
    if sCmd = sCHANGEXP then begin
      nCMDCode:=nCHANGEXP;
      Goto L001;
    end;
    if sCmd = sSC_RECALLMOB then begin
      nCMDCode:=nSC_RECALLMOB;
      Goto L001;
    end;
    if sCmd = sKICK then begin
      nCMDCode:=nKICK;
      Goto L001;
    end;
    if sCmd = sTAKEW then begin
      nCMDCode:=nTAKEW;
      Goto L001;
    end;
    if sCmd = sTIMERECALL then begin
      nCMDCode:=nTIMERECALL;
      Goto L001;
    end;
    if sCmd = sSC_PARAM1 then begin
      nCMDCode:=nSC_PARAM1;
      Goto L001;
    end;
    if sCmd = sSC_PARAM2 then begin
      nCMDCode:=nSC_PARAM2;
      Goto L001;
    end;
    if sCmd = sSC_PARAM3 then begin
      nCMDCode:=nSC_PARAM3;
      Goto L001;
    end;
    if sCmd = sSC_PARAM4 then begin
      nCMDCode:=nSC_PARAM4;
      Goto L001;
    end;
    if sCmd = sSC_EXEACTION then begin
      nCMDCode:=nSC_EXEACTION;
      Goto L001;
    end;
    
    if sCmd = s_GETAUCTIONITEMS then begin
      nCMDCode:= n_GETAUCTIONITEMS;
      Goto L001;
    end;

    if sCmd = s_CLOSEAUCTION then begin
      nCMDCode:= n_CLOSEAUCTION;
      Goto L001;
    end;

    if sCmd = sMAPMOVE then begin
      nCMDCode:=nMAPMOVE;
      Goto L001;
    end;
    if sCmd = sGTMAPMOVE then begin
      nCMDCode:=nGTMAPMOVE;
      Goto L001;
    end;
    if sCmd = sMAP then begin
      nCMDCode:=nMAP;
      Goto L001;
    end;
    if sCmd = sTAKECHECKITEM then begin
      nCMDCode:=nTAKECHECKITEM;
      Goto L001;
    end;
    if sCmd = sMONGEN then begin
      nCMDCode:=nMONGEN;
      Goto L001;
    end;
    if sCmd = sMONCLEAR then begin
      nCMDCode:=nMONCLEAR;
      Goto L001;
    end;
    if sCmd = sMOV then begin
      nCMDCode:=nMOV;
      Goto L001;
    end;
    if sCmd = sINC then begin
      nCMDCode:=nINC;
      Goto L001;
    end;
    if sCmd = sDEC then begin
      nCMDCode:=nDEC;
      Goto L001;
    end;
    if sCmd = sSUM then begin
      nCMDCode:=nSUM;
      Goto L001;
    end;
    if sCmd = sBREAKTIMERECALL then begin
      nCMDCode:=nBREAKTIMERECALL;
      Goto L001;
    end;

    if sCmd = sMOVR then begin
      nCMDCode:=nMOVR;
      Goto L001;
    end;
    if sCmd = sEXCHANGEMAP then begin
      nCMDCode:=nEXCHANGEMAP;
      Goto L001;
    end;
    if sCmd = sRECALLMAP then begin
      nCMDCode:=nRECALLMAP;
      Goto L001;
    end;
    if sCmd = sADDBATCH then begin
      nCMDCode:=nADDBATCH;
      Goto L001;
    end;
    if sCmd = sBATCHDELAY then begin
      nCMDCode:=nBATCHDELAY;
      Goto L001;
    end;
    if sCmd = sBATCHMOVE then begin
      nCMDCode:=nBATCHMOVE;
      Goto L001;
    end;
    if sCmd = sPLAYDICE then begin
      nCMDCode:=nPLAYDICE;
      Goto L001;
    end;
    if sCmd = sGOQUEST then begin
      nCMDCode:=nGOQUEST;
      Goto L001;
    end;
    if sCmd = sENDQUEST then begin
      nCMDCode:=nENDQUEST;
      Goto L001;
    end;
    if sCmd = sSC_HAIRCOLOR then begin
      nCMDCode:=nSC_HAIRCOLOR;
      Goto L001;
    end;
    if sCmd = sSC_WEARCOLOR then begin
      nCMDCode:=nSC_WEARCOLOR;
      Goto L001;
    end;
    if sCmd = sSC_HAIRSTYLE then begin
      nCMDCode:=nSC_HAIRSTYLE;
      Goto L001;
    end;
    if sCmd = sSC_MONRECALL then begin
      nCMDCode:=nSC_MONRECALL;
      Goto L001;
    end;
    if sCmd = sSC_HORSECALL then begin
      nCMDCode:=nSC_HORSECALL;
      Goto L001;
    end;
    if sCmd = sSC_HAIRRNDCOL then begin
      nCMDCode:=nSC_HAIRRNDCOL;
      Goto L001;
    end;
    if sCmd = sSC_KILLHORSE then begin
      nCMDCode:=nSC_KILLHORSE;
      Goto L001;
    end;
    if sCmd = sSC_RANDSETDAILYQUEST then begin
      nCMDCode:=nSC_RANDSETDAILYQUEST;
      Goto L001;
    end;


    if sCmd = sSC_CHANGELEVEL then begin
      nCMDCode:=nSC_CHANGELEVEL;
      Goto L001;
    end;
    if sCmd = sSC_MARRY then begin
      nCMDCode:=nSC_MARRY;
      Goto L001;
    end;
    if sCmd = sSC_UNMARRY then begin
      nCMDCode:=nSC_UNMARRY;
      Goto L001;
    end;
    if sCmd = sSC_GETMARRY then begin
      nCMDCode:=nSC_GETMARRY;
      Goto L001;
    end;
    if sCmd = sSC_GETMASTER then begin
      nCMDCode:=nSC_GETMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CLEARSKILL then begin
      nCMDCode:=nSC_CLEARSKILL;
      Goto L001;
    end;
    if sCmd = sSC_DELNOJOBSKILL then begin
      nCMDCode:=nSC_DELNOJOBSKILL;
      Goto L001;
    end;
    if sCmd = sSC_DELSKILL then begin
      nCMDCode:=nSC_DELSKILL;
      Goto L001;
    end;
    if sCmd = sSC_ADDSKILL then begin
      nCMDCode:=nSC_ADDSKILL;
      Goto L001;
    end;
    if sCmd = sSC_SKILLLEVEL then begin
      nCMDCode:=nSC_SKILLLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEPKPOINT then begin
      nCMDCode:=nSC_CHANGEPKPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEEXP then begin
      nCMDCode:=nSC_CHANGEEXP;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEJOB then begin
      nCMDCode:=nSC_CHANGEJOB;
      Goto L001;
    end;
    if sCmd = sSC_MISSION then begin
      nCMDCode:=nSC_MISSION;
      Goto L001;
    end;
    if sCmd = sSC_MOBPLACE then begin
      nCMDCode:=nSC_MOBPLACE;
      Goto L001;
    end;
    if sCmd = sSC_SETMEMBERTYPE then begin
      nCMDCode:=nSC_SETMEMBERTYPE;
      Goto L001;
    end;
    if sCmd = sSC_SETMEMBERLEVEL then begin
      nCMDCode:=nSC_SETMEMBERLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_GAMEGOLD then begin
      nCMDCode:=nSC_GAMEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_GAMEPOINT then begin
      nCMDCode:=nSC_GAMEPOINT;
      Goto L001;
    end;
    if sCmd = sSC_PKZONE then begin
      nCMDCode:=nSC_PKZONE;
      Goto L001;
    end;
    if sCmd = sSC_RESTBONUSPOINT then begin
      nCMDCode:=nSC_RESTBONUSPOINT;
      Goto L001;
    end;
    if sCmd = sSC_TAKECASTLEGOLD then begin
      nCMDCode:=nSC_TAKECASTLEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_HUMANHP then begin
      nCMDCode:=nSC_HUMANHP;
      Goto L001;
    end;
    if sCmd = sSC_HUMANMP then begin
      nCMDCode:=nSC_HUMANMP;
      Goto L001;
    end;
    if sCmd = sSC_BUILDPOINT then begin
      nCMDCode:=nSC_BUILDPOINT;
      Goto L001;
    end;
    if sCmd = sSC_AURAEPOINT then begin
      nCMDCode:=nSC_AURAEPOINT;
      Goto L001;
    end;
    if sCmd = sSC_STABILITYPOINT then begin
      nCMDCode:=nSC_STABILITYPOINT;
      Goto L001;
    end;
    if sCmd = sSC_FLOURISHPOINT then begin
      nCMDCode:=nSC_FLOURISHPOINT;
      Goto L001;
    end;
    if sCmd = sSC_OPENMAGICBOX then begin
      nCMDCode:=nSC_OPENMAGICBOX;
      Goto L001;
    end;
    if sCmd = sSC_SETRANKLEVELNAME then begin
      nCMDCode:=nSC_SETRANKLEVELNAME;
      Goto L001;
    end;
    if sCmd = sSC_GMEXECUTE then begin
      nCMDCode:=nSC_GMEXECUTE;
      Goto L001;
    end;
    if sCmd = sSC_GUILDCHIEFITEMCOUNT then begin
      nCMDCode:=nSC_GUILDCHIEFITEMCOUNT;
      Goto L001;
    end;
    if sCmd = sSC_ADDNAMEDATELIST then begin
      nCMDCode:=nSC_ADDNAMEDATELIST;
      Goto L001;
    end;
    if sCmd = sSC_DELNAMEDATELIST then begin
      nCMDCode:=nSC_DELNAMEDATELIST;
      Goto L001;
    end;
    if sCmd = sSC_MOBFIREBURN then begin
      nCMDCode:=nSC_MOBFIREBURN;
      Goto L001;
    end;
    if sCmd = sSC_MESSAGEBOX then begin
      nCMDCode:=nSC_MESSAGEBOX;
      Goto L001;
    end;
    if sCmd = sSC_SETSCRIPTFLAG then begin
      nCMDCode:=nSC_SETSCRIPTFLAG;
      Goto L001;
    end;
    if sCmd = sSC_SETAUTOGETEXP then begin
      nCMDCode:=nSC_SETAUTOGETEXP;
      Goto L001;
    end;
    if sCmd = sSC_VAR then begin
      nCMDCode:=nSC_VAR;
      Goto L001;
    end;
    if sCmd = sSC_LOADVAR then begin
      nCMDCode:=nSC_LOADVAR;
      Goto L001;
    end;
    if sCmd = sSC_SAVEVAR then begin
      nCMDCode:=nSC_SAVEVAR;
      Goto L001;
    end;
    if sCmd = sSC_CALCVAR then begin
      nCMDCode:=nSC_CALCVAR;
      Goto L001;
    end;
    if sCmd = sSC_AUTOADDGAMEGOLD then begin
      nCMDCode:=nSC_AUTOADDGAMEGOLD;
      Goto L001;
    end;
    if sCmd = sSC_AUTOSUBGAMEGOLD then begin
      nCMDCode:=nSC_AUTOSUBGAMEGOLD;
      Goto L001;
    end;

    if sCmd = sSC_RECALLGROUPMEMBERS then begin
      nCMDCode:=nSC_RECALLGROUPMEMBERS;
      Goto L001;
    end;
    if sCmd = sSC_CLEARNAMELIST then begin
      nCMDCode:=nSC_CLEARNAMELIST;
      Goto L001;
    end;
    if sCmd = sSC_CHANGENAMECOLOR then begin
      nCMDCode:=nSC_CHANGENAMECOLOR;
      Goto L001;
    end;
    if sCmd = sSC_CLEARPASSWORD then begin
      nCMDCode:=nSC_CLEARPASSWORD;
      Goto L001;
    end;
    if sCmd = sSC_RENEWLEVEL then begin
      nCMDCode:=nSC_RENEWLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_KILLMONEXPRATE then begin
      nCMDCode:=nSC_KILLMONEXPRATE;
      Goto L001;
    end;
    if sCmd = sSC_POWERRATE then begin
      nCMDCode:=nSC_POWERRATE;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEMODE then begin
      nCMDCode:=nSC_CHANGEMODE;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEPERMISSION then begin
      nCMDCode:=nSC_CHANGEPERMISSION;
      Goto L001;
    end;
    if sCmd = sSC_KILL then begin
      nCMDCode:=nSC_KILL;
      Goto L001;
    end;
    if sCmd = sSC_KICK then begin
      nCMDCode:=nSC_KICK;
      Goto L001;
    end;
    if sCmd = sSC_BONUSPOINT then begin
      nCMDCode:=nSC_BONUSPOINT;
      Goto L001;
    end;
    if sCmd = sSC_RESTRENEWLEVEL then begin
      nCMDCode:=nSC_RESTRENEWLEVEL;
      Goto L001;
    end;
    if sCmd = sSC_DELMARRY then begin
      nCMDCode:=nSC_DELMARRY;
      Goto L001;
    end;
    if sCmd = sSC_DELMASTER then begin
      nCMDCode:=nSC_DELMASTER;
      Goto L001;
    end;
    if sCmd = sSC_MASTER then begin
      nCMDCode:=nSC_MASTER;
      Goto L001;
    end;
    if sCmd = sSC_UNMASTER then begin
      nCMDCode:=nSC_UNMASTER;
      Goto L001;
    end;
    if sCmd = sSC_CREDITPOINT then begin
      nCMDCode:=nSC_CREDITPOINT;
      Goto L001;
    end;
    if sCmd = sSC_CLEARNEEDITEMS then begin
      nCMDCode:=nSC_CLEARNEEDITEMS;
      Goto L001;
    end;
    if sCmd = sSC_CLEARMAKEITEMS then begin
      nCMDCode:=nSC_CLEARMAEKITEMS;
      Goto L001;
    end;

    if sCmd = sSC_SETSENDMSGFLAG then begin
      nCMDCode:=nSC_SETSENDMSGFLAG;
      Goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMS then begin
      nCMDCode:=nSC_UPGRADEITEMS;
      Goto L001;
    end;
    if sCmd = sSC_UPGRADEITEMSEX then begin
      nCMDCode:=nSC_UPGRADEITEMSEX;
      Goto L001;
    end;
    if sCmd = sSC_MONGENEX then begin
      nCMDCode:=nSC_MONGENEX;
      Goto L001;
    end;
    if sCmd = sSC_CLEARMAPMON then begin
      nCMDCode:=nSC_CLEARMAPMON;
      Goto L001;
    end;

    if sCmd = sSC_SETMAPMODE then begin
      nCMDCode:=nSC_SETMAPMODE;
      Goto L001;
    end;

    if sCmd = sSC_KILLSLAVE then begin
      nCMDCode:=nSC_KILLSLAVE;
      Goto L001;
    end;
    if sCmd = sSC_CHANGEGENDER then begin
      nCMDCode:=nSC_CHANGEGENDER;
      Goto L001;
    end;

    if sCmd = sSC_MAPTING then begin
      nCMDCode:=nSC_MAPTING;
      Goto L001;
    end;

    if sCmd = sSC_GUILDRECALL then begin
      nCMDCode:=nSC_GUILDRECALL;
      Goto L001;
    end;
    if sCmd = sSC_GROUPRECALL then begin
      nCMDCode:=nSC_GROUPRECALL;
      Goto L001;
    end;
    if sCmd = sSC_GROUPADDLIST then begin
      nCMDCode:=nSC_GROUPADDLIST;
      Goto L001;
    end;
    if sCmd = sSC_CLEARLIST then begin
      nCMDCode:=nSC_CLEARLIST;
      Goto L001;
    end;
    if sCmd = sSC_GROUPMOVEMAP then begin
      nCMDCode:=nSC_GROUPMOVEMAP;
      Goto L001;
    end;
    if sCmd = sSC_SAVESLAVES then begin
      nCMDCode:=nSC_SAVESLAVES;
      Goto L001;
    end;

    L001:
    if nCMDCode > 0 then begin
      QuestActionInfo.nCmdCode:=nCMDCode;
      if (sParam1 <> '') and (sParam1[1] = '"') then begin
        ArrestStringEx(sParam1,'"','"',sParam1);
      end;
      if (sParam2 <> '') and (sParam2[1] = '"') then begin
        ArrestStringEx(sParam2,'"','"',sParam2);
      end;
      if (sParam3 <> '') and (sParam3[1] = '"') then begin
        ArrestStringEx(sParam3,'"','"',sParam3);
      end;
      if (sParam4 <> '') and (sParam4[1] = '"') then begin
        ArrestStringEx(sParam4,'"','"',sParam4);
      end;
      if (sParam5 <> '') and (sParam5[1] = '"') then begin
        ArrestStringEx(sParam5,'"','"',sParam5);
      end;
      if (sParam6 <> '') and (sParam6[1] = '"') then begin
        ArrestStringEx(sParam6,'"','"',sParam6);
      end;
      QuestActionInfo.sParam1:=sParam1;
      QuestActionInfo.sParam2:=sParam2;
      QuestActionInfo.sParam3:=sParam3;
      QuestActionInfo.sParam4:=sParam4;
      QuestActionInfo.sParam5:=sParam5;
      QuestActionInfo.sParam6:=sParam6;
      if IsStringNumber(sParam1) then
        QuestActionInfo.nParam1:=Str_ToInt(sParam1,0);
      if IsStringNumber(sParam2) then
        QuestActionInfo.nParam2:=Str_ToInt(sParam2,1);
      if IsStringNumber(sParam3) then
        QuestActionInfo.nParam3:=Str_ToInt(sParam3,1);
      if IsStringNumber(sParam4) then
        QuestActionInfo.nParam4:=Str_ToInt(sParam4,0);
      if IsStringNumber(sParam5) then
        QuestActionInfo.nParam5:=Str_ToInt(sParam5,0);
      if IsStringNumber(sParam6) then
        QuestActionInfo.nParam6:=Str_ToInt(sParam6,0);
      Result:=True;
    end;
  end;
begin   //0048B684
  Result:= -1;
  n6C:=0;
  n70:=0;
  sScritpFileName:=g_Config.sEnvirDir + sPatch + sScritpName + '.txt';
  if FileExists(sScritpFileName) then begin
    LoadList:=TStringList.Create;
    try
      LoadList.LoadFromFile(sScritpFileName);
      DeCodeStringList(LoadList);
    except
      LoadList.Free;
      exit;
    end;
    i:=0;
    while (True) do  begin
      LoadScriptcall(LoadList);
      Inc(i);
      if i >= 101 then break;
    end;    // while
    DefineList:=TList.Create;
    //LoadList.SaveToFile('.\check.txt');
    s54:=LoadDefineInfo(LoadList,DefineList);
    New(DefineInfo);
    DefineInfo.sName:='@HOME';
    if s54 = '' then s54:='@main';
    DefineInfo.sText:=s54;
    DefineList.Add(DefineInfo);
    // 常量处理
    for I := 0 to LoadList.Count - 1 do begin
      s34:=Trim(LoadList.Strings[i]);
      if (s34 <> '') then begin
        if (s34[1] = '[') then begin
          bo8D:=False;
        end else begin //0048B83F
          if (s34[1] = '#') and
             (CompareLStr(s34,'#IF',Length('#IF')) or
              CompareLStr(s34,'#ACT',Length('#ACT')) or
              CompareLStr(s34,'#ELSEACT',Length('#ELSEACT'))) then begin
            bo8D:=True;
          end else begin //0048B895
            if bo8D then begin
              // 将Define 好的常量换成指定值
              for n20 := 0 to DefineList.Count - 1 do begin
                DefineInfo:=DefineList.Items[n20];
                n1C:=0;
                while (True) do  begin
                  n24:=Pos(DefineInfo.sName,UpperCase(s34));
                  if n24 <= 0 then break;
                  s58:=Copy(s34,1,n24 - 1);
                  s5C:=Copy(s34,length(DefineInfo.sName) + n24,256);
                  s34:=s58 + DefineInfo.sText + s5C;
                  LoadList.Strings[i]:=s34;
                  Inc(n1C);
                  if n1C >= 10 then break;
                end;
              end; // 将Define 好的常量换成指定值

            end; //0048B97D
          end;
        end; //0048B97D
      end; //0048B97D if (s34 <> '') then begin
    end; //for I := 0 to LoadList.Count - 1 do begin
    // 常量处理

    //释放常量定义内容
    //0048B98C
    for I := 0 to DefineList.Count - 1 do begin
      Dispose(pTDefineInfo(DefineList.Items[i]));
    end;    // for I := 0 to List64.Count - 1 do begin
    DefineList.Free;
    //释放常量定义内容
    //LoadList.SaveToFile('.\check.txt');

    Script:=nil;
    SayingRecord:=nil;
    nQuestIdx:=0;

    for I := 0 to LoadList.Count - 1 do begin //0048B9FC
      s34:=Trim(LoadList.Strings[i]);
      if (s34 = '') or (s34[1] = ';') or (s34[1] = '/') then Continue;
      if (n6C = 0) and (boFlag) then begin
        //物品价格倍率
        if s34[1] = '%' then begin  //0048BA57
          s34:=Copy(s34,2,Length(s34) - 1);
          nPriceRate:=Str_ToInt(s34,-1);
          if nPriceRate >= 55 then begin
            TMerchant(NPC).m_nPriceRate:=nPriceRate;
          end;
          Continue;
        end;
        //物品交易类型
        if s34[1] = '+' then begin
          s34:=Copy(s34,2,Length(s34) - 1);
          nItemType:=Str_ToInt(s34,-1);
          if nItemType >= 0 then begin
            TMerchant(NPC).m_ItemTypeList.Add(Pointer(nItemType));
          end;
          Continue;
        end;
        //增加处理NPC可执行命令设置
        if s34[1] = '(' then begin
          ArrestStringEx(s34,'(',')',s34);
          if s34 <> '' then begin
            while (s34 <> '') do  begin
              s34:=GetValidStr3(s34,s30,[' ',',',#9]);
              if CompareText(s30,sBUY) = 0 then begin
                TMerchant(NPC).m_boBuy:=True;
                Continue;
              end else if CompareText(s30,sSELL) = 0 then begin
                TMerchant(NPC).m_boSell:=True;
                Continue;
              end else if CompareText(s30,sMAKEDURG) = 0 then begin
                TMerchant(NPC).m_boMakeDrug:=True;
                Continue;
              end else if CompareText(s30,sMAKEGEM) = 0 then begin
                TMerchant(NPC).m_boBuy:=True;
                TMerchant(NPC).m_boMakeGem:=True;
                Continue;
              end else if CompareText(s30,sPRICES) = 0 then begin
                TMerchant(NPC).m_boPrices:=True;
                Continue;
              end else if CompareText(s30,sSTORAGE) = 0 then begin
                TMerchant(NPC).m_boStorage:=True;
                TMerchant(NPC).m_boGetback:=True;
                Continue;
              end else if CompareText(s30,sGETBACK) = 0 then begin
                TMerchant(NPC).m_boGetback:=True;
                Continue;
              end else if CompareText(s30,sCONSIGN) = 0 then begin
                TMerchant(NPC).m_boConsignment:=True;
                Continue;
              end else if CompareText(s30,sUPGRADENOW) = 0 then begin
                TMerchant(NPC).m_boUpgradenow:=True;
                Continue;
              end else if CompareText(s30,sGETBACKUPGNOW) = 0 then begin
                TMerchant(NPC).m_boGetBackupgnow:=True;
                Continue;
              end else if CompareText(s30,sREPAIR) = 0 then begin
                TMerchant(NPC).m_boRepair:=True;
                Continue;
              end else if CompareText(s30,sSUPERREPAIR) = 0 then begin
                TMerchant(NPC).m_boS_repair:=True;
                Continue;
              end else if CompareText(s30,sSL_SENDMSG) = 0 then begin
                TMerchant(NPC).m_boSendmsg:=True;
                Continue;
              end else if CompareText(s30,sUSEITEMNAME) = 0 then begin
                TMerchant(NPC).m_boUseItemName:=True;
                Continue;
              end;

            end;    // while
          end;
          Continue;
        end;
        //增加处理NPC可执行命令设置
      end; //0048BAF0

      if s34[1] = '{' then begin
        if CompareLStr(s34,'{Quest',length('{Quest')) then begin
          s38:=GetValidStr3(s34,s3C,[' ','}',#9]);
          GetValidStr3(s38,s3C,[' ','}',#9]);
          n70:=Str_ToInt(s3C,0);
          Script:=MakeNewScript();
          Script.nQuest:=n70;
          Inc(n70);
        end; //0048BBA4  
        if CompareLStr(s34,'{~Quest',length('{~Quest')) then Continue;
      end; //0048BBBE
      
      if (n6C = 1)and (Script <> nil) and (s34[1] = '#') then begin
        s38:=GetValidStr3(s34,s3C,['=',' ',#9]);
        Script.boQuest:=True;
        if CompareLStr(s34,'#IF',length('#IF')) then begin
          ArrestStringEx(s34,'[',']',s40);
          Script.QuestInfo[nQuestIdx].wFlag:=Str_ToInt(s40,0);
          GetValidStr3(s38,s44,['=',' ',#9]);
          n24:=Str_ToInt(s44,0);
          if n24 <> 0 then n24:=1;
          Script.QuestInfo[nQuestIdx].btValue:=n24;
        end; //0048BCBD

        
        if CompareLStr(s34,'#RAND',length('#RAND')) then begin
          Script.QuestInfo[nQuestIdx].nRandRage:=Str_ToInt(s44,0);
        end;
        Continue;
      end; //0048BCF0

      if s34[1] = '[' then begin
        n6C:=10;
        if Script = nil then  begin
          Script := MakeNewScript();
          Script.nQuest:=n70;
        end;
        if CompareText(s34,'[goods]') = 0 then begin
          n6C:=20;
          Continue;
        end;

        s34:=ArrestStringEx(s34,'[',']',sLabel);
        New(SayingRecord);
        SayingRecord.ProcedureList:=TList.Create;
        SayingRecord.sLabel:=sLabel;
        s34:=GetValidStrCap(s34,sLabel,[' ',#9]);
        if CompareText(sLabel,'TRUE') = 0 then begin
          SayingRecord.boExtJmp:=True;
        end else begin
          SayingRecord.boExtJmp:=False;
        end;
          
        New(SayingProcedure);
        SayingRecord.ProcedureList.Add(SayingProcedure);
        SayingProcedure.ConditionList:=TList.Create;
        SayingProcedure.ActionList:=TList.Create;
        SayingProcedure.sSayMsg:='';
        SayingProcedure.ElseActionList:=TList.Create;
        SayingProcedure.sElseSayMsg:='';
        Script.RecordList.Add(SayingRecord);
        Continue;
      end; //0048BE05
      if (Script <> nil) and (SayingRecord <> nil) then begin
        if (n6C >= 10) and (n6C < 20) and (s34[1] = '#')then begin
          if CompareText(s34,'#IF') = 0 then begin
            if (SayingProcedure.ConditionList.Count > 0) or (SayingProcedure.sSayMsg <> '') then begin  //0048BE53
              New(SayingProcedure);
              SayingRecord.ProcedureList.Add(SayingProcedure);
              SayingProcedure.ConditionList:=TList.Create;
              SayingProcedure.ActionList:=TList.Create;
              SayingProcedure.sSayMsg:='';
              SayingProcedure.ElseActionList:=TList.Create;
              SayingProcedure.sElseSayMsg:='';
            end; //0048BECE
            n6C:=11;
          end; //0048BED5
          if CompareText(s34,'#ACT') = 0 then n6C:=12;
          if CompareText(s34,'#SAY') = 0 then n6C:=10;
          if CompareText(s34,'#ELSEACT') = 0 then n6C:=13;
          if CompareText(s34,'#ELSESAY') = 0 then n6C:=14;
          Continue;
        end; //0048BF3E

        if (n6C = 10) and (SayingProcedure <> nil) then
          SayingProcedure.sSayMsg:=SayingProcedure.sSayMsg + s34;

        if (n6C = 11) then begin
          New(QuestConditionInfo);
          FillChar(QuestConditionInfo^,SizeOf(TQuestConditionInfo),#0);
          if QuestCondition(Trim(s34),QuestConditionInfo) then begin
            SayingProcedure.ConditionList.Add(QuestConditionInfo);
          end else begin
            Dispose(QuestConditionInfo);
            MainOutMessage('Quest problem: ' + s34 + ' Row:' + IntToStr(i) + ' Filename: ' + sScritpFileName);
          end;
        end; //0048C004

        if (n6C = 12) then begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^,SizeOf(TQuestActionInfo),#0);
          if QuestAction(Trim(s34),QuestActionInfo) then begin
            SayingProcedure.ActionList.Add(QuestActionInfo);
          end else begin
            Dispose(QuestActionInfo);
            MainOutMessage('Quest problem: ' + s34 + ' Row:' + IntToStr(i) + ' FileName: ' + sScritpFileName);
          end;
        end; //0048C0B1

        if (n6C = 13) then begin
          New(QuestActionInfo);
          FillChar(QuestActionInfo^,SizeOf(TQuestActionInfo),#0);
          if QuestAction(Trim(s34),QuestActionInfo) then begin
            SayingProcedure.ElseActionList.Add(QuestActionInfo);
          end else begin
            Dispose(QuestActionInfo);
            MainOutMessage('Quest problem: ' + s34 + ' Row:' + IntToStr(i) + ' FileName: ' + sScritpFileName);
          end;
        end;
        if (n6C = 14) then
          SayingProcedure.sElseSayMsg:=SayingProcedure.sElseSayMsg + s34;
      end;
      if (n6C = 20) and boFlag then begin
        s34:=GetValidStrCap(s34,s48,[' ',#9]);
        s34:=GetValidStrCap(s34,s4C,[' ',#9]);
        s34:=GetValidStrCap(s34,s50,[' ',#9]);
        if (s48 <> '') and (s50 <> '') then begin
          if (s48[1] = '"') then begin
            ArrestStringEx(s48,'"','"',s48);
          end;

          if CanSellItem(s48) then begin
            New(Goods);

            Goods.sItemName := s48;
            Goods.nCount    := _MIN(1000, Str_ToInt(s4C, 0));
            Goods.dwRefillTime := Str_ToInt(s50, 0);
            Goods.dwRefillTick := 0;
            if (Goods.nCount = 0) or (Goods.dwRefillTime = 0) then
              Dispose(Goods)
            else
              TMerchant(NPC).m_RefillGoodsList.Add(Goods);
          end;
        end; //0048C2D2
      end; //0048C2D2      
    end;    // for
    LoadList.Free;
  end else begin //0048C2EB
    MainOutMessage('脚本文件未找到:' + sScritpFileName);
  end;
  Result:=1;
end;

function TFrmDB.SaveGoodRecord(NPC: TMerchant; sFile: String):Integer;//0048C748
var
  I,II: Integer;
  sFileName:String;
  FileHandle:Integer;
  UserItem:pTUserItem;
  List:TList;
  Header420:TGoodFileHeader;
begin
  Result:= -1;
  sFileName:='.\Envir\Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle:=FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FillChar(Header420,SizeOf(TGoodFileHeader),#0);
    for I := 0 to NPC.m_GoodsList.Count - 1 do begin
      List:=TList(NPC.m_GoodsList.Items[i]);
      Inc(Header420.nItemCount,List.Count);
    end;
    FileWrite(FileHandle,Header420,SizeOf(TGoodFileHeader));
    for I := 0 to NPC.m_GoodsList.Count - 1 do begin
      List:=TList(NPC.m_GoodsList.Items[i]);
      for II := 0 to List.Count - 1 do begin
        UserItem:=List.Items[II];
        FileWrite(FileHandle,UserItem^,SizeOf(TUserItem));
      end;
    end;
    FileClose(FileHandle);
    Result:=1;    
  end;
end;

function TFrmDB.SaveGoodPriceRecord(NPC: TMerchant; sFile: String):Integer;//0048CA64
var
  I: Integer;
  sFileName:String;
  FileHandle:Integer;
  ItemPrice:pTItemPrice;
  Header420:TGoodFileHeader;
begin
  Result:= -1;
  sFileName:='.\Envir\Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle:=FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FillChar(Header420,SizeOf(TGoodFileHeader),#0);
    Header420.nItemCount:=NPC.m_ItemPriceList.Count;
    FileWrite(FileHandle,Header420,SizeOf(TGoodFileHeader));
    for I := 0 to NPC.m_ItemPriceList.Count - 1 do begin
      ItemPrice:=NPC.m_ItemPriceList.Items[I];
      FileWrite(FileHandle,ItemPrice^,SizeOf(TItemPrice));
    end;
    FileClose(FileHandle);
    Result:=1;    
  end;

end;
procedure TFrmDB.ReLoadNpc; //
begin

end;
procedure TFrmDB.ReLoadMerchants; //00487BD8
var
  i,ii,nX,nY:Integer;
  sMapName:String;
  boUse,boNewNpc:Boolean;
  tMerchantNPC:TMerchant;
ResourceString
  sSQLString = 'SELECT * FROM TBL_MERCHANT';
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
  try
    for i := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      tMerchantNPC:=TMerchant(UserEngine.m_MerchantList.Items[i]);
      tMerchantNPC.m_nFlag:= -1;
    end;

    UseSQL();
    Query.SQL.Clear;
    Query.SQL.Add(sSQLString);
    try
      Query.Open;
    finally
    end;

    for i:=0 to Query.RecordCount -1 do begin
      boUse                         := GetBoolean(Query,'FLD_ENABLED');
      if boUse then begin
        sMapName                    := Query.FieldByName('FLD_MAPNAME').AsString;
        nX                          := Query.FieldByName('FLD_X').AsInteger;
        nY                          := Query.FieldByName('FLD_Y').AsInteger;

        //Update existing NPC's
        boNewNpc:=True;
        for II := 0 to UserEngine.m_MerchantList.Count - 1 do begin
          tMerchantNPC:=TMerchant(UserEngine.m_MerchantList.Items[II]);
          if (tMerchantNPC.m_sMapName = sMapName) and
             (tMerchantNPC.m_nCurrX = nX) and
             (tMerchantNPC.m_nCurrY = nY) then begin
            boNewNpc:=False;
            tMerchantNPC.m_sScript      := Query.FieldByName('FLD_SCRIPTFILE').AsString;
            tMerchantNPC.m_sCharName    := Query.FieldByName('FLD_NAME').AsString;
            tMerchantNPC.m_nFlag        := Query.FieldByName('FLD_FLAG').AsInteger;
            tMerchantNPC.m_wAppr        := Query.FieldByName('FLD_APPEARANCE').AsInteger;
            tMerchantNPC.m_boCastle     := GetBoolean(Query,'FLD_ISCASTLE');
            tMerchantNPC.m_boCanMove    := GetBoolean(Query,'FLD_CANMOVE');
            tMerchantNPC.m_dwMoveTime   := Query.FieldByName('FLD_MOVETIME').AsInteger;
            
            break;
          end;
        end;


        if boNewNpc then begin
          tMerchantNPC:=TMerchant.Create;
          tMerchantNPC.m_sMapName     := sMapName;
          tMerchantNPC.m_PEnvir:=g_MapManager.FindMap(tMerchantNPC.m_sMapName);

          if tMerchantNPC.m_PEnvir <> nil then begin
            tMerchantNPC.m_sScript      := Query.FieldByName('FLD_SCRIPTFILE').AsString;
            tMerchantNPC.m_nCurrX       := nX;
            tMerchantNPC.m_nCurrY       := nY;
            tMerchantNPC.m_sCharName    := Query.FieldByName('FLD_NAME').AsString;
            tMerchantNPC.m_nFlag        := Query.FieldByName('FLD_FLAG').AsInteger;
            tMerchantNPC.m_wAppr        := Query.FieldByName('FLD_APPEARANCE').AsInteger;
            tMerchantNPC.m_boCastle     := GetBoolean(Query,'FLD_ISCASTLE');
            tMerchantNPC.m_boCanMove    := GetBoolean(Query,'FLD_CANMOVE');
            tMerchantNPC.m_dwMoveTime   := Query.FieldByName('FLD_MOVETIME').AsInteger;
            
            if (tMerchantNPC.m_sScript <> '') and (tMerchantNPC.m_sMapName <> '') then begin
              UserEngine.m_MerchantList.Add(tMerchantNPC);
              tMerchantNPC.Initialize;
            end;
          end else tMerchantNPC.Free;
        end;
      end;

      Query.Next;
    end;

    for i := UserEngine.m_MerchantList.Count - 1 downto 0 do begin
      tMerchantNPC:=TMerchant(UserEngine.m_MerchantList.Items[i]);
      if tMerchantNPC.m_nFlag = -1 then begin
        tMerchantNPC.m_boGhost:=True;
        tMerchantNPC.m_dwGhostTick:=GetTickCount();
//        UserEngine.MerchantList.Delete(I);
      end;
    end;
  finally
    Query.Close;
  end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TFrmDB.LoadUpgradeWeaponRecord(sNPCName: String;
  DataList: TList): Integer;//0048CBD0
var
  I: Integer;
  FileHandle:Integer;
  sFileName:String;
  UpgradeInfo:pTUpgradeInfo;
  UpgradeRecord:TUpgradeInfo;
  nRecordCount:Integer;
begin
  Result:= -1;
  sFileName:='.\Envir\Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      FileRead(FileHandle,nRecordCount,SizeOf(Integer));
      for I := 0 to nRecordCount - 1 do begin
        if FileRead(FileHandle,UpgradeRecord,SizeOf(TUpgradeInfo)) = SizeOf(TUpgradeInfo) then begin
          New(UpgradeInfo);
          UpgradeInfo^:=UpgradeRecord;
          UpgradeInfo.dwGetBackTick:=0;
          DataList.Add(UpgradeInfo);
        end;
      end;
      FileClose(FileHandle);
      Result:=1;
    end;
  end;
end;

function TFrmDB.SaveUpgradeWeaponRecord(sNPCName: String; DataList: TList):Integer;
var
  I: Integer;
  FileHandle:Integer;
  sFileName:String;
  UpgradeInfo:pTUpgradeInfo;
begin
  Result:= -1;
  sFileName:='.\Envir\Market_Upg\' + sNPCName + '.upg';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
  end else begin
    FileHandle:=FileCreate(sFileName);
  end;
  if FileHandle > 0 then begin
    FileWrite(FileHandle,DataList.Count,SizeOf(Integer));
    for I := 0 to DataList.Count - 1 do begin
      UpgradeInfo:=DataList.Items[I];
      FileWrite(FileHandle,UpgradeInfo^,SizeOf(TUpgradeInfo));
    end;
    FileClose(FileHandle);
    Result:=1;
  end;
end;

function TFrmDB.LoadGoodRecord(NPC: TMerchant; sFile: String): Integer;//0048C574
var
  I: Integer;
  sFileName:String;
  FileHandle:Integer;
  UserItem:pTUserItem;
  List:TList;
  Header420:TGoodFileHeader;
begin
  Result:= -1;
  sFileName:='.\Envir\Market_Saved\' + sFile + '.sav';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    List:=nil;
    if FileHandle > 0 then begin
      if FileRead(FileHandle,Header420,SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then begin
        for I := 0 to Header420.nItemCount - 1 do begin
          New(UserItem);
          if FileRead(FileHandle,UserItem^,SizeOf(TUserItem)) = SizeOf(TUserItem) then begin
            if List = nil then begin
              List:=TList.Create;
              List.Add(UserItem)
            end else begin
              if pTUserItem(List.Items[0]).wIndex = UserItem.wIndex then begin
                List.Add(UserItem);
              end else begin
                NPC.m_GoodsList.Add(List);
                List:=TList.Create;
                List.Add(UserItem);
              end;
            end;
          end;
        end;
        if List <> nil then
          NPC.m_GoodsList.Add(List);
        FileClose(FileHandle);
        Result:=1;
      end;
    end;
  end;
end;

function TFrmDB.LoadGoodPriceRecord(NPC: TMerchant; sFile: String): Integer;//0048C918
var
  I: Integer;
  sFileName:String;
  FileHandle:Integer;
  ItemPrice:pTItemPrice;
  Header420:TGoodFileHeader;
begin
  Result:= -1;
  sFileName:='.\Envir\Market_Prices\' + sFile + '.prc';
  if FileExists(sFileName) then begin
    FileHandle:= FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if FileHandle > 0 then begin
      if FileRead(FileHandle,Header420,SizeOf(TGoodFileHeader)) = SizeOf(TGoodFileHeader) then begin
        for I := 0 to Header420.nItemCount - 1 do begin
          New(ItemPrice);
          if FileRead(FileHandle,ItemPrice^,SizeOf(TItemPrice)) = SizeOf(TItemPrice) then begin
            NPC.m_ItemPriceList.Add(ItemPrice);
          end else begin
            Dispose(ItemPrice);
            break;
          end;
        end;
      end;
      FileClose(FileHandle);
      Result:=1;
    end;
  end;
end;
{
procedure DeCryptString(Src,Dest:PChar;nSrc:Integer;var nDest:Integer);stdcall;
begin

end;
}
function DeCodeString(sSrc:String):String;
{var
  Dest:array[0..1024] of Char;
  nDest:Integer;}
begin
  if sSrc = '' then exit;
  {if (nDeCryptString >= 0) and Assigned(PlugProcArray[nDeCryptString].nProcAddr) then begin
    FillChar(Dest,SizeOf(Dest),0);
    TDeCryptString(PlugProcArray[nDeCryptString].nProcAddr)(@sSrc[1],@Dest,length(sSrc),nDest);
    Result:=strpas(PChar(@Dest));
    exit;
  end;}
  Result:=sSrc;
//  DeCryptString(@sSrc[1],@Dest,length(sSrc),nDest);

end;
procedure TFrmDB.DeCodeStringList(StringList: TStringList);
var
  I: Integer;
  sLine:String;
begin
  if StringList.Count > 0 then begin
    sLine:=StringList.Strings[0];
    if not CompareLStr(sLine,sENCYPTSCRIPTFLAG,length(sENCYPTSCRIPTFLAG)) then begin
      exit;
    end;
  end;

  for I := 0 to StringList.Count - 1 do begin
    sLine:=StringList.Strings[I];
    sLine:=DeCodeString(sLine);
    StringList.Strings[I]:=sLine;
  end;
end;

{procedure TFrmDB.GetAuctionItems(Section: integer; CurrPage: Integer; SearchString: String; PlayObject: TPlayObject);
var
  str_query,sSendMsg: string;
  ItemShopItem: TItemShopItem;
  i: integer;
  UserItem: TUserItem;
  Item:TItem;
  ClientItem:TClientItem;
  StdItem:TStdItem;
begin
  SearchString := StringReplace(SearchString,#039,'a',[rfReplaceAll]);

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION WHERE (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
     str_query := 'SELECT * FROM TBL_AUCTION WHERE (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';
  end;

  UseSQL();

  if str_query <> '' then begin
    str_query := str_query +' ORDER BY FLD_END ASC';

    Query.SQL.Clear;
    Query.SQL.Add(str_query);
    Query.Open;
  end;

  if query.eof then begin
    PlayObject.SendDefMessage(SM_GETAUCTIONITEMS_FAIL,0,Section,0,0,'');
    exit;
  end;

  Query.MoveBy((10*CurrPage)-10);

  for i:=0 to 9 do begin

    if query.eof then
      break;

    AuctionItem.AuctionID := Query.FieldByName('FLD_AUCTIONID').AsInteger;
    AuctionItem.StartTime := UnixToDateTime(strtoint(Query.FieldByName('FLD_START').AsString));
    AuctionItem.EndTime := UnixToDateTime(strtoint(Query.FieldByName('FLD_END').AsString));
    AuctionItem.Cost := Query.FieldByName('FLD_COST').AsInteger;

    if Section = 17 then begin

      // 检测期限
      if (Auctionitem.EndTime < Now) then begin
        if GetBoolean(Query,'FLD_SOLD') then
          AuctionItem.Seller := '已出售'
        else
          AuctionItem.Seller := '已过期';
      end else begin
        if GetBoolean(Query,'FLD_SOLD') then
          AuctionItem.Seller := '已出售'
        else
          AuctionItem.Seller := '未出售';
      end;

    end else
      AuctionItem.Seller := Query.FieldByName('FLD_SELLER').AsString;

    UserItem.MakeIndex := Query.FieldByName('FLD_MAKEINDEX').AsInteger;
    UserItem.wIndex := Query.FieldByName('FLD_WINDEX').AsInteger;
    UserItem.Dura := Query.FieldByName('FLD_DURA').AsInteger;
    UserItem.DuraMax := Query.FieldByName('FLD_MAXDURA').AsInteger;
    UserItem.btValue[0] := Query.FieldByName('FLD_ADDITIONAL_0').AsInteger;
    UserItem.btValue[1] := Query.FieldByName('FLD_ADDITIONAL_1').AsInteger;
    UserItem.btValue[2] := Query.FieldByName('FLD_ADDITIONAL_2').AsInteger;
    UserItem.btValue[3] := Query.FieldByName('FLD_ADDITIONAL_3').AsInteger;
    UserItem.btValue[4] := Query.FieldByName('FLD_ADDITIONAL_4').AsInteger;
    UserItem.btValue[5] := Query.FieldByName('FLD_ADDITIONAL_5').AsInteger;
    UserItem.btValue[6] := Query.FieldByName('FLD_ADDITIONAL_6').AsInteger;
    UserItem.btValue[7] := Query.FieldByName('FLD_ADDITIONAL_7').AsInteger;
    UserItem.btValue[8] := Query.FieldByName('FLD_ADDITIONAL_8').AsInteger;
    UserItem.btValue[9] := Query.FieldByName('FLD_ADDITIONAL_9').AsInteger;
    UserItem.btValue[10] := Query.FieldByName('FLD_ADDITIONAL_10').AsInteger;
    UserItem.btValue[11] := Query.FieldByName('FLD_ADDITIONAL_11').AsInteger;
    UserItem.btValue[12] := Query.FieldByName('FLD_ADDITIONAL_12').AsInteger;
    UserItem.btValue[13] := Query.FieldByName('FLD_ADDITIONAL_13').AsInteger;
    UserItem.btValue[14] := Query.FieldByName('FLD_ADDITIONAL_14').AsInteger;
    UserItem.btValue[15] := Query.FieldByName('FLD_ADDITIONAL_15').AsInteger;
    UserItem.btValue[16] := Query.FieldByName('FLD_ADDITIONAL_16').AsInteger;
    UserItem.btValue[17] := Query.FieldByName('FLD_ADDITIONAL_17').AsInteger;
    UserItem.Amount := Query.FieldByName('FLD_AMOUNT').AsInteger;

    Item:=UserEngine.GetStdItem(UserItem.wIndex);

    if Item <> nil then begin
      Item.GetStandardItem(StdItem);
      Item.GetItemAddValue(@UserItem,StdItem);

      ClientItem.S := StdItem;
      ClientItem.Dura := UserItem.Dura;
      ClientItem.DuraMax := UserItem.DuraMax;
      ClientItem.MakeIndex := UserItem.MakeIndex;

      AuctionItem.Item := ClientItem;

      sSendMsg:=sSendMsg + EncodeBuffer(@AuctionItem,SizeOf(TAuctionItem)) + '/';
    end;

    Query.Next;
  end;

  if Query.RecordCount <> 0 then begin
    PlayObject.m_DefMsg:=MakeDefaultMsg(SM_SENGGAMESHOPITEMS,Integer(Self),CurrPage,ceil(Query.RecordCount / 10),Section);
    PlayObject.SendSocket(@PlayObject.m_DefMsg,sSendMsg);
  end;
end; }

function TFrmDB.ConsignItem(Useritem: pTUserItem; Cost: String; Name: string): boolean;

var
  str_query: string;
  Item: TItem;

begin
  Result := False;
  Item:=UserEngine.GetStdItem(UserItem.wIndex);
  if Item = nil then exit;


  str_query := 'INSERT INTO TBL_AUCTION (FLD_START, FLD_END, FLD_SELLER, FLD_ITEMNAME, FLD_COST, FLD_MAKEINDEX, FLD_WINDEX, FLD_STDMODE, FLD_AMOUNT, FLD_DURA, FLD_MAXDURA, FLD_ADDITIONAL_0, FLD_ADDITIONAL_1, FLD_ADDITIONAL_2,'
   +' FLD_ADDITIONAL_3, FLD_ADDITIONAL_4, FLD_ADDITIONAL_5, FLD_ADDITIONAL_6, FLD_ADDITIONAL_7, FLD_ADDITIONAL_8, FLD_ADDITIONAL_9, FLD_ADDITIONAL_10, FLD_ADDITIONAL_11,'
   +' FLD_ADDITIONAL_12, FLD_ADDITIONAL_13, FLD_ADDITIONAL_14, FLD_ADDITIONAL_15, FLD_ADDITIONAL_16, FLD_ADDITIONAL_17, FLD_SOLD)'
   +' VALUES ('''+IntToStr(UnixTime)+''',''' +IntToStr(DateTimeToUnix(IncDay(now, 100))) +''',''' +Name +''',''' +Item.Name +''',''' +Cost +''',''' +inttostr(UserItem.MakeIndex) +''',''' +inttostr(UserItem.wIndex) +''',''' +inttostr(Item.StdMode) +''',''' +inttostr(UserItem.Amount) +''''
   +',''' +inttostr(UserItem.Dura) +''',''' +inttostr(UserItem.DuraMax) +''',''' +inttostr(UserItem.btValue[0]) +''',''' +inttostr(UserItem.btValue[1]) +''',''' +inttostr(UserItem.btValue[2]) +''''
   +',''' +inttostr(UserItem.btValue[3]) +''',''' +inttostr(UserItem.btValue[4]) +''',''' +inttostr(UserItem.btValue[5]) +''',''' +inttostr(UserItem.btValue[6]) +''',''' +inttostr(UserItem.btValue[7]) +''''
   +',''' +inttostr(UserItem.btValue[8]) +''',''' +inttostr(UserItem.btValue[9]) +''',''' +inttostr(UserItem.btValue[10]) +''',''' +inttostr(UserItem.btValue[11]) +''',''' +inttostr(UserItem.btValue[12]) +''''
   +',''' +inttostr(UserItem.btValue[13]) +''',''' +inttostr(UserItem.btValue[14]) +''',''' +inttostr(UserItem.btValue[15]) +''',''' +inttostr(UserItem.btValue[16]) +''''
   +',''' +inttostr(UserItem.btValue[17]) +''', FALSE)';

  UseSQL();
  Query.SQL.Clear;
  Query.SQL.Add(str_query);
  Query.ExecSQL;
  Result := True;
end;

procedure TFrmDB.GetAuctionItems(Section: integer; CurrPage: Integer; SearchString: String; PlayObject: TPlayObject);

var
  str_query,sSendMsg: string;
 
  AuctionItem: TAuctionItem;
  i: integer;

  UserItem: TUserItem;
  Item:TItem;
  ClientItem:TClientItem;
  StdItem:TStdItem;

begin

  {
  PlayObject.SysMsg('Search term:' +SearchString,c_Red,t_Hint);
  PlayObject.SysMsg('Section:' +inttostr(section),c_Red,t_Hint);
  PlayObject.SysMsg('Current Page:' +inttostr(CurrPage),c_Red,t_Hint);
  }

  // Replace any instances of " ' " to break any attempt at SQL Injection
  SearchString := StringReplace(SearchString,#039,'a',[rfReplaceAll]);

  case Section of
  1: begin//All

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION WHERE (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
     str_query := 'SELECT * FROM TBL_AUCTION WHERE (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  2: begin//武器

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 5'
                   +' OR FLD_STDMODE = 6'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 5'
                   +' OR FLD_STDMODE = 6'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  3: begin//项链

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 19'
                   +' OR FLD_STDMODE = 20'
                   +' OR FLD_STDMODE = 21'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 19'
                   +' OR FLD_STDMODE = 20'
                   +' OR FLD_STDMODE = 21'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  4: begin//戒指

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 22'
                   +' OR FLD_STDMODE = 23'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 22'
                   +' OR FLD_STDMODE = 23'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  5: begin//手镯/手套

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 24'
                   +' OR FLD_STDMODE = 26'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 24'
                   +' OR FLD_STDMODE = 26'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  6: begin//石头

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 63'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 63'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  7: begin//盔甲

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 10'
                   +' OR FLD_STDMODE = 11'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_STDMODE = 10'
                   +' OR FLD_STDMODE = 11'
                   +') AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  8: begin//头盔

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 15'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 15'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  9: begin//鞋

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 62'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 62'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';
                   
  end;
  10: begin//腰带

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 64'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 64'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';


  end;
  11: begin//特殊药品

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 3'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 3'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  12: begin//宝石和球

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 37'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 37'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  13: begin//技能书

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 4'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 4'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  14: begin//矿石

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 43'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime) +')'
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_STDMODE = 43'
                   +' AND (FLD_SOLD = FALSE AND FLD_END > ' +IntToStr(UnixTime)
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';

  end;
  15: begin//任务物品

  end;
  16: begin//其他物品


  end;
  17: begin//角色物品

    if searchstring = '' then
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE FLD_SELLER = ''' +PlayObject.m_sCharName +''''
    else
      str_query := 'SELECT * FROM TBL_AUCTION'
                   +' WHERE (FLD_SELLER = ''' +PlayObject.m_sCharName +''''
                   +' AND FLD_ITEMNAME LIKE ''' +'%' +SearchString +'%' +''')';
  end;
  end;

  UseSQL();

  if str_query <> '' then begin
    str_query := str_query +' ORDER BY FLD_END ASC';
    //PlayObject.SysMsg('Query:' +str_query,c_Red,t_Hint);

    Query.SQL.Clear;
    Query.SQL.Add(str_query);
    Query.Open;
  end;

  if query.eof then begin
    PlayObject.SendDefMessage(SM_GETAUCTIONITEMS_FAIL,0,Section,0,0,'');
    exit;
  end;

  Query.MoveBy((10*CurrPage)-10);

  for i:=0 to 9 do begin

    if query.eof then
      break;

    AuctionItem.AuctionID := Query.FieldByName('FLD_AUCTIONID').AsInteger;
    AuctionItem.StartTime := UnixToDateTime(strtoint(Query.FieldByName('FLD_START').AsString));
    AuctionItem.EndTime := UnixToDateTime(strtoint(Query.FieldByName('FLD_END').AsString));
    AuctionItem.Cost := Query.FieldByName('FLD_COST').AsInteger;

    if Section = 17 then begin

      // 检测期限
      if (Auctionitem.EndTime < Now) then begin
        if GetBoolean(Query,'FLD_SOLD') then
          AuctionItem.Seller := '已出售'
        else
          AuctionItem.Seller := '已过期';
      end else begin
        if GetBoolean(Query,'FLD_SOLD') then
          AuctionItem.Seller := '已出售'
        else
          AuctionItem.Seller := '未出售';
      end;

    end else
      AuctionItem.Seller := Query.FieldByName('FLD_SELLER').AsString;

    UserItem.MakeIndex := Query.FieldByName('FLD_MAKEINDEX').AsInteger;
    UserItem.wIndex := Query.FieldByName('FLD_WINDEX').AsInteger;
    UserItem.Dura := Query.FieldByName('FLD_DURA').AsInteger;
    UserItem.DuraMax := Query.FieldByName('FLD_MAXDURA').AsInteger;
    UserItem.btValue[0] := Query.FieldByName('FLD_ADDITIONAL_0').AsInteger;
    UserItem.btValue[1] := Query.FieldByName('FLD_ADDITIONAL_1').AsInteger;
    UserItem.btValue[2] := Query.FieldByName('FLD_ADDITIONAL_2').AsInteger;
    UserItem.btValue[3] := Query.FieldByName('FLD_ADDITIONAL_3').AsInteger;
    UserItem.btValue[4] := Query.FieldByName('FLD_ADDITIONAL_4').AsInteger;
    UserItem.btValue[5] := Query.FieldByName('FLD_ADDITIONAL_5').AsInteger;
    UserItem.btValue[6] := Query.FieldByName('FLD_ADDITIONAL_6').AsInteger;
    UserItem.btValue[7] := Query.FieldByName('FLD_ADDITIONAL_7').AsInteger;
    UserItem.btValue[8] := Query.FieldByName('FLD_ADDITIONAL_8').AsInteger;
    UserItem.btValue[9] := Query.FieldByName('FLD_ADDITIONAL_9').AsInteger;
    UserItem.btValue[10] := Query.FieldByName('FLD_ADDITIONAL_10').AsInteger;
    UserItem.btValue[11] := Query.FieldByName('FLD_ADDITIONAL_11').AsInteger;
    UserItem.btValue[12] := Query.FieldByName('FLD_ADDITIONAL_12').AsInteger;
    UserItem.btValue[13] := Query.FieldByName('FLD_ADDITIONAL_13').AsInteger;
    UserItem.btValue[14] := Query.FieldByName('FLD_ADDITIONAL_14').AsInteger;
    UserItem.btValue[15] := Query.FieldByName('FLD_ADDITIONAL_15').AsInteger;
    UserItem.btValue[16] := Query.FieldByName('FLD_ADDITIONAL_16').AsInteger;
    UserItem.btValue[17] := Query.FieldByName('FLD_ADDITIONAL_17').AsInteger;
    UserItem.Amount := Query.FieldByName('FLD_AMOUNT').AsInteger;

    Item:=UserEngine.GetStdItem(UserItem.wIndex);

    if Item <> nil then begin
      Item.GetStandardItem(StdItem);
      Item.GetItemAddValue(@UserItem,StdItem);

      ClientItem.S := StdItem;
      ClientItem.Dura := UserItem.Dura;
      ClientItem.DuraMax := UserItem.DuraMax;
      ClientItem.MakeIndex := UserItem.MakeIndex;

      AuctionItem.Item := ClientItem;

      sSendMsg:=sSendMsg + EncodeBuffer(@AuctionItem,SizeOf(TAuctionItem)) + '/';
    end;

    Query.Next;
  end;

  if Query.RecordCount <> 0 then begin
    PlayObject.m_DefMsg:=MakeDefaultMsg(SM_AUCTIONITEMS,Integer(Self),CurrPage,ceil(Query.RecordCount / 10),Section);
    PlayObject.SendSocket(@PlayObject.m_DefMsg,sSendMsg);
  end;
end;

procedure TFrmDB.BuyAuctionItem(PlayObject: TPlayObject; AuctionID: Integer);

var
  str_query: string;
  Cost: Integer;
  UserItem: pTUserItem;

begin

  str_query := 'SELECT * FROM TBL_AUCTION WHERE FLD_AUCTIONID = ' +inttostr(AuctionID);

  UseSQL();
  Query.SQL.Clear;
  Query.SQL.Add(str_query);
  Query.Open;

  // 没有结果-退出
  if Query.eof then
    exit;

  // 有结果，它已经被卖了？
  if GetBoolean(Query,'FLD_SOLD') then begin
    PlayObject.SysMsg('这个物品已经卖出。',c_Red,t_Hint);
    exit;
  end;

  // 如果它未被卖，它到期了？
  if UnixToDateTime(strtoint(Query.FieldByName('FLD_END').AsString)) < now then begin
    PlayObject.SysMsg('This item has expired.',c_Red,t_Hint);
    exit;
  end;

  Cost := UINT(Query.FieldByName('FLD_COST').AsInteger);

  // 如果玩家没有足够金钱-退出
  if PlayObject.m_nGold < Cost then exit;

  New(UserItem);
  
  UserItem.MakeIndex := Query.FieldByName('FLD_MAKEINDEX').AsInteger;
  UserItem.wIndex := Query.FieldByName('FLD_WINDEX').AsInteger;
  UserItem.Dura := Query.FieldByName('FLD_DURA').AsInteger;
  UserItem.DuraMax := Query.FieldByName('FLD_MAXDURA').AsInteger;
  UserItem.btValue[0] := Query.FieldByName('FLD_ADDITIONAL_0').AsInteger;
  UserItem.btValue[1] := Query.FieldByName('FLD_ADDITIONAL_1').AsInteger;
  UserItem.btValue[2] := Query.FieldByName('FLD_ADDITIONAL_2').AsInteger;
  UserItem.btValue[3] := Query.FieldByName('FLD_ADDITIONAL_3').AsInteger;
  UserItem.btValue[4] := Query.FieldByName('FLD_ADDITIONAL_4').AsInteger;
  UserItem.btValue[5] := Query.FieldByName('FLD_ADDITIONAL_5').AsInteger;
  UserItem.btValue[6] := Query.FieldByName('FLD_ADDITIONAL_6').AsInteger;
  UserItem.btValue[7] := Query.FieldByName('FLD_ADDITIONAL_7').AsInteger;
  UserItem.btValue[8] := Query.FieldByName('FLD_ADDITIONAL_8').AsInteger;
  UserItem.btValue[9] := Query.FieldByName('FLD_ADDITIONAL_9').AsInteger;
  UserItem.btValue[10] := Query.FieldByName('FLD_ADDITIONAL_10').AsInteger;
  UserItem.btValue[11] := Query.FieldByName('FLD_ADDITIONAL_11').AsInteger;
  UserItem.btValue[12] := Query.FieldByName('FLD_ADDITIONAL_12').AsInteger;
  UserItem.btValue[13] := Query.FieldByName('FLD_ADDITIONAL_13').AsInteger;
  UserItem.btValue[14] := Query.FieldByName('FLD_ADDITIONAL_14').AsInteger;
  UserItem.btValue[15] := Query.FieldByName('FLD_ADDITIONAL_15').AsInteger;
  UserItem.btValue[16] := Query.FieldByName('FLD_ADDITIONAL_16').AsInteger;
  UserItem.btValue[17] := Query.FieldByName('FLD_ADDITIONAL_17').AsInteger;
  UserItem.Amount := Query.FieldByName('FLD_AMOUNT').AsInteger;
  
  str_query := 'UPDATE TBL_AUCTION SET FLD_SOLD = TRUE WHERE (FLD_AUCTIONID = ' +Inttostr(AuctionID) +' AND FLD_SOLD = FALSE)';
  Query.SQL.Clear;
  Query.SQL.Add(str_query);
  Query.ExecSQL;
  
  if query.RowsAffected <> 0 then begin
    if (PlayObject.DecGold(Cost)) then begin
      PlayObject.AddItemToBag(UserItem);
      PlayObject.SendAddItem(UserItem);
      PlayObject.SendMsg(PlayObject,RM_AUCTIONGIVE,0,PlayObject.m_nGold,0,0,'');
    end;
  end;
end;

procedure TFrmDB.EndOfAuction(PlayObject: TPlayObject; AuctionID: Integer);

var
  str_query: string;
  UserItem: pTUserItem;
  nGold:UINT;

begin

  str_query := 'SELECT * FROM TBL_AUCTION WHERE FLD_AUCTIONID = ' +inttostr(AuctionID);
  UseSQL();
  Query.SQL.Clear;
  Query.SQL.Add(str_query);
  Query.Open;

  if Query.eof then
    exit;

  if GetBoolean(Query,'FLD_SOLD') then begin
    // 物品卖了，因此金币给卖家
    nGold := Query.FieldByName('FLD_COST').AsInteger;
    PlayObject.IncGold(nGold);

    // 从数据库删除
    str_query := 'DELETE FROM TBL_AUCTION WHERE FLD_AUCTIONID = ' +inttostr(AuctionID);
    Query.SQL.Clear;
    Query.SQL.Add(str_query);
    Query.ExecSQL;

    PlayObject.SendMsg(PlayObject,RM_AUCTIONGIVE,0,PlayObject.m_nGold,0,0,'');

  end else begin
    // 到期或玩家取回，取回物品

    New(UserItem);
  
    UserItem.MakeIndex := Query.FieldByName('FLD_MAKEINDEX').AsInteger;
    UserItem.wIndex := Query.FieldByName('FLD_WINDEX').AsInteger;
    UserItem.Dura := Query.FieldByName('FLD_DURA').AsInteger;
    UserItem.DuraMax := Query.FieldByName('FLD_MAXDURA').AsInteger;
    UserItem.btValue[0] := Query.FieldByName('FLD_ADDITIONAL_0').AsInteger;
    UserItem.btValue[1] := Query.FieldByName('FLD_ADDITIONAL_1').AsInteger;
    UserItem.btValue[2] := Query.FieldByName('FLD_ADDITIONAL_2').AsInteger;
    UserItem.btValue[3] := Query.FieldByName('FLD_ADDITIONAL_3').AsInteger;
    UserItem.btValue[4] := Query.FieldByName('FLD_ADDITIONAL_4').AsInteger;
    UserItem.btValue[5] := Query.FieldByName('FLD_ADDITIONAL_5').AsInteger;
    UserItem.btValue[6] := Query.FieldByName('FLD_ADDITIONAL_6').AsInteger;
    UserItem.btValue[7] := Query.FieldByName('FLD_ADDITIONAL_7').AsInteger;
    UserItem.btValue[8] := Query.FieldByName('FLD_ADDITIONAL_8').AsInteger;
    UserItem.btValue[9] := Query.FieldByName('FLD_ADDITIONAL_9').AsInteger;
    UserItem.btValue[10] := Query.FieldByName('FLD_ADDITIONAL_10').AsInteger;
    UserItem.btValue[11] := Query.FieldByName('FLD_ADDITIONAL_11').AsInteger;
    UserItem.btValue[12] := Query.FieldByName('FLD_ADDITIONAL_12').AsInteger;
    UserItem.btValue[13] := Query.FieldByName('FLD_ADDITIONAL_13').AsInteger;
    UserItem.btValue[14] := Query.FieldByName('FLD_ADDITIONAL_14').AsInteger;
    UserItem.btValue[15] := Query.FieldByName('FLD_ADDITIONAL_15').AsInteger;
    UserItem.btValue[16] := Query.FieldByName('FLD_ADDITIONAL_16').AsInteger;
    UserItem.btValue[17] := Query.FieldByName('FLD_ADDITIONAL_17').AsInteger;
    UserItem.Amount := Query.FieldByName('FLD_AMOUNT').AsInteger;
    
    // 从数据库删除
    str_query := 'DELETE FROM TBL_AUCTION WHERE FLD_AUCTIONID = ' +inttostr(AuctionID);
    Query.SQL.Clear;
    Query.SQL.Add(str_query);
    Query.ExecSQL;

    PlayObject.AddItemToBag(UserItem);
    PlayObject.SendAddItem(UserItem);
    PlayObject.SendMsg(PlayObject,RM_AUCTIONGIVE,0,0,1,0,'');
  end;

end;


constructor TFrmDB.Create();
begin
  inherited;
  CoInitialize(nil);
  Query:=TADOQuery.Create(nil);
  QueryCommand:=TADOCommand.Create(nil);
  SQLTimer := TTimer.Create(nil);
  SQLTimer.Enabled := False;    
end;

function TFrmDB.GetBoolean(MyQuery: TADOQuery; Field: String): boolean;
begin
  UseSQL();
  if Not g_config.boUseSQL then Result := MyQuery.FieldByName(Field).AsBoolean
  else Result := {(}MyQuery.FieldByName(Field).AsBoolean{ = 1)};
end;

procedure TFrmDB.InitDBM();
begin
  if not g_config.boUseSQL then Query.ConnectionString := g_sADODBString
  else begin
    if lowercase(g_Config.SQLType) = 'mysql' then begin
      Query.ConnectionString := 'DRIVER={MySQL ODBC 3.51 Driver};SERVER='+g_config.SQLHost+';PORT='+inttostr(g_config.SQLPort)+';DATABASE='+g_config.SQLDatabase+';USER='+g_config.SQLUsername+';PASSWORD='+g_config.SQLPassword+';OPTION=3';
    end
    else if lowercase(g_Config.SQLType) = 'mssql' then begin
      Query.ConnectionString := 'Provider=SQLOLEDB.1;Password='+g_config.SQLPassword+';Persist Security Info=True;User ID='+g_config.SQLUsername+';Initial Catalog='+g_config.SQLDatabase+';Data Source='+g_config.SQLHost;
    end
    else begin
      Application.MessageBox('Invalid SQL Type seclected. Valid Types: mysql','Error!');
      Application.Terminate;
    end;

    // 测试连接
    try
      UseSQL();
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('SELECT * FROM TBL_STDITEMS');
      Query.Open;
    except
      Application.MessageBox('数据库连接失败.','错误!');
      Application.Terminate;
    end;
  end;

  QueryCommand.ConnectionString := Query.ConnectionString;
  SQLTimer.Interval := 60000; // Fire after 1 Minute to start with.
  SQLTimer.OnTimer := DoSQLTimer;
  SQLTimer.Enabled := True;
end;

procedure TFrmDB.UseSQL();
begin
  if g_Config.boUseSQL then LastSQLTime := UnixTime;
end;

procedure TFrmDB.DoSQLTimer(Sender: TObject);
var
  boError: Boolean;
begin
  boError := False;
   if not g_Config.boUseSQL then begin
     SQLTimer.Enabled := False;
     exit;
   end;
  // 停止SQL连接时间。
  if (LastSQLTime < (UnixTime-(60*10))) or (SQLTimer.Interval = 60000) then begin
    // 前面用法是超过10分钟前
    MainOutMessage('-- SQL KeepAlive');
    try
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('SELECT * FROM TBL_KEEPALIVE');
      Query.Open;
      Query.Close;
    except
      MainOutMessage('-- --> Error Keeping Query Alive!');
      boError := True;
    end;

    Try
      QueryCommand.CommandText := 'UPDATE TBL_KEEPALIVE Set FLD_TIME='+inttostr(UnixTime)+' Where FLD_ID=1';
      QueryCommand.Execute;
    Except
      MainOutMessage('-- --> Error Keeping QueryCommand Alive!');
      boError := True;
    end;
    if Not boError then UseSQL();
  end
  else begin
    MainOutMessage('-- SQL Keep Alive not needed.');
  end;
  SQLTimer.Interval := (60*60)*1000;  
end;

procedure TFrmDB.LoadGT(Number,ListNumber:Integer);
var
  GT:TTerritory;
  sSQLString:String;
  nerror:integer;
begin
  nerror:=0;
  sSQLString := 'SELECT * FROM TBL_GTList WHERE(TerritoryNumber=' + IntToStr(Number) + ')';
  UseSQL();
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
  except
    //nerror:=1;
  //增加捉住某一处的错误在这里
  end;
  //new(GT);
  GT:=g_GuildTerritory.GTList[ListNumber];
  try
    if Query.RecordCount = 1 then begin //如果那里纪录
      GT.TerritoryNumber := Number;
      GT.Guildname:= Query.FieldByName('FLD_GuildName').AsString;
      GT.RegDate := UnixToDateTime(strtoint(Query.FieldByName('FLD_RegDate').AsString));
      GT.RegEnd := UnixToDateTime(strtoint(Query.FieldByName('FLD_RegEnd').AsString));
      if GetBoolean(Query,'FLD_ForSale') then
        GT.ForSale := True
      else
        GT.ForSale := False;
      GT.ForSaleEnd := UnixToDateTime(strtoint(Query.FieldByName('FLD_ForSaleEnd').AsString));
      GT.ForSaleGold := strtoint(Query.FieldByName('FLD_ForSaleGold').AsString);
      GT.BuyerGName := Query.FieldByName('FLD_Buyer').AsString;
      Query.Close;
    end else begin
      Query.Close;
      GT.TerritoryNumber := number;
      GT.GuildName :='';
      GT.RegDate := now();
      GT.RegEnd := now();
      GT.ForSale:=True;
      GT.ForSaleEnd := now();
      GT.ForSaleGold := 10000000;
      GT.BuyerGName := '';
      SetupGT(GT);
    end;
  except
    if nerror = 0 then nerror:=2;
  end;

  if nerror <> 0 then exit; //technicaly应该增加错误报告在这里
  LoadGTDecorations(GT);
end;

procedure TFrmDB.LoadGTDecorations(GT:TTerritory);
var
  sSQLString:String;
  nerror,i,ii:integer;
  Decoration:pTGTDecoration;
  MapItem: pTMapItem;
  UserItem:pTUserItem;
  LastMapName:string;
  Envir:TEnvirnoment;
begin
  nerror:=0;
  sSQLString := 'SELECT * FROM TBL_GTObjects WHERE(TerritoryNumber=' + IntToStr(GT.TerritoryNumber) + ') ORDER BY FLD_MapName';
  UseSQL();
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
  except
    MainOutMessage('[Exception] TFrmDB.LoadGTDecorations => Failed to select territory.');
  end;
  lastmapname:='';
  try
    for i:=0 to Query.RecordCount -1 do begin
      new(Decoration);
      Decoration.appr := Query.FieldByName('FLD_Appr').AsInteger;
      Decoration.x := strtoint(Query.FieldByName('FLD_X').AsString);
      Decoration.y := strtoint(Query.FieldByName('FLD_Y').AsString);
      Decoration.starttime := strtoint(Query.FieldByName('FLD_StartTime').AsString);
      if LastMapName <> Query.FieldByName('FLD_MapName').AsString then begin
        for ii:= 0 to g_MapManager.Count -1 do begin
          Envir := g_MapManager.Items[ii];
          if (Envir.sMapName = Query.FieldByName('FLD_MapName').AsString) and (TTerritory(Envir.m_GuildTerritory).TerritoryNumber = GT.TerritoryNumber) then
            break;
        end;
      end;

      if (Envir <> nil) then begin
        Decoration.Map := Envir;
        //首先我们做我们新的用户物品
        New(UserItem);
        if UserEngine.CopyToUserItemFromName(g_Config.sGTDeco,UserItem) = False then begin
          if nerror = 0 then nerror:=1;
          Dispose(UserItem);
          continue;
        end;
        UserItem.MakeIndex:=GetItemNumberEx();
        UserItem.btValue[0] := GT.TerritoryNumber;
        UserItem.btValue[5] := LoByte(Decoration.Appr);
        UserItem.btValue[6] := HiByte(Decoration.Appr);
        UserItem.btValue[1] := LoByte(LoWord(Decoration.starttime));
        UserItem.btValue[2] := HiByte(LoWord(Decoration.starttime));
        UserItem.btValue[3] := LoByte(HiWord(Decoration.starttime));
        UserItem.btValue[4] := HiByte(HiWord(Decoration.starttime));

        //现在做实际地图物品 (去在地板上)的那个
        new(MapItem);
        MapItem.UserItem := UserItem^;
        MapItem.Looks := Decoration.Appr + 10000;
        MapItem.Name := GetDecoName(Decoration.Appr)+ '[7]';
        MapItem.AniCount := 0;
        MapItem.Reserved := 0;
        MapItem.Count := 1;
        MapItem.OfBaseObject:=nil;
        MapItem.dwCanPickUpTick:=GetTickCount();
        MapItem.DropBaseObject:=nil;
        if Envir.AddToMap (Decoration.X, Decoration.Y, OS_ITEMOBJECT, TObject (MapItem)) = nil then begin
          dispose(MapItem);
          if nerror = 0 then nerror:=3;
        end;
        GT.NewDecoration(@MapItem.UserItem,Decoration.x,Decoration.Y,Envir,False);
        Dispose(UserItem);
      end else begin
        Dispose (Decoration);
      end;

      Query.next;
    end;
  except
    if nerror = 0 then nerror:=2;
  end;
  Query.Close;
end;

procedure TFrmDB.SaveGT(GT:TTerritory);
var
  sSQLString:String;
  sForSale:String;
begin
  UseSQL();
  sForSale:='FALSE';
  Try
    if GT.ForSale then
      sForSale:='TRUE';
    sSQLString := 'UPDATE TBL_GTList Set FLD_GuildName=''' + GT.GuildName + ''', ' +
    'FLD_RegDate=' + IntToStr(DateTimeToUnix(GT.RegDate)) + ', FLD_RegEnd=' + IntToStr(DateTimeToUnix(GT.RegEnd)) + ', '+
    'FLD_ForSaleEnd=' + IntToStr(DateTimeToUnix(GT.ForSaleEnd)) + ', FLD_ForSaleGold=' + inttostr(GT.ForSaleGold) + ', ' +
    'FLD_ForSale=' + sForSale + ', FLD_Buyer=''' + GT.BuyerGName + '''' +
    ' Where TerritoryNumber=' + inttostr(GT.TerritoryNumber);
    QueryCommand.CommandText:=sSQLString;
    QueryCommand.Execute;
  Except
    MainOutMessage('[Exception] TFrmDB.SaveGT');
  end;
end;

procedure TFrmDB.SetupGT(GT:TTerritory);
var
  sSQLString:String;
begin
  UseSQL();
  Try
    sSQLString := 'INSERT INTO TBL_GTList (FLD_GuildName, FLD_RegDate, FLD_RegEnd, FLD_ForSaleEnd, FLD_ForSaleGold' +
    ',  FLD_ForSale, FLD_Buyer, TerritoryNumber) values (' +
    '''' + GT.GuildName + ''', ' + IntToStr(DateTimeToUnix(GT.RegDate)) + ',' + IntToStr(DateTimeToUnix(GT.RegEnd)) + ',' +
    IntToStr(DateTimeToUnix(GT.ForSaleEnd)) + ',' + inttostr(GT.ForSaleGold) + ',TRUE, ''' + GT.BuyerGName + ''',' +
    inttostr(GT.TerritoryNumber) + ')';

    {sSQLString := format('INSERT INTO TBL_GTList (FLD_GuildName, FLD_RegDate, FLD_RegEnd, FLD_ForSaleEnd, FLD_ForSaleGold' +
    ',  FLD_ForSale, FLD_Buyer, TerritoryNumber) values' +
    '("%s", %d, %d, %d, %d, ' +
    '1, "%s", %d)',

    [GT.GuildName, DateTimeToUnix(GT.RegDate), DateTimeToUnix(GT.RegEnd),
    DateTimeToUnix(GT.ForSaleEnd), GT.ForSaleGold, GT.BuyerGName, GT.TerritoryNumber]);}

    QueryCommand.CommandText:=sSQLString;
    QueryCommand.Execute;
  Except
    MainOutMessage('[Exception] TFrmDB.SetupGT');
  end;
end;

procedure TFrmDB.SaveDeco(looks,GTNumber:Byte;x,y:integer;mapname:String; starttime:dword);
var
  sSQLString:String;
begin
  UseSQL();
  Try
    sSQLString := 'INSERT INTO TBL_GTObjects (TerritoryNumber, FLD_Appr, FLD_x, FLD_Y, FLD_MapName, FLD_StartTime) values (' +
    inttostr(GTNumber) + ',' + IntToStr(looks) + ',' + IntToStr(x) + ',' + IntToStr(y)
    + ',''' + mapname + ''',' + IntToStr(starttime) + ')';
    QueryCommand.CommandText:=sSQLString;
    QueryCommand.Execute;
  Except
    MainOutMessage('[Exception] TFrmDB.SaveDeco');
  end;
end;

procedure TFrmDB.DeleteDeco(GTNumber:Byte; x,y: integer; mapname:String);
var
  sSQLString:String;
begin

  Try
    sSQLString := 'Delete * FROM TBL_GTObjects WHERE('
    + '(TerritoryNumber=' + IntToStr(GTNumber) + ') AND (FLD_X=' + IntToStr(x) + ') AND (FLD_Y=' + IntToStr(y) + ') AND (FLD_MapName=''' + mapname + '''))';
    QueryCommand.CommandText:=sSQLString;
    QueryCommand.Execute;
  Except
    MainOutMessage('[Exception] TFrmDB.DeleteDeco');
  end;
end;

function TFrmDB.LoadDecorationList(): Integer; //00488CDC
var
  I,n14:Integer;
  s18,s20,s24:String;
  LoadList:TStringList;
  sFileName:String;
  Decoration:pTDecoItem;
begin
  Result:= -1;
  sFileName:=g_Config.sEnvirDir + 'DecoItem.txt';
  if FileExists(sFileName) then begin
    LoadList:=TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    s24:='';
    for I := 0 to LoadList.Count - 1 do begin
      s18:=Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        new(Decoration);
        s18:=GetValidStr3(s18,s20,[' ',#9]);
        n14:=Str_ToInt(Trim(s20),0);
        Decoration.Appr := n14;
        s18:=GetValidStr3(s18,s20,[' ',#9]);
        Decoration.Name := s20;
        s18:=GetValidStr3(s18,s20,[' ',#9]);
        n14:=Str_ToInt(Trim(s20),0);
        Decoration.Location := n14;
        n14:=Str_ToInt(Trim(s18),0);
        Decoration.Price := n14;
        g_DecorationList.Add(Decoration);
      end;
    end;    // for
    LoadList.Free;
    Result:=1;
  end;
end;

function TFrmDB.LoadGameShopItemList(PageCount:integer): TList;
var
  sSQLString:String;
  output:TList;
  ItemShopItem:pTItemShopItem;
  I:integer;
begin
  sSQLString := 'SELECT * FROM TBL_GAMESHOP';
  UseSQL();
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  output:=TList.create;
  try
    Query.Open;
    for i:=0 to Query.RecordCount -1 do begin
      new(ItemShopItem);
      ItemShopItem.Name := LeftStr(Query.FieldByName('FLD_NAME').AsString,20);
      ItemShopItem.Price := Query.FieldByName('FLD_PRICE').AsInteger;
      output.Add(ItemShopItem);
      Query.next;
    end;
  finally
  //增加捉住某一处的错误在这里
  end;
  Query.Close;
  result:=output;
end;

function TFrmDB.LoadBBSMsgList(GuildName:String;PageCount:integer):TList;
var
  sSQLString:String;
  output:TList;
  BBSMsg:pTBBSMSG;
  I:integer;
begin
  sSQLString := 'SELECT TOP 100 * FROM TBL_GTForum WHERE(FLD_Guild=''' + GuildName + ''' AND FLD_Deleted = False) ORDER BY FLD_Sticky, FLD_MasterPost DESC, FLD_Index';
  UseSQL();
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  output:=TList.create;
  try
    Query.Open;
    for i:=0 to Query.RecordCount -1 do begin
      new(BBSMsg);
      BBSMsg.index := Query.FieldByName('FLD_INDEX').AsInteger;
      BBSMsg.Poster := Query.FieldByName('FLD_Poster').AsString;
      BBSMsg.Msg := LeftStr(Query.FieldByName('FLD_Msg').AsString,20);
      BBSMsg.Sticky := Query.FieldByName('FLD_Sticky').AsBoolean;
      BBSMsg.MasterIndex := Query.FieldByName('FLD_MasterPost').AsInteger;
      output.Add(BBSMsg);
      Query.next;
    end;
  finally
  //增加捉住某一处的错误在这里
  end;
  Query.Close;
  result:=output;
end;

function TFrmDB.LoadBBSMsg(Index:integer):pTBBSMSGL;
var
  sSQLString:String;
  BBSMsg:pTBBSMSGL;
begin
  sSQLString := 'SELECT * FROM TBL_GTForum WHERE(FLD_INDEX=' + IntToStr(Index) + ' AND FLD_Deleted = False)';
  UseSQL();
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  result:=nil;
  try
    Query.Open;
    if Query.RecordCount = 1 then begin
      new(BBSMsg);
      BBSMsg.index := Query.FieldByName('FLD_INDEX').AsInteger;
      BBSMsg.Poster := Query.FieldByName('FLD_Poster').AsString;
      BBSMsg.Msg := Query.FieldByName('FLD_Msg').AsString;
      BBSMsg.Sticky := Query.FieldByName('FLD_Sticky').AsBoolean;
      BBSMsg.MasterIndex := Query.FieldByName('FLD_MasterPost').AsInteger;
      result:=BBSMsg;
    end;
  finally
    Query.Close;
  end;
end;

procedure TFrmDB.SaveBBSMSG(BBSMsgL:pTBBSMSGL;GuildName:String);
var
  sSQLString:String;
  nstick : integer;
  postdate:integer;
begin
  UseSQL();
  postdate:= DateTimeToUnix(now());
  Try
    nstick:=0;
    if BBSMsgL.Sticky then
      nstick:=1;
    sSQLString := format('INSERT INTO TBL_GTForum (FLD_Guild, FLD_Msg, FLD_Poster, FLD_PostDate, FLD_Sticky,FLD_MasterPost) values (''%S'',''%S'',''%S'',%D,%D, %D)',
    [GuildName,BBSMsgL.Msg,BBSMsgL.Poster,postdate,nstick,BBSMsgL.MasterIndex]);
    QueryCommand.CommandText:=sSQLString;
    QueryCommand.Execute;
  Except
  end;
  try
    if BBSMsgL.MasterIndex = 0 then begin
      sSQLString := format('UPDATE TBL_GTForum SET FLD_MasterPost = FLD_INDEX WHERE(FLD_Poster = ''%s'' AND FLD_PostDate = %D)',[BBSMsgL.Poster,postdate]);
      QueryCommand.CommandText:=sSQLString;
    QueryCommand.Execute;
    end;
  except
  end;
end;

procedure TFrmDB.DeleteBBSMsg(index:integer);
var
  sSQLString:String;
begin
  UseSQL();
  try
    sSQLString := format('UPDATE TBL_GTForum SET FLD_Deleted = True WHERE(FLD_Index = %d)',[index]);
    QueryCommand.CommandText:=sSQLString;
    QueryCommand.Execute;
  except
  end;
end;


destructor TFrmDB.Destroy;
begin
  Query.Free;
  CoUnInitialize;
  inherited;
end;

initialization
begin
  {---- Adjust global SVN revision ----}
  SVNRevision('$Id: LocalDB.pas 594 2007-03-09 15:00:12Z damian $');
end;
finalization

end.
