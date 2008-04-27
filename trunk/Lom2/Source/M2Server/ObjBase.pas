unit ObjBase;
// If you get an error on the next line, you need to reextract SourceFiles.rar
{$I defines.inc}
interface
uses
  svn, nixtime, Windows, Classes, SysUtils, DateUtils, Forms, StrUtils, Math, SDK, Grobal2, Envir,
  ItmUnit, MD5Unit, ADODB;

type
  TClientAction = (cHit,cMagHit,cRun,cWalk,cDigUp,cTurn);
const
  gMan          = 0;
  gWoMan        = 1;

type
  TBaseObject = class;

  pTStartPoint=^TStartPoint;
  TStartPoint=record
    sMapName:String[MapNameLen];
    nX:Integer;
    nY:Integer;
    btJob:Byte;
    Envir:TEnvirnoment;
    dwWhisperTick:LongWord;
  end;

  pTSendMessage=^TSendMessage;
  TSendMessage=record
     wIdent:word;
     wParam:word;
     nParam1:integer;
     nParam2:integer;
     nParam3:integer;
     dwDeliveryTime:dword;
     BaseObject:TBaseObject;
     boLateDelivery:Boolean;
     Buff:pointer;
  end;

  pTVisibleBaseObject=^TVisibleBaseObject;
  TVisibleBaseObject=record
    BaseObject:TBaseObject;
    nVisibleFlag:Integer;
  end;

  pTVisibleMapItem=^TVisibleMapItem;
  TVisibleMapItem=record
     nX,nY:integer;
     MapItem:pTMapItem;
     sName:String;
     wLooks:word;
     nVisibleFlag:integer;
  end;

  TBaseObject = class
    m_sMapName                :String[MapNameLen]; //0x04
    m_sCharName               :String[ActorNameLen]; //0x15
    m_nCurrX                  :Integer;    //0x24
    m_nCurrY                  :Integer;    //0x28
    m_btDirection             :Byte;       //0x2C
    m_btGender                :Byte;       //0x2D
    m_btHair                  :Byte;       //0x2E
    m_btJob                   :Byte;       //0x2F
    m_nGold                   :Integer;    //0x30
    m_Abil                    :TAbility; //TAbility;   //0x34 -> 0x5B
    m_nCharStatus             :Integer;    //0x5C
    m_sHomeMap                :String[MapNameLen]; //0x78
    m_nHomeX                  :Integer;    //0x8C
    m_nHomeY                  :Integer;    //0x90
      bo94                    :Boolean;    //0x94
    m_boOnHorse               :Boolean;    //0x95
    m_btHorseType             :Byte;
    m_btDressEffType          :Byte;
    m_btHelmetEffType         :Byte;
      n98                     :Integer;    //0x98
      n9C                     :Integer;    //0x9C
      nA0                     :Integer;    //0xA0
      nA4                     :Integer;    //0xA4
      nA8                     :Integer;    //0xA8
    m_nPkPoint                :Integer;    //0xAC
    m_boAllowGroup            :Boolean;    //0xB0
    m_boAllowGuild            :Boolean;    //0xB1
      btB2                    :Byte;       //0xB2
      btB3                    :Byte;       //0xB3
    m_nIncHealth              :Integer;    //0x0B4
    m_nIncSpell               :Integer;    //0x0B8
    m_nIncHealing             :Integer;    //0x0BC
    m_nFightZoneDieCount      :Integer;    //0x0C0
      nC4                     :Integer;
      btC8                    :Byte;     //0xC8
      btC9                    :Byte;     //0xC9
    m_BonusAbil               :TNakedAbility; //0x0CA TNakedAbility
    m_CurBonusAbil            :TNakedAbility; //0x0DE
    m_nBonusPoint             :Integer;        //0x0F4
    m_nHungerStatus           :Integer;        //0x0F8
    m_boAllowGuildReCall      :Boolean;        //0xFC
//      btFC               :Byte;
    m_btFD                    :Byte;
    m_btFE                    :Byte;
    m_btFF                    :Byte;
    m_dBodyLuck               :Double;        //0x100
    m_nBodyLuckLevel          :Integer;       //0x108
    m_wGroupRcallTime         :Word;          //0x10C
    m_boAllowGroupReCall      :Boolean;       //0x10E
    m_QuestUnitOpen           :TQuestUnit;    //0x10F
    m_QuestUnit               :TQuestUnit;    //0x11C
    m_QuestFlag               :TQuestFlag;    //0x128 129
    m_nCharStatusEx           :Integer;
    m_dwFightExp              :LongWord;      //0x194
    m_WAbil                   :TAbility;      //0x198
    m_AddAbil                 :TAddAbility;   //0x1C0
    m_nViewRange              :Integer;       //0x1E4
    m_wStatusTimeArr          :TStatusTime;   //0x60
    m_dwStatusArrTick         :array [0..MAX_STATUS_ATTRIBUTE -1] of LongWord; //0x1E8
    m_wStatusArrValue         :array [0..6] of Word; //0x218
    m_dwStatusArrTimeOutTick  :array [0..6] of LongWord; // :Tarry220;           //0x220
    m_wAppr                   :Word;         //0x238
    m_btRaceServer            :Byte;         //0x23A
    m_btRaceImg               :Byte;         //0x23B
    m_btHitPoint              :Byte;         //0x23C
    m_nHitPlus                :ShortInt;      //0x23D
    m_nHitDouble              :ShortInt;      //0x23E
    m_dwGroupRcallTick        :LongWord;     //0x240
    m_boRecallSuite           :Boolean;      //0x244
      bo245                   :Boolean;      //0x245
    m_boTestGa                :Boolean;      //0x246
    m_boGsa                   :Boolean;      //0x247
    m_nHealthRecover          :ShortInt;      //0x248
    m_nSpellRecover           :ShortInt;      //0x249
    m_btAntiPoison            :Byte;         //0x24A
    m_nPoisonRecover          :ShortInt;     //0x24B
    m_nAntiMagic              :ShortInt;     //0x24C
    m_nLuck                   :Integer;      //0x250
    m_nPoisonIncrease         :Integer;
    m_nFreezingIncrease       :Integer;
    m_nPerHealth              :Integer;      //0x254
    m_nPerHealing             :Integer;      //0x258
    m_nPerSpell               :Integer;      //0x25C
    m_dwIncHealthSpellTick    :LongWord;     //0x260
    m_btGreenPoisoningPoint   :Byte;         //0x264
    m_nGoldMax                :Integer;      //0x268
    m_btSpeedPoint            :Byte;         //0x26C
    m_btPermission            :Byte;         //0x26D
    m_nHitSpeed               :ShortInt;     //0x26E  //1-18
    m_btLifeAttrib            :Byte;         //0x26F
    m_btCoolEye               :Byte;         //0x270
    m_GroupOwner              :TBaseObject;    //0x274
    m_GroupMembers            :TStringList;  //0x278
    m_boHearWhisper           :Boolean;      //0x27C
    m_boBanShout              :Boolean;      //0x27D
    m_boBanGuildChat          :Boolean;      //0x27E
    m_boAllowDeal             :Boolean;      //0x27F
    m_BlockWhisperList        :TStringList;  //0x280
    m_dwShoutMsgTick          :LongWord;     //0x284
    m_Master                  :TBaseObject;    //0x288
    m_dwMasterRoyaltyTick     :LongWord;     //0x28C
    m_dwMasterTick            :LongWord;      //0x290
      n294                    :Integer;      //0x294
    m_btSlaveExpLevel         :Byte;         //0x298   1-7
    m_btSlaveMakeLevel        :Byte;         //0x299
    m_SlaveList               :TList;        //0x29C
      bt2A0                   :Byte;         //0x2A0
    m_boSlaveRelax            :Boolean;      //0x2A0
    m_btAttatckMode           :Byte;         //0x2A1   攻击模式
    m_btNameColor             :Byte;       //0x2A2
    m_nLight                  :Integer;    //0x2A4
    m_boGuildWarArea          :Boolean;    //0x2A8
    m_Castle                  :TObject;    //0x2AC
      bo2B0                   :Boolean;    //0x2B0
    m_dw2B4Tick               :LongWord;   //0x2B4
    m_boSuperMan              :Boolean;    //0x2B8
      bo2B9                   :Boolean;    //0x2B9
      bo2BA                   :Boolean;    //0x2BA
    m_boAnimal                :Boolean;    //0x2BB
    m_boNoItem                :Boolean;    //0x2BC
    m_boFixedHideMode         :Boolean;    //0x2BD
    m_boStickMode             :Boolean;    //0x2BE
      bo2BF                   :Boolean;    //0x2BF
    m_boNoAttackMode          :Boolean;    //0x2C0
    m_boNoTame                :Boolean;    //0x2C1
    m_boSkeleton              :Boolean;    //0x2C2
    m_nMeatQuality            :Integer;    //0x2C4
    m_nBodyLeathery           :Integer;    //0x2C8
    m_boHolySeize             :Boolean;    //0x2CC
    m_dwHolySeizeTick         :LongWord;     //0x2D0
    m_dwHolySeizeInterval     :LongWord;     //0x2D4
    m_boCrazyMode             :Boolean;      //0x2D8
    m_dwCrazyModeTick         :LongWord;     //0x2DC
    m_dwCrazyModeInterval     :LongWord;     //0x2E0
    m_boHallucMode            :Boolean;      //Hallucination
    m_dwHallucModeTick        :LongWord;
    m_dwHallucModeInterval    :LongWord;
    
    m_boShowHP                :Boolean;      //0x2E4
//      nC2E6                   :Integer;      //0x2E6
    m_dwShowHPTick            :LongWord;     //0x2E8
    m_dwShowHPInterval        :LongWord;     //0x2EC
      bo2F0                   :Boolean;      //0x2F0
    m_dwDupObjTick            :LongWord;     //0x2F4
    m_PEnvir                  :TEnvirnoment; //0x2F8
    m_boGhost                 :Boolean;    //0x2FC
    m_dwGhostTick             :LongWord;   //0x300
    m_boDeath                 :Boolean;    //0x304
    m_dwDeathTick             :LongWord;   //0x308
    m_btMonsterWeapon         :Byte;       //0x30C
    m_dwStruckTick            :LongWord;   //0x310
    m_boWantRefMsg            :Boolean;    //0x314
    m_boAddtoMapSuccess       :Boolean;    //0x315
    m_bo316                   :Boolean;    //0x316
    m_boDealing               :Boolean;    //0x317
    m_DealLastTick            :LongWord;   //0x318
    m_DealCreat               :TBaseObject;  //0x31C
    m_boRefineing             :Boolean;
    m_RefineLastTick          :LongWord;
    m_RefineCreat             :TBaseObject;  //0x31C
    m_boDealGT                :Boolean;
    m_MyGuild                 :TOBject;    //0x320
    m_nGuildRankNo            :Integer;    //0x324
    m_sGuildRankName          :String;     //0x328
    m_sScriptLable            :String;     //0x32C
    m_btAttackSkillCount      :Byte;       //0x330
      bt331                   :Byte;
      bt332                   :Byte;
      bt333                   :Byte;
    m_btAttackSkillPointCount :Byte;       //0x334
      bo335                   :Boolean;    //0x335
      bo336                   :Boolean;    //0x336
      bo337                   :Boolean;    //0x337
    m_boMission               :Boolean;    //0x338
    m_nMissionX               :Integer;    //0x33C
    m_nMissionY               :Integer;    //0x340
    m_boHideMode              :Boolean;    //0x344
    m_boTDBeffect             :Boolean;
    m_boStoneMode             :Boolean;    //0x345
    m_boCoolEye               :Boolean;    //0x346
    m_boUserUnLockDurg        :Boolean;    //0x347
    m_boTransparent           :Boolean;    //0x348
    m_boAdminMode             :Boolean;    //0x349
    m_boObMode                :Boolean;    //0x34A
    m_boTeleport              :Boolean;    //0x34B
    m_boParalysis             :Boolean;    //0x34C
    m_boUnParalysis           :Boolean;
    m_boRevival               :Boolean;    //0x34D
    m_boUnRevival             :Boolean;
      bo34E                   :boolean;
      bo34F                   :Boolean;
    m_dwRevivalTick           :LongWord;   //0x350
    m_boFlameRing             :Boolean;    //0x354
    m_boRecoveryRing          :Boolean;    //0x355
    m_boAngryRing             :Boolean;    //0x356
    m_boMagicShield           :Boolean;    //0x357
    m_boUnMagicShield         :Boolean;
    m_boMuscleRing            :Boolean;    //0x358
    m_boFastTrain             :Boolean;    //0x359
    m_boProbeNecklace         :Boolean;    //0x35A
    m_boGuildMove             :Boolean;
    m_boSupermanItem          :Boolean;
    m_bopirit                 :Boolean;

    m_boNoDropItem            :Boolean;
    m_boNoDropUseItem         :Boolean;
    m_boExpItem               :Boolean;
    m_boPowerItem             :Boolean;

    m_rExpItem                :Real;
    m_rPowerItem              :Real;
    m_dwPKDieLostExp          :LongWord;   //PK 
    m_nPKDieLostLevel         :Integer;    //PK

    m_boAbilSeeHealGauge      :Boolean;    //0x35B
    m_boAbilMagBubbleDefence  :Boolean;    //0x35C
    m_boAbilCelestialDefence  :Boolean;    //0x35C
    m_btMagBubbleDefenceLevel :Byte;       //0x35D
    m_dwSearchTime            :LongWord;   //0x360
    m_dwSearchTick            :LongWord;   //0x364
    m_dwRunTick               :LongWord;   //0x368
    m_nRunTime                :Integer;    //0x36C
    m_nHealthTick             :Integer;    //0x370
    m_nSpellTick              :Integer;    //0x374
    m_TargetCret              :TBaseObject;  //0x378
    m_dwTargetFocusTick       :LongWord;   //0x37C
    m_LastHiter               :TBaseObject;  //0x380
    m_LastHiterTick           :LongWord;   //0x384
    m_ExpHitter               :TBaseObject;  //0x388
    m_ExpHitterTick           :LongWord;   //0x38C
    m_dwTeleportTick          :LongWord;   //0x390
    m_dwProbeTick             :LongWord;   //0x394
    m_dwMapMoveTick           :LongWord;   //0x398
    m_boPKFlag                :Boolean;    //0x39C
    m_dwPKTick                :LongWord;   //0x3A0
    m_nMoXieSuite             :Integer;    //0x3A4
    m_nHongMoSuite            :Integer;    //0x3A8
    m_n3AC                    :Integer;    //0x3AC
    m_db3B0                   :Double;     //0x3B0
    m_dwPoisoningTick         :LongWord;   //0x3B8
    m_dwDecPkPointTick        :LongWord;   //0x3BC
    m_DecLightItemDrugTick    :LongWord;   //0x3C0
    m_dwVerifyTick            :LongWord;   //0x3C4
    m_dwCheckRoyaltyTick      :LongWord;   //0x3C8
    m_dwDecHungerPointTick    :LongWord;   //0x3CC
    m_dwHPMPTick              :LongWord;   //0x3D0
    m_MsgList                 :TList;      //0x3D4
    m_VisibleHumanList        :TList;      //0x3D8
    m_VisibleItems            :TList;      //0x3DC
    m_VisibleEvents           :TList;      //0x3E0
    m_SendRefMsgTick          :LongWord;   //0x3E4
    m_boInFreePKArea          :Boolean;    //0x3E8
      LIst_3EC                :TList;      //0x3EC
      dwTick3F0               :LongWord;   //0x3F0
      dwTick3F4               :LongWord;   //0x3F4
    m_dwHitTick               :Integer;   //0x3F8
    m_dwWalkTick              :Integer;   //0x3FC
    m_dwSearchEnemyTick       :LongWord;   //0x400
    m_boNameColorChanged      :Boolean;    //0x404
    m_boIsVisibleActive       :Boolean;
    m_nProcessRunCount        :ShortInt;
    m_VisibleActors           :TList;      //0x408
    m_ItemList                :TList;      //0x40C
    m_DealItemList            :TList;      //0x410
    m_RefineItemList          :TList;      //0x410
    m_boRefineOK              :Boolean;
    m_nDealGolds              :Integer;    //0x414
    m_boDealOK                :Boolean;    //0x418
    m_MagicList               :TList;      //0x41C
    m_UseItems                :THumanUseItems;  //0x420  + D8 -> 4F8
    m_SayMsgList              :TList;
    m_StorageItemList         :TList;      //0x4F8
    m_nWalkSpeed              :Integer;   //0x4FC
    m_nWalkStep               :Integer;    //0x500
    m_nWalkCount              :Integer;    //0x504
    m_dwWalkWait              :LongWord;   //0x508
    m_dwWalkWaitTick          :LongWord;   //0x50C
    m_boWalkWaitLocked        :Boolean;    //0x510
    m_nNextHitTime            :Integer;    //0x514
    m_MagicOneSwordSkill      :pTUserMagic;    //0x518
    m_MagicPowerHitSkill      :pTUserMagic;    //0x51C
    m_MagicErgumSkill         :pTUserMagic;    //0x520
    m_MagicBanwolSkill        :pTUserMagic;    //0x524
    m_MagicRedBanwolSkill     :pTUserMagic;
    m_MagicFireSwordSkill     :pTUserMagic;    //0x528
    m_MagicCrsSkill           :pTUserMagic;    //0x750
    m_MagicTwnHitSkill        :pTUserMagic;    //0x528
    m_boPowerHit              :Boolean;     //0x52C
    m_boUseThrusting          :Boolean;     //0x52D
    m_boUseHalfMoon           :Boolean;     //0x52E
    m_boRedUseHalfMoon        :Boolean;
    m_boFireHitSkill          :Boolean;     //0x52F
    m_boCrsHitkill            :Boolean;
    m_bo41kill                :Boolean;
    m_boTwinHitSkill          :Boolean;
    m_boTwinHitSkillPhase     :Boolean;
    m_bo43kill                :Boolean;
    m_dwLatestFireHitTick     :LongWord;    //0x530
    m_dwDoMotaeboTick         :LongWord;    //0x534
    m_dwLatestTwinHitTick     :LongWord;
    m_boDenyRefStatus         :Boolean;
    m_boAddToMaped            :Boolean;
    m_boDelFormMaped          :Boolean;
    m_boAutoChangeColor       :Boolean;
    m_dwAutoChangeColorTick   :LongWord;
    m_nAutoChangeIdx          :Integer;

    m_boFixColor              :Boolean;
    m_nFixColorIdx            :Integer;
    m_nFixStatus              :Integer;
    m_boFastParalysis         :Boolean;

    m_boNastyMode             :Boolean;
//    m_FriendList              :TList;
    
    m_nnonfrzWalkSpeed        :Integer;
    m_nnonfrzNextHitTime      :Integer;

    m_boCanLooseDura          :Boolean;
  private
    function  GetLevelExp(nLevel: Integer): LongWord;
    function  InSafeArea: Boolean;
    procedure UpdateVisibleGay(BaseObject:TBaseObject);virtual;
    function  Walk(nIdent:Integer): Boolean;
    function  AddToMap():Boolean;
    procedure UseLamp();
    procedure CheckPKStatus();
    procedure UpdateVisibleItem(wX,wY:Integer;MapItem:PTMapItem);
    procedure UpdateVisibleEvent(wX,wY:Integer;MapEvent:TObject);
    procedure GetAccessory(UserItem:TUserItem;var AddAbility:TAddAbility);
    function  RecalcBagWeight():Integer;
    procedure RecalcHitSpeed();
    procedure DecPKPoint(nPoint:Integer);
    function  GetCharColor(BaseObject:TBaseObject):Byte;
    function  GetNamecolor: Byte;
    procedure SendUpdateDelayMsg(BaseObject: TBaseObject; wIdent, wParam: Word;
      lParam1, lParam2, lParam3: Integer; sMsg: String; dwDelay: LongWord);
    procedure LeaveGroup();
    procedure DelMember(BaseObject:TBaseObject);
    procedure HearMsg(sMsg:String);    
    procedure AttackDir(TargeTBaseObject:TBaseObject;wHitMode:Word;nDir:Integer);virtual;

    procedure DoDamageWeapon(nWeaponDamage:Integer);
    function GetFeatureEx: Word;
  public
    constructor Create();virtual;
    destructor Destroy; override;
    procedure SendMsg(BaseObject:TBaseObject;wIdent,wParam:Word;nParam1,nParam2,nParam3:Integer;sMsg:String);
    procedure SendFirstMsg(BaseObject:TBaseObject;wIdent,wParam:Word;lParam1,lParam2,lParam3:Integer;sMsg:String);
    procedure SendDelayMsg(BaseObject:TBaseObject;wIdent,wParam:Word;lParam1,lParam2,lParam3:Integer;sMsg:String;dwDelay:LongWord);
    procedure SendRefMsg(wIdent,wParam:Word;nParam1,nParam2,nParam3:Integer;sMsg:String);
    procedure SendUpdateMsg(BaseObject: TBaseObject; wIdent, wParam: Word; lParam1,lParam2, lParam3: Integer; sMsg: String);
    procedure SendActionMsg(BaseObject: TBaseObject; wIdent, wParam: Word;
      lParam1, lParam2, lParam3: Integer; sMsg: String);
    procedure SendAttackMsg(wIdent:Word;btDir:Byte;nX,nY:Integer);
    procedure SysMsg(sMsg:String;MsgColor:TMsgColor;MsgType:TMsgType);
    procedure SendGroupText(sMsg:String);
    procedure MonsterSayMsg(AttackBaseObject:TBaseObject;MonStatus:TMonStatus);
    function  IsVisibleHuman():Boolean;
    procedure RecalcLevelAbilitys;
    function  PKLevel():Integer;
    function  InSafeZone():Boolean;OverLoad;
    function  InSafeZone(Envir:TEnvirnoment;nX,nY:Integer):Boolean;OverLoad;
    procedure OpenHolySeizeMode(dwInterval:LongWord);
    procedure BreakHolySeizeMode;
    procedure OpenCrazyMode(nTime:Integer);
    procedure BreakCrazyMode();
    procedure OpenHallucMode(nTime:Integer);
    procedure BreakHallucMode();
    procedure HealthSpellChanged();
    procedure SendGroupRev();
    function  _Attack(var wHitMode:Word;AttackTarget:TBaseObject):Boolean;
    function  GetHitStruckDamage(Target:TBaseObject;nDamage:integer):Integer;
    procedure HasLevelUp(nLevel: Integer);
    procedure sub_4BC87C();
    procedure GoldChanged();
    procedure BankGoldChanged();
    procedure GameGoldChanged;
    procedure BoxMsg(Cret:TBaseObject; sMsg:String);
    function  CanMove: Boolean; //0051633C
    function  GetHitSpeed: Integer;
    function  GetWalkSpeed: Integer;

    procedure DamageSpell(nSpellPoint:Integer);

      function  IncreaseItem(sName:String):Boolean;
      function  GetGuildRelation (cert1:TBaseObject; cert2:TBaseObject):Integer;
      function  IsGoodKilling(cert:TBaseObject):Boolean;
      procedure IncPkPoint(nPoint:Integer);
      procedure AddBodyLuck(dLuck:Double);
      procedure MakeWeaponUnlock();
      procedure ScatterGolds(GoldOfCreat:TBaseObject);
      function  DropGoldDown (nGold:Integer;boFalg:Boolean;GoldOfCreat,DropGoldCreat:TBaseObject):Boolean;
      function  DropItemDown(UserItem: pTUserItem; nScatterRange:Integer;boDieDrop:Boolean;ItemOfCreat,DropCreat:TBaseObject): Boolean;virtual;
      procedure DamageHealth(nDamage:Integer);
      function  GetAttackPower(nBasePower, nPower: Integer): Integer;
      function  CharPushed(nDir,nPushCount:Integer): Integer;
      function  GetDropPosition (nOrgX,nOrgY,nRange:Integer;var nDX:Integer;var nDY:Integer):Boolean;
      function  GetBackDir(nDir: integer): Integer;
      function  GetMapBaseObjects (tEnvir:TEnvirnoment;nX,nY:Integer;nRage:Integer;rList:TList):Boolean;
      function  MagPassThroughMagic(sx, sy, tx, ty, ndir, magpwr: integer;
        undeadattack: Boolean): integer;
//      function  WindStained(sx, sy, tx, ty, ndir, magpwr: integer;
//        undeadattack: Boolean): integer;
      procedure KickException;
      function  GetMagStruckDamage(BaseObject:TBaseObject;nDamage:Integer):Integer;virtual;
      procedure DamageBubbleDefence(nInt:Integer);
      procedure BreakOpenHealth;
      function  GetCharStatus: UINT;
      procedure MakeOpenHealth;
      procedure IncHealthSpell(nHP, nMP: Integer);
      procedure ItemDamageRevivalRing;
      function  CalcGetExp(nLevel: Integer;nExp:Integer): Integer;
      procedure GainSlaveExp(nLevel: Integer);
      procedure MapRandomMove(sMapName:String;nInt:Integer);
      procedure TurnTo(nDir:integer);
      procedure FeatureChanged();
      function  GetFeatureToLong():Integer;
      function  GetPoseCreate():TBaseObject;
      function  GetFeature(BaseObject: TBaseObject):Integer;
      function  IsGroupMember(target: TBaseObject): Boolean;
      procedure AbilCopyToWAbil();
    procedure ChangePKStatus(boWarFlag: Boolean);
    procedure StruckDamage(nDamage:integer);virtual;
    function  sub_4C4CD4(sItemName:String;var nCount:Integer):pTUserItem;
    procedure StatusChanged;
    function  GeTBaseObjectInfo():String;
    procedure TrainSkill(UserMagic:pTUserMagic;nTranPoint:Integer);
    function  CheckMagicLevelup(UserMagic:pTUserMagic):Boolean;
    function  MagCanHitTarget(nX,nY:Integer;TargeTBaseObject:TBaseObject):Boolean;virtual;
    procedure CheckMagicSpecialAbility(Magic: pTUserMagic);
    function  MagBubbleDefenceUp(nLevel,nSec:Integer):Boolean;
    function  CelestialDefenceUp(nLevel, nSec: Integer): Boolean;
    procedure ApplyMeatQuality();
    function  TakeBagItems(BaseObject:TBaseObject):Boolean;
    function  AddItemToBag(UserItem: PTUserItem): Boolean;
    function  DelBagItem(nIndex:Integer):Boolean;overload;
    function  DelBagItem(nItemIndex:Integer;sItemName:String):Boolean;overload;
    procedure WeightChanged();
    function  IsTrainingSkill(nIndex:Integer):Boolean;
    procedure SetQuestFlagStatus(nFlag:Integer;nValue:Integer);
    function  GetQuestFalgStatus(nFlag:integer):Integer;
    procedure SetQuestUnitOpenStatus(nFlag:Integer;nValue:Integer);
    function  GetQuestUnitOpenStatus(nFlag:integer):Integer;
    procedure SetQuestUnitStatus(nFlag:Integer;nValue:Integer);
    function  GetQuestUnitStatus(nFlag:integer):Integer;
    function  GetAttackDir(BaseObject:TBaseObject;var btDir:Byte):Boolean;
    function  TargetInSpitRange(BaseObject:TBaseObject;var btDir:Byte):Boolean;
    procedure MonsterRecalcAbilitys();
    procedure RefNameColor;
    procedure SetPKFlag(BaseObject:TBaseObject);
    procedure SetLastHiter(BaseObject:TBaseObject);
    function  EnterAnotherMap(Envir:TEnvirnoment;nDMapX,nDMapY:Integer):Boolean;
    function  sub_4DD704():Boolean;
    function  DefenceUp(nSec:Integer):Boolean;
    function  MagDefenceUp(nSec:Integer):Boolean;
    function  AttPowerUp(nPower, nTime: Integer): Boolean;
    function  AttPowerDown(nPower, nTime: Integer): Boolean;
    function  SCPowerUp(nSec:Integer):Boolean;
    procedure RefShowName;
    function  MakeSlave(sMonName:String;nMakeLevel,nExpLevel,nMaxMob:Integer;dwRoyaltySec:LongWord):TBaseObject;
    function  MakePosion(nType,nTime,nPoint:Integer):Boolean;
    function  GetFrontPosition(var nX: Integer; var nY: Integer):Boolean;virtual;
    function  GetBackPosition(var nX:Integer;var nY:Integer):Boolean;
    function  WalkTo(btDir: Byte;boFlag:boolean): Boolean;
    procedure SpaceMove(sMap: String; nX, nY: Integer; nInt:Integer);
    procedure SpaceMoveEX(sMap: String; nX, nY: Integer; nInt,GTNumber:Integer);//gt spacemoves
    function  sub_4C5370(nX, nY:Integer;nRange: Integer;var nDX, nDY:Integer):Boolean;
    function  CheckItems(sItemName:String):pTUserItem;
    function  MagMakeDefenceArea(nX,nY,nRange,nSec:Integer;btState:Byte):Integer;
    function  MagMakeCurseArea(nX,nY,nRange,nSec, nPow:Integer):Integer;
    function  sub_4C3538():Integer;
    function  IsGuildMaster():Boolean;
    procedure LoadSayMsg();
    procedure DisappearA();
    function  GetShowName():String;virtual;
    procedure DropUseItems(BaseObject:TBaseObject); virtual;
    procedure ScatterBagItems(ItemOfCreat:TBaseObject); virtual;
    function  GetMessage(Msg:pTProcessMessage):Boolean;virtual; //FFFF
    procedure Initialize();virtual;//FFFE
    procedure Disappear();virtual;//FFFD
    function  Operate(ProcessMsg:pTProcessMessage):Boolean;virtual;//FFFC
    procedure SearchViewRange();virtual;//dynamic;
    procedure Run();virtual;//dynamic;//FFFB
    procedure ProcessSayMsg(sMsg:String); virtual;//FFFA
    procedure MakeGhost;virtual;
    procedure Die();virtual;//FFF9;
    procedure ReAlive();virtual;//FFF8;
    procedure RecalcAbilitys();virtual; //FFF7
    function  IsProtectTarget(BaseObject:TBaseObject):Boolean; virtual; //FFF6
    function  IsAttackTarget(BaseObject:TBaseObject):Boolean; virtual; //FFF5
    function  IsProperTarget(BaseObject:TBaseObject):Boolean; virtual; //FFF4
    function  IsProperFriend(BaseObject:TBaseObject):Boolean; virtual; //FFF3
    function  IsReincarnation(BaseObject: TBaseObject): Boolean; virtual;
    procedure SetTargetCreat(BaseObject:TBaseObject); virtual; //FFF2
    procedure DelTargetCreat(); virtual; //FFF1
    function  MakeClone(sMonName:String;nMakeLevel,nExpLevel:Integer;dwRoyaltySec:LongWord;nMpLoss:Integer):TBaseObject;
    procedure RecallSlave(sSlaveName:String);
    function  SlaveCount(sSlaveName:String):Integer;
    procedure KillClone(sCloneName:String;nSpellPoint:Integer);
    function copyuseritem(UserItem:pTUserItem):pTUserItem;

    function  GetMagicInfo(nMagicID:Integer):pTUserMagic;
    procedure AddItemSkill(nIndex:Integer);
    procedure DelItemSkill(nIndex:Integer);
    procedure reloadmonitem();

  end;
  TAnimalObject =class(TBaseObject)
    m_nNotProcessCount            :Integer;    //未被处理次数，用于怪物处理循环
    m_nTargetX                    :Integer;    //0x538
    m_nTargetY                    :Integer;    //0x53C
    m_boRunAwayMode               :Boolean;    //0x540
    m_dwRunAwayStart              :LongWord;   //0x544
    m_dwRunAwayTime               :LongWord;    //0x548
  private

  public
    constructor Create();override;
    procedure SearchTarget();
    procedure sub_4C959C;
    function  Operate(ProcessMsg:pTProcessMessage):Boolean;override; //FFFC
    procedure Run;override;  //FFFB
    procedure DelTargetCreat();override;//FFF1
    procedure SetTargetXY(nX,nY:Integer);virtual; //FFF0
    procedure GotoTargetXY(); virtual; //0FFEF
    procedure Wondering(); virtual; //0FFEE
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer);virtual; //0FFED
    procedure Struck(Hiter: TBaseObject);virtual; //FFEC

    procedure HitMagAttackTarget(TargeTBaseObject: TBaseObject; nHitPower: Integer;nMagPower:integer;boFlag:Boolean);
  end;
  TPlayObject = class(TAnimalObject)
    m_DefMsg                  :TDefaultMessage;  //0x550
      TList55C                :TList;      //0x55C
    m_sOldSayMsg              :String;     //0x560
    m_nSayMsgCount            :Integer;    //0x560
    m_dwSayMsgTick            :LongWord;   //0x568
    m_boDisableSayMsg         :Boolean;    //0x56C
    m_dwDisableSayMsgTick     :LongWord;   //0x570
    m_dwCheckDupObjTick       :LongWord;   //0x574
      dwTick578               :LongWord;   //0x578
      dwTick57C               :LongWord;   //0x57C
    m_boInSafeArea            :Boolean;    //0x580
      n584                    :Integer;    //0x584
      n588                    :Integer;    //0x584
    m_sUserID                 :string[11]; //0x58C
    m_sIPaddr                 :string;     //0x598
    m_sIPLocal                :String;
    m_nSocket                 :Integer;    //0x59C nSocket
    m_nGSocketIdx             :Integer;    //0x5A0 wGateIndex SOCKET ID
    m_nGateIdx                :Integer;    //0x5A8 nGateIdx
    m_nSoftVersionDate        :Integer;    //0x5AC
    m_dLogonTime              :TDateTime;  //0x5B0
    m_dwLogonTick             :LongWord;   //0x5B8
    m_boReadyRun              :Boolean;    //0x5BC
    m_nSessionID              :Integer;    //0x5C0
    m_nPayMent                :Integer;    //0x5C4
    m_nPayMode                :Integer;    //0x5C8
    m_SessInfo                :pTSessInfo;
    m_dwLoadTick              :LongWord;   //0x5CC
    m_nServerIndex            :Integer;    //0x5D0
    m_boEmergencyClose        :Boolean;    //0x5D4
    m_boSoftClose             :Boolean;    //0x5D5
    m_boKickFlag              :Boolean;    //0x5D6  (Byte)(@kick )
    m_boReconnection          :Boolean;    //0x5D7
    m_boRcdSaved              :Boolean;    //0x5D8
    m_boSwitchData            :Boolean;    //0x5D9
    m_nWriteChgDataErrCount   :Integer;    //0x5DC
    m_sSwitchMapName          :String;     //0x5E0
    m_nSwitchMapX             :Integer;    //0x5E4
    m_nSwitchMapY             :Integer;    //0x5E8
    m_boSwitchDataSended      :Boolean;    //0x5EC
    m_dwChgDataWritedTick     :LongWord;   //0x5F0
      m_dw5D4                 :LongWord;   //0x5F4
      n5F8                    :Integer;    //0x5F8
      n5FC                    :Integer;    //0x5FC
    m_dwHitIntervalTime       :LongWord;
    m_dwMagicHitIntervalTime  :LongWord;
    m_dwRunIntervalTime       :LongWord;
    m_dwWalkIntervalTime      :LongWord;
    m_dwTurnIntervalTime      :LongWord;
    m_dwActionIntervalTime    :LongWord;
    m_dwRunLongHitIntervalTime:LongWord;
    m_dwRunHitIntervalTime    :LongWord;
    m_dwWalkHitIntervalTime   :LongWord;
    m_dwRunMagicIntervalTime  :LongWord;


    m_dwMagicAttackTick       :LongWord;   //0x600
    m_dwMagicAttackInterval   :LongWord;   //0x604
    m_dwAttackTick            :LongWord;   //0x608
    m_dwMoveTick              :LongWord;   //0x60C
    m_dwAttackCount           :LongWord;   //0x610
    m_dwAttackCountA          :LongWord;   //0x614
    m_dwMagicAttackCount      :LongWord;   //0x618
    m_dwMoveCount             :LongWord;   //0x61C
    m_dwMoveCountA            :LongWord;   //0x620
    m_nOverSpeedCount         :Integer;   //0x624
    m_boDieInFight3Zone       :Boolean;    //0x628
    m_Script                  :pTScript;    //0x62C
    m_NPC                     :TBaseObject;   //0x630
    m_nVal                    :array[0..9] of Integer;     //0x634 - 658
    m_nMval                   :array[0..99] of Integer;
    m_DyVal                   :array[0..9] of Integer; //0x65C - 680
    m_sPlayDiceLabel          :String;
    m_boTimeRecall            :Boolean;   //0x684
    m_dwTimeRecallTick        :LongWord;  //0x688
    m_sMoveMap                :String;    //0x68C
    m_nMoveX                  :Integer;   //0x690
    m_nMoveY                  :Integer;   //0x694
      bo698                   :Boolean;   //0x698
      n69C                    :Integer;   //0x69C
    m_dwSaveRcdTick           :LongWord;  //0x6A0
    m_btBright                :Byte;
    m_boNewHuman              :Boolean;   //0x6A8
    m_boSendNotice            :Boolean;   //0x6A9
    m_dwWaitLoginNoticeOKTick :LongWord;
    m_boLoginNoticeOK         :Boolean;   //0x6AA
      bo6AB                   :Boolean;   //0x6AB
    m_boExpire                :Boolean;   //0x6AC
    m_dwShowLineNoticeTick    :LongWord;  //0x6B0
    m_nShowLineNoticeIdx      :Integer;   //0x6B4

    //m_AddUseItems             :array[9..12] of TUserItem;
    m_nSoftVersionDateEx      :Integer;
    m_CanJmpScriptLableList   :TStringList;
    m_nScriptGotoCount        :Integer;
    m_sScriptCurrLable        :String;
    m_sScriptGoBackLable      :String;
    m_dwTurnTick              :LongWord;
    m_wOldIdent               :Word;
    m_btOldDir                :Byte;

    m_boFirstAction           :Boolean;
    m_dwActionTick            :LongWord;
    m_sDearName               :String[ActorNameLen];
    m_DearHuman               :TPlayObject;

    m_xLoveInfo               :TLover;

    m_boCanDearRecall         :Boolean;
    m_boCanMasterRecall       :Boolean;
    m_dwDearRecallTick        :LongWord;
    m_dwMasterRecallTick      :LongWord;
    m_sMasterName             :String[ActorNameLen];
    m_MasterHuman             :TPlayObject;
    m_MasterList              :TList;
    m_boMaster                :Boolean;
    m_btCreditPoint           :Byte;
    m_btMarryCount            :Byte;
    m_btReLevel               :Byte;
    m_btReColorIdx            :Byte;
    m_dwReColorTick           :LongWord;
    m_nKillMonExpMultiple     :Integer;
    m_dwGetMsgTick            :LongWord;

    m_boSetStoragePwd         :Boolean;
    m_boReConfigPwd           :Boolean;
    m_boCheckOldPwd           :Boolean;
    m_boUnLockPwd             :Boolean;
    m_boUnLockStoragePwd      :Boolean;
    m_boPasswordLocked        :Boolean;
    m_btPwdFailCount          :Byte;
    m_boLockLogon             :Boolean;
    m_boLockLogoned           :Boolean;
    m_sTempPwd                :String[7];
    m_sStoragePwd             :String[7];
    m_PoseBaseObject          :TBaseObject;
    m_boStartMarry            :Boolean;
    m_boStartMaster           :Boolean;    
    m_boStartUnMarry          :Boolean;
    m_boStartUnMaster         :Boolean;    
    m_boFilterSendMsg         :Boolean;
    m_nKillMonExpRate         :Integer;
    m_nPowerRate              :Integer;
    m_dwKillMonExpRateTime    :LongWord;
    m_dwPowerRateTime         :LongWord;
    m_dwRateTick              :LongWord;


    m_boCanUseItem            :Boolean;
    m_boCanDeal               :Boolean;
    m_boCanDrop               :Boolean;
    m_boCanGetBackItem        :Boolean;
    m_boCanWalk               :Boolean;
    m_boCanRun                :Boolean;
    m_boCanHit                :Boolean;
    m_boCanSpell              :Boolean;
    m_boCanSendMsg            :Boolean;

    m_nMemberType             :Integer;
    m_nMemberLevel            :Integer;
    m_boSendMsgFlag           :Boolean;
    m_boChangeItemNameFlag    :Boolean;

    m_nGameGold               :Integer;
    m_nBankGold               :Integer;
    m_boDecGameGold           :Boolean;
    m_dwDecGameGoldTime       :LongWord;
    m_dwDecGameGoldTick       :LongWord;
    m_nDecGameGold            :Integer;

    m_boIncGameGold           :Boolean;
    m_dwIncGameGoldTime       :LongWord;
    m_dwIncGameGoldTick       :LongWord;
    m_nIncGameGold            :Integer;

    m_nGamePoint              :Integer;
    m_dwIncGamePointTick      :LongWord;
    
    m_nPayMentPoint           :Integer;
    m_dwPayMentPointTick      :LongWord;

    m_dwDecHPTick             :LongWord;
    m_dwIncHPTick             :LongWord;

    m_GetWhisperHuman         :TPlayObject;
    m_dwClearObjTick          :LongWord;
    m_wContribution           :Word;
    m_sRankLevelName          :String;
    m_boFilterAction          :Boolean;
    m_dwAutoGetExpTick        :LongWord;
    m_nAutoGetExpTime         :Integer;
    m_nAutoGetExpPoint        :Integer;
    m_AutoGetExpEnvir         :TEnvirnoment;
    m_boAutoGetExpInSafeZone  :Boolean;
    m_DynamicVarList          :TList;
    m_dwClientTick            :LongWord;
    m_boTestSpeedMode         :Boolean; 

      {
      LatestRevivalTime       :LongWord;
      wObjectType  :Word;
      Feature      :TObjectFeature;
      boOpenHealth :Boolean;
      dwOpenHealthStart :LongWord;
      dwOpenHealthTime  :LongWord;
      dwMapMoveTime    :LongWord;

      dwTargetFocusTime:LongWord;

      dwWalkTime  :LongWord;
      AntiMagic     :Integer;
      BoAbilSeeHealGauge :Boolean;
      dwStruckTime :LongWord;
      nMeatQuality :Integer;
      nHitTime     :Integer;
      bofirst      :Boolean;
      nSlaveMakeLevel :Integer;
      dwNextHitTime  :LongWord;
      dwNextWalkTime :LongWord;
      boUsePoison    :Boolean;
      }
    nRunCount:Integer;
    dwRunTimeCount:LongWord;
    m_dwDelayTime:LongWord;

    m_dwBBSDelayTime:LongWord;
    m_dwBBSPostDelay:LongWord;
  private
    function  ClientDropGold(nGold:Integer):Boolean;
    function  PlayGetPoseCreate: TPlayObject;
    procedure ClientQueryBagItems();
    procedure ClientQueryStorageItems();
    procedure ClientQueryUserState(PlayObject:TPlayObject;nX,nY:Integer);
    function  ClientDropItem(sItemName:String;nItemIdx:Integer;nAmount:Integer):Boolean;
    function  ClientPickUpItem: Boolean;
    procedure ClientOpenDoor(nX,nY:Integer);
    procedure ClientTakeOnItems(btWhere:Byte;nItemIdx:integer;sItemName:String);
    procedure ClientTakeOffItems(btWhere:Byte;nItemIdx:integer;sItemName:String);
    procedure ClientUseItems(nItemIdx:Integer;sItemName:String);
    function  UseStdmodeFunItem(StdItem:TItem):Boolean;
    function  ClientGetButchItem(BaseObject:TBaseObject;nX,nY:Integer;btDir:Byte;var dwDelayTime:LongWord):Boolean;
    procedure ClientChangeMagicKey(nSkillIdx,nKey:integer);
    procedure ClientClickNPC(NPC:Integer);
    procedure ClientMerchantDlgSelect(nParam1: Integer;sMsg: String);
    procedure GemInfo(nParam1: Integer;sMsg: String);
    procedure ClientMerchantQuerySellPrice(nParam1,nMakeIndex:Integer;sMsg: String; nAmount:Integer);
    procedure ClientUserSellItem(nParam1,nMakeIndex:Integer;sMsg: String; nAmount:Integer);
    procedure ClientUserBuyItem(nIdent,nParam1,nInt,nZz:Integer;sMsg: String);
    procedure ClientQueryRepairCost(nParam1,nInt:Integer;sMsg: String);
    procedure ClientRepairItem(nParam1,nInt:Integer;sMsg: String);
    procedure ClientTradeGT(nParam1:Integer);
    procedure ClientOpenShop(nParam1:integer;sData:String);
    procedure ClientRequestGameShopList;
    {lover}
    procedure ChangeAvailability;
    procedure RequestRelay;
    procedure SendRequestRelay(name:string);
    procedure SendRequestFail(name:string);
    procedure RequestDivorce;
    procedure OpenLoverWindow;
    {}
    procedure ClientGroupClose();
    procedure ClientCreateGroup(sHumName:String);
    procedure ClientAddGroupMember(sHumName:String);
    procedure ClientDelGroupMember(sHumName:String);
    procedure ClientDealTry(sHumName:String);
    procedure ClientAddDealItem(nItemIdx:integer;sItemName:String; nAmount:Integer);
    procedure ClientDelDealItem(nItemIdx:integer;sItemName:String);
    procedure ClientCancelDeal();
    procedure ClientChangeDealGold(nGold:Integer);
    procedure ClientDealEnd();
    procedure ClientCancelRefine();
    procedure ClientStorageItem(NPC:TObject;nItemIdx:Integer;sMsg:String; nAmount:Integer);
    procedure ClientTakeBackStorageItem(NPC:TObject;nItemIdx:Integer;sMsg:String);
    procedure ConsignItem(NPC:TObject;nItemIdx:Integer;sMsg:String);
    procedure ClientMakeDrugItem(NPC:TObject;nItemName:String);
    procedure ClientOpenGuildDlg();
    procedure ClientGuildHome();
    procedure ClientGuildMemberList();
    procedure ClientGuildAddMember(sHumName:String);
    procedure ClientGuildDelMember(sHumName:String);
    procedure ClientGuildUpdateNotice(sNotict:String);
    procedure ClientGuildUpdateRankInfo(sRankInfo:String);
    procedure ClientGuildAlly();
    procedure ClientGuildBreakAlly(sGuildName:String);
    procedure ClientAdjustBonus(nPoint:Integer;sMsg:String);
    procedure ClientSendFriendsList();
    procedure ClientFriendStatusChanged(sPlayerName: String;Status: Byte);
    procedure ClientFriendChangeState(Online: Boolean = True);
    procedure ClientAddFriend(sPlayerName:String;BlackList:Byte);
    procedure ClientDelFriend(sPlayerName:String);
    procedure ClientReqAddFriend(sPlayerName:String;BlackList:Byte);
    procedure ClientReqDelFriend(sPlayerName:String);
    procedure ClientUpdateMemoFriend(body:String);
    procedure ClientReqMemoFriend(sFriendName:String);

    procedure ClientRequestMailList(ProcessMsg: pTProcessMessage);
    procedure ClientSendMail(ProcessMsg: pTProcessMessage);
    procedure ClientReadMail(ProcessMsg: pTProcessMessage);
    procedure ClientDeleteMail(ProcessMsg: pTProcessMessage);
    procedure ClientSetMailStatus(ProcessMsg: pTProcessMessage);
    procedure ClientRequestBlockList(ProcessMsg: pTProcessMessage);
    procedure ClientAddBlock(ProcessMsg: pTProcessMessage);
    procedure ClientDelBlock(ProcessMsg: pTProcessMessage);

    procedure ClientRequestGTList(ProcessMsg: pTProcessMessage);
    procedure ClientRequestDecoList(ProcessMsg: pTProcessMessage);
    procedure ClientBuyGT(ProcessMsg:pTProcessMessage);
    procedure ClientBuyDecoItem(ProcessMsg:pTProcessMessage);
    procedure ClientRequestBBSList(ProcessMsg: pTProcessMessage);
    procedure ClientRequestBBSMsg(ProcessMsg: pTProcessMessage);
    procedure ClientPostBBSMsg(ProcessMsg: pTProcessMessage;Body:String);
    procedure ClientDeleteBBSMsg(ProcessMsg: pTProcessMessage);

    function  ClientChangeDir(wIdent:Word;nX,nY,nDir:Integer;var dwDelayTime:LongWord):Boolean;
    function  ClientWalkXY(wIdent:Word;nX, nY:Integer;boLateDelivery:Boolean;var dwDelayTime:LongWord): Boolean;

    function  ClientHorseRunXY(wIdent:Word;nX,nY:Integer;boLateDelivery:Boolean;var dwDelayTime:LongWord):Boolean;
    function  ClientRunXY(wIdent:Word;nX,nY:Integer;nFlag:Integer;var dwDelayTime:LongWord):Boolean;
    function  ClientHitXY(wIdent:Word;nX,nY,nDir:Integer;boLateDelivery:Boolean;var dwDelayTime:LongWord):Boolean;
    function  ClientSitDownHit(nX,nY,nDir:Integer;var dwDelayTime:LongWord):Boolean;
    function  ClientSpellXY(wIdent:Word;nKey:Integer;nTargetX, nTargetY:Integer;TargeTBaseObject: TBaseObject;boLateDelivery:Boolean;var dwDelayTime:LongWord):Boolean;


    function  CheckTakeOnItems(nWhere: Integer;var StdItem:TStdItem):Boolean;
    function  GetUserItemWeitht(nWhere: Integer):Integer;

    procedure SendDelDealItem(UserItem:pTUserItem);
    procedure SendAddDealItem(UserItem:pTUserItem);



    procedure OpenDealDlg(BaseObject:TBaseObject);
    function  EatItems(StdItem:TItem;UserItem:pTUserItem):Boolean;
    function  EatUseItems(nShape:integer):Boolean;
    function  ReadBook(StdItem:TItem):Boolean;
    function  DayBright():Byte;
    procedure BaseObjectMove(sMap,sX,sY:String);
    procedure MoveToHome();
    function  RepairWeapon():Boolean;
    function  SuperRepairWeapon():Boolean;
    function  WinLottery():Boolean;
    procedure ChangeServerMakeSlave(SlaveInfo:pTSlaveInfo);
    function  WeaptonMakeLuck():Boolean;
    function  PileStones(nX,nY:Integer):Boolean;
    function  RunTo(btDir: Byte;boFlag:boolean;nDestX,nDestY:Integer):Boolean;
    procedure ThrustingOnOff(boSwitch:Boolean);
    procedure HalfMoonOnOff(boSwitch: Boolean);
    procedure RedHalfMoonOnOff(boSwitch: Boolean);
    procedure SkillCrsOnOff(boSwitch: Boolean);
    procedure SkillTwinOnOff(boSwitch: Boolean);
    function  AllowFireHitSkill():Boolean;
    function  AllowTwinHitSkill():Boolean;
    function  RandomOreDura: integer;
    procedure MakeMine();
    procedure MakeMine2();
    procedure MakeMine3();

    function  GetRangeHumanCount():Integer;
    procedure GetHomePoint();
    function  GetStartPoint(var StartPoint:pTStartPoint):Boolean;

    procedure MobPlace(sX, sY, sMonName, sCount: String);


    procedure LogonTimcCost;
    procedure SendNotice();
    procedure SendLogon();
    procedure SendServerConfig();
    procedure SendServerStatus();

//    procedure SendUserName(PlayObject:TPlayObject;nX,nY:Integer);
    function  CretInNearXY(TargeTBaseObject:TBaseObject;nX,nY:Integer):Boolean;
    procedure ClientQueryUserName(target: TBaseObject; x, y: integer);
    procedure SendUseitems();
    procedure SendUseMagic();
    procedure SendSaveItemList(nBaseObject:Integer);
    procedure SendDelItemList(ItemList:TStringList);
    procedure SendAttatckMode();
    procedure SendAdjustBonus();
    procedure SendChangeGuildName();
    procedure SendMapDescription();
    procedure SendGoldInfo(boSendName:Boolean);

    procedure ShowMapInfo(sMap, sX, sY: String);

    function  CancelGroup():Boolean;

    function  DoMotaebo(nDir:Byte;nMagicLevel:Integer):Boolean;
    function  DoSpell(UserMagic:pTUserMagic;nTargetX,nTargetY:Integer;BaseObject:TBaseObject):boolean;
    procedure ReadAllBook;
    function  CheckItemsNeed(StdItem:TItem):Boolean;
    function  CheckItemBindUse(UserItem:pTUserItem):Boolean;
    function  CheckActionStatus(wIdent:Word;var dwDelayTime:LongWord):Boolean;
    procedure RecalcAdjusBonus;
    procedure CheckMarry();
    procedure CheckMaster();
    procedure RefMyStatus;
    procedure ProcessClientPassword(ProcessMsg: pTProcessMessage);
    function CheckDenyLogon: Boolean;
    procedure ProcessSpiritSuite;
    function HorseRunTo(btDir: Byte; boFlag: boolean): Boolean;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure SendSocket(DefMsg: pTDefaultMessage; sMsg: String);virtual;
    procedure SendDefMessage(wIdent: Word; nRecog: Integer; nParam, nTag, nSeries: Word; sMsg: String);
    procedure SearchViewRange();override;
    procedure UpdateVisibleGay(BaseObject:TBaseObject);override;
    procedure PKDie(PlayObject: TPlayObject);
    procedure GameTimeChanged();
    procedure RunNotice();
    function  GemItem(Gem:Integer;ItemIdx:Integer):integer;
    procedure GemItemFail(UserItem:pTUserItem;msg:String);
    function  ItemRepair(Gem:Integer;ItemIdx:Integer):integer;
    procedure CraftFailed(datat:string);
    procedure CreateGem(datat:string);
    function  GetMyStatus():Integer;
    function  IncGold(tGold:Integer):Boolean;
    function  IsEnoughBag():Boolean;
    function  IsAddWeightAvailable(nWeight:Integer):Boolean;
    procedure SendAddItem(UserItem:pTUserItem );
    procedure SendAddStorage(UserItem:pTUserItem );
    procedure SendDelItems(UserItem:pTUserItem);
    procedure Whisper(whostr, saystr: string);
    function  IsBlockWhisper(sName:String):Boolean;
    function  QuestCheckItem(sItemName:String;var nCount:Integer;var nParam:Integer;var nDura:Integer):pTUserItem;
    function  QuestTakeCheckItem(CheckItem:pTUserItem):Boolean;
    procedure GainExp(dwExp:LongWord);
    procedure GetExp(dwExp:LongWord);
    procedure WinExp(dwExp:LongWord);
    function  DecGold(nGold:Integer):Boolean;
    procedure Run();override;
    function  Operate(ProcessMsg:pTProcessMessage):Boolean;override;
    procedure RecalcAbilitys();override; //FFF7
    function  GetSpellPoint(UserMagic:pTUserMagic):Integer;
    procedure MakeSaveRcd(var HumanRcd:THumData);
    procedure DealCancel();
    procedure DealCancelA();
    procedure RefineCancel();
    function  GetShowName():String;override;
    procedure GetBackDealItems();
    procedure GetBackRefineItems();
    procedure Disappear();override;//FFFD
    procedure GoldChange(sChrName:String;nGold:Integer);
    procedure ProcessUserLineMsg(sData:String);
    procedure ProcessSayMsg(sData:String);override;
    procedure ClearStatusTime();
    procedure UserLogon();virtual;
    procedure RefRankInfo(nRankNo:Integer;sRankName:string);
    procedure RefUserState;
    procedure SendGroupMembers();
    procedure JoinGroup(PlayObject:TPlayObject);
    function  GeTBaseObjectInfo():String;
    function  GetHitMsgCount():Integer;
    function  GetSpellMsgCount():Integer;
    function  GetWalkMsgCount():Integer;
    function  GetRunMsgCount():Integer;
    function  GetTurnMsgCount():Integer;
    function  GetSiteDownMsgCount():Integer;
    function  GetDigUpMsgCount():Integer;
    procedure SetScriptLabel(sLabel: String);
    procedure GetScriptLabel(sMsg:String);
    function  LableIsCanJmp(sLabel:String):Boolean;
    function  GetMyInfo():String;
    procedure MakeGhost;override;
    procedure ScatterBagItems(ItemOfCreat:TBaseObject); override;
    procedure DropUseItems(BaseObject:TBaseObject); override;
    procedure RecallHuman(sHumName:String);
    procedure SendAddMagic(UserMagic:pTUserMagic);
    procedure SendDelMagic(UserMagic:pTUserMagic);
    procedure ReQuestGuildWar(sGuildName:String);
    procedure SendUpdateItem(UserItem:pTUserItem);
    procedure GetBagUseItems(var btDc:Byte;var btSc:Byte;var btMc:Byte;var btDura:Byte);
    procedure RecallGuild();
    function MoveToGT(Number:Integer):Boolean;
  //protected
    procedure CmdEndGuild();
    procedure CmdMemberFunction(sCmd,sParam:String);
    procedure CmdMemberFunctionEx(sCmd,sParam:String);

    procedure CmdSearchDear(sCmd,sParam:String);
    procedure CmdSearchMaster(sCmd,sParam:String);
    procedure CmdDearRecall(sCmd,sParam:String);
    procedure CmdMasterRecall(sCmd,sParam:String);
    procedure CmdSbkDoorControl(sCmd,sParam:String);

    procedure CmdClearBagItem(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdShowUseItemInfo(Cmd:pTGameCmd;sHumanName:String);

    procedure CmdBindUseItem(Cmd:pTGameCmd;sHumanName,sItem,sType:String);
    procedure CmdUnBindUseItem(Cmd:pTGameCmd;sHumanName,sItem,sType:String);
    procedure CmdLockLogin(Cmd:pTGameCmd);
    procedure CmdViewDiary(sCMD:String;nFlag:Integer);
    procedure CmdUserMoveXY(sCMD,sX,sY:String);
    procedure CmdSearchHuman(sCMD,sHumanName:String);
    procedure CmdGroupRecall(sCMD:String);
    procedure CmdAllowGroupReCall(sCmd,sParam:String);

    procedure CmdGuildRecall(sCmd,sParam:String);


    procedure CmdChangeAttackMode(nMode:Integer;sParam1,sParam2,sParam3,sParam4,sParam5,sParam6,sParam7:String);
    procedure CmdChangeSalveStatus();
    procedure CmdTakeOnHorse(sCmd,sParam:String);
    procedure CmdTakeOffHorse(sCmd,sParam:String);


    procedure CmdPrvMsg(sCmd:String;nPermission:Integer;sHumanName:String);
    procedure CmdHumanLocal(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdMapMove(Cmd:pTGameCmd;sMapName:String);

    procedure CmdPositionMove(Cmd:pTGameCmd;sMapName,sX,sY:String);

    procedure CmdHumanInfo(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdReLoadAdmin(sCmd:String);
    procedure CmdReloadNpc(sParam:String);
    procedure CmdReloadManage(Cmd:pTGameCmd;sParam:String);
    procedure CmdReloadRobotManage;
    procedure CmdReloadRobot;
    procedure CmdReloadMonItems();
    procedure CmdAdjustExp(Human:TPlayObject;nExp:Integer);
    procedure CmdAddGuild(Cmd:pTGameCmd;sGuildName,sGuildChief:String);
    procedure CmdDelGuild(Cmd:pTGameCmd;sGuildName:String);
    procedure CmdGuildWar(sCmd,sGuildName:String);
    procedure CmdChangeSabukLord(Cmd:pTGameCmd;sCastleName,sGuildName:String;boFlag:Boolean);
    procedure CmdForcedWallconquestWar(Cmd:pTGameCmd;sCastleName:String);
    procedure CmdOPTraining(sHumanName,sSkillName:String;nLevel:Integer);
    procedure CmdOPDeleteSkill(sHumanName,sSkillName:String);
    procedure CmdReloadGuildAll();
    procedure CmdReAlive(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdAdjuestLevel(Cmd:pTGameCmd;sHumanName:String;nLevel:Integer);
    procedure CmdAdjuestExp(Cmd:pTGameCmd;sHumanName,sExp:String);

    procedure CmdBackStep(sCmd:String;nType,nCount:Integer);
    procedure CmdFreePenalty(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdPKpoint(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdIncPkPoint(Cmd:pTGameCmd;sHumanName:String;nPoint:Integer);
    procedure CmdHunger(sCmd,sHumanName:String;nHungerPoint:Integer);
    procedure CmdHair(Cmd:pTGameCmd;sHumanName:String;nHair:Integer);
    procedure CmdTrainingSkill(Cmd:pTGameCmd;sHumanName,sSkillName:String;nLevel:Integer);
    procedure CmdTrainingMagic(Cmd:pTGameCmd;sHumanName,sSkillName:String;nLevel:Integer);

    procedure CmdDelSkill(Cmd:pTGameCmd;sHumanName,sSkillName:String);
    procedure CmdDeleteItem(Cmd:pTGameCmd;sHumanName,sItemName:String;nCount:Integer);
    procedure CmdClearMission(Cmd:pTGameCmd;sHumanName:String);

    procedure CmdTraining(sSkillName:String;nLevel:Integer);
    procedure CmdChangeJob(Cmd:pTGameCmd;sHumanName,sJobName:String);
    procedure CmdChangeGender(Cmd:pTGameCmd;sHumanName,sSex:String);
    procedure CmdMission(Cmd:pTGameCmd;sX,sY:String);
    procedure CmdMobPlace(Cmd:pTGameCmd;sX,sY,sMonName,sCount:String);
    procedure CmdMobLevel(Cmd:pTGameCmd;Param:String);
    procedure CmdMobCount(Cmd:pTGameCmd;sMapName:String);
    procedure CmdHumanCount(Cmd:pTGameCmd;sMapName:String);

    procedure CmdDisableFilter(sCmd,sParam1:String);
    procedure CmdChangeUserFull(sCmd,sUserCount:String);
    procedure CmdChangeZenFastStep(sCmd,sFastStep:String);

    procedure CmdReconnection(sCmd,sIPaddr,sPort:String);
    procedure CmdContestPoint(Cmd:pTGameCmd;sGuildName:String);
    procedure CmdStartContest(Cmd:pTGameCmd;sParam1:String);
    procedure CmdEndContest(Cmd:pTGameCmd;sParam1:String);

    procedure CmdAnnouncement(Cmd:pTGameCmd;sGuildName:String);
    procedure CmdKill(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdMakeItem(Cmd:pTGameCmd;sItemName:String;nCount:Integer);
    procedure CmdSmakeItem(Cmd:pTGameCmd;nWhere,nValueType,nValue:Integer);
    procedure CmdBonuPoint(Cmd:pTGameCmd;sHumName:String;nCount:Integer);
    procedure CmdDelBonuPoint(Cmd:pTGameCmd;sHumName:String);
    procedure CmdRestBonuPoint(Cmd:pTGameCmd;sHumName:String);

    procedure CmdFireBurn(nInt,nTime,nN:Integer);
    procedure CmdTestFire(sCmd:String;nRange,nType,nTime,nPoint:Integer);

    procedure CmdTestStatus(sCmd:String;nType,nTime:Integer);

    procedure CmdDelGold(Cmd:pTGameCmd;sHumName:String;nCount:Integer);
    procedure CmdAddGold(Cmd:pTGameCmd;sHumName:String;nCount:Integer);
    procedure CmdDelGameGold(sCmd,sHumName:String;nPoint:Integer);
    procedure CmdAddGameGold(sCmd,sHumName:String;nPoint:Integer);
    procedure CmdGameGold(Cmd:pTGameCmd;sHumanName:String;sCtr:String;nGold:Integer);
    procedure CmdGamePoint(Cmd:pTGameCmd;sHumanName:String;sCtr:String;nPoint:Integer);
    procedure CmdCreditPoint(Cmd:pTGameCmd;sHumanName:String;sCtr:String;nPoint:Integer);

    procedure CmdMob(Cmd:pTGameCmd;sMonName:String;nCount,nLevel:Integer; nExpRatio:Integer = -1);

    procedure CmdRefineWeapon(Cmd:pTGameCmd;nDC,nMC,nSC,nHit:Integer);
    procedure CmdRecallMob(Cmd:pTGameCmd;sMonName:String;nCount,nLevel,nAutoChangeColor,nFixColor:Integer);
    procedure CmdLuckPoint(sCmd:String;nPerMission:Integer;sHumanName,sCtr,sPoint:String);
    procedure CmdLotteryTicket(sCmd:String;nPerMission:Integer;sParam1:String);
    procedure CmdReloadGuild(sCmd:String;nPerMission:Integer;sParam1:String);
    procedure CmdReloadLineNotice(sCmd:String;nPerMission:Integer;sParam1:String);
    procedure CmdReloadAbuse(sCmd:String;nPerMission:Integer;sParam1:String);

    procedure CmdMobNpc(sCmd:String;nPermission:Integer;sParam1,sParam2,sParam3,sParam4:String);
    procedure CmdNpcScript(sCmd:String;nPermission:Integer;sParam1,sParam2,sParam3:String);
    procedure CmdDelNpc(sCmd:String;nPermission:Integer;sParam1:String);
    procedure CmdKickHuman(Cmd:pTGameCmd;sHumName:String);
    procedure CmdTing(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdSuperTing(Cmd:pTGameCmd;sHumanName,sRange:String);
    procedure CmdMapMoveHuman(Cmd:pTGameCmd;sSrcMap,sDenMap:String);
    procedure CmdShutup(Cmd:pTGameCmd;sHumanName,sTime:String);
    procedure CmdShowMapInfo(Cmd:pTGameCmd;sParam1:String);

    procedure CmdShutupRelease(Cmd:pTGameCmd;sHumanName:String;boAll:Boolean);
    procedure CmdShutupList(Cmd:pTGameCmd;sParam1:String);
    procedure CmdSvnInfo(Cmd:pTGameCmd;sParam1:String);
    procedure CmdShowSbkGold(Cmd:pTGameCmd;sCastleName,sCtr,sGold:String);
    procedure CmdRecallHuman(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdReGotoHuman(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdShowHumanFlag(sCmd:String;nPermission:Integer;sHumanName,sFlag:String);
    procedure CmdShowHumanUnitOpen(sCmd:String;nPermission:Integer;sHumanName,sUnit:String);
    procedure CmdShowHumanUnit(sCmd:String;nPermission:Integer;sHumanName,sUnit:String);



    procedure CmdChangeAdminMode(sCmd:String;nPermission:Integer;sParam1:String;boFlag:Boolean);
    procedure CmdChangeObMode(sCmd:String;nPermission:Integer;sParam1:String;boFlag:Boolean);
    procedure CmdChangeSuperManMode(sCmd:String;nPermission:Integer;sParam1:String;boFlag:Boolean);
    procedure CmdChangeLevel(Cmd:pTGameCmd;sParam1:String);
    procedure CmdChangeDearName(Cmd:pTGameCmd;sHumanName:String;sDearName:String);
    procedure CmdChangeMasterName(Cmd:pTGameCmd;sHumanName:String;sMasterName,sIsMaster:String);
    procedure CmdStartQuest(Cmd:pTGameCmd;sQuestName:String);
    procedure CmdSetPermission(Cmd:pTGameCmd;sHumanName,sPermission:String);
    procedure CmdClearMapMonster(Cmd:pTGameCmd;sMapName,sMonName,sItems:String);
    procedure CmdReNewLevel(Cmd:pTGameCmd;sHumanName,sLevel:String);

    procedure CmdDenyIPaddrLogon(Cmd:pTGameCmd;sIPaddr,sFixDeny:String);
    procedure CmdDelDenyIPaddrLogon(Cmd:pTGameCmd;sIPaddr,sFixDeny:String);
    procedure CmdShowDenyIPaddrLogon(Cmd:pTGameCmd;sIPaddr,sFixDeny:String);

    procedure CmdDenyAccountLogon(Cmd:pTGameCmd;sAccount,sFixDeny:String);
    procedure CmdDelDenyAccountLogon(Cmd:pTGameCmd;sAccount,sFixDeny:String);
    procedure CmdShowDenyAccountLogon(Cmd:pTGameCmd;sAccount,sFixDeny:String);

    procedure CmdDenyCharNameLogon(Cmd:pTGameCmd;sCharName,sFixDeny:String);
    procedure CmdDelDenyCharNameLogon(Cmd:pTGameCmd;sCharName,sFixDeny:String);
    procedure CmdShowDenyCharNameLogon(Cmd:pTGameCmd;sCharName,sFixDeny:String);
    procedure CmdViewWhisper(Cmd:pTGameCmd;sCharName,sParam2:String);
    procedure CmdSpirtStart(sCmd:String;sParam1:String);
    procedure CmdSpirtStop(sCmd:String;sParam1:String);
    procedure CmdSetMapMode(sCmd:String;sMapName,sMapMode,sParam1,sParam2:String);
    procedure CmdShowMapMode(sCmd:String;sMapName:String);
    procedure CmdClearHumanPassword(sCmd:String;nPermission:Integer;sHumanName:String);

    procedure CmdChangeItemName(sCmd,sMakeIndex,sItemIndex,sItemName:String);
    procedure CmdDisableSendMsg(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdEnableSendMsg(Cmd:pTGameCmd;sHumanName:String);
    procedure CmdDisableSendMsgList(Cmd:pTGameCmd);
    procedure CmdTestGetBagItems(Cmd:pTGameCmd;sParam:String);
    procedure CmdMobFireBurn(Cmd:pTGameCmd;sMap,sX,sY,sType,sTime,sPoint:String);
    procedure CmdTestSpeedMode(Cmd:pTGameCmd);

    procedure CmdTradeGT(Cmd:pTGameCmd);

    procedure SendWhisperMsg(PlayObject:TPlayObject);
  end;

  procedure AddUserLog(sMsg:String);

implementation

uses M2Share, Guild, HUtil32, EDcode, ObjNpc, IdSrvClient, Event,
  ObjMon, LocalDB, Castle, EncryptUnit, svMain, ObjMon3, GuildTerritory;



{ TBaseObject }

constructor TBaseObject.Create; //4B780C
begin
  m_boGhost               := False;
  m_dwGhostTick           := 0;
  m_boDeath               := False;
  m_dwDeathTick           := 0;
  m_SendRefMsgTick        := GetTickCount();
  m_btDirection           := 4;
  m_btRaceServer          := RC_MONSTER;
  m_btRaceImg             := 0;
  m_btHair                := 0;
  m_btJob                 := jWarr;
  m_nGold                 := 0;
  m_wAppr                 := 0;
  bo2B9                   := True;
  m_nViewRange            := 5;
  m_sHomeMap              := '0';
  bo94                    := False;
  m_btPermission          := 0;
  m_nLight                := 0;
  m_btNameColor           := 255;
  m_nHitPlus              := 0;
  m_nHitDouble            := 0;
  m_dBodyLuck             := 0;
  m_wGroupRcallTime       := 0;
  m_dwGroupRcallTick      := GetTickCount();
  m_boRecallSuite         := False;
  bo245                   := False;
  m_boTestGa              := False;
  m_boGsa                 := False;
  bo2BA                   := False;
  m_boAbilSeeHealGauge    := False;
  m_boPowerHit            := False;
  m_boUseThrusting        := False;
  m_boUseHalfMoon         := False;
  m_boRedUseHalfMoon      := False;
  m_boFireHitSkill        := False;
  m_boTwinHitSkill        := False;
  m_boTwinHitSkillPhase   := False;
  m_btHitPoint            := 5;
  m_btSpeedPoint          := 15;
  m_nHitSpeed             := 0;
  m_btLifeAttrib          := 0;
  m_btAntiPoison          := 0;
  m_nPoisonRecover        := 0;
  m_nHealthRecover        := 0;
  m_nSpellRecover         := 0;
  m_nAntiMagic            := 0;
  m_nLuck                 := 0;
  m_nPoisonIncrease       := 0;
  m_nFreezingIncrease     := 0;
  m_nIncSpell             := 0;
  m_nIncHealth            := 0;
  m_nIncHealing           := 0;
  m_nPerHealth            := 5;
  m_nPerHealing           := 5;
  m_nPerSpell             := 5;
  m_dwIncHealthSpellTick  := GetTickCount();
  m_btGreenPoisoningPoint := 0;
  m_nFightZoneDieCount    := 0;
//  m_nGoldMax       := 5000000;
  m_nGoldMax              := g_Config.nHumanMaxGold;
  m_nCharStatus           := 0;
  m_nCharStatusEx         := 0;
  FillChar(m_wStatusTimeArr,SizeOf(TStatusTime),#0);   //004B7A83
  FillChar(m_BonusAbil, SizeOf(TNakedAbility), #0);
  FillChar(m_CurBonusAbil, SizeOf(TNakedAbility), #0);

  FillChar(m_wStatusArrValue, Sizeof(m_wStatusArrValue), 0);
  FillChar(m_dwStatusArrTimeOutTick, SizeOf(m_dwStatusArrTimeOutTick), #0);
  m_boAllowGroup          := False;
  m_boAllowGuild          := False;
  btB2                    := 0;
  m_btAttatckMode         := 0;
  m_boInFreePKArea        := False;
  m_boGuildWarArea        := False;
  bo2B0                   := False;
  m_boSuperMan            := False;
  m_boSkeleton            := False;
  bo2BF                   := False;
  m_boHolySeize           := False;
  m_boCrazyMode           := False;
  m_boHallucMode          := False; //Hallucination 
  m_boShowHP              := False;
  bo2F0                   := False;
  m_boAnimal              := False;
  m_boNoItem              := False;
  m_nBodyLeathery         := 50;
  m_boFixedHideMode       := False;
  m_boStickMode           := False;
  m_boNoAttackMode        := False;
  m_boNoTame              := False;
  m_boPKFlag              := False;
  m_nMoXieSuite           := 0;
  m_nHongMoSuite          := 0;
  m_db3B0                 := 0;
  FillChar(m_AddAbil, SizeOf(TAddAbility), #0);
  m_MsgList               := TList.Create;
  m_VisibleHumanList      := TList.Create;
  LIst_3EC                := TList.Create;
  m_VisibleActors         := TList.Create;
  m_VisibleItems          := TList.Create;
  m_VisibleEvents         := TList.Create;
  m_ItemList              := TList.Create;
  m_DealItemList          := TList.Create;
  m_boIsVisibleActive     := False;
  m_nProcessRunCount      := 0;
  m_nDealGolds            := 0;
  m_MagicList             := TList.Create;
  m_StorageItemList       := TList.Create;
  FillChar(m_UseItems, SizeOf(THumanUseItems), 0);
  m_MagicOneSwordSkill    := nil;
  m_MagicPowerHitSkill    := nil;
  m_MagicErgumSkill       := nil;
  m_MagicBanwolSkill      := nil;
  m_MagicRedBanwolSkill   := nil;
  m_MagicFireSwordSkill   := nil;
  m_MagicCrsSkill         := nil;
  m_MagicTwnHitSkill      := nil;

  m_GroupOwner            := nil;
  m_Castle                := nil;
  m_Master                := nil;
  n294                    := 0;
  m_btSlaveExpLevel       := 0;
  bt2A0                   := 0;
  m_GroupMembers          := TStringList.Create;
  m_boHearWhisper         := True;
  m_boBanShout            := True;
  m_boBanGuildChat        := True;
  m_boAllowDeal           := True;
  m_boAllowGroupReCall    := False;
  m_BlockWhisperList      := TStringList.Create;
  m_SlaveList             := TList.Create;
  FillChar(m_WAbil, SizeOf(TAbility), #0);
  FillChar(m_QuestUnitOpen, SizeOf(TQuestUnit),#0);
  FillChar(m_QuestUnit,SizeOf(TQuestUnit),#0);
  m_Abil.Level            := 1;
  m_Abil.AC               := 0;
  m_Abil.MAC              := 0;
  m_Abil.DC               := MakeLong(1,4);
  m_Abil.MC               := MakeLong(1,2);
  m_Abil.SC               := MakeLong(1,2);
  m_Abil.HP               := 15;
  m_Abil.MP               := 15;
  m_Abil.MaxHP            := 15;
  m_Abil.MaxMP            := 15;
  m_Abil.Exp              := 0;
  m_Abil.MaxExp           := 50;
  m_Abil.Weight           := 0;
  m_Abil.MaxWeight        := 100;
  m_boWantRefMsg          := False;
  m_boDealing             := False;
  m_boRefineing           := False;
  m_DealCreat             := nil;
  m_MyGuild               := nil;
  m_nGuildRankNo         := 0;
  m_sGuildRankName       := '';
  m_sScriptLable         := '';
  m_boMission            := False;
  m_boHideMode           := False;
  m_boTDBeffect          := False;
  m_boStoneMode          := False;
  m_boCoolEye            := False;
  m_boUserUnLockDurg     := False;
  m_boTransparent        := False;
  m_boAdminMode          := False;
  m_boObMode             := False;
  m_dwRunTick            := GetTickCount + LongWord(Random(1500));
  m_nRunTime             := 250;
  m_dwSearchTime         := Random(2000) + 2000;
  m_dwSearchTick         := GetTickCount;
  m_dwDecPkPointTick     := GetTickCount;
  m_DecLightItemDrugTick := GetTickCount();
  m_dwPoisoningTick      := GetTickCount;
  m_dwVerifyTick         := GetTickCount();
  m_dwCheckRoyaltyTick   := GetTickCount();
  m_dwDecHungerPointTick := GetTickCount();
  m_dwHPMPTick           := GetTickCount();
  m_dwShoutMsgTick       := 0;
  m_dwTeleportTick       := 0;
  m_dwProbeTick          := 0;
  m_dwMapMoveTick        := GetTickCount();
  m_dwMasterTick         := 0;
  m_nWalkSpeed           := 1400;
  m_nNextHitTime         := 3000;
  m_nWalkCount           := 0;
  m_dwWalkWaitTick       := GetTickCount();
  m_boWalkWaitLocked     := False;
  m_nHealthTick         := 0;
  m_nSpellTick          := 0;
  m_TargetCret          := nil;
  m_LastHiter           := nil;
  m_ExpHitter           := nil;
  m_SayMsgList          := nil;
  m_boDenyRefStatus     := False;
  m_btHorseType         := 0;
  m_btDressEffType      := 0;
  m_btHelmetEffType     := 0;
  m_dwPKDieLostExp      := 0;
  m_nPKDieLostLevel     := 0;
  m_boAddToMaped          := True;
  m_boAutoChangeColor     := False;
  m_dwAutoChangeColorTick := GetTickCount();
  m_nAutoChangeIdx        := 0;

  m_boFixColor            := False;
  m_nFixColorIdx          := 0;
  m_nFixStatus            := -1;
  m_boFastParalysis       := False;

  m_boNastyMode           := False;
  m_boCanLooseDura        := True;
end;

destructor TBaseObject.Destroy;//004B80C0
var
  I           :Integer;
  SendMessage :pTSendMessage;
  nCheckCode  :Integer;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::Destroy Code: %d';
begin
 nCheckCode:=0;
  try
    nCheckCode:=1;
    for I:=0 to m_MsgList.Count -1 do begin
      nCheckCode:=2;
      SendMessage:=m_MsgList.Items[I];
      if (SendMessage.wIdent = RM_SENDDELITEMLIST) and (SendMessage.nParam1 <> 0) then begin
        nCheckCode:=3;
        if TStringList(SendMessage.nParam1) <> nil then begin
          TStringList(SendMessage.nParam1).Free;
          nCheckCode:=4;
        end;
      end;
      if (SendMessage.wIdent = RM_10401) and (SendMessage.nParam1 <> 0) then begin
        nCheckCode:=5;
        Dispose(pTSlaveInfo(SendMessage.nParam1));
      end;
      nCheckCode:=6;
      if (SendMessage.Buff <> nil) then begin
        nCheckCode:=7;
        FreeMem(SendMessage.Buff);
      end;
      Dispose(SendMessage);
      nCheckCode:=8;
    end;//004B81EE
    nCheckCode:=9;
    m_MsgList.Free;
    nCheckCode:=10;
    m_VisibleHumanList.Free;
    nCheckCode:=11;
    for i:=0 to LIst_3EC.Count -1 do begin

    end;//004B8249
    LIst_3EC.Free;
    nCheckCode:=12;
    for i:=0 to m_VisibleActors.Count -1 do begin
      Dispose(pTVisibleBaseObject(m_VisibleActors.Items[i]));
    end;//004B8296
    nCheckCode:=13;
    m_VisibleActors.Free;
    nCheckCode:=14;
    for i:=0 to m_VisibleItems.Count -1 do begin
      Dispose(pTVisibleMapItem(m_VisibleItems.Items[i]));
    end;//004B82E3
    nCheckCode:=15;
    m_VisibleItems.Free;
    nCheckCode:=16;
    m_VisibleEvents.Free;
    nCheckCode:=17;
    for i:=0 to m_ItemList.Count -1 do begin
      Dispose(PTUserItem(m_ItemList.Items[i]));
    end;//004B833E
    nCheckCode:=18;
    m_ItemList.Free;
    nCheckCode:=19;
    for i:=0 to m_DealItemList.Count -1 do begin
      Dispose(pTUserItem(m_DealItemList.Items[i]));
    end;//004B838B
    m_DealItemList.Free;
    nCheckCode:=20;
    for i:=0 to m_MagicList.Count -1 do begin
      Dispose(pTUserMagic(m_MagicList.Items[i]));
    end;//004B83D8
    m_MagicList.Free;
    nCheckCode:=21;
    for i:=0 to m_StorageItemList.Count -1 do begin
      Dispose(pTUserItem(m_StorageItemList.Items[i]));
    end;//004B8425
    m_StorageItemList.Free;
    nCheckCode:=22;
    m_GroupMembers.Free;
    nCheckCode:=23;
    m_BlockWhisperList.Free;
    nCheckCode:=24;
    m_SlaveList.Free;
    nCheckCode:=25;
  except
    on e: Exception do begin
      MainOutMessage(format(sExceptionMsg,[nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
  {
  for I := 0 to CertCheck.Count - 1 do begin
    if CertCheck.Items[I] = Self then begin
      CertCheck.Delete(I);
      break;
    end;
  end;
  }
  inherited;
end;

procedure TBaseObject.ChangePKStatus(boWarFlag:Boolean);//004B84C8
begin
  if m_boInFreePKArea <> boWarFlag then begin
    m_boInFreePKArea:=boWarFlag;
    m_boNameColorChanged:=True;
  end;
end;

function TBaseObject.GetDropPosition (nOrgX,nOrgY,nRange:Integer;var nDX:Integer;var nDY:Integer):Boolean;//004C5238
var
 i,ii,iii:Integer;
 nItemCount,n24,n28,n2C:integer;
begin
  n24:=999;
  Result:=False;
  n28:=0; //09/10
  n2C:=0; //09/10
  for I := 1 to nRange do begin
    for II := -I to I  do begin
      for III := -I to I do begin
        nDX:=nOrgX + III;
        nDY:=nOrgY + II;
        if m_PEnvir.GetItemEx(nDX,nDY,nItemCount) = nil then begin
          if m_PEnvir.bo2C then begin
            Result:=True;
            break;
          end;
        end else begin
          if m_PEnvir.bo2C and (n24 > nItemCount) then begin
            n24:=nItemCount;
            n28:=nDX;
            n2C:=nDY;
          end;
        end;
      end;
      if Result then break;
    end;
    if Result then break;
  end;
  if not Result then begin
    if n24 < 8 then begin
      nDX:=n28;
      nDY:=n2C;
    end else begin
      nDX:=nOrgX;
      nDY:=nOrgY;
    end;
  end;
end;
//004C5478
function  TBaseObject.DropItemDown (UserItem:pTUserItem;nScatterRange:Integer;boDieDrop:Boolean;ItemOfCreat,DropCreat:TBaseObject): Boolean;
var
   dx, dy, idura: integer;
   MapItem, pr: pTMapItem;
   StdItem:TItem;
   logcap: string;
   ItemCount:integer;
begin
   Result := FALSE;
   StdItem:= UserEngine.GetStdItem (UserItem.wIndex);
   if StdItem <> nil then begin
      if StdItem.StdMode = 40 then begin
         idura := UserItem.Dura;
         idura := idura - 2000;
         if idura < 0 then idura := 0;
         UserItem.Dura := idura;
      end;
      {
      if StdItem.Shape = 219 then begin //CoupleRing
      Result := FALSE;
      exit;
      end;
       }
      New(MapItem);
      MapItem.UserItem := UserItem^;
      MapItem.Name := GetItemName(UserItem);

      MapItem.Looks := StdItem.Looks;
      if StdItem.StdMode = 45 then begin 
         MapItem.Looks := GetRandomLook (MapItem.Looks, StdItem.Shape);
      end else if StdItem.StdMode = 48 then begin
        MapItem.Name := GetDecoName(MakeWord(UserItem.btValue[5],UserItem.btValue[6])) + '[7]';
        MapItem.Looks := MakeWord(UserItem.btValue[5],UserItem.btValue[6]) + 10000;
      end;
      MapItem.AniCount := StdItem.AniCount;
      MapItem.Reserved := 0;
      MapItem.Count := 1;
      MapItem.OfBaseObject:=ItemOfCreat;
      MapItem.dwCanPickUpTick:=GetTickCount();
      MapItem.DropBaseObject:=DropCreat;


      if m_btRaceServer = 140 then begin  //if the race = parts of em then the drop should be randomly below the mob not at it's location
        dx := random(10);
        dy := random(10) + 5;
        nScatterRange:=2;
        GetDropPosition ((m_nCurrX - 5) + dx, m_nCurrY + dy, nScatterRange, dx, dy);
      end else if StdItem.StdMode = 48 then begin //decoration items
        dx:= m_nCurrx;
        dy:= m_nCurry;
        m_PEnvir.GetItemEx(dx,dy,itemcount);
        if (itemcount > 0) or (m_PEnvir.m_GuildTerritory =  nil) then begin
          Dispose (MapItem);
          exit;
        end;
        TTerritory(TGuild(m_MyGuild).m_Territory).NewDecoration(UserItem,dx,dy,m_PEnvir,True);
      end else
        GetDropPosition (m_nCurrX, m_nCurrY, nScatterRange, dx, dy);
      pr := m_PEnvir.AddToMap (dx, dy, OS_ITEMOBJECT, TObject (MapItem));
      if pr = MapItem then begin
        if MapItem.UserItem.Amount > 1 then
          SendRefMsg (RM_ITEMSHOW, MapItem.Looks, integer(MapItem), dx, dy, MapItem.Name + '(' + IntToStr(MapItem.UserItem.Amount) + ')')
        else
          SendRefMsg (RM_ITEMSHOW, MapItem.Looks, integer(MapItem), dx, dy, MapItem.Name);
         if boDieDrop then logcap := '15'
         else logcap := '7';
         if not IsCheapStuff (StdItem.StdMode) then
            //004C5716
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog (logcap + #9 +
                        m_sMapName + #9 +
                        IntToStr(m_nCurrX) + #9 +
                        IntToStr(m_nCurrY) + #9 +
                        m_sCharName + #9 +
                        //UserEngine.GetStdItemName(ui.wIndex) + #9 +
                        StdItem.Name + #9 +
                        IntToStr(UserItem.MakeIndex) + #9 +
                        BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
                        '0');
         Result := TRUE;
      end else begin
         Dispose (MapItem);
      end;
   end;
end;

procedure TBaseObject.GoldChanged();//004C49F4
begin
  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendUpdateMsg(Self,RM_GOLDCHANGED,0,0,0,0,'');
  end;
end;
procedure TBaseObject.BankGoldChanged();//004C49F4
begin
  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendUpdateMsg(Self,RM_BACKGOLDCHANGED,0,0,0,0,'');
  end;
end;
procedure TBaseObject.GameGoldChanged();//004C49F4
begin
  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendUpdateMsg(Self,RM_GAMEGOLDCHANGED,0,0,0,0,'');
  end;
end;

procedure TBaseObject.BoxMsg(Cret:TBaseObject; sMsg:String);
begin
  if Cret.m_btRaceServer <> RC_PLAYOBJECT then begin
    MainOutMessage('TCreature.BoxMsg : not Human');
    exit;
  end;

  Cret.SendMsg(Self,RM_MENU_OK,0,Integer(Cret),0,0,sMsg);
end;

function TBaseObject.CanMove: Boolean;
begin
  if (not m_boDeath) and (not m_boGhost) and
    (m_wStatusTimeArr[POISON_STONE] = 0) and
    (m_wStatusTimeArr[POISON_FREEZE] = 0) and
    (m_wStatusTimeArr[POISON_STUN] = 0) and
    (m_wStatusTimeArr[POISON_DONTMOVE] = 0) then
    Result := True
  else
    Result := False;
end;

function TBaseObject.GetHitSpeed: Integer;
begin
  if (m_wStatusTimeArr[POISON_SLOWDOWN] > 0) then begin
    Result := (m_nNextHitTime div 2) + m_nNextHitTime;
    exit;
  end else begin
    Result := m_nNextHitTime;
  end;
end;

function TBaseObject.GetWalkSpeed: Integer;
begin
  if (m_wStatusTimeArr[POISON_SLOWDOWN] > 0) then begin
    Result := (m_nWalkSpeed div 2) + m_nWalkSpeed;
    exit;
  end else begin
    Result := m_nWalkSpeed;
  end;
end;

function  TPlayObject.ClientPickUpItem: Boolean; //004C5CB0
  function IsSelf(BaseObject:TBaseObject):Boolean;
  begin
    if (BaseObject = nil) or (Self = BaseObject) then Result:=True
    else Result:=False;
  end;
  function IsOfGroup(BaseObject:TBaseObject):Boolean;
  var
    I: Integer;
    GroupMember:TBaseObject;
  begin
    Result:=False;
    if m_GroupOwner = nil then exit;
    for I := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
      GroupMember:=TBaseObject(m_GroupOwner.m_GroupMembers.Objects[i]);
      if GroupMember = BaseObject then begin
        Result:=True;
        break;
      end;
    end;
  end;
var
  UserItem:PTUserItem;
  UserItem2:pTUserItem;
  MapItem:pTMapItem;
  StdItem:TItem;
  I:Integer;
  boSucces:Boolean;
  nDateDropped:DWord;
begin
  Result:=False;
  if m_boDealing then exit;
  MapItem:=m_PEnvir.GetItem (m_nCurrX,m_nCurrY);
  if MapItem = nil then exit;

  if (GetTickCount - MapItem.dwCanPickUpTick) > g_Config.dwFloorItemCanPickUpTime {2 * 60 * 1000} then begin
    MapItem.OfBaseObject:=nil;
  end;
  if not IsSelf(TBaseObject(MapItem.OfBaseObject)) and not IsOfGroup(TBaseObject(MapItem.OfBaseObject)) then begin
    SysMsg(g_sCanotPickUpItem,c_Red,t_Hint);
    exit;
  end;
  //gold
  if CompareText (MapItem.Name, sSTRING_GOLDNAME) = 0 then begin
    if m_PEnvir.DeleteFromMap (m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
      if IncGold (MapItem.Count) then begin
        SendRefMsg (RM_ITEMHIDE, 0, Integer(MapItem), m_nCurrX, m_nCurrY, '');
        if g_boGameLogGold then //004C5E8C
           AddGameDataLog('4' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     sSTRING_GOLDNAME + #9 +
                     IntToStr(MapItem.Count) + #9 +
                     '1' + #9 +
                     '0');
        GoldChanged;
        Dispose(MapItem);
      end else
        m_PEnvir.AddToMap (m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem));
    end;
    exit;
  end;

  boSucces:=FALSE;
  if TItem(UserEngine.GetStdItem (MapItem.UserItem.wIndex)).StdMode = 45 then begin
    if (m_WAbil.Weight + (TItem(UserEngine.GetStdItem (MapItem.UserItem.wIndex)).Weight * MapItem.UserItem.Amount)) <= m_WAbil.MaxWeight then
      boSucces:=TRUE;
  end else
    if IsEnoughBag then
      boSucces:=TRUE;

  if boSucces then begin
    if m_PEnvir.DeleteFromMap (m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
      New(UserItem);
      UserItem^:= MapItem.UserItem;
      StdItem:=UserEngine.GetStdItem (UserItem.wIndex);
      if StdItem.StdMode = 48 then begin //guild decoration item
        nDateDropped:=Makelong(MakeWord(UserItem.btValue[1],UserItem.btValue[2]),MakeWord(UserItem.btValue[3], UserItem.btValue[4]));
        inc(nDateDropped,120000);
        if (m_MyGuild = nil) or (TTerritory(TGuild(m_MyGuild).m_Territory)=nil)  or (UserItem.btValue[0] <> TTerritory(TGuild(m_MyGuild).m_Territory).TerritoryNumber) then begin
          SysMsg('You can only pickup decorations if your guild owns the Guild Territory',c_Red,t_Hint);
          StdItem := nil;
        end;
        if (stditem <> nil) and (nDateDropped < DateTimeToUnix(Now())) then begin //fastest way to stop ppl from picking up
          if IsGuildMaster = false then begin
            SysMsg('Only Guild leaders can pickup decoration after 2 minutes',c_Red,t_Hint);
            StdItem := nil;
          end;
        end;
        if StdItem <> nil then
          TTerritory(TGuild(m_MyGuild).m_Territory).DeleteDecoration(m_nCurrX,m_nCurry,m_PEnvir);
      end;
      if (StdItem <> nil) and IsAddWeightAvailable (UserEngine.GetStdItemWeight(UserItem.wIndex)) then begin
        SendMsg (self, RM_ITEMHIDE, 0, integer(MapItem), m_nCurrX, m_nCurrY, '');
        if StdItem.StdMode = 45 then begin
          if CheckItems(StdItem.Name) <> nil then begin
            UserItem2:=CheckItems(StdItem.Name);
            inc(UserItem2.Amount,UserItem.Amount);
            WeightChanged();
            UserItem.MakeIndex:=UserItem2.MakeIndex;
          end;
        end else
          AddItemToBag(UserItem);
        if m_btRaceServer = RC_PLAYOBJECT then begin
          if UserItem2 = nil then
            SendAddItem(UserItem)
          else begin
            for I:=0 to UserItem.Amount-1 do //ugly i know but by far simpler then the alternative
              SendAddItem(UserItem);
          end;
        end;


        if not IsCheapStuff (StdItem.StdMode) then
        if StdItem.NeedIdentify = 1 then  //004C60FF
          AddGameDataLog('4' +  #9 +
                                    m_sMapName + #9 +
                                    IntToStr(m_nCurrX) + #9 +
                                    IntToStr(m_nCurrY) + #9 +
                                    m_sCharName + #9 +
                                    //UserEngine.GetStdItemName(pu.wIndex) + #9 +
                                    StdItem.Name + #9 +
                                    IntToStr(UserItem.MakeIndex) + #9 +
                                    '1' + #9 +
                                    '0');
        Dispose(MapItem);
        Result:=TRUE;
      end else begin
        Dispose(UserItem);
        m_PEnvir.AddToMap(m_nCurrX, m_nCurrY, OS_ITEMOBJECT, TObject(MapItem));
      end;
    end;
  end;
end;



procedure TPlayObject.RunNotice;//004DA588
var
  Msg:TProcessMessage;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::RunNotice';
begin
  if m_boEmergencyClose or m_boKickFlag or m_boSoftClose then begin
    if m_boKickFlag then SendDefMessage(SM_OUTOFCONNECTION,0,0,0,0,'');
    MakeGhost();
  end else begin
    try
      if not m_boSendNotice then begin
        SendNotice();
        m_boSendNotice:=True;
        m_dwWaitLoginNoticeOKTick:=GetTickCount();
      end else begin
        if GetTickCount - m_dwWaitLoginNoticeOKTick > 10 * 1000 then begin
          m_boEmergencyClose:=True;
        end;

        while GetMessage(@Msg) do begin
          if msg.wIdent = CM_LOGINNOTICEOK then begin
            m_boLoginNoticeOK:=True;
            m_dwClientTick:=Msg.nParam1;
            SysMsg(IntToStr(m_dwClientTick),c_Red,t_Notice);
          end;
        end;
      end;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;
end;
procedure TPlayObject.WinExp(dwExp: LongWord);
begin
  dwExp:=g_Config.dwKillMonExpMultiple * dwExp; //系统指定杀怪经验倍数
  dwExp:=LongWord(m_nKillMonExpMultiple) * dwExp; //人物指定的杀怪经验倍数

  dwExp:=ROUND((m_nKillMonExpRate / 100) * dwExp); //人物指定的杀怪经验倍数
  if m_PEnvir.Flag.boEXPRATE then
    dwExp:=ROUND((m_PEnvir.Flag.nEXPRATE / 100) * dwExp); //地图上指定杀怪经验倍数

  if m_boExpItem then begin //物品经验倍数
    dwExp:=ROUND(m_rExpItem * dwExp);
  end;
  GetExp(dwExp);
end;

procedure TPlayObject.GetExp(dwExp: LongWord);//004BEB74
begin

  Inc(m_Abil.Exp,dwExp);
  AddBodyLuck(dwExp * 0.002);
  SendMsg(Self,RM_WINEXP,0,dwExp,0,0,'');
  
  if m_Abil.Exp >= m_Abil.MaxExp then begin
    Dec(m_Abil.Exp,m_Abil.MaxExp);
    if m_Abil.Level < MAXUPLEVEL then begin
      Inc(m_Abil.Level);
    end;

    HasLevelUp(m_Abil.Level - 1);
    AddBodyLuck(100);
      //004BECDC
      AddGameDataLog('12' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_Abil.Level) + #9 +
                     IntToStr(m_Abil.Exp) + #9 +
                     m_sCharName + #9 +
                     '0' + #9 +
                     '0' + #9 +
                     '1' + #9 +
                     '0');
    IncHealthSpell(2000,2000);
  end;
end;
procedure TBaseObject.RecalcLevelAbilitys();//004BF7DC
var
  nLevel,n:integer;
begin
{$IF OEMVER = OEM775}

{$ELSE}
  nLevel:=m_Abil.Level;
  case m_btJob of
    jTaos: begin
      //m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND((nLevel / 6 + 2.5) * nLevel));
      m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND(((nLevel / g_Config.nLevelValueOfTaosHP + g_Config.nLevelValueOfTaosHPRate) * nLevel)));

      //m_Abil.MaxMP:=_MIN(High(Word),13 + ROUND((nLevel / 8)* 2.2 * nLevel));
      m_Abil.MaxMP:=_MIN(High(Word),13 + ROUND(((nLevel / g_Config.nLevelValueOfTaosMP)* 2.2 * nLevel)));

      m_Abil.MaxWeight:=50 + ROUND((nLevel / 4) * nLevel);
      m_Abil.MaxWearWeight:=15 + ROUND((nLevel / 50) * nLevel);
      m_Abil.MaxHandWeight:=12 + ROUND((nLevel / 42) * nLevel);

      n:=nLevel div 7;
      m_Abil.DC:=MakeLong(_MAX(n-1, 0), _MAX(1, n));
      m_Abil.MC:=0;
      m_Abil.SC:=MakeLong(_MAX(n-1, 0), _MAX(1, n));
      m_Abil.AC:=0;

      n:=ROUND(nLevel / 6);
      m_Abil.MAC:=MakeLong(n div 2, n + 1);
    end;
    jWizard: begin
      //m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND((nLevel / 15 + 1.8) * nLevel));
      m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND(((nLevel / g_Config.nLevelValueOfWizardHP + g_Config.nLevelValueOfWizardHPRate) * nLevel)));

      m_Abil.MaxMP:=_MIN(High(Word),13 + ROUND((nLevel / 5 + 2) * 2.2 * nLevel));
      m_Abil.MaxWeight:=50 + ROUND((nLevel / 5) * nLevel);
      m_Abil.MaxWearWeight:= 15 + ROUND((nLevel / 100) * nLevel);
      m_Abil.MaxHandWeight:= 12 + ROUND((nLevel / 90) * nLevel);

      n:=nLevel div 7;
      m_Abil.DC:=MakeLong(_MAX(n-1, 0), _MAX(1, n));
      m_Abil.MC:=MakeLong(_MAX(n-1, 0), _MAX(1, n));
      m_Abil.SC:=0;
      m_Abil.AC:=0;
      m_Abil.MAC:=0;
    end;
    jWarr: begin
      //m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND((nLevel / 4.0 + 4.5 + nLevel / 20) * nLevel));
      m_Abil.MaxHP:=_MIN(High(Word),14 + ROUND(((nLevel / g_Config.nLevelValueOfWarrHP + g_Config.nLevelValueOfWarrHPRate + nLevel / 20) * nLevel)));

      m_Abil.MaxMP:=_MIN(High(Word),11 + ROUND(nLevel * 3.5));
      m_Abil.MaxWeight:= 50 + ROUND((nLevel / 3) * nLevel);
      m_Abil.MaxWearWeight:= 15 + ROUND((nLevel / 20) * nLevel);
      m_Abil.MaxHandWeight:= 12 + ROUND((nLevel / 13) * nLevel);

      m_Abil.DC:= MakeLong(_MAX((nLevel div 5) - 1, 1), _MAX(1, (nLevel div 5)));
      m_Abil.SC:= 0;
      m_Abil.MC:= 0;
      m_Abil.AC:= MakeLong(0, (nLevel div 7));
      m_Abil.MAC:= 0;
    end;
  end;
  if m_Abil.HP > m_Abil.MaxHP then m_Abil.HP:=m_Abil.MaxHP;
  if m_Abil.MP > m_Abil.MaxMP then m_Abil.MP:=m_Abil.MaxMP;
{$IFEND}
end;

procedure TBaseObject.HasLevelUp(nLevel:Integer);//004BED6C
begin
  m_Abil.MaxExp:=GetLevelExp(m_Abil.Level);
  RecalcLevelAbilitys();
  RecalcAbilitys();
  //Changed 'from' SendMsg so everyone can see effect
  SendRefMsg(RM_LEVELUP, 0, m_Abil.Exp, 0, 0, '');

{$IFDEF FOR_ABIL_POINT}

   if prevlevel + 1 = Abil.Level then begin
      BonusPoint := BonusPoint + GetBonusPoint (Job, Abil.Level);
      SendMsg (self, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
   end else begin
      if prevlevel <> Abil.Level then begin
         BonusPoint := GetLevelBonusSum (Job, Abil.Level);
         FillChar (BonusAbil, sizeof(TNakedAbility), #0);
         FillChar (CurBonusAbil, sizeof(TNakedAbility), #0);
         //if prevlevel <> 0 then begin
         RecalcLevelAbilitys;
         //end else begin
         //   RecalcLevelAbilitys_old;
         //   BonusPoint := 0;
         //end;
         SendMsg (self, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
      end;
   end;
{$ENDIF}

  if (g_FunctionNPC <> nil) then
    g_FunctionNPC.GotoLable(TPlayObject(Self),'@LevelUp',False);
end;
function TPlayObject.IncGold(tGold: Integer):Boolean;//004BF64C
begin
  Result:=False;
//  if m_nGold + tGold <= BAGGOLD then begin
  if m_nGold + tGold <= g_Config.nHumanMaxGold then begin
     Inc(m_nGold,tGold);
     Result:=True;
  end;
end;


procedure AddUserLog(sMsg: String);//004E42F8
begin
  MainOutMessage(sMsg);
end;

function TBaseObject.WalkTo(btDir:Byte;boFlag:boolean):Boolean;//004C3F64
var
  nOX,nOY,nNX,nNY,n20,n24:Integer;
  //Envir:TEnvirnoment;
  bo29:Boolean;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::WalkTo';
begin
  Result:=False;
  if m_boHolySeize then exit;
  try
    nOX:=m_nCurrX;
    nOY:=m_nCurrY;
//    Envir:=m_PEnvir;
    m_btDirection:=btDir;
    nNX:=0;
    nNY:=0;
   case btDir of
      DR_UP         :begin nNX:= m_nCurrX;   nNY:= m_nCurrY-1; end;
      DR_UPRIGHT    :begin nNX:= m_nCurrX+1; nNY:= m_nCurrY-1; end;
      DR_RIGHT      :begin nNX:= m_nCurrX+1; nNY:= m_nCurrY; end;
      DR_DOWNRIGHT  :begin nNX:= m_nCurrX+1; nNY:= m_nCurrY+1; end;
      DR_DOWN       :begin nNX:= m_nCurrX;   nNY:= m_nCurrY+1; end;
      DR_DOWNLEFT   :begin nNX:= m_nCurrX-1; nNY:= m_nCurrY+1; end;
      DR_LEFT       :begin nNX:= m_nCurrX-1; nNY:= m_nCurrY; end;
      DR_UPLEFT     :begin nNX:= m_nCurrX-1; nNY:= m_nCurrY-1; end;
   end;
   if (nNX >= 0) and ((m_PEnvir.Header.wWidth - 1 ) >= nNX) and
      (nNY >= 0) and ((m_PEnvir.Header.wHeight - 1) >= nNY) then begin
     bo29:=True;
     if bo2BA and not m_PEnvir.CanSafeWalk(nNX,nNY) then bo29:=False;
     if m_Master <> nil then begin
       m_Master.m_PEnvir.GetNextPosition(m_Master.m_nCurrX,m_Master.m_nCurrY,m_Master.m_btDirection,1,n20,n24);
       if (nNX = n20) and (nNY = n24) then bo29:=False;
     end;
     if bo29 then begin
       if m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,nNX,nNY,boFlag) > 0 then begin
         m_nCurrX:=nNX;
         m_nCurrY:=nNY;
       end;
     end;
   end;
   if (m_nCurrX <> nOX) or (m_nCurrY <> nOY) then begin
     if Walk(RM_WALK) then begin
       if m_boTransparent and m_boHideMode then m_wStatusTimeArr[STATE_TRANSPARENT{0x70}]:=1;
       Result:=True;
     end else begin
       m_PEnvir.DeleteFromMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
       m_nCurrX:=nOX;
       m_nCurrY:=nOY;
       m_PEnvir.AddToMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
     end;
   end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TPlayObject.IsEnoughBag: Boolean;//004C4990
begin
  Result:=False;
  if m_ItemList.Count < MAXBAGITEM then
    Result:=True;
end;

function TPlayObject.IsAddWeightAvailable(nWeight:Integer): Boolean; //004C4A78
begin
  Result:=False;
  if (m_WAbil.Weight + nWeight) <= m_WAbil.MaxWeight then
    Result:=True;
end;



procedure TPlayObject.SendAddItem(UserItem:pTUserItem); //004D0824
var
  Item:TItem;
  StdItem:TStdItem;
  ClientItem:TClientItem;
begin
  Item:=UserEngine.GetStdItem(UserItem.wIndex);
  if Item = nil then exit;
  Item.GetStandardItem(ClientItem.S);
  Item.GetItemAddValue(UserItem, ClientItem.S);
  ClientItem.S.Name := GetItemName(UserItem);

  ClientItem.MakeIndex:=UserItem.MakeIndex;
  ClientItem.Dura:=UserItem.Dura;
  ClientItem.DuraMax:=UserItem.DuraMax;
  ClientItem.Amount:=UserItem.Amount;
  if StdItem.StdMode = 50 then begin
    ClientItem.S.Name:=ClientItem.S.Name + ' #' + IntToStr(UserItem.Dura);
  end;
  if StdItem.StdMode in [15,19,20,21,22,23,24,26] then begin
    if UserItem.btValue[8] = 0 then ClientItem.S.Shape:=0
    else ClientItem.S.Shape:=130;
  end;
  m_DefMsg:=MakeDefaultMsg(SM_ADDITEM,Integer(Self),0,0,1);
  SendSocket(@m_DefMsg,EncodeBuffer(@ClientItem,SizeOf(TClientItem)));
end;

procedure TPlayObject.SendAddStorage(UserItem:pTUserItem); //004D0824
var
  Item:TItem;
  StdItem:TStdItem;
  ClientItem:TClientItem;
begin
  Item:=UserEngine.GetStdItem(UserItem.wIndex);
  if Item = nil then exit;
  Item.GetStandardItem(ClientItem.S);
  Item.GetItemAddValue(UserItem, ClientItem.S);
  ClientItem.S.Name := GetItemName(UserItem);

  ClientItem.MakeIndex:=UserItem.MakeIndex;
  ClientItem.Dura:=UserItem.Dura;
  ClientItem.DuraMax:=UserItem.DuraMax;
  ClientItem.Amount:=UserItem.Amount;
  if StdItem.StdMode = 50 then begin
    ClientItem.S.Name:=ClientItem.S.Name + ' #' + IntToStr(UserItem.Dura);
  end;
  if StdItem.StdMode in [15,19,20,21,22,23,24,26] then begin
    if UserItem.btValue[8] = 0 then ClientItem.S.Shape:=0
    else ClientItem.S.Shape:=130;
  end;
  m_DefMsg:=MakeDefaultMsg(SM_ADDSTORAGE,Integer(Self),0,0,1);
  SendSocket(@m_DefMsg,EncodeBuffer(@ClientItem,SizeOf(TClientItem)));
end;

function TBaseObject.IsGroupMember(target:TBaseObject):Boolean; //004C3908
var
  I: Integer;
begin
  Result:=False;
  if m_GroupOwner = nil then exit;
  for I := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do begin
    if m_GroupOwner.m_GroupMembers.Objects[i] = target then begin
      Result:=True;
      break;
    end;
  end;
end;

//004D1558
procedure TPlayObject.Whisper(whostr, saystr: string);
var
  PlayObject:TPlayObject;
  svidx:Integer;
begin
  PlayObject:=UserEngine.GeTPlayObject(whostr);
  if PlayObject <> nil then begin
    if not PlayObject.m_boReadyRun then begin
      SysMsg(whostr + g_sCanotSendmsg, c_Red,t_Hint);
      exit;
    end;
    if not PlayObject.m_boHearWhisper or PlayObject.IsBlockWhisper(m_sCharName) then begin
      SysMsg (whostr + g_sUserDenyWhisperMsg, c_Red,t_Hint);
      exit;
    end;
    if m_btPermission > 0 then begin
      PlayObject.SendMsg (PlayObject,RM_WHISPER,0,g_Config.btGMWhisperMsgFColor,g_Config.btGMWhisperMsgBColor,0,m_sCharName + '=> ' + saystr);
      if (m_GetWhisperHuman <> nil) and (not m_GetWhisperHuman.m_boGhost) then
        m_GetWhisperHuman.SendMsg (m_GetWhisperHuman,RM_WHISPER,0,g_Config.btGMWhisperMsgFColor,g_Config.btGMWhisperMsgBColor,0, m_sCharName + '=>' + PlayObject.m_sCharName + ' ' + saystr);

      if (PlayObject.m_GetWhisperHuman <> nil) and (not PlayObject.m_GetWhisperHuman.m_boGhost) then
        PlayObject.m_GetWhisperHuman.SendMsg (PlayObject.m_GetWhisperHuman,RM_WHISPER,0,g_Config.btGMWhisperMsgFColor,g_Config.btGMWhisperMsgBColor,0, m_sCharName + '=>' + PlayObject.m_sCharName + ' ' + saystr);
    end else begin
      PlayObject.SendMsg (PlayObject,RM_WHISPER,0,g_Config.btWhisperMsgFColor,g_Config.btWhisperMsgBColor,0,m_sCharName + '=> ' + saystr);
      if (m_GetWhisperHuman <> nil) and (not m_GetWhisperHuman.m_boGhost) then
        m_GetWhisperHuman.SendMsg (m_GetWhisperHuman,RM_WHISPER,0,g_Config.btWhisperMsgFColor,g_Config.btWhisperMsgBColor,0, m_sCharName + '=>' + PlayObject.m_sCharName + ' ' + saystr);

      if (PlayObject.m_GetWhisperHuman <> nil) and (not PlayObject.m_GetWhisperHuman.m_boGhost) then
        PlayObject.m_GetWhisperHuman.SendMsg (PlayObject.m_GetWhisperHuman,RM_WHISPER,0,g_Config.btWhisperMsgFColor,g_Config.btWhisperMsgBColor,0, m_sCharName + '=>' + PlayObject.m_sCharName + ' ' + saystr);
    end;



  end else begin
    if UserEngine.FindOtherServerUser (whostr, svidx) then begin
      UserEngine.SendServerGroupMsg (SS_WHISPER, svidx, whostr + '/' + m_sCharName + '=> ' + saystr);
    end else begin
      SysMsg (whostr + ' ' + g_sUserNotOnLine, c_Red,t_Hint);
    end;
  end;
end;
//004D199C
function TPlayObject.IsBlockWhisper(sName: String): Boolean;
var
  I: Integer;
begin
  Result:=False;
  for I := 0 to m_BlockWhisperList.Count - 1 do begin
    if CompareText(sName,m_BlockWhisperList.Strings[i]) = 0 then begin
      Result:=True;
      break;
    end;
  end;
end;

function TBaseObject.PKLevel(): Integer;//004BF0A0
begin
  Result:=m_nPkPoint div 100;
end;

procedure TBaseObject.HealthSpellChanged;//004C4A24
begin
  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendUpdateMsg(Self,RM_HEALTHSPELLCHANGED,0,0,0,0,'');
  end;
  if m_boShowHP then begin
    SendRefMsg(RM_HEALTHSPELLCHANGED,0,0,0,0,'');
  end;
  SendGroupRev();
end;

procedure TBaseObject.SendGroupRev();
var
  I: Integer;
  PlayObject:TPlayObject;
begin
  if m_GroupOwner <> nil then begin
    for I := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do  begin
      PlayObject:=TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
      PlayObject.SendRefMsg(RM_HEALTHSPELLCHANGED,0,0,0,0,'');
    end;
  end;
end;

function TBaseObject.CalcGetExp(nLevel:Integer;nExp:Integer):Integer;   //004BE59F
begin

  if g_Config.boHighLevelKillMonFixExp or (m_Abil.Level < (nLevel + 10)) then begin
    Result:=nExp;
  end else begin
    Result := nExp - ROUND((nExp / 15) * (m_Abil.Level - (nLevel + 10)));
  end;
  if Result <= 0 then Result:=1;
end;

procedure TBaseObject.RefNameColor();//004BF124
begin
  SendRefMsg(RM_CHANGENAMECOLOR,0,0,0,0,'');
end;

procedure TBaseObject.GainSlaveExp(nLevel:Integer); //004BE8BC
  function GetUpKillCount ():Integer;  //004BE864
  var
    tCount:Integer;
  begin
    if m_btSlaveExpLevel < SLAVEMAXLEVEL -2 then begin
      tCount:=g_Config.MonUpLvNeedKillCount[m_btSlaveExpLevel];
    end else begin
      tCount:=0;
    end;
//    Result:= ((m_Abil.Level shl 4) - m_Abil.Level) + 100 + tCount
    Result:=((m_Abil.Level * g_Config.nMonUpLvRate{16}) - m_Abil.Level) + g_Config.nMonUpLvNeedKillBase{100} + tCount
  end;
{
var
  nNeedCount:Integer;
}
begin
  Inc(n294,nLevel);
  if GetUpKillCount() < n294 then begin
    Dec(n294,GetUpKillCount);
    if m_btSlaveExpLevel < (m_btSlaveMakeLevel * 2 + 1) then begin
      Inc(m_btSlaveExpLevel);
      RecalcAbilitys();
      RefNameColor();
    end;
  end;//004BE92F
end;

function TBaseObject.DropGoldDown(nGold:Integer;boFalg:Boolean;GoldOfCreat,DropGoldCreat:TBaseObject): Boolean; //004C5794
var
  MapItem,MapItemA:PTMapItem;
  nX,nY:Integer;
  s20:String;
begin
  Result:=False;
  New(MapItem);
  FillChar(MapItem^,SizeOf(TMapItem),#0);
  MapItem.Name:=sSTRING_GOLDNAME;
  MapItem.Count:=nGold;
  MapItem.Looks:=GetGoldShape(nGold);
  MapItem.OfBaseObject:=GoldOfCreat;
  MapItem.dwCanPickUpTick:=GetTickCount();
  MapItem.DropBaseObject:=DropGoldCreat;
  GetDropPosition (m_nCurrX, m_nCurrY, 3, nX,nY);
  MapItemA:=m_PEnvir.AddToMap (nX, nY, OS_ITEMOBJECT, TObject (MapItem));
  if MapItemA <> nil then begin
    if MapItemA <> MapItem then begin
      Dispose(MapItem);
      MapItem:=MapItemA;
    end;
    SendRefMsg (RM_ITEMSHOW, MapItem.Looks, integer(MapItem), nX, nY, MapItem.Name);
    if m_btRaceServer = RC_PLAYOBJECT then begin
      if boFalg then s20:='15'
      else s20:='7';
           //004C5995
          if g_boGameLogGold then
            AddGameDataLog (s20 + #9 +
                        m_sMapName + #9 +
                        IntToStr(m_nCurrX) + #9 +
                        IntToStr(m_nCurrY) + #9 +
                        m_sCharName + #9 +
                        sSTRING_GOLDNAME + #9 +
                        IntToStr(nGold) + #9 +
                        BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
                        '0');
    end; //004C599A
    Result:=True;
  end else Dispose(MapItem);    
end;

function TBaseObject.GetGuildRelation(cert1, cert2: TBaseObject): Integer; //004BF380
begin
  Result:=0;
  m_boGuildWarArea:=False;
  if (cert1.m_MyGuild= nil) or (cert2.m_MyGuild = nil) then exit;
  if cert1.InSafeArea or (cert2.InSafeArea) then exit;
  if TGuild(cert1.m_MyGuild).GuildWarList.Count <= 0 then exit;
  m_boGuildWarArea:=True;
  if TGuild(cert1.m_MyGuild).IsWarGuild(TGuild(cert2.m_MyGuild)) and
     TGuild(cert2.m_MyGuild).IsWarGuild(TGuild(cert1.m_MyGuild)) then Result:=2;

  if cert1.m_MyGuild = cert2.m_MyGuild then Result:=1;
  if TGuild(cert1.m_MyGuild).IsAllyGuild(TGuild(cert2.m_MyGuild)) and
     TGuild(cert2.m_MyGuild).IsAllyGuild(TGuild(cert1.m_MyGuild)) then Result:=3;
end;

procedure TBaseObject.IncPkPoint(nPoint: Integer); //004BF4D4
var
  nOldPKLevel:Integer;
begin
  nOldPKLevel:=PKLevel;
  Inc(m_nPkPoint,nPoint);
  if PKLevel <> nOldPKLevel then begin
    if PKLevel <= 2 then RefNameColor;
  end;    
end;

procedure TBaseObject.AddBodyLuck(dLuck:Double); //004BF580
var
  n:Integer;
begin
  if (dLuck > 0) and (m_dBodyLuck < 5 * BODYLUCKUNIT) then begin
    m_dBodyLuck := m_dBodyLuck + dLuck;
  end;
  if (dLuck < 0) and (m_dBodyLuck > -(5 * BODYLUCKUNIT)) then begin
    m_dBodyLuck := m_dBodyLuck + dLuck;
  end;

  n := Trunc (m_dBodyLuck / BODYLUCKUNIT);
  if n > 5 then n := 5;
  if n < -10 then n := -10;
  m_nBodyLuckLevel := n;
end;

procedure TBaseObject.MakeWeaponUnlock; //004C1198
begin
  if m_UseItems[U_WEAPON].wIndex <= 0 then exit;
  if m_UseItems[U_WEAPON].btValue[3] > 0 then begin
    Dec(m_UseItems[U_WEAPON].btValue[3]);
    SysMsg(g_sTheWeaponIsCursed,c_Red,t_Hint);
  end else begin
    if m_UseItems[U_WEAPON].btValue[4] < 10 then begin
      Inc(m_UseItems[U_WEAPON].btValue[4]);
      SysMsg(g_sTheWeaponIsCursed,c_Red,t_Hint);
    end;
  end;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    RecalcAbilitys();
    SendMsg(Self,RM_ABILITY,0,0,0,0,'');
    SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
  end;
end;

function TBaseObject.GetAttackPower(nBasePower,nPower:Integer):Integer;
var
  PlayObject:TPlayObject;
begin
  if nPower < 0 then nPower := 0;
  if m_nLuck > 0 then begin
    if Random(10 - _MIN(9,m_nLuck)) = 0 then Result := nBasePower + nPower
    else Result := nBasePower + Random(nPower + 1);
  end else begin
    Result := nBasePower + Random(nPower + 1);
    if m_nLuck < 0 then begin
      if Random(10 - _MAX(0,-m_nLuck)) = 0 then Result := nBasePower;
    end;
  end;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    PlayObject:=TPlayObject(Self);
    //Result:=Result * PlayObject.m_nPowerMult + ROUND(Result * (PlayObject.m_nPowerMultPoint / 100));
    Result:=ROUND(Result * (PlayObject.m_nPowerRate / 100));
    if PlayObject.m_boPowerItem then
      Result:=ROUND(m_rPowerItem * Result);
  end;
  if m_boAutoChangeColor then begin
    Result:=Result * m_nAutoChangeIdx + 1;
  end;
  if m_boFixColor then begin
    Result:=Result * m_nFixColorIdx + 1;
  end;

end;
procedure TBaseObject.DamageHealth(nDamage: Integer); //004BE3FC
var
  nSpdam:Integer;
begin
  if ((m_LastHiter = nil) or not m_LastHiter.m_boUnMagicShield) and m_boMagicShield and (nDamage > 0) and (m_WAbil.MP > 0) then begin
    nSpdam := Round (nDamage * 1.5);
    if integer(m_WAbil.MP) >= nSpdam then begin
      m_WAbil.MP := m_WAbil.MP - nSpdam;
      nSpdam := 0;
    end else begin
      nSpdam := nSpdam - m_WAbil.MP;
      m_WAbil.MP := 0;
    end;
    nDamage := Round (nSpdam / 1.5);
    HealthSpellChanged();
  end;
  if nDamage > 0 then begin
    if (m_WAbil.HP - nDamage) > 0 then begin
      m_WAbil.HP:=m_WAbil.HP - nDamage;
    end else begin
      m_WAbil.HP:=0;
    end;
    if m_boAbilCelestialDefence=True then begin
     if Random(6) < 3 then
      m_nIncHealth:=nDamage + 15;
      SysMsg('阴阳法环抵御攻击.',c_Green,t_Hint);
     end;
  end else begin
    if (m_WAbil.HP - nDamage) < m_WAbil.MaxHP then begin
      m_WAbil.HP:=m_WAbil.HP - nDamage;
    end else begin
      m_WAbil.HP:= m_WAbil.MaxHP;
    end;
  end;
end;
function  TBaseObject.GetBackDir(nDir:integer):Integer;//004B2708
begin
  Result:=0;
  case nDir of
    DR_UP:Result:= DR_DOWN;
    DR_DOWN:Result:= DR_UP;
    DR_LEFT:Result:= DR_RIGHT;
    DR_RIGHT:Result:= DR_LEFT;
    DR_UPLEFT:Result:= DR_DOWNRIGHT;
    DR_UPRIGHT:Result:= DR_DOWNLEFT;
    DR_DOWNLEFT:Result:= DR_UPRIGHT;
    DR_DOWNRIGHT:Result:= DR_UPLEFT;
  end;
end;
function  TBaseObject.CharPushed (nDir,nPushCount:Integer): integer; //004C2F90
var
   i, nx, ny, olddir, oldx, oldy, nBackDir: integer;
begin
   Result := 0;
   olddir := m_btDirection;
   oldx := m_nCurrX;
   oldy := m_nCurrY;
   m_btDirection := ndir;
   nBackDir:=GetBackDir(ndir);
   for i:=0 to nPushCount - 1 do begin
     GetFrontPosition(nx, ny);
     if m_PEnvir.CanWalk (nX,nY,False) then begin
       if m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,nX,nY,False) > 0 then begin
         m_nCurrX := nX;
         m_nCurrY := nY;
            //SendRefMsg(RM_PUSH, GetBackDir(ndir), m_nCurrX, m_nCurrY, 0, '');
         SendRefMsg(RM_PUSH, nBackDir, m_nCurrX, m_nCurrY, 0, '');
         Inc(Result);
         if m_btRaceServer >= RC_ANIMAL then
            m_dwWalkTick := m_dwWalkTick + 800;
       end else break;
     end else break;
   end;

   m_btDirection:=nBackDir;
   if Result = 0 then m_btDirection:=olddir;
end;

function  TBaseObject.MagPassThroughMagic (sx, sy, tx, ty, ndir, magpwr: integer; undeadattack: Boolean): integer; //004C69F4
var
   i, tcount: integer;
   BaseObject:TBaseObject;
begin
   tcount := 0;
   for i:=0 to 12 do begin
     BaseObject:=TBaseObject(m_PEnvir.GetMovingObject(sx,sy,True));
     if BaseObject <> nil then begin
       if IsProperTarget (BaseObject) then begin
         if Random(50) >= BaseObject.m_nAntiMagic then begin
           if undeadattack then
             magpwr := Round (magpwr * 1.5);

           BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
           Inc (tcount);
         end;
       end;
     end;
     if not ((abs(sx-tx) <= 0) and (abs(sy-ty) <= 0)) then begin
       ndir := GetNextDirection (sx, sy, tx, ty);
       if not m_PEnvir.GetNextPosition (sx, sy, ndir, 1, sx, sy) then
         break;
     end else
       break;
   end;
   Result := tcount;
end;


procedure TPlayObject.SendSocket(DefMsg:pTDefaultMessage;sMsg:String);//004CAB38
var
  MsgHdr:TMsgHeader;
  nSendBytes:Integer;
  tBuff:PChar;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::SendSocket..';
begin
  tBuff:=nil;
  try
    MsgHdr.dwCode         := RUNGATECODE;
    MsgHdr.nSocket        := m_nSocket;
    MsgHdr.wGSocketIdx    := m_nGSocketIdx;
    MsgHdr.wIdent         := GM_DATA;

//    MsgHdr.nUserListIndex := 0;
    //004CAB9A
    if DefMsg <> nil then begin
      if sMsg <> '' then begin
        MsgHdr.nLength:=Length(sMsg) + SizeOf(TDefaultMessage) + 1;
        nSendBytes:=MsgHdr.nLength + SizeOf(TMsgHeader);
        GetMem(tBuff,nSendBytes + SizeOf(Integer));
        Move(nSendBytes,tBuff^,SizeOf(Integer));
        Move(MsgHdr,tBuff[SizeOf(Integer)],SizeOf(TMsgHeader));
        Move(DefMsg^,tBuff[SizeOf(TMsgHeader) + SizeOf(Integer)],SizeOf(TDefaultMessage));
        Move(sMsg[1],tBuff[SizeOf(TDefaultMessage) + SizeOf(TMsgHeader) + SizeOf(Integer)],Length(sMsg) + 1);
      end else begin//004CAC29
        MsgHdr.nLength:=SizeOf(TDefaultMessage);
        nSendBytes:=MsgHdr.nLength + SizeOf(TMsgHeader);
        GetMem(tBuff,nSendBytes + SizeOf(Integer));
        Move(nSendBytes,tBuff^,SizeOf(Integer));
        Move(MsgHdr,tBuff[SizeOf(Integer)],SizeOf(TMsgHeader));
        Move(DefMsg^,tBuff[SizeOf(TMsgHeader) + SizeOf(Integer)],SizeOf(TDefaultMessage));
      end;
    end else begin//004CAC7F
      if sMsg <> '' then begin
        MsgHdr.nLength:= - (Length(sMsg) + 1);
        nSendBytes:=abs(MsgHdr.nLength) + SizeOf(TMsgHeader);
        GetMem(tBuff,nSendBytes + SizeOf(Integer));
        Move(nSendBytes,tBuff^,SizeOf(Integer));
        Move(MsgHdr,tBuff[SizeOf(Integer)],SizeOf(TMsgHeader));
        Move(sMsg[1],tBuff[SizeOf(TMsgHeader) + SizeOf(Integer)],Length(sMsg) + 1);
      end;//004CACF0
    end;//004CACF0
    if not RunSocket.AddGateBuffer(m_nGateIdx,tBuff) then begin
      FreeMem(tBuff);
      //MainOutMessage('SendSocket Buffer Fail ' + IntToStr(m_nGateIdx));
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TPlayObject.SendDefMessage(wIdent:Word;nRecog:Integer;nParam,nTag,nSeries:Word;sMsg:String); //004CAD6C
begin
  m_DefMsg:=MakeDefaultMsg(wIdent,nRecog,nParam,nTag,nSeries);
  if sMsg <> '' then SendSocket(@m_DefMsg,EncodeString(sMsg))
  else SendSocket(@m_DefMsg,'');
end;

procedure TPlayObject.ClientQueryUserName (target: TBaseObject; x, y: integer); //004DA8E8
var
  uname: string;
  TagColor:Integer;
  Def:TDefaultMessage;
begin
   if CretInNearXY (target, x, y) then begin
      tagcolor := GetCharColor (target);
      Def := MakeDefaultMsg (SM_USERNAME, Integer(target), tagcolor, 0, 0);
      uname := target.GetShowName;
      SendSocket (@Def, EncodeString (uname));
   end else
      SendDefMessage (SM_GHOST, integer(target), x, y, 0, '');
end;

function TBaseObject.GetShowName: String; //004C129C
var
  sShowName:String;
begin
  sShowName:=m_sCharName;
  Result:=FilterShowName(sShowName);
  if (m_Master <> nil) and not m_Master.m_boObMode and (m_btRaceServer <> MONSTER_CLONE) then begin
    Result:=Result + '(' + m_Master.m_sCharName + ')';
  end;

  {
  if m_btRaceServer <> RC_PLAYOBJECT then begin
    sShowName:=m_sCharName;
    Result:=FilterShowName(sShowName);
    if (m_Master <> nil) and not m_Master.m_boObMode then begin
      Result:=Result + '(' + m_Master.m_sCharName + ')';
    end;
  end else begin//004C1340
    Result:=m_sCharName;
    if m_MyGuild <> nil then begin
      if UserCastle.IsMasterGuild(TGuild(m_MyGuild)) then begin
        Result:=Result + '\' + TGuild(m_MyGuild).sGuildName + '(' + UserCastle.sName + ')';
      end else begin
        if g_boShowGuildName or (UserCastle.boUnderWar and (m_boInFreePKArea or UserCastle.IsCastleWarArea(m_PEnvir,m_nCurrX,m_nCurrY))) then begin
          Result:=Result + '\' + TGuild(m_MyGuild).sGuildName + '[' + m_sGuildRankName + ']';
        end;
      end;
    end;
  end;
  }
end;





procedure TAnimalObject.Attack(TargeTBaseObject: TBaseObject; nDir: Integer); //004C9380
begin
  inherited AttackDir(TargeTBaseObject,0,nDir);
end;

constructor TAnimalObject.Create;//004C9190
begin
  inherited;
  m_nNotProcessCount:=0;
  m_nTargetX:= -1;
  dwTick3F0:=Random(4) * 500 + 1000;
  dwTick3F4:=GetTickCount();
  m_btRaceServer:=RC_ANIMAL;
  m_dwHitTick:=GetCurrentTime - LongWord(Random(3000));
  m_dwWalkTick:=GetCurrentTime - LongWord(Random(3000));
  m_dwSearchEnemyTick:=GetTickCount();
  m_boRunAwayMode:=False;
  m_dwRunAwayStart:=GetTickCount();
  m_dwRunAwayTime:=0;
end;
procedure TAnimalObject.GotoTargetXY; //004C9694
var
  I     :Integer;
  nDir  :Integer;
  n10   :Integer;
  n14   :Integer;
  n20   :Integer;
  nOldX :Integer;
  nOldY :Integer;
begin
  if ((m_nCurrX <> m_nTargetX) or (m_nCurrY <> m_nTargetY)) then begin
    n10:=m_nTargetX;
    n14:=m_nTargetY;
    dwTick3F4:=GetTickCount();
    nDir:=DR_DOWN;
    if n10 > m_nCurrX then begin
      nDir:=DR_RIGHT;
      if n14 > m_nCurrY then nDir:=DR_DOWNRIGHT;
      if n14 < m_nCurrY then nDir:=DR_UPRIGHT;
    end else begin //004C9728
      if n10 < m_nCurrX then begin
        nDir:=DR_LEFT;
        if n14 > m_nCurrY then nDir:=DR_DOWNLEFT;
        if n14 < m_nCurrY then nDir:=DR_UPLEFT;
      end else begin //004C9760
        if n14 > m_nCurrY then nDir:=DR_DOWN
        else if n14 < m_nCurrY then nDir:=DR_UP;
      end;
   end;
    nOldX:=m_nCurrX;
    nOldY:=m_nCurrY;
    WalkTo(nDir,False);
    n20:=Random(3);
    for I := DR_UP to DR_UPLEFT do begin
      if (nOldX = m_nCurrX) and (nOldY = m_nCurrY) then begin
        if n20 <> 0 then Inc(nDir)
        else if nDir > 0 then Dec(nDir)
        else nDir:=DR_UPLEFT;
        if (nDir > DR_UPLEFT) then nDir:=DR_UP;
        WalkTo(nDir,False);
      end;
    end;
  end; //004C980B
end;

function TAnimalObject.Operate(ProcessMsg:pTProcessMessage):Boolean; //004C9280
begin
//  Result:=False;
  if ProcessMsg.wIdent = RM_STRUCK then begin
    if (ProcessMsg.BaseObject = Self) and (TBaseObject(ProcessMsg.nParam3{AttackBaseObject}) <> nil) then begin
      SetLastHiter(TBaseObject(ProcessMsg.nParam3{AttackBaseObject}));
      Struck(TBaseObject(ProcessMsg.nParam3{AttackBaseObject}));{0FFEC}
      BreakHolySeizeMode();
      if (m_Master <> nil) and
         (TBaseObject(ProcessMsg.nParam3) <> m_Master) and
         (TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT) then begin

        m_Master.SetPKFlag(TBaseObject(ProcessMsg.nParam3));
      end;
      if g_Config.boMonSayMsg then MonsterSayMsg(TBaseObject(ProcessMsg.nParam3),s_UnderFire);
    end;
    Result:=True;
  end else begin //004C932C
    Result:=inherited Operate(ProcessMsg);
  end;
end;


procedure TAnimalObject.Run;//004C936C
begin
  inherited;

end;

procedure TAnimalObject.Struck (Hiter: TBaseObject);//004C93A8
var
  btDir:Byte;
begin
  m_dwStruckTick := GetTickCount;
  if Hiter <> nil then begin
    if (m_TargetCret = nil) or GetAttackDir(m_TargetCret,btDir) or (Random(6) = 0) then begin
      if IsProperTarget (Hiter) then
        SetTargetCreat (Hiter);
    end;
  end; //004C941D
  if m_boAnimal then begin
     m_nMeatQuality := m_nMeatQuality - Random (300);
     if m_nMeatQuality < 0 then m_nMeatQuality := 0;
  end;
  //if m_Abil.Level < 50 then
     m_dwHitTick  := m_dwHitTick + LongWord(150 - _MIN(130, m_Abil.Level * 4));
  //WalkTime := WalkTime + (300 - _MIN(200, (Abil.Level div 5) * 20));
end;

procedure TBaseObject.RecalcAbilitys;//004C03B0
var
  wOldHP,wOldMP  :Word;
  boOldHideMode  :Boolean;
  nOldLight      :Integer;
  nItemLight     :Integer;
  I              :Integer;
  StdItem        :TItem;

  boRecallSuite  :Array[0..3] of Boolean;
  boMoXieSuite   :Array[0..2] of Boolean;

  boHongMoSuite1 :Boolean;
  boHongMoSuite2 :Boolean;
  boHongMoSuite3 :Boolean;
  boSpirit       :Array[0..3] of Boolean;

  boSmash1,boSmash2,boSmash3:Boolean;
  boHwanDevil1,boHwanDevil2,boHwanDevil3:Boolean;
  boPurity1,boPurity2,boPurity3:Boolean;
  boMundane1,boMundane2:Boolean;
  boNokChi1,boNokChi2:Boolean;
  boTaoBu1,boTaoBu2:Boolean;
  boFiveString1,boFiveString2,boFiveString3:Boolean;
  boBone1,boBone2,boBone3: Boolean; //bone set(wpn,helm,robe)
  boBug1,boBug2,boBug3: Boolean; //bug set (neck, ring, brace
  boWhiteGold1,boWhiteGold2,boWhiteGold3,boWhiteGold4,boWhiteGold5: Boolean; // white gold set (belt, shoes, neck, brace, ring)
  boRedJade1,boRedJade2,boRedJade3,boRedJade4,boRedJade5: Boolean; // red jade set (belt, shoes, neck, brace, ring)
  boNephrite1,boNephrite2,boNephrite3,boNephrite4,boNephrite5: Boolean; // nephrite set (belt, shoes, neck, brace, ring)
  boWhiteGoldH1,boWhiteGoldH2,boWhiteGoldH3,boWhiteGoldH4,boWhiteGoldH5: Boolean;// white gold H set (belt, soes, neck, brace ring)
  boRedJadeH1,boRedJadeH2,boRedJadeH3,boRedJadeH4,boRedJadeH5: Boolean; // red jade H set (belt, shoes, neck, brace, ring)
  boNephriteH1,boNephriteH2,boNephriteH3,boNephriteH4,boNephriteH5: Boolean; // nephrite H set (belt, shoes, neck, brace, ring)
begin
  FillChar(m_AddAbil,SizeOf(TAddAbility),#0);
  wOldHP             := m_WAbil.HP;
  wOldMP             := m_WAbil.MP;
  m_WAbil            := m_Abil;
  m_WAbil.HP         := wOldHP;
  m_WAbil.MP         := wOldMP;
  m_WAbil.Weight     := 0;
  m_WAbil.WearWeight := 0;
  m_WAbil.HandWeight := 0;
  m_btAntiPoison     := 0;
  m_nPoisonRecover   := 0;
  m_nHealthRecover   := 0;
  m_nSpellRecover    := 0;
  m_nAntiMagic       := 1;
  m_nLuck            := 0;
  m_nHitSpeed        := 0;
  m_boExpItem        := False;
  m_rExpItem         := 0;
  m_boPowerItem      := False;
  m_rPowerItem       := 0;
  boOldHideMode      := m_boHideMode;
  m_boHideMode       := False;
  m_boTeleport       := False;
  m_boParalysis      := False;
  m_boRevival        := False;
  m_boUnRevival      := False;
  m_boFlameRing      := False;
  m_boRecoveryRing   := False;
  m_boAngryRing      := False;
  m_boMagicShield    := False;
  m_boUnMagicShield  := False;
  m_boMuscleRing     := False;
  m_boFastTrain      := False;
  m_boProbeNecklace  := False;
  m_boSupermanItem   := False;
  m_boGuildMove      := False;
  m_boUnParalysis    := False;
  m_boExpItem        := False;
  m_boPowerItem      := False;
  m_boNoDropItem     := False;
  m_boNoDropUseItem  := False;
  m_bopirit          := False;
  m_btHorseType      := 0;
  m_btDressEffType   := 0;
  m_btHelmetEffType  := 0;
{sets}
  m_nMoXieSuite      := 0;
  boMoXieSuite[0]    := False;
  boMoXieSuite[1]    := False;
  boMoXieSuite[2]    := False;
  m_db3B0            := 0;
  m_nHongMoSuite     := 0;
  boHongMoSuite1     := False;
  boHongMoSuite2     := False;
  boHongMoSuite3     := False;
  boSpirit[0]        := False;
  boSpirit[1]        := False;
  boSpirit[2]        := False;
  boSpirit[3]        := False;
  m_boRecallSuite    := False;
  boRecallSuite[0]   := False;
  boRecallSuite[1]   := False;
  boRecallSuite[2]   := False;
  boRecallSuite[3]   := False;
  boSmash1            := False;
  boSmash2            := False;
  boSmash3            := False;
  boHwanDevil1        := False;
  boHwanDevil2        := False;
  boHwanDevil3        := False;
  boPurity1           := False;
  boPurity2           := False;
  boPurity3           := False;
  boMundane1          := False;
  boMundane2          := False;
  boNokChi1           := False;
  boNokChi2           := False;
  boTaoBu1            := False;
  boTaoBu2            := False;
  boFiveString1       := False;
  boFiveString2       := False;
  boFiveString3       := False;
  boBone1             := False;
  boBone2             := False;
  boBone3             := False;
  boBug1              := False;
  boBug2              := False;
  boBug3              := False;
  boWhiteGold1        := False;
  boWhiteGold2        := False;
  boWhiteGold3        := False;
  boWhiteGold4        := False;
  boWhiteGold5        := False;
  boWhiteGoldH1       := False;
  boWhiteGoldH2       := False;
  boWhiteGoldH3       := False;
  boWhiteGoldH4       := False;
  boWhiteGoldH5       := False;
  boRedJade1          := False;
  boRedJade2          := False;
  boRedJade3          := False;
  boRedJade4          := False;
  boRedJade5          := False;
  boRedJadeH1         := False;
  boRedJadeH2         := False;
  boRedJadeH3         := False;
  boRedJadeH4         := False;
  boRedJadeH5         := False;
  boNephrite1         := False;
  boNephrite2         := False;
  boNephrite3         := False;
  boNephrite4         := False;
  boNephrite5         := False;
  boNephriteH1        := False;
  boNephriteH2        := False;
  boNephriteH3        := False;
  boNephriteH4        := False;
  boNephriteH5        := False;
{end of sets}
  m_dwPKDieLostExp   := 0;
  m_nPKDieLostLevel  := 0;
  nItemLight         := 0;
  m_boCanLooseDura    := True;

  for I:=Low(THumanUseItems) to High(THumanUseItems) do begin
    if (m_UseItems[I].wIndex <= 0) or (m_UseItems[I].Dura <= 0) then Continue;
    GetAccessory(m_UseItems[I],m_AddAbil);
    StdItem:=UserEngine.GetStdItem(m_UseItems[I].wIndex);
    if StdItem = nil then Continue;

    if nItemLight < StdItem.Light then nItemLight := StdItem.Light;

    if (I = U_WEAPON) or (I = U_RIGHTHAND) or (I = U_DRESS) then begin
      if I = U_DRESS then begin
        Inc(m_WAbil.WearWeight,StdItem.Weight);
      end else begin
        Inc(m_WAbil.HandWeight,StdItem.Weight);
      end;

      if StdItem.AniCount = 120 then m_boFastTrain     := True;
      if StdItem.AniCount = 121 then m_boProbeNecklace := True;
      if StdItem.AniCount = 145 then m_boGuildMove     := True;
      if StdItem.AniCount = 111 then begin
        m_wStatusTimeArr[STATE_TRANSPARENT{8 0x70}]:=6 * 10 * 1000;
        m_boHideMode:=True;
      end;
      if StdItem.AniCount = 112 then m_boTeleport     := True;
      if StdItem.AniCount = 113 then m_boParalysis    := True;
      if StdItem.AniCount = 114 then m_boRevival      := True;
      if StdItem.AniCount = 115 then m_boFlameRing    := True;
      if StdItem.AniCount = 116 then m_boRecoveryRing := True;
      if StdItem.AniCount = 117 then m_boAngryRing    := True;
      if StdItem.AniCount = 118 then m_boMagicShield  := True;
      if StdItem.AniCount = 119 then m_boMuscleRing   := True;
      if StdItem.AniCount = 135 then begin
        boMoXieSuite[0]:=True;
        Inc(m_nMoXieSuite,StdItem.Weight div 10);
      end;
      if StdItem.AniCount = 138 then begin
        Inc(m_nHongMoSuite,StdItem.Weight);
      end;
      if StdItem.AniCount = 139 then m_boUnParalysis:=True;
      if StdItem.AniCount = 140 then m_boSupermanItem:=True;
      if StdItem.AniCount = 141 then begin
        m_boExpItem:=True;
        m_rExpItem:=m_rExpItem + (m_UseItems[i].Dura / g_Config.nItemExpRate);
      end;
      if StdItem.AniCount = 142 then begin
        m_boPowerItem:=True;
        m_rPowerItem:=m_rPowerItem + (m_UseItems[i].Dura / g_Config.nItemPowerRate);
      end;
      if StdItem.AniCount = 182 then begin
        m_boExpItem:=True;
        m_rExpItem:=m_rExpItem + (m_UseItems[i].DuraMax / g_Config.nItemExpRate);
      end;
      if StdItem.AniCount = 183 then begin
        m_boPowerItem:=True;
        m_rPowerItem:=m_rPowerItem + (m_UseItems[i].DuraMax / g_Config.nItemPowerRate);
      end;

      if StdItem.AniCount = 143 then m_boUnMagicShield:=True;
      if StdItem.AniCount = 144 then m_boUnRevival:=True;
      if StdItem.AniCount = 170 then m_boAngryRing:=True;
      if StdItem.AniCount = 171 then m_boNoDropItem:=True;
      if StdItem.AniCount = 172 then m_boNoDropUseItem:=True;
      if StdItem.AniCount = 150 then begin
        m_boParalysis:=True;
        m_boMagicShield:=True;
      end;
      if StdItem.AniCount = 151 then begin
        m_boParalysis:=True;
        m_boFlameRing:=True;
      end;
      if StdItem.AniCount = 152 then begin
        m_boParalysis:=True;
        m_boRecoveryRing:=True;
      end;
      if StdItem.AniCount = 153 then begin
        m_boParalysis:=True;
        m_boMuscleRing:=True;
      end;
      if StdItem.Shape = 154 then begin
        m_boMagicShield:=True;
        m_boFlameRing:=True;
      end;
      if StdItem.AniCount = 155 then begin
        m_boMagicShield:=True;
        m_boRecoveryRing:=True;
      end;
      if StdItem.AniCount = 156 then begin
        m_boMagicShield:=True;
        m_boMuscleRing:=True;
      end;

      if StdItem.AniCount = 157 then begin
        m_boTeleport:=True;
        m_boParalysis:=True;
      end;

      if StdItem.AniCount = 158 then begin
        m_boTeleport:=True;
        m_boMagicShield:=True;
      end;

      if StdItem.AniCount = 159 then begin
        m_boTeleport:=True;
        m_boProbeNecklace:=True;
      end;
      if StdItem.AniCount = 160 then begin
        m_boTeleport:=True;
        m_boRevival:=True;
      end;
      if StdItem.AniCount = 161 then begin
        m_boParalysis:=True;
        m_boRevival:=True;
      end;
      if StdItem.AniCount = 162 then begin
        m_boMagicShield:=True;
        m_boRevival:=True;
      end;
      if StdItem.AniCount = 180 then begin //PK
        m_dwPKDieLostExp:=StdItem.DuraMax * g_Config.dwPKDieLostExpRate;
//        m_nPKDieLostLevel:=1;
      end;
      if StdItem.AniCount = 181 then begin //PK
        m_nPKDieLostLevel:=StdItem.DuraMax div g_Config.nPKDieLostLevelRate;
      end;
    end else begin
      Inc(m_WAbil.WearWeight,StdItem.Weight);
    end;
    Inc(m_WAbil.Weight,StdItem.Weight);
    if (i = U_WEAPON) then begin
      if (StdItem.Source - 1 - 10) < 0 then begin
        m_AddAbil.btWeaponStrong:=StdItem.Source
      end;
      if (StdItem.Source <= -1) and (StdItem.Source >= -50) then begin // -1 to -50
        m_AddAbil.btUndead:=m_AddAbil.btUndead + -StdItem.Source;//Holy+
      end;
      if (StdItem.Source <= -51) and (StdItem.Source >= -100) then begin // -51 to -100
        m_AddAbil.btUndead:=m_AddAbil.btUndead + (StdItem.Source + 50);//Holy-
      end;
      if StdItem.Anicount = 220 then boBone1 := True;
      Continue;
    end;
    if (i = U_RIGHTHAND) then begin
      if StdItem.Shape in [1..50] then
        m_btDressEffType:=StdItem.Shape;
      if StdItem.Shape in [51..100] then
        m_btHorseType:=StdItem.Shape - 50;

      if (StdItem.Source = 0){is candle?} and (StdItem.Reserved = 1){is special candle?} then
        m_boCanLooseDura := False;

      Continue;
    end;

    if (I = U_DRESS) then begin
      if m_UseItems[I].btValue[5] > 0 then
        m_btDressEffType:=m_UseItems[I].btValue[5];
      if (StdItem.AniCount > 0) and (StdItem.AniCount <> 220) then
        m_btDressEffType:=StdItem.AniCount;
      if StdItem.AniCount = 220 then boBone3 := True;
      Continue;
    end;
      if StdItem.Shape = 139 then m_boUnParalysis  := True;
      if StdItem.Shape = 140 then m_boSupermanItem := True;
      if StdItem.Shape = 141 then begin
        m_boExpItem:=True;
        m_rExpItem:=m_rExpItem + (m_UseItems[i].Dura / g_Config.nItemExpRate);
      end;
      if StdItem.Shape = 142 then begin
        m_boPowerItem:=True;
        m_rPowerItem:=m_rPowerItem + (m_UseItems[i].Dura / g_Config.nItemPowerRate);
      end;
      if StdItem.Shape = 182 then begin
        m_boExpItem:=True;
        m_rExpItem:=m_rExpItem + (m_UseItems[i].DuraMax / g_Config.nItemExpRate);
      end;
      if StdItem.Shape = 183 then begin
        m_boPowerItem:=True;
        m_rPowerItem:=m_rPowerItem + (m_UseItems[i].DuraMax / g_Config.nItemPowerRate);
      end;
      if StdItem.Shape = 143 then m_boUnMagicShield := True;
      if StdItem.Shape = 144 then m_boUnRevival     := True;
      if StdItem.Shape = 170 then m_boAngryRing     := True;
      if StdItem.Shape = 171 then m_boNoDropItem    := True;
      if StdItem.Shape = 172 then m_boNoDropUseItem := True;

      if StdItem.Shape = 150 then begin
        m_boParalysis:=True;
        m_boMagicShield:=True;
      end;
      if StdItem.Shape = 151 then begin
        m_boParalysis:=True;
        m_boFlameRing:=True;
      end;
      if StdItem.Shape = 152 then begin
        m_boParalysis:=True;
        m_boRecoveryRing:=True;
      end;
      if StdItem.Shape = 153 then begin
        m_boParalysis:=True;
        m_boMuscleRing:=True;
      end;
      if StdItem.Shape = 154 then begin
        m_boMagicShield:=True;
        m_boFlameRing:=True;
      end;
      if StdItem.Shape = 155 then begin
        m_boMagicShield:=True;
        m_boRecoveryRing:=True;
      end;
      if StdItem.Shape = 156 then begin
        m_boMagicShield:=True;
        m_boMuscleRing:=True;
      end;

      if StdItem.Shape = 157 then begin
        m_boTeleport:=True;
        m_boParalysis:=True;
      end;

      if StdItem.Shape = 158 then begin
        m_boTeleport:=True;
        m_boMagicShield:=True;
      end;

      if StdItem.Shape = 159 then begin
        m_boTeleport:=True;
        m_boProbeNecklace:=True;
      end;
      if StdItem.Shape = 160 then begin
        m_boTeleport:=True;
        m_boRevival:=True;
      end;
      if StdItem.Shape = 161 then begin
        m_boParalysis:=True;
        m_boRevival:=True;
      end;
      if StdItem.Shape = 162 then begin
        m_boMagicShield:=True;
        m_boRevival:=True;
      end;
      if StdItem.Shape = 180 then begin //PK
        m_dwPKDieLostExp:=StdItem.DuraMax * g_Config.dwPKDieLostExpRate;
//        m_nPKDieLostLevel:=1;
      end;
      if StdItem.Shape = 181 then begin //PK
        m_nPKDieLostLevel:=StdItem.DuraMax div g_Config.nPKDieLostLevelRate;
      end;
    if (i = U_NECKLACE) then begin
      if StdItem.Shape = 120 then m_boFastTrain:=True;
      if StdItem.Shape = 121 then m_boProbeNecklace:=True;
      if StdItem.Shape = 123 then boRecallSuite[0]:=True;
      if StdItem.Shape = 145 then m_boGuildMove:=True;
      if StdItem.Shape = 127 then boSpirit[0]:=True;
      if StdItem.Shape = 135 then begin
        boMoXieSuite[0]:=True;
        Inc(m_nMoXieSuite,StdItem.AniCount);
      end;
      if StdItem.Shape = 138 then begin
        boHongMoSuite1:=True;
        Inc(m_nHongMoSuite,StdItem.AniCount);
      end;
      if StdItem.Shape = 200 then boSmash1:=True;
      if StdItem.Shape = 205 then boHwanDevil1:=True;
      if StdItem.Shape = 206 then boPurity1:=True;
      if StdItem.Shape = 218 then boFiveString1:=True;
      if StdItem.Shape = 221 then boBug1 := True;
      if StdItem.Shape = 222 then boWhiteGold3 := True;
      if StdItem.Shape = 223 then boWhiteGoldH3 := True;
      if StdItem.Shape = 224 then boRedJade3 := True;
      if StdItem.Shape = 225 then boRedJadeH3 := True;
      if StdItem.Shape = 226 then boNephrite3 := True;
      if StdItem.Shape = 227 then boNephriteH3 := True;
    end;
    if (i = U_RINGR) or (i = U_RINGL) then begin
      if StdItem.Shape = 111 then begin
        m_wStatusTimeArr[STATE_TRANSPARENT{8 0x70}]:=6 * 10 * 1000;
        m_boHideMode:=True;
      end;
      if StdItem.Shape = 112 then m_boTeleport     := True;
      if StdItem.Shape = 113 then m_boParalysis    := True;
      if StdItem.Shape = 114 then m_boRevival      := True;
      if StdItem.Shape = 115 then m_boFlameRing    := True;
      if StdItem.Shape = 116 then m_boRecoveryRing := True;
      if StdItem.Shape = 117 then m_boAngryRing    := True;
      if StdItem.Shape = 118 then m_boMagicShield  := True;
      if StdItem.Shape = 119 then m_boMuscleRing   := True;
      if StdItem.Shape = 122 then boRecallSuite[1] := True;
      if StdItem.Shape = 128 then boSpirit[1]      := True;
      if StdItem.Shape = 133 then begin
        boMoXieSuite[1]:=True;
        Inc(m_nMoXieSuite,StdItem.AniCount);
      end;
      if StdItem.Shape = 999 then begin
        m_boParalysis:=True;
        m_boMagicShield:=True;
        m_boTeleport:=True;
        m_boRevival:=True;
        m_boFlameRing:=True;
        m_boRecoveryRing:=True;
        m_boAngryRing:=True;
        m_boMuscleRing:=True;
        m_wStatusTimeArr[STATE_TRANSPARENT{8 0x70}]:=6 * 10 * 1000;
        m_boHideMode:=True;
        m_boNoDropItem:=True;
        m_boNoDropUseItem:=True;
        m_boProbeNecklace:=True;
      end;
      if StdItem.Shape = 136 then begin
        boHongMoSuite2:=True;
        Inc(m_nHongMoSuite,StdItem.AniCount);
      end;
      if StdItem.Shape = 200 then boSmash2:=True;
      if StdItem.Shape = 205 then boHwanDevil2:=True;
      if StdItem.Shape = 206 then boPurity2:=True;
      if StdItem.Shape = 210 then boMundane1:=True;
      if StdItem.Shape = 212 then boNokChi1:=True;
      if StdItem.Shape = 214 then boTaoBu1:=True;
      if StdItem.Shape = 218 then boFiveString2:=True;
      if StdItem.Shape = 221 then boBug2 := True;
      if StdItem.Shape = 222 then boWhiteGold5 := True;
      if StdItem.Shape = 223 then boWhiteGoldH5 := True;
      if StdItem.Shape = 224 then boRedJade5 := True;
      if StdItem.Shape = 225 then boRedJadeH5 := True;
      if StdItem.Shape = 226 then boNephrite5 := True;
      if StdItem.Shape = 227 then boNephriteH5 := True;
    end;
    if (i = U_ARMRINGL) or (i = U_ARMRINGR) then begin
      if (StdItem.Source <= -1) and (StdItem.Source >= -50) then begin // -1 to -50
        m_AddAbil.btUndead:=m_AddAbil.btUndead + -StdItem.Source;//Holy+
      end;
      if (StdItem.Source <= -51) and (StdItem.Source >= -100) then begin // -51 to -100
        m_AddAbil.btUndead:=m_AddAbil.btUndead + (StdItem.Source + 50);//Holy-
      end;
      
      if StdItem.Shape = 124 then boRecallSuite[2] := True;
      if StdItem.Shape = 126 then boSpirit[2]      := True;
      if StdItem.Shape = 145 then m_boGuildMove  := True;
      if StdItem.Shape = 134 then begin
        boMoXieSuite[2]:=True;
        Inc(m_nMoXieSuite,StdItem.AniCount);
      end;
      if StdItem.Shape = 137 then begin
        boHongMoSuite3:=True;
        Inc(m_nHongMoSuite,StdItem.AniCount);
      end;
      if StdItem.Shape = 200 then boSmash3:=True;
      if StdItem.Shape = 205 then boHwanDevil3:=True;
      if StdItem.Shape = 206 then boPurity3:=True;
      if StdItem.Shape = 211 then boMundane2:=True;
      if StdItem.Shape = 213 then boNokChi2:=True;
      if StdItem.Shape = 215 then boTaoBu2:=True;
      if StdItem.Shape = 218 then boFiveString3:=True;
      if StdItem.Shape = 221 then boBug3 := True;
      if StdItem.Shape = 222 then boWhiteGold4 := True;
      if StdItem.Shape = 223 then boWhiteGoldH4 := True;
      if StdItem.Shape = 224 then boRedJade4 := True;
      if StdItem.Shape = 225 then boRedJadeH4 := True;
      if StdItem.Shape = 226 then boNephrite4 := True;
      if StdItem.Shape = 227 then boNephriteH4 := True;
    end;
    if (i = U_HELMET) then begin
      if (StdItem.AniCount > 0) and (StdItem.AniCount < 10) then
        m_btHelmetEffType:=StdItem.AniCount;
      if StdItem.Shape = 125 then boRecallSuite[3] := True;
      if StdItem.Shape = 129 then boSpirit[3]      := True;
      if StdItem.Shape = 220 then boBug2 := True;
    end;
    if (i = U_BELT) then begin
      if StdItem.Shape = 222 then boWhiteGold1 := True;
      if StdItem.Shape = 223 then boWhiteGoldH1 := True;
      if StdItem.Shape = 224 then boRedJade1 := True;
      if StdItem.Shape = 225 then boRedJadeH1 := True;
      if StdItem.Shape = 226 then boNephrite1 := True;
      if StdItem.Shape = 227 then boNephriteH1 := True;
    end;
    if (i = U_BOOTS) then begin
      if StdItem.Shape = 222 then boWhiteGold2 := True;
      if StdItem.Shape = 223 then boWhiteGoldH2 := True;
      if StdItem.Shape = 224 then boRedJade2 := True;
      if StdItem.Shape = 225 then boRedJadeH2 := True;
      if StdItem.Shape = 226 then boNephrite2 := True;
      if StdItem.Shape = 227 then boNephriteH2 := True;
    end;
    if (i = U_CHARM) then begin
      if StdItem.Shape = 1 then m_boNoDropUseItem := True;
    end;
  end;

  if boRecallSuite[0] and
     boRecallSuite[1] and
     boRecallSuite[2] and
     boRecallSuite[3] then m_boRecallSuite:=True;
  if boMoXieSuite[0] and
     boMoXieSuite[1] and
     boMoXieSuite[2] then Inc(m_nMoXieSuite,50);
  if boHongMoSuite1 and
     boHongMoSuite2 and
     boHongMoSuite3 then Inc(m_AddAbil.wHitPoint,2);

  if boSpirit[0] and
     boSpirit[1] and
     boSpirit[2] and
     boSpirit[3] then m_bopirit:=True;


  m_WAbil.Weight:=RecalcBagWeight();



  if m_boTransparent and (m_wStatusTimeArr[STATE_TRANSPARENT{8 0x70}] > 0) then //004C08D7
    m_boHideMode:=True;

  if m_boHideMode then begin //004C08E8
    if not boOldHideMode then begin
      m_nCharStatus:=GetCharStatus();
      StatusChanged();
    end;
  end else begin
    if boOldHideMode then begin      //004C091B
      m_wStatusTimeArr[STATE_TRANSPARENT{8 0x70}]:=0; //0x70
      m_nCharStatus:=GetCharStatus();
      StatusChanged();
    end;
  end;

  if m_btRaceServer = RC_PLAYOBJECT then
    RecalcHitSpeed();

  nOldLight := m_nLight;
  {
  if (m_UseItems[U_RIGHTHAND].wIndex > 0) and (m_UseItems[U_RIGHTHAND].Dura > 0) then
    m_nLight := StdItem.Light;
  }
  m_nLight := nItemLight;

  if nOldLight <> m_nLight then
    SendRefMsg(RM_CHANGELIGHT,0,0,0,0,'');

  Inc(m_btSpeedPoint,m_AddAbil.wSpeedPoint);
  Inc(m_btHitPoint,m_AddAbil.wHitPoint);
  Inc(m_btAntiPoison,m_AddAbil.wAntiPoison);
  Inc(m_nPoisonRecover,m_AddAbil.wPoisonRecover);
  Inc(m_nHealthRecover,m_AddAbil.wHealthRecover);
  Inc(m_nSpellRecover,m_AddAbil.wSpellRecover);
  Inc(m_nAntiMagic,m_AddAbil.wAntiMagic);
  Inc(m_nLuck,m_AddAbil.btLuck);
  Dec(m_nLuck,m_AddAbil.btUnLuck);
  m_nHitSpeed:=m_AddAbil.nHitSpeed;//004C0A53
  Inc(m_nPoisonIncrease, m_AddAbil.wTox);
  Inc(m_nFreezingIncrease, m_AddAbil.wSlowDown);

  Inc(m_WAbil.MaxWeight,m_AddAbil.Weight);
  Inc(m_WAbil.MaxWearWeight,m_AddAbil.WearWeight);
  Inc(m_WAbil.MaxHandWeight,m_AddAbil.HandWeight);

  m_WAbil.MaxHP:=_MIN(High(Word),m_Abil.MaxHP + m_AddAbil.wHP);
  m_WAbil.MaxMP:=_MIN(High(Word),m_Abil.MaxMP + m_AddAbil.wMP);

  m_WAbil.AC  := MakeLong(LoWord(m_AddAbil.wAC)  + LoWord(m_Abil.AC),  HiWord(m_AddAbil.wAC)  + HiWord(m_Abil.AC));
  m_WAbil.MAC := MakeLong(LoWord(m_AddAbil.wMAC) + LoWord(m_Abil.MAC), HiWord(m_AddAbil.wMAC) + HiWord(m_Abil.MAC));
  m_WAbil.DC  := MakeLong(LoWord(m_AddAbil.wDC)  + LoWord(m_Abil.DC),  HiWord(m_AddAbil.wDC)  + HiWord(m_Abil.DC));
  m_WAbil.MC  := MakeLong(LoWord(m_AddAbil.wMC)  + LoWord(m_Abil.MC),  HiWord(m_AddAbil.wMC)  + HiWord(m_Abil.MC));
  m_WAbil.SC  := MakeLong(LoWord(m_AddAbil.wSC)  + LoWord(m_Abil.SC),  HiWord(m_AddAbil.wSC)  + HiWord(m_Abil.SC));

  if (m_btRaceServer >= RC_ANIMAL) and (m_btRaceServer <> MONSTER_CLONE) then begin //004C0EA0
    MonsterRecalcAbilitys();
  end;


  if m_wStatusTimeArr[STATE_DEFENCEUP{10 0x72}] > 0 then //004C0BCD
    m_WAbil.AC  := MakeLong(LoWord(m_WAbil.AC),HiWord(m_WAbil.AC) + 2 + (m_Abil.Level div 7));
  if m_wStatusTimeArr[STATE_MAGDEFENCEUP{11 0x74}] > 0 then //004C0C17
    m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC),HiWord(m_WAbil.MAC) + 2 + (m_Abil.Level div 7));


  if m_wStatusArrValue[0] > 0 then
    m_WAbil.DC  := MakeLong(LoWord(m_WAbil.DC),HiWord(m_WAbil.DC) + 2 + m_wStatusArrValue[0]{n218});

  if m_wStatusArrValue[1] > 0 then
    m_WAbil.MC  := MakeLong(LoWord(m_WAbil.MC),HiWord(m_WAbil.MC) + 2 + m_wStatusArrValue[1]{n219});


  if m_wStatusArrValue[2] > 0 then
    m_WAbil.SC  := MakeLong(LoWord(m_WAbil.SC),HiWord(m_WAbil.SC) + 2 + m_wStatusArrValue[2]{n21A});


  if m_wStatusArrValue[3] > 0 then
    Inc(m_nHitSpeed,m_wStatusArrValue[3]{n21B});


  if m_wStatusArrValue[4] > 0 then begin
    m_WAbil.MaxHP:=_MIN(High(Word),m_WAbil.MaxHP + m_wStatusArrValue[4]);
  end;


  if m_wStatusArrValue[5] > 0 then begin
    m_WAbil.MaxMP:=_MIN(High(Word),m_WAbil.MaxMP + m_wStatusArrValue[5]);
  end;

  if m_wStatusArrValue[6] > 0 then begin
    if HiWord(m_WAbil.DC) > (2 + m_wStatusArrValue[6]) then
      m_WAbil.DC  := MakeLong(LoWord(m_WAbil.DC),HiWord(m_WAbil.DC) - 2 - m_wStatusArrValue[6])
    else
      m_WAbil.DC :=MakeLong(LoWord(m_WAbil.DC),0);
  end;


  if m_boFlameRing then AddItemSkill(1)
  else DelItemSkill(1);
    
  if m_boRecoveryRing then AddItemSkill(2)
  else DelItemSkill(2);

  if m_boMuscleRing then begin
    Inc(m_WAbil.MaxWeight,m_WAbil.MaxWeight);
    Inc(m_WAbil.MaxWearWeight,m_WAbil.MaxWearWeight);
    Inc(m_WAbil.MaxHandWeight,m_WAbil.MaxHandWeight);
  end;
  if m_nMoXieSuite > 0 then begin
    if m_WAbil.MaxMP <= m_nMoXieSuite then
      m_nMoXieSuite:= m_WAbil.MaxMP -1;
    Dec(m_WAbil.MaxMP,m_nMoXieSuite);
    m_WAbil.MaxHP:=_MIN(High(Word),m_WAbil.MaxHP + m_nMoXieSuite);
  end;
  if m_bopirit then begin //Bonus DC Min +2,DC Max +5,A.Speed + 2
    m_WAbil.DC  := MakeLong(LoWord(m_WAbil.DC) + 2,HiWord(m_WAbil.DC) + 5);
    Inc(m_nHitSpeed, 2);
  end;
  if boSmash2 and boSmash3 then begin //Attack Speed +2, DC1-3
    m_AddAbil.nHitSpeed:=_MIN(high(Word),m_AddAbil.nHitSpeed + 2);
    if boSmash1 then
      m_WAbil.DC  := MakeLong(LoWord(m_WAbil.DC) + 1,HiWord(m_WAbil.DC) + 3);
  end;
  if boHwanDevil2 and boHwanDevil3 then begin
    //Hand Carrying Weight Increase +5, Bag Weight Limit Increase +20, +MC 1-2
    Inc(m_WAbil.MaxWearWeight,5);
    Inc(m_WAbil.MaxWeight,20);
    if boHwanDevil1 then
      m_WAbil.MC  := MakeLong(LoWord(m_WAbil.MC) + 1,HiWord(m_WAbil.MC) + 2);
  end;
  if boPurity2 and boPurity3 then begin //Holy +3, Sc 1-2
    m_AddAbil.btUndead:=m_AddAbil.btUndead + 3;
    if boPurity1 then
      m_WAbil.SC  := MakeLong(LoWord(m_WAbil.SC) + 1,HiWord(m_WAbil.SC) + 2);
  end;
  if boMundane1 and boMundane2 then begin //Bonus of Hp+50
    m_WAbil.MaxHP:=_MIN(High(Word),m_WAbil.MaxHP + 50);
  end;
  if boNokChi1 and boNokChi2 then begin  //Bonus of Mp+50
    m_WAbil.MaxMP:=_MIN(High(Word),m_WAbil.MaxMP + 50);
  end;
  if boTaoBu1 and boTaoBu2 then begin //Bonus of Hp+30, Mp+30
    m_WAbil.MaxHP:=_MIN(High(Word),m_WAbil.MaxHP + 30);
    m_WAbil.MaxMP:=_MIN(High(Word),m_WAbil.MaxMP + 30);
  end;
  if boFiveString1 and boFiveString2 and boFiveString3 then begin //Bonus of Hp +30%, Ac+2
    m_WAbil.MaxHP:=_MIN(High(Word),(m_WAbil.MaxHP * 90 div 30 div 10) + m_WAbil.MaxHP);
    //Inc(m_btHitPoint,2);
    m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC) + 0,HiWord(m_WAbil.AC) + 2);
  end;
  if boBone1 and boBone2 and boBone3 then begin //AC+2 MC+1 SC+1
    m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC),HiWord(m_WAbil.AC) + 2);
    m_WAbil.SC  := MakeLong(LoWord(m_WAbil.SC),HiWord(m_WAbil.SC) + 1);
    m_WAbil.MC  := MakeLong(LoWord(m_WAbil.MC),HiWord(m_WAbil.MC) + 1);
  end;

  if boBug1 and boBug2 and boBug3 then begin //DC+1 MC+1 SC+1 AMC+1 PR+1
    m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC),HiWord(m_WAbil.MAC) + 1);
    m_WAbil.DC  := MakeLong(LoWord(m_WAbil.DC),HiWord(m_WAbil.DC) + 1);
    m_WAbil.SC  := MakeLong(LoWord(m_WAbil.SC),HiWord(m_WAbil.SC) + 1);
    m_WAbil.MC  := MakeLong(LoWord(m_WAbil.MC),HiWord(m_WAbil.MC) + 1);
    inc(m_btAntiPoison,1)
  end;

  if boWhiteGold1 and boWhiteGold2 and boWhiteGold3 and boWhiteGold4 and boWhiteGold5 then begin
    //DC+2 AC+2
    m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC),HiWord(m_WAbil.AC) + 2);
    m_WAbil.DC  := MakeLong(LoWord(m_WAbil.DC),HiWord(m_WAbil.DC) + 2);
  end;

  if boWhiteGoldH1 and boWhiteGoldH2 and boWhiteGoldH3 and boWhiteGoldH4 and boWhiteGoldH5 then begin
    //DC+3 HP+30 ASpeed +2
    m_WAbil.DC  := MakeLong(LoWord(m_WAbil.DC),HiWord(m_WAbil.DC) + 3);
    m_WAbil.MaxHP:=_MIN(High(Word),m_WAbil.MaxHP + 30);
    m_AddAbil.nHitSpeed:=_MIN(high(Word),m_AddAbil.nHitSpeed + 2);
  end;

  if boRedJade1 and boRedJade2 and boRedJade3 and boRedJade4 and boRedJade5 then begin
    //MC+2 AMC+2
    m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC),HiWord(m_WAbil.MAC) + 2);
    m_WAbil.MC  := MakeLong(LoWord(m_WAbil.MC),HiWord(m_WAbil.MC) + 2);
  end;

  if boRedJadeH1 and boRedJadeH2 and boRedJadeH3 and boRedJadeH4 and boRedJadeH5 then begin
    //MC+2 MP+40 AGIL+2
    m_WAbil.MC  := MakeLong(LoWord(m_WAbil.MC),HiWord(m_WAbil.MC) + 2);
    m_WAbil.MaxMP:=_MIN(High(Word),m_WAbil.MaxMP + 40);
    inc(m_btSpeedPoint,2);
  end;

  if boNephrite1 and boNephrite2 and boNephrite3 and boNephrite4 and boNephrite5 then begin
    //SC+2 AC+1 AMC+1
    m_WAbil.SC  := MakeLong(LoWord(m_WAbil.SC),HiWord(m_WAbil.SC) + 2);
    m_WAbil.MAC := MakeLong(LoWord(m_WAbil.MAC),HiWord(m_WAbil.MAC) + 1);
    m_WAbil.AC := MakeLong(LoWord(m_WAbil.AC),HiWord(m_WAbil.AC) + 1);
  end;

  if boNephriteH1 and boNephriteH2 and boNephriteH3 and boNephriteH4 and boNephriteH5 then begin
    //SC+2 HP+15 MP+20 Holy+1 ACC+1
    m_WAbil.SC  := MakeLong(LoWord(m_WAbil.SC),HiWord(m_WAbil.SC) + 2);
    m_WAbil.MaxMP:=_MIN(High(Word),m_WAbil.MaxMP + 20);
    m_WAbil.MaxHP:=_MIN(High(Word),m_WAbil.MaxHP + 30);
    inc(m_bthitPoint,1);
    m_AddAbil.btUndead:=m_AddAbil.btUndead + 1;
  end;


  if m_btRaceServer = RC_PLAYOBJECT then begin
    SendUpdateMsg(Self,RM_CHARSTATUSCHANGED,m_nHitSpeed,m_nCharStatus,0,0,'');
  end;

  m_WAbil.AC  := MakeLong(_MIN(MAXHUMPOWER,LoWord(m_WAbil.AC)),_MIN(MAXHUMPOWER,HiWord(m_WAbil.AC)));
  m_WAbil.MAC := MakeLong(_MIN(MAXHUMPOWER,LoWord(m_WAbil.MAC)),_MIN(MAXHUMPOWER,HiWord(m_WAbil.MAC)));
  m_WAbil.DC  := MakeLong(_MIN(MAXHUMPOWER,LoWord(m_WAbil.DC)),_MIN(MAXHUMPOWER,HiWord(m_WAbil.DC)));
  m_WAbil.MC  := MakeLong(_MIN(MAXHUMPOWER,LoWord(m_WAbil.MC)),_MIN(MAXHUMPOWER,HiWord(m_WAbil.MC)));
  m_WAbil.SC  := MakeLong(_MIN(MAXHUMPOWER,LoWord(m_WAbil.SC)),_MIN(MAXHUMPOWER,HiWord(m_WAbil.SC)));


  if g_Config.boHungerSystem and g_Config.boHungerDecPower then begin
    case m_nHungerStatus of    //
      0..999: begin
        m_WAbil.DC:= MakeLong(ROUND(LoWord(m_WAbil.DC) * 0.2),ROUND(HiWord(m_WAbil.DC) * 0.2));
        m_WAbil.MC:= MakeLong(ROUND(LoWord(m_WAbil.MC) * 0.2),ROUND(HiWord(m_WAbil.MC) * 0.2));
        m_WAbil.SC:= MakeLong(ROUND(LoWord(m_WAbil.SC) * 0.2),ROUND(HiWord(m_WAbil.SC) * 0.2));
      end;
      1000..1999: begin
        m_WAbil.DC:= MakeLong(ROUND(LoWord(m_WAbil.DC) * 0.4),ROUND(HiWord(m_WAbil.DC) * 0.4));
        m_WAbil.MC:= MakeLong(ROUND(LoWord(m_WAbil.MC) * 0.4),ROUND(HiWord(m_WAbil.MC) * 0.4));
        m_WAbil.SC:= MakeLong(ROUND(LoWord(m_WAbil.SC) * 0.4),ROUND(HiWord(m_WAbil.SC) * 0.4));
      end;
      2000..2999: begin
        m_WAbil.DC:= MakeLong(ROUND(LoWord(m_WAbil.DC) * 0.6),ROUND(HiWord(m_WAbil.DC) * 0.6));
        m_WAbil.MC:= MakeLong(ROUND(LoWord(m_WAbil.MC) * 0.6),ROUND(HiWord(m_WAbil.MC) * 0.6));
        m_WAbil.SC:= MakeLong(ROUND(LoWord(m_WAbil.SC) * 0.6),ROUND(HiWord(m_WAbil.SC) * 0.6));
      end;
      3000..3999: begin
        m_WAbil.DC:= MakeLong(ROUND(LoWord(m_WAbil.DC) * 0.9),ROUND(HiWord(m_WAbil.DC) * 0.9));
        m_WAbil.MC:= MakeLong(ROUND(LoWord(m_WAbil.MC) * 0.9),ROUND(HiWord(m_WAbil.MC) * 0.9));
        m_WAbil.SC:= MakeLong(ROUND(LoWord(m_WAbil.SC) * 0.9),ROUND(HiWord(m_WAbil.SC) * 0.9));
      end;
    end;
  end;
end;

procedure TBaseObject.BreakOpenHealth();//004BDCD0
begin
  if m_boShowHP then begin
    m_boShowHP:=False;
    m_nCharStatusEx:= m_nCharStatusEx xor STATE_OPENHEATH;
    m_nCharStatus:=GetCharStatus();
    SendRefMsg(RM_CLOSEHEALTH,0,0,0,0,'');
  end;
end;

procedure TBaseObject.MakeOpenHealth(); //004BDC7C
begin
  m_boShowHP:=True;
  m_nCharStatusEx:= m_nCharStatusEx or STATE_OPENHEATH;
  m_nCharStatus:=GetCharStatus();
  SendRefMsg(RM_OPENHEALTH,0,m_WAbil.HP,m_WAbil.MaxHP,0,'');
end;


procedure TBaseObject.IncHealthSpell(nHP,nMP:Integer);//004BCAA4
begin
  if (nHP < 0) or (nMP < 0) then exit;
  if (m_WAbil.HP + nHP) >= m_WAbil.MaxHP then m_WAbil.HP:=m_WAbil.MaxHP
  else Inc(m_WAbil.HP,nHP);
  if (m_WAbil.MP + nMP) >= m_WAbil.MaxMP then m_WAbil.MP:=m_WAbil.MaxMP
  else Inc(m_WAbil.MP,nMP);
  HealthSpellChanged();    
end;

procedure TBaseObject.ItemDamageRevivalRing();//004C022C
var
  i:integer;
  pSItem: TItem;
  nDura,tDura :Integer;
begin
  for i:=Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[i].wIndex > 0 then begin
      pSItem:=UserEngine.GetStdItem(m_UseItems[i].wIndex);
      if pSItem <> nil then begin
//        if (i = U_RINGR) or (i = U_RINGL) then begin
          if (pSItem.Shape in [114,160,161,162]) or (((i = U_WEAPON) or (i = U_RIGHTHAND)) and (pSItem.AniCount in [114,160,161,162])) then begin
            nDura:=m_UseItems[i].Dura;
            tDura:=Round(nDura / 1000);
            Dec(nDura,1000);
            if nDura <= 0 then begin
              nDura:=0;
              m_UseItems[i].Dura:= nDura;
              SendMsg(Self,RM_DURACHANGE,i,nDura,m_UseItems[i].DuraMax,0,'');
             {   //Nicky no breaking
              if m_btRaceServer = RC_PLAYOBJECT then begin
                PlayObject:=TPlayObject(Self);
                PlayObject.SendDelItems(@m_UseItems[i]);
              end;//004C0310
              m_UseItems[i].wIndex:=0;
              }
              RecalcAbilitys();
              
            end else begin//004C0331
              m_UseItems[i].Dura:= nDura;
            end;
            if tDura <> Round(nDura / 1000{1.03}) then begin
              SendMsg(Self,RM_DURACHANGE,i,nDura,m_UseItems[i].DuraMax,0,'');
            end;
            //break;
          end;//004C0397
//        end;//004C0397
      end;//004C0397 if pSItem <> nil then begin
    end;//if UseItems[i].wIndex > 0 then begin
  end;// for i:=Low(UseItems) to High(UseItems) do begin
end;

procedure TBaseObject.Run; //004C7720
var
  i:integer;
  boChg:Boolean;
  boNeedRecalc:Boolean;
  nHP, nMP, nPlus:Integer; //
  dwC,dwInChsTime:LongWord;
  ProcessMsg:TProcessMessage;
  BaseObject:TBaseObject;
  nCheckCode:Integer;
  dwRunTick:LongWord;
  nInteger:Integer;
ResourceString
  sExceptionMsg0 = '[Exception] TBaseObject::Run 0 code: %d';
  sExceptionMsg1 = '[Exception] TBaseObject::Run 1';
  sExceptionMsg2 = '[Exception] TBaseObject::Run 2';
  sExceptionMsg3 = '[Exception] TBaseObject::Run 3';
  sExceptionMsg4 = '[Exception] TBaseObject::Run 4 Code:%d';
  sExceptionMsg5 = '[Exception] TBaseObject::Run 5';
  sExceptionMsg6 = '[Exception] TBaseObject::Run 6';
begin
  nCheckCode:=0;
  dwRunTick:=GetTickCount();
  try
    while GetMessage(@ProcessMsg) do begin
      nCheckCode:=1000;
      Operate(@ProcessMsg);
      nCheckCode:=1001;
    end;
  except
    on e: Exception do begin
      MainOutMessage(format(sExceptionMsg0,[nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;
  //SetProcessName('TBaseObject.Run 1');
  //004C7798
  try
    if m_boSuperMan then begin
      m_WAbil.HP:=m_WAbil.MaxHP;
      m_WAbil.MP:=m_WAbil.MaxMP;
    end;
    //004C77DA
    dwC:=(GetTickCount() - m_dwHPMPTick) div 20;
    m_dwHPMPTick:=GetTickCount();

    nPlus := dwC*(1+ m_nHealthRecover);
    Inc(m_nHealthTick,nPlus);
    nPlus := dwC*(1+ m_nSpellRecover);
    Inc(m_nSpellTick,nPlus);

    //004C781D
    if not m_boDeath then begin
      if (m_WAbil.HP < m_WAbil.MaxHP) and (m_nHealthTick >= g_Config.nHealthFillTime) then begin
        nPlus:= (m_WAbil.MaxHP div 75) + 1;
        //nPlus = m_WAbility.MaxHP / 15 + 1;        
        if (m_WAbil.HP + nPlus) < m_WAbil.MaxHP then begin
          Inc(m_WAbil.HP,nPlus);
        end else begin
          m_WAbil.HP:=m_WAbil.MaxHP;
        end;
        HealthSpellChanged;
      end;
      //004C78AF
      if (m_WAbil.MP < m_WAbil.MaxMP) and (m_nSpellTick >= g_Config.nSpellFillTime) then begin
        nPlus:= (m_WAbil.MaxMP div 18) + 1;
        if (m_WAbil.MP + nPlus) < m_WAbil.MaxMP then begin
          Inc(m_WAbil.MP,nPlus);
        end else begin
          m_WAbil.MP:=m_WAbil.MaxMP;
        end;
        HealthSpellChanged;
      end;

      //004C7934
      if m_WAbil.HP = 0 then begin
        if ((m_LastHiter = nil) or not m_LastHiter.m_boUnRevival{防复活}) and m_boRevival and (GetTickCount - m_dwRevivalTick > g_Config.dwRevivalTime{60 * 1000}) then begin
           m_dwRevivalTick:= GetTickCount();
           ItemDamageRevivalRing;
           m_WAbil.HP := m_WAbil.MaxHP;
           HealthSpellChanged;
           SysMsg (g_sRevivalRecoverMsg{'生命值得到恢复'}, c_Green,t_Hint);
        end;
        if m_WAbil.HP = 0 then Die;
      end;
      if m_nHealthTick >= g_Config.nHealthFillTime then m_nHealthTick:=0;
      if m_nSpellTick >= g_Config.nSpellFillTime then m_nSpellTick:=0;
    end else begin
      if (GetTickCount() - m_dwDeathTick > g_Config.dwMakeGhostTime {3 * 60 * 1000}) then
        MakeGhost();
    end;
  except
    on e: Exception do begin
      MainOutMessage(sExceptionMsg1);
      MainOutMessage(E.Message);
    end;
  end;

  //004C7A34
  try
    if not m_boDeath and ((m_nIncSpell > 0) or (m_nIncHealth > 0) or (m_nIncHealing > 0)) then begin
      //004C7A7A
      dwInChsTime:=600 - _MIN(400,m_Abil.Level * 10);


      if ((GetTickCount - m_dwIncHealthSpellTick) >= dwInChsTime) and not m_boDeath then begin
        dwC:=_MIN(200,(GetTickCount - m_dwIncHealthSpellTick - dwInChsTime));
        m_dwIncHealthSpellTick:=GetTickCount() + dwC;
        if (m_nIncSpell > 0) or (m_nIncHealth > 0) or (m_nPerHealing > 0) then begin
          //004C7B1C

          if (m_nPerHealth <= 0) then m_nPerHealth:= 1;
          if (m_nPerSpell <= 0) then m_nPerSpell:= 1;
          if (m_nPerHealing <= 0) then m_nPerHealing:= 1;

          //004C7B67
          if m_nIncHealth < m_nPerHealth then begin
            nHP:=m_nIncHealth;
            m_nIncHealth:=0;
          end else begin
            //004C7B94
            nHP:=m_nPerHealth;
            Dec(m_nIncHealth,m_nPerHealth);
          end;

          //004C7BB2
          if m_nIncSpell < m_nPerSpell then begin
            nMP:=m_nIncSpell;
            m_nIncSpell:=0;
          end else begin
            //004C7BDF
            nMP:=m_nPerSpell;
            Dec(m_nIncSpell,m_nPerSpell);
          end;
          
          //004C7BFD
          if m_nIncHealing < m_nPerHealing then begin
            Inc(nHP,m_nIncHealing);
            m_nIncHealing:=0;
          end else begin
            //004C7C2A
            Inc(nHP,m_nPerHealing);
            Dec(m_nIncHealing,m_nPerHealing);
          end;
          m_nPerHealth:=(m_Abil.Level div 10 + 5);
          m_nPerSpell:=(m_Abil.Level div 10 + 5);
          m_nPerHealing:=5;
          IncHealthSpell(nHP,nMP);

          //004C7C9B
          if m_WAbil.HP = m_WAbil.MaxHP then begin
            m_nIncHealth:=0;
            m_nIncHealing:=0;
          end;
          if m_WAbil.MP = m_WAbil.MaxMP then begin
            m_nIncSpell:=0;
          end;
        end;
      end;
    end else begin //004C7CEA
      m_dwIncHealthSpellTick:=GetTickCount();
    end;
    //004C7CF8
    if (m_nHealthTick < - g_Config.nHealthFillTime) and (m_WAbil.HP > 1) then begin //Jacky ????
      dec(m_WAbil.HP);
      Inc(m_nHealthTick,g_Config.nHealthFillTime);
      HealthSpellChanged();
    end;
    //检查HP/MP值是否大于最大值，大于则降低到正常大小
    boNeedRecalc:=False;
    if m_WAbil.HP > m_WAbil.MaxHP then begin
      boNeedRecalc:=True;
      m_WAbil.HP:=m_WAbil.MaxHP -1;
    end;
    if m_WAbil.MP > m_WAbil.MaxMP then begin
      boNeedRecalc:=True;
      m_WAbil.MP:=m_WAbil.MaxMP -1;
    end;
    if boNeedRecalc then HealthSpellChanged();

  except
    MainOutMessage(sExceptionMsg2);
  end;

  //004C7D59
  //TBaseObject.Run 3 清理目标对象
  try
    if (m_TargetCret <> nil) then begin
      if ((GetTickCount() - m_dwTargetFocusTick) > 30000) or
         m_TargetCret.m_boDeath or
         m_TargetCret.m_boGhost or
         (m_TargetCret.m_PEnvir <> m_PEnvir) or // 08/06 增加，弓箭卫士在人物进入房间后再出来，还会攻击人物(人物的攻击目标没清除)
         (abs(m_TargetCret.m_nCurrX - m_nCurrX) > 15) or
         (abs(m_TargetCret.m_nCurrY - m_nCurrY) > 15) then begin
          //004C7DE4
          m_TargetCret:=nil;
      end;
    end;
    //004C7DEF
    if (m_LastHiter <> nil) then begin
      if ((GetTickCount() - m_LastHiterTick) > 30000) or
         m_LastHiter.m_boDeath or
         m_LastHiter.m_boGhost then begin
          //004C7E34
        m_LastHiter:=nil;
      end;
    end;
    //004C7E3F
    //
    if (m_ExpHitter <> nil) then begin
      if ((GetTickCount() - m_ExpHitterTick) > 6000) or
         m_ExpHitter.m_boDeath or
         m_ExpHitter.m_boGhost then begin
          //004C7E84
        m_ExpHitter:=nil;
      end;
    end;
    //004C7E8F
    if (m_Master <> nil) then begin
      m_boNoItem:=True;
      //宝宝变色
      if m_boAutoChangeColor and (GetTickCount - m_dwAutoChangeColorTick > g_Config.dwBBMonAutoChangeColorTime) then begin
        m_dwAutoChangeColorTick:=GetTickCount();
        case m_nAutoChangeIdx of    //
          0: nInteger:=STATE_TRANSPARENT;
          1: nInteger:=POISON_STONE;
          2: nInteger:=POISON_DONTMOVE;
          3: nInteger:=POISON_SLOWDOWN;
          4: nInteger:=POISON_DECHEALTH;
          5: nInteger:=POISON_FREEZE;
          6: nInteger:=POISON_DAMAGEARMOR;
          else begin
            m_nAutoChangeIdx:=0;
            nInteger:=STATE_TRANSPARENT;
          end;
        end;
        Inc(m_nAutoChangeIdx);
        m_nCharStatus:=(m_nCharStatusEx and $FFFFF) or (($80000000 shr nInteger) or 0);
        StatusChanged();
      end;
      if m_boFixColor and (m_nFixStatus <> m_nCharStatus) then begin
        case m_nFixColorIdx of    //
          0: nInteger:=STATE_TRANSPARENT;
          1: nInteger:=POISON_STONE;
          2: nInteger:=POISON_DONTMOVE;
          3: nInteger:=POISON_SLOWDOWN;
          4: nInteger:=POISON_DECHEALTH;
          5: nInteger:=POISON_FREEZE;
          6: nInteger:=POISON_DAMAGEARMOR;
          else begin
            m_nFixColorIdx:=0;
            nInteger:=STATE_TRANSPARENT;
          end;
        end;
        m_nCharStatus:=(m_nCharStatusEx and $FFFFF) or (($80000000 shr nInteger) or 0);
        m_nFixStatus:=m_nCharStatus;
        StatusChanged();
      end;
        
        
      // 宝宝在主人死亡后死亡处理
      if (m_Master.m_boDeath and ((GetTickCount - m_Master.m_dwDeathTick) > 1000)) then begin
        if g_Config.boMasterDieMutiny and (m_Master.m_LastHiter <> nil) and (Random(g_Config.nMasterDieMutinyRate) = 0) then begin
          m_Master:=nil;
          m_btSlaveExpLevel:=High(g_Config.SlaveColor);
          RecalcAbilitys();
          m_WAbil.DC:=MakeLong(LoWord(m_WAbil.DC) * g_Config.nMasterDieMutinyPower,HiWord(m_WAbil.DC) * g_Config.nMasterDieMutinyPower);
          m_nWalkSpeed:=m_nWalkSpeed div g_Config.nMasterDieMutinySpeed;
          RefNameColor;
          RefShowName;
        end else begin
          //004C7EFF
          m_WAbil.HP:=0;
        end;
      end;
      if m_Master.m_boGhost and ((GetTickCount - m_Master.m_dwGhostTick) > 1000) then begin
        MakeGhost;
      end;
      {
      if (m_Master.m_boDeath and ((GetTickCount - m_Master.m_dwDeathTick) > 1000)) or
         (m_Master.m_boGhost and ((GetTickCount - m_Master.m_dwGhostTick) > 1000)) then begin

        if g_Config.boMasterDieMutiny and (m_Master.m_LastHiter = nil) and (Random(g_Config.nMasterDieMutinyRate) = 0) then begin
          m_Master:=nil;
          m_btSlaveExpLevel:=High(g_Config.SlaveColor);
          RecalcAbilitys();
          m_WAbil.DC:=MakeLong(LoWord(m_WAbil.DC) * g_Config.nMasterDieMutinyPower,HiWord(m_WAbil.DC) * g_Config.nMasterDieMutinyPower);
          m_nWalkSpeed:=m_nWalkSpeed div g_Config.nMasterDieMutinySpeed;
          RefNameColor;
          RefShowName;
        end else begin
          //004C7EFF
          m_WAbil.HP:=0;
        end;
      end;
      }
    end;
    //004C7F0B
    //清除宝宝列表中已经死亡及叛变的宝宝信息
    for i:=m_SlaveList.Count -1 downto 0 do begin
      if TBaseObject(m_SlaveList.Items[i]).m_boDeath or
         TBaseObject(m_SlaveList.Items[i]).m_boGhost or
         (TBaseObject(m_SlaveList.Items[i]).m_Master <> Self) then

      m_SlaveList.Delete(i);
    end;
    //004C7F8A
    if m_boHolySeize and ((GetTickCount() - m_dwHolySeizeTick) > m_dwHolySeizeInterval) then begin
      BreakHolySeizeMode();
    end;
    //004C7FB7
    if m_boCrazyMode and ((GetTickCount() - m_dwCrazyModeTick) > m_dwCrazyModeInterval) then begin
      BreakCrazyMode();
    end;
    if m_boHallucMode and ((GetTickCount() - m_dwHallucModeTick) > m_dwHallucModeInterval) then begin
      BreakHallucMode(); //Hallucination
    end;
    if m_boShowHP and ((GetTickCount() - m_dwShowHPTick) > m_dwShowHPInterval) then begin
      BreakOpenHealth();
    end;
  except
    MainOutMessage(sExceptionMsg3);
  end;

  //SetProcessName('TBaseObject.Run ');
  //004C802F
  try
    nCheckCode:=4;
    // 减少PK值开始
    if (GetTickCount() - m_dwDecPkPointTick) > g_Config.dwDecPkPointTime{120000} then begin
      m_dwDecPkPointTick:=GetTickCount();
      if m_nPkPoint > 0 then begin
        DecPKPoint(g_Config.nDecPkPointCount{1});
      end;
    end;
    // 减少PK值结束

    //检查照明物品及PK状态 开始
    nCheckCode:=41;
    if (GetTickCount - m_DecLightItemDrugTick) > g_Config.dwDecLightItemDrugTime{500} then begin
      Inc(m_DecLightItemDrugTick,g_Config.dwDecLightItemDrugTime{500});
      if m_btRaceServer = RC_PLAYOBJECT then begin
        UseLamp();
        CheckPKStatus();
      end;
    end;
    //检查照明物品及PK状态 结束

    nCheckCode:=42;
    if (GetTickCount - m_dwCheckRoyaltyTick) > 10000 then begin
      m_dwCheckRoyaltyTick:=GetTickCount();
      if m_Master <> nil then begin
        if (g_dwSpiritMutinyTick > GetTickCount) and (m_btSlaveExpLevel < 5) then begin
          m_dwMasterRoyaltyTick:=0;
        end;
          
        //宝宝叛变  开始
        nCheckCode:=423;
        if (GetTickCount > m_dwMasterRoyaltyTick) then begin
          for I := 0 to m_Master.m_SlaveList.Count - 1 do begin
            nCheckCode:=424;
            if m_Master.m_SlaveList.Items[i] = Self then begin
              nCheckCode:=425;
              m_Master.m_SlaveList.Delete(i);
              break;
            end;
          end;
          m_Master:=nil;
          m_WAbil.HP:=m_WAbil.HP div 10;
          nCheckCode:=426;
          RefShowName();
        end;
        //宝宝叛变 结束
        nCheckCode:=427;
        if m_dwMasterTick <> 0 then begin
          if (GetTickCount -  m_dwMasterTick) > 12 * 60 * 60 * 1000 then begin
            m_WAbil.HP:=0;
          end;
        end;
      end; //004C81DB
    end;
    nCheckCode:=43;
    if (GetTickCount -  m_dwVerifyTick) > 30 * 1000 then begin
      m_dwVerifyTick:=GetTickCount();
      // 清组队已死亡成员
      if (m_GroupOwner <> nil) then begin
        if m_GroupOwner.m_boDeath or m_GroupOwner.m_boGhost then begin
          m_GroupOwner:=nil;
        end;
      end;
      nCheckCode:=44;
      if m_GroupOwner = Self then begin
        for I := m_GroupMembers.Count - 1 downto 0 do begin
          BaseObject:=TBaseObject(m_GroupMembers.Objects[i]);
          if BaseObject.m_boDeath or (BaseObject.m_boGhost) then
            m_GroupMembers.Delete(i);
        end;
      end;
      // 清组队已死亡成员 结束
      nCheckCode:=45;
      // 检查交易双方 状态
      if (m_DealCreat <> nil) and (m_DealCreat.m_boGhost) then
        m_DealCreat:=nil;
      nCheckCode:=46;  
      if not m_boDenyRefStatus then
        m_PEnvir.VerifyMapTime(m_nCurrX,m_nCurrY,Self);  //刷新在地图上位置的时间
    end;
  except
    on e: Exception do begin
      MainOutMessage(format(sExceptionMsg4,[nCheckCode]));
      MainOutMessage(E.Message);
    end;
  end;

  //SetProcessName('TBaseObject.Run 5');
  try
    boChg:=False;
    boNeedRecalc:=False;
    //004C832E
//    for i:=0 to MAX_STATUS_ATTRIBUTE - 1 do begin
    for i:=Low(m_dwStatusArrTick) to High(m_dwStatusArrTick) do begin  //004C832E
      if (m_wStatusTimeArr[i] > 0) and (m_wStatusTimeArr[i] < 60000) then begin
        if (GetTickCount() - m_dwStatusArrTick[i]) > 1000 then begin
          Dec(m_wStatusTimeArr[i]);
          Inc(m_dwStatusArrTick[i],1000);
          if (m_wStatusTimeArr[i] = 0) then begin
            boChg:=True;
            case i of
              STATE_TRANSPARENT: begin
                m_boHideMode:=False;
              end;
              STATE_DEFENCEUP: begin
                boNeedRecalc:=True;
                SysMsg('防御力恢复正常。',c_Green,t_Hint);
              end;
              STATE_MAGDEFENCEUP :begin
                boNeedRecalc:=True;
                SysMsg('魔法防御力恢复正常。',c_Green,t_Hint);
              end;
              STATE_BUBBLEDEFENCEUP :begin
                m_boAbilMagBubbleDefence:=False;
                m_boAbilCelestialDefence:=False;
               end;
              {STATE_SUNCHENDEFENCEUP :begin

              end;}
              POISON_FREEZE: begin
                m_nWalkSpeed:= m_nnonfrzWalkSpeed;
                m_nNextHitTime := m_nnonfrzNextHitTime;
              end;
              POISON_DONTMOVE: begin
                m_boTDBeffect:=False;
              end;
            end;
          end;
        end;
      end;
    end;
    //004C8409
    for i:=Low(m_wStatusArrValue) to High(m_wStatusArrValue) do begin
      if m_wStatusArrValue{218}[i] > 0 then begin
        if GetTickCount() > m_dwStatusArrTimeOutTick{220}[i] then begin
          m_wStatusArrValue[i]:=0;
          boNeedRecalc:=True;
          case i of
            0: begin
              SysMsg('Removed temporarily increased destructive power.',c_Green,t_Hint);
            end;
            1: begin
              SysMsg('Removed temporarily increased magic power.',c_Green,t_Hint);
            end;
            2: begin
              SysMsg('Removed temporarily increased zen power.',c_Green,t_Hint);
            end;
            3: begin
              SysMsg('Removed temporarily increased hitting speed.',c_Green,t_Hint);
            end;
            4: begin
              SysMsg('Removed temporarily increased HP.',c_Green,t_Hint);
            end;
            5: begin
              SysMsg('Removed temporarily increased MP.',c_Green,t_Hint);
            end;
            6: begin  //New
              SysMsg('Removed temporarily decreased attack ability.',c_Green,t_Hint);
            end;
          end;
        end;
      end;
    end;

    //004C84F5
    if boChg then begin
      m_nCharStatus:=GetCharStatus();
      StatusChanged();
    end;
    //004C8511
    if boNeedRecalc then begin
      RecalcAbilitys();
      SendMsg(Self, RM_ABILITY, 0, 0, 0, 0, '');
    end;
  except
    MainOutMessage(sExceptionMsg5);
  end;

  //SetProcessName('TBaseObject.Run 6');
  //004C855A
  try
    if (GetTickCount - m_dwPoisoningTick) > g_Config.dwPosionDecHealthTime{2500} then begin
      m_dwPoisoningTick:=GetTickCount();
      if m_wStatusTimeArr[POISON_DECHEALTH{0 0x60}] > 0 then begin
        if m_boAnimal then Dec(m_nMeatQuality,1000);
        DamageHealth(m_btGreenPoisoningPoint + 1);
        m_nHealthTick:=0;
        m_nSpellTick:=0;
        HealthSpellChanged();
      end;
    end;
  except
    MainOutMessage(sExceptionMsg6);
  end;
  {
  if boOpenHealth then begin
    if (GetTickCount() - dwOpenHealthStart) > dwOpenHealthTime then begin
      BreakOpenHealth();
    end;
  end;
  }
  g_nBaseObjTimeMin:=GetTickCount - dwRunTick;
  if g_nBaseObjTimeMax < g_nBaseObjTimeMin then g_nBaseObjTimeMax:=g_nBaseObjTimeMin;


end;

function TPlayObject.DayBright: Byte;
begin
  if m_PEnvir.Flag.boDarkness then Result := 1
  else if (m_btBright = 1) then
    Result := 0
  else if (m_btBright = 3) then
    Result := 1
  else
    Result := 2;

  if m_PEnvir.Flag.boDayLight then Result := 0;
end;



function TBaseObject.GetFrontPosition(var nX:Integer;var nY:Integer):Boolean;//004B2790
var
  Envir:TEnvirnoment;
begin
  Envir:=m_PEnvir;
  nX:=m_nCurrX;
  nY:=m_nCurrY;
  case m_btDirection of    //
    DR_UP: begin
      if nY > 0 then Dec(nY);
    end;
    DR_UPRIGHT: begin
      if (nX < (Envir.Header.wWidth -1)) and (nY > 0) then begin
       Inc(nX);
       Dec(nY);
      end;
    end;
    DR_RIGHT: begin
     if nX < (Envir.Header.wWidth -1) then Inc(nX);
    end;
    DR_DOWNRIGHT: begin
      if (nX < (Envir.Header.wWidth -1)) and (nY < (Envir.Header.wHeight -1)) then begin
       Inc(nX);
       Inc(nY);
      end;
    end;
    DR_DOWN: begin
     if nY < (Envir.Header.wHeight -1) then Inc(nY);
    end;
    DR_DOWNLEFT: begin
      if (nX > 0) and (nY < (Envir.Header.wHeight -1)) then begin
       Dec(nX);
       Inc(nY);
      end;
    end;
    DR_LEFT: begin
      if nX > 0 then Dec(nX);
    end;
    DR_UPLEFT: begin
      if (nX > 0) and (nY > 0) then begin
        Dec(nX);
        Dec(nY);
      end;
    end;
  end;
  Result:=True;
end;

procedure TBaseObject.SpaceMove(sMap:String;nX,nY:Integer;nInt:Integer);//004BCD1C
  function GetRandXY(Envir:TEnvirnoment;var nX:Integer;var nY:Integer):Boolean;
  var
    n14,n18,n1C:Integer;
  begin
    Result:=False;
    if Envir.Header.wWidth < 80 then n18:=3
    else n18:=10;
    if Envir.Header.wHeight < 150 then begin
      if Envir.Header.wHeight < 50 then n1C:=2
      else n1C:=15;
    end else n1C:=50;
    n14:=0;
    while (True) do begin
      if Envir.CanWalk(nX,nY,True) then begin
        Result:=True;
        break;
      end;
      if nX < (Envir.Header.wWidth - n1C -1) then Inc(nX,n18)
      else begin
        nX:=Random(Envir.Header.wWidth);
        if nY < (Envir.Header.wHeight - n1C -1) then Inc(nY,n18)
        else nY:=Random(Envir.Header.wHeight);
      end;
      Inc(n14);
      if n14 >= 201 then break;
    end;
  end;
var
  I: Integer;
  Envir,OldEnvir:TEnvirnoment;
  nOldX,nOldY:Integer;
  bo21:Boolean;
  PlayObject:TPlayObject;
begin
  Envir:=g_MapManager.FindMap(sMap);
  if Envir <> nil then begin
    if nServerIndex = Envir.nServerIndex then begin
      OldEnvir := m_PEnvir;
      nOldX    := m_nCurrX;
      nOldY    := m_nCurrY;
      bo21     := False;

      m_PEnvir.DeleteFromMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
      m_VisibleHumanList.Clear;
      for I := 0 to m_VisibleItems.Count - 1 do begin
        Dispose(pTVisibleMapItem(m_VisibleItems.Items[i]));
      end;
      m_VisibleItems.Clear;
      for I := 0 to m_VisibleActors.Count - 1 do begin
        Dispose(pTVisibleBaseObject(m_VisibleActors.Items[i]));
      end;
      m_VisibleActors.Clear;
      m_VisibleEvents.Clear; //01/21 移动时清除列表
      m_PEnvir:=Envir;
      m_sMapName:=Envir.sMapName;
      m_nCurrX:=nX;
      m_nCurrY:=nY;
      if GetRandXY(m_PEnvir,m_nCurrX,m_nCurrY) then begin
        m_PEnvir.AddToMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
        SendMsg(Self,RM_CLEAROBJECTS,0,0,0,0,'');
        SendMsg(Self,RM_CHANGEMAP,0,0,0,0,m_sMapName);
        if nInt = 1 then begin
          SendRefMsg(RM_SPACEMOVE_SHOW2,m_btDirection,m_nCurrX,m_nCurrY,0,'');
        end else SendRefMsg(RM_SPACEMOVE_SHOW,m_btDirection,m_nCurrX,m_nCurrY,0,'');
        m_dwMapMoveTick:=GetTickCount();
        m_bo316:=True;
        bo21:=True;
      end; //004BCFA9
      if not bo21 then begin
        m_PEnvir := OldEnvir;
        m_nCurrX := nOldX;
        m_nCurrY := nOldY;
        m_PEnvir.AddToMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
      end;
    end else begin //004BCFF6
      if GetRandXY(Envir,nX,nY) then begin
        if m_btRaceServer = RC_PLAYOBJECT then begin
          DisappearA();
          m_bo316:=True;
          PlayObject:=TPlayObject(Self);
          PlayObject.m_sSwitchMapName:=Envir.sMapName;
          PlayObject.m_nSwitchMapX:=nX;
          PlayObject.m_nSwitchMapY:=nY;
          PlayObject.m_boSwitchData:=True;
          PlayObject.m_nServerIndex:=Envir.nServerIndex;
          PlayObject.m_boEmergencyClose:=True;
          PlayObject.m_boReconnection:=True;
        end else KickException();
      end;
    end;
  end;
end;
procedure TBaseObject.SpaceMoveEx(sMap:String;nX,nY:Integer;nInt,GTNumber:Integer);//004BCD1C
  function GetRandXY(Envir:TEnvirnoment;var nX:Integer;var nY:Integer):Boolean;
  var
    n14,n18,n1C:Integer;
  begin
    Result:=False;
    if Envir.Header.wWidth < 80 then n18:=3
    else n18:=10;
    if Envir.Header.wHeight < 150 then begin
      if Envir.Header.wHeight < 50 then n1C:=2
      else n1C:=15;
    end else n1C:=50;
    n14:=0;
    while (True) do begin
      if Envir.CanWalk(nX,nY,True) then begin
        Result:=True;
        break;
      end;
      if nX < (Envir.Header.wWidth - n1C -1) then Inc(nX,n18)
      else begin
        nX:=Random(Envir.Header.wWidth);
        if nY < (Envir.Header.wHeight - n1C -1) then Inc(nY,n18)
        else nY:=Random(Envir.Header.wHeight);
      end;
      Inc(n14);
      if n14 >= 201 then break;
    end;
  end;
var
  I: Integer;
  Envir,OldEnvir:TEnvirnoment;
  nOldX,nOldY:Integer;
  bo21:Boolean;
  PlayObject:TPlayObject;
begin
  Envir:=g_MapManager.FindMapEx(sMap,GTNumber);
  if Envir <> nil then begin
    if nServerIndex = Envir.nServerIndex then begin
      OldEnvir := m_PEnvir;
      nOldX    := m_nCurrX;
      nOldY    := m_nCurrY;
      bo21     := False;

      m_PEnvir.DeleteFromMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
      m_VisibleHumanList.Clear;
      for I := 0 to m_VisibleItems.Count - 1 do begin
        Dispose(pTVisibleMapItem(m_VisibleItems.Items[i]));
      end;
      m_VisibleItems.Clear;
      for I := 0 to m_VisibleActors.Count - 1 do begin
        Dispose(pTVisibleBaseObject(m_VisibleActors.Items[i]));
      end;
      m_VisibleActors.Clear;
      m_VisibleEvents.Clear; //01/21 移动时清除列表
      m_PEnvir:=Envir;
      m_sMapName:=Envir.sMapName;
      m_nCurrX:=nX;
      m_nCurrY:=nY;
      if GetRandXY(m_PEnvir,m_nCurrX,m_nCurrY) then begin
        m_PEnvir.AddToMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
        SendMsg(Self,RM_CLEAROBJECTS,0,0,0,0,'');
        SendMsg(Self,RM_CHANGEMAP,0,0,0,0,m_sMapName);
        if nInt = 1 then begin
          SendRefMsg(RM_SPACEMOVE_SHOW2,m_btDirection,m_nCurrX,m_nCurrY,0,'');
        end else SendRefMsg(RM_SPACEMOVE_SHOW,m_btDirection,m_nCurrX,m_nCurrY,0,'');
        m_dwMapMoveTick:=GetTickCount();
        m_bo316:=True;
        bo21:=True;
      end; //004BCFA9
      if not bo21 then begin
        m_PEnvir := OldEnvir;
        m_nCurrX := nOldX;
        m_nCurrY := nOldY;
        m_PEnvir.AddToMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
      end;
    end else begin //004BCFF6
      if GetRandXY(Envir,nX,nY) then begin
        if m_btRaceServer = RC_PLAYOBJECT then begin
          DisappearA();
          m_bo316:=True;
          PlayObject:=TPlayObject(Self);
          PlayObject.m_sSwitchMapName:=Envir.sMapName;
          PlayObject.m_nSwitchMapX:=nX;
          PlayObject.m_nSwitchMapY:=nY;
          PlayObject.m_boSwitchData:=True;
          PlayObject.m_nServerIndex:=Envir.nServerIndex;
          PlayObject.m_boEmergencyClose:=True;
          PlayObject.m_boReconnection:=True;
        end else KickException();
      end;
    end;
  end;
end;

procedure TPlayObject.RefUserState(); //004D6870
var
  n8:Integer;
begin
  n8:=0;
  if m_PEnvir.Flag.boFightZone then n8:=n8 or 1;
  if m_PEnvir.Flag.boSAFE then n8:=n8 or 2;
  if m_boInFreePKArea then n8:=n8 or 4;
  SendDefMessage(SM_AREASTATE,n8,0,0,0,'');
end;
procedure TBaseObject.RefShowName();//004BF0C4
begin
  SendRefMsg(RM_USERNAME,0,0,0,0,GetShowName);
end;
procedure TPlayObject.RefMyStatus();
begin
  RecalcAbilitys();
  SendMsg(Self,RM_MYSTATUS,0,0,0,0,'');
end;
function TBaseObject.Operate(ProcessMsg:pTProcessMessage):Boolean;//004C716C
var
  nDamage          :Integer;
  nTargetX         :Integer;
  nTargetY         :Integer;
  nPower           :Integer;
  nRage            :Integer;
  TargetBaseObject :TBaseObject;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::Operate ';
begin
  Result:=False;
try
  case ProcessMsg.wIdent of
    RM_MAGSTRUCK,
    RM_MAGSTRUCK_MINE: begin //10025
      if (ProcessMsg.wIdent = RM_MAGSTRUCK) and
         (m_btRaceServer >= RC_ANIMAL) and
         (not bo2BF) and (m_Abil.Level < 50) then begin
        m_dwWalkTick:=m_dwWalkTick + 800 + LongWord(Random(1000));
      end;
      if ProcessMsg.nParam2 <> 1 then begin //if 1 then hit through mshield and amc :p
        nDamage:=GetMagStruckDamage(nil,ProcessMsg.nParam1);
      end else
        nDamage:= ProcessMsg.nParam1;
      if nDamage > 0 then begin
        StruckDamage(nDamage);
        HealthSpellChanged();
        SendRefMsg(RM_STRUCK_MAG,nDamage,m_WAbil.HP,m_WAbil.MaxHP,Integer(ProcessMsg.BaseObject),'');
        if m_btRaceServer <> RC_PLAYOBJECT then begin
          if m_boAnimal then Dec(m_nMeatQuality,nDamage * 1000);
          SendMsg(Self,RM_STRUCK,nDamage,m_WAbil.HP,m_WAbil.MaxHP,Integer(ProcessMsg.BaseObject){AttackBaseObject},'');
        end;          
      end;
      if m_boFastParalysis then begin
        m_wStatusTimeArr[POISON_STONE]:=1;
        m_boFastParalysis:=False;
      end;
    end;
    RM_MAGHEALING: begin //10026
      if (m_nIncHealing + ProcessMsg.nParam1) < 300 then begin
        if m_btRaceServer = RC_PLAYOBJECT then begin
          Inc(m_nIncHealing,ProcessMsg.nParam1);
          m_nPerHealing:=5;
        end else begin
          Inc(m_nIncHealing,ProcessMsg.nParam1);
          m_nPerHealing:=5;
        end;
      end else m_nIncHealing:=300;
    end;
    RM_10101: begin //10101
      SendRefMsg(Integer(ProcessMsg.BaseObject),
                 ProcessMsg.wParam{nPower},
                 ProcessMsg.nParam1{HP},
                 ProcessMsg.nParam2{MaxHP},
                 ProcessMsg.nParam3{AttackSrc},
                 ProcessMsg.sMsg);
      if (Integer(ProcessMsg.BaseObject) = RM_STRUCK) and (m_btRaceServer <> RC_PLAYOBJECT) then begin
        SendMsg(Self,Integer(ProcessMsg.BaseObject),
                ProcessMsg.wParam,
                ProcessMsg.nParam1,
                ProcessMsg.nParam2,
                ProcessMsg.nParam3{AttackBaseObject},
                ProcessMsg.sMsg);
      end;
      if m_boFastParalysis then begin
        m_wStatusTimeArr[POISON_STONE]:=1;
        m_boFastParalysis:=False;
      end;
    end;
    RM_DELAYMAGIC: begin //10154 004C726E
      nPower:=ProcessMsg.wParam;
      nTargetX:=LoWord(ProcessMsg.nParam1);
      nTargetY:=HiWord(ProcessMsg.nParam1);
      nRage:=ProcessMsg.nParam2;
      TargetBaseObject:=TBaseObject(ProcessMsg.nParam3);
      if (TargetBaseObject <> nil) and
         (TargetBaseObject.GetMagStruckDamage(Self,nPower) > 0) then begin

        SetTargetCreat{0FFF2}(TargetBaseObject);
        if TargetBaseObject.m_btRaceServer >= RC_ANIMAL then
          nPower:=ROUND(nPower / 1.2);
        if (abs(nTargetX - TargetBaseObject.m_nCurrX) <= nRage) and (abs(nTargetY - TargetBaseObject.m_nCurrY) <= nRage )then
          TargetBaseObject.SendMsg(Self,RM_MAGSTRUCK,0,nPower,0,0,'');
      end;         
    end;
    RM_10155: begin //10155
      MapRandomMove(ProcessMsg.sMsg,ProcessMsg.wParam);
    end;
    RM_DELAYPUSHED: begin
      nPower:=ProcessMsg.wParam;
      nTargetX:=LoWord(ProcessMsg.nParam1);
      nTargetY:=HiWord(ProcessMsg.nParam1);
      nRage:=ProcessMsg.nParam2;
      TargetBaseObject:=TBaseObject(ProcessMsg.nParam3);
      if (TargetBaseObject <> nil) then begin
        TargetBaseObject.CharPushed (nPower, nRage);
      end;
    end;
    RM_POISON: begin //10300 004C74AB
      TargetBaseObject:=TBaseObject(ProcessMsg.nParam2);
      if TargetBaseObject <> nil then begin
        if IsProperTarget{FFF4}(TargetBaseObject) then begin
          SetTargetCreat{0FFF2}(TargetBaseObject);
          if (m_btRaceServer = RC_PLAYOBJECT) and (TargetBaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
            SetPKFlag(TargetBaseObject);
          end;
          SetLastHiter(TargetBaseObject);


        end;
        MakePosion(ProcessMsg.wParam,ProcessMsg.nParam1{nPower},ProcessMsg.nParam3{});
      end else MakePosion(ProcessMsg.wParam,ProcessMsg.nParam1{nPower},ProcessMsg.nParam3);
        
    end;
    RM_TRANSPARENT: begin //10308
      MagicManager.MagMakePrivateTransparent(Self,ProcessMsg.nParam1);
    end;
    RM_DOOPENHEALTH: begin //10412
      MakeOpenHealth();
    end;
{$IF CHECKNEWMSG = 1}
    else begin
      MainOutMessage(format('人物: %s 消息: Ident %d Param %d P1 %d P2 %d P3 %d Msg %s',
                            [m_sCharName,
                            ProcessMsg.wIdent,
                            ProcessMsg.wParam,
                            ProcessMsg.nParam1,
                            ProcessMsg.nParam2,
                            ProcessMsg.nParam3,
                            ProcessMsg.sMsg]));
    end;
{$IFEND}    
  end;
except
  on e: Exception do begin
    MainOutMessage(sExceptionMsg);
    MainOutMessage(E.Message);
  end;
end;
end;
function TPlayObject.Operate(ProcessMsg: pTProcessMessage):Boolean;
var
  CharDesc:TCharDesc;
  nObjCount:integer;
  s1C:String;
  MessageBodyWL:TMessageBodyWL;
  MessageBodyW:TMessageBodyW;
  ShortMessage:TShortMessage;
  dwDelayTime:LongWord;
  nMsgCount:Integer;
  tmp2:Integer;
  LoverObject,Lover:TPlayObject;
begin
  Result:=True;
      case ProcessMsg.wIdent of
        CM_QUERYUSERNAME: begin //80
          ClientQueryUserName(TPlayObject(ProcessMsg.nParam1),ProcessMsg.nParam2,ProcessMsg.nParam3);//004D7931
        end;
        CM_QUERYBAGITEMS: begin //0x81
          ClientQueryBagItems();//004D793E
        end;
        CM_QUERYSTORAGEITEMS: begin
          ClientQueryStorageItems();
        end;
        CM_GETAUCTION: begin
          FrmDB.GetAuctionItems(ProcessMsg.nParam2,ProcessMsg.nParam3,DecodeString(ProcessMsg.sMsg),TPlayObject(ProcessMsg.nParam1));
        end;
        CM_BUYAUCTIONITEM: begin
          FrmDB.BuyAuctionItem(TPlayObject(ProcessMsg.nParam1),MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3));
        end;
        CM_GETGOLDITEM: begin
          FrmDB.EndOfAuction(TPlayObject(ProcessMsg.nParam1),MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3));
        end;

        CM_QUERYUSERSTATE: begin //82
          ClientQueryUserState(TPlayObject(ProcessMsg.nParam1),ProcessMsg.nParam2,ProcessMsg.nParam3);
        end;
        CM_DROPITEM: begin //1000
          if ClientDropItem(ProcessMsg.sMsg,ProcessMsg.nParam1,ProcessMsg.nParam2) then
            SendDefMessage(SM_DROPITEM_SUCCESS,ProcessMsg.nParam1,0,0,0,ProcessMsg.sMsg)
          else SendDefMessage(SM_DROPITEM_FAIL,ProcessMsg.nParam1,0,0,0,ProcessMsg.sMsg);
        end;
        CM_PICKUP: begin //1001  004D78F9
          if (m_nCurrX = ProcessMsg.nParam2) and (m_nCurrY = ProcessMsg.nParam3) then
            ClientPickUpItem();
        end;
        CM_OPENDOOR: begin //1002
          ClientOpenDoor(ProcessMsg.nParam2,ProcessMsg.nParam3);
        end;
        CM_TAKEONITEM: begin //1003
          ClientTakeOnItems(ProcessMsg.nParam2,ProcessMsg.nParam1,ProcessMsg.sMsg);
        end;
        CM_TAKEOFFITEM: begin //1004
          ClientTakeOffItems(ProcessMsg.nParam2,ProcessMsg.nParam1,ProcessMsg.sMsg);
        end;
        CM_EAT: begin //1006
          ClientUseItems(ProcessMsg.nParam1,ProcessMsg.sMsg);
        end;
        CM_BUTCH: begin //1007
          if not ClientGetButchItem(TBaseObject(ProcessMsg.nParam1),ProcessMsg.nParam2,ProcessMsg.nParam3,ProcessMsg.wParam,dwDelayTime) then begin
            if dwDelayTime <> 0 then begin
              nMsgCount:=GetDigUpMsgCount();
              if nMsgCount >= g_Config.nMaxDigUpMsgCount then begin
                Inc(m_nOverSpeedCount);
                if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
                  if g_Config.boKickOverSpeed then begin
                    SysMsg(g_sKickClientUserMsg,c_Red,t_Hint);
                    m_boEmergencyClose:=True;
                  end;
                  if g_Config.boViewHackMessage then begin
                   MainOutMessage(format(g_sBunOverSpeed,[m_sCharName,dwDelayTime,nMsgCount]));
                  end;
                end;
                SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
              end else begin
                if dwDelayTime < g_Config.dwDropOverSpeed then begin
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                  SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
                end else begin
                  SendDelayMsg(Self,ProcessMsg.wIdent,ProcessMsg.wParam,ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.nParam3,'',dwDelayTime);
                  Result:=False;
                end;
              end;
            end;
          end;
        end;
        CM_MAGICKEYCHANGE: begin //1008
          ClientChangeMagicKey(ProcessMsg.nParam1,ProcessMsg.nParam2);
        end;
        CM_SOFTCLOSE: begin //1009  004D79CB
        m_MyGuild:=g_GuildManager.MemberOfGuild(m_sCharName);
        if m_MyGuild <> nil then begin
          //send guild member has disconnected
          TGuild(m_MyGuild).SendGuildMsg(m_sCharName + ' has exited the game.');
          UserEngine.SendServerGroupMsg(SS_208,nServerIndex,TGuild(m_MyGuild).sGuildName + '/' + '' + '/' + m_sCharName + ' has exited the game.');
        end;

        if m_xLoveInfo.Lover <> '' then begin
          Lover:=UserEngine.GetPlayObject(m_xLoveInfo.Lover);
          if Lover <> nil then begin
            Lover.SysMsg(m_sCharName + ' has exited from the game.',c_Blue,t_hint);
          end;
        end;
          m_boReconnection:=True;
          m_boSoftClose:=True;
        end;
        CM_CLICKNPC: //1010  004D79E4
          ClientClickNPC(ProcessMsg.nParam1);
        CM_MERCHANTDLGSELECT: //1011
          ClientMerchantDlgSelect(ProcessMsg.nParam1,ProcessMsg.sMsg);
        CM_GEMINFO:
      //  mainoutmessage(processmsg.sMsg);
          GemInfo(ProcessMsg.nParam1,ProcessMsg.sMsg);
        CM_MERCHANTQUERYSELLPRICE: //1012
          ClientMerchantQuerySellPrice(ProcessMsg.nParam1,MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3),ProcessMsg.sMsg,ProcessMsg.wParam);
        CM_USERSELLITEM: //1013
          ClientUserSellItem(ProcessMsg.nParam1,MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3),ProcessMsg.sMsg, ProcessMsg.wParam);

        CM_USERBUYITEM:  //1014  004D7AD4
          ClientUserBuyItem(ProcessMsg.wIdent,ProcessMsg.nParam1,MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3),0,ProcessMsg.sMsg);

        CM_USERGETDETAILITEM:  //1015 004D7AB6
          ClientUserBuyItem(ProcessMsg.wIdent,ProcessMsg.nParam1,0,ProcessMsg.nParam2,ProcessMsg.sMsg);

        CM_DROPGOLD:  //1016  004D7AFC
          if ProcessMsg.nParam1 > 0 then ClientDropGold(ProcessMsg.nParam1);
          
        CM_1017: //1017
          SendDefMessage(1,0,0,0,0,'');

        CM_GROUPMODE: begin //1019
          if ProcessMsg.nParam2 = 0 then ClientGroupClose()
          else m_boAllowGroup:=True;
          if m_boAllowGroup then SendDefMessage(SM_GROUPMODECHANGED,0,1,0,0,'')
          else SendDefMessage(SM_GROUPMODECHANGED,0,0,0,0,'');
        end;
        CM_CREATEGROUP: begin //1020
          ClientCreateGroup(Trim(ProcessMsg.sMsg));
        end;
        CM_ADDGROUPMEMBER: begin //1021
          ClientAddGroupMember(Trim(ProcessMsg.sMsg));
        end;
        CM_DELGROUPMEMBER: begin //1022
          ClientDelGroupMember(Trim(ProcessMsg.sMsg));
        end;
        CM_USERREPAIRITEM: begin //1023 004D7A70
          ClientRepairItem(ProcessMsg.nParam1,MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3),ProcessMsg.sMsg);
        end;
        CM_TRADEGT : begin
          ClientTradeGT(ProcessMsg.nParam1);
        end;
        CM_MERCHANTQUERYREPAIRCOST: begin //1024 004D7A2A
          ClientQueryRepairCost(ProcessMsg.nParam1,MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3),ProcessMsg.sMsg);
        end;
        CM_DEALTRY: begin //1025
          ClientDealTry(Trim(ProcessMsg.sMsg));
        end;
        CM_DEALADDITEM: begin //1026
          ClientAddDealItem(ProcessMsg.nParam1,ProcessMsg.sMsg,ProcessMsg.nParam2);
        end;
        CM_DEALDELITEM: begin //1027
          ClientDelDealItem(ProcessMsg.nParam1,ProcessMsg.sMsg);
        end;
        CM_DEALCANCEL: begin //1028
          ClientCancelDeal();
        end;
        CM_DEALCHGGOLD: begin //1029
          ClientChangeDealGold(ProcessMsg.nParam1);
        end;
        CM_DEALEND: begin //1030
          ClientDealEnd();
        end;

        CM_REFINECANCEL: begin //1053
          ClientCancelRefine();
        end;

        CM_USERSTORAGEITEM: begin  //1031
          ClientStorageItem(TObject(ProcessMsg.nParam1),MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3),ProcessMsg.sMsg, ProcessMsg.wParam);
        end;
        CM_USERTAKEBACKSTORAGEITEM: begin //1032
          ClientTakeBackStorageItem(TObject(ProcessMsg.nParam1),MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3),ProcessMsg.sMsg);
        end;
        CM_CONSIGNITEM: begin  //10311
          ConsignItem(TObject(ProcessMsg.nParam1),MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3),DecodeString(ProcessMsg.sMsg));
        end;
        CM_USERMAKEDRUGITEM: begin //1034
          ClientMakeDrugItem(TObject(ProcessMsg.nParam1),ProcessMsg.sMsg);
        end;
        CM_OPENGUILDDLG: begin //1035
          ClientOpenGuildDlg();
        end;
        CM_GUILDHOME: begin //1036
          ClientGuildHome();
        end;
        CM_GUILDMEMBERLIST: begin
          ClientGuildMemberList();
        end;
        CM_GUILDADDMEMBER: begin
          ClientGuildAddMember(ProcessMsg.sMsg);
        end;
        CM_GUILDDELMEMBER: begin
          ClientGuildDelMember(ProcessMsg.sMsg);
        end;
        CM_GUILDUPDATENOTICE: begin
          ClientGuildUpdateNotice(ProcessMsg.sMsg);
        end;
        CM_GUILDUPDATERANKINFO: begin //1041
          ClientGuildUpdateRankInfo(ProcessMsg.sMsg);
        end;
        CM_1042: begin
          MainOutMessage('[非法数据] ' + m_sCharName);
        end;
        CM_ADJUST_BONUS: begin
          ClientAdjustBonus(ProcessMsg.nParam1,ProcessMsg.sMsg);
        end;
        CM_ADDBADFRIEND: begin
          ClientReqAddFriend(ProcessMsg.sMsg, 1);
        end;
        CM_ADDFRIEND: begin
          ClientReqAddFriend(ProcessMsg.sMsg, 0);
        end;
        CM_DELFRIEND: begin
          ClientReqDelFriend(ProcessMsg.sMsg);
        end;
        CM_UPDATEMEMOFRIEND: begin
           ClientUpdateMemoFriend(ProcessMsg.sMsg);
        end;
        CM_REQMEMOFRIEND: begin
           ClientReqMemoFriend(ProcessMsg.sMsg);
        end;

        CM_REQUESTMAILLIST: Begin
          ClientRequestMailList(ProcessMsg);
        end;
        CM_SENDMAIL: Begin
          ClientSendMail(ProcessMsg);
        end;
        CM_READMAIL: Begin
          ClientReadMail(ProcessMsg);
        end;
        CM_DELETEMAIL: Begin
          ClientDeleteMail(ProcessMsg);
        end;
        CM_SETMAILSTATUS: Begin
          ClientSetMailStatus(ProcessMsg);
        end;
        CM_REQUESTBLOCKLIST: Begin
          ClientRequestBlockList(ProcessMsg);
        end;
        CM_ADDBLOCK: Begin
          ClientAddBlock(ProcessMsg);
        end;
        CM_DELBLOCK: Begin
          ClientDelBlock(ProcessMsg);
        end;
        CM_OPENLOVERWINDOW: Begin
          OpenLoverWindow;
        end;
        CM_OPENGAMESHOP: Begin
          ClientRequestGameShopList;
        end;
        CM_CHANGEAVAILABILITY: Begin
          ChangeAvailability;
        end;
        CM_ASKRELAY: Begin
          if m_xLoveInfo.Lover <> '' then begin
            SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'You are already in a relationship.');
            exit;
          end else begin
            LoverObject:=PlayGetPoseCreate();
            if LoverObject <> nil then begin
              if m_xLoveInfo.Lover <> '' then begin
                SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'Player is already in a relationship');
                exit;
              end else begin
                LoverObject.SendRequestRelay(m_sCharName);
              end;
            end;
          end;
        end;
        CM_REQUESTRELAYOK: Begin
          LoverObject:=PlayGetPoseCreate();
            if LoverObject <> nil then LoverObject.RequestRelay;
        end;
        CM_REQUESTRELAYFAIL: Begin
          LoverObject:=PlayGetPoseCreate();
          if LoverObject <> nil then begin
          LoverObject.SendRequestFail(ProcessMsg.sMsg);
          end;
        end;
        CM_ASKDIVORCE: Begin
          RequestDivorce;
        end;
        CM_GEMSYSTEM: begin
          CreateGem(DecodeString(ProcessMsg.sMsg));
        end;
        CM_GUILDALLY: begin  //1044
          ClientGuildAlly();
        end;
        CM_GUILDBREAKALLY: begin //1045
          ClientGuildBreakAlly(ProcessMsg.sMsg);
        end;
        CM_REQUESTGTLIST: begin
          if (gettickcount - m_dwBBSDelayTime) > 1000 then begin
            m_dwBBSDelayTime := gettickcount();
            ClientRequestGTList(ProcessMsg);
          end;
        end;
        CM_REQUESTDECOLIST: begin
          ClientRequestDecoList(ProcessMsg);
        end;
        CM_BUYGT: begin
          //ClientBuyGT(ProcessMsg);
        end;
        CM_BUYDECOITEM: begin
          ClientBuyDecoItem(ProcessMsg);
        end;
        CM_BBSLIST: begin
          if (gettickcount - m_dwBBSDelayTime) > 1000 then begin
            m_dwBBSDelayTime := gettickcount();
            ClientRequestBBSList(ProcessMsg);
          end;
        end;
        CM_BBSMSG: begin
          if (gettickcount - m_dwBBSDelayTime) > 1000 then begin
            m_dwBBSDelayTime := gettickcount();
            ClientRequestBBSMsg(ProcessMsg);
          end;
        end;
        CM_BBSPOST: begin
          if (gettickcount - m_dwBBSPostDelay) > 30000 then begin
            m_dwBBSPostDelay := gettickcount();
            ClientPostBBSMsg(ProcessMsg,ProcessMsg.sMsg);
          end else
            SysMsg('you have to wait 30 seconds between posting messages',c_Red,t_Hint);
        end;
        CM_BBSDELETE: begin
          if (gettickcount - m_dwBBSPostDelay) > 30000 then begin
            m_dwBBSPostDelay := gettickcount();
            ClientDeleteBBSMsg(ProcessMsg);
          end else
            SysMsg('you have to wait 30 seconds between deleting messages',c_Red,t_Hint);
        end;
{$IF CHECKNEWMSG = 1}
        CM_1046: begin
          MainOutMessage(format('%s/%d/%d/%d/%d/%d/%s',
                               [m_sCharName,
                                ProcessMsg.wIdent,
                                ProcessMsg.wParam,
                                ProcessMsg.nParam1,
                                ProcessMsg.nParam2,
                                ProcessMsg.nParam3,
                                DecodeString(ProcessMsg.sMsg)]));
        end;
        CM_1056: begin
          MainOutMessage(format('%s/%d/%d/%d/%d/%d/%s',
                               [m_sCharName,
                                ProcessMsg.wIdent,
                                ProcessMsg.wParam,
                                ProcessMsg.nParam1,
                                ProcessMsg.nParam2,
                                ProcessMsg.nParam3,
                                DecodeString(ProcessMsg.sMsg)]));
        end;
{$IFEND}
        CM_TURN: begin //3010    004D73DD
          if ClientChangeDir(ProcessMsg.wIdent,ProcessMsg.nParam1{x},ProcessMsg.nParam2{y},ProcessMsg.wParam{dir},dwDelayTime) then begin
            m_dwActionTick:=GetTickCount;
            SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
          end else begin
            if dwDelayTime = 0 then begin
              SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount))
            end else begin
              nMsgCount:=GetTurnMsgCount();
              if nMsgCount >= g_Config.nMaxTurnMsgCount then begin
                Inc(m_nOverSpeedCount);
                if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
                  if g_Config.boKickOverSpeed then begin
                    SysMsg(g_sKickClientUserMsg,c_Red,t_Hint);
                    m_boEmergencyClose:=True;
                  end;
                  if g_Config.boViewHackMessage then begin
                    MainOutMessage(format(g_sBunOverSpeed,[m_sCharName,dwDelayTime,nMsgCount]));
                  end;
                end;
                SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
              end else begin
                if dwDelayTime < g_Config.dwDropOverSpeed then begin
                  SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                end else begin
                  SendDelayMsg(Self,ProcessMsg.wIdent,ProcessMsg.wParam,ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.nParam3,'',dwDelayTime);
                  Result:=False;
                end;
              end;
            end;
          end;
        end;
        CM_WALK: begin //3011
          if ClientWalkXY(ProcessMsg.wIdent,ProcessMsg.nParam1{x},ProcessMsg.nParam2{y},ProcessMsg.boLateDelivery,dwDelayTime) then begin
            m_dwActionTick:=GetTickCount;
            SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
            Inc(n5F8);
          end else begin
            if dwDelayTime = 0 then begin
              SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount))
            end else begin
              nMsgCount:=GetWalkMsgCount();
              if nMsgCount >= g_Config.nMaxWalkMsgCount then begin
                Inc(m_nOverSpeedCount);
                if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
                  if g_Config.boKickOverSpeed then begin
                    SysMsg(g_sKickClientUserMsg,c_Red,t_Hint);
                    m_boEmergencyClose:=True;
                  end;
                  if g_Config.boViewHackMessage then begin
                   MainOutMessage(format(g_sWalkOverSpeed,[m_sCharName,dwDelayTime,nMsgCount]));
                  end;
                end;
                SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
                if m_boTestSpeedMode then
                  SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
              end else begin
                if (dwDelayTime > g_Config.dwDropOverSpeed) and (g_Config.btSpeedControlMode = 1) and  m_boFilterAction then begin
                  SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                end else begin

                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                  SendDelayMsg(Self,ProcessMsg.wIdent,ProcessMsg.wParam,ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.nParam3,'',dwDelayTime);
                  Result:=False;
                end;
              end;
            end;
          end;
        end;
          
        CM_HORSERUN: begin //3009
          if ClientHorseRunXY(ProcessMsg.wIdent,ProcessMsg.nParam1{x},ProcessMsg.nParam2{y},ProcessMsg.boLateDelivery,dwDelayTime) then begin
            m_dwActionTick:=GetTickCount;
            SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
            Inc(n5F8);
          end else begin

            if dwDelayTime = 0 then begin
              SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
            end else begin
              nMsgCount:=GetRunMsgCount();
              if nMsgCount >= g_Config.nMaxRunMsgCount then begin
                Inc(m_nOverSpeedCount);
                if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
                  if g_Config.boKickOverSpeed then begin
                    SysMsg(g_sKickClientUserMsg,c_Red,t_Hint);
                    m_boEmergencyClose:=True;
                  end;
                  if g_Config.boViewHackMessage then begin
                    MainOutMessage(format(g_sRunOverSpeed,[m_sCharName,dwDelayTime,nMsgCount]));
                  end;

                end;
                SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
                if m_boTestSpeedMode then
                  SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
              end else begin
                if m_boTestSpeedMode then
                  SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                SendDelayMsg(Self,ProcessMsg.wIdent,ProcessMsg.wParam,ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.nParam3,'',dwDelayTime);
                Result:=False;
              end;
            end;

          end;
        end;
        CM_RUN: begin //3013
          if ClientRunXY(ProcessMsg.wIdent,ProcessMsg.nParam1{x},ProcessMsg.nParam2{y},ProcessMsg.nParam3,dwDelayTime) then begin
            m_dwActionTick:=GetTickCount;
            SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
            Inc(n5F8);
          end else begin
            if dwDelayTime = 0 then begin
              SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
            end else begin
              nMsgCount:=GetRunMsgCount();
              if nMsgCount >= g_Config.nMaxRunMsgCount then begin
                Inc(m_nOverSpeedCount);
                if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
                  if g_Config.boKickOverSpeed then begin
                    SysMsg(g_sKickClientUserMsg,c_Red,t_Hint);
                    m_boEmergencyClose:=True;
                  end;
                  if g_Config.boViewHackMessage then begin
                    MainOutMessage(format(g_sRunOverSpeed,[m_sCharName,dwDelayTime,nMsgCount]));
                  end;
                end;
                SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
              end else begin
                if (dwDelayTime > g_Config.dwDropOverSpeed) and (g_Config.btSpeedControlMode = 1) and  m_boFilterAction then begin
                  SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                end else begin
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                  SendDelayMsg(Self,ProcessMsg.wIdent,ProcessMsg.wParam,ProcessMsg.nParam1,ProcessMsg.nParam2,CM_RUN,'',dwDelayTime);
                  Result:=False;
                end;
              end;
            end;

          end;
        end;
        CM_HIT, //3014
        CM_HEAVYHIT,//3015
        CM_BIGHIT, //3016
        CM_POWERHIT, //3018
        CM_LONGHIT, //3019
        CM_WIDEHIT, //3024
        CM_CRSHIT,
        CM_TWINHIT,
        CM_FIREHIT: begin //3025  :004D75BC
          if ClientHitXY(ProcessMsg.wIdent{ident},ProcessMsg.nParam1{x},ProcessMsg.nParam2{y},ProcessMsg.wParam{dir},ProcessMsg.boLateDelivery,dwDelayTime) then begin
            m_dwActionTick:=GetTickCount;
            SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
            Inc(n5F8);
          end else begin
            if dwDelayTime = 0 then begin
              SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
            end else begin
              nMsgCount:=GetHitMsgCount();
              if nMsgCount >= g_Config.nMaxHitMsgCount then begin
                Inc(m_nOverSpeedCount);
                if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
                  if g_Config.boKickOverSpeed then begin
                    SysMsg(g_sKickClientUserMsg,c_Red,t_Hint);
                    m_boEmergencyClose:=True;
                  end;
                  if g_Config.boViewHackMessage then begin
                    MainOutMessage(format(g_sHitOverSpeed,[m_sCharName,dwDelayTime,nMsgCount]));
                  end;
                end;
                SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
              end else begin
                if (dwDelayTime > g_Config.dwDropOverSpeed) and (g_Config.btSpeedControlMode = 1) and  m_boFilterAction then begin
                  SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                end else begin
                  if m_boTestSpeedMode then begin
                     SysMsg('testspeedmode Ident: ' + IntToStr(ProcessMsg.wIdent) + ' Time: ' + IntToStr(dwDelayTime),c_Red,t_Hint);
                  end;
                  SendDelayMsg(Self,ProcessMsg.wIdent,ProcessMsg.wParam,ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.nParam3,'',dwDelayTime);
                  Result:=False;
                end;
              end;
            end;
          end;
        end;
        CM_SITDOWN: begin //3012
          if ClientSitDownHit(ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam,dwDelayTime) then begin
            m_dwActionTick:=GetTickCount();
            SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
          end else begin
            if dwDelayTime = 0 then begin
              SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
            end else begin
              nMsgCount:=GetSiteDownMsgCount();
              if nMsgCount >= g_Config.nMaxSitDonwMsgCount then begin
                Inc(m_nOverSpeedCount);
                if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
                  if g_Config.boKickOverSpeed then begin
                    SysMsg(g_sKickClientUserMsg,c_Red,t_Hint);
                    m_boEmergencyClose:=True;
                  end;
                  if g_Config.boViewHackMessage then begin
                    MainOutMessage(format(g_sBunOverSpeed,[m_sCharName,dwDelayTime,nMsgCount]));
                  end;
                end;
                SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
              end else begin
                if dwDelayTime < g_Config.dwDropOverSpeed then begin
                  SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                end else begin
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                  SendDelayMsg(Self,ProcessMsg.wIdent,ProcessMsg.wParam,ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.nParam3,'',dwDelayTime);
                  Result:=False;
                end;
              end;
            end;
          end;
        end;
        CM_SPELL: begin //3017  004D76FD
          if ClientSpellXY(ProcessMsg.wIdent,ProcessMsg.wParam,ProcessMsg.nParam1,ProcessMsg.nParam2,TBaseObject(ProcessMsg.nParam3),ProcessMsg.boLateDelivery,dwDelayTime) then begin
            m_dwActionTick:=GetTickCount;
            SendSocket(nil,sSTATUS_GOOD + IntToStr(GetTickCount));
            Inc(n5F8);
          end else begin
            if dwDelayTime = 0 then begin
              SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
            end else begin
              nMsgCount:=GetSpellMsgCount();
              if nMsgCount >= g_Config.nMaxSpellMsgCount then begin
                Inc(m_nOverSpeedCount);
                if m_nOverSpeedCount > g_Config.nOverSpeedKickCount then begin
                  if g_Config.boKickOverSpeed then begin
                    SysMsg(g_sKickClientUserMsg,c_Red,t_Hint);
                    m_boEmergencyClose:=True;
                  end;
                  if g_Config.boViewHackMessage then begin
                    MainOutMessage(format(g_sSpellOverSpeed,[m_sCharName,dwDelayTime,nMsgCount]));
                  end;
                end;
                SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
              end else begin
                if (dwDelayTime > g_Config.dwDropOverSpeed) and (g_Config.btSpeedControlMode = 1) and  m_boFilterAction then begin
                  SendSocket(nil,sSTATUS_FAIL + IntToStr(GetTickCount));
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                end else begin
                  if m_boTestSpeedMode then
                     SysMsg(format('testspeedmode Ident: %d Time: %d',[ProcessMsg.wIdent,dwDelayTime]),c_Red,t_Hint);
                  SendDelayMsg(Self,ProcessMsg.wIdent,ProcessMsg.wParam,ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.nParam3,'',dwDelayTime);
                  Result:=False;
                end;
              end;
            end;
          end;
        end;


        CM_SAY: begin //3030
          if ProcessMsg.sMsg <> '' then begin
            ProcessUserLineMsg(ProcessMsg.sMsg);
          end;
        end;
        CM_PASSWORD: begin
          ProcessClientPassword(ProcessMsg);
        end;
        CM_GEMITEM:begin
        tmp2:=MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3);
        GemItem(ProcessMsg.nParam1,tmp2);
        end;
        CM_REPAIRITEM:begin
        tmp2:=MakeLong(ProcessMsg.nParam2,ProcessMsg.nParam3);
        ItemRepair(ProcessMsg.nParam1,tmp2);
        end;
        RM_WALK: begin //10002
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_WALK,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,MakeWord(ProcessMsg.wParam, TBaseObject(ProcessMsg.BaseObject).m_nLight));
            CharDesc.feature:=TBaseObject(ProcessMsg.BaseObject).GetFeature(TBaseObject(ProcessMsg.BaseObject));
            CharDesc.Status:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
            SendSocket(@m_DefMsg,EncodeBuffer(@CharDesc,SizeOf(TCharDesc)));
          end;
        end;
        RM_HORSERUN: begin//10003 004D860A
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_HORSERUN,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,MakeWord(ProcessMsg.wParam, TBaseObject(ProcessMsg.BaseObject).m_nLight));
            CharDesc.feature:=TBaseObject(ProcessMsg.BaseObject).GetFeature(TBaseObject(ProcessMsg.BaseObject));
            CharDesc.Status:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
            SendSocket(@m_DefMsg,EncodeBuffer(@CharDesc,SizeOf(TCharDesc)));
          end;
        end;
        RM_RUN: begin//10003 004D860A
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_RUN,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,MakeWord(ProcessMsg.wParam, TBaseObject(ProcessMsg.BaseObject).m_nLight));
            CharDesc.feature:=TBaseObject(ProcessMsg.BaseObject).GetFeature(TBaseObject(ProcessMsg.BaseObject));
            CharDesc.Status:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
            SendSocket(@m_DefMsg,EncodeBuffer(@CharDesc,SizeOf(TCharDesc)));
          end;
        end;
        RM_HIT: begin //10004 004D871D
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_HIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;
        end;
        RM_81: begin //10054
          if TBaseObject(ProcessMsg.nParam3) <> nil then begin
            MessageBodyW.Param1:=TBaseObject(ProcessMsg.nParam3).m_nCurrX;
            MessageBodyW.Param2:=TBaseObject(ProcessMsg.nParam3).m_nCurrY;
            MessageBodyW.Tag1:=LoWord(ProcessMsg.nParam3);
            MessageBodyW.Tag2:=HiWord(ProcessMsg.nParam3);
            m_DefMsg:=MakeDefaultMsg(SM_81,
                                     Integer(ProcessMsg.BaseObject),
                                     ProcessMsg.nParam1,
                                     ProcessMsg.nParam2,
                                     ProcessMsg.wParam);
            SendSocket(@m_DefMsg,EncodeBuffer(@MessageBodyW,SizeOf(TMessageBodyW)));
          end;
        end;
        RM_82: begin //10055
         if TBaseObject(ProcessMsg.nParam3) <> nil then begin
            MessageBodyW.Param1:=TBaseObject(ProcessMsg.nParam3).m_nCurrX;
            MessageBodyW.Param2:=TBaseObject(ProcessMsg.nParam3).m_nCurrY;
            MessageBodyW.Tag1:=LoWord(ProcessMsg.nParam3);
            MessageBodyW.Tag2:=HiWord(ProcessMsg.nParam3);
            m_DefMsg:=MakeDefaultMsg(SM_82,
                                     Integer(ProcessMsg.BaseObject),
                                     ProcessMsg.nParam1,
                                     ProcessMsg.nParam2,
                                     ProcessMsg.wParam);
            SendSocket(@m_DefMsg,EncodeBuffer(@MessageBodyW,SizeOf(TMessageBodyW)));
          end;
        end;
        RM_83: begin //10056
          if TBaseObject(ProcessMsg.nParam3) <> nil then begin
            MessageBodyW.Param1:=TBaseObject(ProcessMsg.nParam3).m_nCurrX;
            MessageBodyW.Param2:=TBaseObject(ProcessMsg.nParam3).m_nCurrY;
            MessageBodyW.Tag1:=LoWord(ProcessMsg.nParam3);
            MessageBodyW.Tag2:=HiWord(ProcessMsg.nParam3);
            m_DefMsg:=MakeDefaultMsg(SM_83,
                                     Integer(ProcessMsg.BaseObject),
                                     ProcessMsg.nParam1,
                                     ProcessMsg.nParam2,
                                     ProcessMsg.wParam);
            SendSocket(@m_DefMsg,EncodeBuffer(@MessageBodyW,SizeOf(TMessageBodyW)));
          end;
        end;

        RM_HEAVYHIT: begin
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_HEAVYHIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,ProcessMsg.sMsg);
          end;
        end;
        RM_READYFIREHIT: begin
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_READYFIREHIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,ProcessMsg.sMsg);
          end;
        end;
        RM_BIGHIT: begin//004D893A
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_BIGHIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;
        end;
        RM_SPELL: begin // 10007 004D8A12
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_SPELL,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,IntToStr(ProcessMsg.nParam3));
          end;
        end;
        RM_SPELL2: begin //10008 004D8789
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_POWERHIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;
        end;
        {
        RM_POWERHIT: begin

        end;
        }
        RM_MOVEFAIL: begin //10010 004D8289
          m_DefMsg:=MakeDefaultMsg(SM_MOVEFAIL,Integer(Self),m_nCurrX,m_nCurrY,m_btDirection);
          CharDesc.feature:=TBaseObject(ProcessMsg.BaseObject).GetFeatureToLong;
          CharDesc.Status:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
          SendSocket(@m_DefMsg,EncodeBuffer(@CharDesc,SizeOf(CharDesc)));
        end;
        RM_LONGHIT: begin //10011 004D87F5
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_LONGHIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;
        end;
        RM_WIDEHIT: begin//10012 004D8861
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_WIDEHIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;
        end;
        RM_FIREHIT: begin //10014 004D89A6
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_FIREHIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;
        end;
        RM_CRSHIT: begin //10014 004D89A6
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_CRSHIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;
        end;
        RM_41: begin //10014 004D89A6
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_41,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;
        end;
        RM_TWINHIT: begin //10014 004D89A6
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_TWINHIT,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;
        end;
      {  RM_43: begin //10014 004D89A6
          if TBaseObject(ProcessMsg.BaseObject) <> Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_43,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end; }
        RM_TURN,
        RM_PUSH,
        RM_RUSH,
        RM_RUSHKUNG: begin//004D831D
          if (TBaseObject(ProcessMsg.BaseObject) <> Self) or (ProcessMsg.wIdent = RM_PUSH) or (ProcessMsg.wIdent = RM_RUSH) or (ProcessMsg.wIdent = RM_RUSHKUNG) then begin
            case ProcessMsg.wIdent of
              RM_PUSH://004D835F
                m_DefMsg:=MakeDefaultMsg(SM_BACKSTEP,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1{x},ProcessMsg.nParam2{y},MakeWord(ProcessMsg.wParam{dir}, TBaseObject(ProcessMsg.BaseObject).m_nLight{light}));
              RM_RUSH://004D83B9
                m_DefMsg:=MakeDefaultMsg(SM_RUSH,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,MakeWord(ProcessMsg.wParam, TBaseObject(ProcessMsg.BaseObject).m_nLight));
              RM_RUSHKUNG://004D8413
                m_DefMsg:=MakeDefaultMsg(SM_RUSHKUNG,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,MakeWord(ProcessMsg.wParam, TBaseObject(ProcessMsg.BaseObject).m_nLight));
              else begin //004D846A
                m_DefMsg:=MakeDefaultMsg(SM_TURN,Integer(ProcessMsg.BaseObject),ProcessMsg.nParam1,ProcessMsg.nParam2,MakeWord(ProcessMsg.wParam, TBaseObject(ProcessMsg.BaseObject).m_nLight));
              end;
            end;
            CharDesc.feature:=TBaseObject(ProcessMsg.BaseObject).GetFeature(TBaseObject(ProcessMsg.BaseObject));
            CharDesc.Status:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
            s1C:=EncodeBuffer(@CharDesc,SizeOf(CharDesc));
            nObjCount:=GetCharColor(TBaseObject(ProcessMsg.BaseObject));
            if ProcessMsg.sMsg <> '' then
              s1C:=s1C + ( EncodeString(ProcessMsg.sMsg + '/' + IntToStr(nObjCount)));
            SendSocket(@m_DefMsg,s1C);
            if ProcessMsg.wIdent = RM_TURN then begin
              nObjCount:=TBaseObject(ProcessMsg.BaseObject).GetFeatureToLong();
              SendDefMessage(SM_FEATURECHANGED,
                             Integer(ProcessMsg.BaseObject),
                             LoWord(nObjCount),
                             HiWord(nObjCount),
                             TBaseObject(ProcessMsg.BaseObject).GetFeatureEx,
                             '');
            end;
          end;
        end;
        RM_STRUCK,
        RM_STRUCK_MAG: begin //10020 004D8B28
          if ProcessMsg.wParam{nPower} > 0 then begin
            if ProcessMsg.BaseObject = Self then begin
              if TBaseObject(ProcessMsg.nParam3){AttackBaseObject} <> nil then begin
                if TBaseObject(ProcessMsg.nParam3).m_btRaceServer = RC_PLAYOBJECT then begin
                  SetPKFlag(TBaseObject(ProcessMsg.nParam3){AttackBaseObject});
                end;
                SetLastHiter(TBaseObject(ProcessMsg.nParam3){AttackBaseObject});
                {
                //反复活
                if TBaseObject(ProcessMsg.nParam3).m_boUnRevival then
                  m_boRevival:=False;
                }
              end; //004D8B67
              if PKLevel >= 2 then m_dw5D4:=GetTickCount();
              //if UserCastle.IsMasterGuild(TGuild(m_MyGuild)) and (TBaseObject(ProcessMsg.nParam3) <> nil) then begin
              if (g_CastleManager.IsCastleMember(Self) <> nil) and (TBaseObject(ProcessMsg.nParam3) <> nil) then begin
                TBaseObject(ProcessMsg.nParam3).bo2B0:=True;
                TBaseObject(ProcessMsg.nParam3).m_dw2B4Tick:=GetTickCount();
              end;
              m_nHealthTick:=0;
              m_nSpellTick:=0;
              Dec(m_nPerHealth);
              Dec(m_nPerSpell);
              m_dwStruckTick:=GetTickCount();//09/10
            end; //4D8BE1
            if ProcessMsg.BaseObject <> nil then begin
              if ((ProcessMsg.BaseObject = Self) and (g_Config.boDisableSelfStruck)) or ((TBaseObject(ProcessMsg.BaseObject).m_btRaceServer = RC_PLAYOBJECT) and g_Config.boDisableStruck) then begin
                TBaseObject(ProcessMsg.BaseObject).SendRefMsg(RM_HEALTHSPELLCHANGED,0,0,0,0,'');
              end else begin
              m_DefMsg:=MakeDefaultMsg(SM_STRUCK,
                                       Integer(ProcessMsg.BaseObject),
                                       TBaseObject(ProcessMsg.BaseObject).m_WAbil.HP,
                                       TBaseObject(ProcessMsg.BaseObject).m_WAbil.MaxHP,
                                       ProcessMsg.wParam);
              MessageBodyWL.lParam1:=TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
              MessageBodyWL.lParam2:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
              MessageBodyWL.lTag1:=ProcessMsg.nParam3;
              if ProcessMsg.wIdent = RM_STRUCK_MAG then MessageBodyWL.lTag2:=1
              else MessageBodyWL.lTag2:=0;
              SendSocket(@m_DefMsg,EncodeBuffer(@MessageBodyWL,SizeOf(TMessageBodyWL)));
              end;
            end;
          end;
        end;
        RM_DEATH: begin //10021 004D8C9D
          if ProcessMsg.nParam3 = 1 then begin
              m_DefMsg:=MakeDefaultMsg(SM_NOWDEATH,
                                       Integer(ProcessMsg.BaseObject),
                                       ProcessMsg.nParam1,
                                       ProcessMsg.nParam2,
                                       ProcessMsg.wParam);

          if (ProcessMsg.BaseObject = Self) then begin
            if (g_FunctionNPC <> nil) then
              g_FunctionNPC.GotoLable(Self,'@OnDeath',False);
          end;

          end else begin
              m_DefMsg:=MakeDefaultMsg(SM_DEATH,
                                       Integer(ProcessMsg.BaseObject),
                                       ProcessMsg.nParam1,
                                       ProcessMsg.nParam2,
                                       ProcessMsg.wParam);
          end;
          CharDesc.feature:=TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
          CharDesc.Status:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
          SendSocket(@m_DefMsg,EncodeBuffer(@CharDesc,SizeOf(TCharDesc)));
        end;
        RM_DISAPPEAR: begin //10022 004D915C
          m_DefMsg:=MakeDefaultMsg(SM_DISAPPEAR,
                                   Integer(ProcessMsg.BaseObject),
                                   0,0,0);
          SendSocket(@m_DefMsg,'');
        end;
        RM_SKELETON: begin //10024 004D8D7B
              m_DefMsg:=MakeDefaultMsg(SM_SKELETON,
                                       Integer(ProcessMsg.BaseObject),
                                       ProcessMsg.nParam1,
                                       ProcessMsg.nParam2,
                                       ProcessMsg.wParam);
          CharDesc.feature:=TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
          CharDesc.Status:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
          SendSocket(@m_DefMsg,EncodeBuffer(@CharDesc,SizeOf(TCharDesc)));
        end;
        RM_USERNAME: begin //10043 004D9587
          m_DefMsg:=MakeDefaultMsg(SM_USERNAME,
                                   Integer(ProcessMsg.BaseObject),
                                   GetCharColor(TBaseObject(ProcessMsg.BaseObject)),0,0);
          SendSocket(@m_DefMsg,EncodeString(ProcessMsg.sMsg));
        end;

        RM_WINEXP: begin //10044 004D95FE
          m_DefMsg:=MakeDefaultMsg(SM_WINEXP,m_Abil.Exp,LoWord(ProcessMsg.nParam1),HiWord(ProcessMsg.nParam1),0);
          SendSocket(@m_DefMsg,'');
        end;
        RM_LEVELUP: begin
          nObjCount := Integer(ProcessMsg.BaseObject);

          m_DefMsg:=MakeDefaultMsg(SM_LEVELUP,m_Abil.Exp,m_Abil.Level,LoWord(nObjCount),HiWord(nObjCount));
          SendSocket(@m_DefMsg,'');

          if ProcessMsg.BaseObject = Self then begin
            m_DefMsg:=MakeDefaultMsg(SM_ABILITY,m_nGold,MakeWord(m_btJob,99),LoWord(m_nGameGold),HiWord(m_nGameGold));
            //0806
            SendSocket(@m_DefMsg,EncodeBuffer(@m_WAbil,SizeOf(TAbility)));

            //SendSocket(@m_DefMsg,EncodeBuffer(@m_WAbil,SizeOf(TAbility)));
            SendDefMessage(SM_SUBABILITY,
                         MakeLong(MakeWord(m_nAntiMagic,0),0),
                         MakeWord(m_btHitPoint,m_btSpeedPoint),
                         MakeWord(m_btAntiPoison,m_nPoisonRecover),
                         MakeWord(m_nHealthRecover,m_nSpellRecover),
                         '');
          end;
        end;
        RM_CHANGENAMECOLOR: begin //10046 004D9555
          SendDefMessage(SM_CHANGENAMECOLOR,
                         Integer(ProcessMsg.BaseObject),
                         GetCharColor(TBaseObject(ProcessMsg.BaseObject)),
                         0,
                         0,
                         '');
        end;
        RM_LOGON: begin //10050
          m_DefMsg:=MakeDefaultMsg(SM_NEWMAP,Integer(Self),m_nCurrX,m_nCurrY,DayBright());
          SendSocket(@m_DefMsg,EncodeString(m_sMapName));
          SendMsg(Self,RM_CHANGELIGHT,0,0,0,0,'');
          SendLogon();
          SendServerConfig();
          ClientQueryUserName(Self,m_nCurrX,m_nCurrY);
          RefUserState();
          SendMapDescription();
          SendGoldInfo(True);
          //SendDefMessage(SM_GAMEGOLDNAME,m_nGameGold,LoWord(m_nGamePoint),HiWord(m_nGamePoint),0,g_Config.sGameGoldName + #13 + g_Config.sGamePointName);

          m_DefMsg:=MakeDefaultMsg(SM_VERSION_FAIL,g_Config.nClientFile1_CRC,LoWord(g_Config.nClientFile2_CRC),HiWord(g_Config.nClientFile2_CRC),0);
          SendSocket(@m_DefMsg,EncodeBuffer(@g_Config.nClientFile3_CRC,SizeOf(Integer)));
        end;
        RM_HEAR,
        RM_WHISPER,
        RM_CRY,
        RM_SYSMESSAGE,
        RM_GROUPMESSAGE,
        RM_SYSMESSAGE2,
        RM_GUILDMESSAGE,
        RM_SYSMESSAGE3,
        RM_MERCHANTSAY: begin
          {
          case ProcessMsg.wIdent of    //004D97B3
            RM_HEAR: m_DefMsg:=MakeDefaultMsg(SM_HEAR,Integer(ProcessMsg.BaseObject),MakeWord($0,$FF),0,1);//10030
//            RM_WHISPER: m_DefMsg:=MakeDefaultMsg(SM_WHISPER,Integer(ProcessMsg.BaseObject),MakeWord($FC,$FF),0,1);//10031
            RM_WHISPER: m_DefMsg:=MakeDefaultMsg(SM_WHISPER,Integer(ProcessMsg.BaseObject),MakeWord($FF,$38),0,1);//10031
            RM_CRY: m_DefMsg:=MakeDefaultMsg(SM_HEAR,Integer(ProcessMsg.BaseObject),MakeWord($0,$97),0,1);//10032
            RM_SYSMESSAGE: m_DefMsg:=MakeDefaultMsg(SM_SYSMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord($FF,$38),0,1);//10100 红色
            RM_GROUPMESSAGE: m_DefMsg:=MakeDefaultMsg(SM_SYSMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord($C4,$FF),0,1);//10102
            RM_SYSMESSAGE2: m_DefMsg:=MakeDefaultMsg(SM_SYSMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord($DB,$FF),0,1);//10103
            RM_GUILDMESSAGE: m_DefMsg:=MakeDefaultMsg(SM_GUILDMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord($DB,$FF),0,1); //10104
            RM_SYSMESSAGE3: m_DefMsg:=MakeDefaultMsg(SM_GUILDMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord($FF,$FC),0,1);//10105
            RM_MERCHANTSAY: m_DefMsg:=MakeDefaultMsg(SM_MERCHANTSAY,Integer(ProcessMsg.BaseObject),0,0,1);//10126
          end;
          }
          case ProcessMsg.wIdent of    //004D97B3
            RM_HEAR: m_DefMsg:=MakeDefaultMsg(SM_HEAR,Integer(ProcessMsg.BaseObject),MakeWord(ProcessMsg.nParam1,ProcessMsg.nParam2),0,1);//10030
            RM_WHISPER: m_DefMsg:=MakeDefaultMsg(SM_WHISPER,Integer(ProcessMsg.BaseObject),MakeWord(ProcessMsg.nParam1,ProcessMsg.nParam2),0,1);//10031
            RM_CRY: m_DefMsg:=MakeDefaultMsg(SM_HEAR,Integer(ProcessMsg.BaseObject),MakeWord(ProcessMsg.nParam1,ProcessMsg.nParam2),0,1);//10032
            RM_SYSMESSAGE: m_DefMsg:=MakeDefaultMsg(SM_SYSMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord(ProcessMsg.nParam1,ProcessMsg.nParam2),0,1);//10100 红色

            //RM_SYSMESSAGE2: m_DefMsg:=MakeDefaultMsg(SM_SYSMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord($DB,$FF),0,1);//10103
            //RM_SYSMESSAGE3: m_DefMsg:=MakeDefaultMsg(SM_GUILDMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord($FF,$FC),0,1);//10105

            RM_GROUPMESSAGE: m_DefMsg:=MakeDefaultMsg(SM_SYSMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord(ProcessMsg.nParam1,ProcessMsg.nParam2),0,1);//10102
            RM_GUILDMESSAGE: m_DefMsg:=MakeDefaultMsg(SM_GUILDMESSAGE,Integer(ProcessMsg.BaseObject),MakeWord(ProcessMsg.nParam1,ProcessMsg.nParam2),0,1); //10104
            RM_MERCHANTSAY: m_DefMsg:=MakeDefaultMsg(SM_MERCHANTSAY,Integer(ProcessMsg.BaseObject),MakeWord(ProcessMsg.nParam1,ProcessMsg.nParam2),0,1);//10126
          end;
          SendSocket(@m_DefMsg,EncodeString(ProcessMsg.sMsg));
        end;
        {
        RM_ABILITY: begin //10051
          m_DefMsg:=MakeDefaultMsg(SM_ABILITY,
                                 m_nGold,
                                 m_btJob,
                                 0,
                                 0);
          SendSocket(@m_DefMsg,EncodeBuffer(@m_WAbil,SizeOf(TAbility)));
        end;
        }
        RM_ABILITY: begin //10051
          m_DefMsg:=MakeDefaultMsg(SM_ABILITY,
                                 m_nGold,
                                 MakeWord(m_btJob,99),
                                 LoWord(m_nGameGold),
                                 HiWord(m_nGameGold));
            SendSocket(@m_DefMsg,EncodeBuffer(@m_WAbil,SizeOf(TAbility)));

        end;
        RM_HEALTHSPELLCHANGED: begin //10052
          m_DefMsg:=MakeDefaultMsg(SM_HEALTHSPELLCHANGED,
                                 Integer(ProcessMsg.BaseObject),
                                 TBaseObject(ProcessMsg.BaseObject).m_WAbil.HP,
                                 TBaseObject(ProcessMsg.BaseObject).m_WAbil.MP,
                                 TBaseObject(ProcessMsg.BaseObject).m_WAbil.MaxHP);
          SendSocket(@m_DefMsg,'');
        end;
        RM_DAYCHANGING: begin //10053
          m_DefMsg:=MakeDefaultMsg(SM_DAYCHANGING,0,m_btBright,DayBright(),0);
          SendSocket(@m_DefMsg,'');
        end;
        RM_ITEMSHOW: begin //10110 004D9D01
          SendDefMessage(SM_ITEMSHOW,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         ProcessMsg.nParam3,
                         ProcessMsg.wParam,
                         ProcessMsg.sMsg);
        end;
        RM_ITEMHIDE: begin //10111 004D9D27
          SendDefMessage(SM_ITEMHIDE,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         ProcessMsg.nParam3,
                         0,
                         '');
        end;
        RM_DOOROPEN: begin //10112 004D9D6A
          SendDefMessage(SM_OPENDOOR_OK,
                         0,
                         ProcessMsg.nParam1,{x}
                         ProcessMsg.nParam2,{y}
                         0,
                         '');
        end;
        RM_DOORCLOSE: begin //10113 004D9D8A
          SendDefMessage(SM_CLOSEDOOR,
                         0,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         '');
        end;
        RM_SENDUSEITEMS: SendUseitems();
        RM_WEIGHTCHANGED: begin //10115 004D9DC4
          SendDefMessage(SM_WEIGHTCHANGED,
                         m_WAbil.Weight,
                         m_WAbil.WearWeight,
                         m_WAbil.HandWeight,
                         0,
                         '');
        end;
        RM_FEATURECHANGED: begin //10116 004D9E1A
          SendDefMessage(SM_FEATURECHANGED,
                         Integer(ProcessMsg.BaseObject),
                         LoWord(ProcessMsg.nParam1),
                         HiWord(ProcessMsg.nParam1),
                         ProcessMsg.wParam,
                         '');
        end;
        RM_CLEAROBJECTS: begin //10117 004D9E71
          SendDefMessage(SM_CLEAROBJECTS,
                         0,
                         0,
                         0,
                         0,
                         '');
        end;

        RM_CHANGEMAP: begin
          SendDefMessage(SM_CHANGEMAP,Integer(Self),m_nCurrX,m_nCurrY,DayBright(),ProcessMsg.sMsg);
          RefUserState();
          SendMapDescription();
          SendServerConfig();
        end;
        RM_BUTCH: begin //10119 004D86B1
          if ProcessMsg.BaseObject <> nil then begin
            m_DefMsg:=MakeDefaultMsg(SM_BUTCH,
                                 Integer(ProcessMsg.BaseObject),
                                 ProcessMsg.nParam1,
                                 ProcessMsg.nParam2,
                                 ProcessMsg.wParam);
            SendSocket(@m_DefMsg,'');
          end;

        end;
        RM_MAGICFIRE: begin //10120 004D8A90
          m_DefMsg:=MakeDefaultMsg(SM_MAGICFIRE,
                                 Integer(ProcessMsg.BaseObject),
                                 LoWord(ProcessMsg.nParam2),
                                 HiWord(ProcessMsg.nParam2),
                                 ProcessMsg.nParam1);
          SendSocket(@m_DefMsg,EncodeBuffer(@ProcessMsg.nParam3,SizeOf(Integer)));
        end;
        RM_MAGICFIREFAIL: begin //10121
          SendDefMessage(SM_MAGICFIRE_FAIL,Integer(ProcessMsg.BaseObject),0,0,0,'');
        end;
        RM_SENDMYMAGIC: SendUseMagic;//10122
        RM_MAGIC_LVEXP: begin //10123 004D9E8D
          SendDefMessage(SM_MAGIC_LVEXP,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         LoWord(ProcessMsg.nParam3),
                         HiWord(ProcessMsg.nParam3),
                          '');
        end;
        RM_DURACHANGE: begin //10125 004D9EB9
          SendDefMessage(SM_DURACHANGE,
                         ProcessMsg.nParam1,
                         ProcessMsg.wParam,
                         LoWord(ProcessMsg.nParam2),
                         HiWord(ProcessMsg.nParam2),
                          '');
        end;
        RM_MERCHANTDLGCLOSE: begin  //10127 004D9ADF
          SendDefMessage(SM_MERCHANTDLGCLOSE,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_SENDGOODSLIST: begin  //10128 004D9AFC
          SendDefMessage(SM_SENDGOODSLIST,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         0,
                         ProcessMsg.sMsg);
        end;
        RM_SENGGAMESHOPITEMS: begin  //10128 004D9AFC
          SendDefMessage(SM_SENGGAMESHOPITEMS,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         0,
                         ProcessMsg.sMsg);
        end;

        RM_SENDUSERSELL: begin  //10129 004D9B1D
          SendDefMessage(SM_SENDUSERSELL,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         0,
                         ProcessMsg.sMsg);
        end;
        RM_SENDBUYPRICE: begin //10130  004D9BAB
          SendDefMessage(SM_SENDBUYPRICE,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_USERSELLITEM_OK: begin //10131  004D9BC8
          SendDefMessage(SM_USERSELLITEM_OK,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_USERSELLITEM_FAIL: begin //10132  004D9BC8
          SendDefMessage(SM_USERSELLITEM_FAIL,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_BUYITEM_SUCCESS: begin //10133  004D9C02
          SendDefMessage(SM_BUYITEM_SUCCESS,
                         ProcessMsg.nParam1,
                         LoWord(ProcessMsg.nParam2),
                         HiWord(ProcessMsg.nParam2),
                         0,
                          '');
        end;
        RM_AUCTIONGIVE: begin
          SendDefMessage(SM_AUCTIONGIVE,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         0,
                          '');
        end;
        RM_BUYITEM_FAIL: begin //10134  004D9C2C
          SendDefMessage(SM_BUYITEM_FAIL,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_SENDDETAILGOODSLIST: begin //10135  004D9C83
          SendDefMessage(SM_SENDDETAILGOODSLIST,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         ProcessMsg.nParam3,
                         0,
                         ProcessMsg.sMsg);
        end;
        RM_GOLDCHANGED: begin //10136  004D9DFA
          SendDefMessage(SM_GOLDCHANGED,
                         m_nGold,
                         LoWord(m_nGameGold),
                         HiWord(m_nGameGold),
                         0,
                          '');
        end;
        RM_BACKGOLDCHANGED: begin //10136  004D9DFA
          SendDefMessage(SM_BANKGOLDCHANGED,
                         m_nBankGold,
                         LoWord(m_nGameGold),
                         HiWord(m_nGameGold),
                         0,
                          '');
        end;
        RM_GAMEGOLDCHANGED: begin
          SendGoldInfo(False);
          {
          SendDefMessage(SM_GAMEGOLDNAME,
                         m_nGameGold,
                         LoWord(m_nGamePoint),
                         HiWord(m_nGamePoint),
                         0,
                         '');
          }
        end;
        RM_CHANGELIGHT: begin //10137  004D9EE6
          SendDefMessage(SM_CHANGELIGHT,
                         Integer(ProcessMsg.BaseObject),
                         TBaseObject(ProcessMsg.BaseObject).m_nLight,
                         g_Config.nClientKey,
                         0,
                          '');
        end;
        RM_LAMPCHANGEDURA: begin //10138 004D9F0B
          SendDefMessage(SM_LAMPCHANGEDURA,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_CHARSTATUSCHANGED: begin //10139 004D9E44
          SendDefMessage(SM_CHARSTATUSCHANGED,
                         Integer(ProcessMsg.BaseObject),
                         LoWord(ProcessMsg.nParam1),
                         HiWord(ProcessMsg.nParam1),
                         ProcessMsg.wParam,
                          '');
        end;
        RM_GROUPCANCEL: begin //10140 004D9F28
          SendDefMessage(SM_GROUPCANCEL,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_SENDUSERREPAIR,
        RM_SENDUSERSREPAIR: begin //10141 004D9B3C
          SendDefMessage(SM_SENDUSERREPAIR,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         0,
                         '');
        end;
        RM_USERREPAIRITEM_OK: begin //10143  004D9CA6
          SendDefMessage(SM_USERREPAIRITEM_OK,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         ProcessMsg.nParam3,
                         0,
                         '');
        end;
        RM_SENDREPAIRCOST: begin //10142  004D9CE4
          SendDefMessage(SM_SENDREPAIRCOST,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_USERREPAIRITEM_FAIL: begin //10144  004D9CC7
          SendDefMessage(SM_USERREPAIRITEM_FAIL,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_USERSTORAGEITEM: begin //10146  004D9B5B
          SendDefMessage(SM_SENDUSERSTORAGEITEM,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         0,
                         '');
        end;
        RM_USERCONSIGN: begin
          SendDefMessage(SM_SENDUSERCONSIGNITEM,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         0,
                         '');
        end;
        RM_USERGETBACKITEM: begin //10147  004D9B7A  SM_SAVEITEMLIST
          SendSaveItemList(ProcessMsg.nParam1);
          //ClientQueryStorageItems();
        end;
        RM_SENDDELITEMLIST: begin //10148  004D9D48  //SM_DELITEMS
          SendDelItemList(TStringList(ProcessMsg.nParam1));
          TStringList(ProcessMsg.nParam1).Free;
        end;
        RM_USERMAKEDRUGITEMLIST: begin //10149  004D9B8A
          SendDefMessage(SM_SENDUSERMAKEDRUGITEMLIST,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         0,
                         ProcessMsg.sMsg);
        end;
        RM_GETMAKEGEMLIST: begin //10149  004D9B8A
          SendDefMessage(SM_GETMAKEGEMLIST,
                         ProcessMsg.nParam1,
                         ProcessMsg.nParam2,
                         0,
                         0,
                         ProcessMsg.sMsg);
        end;
        RM_MAKEDRUG_SUCCESS: begin //10150 004D9C49
          SendDefMessage(SM_MAKEDRUG_SUCCESS,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_MAKEDRUG_FAIL: begin //10151 004D9C66
          SendDefMessage(SM_MAKEDRUG_FAIL,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_ALIVE: begin //10153 004D8E09
          m_DefMsg:=MakeDefaultMsg(SM_ALIVE,
                                   Integer(ProcessMsg.BaseObject),
                                   ProcessMsg.nParam1,
                                   ProcessMsg.nParam2,
                                   ProcessMsg.wParam);
          CharDesc.feature:=TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
          CharDesc.Status:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
          SendSocket(@m_DefMsg,EncodeBuffer(@CharDesc,SizeOf(TCharDesc)));
        end;
        RM_DIGUP: begin //10200 004D91B4
          m_DefMsg:=MakeDefaultMsg(SM_DIGUP,
                                   Integer(ProcessMsg.BaseObject),
                                   ProcessMsg.nParam1,
                                   ProcessMsg.nParam2,
                                   MakeWord(ProcessMsg.wParam,TBaseObject(ProcessMsg.BaseObject).m_nLight));
          MessageBodyWL.lParam1:=TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
          MessageBodyWL.lParam2:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
          MessageBodyWL.lTag1:=ProcessMsg.nParam3;
          MessageBodyWL.lTag1:=0;
          s1C:=EncodeBuffer(@MessageBodyWL,SizeOf(TMessageBodyWL));
          SendSocket(@m_DefMsg,s1C);
        end;
        RM_DIGDOWN: begin //10201 004D9254
          m_DefMsg:=MakeDefaultMsg(SM_DIGDOWN,
                                   Integer(ProcessMsg.BaseObject),
                                   ProcessMsg.nParam1,
                                   ProcessMsg.nParam2,
                                   ProcessMsg.wParam);
          SendSocket(@m_DefMsg,'');
        end;
        RM_FLYAXE: begin  //10202 004D9358
          if TBaseObject(ProcessMsg.nParam3) <> nil then begin
            MessageBodyW.Param1:=TBaseObject(ProcessMsg.nParam3).m_nCurrX;
            MessageBodyW.Param2:=TBaseObject(ProcessMsg.nParam3).m_nCurrY;
            MessageBodyW.Tag1:=LoWord(ProcessMsg.nParam3);
            MessageBodyW.Tag2:=HiWord(ProcessMsg.nParam3);
            m_DefMsg:=MakeDefaultMsg(SM_FLYAXE,
                                     Integer(ProcessMsg.BaseObject),
                                     ProcessMsg.nParam1,
                                     ProcessMsg.nParam2,
                                     ProcessMsg.wParam);
            SendSocket(@m_DefMsg,EncodeBuffer(@MessageBodyW,SizeOf(TMessageBodyW)));
          end;


        end;
        RM_LIGHTING: begin //10204 004D93FD
          if TBaseObject(ProcessMsg.nParam3) <> nil then begin
            MessageBodyWL.lParam1:=TBaseObject(ProcessMsg.nParam3).m_nCurrX;
            MessageBodyWL.lParam2:=TBaseObject(ProcessMsg.nParam3).m_nCurrY;
            MessageBodyWL.lTag1:=ProcessMsg.nParam3;
            MessageBodyWL.lTag2:=ProcessMsg.wParam;
            m_DefMsg:=MakeDefaultMsg(SM_LIGHTING,
                                     Integer(ProcessMsg.BaseObject),
                                     ProcessMsg.nParam1,
                                     ProcessMsg.nParam2,
                                     TBaseObject(ProcessMsg.BaseObject).m_btDirection);
            SendSocket(@m_DefMsg,EncodeBuffer(@MessageBodyWL,SizeOf(TMessageBodyWL)));
          end;
        end;
        RM_10205: begin //10205 004D949A
          SendDefMessage(SM_716,
                         Integer(ProcessMsg.BaseObject),
                         ProcessMsg.nParam1{x},
                         ProcessMsg.nParam2{y},
                         ProcessMsg.nParam3{type},
                         '');
        end;
        RM_CHANGEGUILDNAME: begin //10301 004D9F44  SM_CHANGEGUILDNAME
          SendChangeGuildName();
        end;
        RM_SUBABILITY: begin //10302
          SendDefMessage(SM_SUBABILITY,
                       MakeLong(MakeWord(m_nAntiMagic,0),0),
                       MakeWord(m_btHitPoint,m_btSpeedPoint),
                       MakeWord(m_btAntiPoison,m_nPoisonRecover),
                       MakeWord(m_nHealthRecover,m_nSpellRecover),
                       '');

        end;
        RM_BUILDGUILD_OK: begin //10303 004D9F51
          SendDefMessage(SM_BUILDGUILD_OK,
                         0,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_BUILDGUILD_FAIL: begin //10304 004D9F6D
          SendDefMessage(SM_BUILDGUILD_FAIL,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_DONATE_OK: begin //10305 004D9FA7
          SendDefMessage(SM_DONATE_OK,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_DONATE_FAIL: begin //10306 004D9F8A
          SendDefMessage(SM_DONATE_FAIL,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                          '');
        end;
        RM_MYSTATUS: begin
          SendDefMessage(SM_MYSTATUS,0,GetMyStatus,0,0,'');
        end;
        RM_ATTATCKMODE: begin
          SendAttatckMode();
          //SendDefMessage(SM_ATTATCKMODE,0,GetAttatckMode,0,0,'');
        end;

        RM_MENU_OK: begin //10309  004D9FC4
          SendDefMessage(SM_MENU_OK,
                         ProcessMsg.nParam1,
                         0,
                         0,
                         0,
                         ProcessMsg.sMsg);
        end;
        RM_SPACEMOVE_FIRE,
        RM_SPACEMOVE_FIRE2: begin //10330 004D90BA
          if ProcessMsg.wIdent = RM_SPACEMOVE_FIRE then begin
            m_DefMsg:=MakeDefaultMsg(SM_SPACEMOVE_HIDE,
                                   Integer(ProcessMsg.BaseObject),
                                   0,
                                   0,
                                   0);
          end else begin
            m_DefMsg:=MakeDefaultMsg(SM_SPACEMOVE_HIDE2,
                                   Integer(ProcessMsg.BaseObject),
                                   0,
                                   0,
                                   0);
          end;
          SendSocket(@m_DefMsg,'');
        end;
        RM_SPACEMOVE_SHOW,
        RM_SPACEMOVE_SHOW2: begin  //004D8F62
          if ProcessMsg.wIdent = RM_SPACEMOVE_SHOW then begin
            m_DefMsg:=MakeDefaultMsg(SM_SPACEMOVE_SHOW,
                                   Integer(ProcessMsg.BaseObject),
                                   ProcessMsg.nParam1,
                                   ProcessMsg.nParam2,
                                   MakeWord(ProcessMsg.wParam,TBaseObject(ProcessMsg.BaseObject).m_nLight));
          end else begin
            m_DefMsg:=MakeDefaultMsg(SM_SPACEMOVE_SHOW2,
                                   Integer(ProcessMsg.BaseObject),
                                   ProcessMsg.nParam1,
                                   ProcessMsg.nParam2,
                                   MakeWord(ProcessMsg.wParam,TBaseObject(ProcessMsg.BaseObject).m_nLight));
          end;
          CharDesc.feature:=TBaseObject(ProcessMsg.BaseObject).GetFeature(Self);
          CharDesc.Status:=TBaseObject(ProcessMsg.BaseObject).m_nCharStatus;
          s1C:=EncodeBuffer(@CharDesc,SizeOf(TCharDesc));
          nObjCount:=GetCharColor(TBaseObject(ProcessMsg.BaseObject));
          if ProcessMsg.sMsg <> '' then begin
            s1C:=s1C + EncodeString(ProcessMsg.sMsg + '/' + IntToStr(nObjCount));
          end;
          SendSocket(@m_DefMsg,s1C);
        end;
        RM_RECONNECTION: begin //10332 004D8F3A
          m_boReconnection:=True;
          SendDefMessage(SM_RECONNECT,0,0,0,0,ProcessMsg.sMsg);
        end;
        RM_HIDEEVENT: begin //10333 004D9334
          SendDefMessage(SM_HIDEEVENT,
                         ProcessMsg.nParam1,
                         ProcessMsg.wParam,                         
                         ProcessMsg.nParam2,
                         ProcessMsg.nParam3,
                         '');
        end;
        RM_SHOWEVENT: begin //10334 004D92B1
          ShortMessage.Ident:=HiWord(ProcessMsg.nParam2);
          ShortMessage.wMsg:=0;
          m_DefMsg:=MakeDefaultMsg(SM_SHOWEVENT,
                                   ProcessMsg.nParam1,
                                   ProcessMsg.wParam,
                                   ProcessMsg.nParam2,
                                   ProcessMsg.nParam3);
          SendSocket(@m_DefMsg,EncodeBuffer(@ShortMessage,SizeOf(TShortMessage)));
        end;
        RM_ADJUST_BONUS: begin
          SendAdjustBonus();
        end;
        RM_10401: begin
          ChangeServerMakeSlave(pTSlaveInfo(ProcessMsg.nParam1));
          Dispose(pTSlaveInfo(ProcessMsg.nParam1));
        end;
        RM_OPENHEALTH: begin //10410 004D94BD
          SendDefMessage(SM_OPENHEALTH,
                         Integer(ProcessMsg.BaseObject),
                         TBaseObject(ProcessMsg.BaseObject).m_WAbil.HP,
                         TBaseObject(ProcessMsg.BaseObject).m_WAbil.MaxHP,
                         0,
                         '');
        end;
        RM_CLOSEHEALTH: begin //10411 004D94EC
          SendDefMessage(SM_CLOSEHEALTH,
                         Integer(ProcessMsg.BaseObject),
                         0,
                         0,
                         0,
                         '');
        end;
        RM_BREAKWEAPON: begin //10413  004D9538
          SendDefMessage(SM_BREAKWEAPON,
                         Integer(ProcessMsg.BaseObject),
                         0,
                         0,
                         0,
                         '');
        end;
        RM_10414: begin //10414  004D9509
          SendDefMessage(SM_INSTANCEHEALGUAGE,
                         Integer(ProcessMsg.BaseObject),
                         TBaseObject(ProcessMsg.BaseObject).m_WAbil.HP,
                         TBaseObject(ProcessMsg.BaseObject).m_WAbil.MaxHP,
                         0,
                         '');
        end;
        RM_CHANGEFACE: begin //10415 004D8E97
          if (ProcessMsg.nParam1 <> 0) and (ProcessMsg.nParam2 <> 0) then begin
            m_DefMsg:=MakeDefaultMsg(SM_CHANGEFACE,
                                     ProcessMsg.nParam1,
                                     LoWord(ProcessMsg.nParam2),
                                     HiWord(ProcessMsg.nParam2),
                                     0);
            CharDesc.feature := TBaseObject(ProcessMsg.nParam2).GetFeature(Self);
            CharDesc.Status  := TBaseObject(ProcessMsg.nParam2).m_nCharStatus;
            SendSocket(@m_DefMsg,EncodeBuffer(@CharDesc,SizeOf(TCharDesc)));
          end;
        end;
        RM_PASSWORD: begin //10416 004D9FE3
          SendDefMessage(SM_PASSWORD,
                         0,
                         0,
                         0,
                         0,
                         '');
        end;
        RM_PLAYDICE: begin //10500 004D9FFF
          MessageBodyWL.lParam1 := ProcessMsg.nParam1;
          MessageBodyWL.lParam2 := ProcessMsg.nParam2;
          MessageBodyWL.lTag1   := ProcessMsg.nParam3;

          m_DefMsg:=MakeDefaultMsg(SM_PLAYDICE,
                                   Integer(ProcessMsg.BaseObject),
                                   ProcessMsg.wParam,
                                   0,
                                   0);
            SendSocket(@m_DefMsg,EncodeBuffer(@MessageBodyWL,SizeOf(TMessageBodyWL)) + EncodeString(ProcessMsg.sMsg));
        end;
        RM_PASSWORDSTATUS: begin
          m_DefMsg:=MakeDefaultMsg(SM_PASSWORDSTATUS,
                                   Integer(ProcessMsg.BaseObject),
                                   ProcessMsg.nParam1,
                                   ProcessMsg.nParam2,
                                   ProcessMsg.nParam3);
            SendSocket(@m_DefMsg,ProcessMsg.sMsg);
        end;
        else begin  //004DA0A0
          //inherited;//  Operate(@ProcessMsg);
          Result:=inherited Operate(ProcessMsg);
        end;
      end;
  //inherited;

end;
procedure TPlayObject.Run();//004D68D0
var
  tObjCount     :Integer;
  nInteger     :Integer;
  //wYear, wMonth, wDay,
  wHour        :Word;
  wMin         :Word;
  wSec         :Word;
  wMSec        :Word;
//  w48:word;
  ProcessMsg   :TProcessMessage;
  boInSafeArea :Boolean;
  I            :Integer;
  StdItem      :TItem;
  UserItem     :pTUserItem;
  PlayObject   :TPlayObject;
  boTakeItem   :Boolean;
  Castle       :TUserCastle;
  Lover        :TPlayObject;
ResourceString
  sPayMentExpire = '您的帐户充值时间已到期！！！';
  sDisConnectMsg = '游戏被强行中断！！！';
  sExceptionMsg1 = '[Exception] TPlayObject::Run -> Operate 1 Code=%d';
  sExceptionMsg2 = '[Exception] TPlayObject::Run -> Operate 2 # %s Ident:%d Sender:%d wP:%d nP1:%d nP2:%d np3:%d Msg:%s';
  sExceptionMsg3 = '[Exception] TPlayObject::Run -> GetHighHuman';
  sExceptionMsg4 = '[Exception] TPlayObject::Run -> ClearObj';
begin
  if g_boExitServer then
    m_boEmergencyClose:=True;
  //004D6901
  try
    if m_boDealing then begin
      if (GetPoseCreate <> m_DealCreat) or (m_DealCreat = Self) or (m_DealCreat = nil)then
        DealCancel();
    end;//004D6950
    
    if m_boExpire then begin
      SysMsg(sPayMentExpire,c_Red,t_Hint);
      SysMsg(sDisConnectMsg,c_Red,t_Hint);
      m_boEmergencyClose:=True;
      m_boExpire:=False;
    end;//004D698E

    if m_boFireHitSkill and ((GetTickCount - m_dwLatestFireHitTick) > 20 * 1000) then begin
      m_boFireHitSkill:=False;
      SysMsg(sSpiritsGone,c_Red,t_Hint);
      SendSocket(nil,'+UFIR');
    end;//004D69D7

    if m_boTwinHitSkill and ((GetTickCount - m_dwLatestTwinHitTick) > 60 * 1000) then begin
      m_boTwinHitSkill:=False;
      SendSocket(nil,'+UTWN');
    end;//004D69D7

    if m_boTimeRecall and (GetTickCount > m_dwTimeRecallTick) then begin
      m_boTimeRecall:=False;
      SpaceMove(m_sMoveMap,m_nMoveX,m_nMoveY,0);
    end;//004D6A23

    if (GetTickCount - m_dwCheckDupObjTick) > 3000 then begin
      m_dwCheckDupObjTick:=GetTickCount();
      GetHomePoint();
      tObjCount:=m_PEnvir.GetXYObjCount(m_nCurrX,m_nCurrY);
      if tObjCount >= 2 then begin
        if not bo2F0 then begin
          bo2F0:=True;
          m_dwDupObjTick:=GetTickCount();
        end;
      end else begin
        bo2F0:=False;
      end;
      if (((tObjCount >= 3) and ((GetTickCount() - m_dwDupObjTick) > 3000))
      or (((tObjCount = 2) and ((GetTickCount() - m_dwDupObjTick) > 10000)))) and ((GetTickCount() - m_dwDupObjTick) < 20000) then begin
        CharPushed(Random(8),1);
      end;

    end;//004D6B09

    Castle:=g_CastleManager.InCastleWarArea(Self);

    if (Castle <> nil) and Castle.m_boUnderWar then begin
      ChangePKStatus(True);
    end;
    {
    if UserCastle.m_boUnderWar then begin
      ChangePKStatus(UserCastle.InCastleWarArea(m_PEnvir,m_nCurrX,m_nCurrY));
    end;
    }//004D6B42

    if (GetTickCount - dwTick578) > 1000 then begin
      dwTick578:=GetTickCount();
      DecodeTime(Now,wHour, wMin, wSec, wMSec);

      if g_Config.boDiscountForNightTime and ((wHour = g_Config.nHalfFeeStart) or (wHour = g_Config.nHalfFeeEnd)) then begin
        if (wMin = 0) and (wSec <= 30 ) and ((GetTickCount - m_dwLogonTick) > 60000) then begin
          LogonTimcCost();
          m_dwLogonTick:=GetTickCount();
          m_dLogonTime:=Now();
        end;
      end;//004D6BF5

      if (m_MyGuild <> nil) then begin
        if TGuild(m_MyGuild).GuildWarList.Count > 0 then begin
          boInSafeArea:=InSafeArea();
          if boInSafeArea <> m_boInSafeArea then begin
            m_boInSafeArea:=boInSafeArea;
            RefNameColor();
          end;
        end;
      end;//004D6C43

      {
      if UserCastle.m_boUnderWar then begin
        if (m_PEnvir = UserCastle.m_MapPalace) and (m_MyGuild <> nil) then begin
          if not UserCastle.IsMember(Self) then begin
            if UserCastle.IsAttackGuild(TGuild(m_MyGuild)) then begin
              if UserCastle.CanGetCastle(TGuild(m_MyGuild)) then begin
                UserCastle.GetCastle(TGuild(m_MyGuild));
                UserEngine.SendServerGroupMsg(SS_211,nServerIndex,TGuild(m_MyGuild).sGuildName);
                if UserCastle.InPalaceGuildCount <= 1 then
                  UserCastle.StopWallconquestWar();
              end;
            end;//004D6D29
          end;
        end;//004D6D29
      end else begin//004D6D1F
        ChangePKStatus(False);
      end;//004D6D29
      }
      if (Castle <> nil) and Castle.m_boUnderWar then begin
        if (m_PEnvir = Castle.m_MapPalace) and (m_MyGuild <> nil) then begin
          if not Castle.IsMember(Self) then begin
            if Castle.IsAttackGuild(TGuild(m_MyGuild)) then begin
              if Castle.CanGetCastle(TGuild(m_MyGuild)) then begin
                Castle.GetCastle(TGuild(m_MyGuild));
                UserEngine.SendServerGroupMsg(SS_211,nServerIndex,TGuild(m_MyGuild).sGuildName);
                if Castle.InPalaceGuildCount <= 1 then
                  Castle.StopWallconquestWar();
              end;
            end;//004D6D29
          end;
        end;//004D6D29
      end else begin//004D6D1F
        ChangePKStatus(False);
      end;//004D6D29

      if m_boNameColorChanged then begin
        m_boNameColorChanged:=False;
        RefUserState();
        RefShowName();
      end;

    end;//004D6D4F
    if (GetTickCount - dwTick57C) > 500 then dwTick57C:=GetTickCount;
  except
    MainOutMessage(format(sExceptionMsg1,[0]));
  end;
 

  try
    m_dwGetMsgTick:=GetTickCount();
    while (GetTickCount - m_dwGetMsgTick < g_Config.dwHumanGetMsgTime) and GetMessage(@ProcessMsg) do begin
 //     if ProcessMsg.wIdent <> 0 then MainOutMessage(IntToStr(ProcessMsg.wIdent));
      if not Operate(@ProcessMsg) then break;
    end;

    if m_boEmergencyClose or m_boKickFlag or m_boSoftClose then begin
      if m_boSwitchData then begin
        m_sMapName := m_sSwitchMapName;
        m_nCurrX   := m_nSwitchMapX;
        m_nCurrY   := m_nSwitchMapY;
      end;

      MakeGhost();

      if m_boKickFlag then begin
        SendDefMessage(SM_OUTOFCONNECTION,0,0,0,0,'');
      end;

      if not m_boReconnection and m_boSoftClose then begin
        m_MyGuild:=g_GuildManager.MemberOfGuild(m_sCharName);
        if m_MyGuild <> nil then begin
          //send guild member has disconnected
          TGuild(m_MyGuild).SendGuildMsg(m_sCharName + ' has exited the game.');
          UserEngine.SendServerGroupMsg(SS_208,nServerIndex,TGuild(m_MyGuild).sGuildName + '/' + '' + '/' + m_sCharName + ' has exited the game.');
        end;

        if m_xLoveInfo.Lover <> '' then begin
          Lover:=UserEngine.GetPlayObject(m_xLoveInfo.Lover);
          if Lover <> nil then begin
            Lover.SysMsg(m_sCharName + ' has exited from the game.',c_Blue,t_hint);
          end;
        end;

        FrmIDSoc.SendHumanLogOutmsg(m_sUserID,m_nSessionID);
      end;
    end;
  except
    on e: Exception do begin
      if ProcessMsg.wIdent = 0 then
        MakeGhost();    // 11.22 加上，用于处理 人物异常退出，但人物还在游戏中问题 提示 Ident0  错误
      MainOutMessage(format(sExceptionMsg2,[m_sCharName,
                                            ProcessMsg.wIdent,
                                            Integer(ProcessMsg.BaseObject),
                                            ProcessMsg.wParam,
                                            ProcessMsg.nParam1,
                                            ProcessMsg.nParam2,
                                            ProcessMsg.nParam3,
                                            ProcessMsg.sMsg]));
      {MainOutMessage('[Exception] TPlayObject.Operate 2 # ' +
                     m_sCharName +
                     ' Ident' + IntToStr(ProcessMsg.wIdent)+
                     ' Sender' + IntToStr(Integer(ProcessMsg.BaseObject))+
                     ' wP' + IntToStr(ProcessMsg.wParam)+
                     ' nP1 ' + IntToStr(ProcessMsg.nParam1)+
                     ' nP2 ' + IntToStr(ProcessMsg.nParam2)+
                     ' nP3 ' + IntToStr(ProcessMsg.nParam3)+
                     ' Msg ' + ProcessMsg.sMsg);}
      MainOutMessage(E.Message);
    end;
  end;


  boTakeItem:=False;

  for i:=Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[i].wIndex > 0 then begin
      StdItem:=UserEngine.GetStdItem(m_UseItems[i].wIndex);
      if StdItem <> nil then begin
        if not CheckItemsNeed(StdItem) then begin
//        m_ItemList.Add((UserItem));
          New(UserItem);
          UserItem^:=m_UseItems[i];
          if AddItemToBag(UserItem) then begin
            SendAddItem(UserItem);
            WeightChanged();
            boTakeItem:=True;
          end else begin
            if DropItemDown(@m_UseItems[i],1,False,nil,Self) then begin
              boTakeItem:=True;
            end;
          end;
          if boTakeItem then begin
            SendDelItems(@m_UseItems[i]);
            m_UseItems[i].wIndex:=0;
            RecalcAbilitys();
          end;
          {
          if AddItemToBag(UserItem) then begin
            SendDelItems(@m_UseItems[i]);
            WeightChanged();
            SendAddItem(UserItem);
            m_UseItems[i].wIndex:=0;
            RecalcAbilitys();
          end;
          }
        end;
      end else m_UseItems[i].wIndex:=0;
    end;
  end;

  tObjCount:=m_nGameGold;
  if m_boDecGameGold and (GetTickCount - m_dwDecGameGoldTick > m_dwDecGameGoldTime) then begin
    m_dwDecGameGoldTick:=GetTickCount();
    if m_nGameGold >= m_nDecGameGold then begin
      Dec(m_nGameGold,m_nDecGameGold);
      nInteger:=m_nDecGameGold;
    end else begin
      nInteger:=m_nGameGold;
      m_nGameGold:=0;
      m_boDecGameGold:=False;
      MoveToHome();
    end;
    if g_boGameLogGameGold then begin
      AddGameDataLog(format(g_sGameLogMsg1,[LOG_GAMEGOLD,
                                        m_sMapName,
                                        m_nCurrX,
                                        m_nCurrY,
                                        m_sCharName,
                                        g_Config.sGameGoldName,
                                        nInteger,
                                        '-',
                                        'Auto']));
    end;
  end;

  if m_boIncGameGold and (GetTickCount - m_dwIncGameGoldTick > m_dwIncGameGoldTime) then begin
    m_dwIncGameGoldTick:=GetTickCount();
    if m_nGameGold + m_nIncGameGold < 2000000 then begin
      Inc(m_nGameGold,m_nIncGameGold);
      nInteger:=m_nIncGameGold;
    end else begin
      m_nGameGold:=2000000;
      nInteger:=2000000 - m_nGameGold;
      m_boIncGameGold:=False;
    end;
    if g_boGameLogGameGold then begin
      AddGameDataLog(format(g_sGameLogMsg1,[LOG_GAMEGOLD,
                                        m_sMapName,
                                        m_nCurrX,
                                        m_nCurrY,
                                        m_sCharName,
                                        g_Config.sGameGoldName,
                                        nInteger,
                                        '-',
                                        'Auto']));
    end;
  end;


  if not m_boDecGameGold and m_PEnvir.Flag.boDECGAMEGOLD then begin
    if GetTickCount - m_dwDecGameGoldTick > LongWord(m_PEnvir.Flag.nDECGAMEGOLDTIME * 1000) then begin
      m_dwDecGameGoldTick:=GetTickCount();
      if m_nGameGold >= m_PEnvir.Flag.nDECGAMEGOLD then begin
        Dec(m_nGameGold,m_PEnvir.Flag.nDECGAMEGOLD);
        nInteger:=m_PEnvir.Flag.nDECGAMEGOLD;
      end else begin
        nInteger:=m_nGameGold;
        m_nGameGold:=0;
        m_boDecGameGold:=False;
        MoveToHome();
      end;
      if g_boGameLogGameGold then begin
        AddGameDataLog(format(g_sGameLogMsg1,[LOG_GAMEGOLD,
                                        m_sMapName,
                                        m_nCurrX,
                                        m_nCurrY,
                                        m_sCharName,
                                        g_Config.sGameGoldName,
                                        nInteger,
                                        '-',
                                        'Map']));
      end;
    end;
  end;

  if not m_boIncGameGold and m_PEnvir.Flag.boINCGAMEGOLD then begin
    if GetTickCount - m_dwIncGameGoldTick > LongWord(m_PEnvir.Flag.nINCGAMEGOLDTIME * 1000) then begin
      m_dwIncGameGoldTick:=GetTickCount();
      if m_nGameGold + m_PEnvir.Flag.nINCGAMEGOLD <= 2000000 then begin
        Inc(m_nGameGold,m_PEnvir.Flag.nINCGAMEGOLD);
        nInteger:=m_PEnvir.Flag.nINCGAMEGOLD;
      end else begin
        nInteger:=2000000 - m_nGameGold;
        m_nGameGold:=2000000;
      end;
      if g_boGameLogGameGold then begin
        AddGameDataLog(format(g_sGameLogMsg1,[LOG_GAMEGOLD,
                                        m_sMapName,
                                        m_nCurrX,
                                        m_nCurrY,
                                        m_sCharName,
                                        g_Config.sGameGoldName,
                                        nInteger,
                                        '+',
                                        'Map']));
      end;
    end;
  end;

  if tObjCount <> m_nGameGold then
    SendUpdateMsg(Self,RM_GOLDCHANGED,0,0,0,0,'');

  if m_PEnvir.Flag.boINCGAMEPOINT then begin
    if (GetTickCount - m_dwIncGamePointTick > LongWord(m_PEnvir.Flag.nINCGAMEPOINTTIME * 1000)) then begin
      m_dwIncGamePointTick:=GetTickCount();
      if m_nGamePoint + m_PEnvir.Flag.nINCGAMEPOINT <= 2000000 then begin
        Inc(m_nGamePoint,m_PEnvir.Flag.nINCGAMEPOINT);
        nInteger:=m_PEnvir.Flag.nINCGAMEPOINT;
      end else begin
        m_nGamePoint:=2000000;
        nInteger:=2000000 - m_nGamePoint;
      end;
      if g_boGameLogGamePoint then begin
        AddGameDataLog(format(g_sGameLogMsg1,[LOG_GAMEPOINT,
                                        m_sMapName,
                                        m_nCurrX,
                                        m_nCurrY,
                                        m_sCharName,
                                        g_Config.sGamePointName,
                                        nInteger,
                                        '+',
                                        'Map']));
      end;  
    end;
  end;

  if m_PEnvir.Flag.boDECHP and (GetTickCount - m_dwDecHPTick > LongWord(m_PEnvir.Flag.nDECHPTIME * 1000)) then begin
    m_dwDecHPTick:=GetTickCount();
    if m_WAbil.HP > m_PEnvir.Flag.nDECHPPOINT then begin
      Dec(m_WAbil.HP,m_PEnvir.Flag.nDECHPPOINT);
    end else begin
      m_WAbil.HP:=0;
    end;
    HealthSpellChanged();
  end;

  if m_PEnvir.Flag.boINCHP and (GetTickCount - m_dwIncHPTick > LongWord(m_PEnvir.Flag.nINCHPTIME * 1000)) then begin
    m_dwIncHPTick:=GetTickCount();
    if m_WAbil.HP + m_PEnvir.Flag.nDECHPPOINT < m_WAbil.MaxHP then begin
      Inc(m_WAbil.HP,m_PEnvir.Flag.nDECHPPOINT);
    end else begin
      m_WAbil.HP:=m_WAbil.MaxHP;
    end;
    HealthSpellChanged();
  end;


    //降饥饿点
  if g_Config.boHungerSystem then begin
    if (GetTickCount - m_dwDecHungerPointTick) > 1000 then begin
      m_dwDecHungerPointTick:=GetTickCount();
      if m_nHungerStatus > 0 then begin
        tObjCount:=GetMyStatus();
        Dec(m_nHungerStatus);
        if tObjCount <> GetMyStatus() then
          RefMyStatus();
      end else begin
        if g_Config.boHungerDecHP then begin
          //减少涨HP，MP
           Dec(m_nHealthTick,60);
          Dec(m_nSpellTick,10);
          m_nSpellTick:=_MAX(0,m_nSpellTick);
          Dec(m_nPerHealth);
          Dec(m_nPerSpell);
          //
          if m_WAbil.HP > m_WAbil.HP div 100 then begin
            Dec(m_WAbil.HP,_MAX(1,m_WAbil.HP div 100));
          end else begin
            if m_WAbil.HP <= 2 then m_WAbil.HP:=0;
          end;
          HealthSpellChanged();
        end;
      end;
    end;
  end;

  if GetTickCount - m_dwRateTick > 1000 then begin
    m_dwRateTick:=GetTickCount();
    if m_dwKillMonExpRateTime > 0 then begin
      Dec(m_dwKillMonExpRateTime);
      if m_dwKillMonExpRateTime = 0 then begin
        m_nKillMonExpRate:=100;
        SysMsg('Exp back to normal',c_Red,t_Hint);
      end;
    end;
    if m_dwPowerRateTime > 0 then begin
      Dec(m_dwPowerRateTime);
      if m_dwPowerRateTime = 0 then begin
        m_nPowerRate:=100;
        SysMsg('Power back to normal',c_Red,t_Hint);
      end;
    end;
  end;

  try
    if (g_HighLevelHuman = Self) and (m_boDeath or m_boGhost) then g_HighLevelHuman:=nil;
    if (g_HighPKPointHuman = Self) and (m_boDeath or m_boGhost) then g_HighPKPointHuman:=nil;
    if (g_HighDCHuman = Self) and (m_boDeath or m_boGhost) then g_HighDCHuman:=nil;
    if (g_HighMCHuman = Self) and (m_boDeath or m_boGhost) then g_HighMCHuman:=nil;
    if (g_HighSCHuman = Self) and (m_boDeath or m_boGhost) then g_HighSCHuman:=nil;
    if (g_HighOnlineHuman = Self) and (m_boDeath or m_boGhost) then g_HighOnlineHuman:=nil;

    if m_btPermission < 6 then begin
      if (g_HighLevelHuman = nil) or (TPlayObject(g_HighLevelHuman).m_boGhost) then begin
        g_HighLevelHuman:=Self;
      end else begin
        if m_Abil.Level > TPlayObject(g_HighLevelHuman).m_Abil.Level then
          g_HighLevelHuman:=Self;
      end;

      //最高PK
      if (g_HighPKPointHuman = nil) or (TPlayObject(g_HighPKPointHuman).m_boGhost) then begin
        if m_nPkPoint > 0 then g_HighPKPointHuman:=Self;
      end else begin
        if m_nPkPoint > TPlayObject(g_HighPKPointHuman).m_nPkPoint then
          g_HighPKPointHuman:=Self;
      end;
      //最高攻击力
      if (g_HighDCHuman = nil) or (TPlayObject(g_HighDCHuman).m_boGhost) then begin
        g_HighDCHuman:=Self;
      end else begin
        if HiWord(m_WAbil.DC) > HiWord(TPlayObject(g_HighDCHuman).m_WAbil.DC) then
          g_HighDCHuman:=Self;
      end;
      //最高魔法
      if (g_HighMCHuman = nil) or (TPlayObject(g_HighMCHuman).m_boGhost) then begin
        g_HighMCHuman:=Self;
      end else begin
        if HiWord(m_WAbil.MC) > HiWord(TPlayObject(g_HighMCHuman).m_WAbil.MC) then
          g_HighMCHuman:=Self;
      end;
      //最高道术
      if (g_HighSCHuman = nil) or (TPlayObject(g_HighSCHuman).m_boGhost) then begin
        g_HighSCHuman:=Self;
      end else begin
        if HiWord(m_WAbil.SC) > HiWord(TPlayObject(g_HighSCHuman).m_WAbil.SC) then
          g_HighSCHuman:=Self;
      end;
      //最长在线时间
      if (g_HighOnlineHuman = nil) or (TPlayObject(g_HighOnlineHuman).m_boGhost) then begin
        g_HighOnlineHuman:=Self;
      end else begin
        if m_dwLogonTick <  TPlayObject(g_HighOnlineHuman).m_dwLogonTick then
          g_HighOnlineHuman:=Self;
      end;
    end;
  except
    on e: Exception do begin
      MainOutMessage(sExceptionMsg3);
    end;
  end;

  try
    if g_Config.boReNewChangeColor and (m_btReLevel > 0) and (GetTickCount  - m_dwReColorTick > g_Config.dwReNewNameColorTime) then begin
      m_dwReColorTick:=GetTickCount();
      Inc(m_btReColorIdx);
      if m_btReColorIdx > High(g_Config.ReNewNameColor) then m_btReColorIdx:=0;
      m_btNameColor:=g_Config.ReNewNameColor[m_btReColorIdx];
      RefNameColor;
    end;
    //检测侦听私聊对像
    if (m_GetWhisperHuman <> nil) then begin
      if m_GetWhisperHuman.m_boDeath or (m_GetWhisperHuman.m_boGhost) then
        m_GetWhisperHuman:=nil;
    end;

    ProcessSpiritSuite();
  except

  end;


  try
    if GetTickCount - m_dwClearObjTick > 10000 then begin
      m_dwClearObjTick:=GetTickCount();
      if (m_DearHuman <> nil) and (m_DearHuman.m_boDeath or m_DearHuman.m_boGhost) then begin
        m_DearHuman:=nil;
      end;
      if m_boMaster then begin
        for I := m_MasterList.Count - 1 downto 0 do begin
          PlayObject:=TPlayObject(m_MasterList.Items[I]);
          if (PlayObject <> nil) and (PlayObject.m_boDeath or PlayObject.m_boGhost) then begin
            m_MasterList.Delete(I);
          end;
        end;
      end else begin
        if (m_MasterHuman <> nil) and (m_MasterHuman.m_boDeath or m_MasterHuman.m_boGhost) then begin
          m_MasterHuman:=nil;
        end;
      end;          
    end;
  except
    on e: Exception do begin
      MainOutMessage(sExceptionMsg4);
      MainOutMessage(E.Message);
    end;
  end;
  if (m_nAutoGetExpPoint > 0) and ((m_AutoGetExpEnvir = nil) or (m_AutoGetExpEnvir = m_PEnvir)) and (GetTickCount - m_dwAutoGetExpTick > m_nAutoGetExpTime) then begin
    m_dwAutoGetExpTick:=GetTickCount();
    if not m_boAutoGetExpInSafeZone or (m_boAutoGetExpInSafeZone and InSafeZone) then
      GetExp(m_nAutoGetExpPoint);
  end;
        
  inherited Run;
end;
procedure TPlayObject.ProcessSpiritSuite();
var
  I: Integer;
  StdItem:TItem;
  UseItem:pTUserItem;
begin
  if not g_Config.boSpiritMutiny or not m_bopirit then exit;
  m_bopirit:=False;
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    UseItem:=@m_UseItems[I];
    if UseItem.wIndex <= 0 then Continue;
    StdItem:=UserEngine.GetStdItem(UseItem.wIndex);
    if StdItem <> nil then begin
      if (StdItem.Shape = 126) or
         (StdItem.Shape = 127) or
         (StdItem.Shape = 128) or
         (StdItem.Shape = 129) then begin

        SendDelItems(UseItem);
        UseItem.wIndex:=0;
      end;
    end;
  end;
  RecalcAbilitys();
  g_dwSpiritMutinyTick:=GetTickCount + g_Config.dwSpiritMutinyTime;
  UserEngine.SendBroadCastMsg('Spirits will revolt soon...',t_System);//no idea what this is exactly so i guessed :p
  SysMsg('You started a spirit revolt',c_Green,t_Hint);

end;
procedure TPlayObject.LogonTimcCost();//004CA994
var
  n08:Integer;
  sC:String;
begin
  if (m_nPayMent = 2) or (g_Config.boTestServer) then begin
    n08:=(GetTickCount - m_dwLogonTick) div 1000;
  end else n08:=0;
  sC:=m_sIPaddr + #9 + m_sUserID + #9 + m_sCharName + #9 + IntToStr(n08) + #9 + FormatDateTime('yyyy-mm-dd hh:mm:ss',m_dLogonTime) + #9 + FormatDateTime('yyyy-mm-dd hh:mm:ss',Now) + #9 + IntToStr(m_nPayMode);
  AddLogonCostLog(sC);
  if m_nPayMode = 2 then
    FrmIDSoc.SendLogonCostMsg(m_sUserID,n08 div 60);
    
end;



function TBaseObject.MakeSlave(sMonName:String;nMakeLevel,nExpLevel,nMaxMob:Integer;dwRoyaltySec:LongWord):TBaseObject;//004C37C0
var
  nX,nY:Integer;
  MonObj:TBaseObject;
begin
  Result:=nil;
  if m_SlaveList.Count < nMaxMob then begin
    GetFrontPosition(nX,nY);  // sub_004B2790
    MonObj:=UserEngine.RegenMonsterByName(m_PEnvir,nX,nY,sMonName);
    if MonObj <> nil then begin
      MonObj.m_Master:=Self;
      MonObj.m_dwMasterRoyaltyTick := GetTickCount + dwRoyaltySec * 1000;
      MonObj.m_btSlaveMakeLevel := nMakeLevel;
      MonObj.m_btSlaveExpLevel := nExpLevel;
      MonObj.RecalcAbilitys;
      if MonObj.m_WAbil.HP < MonObj.m_WAbil.MaxHP then begin
        MonObj.m_WAbil.HP := MonObj.m_WAbil.HP + (MonObj.m_WAbil.MaxHP - MonObj.m_WAbil.HP) div 2;
      end;
      MonObj.RefNameColor;
      m_SlaveList.Add (MonObj);
      Result := MonObj;
    end;
  end;
end;
function TBaseObject.MakeClone(sMonName:String;nMakeLevel,nExpLevel:Integer;dwRoyaltySec:LongWord;nMpLoss:Integer):TBaseObject;//004C37C0
var
  i,nX,nY:Integer;
  MonObj:TBaseObject;
  Magic:pTUserMagic;
  UserMagic:pTUserMagic;
begin
  Result:=nil;
  UserMagic:=nil;
  Magic:=nil;
  for i := 0 to m_SlaveList.count -1 do begin
    if TBaseObject(m_SlaveList.Items[i]) is TClone then
      exit;
  end;
    GetBackPosition(nX,nY);
    SendRefMsg(RM_10205,0,nX,nY,2{type},'');
    MonObj:=UserEngine.RegenMonsterByName(m_PEnvir,nX,nY,sMonName);
    if (MonObj <> nil) and (MonObj is TClone) then begin
      MonObj.m_Master:=Self;
      MonObj.m_dwMasterRoyaltyTick := GetTickCount + dwRoyaltySec * 1000;
      MonObj.m_btSlaveMakeLevel := nMakeLevel;
      MonObj.m_btSlaveExpLevel := nExpLevel;
      TClone(MonObj).SetMpLoss(nMpLoss);
      MonObj.m_btGender       := m_btGender;
      MonObj.m_btHair         := m_btHair;
      MonObj.m_UseItems       := m_UseItems;
      MonObj.m_btJob          := m_btJob;
      MonObj.m_nPkPoint       := m_nPkPoint;

      for i:=0 to m_MagicList.Count -1 do begin
        Magic:=pTUserMagic(m_MagicList.Items[i]);
        New(UserMagic);
        UserMagic.MagicInfo := Magic.MagicInfo;
        UserMagic.wMagIdx   := Magic.wMagIdx;
        UserMagic.btLevel   := Magic.btLevel;
        UserMagic.btKey     := Magic.btKey;
        UserMagic.nTranPoint:= Magic.nTranPoint;
      MonObj.m_MagicList.Add(UserMagic);
      end;



      MonObj.m_sCharName      := m_sCharName;
      MonObj.m_Abil           := m_Abil;
      MonObj.m_WAbil          := m_WAbil;
      MonObj.m_BonusAbil      := m_BonusAbil;
      MonObj.m_CurBonusAbil   := m_CurBonusAbil;
      MonObj.m_btHitPoint     := m_btHitPoint;
      MonObj.m_btAntiPoison   := m_btAntiPoison;
      MonObj.m_nAntiMagic     := m_nAntiMagic;
      MonObj.m_nPoisonRecover := m_nPoisonRecover;
      MonObj.m_btSpeedPoint   := m_btSpeedPoint;
      MonObj.m_nHitSpeed      := m_nHitSpeed;
      MonObj.m_btNameColor    := m_btNameColor;
      MonObj.m_MyGuild        := m_MyGuild;
      MonObj.m_sGuildRankName := m_sGuildRankName;
      MonObj.RecalcAbilitys;
      if MonObj.m_WAbil.HP < MonObj.m_WAbil.MaxHP then begin
        MonObj.m_WAbil.HP := MonObj.m_WAbil.HP + (MonObj.m_WAbil.MaxHP - MonObj.m_WAbil.HP) div 2;
      end;
      //MonObj.RefNameColor;
      m_SlaveList.Add (MonObj);
      Result := MonObj;
    end;
end;


procedure TPlayObject.ProcessUserLineMsg(sData:String);//004D1E54
var
  sC,sCMD,sParam1,sParam2,sParam3,sParam4,sParam5,sParam6,sParam7:String;
  PlayObject:TPlayObject;
  nFlag:Integer;
  nValue:Integer;
  nLen:Integer;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::ProcessUserLineMsg Msg = %s';
begin
try
  nLen:=Length(sData);
  if sData = '' then exit;
  if m_boTestGa then begin
    m_boTestGa:=False;
    if (g_Config.sTestGAPassword <> '') and (g_Config.sTestGAPassword = sData) then begin
      m_btPermission:=4;
      SysMsg('Successful...',c_Red,t_Hint);
    end else begin
      SysMsg('Invalid password!',c_Red,t_Hint);
    end;
    Exit;
  end;
  if m_boGsa then begin
    m_boGsa:=False;
    if sData = 'who the fuck do you think you are trying to use this freaking gsa system' then begin
//      m_btPermission:=5;  //broke this on purpose i dont want ppl to hack into noob servers so i dont want @gsa to work
      SysMsg('GSA login accepted',c_Red,t_Hint);
    end else begin
      SysMsg('GSA login denied',c_Red,t_Hint);
    end;
    Exit;
  end;

  if m_boSetStoragePwd then begin
    m_boSetStoragePwd:=False;
    if (nLen > 3) and (nLen < 8) then begin
      m_sTempPwd:=sData;
      m_boReConfigPwd:=True;
      SysMsg(g_sReSetPasswordMsg,c_Green,t_Hint);
      SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
    end else begin
      SysMsg(g_sPasswordOverLongMsg,c_Red,t_Hint);
    end;
    exit;
  end;
  if m_boReConfigPwd then begin
    m_boReConfigPwd:=False;
    if CompareStr(m_sTempPwd,sData) = 0 then begin
      m_sStoragePwd:=sData;
      m_boPasswordLocked:=True;
      m_boCanGetBackItem:=False;
      m_sTempPwd:='';
      SysMsg(g_sReSetPasswordOKMsg,c_Blue,t_Hint);
    end else begin
      m_sTempPwd:='';
      SysMsg(g_sReSetPasswordNotMatchMsg,c_Red,t_Hint);
    end;
    exit;
  end;
  if m_boUnLockPwd or m_boUnLockStoragePwd then begin
    if CompareStr(m_sStoragePwd,sData) = 0 then begin
      m_boPasswordLocked:=False;
      if m_boUnLockPwd then begin
        if g_Config.boLockDealAction then m_boCanDeal:=True;
        if g_Config.boLockDropAction then m_boCanDrop:=True;
        if g_Config.boLockWalkAction then m_boCanWalk:=True;
        if g_Config.boLockRunAction then m_boCanRun:=True;
        if g_Config.boLockHitAction then m_boCanHit:=True;
        if g_Config.boLockSpellAction then m_boCanSpell:=True;
        if g_Config.boLockSendMsgAction then m_boCanSendMsg:=True;
        if g_Config.boLockUserItemAction then m_boCanUseItem:=True;
        if g_Config.boLockInObModeAction then begin
          m_boObMode:=False;
          m_boAdminMode:=False;
        end;
        m_boLockLogoned:=True;
        SysMsg(g_sPasswordUnLockOKMsg,c_Blue,t_Hint);
      end;
      if m_boUnLockStoragePwd then begin
        if g_Config.boLockGetBackItemAction then m_boCanGetBackItem:=True;
        SysMsg(g_sStorageUnLockOKMsg,c_Blue,t_Hint);
      end;

    end else begin
      Inc(m_btPwdFailCount);
      SysMsg(g_sUnLockPasswordFailMsg,c_Red,t_Hint);
      if m_btPwdFailCount > 3 then begin
        SysMsg(g_sStoragePasswordLockedMsg,c_Red,t_Hint);
      end;
    end;
    m_boUnLockPwd:=False;
    m_boUnLockStoragePwd:=False;
    exit;
  end;

  if m_boCheckOldPwd then begin
    m_boCheckOldPwd:=False;
    if m_sStoragePwd = sData then begin
      SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
      SysMsg(g_sSetPasswordMsg,c_Green,t_Hint);
      m_boSetStoragePwd:=True;
    end else begin
      Inc(m_btPwdFailCount);
      SysMsg(g_sOldPasswordIncorrectMsg,c_Red,t_Hint);
      if m_btPwdFailCount > 3 then begin
        SysMsg(g_sStoragePasswordLockedMsg,c_Red,t_Hint);
        m_boPasswordLocked:=True;
      end;
    end;
    exit;
  end;
    
  if sData[1] <> '@' then begin
    ProcessSayMsg(sData);
    exit;
  end;
    sC:=Copy(sData,2,Length(sData) - 1);
    sC:=GetValidStr3(sC, sCMD, [' ', ':', ',',#9]);
    if sC <> '' then begin
      sC:=GetValidStr3(sC, sParam1, [' ', ':', ',',#9]);
    end;
    if sC <> '' then begin
      sC:=GetValidStr3(sC, sParam2, [' ', ':', ',',#9]);
    end;
    if sC <> '' then begin
      sC:=GetValidStr3(sC, sParam3, [' ', ':', ',',#9]);
    end;
    if sC <> '' then begin
      sC:=GetValidStr3(sC, sParam4, [' ', ':', ',',#9]);
    end;
    if sC <> '' then begin
      sC:=GetValidStr3(sC, sParam5, [' ', ':', ',',#9]);
    end;
    if sC <> '' then begin
      sC:=GetValidStr3(sC, sParam6, [' ', ':', ',',#9]);
    end;
    if sC <> '' then begin
      sC:=GetValidStr3(sC, sParam7, [' ', ':', ',',#9]);
    end;//004D20BF

    if CompareText(sCMD,g_GameCommand.PASSWORDLOCK.sCmd) = 0 then begin
      if not g_Config.boPasswordLockSystem then begin
        SysMsg(g_sNoPasswordLockSystemMsg,c_Red,t_Hint);
        exit;
      end;
      if m_sStoragePwd = '' then begin
        SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
        m_boSetStoragePwd:=True;
        SysMsg(g_sSetPasswordMsg,c_Green,t_Hint);
        exit;
      end;
      if m_btPwdFailCount > 3 then begin
        SysMsg(g_sStoragePasswordLockedMsg,c_Red,t_Hint);
        m_boPasswordLocked:=True;
        exit;
      end;
      if m_sStoragePwd <> '' then begin
        SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
        m_boCheckOldPwd:=True;
        SysMsg(g_sPleaseInputOldPasswordMsg,c_Green,t_Hint);
        exit;
      end;
      exit;
    end;
    
    if CompareText(sCMD,g_GameCommand.SETPASSWORD.sCmd) = 0 then begin
      if not g_Config.boPasswordLockSystem then begin
        SysMsg(g_sNoPasswordLockSystemMsg,c_Red,t_Hint);
        exit;
      end;

      if m_sStoragePwd = '' then begin
        SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
        m_boSetStoragePwd:=True;
        SysMsg(g_sSetPasswordMsg,c_Green,t_Hint);
      end else begin
        SysMsg(g_sAlreadySetPasswordMsg,c_Red,t_Hint);
      end;
      exit;
    end;
    
    if CompareText(sCMD,g_GameCommand.UNPASSWORD.sCmd) = 0 then begin
      if not g_Config.boPasswordLockSystem then begin
        SysMsg(g_sNoPasswordLockSystemMsg,c_Red,t_Hint);
        exit;
      end;
      if not m_boPasswordLocked then begin
        m_sStoragePwd:='';
        SysMsg(g_sOldPasswordIsClearMsg,c_Green,t_Hint);
      end else begin
        SysMsg(g_sPleaseUnLockPasswordMsg,c_Red,t_Hint);
      end;
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CHGPASSWORD.sCmd) = 0 then begin
      if not g_Config.boPasswordLockSystem then begin
        SysMsg(g_sNoPasswordLockSystemMsg,c_Red,t_Hint);
        exit;
      end;
      if m_btPwdFailCount > 3 then begin
        SysMsg(g_sStoragePasswordLockedMsg,c_Red,t_Hint);
        m_boPasswordLocked:=True;
        exit;
      end;
      if m_sStoragePwd <> '' then begin
        SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
        m_boCheckOldPwd:=True;
        SysMsg(g_sPleaseInputOldPasswordMsg,c_Green,t_Hint);
      end else begin
        SysMsg(g_sNoPasswordSetMsg,c_Red,t_Hint);
      end;
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.UNLOCKSTORAGE.sCmd) = 0 then begin
      if not g_Config.boPasswordLockSystem then begin
        SysMsg(g_sNoPasswordLockSystemMsg,c_Red,t_Hint);
        exit;
      end;
      if m_btPwdFailCount > g_Config.nPasswordErrorCountLock{3} then begin
        SysMsg(g_sStoragePasswordLockedMsg,c_Red,t_Hint);
        m_boPasswordLocked:=True;
        exit;
      end;
      if m_sStoragePwd <> '' then begin
        if not m_boUnLockStoragePwd then begin
          SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
          SysMsg(g_sPleaseInputUnLockPasswordMsg,c_Green,t_Hint);
          m_boUnLockStoragePwd:=True;
        end else begin
          SysMsg(g_sStorageAlreadyUnLockMsg,c_Red,t_Hint);
        end;
      end else begin
        SysMsg(g_sStorageNoPasswordMsg,c_Red,t_Hint);
      end;
      exit;
    end;

    if CompareText(sCMD,g_GameCommand.UNLOCK.sCmd) = 0 then begin
      if not g_Config.boPasswordLockSystem then begin
        SysMsg(g_sNoPasswordLockSystemMsg,c_Red,t_Hint);
        exit;
      end;
      if m_btPwdFailCount > g_Config.nPasswordErrorCountLock{3} then begin
        SysMsg(g_sStoragePasswordLockedMsg,c_Red,t_Hint);
        m_boPasswordLocked:=True;
        exit;
      end;
      if m_sStoragePwd <> '' then begin
        if not m_boUnLockPwd then begin
          SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
          SysMsg(g_sPleaseInputUnLockPasswordMsg,c_Green,t_Hint);
          m_boUnLockPwd:=True;
        end else begin
          SysMsg(g_sStorageAlreadyUnLockMsg,c_Red,t_Hint);
        end;
      end else begin
        SysMsg(g_sStorageNoPasswordMsg,c_Red,t_Hint);
      end;
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.LOCK.sCmd) = 0 then begin
      if not g_Config.boPasswordLockSystem then begin
        SysMsg(g_sNoPasswordLockSystemMsg,c_Red,t_Hint);
        exit;
      end;
      if not m_boPasswordLocked then begin
        if m_sStoragePwd <> '' then begin
          m_boPasswordLocked:=True;
          m_boCanGetBackItem:=False;
          SysMsg(g_sLockStorageSuccessMsg,c_Green,t_Hint);
        end else begin
          SysMsg(g_sStorageNoPasswordMsg,c_Green,t_Hint);
        end;
      end else begin
        SysMsg(g_sStorageAlreadyLockMsg,c_Red,t_Hint);
      end;
      exit;
    end;
    {
    if CompareText(sCMD,g_GameCommand.LOCK.sCmd) = 0 then begin
      if not m_boPasswordLocked then begin
        m_sStoragePwd:='';
        SysMsg(g_sStoragePasswordClearMsg,c_Green,t_Hint);
      end else begin
        SysMsg(g_sPleaseUnloadStoragePasswordMsg,c_Red,t_Hint);
      end;
      exit;
    end;
    }
    if CompareText(sCMD,g_GameCommand.MEMBERFUNCTION.sCmd) = 0 then begin
      CmdMemberFunction(g_GameCommand.MEMBERFUNCTION.sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.MEMBERFUNCTIONEX.sCmd) = 0 then begin
      CmdMemberFunctionEx(g_GameCommand.MEMBERFUNCTIONEX.sCmd,sParam1);
      exit;
    end;

    if CompareText(sCMD,g_GameCommand.DEAR.sCmd) = 0 then begin
      CmdSearchDear(g_GameCommand.DEAR.sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.MASTER.sCmd) = 0 then begin
      CmdSearchMaster(g_GameCommand.MASTER.sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.MASTERECALL.sCmd) = 0 then begin
      CmdMasterRecall(g_GameCommand.MASTERECALL.sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DEARRECALL.sCmd) = 0 then begin
      CmdDearRecall(g_GameCommand.DEARRECALL.sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ALLOWDEARRCALL.sCmd) = 0 then begin
      m_boCanDearRecall:= not m_boCanDearRecall;
      if m_boCanDearRecall then begin
        SysMsg(g_sEnableDearRecall,c_Blue,t_Hint);
      end else begin
        SysMsg(g_sDisableDearRecall,c_Blue,t_Hint);
      end;
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ALLOWMASTERRECALL.sCmd) = 0 then begin
      m_boCanMasterRecall:= not m_boCanMasterRecall;
      if m_boCanMasterRecall then begin
        SysMsg(g_sEnableMasterRecall,c_Blue,t_Hint);
      end else begin
        SysMsg(g_sDisableMasterRecall,c_Blue,t_Hint);
      end;
      exit;
    end;

    if CompareText(sCMD,g_GameCommand.DATA.sCmd) = 0 then begin
      SysMsg(g_sNowCurrDateTime + FormatDateTime('dddddd,dddd,hh:mm:nn', Now),c_Blue,t_Hint);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.PRVMSG.sCmd) = 0 then begin
      CmdPrvMsg(g_GameCommand.PRVMSG.sCmd,g_GameCommand.PRVMSG.nPermissionMin,sParam1);
      exit;
    end;

    if CompareText(sCMD,g_GameCommand.ALLOWMSG.sCmd) = 0 then begin
      m_boHearWhisper:= not m_boHearWhisper;
      if m_boHearWhisper then SysMsg(g_sEnableHearWhisper{'[Reject Whisper Deactivated]'},c_Green,t_Hint)
      else SysMsg(g_sDisableHearWhisper{'[Reject Whisper Activated]'},c_Green,t_Hint);
      exit;
    end;

    if CompareText(sCMD,g_GameCommand.LETSHOUT.sCmd) = 0 then begin
      m_boBanShout:= not m_boBanShout;
      if m_boBanShout then SysMsg(g_sEnableShoutMsg{'[Show Shout]'},c_Green,t_Hint)
      else SysMsg(g_sDisableShoutMsg{'[Hide Shout]'},c_Green,t_Hint);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.LETTRADE.sCmd) = 0 then begin
      m_boAllowDeal:= not m_boAllowDeal;
      if m_boAllowDeal then SysMsg(g_sEnableDealMsg{'[Allow Deal]'},c_Green,t_Hint)
      else SysMsg(g_sDisableDealMsg{'[Disallow Deal]'},c_Green,t_Hint);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.BANGUILDCHAT.sCmd) = 0 then begin
      m_boBanGuildChat:= not m_boBanGuildChat;
      if m_boBanGuildChat then SysMsg(g_sEnableGuildChat{'[Show Guild Chat]'},c_Green,t_Hint)
      else SysMsg(g_sDisableGuildChat{'[Hide Guild Chat]'},c_Green,t_Hint);
      exit;
    end;

    if CompareText(sCMD,g_GameCommand.LETGUILD.sCmd) = 0 then begin
      m_boAllowGuild:= not m_boAllowGuild;
      if m_boAllowGuild then SysMsg(g_sEnableJoinGuild{'[Allow Guild]'},c_Green,t_Hint)
      else SysMsg(g_sDisableJoinGuild{'[Reject Guild]'},c_Green,t_Hint);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ENDGUILD.sCmd) = 0 then begin
      CmdEndGuild();
      exit;
    end;

    if CompareText(sCMD,g_GameCommand.AUTHALLY.sCmd) = 0 then begin
      if IsGuildMaster then begin
        TGuild(m_MyGuild).m_boEnableAuthAlly:=not TGuild(m_MyGuild).m_boEnableAuthAlly;
        if TGuild(m_MyGuild).m_boEnableAuthAlly then SysMsg(g_sEnableAuthAllyGuild{'[Allow Ally]'},c_Green,t_Hint)
        else SysMsg(g_sDisableAuthAllyGuild{'[Disallow Ally]'},c_Green,t_Hint);
      end;
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ALLOWGROUPCALL.sCmd) = 0 then begin
      CmdAllowGroupReCall(sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.GROUPRECALLL.sCmd) = 0 then begin
      CmdGroupRecall(g_GameCommand.GROUPRECALLL.sCmd);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ALLOWGUILDRECALL.sCmd) = 0 then begin
      m_boAllowGuildReCall:= not m_boAllowGuildReCall;
      if m_boAllowGuildReCall then SysMsg(g_sEnableGuildRecall{'[Allow Guild Recall]'},c_Green,t_Hint)
      else SysMsg(g_sDisableGuildRecall{'[Disallow Guild Recall]'},c_Green,t_Hint);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.GUILDRECALLL.sCmd) = 0 then begin
      CmdGuildRecall(g_GameCommand.GUILDRECALLL.sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ALLIANCE.sCmd) = 0 then begin
      if IsGuildMaster then ClientGuildAlly();
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CANCELALLIANCE.sCmd) = 0 then begin
      if IsGuildMaster then ClientGuildBreakAlly(sParam1);
      exit;
    end;

    if CompareText(sCMD,g_GameCommand.DIARY.sCmd) = 0 then begin
      CmdViewDiary(g_GameCommand.DIARY.sCmd,Str_ToInt(sParam1,0));
      exit;
    end;

    if CompareText(sCMD,g_GameCommand.ATTACKMODE.sCmd) = 0 then begin
      CmdChangeAttackMode(Str_ToInt(sParam1,-1),sParam1,sParam2,sParam3,sParam4,sParam5,sParam6,sParam7);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.REST.sCmd) = 0 then begin
      CmdChangeSalveStatus();
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.TAKEONHORSE.sCmd) = 0 then begin
      CmdTakeOnHorse(sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.TAKEOFHORSE.sCmd) = 0 then begin
      CmdTakeOffHorse(sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SVNINFO.sCmd) = 0 then begin
      CmdSvnInfo(@g_GameCommand.SVNINFO,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.TRADEGT.sCmd) = 0 then begin
      CmdTradeGT(@g_GameCommand.TRADEGT);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.TESTGA.sCmd) = 0 then begin //004D25C5
      exit;
      SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
      m_boTestGa:=True;
      SysMsg(g_sPleaseInputPassword{'Password: '},c_Green,t_Hint);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.MAPINFO.sCmd) = 0 then begin
      ShowMapInfo(sParam1,sParam2,sParam3);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CLEARBAG.sCmd) = 0 then begin
      CmdClearBagItem(@g_GameCommand.CLEARBAG,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHOWUSEITEMINFO.sCmd) = 0 then begin
      CmdShowUseItemInfo(@g_GameCommand.SHOWUSEITEMINFO,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.BINDUSEITEM.sCmd) = 0 then begin
      CmdBindUseItem(@g_GameCommand.BINDUSEITEM,sParam1,sParam2,sParam3);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SBKDOOR.sCmd) = 0 then begin //004D2610
      CmdSbkDoorControl(g_GameCommand.SBKDOOR.sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.USERMOVE.sCmd) = 0 then begin
      CmdUserMoveXY(g_GameCommand.USERMOVE.sCmd,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SEARCHING.sCmd) = 0 then begin
      CmdSearchHuman(g_GameCommand.SEARCHING.sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.LOCKLOGON.sCmd) = 0 then begin
      CmdLockLogin(@g_GameCommand.LOCKLOGON);
      exit;
    end;
    if (m_btPermission >= 2) and (length(sData) > 2) then begin
      //if sData[2] = '!' then begin
      if (m_btPermission >= 6) and (sData[2] = g_GMRedMsgCmd) then begin

        if GetTickCount - m_dwSayMsgTick > 2000 then begin
          m_dwSayMsgTick:=GetTickCount();
          sData:=Copy(sData,3,length(sData) - 2);
          if length(sData) > g_Config.nSayRedMsgMaxLen then begin
            sData:=Copy(sData,1,g_Config.nSayRedMsgMaxLen);
          end;

          if g_Config.boShutRedMsgShowGMName then
            sC:=m_sCharName + ': ' + sData
          else sC:=sData;
          UserEngine.SendBroadCastMsg(sC,t_GM);
        end;
        exit;
      end;
    end;
    //004D2C70
    if CompareText(sCMD,g_GameCommand.HUMANLOCAL.sCmd) = 0 then begin
      CmdHumanLocal(@g_GameCommand.HUMANLOCAL,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.MOVE.sCmd) = 0 then begin
      CmdMapMove(@g_GameCommand.MOVE,sParam1);
      Exit;
    end;//004D2CD0
    if CompareText(sCMD,g_GameCommand.POSITIONMOVE.sCmd) = 0 then begin
      CmdPositionMove(@g_GameCommand.POSITIONMOVE,sParam1,sParam2,sParam3);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.INFO.sCmd) = 0 then begin
      CmdHumanInfo(@g_GameCommand.INFO,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.MOBLEVEL.sCmd) = 0 then begin
      CmdMobLevel(@g_GameCommand.MOBLEVEL,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.MOBCOUNT.sCmd) = 0 then begin
      CmdMobCount(@g_GameCommand.MOBCOUNT,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.HUMANCOUNT.sCmd) = 0 then begin
      CmdHumanCount(@g_GameCommand.HUMANCOUNT,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.KICK.sCmd) = 0 then begin
      CmdKickHuman(@g_GameCommand.KICK,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.TING.sCmd) = 0 then begin
      CmdTing(@g_GameCommand.TING,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.SUPERTING.sCmd) = 0 then begin
      CmdSuperTing(@g_GameCommand.SUPERTING,sParam1,sParam2);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.MAPMOVE.sCmd) = 0 then begin
      CmdMapMoveHuman(@g_GameCommand.MAPMOVE,sParam1,sParam2);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHUTUP.sCmd) = 0 then begin
      CmdShutup(@g_GameCommand.SHUTUP,sParam1,sParam2);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.MAP.sCmd) = 0 then begin
      CmdShowMapInfo(@g_GameCommand.MAP,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.RELEASESHUTUP.sCmd) = 0 then begin
      CmdShutupRelease(@g_GameCommand.RELEASESHUTUP,sParam1,True);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHUTUPLIST.sCmd) = 0 then begin
      CmdShutupList(@g_GameCommand.SHUTUPLIST,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.GAMEMASTER.sCmd) = 0 then begin
      CmdChangeAdminMode(g_GameCommand.GAMEMASTER.sCmd,g_GameCommand.GAMEMASTER.nPermissionMin,sParam1,not m_boAdminMode);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.OBSERVER.sCmd) = 0 then begin
      CmdChangeObMode(g_GameCommand.OBSERVER.sCmd,g_GameCommand.OBSERVER.nPermissionMin,sParam1,not m_boObMode);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.SUEPRMAN.sCmd) = 0 then begin
      CmdChangeSuperManMode(g_GameCommand.OBSERVER.sCmd,g_GameCommand.OBSERVER.nPermissionMin,sParam1,not m_boSuperMan);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.LEVEL.sCmd) = 0 then begin
      CmdChangeLevel(@g_GameCommand.LEVEL,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.SABUKWALLGOLD.sCmd) = 0 then begin
      CmdShowSbkGold(@g_GameCommand.SABUKWALLGOLD,sParam1,sParam2,sParam3);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.RECALL.sCmd) = 0 then begin
      CmdRecallHuman(@g_GameCommand.RECALL,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.REGOTO.sCmd) = 0 then begin
      CmdReGotoHuman(@g_GameCommand.REGOTO,sParam1);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHOWFLAG.sCmd) = 0 then begin
      CmdShowHumanFlag(g_GameCommand.SHOWFLAG.sCmd,g_GameCommand.SHOWFLAG.nPermissionMin,sParam1,sParam2);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHOWOPEN.sCmd) = 0 then begin
      CmdShowHumanUnitOpen(g_GameCommand.SHOWOPEN.sCmd,g_GameCommand.SHOWOPEN.nPermissionMin,sParam1,sParam2);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHOWUNIT.sCmd) = 0 then begin
      CmdShowHumanUnit(g_GameCommand.SHOWUNIT.sCmd,g_GameCommand.SHOWUNIT.nPermissionMin,sParam1,sParam2);
      Exit;
    end;
    if CompareText(sCMD,g_GameCommand.ATTACK.sCmd) = 0 then begin
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.MOB.sCmd) = 0 then begin
      CmdMob(@g_GameCommand.MOB,sParam1,Str_ToInt(sParam2,0),Str_ToInt(sParam3,0), Str_ToInt(sParam4,-1));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.MOBNPC.sCmd) = 0 then begin
      CmdMobNpc(g_GameCommand.MOBNPC.sCmd,g_GameCommand.MOBNPC.nPermissionMin,sParam1,sParam2,sParam3,sParam4);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.NPCSCRIPT.sCmd) = 0 then begin
      CmdNpcScript(g_GameCommand.NPCSCRIPT.sCmd,g_GameCommand.NPCSCRIPT.nPermissionMin,sParam1,sParam2,sParam3);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DELNPC.sCmd) = 0 then begin
      CmdDelNpc(g_GameCommand.DELNPC.sCmd,g_GameCommand.DELNPC.nPermissionMin,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.RECALLMOB.sCmd) = 0 then begin
      CmdRecallMob(@g_GameCommand.RECALLMOB,sParam1,Str_ToInt(sParam2,0),Str_ToInt(sParam3,0),Str_ToInt(sParam4,0),Str_ToInt(sParam5,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.LUCKYPOINT.sCmd) = 0 then begin
      CmdLuckPoint(g_GameCommand.LUCKYPOINT.sCmd,g_GameCommand.LUCKYPOINT.nPermissionMin,sParam1,sParam2,sParam3);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.LOTTERYTICKET.sCmd) = 0 then begin
      CmdLotteryTicket(g_GameCommand.LOTTERYTICKET.sCmd,g_GameCommand.LOTTERYTICKET.nPermissionMin,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.RELOADGUILD.sCmd) = 0 then begin
      CmdReloadGuild(g_GameCommand.RELOADGUILD.sCmd,g_GameCommand.RELOADGUILD.nPermissionMin,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.RELOADLINENOTICE.sCmd) = 0 then begin
      CmdReloadLineNotice(g_GameCommand.RELOADLINENOTICE.sCmd,g_GameCommand.RELOADLINENOTICE.nPermissionMin,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.RELOADABUSE.sCmd) = 0 then begin
      CmdReloadAbuse(g_GameCommand.RELOADABUSE.sCmd,g_GameCommand.RELOADABUSE.nPermissionMin,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.FREEPENALTY.sCmd) = 0 then begin
      CmdFreePenalty(@g_GameCommand.FREEPENALTY,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.PKPOINT.sCmd) = 0 then begin
      CmdPKpoint(@g_GameCommand.PKPOINT,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.INCPKPOINT.sCmd) = 0 then begin
      CmdIncPkPoint(@g_GameCommand.INCPKPOINT,sParam1,Str_ToInt(sParam2,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.MAKE.sCmd) = 0 then begin
      CmdMakeItem(@g_GameCommand.MAKE,sParam1,Str_ToInt(sParam2,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.VIEWWHISPER.sCmd) = 0 then begin
      CmdViewWhisper(@g_GameCommand.VIEWWHISPER,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.REALIVE.sCmd) = 0 then begin
      CmdReAlive(@g_GameCommand.REALIVE,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.KILL.sCmd) = 0 then begin
      CmdKill(@g_GameCommand.KILL,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SMAKE.sCmd) = 0 then begin
      CmdSmakeItem(@g_GameCommand.SMAKE,Str_ToInt(sParam1,0),Str_ToInt(sParam2,0),Str_ToInt(sParam3,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CHANGEJOB.sCmd) = 0 then begin
      CMdChangeJob(@g_GameCommand.CHANGEJOB,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CHANGEGENDER.sCmd) = 0 then begin
      CmdChangeGender(@g_GameCommand.CHANGEGENDER,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.HAIR.sCmd) = 0 then begin
      CmdHair(@g_GameCommand.HAIR,sParam1,Str_ToInt(sParam2,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.BONUSPOINT.sCmd) = 0 then begin
      CmdBonuPoint(@g_GameCommand.BONUSPOINT,sParam1,Str_ToInt(sParam2,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DELBONUSPOINT.sCmd) = 0 then begin
      CmdDelBonuPoint(@g_GameCommand.DELBONUSPOINT,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.RESTBONUSPOINT.sCmd) = 0 then begin
      CmdRestBonuPoint(@g_GameCommand.RESTBONUSPOINT,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SETPERMISSION.sCmd) = 0 then begin
      CmdSetPermission(@g_GameCommand.SETPERMISSION,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.RENEWLEVEL.sCmd) = 0 then begin
      CmdReNewLevel(@g_GameCommand.RENEWLEVEL,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DELGOLD.sCmd) = 0 then begin
      CmdDelGold(@g_GameCommand.DELGOLD,sParam1,Str_ToInt(sParam2,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ADDGOLD.sCmd) = 0 then begin
      CmdAddGold(@g_GameCommand.ADDGOLD,sParam1,Str_ToInt(sParam2,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.GAMEGOLD.sCmd) = 0 then begin
      CmdGameGold(@g_GameCommand.GAMEGOLD,sParam1,sParam2,Str_ToInt(sParam3,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.GAMEPOINT.sCmd) = 0 then begin
      CmdGamePoint(@g_GameCommand.GAMEPOINT,sParam1,sParam2,Str_ToInt(sParam3,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CREDITPOINT.sCmd) = 0 then begin
      CmdCreditPoint(@g_GameCommand.CREDITPOINT,sParam1,sParam2,Str_ToInt(sParam3,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.TRAINING.sCmd) = 0 then begin
      CmdTrainingSkill(@g_GameCommand.TRAINING,sParam1,sParam2,Str_ToInt(sParam3,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DELETEITEM.sCmd) = 0 then begin
      CmdDeleteItem(@g_GameCommand.DELETEITEM,sParam1,sParam2,Str_ToInt(sParam3,1));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DELETESKILL.sCmd) = 0 then begin
      CmdDelSkill(@g_GameCommand.DELETESKILL,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.TRAININGSKILL.sCmd) = 0 then begin
      CmdTrainingMagic(@g_GameCommand.TRAININGSKILL,sParam1,sParam2,Str_ToInt(sParam3,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CLEARMISSION.sCmd) = 0 then begin
      CmdClearMission(@g_GameCommand.CLEARMISSION,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.STARTQUEST.sCmd) = 0 then begin
      CmdStartQuest(@g_GameCommand.STARTQUEST,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DENYIPLOGON.sCmd) = 0 then begin
      CmdDenyIPaddrLogon(@g_GameCommand.DENYIPLOGON,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CHANGEDEARNAME.sCmd) = 0 then begin
      CmdChangeDearName(@g_GameCommand.CHANGEDEARNAME,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CHANGEMASTERNAME.sCmd) = 0 then begin
      CmdChangeMasterName(@g_GameCommand.CHANGEMASTERNAME,sParam1,sParam2,sParam3);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CLEARMON.sCmd) = 0 then begin
      CmdClearMapMonster(@g_GameCommand.CLEARMON,sParam1,sParam2,sParam3);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DENYACCOUNTLOGON.sCmd) = 0 then begin
      CmdDenyAccountLogon(@g_GameCommand.DENYACCOUNTLOGON,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DENYCHARNAMELOGON.sCmd) = 0 then begin
      CmdDenyCharNameLogon(@g_GameCommand.DENYCHARNAMELOGON,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DELDENYIPLOGON.sCmd) = 0 then begin
      CmdDelDenyIPaddrLogon(@g_GameCommand.DELDENYIPLOGON,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DELDENYACCOUNTLOGON.sCmd) = 0 then begin
      CmdDelDenyAccountLogon(@g_GameCommand.DELDENYACCOUNTLOGON,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DELDENYCHARNAMELOGON.sCmd) = 0 then begin
      CmdDelDenyCharNameLogon(@g_GameCommand.DELDENYCHARNAMELOGON,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHOWDENYIPLOGON.sCmd) = 0 then begin
      CmdShowDenyIPaddrLogon(@g_GameCommand.SHOWDENYIPLOGON,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHOWDENYACCOUNTLOGON.sCmd) = 0 then begin
      CmdShowDenyAccountLogon(@g_GameCommand.SHOWDENYACCOUNTLOGON,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHOWDENYCHARNAMELOGON.sCmd) = 0 then begin
      CmdShowDenyCharNameLogon(@g_GameCommand.SHOWDENYCHARNAMELOGON,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.MISSION.sCmd) = 0 then begin
      CmdMission(@g_GameCommand.MISSION,sParam1,sParam2);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.MOBPLACE.sCmd) = 0 then begin
      CmdMobPlace(@g_GameCommand.MOBPLACE,sParam1,sParam2,sParam3,sParam4);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SETMAPMODE.sCmd) = 0 then begin
      CmdSetMapMode(g_GameCommand.SETMAPMODE.sCmd,sParam1,sParam2,sParam3,sParam4);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.SHOWMAPMODE.sCmd) = 0 then begin
      CmdShowMapMode(g_GameCommand.SHOWMAPMODE.sCmd,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CLRPASSWORD.sCmd) = 0 then begin
      CmdClearHumanPassword(g_GameCommand.CLRPASSWORD.sCmd,g_GameCommand.CLRPASSWORD.nPermissionMin,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.CONTESTPOINT.sCmd) = 0 then begin
      CmdContestPoint(@g_GameCommand.CONTESTPOINT,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.STARTCONTEST.sCmd) = 0 then begin
      CmdStartContest(@g_GameCommand.STARTCONTEST,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ENDCONTEST.sCmd) = 0 then begin
      CmdEndContest(@g_GameCommand.ENDCONTEST,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ANNOUNCEMENT.sCmd) = 0 then begin
      CmdAnnouncement(@g_GameCommand.ANNOUNCEMENT,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DISABLESENDMSG.sCmd) = 0 then begin
      CmdDisableSendMsg(@g_GameCommand.DISABLESENDMSG,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.ENABLESENDMSG.sCmd) = 0 then begin
      CmdEnableSendMsg(@g_GameCommand.ENABLESENDMSG,sParam1);
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.REFINEWEAPON.sCmd) = 0 then begin
      CmdRefineWeapon(@g_GameCommand.REFINEWEAPON,Str_ToInt(sParam1,0),Str_ToInt(sParam2,0),Str_ToInt(sParam3,0),Str_ToInt(sParam4,0));
      exit;
    end;
    if CompareText(sCMD,g_GameCommand.DISABLESENDMSGLIST.sCmd) = 0 then begin
      CmdDisableSendMsgList(@g_GameCommand.DISABLESENDMSGLIST);
      exit;
    end;
    if m_btPermission > 4 then begin
      if CompareText(sCMD,g_GameCommand.BACKSTEP.sCmd) = 0 then begin
        CmdBackStep(sCmd,Str_ToInt(sParam1,0),Str_ToInt(sParam2,1));
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.BALL.sCmd) = 0 then begin //精神波
        exit;
      end;

      if CompareText(sCMD,g_GameCommand.CHANGELUCK.sCmd) = 0 then begin
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.HUNGER.sCmd) = 0 then begin
        CmdHunger(g_GameCommand.HUNGER.sCmd,sParam1,Str_ToInt(sParam2,0));
        exit;
      end;

      if CompareText(sCMD,g_GameCommand.NAMECOLOR.sCmd) = 0 then begin
        exit;
      end;

      if CompareText(sCMD,g_GameCommand.TRANSPARECY.sCmd) = 0 then begin
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.LEVEL0.sCmd) = 0 then begin
        exit;
      end;

      if CompareText(sCMD,g_GameCommand.SETFLAG.sCmd) = 0 then begin //004D3BDD
        PlayObject:=UserEngine.GeTPlayObject(sParam1);
        if PlayObject <> nil then begin
          nFlag:=Str_ToInt(sParam2,0);
          nValue:=Str_ToInt(sParam3,0);
          PlayObject.SetQuestFlagStatus(nFlag,nValue);
          if PlayObject.GetQuestFalgStatus(nFlag) = 1 then begin
            SysMsg(PlayObject.m_sCharName + ': [' + IntToStr(nFlag) + '] = ON',c_Green,t_Hint);
          end else begin
            SysMsg(PlayObject.m_sCharName + ': [' + IntToStr(nFlag) + '] = OFF',c_Green,t_Hint);
          end;
        end else begin
          SysMsg('@' + g_GameCommand.SETFLAG.sCmd + ' Username Flag (0 - 1)',c_Red,t_Hint);
        end;
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.SETOPEN.sCmd) = 0 then begin
        PlayObject:=UserEngine.GeTPlayObject(sParam1);
        if PlayObject <> nil then begin
          nFlag:=Str_ToInt(sParam2,0);
          nValue:=Str_ToInt(sParam3,0);
          PlayObject.SetQuestUnitOpenStatus(nFlag,nValue);
          if PlayObject.GetQuestUnitOpenStatus(nFlag) = 1 then begin
            SysMsg(PlayObject.m_sCharName + ': [' + IntToStr(nFlag) + '] = ON',c_Green,t_Hint);
          end else begin
            SysMsg(PlayObject.m_sCharName + ': [' + IntToStr(nFlag) + '] = OFF',c_Green,t_Hint);
          end;
        end else begin
          SysMsg('@' + g_GameCommand.SETOPEN.sCmd + ' Username Flag On/Off(0 - 1)',c_Red,t_Hint);
        end;
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.SETUNIT.sCmd) = 0 then begin
        PlayObject:=UserEngine.GeTPlayObject(sParam1);
        if PlayObject <> nil then begin
          nFlag:=Str_ToInt(sParam2,0);
          nValue:=Str_ToInt(sParam3,0);
          PlayObject.SetQuestUnitStatus(nFlag,nValue);
          if PlayObject.GetQuestUnitStatus(nFlag) = 1 then begin
            SysMsg(PlayObject.m_sCharName + ': [' + IntToStr(nFlag) + '] = ON',c_Green,t_Hint);
          end else begin
            SysMsg(PlayObject.m_sCharName + ': [' + IntToStr(nFlag) + '] = OFF',c_Green,t_Hint);
          end;
        end else begin
          SysMsg('@' + g_GameCommand.SETUNIT.sCmd + ' Username Flag On/Off(0 - 1)',c_Red,t_Hint);
        end;
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.RECONNECTION.sCmd) = 0 then begin
        CmdReconnection(sCmd,sParam1,sParam2);
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.DISABLEFILTER.sCmd) = 0 then begin
        CmdDisableFilter(sCmd,sParam1);
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.CHGUSERFULL.sCmd) = 0 then begin
        CmdChangeUserFull(sCmd,sParam1);
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.CHGZENFASTSTEP.sCmd) = 0 then begin
        CmdChangeZenFastStep(sCmd,sParam1);
        exit;
      end;

      if CompareText(sCMD,g_GameCommand.OXQUIZROOM.sCmd) = 0 then begin
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.GSA.sCmd) = 0 then begin
        exit;
      end;
      if CompareText(sCMD,g_GameCommand.CHANGEITEMNAME.sCmd) = 0 then begin
        CmdChangeItemName(g_GameCommand.CHANGEITEMNAME.sCmd,sParam1,sParam2,sParam3);
        exit;
      end;
      if (m_btPermission >= 5) or (g_Config.boTestServer)then begin

        if CompareText(sCMD,g_GameCommand.FIREBURN.sCmd) = 0 then begin
          CmdFireBurn(Str_ToInt(sParam1,0),Str_ToInt(sParam2,0),Str_ToInt(sParam3,0));
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.TESTFIRE.sCmd) = 0 then begin
          CmdTestFire(sCmd,Str_ToInt(sParam1,0),Str_ToInt(sParam2,0),Str_ToInt(sParam3,0),Str_ToInt(sParam4,0));
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.TESTSTATUS.sCmd) = 0 then begin
          CmdTestStatus(sCmd,Str_ToInt(sParam1,-1),Str_ToInt(sParam2,0));
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.DELGAMEGOLD.sCmd) = 0 then begin
          CmdDelGameGold(g_GameCommand.DELGAMEGOLD.sCmd,sParam1,Str_ToInt(sParam2,0));
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.ADDGAMEGOLD.sCmd) = 0 then begin
          CmdAddGameGold(g_GameCommand.ADDGAMEGOLD.sCmd,sParam1,Str_ToInt(sParam2,0));
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.TESTGOLDCHANGE.sCmd) = 0 then begin
          exit;
        end;

        if CompareText(sCMD,g_GameCommand.RELOADADMIN.sCmd) = 0 then begin
          CmdReLoadAdmin(g_GameCommand.RELOADADMIN.sCmd);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADNPC.sCmd) = 0 then begin
          CmdReloadNpc(sParam1);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADMANAGE.sCmd) = 0 then begin
          CmdReloadManage(@g_GameCommand.RELOADMANAGE,sParam1);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADROBOTMANAGE.sCmd) = 0 then begin
          CmdReloadRobotManage();
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADROBOT.sCmd) = 0 then begin
          CmdReloadRobot();
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADMONITEMS.sCmd) = 0 then begin
          CmdReLoadMonitems();
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADDIARY.sCmd) = 0 then begin
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADITEMDB.sCmd) = 0 then begin
          FrmDB.LoadItemsDB();
          SysMsg('Item DB Reloaded.',c_Green,t_Hint);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADMAGICDB.sCmd) = 0 then begin
          //FrmDB.LoadMagicDB();
          //SysMsg('Magic DB has been reloaded',c_Green,t_Hint);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADMONSTERDB.sCmd) = 0 then begin
          FrmDB.LoadMonsterDB();
          SysMsg('Monster DB Reloaded.',c_Green,t_Hint);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.RELOADMINMAP.sCmd) = 0 then begin
          {$IFDEF UseTXT}
            FrmDB.LoadMinMap();
            g_MapManager.ReSetMinMap();
            SysMsg('Minimaps Reloaded.',c_Green,t_Hint);
          {$ELSE}
            SysMsg('Minimaps Reloaded. (Not Added Yet)',c_Green,t_Hint);
          {$ENDIF}
          exit;
        end;

        if CompareText(sCMD,g_GameCommand.RELOADBIGMAP.sCmd) = 0 then begin
          {$IFDEF UseTXT}
            FrmDB.LoadBigMap();
            g_MapManager.ReSetBigMap();
            SysMsg('Bigmaps Reloaded.',c_Green,t_Hint);
          {$ELSE}
            SysMsg('Bigmaps Reloaded. (Not Added Yet)',c_Green,t_Hint);
          {$ENDIF}
          exit;
        end;

        if CompareText(sCMD,g_GameCommand.ADJUESTLEVEL.sCmd) = 0 then begin
          CmdAdjuestLevel(@g_GameCommand.ADJUESTLEVEL,sParam1,Str_ToInt(sParam2,1));
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.ADJUESTEXP.sCmd) = 0 then begin
          CmdAdjuestExp(@g_GameCommand.ADJUESTEXP,sParam1,sParam2);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.ADDGUILD.sCmd) = 0 then begin
          CmdAddGuild(@g_GameCommand.ADDGUILD,sParam1,sParam2);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.DELGUILD.sCmd) = 0 then begin
          CmdDelGuild(@g_GameCommand.DELGUILD,sParam1);
          exit;
        end;
        if (CompareText(sCMD,g_GameCommand.CHANGESABUKLORD.sCmd) = 0) then begin
          CmdChangeSabukLord(@g_GameCommand.CHANGESABUKLORD,sParam1,sParam2,True);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.FORCEDWALLCONQUESTWAR.sCmd) = 0 then begin
          CmdForcedWallconquestWar(@g_GameCommand.FORCEDWALLCONQUESTWAR,sParam1);
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.ADDTOITEMEVENT.sCmd) = 0 then begin
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.ADDTOITEMEVENTASPIECES.sCmd) = 0 then begin
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.ITEMEVENTLIST.sCmd) = 0 then begin
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.STARTINGGIFTNO.sCmd) = 0 then begin
          exit;
        end;
        if CompareText(sCMD,g_GameCommand.DELETEALLITEMEVENT.sCmd) = 0 then begin
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.STARTITEMEVENT.sCmd) = 0 then begin
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.ITEMEVENTTERM.sCmd) = 0 then begin
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.ADJUESTTESTLEVEL.sCmd) = 0 then begin
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.OPDELETESKILL.sCmd) = 0 then begin
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.CHANGEWEAPONDURA.sCmd) = 0 then begin
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.RELOADGUILDALL.sCmd) = 0 then begin
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.SPIRIT.sCmd) = 0 then begin
          CmdSpirtStart(g_GameCommand.SPIRIT.sCmd,sParam1);
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.SPIRITSTOP.sCmd) = 0 then begin
          CmdSpirtStop(g_GameCommand.SPIRITSTOP.sCmd,sParam1);
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.TESTSERVERCONFIG.sCmd) = 0 then begin
          SendServerConfig();
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.SERVERSTATUS.sCmd) = 0 then begin
          SendServerStatus();
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.TESTGETBAGITEM.sCmd) = 0 then begin
          CmdTestGetBagItems(@g_GameCommand.TESTGETBAGITEM,sParam1);
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.MOBFIREBURN.sCmd) = 0 then begin
          CmdMobFireBurn(@g_GameCommand.MOBFIREBURN,sParam1,sParam2,sParam3,sParam4,sParam5,sParam6);
          exit;
        end else
        if CompareText(sCMD,g_GameCommand.TESTSPEEDMODE.sCmd) = 0 then begin
          CmdTestSpeedMode(@g_GameCommand.TESTSPEEDMODE);
          exit;
        end;
      end;
    end;//004D52B5
    SysMsg('@' + sCMD + ' is an unknown command.',c_Red,t_Hint);
except
  on e: Exception do begin
    MainOutMessage(format(sExceptionMsg,[sData]));
    MainOutMessage(E.Message);
  end;
end;
end;
// else begin//004D4D8B
procedure TPlayObject.ProcessSayMsg(sData:String);
var
  boDisableSayMsg:Boolean;
  sC,sCryCryMsg,sParam1:String;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject.ProcessSayMsg Msg = %s';
begin
  try
    if length(sData) > g_Config.nSayMsgMaxLen then begin
      sData:=Copy(sData,1,g_Config.nSayMsgMaxLen);
    end;

    if {(sData = m_sOldSayMsg) and} ((GetTickCount - m_dwSayMsgTick) < g_Config.dwSayMsgTime{3 * 1000}) then begin
      Inc(m_nSayMsgCount);
      if m_nSayMsgCount >= g_Config.nSayMsgCount{2} then begin
        m_boDisableSayMsg:=True;
        m_dwDisableSayMsgTick:=GetTickCount + g_Config.dwDisableSayMsgTime{60 * 1000};
        SysMsg(format(g_sDisableSayMsg,[g_Config.dwDisableSayMsgTime div (60 * 1000)]),c_Red,t_Hint);
      end;
    end else begin  //004D4DF6
      m_dwSayMsgTick:=GetTickCount();
      m_nSayMsgCount:=0;
    end;

    if GetTickCount >= m_dwDisableSayMsgTick  then m_boDisableSayMsg:=False;
    boDisableSayMsg:=m_boDisableSayMsg;
    g_DenySayMsgList.Lock;
    try
      if g_DenySayMsgList.GetIndex(m_sCharName) >= 0 then boDisableSayMsg:=True;
    finally
      g_DenySayMsgList.UnLock;
    end;

    if not (boDisableSayMsg or m_PEnvir.Flag.boNOCHAT) then begin
      //Log it..
      try
        g_ChatLoggingList.Lock;
        g_ChatLoggingList.Add('['+DateTimeToStr(Now)+'] ' +m_sCharName+ ': ' +sData);
      finally
        g_ChatLoggingList.unLock;
      end;

      m_sOldSayMsg:=sData;
      if sData[1] = '/' then begin
        sC:=Copy(sData,2,length(sData) - 1);
        if CompareText(Trim(sC),Trim(g_GameCommand.WHO.sCmd)) = 0 then begin
          if (m_btPermission < g_GameCommand.WHO.nPermissionMin) then begin
            SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
            exit;
          end;
          HearMsg(format(g_sOnlineCountMsg,[UserEngine.PlayObjectCount]));
          exit;
        end; //004D4F03
        if CompareText(Trim(sC),Trim(g_GameCommand.TOTAL.sCmd)) = 0 then begin
          if (m_btPermission < g_GameCommand.TOTAL.nPermissionMin) then begin
            SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
            exit;
          end;
          HearMsg(format(g_sTotalOnlineCountMsg,[g_nTotalHumCount]));
          exit;
        end ;  //004D4F5B
        sC:=GetValidStr3(sC,sParam1,[' ']);
        if not m_boFilterSendMsg then
          Whisper(sParam1,sC);
        exit;
      end;
      if sData[1] = '!' then begin
        if length(sData) >= 2 then begin
          if sData[2] = '!' then begin
            sC:=Copy(sData,3,length(sData) - 2);
            SendGroupText(m_sCharName + ': ' + sC);
            exit;
          end;
          if sData[2] = '~' then begin
            if m_MyGuild <> nil then begin
              sC:=Copy(sData,3,length(sData) - 2);
              TGuild(m_MyGuild).SendGuildMsg(m_sCharName + ': ' + sC);
              UserEngine.SendServerGroupMsg(SS_208,nServerIndex,TGuild(m_MyGuild).sGuildName + '/' + m_sCharName + '/' +sC);
            end;
            exit;
          end;
        end; //004D512C
        if not m_PEnvir.Flag.boQUIZ then begin
          if (GetTickCount - m_dwShoutMsgTick) > 10 * 1000 then begin
            if m_Abil.Level <= g_Config.nCanShoutMsgLevel then begin
              SysMsg(format(g_sYouNeedLevelMsg,[g_Config.nCanShoutMsgLevel + 1]),c_Red,t_Hint);
              exit;
            end;
            m_dwShoutMsgTick:=GetTickCount();
            sC:=Copy(sData,2,length(sData) -1);
            sCryCryMsg:='(!)' + m_sCharName + ': ' + sC;
            if m_boFilterSendMsg then begin
              SendMsg(nil,RM_CRY,0,0,$FFFF,0,sCryCryMsg);
            end else begin
              UserEngine.CryCry(RM_CRY,m_PEnvir,m_nCurrX,m_nCurrY,50,g_Config.btCryMsgFColor,g_Config.btCryMsgBColor,sCryCryMsg);
            end;
            exit;
          end;
          //SysMsg(IntToStr(10 - (GetTickCount - m_dwShoutMsgTick) div 1000) + '  Seconds爐ill爕ou燾an爏hout.',c_Red,t_Hint);
          SysMsg(format(g_sYouCanSendCyCyLaterMsg,[10 - (GetTickCount - m_dwShoutMsgTick) div 1000]),c_Red,t_Hint);

          exit;
        end;
        SysMsg(g_sThisMapDisableSendCyCyMsg{'Cannot shout on this map.'},c_Red,t_Hint);
        exit;
      end;  //004D5299
      if m_boFilterSendMsg then begin
        SendMsg(Self,RM_HEAR,0,g_Config.btHearMsgFColor,g_Config.btHearMsgBColor,0,m_sCharName + ': ' + sData);
      end else begin
        inherited;
      end;
//      ProcessSayMsg(sData);
      exit;
    end;
    SysMsg(g_sYouIsDisableSendMsg{'Chat ban'},c_Red,t_Hint);
except
  on e: Exception do begin
    MainOutMessage(format(sExceptionMsg,[sData]));
    MainOutMessage(E.Message);
  end;
end;
end;

function TPlayObject.ClientHitXY(wIdent: Word; nX, nY, nDir: Integer;boLateDelivery:Boolean;var dwDelayTime:LongWord): Boolean; //004CB7F8
var
  n14,n18:Integer;
  StdItem:TItem;
  dwAttackTime,dwCheckTime:LongWord;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::ClientHitXY';
begin

  Result:=False;
  dwDelayTime:=0;
try
  if not m_boCanHit then exit;

  if m_boDeath or ((m_wStatusTimeArr[POISON_STONE{5}]{0x6A} <> 0) and not g_Config.ClientConf.boParalyCanHit) then exit;//防麻
  if not boLateDelivery then begin
    if not CheckActionStatus(wIdent,dwDelayTime) then begin
      m_boFilterAction:=False;
      exit;
    end;
    m_boFilterAction:=True;
    dwAttackTime:=_MAX(0,Integer(g_Config.dwHitIntervalTime) - m_nHitSpeed * g_Config.ClientConf.btItemSpeed); //防止负数出错
    dwCheckTime:=GetTickCount - m_dwAttackTick;
    if dwCheckTime < dwAttackTime then begin
      Inc(m_dwAttackCount);
      dwDelayTime:=dwAttackTime - dwCheckTime;
      if dwDelayTime > g_Config.dwDropOverSpeed then  begin
        if m_dwAttackCount >= 4 then begin
          m_dwAttackTick:=GetTickCount();
          m_dwAttackCount:=0;
          dwDelayTime:=g_Config.dwDropOverSpeed;
          if m_boTestSpeedMode then
            SysMsg('Attack speed is ' + IntToStr(dwDelayTime),c_Red,t_Hint);
        end else m_dwAttackCount:=0;
        exit;
      end else begin
        if m_boTestSpeedMode then
          SysMsg('Attack speed is ' + IntToStr(dwDelayTime),c_Red,t_Hint);
        exit;
      end;
    end;
  end;
  {
  if (GetTickCount - m_dwAttackTick) > (900 - m_btHitSpeed * 60) then begin
    m_dwAttackCount:=0;
    if m_dwAttackCountA > 0 then Dec(m_dwAttackCountA);
  end else begin
    Inc(m_dwAttackCount);
    Inc(m_dwAttackCountA);
  end;

  if (m_dwAttackCount >= 4) or (m_dwAttackCountA >= 6) then begin
    m_dwAttackTick:=GetTickCount();
    Inc(m_dwOverSpeedCount);
    //if m_dwOverSpeedCount > 8 then m_boEmergencyClose:=True;
    SysMsg('攻击超速！！！',c_Red,t_Hint);
    if boViewHackMessage then
      MainOutMessage('[11000-Hit] ' + m_sCharName + ' ' + DateToStr(Now));
    exit;
  end;
  }
//  if not m_boDeath then begin
    if (nX = m_nCurrX) and (nY = m_nCurrY) then begin
      Result:=True;
      m_dwAttackTick:=GetTickCount();
      if (wIdent = CM_HEAVYHIT) and (m_UseItems[U_WEAPON].Dura > 0) then begin//挖矿
        if GetFrontPosition(n14,n18) and not m_PEnvir.CanWalk(n14,n18,False) then begin   //sub_004B2790
          StdItem:=UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
          if (StdItem <> nil) and (StdItem.Shape = 19)then begin
            if PileStones(n14,n18) then SendSocket(nil,'=DIG');
            Dec(m_nHealthTick,30);
            Dec(m_nSpellTick,50);
            m_nSpellTick:=_MAX(0,m_nSpellTick);
            Dec(m_nPerHealth,2);
            Dec(m_nPerSpell,2);
            exit;
          end;
        end;
      end;
      if wIdent = CM_HIT      then AttackDir(nil,0,nDir);
      if wIdent = CM_HEAVYHIT then AttackDir(nil,1,nDir);
      if wIdent = CM_BIGHIT   then AttackDir(nil,2,nDir);
      if wIdent = CM_POWERHIT then AttackDir(nil,3,nDir);
      if wIdent = CM_LONGHIT  then AttackDir(nil,4,nDir);
      if wIdent = CM_WIDEHIT  then AttackDir(nil,5,nDir);
      if wIdent = CM_FIREHIT  then AttackDir(nil,7,nDir);
      if wIdent = CM_CRSHIT   then AttackDir(nil,8,nDir);
      if wIdent = CM_TWINHIT  then AttackDir(nil,9,nDir);
      if wIdent = CM_42HIT    then AttackDir(nil,10,nDir);
      if wIdent = CM_42HIT    then AttackDir(nil,11,nDir);
      if (m_MagicPowerHitSkill <> nil) and (m_UseItems[U_WEAPON].Dura > 0) then begin
        Dec(m_btAttackSkillCount);
        if m_btAttackSkillPointCount = m_btAttackSkillCount then begin
          m_boPowerHit:=True;
          SendSocket(nil,'+PWR');
        end;
        if m_btAttackSkillCount <= 0 then begin
          m_btAttackSkillCount:=7 - m_MagicPowerHitSkill.btLevel;
          m_btAttackSkillPointCount:=Random(m_btAttackSkillCount);
        end;
      end;
      Dec(m_nHealthTick,30);
      Dec(m_nSpellTick,100);
      m_nSpellTick:=_MAX(0,m_nSpellTick);
      Dec(m_nPerHealth,2);
      Dec(m_nPerSpell,2);  //004CBB62
    end;
//  end else Result:=False;
except
  on e: Exception do begin
    MainOutMessage(sExceptionMsg);
    MainOutMessage(E.Message);
  end;
end;
end;


function TPlayObject.ClientHorseRunXY(wIdent: Word; nX, nY: Integer;boLateDelivery:Boolean;
  var dwDelayTime: LongWord): Boolean;
var
  n14:Integer;
  dwCheckTime:LongWord;
begin
  Result:=False;
  dwDelayTime:=0;

    
  if not m_boCanRun then exit;
  if m_boDeath or ((m_wStatusTimeArr[POISON_STONE{5}]{0x6A} <> 0) and not g_Config.ClientConf.boParalyCanRun) then exit;//防麻
  if not boLateDelivery then begin

  if not CheckActionStatus(wIdent,dwDelayTime) then begin
    m_boFilterAction:=False;
    exit;
  end;
  m_boFilterAction:=True;
  dwCheckTime:=GetTickCount - m_dwMoveTick;
  if dwCheckTime < g_Config.dwRunIntervalTime then begin
    Inc(m_dwMoveCount);
    dwDelayTime:=g_Config.dwRunIntervalTime - dwCheckTime;
    if dwDelayTime > g_Config.dwDropOverSpeed then  begin
      if m_dwMoveCount >= 4 then begin
        m_dwMoveTick:=GetTickCount();
        m_dwMoveCount:=0;
        dwDelayTime:=g_Config.dwDropOverSpeed;
        if m_boTestSpeedMode then
          SysMsg('Speed test information: ' + IntTOStr(dwDelayTime),c_Red,t_Hint);
      end else m_dwMoveCount:=0;
      exit;
    end else begin
      if m_boTestSpeedMode then
        SysMsg('Speed test information: ' + IntTOStr(dwDelayTime),c_Red,t_Hint);
      exit;
    end;
  end;
  end;

  m_dwMoveTick:=GetTickCount();
    m_bo316:=False;
{$IF DEBUG = 1}
    SysMsg(format('coords: %d:%d newcoords: %d:%d',[m_nCurrX,m_nCurrY,nX,nY]),c_Green,t_Hint);
{$IFEND}
    n14:=GetNextDirection(m_nCurrX,m_nCurrY,nX,nY);
    if HorseRunTo(n14,False) then begin
      if m_boTransparent and (m_boHideMode) then m_wStatusTimeArr[STATE_TRANSPARENT{0 0x70}]:=1;  //004CB212

      if m_bo316 or ((m_nCurrX = nX) and (m_nCurrY = nY)) then
        Result:=True;
      Dec(m_nHealthTick,60);
      Dec(m_nSpellTick,10);
      m_nSpellTick:=_MAX(0,m_nSpellTick);
      Dec(m_nPerHealth);
      Dec(m_nPerSpell);
    end else begin
      m_dwMoveCount:=0;
      m_dwMoveCountA:=0;
    end;
end;

function TPlayObject.ClientSpellXY(wIdent:Word;nKey:Integer;nTargetX, nTargetY:Integer;TargeTBaseObject: TBaseObject;boLateDelivery:Boolean;var dwDelayTime:LongWord): Boolean;//004CBCEC
var
  UserMagic     :pTUserMagic;
  nSpellPoint   :Integer;
  n14           :Integer;
  BaseObject    :TBaseObject;
  dwCheckTime   :LongWord;
  boIsWarrSkill :Boolean;
begin
  Result:=False;
  dwDelayTime:=0;

  if not m_boCanSpell then exit;
  if m_boDeath or ((m_wStatusTimeArr[POISON_STONE{5}]{0x6A} <> 0) and not g_Config.ClientConf.boParalyCanSpell) then exit;//防麻

  UserMagic:=GetMagicInfo(nKey);
  if UserMagic = nil then exit;
  boIsWarrSkill:=MagicManager.IsWarrSkill(UserMagic.wMagIdx);

  if not boLateDelivery and not boIsWarrSkill then begin
    if not CheckActionStatus(wIdent,dwDelayTime) then begin
      m_boFilterAction:=False;
      exit;
    end;
    m_boFilterAction:=True;
    dwCheckTime:=GetTickCount - m_dwMagicAttackTick;
    if dwCheckTime < m_dwMagicAttackInterval then begin
      Inc(m_dwMagicAttackCount);
      dwDelayTime:=m_dwMagicAttackInterval - dwCheckTime;
      if dwDelayTime > g_Config.dwMagicHitIntervalTime div 3 then  begin
        if m_dwMagicAttackCount >= 4 then begin
          m_dwMagicAttackTick:=GetTickCount();
          m_dwMagicAttackCount:=0;
          dwDelayTime:=g_Config.dwMagicHitIntervalTime div 3;
          if m_boTestSpeedMode then
            SysMsg('Speed test information: ' + IntTOStr(dwDelayTime),c_Red,t_Hint);
        end else m_dwMagicAttackCount:=0;
        exit;
      end else begin
        if m_boTestSpeedMode then
          SysMsg('Speed test information: ' + IntTOStr(dwDelayTime),c_Red,t_Hint);
        exit;
      end;
    end;
  end;
  
    Dec(m_nSpellTick,450);
    m_nSpellTick:=_MAX(0,m_nSpellTick);


      if boIsWarrSkill then begin
        //m_dwMagicAttackInterval:=0;
        //m_dwMagicAttackInterval:=g_Config.dwMagicHitIntervalTime; //01/21 改成此行
      end else begin
        m_dwMagicAttackInterval:=UserMagic.MagicInfo.dwDelayTime + g_Config.dwMagicHitIntervalTime;
      end;
      m_dwMagicAttackTick:=GetTickCount();
      case UserMagic.wMagIdx of    //
        SKILL_ERGUM{12}: begin  //刺杀剑法
          if m_MagicErgumSkill <> nil then begin
            if not m_boUseThrusting then begin
              ThrustingOnOff(True);
              SendSocket(nil,'+LNG');
            end else begin
              ThrustingOnOff(False);
              SendSocket(nil,'+ULNG');
            end;
          end;
          Result:=True;
        end;
        SKILL_BANWOL{25}: begin //半月弯刀
          {if m_MagicCrsSkill <> nil then begin
            if m_boCrsHitkill then begin
              SkillCrsOnOff(False);
              SendSocket(nil,'+UCRS');
            end;
          end;}

          if m_MagicBanwolSkill <> nil then begin
            if not m_boUseHalfMoon then begin
              HalfMoonOnOff(True);
              SendSocket(nil,'+WID');
            end else begin
              HalfMoonOnOff(False);
              SendSocket(nil,'+UWID');
            end;
          end;
          Result:=True;
        end;
        //SKILL_REDBANWOL{56}: begin
          {if m_MagicRedBanwolSkill <> nil then begin
            if not m_boRedUseHalfMoon then begin
              RedHalfMoonOnOff(True);
              SendSocket(nil,'+WID');
            end else begin
              RedHalfMoonOnOff(False);
              SendSocket(nil,'+UWID');
            end;
          end;
          Result:=True;
        end;}
        SKILL_FIRESWORD{26}: begin //烈火剑法
          if m_MagicFireSwordSkill <> nil then begin
            if AllowFireHitSkill then begin
              nSpellPoint:=GetSpellPoint(UserMagic);
              if m_WAbil.MP >= nSpellPoint then begin
                if nSpellPoint > 0 then begin
                  DamageSpell(nSpellPoint);
                  HealthSpellChanged();
                end;
                SendSocket(nil,'+FIR');
              end;
            end;
          end;
          Result:=True;
        end;
        SKILL_MOOTEBO{27}: begin //野蛮冲撞
          Result:=True;
          if (GetTickCount - m_dwDoMotaeboTick) > 3 * 1000 then begin
            m_dwDoMotaeboTick:=GetTickCount();
            m_btDirection:=nTargetX;
            nSpellPoint:=GetSpellPoint(UserMagic);
            if m_WAbil.MP >= nSpellPoint then begin
              if nSpellPoint > 0 then begin
                DamageSpell(nSpellPoint);
                HealthSpellChanged();
              end;
              if DoMotaebo(m_btDirection,UserMagic.btLevel) then begin
                if UserMagic.btLevel < 3 then begin
                  if UserMagic.MagicInfo.TrainLevel[UserMagic.btLevel] < m_Abil.Level then begin
                    TrainSkill(UserMagic,Random(3) + 1);
                    if not CheckMagicLevelup(UserMagic) then begin

                      SendDelayMsg(Self,
                                   RM_MAGIC_LVEXP,
                                   0,
                                   UserMagic.MagicInfo.wMagicId,
                                   UserMagic.btLevel,
                                   UserMagic.nTranPoint,
                                   '',1000);
                    end;
                  end;
                end;
              end;
            end;
          end; //004CC1B5
        end;
        SKILL_CROSSMOON: begin  //双龙斩
          {if m_MagicBanwolSkill <> nil then begin
            if m_boUseHalfMoon then begin
              HalfMoonOnOff(False);
              SendSocket(nil,'+UWID');
            end;
          end;}

          if m_MagicCrsSkill <> nil then begin
            if not m_boCrsHitkill then begin
              SkillCrsOnOff(True);
              SendSocket(nil,'+CRS');
            end else begin
              SkillCrsOnOff(False);
              SendSocket(nil,'+UCRS');
            end;
          end;
          Result:=True;
        end;
        SKILL_TWINBLADE: begin  //狂风斩
          if m_MagicTwnHitSkill <> nil then begin
            if AllowTwinHitSkill then begin
              nSpellPoint:=GetSpellPoint(UserMagic);
              if m_WAbil.MP >= nSpellPoint then begin
                if nSpellPoint > 0 then begin
                  DamageSpell(nSpellPoint);
                  HealthSpellChanged();
                end;
                SendSocket(nil,'+TWN');
              end;
            end;
          end;
          Result:=True;
        end;
        else begin
          n14:=GetNextDirection(m_nCurrX,m_nCurrY,nTargetX,nTargetY);
          m_btDirection:=n14;
          BaseObject:=nil;
          //检查目标角色，与目标座标误差范围，如果在误差范围内则修正目标座标
          if CretInNearXY(TargeTBaseObject,nTargetX,nTargetY) then begin
            BaseObject:=TargeTBaseObject;
            nTargetX:=BaseObject.m_nCurrX;
            nTargetY:=BaseObject.m_nCurrY;
          end;

          if not DoSpell(UserMagic,nTargetX,nTargetY,BaseObject) then begin
            SendRefMsg(RM_MAGICFIREFAIL,0,0,0,0,'');
          end;
          Result:=True;
        end;
      end; 
end;

//004C42C0
function TPlayObject.RunTo(btDir: Byte;boFlag:boolean;nDestX,nDestY:Integer): Boolean;
var
  nOldX,nOldY:Integer;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::RunTo';
begin
  Result:=False;
  try
    nOldX:=m_nCurrX;
    nOldY:=m_nCurrY;
    m_btDirection:=btDir;
    case btDir of
      DR_UP{0}: begin
        if (m_nCurrY > 1) and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY -1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY -2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX,m_nCurrY -2,True) > 0)then begin

          Dec(m_nCurrY,2);
        end;
      end;
      DR_UPRIGHT{1}: begin
        if (m_nCurrX < m_PEnvir.Header.wWidth -2) and
           (m_nCurrY > 1) and
           (m_PEnvir.CanWalkEx(m_nCurrX +1,m_nCurrY -1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX +2,m_nCurrY -2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX + 2,m_nCurrY -2,True) > 0)then begin

          Inc(m_nCurrX,2);
          Dec(m_nCurrY,2);
        end;
      end;
      DR_RIGHT{2}: begin
        if (m_nCurrX < m_PEnvir.Header.wWidth -2) and
           (m_PEnvir.CanWalkEx(m_nCurrX + 1,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX + 2,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX + 2,m_nCurrY,True) > 0)then begin

          Inc(m_nCurrX,2);
        end;
      end;
      DR_DOWNRIGHT{3}: begin
        if (m_nCurrX < m_PEnvir.Header.wWidth - 2) and
           (m_nCurrY < m_PEnvir.Header.wHeight -2) and
           (m_PEnvir.CanWalkEx(m_nCurrX +1,m_nCurrY +1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX +2,m_nCurrY +2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX + 2,m_nCurrY +2,True) > 0)then begin

          Inc(m_nCurrX,2);
          Inc(m_nCurrY,2);
        end;
      end;
      DR_DOWN{4}: begin
        if (m_nCurrY < m_PEnvir.Header.wHeight -2) and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY +1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY +2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX,m_nCurrY +2,True) > 0)then begin

          Inc(m_nCurrY,2);
        end;
      end;
      DR_DOWNLEFT{5}: begin
        if (m_nCurrX > 1) and
           (m_nCurrY < m_PEnvir.Header.wHeight -2) and
           (m_PEnvir.CanWalkEx(m_nCurrX -1,m_nCurrY +1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX -2,m_nCurrY +2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX - 2,m_nCurrY +2,True) > 0)then begin

          Dec(m_nCurrX,2);
          Inc(m_nCurrY,2);
        end;      
      end;
      DR_LEFT{6}: begin
        if (m_nCurrX > 1) and
           (m_PEnvir.CanWalkEx(m_nCurrX - 1,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX - 2,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX - 2,m_nCurrY,True) > 0)then begin

          Dec(m_nCurrX,2);
        end;
      end;
      DR_UPLEFT{7}: begin
        if (m_nCurrX > 1) and
           (m_nCurrY > 1) and
           (m_PEnvir.CanWalkEx(m_nCurrX -1,m_nCurrY -1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX -2,m_nCurrY -2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX - 2,m_nCurrY -2,True) > 0)then begin

          Dec(m_nCurrX,2);
          Dec(m_nCurrY,2);
        end;
      end;
    end;
    if ((m_nCurrX <> nOldX) or (m_nCurrY <> nOldY)) {and ((m_nCurrX = nDestX) and (m_nCurrY = nDestY))} then begin
      if Walk(RM_RUN) then Result:=True
      else begin
        m_nCurrX:=nOldX;
        m_nCurrY:=nOldY;
        m_PEnvir.MoveToMovingObject(nOldX,nOldY,Self,m_nCurrX,m_nCurrX,True);
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

//004C42C0
function TPlayObject.HorseRunTo(btDir: Byte;boFlag:boolean): Boolean;
var
  n10,n14:Integer;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::HorseRunTo';
begin
  Result:=False;
  try
    n10:=m_nCurrX;
    n14:=m_nCurrY;
    m_btDirection:=btDir;
    case btDir of
      DR_UP{0}: begin
        if (m_nCurrY > 2) and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY -1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY -2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY -3,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and           
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX,m_nCurrY -3,True) > 0)then begin

          Dec(m_nCurrY,3);
        end;
      end;
      DR_UPRIGHT{1}: begin
        if (m_nCurrX < m_PEnvir.Header.wWidth - 3) and
           (m_nCurrY > 2) and
           (m_PEnvir.CanWalkEx(m_nCurrX +1,m_nCurrY -1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX +2,m_nCurrY -2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX +3,m_nCurrY -3,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and           
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX + 3,m_nCurrY -3,True) > 0)then begin

          Inc(m_nCurrX,3);
          Dec(m_nCurrY,3);
        end;
      end;
      DR_RIGHT{2}: begin
        if (m_nCurrX < m_PEnvir.Header.wWidth -3) and
           (m_PEnvir.CanWalkEx(m_nCurrX + 1,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX + 2,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX + 3,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX + 3,m_nCurrY,True) > 0)then begin

          Inc(m_nCurrX,3);
        end;
      end;
      DR_DOWNRIGHT{3}: begin
        if (m_nCurrX < m_PEnvir.Header.wWidth - 3) and
           (m_nCurrY < m_PEnvir.Header.wHeight -3) and
           (m_PEnvir.CanWalkEx(m_nCurrX +1,m_nCurrY +1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX +2,m_nCurrY +2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX +3,m_nCurrY +3,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX + 3,m_nCurrY +3,True) > 0)then begin

          Inc(m_nCurrX,3);
          Inc(m_nCurrY,3);
        end;
      end;
      DR_DOWN{4}: begin
        if (m_nCurrY < m_PEnvir.Header.wHeight -3) and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY +1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY +2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX,m_nCurrY +3,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX,m_nCurrY +3,True) > 0)then begin

          Inc(m_nCurrY,3);
        end;
      end;
      DR_DOWNLEFT{5}: begin
        if (m_nCurrX > 2) and
           (m_nCurrY < m_PEnvir.Header.wHeight -3) and
           (m_PEnvir.CanWalkEx(m_nCurrX -1,m_nCurrY +1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX -2,m_nCurrY +2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX -3,m_nCurrY +3,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX - 3,m_nCurrY +3,True) > 0)then begin

          Dec(m_nCurrX,3);
          Inc(m_nCurrY,3);
        end;      
      end;
      DR_LEFT{6}: begin
        if (m_nCurrX > 2) and
           (m_PEnvir.CanWalkEx(m_nCurrX - 1,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX - 2,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX - 3,m_nCurrY,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX - 3,m_nCurrY,True) > 0)then begin

          Dec(m_nCurrX,3);
        end;
      end;
      DR_UPLEFT{7}: begin
        if (m_nCurrX > 2) and
           (m_nCurrY > 2) and
           (m_PEnvir.CanWalkEx(m_nCurrX -1,m_nCurrY -1,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX -2,m_nCurrY -2,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.CanWalkEx(m_nCurrX -3,m_nCurrY -3,g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll){True}))and
           (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,m_nCurrX - 3,m_nCurrY -3,True) > 0)then begin

          Dec(m_nCurrX,3);
          Dec(m_nCurrY,3);
        end;
      end;
    end;
//    SysMsg(format('原X:%d 原Y:%d 新X:%d 新Y:%d',[n10,n14,m_nCurrX,m_nCurrY]),c_Green,t_Hint);
    if (m_nCurrX <> n10) or (m_nCurrY <> n14) then begin
      if Walk(RM_HORSERUN) then Result:=True
      else begin
        m_nCurrX:=n10;
        m_nCurrY:=n14;
        m_PEnvir.MoveToMovingObject(n10,n14,Self,m_nCurrX,m_nCurrX,True)
      end;        
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TPlayObject.ClientRunXY(wIdent:Word;nX, nY:Integer;nFlag:Integer;var dwDelayTime:LongWord): Boolean;//004CB11C
var
  nDir:Integer;
  dwCheckTime:LongWord;
begin
  Result:=False;
  dwDelayTime:=0;
  if not m_boCanRun then exit;
  if m_boDeath or ((m_wStatusTimeArr[POISON_STONE{5}]{0x6A} <> 0) and not g_Config.ClientConf.boParalyCanRun) then exit;//防麻

  if nFlag <> wIdent then begin

  if not CheckActionStatus(wIdent,dwDelayTime) then begin
    m_boFilterAction:=False;
    exit;
  end;
  m_boFilterAction:=True;
  dwCheckTime:=GetTickCount - m_dwMoveTick;
  if dwCheckTime < g_Config.dwRunIntervalTime then begin
    Inc(m_dwMoveCount);
    dwDelayTime:=g_Config.dwRunIntervalTime - dwCheckTime;
    if dwDelayTime > g_Config.dwRunIntervalTime div 3 then  begin
      if m_dwMoveCount >= 4 then begin
        m_dwMoveTick:=GetTickCount();
        m_dwMoveCount:=0;
        dwDelayTime:=g_Config.dwRunIntervalTime div 3;
        if m_boTestSpeedMode then
          SysMsg('Speed test information: ' + IntTOStr(dwDelayTime),c_Red,t_Hint);
      end else m_dwMoveCount:=0;
      exit;
    end else begin
      if m_boTestSpeedMode then
        SysMsg('Speed test information: ' + IntTOStr(dwDelayTime),c_Red,t_Hint);
      exit;
    end;
  end;
  end;
  {
  if (GetTickCount - m_dwMoveTick) < 600 then begin
    Inc(m_dwMoveCount);
    Inc(m_dwMoveCountA);
  end else begin
    m_dwMoveCount:=0;
    if m_dwMoveCountA > 0 then Dec(m_dwMoveCountA);
  end;
  }
  m_dwMoveTick:=GetTickCount();
//  if (m_dwMoveCount < 4) and (m_dwMoveCountA < 6) then begin
    m_bo316:=False;
    nDir:=GetNextDirection(m_nCurrX,m_nCurrY,nX,nY);
    if RunTo(nDir,False,nX,nY) then begin
      if m_boTransparent and (m_boHideMode) then m_wStatusTimeArr[STATE_TRANSPARENT{0 0x70}]:=1;  //004CB212
        
      if m_bo316 or ((m_nCurrX = nX) and (m_nCurrY = nY)) then
        Result:=True;
      Dec(m_nHealthTick,60);
      Dec(m_nSpellTick,10);
      m_nSpellTick:=_MAX(0,m_nSpellTick);
      Dec(m_nPerHealth);
      Dec(m_nPerSpell);
    end else begin
      m_dwMoveCount:=0;
      m_dwMoveCountA:=0;
    end;
{
  end else begin
    Inc(m_dwOverSpeedCount);
    //if m_dwOverSpeedCount > 8 then m_boEmergencyClose:=True;
    SysMsg('跑步超速！！！',c_Red,t_Hint);
    if boViewHackMessage then begin
      MainOutMessage('[11002-Run] ' + m_sCharName + ' ' + DateToStr(Now));
    end;
  end;
}
end;

function TPlayObject.ClientWalkXY(wIdent:Word;nX, nY:Integer;boLateDelivery:Boolean;var dwDelayTime:LongWord): Boolean;//004CAF08
var
  n14:Integer;
  dwCheckTime:LongWord;
begin
  Result:=False;
  dwDelayTime:=0;
  if not m_boCanWalk then exit;
  if m_boDeath or ((m_wStatusTimeArr[POISON_STONE{5}]{0x6A} <> 0) and not g_Config.ClientConf.boParalyCanWalk) then exit;//防麻

  if not boLateDelivery then begin
    if not CheckActionStatus(wIdent,dwDelayTime) then begin
      m_boFilterAction:=False;
      exit;
    end;
    m_boFilterAction:=True;
    dwCheckTime:=GetTickCount - m_dwMoveTick;
    if dwCheckTime < g_Config.dwWalkIntervalTime then begin
      Inc(m_dwMoveCount);
      dwDelayTime:=g_Config.dwWalkIntervalTime - dwCheckTime;
      if dwDelayTime > g_Config.dwWalkIntervalTime div 3 then  begin
        if m_dwMoveCount >= 4 then begin
          m_dwMoveTick:=GetTickCount();
          m_dwMoveCount:=0;
          dwDelayTime:=g_Config.dwWalkIntervalTime div 3;
          if m_boTestSpeedMode then
            SysMsg('Walk Speed: ' + IntTOStr(dwDelayTime),c_Red,t_Hint);
        end else m_dwMoveCount:=0;
        exit;
      end else begin
        if m_boTestSpeedMode then
          SysMsg('Walk Speed:' + IntTOStr(dwDelayTime),c_Red,t_Hint);
        exit;
      end;
    end;
  end;
  {
  if (GetTickCount - m_dwMoveTick) < 600 then begin
    Inc(m_dwMoveCount);
    Inc(m_dwMoveCountA);
  end else begin
    m_dwMoveCount:=0;
    if m_dwMoveCountA > 0 then Dec(m_dwMoveCountA);
  end;
  }
  m_dwMoveTick:=GetTickCount();
//  if (m_dwMoveCount < 4) and (m_dwMoveCountA < 6) then begin
    m_bo316:=False;
//    n18:=m_nCurrX;
//    n1C:=m_nCurrY;
    n14:=GetNextDirection(m_nCurrX,m_nCurrY,nX,nY);


    if WalkTo(n14,False) then begin
      if m_bo316 or ((m_nCurrX = nX) and (m_nCurrY = nY)) then
        Result:=True;
      Dec(m_nHealthTick,10);
    end else begin
      m_dwMoveCount:=0;
      m_dwMoveCountA:=0;
    end;
  {
  end else begin
    Inc(m_dwOverSpeedCount);
    //if m_dwOverSpeedCount > 8 then m_boEmergencyClose:=True;
    SysMsg('走步超速！！！',c_Red,t_Hint);
    if boViewHackMessage then begin
      MainOutMessage('[11002-Walk] ' + m_sCharName + ' ' + DateToStr(Now));
    end;
  end;
  }
end;
//004BC900
procedure TPlayObject.ThrustingOnOff(boSwitch: Boolean);
begin
  m_boUseThrusting:=boSwitch;
  if m_boUseThrusting then begin
    SysMsg(sThrustingOn,c_Green,t_Hint);
  end else begin
    SysMsg(sThrustingOff,c_Green,t_Hint);
  end;
end;
//004BC980
procedure TPlayObject.HalfMoonOnOff(boSwitch: Boolean);
begin
  m_boUseHalfMoon:=boSwitch;
  if m_boUseHalfMoon then begin
    SysMsg(sHalfMoonOn,c_Green,t_Hint);
  end else begin
    SysMsg(sHalfMoonOff,c_Green,t_Hint);
  end;
end;

procedure TPlayObject.RedHalfMoonOnOff(boSwitch: Boolean);
begin
  m_boRedUseHalfMoon:=boSwitch;
  if m_boRedUseHalfMoon then begin
    SysMsg(sRedHalfMoonOn,c_Green,t_Hint);
  end else begin
    SysMsg(sRedHalfMoonOff,c_Green,t_Hint);
  end;
end;

procedure TPlayObject.SkillCrsOnOff(boSwitch: Boolean);
begin
  m_boCrsHitkill:=boSwitch;
  if m_boCrsHitkill then begin
    SysMsg(sCrsHitOn,c_Green,t_Hint);
  end else begin
    SysMsg(sCrsHitOff,c_Green,t_Hint);
  end;
end;
procedure TPlayObject.SkillTwinOnOff(boSwitch: Boolean);
begin
  m_boTwinHitSkill:=boSwitch;
  if m_boTwinHitSkill then begin
    SysMsg(sTwinHitOn,c_Green,t_Hint);
  end else begin
    SysMsg(sTwinHitOff,c_Green,t_Hint);
  end;
end;

function TPlayObject.AllowFireHitSkill():Boolean;//004BCA00
begin
  Result:=False;
  if (GetTickCount - m_dwLatestFireHitTick) > 10 * 1000 then begin
    m_dwLatestFireHitTick:=GetTickCount();
    m_boFireHitSkill:=True;
    SysMsg(sFireSpiritsSummoned,c_Green,t_Hint);
    Result:=True;
  end else begin
    SysMsg(sFireSpiritsFail,c_Red,t_Hint);
  end;
end;

function TPlayObject.AllowTwinHitSkill():Boolean;
begin
  Result:=False;
    m_dwLatestTwinHitTick:=GetTickCount();
    m_boTwinHitSkill:=True;
    Result:=True;
end;

procedure TBaseObject.MapRandomMove(sMapName:String;nInt:Integer);//004BCB54
var
  Envir:TEnvirnoment;
  nX,nY,nEgdey:Integer;
begin
  Envir:=g_MapManager.FindMap(sMapName);
  if Envir <> nil then begin
    if Envir.Header.wHeight < 150 then begin
      if Envir.Header.wHeight < 30 then begin
        nEgdey:=2;
      end else nEgdey:=20;
    end else nEgdey:=50;
    nX:=Random(Envir.Header.wWidth - nEgdey -1) + nEgdey;
    nY:=Random(Envir.Header.wHeight - nEgdey -1) + nEgdey;
    SpaceMove(sMapName,nX,nY,nInt);
  end;
end;

procedure TPlayObject.ClientClickNPC(NPC: Integer);//004DBA10
var
  NormNpc:TNormNpc;
begin
  if not m_boCanDeal then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sCanotTryDealMsg);
    exit;
  end;
  if m_boDeath or m_boGhost then exit;
    
  NormNpc:=UserEngine.FindMerchant(TObject(NPC));
  if NormNpc = nil then
    NormNpc:=UserEngine.FindNPC(TObject(NPC));

  if NormNpc <> nil then begin
    if (NormNpc.m_PEnvir = m_PEnvir) and (abs(NormNpc.m_nCurrX - m_nCurrX) <= 15) and (abs(NormNpc.m_nCurrY - m_nCurrY) <= 15) then begin
      NormNpc.Click(Self);
    end;
  end;//004DBA9C
end;

//004C4DB8
function TBaseObject.AddItemToBag(UserItem:PTUserItem):Boolean;
begin
  Result:=False;
  if m_ItemList.Count < MAXBAGITEM then begin
    m_ItemList.Add(UserItem);
    WeightChanged();
    Result:=True;
  end;
end;

//4C9BD0
function TPlayObject.GetRangeHumanCount: Integer;
begin
  Result:=UserEngine.GetMapOfRangeHumanCount(m_PEnvir,m_nCurrX,m_nCurrY,10);
end;

procedure TBaseObject.CheckMagicSpecialAbility(Magic:pTUserMagic); //004C713C
begin
  if Magic.MagicInfo.wMagicId = 28 then
    if Magic.btLevel >= 2 then m_boAbilSeeHealGauge:=True;
end;

procedure TPlayObject.GetHomePoint;
var
  I: Integer;
  StartPoint:pTStartPoint;
begin
  try
    g_StartPoint.Lock;
    for I := 0 to g_StartPoint.Count - 1 do begin
      StartPoint:=g_StartPoint.Items[I];
      if StartPoint.Envir = m_PEnvir then begin
        if (abs(m_nCurrX - StartPoint.nX) < 50) and (abs(m_nCurrY - StartPoint.nY) < 50) then begin
          m_sHomeMap:=StartPoint.sMapName;
          m_nHomeX:=StartPoint.nX;
          m_nHomeY:=StartPoint.nY;
          break;
        end;
      end;
    end;
    if PKLevel >= 2 then begin
      m_sHomeMap :=g_Config.sRedHomeMap;
      m_nHomeX   :=g_Config.nRedHomeX;
      m_nHomeY   :=g_Config.nRedHomeY;
    end;
  finally
    g_StartPoint.UnLock;
  end;
end;

function TPlayObject.GetStartPoint(var StartPoint:pTStartPoint):Boolean;
var
  i    :Integer;
  Point:pTStartPoint;
begin
  Result:=False;
  if (m_PEnvir.sMapName = g_Config.sRedHomeMap) and
     (abs(m_nCurrX - g_Config.nRedHomeX) < g_Config.nSafeZoneSize) and
     (abs(m_nCurrY - g_Config.nRedHomeY) < g_Config.nSafeZoneSize) then begin
    StartPoint:=@g_RedStartPoint;
    StartPoint.sMapName:=m_PEnvir.sMapName;
    StartPoint.Envir:=m_PEnvir;
    StartPoint.nX:=g_Config.nRedHomeX;
    StartPoint.nY:=g_Config.nRedHomeY;
    Result:=True;
    exit;
  end;
  g_StartPoint.Lock;
  try
    for I := 0 to g_StartPoint.Count - 1 do begin
      Point:=g_StartPoint.Items[I];
      if Point.Envir = m_PEnvir then begin
        if (abs(m_nCurrX - Point.nX) < g_Config.nSafeZoneSize) and (abs(m_nCurrY - Point.nY) < g_Config.nSafeZoneSize) then begin
          StartPoint:=Point;
          Result:=True;
          break;
        end;
      end;
    end;
  finally
    g_StartPoint.UnLock;
  end;
end;

procedure TPlayObject.MobPlace(sX, sY, sMonName, sCount: String); //004C1508
begin

end;

function TBaseObject.GetQuestFalgStatus(nFlag: integer): Integer;//004C1490
var
  n10,n14:Integer;
begin
  Result:=0;
  Dec(nFlag);
  if nFlag < 0 then exit;
  n10:=nFlag div 8;
  n14:=(nFlag mod 8);
  if (n10 - SizeOf(TQuestFlag)) < 0 then begin
    if ((128 shr n14) and (m_QuestFlag[n10])) <> 0 then Result:=1
    else Result:=0;
  end;

  //note: swapped the results around...
end;

procedure TBaseObject.SetQuestFlagStatus(nFlag:Integer;nValue:Integer);//004C1508
var
  n10,n14:Integer;
  bt15:Byte;
begin
  Dec(nFlag);
  if nFlag < 0 then exit;
  n10:=nFlag div 8;
  n14:=(nFlag mod 8);
  if (n10 - SizeOf(TQuestFlag)) < 0 then begin
    bt15:=m_QuestFlag[n10];
    if nValue = 0 then begin
      m_QuestFlag[n10]:=(not (128 shr n14)) and (bt15);
    end else begin
      m_QuestFlag[n10]:=(128 shr n14) or (bt15);
    end;
  end;
end;
function TBaseObject.GetQuestUnitOpenStatus(nFlag: integer): Integer;//004C159C
var
  n10,n14:Integer;
begin
  Result:=0;
  Dec(nFlag);
  if nFlag < 0 then exit;
  n10:=nFlag div 8;
  n14:=(nFlag mod 8);
  if (n10 - SizeOf(TQuestUnit)) < 0 then begin
    if ((128 shr n14) and (m_QuestUnitOpen[n10])) <> 0 then Result:=1
    else Result:=0;
  end;
end;
procedure TBaseObject.SetQuestUnitOpenStatus(nFlag:Integer;nValue:Integer);//004C1614
var
  n10,n14:Integer;
  bt15:Byte;
begin
  Dec(nFlag);
  if nFlag < 0 then exit;
  n10:=nFlag div 8;
  n14:=(nFlag mod 8);
  if (n10 - SizeOf(TQuestUnit)) < 0 then begin
    bt15:=m_QuestUnitOpen[n10];
    if nValue = 0 then begin
      m_QuestUnitOpen[n10]:=(not (128 shr n14)) and (bt15);
    end else begin
      m_QuestUnitOpen[n10]:=(128 shr n14) or (bt15);
    end;
  end;
end;

function TBaseObject.GetQuestUnitStatus(nFlag: integer): Integer;//004C16A8
var
  n10,n14:Integer;
begin
  Result:=0;
  Dec(nFlag);
  if nFlag < 0 then exit;
  n10:=nFlag div 8;
  n14:=(nFlag mod 8);
  if (n10 - SizeOf(TQuestUnit)) < 0 then begin
    if ((128 shr n14) and (m_QuestUnit[n10])) <> 0 then Result:=1
    else Result:=0;
  end;
end;

procedure TBaseObject.SetQuestUnitStatus(nFlag:Integer;nValue:Integer);//004C1720
var
  n10,n14:Integer;
  bt15:Byte;
begin
  Dec(nFlag);
  if nFlag < 0 then exit;
  n10:=nFlag div 8;
  n14:=(nFlag mod 8);
  if (n10 - SizeOf(TQuestUnit)) < 0 then begin
    bt15:=m_QuestUnit[n10];
    if nValue = 0 then begin
      m_QuestUnit[n10]:=(not (128 shr n14)) and (bt15);
    end else begin
      m_QuestUnit[n10]:=(128 shr n14) or (bt15);
    end;
  end;
end;


procedure TPlayObject.CmdTrainingMagic(Cmd:pTGameCmd;sHumanName, sSkillName: String;
  nLevel: Integer);
var
  Magic:pTMagic;
  UserMagic:pTUserMagic;
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sHumanName <> '') and (sHumanName[1] = '?')) or (sHumanName = '') or (sSkillName = '') or (nLevel < 0) or not (nLevel in [0..3]) then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Skill> <Level(0-3)>',c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  Magic:=UserEngine.FindMagic(sSkillName);
  if Magic = nil then begin
    SysMsg(format('%s does not exist.',[sSkillName]),c_Red,t_Hint);
    exit;
  end;

  if PlayObject.IsTrainingSkill(Magic.wMagicId) then begin
    SysMsg(format('%s already trained.',[sSkillName]),c_Red,t_Hint);
    exit;
  end;
  New(UserMagic);
  UserMagic.MagicInfo:=Magic;
  UserMagic.wMagIdx:=Magic.wMagicId;
  UserMagic.btLevel:=nLevel;
  UserMagic.btKey:=0;
  UserMagic.nTranPoint:=0;
  PlayObject.m_MagicList.Add(UserMagic);
  PlayObject.SendAddMagic(UserMagic);
  PlayObject.RecalcAbilitys;
  SysMsg(format('%s has began training the skill of %s.',[sHumanName,sSkillName]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdTrainingSkill(Cmd:pTGameCmd;sHumanName, sSkillName: String;
  nLevel: Integer);
var
  I: Integer;
  UserMagic:pTUserMagic;
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or (sSkillName = '') or (nLevel <= 0) then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Skill> <Level(0-3)>',c_Red,t_Hint);
    exit;
  end;
  nLevel:=_MIN(3,nLevel);
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format('%s is not online.',[sHumanName]),c_Red,t_Hint);
    exit;
  end;

  for I := 0 to PlayObject.m_MagicList.Count - 1 do begin
    UserMagic:=PlayObject.m_MagicList.Items[I];
    if CompareText(UserMagic.MagicInfo.sMagicName,sSkillName) = 0 then begin
      UserMagic.btLevel:=nLevel;
      PlayObject.SendMsg(PlayObject,
              RM_MAGIC_LVEXP,
              0,
              UserMagic.MagicInfo.wMagicId,
              UserMagic.btLevel,
              UserMagic.nTranPoint,
              '');
      PlayObject.SysMsg(format('%s has been trained at level %d.',[sSkillName,nLevel]),c_Green,t_Hint);
      SysMsg(format('%s has now learnt %s at level %d.',[sHumanName,sSkillName,nLevel]),c_Green,t_Hint);
      break;
    end;
  end;
end;

procedure TPlayObject.CmdAddGameGold(sCmd, sHumName: String;
  nPoint: Integer);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < 6) then exit;
  if (sHumName = '') or (nPoint <= 0) then begin
    SysMsg('@' + sCmd + ' <Username> <Amount>',c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if PlayObject <> nil then begin
    if (PlayObject.m_nGameGold + nPoint) < 2000000 then begin
      Inc(PlayObject.m_nGameGold,nPoint);
    end else begin
      nPoint:=2000000 - PlayObject.m_nGameGold;
      PlayObject.m_nGameGold:=2000000;
    end;
    PlayObject.GoldChanged();
    SysMsg(sHumName + ' has been given ' + IntToStr(nPoint)+ ' gold.',c_Green,t_Hint);
    PlayObject.SysMsg('You recieved ' + IntToStr(nPoint)+ ' gold.',c_Green,t_Hint);
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumName]),c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdDelGameGold(sCmd, sHumName: String;
  nPoint: Integer);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < 6) then exit;
  if (sHumName = '') or (nPoint <= 0) then exit;
  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if PlayObject <> nil then begin
    if PlayObject.m_nGameGold > nPoint then begin
      Dec(PlayObject.m_nGameGold,nPoint);
    end else begin
      nPoint:=PlayObject.m_nGameGold;
      PlayObject.m_nGameGold:=0;
    end;
    PlayObject.GoldChanged();
    SysMsg(IntToStr(nPoint)+ ' gold has been removed from '+ sHumName+ '.',c_Green,t_Hint);
    PlayObject.SysMsg(IntToStr(nPoint)+ ' gold has been taken away from you.',c_Green,t_Hint);
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumName]),c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdGameGold(Cmd:pTGameCmd;sHumanName:String;sCtr:String;nGold:Integer);
var
  PlayObject:TPlayObject;
  Ctr:Char;
begin
  Ctr:='1';
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sCtr <> '') then begin
    Ctr:=sCtr[1];
  end;
    
  if (sHumanName = '') or not (Ctr in ['=','+','-']) or (nGold < 0) or (nGold > 200000000) or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandGameGoldHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  case sCtr[1] of
    '=': begin
      PlayObject.m_nGamePoint:=nGold;
    end;
    '+': Inc(PlayObject.m_nGameGold,nGold);
    '-': Dec(PlayObject.m_nGameGold,nGold);
  end;
  if g_boGameLogGameGold then begin
    AddGameDataLog(format(g_sGameLogMsg1,[LOG_GAMEGOLD,
                                        PlayObject.m_sMapName,
                                        PlayObject.m_nCurrX,
                                        PlayObject.m_nCurrY,
                                        PlayObject.m_sCharName,
                                        g_Config.sGameGoldName,
                                        nGold,
                                        sCtr[1],
                                        m_sCharName]));
  end;
  GameGoldChanged();
  PlayObject.SysMsg(format(g_sGameCommandGameGoldHumanMsg,[g_Config.sGameGoldName,nGold,PlayObject.m_nGameGold,g_Config.sGameGoldName]),c_Green,t_Hint);
  SysMsg(format(g_sGameCommandGameGoldGMMsg,[sHumanName,g_Config.sGameGoldName,nGold,PlayObject.m_nGameGold,g_Config.sGameGoldName]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdGamePoint(Cmd:pTGameCmd;sHumanName, sCtr: String; nPoint: Integer);
var
  PlayObject:TPlayObject;
  Ctr:Char;
begin
  Ctr:='1';
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sCtr <> '') then begin
    Ctr:=sCtr[1];
  end;
    
  if (sHumanName = '') or not (Ctr in ['=','+','-']) or (nPoint < 0) or (nPoint > 100000000) or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandGamePointHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  case sCtr[1] of
    '=': begin
      PlayObject.m_nGamePoint:=nPoint;
    end;
    '+': Inc(PlayObject.m_nGamePoint,nPoint);
    '-': Dec(PlayObject.m_nGamePoint,nPoint);
  end;
  if g_boGameLogGamePoint then begin
    AddGameDataLog(format(g_sGameLogMsg1,[LOG_GAMEPOINT,
                                        PlayObject.m_sMapName,
                                        PlayObject.m_nCurrX,
                                        PlayObject.m_nCurrY,
                                        PlayObject.m_sCharName,
                                        g_Config.sGamePointName,
                                        nPoint,
                                        sCtr[1],
                                        m_sCharName]));
  end;
  GameGoldChanged();
  PlayObject.SysMsg(format(g_sGameCommandGamePointHumanMsg,[nPoint,PlayObject.m_nGamePoint]),c_Green,t_Hint);
  SysMsg(format(g_sGameCommandGamePointGMMsg,[sHumanName,nPoint,PlayObject.m_nGamePoint]),c_Green,t_Hint);
end;


procedure TPlayObject.CmdCreditPoint(Cmd:pTGameCmd;sHumanName, sCtr: String; nPoint: Integer);
var
  PlayObject:TPlayObject;
  Ctr:Char;
  nCreditpoint:Integer;
begin
  Ctr:='1';
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sCtr <> '') then begin
    Ctr:=sCtr[1];
  end;
    
  if (sHumanName = '') or not (Ctr in ['=','+','-']) or (nPoint < 0) or (nPoint > High(Byte)) or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandCreditPointHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GetPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  case sCtr[1] of
    '=': begin
      if nPoint in [0..255] then
        PlayObject.m_btCreditPoint:=nPoint;
    end;
    '+': begin
      nCreditpoint:=PlayObject.m_btCreditPoint + nPoint;
      if nPoint in [0..255] then
        PlayObject.m_btCreditPoint:=nCreditpoint;
    end;
    '-': begin
      nCreditpoint:=PlayObject.m_btCreditPoint - nPoint;
      if nPoint in [0..255] then
        PlayObject.m_btCreditPoint:=nCreditpoint;
    end;
  end;
  PlayObject.SysMsg(format(g_sGameCommandCreditPointHumanMsg,[nPoint,PlayObject.m_btCreditPoint]),c_Green,t_Hint);
  SysMsg(format(g_sGameCommandCreditPointGMMsg,[sHumanName,nPoint,PlayObject.m_btCreditPoint]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdAddGold(Cmd:pTGameCmd;sHumName: String; nCount: Integer);//004CD550
var
  PlayObject:TPlayObject;
  nServerIndex:integer;
begin
  if (m_btPermission < 6) then exit;
  if (sHumName = '') or (nCount <= 0) then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Amount>',c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if PlayObject <> nil then begin
    if (PlayObject.m_nGold + nCount) < PlayObject.m_nGoldMax then begin
      Inc(PlayObject.m_nGold,nCount);
    end else begin
      nCount:=PlayObject.m_nGoldMax - PlayObject.m_nGold;
      PlayObject.m_nGold:=PlayObject.m_nGoldMax;
    end;
    PlayObject.GoldChanged();
    SysMsg(sHumName + ' has been given ' + IntToStr(nCount)+ ' gold.',c_Green,t_Hint);
            //004CD6F6
          if g_boGameLogGold then
            AddGameDataLog ('14' + #9 +
                        m_sMapName + #9 +
                        IntToStr(m_nCurrX) + #9 +
                        IntToStr(m_nCurrY) + #9 +
                        m_sCharName + #9 +
                        sSTRING_GOLDNAME + #9 +
                        IntToStr(nCount) + #9 +
                        '1' + #9 +
                        sHumName);
  end else begin
    if UserEngine.FindOtherServerUser(sHumName,nServerIndex) then begin
      SysMsg(sHumName + ' Has been found on server number:' + IntToStr(nServerIndex)+ '.',c_Green,t_Hint);
    end else begin
      FrontEngine.AddChangeGoldList(m_sCharName,sHumName,nCount);
      SysMsg(sHumName + ' has been added to the change gold list.',c_Green,t_Hint);
    end;
  end;
end;
procedure TPlayObject.CmdAddGuild(Cmd:pTGameCmd;sGuildName, sGuildChief: String);//004CEBA0
var
  Human:TPlayObject;
  boAddState:Boolean;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if nServerIndex <> 0 then begin
    SysMsg('Can only create guilds on masterserver',c_Red,t_Hint);
    exit;
  end;
  if (sGuildName = '') or (sGuildChief = '') then begin
    SysMsg('@' + Cmd.sCmd + ' Guild Leader',c_Red,t_Hint);
    exit;
  end;

  boAddState:=False;
  Human:=UserEngine.GeTPlayObject(sGuildChief);
  if Human = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sGuildChief]),c_Red,t_Hint);
    exit;
  end;
  if g_GuildManager.MemberOfGuild(sGuildChief) = nil then begin
    if g_GuildManager.AddGuild(sGuildName,sGuildChief) then begin
      UserEngine.SendServerGroupMsg(SS_205,nServerIndex,sGuildName + '/' + sGuildChief);
      SysMsg('Guild: ' + sGuildName + ' Leader: ' + sGuildChief,c_Green,t_Hint);
      boAddState:=True;
    end;
  end;//004CECB4
  if boAddState then begin
    Human.m_MyGuild:=g_GuildManager.MemberOfGuild(Human.m_sCharName);
    if Human.m_MyGuild <> nil then begin
      Human.m_sGuildRankName:=TGuild(Human.m_MyGuild).GetRankName(Human,Human.m_nGuildRankNo);
      Human.RefShowName();
    end;
  end;//004CED14
end;
procedure TPlayObject.CmdAdjuestExp(Cmd:pTGameCmd; sHumanName,sExp: String);
var
  PlayObject:TPlayObject;
  dwExp:LongWord;
  dwOExp:LongWord;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Amount>',c_Red,t_Hint);
    exit;
  end;
  dwExp:=Str_ToInt(sExp,0);

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    dwOExp:=PlayObject.m_Abil.Exp;
    PlayObject.m_Abil.Exp:=dwExp;
    PlayObject.HasLevelUp(1);
    SysMsg(sHumanName + ' is not online.',c_Green,t_Hint);
  if g_Config.boShowMakeItemMsg then
    MainOutMessage('[Change EXP] ' + m_sCharName + '(' + PlayObject.m_sCharName + ' ' + IntToStr(dwOExp) + ' -> ' + IntToStr(PlayObject.m_Abil.Exp) + ')');
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdAdjuestLevel(Cmd:pTGameCmd;sHumanName: String;
  nLevel: Integer);
var
  PlayObject:TPlayObject;
  nOLevel:Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sHumanName = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Level>',c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    nOLevel:=PlayObject.m_Abil.Level;
    PlayObject.m_Abil.Level:=_MAX(1,_MIN(MAXUPLEVEL,nLevel));
    PlayObject.HasLevelUp(1);
    SysMsg(sHumanName + ' level changed.',c_Green,t_Hint);
    if g_Config.boShowMakeItemMsg then
      MainOutMessage('[Change Level] ' + m_sCharName + '(' + PlayObject.m_sCharName + ' ' + IntToStr(nOLevel) + ' -> ' + IntToStr(PlayObject.m_Abil.Level) + ')');
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdAdjustExp(Human: TPlayObject; nExp: Integer);//004CDDAC
begin
  if (m_btPermission < 6) then exit;
end;

procedure TPlayObject.CmdBackStep(sCmd:String; nType, nCount: Integer);
begin
  if (m_btPermission < 6) then exit;
  nType:=_MIN(nType,8);
  if nType = 0 then begin
    CharPushed(GetBackDir(m_btDirection),nCount);
  end else begin
    CharPushed(RanDom(nType),nCount);
  end;
    
end;

procedure TPlayObject.CmdBonuPoint(Cmd:pTGameCmd;sHumName: String; nCount: Integer);
var
  PlayObject:TPlayObject;
  sMsg:String;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumName = '') then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Amount>',c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GetPlayObject(sHumName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumName]),c_Red,t_Hint);
    exit;
  end;
  if (nCount > 0) then begin
    PlayObject.m_nBonusPoint:=nCount;
    PlayObject.SendMsg (self, RM_ADJUST_BONUS, 0, 0, 0, 0, '');
    exit;
  end;
  sMsg:=format('Points: %d (DC: %d MC: %d SC: %d AC: %d MAC: %d HP: %d MP: %d HIT: %d SPEED: %d)',
               [PlayObject.m_nBonusPoint,
                PlayObject.m_BonusAbil.DC,
                PlayObject.m_BonusAbil.MC,
                PlayObject.m_BonusAbil.SC,
                PlayObject.m_BonusAbil.AC,
                PlayObject.m_BonusAbil.MAC,
                PlayObject.m_BonusAbil.HP,
                PlayObject.m_BonusAbil.MP,
                PlayObject.m_BonusAbil.Hit,
                PlayObject.m_BonusAbil.Speed
               ]);
  SysMsg(format('%s - %s',[sHumName,sMsg]),c_Red,t_Hint);
end;

procedure TPlayObject.CmdChangeAdminMode(sCmd:String;nPermission:Integer;sParam1:String;boFlag:Boolean);
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,'']),c_Red,t_Hint);
    exit;
  end;

  m_boAdminMode:=boFlag;
  if m_boAdminMode then SysMsg(sGameMasterMode,c_Green,t_Hint)
  else  SysMsg(sReleaseGameMasterMode,c_Green,t_Hint);
end;

procedure TPlayObject.CmdChangeAttackMode(nMode: Integer;sParam1,sParam2,sParam3,sParam4,sParam5,sParam6,sParam7:String);
begin
  if (nMode >= HAM_ALL) and (nMode <= HAM_PKATTACK) then
    m_btAttatckMode:=nMode
  else begin
    if m_btAttatckMode < HAM_PKATTACK then Inc(m_btAttatckMode)
    else m_btAttatckMode:=HAM_ALL;
  end;
  case m_btAttatckMode of
    HAM_ALL: SysMsg(sAttackModeOfAll,c_Green,t_Hint); //[Attack All]
    HAM_PEACE: SysMsg(sAttackModeOfPeaceful,c_Green,t_Hint); //[Peaceful]
    HAM_DEAR:  SysMsg(sAttackModeOfDear,c_Green,t_Hint); //[Marriage Attack]
    HAM_MASTER:SysMsg(sAttackModeOfMaster,c_Green,t_Hint); //[Master Attack]
    HAM_GROUP: SysMsg(sAttackModeOfGroup,c_Green,t_Hint); //[Group Attack]
    HAM_GUILD: SysMsg(sAttackModeOfGuild,c_Green,t_Hint); //[Guild Attack]
    HAM_PKATTACK: SysMsg(sAttackModeOfRedWhite,c_Green,t_Hint); //[Red White Attack]
  end;
end;
procedure TPlayObject.CmdChangeDearName(Cmd:pTGameCmd;sHumanName,sDearName: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or (sDearName = '') then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <PartnerName>',c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    if CompareText(sDearName,'None') = 0 then begin
      PlayObject.m_sDearName:='';
      PlayObject.RefShowName;
      SysMsg(sHumanName + ' is no longer married',c_Green,t_Hint);
    end else begin
      PlayObject.m_sDearName:=sDearName;
      PlayObject.RefShowName;
      SysMsg(sHumanName + ' is now married',c_Green,t_Hint);
    end;
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdChangeGender(Cmd:pTGameCmd;sHumanName, sSex: String);
var
  PlayObject:TPlayObject;
  nSex:Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  nSex:= -1;
  if (sSex = 'M') or (sSex = sMAN) or (sSex = sMALE) or (sSex = '0') then begin
    nSex:=0;
  end;
  if (sSex = 'F') or (sSex = sWOMAN) or (sSex = sFEMALE) or (sSex = '1') then begin
    nSex:=1;
  end;
  if (sHumanName = '') or (nSex = -1) then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Gender(M/F)>',c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    if PlayObject.m_btGender <> nSex then begin
      PlayObject.m_btGender:=nSex;
      PlayObject.FeatureChanged();
      SysMsg(PlayObject.m_sCharName + ' changed gender.',c_Green,t_Hint);
    end else begin
      SysMsg(PlayObject.m_sCharName + ' already gender ' + sSex,c_Red,t_Hint);
    end;
  end else begin
    SysMsg(sHumanName + ' is not online.',c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdChangeItemName(sCmd, sMakeIndex,sItemIndex, sItemName: String);
var
  nMakeIndex,nItemIndex:Integer;
begin
  if (m_btPermission < 6) then exit;
  if (sMakeIndex = '') or (sItemIndex = '') or (sItemName = '') then begin
    SysMsg('@' + sCmd + ' <MakeIndex> <ItemIndex> <ItemName>',c_Red,t_Hint);
    exit;
  end;
  nMakeIndex:=Str_ToInt(sMakeIndex,-1);
  nItemIndex:=Str_ToInt(sItemIndex,-1);
  if (nMakeIndex <= 0) or (nItemIndex < 0) then begin
    SysMsg('@' + sCmd + ' <MakeIndex> <ItemIndex> <ItemName>',c_Red,t_Hint);
    exit;
  end;

  if ItemUnit.AddCustomItemName(nMakeIndex,nItemIndex,sItemName) then begin
    ItemUnit.SaveCustomItemName();
    SysMsg('Custom itemname saved.',c_Green,t_Hint);
    exit;
  end;

  SysMsg('Unable to save custom itemname.',c_Red,t_Hint);
end;
procedure TPlayObject.CmdChangeJob(Cmd:pTGameCmd;sHumanName,sJobName: String);//004CC714
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;

  if (sHumanName = '') or (sJobName = '') then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandChangeJobHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    if CompareText(sJobName,sWarrior) = 0 then PlayObject.m_btJob:=jWarr;
    if CompareText(sJobName,sWizard) = 0 then PlayObject.m_btJob:=jWizard;
    if CompareText(sJobName,sTaos) = 0 then PlayObject.m_btJob:=jTaos;
    PlayObject.HasLevelUp(1);
    PlayObject.SysMsg(g_sGameCommandChangeJobHumanMsg,c_Green,t_Hint);
    SysMsg(format(g_sGameCommandChangeJobMsg,[sHumanName]),c_Green,t_Hint);
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdChangeLevel(Cmd:pTGameCmd;sParam1:String);
var
  nOLevel:Integer;
  nLevel:Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,'']),c_Red,t_Hint);
    exit;
  end;
  
  nLevel:=Str_ToInt(sParam1,1);
  nOLevel:=m_Abil.Level;
  m_Abil.Level:=_MIN(MAXUPLEVEL,nLevel);
  HasLevelUp(1);
  if g_Config.boShowMakeItemMsg then begin
    MainOutMessage(format(g_sGameCommandLevelConsoleMsg,[m_sCharName,nOLevel,m_Abil.Level]));
  end;
end;
procedure TPlayObject.CmdChangeMasterName(Cmd:pTGameCmd;sHumanName,sMasterName,sIsMaster: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or (sMasterName = '') then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <MasterName> <IsMaster>)',c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    if CompareText(sMasterName,'None') = 0 then begin
      PlayObject.m_sMasterName:='';
      PlayObject.RefShowName;
      PlayObject.m_boMaster:=False;
      SysMsg(sHumanName + ' no longer has a master',c_Green,t_Hint);
    end else begin
      PlayObject.m_sMasterName:=sMasterName;
      if (sIsMaster <> '') and (sIsMaster[1] = '1') then PlayObject.m_boMaster:=True
      else PlayObject.m_boMaster:=False;
      PlayObject.RefShowName;
      SysMsg(sHumanName + ' Now has a master',c_Green,t_Hint);
    end;
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdChangeObMode(sCmd:String;nPermission:Integer;sParam1:String;boFlag:Boolean);
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,'']),c_Red,t_Hint);
    exit;
  end;
  if boFlag then begin
     SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, ''); //01/21
  end;
  m_boObMode:=boFlag;
  if m_boObMode then begin
    SysMsg(sObserverMode,c_Green,t_Hint);
  end else  SysMsg(g_sReleaseObserverMode,c_Green,t_Hint);
end;
procedure TPlayObject.CmdChangeSabukLord(Cmd:pTGameCmd;sCastleName,sGuildName: String; boFlag: Boolean);//004CFE1C
var
  Guild:TGuild;
  Castle:TUserCastle;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;

  if (sCastleName = '') or (sGuildName = '') then begin
    SysMsg('Syntax: @' + Cmd.sCmd + ' <Castle> <Guild>',c_Red,t_Hint);
    exit;
  end;
  Castle:=g_CastleManager.Find(sCastleName);
  if Castle = nil then begin
    SysMsg(format(g_sGameCommandSbkGoldCastleNotFoundMsg,[sCastleName]),c_Red,t_Hint);
    exit;
  end;

  Guild:=g_GuildManager.FindGuild(sGuildName);
  if Guild <> nil then begin
    //4CFEC7
    AddGameDataLog('27' + #9 +
                   Castle.m_sOwnGuild + #9 +
                   '0' + #9 +
                   '1' + #9 +
                   sGuildName + #9 +
                   m_sCharName + #9 +
                   '0' + #9 +
                   Castle.m_sName + #9 +
                   '0');
    Castle.GetCastle(Guild);
    if boFlag then
      UserEngine.SendServerGroupMsg(SS_211,nServerIndex,sGuildName);
    SysMsg(Castle.m_sName + ' has been taken over by ' + sGuildName,c_Green,t_Hint);
  end else begin
    SysMsg('Unable to find guild ' + sGuildName + '.',c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdChangeSalveStatus;
begin
  if m_SlaveList.Count > 0 then begin
    m_boSlaveRelax:=not m_boSlaveRelax;
    if m_boSlaveRelax then SysMsg(sPetRest,c_Green,t_Hint)
    else SysMsg(sPetAttack,c_Green,t_Hint)
  end;
end;

procedure TPlayObject.CmdChangeSuperManMode(sCmd:String;nPermission:Integer;sParam1:String;boFlag:Boolean);
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,'']),c_Red,t_Hint);
    exit;
  end;
  m_boSuperMan:=boFlag;
  if m_boSuperMan then SysMsg(sSupermanMode,c_Green,t_Hint)
  else  SysMsg(sReleaseSupermanMode,c_Green,t_Hint);
end;


procedure TPlayObject.CmdChangeUserFull(sCmd, sUserCount: String);
var
  nCount:Integer;
begin
  if (m_btPermission < 6) then exit;
  nCount:=Str_ToInt(sUserCount,-1);
  if (sUserCount = '') or (nCount < 1) or ((sUserCount <> '') and (sUserCount[1] = '?')) then begin
    SysMsg('@' + sCmd + ' <UserCount>',c_Red,t_Hint);
    exit;
  end;
  g_Config.nUserFull:=nCount;
  SysMsg(format('Max players allowed on server changed to %d.',[nCount]),c_Green,t_Hint);
end;


procedure TPlayObject.CmdChangeZenFastStep(sCmd, sFastStep: String);
var
  nFastStep:Integer;
begin
  if (m_btPermission < 6) then exit;
  nFastStep:=Str_ToInt(sFastStep,-1);
  if (sFastStep = '') or (nFastStep < 1) or ((sFastStep <> '') and (sFastStep[1] = '?')) then begin
    SysMsg('@' + sCmd + ' FastStep',c_Red,t_Hint);
    exit;
  end;
  g_Config.nZenFastStep:=nFastStep;
  SysMsg(format('Zen fast step changed to %d.',[nFastStep]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdClearBagItem(Cmd: pTGameCmd; sHumanName: String);
var
  I: Integer;
  PlayObject:TPlayObject;
  UserItem:pTUserItem;
  DelList:TStringList;
begin
  DelList:=nil;
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,' <Username>']),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
    
  for I := 0 to PlayObject.m_ItemList.Count - 1 do begin
    UserItem:=PlayObject.m_ItemList.Items[I];
    if DelList = nil then DelList:=TStringList.Create;
    DelList.AddObject(UserEngine.GetStdItemName(UserItem.wIndex), TObject(UserItem.MakeIndex));
    Dispose(UserItem);
  end;
  PlayObject.m_ItemList.Clear;
  if DelList <> nil then begin
    PlayObject.SendMsg(PlayObject,RM_SENDDELITEMLIST,0,Integer(DelList),0,0,'');
  end;
end;

procedure TPlayObject.CmdClearHumanPassword(sCmd:String;nPermission:Integer;sHumanName: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < nPermission) then exit;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format('@%s <Username>',[sCmd]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    exit;
  end;
  PlayObject.m_boPasswordLocked:=False;
  PlayObject.m_boUnLockStoragePwd:=False;
  PlayObject.m_sStoragePwd:='';
  PlayObject.SysMsg('Your storage password has been removed.',c_Green,t_Hint);
  SysMsg(format('%s''s storage password removed.',[sHumanName]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdClearMapMonster(Cmd:pTGameCmd;sMapName, sMonName,sItems: String);
var
  I,II: Integer;
  MonList:TList;
  Envir:TEnvirnoment;
  nMonCount:Integer;
  boKillAll:Boolean;
  boKillAllMap:Boolean;
  boNotItem:Boolean;
  BaseObject:TBaseObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sMapName = '') or (sMonName = '') or (sItems = '') then begin
    SysMsg('@' + Cmd.sCmd + ' <Map(*=All)> <Monster(*=All)> <Items(0,1)>',c_Red,t_Hint);
    exit;
  end;
  boKillAll:=False;
  boKillAllMap:=False;
  boNotItem:=True;
  nMonCount:=0;
  Envir:=nil;
  if sMonName = '*' then boKillAll:=True;
  if sMapName = '*' then boKillAllMap:=True;
  if sItems = '1' then boNotItem:=False;

  MonList:=TList.Create;
  for I := 0 to g_MapManager.Count - 1 do begin
    Envir:=TEnvirnoment(g_MapManager.Items[I]);
    if (Envir <> nil) and (boKillAllMap or (CompareText(Envir.sMapName,sMapName) = 0)) then begin
      UserEngine.GetMapMonster(Envir,MonList);
      for II := 0 to MonList.Count - 1 do begin
        BaseObject:=TBaseObject(MonList.Items[II]);
        if boKillAll or (CompareText(sMonName,BaseObject.m_sCharName) = 0) then begin
          BaseObject.m_boNoItem:=boNotItem;
          BaseObject.m_WAbil.HP:=0;
          Inc(nMonCount);
        end;
      end;
    end;
  end;
  MonList.Free;
  if Envir = nil then begin
    SysMsg('Map not found',c_Red,t_Hint);
    exit;
  end;

  SysMsg('Objects Cleared: ' + IntTOStr(nMonCount),c_Red,t_Hint);
end;

procedure TPlayObject.CmdClearMission(Cmd:pTGameCmd;sHumanName: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') then begin
    SysMsg('@' + Cmd.sCmd + ' <Username>)',c_Red,t_Hint);
    exit;
  end;
  if sHumanName[1] = '?' then begin
    SysMsg('This command resets a persons quest flags',c_Blue,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format('%s is not online.',[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  FillChar(PlayObject.m_QuestFlag,SizeOf(TQuestFlag),#0);
  SysMsg(format('%s has had their quest flags cleared.',[sHumanName]),c_Green,t_Hint);
end;


procedure TPlayObject.CmdContestPoint(Cmd:pTGameCmd;sGuildName: String);//004CEF08
var
  Guild:TGuild;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sGuildName = '')  or ((sGuildName <> '') and (sGuildName[1] = '?')) then begin
    SysMsg(format('@%s <GuildName>',[Cmd.sCmd]),c_Red,t_Hint);
    exit;
  end;
  Guild:=g_GuildManager.FindGuild(sGuildName);
  if Guild <> nil then begin
    SysMsg(format('%s gained %d point(s).',[sGuildName,Guild.nContestPoint]),c_Green,t_Hint);
  end else begin
    SysMsg(format('%s was not found.',[sGuildName]),c_Green,t_Hint);
  end;
end;

function TPlayObject.ItemRepair(Gem:Integer;Itemidx:integer):integer;
var
  UserItem,Gemt:pTUserItem;
  StdItem:TItem;
  GemItem :TItem;
  I,k:Integer;
  //gem part
  GiveDura:integer;
  Mode:integer;
begin
for I := 0 to m_ItemList.Count - 1 do begin
    Gemt:=m_ItemList.Items[i];
    if (Gemt <> nil) and (Gemt.MakeIndex = Gem) then begin
        GemItem:=UserEngine.GetStdItem(Gemt.wIndex);
         GiveDura:=Gemitem.DuraMax;
         Mode:=Gemitem.Source;
    end;
end;
Result:=1;
for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[i];
    if (userItem <> nil) and (UserItem.MakeIndex = Itemidx) then begin
     stdItem:=UserEngine.GetStdItem(UserItem.wIndex);
     if UserItem.Dura = UserItem.DuraMax then exit;
       if Mode=0 then begin //sewing repair   Repairs Armour, Helmet, Belt or Shoes by Dura 5
         if stditem.StdMode in [10,11,12,15,54,52] then begin
          if UserItem.Dura + GiveDura > UserItem.DuraMax then begin
           UserItem.Dura := UserItem.DuraMax;
           SysMsg('Item Repaired.',c_Green,t_Hint);
             m_DefMsg:=MakeDefaultMsg(SM_REPAIRITEMOK,UserItem.MakeIndex,0,0,0);
             SendSocket(@m_DefMsg,'');
             for k := 0 to m_ItemList.Count - 1 do begin
             Gemt:=m_ItemList.Items[k];
             if (Gemt <> nil) and (Gemt.MakeIndex = Gem) then begin
             SendDelItems(Gemt);
             Gemt.wIndex:=0;
             end;
             end;
           end else begin
           Inc(UserItem.Dura,GiveDura);
           SysMsg('Item Repaired.',c_Green,t_Hint);
            m_DefMsg:=MakeDefaultMsg(SM_REPAIRITEMOK,UserItem.MakeIndex,0,0,0);
            SendSocket(@m_DefMsg,'');
             for k := 0 to m_ItemList.Count - 1 do begin
             Gemt:=m_ItemList.Items[k];
             if (Gemt <> nil) and (Gemt.MakeIndex = Gem) then begin
             SendDelItems(Gemt);
             Gemt.wIndex:=0;
             end;
             end;
           end;
           end else begin
           SysMsg('You cannot repair this item.',c_Red,t_Hint);
           exit;
           end;
       end;
       if Mode=1 then begin //bone hammer   Repairs Weapon, Necklace, Bracelet or Ring by Dura 5
        if stditem.StdMode in [22,23,24,26,20,21,19,5,6] then begin
          if UserItem.Dura + GiveDura > UserItem.DuraMax then begin
           UserItem.Dura := UserItem.DuraMax;
           SysMsg('Item Repaired.',c_Green,t_Hint);
             m_DefMsg:=MakeDefaultMsg(SM_REPAIRITEMOK,UserItem.MakeIndex,0,0,0);
             SendSocket(@m_DefMsg,'');
             for k := 0 to m_ItemList.Count - 1 do begin
             Gemt:=m_ItemList.Items[k];
             if (Gemt <> nil) and (Gemt.MakeIndex = Gem) then begin
             SendDelItems(Gemt);
             Gemt.wIndex:=0;
             end;
             end;
           end else begin
           Inc(UserItem.Dura,GiveDura);
           SysMsg('Item Repaired.',c_Green,t_Hint);
             m_DefMsg:=MakeDefaultMsg(SM_REPAIRITEMOK,UserItem.MakeIndex,0,0,0);
             SendSocket(@m_DefMsg,'');
             for k := 0 to m_ItemList.Count - 1 do begin
             Gemt:=m_ItemList.Items[k];
             if (Gemt <> nil) and (Gemt.MakeIndex = Gem) then begin
             SendDelItems(Gemt);
             Gemt.wIndex:=0;
             end;
             end;
           end;
           end else begin
           SysMsg('You cannot repair this item.',c_Red,t_Hint);
           exit;
           end;
       end;
       end;
    end;

{ delete repair item }
end;

procedure TPlayObject.CraftFailed(datat:string);
begin
  SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,datat);
  m_DefMsg:=MakeDefaultMsg(SM_GEMSYSTEMFAIL,0,0,0,0);
  SendSocket(@m_DefMsg,'');
end;

procedure TPlayObject.CreateGem(datat:string);
const
Succesrate = 55;
MinimumSuccess =53;
var
{global variables used all over the place}
  i,ii:integer;//commonly used counter
  Items: array[1..6] of TItem; //list of the raw database values of the items we added
  UserItems: array[1..6] of pTUseritem; //list of the real values of the items we added
  Amounts: Array[1..6] of integer;
{variables used for succes rate calculations}
  Succes: integer;
  nDc, nSc, nMc: integer;
{input variables}
  GemName: String;
  Itemindexs: Array[1..6] of integer;
  tmpString : String;
  InputAmounts: Array[1..6] of integer;
{needed for getting the true items variables}
  TmpItem:pTUserItem;
  loopcount,loopcount2: integer;
{processing variables (checking if we selected all the correct items to make this gem)}
  MakeList: TStringList; //list of the items we need to make this gem
  ListString: String;
  ListAmount: Integer;
  StdItem: TItem;
  bosuccess: boolean;
{variables used when giving the player the gem}
  GemItem: TItem;
  UserItem: pTUserItem;
begin
  loopcount :=0;

{read the values client send us}
  Datat:=GetValidStr3(Datat, GemName, ['/']); //get our gem's name first
  for i := 1 to 6 do begin     //get the makeindex of our 6 items
    tmpString:='';
    ItemIndexs[i]:=0;
    Datat:=GetValidStr3(Datat, tmpString, ['/']);
    if tmpString = '' then CraftFailed('Client cheat detected');//if ppl try to manualy send packets they cheat
    ItemIndexs[i] := StrToInt64(tmpString);
    if ItemIndexs[i] <> 0 then
      inc(loopcount);//keep track of how many items we put in the 6 boxes
  end;
  for i := 1 to 6 do begin //get the amount of each of the 6 items
    tmpString:='';
    InputAmounts[i] := 0;
    Amounts[i]:=0;
    Datat:=GetValidStr3(Datat, tmpString, ['/']);
    if tmpString = '' then CraftFailed('Client cheat detected');//if ppl try to manualy send packets they cheat
    InputAmounts[i] := StrToInt64(tmpString);
  end;
{get the real items we just using to gem}
  loopcount2:=loopcount;//keep a backup of how many items the user commited for later comparing
  for i := 0 to m_ItemList.Count - 1 do begin
    TmpItem:=m_ItemList.Items[i];
    if TmpItem = nil then continue;
    for ii := 1 to 6 do begin
      if TmpItem.MakeIndex = ItemIndexs[ii] then begin
        Items[loopcount]:= UserEngine.GetStdItem(TmpItem.wIndex);
        UserItems[loopcount]:= TmpItem;
        Amounts[loopcount]:= InputAmounts[ii];
        dec(loopcount);
      end;
    end;
  end;
  if loopcount <> 0 then begin //first when we collected our list of items from client we did +1 for every item, when we checked our bag we did -1 so if this isnt 0 then client send more items then exist in our bag = bad
    CraftFailed('You added an item that isn''t in your bag!');
    exit;
  end;
{get the list of items needed to make this gem}
  MakeList:= GetMakeItemInfo(GemName);
  if MakeList.Count <> loopcount2 then begin //if the amount of unique (without checking stacked) isnt the same as the amount client says we added then it cant work!
    CraftFailed('You selected an unknown gem or didn''t add the correct items!');
    exit;
  end;

  Succes:=8;
{check if all the items client send us = all the items we need acording to list}
  for i := 0 to MakeList.Count -1 do begin
    ListString:=MakeList.Strings[I];
    ListAmount:=Integer(MakeList.Objects[I]);
    boSuccess:=FALSE;
    for ii := 1 to loopcount2 do begin
      if ListString = Items[ii].Name then begin //if the item we need = this item we added
        StdItem:=UserEngine.GetStdItem(UserItems[ii].wIndex);
        if StdItem.StdMode = 43 then begin //if the item is an ore then check if the dur is higher then what we need
          if ROUND(UserItems[ii].Dura div 1000) >= ListAmount then begin
            inc(Succes,ROUND(UserItems[ii].DuraMax div 1000));
            boSuccess:=True;
            break;
          end;
        end;
        if ListAmount <= Amounts[ii] then begin //if the amount of an item needed = or < then the amount we have of this item
          boSuccess:=True;
          break;
        end;
      end;
      if ListString = 'Accesory' then begin //if the item we need = accesoire
        StdItem:=UserEngine.GetStdItem(UserItems[ii].wIndex);
        if StdItem.StdMode in [19,20,22,23,24,26] then begin
          nDc:=HiWord(Items[ii].DC) + LoWord(Items[ii].DC);
          nSc:=HiWord(Items[ii].SC) + LoWord(Items[ii].SC);
          nMc:=HiWord(Items[ii].MC) + LoWord(Items[ii].MC);
          inc(Succes,_max(_max(nDc,nSc),nMc));//add the highest value to succes rate
          boSuccess:=True;
          break;
        end;
      end;
      if ListString = 'Stone' then begin
        StdItem:=UserEngine.GetStdItem(UserItems[ii].wIndex);
        if StdItem.StdMode = 63 then begin
          nDc:=HiWord(Items[ii].DC) + LoWord(Items[ii].DC);
          nSc:=HiWord(Items[ii].SC) + LoWord(Items[ii].SC);
          nMc:=HiWord(Items[ii].MC) + LoWord(Items[ii].MC);
          inc(Succes,_max(_max(nDc,nSc),nMc));//add the highest value to succes rate
          boSuccess:=True;
          break;
        end;
      end;
    end;
      if boSuccess = false then begin
        CraftFailed('You didn''t add the correct items!');
        exit;
      end;
  end;
  //k so now we are at the final point where we made sure it's all ok and we can take away the items and make the gem
{taking away the items we used to craft}
  for i := 1 to loopcount2 do begin
    if Items[i].StdMode = 45 then begin
      if UserItems[i].Amount > Amounts[i] then begin
        dec(UserItems[i].Amount,Amounts[i]);
        WeightChanged();
        continue;
      end;
    end;
    for ii := 0 to m_ItemList.Count - 1 do begin
      if pTUserItem(m_ItemList[ii]).MakeIndex = UserItems[i].MakeIndex then begin
        m_ItemList.Delete(ii);
        break
      end;
    end;
    Dispose(UserItems[i]);
  end;
{random succes rate}
  GemItem:=UserEngine.GetStdItem(GemName);
  if GemItem.StdMode = 37 then begin //if it's a gem we have succes rate if it isnt it always works
    if random(SuccesRate) >= _MIN(MinimumSuccess,Round(Succes + m_nBodyLuckLevel)) then begin
      SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'Creation of the gem has failed!');
      exit;
    end;
  end;
{giving the gem}
  New(UserItem);
  if UserEngine.CopyToUserItemFromName(GemName,UserItem) then begin
    UserItem.MakeIndex:=GetItemNumberEx();
    m_ItemList.Add(UserItem);
    SendAddItem(UserItem);
    SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'The gem has been created!');
  end;
end;

procedure TPlayObject.GemItemFail(UserItem:pTUserItem;msg:String);
begin
  SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,msg);
  SendAddItem(UserItem);
end;

function TPlayObject.GemItem(Gem:Integer;Itemidx:integer):integer;
var
  UserItem,GemUserItem:pTUserItem; //the 'real item stats'
  Uitem, GItem: TItem; //the db item stats
  i: integer;
  StatType: byte;
  SuccesRate: integer;
  BreakItem: boolean;
  Succes: boolean;
  DuraAdd: Integer;
begin
Result:=1;
  if (Gem = Itemidx) or (Gem = 0) or (Itemidx = 0) then begin
    SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'You can not use this gem on the selected item.');
    exit; //cant be that the gem is also the item we using so :p
  end;

{find out what item we geming and what gem we using}
  for I := 0 to m_ItemList.Count - 1 do begin
    if pTUserItem(m_ItemList[i]).MakeIndex = Gem then //gem we using
      GemUserItem:= m_ItemList[i];
    if pTUserItem(m_ItemList[i]).MakeIndex = Itemidx then           // item we geming
      UserItem:= m_ItemList[i];
  end;
  GItem:=UserEngine.GetStdItem(GemUserItem.wIndex);
  UItem:=UserEngine.GetStdItem(UserItem.wIndex);
{check if all the items truly exist}
  if (GItem = nil) or (GemUserItem = nil) then begin
    SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'This Gem/Orb is missing.');
    exit;
  end;
  if (Uitem = nil) or  (UserITem = nil) then begin
    GemItemFail(GemUserItem,'This item is missing.');
    exit;
  end;
{check if the gem used is allowed on the item we using it on}
  if UItem.Unique then begin
    GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
    exit; //cant be that the gem is also the item we using so :p
  end;
  stattype:= GItem.AC;
  case GItem.AC of
    0,1,2: begin // dc,mc,sc
      if not (UItem.StdMode in [5,6,19,20,21,22,23,24,26]) then begin
        GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
        exit; //cant be that the gem is also the item we using so :p
      end;
    end;
    3,4: begin  //ac, amc
      if not (UItem.StdMode in [10,11,12,15,22,23,26,62,64]) then begin
        GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
        exit; //cant be that the gem is also the item we using so :p
      end;
    end;
    5: begin  //aspeed
      if not (UItem.StdMode in [5,6,19,20,21,22,23]) then begin
        GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
        exit; //cant be that the gem is also the item we using so :p
      end;
    end;
    6: begin //agil
      if not (UItem.StdMode in [10,11,12,24,26,62,64]) then begin
        GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
        exit; //cant be that the gem is also the item we using so :p
      end;
    end;
    7: begin  //dura
      if not (UItem.StdMode in [5,6,10,11,12,15,19,20,21,22,23,24,26,62,64]) then begin
        GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
        exit; //cant be that the gem is also the item we using so :p
      end;
    end;
    9,14: begin //poison,freezing
      if not (UItem.StdMode in [5,6,19,20,21,22,23]) then begin
        GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
        exit; //cant be that the gem is also the item we using so :p
      end;
    end;
    15: begin //acc
      if not (UItem.StdMode in [15,19,20,21,24,26,64]) then begin
        GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
        exit; //cant be that the gem is also the item we using so :p
      end;
    end;
    11: begin //antipoison
      if not (UItem.StdMode in [5,6,10,11,12,15,19,20,21,22,23,24,26,62,64]) then begin
        GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
        exit; //cant be that the gem is also the item we using so :p
      end;
    end;
    12: begin //antimagic
      if not (UItem.StdMode in [10,11,12,15,62,64]) then begin
        GemItemFail(GemUserItem,'You can not use this gem on the selected item.');
        exit; //cant be that the gem is also the item we using so :p
      end;
    end;
  end;
{get succes rate and stuff}
  SuccesRate:= GItem.AC2;
  BreakItem:=FALSE;
  if GItem.MAC = 0 then
    BreakItem:=TRUE;
  Succes:=TRUE;
{now add the stat to the item}
  if Succes then begin //if the gem worked
    case stattype of
      0,1,2,3,4,9,14,11,12,15: begin //dc,sc,mc,ac,amc,psn,freezing, antipoison, antimagic
        if Random(10) <= SuccesRate - UserItem.btValue[StatType] then begin
          inc(UserItem.btValue[StatType],_MAX(1,Random(GItem.MAC2)));
        end else
          Succes:=FALSE;
      end;
      5: begin //aspeed
        if UItem.StdMode in [5,6] then begin//weapons use btvalue 6 and have the gay aspeed +/- system (above 10 > +, below 10 > -)
          if UserItem.btValue[6]> 10 then begin
            if Random(10) <= SuccesRate - (UserItem.btValue[6] - 10) then begin
              inc(UserItem.btValue[6],_MAX(1,Random(GItem.MAC2)));
            end else
              Succes:=FALSE;
          end else begin
            if Random(10) <= SuccesRate then begin
              if UserItem.btValue[6] > 0 then begin //if its negative aspeed atm
                inc(UserItem.btValue[6],_MAX(1,Random(GItem.MAC2)));
              end else
                inc(UserItem.btValue[6],(_MAX(1,Random(GItem.MAC2))+10));
            end else
              Succes:=FALSE;
          end;
        end else if UItem.StdMode in [19,20,21] then begin //if it is a necklace we orbing then we can use 17 :p
          if Random(10) <= SuccesRate - LoByte(UserItem.btValue[17]) then begin
            inc(UserItem.btValue[17],_MAX(1,Random(GItem.MAC2)));
          end else
            Succes:=FALSE;
        end else begin //if it isnt a wpn and it isnt a necklace we orbing then we can use 16 :p
          if Random(10) <= SuccesRate - LoByte(UserItem.btValue[16]) then begin
            inc(UserItem.btValue[16],_MAX(1,Random(GItem.MAC2)));
          end else
            Succes:=FALSE;
        end;
      end;
      6: begin //agil
        if UItem.StdMode in [10,11,12] then begin //armours use btvalue 6
          if Random(10) <= SuccesRate - UserItem.btValue[StatType] then begin
            inc(UserItem.btValue[StatType],_MAX(1,Random(GItem.MAC2)));
          end else
            Succes:=FALSE;
        end else begin //bracelets however use 16
          if Random(10) <= SuccesRate - LoByte(UserItem.btValue[16]) then begin
            inc(UserItem.btValue[16],_MAX(1,Random(GItem.MAC2)));
          end else
            Succes:=FALSE;
        end;
      end;
      7: begin //dura
        if Random(10) <= SuccesRate - (_MAX(0,(UserItem.DuraMax div 1000) - (UItem.DuraMax div 1000)) div 2) then begin
          DuraAdd:= (GItem.MAC2 * 1000); //Babyhack thanks to Sean
          if (UserItem.DuraMax + DuraAdd) > high(UserItem.DuraMax) then begin
            UserItem.DuraMax := high(UserItem.DuraMax);
          end else
            inc(UserItem.DuraMax, DuraAdd);
        end else
          Succes:= FALSE;
      end;
    end;
  end;
{take away the used up orb + if a gem the failed item}
  for i := 0 to m_ItemList.Count - 1 do begin //taking away our gem
    if pTUserItem(m_ItemList[i]).MakeIndex = GemUserItem.MakeIndex then begin
      m_ItemList.Delete(i);
      break
    end;
  end;
  Dispose(GemUserItem);

  if (not Succes) and (BreakItem) then begin //if the orbing/geming failed and the item should break then take it away
    SendDelItems(UserItem);
    for i := 0 to m_ItemList.Count - 1 do begin
      if pTUserItem(m_ItemList[i]).MakeIndex = UserItem.MakeIndex then begin
        m_ItemList.Delete(i);
        break
      end;
    end;
    Dispose(UserItem);
    SysMsg('The item was destroyed', c_Red, t_Hint);
    exit;
  end;
  if succes then begin
    SysMsg('The item was upgraded', c_Red,t_Hint);
    SendUpdateItem(UserItem);
  end else
    SysMsg('The item was not upgraded', c_Red,t_Hint);
end;

procedure TPlayObject.RecallGuild();
var
  I,II: Integer;
  dwValue:LongWord;
  PlayObject:TPlayObject;
  GuildRank:pTGuildRank;
  nRecallCount,nNoRecallCount:Integer;
begin
  nRecallCount:=0;
  nNoRecallCount:=0;
  dwValue:=(GetTickCount - m_dwGroupRcallTick) div 1000;
  m_dwGroupRcallTick:=m_dwGroupRcallTick + dwValue * 1000;

  if m_wGroupRcallTime > dwValue then begin
    Dec(m_wGroupRcallTime,dwValue);
  end else m_wGroupRcallTime:=0;

  if m_wGroupRcallTime > 0 then begin
    SysMsg(format('%d seconds until you can recall again.',[m_wGroupRcallTime]),c_Red,t_Hint);
    exit;
  end;
  for I := 0 to TGuild(m_MyGuild).m_RankList.Count - 1 do begin
    GuildRank:=TGuild(m_MyGuild).m_RankList.Items[I];
    for II:=0 to GuildRank.MemberList.Count -1 do begin
      PlayObject:=TPlayObject(GuildRank.MemberList.Objects[II]);
      if PlayObject <> nil then begin
        if PlayObject = Self then begin
//          Inc(nNoRecallCount);
          Continue;
        end;
        if PlayObject.m_boAllowGuildReCall then begin
          if PlayObject.m_PEnvir.Flag.boNORECALL then begin
            SysMsg(format('%s Cannot be recalled from that map',[PlayObject.m_sCharName]),c_Red,t_Hint);
          end else begin
            RecallHuman(PlayObject.m_sCharName);
            Inc(nRecallCount);
          end;
        end else begin
          Inc(nNoRecallCount);
          SysMsg(format('%s Has Disabled Guild Recall',[PlayObject.m_sCharName]),c_Red,t_Hint);
        end;
      end;
    end;
  end;
  SysMsg(format('People Recalled:%d,People Blocked:%d',[nRecallCount,nNoRecallCount]),c_Green,t_Hint);
  m_dwGroupRcallTick:=GetTickCount();
  m_wGroupRcallTime:=g_Config.nGuildRecallTime;
end;

procedure TPlayObject.CmdStartContest(Cmd:pTGameCmd;sParam1:String);//004CF008
var
  I,II: Integer;
  List10,List14:TList;
  PlayObject,PlayObjectA:TPlayObject;
  bo19:Boolean;
  s20:String;
  Guild:TGuild;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg('Guild contest started..',c_Red,t_Hint);
    SysMsg(format('Involved: @%s',[Cmd.sCmd]),c_Red,t_Hint);
    exit;
  end;
  
  if not m_PEnvir.Flag.boFight3Zone then begin
    SysMsg('This area is not a valid contest zone...',c_Red,t_Hint);
    exit;
  end;
  List10:=TList.Create;
  List14:=TList.Create;
  UserEngine.GetMapRageHuman(m_PEnvir,m_nCurrX,m_nCurrY,1000,List10);
  for I := 0 to List10.Count - 1 do begin
    PlayObject:=TPlayObject(List10.Items[I]);
    if not PlayObject.m_boObMode or not PlayObject.m_boAdminMode then begin
      PlayObject.m_nFightZoneDieCount:=0;
      if PlayObject.m_MyGuild = nil then Continue;
      bo19:=False;
      for II := 0 to List14.Count - 1 do begin
        PlayObjectA:=TPlayObject(List14.Items[II]);
        if PlayObject.m_MyGuild = PlayObjectA.m_MyGuild then
          bo19:=True;
      end;
      if not bo19 then begin
        List14.Add(PlayObject.m_MyGuild);
      end;        
    end;
  end;
  SysMsg('Guild War Started',c_Green,t_Hint);
  UserEngine.CryCry(RM_CRY,m_PEnvir,m_nCurrX,m_nCurrY,1000,g_Config.btCryMsgFColor,g_Config.btCryMsgBColor,'- 行会战争已爆发。');
  s20:='';
  for I := 0 to List14.Count - 1 do begin
    Guild:=TGuild(List14.Items[I]);
    Guild.StartTeamFight();
    for II := 0 to List10.Count - 1 do  begin
      PlayObject:=TPlayObject(List10.Items[I]);
      if PlayObject.m_MyGuild = Guild then begin
        Guild.AddTeamFightMember(PlayObject.m_sCharName);
      end;
    end;
    s20:=s20 + Guild.sGuildName + ' ';
  end;
  UserEngine.CryCry(RM_CRY,m_PEnvir,m_nCurrX,m_nCurrY,1000,g_Config.btCryMsgFColor,g_Config.btCryMsgBColor,' -参加的门派:' + s20);
  List10.Free;
  List14.Free;
end;

procedure TPlayObject.CmdEndContest(Cmd:pTGameCmd;sParam1:String);//004CF364
var
  I,II: Integer;
  List10,List14:TList;
  PlayObject,PlayObjectA:TPlayObject;
  bo19:Boolean;
  Guild:TGuild;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg('Guild contest over...',c_Red,t_Hint);
    SysMsg(format('Winner: @%s',[Cmd.sCmd]),c_Red,t_Hint);
    exit;
  end;

  if not m_PEnvir.Flag.boFight3Zone then begin
    SysMsg('Contests only work on guild warmaps',c_Red,t_Hint);
    exit;
  end;
  List10:=TList.Create;
  List14:=TList.Create;
  UserEngine.GetMapRageHuman(m_PEnvir,m_nCurrX,m_nCurrY,1000,List10);
  for I := 0 to List10.Count - 1 do begin
    PlayObject:=TPlayObject(List10.Items[I]);
    if not PlayObject.m_boObMode or not PlayObject.m_boAdminMode then begin
      if PlayObject.m_MyGuild = nil then Continue;
      bo19:=False;
      for II := 0 to List14.Count - 1 do begin
        PlayObjectA:=TPlayObject(List14.Items[II]);
        if PlayObject.m_MyGuild = PlayObjectA.m_MyGuild then
          bo19:=True;
      end;
      if not bo19 then begin
        List14.Add(PlayObject.m_MyGuild);
      end;        
    end;
  end;
  for I := 0 to List14.Count - 1 do begin
    Guild:=TGuild(List14.Items[I]);
    Guild.EndTeamFight();
    UserEngine.CryCry(RM_CRY,m_PEnvir,m_nCurrX,m_nCurrY,1000,g_Config.btCryMsgFColor,g_Config.btCryMsgBColor,format(' - %s 行会争霸赛已结束。',[Guild.sGuildName]));
  end;
  List10.Free;
  List14.Free;
end;

procedure TPlayObject.CmdAllowGroupReCall(sCmd, sParam: String);
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('Error [AllowGroupRecall]',c_Red,t_Hint);
    exit;
  end;

  m_boAllowGroupReCall:= not m_boAllowGroupReCall;
  if m_boAllowGroupReCall then SysMsg(g_sEnableGroupRecall,c_Green,t_Hint)
  else SysMsg(g_sDisableGroupRecall,c_Green,t_Hint);
end;


procedure TPlayObject.CmdAnnouncement(Cmd:pTGameCmd;sGuildName: String);//004CF564
var
  I: Integer;
  Guild:TGuild;
  sHumanName:String;
  nPoint:Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sGuildName = '') or ((sGuildName <> '') and (sGuildName[1] = '?')) then begin
    //SysMsg('FixMsg[559]',c_Red,t_Hint);
    SysMsg(format('Use this: @%s <Guildname>',[Cmd.sCmd]),c_Red,t_Hint);
    exit;
  end;

  if not m_PEnvir.Flag.boFight3Zone then begin
    SysMsg('Announcements only work in guild war maps',c_Red,t_Hint);
    exit;
  end;
  Guild:=g_GuildManager.FindGuild(sGuildName);
  if Guild <> nil then begin
    UserEngine.CryCry(RM_CRY,m_PEnvir,m_nCurrX,m_nCurrY,1000,g_Config.btCryMsgFColor,g_Config.btCryMsgBColor,format(' - %s 行会争霸赛结果: ',[Guild.sGuildName]));
    for I := 0 to Guild.TeamFightDeadList.Count - 1 do begin
      nPoint:=Integer(Guild.TeamFightDeadList.Objects[I]);
      sHumanName:=Guild.TeamFightDeadList.Strings[I];
      UserEngine.CryCry(RM_CRY,
                        m_PEnvir,
                        m_nCurrX,
                        m_nCurrY,
                        1000,
                        g_Config.btCryMsgFColor,
                        g_Config.btCryMsgBColor,
                        format(' - %s  : %d 分/死亡%d次。 ',[sHumanName,HiWord(nPoint),LoWord(nPoint)]));
    end;
  end;
      UserEngine.CryCry(RM_CRY,
                        m_PEnvir,
                        m_nCurrX,
                        m_nCurrY,
                        1000,
                        g_Config.btCryMsgFColor,
                        g_Config.btCryMsgBColor,
                        format(' - [%s] : %d points.',[Guild.sGuildName,Guild.nContestPoint]));
      UserEngine.CryCry(RM_CRY,
                        m_PEnvir,
                        m_nCurrX,
                        m_nCurrY,
                        1000,
                        g_Config.btCryMsgFColor,
                        g_Config.btCryMsgBColor,
                        '------------------------------------');
end;

procedure TPlayObject.CmdDearRecall(sCmd, sParam: String);
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('@' + sCmd + ' this command recalls your partner',c_Green,t_Hint);
    exit;
  end;
  if m_sDearName = '' then begin
    SysMsg('You are not married.',c_Red,t_Hint);
    exit;
  end;
  if m_PEnvir.Flag.boNODEARRECALL then begin
    SysMsg('Your partner is not allowing recall.',c_Red,t_Hint);
    exit;
  end;
    
    
  if m_DearHuman = nil then begin
    if m_btGender = gMan then begin
      SysMsg('Your wife is not online.',c_Red,t_Hint);
    end else begin
      SysMsg('Your husband is not online.',c_Red,t_Hint);
    end; 
    exit;
  end;
  if GetTickCount - m_dwDearRecallTick < 10000 then begin
    SysMsg('Please wait 10 seconds before you can recall again.',c_Red,t_Hint);
    exit;
  end;
  m_dwDearRecallTick:=GetTickCount();
  if m_DearHuman.m_boCanDearRecall then begin
    RecallHuman(m_DearHuman.m_sCharName);
  end else begin
    SysMsg(m_DearHuman.m_sCharName + ' is not allowing recall.',c_Red,t_Hint);
    exit;
  end;
      
end;

procedure TPlayObject.CmdMasterRecall(sCmd, sParam: String);
var
  I: Integer;
  MasterHuman:TPlayObject;
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('@' + sCmd + ' this command recalls your apprentice',c_Green,t_Hint);
    exit;
  end;
  if not m_boMaster then begin
    SysMsg('You are not a master.',c_Red,t_Hint);
    exit;
  end;
  if m_MasterList.Count = 0 then begin
    SysMsg('You have no apprentices online.',c_Red,t_Hint);
    exit;
  end;
  if m_PEnvir.Flag.boNOMASTERRECALL then begin
    SysMsg('Your apprentices must allow recall.',c_Red,t_Hint);
    exit;
  end;
  if GetTickCount - m_dwMasterRecallTick < 10000 then begin
    SysMsg('Please wait 10 seconds before you can recall again.',c_Red,t_Hint);
    exit;
  end;
  for I := 0 to m_MasterList.Count - 1 do begin
    MasterHuman:=TPlayObject(m_MasterList.Items[I]);
    if MasterHuman.m_boCanMasterRecall then begin
      RecallHuman(MasterHuman.m_sCharName);
    end else begin
      SysMsg(MasterHuman.m_sCharName + ' is not allowing recall.',c_Red,t_Hint);
    end;
  end;
end;

procedure TPlayObject.CmdDelBonuPoint(Cmd:pTGameCmd;sHumName: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sHumName = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <Username>',c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if PlayObject <> nil then begin
    FillChar(PlayObject.m_BonusAbil,SizeOf(TNakedAbility),#0);
    PlayObject.m_nBonusPoint:=0;
    PlayObject.SendMsg (PlayObject,RM_ADJUST_BONUS,0,0,0,0,'');
    PlayObject.HasLevelUp(0);
    PlayObject.SysMsg('Your bonus points have been deleted.',c_Red,t_Hint);
    SysMsg(sHumName + ' has had their bonus points deleted.',c_Green,t_Hint);
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumName]),c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdReNewLevel(Cmd:pTGameCmd;sHumanName, sLevel: String);
var
  PlayObject:TPlayObject;
  nLevel:Integer;
begin
  if (m_btPermission < 6) then exit;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Level>',c_Red,t_Hint);
    exit;
  end;
  nLevel:=Str_ToInt(sLevel,-1);
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    if (nLevel >= 0) and (nLevel <= 255) then begin
      PlayObject.m_btReLevel:=nLevel;
      PlayObject.RefShowName();
    end;
    SysMsg(sHumanName + ' is now level ' + IntToStr(PlayObject.m_btReLevel),c_Green,t_Hint);
  end else begin
    SysMsg(sHumanName + ' is not online.',c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdRestBonuPoint(Cmd:pTGameCmd;sHumName: String);
var
  PlayObject:TPlayObject;
  nTotleUsePoint:Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sHumName = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <Username>',c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if PlayObject <> nil then begin
    nTotleUsePoint:=PlayObject.m_BonusAbil.DC +
                    PlayObject.m_BonusAbil.MC +
                    PlayObject.m_BonusAbil.SC +
                    PlayObject.m_BonusAbil.AC +
                    PlayObject.m_BonusAbil.MAC +
                    PlayObject.m_BonusAbil.HP +
                    PlayObject.m_BonusAbil.MP +
                    PlayObject.m_BonusAbil.Hit +
                    PlayObject.m_BonusAbil.Speed +
                    PlayObject.m_BonusAbil.X2;
    FillChar(PlayObject.m_BonusAbil,SizeOf(TNakedAbility),#0);


    Inc(PlayObject.m_nBonusPoint,nTotleUsePoint);
    PlayObject.SendMsg (PlayObject,RM_ADJUST_BONUS,0,0,0,0,'');
    PlayObject.HasLevelUp(0);
    PlayObject.SysMsg('Your bonus points are rested.',c_Red,t_Hint);
    SysMsg(sHumName + ' has had their bonus points rested.',c_Green,t_Hint);
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumName]),c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdSbkDoorControl(sCmd, sParam: String);
begin

end;

procedure TPlayObject.CmdSearchDear(sCmd, sParam: String);
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('This command will tell you where your husband or wife is' ,c_Red,t_Hint);
    exit;
  end;
  if m_sDearName = '' then begin
    SysMsg(g_sYouAreNotMarriedMsg,c_Red,t_Hint);
    exit;
  end;
  if m_DearHuman = nil then begin
    if m_btGender = gMan then begin
      SysMsg(g_sYourWifeNotOnlineMsg,c_Red,t_Hint);
    end else begin
      SysMsg(g_sYourHusbandNotOnlineMsg,c_Red,t_Hint);
    end;
    exit;
  end;
  
  if m_btGender = gMan then begin
    SysMsg(g_sYourWifeNowLocateMsg,c_Green,t_Hint);
    SysMsg(m_DearHuman.m_sCharName + ' ' + m_DearHuman.m_PEnvir.sMapDesc + '(' + IntToStr(m_DearHuman.m_nCurrX) + ':' + IntToStr(m_DearHuman.m_nCurrY) + ')' ,c_Green,t_Hint);
    m_DearHuman.SysMsg(g_sYourHusbandSearchLocateMsg,c_Green,t_Hint);
    m_DearHuman.SysMsg(m_sCharName + ' ' + m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) + ')' ,c_Green,t_Hint);
  end else begin
    SysMsg(g_sYourHusbandNowLocateMsg,c_Red,t_Hint);
    SysMsg(m_DearHuman.m_sCharName + ' ' + m_DearHuman.m_PEnvir.sMapDesc + '(' + IntToStr(m_DearHuman.m_nCurrX) + ':' + IntToStr(m_DearHuman.m_nCurrY) + ')' ,c_Green,t_Hint);
    m_DearHuman.SysMsg(g_sYourWifeSearchLocateMsg,c_Green,t_Hint);
    m_DearHuman.SysMsg(m_sCharName + ' ' + m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) + ')' ,c_Green,t_Hint);
  end;
    
end;

procedure TPlayObject.CmdSearchMaster(sCmd, sParam: String);
var
  I: Integer;
  Human:TPlayObject;
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('This command will tell you where your master or servant is',c_Red,t_Hint);
    exit;
  end;
  if m_sMasterName = '' then begin
    SysMsg(g_sYouAreNotMasterMsg,c_Red,t_Hint);
    exit;
  end;
  if m_boMaster then begin
    if m_MasterList.Count <= 0 then begin
      SysMsg(g_sYourMasterListNotOnlineMsg,c_Red,t_Hint);
      exit;
    end;
    SysMsg(g_sYourMasterListNowLocateMsg,c_Green,t_Hint);
    for I := 0 to m_MasterList.Count - 1 do begin
      Human:=TPlayObject(m_MasterList.Items[I]);
      SysMsg(Human.m_sCharName + ' ' + Human.m_PEnvir.sMapDesc + '(' + IntToStr(Human.m_nCurrX) + ':' + IntToStr(Human.m_nCurrY) + ')' ,c_Green,t_Hint);
      Human.SysMsg(g_sYourMasterSearchLocateMsg,c_Green,t_Hint);
      Human.SysMsg(m_sCharName + ' ' + m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) + ')' ,c_Green,t_Hint);
    end;
  end else begin
    if m_MasterHuman = nil then begin
      SysMsg(g_sYourMasterNotOnlineMsg,c_Red,t_Hint);
      exit;
    end;
    SysMsg(g_sYourMasterNowLocateMsg,c_Red,t_Hint);
    SysMsg(m_MasterHuman.m_sCharName + ' ' + m_MasterHuman.m_PEnvir.sMapDesc + '(' + IntToStr(m_MasterHuman.m_nCurrX) + ':' + IntToStr(m_MasterHuman.m_nCurrY) + ')' ,c_Green,t_Hint);
    m_MasterHuman.SysMsg(g_sYourMasterListSearchLocateMsg,c_Green,t_Hint);
    m_MasterHuman.SysMsg(m_sCharName + ' ' + m_PEnvir.sMapDesc + '(' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) + ')' ,c_Green,t_Hint);
  end;
end;

procedure TPlayObject.CmdSetPermission(Cmd:pTGameCmd;sHumanName,sPermission: String);
var
  nPerission:Integer;
  PlayObject:TPlayObject;
ResourceString
  sOutFormatMsg = '[Permission Changed] %s (%s %d -> %d)';
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  nPerission:=Str_ToInt(sPermission,0);
  if (sHumanName = '') or not (nPerission in [0..10]) then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Permission(0 - 10)>',c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  if g_Config.boShowMakeItemMsg then
    MainOutMessage(format(sOutFormatMsg,[m_sCharName,PlayObject.m_sCharName,PlayObject.m_btPermission,nPerission]));
  PlayObject.m_btPermission:=nPerission;
  SysMsg(sHumanName + ' changed permission to ' + IntToStr(PlayObject.m_btPermission),c_Red,t_Hint);
end;

procedure TPlayObject.CmdShowHumanFlag(sCmd: String; nPermission: Integer;
  sHumanName,sFlag: String);
var
  PlayObject:TPlayObject;
  nFlag:Integer;
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,g_sGameCommandShowHumanFlagHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  nFlag:=Str_ToInt(sFlag,0);
  if PlayObject.GetQuestFalgStatus(nFlag) = 1 then begin
    SysMsg(format(g_sGameCommandShowHumanFlagONMsg,[PlayObject.m_sCharName,nFlag]),c_Green,t_Hint);
  end else begin
    SysMsg(format(g_sGameCommandShowHumanFlagOFFMsg,[PlayObject.m_sCharName,nFlag]),c_Green,t_Hint);
  end;
end;

procedure TPlayObject.CmdShowHumanUnit(sCmd: String; nPermission: Integer;
  sHumanName, sUnit: String);
var
  PlayObject:TPlayObject;
  nUnit:Integer;
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,g_sGameCommandShowHumanUnitHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  nUnit:=Str_ToInt(sUnit,0);
  if PlayObject.GetQuestUnitStatus(nUnit) = 1 then begin
    SysMsg(format(g_sGameCommandShowHumanUnitONMsg,[PlayObject.m_sCharName,nUnit]),c_Green,t_Hint);
  end else begin
    SysMsg(format(g_sGameCommandShowHumanUnitOFFMsg,[PlayObject.m_sCharName,nUnit]),c_Green,t_Hint);
  end;
end;

procedure TPlayObject.CmdShowHumanUnitOpen(sCmd: String; nPermission: Integer;
  sHumanName, sUnit: String);
var
  PlayObject:TPlayObject;
  nUnit:Integer;
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,g_sGameCommandShowHumanUnitHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  nUnit:=Str_ToInt(sUnit,0);
  if PlayObject.GetQuestUnitOpenStatus(nUnit) = 1 then begin
    SysMsg(format(g_sGameCommandShowHumanUnitONMsg,[PlayObject.m_sCharName,nUnit]),c_Green,t_Hint);
  end else begin
    SysMsg(format(g_sGameCommandShowHumanUnitOFFMsg,[PlayObject.m_sCharName,nUnit]),c_Green,t_Hint);
  end;
end;

procedure TPlayObject.CmdShowMapInfo(Cmd:pTGameCmd;sParam1:String);
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,'']),c_Red,t_Hint);
    exit;
  end;
  SysMsg(format(g_sGameCommandMapInfoMsg,[m_PEnvir.sMapName,m_PEnvir.sMapDesc]),c_Green,t_Hint);
  SysMsg(format(g_sGameCommandMapInfoSizeMsg,[m_PEnvir.Header.wWidth,m_PEnvir.Header.wHeight]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdShowMapMode(sCmd, sMapName: String);
var
  Envir:TEnvirnoment;
  sMsg:String;
begin
  if (m_btPermission < 6) then exit;
  if (sMapName = '') then begin
    SysMsg('@' + sCmd + ' <Map>',c_Red,t_Hint);
    exit;
  end;
  Envir:=g_MapManager.FindMap(sMapName);
  if (Envir = nil) then begin
    SysMsg(sMapName + ' does not exist.',c_Red,t_Hint);
    exit;
  end;
  sMsg:='Map Info: ' + Envir.GetEnvirInfo;
  SysMsg(sMsg,c_Blue,t_Hint);  
end;

procedure TPlayObject.CmdSetMapMode(sCmd, sMapName, sMapMode, sParam1,
  sParam2: String);
var
  Envir:TEnvirnoment;
  sMsg:String;
begin
  if (m_btPermission < 6) then exit;
  if (sMapName = '') or (sMapMode = '') then begin
    SysMsg('@' + sCmd + ' <Map> <MapMode>',c_Red,t_Hint);
    exit;
  end;
  Envir:=g_MapManager.FindMap(sMapName);
  if (Envir = nil) then begin
    SysMsg(sMapName + ' does not exist.',c_Red,t_Hint);
    exit;
  end;
  if CompareText(sMapMode,'SAFE') = 0 then begin
    if (sParam1 <> '')then begin
      Envir.Flag.boSAFE:=True;
    end else begin
      Envir.Flag.boSAFE:=False;
    end;
  end else
  if CompareText(sMapMode,'DARK') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boDarkness:=True;
    end else begin
      Envir.Flag.boDarkness:=False;
    end;
  end else
  if CompareText(sMapMode,'FIGHT') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boFightZone:=True;
    end else begin
      Envir.Flag.boFightZone:=False;
    end;
  end else
  if CompareText(sMapMode,'FIGHT3') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boFight3Zone:=True;
    end else begin
      Envir.Flag.boFight3Zone:=False;
    end;
  end else
  if CompareText(sMapMode,'DAY') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boDayLight:=True;
    end else begin
      Envir.Flag.boDayLight:=False;
    end;
  end else
  if CompareText(sMapMode,'QUIZ') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boQUIZ:=True;
    end else begin
      Envir.Flag.boQUIZ:=False;
    end;
  end else
  if CompareText(sMapMode,'NORECONNECT') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNORECONNECT:=True;
      Envir.Flag.sNoReconnectMap:=sParam1;
    end else begin
      Envir.Flag.boNORECONNECT:=False;
    end;
  end else
  if CompareText(sMapMode,'MUSIC') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boMUSIC:=True;
      Envir.Flag.nMUSICID:=Str_ToInt(sParam1,-1);
    end else begin
      Envir.Flag.boMUSIC:=False;
    end;
  end else
  if CompareText(sMapMode,'EXPRATE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boEXPRATE:=True;
      Envir.Flag.nEXPRATE:=Str_ToInt(sParam1,-1);
    end else begin
      Envir.Flag.boEXPRATE:=False;
    end;
  end else
  if CompareText(sMapMode,'PKWINLEVEL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boPKWINLEVEL:=True;
      Envir.Flag.nPKWINLEVEL:=Str_ToInt(sParam1,-1);
    end else begin
      Envir.Flag.boPKWINLEVEL:=False;
    end;
  end else
  if CompareText(sMapMode,'PKWINEXP') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boPKWINEXP:=True;
      Envir.Flag.nPKWINEXP:=Str_ToInt(sParam1,-1);
    end else begin
      Envir.Flag.boPKWINEXP:=False;
    end;
  end else
  if CompareText(sMapMode,'PKLOSTLEVEL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boPKLOSTLEVEL:=True;
      Envir.Flag.nPKLOSTLEVEL:=Str_ToInt(sParam1,-1);
    end else begin
      Envir.Flag.boPKLOSTLEVEL:=False;
    end;
  end else
  if CompareText(sMapMode,'PKLOSTEXP') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boPKLOSTEXP:=True;
      Envir.Flag.nPKLOSTEXP:=Str_ToInt(sParam1,-1);
    end else begin
      Envir.Flag.boPKLOSTEXP:=False;
    end;
  end else
  if CompareText(sMapMode,'DECHP') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.Flag.boDECHP:=True;
      Envir.Flag.nDECHPTIME:=Str_ToInt(sParam1,-1);
      Envir.Flag.nDECHPPOINT:=Str_ToInt(sParam2,-1);
    end else begin
      Envir.Flag.boDECHP:=False;
    end;
  end else
  if CompareText(sMapMode,'DECGAMEGOLD') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.Flag.boDECGAMEGOLD:=True;
      Envir.Flag.nDECGAMEGOLDTIME:=Str_ToInt(sParam1,-1);
      Envir.Flag.nDECGAMEGOLD:=Str_ToInt(sParam2,-1);
    end else begin
      Envir.Flag.boDECGAMEGOLD:=False;
    end;
  end else
  if CompareText(sMapMode,'INCGAMEGOLD') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.Flag.boINCGAMEGOLD:=True;
      Envir.Flag.nINCGAMEGOLDTIME:=Str_ToInt(sParam1,-1);
      Envir.Flag.nINCGAMEGOLD:=Str_ToInt(sParam2,-1);
    end else begin
      Envir.Flag.boINCGAMEGOLD:=False;
    end;
  end else
  if CompareText(sMapMode,'INCGAMEPOINT') = 0 then begin
    if (sParam1 <> '') and (sParam2 <> '') then begin
      Envir.Flag.boINCGAMEPOINT:=True;
      Envir.Flag.nINCGAMEPOINTTIME:=Str_ToInt(sParam1,-1);
      Envir.Flag.nINCGAMEPOINT:=Str_ToInt(sParam2,-1);
    end else begin
      Envir.Flag.boINCGAMEPOINT:=False;
    end;
  end else
  if CompareText(sMapMode,'RUNHUMAN') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boRUNHUMAN:=True;
    end else begin
      Envir.Flag.boRUNHUMAN:=False;
    end;
  end else
  if CompareText(sMapMode,'RUNMON') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boRUNMON:=True;
    end else begin
      Envir.Flag.boRUNMON:=False;
    end;
  end else
  if CompareText(sMapMode,'NEEDHOLE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNEEDHOLE:=True;
    end else begin
      Envir.Flag.boNEEDHOLE:=False;
    end;
  end else
  if CompareText(sMapMode,'NORECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNORECALL:=True;
    end else begin
      Envir.Flag.boNORECALL:=False;
    end;
  end else
  if CompareText(sMapMode,'NOGUILDRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNOGUILDRECALL:=True;
    end else begin
      Envir.Flag.boNOGUILDRECALL:=False;
    end;
  end else
  if CompareText(sMapMode,'NODEARRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNODEARRECALL:=True;
    end else begin
      Envir.Flag.boNODEARRECALL:=False;
    end;
  end else
  if CompareText(sMapMode,'NOMASTERRECALL') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNOMASTERRECALL:=True;
    end else begin
      Envir.Flag.boNOMASTERRECALL:=False;
    end;
  end else
  if CompareText(sMapMode,'NORANDOMMOVE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNORANDOMMOVE:=True;
    end else begin
      Envir.Flag.boNORANDOMMOVE:=False;
    end;
  end else
  if CompareText(sMapMode,'NODRUG') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNODRUG:=True;
    end else begin
      Envir.Flag.boNODRUG:=False;
    end;
  end else
  if CompareText(sMapMode,'MINE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boMINE:=True;
    end else begin
      Envir.Flag.boMINE:=False;
    end;
  end else
  if CompareText(sMapMode,'MINE2') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boMINE2:=True;
    end else begin
      Envir.Flag.boMINE2:=False;
    end;
  end else
  if CompareText(sMapMode,'MINE3') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boMINE3:=True;
    end else begin
      Envir.Flag.boMINE3:=False;
    end;
  end else
  if CompareText(sMapMode,'NOTHROWITEM') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNOTHROWITEM:=True;
    end else begin
      Envir.Flag.boNOTHROWITEM:=False;
    end;
  end else
  if CompareText(sMapMode,'NODROPITEM') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNODROPITEM:=True;
    end else begin
      Envir.Flag.boNODROPITEM:=False;
    end;
  end else
  if CompareText(sMapMode,'NOPOSITIONMOVE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNOPOSITIONMOVE:=True;
    end else begin
      Envir.Flag.boNOPOSITIONMOVE:=False;
    end;
  end else
  if CompareText(sMapMode,'NOHORSE') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNOHORSE:=True;
    end else begin
      Envir.Flag.boNOHORSE:=False;
    end;
  end else
  if CompareText(sMapMode,'NOCHAT') = 0 then begin
    if (sParam1 <> '') then begin
      Envir.Flag.boNOCHAT:=True;
    end else begin
      Envir.Flag.boNOCHAT:=False;
    end;
  end;
  sMsg:='Environment: ' + Envir.GetEnvirInfo;
  SysMsg(sMsg,c_Blue,t_Hint);
end;

procedure TPlayObject.CmdDeleteItem(Cmd:pTGameCmd;sHumanName,sItemName:String;nCount:Integer);//004CDFF8
var
  I: Integer;
  PlayObject:TPlayObject;
  nItemCount:Integer;
  StdItem:TItem;
  UserItem:pTUserItem;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or (sItemName = '') then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Itemname> <Amount>',c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  nItemCount:=0;
  for I := PlayObject.m_ItemList.Count - 1 to 0 do begin
    UserItem:=PlayObject.m_ItemList.Items[I];
    StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
    if (StdItem <> nil) and (CompareText(sItemName,StdItem.Name) = 0) then begin
      PlayObject.SendDelItems(UserItem);
      Dispose(UserItem);
      PlayObject.m_ItemList.Delete(I);
      Inc(nItemCount);
      if nItemCount >= nCount then
        break;
    end;
  end;
end;

procedure TPlayObject.CmdDelGold(Cmd:pTGameCmd;sHumName: String; nCount: Integer);//004CD27C
var
  PlayObject:TPlayObject;
  nServerIndex:integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumName = '') or (nCount <= 0) then exit;
  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if PlayObject <> nil then begin
    if PlayObject.m_nGold > nCount then begin
      Dec(PlayObject.m_nGold,nCount);
    end else begin
      nCount:=PlayObject.m_nGold;
      PlayObject.m_nGold:=0;
    end;
    PlayObject.GoldChanged();
    SysMsg(IntToStr(nCount)+ ' gold was removed from ' + sHumName + '.' ,c_Green,t_Hint);
            //004CD409
          if g_boGameLogGold then
            AddGameDataLog ('13' + #9 +
                        m_sMapName + #9 +
                        IntToStr(m_nCurrX) + #9 +
                        IntToStr(m_nCurrY) + #9 +
                        m_sCharName + #9 +
                        sSTRING_GOLDNAME + #9 +
                        IntToStr(nCount) + #9 +
                        '1' + #9 +
                        sHumName);
  end else begin
    if UserEngine.FindOtherServerUser(sHumName,nServerIndex) then begin
      SysMsg(sHumName + ' is on server ' + IntToStr(nServerIndex)+ '.',c_Green,t_Hint);
    end else begin
      FrontEngine.AddChangeGoldList(m_sCharName,sHumName,-nCount);
      SysMsg(sHumName + ' has been added to the changegoldlist',c_Green,t_Hint);
    end;
  end;
end;
procedure TPlayObject.CmdDelGuild(Cmd:pTGameCmd;sGuildName: String);//004CEDEC
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if nServerIndex <> 0 then begin
    SysMsg('Guilds can only be deleted on the mastersserver',c_Red,t_Hint);
    exit;
  end;
  if sGuildName = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <GuildName>',c_Red,t_Hint);
    exit;
  end;
  if g_GuildManager.DelGuild(sGuildName) then begin
    UserEngine.SendServerGroupMsg(SS_206,nServerIndex,sGuildName);
  end else begin
    SysMsg('Deleted guild ' + sGuildName + '. Remember to manually delete guild files.',c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdDelNpc(sCmd:String;nPermission:Integer;sParam1:String);
var
  BaseObject:TBaseObject;
  I:Integer;
ResourceString
  sDelOK = 'NPC Removed';
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,'']),c_Red,t_Hint);
    exit;
  end;
  BaseObject:=GetPoseCreate();
  if BaseObject <> nil then begin
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      if TBaseObject(UserEngine.m_MerchantList.Items[I]) = BaseObject then begin
        BaseObject.m_boGhost:=True;
        BaseObject.m_dwGhostTick:=GetTickCount();
        BaseObject.SendRefMsg(RM_DISAPPEAR,0,0,0,0,'');
        SysMsg(sDelOK,c_Red,t_Hint);
        exit;
      end;
    end;
    for I := 0 to UserEngine.QuestNPCList.Count - 1 do begin
      if TBaseObject(UserEngine.QuestNPCList.Items[I]) = BaseObject then begin
        BaseObject.m_boGhost:=True;
        BaseObject.m_dwGhostTick:=GetTickCount();
        BaseObject.SendRefMsg(RM_DISAPPEAR,0,0,0,0,'');
        SysMsg(sDelOK,c_Red,t_Hint);
        exit;
      end;
    end;
  end;
  SysMsg(g_sGameCommandDelNpcMsg,c_Red,t_Hint);
end;


procedure TPlayObject.CmdDelSkill(Cmd:pTGameCmd; sHumanName, sSkillName: String);
var
  I: Integer;
  PlayObject:TPlayObject;
  boDelAll:Boolean;
  UserMagic:pTUserMagic;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or (sSkillName = '') then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <Skill>)',c_Red,t_Hint);
    exit;
  end;
  if CompareText(sSkillName,'All') = 0 then boDelAll:=True
  else boDelAll:=False;
    

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
    
  for I := PlayObject.m_MagicList.Count - 1 downto 0 do begin
    UserMagic:=PlayObject.m_MagicList.Items[I];
    if boDelAll then begin
      PlayObject.SendDelMagic(UserMagic);
      Dispose(UserMagic);
      PlayObject.m_MagicList.Delete(I);
    end else begin
      if CompareText(UserMagic.MagicInfo.sMagicName,sSkillName) = 0 then begin
        PlayObject.SendDelMagic(UserMagic);
        Dispose(UserMagic);
        PlayObject.m_MagicList.Delete(I);
        PlayObject.SysMsg(format('Removed %s''s  ',[sSkillName]),c_Green,t_Hint);
        SysMsg(format('%s has lost his %s skill',[sHumanName,sSkillName]),c_Green,t_Hint);
        break;
      end;        
    end;      
  end;
end;

procedure TPlayObject.CmdDenyAccountLogon(Cmd:pTGameCmd; sAccount, sFixDeny: String);
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sAccount = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <AccountID> <AllowLogin/DisallowLogin(0,1)>',c_Red,t_Hint);
    exit;
  end;
  g_DenyAccountList.Lock;
  try
    if (sFixDeny <> '') and (sFixDeny[1] = '1') then begin
      g_DenyAccountList.AddObject(sAccount,TObject(1));
      SaveDenyAccountList();
      SysMsg(sAccount + ' has been banned.',c_Green,t_Hint);
    end else begin
      g_DenyAccountList.AddObject(sAccount,TObject(0));
      SysMsg(sAccount + ' has been unbanned.',c_Green,t_Hint);
    end;
  finally
    g_DenyAccountList.UnLock;
  end;
end;

procedure TPlayObject.CmdDenyCharNameLogon(Cmd:pTGameCmd; sCharName, sFixDeny: String);
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sCharName = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <Username> <AllowLogin/DisallowLogin(0,1)>',c_Red,t_Hint);
    exit;
  end;
  g_DenyChrNameList.Lock;
  try
    if (sFixDeny <> '') and (sFixDeny[1] = '1') then begin
      g_DenyChrNameList.AddObject(sCharName,TObject(1));
      SaveDenyChrNameList();
      SysMsg(sCharName + ' has been banned.',c_Green,t_Hint);
    end else begin
      g_DenyChrNameList.AddObject(sCharName,TObject(0));
      SysMsg(sCharName + ' has been unbanned.',c_Green,t_Hint);
    end;
  finally
    g_DenyChrNameList.UnLock;
  end;
end;

procedure TPlayObject.CmdDenyIPaddrLogon(Cmd:pTGameCmd; sIPaddr, sFixDeny: String);
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sIPaddr = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <IP address> <AllowLogin/DisallowLogin(0,1)>',c_Red,t_Hint);
    exit;
  end;
  g_DenyIPAddrList.Lock;
  try
    if (sFixDeny <> '') and (sFixDeny[1] = '1') then begin
      g_DenyIPAddrList.AddObject(sIPaddr,TObject(1));
      SaveDenyIPAddrList();
      SysMsg(sIPaddr + ' has been banned.',c_Green,t_Hint);
    end else begin
      g_DenyIPAddrList.AddObject(sIPaddr,TObject(0));
      SysMsg(sIPaddr + ' has been unbanned.',c_Green,t_Hint);
    end;
  finally
    g_DenyIPAddrList.UnLock;
  end;
end;


procedure TPlayObject.CmdDisableFilter(sCmd,sParam1:String);
begin
  if (m_btPermission < 6) then exit;
  if (sParam1 <> '') and (sParam1[1] = '?') then begin
    SysMsg('This command enables or disables the bad word list',c_Red,t_Hint);
    exit;
  end;
  boFilterWord:= not boFilterWord;
  if boFilterWord then begin
    SysMsg('Word Filter Activated.',c_Green,t_Hint);
  end else begin
    SysMsg('Word Filter Deactivated.',c_Green,t_Hint);
  end;
end;


procedure TPlayObject.CmdDelDenyAccountLogon(Cmd:pTGameCmd; sAccount,
  sFixDeny: String);
var
  I: Integer;
  boDelete:Boolean;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sAccount = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <AccountID>',c_Red,t_Hint);
    exit;
  end;
  boDelete:=False;
  g_DenyAccountList.Lock;
  try
    for I := 0 to g_DenyAccountList.Count - 1 do begin
      if CompareText(sAccount,g_DenyAccountList.Strings[I]) = 0 then begin
        if Integer(g_DenyAccountList.Objects[I]) <> 0 then
          SaveDenyAccountList;
        g_DenyAccountList.Delete(I);
        SysMsg('Ban removed from account: ' + sAccount,c_Green,t_Hint);
        boDelete:=True;
        break;
      end;
    end;
  finally
    g_DenyAccountList.UnLock;
  end;
  if not boDelete then
    SysMsg('Account ban was not removed from: ' + sAccount,c_Green,t_Hint);
end;

procedure TPlayObject.CmdDelDenyCharNameLogon(Cmd:pTGameCmd; sCharName,
  sFixDeny: String);
var
  I: Integer;
  boDelete:Boolean;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sCharName = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <Username>',c_Red,t_Hint);
    exit;
  end;
  boDelete:=False;
  g_DenyChrNameList.Lock;
  try
    for I := 0 to g_DenyChrNameList.Count - 1 do begin
      if CompareText(sCharName,g_DenyChrNameList.Strings[I]) = 0 then begin
        if Integer(g_DenyChrNameList.Objects[I]) <> 0 then
          SaveDenyChrNameList;
        g_DenyChrNameList.Delete(I);
        SysMsg('Ban has been removed from: ' + sCharName,c_Green,t_Hint);
        boDelete:=True;
        break;
      end;
    end;
  finally
    g_DenyChrNameList.UnLock;
  end;
  if not boDelete then
    SysMsg('Ban could not be removed from ' + sCharName,c_Green,t_Hint);
end;

procedure TPlayObject.CmdDelDenyIPaddrLogon(Cmd:pTGameCmd; sIPaddr,
  sFixDeny: String);
var
  I: Integer;
  boDelete:Boolean;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sIPaddr = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <IP address>',c_Red,t_Hint);
    exit;
  end;
  boDelete:=False;
  g_DenyIPAddrList.Lock;
  try
    for I := 0 to g_DenyIPAddrList.Count - 1 do begin
      if CompareText(sIPaddr,g_DenyIPAddrList.Strings[I]) = 0 then begin
        if Integer(g_DenyIPAddrList.Objects[I]) <> 0 then
          SaveDenyIPAddrList;
        g_DenyIPAddrList.Delete(I);
        SysMsg('IP Ban removed for: ' + sIPaddr,c_Green,t_Hint);
        boDelete:=True;
        break;
      end;
    end;
  finally
    g_DenyIPAddrList.UnLock;
  end;
  if not boDelete then
    SysMsg('IP Ban could not be removed for: ' + sIPaddr,c_Green,t_Hint);
end;

procedure TPlayObject.CmdShowDenyAccountLogon(Cmd:pTGameCmd; sAccount,
  sFixDeny: String);
var
  I: Integer;
begin
  if (m_btPermission < 6) then exit;
  g_DenyAccountList.Lock;
  try
    if g_DenyAccountList.Count <= 0 then begin
      SysMsg('There are no banned accounts.',c_Green,t_Hint);
      exit;
    end;
    for I := 0 to g_DenyAccountList.Count - 1 do begin
      SysMsg(g_DenyAccountList.Strings[I],c_Green,t_Hint);
    end;
  finally
    g_DenyAccountList.UnLock;
  end;
end;

procedure TPlayObject.CmdShowDenyCharNameLogon(Cmd:pTGameCmd; sCharName,
  sFixDeny: String);
var
  I: Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  g_DenyChrNameList.Lock;
  try
    if g_DenyChrNameList.Count <= 0 then begin
      SysMsg('There are no banned players.',c_Green,t_Hint);
      exit;
    end;
    for I := 0 to g_DenyChrNameList.Count - 1 do begin
      SysMsg(g_DenyChrNameList.Strings[I],c_Green,t_Hint);
    end;
  finally
    g_DenyChrNameList.UnLock;
  end;
end;

procedure TPlayObject.CmdShowDenyIPaddrLogon(Cmd:pTGameCmd; sIPaddr,
  sFixDeny: String);
var
  I: Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  g_DenyIPAddrList.Lock;
  try
    if g_DenyIPAddrList.Count <= 0 then begin
      SysMsg('There are no banned IP''s.',c_Green,t_Hint);
      exit;
    end;
    for I := 0 to g_DenyIPAddrList.Count - 1 do begin
      SysMsg(g_DenyIPAddrList.Strings[I],c_Green,t_Hint);
    end;
  finally
    g_DenyIPAddrList.UnLock;
  end;
end;


procedure TPlayObject.CmdDisableSendMsg(Cmd:pTGameCmd; sHumanName: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sHumanName = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <Username>',c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    PlayObject.m_boFilterSendMsg:=True;
  end;
  g_DisableSendMsgList.Add(sHumanName);
  SaveDisableSendMsgList();
  SysMsg(sHumanName + ' can not chat.',c_Green,t_Hint);
end;

procedure TPlayObject.CmdDisableSendMsgList(Cmd:pTGameCmd);
var
  I: Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if g_DisableSendMsgList.Count <= 0 then begin
    SysMsg('There are no players on the chat ban list.',c_Red,t_Hint);
    exit;
  end;

  SysMsg('Chat Ban List:',c_Blue,t_Hint);
  for I := 0 to g_DisableSendMsgList.Count - 1 do begin
    SysMsg(g_DisableSendMsgList.Strings[I],c_Green,t_Hint);
  end;
end;

procedure TPlayObject.CmdEnableSendMsg(Cmd:pTGameCmd; sHumanName: String);
var
  I: Integer;
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sHumanName = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <Username>',c_Red,t_Hint);
    exit;
  end;
  for I := 0 to g_DisableSendMsgList.Count - 1 do begin
    if CompareText(sHumanName,g_DisableSendMsgList.Strings[I]) = 0 then begin
      PlayObject:=UserEngine.GeTPlayObject(sHumanName);
      if PlayObject <> nil then begin
        PlayObject.m_boFilterSendMsg:=False;
      end;
      g_DisableSendMsgList.Delete(I);
      SaveDisableSendMsgList();
      SysMsg(sHumanName + ' can now chat.',c_Green,t_Hint);
      exit;
    end;
  end;
  SysMsg(sHumanName + ' not found.',c_Red,t_Hint);
end;


procedure TPlayObject.CmdEndGuild;//4D1A44
begin
  if (m_MyGuild <> nil) then begin
    if (m_nGuildRankNo > 1) then begin
      if TGuild(m_MyGuild).IsMember(m_sCharName) and TGuild(m_MyGuild).DelMember(m_sCharName) then begin
        UserEngine.SendServerGroupMsg(SS_207,nServerIndex,TGuild(m_MyGuild).sGuildName);
        m_MyGuild:=nil;
        RefRankInfo(0,'');
        RefShowName();//10/31
        SysMsg('You have left the guild.',c_Green,t_Hint);
      end;
    end else begin
      SysMsg('You cannot leave guild when you are the leader.',c_Red,t_Hint);
    end;
  end else begin
    SysMsg('You are not in a guild, so you cannot leave.',c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdFireBurn(nInt, nTime, nN: Integer);
var
  FireBurnEvent:TFireBurnEvent;
begin
  if (m_btPermission < 6) then exit;
  if (nInt = 0) or (nTime = 0) or (nN = 0) then begin
    SysMsg('@' + g_GameCommand.FIREBURN.sCmd + ' nInt nTime nN',c_Red,t_Hint);
    exit;
  end;
  FireBurnEvent:=TFireBurnEvent.Create(Self,m_nCurrX,m_nCurrY,nInt,nTime,nN);
  g_EventManager.AddEvent(FireBurnEvent);
end;
procedure TPlayObject.CmdForcedWallconquestWar(Cmd:pTGameCmd;sCastleName:String);
var
  Castle:TUserCastle;
  s20:String;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;

  if sCastleName = '' then begin
    SysMsg('@' + Cmd.sCmd + ' <CastleName>',c_Red,t_Hint);
    exit;
  end;

  Castle:=g_CastleManager.Find(sCastleName);
  if Castle <> nil then begin
    Castle.m_boUnderWar:= not Castle.m_boUnderWar;
    if Castle.m_boUnderWar then begin
      Castle.m_dwStartCastleWarTick:=GetTickCount();
      Castle.StartWallconquestWar();

      UserEngine.SendServerGroupMsg(SS_212,nServerIndex,'');
      s20:='[' + Castle.m_sName + ' war has started.]';
      UserEngine.SendBroadCastMsg(s20,t_System);
      UserEngine.SendServerGroupMsg(SS_204,nServerIndex,s20);
      Castle.MainDoorControl(True);
    end else begin
      Castle.StopWallconquestWar();
    end;
  end else begin
    SysMsg(format(g_sGameCommandSbkGoldCastleNotFoundMsg,[sCastleName]),c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdFreePenalty(Cmd:pTGameCmd;sHumanName:String);//004CC528
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandFreePKHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  PlayObject.m_nPkPoint:=0;
  PlayObject.RefNameColor();
  PlayObject.SysMsg(g_sGameCommandFreePKHumanMsg,c_Green,t_Hint);
  SysMsg(format(g_sGameCommandFreePKMsg,[sHumanName]),c_Green,t_Hint);
end;
procedure TPlayObject.CmdGroupRecall(sCMD: String);
var
  I: Integer;
  dwValue:LongWord;
  PlayObject:TPlayObject;
begin
  if m_boRecallSuite or (m_btPermission >= 6) then begin
    if not m_PEnvir.Flag.boNORECALL then begin
      dwValue:=(GetTickCount - m_dwGroupRcallTick) div 1000;
      m_dwGroupRcallTick:=m_dwGroupRcallTick + dwValue * 1000;
      if m_btPermission >= 6 then m_wGroupRcallTime:=0;

      if m_wGroupRcallTime > dwValue then begin
        Dec(m_wGroupRcallTime,dwValue);
      end else m_wGroupRcallTime:=0;
      if m_wGroupRcallTime = 0 then begin
        if m_GroupOwner = Self then begin
          for I := 1 to m_GroupMembers.Count - 1 do begin
            PlayObject:=TPlayObject(m_GroupMembers.Objects[I]);
            if PlayObject.m_boAllowGroupReCall then begin
              if PlayObject.m_PEnvir.Flag.boNORECALL then begin
                SysMsg(format('%s map does not allow recall.',[PlayObject.m_sCharName]),c_Red,t_Hint);
              end else begin
                RecallHuman(PlayObject.m_sCharName);
              end;
            end else begin
              SysMsg(format('%s is now rejecting GroupRecall.',[PlayObject.m_sCharName]),c_Red,t_Hint);
            end;
          end;
          m_dwGroupRcallTick:=GetTickCount();
          m_wGroupRcallTime:=g_Config.nGroupRecallTime;
        end;
      end else begin
        SysMsg(format('%d seconds, You can use it again.',[m_wGroupRcallTime]),c_Red,t_Hint);
      end;
    end else begin
      SysMsg('You cannot recall here.',c_Red,t_Hint);
    end;
  end else begin
    SysMsg('You are required to wear the recall set in order to recall.',c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdGuildRecall(sCmd,sParam: String);
var
  I,II: Integer;
  dwValue:LongWord;
  PlayObject:TPlayObject;
  GuildRank:pTGuildRank;
  nRecallCount,nNoRecallCount:Integer;
  Castle:TUserCastle;
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('This command recalls your entire guild to you',c_Red,t_Hint);
    exit;
  end;

  if not m_boGuildMove and (m_btPermission < 6) then begin
    SysMsg('You do not have enough permition to recall a guild',c_Red,t_Hint);
    exit;
  end;
  if not IsGuildMaster then begin
    SysMsg('Only the guild leader can recall.',c_Red,t_Hint);
    exit;
  end;
  if m_PEnvir.Flag.boNOGUILDRECALL then begin
    SysMsg('You cannot recall on this map.',c_Red,t_Hint);
    exit;
  end;
  Castle:=g_CastleManager.InCastleWarArea(Self);

  //if UserCastle.m_boUnderWar and UserCastle.InCastleWarArea(m_PEnvir,m_nCurrX,m_nCurrY) then begin
  if (Castle <> nil) and Castle.m_boUnderWar then begin
    SysMsg('You cannot recall during a ' + Castle.m_sName + ' war.',c_Red,t_Hint);
    exit;
  end;
  nRecallCount:=0;
  nNoRecallCount:=0;
  dwValue:=(GetTickCount - m_dwGroupRcallTick) div 1000;
  m_dwGroupRcallTick:=m_dwGroupRcallTick + dwValue * 1000;
  if m_btPermission >= 6 then m_wGroupRcallTime:=0;  
  if m_wGroupRcallTime > dwValue then begin
    Dec(m_wGroupRcallTime,dwValue);
  end else m_wGroupRcallTime:=0;

  if m_wGroupRcallTime > 0 then begin
    SysMsg(format('%d seconds until you can recall again.',[m_wGroupRcallTime]),c_Red,t_Hint);
    exit;
  end;

  for I := 0 to TGuild(m_MyGuild).m_RankList.Count - 1 do begin
    GuildRank:=TGuild(m_MyGuild).m_RankList.Items[I];
    for II:=0 to GuildRank.MemberList.Count -1 do begin
      PlayObject:=TPlayObject(GuildRank.MemberList.Objects[II]);
      if PlayObject <> nil then begin
        if PlayObject = Self then begin
//          Inc(nNoRecallCount);
          Continue;
        end;
        if PlayObject.m_boAllowGuildReCall then begin
          if PlayObject.m_PEnvir.Flag.boNORECALL then begin
            SysMsg(format('%s Cannot be recalled from that map',[PlayObject.m_sCharName]),c_Red,t_Hint);
          end else begin
            RecallHuman(PlayObject.m_sCharName);
            Inc(nRecallCount);
          end;
        end else begin
          Inc(nNoRecallCount);
          SysMsg(format('%s Has Disabled Guild Recall',[PlayObject.m_sCharName]),c_Red,t_Hint);
        end;
      end;
    end;
  end;
  SysMsg(format('People Recalled:%d,People Blocked:%d',[nRecallCount,nNoRecallCount]),c_Green,t_Hint);
  m_dwGroupRcallTick:=GetTickCount();
  m_wGroupRcallTime:=g_Config.nGuildRecallTime;
end;

procedure TPlayObject.CmdGuildWar(sCmd, sGuildName: String);//004CE9F0
begin
  if (m_btPermission < 6) then exit;
end;
procedure TPlayObject.CmdHair(Cmd:pTGameCmd;sHumanName: String;nHair: Integer);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or (nHair < 0) then begin
    SysMsg('Use this: @' + Cmd.sCmd + ' <Username> <Hairstyle(0,1)>',c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    PlayObject.m_btHair:=nHair;
    PlayObject.FeatureChanged();
    SysMsg(sHumanName + ' has had a hairchange',c_Green,t_Hint);
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdHumanInfo(Cmd:pTGameCmd;sHumanName: String);//004CFC98
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandInfoHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  SysMsg(PlayObject.GeTBaseObjectInfo(),c_Green,t_Hint);
end;

procedure TPlayObject.CmdHumanLocal(Cmd:pTGameCmd;sHumanName: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandHumanLocalHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  SysMsg(format(g_sGameCommandHumanLocalMsg,[sHumanName,m_sIPLocal{GetIPLocal(PlayObject.m_sIPaddr)}]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdHunger(sCmd, sHumanName: String;nHungerPoint:Integer);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < 6) then exit;
  if (sHumanName = '') or (nHungerPoint < 0) then begin
    SysMsg('Use this: @' + sCMD + ' <Username> <hunger points>',c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    PlayObject.m_nHungerStatus:=nHungerPoint;
    PlayObject.SendMsg(PlayObject,RM_MYSTATUS,0,0,0,0,'');
    PlayObject.RefMyStatus();
    SysMsg(sHumanName + ' has a different hunger status now',c_Green,t_Hint);
  end else begin
    SysMsg(sHumanName + ' not found',c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdIncPkPoint(Cmd:pTGameCmd;sHumanName:String;nPoint:Integer);//004BF4D4
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandIncPkPointHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  Inc(PlayObject.m_nPkPoint,nPoint);
  PlayObject.RefNameColor();
  if nPoint > 0 then
    SysMsg(format(g_sGameCommandIncPkPointAddPointMsg,[sHumanName,nPoint]),c_Green,t_Hint)
  else
    SysMsg(format(g_sGameCommandIncPkPointDecPointMsg,[sHumanName,-nPoint]),c_Green,t_Hint);
end;
procedure TPlayObject.CmdKickHuman(Cmd:pTGameCmd;sHumName:String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumName = '') or ((sHumName <> '') and (sHumName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandKickHumanHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if PlayObject <> nil then begin
    PlayObject.m_boKickFlag:=True;
    PlayObject.m_boEmergencyClose:=True;
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumName]),c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdKill(Cmd:pTGameCmd;sHumanName: String);
var
  BaseObject:TBaseObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if sHumanName <> '' then begin
    BaseObject:=UserEngine.GeTPlayObject(sHumanName);
    if BaseObject = nil then begin
      SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
      exit;
    end;
  end else begin
    BaseObject:=GetPoseCreate();
    if BaseObject = nil then begin
      SysMsg('No target found to kill',c_Red,t_Hint);
      exit;
    end;
  end;
  BaseObject.Die;
end;

procedure TPlayObject.CmdLockLogin(Cmd: pTGameCmd);
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if not g_Config.boLockHumanLogin then begin
    SysMsg('Configuration does not allow a lock',c_Red,t_Hint);
    exit;
  end;
    
  if m_boLockLogon and not m_boLockLogoned then begin
    SysMsg('Login lock failed due to unknown reason',c_Red,t_Hint);
    exit;
  end;
    
  m_boLockLogon:= not m_boLockLogon;
  if m_boLockLogon then begin
    SysMsg('Logins locked',c_Green,t_Hint);
  end else begin
    SysMsg('Logins Unlocked',c_Green,t_Hint);
  end;
    
end;

procedure TPlayObject.CmdLotteryTicket(sCmd: String; nPerMission: Integer;
  sParam1: String);
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sParam1 = '') or ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,'']),c_Red,t_Hint);
    exit;
  end;
  SysMsg(format(g_sGameCommandLotteryTicketMsg,[g_Config.nWinLotteryCount,
                                                g_Config.nNoWinLotteryCount,
                                                g_Config.nWinLotteryLevel1,
                                                g_Config.nWinLotteryLevel2,
                                                g_Config.nWinLotteryLevel3,
                                                g_Config.nWinLotteryLevel4,
                                                g_Config.nWinLotteryLevel5,
                                                g_Config.nWinLotteryLevel6]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdLuckPoint(sCmd: String; nPerMission: Integer;
  sHumanName, sCtr, sPoint: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,g_sGameCommandLuckPointHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;

  if sCtr = '' then begin
    SysMsg(format(g_sGameCommandLuckPointMsg,[sHumanName,PlayObject.m_nBodyLuckLevel,PlayObject.m_dBodyLuck,PlayObject.m_nLuck]),c_Green,t_Hint);
    exit;
  end;
  
end;

procedure TPlayObject.CmdMakeItem(Cmd:pTGameCmd;sItemName: String; nCount: Integer);//004CCE34
var
  I: Integer;
  UserItem:pTUserItem;
  StdItem:TItem;
  boSucces:Boolean;
  temp:TItem;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sItemName = '') then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGamecommandMakeHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  if (nCount <= 0) then nCount:=1;
  if (nCount > 10) then nCount:=10;
  if (m_btPermission < Cmd.nPermissionMax) then begin
    if not CanMakeItem(sItemName) then begin
      SysMsg(g_sGamecommandMakeItemNameOrPerMissionNot,c_Red,t_Hint);
      exit;
    end;
    //if UserCastle.InCastleWarArea(m_PEnvir,m_nCurrX,m_nCurry) then begin
    if g_CastleManager.InCastleWarArea(Self) <> nil then begin
      SysMsg(g_sGamecommandMakeInCastleWarRange,c_Red,t_Hint);
      exit;
    end;
    if not InSafeZone then begin
      SysMsg(g_sGamecommandMakeInSafeZoneRange,c_Red,t_Hint);
      exit;
    end;
    nCount:=1;      
  end;

  for I := 0 to nCount - 1 do begin
    boSucces := False;
    UserItem := nil;

    temp:= UserEngine.GetStdItem(sItemName);
    if (temp <> nil) then begin
      if temp.StdMode = 45 then
        UserItem:=CheckItems(sItemName);
    end;
    if UserItem = nil then begin
      if m_ItemList.Count >= MAXBAGITEM then exit;
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName,UserItem) then
        boSucces:=TRUE;
    end else
      boSucces:=TRUE;

    if boSucces then begin
      StdItem:=UserEngine.GetStdItem(UserItem.wIndex);

      if (StdItem.Price >= 15000) and not g_Config.boTestServer and (m_btPermission < 5)then begin
        Dispose(UserItem);
      end else begin
        //if Random(g_Config.nMakeRandomAddValue{10}) = 0 then
          StdItem.RandomUpgradeItem(UserItem);
      end;
      if StdItem.StdMode in [15,19,20,21,22,23,24,26] then begin
        if StdItem.Shape in [130,131,132] then begin
          StdItem.RandomUpgradeUnknownItem(UserItem);
        end;
      end;
      if m_btPermission >= Cmd.nPermissionMax then begin
        if IncreaseItem(sItemName) = false then begin
          UserItem.MakeIndex:=GetItemNumberEx(); //制造的物品另行取得物品ID
          m_ItemList.Add(UserItem);
        end;
        //UserItem.Amount:=1;
        SendAddItem(UserItem);
      end;
      if g_Config.boShowMakeItemMsg and (m_btPermission >= 6) then
        MainOutMessage('[Make] ' + m_sCharName + ' ' + sItemName + '(' + IntToStr(UserItem.MakeIndex) + ')');
            //004CD10D
      if StdItem.NeedIdentify = 1 then
            AddGameDataLog ('5' + #9 +
                        m_sMapName + #9 +
                        IntToStr(m_nCurrX) + #9 +
                        IntToStr(m_nCurrY) + #9 +
                        m_sCharName + #9 +
                        //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                        StdItem.Name + #9 +
                        IntToStr(UserItem.MakeIndex) + #9 +
                        '1' + #9 +
                        '0');
    end else begin //004CD114
      Dispose(UserItem);
      SysMsg(format(g_sGamecommandMakeItemNameNotFound,[sItemName]),c_Red,t_Hint);
      break;
    end;
  end;
end;


procedure TPlayObject.CmdMapMove(Cmd:pTGameCmd;sMapName: String);
var
  Envir:TEnvirnoment;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sMapName = '') or ((sMapName <> '') and (sMapName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandMoveHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  Envir:=g_MapManager.FindMap(sMapName);
  if (Envir = nil) then begin
    SysMsg(format(g_sTheMapNotFound,[sMapName]),c_Red,t_Hint);
    exit;
  end;
  if (m_btPermission >= Cmd.nPermissionMax) or CanMoveMap(sMapName) then begin
    SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
    MapRandomMove(sMapName,0);
  end else begin
    SysMsg(format(g_sTheMapDisableMove,[sMapName,Envir.sMapDesc]),c_Red,t_Hint);
  end;
end;
//004CDA38
procedure TPlayObject.CmdPositionMove(Cmd:pTGameCmd;sMapName, sX, sY: String);
var
  Envir:TEnvirnoment;
  nX,nY:Integer;
begin
try
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sMapName = '') or (sX = '') or (sY = '') or ((sMapName <> '') and (sMapName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandPositionMoveHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  if (m_btPermission >= Cmd.nPermissionMax) or CanMoveMap(sMapName) then begin
    Envir:=g_MapManager.FindMap(sMapName);
    if Envir <> nil then begin
      nX:=Str_ToInt(sX,0);
      nY:=Str_ToInt(sY,0);
      if Envir.CanWalk(nX,nY,True) then begin
        SpaceMove(sMapName,nX,nY,0);
      end else begin
        SysMsg(format(g_sGameCommandPositionMoveCanotMoveToMap,[sMapName,sX,sY]),c_Green,t_Hint);
      end;
    end;
  end else begin
    SysMsg(format(g_sTheMapDisableMove,[sMapName,Envir.sMapDesc]),c_Red,t_Hint);
  end;
except
  on e: Exception do begin
    MainOutMessage('[Exceptioin] TPlayObject.CmdPositionMove');
    MainOutMessage(E.Message);
  end;

end;
end;
procedure TPlayObject.CmdMapMoveHuman(Cmd:pTGameCmd;sSrcMap,sDenMap:String);
var
  SrcEnvir,DenEnvir:TEnvirnoment;
  HumanList:TList;
  I:Integer;
  MoveHuman:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sDenMap = '') or (sSrcMap = '') or ((sSrcMap <> '') and (sSrcMap[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandMapMoveHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  SrcEnvir:=g_MapManager.FindMap(sSrcMap);
  DenEnvir:=g_MapManager.FindMap(sDenMap);
  if (SrcEnvir = nil) then begin
    SysMsg(format(g_sGameCommandMapMoveMapNotFound,[sSrcMap]),c_Red,t_Hint);
    exit;
  end;
  if (DenEnvir = nil) then begin
    SysMsg(format(g_sGameCommandMapMoveMapNotFound,[sDenMap]),c_Red,t_Hint);
    exit;
  end;

  HumanList:=TList.Create;
  UserEngine.GetMapRageHuman(SrcEnvir,SrcEnvir.Header.wWidth div 2,SrcEnvir.Header.wHeight div 2,1000,HumanList);
  for I := 0 to HumanList.Count - 1 do begin
    MoveHuman:=TPlayObject(HumanList.Items[I]);
    if MoveHuman <> Self then
      MoveHuman.MapRandomMove(sDenMap,0);
  end;
  HumanList.Free;
end;

procedure TPlayObject.CmdMemberFunction(sCmd, sParam: String);
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('This command triggers the @Member label from manage npc',c_Red,t_Hint);
    exit;
  end;
  if g_ManageNPC <> nil then begin
    g_ManageNPC.GotoLable(Self,'@Member',False);
  end;
end;


procedure TPlayObject.CmdMemberFunctionEx(sCmd, sParam: String);
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('This command triggers the @member label from function npc',c_Red,t_Hint);
    exit;
  end;
  if g_FunctionNPC <> nil then begin
    g_FunctionNPC.GotoLable(Self,'@Member',False);
  end;
end;

procedure TPlayObject.CmdMission(Cmd:pTGameCmd;sX, sY: String);//004CCA08
var
  nX,nY:Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sX = '') or (sY = '') then begin
    SysMsg('Use this: @' + Cmd.sCmd + ' <X> <Y>',c_Red,t_Hint);
    exit;
  end;
  nX:=Str_ToInt(sX,0);
  nY:=Str_ToInt(sY,0);
  g_boMission:=True;
  g_sMissionMap:=m_sMapName;
  g_nMissionX:=nX;
  g_nMissionY:=nY;
  SysMsg('Misson target set: ' + m_sMapName + '(' + IntToStr(g_nMissionX) + ':' + IntToStr(g_nMissionY) + ')',c_Green,t_Hint);
end;
procedure TPlayObject.CmdMob(Cmd:pTGameCmd;sMonName:String;nCount,nLevel:Integer; nExpRatio:Integer = -1); //004CC7F4
var
  I: Integer;
  nX,nY:Integer;
  Monster:TBaseObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sMonName = '') or ((sMonName <> '') and (sMonName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandMobHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  
  if nCount <= 0 then nCount:=1;
  if not (nLevel in [0..10]) then nLevel:=0;
    
  nCount:=_MIN(64,nCount);
  GetFrontPosition(nX,nY);
  for I := 0 to nCount - 1 do begin
    Monster:=UserEngine.RegenMonsterByName(m_PEnvir,nX,nY,sMonName);
    if Monster <> nil then begin
      Monster.m_btSlaveMakeLevel:=nLevel;
      Monster.m_btSlaveExpLevel:=nLevel;
      Monster.RecalcAbilitys;
      Monster.RefNameColor;
      if nExpRatio <> -1 then begin
        nExpRatio := _MIN(100,nExpRatio);
        Monster.m_dwFightExp := Monster.m_dwFightExp * nExpRatio;
      end;
    end else begin
      SysMsg(g_sGameCommandMobMsg,c_Red,t_Hint);
      break;
    end;      
  end;
end;

procedure TPlayObject.CmdMobCount(Cmd:pTGameCmd;sMapName: String);
var
  Envir: TEnvirnoment;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sMapName = '') or ((sMapName <> '') and (sMapName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandMobCountHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  Envir:=g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    SysMsg(g_sGameCommandMobCountMapNotFound,c_Red,t_Hint);
    exit;
  end;
  SysMsg(format(g_sGameCommandMobCountMonsterCount,[UserEngine.GetMapMonster(Envir,nil)]),c_Green,t_Hint);
end;


procedure TPlayObject.CmdHumanCount(Cmd:pTGameCmd;sMapName: String);
var
  Envir: TEnvirnoment;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sMapName = '') or ((sMapName <> '') and (sMapName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandHumanCountHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  Envir:=g_MapManager.FindMap(sMapName);
  if Envir = nil then begin
    SysMsg(g_sGameCommandMobCountMapNotFound,c_Red,t_Hint);
    exit;
  end;
  SysMsg(format(g_sGameCommandMobCountMonsterCount,[UserEngine.GetMapHuman(sMapName)]),c_Green,t_Hint);
  SysMsg(IntToStr(Envir.HumCount),c_Green,t_Hint);
end;

procedure TPlayObject.CmdMobFireBurn(Cmd: pTGameCmd; sMap, sX, sY, sType,
  sTime, sPoint: String);
var
  nX,nY,nType,nTime,nPoint:Integer;
  FireBurnEvent:TFireBurnEvent;
  Envir:TEnvirnoment;
  OldEnvir:TEnvirnoment;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sMap = '') or ((sMap <> '') and (sMap[1] = '?')) then begin
    SysMsg(format(g_sGameCommandMobFireBurnHelpMsg,[Cmd.sCmd,sMap, sX, sY, sType,sTime, sPoint]),c_Red,t_Hint);
    exit;
  end;

  nX:=Str_ToInt(sX,-1);
  nY:=Str_ToInt(sY,-1);
  nType:=Str_ToInt(sType,-1);
  nTime:=Str_ToInt(sTime,-1);
  nPoint:=Str_ToInt(sPoint,-1);
  if nPoint < 0 then nPoint:=1;
    
  if (sMap = '') or (nX < 0) or (nY < 0) or (nType < 0) or (nTime < 0) or (nPoint < 0) then begin
    SysMsg(format(g_sGameCommandMobFireBurnHelpMsg,[Cmd.sCmd,sMap, sX, sY, sType,sTime, sPoint]),c_Red,t_Hint);
    exit;
  end;
  Envir:=g_MapManager.FindMap(sMap);
  if Envir <> nil then begin
    OldEnvir:=m_PEnvir;
    m_PEnvir:=Envir;
    FireBurnEvent:=TFireBurnEvent.Create(Self,nX,nY,nType,nTime * 1000,nPoint);
    g_EventManager.AddEvent(FireBurnEvent);
    m_PEnvir:=OldEnvir;
    exit;
  end;
  SysMsg(format(g_sGameCommandMobFireBurnMapNotFountMsg,[Cmd.sCmd,sMap]),c_Red,t_Hint);
end;

procedure TPlayObject.CmdMobLevel(Cmd:pTGameCmd;Param:String); //004CFD5C
var
  I: Integer;
  BaseObjectList:TList;
  BaseObject:TBaseObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((Param <> '') and (Param[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,'']),c_Red,t_Hint);
    exit;
  end;

  BaseObjectList:=TList.Create;
  m_PEnvir.GetRangeBaseObject(m_nCurrX,m_nCurrY,2,True,BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject:=TBaseObject(BaseObjectList.Items[i]);
    SysMsg(BaseObject.GeTBaseObjectInfo(),c_Green,t_Hint);
  end;
  BaseObjectList.Free;
end;
procedure TPlayObject.CmdMobNpc(sCmd:String;nPermission:Integer;sParam1,sParam2,sParam3,sParam4:String);
var
  nAppr:Integer;
  boIsCastle:Boolean;
  Merchant:TMerchant;
  nX,nY:Integer;
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sParam1 = '') or (sParam2 = '') or ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,g_sGameCommandMobNpcHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  nAppr:=Str_ToInt(sParam3,0);
  boIsCastle:=(Str_ToInt(sParam4,0) = 1);
  if sParam1 = '' then begin
    SysMsg('Use this: @' + sCmd + ' <Npc name> <File name> <Appr> <Castle Npc>(0,1)',c_Red,t_Hint);
    exit;
  end;
  Merchant:=TMerchant.Create;
  Merchant.m_sCharName:=sParam1;
  Merchant.m_sMapName:=m_sMapName;
  Merchant.m_PEnvir:=m_PEnvir;
  Merchant.m_wAppr:=nAppr;
  Merchant.m_nFlag:=0;
  Merchant.m_boCastle:=boIsCastle;
  Merchant.m_sScript:=sParam2;
  GetFrontPosition(nX,nY);
  Merchant.m_nCurrX:=nX;
  Merchant.m_nCurrY:=nY;
  Merchant.Initialize();
  UserEngine.AddMerchant(Merchant);
end;
procedure TPlayObject.CmdMobPlace(Cmd:pTGameCmd;sX, sY, sMonName, sCount: String); //004CCBB4
var
  I: Integer;
  nCount,nX,nY:Integer;
  MEnvir:TEnvirnoment;
  Mon:TBaseObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  nCount:=_MIN(500,Str_ToInt(sCount,0));
  nX:=Str_ToInt(sX,0);
  nY:=Str_ToInt(sY,0);
  MEnvir:=g_MapManager.FindMap(g_sMissionMap);
  if (nX <= 0) or (nY <= 0) or (sMonName = '') or (nCount <= 0) then begin
    SysMsg('Use this: @' + Cmd.sCmd + ' <X> <Y> <MobName> <Count>',c_Red,t_Hint);
    exit;
  end;
  if not g_boMission or (MEnvir = nil) then begin
    SysMsg('You need to set a mission objective first',c_Red,t_Hint);
    SysMsg('Use this: @' + g_GameCommand.MISSION.sCmd + ' command first',c_Red,t_Hint);
    exit;
  end;

  for I := 0 to nCount - 1 do begin
    Mon:=UserEngine.RegenMonsterByName(g_sMissionMap,nX,nY,sMonName);
    if Mon <> nil then begin
      Mon.m_boMission:=True;
      Mon.m_nMissionX:=g_nMissionX;
      Mon.m_nMissionY:=g_nMissionY;
    end else break;
  end;
  SysMsg(IntToStr(nCount) + ' times ' + sMonName + ' have spawned at: ' + g_sMissionMap + ' ' + IntToStr(g_nMissionX) + ':' + IntToStr(g_nMissionY) + '',c_Green,t_Hint);
end;

procedure TPlayObject.CmdNpcScript(sCmd:String;nPermission:Integer;sParam1,sParam2,sParam3:String);
var
  BaseObject:TBaseObject;
  nNPCType:Integer;
  I:Integer;
  sScriptFileName:String;
  Merchant:TMerchant;
  NormNpc:TNormNpc;
  LoadList:TStringList;
  sScriptLine:String;
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sParam1 = '') or ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,g_sGameCommandNpcScriptHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  
  nNPCType:= -1;
  BaseObject:=GetPoseCreate();
  if BaseObject <> nil then begin
    for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
      if TBaseObject(UserEngine.m_MerchantList.Items[I]) = BaseObject then begin
        nNPCType:=0;
        break;
      end;
    end;
    for I := 0 to UserEngine.QuestNPCList.Count - 1 do begin
      if TBaseObject(UserEngine.QuestNPCList.Items[I]) = BaseObject then begin
        nNPCType:=1;
        break;
      end;
    end;
  end;
  if nNPCType < 0 then begin
    SysMsg('Npc not found',c_Red,t_Hint);
    exit;
  end;

  if sParam1 = '' then begin
    if nNPCType = 0 then begin
      Merchant:=TMerchant(BaseObject);
      sScriptFileName:=g_Config.sEnvirDir + sMarket_Def + Merchant.m_sScript + '-' + Merchant.m_sMapName  + '.txt';
    end;
    if nNPCType = 1 then begin
      NormNpc:=TNormNpc(BaseObject);
      sScriptFileName:=g_Config.sEnvirDir + sNpc_def + NormNpc.m_sCharName + '-' + NormNpc.m_sMapName  + '.txt';
    end;
    if FileExists(sScriptFileName) then begin
      LoadList:=TStringList.Create;
      try
      LoadList.LoadFromFile(sScriptFileName);
      except
        SysMsg('File Read error: ' + sScriptFileName,c_Red,t_Hint);
      end;
      for I := 0 to LoadList.Count - 1 do begin
        sScriptLine:=Trim(LoadList.Strings[I]);
        sScriptLine:=ReplaceChar(sScriptLine,' ',',');
        SysMsg(IntToStr(I) + ',' + sScriptLine,c_Blue,t_Hint);
      end;
      LoadList.Free;
    end;
  end;
end;
procedure TPlayObject.CmdOPDeleteSkill(sHumanName, sSkillName: String);//004CE938
begin
  if (m_btPermission < 6) then exit;
end;
procedure TPlayObject.CmdOPTraining(sHumanName, sSkillName: String;
  nLevel: Integer);//004CC468
begin
  if (m_btPermission < 6) then exit;
end;
procedure TPlayObject.CmdPKpoint(Cmd:pTGameCmd;sHumanName:String);//004CC61C
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandPKPointHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  SysMsg(format(g_sGameCommandPKPointMsg,[sHumanName,PlayObject.m_nPkPoint]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdPrvMsg(sCmd: String; nPermission: Integer;
  sHumanName: String);
var
  I: Integer;
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,g_sGameCommandPrvMsgHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  for I := 0 to m_BlockWhisperList.Count - 1 do begin
    if CompareText(m_BlockWhisperList.Strings[I],sHumanName) = 0 then begin
      m_BlockWhisperList.Delete(I);
      SysMsg(format(g_sGameCommandPrvMsgUnLimitMsg,[sHumanName]),c_Green,t_Hint);
      exit;
    end;
  end;
  m_BlockWhisperList.Add(sHumanName);
  SysMsg(format(g_sGameCommandPrvMsgLimitMsg,[sHumanName]),c_Green,t_Hint);

end;

procedure TPlayObject.CmdReAlive(Cmd:pTGameCmd;sHumanName: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandReAliveHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  PlayObject.ReAlive;
  PlayObject.m_WAbil.HP:=PlayObject.m_WAbil.MaxHP;
  PlayObject.SendMsg(PlayObject,RM_ABILITY,0,0,0,0,'');

  SysMsg(format(g_sGameCommandReAliveMsg,[sHumanName]),c_Green,t_Hint);
  SysMsg(sHumanName + ' has been revived from the dead.',c_Green,t_Hint);
end;
procedure TPlayObject.CmdRecallHuman(Cmd:pTGameCmd;sHumanName:String); //004CE250
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandRecallHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  RecallHuman(sHumanName);
end;
procedure TPlayObject.CmdRecallMob(Cmd:pTGameCmd;sMonName:String;nCount,nLevel,nAutoChangeColor,nFixColor:Integer);//004CC8C4
var
  I: Integer;
  nX,nY:Integer;
  Mon:TBaseObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sMonName = '') or ((sMonName <> '') and (sMonName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandRecallMobHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  
  if nLevel >=10 then nLevel:=0;
  if nCount <= 0 then nCount:=1;    
  for I := 0 to nCount - 1 do begin
    if m_SlaveList.Count >= 20 then break;
    GetFrontPosition(nX,nY);
    Mon:=UserEngine.RegenMonsterByName(m_PEnvir,nX,nY,sMonName);
    if Mon <> nil then begin
      Mon.m_Master:=Self;
      Mon.m_dwMasterRoyaltyTick:=GetTickCount + 24 * 60 * 60 * 1000;
      Mon.m_btSlaveMakeLevel:=3;
      Mon.m_btSlaveExpLevel:=nLevel;
      if nAutoChangeColor = 1 then begin
        Mon.m_boAutoChangeColor:=True;
      end else
      if nFixColor > 0 then begin
        Mon.m_boFixColor:=True;
        Mon.m_nFixColorIdx:=nFixColor - 1;
      end;
        
      Mon.RecalcAbilitys();
      Mon.RefNameColor();
      m_SlaveList.Add(Mon);
    end;
  end;
end;
procedure TPlayObject.CmdReconnection(sCmd,sIPaddr, sPort: String);
//004CE380
begin
  if (m_btPermission < 6) then exit;
  if (sIPaddr <> '') and (sIPaddr[1] = '?') then begin
    SysMsg('this command allows you to reconnect to a different ip/port',c_Blue,t_Hint);
    exit;
  end;
    
  if (sIPaddr = '') or (sPort = '') then begin
    SysMsg('Usage: @' + sCmd + ' IP port',c_Red,t_Hint);
    exit;
  end;
  if (sIPaddr <> '') and (sPort <> '') then begin
    SendMsg(Self,RM_RECONNECTION,0,0,0,0,sIPaddr + '/' + sPort);
  end;
end;
procedure TPlayObject.CmdRefineWeapon(Cmd:pTGameCmd;nDC, nMC, nSC, nHit: Integer);//004CD1C4
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (nDC + nMC + nSC) > 10 then exit;
  if m_UseItems[U_WEAPON].wIndex <= 0 then exit;
  m_UseItems[U_WEAPON].btValue[0]:=nDC;
  m_UseItems[U_WEAPON].btValue[1]:=nMC;
  m_UseItems[U_WEAPON].btValue[2]:=nSC;
  m_UseItems[U_WEAPON].btValue[5]:=nHit;
  SendUpdateItem(@m_UseItems[U_WEAPON]);
  RecalcAbilitys();
  SendMsg(Self,RM_ABILITY,0,0,0,0,'');
  SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
  MainOutMessage('[GM Refine]' +  m_sCharName + ' DC:' + IntToStr(nDC) + ' MC' + IntToStr(nMC) + ' SC' + IntToStr(nSC) + ' HIT:' + IntToStr(nHit));
end;
procedure TPlayObject.CmdReGotoHuman(Cmd:pTGameCmd;sHumanName:String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandReGotoHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  SpaceMove(PlayObject.m_PEnvir.sMapName,PlayObject.m_nCurrX,PlayObject.m_nCurrY,0);

end;


procedure TPlayObject.CmdReloadAbuse(sCmd: String; nPerMission: Integer;
  sParam1: String);
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,'']),c_Red,t_Hint);
    exit;
  end;
end;

procedure TPlayObject.CmdReLoadAdmin(sCmd: String);
begin
  if (m_btPermission < 6) then exit;
  FrmDB.LoadAdminList();
  UserEngine.SendServerGroupMsg(213,nServerIndex,'');
  SysMsg('Admin List reloaded...',c_Green,t_Hint);
end;

procedure TPlayObject.CmdReloadGuild(sCmd: String; nPerMission: Integer;
  sParam1: String);
var
  Guild:TGuild;
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sParam1 = '') or ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,g_sGameCommandReloadGuildHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  if nServerIndex <> 0 then begin
    SysMsg(g_sGameCommandReloadGuildOnMasterserver,c_Red,t_Hint);
    exit;
  end;

  Guild:=g_GuildManager.FindGuild(sParam1);
  if Guild = nil then begin
    SysMsg(format(g_sGameCommandReloadGuildNotFoundGuildMsg,[sParam1]),c_Red,t_Hint);
    exit;
  end;
  Guild.LoadGuild();
  SysMsg(format(g_sGameCommandReloadGuildSuccessMsg,[sParam1]),c_Red,t_Hint);
  UserEngine.SendServerGroupMsg(SS_207,nServerIndex,sParam1);
end;

procedure TPlayObject.CmdReloadGuildAll;//004CE530
begin
  if (m_btPermission < 6) then exit;
end;


procedure TPlayObject.CmdReloadLineNotice(sCmd: String;
  nPerMission: Integer; sParam1: String);
begin
  if (m_btPermission < nPermission) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[sCmd,'']),c_Red,t_Hint);
    exit;
  end;
  if LoadLineNotice(g_Config.sNoticeDir + 'LineNotice.txt') then begin
    SysMsg(g_sGameCommandReloadLineNoticeSuccessMsg,c_Green,t_Hint);
  end else begin
    SysMsg(g_sGameCommandReloadLineNoticeFailMsg,c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdReloadManage(Cmd:pTGameCmd;sParam:String);
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam <> '') and (sParam[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,'']),c_Red,t_Hint);
    exit;
  end;
  if sParam = '' then begin
    if g_ManageNPC <> nil then begin
      g_ManageNPC.ClearScript();
      g_ManageNPC.LoadNPCScript();
      SysMsg('Manage Script reloaded..',c_Green,t_Hint);
    end else begin
      SysMsg('Manage Script not found...',c_Green,t_Hint);
    end;
  end else begin
    if g_FunctionNPC <> nil then begin
      g_FunctionNPC.ClearScript();
      g_FunctionNPC.LoadNPCScript();
      SysMsg('Function Script reloaded...',c_Green,t_Hint);
    end else begin
      SysMsg('Function Script not found...',c_Green,t_Hint);
    end;
  end;
end;
procedure TPlayObject.CmdReloadRobot;
begin
  RobotManage.ReLoadRobot();
  SysMsg('Robot Reloaded...',c_Green,t_Hint);
end;
procedure TPlayObject.CmdReloadRobotManage;
begin
  if (m_btPermission < 6) then exit;
  if g_RobotNPC <> nil then begin
    g_RobotNPC.ClearScript();
    g_RobotNPC.LoadNPCScript();
    SysMsg('Robot Script Reloaded...',c_Green,t_Hint);
  end else begin
    SysMsg('Robot Script not found...',c_Green,t_Hint);
  end;
end;
procedure TPlayObject.CmdReloadMonItems;//
var
  I: Integer;
  Monster:pTMonInfo;
begin
  if (m_btPermission < 6) then exit;
try
    for I := 0 to UserEngine.MonsterList.Count - 1 do begin
      Monster:=UserEngine.MonsterList.Items[I];
      FrmDB.LoadMonitems(Monster.sName,Monster.ItemList);
    end;
  SysMsg('Mon items reloaded...',c_Green,t_Hint);
except
  SysMsg('Error reloading mon items',c_Green,t_Hint);
end;
end;
procedure TPlayObject.CmdReloadNpc(sParam: String); //004CFFF8
var
  I: Integer;
  TmpList:TList;
  Merchant:TMerchant;
  Npc:TNormNpc;
begin
  if (m_btPermission < 6) then exit;
  if CompareText('all',sParam) = 0 then begin
    FrmDB.ReLoadMerchants();
    UserEngine.ReloadMerchantList();
    SysMsg('Merchantlist Reloaded',c_Red,t_Hint);
    UserEngine.ReloadNpcList();
    SysMsg('Npc list reloaded',c_Red,t_Hint);
    exit;
  end; //004D0136
  TmpList:=TList.Create;
  if UserEngine.GetMerchantList(m_PEnvir,m_nCurrX,m_nCurrY,9,TmpList) > 0 then begin
    for I := 0 to TmpList.Count - 1 do begin
      Merchant:=TMerchant(TmpList.Items[i]);
      Merchant.ClearScript;
      Merchant.LoadNPCScript;
      SysMsg(Merchant.m_sCharName + ' reloaded...',c_Green,t_Hint);
    end;    // for
  end else begin
    SysMsg('No Merchant''s in area to reload...',c_Red,t_Hint);
  end;
  TmpList.Clear;
  if UserEngine.GetNpcList(m_PEnvir,m_nCurrX,m_nCurrY,9,TmpList) > 0 then begin
    for I := 0 to TmpList.Count - 1 do begin
      Npc:=TNormNpc(TmpList.Items[i]);
      Npc.ClearScript;
      Npc.LoadNPCScript;
      SysMsg(Npc.m_sCharName + 'reloaded...',c_Green,t_Hint);
    end;    // for
  end else begin
    SysMsg('No Npc''s in area to reload...',c_Red,t_Hint);
  end;
  TmpList.Free;
end;
procedure TPlayObject.CmdSearchHuman(sCmd, sHumanName: String);
var
  PlayObject:TPlayObject;
begin
  if m_boProbeNecklace or (m_btPermission >= 6) then begin
    if (sHumanName = '') then begin
      SysMsg('Use This: @' + sCmd + ' <Username>',c_Red,t_Hint);
      exit;
    end;
    if ((GetTickCount - m_dwProbeTick) > 10000) or (m_btPermission >= 3) then begin
      m_dwProbeTick:=GetTickCount();
      PlayObject:=UserEngine.GeTPlayObject(sHumanName);
      if PlayObject <> nil then begin
        SysMsg(sHumanName + ' Player found at ' + PlayObject.m_PEnvir.sMapDesc + ' ' + IntToStr(PlayObject.m_nCurrX) + ':' + IntToStr(PlayObject.m_nCurrY),c_Blue,t_Hint);
      end else begin
        SysMsg(sHumanName + ' Player can''t be found or is not online.',c_Red,t_Hint);
      end;
    end else begin
      SysMsg(IntToStr((GetTickCount - m_dwProbeTick) div 1000 - 10) + ' seconds before you can use this again.',c_Red,t_Hint);
    end;
  end else begin
    SysMsg('You must wear the items assosiated with this command',c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdShowSbkGold(Cmd:pTGameCmd;sCastleName,sCtr,sGold:String);
var
  I: Integer;
  Ctr:Char;
  nGold:Integer;
  Castle:TUserCastle;
  List:TStringList;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sCastleName <> '') and (sCastleName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,'']),c_Red,t_Hint);
    exit;
  end;
  if sCastleName = '' then begin
   List:=TStringList.Create;
   g_CastleManager.GetCastleGoldInfo(List);
   for I := 0 to List.Count - 1 do begin
     SysMsg(List.Strings[I],c_Green,t_Hint);
   end;
   List.Free;
   exit;
  end;
  Castle:=g_CastleManager.Find(sCastleName);
  if Castle = nil then begin
    SysMsg(format(g_sGameCommandSbkGoldCastleNotFoundMsg,[sCastleName]),c_Red,t_Hint);
    exit;
  end;
    
  Ctr:=sCtr[1];
  nGold:=Str_ToInt(sGold,-1);
  if not (Ctr in ['=','-','+']) or (nGold < 0) or (nGold > 100000000) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandSbkGoldHelpMsg]),c_Red,t_Hint);
    exit;
  end;
    
  case Ctr of
    '=': Castle.m_nTotalGold:=nGold;
    '-': Dec(Castle.m_nTotalGold);
    '+': Inc(Castle.m_nTotalGold,nGold);
  end;
  if Castle.m_nTotalGold < 0 then Castle.m_nTotalGold:=0;
    
end;


procedure TPlayObject.CmdShowUseItemInfo(Cmd: pTGameCmd;
  sHumanName: String);
var
  I: Integer;
  PlayObject:TPlayObject;
  UserItem:pTUserItem;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandShowUseItemInfoHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  for I := Low(PlayObject.m_UseItems) to High(PlayObject.m_UseItems) do begin
    UserItem:=@PlayObject.m_UseItems[I];
    if UserItem.wIndex = 0 then Continue;
    SysMsg(format('%s[%s]IDX[%d]MakeIndex[%d]Durability[%d-%d]',
                 [GetUseItemName(I),
                  UserEngine.GetStdItemName(UserItem.wIndex),
                  UserItem.wIndex,
                  UserItem.MakeIndex,
                  UserItem.Dura,
                  UserItem.DuraMax]),
                  c_Blue,t_Hint);
  end;
end;

procedure TPlayObject.CmdBindUseItem(Cmd: pTGameCmd; sHumanName, sItem,
  sType: String);
var
  I: Integer;
  PlayObject:TPlayObject;
  UserItem:pTUserItem;
  nItem,nBind:Integer;
  ItemBind:pTItemBind;
  nItemIdx,nMakeIdex:Integer;
  sBindName:String;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  nBind:=-1;
  nItem:=GetUseItemIdx(sItem);
  if CompareText(sType,'UserID') = 0 then nBind:=0;
  if CompareText(sType,'CharName') = 0 then nBind:=1;
  if CompareText(sType,'IP') = 0 then nBind:=2;
    
  if (nItem < 0) or (nBind < 0) or (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandBindUseItemHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  UserItem:=@PlayObject.m_UseItems[nItem];
  if UserItem.wIndex = 0 then begin
    SysMsg(format(g_sGameCommandBindUseItemNoItemMsg,[sHumanName,sItem]),c_Red,t_Hint);
    exit;
  end;
  nItemIdx:=UserItem.wIndex;
  nMakeIdex:=UserItem.MakeIndex;
  case nBind of    //
    0: begin
      sBindName:=PlayObject.m_sUserID;
      g_ItemBindAccount.Lock;
      try
        for I := 0 to g_ItemBindAccount.Count - 1 do begin
          ItemBind:=g_ItemBindAccount.Items[I];
          if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
            SysMsg(format(g_sGameCommandBindUseItemAlreadBindMsg,[sHumanName,sItem]),c_Red,t_Hint);
            exit;
          end;
        end;
        New(ItemBind);
        ItemBind.nItemIdx:=nItemIdx;
        ItemBind.nMakeIdex:=nMakeIdex;
        ItemBind.sBindName:=sBindName;
        g_ItemBindAccount.Insert(0,ItemBind);
      finally
        g_ItemBindAccount.UnLock;
      end;
      SaveItemBindAccount();
      SysMsg(format('%s[%s]IDX[%d]MakeIndex[%d]Durability[%d-%d]BindName: %s',
                   [GetUseItemName(nItem),
                    UserEngine.GetStdItemName(UserItem.wIndex),
                    UserItem.wIndex,
                    UserItem.MakeIndex,
                    UserItem.Dura,
                    UserItem.DuraMax,
                    sBindName]),
                    c_Blue,t_Hint);
      PlayObject.SysMsg(format('Item: %s[%s]is now bound using: %s[%s]',
                                [GetUseItemName(nItem),
                                 UserEngine.GetStdItemName(UserItem.wIndex),
                                 sType,
                                 sBindName
                                ]),c_Blue,t_Hint);
    end;
    1: begin
      sBindName:=PlayObject.m_sCharName;
      g_ItemBindCharName.Lock;
      try
        for I := 0 to g_ItemBindCharName.Count - 1 do begin
          ItemBind:=g_ItemBindCharName.Items[I];
          if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
            SysMsg(format(g_sGameCommandBindUseItemAlreadBindMsg,[sHumanName,sItem]),c_Red,t_Hint);
            exit;
          end;
        end;
        New(ItemBind);
        ItemBind.nItemIdx:=nItemIdx;
        ItemBind.nMakeIdex:=nMakeIdex;
        ItemBind.sBindName:=sBindName;
        g_ItemBindCharName.Insert(0,ItemBind);
      finally
        g_ItemBindCharName.UnLock;
      end;
      SaveItemBindCharName();
      SysMsg(format('%s[%s]IDX[%d]MakeIndex[%d]Durability[%d-%d]Name: %s',
                   [GetUseItemName(nItem),
                    UserEngine.GetStdItemName(UserItem.wIndex),
                    UserItem.wIndex,
                    UserItem.MakeIndex,
                    UserItem.Dura,
                    UserItem.DuraMax,
                    sBindName]),
                    c_Blue,t_Hint);
      PlayObject.SysMsg(format('Item: %s[%s]Is now bound using %s[%s]',
                                [GetUseItemName(nItem),
                                 UserEngine.GetStdItemName(UserItem.wIndex),
                                 sType,
                                 sBindName
                                ]),c_Blue,t_Hint);
    end;
    2: begin
      sBindName:=PlayObject.m_sIPaddr;
      g_ItemBindIPaddr.Lock;
      try
        for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
          ItemBind:=g_ItemBindIPaddr.Items[I];
          if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
            SysMsg(format(g_sGameCommandBindUseItemAlreadBindMsg,[sHumanName,sItem]),c_Red,t_Hint);
            exit;
          end;
        end;
        New(ItemBind);
        ItemBind.nItemIdx:=nItemIdx;
        ItemBind.nMakeIdex:=nMakeIdex;
        ItemBind.sBindName:=sBindName;
        g_ItemBindIPaddr.Insert(0,ItemBind);
      finally
        g_ItemBindIPaddr.UnLock;
      end;
      SaveItemBindIPaddr();
      SysMsg(format('%s[%s]IDX[%d]MakeIndex[%d]Durability[%d-%d]BindName: %s',
                   [GetUseItemName(nItem),
                    UserEngine.GetStdItemName(UserItem.wIndex),
                    UserItem.wIndex,
                    UserItem.MakeIndex,
                    UserItem.Dura,
                    UserItem.DuraMax,
                    sBindName]),
                    c_Blue,t_Hint);
      PlayObject.SysMsg(format('Item: %s[%s]is now bound using: %s[%s]',
                                [GetUseItemName(nItem),
                                 UserEngine.GetStdItemName(UserItem.wIndex),
                                 sType,
                                 sBindName
                                ]),c_Blue,t_Hint);
    end;
  end;
end;
procedure TPlayObject.CmdUnBindUseItem(Cmd: pTGameCmd; sHumanName, sItem,
  sType: String);
var
  I: Integer;
  PlayObject:TPlayObject;
  UserItem:pTUserItem;
  nItem,nBind:Integer;
  ItemBind:pTItemBind;
  nItemIdx,nMakeIdex:Integer;
  sBindName:String;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  nBind:=-1;
  nItem:=GetUseItemIdx(sItem);
  if CompareText(sType,'帐号') = 0 then nBind:=0;
  if CompareText(sType,'人物') = 0 then nBind:=1;
  if CompareText(sType,'IP') = 0 then nBind:=2;
    
  if (nItem < 0) or (nBind < 0) or (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandBindUseItemHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject = nil then begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
    exit;
  end;
  UserItem:=@PlayObject.m_UseItems[nItem];
  if UserItem.wIndex = 0 then begin
    SysMsg(format(g_sGameCommandBindUseItemNoItemMsg,[sHumanName,sItem]),c_Red,t_Hint);
    exit;
  end;
  nItemIdx:=UserItem.wIndex;
  nMakeIdex:=UserItem.MakeIndex;
  case nBind of    //
    0: begin
      sBindName:=PlayObject.m_sUserID;
      g_ItemBindAccount.Lock;
      try
        for I := 0 to g_ItemBindAccount.Count - 1 do begin
          ItemBind:=g_ItemBindAccount.Items[I];
          if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
            SysMsg(format(g_sGameCommandBindUseItemAlreadBindMsg,[sHumanName,sItem]),c_Red,t_Hint);
            exit;
          end;
        end;
        New(ItemBind);
        ItemBind.nItemIdx:=nItemIdx;
        ItemBind.nMakeIdex:=nMakeIdex;
        ItemBind.sBindName:=sBindName;
        g_ItemBindAccount.Insert(0,ItemBind);
      finally
        g_ItemBindAccount.UnLock;
      end;
      SaveItemBindAccount();
      SysMsg(format('%s[%s]IDX[%d]MakeIndex[%d]Durability[%d-%d]BindName: %s',
                   [GetUseItemName(nItem),
                    UserEngine.GetStdItemName(UserItem.wIndex),
                    UserItem.wIndex,
                    UserItem.MakeIndex,
                    UserItem.Dura,
                    UserItem.DuraMax,
                    sBindName]),
                    c_Blue,t_Hint);
      PlayObject.SysMsg(format('Item: %s[%s]is now bound using: %s[%s]',
                                [GetUseItemName(nItem),
                                 UserEngine.GetStdItemName(UserItem.wIndex),
                                 sType,
                                 sBindName
                                ]),c_Blue,t_Hint);
    end;
    1: begin
      sBindName:=PlayObject.m_sCharName;
      g_ItemBindCharName.Lock;
      try
        for I := 0 to g_ItemBindCharName.Count - 1 do begin
          ItemBind:=g_ItemBindCharName.Items[I];
          if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
            SysMsg(format(g_sGameCommandBindUseItemAlreadBindMsg,[sHumanName,sItem]),c_Red,t_Hint);
            exit;
          end;
        end;
        New(ItemBind);
        ItemBind.nItemIdx:=nItemIdx;
        ItemBind.nMakeIdex:=nMakeIdex;
        ItemBind.sBindName:=sBindName;
        g_ItemBindCharName.Insert(0,ItemBind);
      finally
        g_ItemBindCharName.UnLock;
      end;
      SaveItemBindCharName();
      SysMsg(format('%s[%s]IDX[%d]MakeIndex[%d]Durability[%d-%d]BindName: %s',
                   [GetUseItemName(nItem),
                    UserEngine.GetStdItemName(UserItem.wIndex),
                    UserItem.wIndex,
                    UserItem.MakeIndex,
                    UserItem.Dura,
                    UserItem.DuraMax,
                    sBindName]),
                    c_Blue,t_Hint);
      PlayObject.SysMsg(format('Item: %s[%s]is now bound using: %s[%s]',
                                [GetUseItemName(nItem),
                                 UserEngine.GetStdItemName(UserItem.wIndex),
                                 sType,
                                 sBindName
                                ]),c_Blue,t_Hint);
    end;
    2: begin
      sBindName:=PlayObject.m_sIPaddr;
      g_ItemBindIPaddr.Lock;
      try
        for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
          ItemBind:=g_ItemBindIPaddr.Items[I];
          if (ItemBind.nItemIdx = nItemIdx) and (ItemBind.nMakeIdex = nMakeIdex) then begin
            SysMsg(format(g_sGameCommandBindUseItemAlreadBindMsg,[sHumanName,sItem]),c_Red,t_Hint);
            exit;
          end;
        end;
        New(ItemBind);
        ItemBind.nItemIdx:=nItemIdx;
        ItemBind.nMakeIdex:=nMakeIdex;
        ItemBind.sBindName:=sBindName;
        g_ItemBindIPaddr.Insert(0,ItemBind);
      finally
        g_ItemBindIPaddr.UnLock;
      end;
      SaveItemBindIPaddr();
      SysMsg(format('%s[%s]IDX[%d]MakeIndex[%d]Durability[%d-%d]BindName: %s',
                   [GetUseItemName(nItem),
                    UserEngine.GetStdItemName(UserItem.wIndex),
                    UserItem.wIndex,
                    UserItem.MakeIndex,
                    UserItem.Dura,
                    UserItem.DuraMax,
                    sBindName]),
                    c_Blue,t_Hint);
      PlayObject.SysMsg(format('Item: %s[%s]is now bound using: %s[%s]',
                                [GetUseItemName(nItem),
                                 UserEngine.GetStdItemName(UserItem.wIndex),
                                 sType,
                                 sBindName
                                ]),c_Blue,t_Hint);
    end;
  end;
end;
procedure TPlayObject.CmdShutup(Cmd:pTGameCmd;sHumanName,sTime:String);
var
  dwTime:LongWord;
  nIndex:Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sTime = '') or (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandShutupHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  dwTime:=Str_ToInt(sTime,5);
  g_DenySayMsgList.Lock;
  try
    nIndex:=g_DenySayMsgList.GetIndex(sHumanName);
    if nIndex >= 0 then begin
      g_DenySayMsgList.Objects[nIndex]:=TObject(GetTickCount + dwTime * 60 * 1000);
    end else begin
      g_DenySayMsgList.AddRecord(sHumanName,GetTickCount + dwTime * 60 * 1000);
    end;      
  finally
    g_DenySayMsgList.UnLock;
  end;
  SysMsg(format(g_sGameCommandShutupHumanMsg,[sHumanName,dwTime]),c_Red,t_Hint);
end;
procedure TPlayObject.CmdShutupList(Cmd:pTGameCmd;sParam1:String);
var
  I: Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if ((sParam1 <> '') and (sParam1[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,'']),c_Red,t_Hint);
    exit;
  end;

  if (m_btPermission < 6) then exit;
  g_DenySayMsgList.Lock;
  try
    if g_DenySayMsgList.Count <= 0 then begin
      SysMsg(g_sGameCommandShutupListIsNullMsg,c_Green,t_Hint);
      exit;
    end;
    for I := 0 to g_DenySayMsgList.Count - 1 do begin
      SysMsg(g_DenySayMsgList.Strings[I] + ' ' + IntToStr((LongWord(g_DenySayMsgList.Objects[I]) - GetTickCount) div 60000),c_Green,t_Hint);
    end; 
  finally
    g_DenySayMsgList.UnLock;
  end;
end;

procedure TPlayObject.CmdSvnInfo(Cmd:pTGameCmd;sParam1:String);
var
  I: Integer;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg('You do not have access to this command',c_Red,t_Hint);
    exit;
  end;

  if (m_btPermission < 6) then exit;


  if (SVN_ISTracking) and (SVN_DETAILS.Count > 0) then begin
    SysMsg('SVN Information:', c_Red, t_SVN1);
    for I := 0 to SVN_DETAILS.Count-1 do SysMsg(' ['+inttostr(I+1)+'] '+SVN_DETAILS.Strings[I], c_Red, t_SVN1);
    SysMsg('SVN Revision: '+inttostr(SVN_REVISION), c_Green, t_SVN2);
  end
  else begin
    SysMsg('No SVN Revision Data Available', c_Red, t_SVN3);
  end;
  SysMsg('Build Time: '+FormatDateTime('dd mmm yyyy/hh:nn:ss',UnixToDateTime(BUILDTIME))+' ('+inttostr(BUILDTIME)+')', c_Green, t_SVN2);
end;


procedure TPlayObject.CmdShutupRelease(Cmd:pTGameCmd;sHumanName:String;boAll:Boolean);
var
  I:Integer;
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandShutupReleaseHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  g_DenySayMsgList.Lock;
  try
    I:=g_DenySayMsgList.GetIndex(sHumanName);
    if I >= 0 then begin
      g_DenySayMsgList.Delete(I);
      PlayObject:=UserEngine.GeTPlayObject(sHumanName);
      if PlayObject <> nil then begin
        PlayObject.SysMsg(g_sGameCommandShutupReleaseCanSendMsg,c_Red,t_Hint);
      end;
      if boAll then begin
        UserEngine.SendServerGroupMsg(SS_210,nServerIndex,sHumanName);
      end;
      SysMsg(format(g_sGameCommandShutupReleaseHumanCanSendMsg,[sHumanName]),c_Green,t_Hint);
    end;      
  finally
    g_DenySayMsgList.UnLock;
  end;
end;
procedure TPlayObject.CmdSmakeItem(Cmd:pTGameCmd;nWhere,nValueType,nValue:Integer);
var
  sShowMsg:String;
  StdItem:TItem;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;

  if (nWhere in [0..12]) and (nValueType in [0..15]) and (nValue in [0..255])then begin
    if m_UseItems[nWhere].wIndex > 0 then begin
      StdItem:=UserEngine.GetStdItem(m_UseItems[nWhere].wIndex);
      if StdItem = nil then exit;
        
      if nValueType > 13 then begin
        nValue:=_MIN(65,nValue);
        if nValueType = 14 then m_UseItems[nWhere].Dura:= nValue * 1000;
        if nValueType = 15 then m_UseItems[nWhere].DuraMax:= nValue * 1000;
      end else begin
        m_UseItems[nWhere].btValue[nValueType]:=nValue;
      end;
      RecalcAbilitys();
      SendUpdateItem(@m_UseItems[nWhere]);
        sShowMsg:=IntToStr(m_UseItems[nWhere].wIndex) + '-' + IntToStr(m_UseItems[nWhere].MakeIndex) + ' ' +
                  IntToStr(m_UseItems[nWhere].Dura) + '/' + IntToStr(m_UseItems[nWhere].DuraMax) + ' ' +
                  IntToStr(m_UseItems[nWhere].btValue[0]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[1]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[2]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[3]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[4]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[5]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[6]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[7]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[8]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[9]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[10]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[11]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[12]) + '/' +
                  IntToStr(m_UseItems[nWhere].btValue[13]);
        SysMsg(sShowMsg,c_Blue,t_Hint);
      if g_Config.boShowMakeItemMsg then
        MainOutMessage('[MakeItem] ' + m_sCharName + '(' + StdItem.Name + ' -> ' + sShowMsg + ')');
    end else begin
      SysMsg(g_sGamecommandSuperMakeHelpMsg,c_Red,t_Hint);
    end;
  end;
end;
procedure TPlayObject.CmdSpirtStart(sCmd, sParam1: String);
var
  nTime:Integer;
  dwTime:LongWord;
begin
  if (m_btPermission < 6) then exit;
  if (sParam1 <> '') and (sParam1[1] = '?') then begin
    SysMsg('this command sets the untame time of all pets currently on server',c_Red,t_Hint);
    exit;
  end;
  nTime:=Str_ToInt(sParam1,-1);
  if nTime > 0 then begin
    dwTime:=LongWord(nTime) * 1000;
  end else begin
    dwTime:=g_Config.dwSpiritMutinyTime;
  end;
    
  g_dwSpiritMutinyTick:=GetTickCount + dwTime;
  SysMsg('All pets will untame in  ' + IntToStr(dwTime div 1000) + ' seconds',c_Green,t_Hint);
end;
procedure TPlayObject.CmdSpirtStop(sCmd, sParam1: String);
begin
  if (m_btPermission < 6) then exit;
  if (sParam1 <> '') and (sParam1[1] = '?') then begin
    SysMsg('This command will instantly cause all pets to untame',c_Red,t_Hint);
    exit;
  end;
  g_dwSpiritMutinyTick:=0;
  SysMsg('All pets untamed',c_Green,t_Hint);

end;



procedure TPlayObject.CmdStartQuest(Cmd:pTGameCmd; sQuestName: String);
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sQuestName = '') then begin
    SysMsg('Usage: @' + Cmd.sCmd + ' questname',c_Red,t_Hint);
    exit;
  end;
  UserEngine.SendQuestMsg(sQuestName);
end;

procedure TPlayObject.CmdSuperTing(Cmd:pTGameCmd;sHumanName,sRange:String);
var
  I: Integer;
  PlayObject:TPlayObject;
  MoveHuman:TPlayObject;
  nRange:Integer;
  HumanList:TList;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sRange = '') or (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandSuperTingHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  nRange:=_MAX(10,Str_ToInt(sRange,2));
  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    HumanList:=TList.Create;
    UserEngine.GetMapRageHuman(PlayObject.m_PEnvir,PlayObject.m_nCurrX,PlayObject.m_nCurrY,nRange,HumanList);
    for I := 0 to HumanList.Count - 1 do begin
      MoveHuman:=TPlayObject(HumanList.Items[I]);
      if MoveHuman <> Self then
        MoveHuman.MapRandomMove(MoveHuman.m_sHomeMap,0);
    end;
    HumanList.Free;
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
  end;
    
end;



procedure TPlayObject.CmdTakeOffHorse(sCmd, sParam: String);
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('this command will let you unmount from your horse',c_Red,t_Hint);
    SysMsg(format('Usage: @%s',[sCmd]),c_Red,t_Hint);
    exit;
  end;
  if not m_boOnHorse then exit;

  m_boOnHorse:=False;
  FeatureChanged();
end;

procedure TPlayObject.CmdTakeOnHorse(sCmd, sParam: String);
begin
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg('This command will let you mount your horse',c_Red,t_Hint);
    SysMsg(format('Use this: @%s',[sCmd]),c_Red,t_Hint);
    exit;
  end;
  if m_boOnHorse then exit;

  if (m_btHorseType = 0) then begin
    SysMsg('You do not have a horse',c_Red,t_Hint);
    exit;
  end;
  m_boOnHorse:=True;
  FeatureChanged();
end;

procedure TPlayObject.CmdTestFire(sCmd:String;nRange,nType,nTime,nPoint:Integer);
var
  nX,nY:Integer;
  FireBurnEvent:TFireBurnEvent;
  nMinX,nMaxX,nMinY,nMaxY:Integer;
begin
  nMinX:=m_nCurrX - nRange;
  nMaxX:=m_nCurrX + nRange;
  nMinY:=m_nCurrY - nRange;
  nMaxY:=m_nCurrY + nRange;
  for nX:= nMinX to nMaxX do begin
    for nY:= nMinY to nMaxY do begin
      if ((nX < nMaxX) and (nY = nMinY)) or
         ((nY < nMaxY) and (nX = nMinX)) or
         (nX = nMaxX) or (nY = nMaxY) then begin
        FireBurnEvent:=TFireBurnEvent.Create(Self,nX,nY,nType,nTime * 1000,nPoint);
        g_EventManager.AddEvent(FireBurnEvent);
      end;
    end;
  end;
end;

procedure TPlayObject.CmdTestGetBagItems(Cmd: pTGameCmd; sParam: String);
var
  btDc,btSc,btMc,btDura:Byte;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sParam <> '') and (sParam[1] = '?') then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandTestGetBagItemsHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  btDc:=0;
  btSc:=0;
  btMc:=0;
  btDura:=0;
  GetBagUseItems(btDc,btSc,btMc,btDura);
  SysMsg(format('DC:%d SC:%d MC:%d DURA:%d',[btDc,btSc,btMc,btDura]),c_Blue,t_Hint);
end;


procedure TPlayObject.CmdTestSpeedMode(Cmd: pTGameCmd);
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  m_boTestSpeedMode:= not m_boTestSpeedMode;
  if m_boTestSpeedMode then begin
    SysMsg('TestSpeedMode enabled',c_Red,t_Hint);
  end else begin
    SysMsg('TestSpeedMode disabled',c_Red,t_Hint);
  end;

end;

procedure TPlayObject.CmdTestStatus(sCmd: String; nType, nTime: Integer);
begin
  if (m_btPermission < 6) then exit;
  if (not (nType in [Low(TStatusTime)..High(TStatusTime)])) or (nTime < 0) then begin
    SysMsg('Use this: @' + sCmd + ' statusvalue(0..11) time',c_Red,t_Hint);
    exit;
  end;
  m_wStatusTimeArr[nType]:=nTime * 1000;
  m_dwStatusArrTick[nType]:=GetTickCount();
  m_nCharStatus:=GetCharStatus();
  StatusChanged();
  SysMsg(format('user status changed for: %d seconds',[nType,nTime]),c_Green,t_Hint);
end;

procedure TPlayObject.CmdTing(Cmd:pTGameCmd;sHumanName:String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sHumanName = '') or ((sHumanName <> '') and (sHumanName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandTingHelpMsg]),c_Red,t_Hint);
    exit;
  end;

  PlayObject:=UserEngine.GeTPlayObject(sHumanName);
  if PlayObject <> nil then begin
    PlayObject.MapRandomMove(m_sHomeMap,0);
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumanName]),c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdTraining(sSkillName: String; nLevel: Integer); //004CC414
begin
  if (m_btPermission < 6) then exit;
end;

procedure TPlayObject.CmdUserMoveXY(sCMD, sX, sY: String);
var
  Envir:TEnvirnoment;
  nX,nY:Integer;
begin
  if m_boTeleport then begin
    nX:=Str_ToInt(sX,-1);
    nY:=Str_ToInt(sY,-1);
    {
    if (nX < 0) or (nY < 0) then begin
      SysMsg('Use this: @' + sCMD + ' 座标X 座标Y',c_Red,t_Hint);
      exit;
    end;
    }
    if not m_PEnvir.Flag.boNOPOSITIONMOVE then begin
      if m_PEnvir.CanWalkOfItem(nX,nY,g_Config.boUserMoveCanDupObj,g_Config.boUserMoveCanOnItem) then begin
        if (GetTickCount - m_dwTeleportTick) > g_Config.dwUserMoveTime * 1000{10000} then begin
          m_dwTeleportTick:=GetTickCount();
          SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
          //BaseObjectMove('',sX,sY);
          SpaceMove(m_sMapName,nX,nY,0);
        end else begin
          SysMsg(IntToStr(g_Config.dwUserMoveTime - (GetTickCount - m_dwTeleportTick) div 1000) + '秒之后才可以再使用此功能！！！',c_Red,t_Hint);
        end;
      end else begin
         SysMsg(format(g_sGameCommandPositionMoveCanotMoveToMap,[m_sMapName,sX,sY]),c_Green,t_Hint);
      end;
    end else begin
      SysMsg(format(g_sGameCommandPositionMoveCanotMoveToMap,[m_sMapName,sX,sY]),c_Red,t_Hint);
    end;
  end else begin
    SysMsg('You must be wearing the items associated with this command to use it.',c_Red,t_Hint);
  end;
end;
procedure TPlayObject.CmdViewDiary(sCMD: String; nFlag: Integer);//004D1B70
begin

end;

procedure TPlayObject.CmdViewWhisper(Cmd:pTGameCmd; sCharName, sParam2: String);
var
  PlayObject:TPlayObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;
  if (sCharName = '') or ((sCharName <> '') and (sCharName[1] = '?')) then begin
    SysMsg(format(g_sGameCommandParamUnKnow,[Cmd.sCmd,g_sGameCommandViewWhisperHelpMsg]),c_Red,t_Hint);
    exit;
  end;
  PlayObject:=UserEngine.GeTPlayObject(sCharName);
  if PlayObject <> nil then begin
    if PlayObject.m_GetWhisperHuman = Self then begin
      PlayObject.m_GetWhisperHuman:=nil;
      SysMsg(format(g_sGameCommandViewWhisperMsg1,[sCharName]),c_Green,t_Hint);
    end else begin
      PlayObject.m_GetWhisperHuman:=Self;
      SysMsg(format(g_sGameCommandViewWhisperMsg2,[sCharName]),c_Green,t_Hint);
    end;
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sCharName]),c_Red,t_Hint);
  end;
end;

procedure TPlayObject.CmdTradeGT(Cmd: pTGameCmd);
var
  BaseObject:TBaseObject;
begin
  if (m_btPermission < Cmd.nPermissionMin) then begin
    SysMsg(g_sGameCommandPermissionTooLow,c_Red,t_Hint);
    exit;
  end;  
  if m_boDealing then exit;
  if GetTickCount - m_DealLastTick < g_Config.dwTryDealTime{3000} then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sPleaseTryDealLaterMsg);
    exit;
  end;
  if not m_boCanDeal then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sCanotTryDealMsg);
    exit;
  end;
  if (m_MyGuild = nil) or (TGuild(m_MyGuild).m_Territory = nil) or (IsGuildMaster = False) then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'You do not own a Guild territory');
    exit;
  end;
  if TTerritory(TGuild(m_MyGuild).m_Territory).ForSale = False then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'Your Guild territory is not up for sale');
    exit;
  end;
  BaseObject:=GetPoseCreate();
  if (BaseObject <> nil) and (BaseObject <> self) then begin
    if (BaseObject.GetPoseCreate = Self) and (not BaseObject.m_boDealing) then begin
      if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if (BaseObject.m_boAllowDeal and TPlayObject(BaseObject).m_boCanDeal) then begin
          if (BaseObject.m_MyGuild = nil) or (BaseObject.IsGuildMaster = False) then begin
            SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'The other person does not own a Guild');
            exit
          end;
          if g_GuildTerritory.FindGuildTerritoryEx(TGuild(BaseObject.m_MyGuild).sGuildName) <> nil then begin
            SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'The other person already owns a Guild territory');
            exit;
          end;
          m_boDealing:=True;
          m_boDealGT:=True;
          m_DealCreat:=BaseObject;
          m_DealLastTick:=GetTickCount();
          BaseObject.m_boDealing := True;
          BaseObject.m_DealCreat := self;
          BaseObject.m_DealLastTick := GetTickCount();
          SysMsg('Waiting for other party to accept',c_Red,t_Hint);
          TPlayObject(BaseObject).SendDefMessage(SM_GTTRADE,TTerritory(TGuild(m_MyGuild).m_Territory).ForSaleGold,0,0,0,'');
        end else begin //004DD1CC
          SysMsg('The other person has disabled trades',c_Red,t_Hint);
        end;
      end;

    end else begin //004DD1E0
      SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'The other person is already trading');
      exit;
    end;
  end else begin //004DD1F9
      SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'You need to face another person to sell your GT to');
      exit;
  end;
end;

constructor TPlayObject.Create;//004C9860
begin
  inherited;
  m_btRaceServer     := RC_PLAYOBJECT;
  m_boEmergencyClose := False;
  m_boSwitchData     := False;
  m_boReconnection   := False;
  m_boKickFlag       := False;
  m_boSoftClose      := False;
  m_boReadyRun       := False;
  bo698              := False;
  n69C               := 0;
  m_dwSaveRcdTick    := GetTickCount();
  m_boWantRefMsg     := True;
  m_boRcdSaved       := False;
  m_boDieInFight3Zone              := False;
  m_Script           := nil;
  m_boTimeRecall     := False;
  m_sMoveMap         := '';
  m_nMoveX           := 0;
  m_nMoveY           := 0;
  m_dwRunTick        := GetTickCount();
  m_nRunTime         := 250;
  m_dwSearchTime     := 1000;
  m_dwSearchTick     := GetTickCount();
  m_nViewRange       := 12;
  m_boNewHuman       := False;
  m_boLoginNoticeOK  := False;
  bo6AB              := False;
  m_boExpire         := False;
  m_boSendNotice     := False;
  m_dwCheckDupObjTick          := GetTickCount();
  dwTick578          := GetTickCount();
  dwTick57C          := GetTickCount();
  m_boInSafeArea              := False;
  n5F8               := 0;
  n5FC               := 0;
  m_dwMagicAttackTick     := GetTickCount();
  m_dwMagicAttackInterval := 0;
  m_dwAttackTick          := GetTickCount();
  m_dwMoveTick            := GetTickCount();
  m_dwTurnTick            := GetTickCount();
  m_dwActionTick          := GetTickCount();
  m_dwAttackCount         := 0;
  m_dwAttackCountA        := 0;
  m_dwMagicAttackCount    := 0;
  m_dwMoveCount           := 0;
  m_dwMoveCountA          := 0;
  m_nOverSpeedCount       := 0;
  TList55C                := TList.Create;
  m_sOldSayMsg            := '';
  m_dwSayMsgTick          := GetTickCount();
  m_boDisableSayMsg       := False;
  m_dwDisableSayMsgTick   := GetTickCount();
  m_dLogonTime            := Now();
  m_dwLogonTick           := GetTickCount();
  n584                    := 0;
  n588                    := 0;
  m_boSwitchData          := False;
  m_boSwitchDataSended    := False;
  m_nWriteChgDataErrCount := 0;
  m_dwShowLineNoticeTick  := GetTickCount();
  m_nShowLineNoticeIdx    := 0;
  m_nSoftVersionDateEx    := 0;
  m_CanJmpScriptLableList := TStringList.Create;
  m_nKillMonExpMultiple   := 1;
  m_nKillMonExpRate       := 100;
  m_dwRateTick            := GetTickCount();
  m_nPowerRate            := 100;

  m_boSetStoragePwd       :=False;
  m_boReConfigPwd         :=False;
  m_boCheckOldPwd         :=False;
  m_boUnLockPwd           :=False;
  m_boUnLockStoragePwd    :=False;
  m_boPasswordLocked      :=False;  //锁仓库
  m_btPwdFailCount        :=0;
  m_sTempPwd              :='';
  m_sStoragePwd           :='';;
  m_boFilterSendMsg       :=False;

  m_boCanDeal             :=True;
  m_boCanDrop             :=True;
  m_boCanGetBackItem        :=True;
  m_boCanWalk               :=True;
  m_boCanRun                :=True;
  m_boCanHit                :=True;
  m_boCanSpell              :=True;
  m_boCanUseItem            :=True;
  m_nMemberType             :=0;
  m_nMemberLevel            :=0;

  m_nGameGold               := 0;
  m_boDecGameGold           := False;
  m_nDecGameGold            := 1;
  m_dwDecGameGoldTick       := GetTickCount();
  m_dwDecGameGoldTime       := 60 * 1000;

  m_boIncGameGold           := False;
  m_nIncGameGold            := 1;
  m_dwIncGameGoldTick       := GetTickCount();
  m_dwIncGameGoldTime       := 60 * 1000;

  m_nGamePoint              := 0;
  m_dwIncGamePointTick      := GetTickCount();

  m_nPayMentPoint           := 0;

  m_DearHuman               := nil;
  m_MasterHuman             := nil;
  m_MasterList              := TList.Create;
  m_boSendMsgFlag           := False;
  m_boChangeItemNameFlag    := False;

  m_boCanMasterRecall       := False;
  m_boCanDearRecall         := False;
  m_dwDearRecallTick        := GetTickCount();
  m_dwMasterRecallTick      := GetTickCount();
  m_btReColorIdx            := 0;
  m_GetWhisperHuman         := nil;
  m_boOnHorse               := False;
  m_wContribution           := 0;
  m_sRankLevelName          := g_sRankLevelName;
  m_boFixedHideMode         := True;
  FillChar(m_nMval,SizeOf(m_nMval),#0);
  //m_nClientFlagMode         := -1;
  m_dwAutoGetExpTick        := GetTickCount;
  m_nAutoGetExpPoint        := 0;
  m_AutoGetExpEnvir         := nil;
  m_dwHitIntervalTime       := g_Config.dwHitIntervalTime;  //攻击间隔
  m_dwMagicHitIntervalTime  := g_Config.dwMagicHitIntervalTime;  //魔法间隔
  m_dwRunIntervalTime       := g_Config.dwRunIntervalTime;  //走路间隔
  m_dwWalkIntervalTime      := g_Config.dwWalkIntervalTime;  //走路间隔
  m_dwTurnIntervalTime      := g_Config.dwTurnIntervalTime;  //换方向间隔
  m_dwActionIntervalTime    := g_Config.dwActionIntervalTime;  //组合操作间隔
  m_dwRunLongHitIntervalTime    := g_Config.dwRunLongHitIntervalTime;  //组合操作间隔
  m_dwRunHitIntervalTime    := g_Config.dwRunHitIntervalTime;  //组合操作间隔
  m_dwWalkHitIntervalTime   := g_Config.dwWalkHitIntervalTime;  //组合操作间隔
  m_dwRunMagicIntervalTime  := g_Config.dwRunMagicIntervalTime;  //跑位魔法间隔
  m_DynamicVarList          := TList.Create;
  m_SessInfo                := nil;
  m_boTestSpeedMode         := False;
  m_boLockLogon             := True;
  m_boLockLogoned           := False;
  m_dwBBSDelayTime          := getTickCount();
  m_dwBBSPostDelay          := getTickCount();
end;

procedure TPlayObject.DealCancel; //004DD394
begin
  if not m_boDealing then exit;
  m_boDealing:=False;
  SendDefMessage(SM_DEALCANCEL,0,0,0,0,'');
  if m_DealCreat <> nil then begin
    TPlayObject(m_DealCreat).DealCancel;
  end;
  m_DealCreat:=nil;
  GetBackDealItems();
  SysMsg(g_sDealActionCancelMsg,c_Green,t_Hint);
  m_DealLastTick:=GetTickCount();
end;

procedure TPlayObject.RefineCancel; //004DD394
begin
  if not m_boRefineing then exit;
  m_boRefineing:=False;
  SendDefMessage(SM_REFINECANCEL,0,0,0,0,'');
  if m_RefineCreat <> nil then begin
    TPlayObject(m_RefineCreat).RefineCancel;
  end;
  m_RefineCreat:=nil;
  GetBackRefineItems();
//  SysMsg(g_sDealActionCancelMsg,c_Green,t_Hint);
  m_RefineLastTick:=GetTickCount();
end;

procedure TPlayObject.DealCancelA;
begin
  m_Abil.HP:=m_WAbil.HP;
  DealCancel();
end;

function TPlayObject.DecGold(nGold: Integer): Boolean; //004BF6A8
begin
  Result:=False;
  if m_nGold >= nGold then begin
    Dec(m_nGold,nGold);
    Result:=True;
  end;     
end;

destructor TPlayObject.Destroy;//004C9B54
var
  I: Integer;
begin
  m_MasterList.Free;
  for I := 0 to TList55C.Count - 1 do begin

  end;
  TList55C.Free;
  for I := 0 to m_DynamicVarList.Count - 1 do begin
    Dispose(pTDynamicVar(m_DynamicVarList.Items[I]));
  end;
  m_DynamicVarList.Free;
  m_CanJmpScriptLableList.Free;
  inherited;
end;

procedure TPlayObject.Disappear;//004CA89C
begin
  if m_boReadyRun then DisappearA;
  if m_boTransparent and m_boHideMode then m_wStatusTimeArr[STATE_TRANSPARENT{0x70}]:=0;  //004CA8F7

  if m_GroupOwner <> nil then begin
    m_GroupOwner.DelMember(Self);
  end;
  if m_MyGuild <> nil then begin
    TGuild(m_MyGuild).DelHumanObj(Self);
  end;
  LogonTimcCost();
  inherited;
end;

procedure TPlayObject.DropUseItems(BaseObject: TBaseObject);
var
  I: Integer;
  nRate:Integer;
  StdItem:TItem;
  DelList:TStringList;
  boNeedRecalc:Boolean;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::DropUseItems';
begin
  DelList:=nil;
  boNeedRecalc := False;
  try                 
    if m_boAngryRing or m_boNoDropUseItem then exit;

    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      StdItem:=UserEngine.GetStdItem(m_UseItems[I].wIndex);
      if StdItem <> nil then begin
        if StdItem.Reserved and 8 <> 0 then begin
          if DelList = nil then DelList:=TStringList.Create;
          DelList.AddObject('',TObject(m_UseItems[I].MakeIndex));
          //004BB885
          if StdItem.NeedIdentify = 1 then
            AddGameDataLog('16' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     //UserEngine.GetStdItemName(m_UseItems[I].wIndex) + #9 +
                     StdItem.Name + #9 +
                     IntToStr(m_UseItems[I].MakeIndex) + #9 +
                     BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
                     '0');
          m_UseItems[I].wIndex:=0;
          boNeedRecalc := True;
        end;
      end;
    end;

    if m_UseItems[U_CHARM].wIndex <> 0 then begin
      SendDelItems(@m_UseItems[U_CHARM]);
      m_UseItems[U_CHARM].wIndex:=0;

      boNeedRecalc := True;
    end;


    if PKLevel > 2 then nRate:=g_Config.nDieRedDropUseItemRate{15}
    else nRate:=g_Config.nDieDropUseItemRate{30};

    for I := Low(THumanUseItems) to High(THumanUseItems) do begin
      if Random(nRate) <> 0 then Continue;
      if InDisableTakeOffList(m_UseItems[I].wIndex) then Continue;
      if DropItemDown(@m_UseItems[I],2,True,BaseObject,Self) then begin
          StdItem:=UserEngine.GetStdItem(m_UseItems[I].wIndex);
          if StdItem <> nil then begin
            if StdItem.Reserved and 10 = 0 then begin
              if m_btRaceServer = RC_PLAYOBJECT then begin
                if DelList = nil then DelList:=TStringList.Create;
                DelList.AddObject(UserEngine.GetStdItemName(m_UseItems[I].wIndex),TObject(m_UseItems[I].MakeIndex));
              end;
              m_UseItems[I].wIndex:=0;
              boNeedRecalc := True;
            end;
          end;
      end;
    end;
    if DelList <> nil then
      SendMsg(Self,RM_SENDDELITEMLIST,0,Integer(DelList),0,0,'');

    if (boNeedRecalc) then begin
      RecalcAbilitys();
      SendMsg(Self,RM_ABILITY,0,0,0,0,'');
      SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TPlayObject.GainExp (dwExp:LongWord); //004BE600
var
   i, n, sumlv: integer;
   PlayObject:TPlayObject;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::GainExp';
const
   bonus: array[0..GROUPMAX] of Real = (1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.1, 2.2);
begin
  try
    if m_GroupOwner <> nil then begin
      sumlv := 0;
      n := 0;
      for i:=0 to m_GroupOwner.m_GroupMembers.Count-1 do begin
        PlayObject:=TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
        if not PlayObject.m_boDeath and (m_PEnvir = PlayObject.m_PEnvir) and (abs(m_nCurrX-PlayObject.m_nCurrX) <= 12) and (abs(m_nCurrX - PlayObject.m_nCurrX) <= 12) then begin
          sumlv := sumlv + PlayObject.m_Abil.Level;
           Inc (n);
        end;
      end;
      if (sumlv > 0) and (n > 1) then begin
        if n in [0..GROUPMAX] then
          dwExp := Round (dwExp * bonus[n]);
        for i:=0 to m_GroupOwner.m_GroupMembers.Count-1 do begin
          PlayObject:= TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
          if not PlayObject.m_boDeath and (m_PEnvir = PlayObject.m_PEnvir) and (abs(m_nCurrX - PlayObject.m_nCurrX) <= 12) and (abs(m_nCurrX - PlayObject.m_nCurrX) <= 12) then begin
            if g_Config.boHighLevelKillMonFixExp then begin //02/08 增加，在高等级经验不变时，把组队的经验平均分配
              PlayObject.WinExp (Round (dwExp / n));
            end else begin
              PlayObject.WinExp (Round (dwExp / sumlv * PlayObject.m_Abil.Level));
            end;
          end;
        end;
      end else WinExp (dwExp);
    end else WinExp (dwExp);
  except
    MainOutMessage (sExceptionMsg);
  end;
end;

procedure TPlayObject.GameTimeChanged;
begin
  if m_btBright <> g_nGameTime then begin
     m_btBright:=g_nGameTime;
     SendMsg(Self,RM_DAYCHANGING,0,0,0,0,'');
  end;
end;
procedure TPlayObject.GetBackDealItems; //004DD270
var
  I: Integer;
  UserItem:pTUserItem;
  UserItem2:pTUserItem;
begin
  if m_DealItemList.Count > 0 then begin
    for I := 0 to m_DealItemList.Count - 1 do begin
      UserItem2:=m_DealItemList.Items[i];
      if UserEngine.GetStdItem(UserItem2.wIndex).StdMode = 45 then begin
        UserItem:=CheckItems(UserEngine.GetStdItemName(UserItem2.wIndex));
        if UserItem = nil then
          m_ItemList.Add(m_DealItemList.Items[i])
        else begin
          inc(UserItem.Amount,pTUserItem(m_DealItemList.Items[i]).Amount);
          WeightChanged();
        end;
      end else
      m_ItemList.Add(m_DealItemList.Items[i]);
    end;
  end;
  m_DealItemList.Clear;
  Inc(m_nGold,m_nDealGolds);
  m_nDealGolds:=0;
  m_boDealOK:=False;
end;

procedure TPlayObject.GetBackRefineItems; //004DD270
var
  I: Integer;
  UserItem:pTUserItem;
  UserItem2:pTUserItem;
begin
  if m_RefineItemList.Count > 0 then begin
    for I := 0 to m_RefineItemList.Count - 1 do begin
      UserItem2:=m_RefineItemList.Items[i];
      if UserEngine.GetStdItem(UserItem2.wIndex).StdMode = 45 then begin
        UserItem:=CheckItems(UserEngine.GetStdItemName(UserItem2.wIndex));
        if UserItem = nil then
          m_ItemList.Add(m_RefineItemList.Items[i])
        else begin
          inc(UserItem.Amount,pTUserItem(m_RefineItemList.Items[i]).Amount);
          WeightChanged();
        end;
      end else
      m_ItemList.Add(m_RefineItemList.Items[i]);
    end;
  end;
  m_RefineItemList.Clear;
  m_boRefineOK:=False;
end;

procedure TPlayObject.GetBagUseItems(var btDc, btSc, btMc, btDura: Byte);
  var
    I,II: Integer;
    DuraList:TList;
    UserItem:pTUserItem;
    StdItem:TItem;
    StdItem80:TStdItem;
    DelItemList:TStringList;
    nDc,nSc,nMc,nDcMin,nDcMax,nScMin,nScMax,nMcMin,nMcMax,nDura,nItemCount:Integer;
  begin
    nDcMin:=0;
    nDcMax:=0;
    nScMin:=0;
    nScMax:=0;
    nMcMin:=0;
    nMcMax:=0;
    nDura:=0;
    nItemCount:=0;
    DelItemList:=nil;
    DuraList:=TList.Create;
    for I := m_ItemList.Count - 1 downto 0 do begin
      UserItem:=m_ItemList.Items[I];
      if UserEngine.GetStdItemName(UserItem.wIndex) = g_Config.sBlackStone then begin
        DuraList.Add(Pointer(ROUND(UserItem.Dura / 1.0e3)));
        if DelItemList = nil then DelItemList:=TStringList.Create;
        DelItemList.AddObject(g_Config.sBlackStone,TObject(UserItem.MakeIndex));
        DisPose(UserItem);
        m_ItemList.Delete(I);
      end else begin
        if IsAccessory(UserItem.wIndex) then begin
          StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
          if StdItem <> nil then begin
            StdItem.GetStandardItem(StdItem80);
            StdItem.GetItemAddValue(UserItem,StdItem80);
            nDc:=0;
            nSc:=0;
            nMc:=0;
            if StdItem.ItemType = ITEM_ACCESSORY then begin
              case StdItem80.StdMode of
                19,20,21: begin //004A0421
                  nDc:=HiWord(StdItem80.DC) + LoWord(StdItem80.DC);
                  nSc:=HiWord(StdItem80.SC) + LoWord(StdItem80.SC);
                  nMc:=HiWord(StdItem80.MC) + LoWord(StdItem80.MC);
                end;
                22,23: begin //004A046E
                  nDc:=HiWord(StdItem80.DC) + LoWord(StdItem80.DC);
                  nSc:=HiWord(StdItem80.SC) + LoWord(StdItem80.SC);
                  nMc:=HiWord(StdItem80.MC) + LoWord(StdItem80.MC);
                end;
                24,26: begin
                  nDc:=HiWord(StdItem80.DC) + LoWord(StdItem80.DC) + 1;
                  nSc:=HiWord(StdItem80.SC) + LoWord(StdItem80.SC) + 1;
                  nMc:=HiWord(StdItem80.MC) + LoWord(StdItem80.MC) + 1;
                end;
              end;
            end;
            if nDcMin < nDc then begin
              nDcMax:=nDcMin;
              nDcMin:=nDc;
            end else begin
              if nDcMax < nDc then nDcMax:=nDc;
            end;
            if nScMin < nSc then begin
              nScMax:=nScMin;
              nScMin:=nSc;
            end else begin
              if nScMax < nSc then nScMax:=nSc;
            end;
            if nMcMin < nMc then begin
              nMcMax:=nMcMin;
              nMcMin:=nMc;
            end else begin
              if nMcMax < nMc then nMcMax:=nMc;
            end;
            if DelItemList = nil then DelItemList:=TStringList.Create;
            DelItemList.AddObject(StdItem.Name,TObject(UserItem.MakeIndex));
            //004A06DB
            if StdItem.NeedIdentify = 1 then
            AddGameDataLog('26' +  #9 +
                           m_sMapName + #9 +
                           IntToStr(m_nCurrX) + #9 +
                           IntToStr(m_nCurrY) + #9 +
                           m_sCharName + #9 +
                           //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                           StdItem.Name + #9 +
                           IntToStr(UserItem.MakeIndex) + #9 +
                           '1' + #9 +
                           '0');
            DisPose(UserItem);
            m_ItemList.Delete(I);
          end;
        end;
      end;
    end;    // for
    for I := 0 to DuraList.Count - 1 do begin
      for II := DuraList.Count -1 downto i + 1 do begin
        if Integer(DuraList.Items[II]) > Integer(DuraList.Items[II- 1]) then
          DuraList.Exchange(II,II-1);
      end;    // for
    end;    // for
    for I := 0 to DuraList.Count - 1 do begin
      nDura:=nDura + Integer(DuraList.Items[I]);
      Inc(nItemCount);
      if nItemCount >= 5 then break;
    end;
    btDura:=ROUND(_MIN(5,nItemCount) + _MIN(5,nItemCount) * ((nDura /nItemCount) / 5.0));
    btDc:=nDcMin div 5 + nDcMax div 3;
    btSc:=nScMin div 5 + nScMax div 3;
    btMc:=nMcMin div 5 + nMcMax div 3;
    if DelItemList <> nil then
      SendMsg(Self,RM_SENDDELITEMLIST,0,Integer(DelItemList),0,0,'');

    if DuraList <> nil then DuraList.Free;

end;


function TPlayObject.GeTBaseObjectInfo: String;
begin
  Result:=m_sCharName +
          ' Hex:' + IntToHex(Integer(Self),2) +
          ' GM Level: ' + IntToStr(m_btPermission) +
          ' GM Mode: ' + BoolToStr(m_boAdminMode) +
          ' Observer: ' + BoolToStr(m_boObMode) +
          ' SuperMan: ' + BoolToStr(m_boSuperMan) +
          ' Map:' + m_sMapName + '(' + m_PEnvir.sMapDesc + ')' +
          ' Co-Ord:' + IntToStr(m_nCurrX) + ':' + IntToStr(m_nCurrY) +
          ' Level:' + IntToStr(m_Abil.Level) +
          ' Re-Level:' + IntToStr(m_btReLevel) +
          ' Exp:' + IntToStr(m_Abil.Exp) +
          ' HP: ' + IntToStr(m_WAbil.HP) + '-' + IntToStr(m_WAbil.MaxHP) +
          ' MP: ' + IntToStr(m_WAbil.MP) + '-' + IntToStr(m_WAbil.MaxMP) +
          ' DC: ' + IntToStr(LoWord(m_WAbil.DC)) + '-' + IntToStr(HiWord(m_WAbil.DC)) +
          ' MC: ' + IntToStr(LoWord(m_WAbil.MC)) + '-' + IntToStr(HiWord(m_WAbil.MC)) +
          ' SC: ' + IntToStr(LoWord(m_WAbil.SC)) + '-' + IntToStr(HiWord(m_WAbil.SC)) +
          ' AC: ' + IntToStr(LoWord(m_WAbil.AC)) + '-' + IntToStr(HiWord(m_WAbil.AC)) +
          ' MAC: ' + IntToStr(LoWord(m_WAbil.MAC)) + '-' + IntToStr(HiWord(m_WAbil.MAC)) +
          ' Hit:' + IntToStr(m_btHitPoint) +
          ' Agility:' + IntToStr(m_btSpeedPoint) +
          ' Speed:' + IntToStr(m_nHitSpeed) +
          ' Store Pass:' + m_sStoragePwd +
          ' Local IP:' + m_sIPaddr + '(' + m_sIPLocal{GetIPLocal(m_sIPaddr)} + ')' +
          ' UserID:' + m_sUserID +
          ' Last Login:' + DateTimeToStr(m_dLogonTime) +
          ' Time ingame(mins):' + IntToStr((GetTickCount - m_dwLogonTick) div 60000) +
          ' Payment:' + IntToStr(m_nPayMent) +
          ' ' + g_Config.sGameGoldName + ':' + IntToStr(m_nGameGold) +
          ' ' + g_Config.sGamePointName + ':' + IntToStr(m_nGamePoint) +
          ' ' + g_Config.sPayMentPointName + ':' + IntToStr(m_nPayMentPoint) +
          ' Member Type:' + IntToStr(m_nMemberType) +
          ' Memeber Level:' + IntToStr(m_nMemberLevel) +
          ' Exp Rate:' + CurrToStr(m_nKillMonExpRate / 100) +
          ' Power Rate:' + CurrToStr(m_nPowerRate / 100) +
          ' Credit Points:' + IntToStr(m_btCreditPoint);
end;

function TPlayObject.GetDigUpMsgCount: Integer;
var
  I: Integer;
  SendMessage:pTSendMessage;
begin
  Result:=0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for I := 0 to m_MsgList.Count - 1 do begin
      SendMessage:=m_Msglist.Items[i];
      if (SendMessage.wIdent = CM_BUTCH) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TBaseObject.UseLamp;//004C759C
var
  nOldDura:Integer;
  nDura:Integer;
  PlayObject:TPlayObject;
  Stditem:TItem;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::UseLamp';
begin
  try
    if m_UseItems[U_RIGHTHAND].wIndex > 0 then begin
      Stditem:=UserEngine.GetStdItem(m_UseItems[U_RIGHTHAND].wIndex);
      if (Stditem = nil) or (Stditem.Source <> 0) then exit;

      nOldDura:=ROUND(m_UseItems[U_RIGHTHAND].Dura / 1000);
      if g_Config.boDecLampDura then begin
        if (StdItem.Reserved = 1) then begin
          nDura:=m_UseItems[U_RIGHTHAND].Dura - 3; //make dura go down faster..
        end else begin
          nDura:=m_UseItems[U_RIGHTHAND].Dura - 1;
        end;
      end else begin
        nDura:=m_UseItems[U_RIGHTHAND].Dura;
      end;
      if nDura <= 0 then begin
        m_UseItems[U_RIGHTHAND].Dura:=0;
        SendMsg(Self,RM_LAMPCHANGEDURA,0,m_UseItems[U_RIGHTHAND].Dura,0,0,'');

        if m_btRaceServer = RC_PLAYOBJECT then begin
          PlayObject:=TPlayObject(Self);
          PlayObject.SendDelItems(@m_UseItems[U_RIGHTHAND]);
        end;
        m_UseItems[U_RIGHTHAND].wIndex:=0;
        //m_nLight:=0;
        //SendRefMsg(RM_CHANGELIGHT,0,0,0,0,'');
        SendMsg(Self,RM_LAMPCHANGEDURA,0,m_UseItems[U_RIGHTHAND].Dura,0,0,'');
        RecalcAbilitys();
      end else begin
       m_UseItems[U_RIGHTHAND].Dura:=nDura;
      end;
      if nOldDura <> ROUND(nDura / 1000) then begin
        SendMsg(Self,RM_LAMPCHANGEDURA,0,m_UseItems[U_RIGHTHAND].Dura,0,0,'');
      end;          
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;


//004C368C
function TBaseObject.GetPoseCreate: TBaseObject;
var
  nX,nY:Integer;
begin
  Result:=nil;
  if GetFrontPosition(nX,nY) then begin
    Result:=m_PEnvir.GetMovingObject(nX,nY,True);
  end;    
end;

function TPlayObject.PlayGetPoseCreate: TPlayObject;
var
  nX,nY:Integer;
begin
  Result:=nil;
  if GetFrontPosition(nX,nY) then begin
    Result:=m_PEnvir.GetMovingObject(nX,nY,True);
  end;
end;



procedure TPlayObject.ClientQueryBagItems; //004D0EDC
var
  I,II:Integer;
  Item:TItem;
  sSendMsg:String;
  ClientItem:TClientItem;
  StdItem:TStdItem;
  UserItem:PTUserItem;
begin
  sSendMsg:='';
  for I := 0 to _Min(m_ItemList.Count - 1,25) do begin
    UserItem:=m_ItemList.Items[i];
    Item:=UserEngine.GetStdItem(UserItem.wIndex);

    if Item <> nil then begin
      Item.GetStandardItem(ClientItem.S);
      Item.GetItemAddValue(UserItem,ClientItem.S);
      ClientItem.S.Name := GetItemName(UserItem);

      ClientItem.Dura:=UserItem.Dura;
      ClientItem.DuraMax:=UserItem.DuraMax;
      ClientItem.Amount:=UserItem.Amount;
      ClientItem.MakeIndex:=UserItem.MakeIndex;
      if StdItem.StdMode = 50 then begin
        ClientItem.S.Name:=ClientItem.S.Name + ' #' + IntToStr(UserItem.Dura);
      end;
      sSendMsg:=sSendMsg + EncodeBuffer(@ClientItem,SizeOf(TClientItem)) + '/';
    end;

  end;
  if sSendMsg <> '' then begin
    m_DefMsg:=MakeDefaultMsg(SM_BAGITEMS,Integer(Self),0,m_ItemList.Count,i);
    SendSocket(@m_DefMsg,sSendMsg);
  end;
{simple solution to sm_bagitems being to big}
  sSendMsg:='';
  for II := 26 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[II];
    Item:=UserEngine.GetStdItem(UserItem.wIndex);

    if Item <> nil then begin
      Item.GetStandardItem(ClientItem.S);
      Item.GetItemAddValue(UserItem,ClientItem.S);
      ClientItem.S.Name := GetItemName(UserItem);

      ClientItem.Dura:=UserItem.Dura;
      ClientItem.DuraMax:=UserItem.DuraMax;
      ClientItem.Amount:=UserItem.Amount;
      ClientItem.MakeIndex:=UserItem.MakeIndex;
      if StdItem.StdMode = 50 then begin
        ClientItem.S.Name:=ClientItem.S.Name + ' #' + IntToStr(UserItem.Dura);
      end;
      sSendMsg:=sSendMsg + EncodeBuffer(@ClientItem,SizeOf(TClientItem)) + '/';
    end;

  end;
  if sSendMsg <> '' then begin
    m_DefMsg:=MakeDefaultMsg(SM_BAGITEMS2,Integer(Self),0,m_ItemList.Count,II);
    SendSocket(@m_DefMsg,sSendMsg);
  end;
end;


procedure TPlayObject.ClientQueryStorageItems;
var
  I,II:Integer;
  Item:TItem;
  sSendMsg:String;
  ClientItem:TClientItem;
  StdItem:TStdItem;
  UserItem:PTUserItem;
begin
  sSendMsg:='';
  for I := 0 to _Min(m_StorageItemList.Count - 1,40) do begin
    UserItem:=m_StorageItemList.Items[i];
    Item:=UserEngine.GetStdItem(UserItem.wIndex);

    if Item <> nil then begin
      Item.GetStandardItem(ClientItem.S);
      Item.GetItemAddValue(UserItem,ClientItem.S);
      ClientItem.S.Name := GetItemName(UserItem);

      ClientItem.Dura:=UserItem.Dura;
      ClientItem.DuraMax:=UserItem.DuraMax;
      ClientItem.Amount:=UserItem.Amount;
      ClientItem.MakeIndex:=UserItem.MakeIndex;
      if StdItem.StdMode = 50 then begin
        ClientItem.S.Name:=ClientItem.S.Name + ' #' + IntToStr(UserItem.Dura);
      end;
      sSendMsg:=sSendMsg + EncodeBuffer(@ClientItem,SizeOf(TClientItem)) + '/';
    end;

  end;
  if sSendMsg <> '' then begin
    m_DefMsg:=MakeDefaultMsg(SM_STORAGEITEMS,Integer(Self),0,m_StorageItemList.Count,i);
    SendSocket(@m_DefMsg,sSendMsg);
  end;

  sSendMsg:='';
  for II := 41 to m_StorageItemList.Count - 1 do begin
    UserItem:=m_StorageItemList.Items[II];
    Item:=UserEngine.GetStdItem(UserItem.wIndex);

    if Item <> nil then begin
      Item.GetStandardItem(ClientItem.S);
      Item.GetItemAddValue(UserItem,ClientItem.S);
      ClientItem.S.Name := GetItemName(UserItem);

      ClientItem.Dura:=UserItem.Dura;
      ClientItem.DuraMax:=UserItem.DuraMax;
      ClientItem.Amount:=UserItem.Amount;
      ClientItem.MakeIndex:=UserItem.MakeIndex;
      if StdItem.StdMode = 50 then begin
        ClientItem.S.Name:=ClientItem.S.Name + ' #' + IntToStr(UserItem.Dura);
      end;
      sSendMsg:=sSendMsg + EncodeBuffer(@ClientItem,SizeOf(TClientItem)) + '/';
    end;

  end;
  if sSendMsg <> '' then begin
    m_DefMsg:=MakeDefaultMsg(SM_STORAGEITEMS2,Integer(Self),0,m_StorageItemList.Count,II);
    SendSocket(@m_DefMsg,sSendMsg);
  end;
end;

procedure TPlayObject.ClientQueryUserState(PlayObject:TPlayObject;nX,nY: Integer); //004DE654
var
  I: Integer;
  UserState:TUserStateInfo;
  StdItem:TItem;
  ClientItem:TClientItem;
  UserItem:pTUserItem;
begin
  if not CretInNearXY(PlayObject,nX,nY) then exit;
  FillChar(UserState,SizeOf(TUserStateInfo),#0);
  UserState.Feature:=PlayObject.GetFeature(Self);
  UserState.UserName:=PlayObject.m_sCharName;
  UserState.NameColor:=GetCharColor(PlayObject);
  if PlayObject.m_MyGuild <> nil then begin
    UserState.GuildName:=TGuild(PlayObject.m_MyGuild).sGuildName;
  end;
  UserState.GuildRankName:=PlayObject.m_sGuildRankName;

  if PlayObject.m_xLoveInfo.Lover <> '' then begin
   UserState.LoverName := PlayObject.m_xLoveInfo.Lover;
  end else begin
   UserState.LoverName := '';
  end;

  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    UserItem:=@PlayObject.m_UseItems[i];
    if UserItem.wIndex > 0 then begin
      StdItem:=UserEngine.GetStdItem(PlayObject.m_UseItems[i].wIndex);
      if StdItem = nil then Continue;
      StdItem.GetStandardItem(ClientItem.S);
      StdItem.GetItemAddValue(@PlayObject.m_UseItems[i],ClientItem.S);
      ClientItem.S.Name := GetItemName(@PlayObject.m_UseItems[i]);
      //heaven + mir ITEMS begin
        if ((ClientItem.S.Reserved and 16 <> 0) or (ClientItem.S.Reserved and 32 <> 0)) then
             ClientItem.S.Name := FilterShowName(ClientItem.S.Name);
        //heaven + mir end
      ClientItem.MakeIndex:=PlayObject.m_UseItems[i].MakeIndex;
      ClientItem.Dura:=PlayObject.m_UseItems[i].Dura;
      ClientItem.DuraMax:=PlayObject.m_UseItems[i].DuraMax;
      UserState.UseItems[I]:=ClientItem;
    end;
  end;
  m_DefMsg:=MakeDefaultMsg(SM_SENDUSERSTATE,0,0,0,0);
  SendSocket(@m_DefMsg,EncodeBuffer(@UserState,SizeOf(TUserStateInfo)));
end;

procedure TPlayObject.ClientMerchantDlgSelect(nParam1: Integer; sMsg: String); //004DBAA4
var
  Npc:TNormNpc;
  i:integer;
begin
  if m_boDeath or m_boGhost then exit;

  Npc:=UserEngine.FindMerchant(TObject(nParam1));
  if Npc = nil then Npc:=UserEngine.FindNPC(TObject(nParam1));
  if Npc = nil then exit;

  if ((Npc.m_PEnvir = m_PEnvir) and
     (abs(Npc.m_nCurrX - m_nCurrX) < 15) and
     (abs(Npc.m_nCurrY - m_nCurrY) < 15)) or (Npc.m_boIsHide) then begin
    Npc.UserSelect(Self, sMsg);
    //Below code breaks certain scripts e.g guild creation!
    {for I := 0 to m_CanJmpScriptLableList.Count - 1 do begin
    if (Trim(sMsg) = '@main') or (CompareText(Trim(sMsg),m_CanJmpScriptLableList.Strings[I]) = 0) then begin
      Npc.UserSelect(Self,Trim(sMsg));
      break;
    end;
    end;}
  end;
end;

procedure TPlayObject.GemInfo(nParam1: Integer; sMsg: String); //004DBAA4
var
  Npc:TNormNpc;
begin
  if m_boDeath or m_boGhost then exit;

  Npc:=UserEngine.FindMerchant(TObject(nParam1));
  if Npc = nil then Npc:=UserEngine.FindNPC(TObject(nParam1));
  if Npc = nil then exit;
  if ((Npc.m_PEnvir = m_PEnvir) and
     (abs(Npc.m_nCurrX - m_nCurrX) < 15) and
     (abs(Npc.m_nCurrY - m_nCurrY) < 15)) or (Npc.m_boIsHide) then
    Npc.GotoLable(Self,DecodeString(Trim(sMsg)),False);
end;

procedure TPlayObject.ClientMerchantQuerySellPrice(nParam1, nMakeIndex: Integer;
  sMsg: String;nAmount:Integer);//004DBB7C
var
  I: Integer;
  UserItem:pTUserItem;
  UserItem18:pTUserItem;
  Merchant:TMerchant;
  sUserItemName:String;
begin
  UserItem18:=nil;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[i];
    if UserItem.MakeIndex = nMakeIndex then begin
      //取自定义物品名称
      sUserItemName:=GetItemName(UserItem);

      if CompareText(sUserItemName,sMsg) = 0 then begin
        UserItem18:=UserItem;
        break;
      end;
    end;
  end;    // for
  if UserItem18 = nil then exit;
  Merchant:=UserEngine.FindMerchant(TObject(nParam1));
  if Merchant = nil then exit;
  if ((Merchant.m_PEnvir = m_PEnvir) and
     (Merchant.m_boSell) and
     (abs(Merchant.m_nCurrX - m_nCurrX) < 15) and
     (abs(Merchant.m_nCurrY - m_nCurrY) < 15)) then
    Merchant.ClientQuerySellPrice(Self,UserItem18,nAmount);

end;

procedure TPlayObject.ClientUserSellItem(nParam1, nMakeIndex: Integer; sMsg: String; nAmount:Integer); //004DBE1C
var
  I: Integer;
  UserItem:pTUserItem;
  Merchant:TMerchant;
  sUserItemName:String;
begin
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[i];
    if (UserItem <> nil) and (UserItem.MakeIndex = nMakeIndex) then begin
        //取自定义物品名称
      sUserItemName:=GetItemName(UserItem);

      if CompareText(sUserItemName,sMsg) = 0 then begin
        Merchant:=UserEngine.FindMerchant(TObject(nParam1));
        if (Merchant <> nil) and
           (Merchant.m_boSell) and
           ((Merchant.m_PEnvir = m_PEnvir) and
           (abs(Merchant.m_nCurrX - m_nCurrX) < 15) and
           (abs(Merchant.m_nCurrY - m_nCurrY) < 15)) then begin
          if Merchant.ClientSellItem(Self,UserItem, nAmount) then begin
            if UserItem.btValue[13] = 1 then begin
              ItemUnit.DelCustomItemName(UserItem.MakeIndex,UserItem.wIndex);
              UserItem.btValue[13]:=0;
            end;
            if (UserEngine.GetStdItem(UserItem.wIndex).StdMode = 45) and (UserItem.Amount > nAmount) then begin
              dec(UserItem.Amount,nAmount);
              WeightChanged();
            end else begin
              Dispose(UserItem); //物品加到NPC物品列表中了
              m_ItemList.Delete(I);
            end;
            WeightChanged();
          end;
        end;
        break;
      end;
    end;
  end;    // for
end;

procedure TPlayObject.ClientUserBuyItem(nIdent, nParam1, nInt, nZz: Integer; sMsg: String);//004DCA10
var
  Merchant:TMerchant;
begin
try
  if m_boDealing then exit;
  Merchant:=UserEngine.FindMerchant(TObject(nParam1));
  if (Merchant = nil) or
     (not Merchant.m_bobuy) or
     (Merchant.m_PEnvir <> m_PEnvir) or
     (abs(Merchant.m_nCurrX - m_nCurrX) > 15) or
     (abs(Merchant.m_nCurrY - m_nCurrY) > 15) then exit;

  if nIdent = CM_USERBUYITEM then begin
    Merchant.ClientBuyItem(Self,sMsg,nInt);
  end;
  if nIdent = CM_USERGETDETAILITEM then begin
    Merchant.ClientGetDetailGoodsList(Self,sMsg,nZz);
  end;
except
  on e: Exception do begin
    MainOutMessage('TUserHumah.ClientUserBuyItem wIdent = ' + IntToStr(nIdent));
    MainOutMessage(E.Message);
  end;
end;
end;

function TPlayObject.ClientDropGold(nGold: Integer):Boolean;//004C5BB0
begin
  Result:=False;
  if g_Config.boInSafeDisableDrop and InSafeZone then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sCanotDropInSafeZoneMsg);
    exit;
  end;
  
  if g_Config.boControlDropItem and (nGold < g_Config.nCanDropGold) then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sCanotDropGoldMsg);
    exit;
  end;
    
  if not m_boCanDrop or m_PEnvir.Flag.boNOTHROWITEM then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sCanotDropItemMsg);
    exit;
  end;
  if nGold >= m_nGold then exit;
  Dec(m_nGold,nGold);
  if not DropGoldDown(nGold,False,nil,Self) then Inc(m_nGold,nGold);
  GoldChanged();
  Result:=True;
end;
function TPlayObject.ClientDropItem(sItemName: String;//004C5A2C
  nItemIdx: Integer;nAmount:Integer): Boolean;
var
  I,II: Integer;
  UserItem:pTUserItem;
  StdItem:TItem;
  sUserItemName:String;
  nOAmount:Integer;
  nDateNow:DWord;
  Decoration:pTDecoItem;
  Appr:integer;
begin
  Result:=False;
  if g_Config.boInSafeDisableDrop and InSafeZone then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sCanotDropInSafeZoneMsg);
    exit;
  end;
  
  if not m_boCanDrop or m_PEnvir.Flag.boNOTHROWITEM then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sCanotDropItemMsg);
    exit;
  end;


  if Pos(' ',sItemName) > 0 then begin //折分物品名称(信件物品的名称后面加了使用次数)
    GetValidStr3(sItemName,sItemName,[' ']);
  end;
  if (GetTickCount - m_DealLastTick) > 3000 then begin
    for I := 0 to m_ItemList.Count - 1 do begin
      UserItem:=m_ItemList.Items[i];
      if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
        StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem = nil then Continue;
        //取自定义物品名称
        sUserItemName:=GetItemName(UserItem);

        if CompareText(sUserItemName,sItemName)= 0 then begin
         if not StdItem.boCanDrop then begin //Vexusdev
         Result := FALSE;
         exit;
         end;
          if g_Config.boControlDropItem and (StdItem.Price < g_Config.nCanDropPrice)then begin

            if stditem.StdMode = 45 then begin
              if UserItem.Amount > nAmount then begin
                dec(UserItem.Amount,nAmount);
                WeightChanged();
                result:=True;
                break;
              end;
            end;
            Dispose(UserItem);
            m_ItemList.Delete(i);
            Result:=True;
            break;
          end;
          if stdItem.StdMode = 45 then begin//stacked items
            if UserItem.Amount > nAmount then begin
              nOAmount:=UserItem.Amount;
              UserItem.Amount:=nAmount;
              if DropItemDown(UserItem,1,False,nil,Self) then begin
                Result:=True;
              end;
              UserItem.Amount:=nOAmount - nAmount;
              break;
            end;
          end;
          if stdItem.StdMode = 48 then begin //decoration in gt
            if m_MyGuild = nil then begin
              Result:=False;
              break;
            end;
            if UserItem.btValue[0] = TTerritory(TGuild(m_MyGuild).m_Territory).TerritoryNumber then begin
              nDateNow:=DateTimeToUnix(now());
              UserItem.btValue[1]:=loByte(loWord(nDateNow));
              UserItem.btValue[2]:=hiByte(loWord(nDateNow));
              UserItem.btValue[3]:=loByte(hiWord(nDateNow));
              UserItem.btValue[4]:=hiByte(hiWord(nDateNow));
              if TTerritory(TGuild(m_MyGuild).m_Territory).DecoCount(m_PEnvir) > 50 then begin
                SysMsg('You cannot have more then 50 decorations on one map',c_Red,t_Hint);
                break;
              end;
              Appr:=MakeWord(UserItem.btValue[5],UserItem.btValue[6]);
              Decoration:=nil;
              if pTDecoItem(g_DecorationList[Appr]).Appr = Appr then begin
                Decoration:=pTDecoItem(g_DecorationList[Appr]);
              end else begin
                for II:=0 to g_DecorationList.Count -1 do begin
                  if pTDecoItem(g_DecorationList[II]).Appr = Appr then begin
                    Decoration:=pTDecoItem(g_DecorationList[II]);
                    break;
                  end;
                end;
              end;
              if Decoration=nil then begin
                SysMsg('Decoration not found',c_Red,t_Hint);
                break;
              end;
              if (Decoration.Location = 0) and (m_PEnvir.sMapName <> g_Config.sGTHomeMap) then begin
                SysMsg('This Decoration can only be used outside',c_Red,t_Hint);
                break;
              end;
              if (Decoration.Location = 1) and (m_PEnvir.sMapName = g_Config.sGTHomeMap) then begin
                SysMsg('This Decoration can only be used inside',c_Red,t_Hint);
                break;
              end;
              if DropItemDown(UserItem,1,False,nil,Self) then begin
                Dispose(UserItem);
                m_ItemList.Delete(i);
                Result:=True;
                break;
              end;
            end;
            break;
          end;//end gt decoration

          if DropItemDown(UserItem,1,False,nil,Self) then begin
            Dispose(UserItem);
            m_ItemList.Delete(i);
            Result:=True;
            break;
          end;
        end; //004C5B53
      end;
    end;
    if Result then WeightChanged();
  end;
end;

procedure TPlayObject.GoldChange(sChrName: String; nGold: Integer);//004CD844
var
  s10,s14:String;
begin
  if nGold > 0 then begin
    s10:='14';
    s14:='Added';
  end else begin
    s10:='13';
    s14:='Decreased';
  end;
  SysMsg(sChrName + ' Gold ' + IntToStr(nGold) +' has ' + s14,c_Green,t_Hint) ;
            //004CD97C
          if g_boGameLogGold then
            AddGameDataLog (s10 + #9 +
                        m_sMapName + #9 +
                        IntToStr(m_nCurrX) + #9 +
                        IntToStr(m_nCurrY) + #9 +
                        m_sCharName + #9 +
                        sSTRING_GOLDNAME + #9 +
                        IntToStr(nGold) + #9 +
                        '1' + #9 +
                        sChrName);
end;



//004D6758

//004C9C08
procedure TPlayObject.ClearStatusTime;
begin
  FillChar(m_wStatusTimeArr,SizeOf(TStatusTime),#0);
end;

procedure TPlayObject.SendMapDescription;
var
  nMUSICID:Integer;
begin
  nMUSICID:=-1;
  if m_PEnvir.Flag.boMUSIC then nMUSICID:=m_PEnvir.Flag.nMUSICID;
    
  SendDefMessage(SM_MAPDESCRIPTION,nMUSICID,m_PEnvir.nMinMap,m_PEnvir.nBigMap,0,m_PEnvir.sMapDesc);
end;

procedure TPlayObject.SendNotice;//004DA490
var
  LoadList:TStringList;
  i:integer;
  sNoticeMsg:String;
begin
  LoadList:=TStringList.Create;
  NoticeManager.GetNoticeMsg('Notice',LoadList);
  sNoticeMsg:='';
  for I := 0 to LoadList.Count - 1 do begin
    sNoticeMsg:=sNoticeMsg + LoadList.Strings[i] + #$20#$1B;
  end;
  LoadList.Free;
//  SendDefMessage(SM_SENDNOTICE,0,0,0,0,sNoticeMsg);
  SendDefMessage(SM_SENDNOTICE,2000,0,0,0,sNoticeMsg);
end;

procedure TPlayObject.UserLogon;//004C9C24
var
  I          :Integer;
  II         :Integer;
  UserItem   :PTUserItem;
  UserItem1  :PTUserItem;
  StdItem    :TItem;
  s14        :String;
  sItem      :String;
  sIPaddr    :String;
//  sAttatckMsg:Byte;
  Lover      :TPlayObject;
  PlayObject: TPlayObject;
ResourceString
  sExceptionMsg    = '[Exception] TPlayObject::UserLogon';
  sCheckIPaddrFail = 'GM IP validation failed...';
begin
  sIPaddr    := '127.0.0.1';
try
  if g_Config.boTestServer then begin
    if m_Abil.Level < g_Config.nTestLevel then m_Abil.Level:=g_Config.nTestLevel;
    if m_nGold < g_Config.nTestGold then m_nGold:=g_Config.nTestGold;
  end;//004C9C99
  if g_Config.boTestServer or (g_Config.boServiceMode) then m_nPayMent:=3;
  m_dwMapMoveTick:=GetTickCount();
  m_dLogonTime:=Now();
  m_dwLogonTick:=GetTickCount();
  Initialize(); //004C9CE8 
  SendMsg(Self,RM_LOGON,0,0,0,0,'');
  if m_Abil.Level <= 7 then begin
    if GetRangeHumanCount >= 80 then begin
      MapRandomMove(m_PEnvir.sMapName,0);
    end;
  end;//004C9D32
  if m_boDieInFight3Zone then begin
    MapRandomMove(m_PEnvir.sMapName,0);
  end;

  UserEngine.GetHumPermission(m_sCharName,sIPaddr,m_btPermission);

  {  if not CompareIPaddr(m_sIPaddr,sIPaddr) then begin
      SysMsg(sCheckIPaddrFail,c_Red,t_Hint);
      m_boEmergencyClose:=True;
    end;}

  GetHomePoint();

  for i:=0 to m_MagicList.Count -1 do begin
    CheckMagicSpecialAbility(pTUserMagic(m_MagicList.Items[i]));
  end;

  if m_boNewHuman then begin
    New(UserItem);
    if UserEngine.CopyToUserItemFromName(g_Config.sCandle,UserItem) then begin
      m_ItemList.Add(UserItem);
    end else Dispose(UserItem);
    New(UserItem);
    if UserEngine.CopyToUserItemFromName(g_Config.sBasicDrug,UserItem) then begin
      m_ItemList.Add(UserItem);
    end else Dispose(UserItem);
    New(UserItem);
    if UserEngine.CopyToUserItemFromName(g_Config.sWoodenSword,UserItem) then begin
      m_ItemList.Add(UserItem);
    end else Dispose(UserItem);

    New(UserItem);
    if m_btGender = gMan then
      sItem:=g_Config.sClothsMan
    else
      sItem:=g_Config.sClothsWoman;

    if UserEngine.CopyToUserItemFromName(sItem,UserItem) then begin
      m_ItemList.Add(UserItem);
    end else Dispose(UserItem);
  end;//004C9F44

  //检查背包中的物品是否合法

  for I := m_ItemList.Count - 1  downto 0 do begin
    UserItem:=m_ItemList.Items[I];
    if UserEngine.GetStdItemName(UserItem.wIndex) = '' then begin
      Dispose(PTUserItem(m_ItemList.Items[I]));
      m_ItemList.Delete(I);
    end;
  end;
  //004C9FB8



  //004C9FBD
  //检查人物身上的物品是否符合使用规则
  if g_Config.boCheckUserItemPlace then begin
    for I:=Low(THumanUseItems) to High(THumanUseItems) do begin
      if m_UseItems[I].wIndex > 0 then begin
        StdItem:=UserEngine.GetStdItem(m_UseItems[I].wIndex);
        if StdItem <> nil then begin
          if not CheckUserItems(I,StdItem) then begin
            New(UserItem);
            UserItem^:=m_UseItems[I];
            if not AddItemToBag(UserItem) then begin
              m_ItemList.Insert(0,UserItem);
            end;
            m_UseItems[I].wIndex:=0;
          end;
        end else m_UseItems[I].wIndex:=0;
      end;
    end;//004CA06D
  end;

  //检查背包中是否有复制品
  for I := m_ItemList.Count - 1 downto 0 do begin
    UserItem:=m_ItemList.Items[I];
    s14:=UserEngine.GetStdItemName(UserItem.wIndex);
    for ii:=I -1 downto 0 do begin
      UserItem1:=m_ItemList.Items[ii];
      if (UserEngine.GetStdItemName(UserItem1.wIndex) = s14) and
         (UserItem.MakeIndex = UserItem1.MakeIndex) then begin
        m_ItemList.Delete(ii);
        break;
      end;
    end;
  end;

  //004CA149
  for i:=Low(m_dwStatusArrTick) to High(m_dwStatusArrTick) do begin
    if m_wStatusTimeArr[i] > 0 then
      m_dwStatusArrTick[i]:=GetTickCount();
  end;
  //004CA177
  m_nCharStatus:=GetCharStatus();
  RecalcLevelAbilitys();
  RecalcAbilitys();
  m_Abil.MaxExp:=GetLevelExp(m_Abil.Level);
  if btB2 = 0 then begin
    m_nPkPoint:=0;
    Inc(btB2);
  end;
  if (m_nGold > g_Config.nHumanMaxGold * 2) and (g_Config.nHumanMaxGold > 0) then m_nGold:=g_Config.nHumanMaxGold * 2;

  if not bo6AB then begin
    if (m_nSoftVersionDate < g_Config.nSoftVersionDate) then begin
      SysMsg(sClientSoftVersionError,c_Red,t_Hint);
      SysMsg(sDownLoadNewClientSoft,c_Red,t_Hint);
      SysMsg(sForceDisConnect,c_Red,t_Hint);
      m_boEmergencyClose:=True;
      exit;
    end;
    if (m_nSoftVersionDateEx = 0) and g_Config.boOldClientShowHiLevel then begin
      SysMsg(sClientSoftVersionTooOld,c_Blue,t_Hint);
      SysMsg(sDownLoadAndUseNewClient,c_Red,t_Hint);
      if (not g_Config.boCanOldClientLogon) then begin
        SysMsg(sClientSoftVersionError,c_Red,t_Hint);
        SysMsg(sDownLoadNewClientSoft,c_Red,t_Hint);
        SysMsg(sForceDisConnect,c_Red,t_Hint);
        m_boEmergencyClose:=True;
        exit;
      end;
        
    end;
      
    case m_btAttatckMode of
      HAM_ALL:   SysMsg(sAttackModeOfAll,c_Green,t_Hint);
      HAM_PEACE: SysMsg(sAttackModeOfPeaceful,c_Green,t_Hint);
      HAM_DEAR:  SysMsg(sAttackModeOfDear,c_Green,t_Hint);
      HAM_MASTER:SysMsg(sAttackModeOfMaster,c_Green,t_Hint);
      HAM_GROUP: SysMsg(sAttackModeOfGroup,c_Green,t_Hint);
      HAM_GUILD: SysMsg(sAttackModeOfGuild,c_Green,t_Hint);
      HAM_PKATTACK: SysMsg(sAttackModeOfRedWhite,c_Green,t_Hint);
    end;

    //PlayObject.SendMsg (PlayObject,RM_ATTATCKMODE,0,0,0,0,'');

    SysMsg(sStartChangeAttackModeHelp,c_Green,t_Hint);
    SysMsg('本程序为测试服务器端，请勿用作商业用途。',c_Red,t_Hint);//广告
    SysMsg('版权所有中国Lom2开发联盟www.lom2.net 。',c_Red,t_Hint);
    if g_Config.boTestServer then
      SysMsg(sStartNoticeMsg,c_Green,t_Hint); 
    if UserEngine.PlayObjectCount > 10{g_Config.nTestUserLimit} then begin //人数限制
      FrmMain.GateSocket.Active:=False;//关闭通讯
      if m_btPermission < 2 then begin
        SysMsg(sOnlineUserFull,c_Red,t_Hint);
        SysMsg(sForceDisConnect,c_Red,t_Hint);
        m_boEmergencyClose:=True;
      end;
    end;

//004CA344

  end;
  m_btBright:=g_nGameTime;
  m_Abil.MaxExp:=GetLevelExp(m_Abil.Level); //jacky 2004/09/15 登录重新取得升级所需经验值

  SendMsg(Self,RM_ABILITY,0,0,0,0,'');
  SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
  SendMsg(Self,RM_ADJUST_BONUS,0,0,0,0,'');
  SendMsg(Self,RM_DAYCHANGING,0,0,0,0,'');
  SendMsg(Self,RM_SENDUSEITEMS,0,0,0,0,'');
  SendMsg(Self,RM_SENDMYMAGIC,0,0,0,0,'');
  Self.ClientFriendChangeState(True);
  Self.ClientSendFriendsList;
//  FeatureChanged(); 
  m_MyGuild:=g_GuildManager.MemberOfGuild(m_sCharName);
  if m_MyGuild <> nil then begin
    m_sGuildRankName:=TGuild(m_MyGuild).GetRankName(Self,m_nGuildRankNo);
    for I := 0 to TGuild(m_MyGuild).GuildWarList.Count - 1 do begin
      SysMsg(TGuild(m_MyGuild).GuildWarList.Strings[i] +  ' is on guild war with your guild.',c_Green,t_Hint);
    end;
    //send guild member has connected
    TGuild(m_MyGuild).SendGuildMsg(m_sCharName + ' has connected.');
    UserEngine.SendServerGroupMsg(SS_208,nServerIndex,TGuild(m_MyGuild).sGuildName + '/' + '' + '/' + m_sCharName + ' has connected.');
    if TGuild(m_MyGuild).m_Territory <> nil then
      SysMsg(TTerritory(TGuild(m_MyGuild).m_Territory).UserLogon(),c_Green,t_Hint);
  end;

  if m_xLoveInfo.Lover <> '' then begin
    Lover:=UserEngine.GetPlayObject(m_xLoveInfo.Lover);
    if Lover <> nil then
      Lover.SysMsg(m_sCharName + ' has connected in ' + m_PEnvir.sMapDesc,c_Blue,t_hint);
  end;

  RefShowName();
  if (m_nPayMent = 1) then begin
    if not bo6AB then  SysMsg(sYouNowIsTryPlayMode,c_Red,t_Hint);
//    m_nGoldMax:=100000;
    m_nGoldMax:=g_Config.nHumanTryModeMaxGold;
    if m_Abil.Level > g_Config.nTryModeLevel then begin
      SysMsg('The trial mode can be used up to level ' + IntToStr(g_Config.nTryModeLevel),c_Red,t_Hint);
      SysMsg('connection was terminated.',c_Red,t_Hint);
      m_boEmergencyClose:=True;
    end;
  end;//004CA4FA
  if (m_nPayMent = 3) and not bo6AB then
    SysMsg(g_sNowIsFreePlayMode,c_Green,t_Hint);

  if g_Config.boVentureServer then
    SysMsg('Welcome to adventure server.',c_Green,t_Hint);
  if (m_MagicErgumSkill <> nil) and (not m_boUseThrusting)then begin
    m_boUseThrusting:=True;
    SendSocket(nil,'+LNG');
  end;
  if m_PEnvir.Flag.boNORECONNECT then
    MapRandomMove(m_PEnvir.Flag.sNoReconnectMap,0);

  if CheckDenyLogon() then exit;

  if g_ManageNPC <> nil then begin
    g_ManageNPC.GotoLable(Self,'@Login',False);
  end;

  m_boFixedHideMode:=False;


  if m_sDearName <> '' then
    CheckMarry();

  CheckMaster();


  m_boFilterSendMsg:=GetDisableSendMsgList(m_sCharName);

  if g_Config.boPasswordLockSystem then begin
    if m_boPasswordLocked then begin
      m_boCanGetBackItem:=not g_Config.boLockGetBackItemAction;
    end;

    if g_Config.boLockHumanLogin and m_boLockLogon and m_boPasswordLocked then begin
      m_boCanDeal    :=not g_Config.boLockDealAction;
      m_boCanDrop    :=not g_Config.boLockDropAction;
      m_boCanUseItem :=not g_Config.boLockUserItemAction;
      m_boCanWalk    :=not g_Config.boLockWalkAction;
      m_boCanRun     :=not g_Config.boLockRunAction;
      m_boCanHit     :=not g_Config.boLockHitAction;
      m_boCanSpell   :=not g_Config.boLockSpellAction;
      m_boCanSendMsg :=not g_Config.boLockSendMsgAction;
      m_boObMode     :=g_Config.boLockInObModeAction;
      m_boAdminMode  :=g_Config.boLockInObModeAction;

      SysMsg(g_sActionIsLockedMsg + ' Connected with limited ability''s use: @' + g_GameCommand.LOCKLOGON.sCmd ,c_Red,t_Hint);
      SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sActionIsLockedMsg + '\ \'
                      + 'Password required use: @' + g_GameCommand.PASSWORDLOCK.sCmd);
    end;
    if not m_boPasswordLocked then begin
      SysMsg(format(g_sPasswordNotSetMsg,[g_GameCommand.PASSWORDLOCK.sCmd]) ,c_Red,t_Hint);
    end;
    if not m_boLockLogon and m_boPasswordLocked then begin
      SysMsg(format(g_sNotPasswordProtectMode,[g_GameCommand.LOCKLOGON.sCmd]) ,c_Red,t_Hint);
    end;
  end;


  {if g_nM2Crc <> nM2Crc then begin
    m_boEmergencyClose:=True;
  end;}
    
  {if UserEngine.PlayObjectCount > g_nMaxUserCount then begin
    if m_btPermission < 10 then begin
      SysMsg(sOnlineUserFull,c_Red,t_Hint);
      SysMsg(sForceDisConnect,c_Red,t_Hint);
      m_boEmergencyClose:=True;
    end;
  end;}
  //
  m_dwIncGamePointTick := GetTickCount();
  m_dwIncGameGoldTick  := GetTickCount();
  m_dwAutoGetExpTick   := GetTickCount();
except
  on e: Exception do begin
    MainOutMessage(sExceptionMsg);
    MainOutMessage(E.Message);
  end;
end;
  //ReadAllBook();
end;


procedure TPlayObject.SendWhisperMsg(PlayObject: TPlayObject);
{var
  sMsg:String;
  StartPoint:pTStartPoint;}
begin
  if (PlayObject = Self) then exit;
  if (PlayObject.m_btPermission >= 9) or (m_btPermission >= 9) then exit;
  if UserEngine.PlayObjectCount < g_Config.nSendWhisperPlayCount + Random(5) then exit;

  (*if GetStartPoint(StartPoint) then begin
    if GetTickCount - StartPoint.dwWhisperTick < g_Config.dwSendWhisperTime{5 * 60 * 1000} then exit;
    StartPoint.dwWhisperTick:=GetTickCount();
  end else begin
    if GetTickCount - m_PEnvir.m_dwWhisperTick < g_Config.dwSendWhisperTime{5 * 60 * 1000} then exit;
    m_PEnvir.m_dwWhisperTick:=GetTickCount();
  end;

  if g_SayMsgList.Count <= 0 then exit;
  Inc(g_nSayMsgIdx);
  if g_SayMsgList.Count <= g_nSayMsgIdx then g_nSayMsgIdx:=0;
  sMsg:=g_SayMsgList.Strings[g_nSayMsgIdx];

  case Random(2) of
    0: begin
      Whisper(PlayObject.m_sCharName,sMsg);
    end;
    1: begin
      SendRefMsg(RM_HEAR,1,g_Config.btHearMsgFColor,g_Config.btHearMsgBColor,0, m_sCharName + ':' + sMsg);
    end;
  end;*)
end;


procedure TPlayObject.ReadAllBook();
var
  I: Integer;
  Magic:pTMagic;
  UserMagic:pTUserMagic;
begin
  for I := 0 to UserEngine.m_MagicList.Count - 1 do begin
    Magic:=UserEngine.m_MagicList.Items[I];
    New(UserMagic);
    UserMagic.MagicInfo := Magic;
    UserMagic.wMagIdx   := Magic.wMagicId;
    UserMagic.btLevel   := 2;
    UserMagic.btKey     := 0;
    UserMagic.btLevel   := 0;
    UserMagic.nTranPoint:=100000;
    m_MagicList.Add(UserMagic);
    SendAddMagic(UserMagic);
  end;
end;

procedure TPlayObject.SendGoldInfo(boSendName:Boolean);
var
  sMsg:String;
begin
  if m_nSoftVersionDateEx = 0 then exit;

  if boSendName then
    sMsg:=g_Config.sGameGoldName + #13 + g_Config.sGamePointName;

  SendDefMessage(SM_GAMEGOLDNAME,
                 m_nGameGold,
                 LoWord(m_nGamePoint),
                 HiWord(m_nGamePoint),
                 0,
                 sMsg);

end;

procedure TPlayObject.SendLogon; //004D677C
var
  MessageBodyWL:TMessageBodyWL;
  nRecog:Integer;
begin
  m_DefMsg:=MakeDefaultMsg(SM_LOGON,Integer(Self),m_nCurrX,m_nCurrY,MakeWord(m_btDirection,m_nLight));
  MessageBodyWL.lParam1:=GetFeatureToLong();
  MessageBodyWL.lParam2:=m_nCharStatus;
  if m_boAllowGroup then MessageBodyWL.lTag1:=MakeLong(MakeWord(1,0),GetFeatureEx)
  else MessageBodyWL.lTag1:=0;
  MessageBodyWL.lTag2:=0;
  SendSocket(@m_DefMsg,EncodeBuffer(@MessageBodyWL,SizeOf(TMessageBodyWL)));

  nRecog:=GetFeatureToLong();
  SendDefMessage(SM_FEATURECHANGED,
                             Integer(Self),
                             LoWord(nRecog),
                             HiWord(nRecog),
                             GetFeatureEx,
                             '');
  if m_xLoveInfo.Lover <> '' then SendDefMessage(SM_LOVERNAME,0,0,0,0,m_xLoveInfo.Lover);
end;

procedure TPlayObject.SendServerConfig;
var
  nRecog,nParam:Integer;
  nRunHuman,nRunMon,nRunNpc,nWarRunAll:Integer;
  ClientConf:TClientConf;
  sMsg:String;
begin
  if m_nSoftVersionDateEx = 0 then exit;
    
  nRunHuman:=0;
  nRunMon:=0;
  nRunNpc:=0;
  nWarRunAll:=0;

  if g_Config.boDiableHumanRun or ((m_btPermission > 9) and g_Config.boGMRunAll) then begin
    nRunHuman:=1;
    nRunMon:=1;
    nRunNpc:=1;
    nWarRunAll:=1;
  end else begin
    if g_Config.boRunHuman or m_PEnvir.Flag.boRUNHUMAN then nRunHuman:=1;
    if g_Config.boRunMon or m_PEnvir.Flag.boRUNMON then nRunMon:=1;
    if g_Config.boRunNpc then nRunNpc:=1;
    if g_Config.boWarDisHumRun then nWarRunAll:=1;

  end;
  ClientConf:=g_Config.ClientConf;
  
  ClientConf.boRunHuman:=nRunHuman = 1;
  ClientConf.boRunMon:=nRunMon = 1;
  ClientConf.boRunNpc:=nRunNpc = 1;
  ClientConf.boWarRunAll:=nWarRunAll = 1;
  ClientConf.wSpellTime:=g_Config.dwMagicHitIntervalTime + 300;
  ClientConf.wHitIime:=g_Config.dwHitIntervalTime + 500;

  sMsg:=EncodeBuffer(@ClientConf,SizeOf(ClientConf));
  nRecog:=MakeLong(MakeWord(nRunHuman,nRunMon),MakeWord(nRunNpc,nWarRunAll));
  nParam:=MakeWord(5,0);
  SendDefMessage(SM_SERVERCONFIG,nRecog,nParam,0,0,sMsg);
end;

procedure TPlayObject.SendServerStatus;
begin
  if m_btPermission < 10 then exit;
  SysMsg(IntToStr(CalcFileCRC(Application.ExeName)),c_Red,t_Hint);
end;

function TPlayObject.CretInNearXY(TargeTBaseObject:TBaseObject; nX,
  nY: Integer): Boolean; //004C36CC
var
  I: Integer;
  nCX,nCY:Integer;
  MapCellInfo:pTMapCellinfo;
  OSObject:pTOSObject;
  BaseObject:TBaseObject;
begin
  Result:=False;
  if m_PEnvir = nil then begin
    MainOutMessage('CretInNearXY nil PEnvir');
    exit;
  end;

    for nCX:= nX -1 to nX + 1 do begin
      for nCY:= nY -1 to nY + 1  do begin
        if m_PEnvir.GetMapCellInfo(nCX,nCY,MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject:=MapCellInfo.ObjList.Items[i];
            if OSObject.btType = OS_MOVINGOBJECT then begin
              BaseObject:=TBaseObject(OSObject.CellObj);
              if BaseObject <> nil then begin
                if not BaseObject.m_boGhost and (BaseObject = TargeTBaseObject) then begin
                  Result:=True;
                  exit;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
end;

//004D112C
procedure TPlayObject.SendUseitems;
var
  i:Integer;
  Item:TItem;
  sSendMsg:String;
  ClientItem:TClientItem;
begin
  sSendMsg:='';
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    if m_UseItems[i].wIndex > 0 then begin
      Item:=UserEngine.GetStdItem(m_UseItems[i].wIndex);
      if Item <> nil then begin
        Item.GetStandardItem(ClientItem.S);
        Item.GetItemAddValue(@m_UseItems[i],ClientItem.S);
        ClientItem.S.Name := GetItemName(@m_UseItems[i]);
        //heaven + mir ITEMS begin
        if ((ClientItem.S.Reserved and 16 <> 0) or (ClientItem.S.Reserved and 32 <> 0)) then
             ClientItem.S.Name := FilterShowName(ClientItem.S.Name);
        //heaven + mir end
        ClientItem.Dura:=m_UseItems[i].Dura;
        ClientItem.DuraMax:=m_UseItems[i].DuraMax;
        ClientItem.MakeIndex:=m_UseItems[i].MakeIndex;
        sSendMsg:=sSendMsg + IntToStr(i) + '/' + EncodeBuffer(@ClientItem,SizeOf(TClientItem)) + '/';
      end;
    end;
  end;
  if sSendMsg <> '' then begin
    m_DefMsg:=MakeDefaultMsg(SM_SENDUSEITEMS,0,0,0,0);
    SendSocket(@m_DefMsg,sSendMsg);
  end;
end;

procedure TPlayObject.SendUseMagic;//004D1418
var
  I           :Integer;
  sSendMsg    :String;
  UserMagic   :pTUserMagic;
  ClientMagic :TClientMagic;
begin
  sSendMsg:='';
  for I :=0 to m_MagicList.Count -1 do begin
    UserMagic:=m_MagicList.Items[I];
    ClientMagic.Key      := Chr(UserMagic.btKey);
    ClientMagic.Level    := UserMagic.btLevel;
    ClientMagic.CurTrain := UserMagic.nTranPoint;
    ClientMagic.Def      := UserMagic.MagicInfo^;
    sSendMsg:=sSendMsg + EncodeBuffer(@ClientMagic,SizeOf(TClientMagic)) + '/';
  end;
  if sSendMsg <> '' then begin
    m_DefMsg:=MakeDefaultMsg(SM_SENDMYMAGIC,0,0,0,m_MagicList.Count);
    SendSocket(@m_DefMsg,sSendMsg);
  end;
end;

function TPlayObject.ClientChangeDir(wIdent:Word;nX, nY, nDir: Integer;var dwDelayTime:LongWord): Boolean;//4CAEB8
var
  dwCheckTime:LongWord;
begin
  Result:=False;
  if m_boDeath or (m_wStatusTimeArr[POISON_STONE{5}]{0x6A} <> 0) then exit;//防麻
  if not CheckActionStatus(wIdent,dwDelayTime) then begin
    m_boFilterAction:=False;
    exit;
  end;
  m_boFilterAction:=True;
  dwCheckTime:=GetTickCount - m_dwTurnTick;
  if dwCheckTime < g_Config.dwTurnIntervalTime then begin
    dwDelayTime:=g_Config.dwTurnIntervalTime - dwCheckTime;
    {
    if dwCheckTime <= g_Config.dwTurnIntervalTime div 2 then begin
      SysMsg('ClientChangeDir ' + IntToStr(dwCheckTime);
      m_boEmergencyClose:=True;
      Result:=True;
    end;
    }
    exit;
  end;

  if (nX = m_nCurrX) and (nY = m_nCurrY) then begin
    m_btDirection:=nDir;
    if Walk(RM_TURN) then begin
      m_dwTurnTick:=GetTickCount();
      Result:=True;
    end;
  end;    
end;

function TPlayObject.ClientSitDownHit(nX, nY, nDir: Integer;var dwDelayTime:LongWord): Boolean;//004CC248
var
  dwCheckTime:LongWord;
begin
  //SetProcessName('TPlayObject.ClientSitDownHit');
  Result:=False;
  if m_boDeath or (m_wStatusTimeArr[POISON_STONE{5}]{0x6A} <> 0) then exit;//防麻

  dwCheckTime:=GetTickCount - m_dwTurnTick;

  if dwCheckTime < g_Config.dwTurnIntervalTime then begin
    dwDelayTime:=g_Config.dwTurnIntervalTime - dwCheckTime;
    exit;
  end;
  m_dwTurnTick:=GetTickCount;
  SendRefMsg(RM_POWERHIT,0,0,0,0,'');
  Result:=True;
end;


procedure TPlayObject.ClientOpenDoor(nX,nY:Integer);//004DABD4
var
  Door:pTDoorInfo;
  Castle:TUserCastle;
begin
  Door:=m_PEnvir.GetDoor(nX,nY);
  if Door = nil then exit;
  Castle:=g_CastleManager.IsCastleEnvir(m_PEnvir);
  if (Castle = nil) or
     (Castle.m_DoorStatus <> Door.Status) or
     (m_btRaceServer <> RC_PLAYOBJECT) or
     Castle.CheckInPalace(m_nCurrX,m_nCurrY,Self) then begin

    UserEngine.OpenDoor(m_PEnvir,nX,nY);
  end;
  {
  if (UserCastle.m_MapCastle <> m_PEnvir) or
     (UserCastle.m_DoorStatus <> Door.Status) or
     (m_btRaceServer <> RC_PLAYOBJECT) or
     UserCastle.CheckInPalace(m_nCurrX,m_nCurrY,Self) then begin

    UserEngine.OpenDoor(m_PEnvir,nX,nY);
  end;
  }
end;

procedure TPlayObject.ClientTakeOnItems(btWhere: Byte; nItemIdx: integer; sItemName: String);//004DAC70
var
  I,n14,n18: Integer;
  UserItem,TakeOffItem:pTUserItem;
  StdItem,StdItem20:TItem;
  StdItem58:TStdItem;
  sUserItemName:String;
  stditemname:string;
  label FailExit;
begin
  StdItem:=nil;
  UserItem:=nil;
  n14:=-1;

  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[i];
    if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
      StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
      sUserItemName := GetItemName(UserItem);
      //heaven item code begins
      if (StdItem.Reserved and 16 <> 0) then begin
        stditemname:= FilterShowName(StdItem.Name);
        if self.m_WAbil.Level >= 50 then begin
          UserItem.wIndex:=UserEngine.GetStdItemIdx(StdItemName + '3');
        end else if self.m_WAbil.Level >= 40 then begin
          UserItem.wIndex:=UserEngine.GetStdItemIdx(StdItemName + '2');
        end else if self.m_WAbil.Level >= 30 then begin
          UserItem.wIndex:=UserEngine.GetStdItemIdx(StdItemName + '1');
        end else begin
          UserItem.wIndex:=UserEngine.GetStdItemIdx(StdItemName);
        end;
         StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
      end;
      //heaven item code ends
      //mir item code begins
      if (StdItem.Reserved and 32 <> 0) then begin
        stditemname:= FilterShowName(StdItem.Name);
        if self.m_btJob = Jwarr then
          UserItem.wIndex:=UserEngine.GetStdItemIdx(StdItemName + '1');
        if self.m_btJob = Jwizard then
          UserItem.wIndex:=UserEngine.GetStdItemIdx(StdItemName + '2');
        if self.m_btJob = Jtaos then
          UserItem.wIndex:=UserEngine.GetStdItemIdx(StdItemName + '3');
        StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
      end;
      //mir item code ends
      if StdItem <> nil then begin
        if CompareText(sUserItemName,sItemName) = 0 then begin
          n14:=i;
          break;
        end;
      end;
    end;
    UserItem:=nil;
  end;
  n18:=0;
  if (StdItem <> nil) and (UserItem <> nil) then begin
    if CheckUserItems(btWhere,StdItem) then begin
      StdItem.GetStandardItem(StdItem58);
      StdItem.GetItemAddValue(UserItem,StdItem58);
      StdItem58.Name := GetItemName(UserItem);

      if CheckTakeOnItems(btWhere,StdItem58) and CheckItemBindUse(UserItem) then begin
        TakeOffItem:=nil;
      if btWhere in [0..12] then begin

        if m_UseItems[btWhere].wIndex > 0 then begin
          StdItem20:=UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
          //heaven + mir item code begins
        if ((StdItem20.Reserved and 16 <> 0) or (StdItem20.Reserved and 32 <> 0)) then begin
          m_UseItems[btWhere].wIndex:=UserEngine.GetStdItemIdx(FilterShowName(StdItem20.Name));
          StdItem20:=UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
        end;
      //heaven + mir code ends
          if (StdItem20 <> nil) and
             (StdItem20.StdMode in [15,19,20,21,22,23,24,26]) then begin
            if (not m_boUserUnLockDurg) and (m_UseItems[btWhere].btValue[7] <> 0)then begin
              SysMsg(g_sCanotTakeOffItem,c_Red,t_Hint);
              n18:=-4;
              goto FailExit;
            end;
          end;
          if not m_boUserUnLockDurg and ((StdItem20.Reserved and 2) <> 0)then begin
            SysMsg(g_sCanotTakeOffItem,c_Red,t_Hint);
            n18:=-4;
            goto FailExit;
          end; //004DAE78
          if (StdItem20.Reserved and 4) <> 0 then begin
            SysMsg(g_sCanotTakeOffItem,c_Red,t_Hint);
            n18:=-4;
            goto FailExit;
          end;
          if InDisableTakeOffList(m_UseItems[btWhere].wIndex) then begin
            SysMsg(g_sCanotTakeOffItem,c_Red,t_Hint);
            goto FailExit;
          end;
          New(TakeOffItem);
          TakeOffItem^:=m_UseItems[btWhere];
        end; //004DAEC7 if m_UseItems[btWhere].wIndex > 0 then begin

        if (StdItem.StdMode in [15,19,20,21,22,23,24,26]) and   //004DAEC7
           (UserItem.btValue[8] <> 0) then
          UserItem.btValue[8]:=0;

        m_UseItems[btWhere]:=UserItem^;
        DelBagItem(n14);
        if TakeOffItem <> nil then begin
          AddItemToBag(TakeOffItem);
          SendAddItem(TakeOffItem);
        end;
        RecalcAbilitys();
        SendMsg(Self,RM_ABILITY,0,0,0,0,'');
        SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
        SendDefMessage(SM_TAKEON_OK,GetFeatureToLong,GetFeatureEx,0,0,'');
        FeatureChanged();
        //heaven + mir item begin
        if ((StdItem.Reserved and 16 <> 0) or (StdItem.Reserved and 32 <> 0)) then
          SendMsg(Self,RM_SENDUSEITEMS,0,0,0,0,'');
        //heaven + mir end
        n18:=1;
      end;{ else begin
        if m_AddUseItems[btWhere].wIndex > 0 then begin
          StdItem20:=UserEngine.GetStdItem(m_AddUseItems[btWhere].wIndex);
          if (StdItem20 <> nil) and
             (StdItem20.StdMode in [15,19,20,21,22,23,24,26]) then begin
            if (not m_boUserUnLockDurg) and (m_AddUseItems[btWhere].btValue[7] <> 0)then begin
              SysMsg('无法取下物品！！！',c_Red,t_Hint);
              n18:=-4;
              goto FailExit;
            end;
          end;
          if not m_boUserUnLockDurg and ((StdItem20.Reserved and 2) <> 0)then begin
            SysMsg('无法取下物品！！！',c_Red,t_Hint);
            n18:=-4;
            goto FailExit;
          end; //004DAE78
          if (StdItem20.Reserved and 4) <> 0 then begin
            SysMsg('无法取下物品！！！',c_Red,t_Hint);
            n18:=-4;
            goto FailExit;
          end;
          New(TakeOffItem);
          TakeOffItem^:=m_AddUseItems[btWhere];
        end; //004DAEC7 if m_UseItems[btWhere].wIndex > 0 then begin

        if (StdItem.StdMode in [15,19,20,21,22,23,24,26]) and   //004DAEC7
           (UserItem.btValue[8] <> 0) then
          UserItem.btValue[8]:=0;

        m_AddUseItems[btWhere]:=UserItem^;
        if TakeOffItem <> nil then begin
          AddItemToBag(TakeOffItem);
          SendAddItem(TakeOffItem);
        end;
        RecalcAbilitys();
        SendMsg(Self,RM_ABILITY,0,0,0,0,'');
        SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
        SendDefMessage(SM_TAKEON_OK,GetFeatureToLong,0,0,0,'');
        FeatureChanged();
        n18:=1;
      end;
      }
      end else n18:=-1; //004DAFA0
    end else n18:=-1; //004DAFA9
  end; //004DAFB0
  FailExit:
  if n18 <= 0 then
    SendDefMessage(SM_TAKEON_FAIL,n18,0,0,0,'');
    
end;

procedure TPlayObject.ClientTakeOffItems(btWhere: Byte; nItemIdx: integer; sItemName: String);//004DB01C
var
  n10:Integer;
  StdItem:TItem;
  UserItem:pTUserItem;
  sUserItemName:String;
label FailExit;
begin
  n10:=0;
  if not m_boDealing and (btWhere < 13) then begin
    if m_UseItems[btWhere].wIndex > 0 then begin
      if m_UseItems[btWhere].MakeIndex = nItemIdx then begin
        StdItem:=UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
        //heaven + mir item code begins
        if ((StdItem.Reserved and 16 <> 0) or (StdItem.Reserved and 32 <> 0)) then begin
          m_UseItems[btWhere].wIndex:=UserEngine.GetStdItemIdx(FilterShowName(StdItem.Name));
          StdItem:=UserEngine.GetStdItem(m_UseItems[btWhere].wIndex);
        end;
      //heaven + mir code ends
        if (StdItem <> nil) and
           (StdItem.StdMode in [15,19,20,21,22,23,24,26]) then begin
          if (not m_boUserUnLockDurg) and (m_UseItems[btWhere].btValue[7] <> 0)then begin
            SysMsg(g_sCanotTakeOffItem,c_Red,t_Hint);
            n10:=-4;
            goto FailExit;
          end;
        end;
        if not m_boUserUnLockDurg and ((StdItem.Reserved and 2) <> 0)then begin
          SysMsg(g_sCanotTakeOffItem,c_Red,t_Hint);
          n10:=-4;
          goto FailExit;
        end;
        if (StdItem.Reserved and 4) <> 0 then begin
          SysMsg(g_sCanotTakeOffItem,c_Red,t_Hint);
          n10:=-4;
          goto FailExit;
        end;
        if InDisableTakeOffList(m_UseItems[btWhere].wIndex) then begin
          SysMsg(g_sCanotTakeOffItem,c_Red,t_Hint);
          goto FailExit;
        end;
        
        sUserItemName:=GetItemName(@m_UseItems[btWhere]);

        if CompareText(sUserItemName,sItemName) = 0 then begin
          New(UserItem);
          UserItem^:=m_UseItems[btWhere];
          if AddItemToBag(UserItem) then begin
            m_UseItems[btWhere].wIndex:=0;

            SendAddItem(UserItem);
            RecalcAbilitys();
            SendMsg(Self,RM_ABILITY,0,0,0,0,'');
            SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
            SendDefMessage(SM_TAKEOFF_OK,GetFeatureToLong,GetFeatureEx,0,0,'');
            FeatureChanged();

            if g_FunctionNPC <> nil then
              g_FunctionNPC.GotoLable(Self,'@TakeOff' + sItemName,False);
          end else begin
            Dispose(UserItem);
            n10:=-3;
          end;
        end;
      end; //004DB26F
    end else n10:=-2; //004DB25F
      
  end else n10:=-1; //004DB268

  FailExit://004DB26F
  if n10 <= 0 then
    SendDefMessage(SM_TAKEOFF_FAIL,n10,0,0,0,'');
end;

procedure TPlayObject.ClientUseItems(nItemIdx: Integer; sItemName: String);//004DB3B0
  function GetUnbindItemName(nShape:Integer):String; //004E4214
  var
    I: Integer;
  begin
    Result:='';
    for I := 0 to g_UnbindList.Count - 1 do begin
      if Integer(g_UnbindList.Objects[I]) = nShape then begin
        Result:=g_UnbindList.Strings[I];
        break;
      end;        
    end;
  end;
  function GetUnBindItems(sItemName:String;nCount:Integer):Boolean; //004DB2DC
  var
    I: Integer;
    UserItem:pTUserItem;
  begin
    Result:=False;
    for I := 0 to nCount - 1 do begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(sItemName,UserItem) then begin
        m_ItemList.Add(UserItem);
        if m_btRaceServer = RC_PLAYOBJECT then
          SendAddItem(UserItem);
        Result:=True;
      end else begin
        Dispose(UserItem);
        break;
      end;
    end;
  end;
var
  I          :Integer;
  boEatOK    :Boolean;
  UserItem   :pTUserItem;
  StdItem    :TItem;
  UserItem34 :TUserItem;
begin
  boEatOK:=False;
  StdItem:=nil;
  if m_boCanUseItem then begin
  if not m_boDeath then begin
    for I := 0 to m_ItemList.Count - 1 do begin
      UserItem:=m_ItemList.Items[I];
      if (UserItem <> nil) and (UserItem.MakeIndex = nItemIdx) then begin
        UserItem34:=UserItem^;
        StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
        if StdItem <> nil then begin
          case StdItem.StdMode of    //
            0,1,2,3: begin //药
              if EatItems(StdItem,UserItem) then begin
                Dispose(UserItem);
                m_ItemList.Delete(I);
                boEatOK:=True;
              end;
              break;
            end;
            4: begin //书
              if ReadBook(StdItem) then begin
                Dispose(UserItem);
                m_ItemList.Delete(I);
                boEatOK:=True;
                if (m_MagicErgumSkill <> nil) and (not m_boUseThrusting) then begin
                  ThrustingOnOff(True);
                  SendSocket(nil,'+LNG');
                end;
                if (m_MagicBanwolSkill <> nil) and (not m_boUseHalfMoon) then begin
                  HalfMoonOnOff(True);
                  SendSocket(nil,'+WID');
                end;
                if (m_MagicRedBanwolSkill <> nil) and (not m_boRedUseHalfMoon) then begin
                  RedHalfMoonOnOff(True);
                  SendSocket(nil,'+WID');
                end;
              end;
            end;
            31: begin //解包物品
              if StdItem.AniCount = 0 then begin
                if (m_ItemList.Count + 6 -1) <= MAXBAGITEM then begin
                  Dispose(UserItem);
                  m_ItemList.Delete(I);
                  GetUnBindItems(GetUnbindItemName(StdItem.Shape),6);
                  boEatOK:=True;
                end;
              end else begin
                if UseStdmodeFunItem(StdItem) then begin
                  Dispose(UserItem);
                  m_ItemList.Delete(I);
                  boEatOK:=True;
                end;
              end;
            end;
          end;
        end;
        break;
      end;
    end;
  end;
  end else begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sCanotUseItemMsg);
  end;
  if boEatOK then begin
    WeightChanged();
    SendDefMessage(SM_EAT_OK,0,0,0,0,'');
      //004DB73F
    if StdItem.NeedIdentify = 1 then
      AddGameDataLog('11' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     //UserEngine.GetStdItemName(UserItem34.wIndex) + #9 +
                     StdItem.Name + #9 +
                     IntToStr(UserItem34.MakeIndex) + #9 +
                     '1' + #9 +
                     '0');
  end else begin
    SendDefMessage(SM_EAT_FAIL,0,0,0,0,'');
  end;
      
end;
function TPlayObject.UseStdmodeFunItem(StdItem: TItem):Boolean;
begin
  Result:=False;
  if g_FunctionNPC <> nil then begin
    g_FunctionNPC.GotoLable(Self,'@StdModeFunc' + IntToStr(StdItem.AniCount),False);
    Result:=True;
  end;    
end;


function TPlayObject.ClientGetButchItem(BaseObject: TBaseObject; nX, nY: Integer;btDir: Byte;var dwDelayTime:LongWord):Boolean;//004DB7E0
var
  n10,n14:Integer;
  dwCheckTime:LongWord;
begin
  Result:=False;
  dwDelayTime:=0;
  dwCheckTime:=GetTickCount - m_dwTurnTick;
  if dwCheckTime < g_Config.dwTurnIntervalTime then begin
    dwDelayTime:=g_Config.dwTurnIntervalTime - dwCheckTime;
    exit;
  end;
  m_dwTurnTick:=GetTickCount;
  if (abs(nX - m_nCurrX) <= 2) and (abs(nY - m_nCurrY) <= 2) then begin
    if m_PEnvir.IsValidObject(nX,nY,2,BaseObject) then begin
      if BaseObject.m_boDeath and (not BaseObject.m_boSkeleton) and (BaseObject.m_boAnimal) then begin
        n10:=Random(16) + 5;
        n14:=Random(201) + 100;
        Dec(BaseObject.m_nBodyLeathery,n10);
        Dec(BaseObject.m_nMeatQuality,n14);
        if BaseObject.m_nMeatQuality < 0 then BaseObject.m_nMeatQuality:=0;
        if BaseObject.m_nBodyLeathery <= 0 then begin
          if (BaseObject.m_btRaceServer >= RC_ANIMAL) and (BaseObject.m_btRaceServer < RC_MONSTER) then begin
            BaseObject.m_boSkeleton:=True;
            ApplyMeatQuality();
            BaseObject.SendRefMsg(RM_SKELETON,BaseObject.m_btDirection,BaseObject.m_nCurrX,BaseObject.m_nCurrY,0,'');
          end;
          if not TakeBagItems(BaseObject) then begin
            SysMsg(sYouFoundNothing,c_Red,t_Hint);
          end;
          BaseObject.m_nBodyLeathery:=50;
        end; //004DB945
        m_dwDeathTick:=GetTickCount();
      end;

    end; //004DB953
    m_btDirection:=btDir;
  end;
  SendRefMsg(RM_BUTCH,m_btDirection,m_nCurrX,m_nCurrY,0,'');
end;

procedure TPlayObject.ClientChangeMagicKey(nSkillIdx, nKey: integer); //004DB9A4
var
  I: Integer;
  UserMagic:pTUserMagic;
begin
  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic:=m_MagicList.Items[i];
    if UserMagic.MagicInfo.wMagicId = nSkillIdx then begin
      UserMagic.btKey:=nKey;
      break;
    end;
  end;
end;

procedure TPlayObject.ClientGroupClose; //004C3C10
begin
  if m_GroupOwner = nil then begin
    m_boAllowGroup:=False;
    exit;
  end;
  if m_GroupOwner <> Self then begin
    m_GroupOwner.DelMember(Self);
    m_boAllowGroup:=False;
  end else begin
    SysMsg('If you want to withdraw from group, use function of (del member).',c_Red,t_Hint);
  end;

  if g_FunctionNPC <> nil then
    g_FunctionNPC.GotoLable(Self,'@GroupClose',False);
end;

procedure TPlayObject.ClientCreateGroup(sHumName: String); //004DCCB4
var
  PlayObject:TPlayObject;
begin
  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if m_GroupOwner <> nil then begin
    SendDefMessage(SM_CREATEGROUP_FAIL,-1,0,0,0,'');
    exit;
  end;
  if (PlayObject = nil) or (PlayObject = Self) or PlayObject.m_boDeath or PlayObject.m_boGhost then begin
    SendDefMessage(SM_CREATEGROUP_FAIL,-2,0,0,0,'');
    exit;
  end;
  if (PlayObject.m_GroupOwner <> nil) then begin
    SendDefMessage(SM_CREATEGROUP_FAIL,-3,0,0,0,'');
    exit;
  end;
  if (not PlayObject.m_boAllowGroup) then begin
    SendDefMessage(SM_CREATEGROUP_FAIL,-4,0,0,0,'');
    exit;
  end;
  m_GroupMembers.Clear;
  m_GroupMembers.AddObject(m_sCharName,Self);
  m_GroupMembers.AddObject(sHumName,PlayObject);
  JoinGroup(Self);
  PlayObject.JoinGroup(Self);
  m_boAllowGroup:=True;
  SendDefMessage(SM_CREATEGROUP_OK,0,0,0,0,'');
  SendGroupMembers();
  if g_FunctionNPC <> nil then
    g_FunctionNPC.GotoLable(Self,'@GroupCreate',False);
end;

procedure TPlayObject.ClientAddGroupMember(sHumName: String); //004DCE48
var
  PlayObject:TPlayObject;
begin
  PlayObject:=UserEngine.GeTPlayObject(sHumName);


  if m_GroupOwner <> Self then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL,-1,0,0,0,'');
    exit;
  end;
  if m_GroupMembers.Count > g_Config.nGroupMembersMax then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL,-5,0,0,0,'');
    exit;
  end;
  if (PlayObject = nil) or (PlayObject = Self) or PlayObject.m_boDeath  or PlayObject.m_boGhost then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL,-2,0,0,0,'');
    exit;
  end;
  if (PlayObject.m_GroupOwner <> nil) then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL,-3,0,0,0,'');
    exit;
  end;
  if (not PlayObject.m_boAllowGroup) then begin
    SendDefMessage(SM_GROUPADDMEM_FAIL,-4,0,0,0,'');
    exit;
  end;

  m_GroupMembers.AddObject(sHumName,PlayObject);
  PlayObject.JoinGroup(Self);
  SendDefMessage(SM_GROUPADDMEM_OK,0,0,0,0,'');
  SendGroupMembers();
  if g_FunctionNPC <> nil then
    g_FunctionNPC.GotoLable(Self,'@GroupAddMember',False);
end;

procedure TPlayObject.ClientDelGroupMember(sHumName: String); //004DCFB8
var
  PlayObject:TPlayObject;
begin
  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if m_GroupOwner <> Self then begin
    SendDefMessage(SM_GROUPDELMEM_FAIL,-1,0,0,0,'');
    exit;
  end;
  if PlayObject = nil then begin
    SendDefMessage(SM_GROUPDELMEM_FAIL,-2,0,0,0,'');
    exit;
  end;
  if not IsGroupMember(PlayObject) then begin
    SendDefMessage(SM_GROUPDELMEM_FAIL,-3,0,0,0,'');
    exit;
  end;
  DelMember(PlayObject);
  SendDefMessage(SM_GROUPDELMEM_OK,0,0,0,0,sHumName);

  if g_FunctionNPC <> nil then
    g_FunctionNPC.GotoLable(Self,'@GroupDelMember',False);
end;

procedure TPlayObject.ClientDealTry(sHumName: String); //004DD0A8
var
  BaseObject:TBaseObject;
begin
  if g_Config.boDisableDeal then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sDisableDealItemsMsg);
    exit;
  end;
  if m_boDealing then exit;
  if GetTickCount - m_DealLastTick < g_Config.dwTryDealTime{3000} then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sPleaseTryDealLaterMsg);
    exit;
  end;

  if not m_boCanDeal then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sCanotTryDealMsg);
    exit;
  end;  
  BaseObject:=GetPoseCreate();
  if (BaseObject <> nil) and (BaseObject <> self) then begin
    if (BaseObject.GetPoseCreate = Self) and (not BaseObject.m_boDealing) then begin
      if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
        if (BaseObject.m_boAllowDeal and TPlayObject(BaseObject).m_boCanDeal) then begin
          BaseObject.SysMsg(m_sCharName + g_sOpenedDealMsg,c_Green,t_Hint);
          SysMsg(BaseObject.m_sCharName + g_sOpenedDealMsg,c_Green,t_Hint);
          TPlayObject(Self).OpenDealDlg(BaseObject);
          TPlayObject(BaseObject).OpenDealDlg(Self);
        end else begin //004DD1CC
          SysMsg(g_sPoseDisableDealMsg,c_Red,t_Hint);
        end;
      end;

    end else begin //004DD1E0
      SendDefMessage(SM_DEALTRY_FAIL,0,0,0,0,'');
    end;

  end else begin //004DD1F9
      SendDefMessage(SM_DEALTRY_FAIL,0,0,0,0,'');
  end;
    
end;


{----------LOVER-----------------}
procedure TPlayObject.ChangeAvailability;
begin
  if m_xLoveInfo.boHasLover then begin
    m_xLoveInfo.boHasLover := False;
    SysMsg('Unavailable for relationship',c_RedWhite,t_Hint);
  end else begin
    m_xLoveInfo.boHasLover := True;
    SysMsg('Available for relationship',c_RedWhite,t_Hint);
  end;
end;

procedure TPlayObject.SendRequestRelay(name:string);
var
Msg:TDefaultMessage;
begin
 //BaseObject:=PlayGetPoseCreate();
 msg:=MakeDefaultMsg(SM_REQUESTRELAY,0,0,0,0);
 SendSocket(@msg,name);
end;

procedure TPlayObject.SendRequestFail(name:string);
var
  Msg:TDefaultMessage;
begin
   msg:=MakeDefaultMsg(SM_REQUESTRELAYFAIL,0,0,0,0);
   SendSocket(@msg,name);
end;


procedure TPlayObject.RequestRelay;
var
  BaseObject:TPlayObject;
  Envir:TEnvirnoment;
  User:TPlayObject;
  List58:TList;
  II:Integer;
begin
  BaseObject:=PlayGetPoseCreate();
  if BaseObject <> nil then begin //if user is facing us
    if m_xLoveInfo.Lover <> '' then begin
      SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'You are already in a relationship.');
      exit;
    end;
    if m_btGender <> BaseObject.m_btGender then begin
      if m_wabil.Level >= 22 then begin
        if m_xLoveInfo.boHasLover then begin //if your set to available
          if BaseObject.m_xLoveInfo.boHasLover then begin //if facey is set to true
            m_xLoveInfo.Lover := BaseObject.m_sCharName;
            m_xLoveInfo.StartDate := Now;
            BaseObject.m_xLoveInfo.Lover := m_sCharName;
            BaseObject.m_xLoveInfo.StartDate := m_xLoveInfo.StartDate;
            //tell ppl on map they married
            Envir:=g_MapManager.FindMap(m_sMapName);
            if Envir <> nil then begin
              List58:=TList.Create;
              UserEngine.GetMapRageHuman(Envir,0,0,1000,List58);
              for II := 0 to List58.Count - 1 do begin
                User:=TPlayObject(List58.Items[II]);
                User.SysMsg('Congratulations to ' + m_sCharName + ' & ' + BaseObject.m_sCharName + ' good luck with your relationship!',c_Blue,t_hint);
                if II > 20 then break;
              end;
              List58.Free;
            end;
            SendMsg(self,SM_LOVERSUCCESS,0,0,0,0,'');//playobject
            BaseObject.SendMsg(BaseObject,SM_LOVERSUCCESS,0,0,0,0,'');//baseobject
          end else begin
            SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'The user is not available for a relationship.');
          end;
        end else begin
          SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'You are currently not engaged in a relationship.\' +
                                                   'To transfer to "Available", click the "Select Availability" button.\');
        end;
      end else begin
        SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'Only levels of 22 or higher can invite others into a relationship.');
      end;
    end;//<>
  end;//<> nil
end;

procedure TPlayObject.RequestDivorce;
var
  Lover:TPlayObject;
begin
  if m_xLoveInfo.Lover <> '' then begin
    Lover:=UserEngine.GeTPlayObject(m_xLoveInfo.Lover);
    if Lover <> nil then begin
      if DecGold(100000) then begin   //take 100k
        GoldChanged();
      end else begin
        SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0, 'You do not have enough gold!');
        exit;
      end;

      m_xLoveInfo.Lover := '';
      m_xLoveInfo.StartDate := 0;
      m_xLoveInfo.TotalDays := 0;
      m_xLoveInfo.boHasLover := False;

      Lover.m_xLoveInfo.Lover := '';
      Lover.m_xLoveInfo.StartDate := 0;
      Lover.m_xLoveInfo.TotalDays := 0;
      Lover.m_xLoveInfo.boHasLover := False;

      //Notify both users
      SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0,'You have broken up.');
      Lover.SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0, m_sCharName + ' has broken up with you.');
    end else begin
      Lover.SendMsg(Self,RM_MENU_OK,0,Integer(self),0,0, 'Your lover must be online for you to break up with them!');
    end;
  end;
end;

procedure TPlayObject.OpenLoverWindow;
var
  msg:TDefaultMessage;

  syear1,smonth1,sday1:word;
  syear2,smonth2,sday2:word;
  day1,day2:integer;
begin
 m_xLoveInfo.TotalDays := 0;
 if m_xLoveInfo.Lover <> '' then begin
  DecodeDate(m_xLoveInfo.StartDate,syear1,smonth1,sday1);
  DecodeDate(Date,syear2,smonth2,sday2);//gonna have to go first
  day1:=Integer(sday1);
  day2:=Integer(sday2);
  m_xLoveInfo.TotalDays := ROUND(day2-day1);
  end;

  msg:=MakeDefaultMsg(SM_LOVERINFO,0,0,0,0);
  SendSocket(@msg,EncodeBuffer(@m_xLoveInfo,SizeOf(TLover)));

end;
{----------------------------------}


procedure TPlayObject.ClientAddDealItem(nItemIdx: integer; sItemName: String; nAmount:Integer); //004DD79C
var
  I: Integer;
  bo11:Boolean;
  UserItem:pTUserItem;
  sUserItemName:String;
  UserItem2:pTUserItem;
begin
  if (m_DealCreat = nil) or (not m_boDealing) then exit;
  if Pos(' ',sItemName) >= 0 then begin //折分物品名称(信件物品的名称后面加了使用次数)
    GetValidStr3(sItemName,sItemName,[' ']);
  end;
  bo11:=False;
  if not m_DealCreat.m_boDealOK then begin
    for I := 0 to m_Itemlist.Count - 1 do begin
      UserItem:=m_Itemlist.Items[i];
      if UserItem.MakeIndex = nItemIdx then begin
        //取自定义物品名称
        sUserItemName:=GetItemName(UserItem);
        if (CompareText(sUserItemName,sItemName) = 0) and
           (m_DealItemList.Count < 12) then begin
          if (UserEngine.GetStdItem(UserItem.wIndex).StdMode = 45) and (UserItem.Amount > nAmount) then begin
            UserItem2:=copyuseritem(UserItem);
            UserItem2.Amount:=nAmount;
            m_DealItemList.Add(UserItem2);
            TPlayObject(Self).SendAddDealItem(UserItem2);
            dec(UserItem.Amount,nAmount);
          end else begin
            m_DealItemList.Add(UserItem);
            m_Itemlist.Delete(i);
            TPlayObject(Self).SendAddDealItem(UserItem);
          end;

          bo11:=True;
          break;
        end;
      end;
    end;
  end; //004DDAA7
  if not bo11 then
    SendDefMessage(SM_DEALADDITEM_FAIL,0,0,0,0,'');
end;

procedure TPlayObject.ClientDelDealItem(nItemIdx: integer; sItemName: String); //004DD958
var
  I: Integer;
  bo11:Boolean;
  UserItem:pTUserItem;
  sUserItemName:String;
begin
  
  if g_Config.boCanNotGetBackDeal then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sDealItemsDenyGetBackMsg);
    SendDefMessage(SM_DEALDELITEM_FAIL,0,0,0,0,'');
    exit;
  end;

  if (m_DealCreat = nil) or (not m_boDealing) then exit;

  if Pos(' ',sItemName) >= 0 then begin //折分物品名称(信件物品的名称后面加了使用次数)
    GetValidStr3(sItemName,sItemName,[' ']);
  end;

  bo11:=False;
  if not m_DealCreat.m_boDealOK then begin
    for I := 0 to m_DealItemList.Count - 1 do begin
      UserItem:=m_DealItemList.Items[i];
      if UserItem.MakeIndex = nItemIdx then begin

        //取自定义物品名称
        sUserItemName:=GetItemName(UserItem);

        if CompareText(sUserItemName,sItemName) = 0 then begin
          m_Itemlist.Add(UserItem);
          TPlayObject(Self).SendDelDealItem(UserItem);
          m_DealItemList.Delete(i);
          bo11:=True;
          break;
        end;
      end;
    end;
  end; //004DDAA7
  if not bo11 then
    SendDefMessage(SM_DEALDELITEM_FAIL,0,0,0,0,'');
end;

procedure TPlayObject.ClientCancelDeal;//004DD450
begin
  DealCancel();
end;

procedure TPlayObject.ClientChangeDealGold(nGold: Integer); //004DDB04
var
  bo09:Boolean;
begin

  //禁止取回放入交易栏内的金币
  if (m_nDealGolds > 0) and g_Config.boCanNotGetBackDeal then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,g_sDealItemsDenyGetBackMsg);
    SendDefMessage(SM_DEALDELITEM_FAIL,0,0,0,0,'');
    exit;
  end;
  
  if nGold < 0 then begin
    SendDefMessage(SM_DEALCHGGOLD_FAIL,m_nDealGolds,LoWord(m_nGold),HiWord(m_nGold),0,'');
    exit;
  end;
  bo09:=False;
  if (m_DealCreat <> nil) and (GetPoseCreate = m_DealCreat) then begin
    if not m_DealCreat.m_boDealOK then begin
      if (m_nGold + m_nDealGolds) >= nGold then begin
        m_nGold:=(m_nGold + m_nDealGolds) - nGold;
        m_nDealGolds:=nGold;
        SendDefMessage(SM_DEALCHGGOLD_OK,m_nDealGolds,LoWord(m_nGold),HiWord(m_nGold),0,'');
        TPlayObject(m_DealCreat).SendDefMessage(SM_DEALREMOTECHGGOLD,m_nDealGolds,0,0,0,'');
        m_DealCreat.m_DealLastTick:=GetTickCount();
        bo09:=True;
        m_DealLastTick:=GetTickCount();
      end; //004DDC50
    end;
  end;
  if not bo09 then begin
    SendDefMessage(SM_DEALCHGGOLD_FAIL,m_nDealGolds,LoWord(m_nGold),HiWord(m_nGold),0,'');
  end;
    
end;

procedure TPlayObject.ClientDealEnd;//004DDC8C
var
  I,II: Integer;
  bo11:Boolean;
  UserItem,UserItem2:pTUserItem;
  StdItem:TItem;
  PlayObject:TPlayObject;
begin
  m_boDealOK:=True;
  if m_DealCreat = nil then exit;
  if ((GetTickcount - m_DealLastTick) < g_Config.dwDealOKTime{1000}) or ((GetTickcount - m_DealCreat.m_DealLastTick) < g_Config.dwDealOKTime{1000}) then begin
    SysMsg(g_sDealOKTooFast,c_Red,t_Hint);
    DealCancel();
    exit;
  end;
  if m_DealCreat.m_boDealOK then begin
    bo11:=True;
    if (MAXBAGITEM - m_ItemList.Count) < m_DealCreat.m_DealItemList.Count  then begin
      bo11:=False;
      SysMsg(g_sYourBagSizeTooSmall,c_Red,t_Hint);
    end;
    if (m_nGoldMax - m_nGold) < m_DealCreat.m_nDealGolds then begin
      SysMsg(g_sYourGoldLargeThenLimit,c_Red,t_Hint);
      bo11:= False;
    end;
    if (MAXBAGITEM - m_DealCreat.m_ItemList.Count) < m_DealItemList.Count then begin
      SysMsg(g_sDealHumanBagSizeTooSmall,c_Red,t_Hint);
      bo11:=False;
    end;
    if (m_DealCreat.m_nGoldMax - m_DealCreat.m_nGold) < m_nDealGolds then begin
      SysMsg(g_sDealHumanGoldLargeThenLimit,c_Red,t_Hint);
      bo11:= False;
    end;
    if bo11 then begin
      for I := 0 to m_DealItemList.Count - 1 do begin
        UserItem:=m_DealItemList.Items[i];
        StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
        UserItem2:= m_DealCreat.CheckItems(StdItem.Name);
        if (StdItem.StdMode = 45) and (UserItem2 <> nil) then begin
          for II:=0 to UserItem.Amount -1 do begin
            m_DealCreat.IncreaseItem(StdItem.Name);
            TPlayObject(m_DealCreat).SendAddItem(UserItem2);
          end;
        end else begin
          m_DealCreat.AddItemToBag(UserItem);
          TPlayObject(m_DealCreat).SendAddItem(UserItem);
        end;
        if StdItem <> nil then begin
          if not IsCheapStuff(StdItem.StdMode) then begin
            //004DDF49
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('8' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                     StdItem.Name + #9 +
                     IntToStr(UserItem.MakeIndex) + #9 +
                     '1' + #9 +
                     m_DealCreat.m_sCharName);
          end;
        end;          
      end; //004DDF5A
      if m_nDealGolds > 0 then begin
        Inc(m_DealCreat.m_nGold,m_nDealGolds);
        m_DealCreat.GoldChanged();
            //004DE05E
          if g_boGameLogGold then
            AddGameDataLog('8' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     sSTRING_GOLDNAME + #9 +
                     IntToStr(m_nGold) + #9 +
                     '1' + #9 +
                     m_DealCreat.m_sCharName);
      end;
      for I := 0 to m_DealCreat.m_DealItemList.Count - 1 do begin
        UserItem:=m_DealCreat.m_DealItemList.Items[i];
        StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
        UserItem2:= CheckItems(StdItem.Name);
        if (StdItem.StdMode = 45) and (UserItem2 <> nil) then begin
          for II:=0 to UserItem.Amount -1 do begin
            IncreaseItem(StdItem.Name);
            TPlayObject(self).SendAddItem(UserItem2);
          end;
        end else begin
          AddItemToBag(UserItem);
          TPlayObject(Self).SendAddItem(UserItem);
        end;
        if StdItem <> nil then begin
          if not IsCheapStuff(StdItem.StdMode) then begin
            //004DE217
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('8' +  #9 +
                     m_DealCreat.m_sMapName + #9 +
                     IntToStr(m_DealCreat.m_nCurrX) + #9 +
                     IntToStr(m_DealCreat.m_nCurrY) + #9 +
                     m_DealCreat.m_sCharName + #9 +
                     //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                     StdItem.Name + #9 +
                     IntToStr(UserItem.MakeIndex) + #9 +
                     '1' + #9 +
                     m_sCharName);
          end;
        end;          
      end; //004DDF5A
      if m_DealCreat.m_nDealGolds > 0 then begin
        Inc(m_nGold,m_DealCreat.m_nDealGolds);
        GoldChanged();
            //004DE36E
          if g_boGameLogGold then
            AddGameDataLog('8' +  #9 +
                     m_DealCreat.m_sMapName + #9 +
                     IntToStr(m_DealCreat.m_nCurrX) + #9 +
                     IntToStr(m_DealCreat.m_nCurrY) + #9 +
                     m_DealCreat.m_sCharName + #9 +
                     sSTRING_GOLDNAME + #9 +
                     IntToStr(m_DealCreat.m_nGold) + #9 +
                     '1' + #9 +
                     m_sCharName);
      end;
      //004DE37
      PlayObject:=TPlayObject(m_DealCreat);
      PlayObject.SendDefMessage(SM_DEALSUCCESS,0,0,0,0,'');
      PlayObject.SysMsg(g_sDealSuccessMsg,c_Green,t_Hint);
      PlayObject.m_DealCreat:=nil;
      PlayObject.m_boDealing:=False;
      PlayObject.m_DealItemList.Clear;
      PlayObject.m_nDealGolds:=0;
      PlayObject.m_boDealOK:=False; 

      SendDefMessage(SM_DEALSUCCESS,0,0,0,0,'');
      SysMsg(g_sDealSuccessMsg,c_Green,t_Hint);
      m_DealCreat:=nil;
      m_boDealing:=False;
      m_DealItemList.Clear;
      m_nDealGolds:=0;
      m_boDealOK:=False;  
    end else begin //004DE42F
      DealCancel();
    end;
  end else begin //004DE439
    SysMsg(g_sYouDealOKMsg,c_Green,t_Hint);
    m_DealCreat.SysMsg(g_sPoseDealOKMsg,c_Green,t_Hint);
  end;
end;

procedure TPlayObject.ClientCancelRefine;//004DD450
begin
  RefineCancel();
end;

procedure TPlayObject.ClientMakeDrugItem(NPC: TObject;nItemName: String); //004DCAF8
var
  Merchant:TMerchant;
begin
  Merchant:=UserEngine.FindMerchant(NPC);
  if (Merchant = nil) or (not Merchant.m_boMakeDrug) then exit;
  if ((Merchant.m_PEnvir = m_PEnvir) and
     (abs(Merchant.m_nCurrX - m_nCurrX) < 15) and
     (abs(Merchant.m_nCurrY - m_nCurrY) < 15)) then
    Merchant.ClientMakeDrugItem(Self,nItemName);

    
end;

procedure TPlayObject.ClientOpenGuildDlg;//004DE8E0
var
  I: Integer;
  sC:String;
begin
  if m_MyGuild <> nil then begin
    sC:=TGuild(m_MyGuild).sGuildName + #13 + ' ' + #13;
    if m_nGuildRankNo = 1 then begin
      sC:=sC + '1' + #13;
    end else begin
      sC:=sC + '0' + #13;
    end;
    sC:=sC + '<Notice>' + #13;
    for I := 0 to TGuild(m_MyGuild).NoticeList.Count - 1 do begin
      if length(sC) > 5000 then break;
      sC:=sC + TGuild(m_MyGuild).NoticeList.Strings[I] + #13;
    end;    // for
    sC:=sC + '<KillGuilds>' + #13;
    for I := 0 to TGuild(m_MyGuild).GuildWarList.Count - 1 do begin
      if length(sC) > 5000 then break;
      sC:=sC + TGuild(m_MyGuild).GuildWarList.Strings[I] + #13;
    end;    // for
    sC:=sC + '<AllyGuilds>' + #13;
    for I := 0 to TGuild(m_MyGuild).GuildAllList.Count - 1 do begin
      if length(sC) > 5000 then break;
      sC:=sC + TGuild(m_MyGuild).GuildAllList.Strings[I] + #13;
    end;    // for
    m_DefMsg:=MakeDefaultMsg(SM_OPENGUILDDLG,0,0,0,1);
    SendSocket(@m_DefMsg,EncodeString(sC));
  end else begin
    SendDefMessage(SM_OPENGUILDDLG_FAIL,0,0,0,0,'');
  end;
    
end;

procedure TPlayObject.ClientGuildHome;//004DEBDC
begin
  ClientOpenGuildDlg();
end;

procedure TPlayObject.ClientGuildMemberList;//004DEBF0
var
  GuildRank:pTGuildRank;
  I,II:Integer;
  sSendMsg:String;
begin
  if m_MyGuild = nil then exit;
  for I:=0 to TGuild(m_MyGuild).m_RankList.Count -1 do begin
    GuildRank:=TGuild(m_MyGuild).m_RankList.Items[I];
    sSendMsg:=sSendMsg + '#' + IntToStr(GuildRank.nRankNo) + '/*' +  GuildRank.sRankName + '/';
    for II := 0 to GuildRank.MemberList.Count - 1 do begin
      if length(sSendMsg) > 5000 then break;
      sSendMsg:=sSendMsg + GuildRank.MemberList.Strings[II] + '/';
    end;
  end;
  m_DefMsg:=MakeDefaultMsg(SM_SENDGUILDMEMBERLIST,0,0,0,1);
  SendSocket(@m_DefMsg,EncodeString(sSendMsg));
end;

procedure TPlayObject.ClientGuildAddMember(sHumName: String);//004DEDB4
var
  nC:integer;
  PlayObject:TPlayObject;
begin
  nC:=1;
  if IsGuildMaster then begin
    PlayObject:=UserEngine.GeTPlayObject(sHumName);
    if PlayObject <> nil then begin
      if PlayObject.GetPoseCreate = Self then begin
        if PlayObject.m_boAllowGuild then begin
          if not TGuild(m_MyGuild).IsMember(sHumName) then begin
            if (PlayObject.m_MyGuild = nil) and (TGuild(m_MyGuild).m_RankList.Count < 400) then begin
              TGuild(m_MyGuild).AddMember(PlayObject);
              UserEngine.SendServerGroupMsg(SS_207,nServerIndex,TGuild(m_MyGuild).sGuildName);
              PlayObject.m_MyGuild:=m_MyGuild;
              PlayObject.m_sGuildRankName:=TGuild(m_MyGuild).GetRankName(PlayObject,PlayObject.m_nGuildRankNo);
              PlayObject.RefShowName();
              PlayObject.SysMsg('You have just joined: ' + TGuild(m_MyGuild).sGuildName + ' .Your guild rank is: ' + PlayObject.m_sGuildRankName ,c_Green,t_Hint);
              nC:=0;
            end else nC:=4;
          end else nC:=3;
        end else begin //004DEEFD
          nC:=5;
          PlayObject.SysMsg('Failed to join guild [use @' + g_GameCommand.LETGUILD.sCmd + ']',c_Red,t_Hint);
        end;
      end else nC:=2; //004DEF15 '
    end else nC:=2;//004DEF1E
  end;//004DEF25
  if nC = 0 then begin
    SendDefMessage(SM_GUILDADDMEMBER_OK,0,0,0,0,'');
  end else begin
    SendDefMessage(SM_GUILDADDMEMBER_FAIL,nC,0,0,0,'');
  end;
end;

procedure TPlayObject.ClientGuildDelMember(sHumName: String);//004DEFB8
var
  nC:integer;
  s14:String;
  PlayObject:TPlayObject;
begin
  nC:=1;
  if IsGuildMaster then begin
    if TGuild(m_MyGuild).IsMember(sHumName) then begin
      if m_sCharName <> sHumName then begin
        if TGuild(m_MyGuild).DelMember(sHumName) then begin
          PlayObject:=UserEngine.GeTPlayObject(sHumName);
          if PlayObject <> nil then begin
            PlayObject.m_MyGuild:=nil;
            PlayObject.RefRankInfo(0,'');
            PlayObject.RefShowName();//10/31
          end;//004DF078
          UserEngine.SendServerGroupMsg(SS_207,nServerIndex,TGuild(m_MyGuild).sGuildName);
          nC:=0;
        end else nC:=4;//004DF0A8
      end else begin //004DF0B4
        nC:=3;
        s14:=TGuild(m_MyGuild).sGuildName;
        if TGuild(m_MyGuild).CancelGuld(sHumName) then begin
          g_GuildManager.DelGuild(s14);
          UserEngine.SendServerGroupMsg(SS_206,nServerIndex,s14);
          m_MyGuild:=nil;
          RefRankInfo(0,'');
          RefShowName();//10/31
          SysMsg('Guild ' + s14 + ' has been disbanded',c_Red,t_Hint);
          nC:=0;
        end
      end;
    end else nC:=2;
  end;//004DF15C

  if nC = 0 then begin
    SendDefMessage(SM_GUILDDELMEMBER_OK,0,0,0,0,'');
  end else begin
    SendDefMessage(SM_GUILDDELMEMBER_FAIL,nC,0,0,0,'');
  end;

end;

procedure TPlayObject.ClientGuildUpdateNotice(sNotict: String);//004DF1EC
var
  sC:String;
begin
  if (m_MyGuild = nil) or (m_nGuildRankNo <> 1) then exit;
  TGuild(m_MyGuild).NoticeList.Clear;
  while (sNotict <> '') do begin
    sNotict:=GetValidStr3(sNotict,sC,[#$D]);
    TGuild(m_MyGuild).NoticeList.Add(sC);
  end;    // while
  TGuild(m_MyGuild).SaveGuildInfoFile();
  UserEngine.SendServerGroupMsg(SS_207,nServerIndex,TGuild(m_MyGuild).sGuildName);
  ClientOpenGuildDlg();
end;

procedure TPlayObject.ClientGuildUpdateRankInfo(sRankInfo: String);//004DF2E8
var
  nC:Integer;
begin
  if (m_MyGuild = nil) or (m_nGuildRankNo <> 1) then exit;
  nC:=TGuild(m_MyGuild).UpdateRank(sRankInfo);
  if nC = 0 then begin
    UserEngine.SendServerGroupMsg(SS_207,nServerIndex,TGuild(m_MyGuild).sGuildName);
    ClientGuildMemberList();
  end else begin
    if nC <= -2 then begin
      SendDefMessage(SM_GUILDRANKUPDATE_FAIL,nC,0,0,0,'');
    end;
      
  end;
    
end;

procedure TPlayObject.ClientGuildAlly;//004DF3AC
var
  n8:Integer;
  BaseObjectC:TBaseObject;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::ClientGuildAlly';
begin
try
  n8:= -1;
  BaseObjectC:=GetPoseCreate();
  if (BaseObjectC <> nil) and
     (BaseObjectC.m_MyGuild <> nil) and
     (BaseObjectC.m_btRaceServer = RC_PLAYOBJECT) and
     (BaseObjectC.GetPoseCreate = Self) then begin
    if TGuild(BaseObjectC.m_MyGuild).m_boEnableAuthAlly then begin
      if BaseObjectC.IsGuildMaster and IsGuildMaster then begin
        if TGuild(m_MyGuild).IsNotWarGuild(TGuild(BaseObjectC.m_MyGuild)) and
           TGuild(BaseObjectC.m_MyGuild).IsNotWarGuild(TGuild(m_MyGuild)) then begin

          TGuild(m_MyGuild).AllyGuild(TGuild(BaseObjectC.m_MyGuild));
          TGuild(BaseObjectC.m_MyGuild).AllyGuild(TGuild(m_MyGuild));
          
          TGuild(m_MyGuild).SendGuildMsg(TGuild(BaseObjectC.m_MyGuild).sGuildName + '行会已经和您的行会联盟成功。');
          TGuild(BaseObjectC.m_MyGuild).SendGuildMsg(TGuild(m_MyGuild).sGuildName + '行会已经和您的行会联盟成功。');
          TGuild(m_MyGuild).RefMemberName;
          TGuild(BaseObjectC.m_MyGuild).RefMemberName;
          UserEngine.SendServerGroupMsg(SS_207,nServerIndex,TGuild(m_MyGuild).sGuildName);
          UserEngine.SendServerGroupMsg(SS_207,nServerIndex,TGuild(BaseObjectC.m_MyGuild).sGuildName);
          n8:=0;
        end else n8:= -2;
      end else n8:= -3;
    end else n8:= -4;//004DF57C
  end;
  if n8 = 0 then begin
    SendDefMessage(SM_GUILDMAKEALLY_OK,0,0,0,0,'');
  end else begin
    SendDefMessage(SM_GUILDMAKEALLY_FAIL,n8,0,0,0,'');
  end;
except
  on e: Exception do begin
    MainOutMessage(sExceptionMsg);
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TPlayObject.ClientGuildBreakAlly(sGuildName: String);//004DF604
var
  n10:Integer;
  Guild:TGuild;
begin
  n10:= -1;
  if not IsGuildMaster() then exit;
  Guild:=g_GuildManager.FindGuild(sGuildName);
  if Guild <> nil then begin
    if TGuild(m_MyGuild).IsAllyGuild(Guild) then begin
      TGuild(m_MyGuild).DelAllyGuild(Guild);
      Guild.DelAllyGuild(TGuild(m_MyGuild));
      TGuild(m_MyGuild).SendGuildMsg(Guild.sGuildName +  ' has canceled the alliance');
      Guild.SendGuildMsg(TGuild(m_MyGuild).sGuildName +  ' Alliance ended');
      TGuild(m_MyGuild).RefMemberName();
      Guild.RefMemberName();
      UserEngine.SendServerGroupMsg(SS_207,nServerIndex,TGuild(m_MyGuild).sGuildName);
      UserEngine.SendServerGroupMsg(SS_207,nServerIndex,Guild.sGuildName);
      n10:=0;
    end else n10:= -2;
  end else n10:= -3; //004DF750
  if n10 = 0 then begin
    SendDefMessage(SM_GUILDBREAKALLY_OK,0,0,0,0,'');
  end else begin
    SendDefMessage(SM_GUILDMAKEALLY_FAIL,0,0,0,0,'');
  end;
    
    
end;
procedure TPlayObject.RecalcAdjusBonus();
   procedure AdjustAb (abil: byte; val: word; var lov, hiv: Word);
   var
      lo, hi: byte;
      i: integer;
   begin
      lo := Lobyte(abil);
      hi := Hibyte(abil);
      lov := 0; hiv := 0;
      for i:=1 to val do begin
         if lo + 1 < hi then begin
           Inc(lo);
           Inc(lov);
         end else begin
           Inc(hi);
           Inc(hiv);
         end;
      end;
   end;
var
  BonusTick:pTNakedAbility;
  NakedAbil:pTNakedAbility;
   adc, amc, asc, aac, amac: integer;
   ldc, lmc, lsc, lac, lmac, hdc, hmc, hsc, hac, hmac: Word;
begin
  BonusTick:=nil;
  NakedAbil:=nil;
  case m_btJob of
    jWarr: begin
      BonusTick:=@g_Config.BonusAbilofWarr;
      NakedAbil:=@g_Config.NakedAbilofWarr;
    end;
    jWizard: begin
      BonusTick:=@g_Config.BonusAbilofWizard;
      NakedAbil:=@g_Config.NakedAbilofWizard;
    end;
    jTaos: begin
      BonusTick:=@g_Config.BonusAbilofTaos;
      NakedAbil:=@g_Config.NakedAbilofTaos;
    end;
  end;


      adc := m_BonusAbil.DC div BonusTick.DC;
      amc := m_BonusAbil.MC div BonusTick.MC;
      asc := m_BonusAbil.SC div BonusTick.SC;
      aac := m_BonusAbil.AC div BonusTick.AC;
      amac := m_BonusAbil.MAC div BonusTick.MAC;


      AdjustAb (NakedAbil.DC, adc, ldc, hdc);
      AdjustAb (NakedAbil.MC, amc, lmc, hmc);
      AdjustAb (NakedAbil.SC, asc, lsc, hsc);
      AdjustAb (NakedAbil.AC, aac, lac, hac);
      AdjustAb (NakedAbil.MAC, amac, lmac, hmac);
      //lac  := 0;  hac := aac;
      //lmac := 0;  hmac := amac;
      
      m_WAbil.DC:=MakeLong(LoWord(m_WAbil.DC) + ldc,HiWord(m_WAbil.DC) + hdc);
      m_WAbil.MC:=MakeLong(LoWord(m_WAbil.MC) + lmc,HiWord(m_WAbil.MC) + hmc);
      m_WAbil.SC:=MakeLong(LoWord(m_WAbil.SC) + lsc,HiWord(m_WAbil.SC) + hsc);
      m_WAbil.AC:=MakeLong(LoWord(m_WAbil.AC) + lac,HiWord(m_WAbil.AC) + hac);
      m_WAbil.MAC:=MakeLong(LoWord(m_WAbil.MAC) + lmac,HiWord(m_WAbil.MAC) + hmac);

      m_WAbil.MaxHP:=_MIN(High(Word),m_WAbil.MaxHP + m_BonusAbil.HP div BonusTick.HP);
      m_WAbil.MaxMP:=_MIN(High(Word),m_WAbil.MaxMP + m_BonusAbil.MP div BonusTick.MP);
//      m_btSpeedPoint:=m_btSpeedPoint + m_BonusAbil.Speed div BonusTick.Speed;
//      m_btHitPoint:=m_btHitPoint + m_BonusAbil.Hit div BonusTick.Hit;
end;
procedure TPlayObject.ClientAdjustBonus(nPoint: Integer; sMsg: String);//004DF804
var
  BonusAbil:TNakedAbility;
  nTotleUsePoint:Integer;
begin
  FillChar(BonusAbil,SizeOf(TNakedAbility),#0);
  DecodeBuffer(sMsg,@BonusAbil,SizeOf(TNakedAbility));

  nTotleUsePoint:=BonusAbil.DC +
                  BonusAbil.MC +
                  BonusAbil.SC +
                  BonusAbil.AC +
                  BonusAbil.MAC +
                  BonusAbil.HP +
                  BonusAbil.MP +
                  BonusAbil.Hit +
                  BonusAbil.Speed +
                  BonusAbil.X2;

  if (nPoint + nTotleUsePoint) = m_nBonusPoint then begin
    m_nBonusPoint:=nPoint;
    Inc(m_BonusAbil.DC,BonusAbil.DC);
    Inc(m_BonusAbil.MC,BonusAbil.MC);
    Inc(m_BonusAbil.SC,BonusAbil.SC);
    Inc(m_BonusAbil.AC,BonusAbil.AC);
    Inc(m_BonusAbil.MAC,BonusAbil.MAC);
    Inc(m_BonusAbil.HP,BonusAbil.HP);
    Inc(m_BonusAbil.MP,BonusAbil.MP);
    Inc(m_BonusAbil.Hit,BonusAbil.Hit);
    Inc(m_BonusAbil.Speed,BonusAbil.Speed);
    Inc(m_BonusAbil.X2,BonusAbil.X2);

    RecalcAbilitys();
    SendMsg(Self,RM_ABILITY,0,0,0,0,'');
    SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
  end else begin
    SysMsg('Total amount of points vailable does not match the points you entered',c_Red,t_Hint);
  end;
end;

procedure TPlayObject.ClientSendFriendsList;
var
  sMsg,sMsgo: String;
  FriendObject: TPlayObject;
  Friend: ptClientFriends;
  I: Integer;
  DBM: TADOQuery;
begin
  sMsg := '';

  FrmDB.UseSQL();
  DBM := FrmDB.Query;

  sMsg := 'SELECT * FROM TBL_FRIEND Where FLD_CHAR='''+Self.m_sCharName+''' ORDER BY FLD_ID';
  DBM.SQL.Clear;
  DBM.SQL.Add(sMsg);
  DBM.Open;
  sMsg := '';
  sMsgo := '';

  new(Friend);
  for I := 0 to DBM.RecordCount do begin
    if DBM.eof then break;

    Friend.Id := DBM.FieldByName('FLD_ID').AsInteger;
    Friend.Name :=  DBM.FieldByName('FLD_PERSON').AsString;
    Friend.Memo := DBM.FieldByName('FLD_MEMO').AsString;
    Friend.BlackList := FrmDB.GetBoolean(DBM,'FLD_BAD');
    FriendObject := UserEngine.GetPlayObject(Friend.Name);
    if FriendObject <> nil then begin
      if Friend.BlackList then sMsg := sMsg+#1+Friend.Name+'/'
      else  sMsg := sMsg+Friend.Name+'/';
    end
    else begin
      if Friend.BlackList then sMsgo := sMsgo+#1+Friend.Name+'/'
      else sMsgo := sMsgo+Friend.Name+'/';
    end;
    DBM.Next;
  end;
  Dispose(Friend);
  DBM.Close;
  sMsg := sMsg + '#' + sMsgo;
  if sMsg <> '' then SendDefMessage(SM_FRIENDLIST, 0, 0, 0, 0, sMsg);
end;

procedure TPlayObject.ClientFriendStatusChanged(sPlayerName: String;Status: Byte);
begin
  SendDefMessage(SM_FRIENDSTATUS, Status, 0, 0, 0, sPlayerName);
end;

procedure TPlayObject.ClientFriendChangeState(Online: Boolean = True);
var
  sMsg,sMsgo: String;
  FriendObject: TPlayObject;
  I: Integer;
  DBM: TADOQuery;
begin
  sMsg := '';

  FrmDB.UseSQL();
  DBM := FrmDB.Query;

  sMsg := 'SELECT * FROM TBL_FRIEND Where FLD_PERSON='''+Self.m_sCharName+''' ORDER BY FLD_ID';
  DBM.SQL.Clear;
  DBM.SQL.Add(sMsg);
  DBM.Open;
  sMsg := '';
  sMsgo := '';

  for I := 0 to DBM.RecordCount do begin
    if DBM.eof then break;
    FriendObject := UserEngine.GetPlayObject(DBM.FieldByName('FLD_CHAR').AsString);
    if FriendObject <> nil then begin
      if Online then FriendObject.ClientFriendStatusChanged(Self.m_sCharName, 1)
      else FriendObject.ClientFriendStatusChanged(Self.m_sCharName, 0);
    end;
    DBM.Next;
  end;
  DBM.Close;
end;

procedure TPlayObject.ClientAddFriend(sPlayerName:String;BlackList:Byte);
var
  Friend: ptClientFriends;
  DBM: TADOCommand;
begin
  new(Friend);
  Friend.Name := sPlayerName;
  Friend.Status := 1;
  Friend.BlackList := (BlackList = 1);
  if Not Friend.blacklist then SendDefMessage(SM_ADDFRIEND, 0, 0, 0, 0, sPlayerName)
  else SendDefMessage(SM_ADDFRIEND, 0, 0, 0, 0, #1 + sPlayerName);
  //Save friends list

  FrmDB.UseSQL();
  DBM := FrmDB.QueryCommand;
  DBM.CommandText := 'INSERT INTO TBL_FRIEND (FLD_CHAR,FLD_PERSON,FLD_BAD,FLD_TIME) values (:FLD_CHAR, :FLD_PERSON, :FLD_BAD, :FLD_TIME)';
  DBM.Parameters.ParamByName('FLD_CHAR').Value := Self.m_sCharName;
  DBM.Parameters.ParamByName('FLD_PERSON').Value := Friend.Name;
  DBM.Parameters.ParamByName('FLD_BAD').Value := BoolToByte(Friend.Blacklist);
  DBM.Parameters.ParamByName('FLD_TIME').Value := UnixTime();
  DBM.Execute;
  DBM.CommandText := '';

  Dispose(Friend);
end;

procedure TPlayObject.ClientDelFriend(sPlayerName:String);
var
  DBM: TADOCommand;
begin
  // Assume name is correct, we dont care yet
  SendDefMessage(SM_DELFRIEND, 0, 0, 0, 0, sPlayerName);

  // Delete from sql
  FrmDB.UseSQL();
  DBM := FrmDB.QueryCommand;
  DBM.CommandText := 'DELETE FROM TBL_FRIEND WHERE FLD_CHAR = :FLD_CHAR and FLD_PERSON = :FLD_PERSON';
  DBM.Parameters.ParamByName('FLD_CHAR').Value := Self.m_sCharName;
  DBM.Parameters.ParamByName('FLD_PERSON').Value := sPlayerName;
  DBM.Execute;
  DBM.CommandText := '';
end;

procedure TPlayObject.ClientReqAddFriend(sPlayerName:String;BlackList:Byte);
var
  FriendObject: TPlayObject;
  DBM: TADOQuery;
begin
  if sPlayerName = Self.m_sCharName then begin
    SendDefMessage(SM_ADDFRIENDFAIL, 0, 0, 0, 0, sPlayerName + #1 + 'You cant add yourself..');
    exit;
  end;

  FrmDB.UseSQL();
  DBM := FrmDB.Query;
  DBM.Close;
  DBM.SQL.Clear;
  DBM.SQL.Add('SELECT * FROM TBL_FRIEND WHERE FLD_CHAR = :FLD_CHAR and FLD_PERSON = :FLD_PERSON');
  DBM.Parameters.ParamByName('FLD_CHAR').Value := Self.m_sCharName;
  DBM.Parameters.ParamByName('FLD_PERSON').Value := sPlayerName;
  DBM.Open;

  if DBM.RecordCount > 0 then begin
    SendDefMessage(SM_ADDFRIENDFAIL, 0, 0, 0, 0, sPlayerName + #1 + 'You cant add friends already on your list.');
  end
  else begin
    FriendObject := UserEngine.GeTPlayObject(sPlayerName);
    if FriendObject <> nil then begin
      Self.ClientAddFriend(FriendObject.m_sCharName, Blacklist);
      FriendObject.SysMsg('(!) '+Self.m_sCharName+' just added you as a friend',c_Green,t_Hint);
    end
    else begin
      SendDefMessage(SM_ADDFRIENDFAIL, 0, 0, 0, 0, sPlayerName + #1 + 'Friend must be online.');
    end;
  end;
  DBM.Close;
end;

procedure TPlayObject.ClientReqDelFriend(sPlayerName:String);
begin
  Self.ClientDelFriend(sPlayerName);
end;

procedure TPlayObject.ClientUpdateMemoFriend(body:String);
var
  sMemo, sFriendName: String;
  DBM: TADOCommand;
  p: Integer;
begin
  p := Pos(#1, body);
  sFriendName := Copy(body, 0, p-1);
  sMemo := Copy(body, p+1, 100);

  FrmDB.UseSQL();
  DBM := FrmDB.QueryCommand;
  DBM.CommandText := 'UPDATE TBL_FRIEND SET FLD_MEMO=:FLD_MEMO WHERE FLD_CHAR = :FLD_CHAR and FLD_PERSON = :FLD_PERSON';
  DBM.Parameters.ParamByName('FLD_MEMO').Value := sMemo;
  DBM.Parameters.ParamByName('FLD_CHAR').Value := Self.m_sCharName;
  DBM.Parameters.ParamByName('FLD_PERSON').Value := sFriendName;
  DBM.Execute;
  DBM.CommandText := '';
end;

procedure TPlayObject.ClientReqMemoFriend(sFriendName:String);
var
  DBM: TADOQuery;
  I: Integer;
begin
  //Load Memo
  FrmDB.UseSQL();
  DBM := FrmDB.Query;

  DBM.Close;
  DBM.SQL.Clear;
  DBM.SQL.Add('SELECT * FROM TBL_FRIEND Where FLD_CHAR=:FLD_CHAR and FLD_PERSON=:FLD_PERSON');
  DBM.Parameters.ParamByName('FLD_CHAR').Value := Self.m_sCharName;
  DBM.Parameters.ParamByName('FLD_PERSON').Value := sFriendName;
  DBM.Open;

  for I := 0 to DBM.RecordCount do begin
    if DBM.eof then break;
    SendDefMessage(SM_MEMOFRIEND, 0, 0, 0, 0, sFriendName + #1 + DBM.FieldByName('FLD_MEMO').AsString);
    DBM.Next;
  end;
  DBM.Close;
end;

function TPlayObject.GetMyStatus: Integer;//004C145C
begin
  Result:=m_nHungerStatus div 1000;
  if Result > 4 then Result:=4;
end;

procedure TPlayObject.SendAttatckMode; //004DA9E4
var
  sSendMsg:String;
begin
  m_DefMsg:=MakeDefaultMsg(SM_ATTATCKMODE,m_btAttatckMode,0,0,0);
  sSendMsg:='';
  SendSocket(@m_DefMsg,sSendMsg);
end;

procedure TPlayObject.SendAdjustBonus; //004DA9E4
var
  sSendMsg:String;
  //NakedAbil:TNakedAbility;
begin
  m_DefMsg:=MakeDefaultMsg(SM_ADJUST_BONUS,m_nBonusPoint,0,0,0);
  sSendMsg:='';
  //NakedAbil:=m_BonusAbil;
  //FillChar(NakedAbil,SizeOf(TNakedAbility),#0);
  case m_btjob of    //
    jWarr: sSendMsg:=EncodeBuffer(@g_Config.BonusAbilofWarr,SizeOf(TNakedAbility)) + '/' +
                 EncodeBuffer(@m_BonusAbil,SizeOf(TNakedAbility)) + '/' +
                 EncodeBuffer(@g_Config.NakedAbilofWarr,SizeOf(TNakedAbility));
    jWizard: sSendMsg:=EncodeBuffer(@g_Config.BonusAbilofWizard,SizeOf(TNakedAbility)) + '/' +
                 EncodeBuffer(@m_BonusAbil,SizeOf(TNakedAbility)) + '/' +
                 EncodeBuffer(@g_Config.NakedAbilofWizard,SizeOf(TNakedAbility));
    jTaos: sSendMsg:=EncodeBuffer(@g_Config.BonusAbilofTaos,SizeOf(TNakedAbility)) + '/' +
                 EncodeBuffer(@m_BonusAbil,SizeOf(TNakedAbility)) + '/' +
                 EncodeBuffer(@g_Config.NakedAbilofTaos,SizeOf(TNakedAbility));
  end;    // case
  SendSocket(@m_DefMsg,sSendMsg);
end;

function TBaseObject.GetAttackDir(BaseObject: TBaseObject; var btDir: Byte): Boolean; //004C3CA0
begin
  Result:=False;
  if (m_nCurrX -1 <= BaseObject.m_nCurrX) and
     (m_nCurrX +1 >= BaseObject.m_nCurrX) and
     (m_nCurrY -1 <= BaseObject.m_nCurrY) and
     (m_nCurrY +1 >= BaseObject.m_nCurrY) and
     ((m_nCurrX <> BaseObject.m_nCurrX) or
     (m_nCurrY <> BaseObject.m_nCurrY)) then begin
    Result:=True;
    if ((m_nCurrX -1) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
      btDir:=DR_LEFT;
      exit;
    end;
    if ((m_nCurrX +1) = BaseObject.m_nCurrX) and (m_nCurrY = BaseObject.m_nCurrY) then begin
      btDir:=DR_RIGHT;
      exit;
    end;
    if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY - 1) = BaseObject.m_nCurrY) then begin
      btDir:=DR_UP;
      exit;
    end;
    if (m_nCurrX = BaseObject.m_nCurrX) and ((m_nCurrY + 1) = BaseObject.m_nCurrY) then begin
      btDir:=DR_DOWN;
      exit;
    end;
    if ((m_nCurrX -1) = BaseObject.m_nCurrX) and ((m_nCurrY - 1) = BaseObject.m_nCurrY) then begin
      btDir:=DR_UPLEFT;
      exit;
    end;
    if ((m_nCurrX +1) = BaseObject.m_nCurrX) and ((m_nCurrY - 1) = BaseObject.m_nCurrY) then begin
      btDir:=DR_UPRIGHT;
      exit;
    end;
    if ((m_nCurrX -1) = BaseObject.m_nCurrX) and ((m_nCurrY + 1) = BaseObject.m_nCurrY) then begin
      btDir:=DR_DOWNLEFT;
      exit;
    end;
    if ((m_nCurrX +1) = BaseObject.m_nCurrX) and ((m_nCurrY + 1) = BaseObject.m_nCurrY) then begin
      btDir:=DR_DOWNRIGHT;
      exit;
    end;
    btDir:=0;
  end;
end;

function TBaseObject.TargetInSpitRange(BaseObject: TBaseObject;var btDir: Byte): Boolean; //004C3E68
var
  nX,nY:Integer;
begin
  Result:=False;
  if (abs(BaseObject.m_nCurrX - m_nCurrX) <= 2) and (abs(BaseObject.m_nCurrY - m_nCurrY) <= 2) then begin
    nX:=BaseObject.m_nCurrX - m_nCurrX;
    nY:=BaseObject.m_nCurrY - m_nCurrY;
    if (abs(nX) <= 1) and (abs(nY) <= 1) then begin
      GetAttackDir(BaseObject,btDir);
      Result:=True;
      exit;
    end;
    Inc(nX,2);
    Inc(nY,2);
    if ((nX >= 0) and (nX <= 4)) and ((nY >= 0) and (nY <= 4)) then begin
      btDir:=GetNextDirection(m_nCurrX,m_nCurrY,BaseObject.m_nCurrX,BaseObject.m_nCurrY);
      if g_Config.SpitMap[btDir,nY,nX] = 1 then
        Result:=True;
    end;

  end;

end;

//004BF6F0
function TBaseObject.RecalcBagWeight:Integer;
var
  I: Integer;
  UserItem:PTUserItem;
  StdItem:TItem;
begin
  Result:=0;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[i];
    StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      if StdItem.StdMode = 45 then
        inc(Result,(StdItem.Weight * UserItem.Amount))
      else
        Inc(Result,StdItem.Weight);
    end;
  end;
end;
//004BFD50
procedure TBaseObject.RecalcHitSpeed;
var
  I: Integer;
  UserMagic:pTUserMagic;
  BonusTick:pTNakedAbility;
begin
  BonusTick:=nil;
  case m_btJob of
    jWarr: BonusTick:=@g_Config.BonusAbilofWarr;
    jWizard: BonusTick:=@g_Config.BonusAbilofWizard;
    jTaos: BonusTick:=@g_Config.BonusAbilofTaos;
  end;
  m_btHitPoint:=DEFHIT + m_BonusAbil.Hit div BonusTick.Hit;

  case m_btJob of
    jTaos: m_btSpeedPoint := DEFSPEED + m_BonusAbil.Speed div BonusTick.Speed + 3;  //档荤绰 扁夯 刮酶捞 臭促.
    else m_btSpeedPoint := DEFSPEED + m_BonusAbil.Speed div BonusTick.Speed;
  end;


  m_nHitPlus:=0;
  m_nHitDouble:=0;
  
  m_MagicOneSwordSkill  := nil;
  m_MagicPowerHitSkill  := nil;
  m_MagicErgumSkill     := nil;
  m_MagicBanwolSkill    := nil;
  m_MagicRedBanwolSkill := nil;
  m_MagicFireSwordSkill := nil;
  m_MagicCrsSkill       := nil;
  m_MagicTwnHitSkill    := nil;

  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic:=m_MagicList.Items[i];
    case UserMagic.wMagIdx of
      SKILL_ONESWORD: begin  //内功心法
        m_MagicOneSwordSkill:=UserMagic;
        if UserMagic.btLevel > 0 then begin
          m_btHitPoint:=m_btHitPoint + ROUND(9/3* UserMagic.btLevel);
        end;
      end;
      SKILL_YEDO: begin //攻杀剑法
        m_MagicPowerHitSkill:=UserMagic;
        if UserMagic.btLevel > 0 then begin
          m_btHitPoint:=m_btHitPoint + ROUND(3/3* UserMagic.btLevel);
        end;
        m_nHitPlus:=DEFHIT + UserMagic.btLevel;
        m_btAttackSkillCount:=7 - UserMagic.btLevel;
        m_btAttackSkillPointCount:=Random(m_btAttackSkillCount);
      end;
      SKILL_ERGUM: begin //刺杀剑法
        m_MagicErgumSkill:=UserMagic;
      end;
      SKILL_BANWOL: begin //半月弯刀
        m_MagicBanwolSkill:=UserMagic;
      end;
      {SKILL_REDBANWOL: begin
        m_MagicRedBanwolSkill:=UserMagic;
      end;}
      SKILL_FIRESWORD: begin //烈火剑法
        m_MagicFireSwordSkill:=UserMagic;
        m_nHitDouble:= 4 + UserMagic.btLevel * 4;
      end;
      SKILL_ILKWANG: begin //基本剑法
        m_MagicOneSwordSkill:=UserMagic;
        if UserMagic.btLevel > 0 then begin
          m_btHitPoint:=m_btHitPoint + ROUND(8/3* UserMagic.btLevel);
        end;
      end;
      SKILL_CROSSMOON: begin
        m_MagicCrsSkill:=UserMagic;
      end;
      SKILL_TWINBLADE: begin
        m_MagicTwnHitSkill:=UserMagic;
      end;
    end;
  end;
end;
//004BFFD0
procedure TBaseObject.AddItemSkill(nIndex: Integer);
var
  Magic      :pTMagic;
  UserMagic  :pTUserMagic;
begin
  Magic:=nil;
  case nIndex of
    1: Magic:=UserEngine.FindMagic(g_Config.sFireBallSkill);
    2: Magic:=UserEngine.FindMagic(g_Config.sHealSkill);
  end;
  if Magic <> nil then begin
    if not IsTrainingSkill(Magic.wMagicId) then begin
      New(UserMagic);
      UserMagic.MagicInfo  := Magic;
      UserMagic.wMagIdx    := Magic.wMagicId;
      UserMagic.btKey      := 0;
      UserMagic.btLevel    := 1;
      UserMagic.nTranPoint := 0;
      m_MagicList.Add(UserMagic);
      if m_btRaceServer = RC_PLAYOBJECT then begin
        TPlayObject(Self).SendAddMagic(UserMagic);
      end;
    end;
  end;
end;

function TBaseObject.AddToMap: Boolean; //004BA5E4
var
  Point:Pointer;
begin
  Point:=m_PEnvir.AddToMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
  if Point <> nil then Result:=True
  else Result:=False;
  if not m_boFixedHideMode then
    SendRefMsg(RM_TURN,m_btDirection,m_nCurrX,m_nCurrY,0,'');
end;

procedure TBaseObject.AttackDir(TargeTBaseObject: TBaseObject; wHitMode: Word;
  nDir: Integer);//004C2C50
  function GetMagicSpell(UserMagic:pTUserMagic):Integer;
  begin
    Result:=ROUND(UserMagic.MagicInfo.wSpell / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1));
  end;
  //武器升级设置
  procedure CheckWeaponUpgradeStatus(UserItem:pTUserItem); //004C27C0
  begin
    //if (UserItem.btValue[0] + UserItem.btValue[1] + UserItem.btValue[2]) < 20 then begin
    if (UserItem.btValue[0] + UserItem.btValue[1] + UserItem.btValue[2]) < g_Config.nUpgradeWeaponMaxPoint then begin
      case UserItem.btValue[10] of
        1: UserItem.wIndex:=0;
        10..13: UserItem.btValue[0]:=UserItem.btValue[0] + UserItem.btValue[10] - 9;
        20..23: UserItem.btValue[1]:=UserItem.btValue[1] + UserItem.btValue[10] - 19;
        30..33: UserItem.btValue[2]:=UserItem.btValue[2] + UserItem.btValue[10] - 29;
      end;
    end else UserItem.wIndex:=0;
    UserItem.btValue[10]:=0;
  end;
  procedure CheckWeaponUpgrade(); //004C2854
  var
    UseItems:TUserItem;
    PlayObject:TPlayObject;
    StdItem:TItem;
  begin
    if m_UseItems[U_WEAPON].btValue[10] > 0 then begin
      UseItems:=m_UseItems[U_WEAPON];
      CheckWeaponUpgradeStatus(@m_UseItems[U_WEAPON]);
      if m_UseItems[U_WEAPON].wIndex = 0 then begin
        SysMsg(g_sTheWeaponBroke,c_Red,t_Hint);
        PlayObject:=TPlayObject(Self);
        PlayObject.SendDelItems(@UseItems);
        //PlayObject.StatusChanged;
        SendRefMsg(RM_BREAKWEAPON,0,0,0,0,'');
        StdItem:=UserEngine.GetStdItem(UseItems.wIndex);
        //004C29E0
        if StdItem.NeedIdentify = 1 then
          AddGameDataLog('21' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     //UserEngine.GetStdItemName(UseItems.wIndex) + #9 +
                     StdItem.Name + #9 +
                     IntToStr(UseItems.MakeIndex) + #9 +
                     '1' + #9 +
                     '0');
        FeatureChanged();
      end else begin
        SysMsg(sTheWeaponRefineSuccessfull,c_Red,t_Hint);
        PlayObject:=TPlayObject(Self);
        PlayObject.SendUpdateItem(@m_UseItems[U_WEAPON]);
        StdItem:=UserEngine.GetStdItem(UseItems.wIndex);
        //004C2B14
        if StdItem.NeedIdentify = 1 then
          AddGameDataLog('20' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     //UserEngine.GetStdItemName(UseItems.wIndex) + #9 +
                     StdItem.Name + #9 +
                     IntToStr(UseItems.MakeIndex) + #9 +
                     '1' + #9 +
                     '0');
        RecalcAbilitys();
        SendMsg(Self,RM_ABILITY,0,0,0,0,'');
        SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
      end;
    end;
  end;
var
  AttackTarget :TBaseObject;
  boPowerHit   :Boolean;
  boFireHit    :Boolean;
  boCrsHit     :Boolean;
  bo41         :Boolean;
  boTwinHit    :Boolean;
  bo43         :Boolean;
  wIdent       :Word;
  nCheckCode   :Integer;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::AttackDir Code: %d';
begin //004C2C50
  nCheckCode:=0;
try
  if (wHitMode = 5) and (m_MagicBanwolSkill <> nil) then begin //半月
    if m_WAbil.MP > 0 then begin
      DamageSpell(m_MagicBanwolSkill.MagicInfo.btDefSpell + GetMagicSpell(m_MagicBanwolSkill));
      HealthSpellChanged();
    end else wHitMode:=RM_HIT;
  end;
  if (wHitMode = 12) and (m_MagicRedBanwolSkill <> nil) then begin
    if m_WAbil.MP > 0 then begin
      DamageSpell(m_MagicRedBanwolSkill.MagicInfo.btDefSpell + GetMagicSpell(m_MagicRedBanwolSkill));
      HealthSpellChanged();
    end else wHitMode:=RM_HIT;
  end;
  if (wHitMode = 8) and (m_MagicCrsSkill <> nil) then begin
    if m_WAbil.MP > 0 then begin
      DamageSpell(m_MagicCrsSkill.MagicInfo.btDefSpell + GetMagicSpell(m_MagicCrsSkill));
      HealthSpellChanged();
    end else wHitMode:=RM_HIT;
  end;

  nCheckCode:=4;
  m_btDirection:=nDir;
  if TargeTBaseObject = nil then begin
    nCheckCode:=41;
    AttackTarget:=GetPoseCreate();
  end else AttackTarget:=TargeTBaseObject;
  if (AttackTarget <> nil) and (m_UseItems[U_WEAPON].wIndex > 0) then begin
    nCheckCode:=42;
    CheckWeaponUpgrade();
  end;
  nCheckCode:=5;
  boPowerHit:=m_boPowerHit;
  boFireHit:=m_boFireHitSkill;
  boCrsHit:=m_boCrsHitkill;
  bo41:=m_bo41kill;
  boTwinHit:=m_boTwinHitSkill;
  bo43:=m_bo43kill;
  if _Attack(wHitMode,AttackTarget) then begin
    nCheckCode:=6;
    SetTargetCreat(AttackTarget); //$FFF2
    nCheckCode:=7;
  end;
  wIdent:=RM_HIT;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    case wHitMode of
      0: wIdent:=RM_HIT;
      1: wIdent:=RM_HEAVYHIT;
      2: wIdent:=RM_BIGHIT;
      3: if boPowerHit then wIdent:=RM_SPELL2;
      4: if m_MagicErgumSkill <> nil then wIdent:=RM_LONGHIT;
      5: if m_MagicBanwolSkill <> nil then wIdent:=RM_WIDEHIT;
      7: if boFireHit then wIdent:=RM_FIREHIT;
      8: if m_MagicCrsSkill <> nil then wIdent:=RM_CRSHIT;
      9: if boTwinHit then wIdent:=RM_TWINHIT;
      {10: if boTwinHit then wIdent:=RM_TWINHIT;
      11: if bo43 then wIdent:=RM_43;}
      12: if m_MagicRedBanwolSkill <> nil then wIdent:=RM_WIDEHIT;
    end;
  end;
  nCheckCode:=8;
  SendAttackMsg(wIdent,m_btDirection,m_nCurrX,m_nCurrY);
  nCheckCode:=9;
except
  on e: Exception do begin
    MainOutMessage(format(sExceptionMsg,[nCheckCode]));
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TBaseObject.CheckPKStatus;//004BC83C
begin
  if m_boPKFlag and ((GetTickCount - m_dwPKTick) > g_Config.dwPKFlagTime{60 * 1000}) then begin
    m_boPKFlag:=False;
    RefNameColor();
  end;
end;

procedure TBaseObject.DamageSpell(nSpellPoint: Integer); //004BE50C
begin
  if nSpellPoint > 0 then begin
    if (m_WAbil.MP - nSpellPoint) > 0 then
      Dec(m_WAbil.MP,nSpellPoint)
    else m_WAbil.MP:=0;
  end else begin
    if (m_WAbil.MP - nSpellPoint) < m_WAbil.MaxMP then
      Dec(m_WAbil.MP,nSpellPoint)
    else m_WAbil.MP:=m_WAbil.MaxMP;
  end;    
end;

//004BF520
procedure TBaseObject.DecPKPoint(nPoint: Integer);
var
  nC:Integer;
begin
  nC:=PKLevel();
  Dec(m_nPkPoint,nPoint);
  if m_nPkPoint < 0 then m_nPkPoint:=0;
  if (PKLevel <> nC) and (nC > 0 ) and (nC <= 2)then begin
    RefNameColor();
  end;
end;

//004C01B8
procedure TBaseObject.DelItemSkill(nIndex: Integer);
  procedure DeleteSkill(sSkillName:String); //004C00B8
  var
    I: Integer;
    UserMagic:pTUserMagic;
    PlayObject:TPlayObject;
  begin
    for I := 0 to m_MagicList.Count - 1 do begin
      UserMagic:=m_MagicList.Items[i];
      if UserMagic.MagicInfo.sMagicName = sSkillName then begin
        PlayObject:=TPlayObject(Self);
        PlayObject.SendDelMagic(UserMagic);
        Dispose(UserMagic);
        m_MagicList.Delete(i);
        break;
      end;
    end;
  end;
begin
  if m_btRaceServer <> RC_PLAYOBJECT then exit;
  case nIndex of
    1: if m_btJob <> jWizard then DeleteSkill(g_Config.sFireBallSkill);
    2: if m_btJob <> jTaos then DeleteSkill(g_Config.sHealSkill)
  end;
end;

//004C39E8
procedure TBaseObject.DelMember(BaseObject: TBaseObject);
var
  I: Integer;
  PlayObject:TPlayObject;
begin
  if m_GroupOwner <> BaseObject then begin
    for I := 0 to m_GroupMembers.Count - 1 do begin
      if m_GroupMembers.Objects[i] = BaseObject then begin
        BaseObject.LeaveGroup();
        m_GroupMembers.Delete(i);
        break;
      end;
    end;
  end else begin//004C3A65
    for I := m_GroupMembers.Count - 1 downto 0  do begin
      TBaseObject(m_GroupMembers.Objects[i]).LeaveGroup;
      m_GroupMembers.Delete(i);
    end;
  end;
  PlayObject:=TPlayObject(Self);
  if not PlayObject.CancelGroup then begin
    PlayObject.SendDefMessage(SM_GROUPCANCEL,0,0,0,0,'');
  end else PlayObject.SendGroupMembers();
end;

procedure TBaseObject.DoDamageWeapon(nWeaponDamage: Integer); //004C17B4
var
  nDura,nDuraPoint:Integer;
  PlayObject:TPlayObject;
  StdItem:TItem;
begin
  //Fixed routine, few minor mistakes.
  if not m_boCanLooseDura then exit;
  if m_UseItems[U_WEAPON].wIndex <= 0 then exit;

  nDura:=m_UseItems[U_WEAPON].Dura;
  nDuraPoint:=Round(nDura / 1000);
  Dec(nDura,nWeaponDamage);
  if nDura <= 0 then begin
    nDura:=0;
    m_UseItems[U_WEAPON].Dura:=nDura; 
    SendMsg(Self,RM_DURACHANGE,U_WEAPON,m_UseItems[U_WEAPON].Dura,m_UseItems[U_WEAPON].DuraMax,0,'');
   if m_btRaceServer = RC_PLAYOBJECT then begin
      PlayObject:=TPlayObject(Self);
//      PlayObject.SendDelItems(@m_UseItems[U_WEAPON]); //Nicky no breaking at dura 0
      StdItem:=UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
      PlayObject.SysMsg(StdItem.Name+'''s durability has dropped to 0.',c_Green,t_Hint);
            //004C195A
      {if StdItem.NeedIdentify = 1 then
            AddGameDataLog ('3' + #9 +
                        m_sMapName + #9 +
                        IntToStr(m_nCurrX) + #9 +
                        IntToStr(m_nCurrY) + #9 +
                        m_sCharName + #9 +
                        StdItem.Name + #9 +
                        IntToStr(m_UseItems[U_WEAPON].MakeIndex) + #9 +
                        BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
                        '0');}
    end;
//    m_UseItems[U_WEAPON].wIndex:=0;
    RecalcAbilitys();

    //Remove special effects
//    SendMsg(Self,RM_DURACHANGE,U_WEAPON,m_UseItems[U_WEAPON].Dura,m_UseItems[U_WEAPON].DuraMax,0,'');
    SendMsg(Self,RM_ABILITY, 0, 0, 0, 0, '');
    SendMsg(Self,RM_SUBABILITY, 0, 0, 0, 0, '');
  end else begin //004C199D
    m_UseItems[U_WEAPON].Dura:=nDura;
  end;
  if (nDura / 1000) <> nDuraPoint then begin
    SendMsg(Self,RM_DURACHANGE,U_WEAPON,m_UseItems[U_WEAPON].Dura,m_UseItems[U_WEAPON].DuraMax,0,'');
  end;
end;

procedure TBaseObject.GetAccessory(UserItem: TUserItem;var AddAbility: TAddAbility); //004C0EBC
var
  Item:TItem;
  StdItem:TStdItem;
begin
  Item:=UserEngine.GetStdItem(UserItem.wIndex);
  if Item = nil then exit;
  Item.GetItemAddValue(@UserItem,StdItem);

  case Item.ItemType of
    ITEM_WEAPON: begin
      if HiWord(StdItem.MAC) > 10 then begin
        Inc(AddAbility.nHitSpeed,HiWord(StdItem.MAC) - 10);
      end else begin
        Dec(AddAbility.nHitSpeed,HiWord(StdItem.MAC));
      end;
      Inc(AddAbility.btLuck,LoWord(StdItem.AC));
      Inc(AddAbility.btUnLuck,LoWord(StdItem.MAC));
      Inc(AddAbility.wSpeedPoint, HiByte(StdItem.Tox));
      Inc(AddAbility.wHitPoint, HiByte(StdItem.SlowDown));
    end;
    ITEM_ARMOR: begin
      AddAbility.wAC:=MakeLong(LoWord(AddAbility.wAC) + LoWord(StdItem.AC),HiWord(AddAbility.wAC) + HiWord(StdItem.AC));
      AddAbility.wMAC:=MakeLong(LoWord(AddAbility.wMAC) + LoWord(StdItem.MAC),HiWord(AddAbility.wMAC) + HiWord(StdItem.MAC));

      Inc(AddAbility.btLuck,LoByte(StdItem.Source));
      Inc(AddAbility.btUnLuck,HiByte(StdItem.Source));
      Inc(AddAbility.wSpeedPoint, HiByte(StdItem.Tox));
      Inc(AddAbility.wHitPoint, HiByte(StdItem.SlowDown));
    end;
    ITEM_ACCESSORY: begin
      case Item.StdMode of
        19,20: begin//necklace with luck
          Dec(AddAbility.nHitSpeed,HiWord(StdItem.AC));
          Inc(AddAbility.nHitSpeed,LoWord(StdItem.AC));
          Inc(AddAbility.btUnLuck,LoWord(StdItem.MAC));
          Inc(AddAbility.btLuck,HiWord(StdItem.MAC));
          Inc(AddAbility.wSpeedPoint, HiByte(StdItem.Tox));
          Inc(AddAbility.wHitPoint, HiByte(StdItem.SlowDown));
        end;
        21: begin//necklace with hp/mp recovery
          Dec(AddAbility.nHitSpeed,HiWord(StdItem.AC));
          Inc(AddAbility.nHitSpeed,LoWord(StdItem.AC));
          Inc(AddAbility.wHealthRecover,LoWord(StdItem.MAC));
          Inc(AddAbility.wSpellRecover,HiWord(StdItem.MAC));
          Inc(AddAbility.wSpeedPoint, HiByte(StdItem.Tox));
          Inc(AddAbility.wHitPoint, HiByte(StdItem.SlowDown));
        end;
        22,23: begin
          AddAbility.wAC:=MakeLong(LoWord(AddAbility.wAC) + LoWord(StdItem.AC),HiWord(AddAbility.wAC) + HiWord(StdItem.AC));
          AddAbility.wMAC:=MakeLong(LoWord(AddAbility.wMAC) + LoWord(StdItem.MAC),HiWord(AddAbility.wMAC) + HiWord(StdItem.MAC));
          Inc(AddAbility.nHitSpeed, HiByte(StdItem.Tox));
          Inc(AddAbility.wHitPoint, HiByte(StdItem.SlowDown));
        end;
        62: begin //boots
          AddAbility.wAC:=MakeLong(LoWord(AddAbility.wAC) + LoWord(StdItem.AC),HiWord(AddAbility.wAC) + HiWord(StdItem.AC));
          AddAbility.wMAC:=MakeLong(LoWord(AddAbility.wMAC) + LoWord(StdItem.MAC),HiWord(AddAbility.wMAC) + HiWord(StdItem.MAC));
          Inc(AddAbility.wSpeedPoint, HiByte(StdItem.Tox));
          Inc(AddAbility.HandWeight,StdItem.Source);
          Inc(AddAbility.WearWeight,HiByte(StdItem.SlowDown));
        end;
        63: begin //stones
          Inc(AddAbility.btUnLuck,LoWord(StdItem.MAC));
          Inc(AddAbility.btLuck,HiWord(StdItem.MAC));
        end;
        64: begin //Belt
          AddAbility.wAC:=MakeLong(LoWord(AddAbility.wAC) + LoWord(StdItem.AC),HiWord(AddAbility.wAC) + HiWord(StdItem.AC));
          AddAbility.wMAC:=MakeLong(LoWord(AddAbility.wMAC) + LoWord(StdItem.MAC),HiWord(AddAbility.wMAC) + HiWord(StdItem.MAC));
          Inc(AddAbility.Weight, StdItem.Source);
          Inc(AddAbility.wSpeedPoint, HiByte(StdItem.Tox));
          Inc(AddAbility.wHitPoint, HiByte(StdItem.SlowDown));
        end;
        else begin
          AddAbility.wAC:=MakeLong(LoWord(AddAbility.wAC) + LoWord(StdItem.AC),HiWord(AddAbility.wAC) + HiWord(StdItem.AC));
          AddAbility.wMAC:=MakeLong(LoWord(AddAbility.wMAC) + LoWord(StdItem.MAC),HiWord(AddAbility.wMAC) + HiWord(StdItem.MAC));
          Inc(AddAbility.wSpeedPoint, HiByte(StdItem.Tox));
          Inc(AddAbility.wHitPoint, HiByte(StdItem.SlowDown));
        end;
      end;
    end;
  end;

  Inc(AddAbility.wHP,LoByte(StdItem.HpAdd));
  Inc(AddAbility.wMP,LoByte(StdItem.MpAdd));
  Inc(AddAbility.wHealthRecover, HiByte(StdItem.HpAdd));
  Inc(AddAbility.wSpellRecover, HiByte(StdItem.MpAdd));
  Inc(AddAbility.wPoisonIncrease,LoByte(StdItem.Tox));
  Inc(AddAbility.wFreezingIncrease,LoByte(StdItem.SlowDown));
  Inc(AddAbility.wAntiMagic, StdItem.MagAvoid);
  Inc(AddAbility.wAntiPoison, StdItem.ToxAvoid);
  AddAbility.wDC:=MakeLong(LoWord(AddAbility.wDC) + LoWord(StdItem.DC),HiWord(AddAbility.wDC) + HiWord(StdItem.DC));
  AddAbility.wMC:=MakeLong(LoWord(AddAbility.wMC) + LoWord(StdItem.MC),HiWord(AddAbility.wMC) + HiWord(StdItem.MC));
  AddAbility.wSC:=MakeLong(LoWord(AddAbility.wSC) + LoWord(StdItem.SC),HiWord(AddAbility.wSC) + HiWord(StdItem.SC));
end;

//004BF180
{
function TBaseObject.GetCharColor(BaseObject:TBaseObject): Byte;
var
  n10:Integer;
  nCheckCode:Integer;
begin
  nCheckCode:=0;
try
  Result:=BaseObject.GetNamecolor();
  nCheckCode:=1;
  if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
    if BaseObject.PKLevel < 2 then begin
      if BaseObject.m_boPKFlag then Result:=g_Config.btPKFlagNameColor;//$2F
      nCheckCode:=2;
      n10:=GetGuildRelation(Self,BaseObject);
      nCheckCode:=3;
      case n10 of
        1,3: Result:=g_Config.btAllyAndGuildNameColor;//$B4;
        2: Result:=g_Config.btWarGuildNameColor;//$45;
      end;
      if BaseObject.m_PEnvir.m_boFight3Zone then begin
        if m_MyGuild = BaseObject.m_MyGuild then Result:=g_Config.btAllyAndGuildNameColor//$B4
        else Result:=g_Config.btWarGuildNameColor//$45;
      end;
    end; //004BF218
    nCheckCode:=4;
    if UserCastle.m_boUnderWar and m_boInFreePKArea and BaseObject.m_boInFreePKArea then begin
      nCheckCode:=5;
      Result:=g_Config.btInFreePKAreaNameColor;//$DD;
      m_boGuildWarArea:=True;
      nCheckCode:=6;
      if (m_MyGuild = nil) then exit;        
      if UserCastle.IsMasterGuild(TGuild(m_MyGuild)) then begin
        nCheckCode:=7;
        if (m_MyGuild = BaseObject.m_MyGuild) or
           (TGuild(m_MyGuild).IsAllyGuild(TGuild(BaseObject.m_MyGuild))) then begin
          nCheckCode:=8;
          Result:=g_Config.btAllyAndGuildNameColor//$B4;
        end else begin //004BF2A8
          nCheckCode:=9;
          if UserCastle.IsAttackGuild(TGuild(BaseObject.m_MyGuild)) then begin
            nCheckCode:=10;
            Result:=g_Config.btWarGuildNameColor//$45;
          end;
        end;
      end else begin //004BF2CE
        nCheckCode:=11;
        if UserCastle.IsAttackGuild(TGuild(m_MyGuild)) then begin
          nCheckCode:=12;
          if (m_MyGuild = BaseObject.m_MyGuild) or
             (TGuild(m_MyGuild).IsAllyGuild(TGuild(BaseObject.m_MyGuild))) then begin
            nCheckCode:=13;
            Result:=g_Config.btAllyAndGuildNameColor//$B4;
          end else begin
            nCheckCode:=14;
            if UserCastle.IsMember(BaseObject) then begin
              nCheckCode:=15;
              Result:=g_Config.btWarGuildNameColor//$45;
            end;
          end;
        end; //004BF379
      end;
    end;
  end else begin //004BF339
    //if (BaseObject.m_btSlaveExpLevel - 8) < 0 then begin
    if (BaseObject.m_btSlaveExpLevel < SLAVEMAXLEVEL) then begin
      Result:=g_Config.SlaveColor[BaseObject.m_btSlaveExpLevel];
    end;
    if BaseObject.m_boCrazyMode then Result:=$F9;
    if BaseObject.m_boHolySeize then Result:=$7D;
  end;
except
  on e: Exception do begin
    MainOutMessage('[Exception] TBaseObject.GetCharColor Code: ' + IntToStr(nCheckCode));
    MainOutMessage(E.Message);
  end;
end;
end;
}
function TBaseObject.GetCharColor(BaseObject:TBaseObject): Byte;
var
  n10:Integer;
  nCheckCode:Integer;
  Castle:TUserCastle;
begin
  nCheckCode:=0;
  Result:=BaseObject.GetNamecolor();
  nCheckCode:=1;
  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer = MONSTER_CLONE) then begin
    if BaseObject.PKLevel < 2 then begin
      if BaseObject.m_boPKFlag then Result:=g_Config.btPKFlagNameColor;//$2F
      nCheckCode:=2;
      n10:=GetGuildRelation(Self,BaseObject);
      nCheckCode:=3;
      case n10 of
        1,3: Result:=g_Config.btAllyAndGuildNameColor;//$B4;
        2: Result:=g_Config.btWarGuildNameColor;//$45;
      end;
      if BaseObject.m_PEnvir.Flag.boFight3Zone then begin
        if m_MyGuild = BaseObject.m_MyGuild then Result:=g_Config.btAllyAndGuildNameColor//$B4
        else Result:=g_Config.btWarGuildNameColor//$45;
      end;
    end; //004BF218
    nCheckCode:=4;
    Castle:=g_CastleManager.InCastleWarArea(BaseObject);
//    if  UserCastle.m_boUnderWar and m_boInFreePKArea and BaseObject.m_boInFreePKArea then begin
    if (Castle <> nil) and Castle.m_boUnderWar and m_boInFreePKArea and BaseObject.m_boInFreePKArea then begin
      nCheckCode:=5;
      Result:=g_Config.btInFreePKAreaNameColor;//$DD;
      m_boGuildWarArea:=True;
      nCheckCode:=6;
      if (m_MyGuild = nil) then exit;        
//      if UserCastle.IsMasterGuild(TGuild(m_MyGuild)) then begin
      if Castle.IsMasterGuild(TGuild(m_MyGuild)) then begin
        nCheckCode:=7;
        if (m_MyGuild = BaseObject.m_MyGuild) or
           (TGuild(m_MyGuild).IsAllyGuild(TGuild(BaseObject.m_MyGuild))) then begin
          nCheckCode:=8;
          Result:=g_Config.btAllyAndGuildNameColor//$B4;
        end else begin //004BF2A8
          nCheckCode:=9;
          //if UserCastle.IsAttackGuild(TGuild(BaseObject.m_MyGuild)) then begin
          if Castle.IsAttackGuild(TGuild(BaseObject.m_MyGuild)) then begin
            nCheckCode:=10;
            Result:=g_Config.btWarGuildNameColor//$45;
          end;
        end;
      end else begin //004BF2CE
        nCheckCode:=11;
//        if UserCastle.IsAttackGuild(TGuild(m_MyGuild)) then begin
        if Castle.IsAttackGuild(TGuild(m_MyGuild)) then begin
          nCheckCode:=12;
          if (m_MyGuild = BaseObject.m_MyGuild) or
             (TGuild(m_MyGuild).IsAllyGuild(TGuild(BaseObject.m_MyGuild))) then begin
            nCheckCode:=13;
            Result:=g_Config.btAllyAndGuildNameColor//$B4;
          end else begin
            nCheckCode:=14;
//            if UserCastle.IsMember(BaseObject) then begin
            if Castle.IsMember(BaseObject) then begin
              nCheckCode:=15;
              Result:=g_Config.btWarGuildNameColor//$45;
            end;
          end;
        end; //004BF379
      end;
    end;
  end else begin //004BF339
    //if (BaseObject.m_btSlaveExpLevel - 8) < 0 then begin
    if (BaseObject.m_btSlaveExpLevel < SLAVEMAXLEVEL) then begin
      Result:=g_Config.SlaveColor[BaseObject.m_btSlaveExpLevel];
    end;
    if BaseObject.m_boCrazyMode then Result:=$F9;
    if BaseObject.m_boHallucMode then Result:=$FD; //Hallucination 
    //if BaseObject.m_boNastyMode then Result:=$F9;
    if BaseObject.m_boHolySeize then Result:=$7D;
  end;
end;
function TBaseObject.GetLevelExp(nLevel:Integer):LongWord;//004BEDC8
begin
  if nLevel <= MAXLEVEL{51} then begin
    Result:=g_Config.dwNeedExps[nLevel]
  end else begin
    Result:=g_Config.dwNeedExps[High(g_Config.dwNeedExps)];
    //Result:=$FFFFFFFF;
  end;
end;

//004BF144
function  TBaseObject.GetNamecolor():Byte;
begin
  Result:=m_btNameColor;
  if PKLevel = 1 then Result:=g_Config.btPKLevel1NameColor;//$FB;
  if PKLevel >= 2 then Result:= g_Config.btPKLevel2NameColor;//$F9;
end;

procedure TBaseObject.HearMsg(sMsg: String);//004BB2A0
begin
  if sMsg <> '' then SendMsg(nil,RM_HEAR,0,g_Config.btHearMsgFColor,g_Config.btHearMsgBColor,0,sMsg);
end;

function TBaseObject.InSafeArea():Boolean;//004BEF8C
var
  I: Integer;
  StartPoint:pTStartPoint;
begin
  Result := False;
  g_StartPoint.Lock;
  try
    for I := 0 to g_StartPoint.Count - 1 do begin
      StartPoint:=g_StartPoint.Items[I];
      if StartPoint.Envir = m_PEnvir then begin
        if (abs(m_nCurrX - StartPoint.nX) <= 60) and (abs(m_nCurrY - StartPoint.nY) <= 60) then begin
          Result:=True;
          break;
        end;
      end;
    end;
  finally
    g_StartPoint.UnLock;
  end;
end;

procedure TBaseObject.MonsterRecalcAbilitys; //004BE934
var
  n8:Integer;
begin
  m_WAbil.DC:=MakeLong(LoWord(m_WAbil.DC),HiWord(m_Abil.DC));
  n8:=0;
  if (m_btRaceServer = MONSTER_WHITESKELETON) or
     (m_btRaceServer = MONSTER_ELFMONSTER) or
     (m_btRaceServer = MONSTER_ELFWARRIOR) then begin


    m_WAbil.DC:=MakeLong(LoWord(m_WAbil.DC),ROUND((m_btSlaveExpLevel * 0.1 + 0.3) * 3.0 * m_btSlaveExpLevel + HiWord(m_WAbil.DC)));
    n8:=n8 + ROUND((m_btSlaveExpLevel * 0.1 + 0.3) * m_Abil.MaxHP) * m_btSlaveExpLevel;
    n8:=n8 + m_Abil.MaxHP;
    if m_btSlaveExpLevel > 0 then m_WAbil.MaxHP:=n8
    else m_WAbil.MaxHP:=m_Abil.MaxHP;
  end else begin //004BEA85
    n8:=m_Abil.MaxHP;
    m_WAbil.DC:=MakeLong(LoWord(m_WAbil.DC),ROUND(m_btSlaveExpLevel * 2 + HiWord(m_WAbil.DC)));
    n8:=n8 + ROUND(m_Abil.MaxHP * 0.15) * m_btSlaveExpLevel;
    m_WAbil.MaxHP:=_MIN(ROUND(m_Abil.MaxHP + m_btSlaveExpLevel * 60),n8);
    //m_WAbil.MAC:=0; 01/20 取消此行，防止怪物升级后魔防变0
  end;
  //m_btHitPoint:=15; 01/20 取消此行，防止怪物升级后准确率变15
end;
procedure TPlayObject.ShowMapInfo(sMap,sX,sY:String);
var
  Map:TEnvirnoment;
  nX,nY:Integer;
  MapCellInfo:pTMapCellinfo;
begin
  nX:=Str_ToInt(sX,0);
  nY:=Str_ToInt(sY,0);
  if (sMap <> '') and (nX >= 0) and (nY >= 0)then begin
    Map:=g_MapManager.FindMap(sMap);
    if Map <> nil then begin
      if Map.GetMapCellInfo(nX,nY,MapCellInfo) then begin
        SysMsg('Cell Flag: ' + IntToStr(MapCellInfo.chFlag),c_Green,t_Hint);
        if MapCellInfo.ObjList <> nil then begin
          SysMsg('Cell Count: ' + IntToStr(MapCellInfo.ObjList.Count),c_Green,t_Hint);
        end;
      end else begin
        SysMsg('Failed to get cell information for map: ' + sMap ,c_Red,t_Hint);
      end;
    end;
  end else begin
    SysMsg('Usage: @' + g_GameCommand.MAPINFO.sCmd + ' <MAP> <X> <Y>',c_Green,t_Hint);
  end;
end;



procedure TBaseObject.SendFirstMsg(BaseObject: TBaseObject; wIdent, wParam: Word;
  lParam1, lParam2, lParam3: Integer; sMsg: String); //004B84FC
var
  SendMessage:pTSendMessage;
begin
    try
      EnterCriticalSection(ProcessMsgCriticalSection);
      if not m_boGhost then begin
        New(SendMessage);
        SendMessage.wIdent         :=wIdent;
        SendMessage.wParam         :=wParam;
        SendMessage.nParam1        :=lParam1;
        SendMessage.nParam2        :=lParam2;
        SendMessage.nParam3        :=lParam3;
        SendMessage.dwDeliveryTime :=0;
        SendMessage.BaseObject       :=BaseObject;
        if sMsg <> '' then begin
          try
            GetMem(SendMessage.Buff,Length(sMsg) + 1);
            Move(sMsg[1],SendMessage.Buff^,Length(sMsg) + 1);
          except
            SendMessage.Buff:=nil;
          end;
        end else begin
          SendMessage.Buff:=nil;
        end;
        m_MsgList.Insert(0,SendMessage);
      end;
    finally
      LeaveCriticalSection(ProcessMsgCriticalSection);
    end;
end;

procedure TBaseObject.SendMsg(BaseObject: TBaseObject; wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: String);//004B865C
var
  SendMessage:pTSendMessage;
begin
    try
      EnterCriticalSection(ProcessMsgCriticalSection);
      if not m_boGhost then begin
        New(SendMessage);
        SendMessage.wIdent         :=wIdent;
        SendMessage.wParam         :=wParam;
        SendMessage.nParam1        :=nParam1;
        SendMessage.nParam2        :=nParam2;
        SendMessage.nParam3        :=nParam3;
        SendMessage.dwDeliveryTime :=0;
        SendMessage.BaseObject     :=BaseObject;
        SendMessage.boLateDelivery :=False;
        if sMsg <> '' then begin
          try
            GetMem(SendMessage.Buff,Length(sMsg) + 1);
            Move(sMsg[1],SendMessage.Buff^,Length(sMsg) + 1);
          except
            SendMessage.Buff:=nil;
          end;
        end else begin
          SendMessage.Buff:=nil;
        end;
        m_MsgList.Add(SendMessage);
      end;
    finally
      LeaveCriticalSection(ProcessMsgCriticalSection);
    end;
end;

procedure TBaseObject.SendDelayMsg(BaseObject: TBaseObject; wIdent,
  wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: String;
  dwDelay: LongWord);//004B87C4
var
  SendMessage:pTSendMessage;
begin
    try
      EnterCriticalSection(ProcessMsgCriticalSection);
      if not m_boGhost then begin
        New(SendMessage);
        SendMessage.wIdent         :=wIdent;
        SendMessage.wParam         :=wParam;
        SendMessage.nParam1        :=lParam1;
        SendMessage.nParam2        :=lParam2;
        SendMessage.nParam3        :=lParam3;
        SendMessage.dwDeliveryTime :=GetTickCount + dwDelay;
        SendMessage.BaseObject     :=BaseObject;
        SendMessage.boLateDelivery :=True;
        if sMsg <> '' then begin
          try
            GetMem(SendMessage.Buff,Length(sMsg) + 1);
            Move(sMsg[1],SendMessage.Buff^,Length(sMsg) + 1);
          except
            SendMessage.Buff:=nil;
          end;
        end else begin
          SendMessage.Buff:=nil;
        end;
        m_MsgList.Add(SendMessage);
      end;
    finally
      LeaveCriticalSection(ProcessMsgCriticalSection);
    end;
end;

procedure TBaseObject.SendUpdateDelayMsg(BaseObject: TBaseObject; wIdent,
  wParam: Word; lParam1, lParam2, lParam3: Integer; sMsg: String;
  dwDelay: LongWord);//004B8930
var
  SendMessage:pTSendMessage;
  i:integer;
begin
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    i:=0;
    while (True) do begin
      if m_MsgList.Count <= i then break;
      SendMessage:=m_MsgList.Items[i];
      if (SendMessage.wIdent = wIdent) and (SendMessage.nParam1 = lParam1) then begin
        m_MsgList.Delete(i);
        if SendMessage.Buff <> nil then FreeMem(SendMessage.Buff);
        Dispose(SendMessage);
        Continue;
      end;
      Inc(i);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
  SendDelayMsg(BaseObject,wIdent,wParam,lParam1,lParam2,lParam3,sMsg,dwDelay);
end;

procedure TBaseObject.SendUpdateMsg(BaseObject: TBaseObject; wIdent, wParam: Word;
  lParam1, lParam2, lParam3: Integer; sMsg: String);//004B8A7C
var
  SendMessage:pTSendMessage;
  i:Integer;
begin
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    i:=0;
    while (True) do begin
      if m_MsgList.Count <= i then break;
      SendMessage:=m_MsgList.Items[i];
      if SendMessage.wIdent = wIdent then begin
        m_MsgList.Delete(i);
        if SendMessage.Buff <> nil then FreeMem(SendMessage.Buff);
        Dispose(SendMessage);
        Continue;
      end;
      Inc(i);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
  SendMsg(BaseObject,wIdent,wParam,lParam1,lParam2,lParam3,sMsg);
end;

procedure TBaseObject.SendActionMsg(BaseObject: TBaseObject; wIdent, wParam: Word;
  lParam1, lParam2, lParam3: Integer; sMsg: String);//004B8A7C
var
  SendMessage:pTSendMessage;
  i:Integer;
begin
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    i:=0;
    while (True) do begin
      if m_MsgList.Count <= i then break;
      SendMessage:=m_MsgList.Items[i];
      if (SendMessage.wIdent = CM_TURN) or
         (SendMessage.wIdent = CM_WALK) or
         (SendMessage.wIdent = CM_SITDOWN) or
         (SendMessage.wIdent = CM_HORSERUN) or
         (SendMessage.wIdent = CM_RUN) or
         (SendMessage.wIdent = CM_HIT) or
         (SendMessage.wIdent = CM_HEAVYHIT) or
         (SendMessage.wIdent = CM_BIGHIT) or
         (SendMessage.wIdent = CM_POWERHIT) or
         (SendMessage.wIdent = CM_LONGHIT) or
         (SendMessage.wIdent = CM_WIDEHIT) or
         (SendMessage.wIdent = CM_FIREHIT) then begin
        m_MsgList.Delete(i);
        if SendMessage.Buff <> nil then FreeMem(SendMessage.Buff);
        Dispose(SendMessage);
        Continue;
      end;
      Inc(i);
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
  SendMsg(BaseObject,wIdent,wParam,lParam1,lParam2,lParam3,sMsg);
end;

function TBaseObject.GetMessage(Msg:pTProcessMessage): Boolean;//004B8BA4($FFFF)
var
  I:Integer;
  SendMessage:pTSendMessage;
begin
  Result:=False;
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    I:=0;
    Msg.wIdent:=0;
    while m_MsgList.Count > I do begin
      SendMessage:=m_MsgList.Items[I];
      if (SendMessage.dwDeliveryTime <> 0) and (GetTickCount < SendMessage.dwDeliveryTime)then begin
        Inc(I);
        Continue;
      end;
      m_MsgList.Delete(I);
      Msg.wIdent:=SendMessage.wIdent;
      Msg.wParam:=SendMessage.wParam;
      Msg.nParam1:=SendMessage.nParam1;
      Msg.nParam2:=SendMessage.nParam2;
      Msg.nParam3:=SendMessage.nParam3;
      Msg.BaseObject:=SendMessage.BaseObject;
      Msg.dwDeliveryTime:=SendMessage.dwDeliveryTime;
      Msg.boLateDelivery:=SendMessage.boLateDelivery;
      if SendMessage.Buff <> nil then begin
        Msg.sMsg:=StrPas(SendMessage.Buff);
        FreeMem(SendMessage.Buff);
      end else begin
        Msg.sMsg:='';
      end;
      Dispose(SendMessage);
      Result:=True;
      break;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TBaseObject.GetMapBaseObjects(tEnvir: TEnvirnoment; nX, nY,nRage: Integer; rList: TList):Boolean;//004B8D2C
var
  III: Integer;
  x,y: Integer;
  nStartX,nStartY,nEndX,nEndY:Integer;
  MapCellInfo:pTMapCellinfo;
  OSObject:pTOSObject;
  BaseObject:TBaseObject;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::GetMapBaseObjects';
begin
  Result:=False;
  if rList = nil then exit;
  try
    nStartX:=nX - nRage;
    nEndX:=nX + nRage;
    nStartY:=nY - nRage;
    nEndY:=nY + nRage;
    for x:= nStartX to nEndX do begin
      for y := nStartY to nEndY do begin
        if tEnvir.GetMapCellInfo(x,y,MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for III := 0 to MapCellInfo.ObjList.Count - 1 do begin
            OSObject:=MapCellInfo.ObjList.Items[III];
            if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
              BaseObject:=TBaseObject(OSObject.CellObj);
              if (BaseObject <> nil) and (not BaseObject.m_boDeath) and (not BaseObject.m_boGhost) then begin
                rList.Add(BaseObject);
              end;
            end;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
  Result:=True;
end;

procedure TBaseObject.SendRefMsg(wIdent, wParam: Word; nParam1, nParam2, nParam3: Integer; sMsg: String);//004B8EBC
var
  II,nC: Integer;
  nCX,nCY,nLX,nLY,nHX,nHY:Integer;
  MapCellInfo:pTMapCellinfo;
  OSObject:pTOSObject;
  BaseObject:TBaseObject;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::SendRefMsg Name = %s';
begin
  if m_PEnvir = nil then begin
    MainOutMessage(m_sCharName + ' SendRefMsg nil PEnvir ');
    exit;
  end;
  //if m_boObMode or m_boFixedHideMode then exit;
  //01/21 增加，原来直接不发信息，如果隐身模式则只发送信息给自己
  if m_boObMode or m_boFixedHideMode then begin
  try
    SendMsg(Self,wIdent,wParam,nParam1,nParam2,nParam3,sMsg);
  except
    MainOutMessage(format(sExceptionMsg,[m_sCharName]));
    MainOutMessage('Please contact thedeath and tell him you saw msg number 1');
  end;
    exit;
  end;

  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    if ((GetTickCount - m_SendRefMsgTick) >= 500) or (m_VisibleHumanList.Count = 0) then begin
      m_SendRefMsgTick:=GetTickCount();
      m_VisibleHumanList.Clear;
      nLX:=m_nCurrX - g_Config.nSendRefMsgRange{12};
      nHX:=m_nCurrX + g_Config.nSendRefMsgRange{12};
      nLY:=m_nCurrY - g_Config.nSendRefMsgRange{12};
      nHY:=m_nCurrY + g_Config.nSendRefMsgRange{12};
      for nCX:= nLX to nHX do begin
        for nCY:= nLY to nHY do begin
            if m_PEnvir.GetMapCellInfo(nCX,nCY,MapCellInfo) then begin
              if MapCellInfo.ObjList <> nil then begin
                for II := MapCellInfo.ObjList.Count - 1 downto 0 do begin
                  OSObject:=MapCellInfo.ObjList.Items[II];
                  if OSObject <> nil then begin
                    if OSObject.btType = OS_MOVINGOBJECT then begin
                      if (GetTickCount - OSObject.dwAddTime) >= 60 * 1000 then begin
                        try
                          DisPose(OSObject);
                          MapCellInfo.ObjList.Delete(II);
                          if MapCellInfo.ObjList.Count <= 0 then begin
                            MapCellInfo.ObjList.Free;
                            MapCellInfo.ObjList:=nil;
                            break;
                          end;
                        except
                          MainOutMessage(format(sExceptionMsg,[m_sCharName]));
                          MainOutMessage('Please contact thedeath and tell him you saw msg number 2');
                        end;
                      end else begin//004B90A4
                        try
                          BaseObject:=TBaseObject(OSObject.CellObj);
                          if (BaseObject <> nil)and not BaseObject.m_boGhost then begin
                            if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                              BaseObject.SendMsg(Self,wIdent,wParam,nParam1,nParam2,nParam3,sMsg);
                              m_VisibleHumanList.Add(BaseObject);
                            end else //004B9125
                            if BaseObject.m_boWantRefMsg then begin
                              if (wIdent = RM_STRUCK) or (wIdent = RM_HEAR) or (wIdent = RM_DEATH) then begin
                                BaseObject.SendMsg(Self,wIdent,wParam,nParam1,nParam2,nParam3,sMsg);
                                m_VisibleHumanList.Add(BaseObject);
                              end;
                            end;
                          end;
                        except
                          on e: Exception do begin
                            MapCellInfo.ObjList.Delete(II);
                            if MapCellInfo.ObjList.Count <= 0 then begin
                              MapCellInfo.ObjList.Free;
                              MapCellInfo.ObjList:=nil;
                            end;
                            MainOutMessage(format(sExceptionMsg,[m_sCharName]));
                            MainOutMessage(E.Message);
                          end;
                        end;
                      end;
                    end;
                  end;
                end; //for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
              end; //if MapCellInfo.ObjList <> nil then begin
            end; //if PEnvir.GetMapCellInfo(nC,n10,MapCellInfo) then begin
        end;
      end;
      exit;
    end; //004B91FC

    for nC:= 0 to m_VisibleHumanList.Count - 1 do begin
    try
      BaseObject:=TBaseObject(m_VisibleHumanList.Items[nC]);
    except
      MainOutMessage(format(sExceptionMsg,[m_sCharName]));
      MainOutMessage('Please contact thedeath and tell him you saw msg number 4');
    end;
      if BaseObject.m_boGhost then Continue;
  try
      if (BaseObject.m_PEnvir = m_PEnvir) and
         (abs(BaseObject.m_nCurrX - m_nCurrX) < 11) and
         (abs(BaseObject.m_nCurrY - m_nCurrY) < 11) then begin
        if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          BaseObject.SendMsg(Self,wIdent,wParam,nParam1,nParam2,nParam3,sMsg);
        end else
        if BaseObject.m_boWantRefMsg then begin
          if (wIdent = RM_STRUCK) or (wIdent = RM_HEAR) or (wIdent = RM_DEATH) then begin
            BaseObject.SendMsg(Self,wIdent,wParam,nParam1,nParam2,nParam3,sMsg);
          end;
        end; //if BaseObject.m_boWantRefMsg then begin
      end; //if (BaseObject.m_PEnvir = m_PEnvir) and
  except
    MainOutMessage(format(sExceptionMsg,[m_sCharName]));
    MainOutMessage('Please contact thedeath and tell him you saw msg number 3');
  end;
    end; //for nC:= 0 to m_VisibleHumanList.Count - 1 do begin
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TBaseObject.UpdateVisibleGay(BaseObject:TBaseObject);//004B939C
var
  I                 :Integer;
  boIsVisible       :Boolean;
  VisibleBaseObject :pTVisibleBaseObject;
begin
  boIsVisible:=False;
  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_Master <> nil) then
    m_boIsVisibleActive:=True;//如果是人物或宝宝则置TRUE
  for I := 0 to m_VisibleActors.Count - 1 do begin
    VisibleBaseObject:=m_VisibleActors.Items[i];
    if VisibleBaseObject.BaseObject = BaseObject then begin
      VisibleBaseObject.nVisibleFlag:=1;
      boIsVisible:=True;
      break;
    end;
  end;
  if boIsVisible then exit;
  New(VisibleBaseObject);
  VisibleBaseObject.nVisibleFlag := 2;
  VisibleBaseObject.BaseObject   := BaseObject;
  m_VisibleActors.Add(VisibleBaseObject);
end;

procedure TBaseObject.UpdateVisibleItem(wX, wY: Integer; MapItem: PTMapItem);//004B94FC
var
  I: Integer;
  boIsVisible:Boolean;
  VisibleMapItem:pTVisibleMapItem;
begin
  boIsVisible:=False;
  for I := 0 to m_VisibleItems.Count - 1 do begin
    VisibleMapItem:=m_VisibleItems.Items[i];
    if VisibleMapItem.MapItem = MapItem then begin
      VisibleMapItem.nVisibleFlag:=1;
      boIsVisible:=True;
      break;
    end;
  end;
  if boIsVisible then exit;
    New(VisibleMapItem);
    VisibleMapItem.nVisibleFlag:=2;
    VisibleMapItem.nX:=wX;
    VisibleMapItem.nY:=wY;
    VisibleMapItem.MapItem:=MapItem;
    VisibleMapItem.sName:=MapItem.Name;
    VisibleMapItem.wLooks:=MapItem.Looks;
    m_VisibleItems.Add(VisibleMapItem);
end;

procedure TBaseObject.UpdateVisibleEvent(wX, wY: Integer; MapEvent: TObject); //004B95D0
var
  I: Integer;
  boIsVisible:Boolean;
  Event:TEvent;
begin
  boIsVisible:=False;
  for I := 0 to m_VisibleEvents.Count - 1 do begin
    Event:=m_VisibleEvents.Items[i];
    if Event = MapEvent then begin
      Event.nVisibleFlag:=1;
      boIsVisible:=True;
      break;
    end;
  end;
  if boIsVisible then exit;
  TEvent(MapEvent).nVisibleFlag:=2;
  TEvent(MapEvent).m_nX:=wX;
  TEvent(MapEvent).m_nY:=wY;
  m_VisibleEvents.Add(MapEvent);
end;
function TBaseObject.IsVisibleHuman: Boolean;
var
  I:Integer;
  VisibleBaseObject:pTVisibleBaseObject;
begin
  Result:=False;
  for I := 0 to m_VisibleActors.Count - 1 do begin
    VisibleBaseObject:=m_VisibleActors.Items[i];
    if (VisibleBaseObject.BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (VisibleBaseObject.BaseObject.m_Master <> nil) then begin
      Result:=True;
      break;
    end;
  end;
end;

procedure TBaseObject.SearchViewRange;//004B966C
var
  I           :Integer;
  nStartX     :Integer;
  nEndX       :Integer;
  nStartY     :Integer;
  nEndY       :Integer;
  n18         :Integer;
  n1C         :Integer;
  nIdx        :Integer;
  n24         :Integer;
  MapCellInfo :pTMapCellinfo;
  OSObject    :pTOSObject;
  BaseObject  :TBaseObject;
  VisibleBaseObject:pTVisibleBaseObject;
  nCheckCode       :Integer;
ResourceString
  sExceptionMsg1 = '[Exception] TBaseObject::SearchViewRange Code:%d';
  sExceptionMsg2 = '[Exception] TBaseObject::SearchViewRange 1-%d %s %s %d %d %d';

begin
  nCheckCode:=0;
  if m_PEnvir = nil then begin
    MainOutMessage('SearchViewRange nil PEnvir');
    exit;
  end;
  nCheckCode:=1;
  n24:=0;
  m_boIsVisibleActive:=False;//先置为FALSE
  try
    nCheckCode:=4;
    for I := 0 to m_VisibleActors.Count - 1 do begin
      pTVisibleBaseObject(m_VisibleActors.Items[I]).nVisibleFlag:=0;
    end;
    nCheckCode:=5;
  except
    MainOutMessage(format(sExceptionMsg1,[nCheckCode]));
    KickException();
  end;
  nCheckCode:=6;

  nStartX :=m_nCurrX - m_nViewRange;
  nEndX   :=m_nCurrX + m_nViewRange;
  nStartY :=m_nCurrY - m_nViewRange;
  nEndY   :=m_nCurrY + m_nViewRange;
  try
    nCheckCode:=7;
    for n18:= nStartX to nEndX do begin
      nCheckCode:=8;
      for n1C:= nStartY to nEndY  do begin
        nCheckCode:=9;
        if m_PEnvir.GetMapCellInfo(n18,n1C,MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          nCheckCode:=10;
          n24:=1;
          nIdx:=0;
          while (True) do begin
            nCheckCode:=11;
            if MapCellInfo.ObjList.Count <= nIdx then break;    //004B9858
              OSObject:=MapCellInfo.ObjList.Items[nIdx];
              nCheckCode:=12;
              if OSObject <> nil then begin
                nCheckCode:=13;
                if OSObject.btType = OS_MOVINGOBJECT then begin
                  nCheckCode:=14;
                  if (GetTickCount - OSObject.dwAddTime) >= 60 * 1000 then begin
                    Dispose(OSObject);
                    MapCellInfo.ObjList.Delete(nIdx);
                    if MapCellInfo.ObjList.Count > 0 then Continue;
                    MapCellInfo.ObjList.Free;
                    MapCellInfo.ObjList:=nil;
                    break;
                  end; //004B9907
                  nCheckCode:=15;
                  BaseObject:=TBaseObject(OSObject.CellObj);
                  if BaseObject <> nil then begin
                    nCheckCode:=16;
                    if not BaseObject.m_boGhost and not BaseObject.m_boFixedHideMode and not BaseObject.m_boObMode then begin
                      nCheckCode:=17;
                      if (m_btRaceServer < RC_ANIMAL) or
                         (m_Master <> nil) or
                         m_boCrazyMode or
                         m_boNastyMode or
                         m_boHallucMode or //Hallucination
                         m_boWantRefMsg or
                         ((BaseObject.m_Master <> nil) and (abs(BaseObject.m_nCurrX - m_nCurrX) <= 3) and (abs(BaseObject.m_nCurrY - m_nCurrY) <= 3)) or
                         (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                            nCheckCode:=18;
                            UpdateVisibleGay(BaseObject);
                            nCheckCode:=19;
                      end;
                    end;
                  end;
                end;
              end;
            Inc(nIdx);
          end;
        end;
      end;
    end;
  except
    on e: Exception do begin

      MainOutMessage(format(sExceptionMsg2,[n24,m_sCharName,m_sMapName,m_nCurrX,m_nCurrY,nCheckCode]));
      {
      MainOutMessage(m_sCharName + ',' +
                     m_sMapName + ',' +
                     IntToStr(m_nCurrX) + ',' +
                     IntToStr(m_nCurrY) + ',' +
                     ' SearchViewRange 1-' +
                     IntToStr(n24));
      }
      MainOutMessage(E.Message);
      KickException();
    end;
  end;

  nCheckCode:=40;
  n24:=2;
  try
    n18:=0;
    while (True) do begin
      if m_VisibleActors.Count <= n18 then break;
      nCheckCode:=41;
      VisibleBaseObject:=m_VisibleActors.Items[n18];
      nCheckCode:=42;
      if VisibleBaseObject.nVisibleFlag = 0 then begin
        nCheckCode:=43;
        m_VisibleActors.Delete(n18);
        nCheckCode:=48;
        Dispose(VisibleBaseObject);
        nCheckCode:=49;
        Continue;
      end;
      nCheckCode:=50;
      Inc(n18);
    end;
  except
    on e: Exception do begin
      MainOutMessage(format(sExceptionMsg2,[n24,m_sCharName,m_sMapName,m_nCurrX,m_nCurrY,nCheckCode]));
    {MainOutMessage(m_sCharName + ',' +
                   m_sMapName + ',' +
                   IntToStr(m_nCurrX) + ',' +
                   IntToStr(m_nCurrY) + ',' +
                   ' SearchViewRange 2');}
      KickException();
    end;
  end;
end;

function TBaseObject.GetFeatureToLong: Integer; //004BA23C
begin
  Result:=GetFeature(nil);
end;
function TBaseObject.GetFeatureEx():Word;
begin
  if m_boOnHorse then begin
    Result:=MakeWord(m_btHorseType,m_btDressEffType);
  end else begin
    Result:=MakeWord(0,m_btDressEffType);
  end;
end;
function TBaseObject.GetFeature(BaseObject: TBaseObject):Integer;//004BA25C
var
  nDress,nWeapon,nHair,nRaceImg,nAppr:Integer;
  StdItem:TItem;
  bo25:Boolean;
begin
  if (m_btRaceServer = RC_PLAYOBJECT) or (m_btRaceServer = MONSTER_CLONE) then begin
    nDress:=0;
    //衣服
    if m_UseItems[U_DRESS].wIndex > 0 then begin
      StdItem:=UserEngine.GetStdItem(m_UseItems[U_DRESS].wIndex);
      if StdItem <> nil then begin
        nDress:=StdItem.Shape * 2;
      end;
    end;
    Inc(nDress,m_btGender);
    nWeapon:=0;
    //武器
    if m_UseItems[U_WEAPON].wIndex > 0 then begin
      StdItem:=UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
      if StdItem <> nil then begin
        nWeapon:=StdItem.Shape * 2;
      end;
    end;
    Inc(nWeapon,m_btGender);
    {nHelmet:=0;
    //头盔
    if m_UseItems[U_HELMET].wIndex > 0 then begin
      StdItem:=UserEngine.GetStdItem(m_UseItems[U_HELMET].wIndex);
      if StdItem <> nil then begin
        nHelmet:=StdItem.Shape * 2;
      end;
    end;
    Inc(nHelmet,m_btGender); }

    nHair:=m_btHair * 2 + m_btGender;
    Result:=MakeHumanFeature(0,nDress,nWeapon,nHair);
    exit;
  end;//004BA32F
  
  bo25:=False;
  if (BaseObject <> nil) and (BaseObject.bo245) then
    bo25:=True;
  if bo25 then begin
    nRaceImg:=m_btRaceImg;
    nAppr:=m_wAppr;
    case nAppr of   
      0: begin
        nRaceImg:=12;
        nAppr:=5;
      end;
      1: begin
        nRaceImg:=11;
        nAppr:=9;
      end;
      160: begin
        nRaceImg:=10;
        nAppr:=0;
      end;
      161: begin
        nRaceImg:=10;
        nAppr:=1;
      end;
      162: begin
        nRaceImg:=11;
        nAppr:=6;
      end;
      163: begin
        nRaceImg:=11;
        nAppr:=3;
      end;
    end;
    
    Result:=MakeMonsterFeature(nRaceImg,m_btMonsterWeapon,nAppr);
    exit;
  end;//004BA40E

  Result:=MakeMonsterFeature(m_btRaceImg,m_btMonsterWeapon,m_wAppr);
end;

function TBaseObject.GetCharStatus():UINT;//004BA43C
var
  I: Integer;
  nStatus:DWord;
begin
  nStatus:=0;
  for I := Low(TStatusTime) to High(TStatusTime) do begin
    if m_wStatusTimeArr[I] > 0 then begin
      nStatus:=($80000000 shr I) or nStatus;
    end;
  end;
  Result:=(m_nCharStatusEx and $FFFFF) or nStatus;
end;

procedure TBaseObject.AbilCopyToWAbil;//004BA494
begin
  m_WAbil:=m_Abil;
end;

procedure TBaseObject.Initialize;//4BA4B8
var
  I: Integer;
  UserMagic:pTUserMagic;
begin
  AbilCopyToWAbil();
  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic:=m_MagicList.Items[i];
    if UserMagic.btLevel >= 4 then UserMagic.btLevel:=0;
  end;
  m_boAddtoMapSuccess:=True;
  if m_PEnvir.CanWalk(m_nCurrX,m_nCurrY,True) and AddToMap() then
    m_boAddtoMapSuccess:=False;
  m_nCharStatus:=GetCharStatus();
  AddBodyLuck(0);
  LoadSayMsg();
  if g_Config.boMonSayMsg then MonsterSayMsg(nil,s_MonGen);
end;
//==============================
//取得怪物说话信息列表
procedure TBaseObject.LoadSayMsg();
var
  I: Integer;
begin
  for I := 0 to g_MonSayMsgList.Count - 1 do begin
    if CompareText(g_MonSayMsgList.Strings[I],m_sCharName) = 0 then begin
      m_SayMsgList:=TList(g_MonSayMsgList.Objects[I]);
      break;
    end;
  end;
end;
procedure TBaseObject.Disappear(); //004BA580
begin

end;

procedure TBaseObject.FeatureChanged;//004BA58C
begin
  SendRefMsg(RM_FEATURECHANGED,GetFeatureEx,GetFeatureToLong,0,0,'')
end;

procedure TBaseObject.StatusChanged();//004BA5B4
begin
  SendRefMsg(RM_CHARSTATUSCHANGED, m_nHitSpeed,m_nCharStatus, 0, 0, '')
end;

procedure TBaseObject.DisappearA(); //004BA65C
begin
  m_PEnvir.DeleteFromMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
  SendRefMsg(RM_DISAPPEAR, 0, 0, 0, 0, '');
end;

procedure  TBaseObject.KickException; //004BA6A8
var
  PlayObject:TPlayObject;
begin
   if m_btRaceServer = RC_PLAYOBJECT then begin
      m_sMapName := g_Config.sHomeMap;
      m_nCurrX := g_Config.nHomeX;
      m_nCurrY := g_Config.nHomeY;
      PlayObject:= TPlayObject(self);
      PlayObject.m_boEmergencyClose := TRUE;
   end else begin  //
      m_boDeath:=True;
      m_dwDeathTick:=GetTickCount;
      MakeGhost;
   end;
end;

function TBaseObject.Walk(nIdent:Integer):Boolean;//004BA724
var
  I: Integer;
  MapCellInfo:pTMapCellinfo;
  OSObject:pTOSObject;
  GateObj:pTGateObj;
  bo1D:Boolean;
  Event:TEvent;
  PlayObject:TPlayObject;
  nCheckCode:Integer;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::Walk  CheckCode:%d %s %s %d:%d';
begin
  Result:=True;
  nCheckCode:= -1;
  if m_PEnvir = nil then begin
    MainOutMessage('Walk nil PEnvir');
    exit;
  end;
  try
    nCheckCode:=1;
    bo1D:=m_PEnvir.GetMapCellInfo(m_nCurrX,m_nCurrY,MapCellInfo);
    GateObj:=nil;
    Event:=nil;
    nCheckCode:=2;
    if bo1D and (MapCellInfo.ObjList <> nil)then begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do begin
        OSObject:=MapCellInfo.ObjList.Items[i];
        if OSObject.btType = OS_GATEOBJECT then begin
         GateObj:=pTGateObj(OSObject.CellObj);
        end;
        if OSObject.btType = OS_EVENTOBJECT then begin
          if TEvent(OSObject.CellObj).m_OwnBaseObject <> nil then
            Event:=TEvent(OSObject.CellObj);
        end;
        if OSObject.btType = OS_MAPEVENT then begin

        end;
        if OSObject.btType = OS_DOOR then begin

        end;
        if OSObject.btType = OS_ROON then begin

        end;
      end;
    end;
    nCheckCode:=3;
    if Event <> nil then begin
      if Event.m_OwnBaseObject.IsProperTarget(Self) then  //FFF4
        SendMsg(Event.m_OwnBaseObject,RM_MAGSTRUCK_MINE,0,Event.m_nDamage,0,0,'');
    end;
    nCheckCode:=4;
    if Result and (GateObj <> nil) then begin
      if m_btRaceServer = RC_PLAYOBJECT then begin
        if m_PEnvir.ArroundDoorOpened(m_nCurrX,m_nCurrY) then begin
          //004BA89E
          if (not TEnvirnoment(GateObj.DEnvir).Flag.boNEEDHOLE) or (g_EventManager.GetEvent(m_PEnvir,m_nCurrX,m_nCurrY,ET_DIGOUTZOMBI) <> nil) then begin
            if nServerIndex = TEnvirnoment(GateObj.DEnvir).nServerIndex then begin
              if not EnterAnotherMap(TEnvirnoment(GateObj.DEnvir),GateObj.nDMapX,GateObj.nDMapY) then begin
                Result:=False;
              end;
            end else begin //004BA914
              DisappearA();
              m_bo316:=True;
              PlayObject:=TPlayObject(Self);
              PlayObject.m_sSwitchMapName:=TEnvirnoment(GateObj.DEnvir).sMapName;
              PlayObject.m_nSwitchMapX:=GateObj.nDMapX;
              PlayObject.m_nSwitchMapY:=GateObj.nDMapY;
              PlayObject.m_boSwitchData:=True;
              PlayObject.m_nServerIndex:=TEnvirnoment(GateObj.DEnvir).nServerIndex;
              PlayObject.m_boEmergencyClose:=True;
              PlayObject.m_boReconnection:=True;
            end;
          end;
        end;
      end else Result:=False;
    end else begin  //004BA998
      nCheckCode:=5;
      if Result then begin
        nCheckCode:=6;
        SendRefMsg(nIdent,m_btDirection,m_nCurrX,m_nCurrY,0,'');
      end;
    end;
  except
    on e: Exception do begin
      MainOutMessage(format(sExceptionMsg,[nCheckCode,m_sCharname,m_sMapName,m_nCurrX,m_nCurrY]));
      {MainOutMessage('[Exception] TBaseObject.Walk  CheckCode: ' + IntToStr(nCheckCode) + ' ' +
                    m_sCharname + ' ' +
                    m_sMapName + ' ' +
                    IntToStr(m_nCurrX) + ':' +
                    IntToStr(m_nCurrY));}
      MainOutMessage(E.Message);
    end;
  end;
end;

function TBaseObject.EnterAnotherMap(Envir: TEnvirnoment; nDMapX,
  nDMapY: Integer): Boolean; //004BAADC
var
  I           :Integer;
  MapCellInfo :pTMapCellinfo;
  OldEnvir    :TEnvirnoment;
  nOldX       :Integer;
  nOldY       :Integer;
  Castle      :TUserCastle;
ResourceString
  sExceptionMsg1 = '[Exception] TBaseObject::EnterAnotherMap -> MsgTargetList Clear';
  sExceptionMsg2 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleItems Dispose';
  sExceptionMsg3 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleItems Clear';
  sExceptionMsg4 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleEvents Clear';
  sExceptionMsg5 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleActors Dispose';
  sExceptionMsg6 = '[Exception] TBaseObject::EnterAnotherMap -> VisbleActors Clear';
  sExceptionMsg7 = '[Exception] TBaseObject::EnterAnotherMap';
begin
  Result:=False;
  try
    if m_Abil.Level < Envir.nRequestLevel then exit;
    if Envir.QuestNPC <> nil then TMerchant(Envir.QuestNPC).Click(TPlayObject(Self));
    if Envir.Flag.nNEEDSETONFlag >=  0 then begin
      if GetQuestFalgStatus(Envir.Flag.nNEEDSETONFlag) <> Envir.Flag.nNeedONOFF then exit;
    end;
    if not Envir.GetMapCellInfo(nDMapX,nDMapY,MapCellInfo) then exit;
    Castle:=g_CastleManager.IsCastlePalaceEnvir(Envir);
    if (Castle <> nil) and (m_btRaceServer = RC_PLAYOBJECT) then begin
      if not Castle.CheckInPalace(m_nCurrX,m_nCurrY,Self) then exit;
    end;
    {
    if (UserCastle.m_MapPalace = Envir) and (m_btRaceServer = RC_PLAYOBJECT) then begin
      if not UserCastle.CheckInPalace(m_nCurrX,m_nCurrY,Self) then exit;
    end;
    }
    {
    if (m_PEnvir.Flag.nGuildTerritory <> Envir.Flag.nGuildTerritory) and (Envir.Flag.nGuildTerritory <> -1) then begin
      if m_MyGuild = nil then exit;
      if g_GuildTerritory.GetTerritoryNumber(TGuild(m_MyGuild).sGuildName) <> Envir.Flag.nGuildTerritory then exit;
    end;
    }
    if Envir.Flag.boNOHORSE then m_boOnHorse:=False;
    OldEnvir:=m_PEnvir;
    nOldX:=m_nCurrX;
    nOldY:=m_nCurrY;
    DisappearA();
    try
      m_VisibleHumanList.Clear;
    except
      MainOutMessage(sExceptionMsg1);
    end;
    try
      for I := 0 to m_VisibleItems.Count - 1 do begin
        Dispose(pTVisibleMapItem(m_VisibleItems.Items[i]));
      end;
    except
      MainOutMessage(sExceptionMsg2);
    end;
    try
      m_VisibleItems.Clear;
    except
      MainOutMessage(sExceptionMsg3);
    end;

    try
      m_VisibleEvents.Clear;
    except
      MainOutMessage(sExceptionMsg4);
    end;
    try
      for I := 0 to m_VisibleActors.Count - 1 do begin
        Dispose(pTVisibleBaseObject(m_VisibleActors.Items[i]));
      end;
    except
      MainOutMessage(sExceptionMsg5);
    end;
    try
      m_VisibleActors.Clear;
    except
      MainOutMessage(sExceptionMsg6);
    end;
    SendMsg(Self,RM_CLEAROBJECTS,0,0,0,0,'');
    m_PEnvir:=Envir;
    m_sMapName:=Envir.sMapName;
    m_nCurrX:=nDMapX;
    m_nCurrY:=nDMapY;
    SendMsg(Self,RM_CHANGEMAP,0,0,0,0,Envir.sMapName);
    if AddToMap() then begin
      m_dwMapMoveTick:=GetTickCount();
      m_bo316:=True;
      Result:=True;
    end else begin
      m_PEnvir:=OldEnvir;
      m_nCurrX:=nOldX;
      m_nCurrY:=nOldY;
      m_PEnvir.AddToMap(m_nCurrX,m_nCurrY,OS_MOVINGOBJECT,Self);
    end;
    if m_btRaceServer = RC_PLAYOBJECT then begin
      TPlayObject(Self).m_dwIncGamePointTick:=GetTickCount();
      TPlayObject(Self).m_dwIncGameGoldTick:=GetTickCount();
      TPlayObject(Self).m_dwAutoGetExpTick:=GetTickCount();
    end;

    if m_PEnvir.Flag.boFight3Zone and (m_PEnvir.Flag.boFight3Zone <> OldEnvir.Flag.boFight3Zone) then
      RefShowName();
  except
    MainOutMessage(sExceptionMsg7);
  end;
end;

procedure TBaseObject.TurnTo(nDir: integer); //004BB048
begin
  m_btDirection:=nDir;
  SendRefMsg(RM_TURN,nDir,m_nCurrX,m_nCurrY,0,'');
end;

function TBaseObject.copyuseritem(UserItem:pTUserItem):pTUserItem;
var
  UserItem2:TUserItem;
begin
  UserItem2 := UserItem^;
  Result:=@UserItem2;
end;

procedure TBaseObject.ProcessSayMsg(sMsg: String);//004BB084
var
  sCharName:String;
begin
  if m_btRaceServer = RC_PLAYOBJECT then sCharName:=m_sCharName
  else sCharName:=FilterShowName(m_sCharName);    
  SendRefMsg(RM_HEAR,0,g_Config.btHearMsgFColor,g_Config.btHearMsgBColor,0, sCharName + ':' + sMsg);
end;

procedure TBaseObject.SysMsg(sMsg:String;MsgColor:TMsgColor;MsgType:TMsgType);//004BB124
begin
  if g_Config.boShowPreFixMsg then begin
    case MsgType of
      t_Mon: sMsg:=g_Config.sMonSayMsgpreFix + sMsg;
      t_Hint: sMsg:=g_Config.sHintMsgPreFix + sMsg;
    {
    s_GroupMsg: sMsg:=g_Config.sGroupMsgPreFix + sMsg;
    s_GuildMsg: sMsg:=g_Config.sGuildMsgPreFix + sMsg;
    }
      t_GM: sMsg:=g_Config.sGMRedMsgpreFix + sMsg;
      t_System: sMsg:=g_Config.sSysMsgPreFix + sMsg;
      t_Notice: sMsg:=g_Config.sLineNoticePreFix + sMsg;
      t_Cust:   sMsg:=g_Config.sCustMsgpreFix + sMsg;
      t_Castle: sMsg:=g_Config.sCastleMsgpreFix + sMsg;
      t_SVN1: begin
        SendMsg(Self,RM_SYSMESSAGE,0,$38,$FF,0,sMsg);
        exit;
      end;
      t_SVN2: begin
        SendMsg(Self,RM_SYSMESSAGE,0,$FF,$DB,0,sMsg);
        exit;
      end;
      t_SVN3: begin
        SendMsg(Self,RM_SYSMESSAGE,0,$FF,$38,0,sMsg);
        exit;
      end;
    end;
  end;
  case MsgColor of
    c_Green: SendMsg(Self,RM_SYSMESSAGE,0,g_Config.btGreenMsgFColor,g_Config.btGreenMsgBColor,0,sMsg);
    c_Blue: SendMsg(Self,RM_SYSMESSAGE,0,g_Config.btBlueMsgFColor,g_Config.btBlueMsgBColor,0,sMsg);
    c_RedWhite: SendMsg(Self,RM_SYSMESSAGE,0,255,151,0,sMsg);
    else begin
      if MsgType = t_Cust then begin
        SendMsg(Self,RM_SYSMESSAGE,0,g_Config.btCustMsgFColor,g_Config.btCustMsgBColor,0,sMsg);
      end else begin
        SendMsg(Self,RM_SYSMESSAGE,0,g_Config.btRedMsgFColor,g_Config.btRedMsgBColor,0,sMsg);
      end;
    end;
  end;
end;
procedure TBaseObject.MonsterSayMsg(AttackBaseObject:TBaseObject;MonStatus:TMonStatus);
var
  I: Integer;
  sMsg:String;
  MonSayMsg:pTMonSayMsg;
  sAttackName:String;
begin
  if m_SayMsgList = nil then exit;
  if (m_btRaceServer = RC_PLAYOBJECT) then exit;
  if (AttackBaseObject <> nil) then begin
    if (AttackBaseObject.m_btRaceServer <> RC_PLAYOBJECT) and (AttackBaseObject.m_Master = nil) then begin
      exit;
    end;
    if AttackBaseObject.m_Master <> nil then sAttackName:=AttackBaseObject.m_Master.m_sCharName
    else sAttackName:=AttackBaseObject.m_sCharName;
  end;
  for I := 0 to m_SayMsgList.Count - 1 do begin
    MonSayMsg:=m_SayMsgList.Items[I];
    sMsg:=AnsiReplaceText(MonSayMsg.sSayMsg,'%s',FilterShowName(m_sCharName));
    sMsg:=AnsiReplaceText(sMsg,'%d',sAttackName);
    if (MonSayMsg.State = MonStatus) and (Random(MonSayMsg.nRate) = 0) then begin
      if MonStatus = s_MonGen then begin
        UserEngine.SendBroadCastMsg(sMsg,t_Mon);
        break;
      end;
      if MonSayMsg.Color = c_White then begin
        ProcessSayMsg(sMsg);
      end else begin
        AttackBaseObject.SysMsg(sMsg,MonSayMsg.Color,t_Mon);
      end;
      break;
    end;
  end;
end;
procedure TBaseObject.SendGroupText(sMsg: String);//004BB1CC
var
  I: Integer;
  PlayObject:TPlayObject;
begin
  if g_Config.boShowPreFixMsg then
    sMsg:=g_Config.sGroupMsgPreFix + sMsg;

  if m_GroupOwner <> nil then begin
    for I := 0 to m_GroupOwner.m_GroupMembers.Count - 1 do  begin
      PlayObject:=TPlayObject(m_GroupOwner.m_GroupMembers.Objects[i]);
      PlayObject.SendMsg(Self,RM_GROUPMESSAGE,0,g_Config.btGroupMsgFColor,g_Config.btGroupMsgBColor,0,sMsg);
    end;
  end;    
end;



procedure TBaseObject.MakeGhost(); //004BB300
begin
  m_boGhost:=True;
  m_dwGhostTick:=GetTickCount();
  DisappearA();
end;

procedure TBaseObject.ApplyMeatQuality; //004BB32C
var
  I: Integer;
  StdItem:TItem;
  UserItem:pTUseritem;
begin
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[i];
    StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      if StdItem.StdMode = 40 then begin
        UserItem.Dura:=m_nMeatQuality;
      end;
    end;
  end;
end;

function TBaseObject.TakeBagItems(BaseObject: TBaseObject): Boolean; //004BB3B0
var
  UserItem:pTUseritem;
  PlayObject:TPlayObject;
begin
  Result:=False;
  while (True) do begin
    if BaseObject.m_ItemList.Count <= 0 then break;
    UserItem:=BaseObject.m_ItemList.Items[0];
    if not AddItemToBag(UserItem) then break;
    if Self is TPlayObject then begin
      PlayObject:=TPlayObject(Self);
      PlayObject.SendAddItem(UserItem);
      Result:=True;
    end;
    BaseObject.m_ItemList.Delete(0);
  end;
end;
{
procedure TBaseObject.ScatterBagItems(ItemOfCreat:TBaseObject); //004BB44C
var
   i, dropwide: integer;
   pu: PTUserItem;
   dellist: TStringList;
   boDropall: Boolean;
begin
   dellist := nil;
   if m_boAngryRing or m_boNoDropItem or m_PEnvir.Flag.boNODROPITEM then exit; //不死戒指

   boDropall := TRUE;
   if m_btRaceServer = RC_PLAYOBJECT then begin
      dropwide := 2;
      if PKLevel < 2 then boDropall := FALSE; //荤恩篮 1/3犬伏肺 冻焙促.
      //弧盎捞绰 促 冻焙促.
   end else
      dropwide := 3;

   try
      for i:=m_ItemList.Count-1 downto 0 do begin
         if (Random(3) = 0) or boDropall then begin
            if DropItemDown (pTUserItem(m_ItemList[i]), dropwide, TRUE,ItemOfCreat,Self) then begin
               pu := PTUserItem(m_ItemList[i]);
               if m_btRaceServer = RC_PLAYOBJECT then begin
                  if dellist = nil then dellist := TStringList.Create;
                  dellist.AddObject(UserEngine.GetStdItemName (pu.wIndex), TObject(pu.MakeIndex));
               end;
               Dispose(PTUserItem(m_ItemList[i]));
               m_ItemList.Delete (i);
            end;
         end;
      end;
      if dellist <> nil then begin
         SendMsg (self, RM_SENDDELITEMLIST, 0, integer(dellist), 0, 0, '');
      end;
   except
      MainOutMessage ('[Exception] TBaseObject.ScatterBagItems');
   end;
end;
}

procedure TBaseObject.ScatterBagItems(ItemOfCreat:TBaseObject); //004BB44C
const
  DropWide:Integer = 3;
var
  I,II:Integer;
  UserItem:pTUserItem;
  StdItem:TItem;
  boCanNotDrop:Boolean;
  MonDrop:pTMonDrop;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::ScatterBagItems';
begin
  try
    g_MonDropLimitLIst.Lock;
    try
      for I:=m_ItemList.Count - 1 downto 0 do begin
        UserItem:=m_ItemList.Items[I];
        StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
        boCanNotDrop:=False;
        if StdItem <> nil then begin
         if not StdItem.boCanDeathDrop then Continue; //Vexusdev
          for II:= 0 to g_MonDropLimitLIst.Count - 1 do begin
            if CompareText(StdItem.Name,g_MonDropLimitLIst.Strings[II]) = 0 then begin
              MonDrop:=pTMonDrop(g_MonDropLimitLIst.Objects[II]);
              if MonDrop.nDropCount < MonDrop.nCountLimit then begin
                Inc(MonDrop.nDropCount);
                g_MonDropLimitLIst.Objects[II]:=TObject(MonDrop);
              end else begin
                Inc(MonDrop.nNoDropCount);
                boCanNotDrop:=True;
              end;
              break;
            end;
          end;
        end;
        if boCanNotDrop then Continue;

        if DropItemDown(UserItem,DropWide,True,ItemOfCreat,Self) then begin
          Dispose(UserItem);
          m_ItemList.Delete(I);
        end;
      end;
    finally
      g_MonDropLimitLIst.UnLock;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;
procedure TBaseObject.ScatterGolds(GoldOfCreat:TBaseObject); //004BB63C
var
  I, nGold: integer;
begin
   if m_nGold > 0 then begin
      I:=0;
      while (True) do begin
//      for i:=0 to 18 do begin
         if m_nGold > g_Config.nMonOneDropGoldCount then begin
            nGold := g_Config.nMonOneDropGoldCount;
            m_nGold := m_nGold - g_Config.nMonOneDropGoldCount;
         end else begin
            nGold := m_nGold;
            m_nGold := 0;
         end;
         if nGold > 0 then begin
            if not DropGoldDown (nGold, TRUE,GoldOfCreat,Self) then begin
               m_nGold := m_nGold + nGold;
               break;
            end;
         end else break;
        Inc(I);
        if I >= 17 then break;          
      end;
      GoldChanged;
   end;
end;

procedure TBaseObject.DropUseItems(BaseObject:TBaseObject); //004BB6C8
var
  nC,nRate:Integer;
  StdItem:TItem;
  DropItemList:TStringList;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::DropUseItems';
begin
  DropItemList:=nil;
  try
    if m_boNoDropUseItem then exit;  
    if m_btRaceServer = RC_PLAYOBJECT then begin
      nC:=0;
      while (True) do begin
        StdItem:=UserEngine.GetStdItem(m_UseItems[nC].wIndex);
        if StdItem <> nil then begin
         if not StdItem.boCanDeathDrop then Continue; //Vexusdev
          if StdItem.Reserved and 8 <> 0 then begin
            if DropItemList = nil then DropItemList:=TStringList.Create;
            DropItemList.AddObject('',TObject(m_UseItems[nC].MakeIndex));
            //004BB885
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('16' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     //UserEngine.GetStdItemName(m_UseItems[nC].wIndex) + #9 +
                     StdItem.Name + #9 +
                     IntToStr(m_UseItems[nC].MakeIndex) + #9 +
                     BoolToIntStr(m_btRaceServer = RC_PLAYOBJECT) + #9 +
                     '0');
            m_UseItems[nC].wIndex:=0;
          end;
        end;
        Inc(nC);
        if nC >= 9 then break;
      end;
    end;
    if PKLevel > 2 then nRate:=15
    else nRate:=30;
    nC:=0;
    While (True) do begin
      if Random(nRate) = 0 then begin
        if DropItemDown(@m_UseItems[nC],2,True,BaseObject,Self) then begin
          StdItem:=UserEngine.GetStdItem(m_UseItems[nC].wIndex);
          if StdItem <> nil then begin
            if StdItem.Reserved and 10 = 0 then begin
              if m_btRaceServer = RC_PLAYOBJECT then begin
                if DropItemList = nil then DropItemList:=TStringList.Create;
                DropItemList.AddObject(UserEngine.GetStdItemName(m_UseItems[nC].wIndex),TObject(m_UseItems[nC].MakeIndex));
              end;
              m_UseItems[nC].wIndex:=0;
            end; //004BB9A9
          end;
        end; //004BB9A9
      end;
      Inc(nC);
      if nC >= 9 then break;
    end;
    if DropItemList <> nil then
      SendMsg(Self,RM_SENDDELITEMLIST,0,Integer(DropItemList),0,0,'');
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TBaseObject.Die; //004BBA98
var
  boPK,guildwarkill :Boolean;
  tStr:String;
  tExp:LongWord;
  i:Integer;
  GroupHuman:TPlayObject;
  QuestNPC:TMerchant;
  tCheck:Boolean;
  AttackBaseObject:TBaseObject;
  Castle:TUserCastle;
ResourceString
  sExceptionMsg1 = '[Exception] TBaseObject::Die 1';
  sExceptionMsg2 = '[Exception] TBaseObject::Die 2';
  sExceptionMsg3 = '[Exception] TBaseObject::Die 3';
begin
  //004BBABB
  if m_boSuperMan then exit;
  if m_boSupermanItem then exit;
    
  m_boDeath:=True;
  m_dwDeathTick:=GetTickCount();
  sub_4BC87C();
  if m_Master <> nil then begin
    m_ExpHitter:=nil;
    m_LastHiter:=nil;
  end;
  m_nIncSpell   :=0;
  m_nIncHealth  :=0;
  m_nIncHealing :=0;
  //004BBB30
  try
    if (m_btRaceServer <> RC_PLAYOBJECT) and (m_LastHiter <> nil) then begin
      if g_Config.boMonSayMsg then MonsterSayMsg(m_LastHiter,s_Die);

      if (m_ExpHitter <> nil) then begin
        if m_ExpHitter.m_btRaceServer = RC_PLAYOBJECT then begin
          if g_FunctionNPC <> nil then
            g_FunctionNPC.GotoLable(TPlayObject(m_ExpHitter),'@OnKillMob('+m_sCharName+')',False);

          tExp:=m_ExpHitter.CalcGetExp(m_Abil.Level,m_dwFightExp);
          if not g_Config.boVentureServer then begin
            TPlayObject(m_ExpHitter).GainExp(tExp);
          end;//004BBBBF
          //是否执行任务脚本
          if m_PEnvir.IsCheapStuff then begin
            if m_ExpHitter.m_GroupOwner <> nil then begin
              for i:= 0 to m_ExpHitter.m_GroupOwner.m_GroupMembers.Count -1 do begin
                GroupHuman:=TPlayObject(m_ExpHitter.m_GroupOwner.m_GroupMembers.Objects[i]);
                if not GroupHuman.m_boDeath and (m_ExpHitter.m_PEnvir = GroupHuman.m_PEnvir) and (abs(m_ExpHitter.m_nCurrX - GroupHuman.m_nCurrX) <= 12) and (abs(m_ExpHitter.m_nCurrX - GroupHuman.m_nCurrX) <= 12) and (m_ExpHitter = GroupHuman) then begin
                  tCheck:=False;
                end else begin//004BBCB3
                  tCheck:=True;
                end;//004BBCB7
                QuestNPC:=TMerchant(m_PEnvir.GetQuestNPC(GroupHuman,m_sCharName,'',tCheck));
                if QuestNPC <> nil then begin
                  QuestNPC.Click(GroupHuman);
                end;
              end;//004BBD08
            end;//004BBD08
            QuestNPC:=TMerchant(m_PEnvir.GetQuestNPC(m_ExpHitter,m_sCharName,'',False));
            if QuestNPC <> nil then begin
              QuestNPC.Click(TPlayObject(m_ExpHitter));
            end;
          end;
        end else begin;//004BBD5B
          if m_ExpHitter.m_Master <> nil then begin
            m_ExpHitter.GainSlaveExp(m_Abil.Level);
            tExp:=m_ExpHitter.m_Master.CalcGetExp(m_Abil.Level,m_dwFightExp);
            if not g_Config.boVentureServer then begin
              TPlayObject(m_ExpHitter.m_Master).GainExp(tExp);
            end;
          end;
        end;
      end else begin;//004BBDD2
        if m_LastHiter.m_btRaceServer = RC_PLAYOBJECT then begin
          if g_FunctionNPC <> nil then
            g_FunctionNPC.GotoLable(TPlayObject(m_LastHiter),'@OnKillMob('+m_sCharName+')',False);

          tExp:=m_LastHiter.CalcGetExp(m_Abil.Level,m_dwFightExp);
          if not g_Config.boVentureServer then begin
            TPlayObject(m_LastHiter).GainExp(tExp);
          end;
        end;//004BBE21
      end;//004BBE21
    end;//004BBE21
    if (g_Config.boMonSayMsg) and (m_btRaceServer = RC_PLAYOBJECT) and (m_LastHiter <> nil) then begin
      m_LastHiter.MonsterSayMsg(Self,s_KillHuman);
    end;
    m_Master:=nil;
  except
    on e: Exception do begin
      MainOutMessage (sExceptionMsg1);
      MainOutMessage(E.Message);
    end;
  end;
   try
      boPK:=False;
      if (not g_Config.boVentureServer) and (not m_PEnvir.Flag.boFightZone) and (not m_PEnvir.Flag.boFight3Zone) then begin
         if (m_btRaceServer = RC_PLAYOBJECT) and (m_LastHiter <> nil) and (PKLevel < 2) then begin
//            if (m_LastHiter.m_btRaceServer = RC_PLAYOBJECT) then
            if (m_LastHiter.m_btRaceServer = RC_PLAYOBJECT) or (m_LastHiter.m_btRaceServer = RC_NPC) then
              {修改日期2004/07/21，允许NPC杀死人物}

               boPK:=True;
            if m_LastHiter.m_Master <> nil then
               if m_LastHiter.m_Master.m_btRaceServer = RC_PLAYOBJECT then begin
                  m_LastHiter := m_LastHiter.m_Master;
                  boPK:=True;
               end;
         end;
      end;

      if boPK and (m_LastHiter <> nil) then begin
         guildwarkill := FALSE;
         if (m_MyGuild <> nil) and (m_LastHiter.m_MyGuild <> nil) then begin

            if GetGuildRelation (self, m_LastHiter) = 2 then
               guildwarkill := TRUE;
         end;
         Castle:=g_CastleManager.InCastleWarArea(Self);
         if ((Castle <> nil) and Castle.m_boUnderWar) or (m_boInFreePKArea) then
           guildwarkill := TRUE;
         {
         if UserCastle.m_boUnderWar then
            if (m_boInFreePKArea) or (UserCastle.InCastleWarArea(m_PEnvir, m_nCurrX, m_nCurrY)) then
               guildwarkill := TRUE;
         }
         (*
         if not guildwarkill then begin
            if not m_LastHiter.IsGoodKilling(self) then begin
               m_LastHiter.IncPkPoint (nKillHumanAddPKPoint{100});
               m_LastHiter.SysMsg ('你犯了谋杀罪！！！', c_Red,t_Hint);
               SysMsg('你被 ' + m_LastHiter.m_sCharName + '杀害了！！！',c_Red,t_Hint);
               m_LastHiter.AddBodyLuck (-nKillHumanDecLuckPoint{500});
               if PkLevel < 1 then
                  if Random(5) = 0 then
                     m_LastHiter.MakeWeaponUnlock;
            end else
               m_LastHiter.SysMsg ('[你受到正当规则保护。]', c_Green,t_Hint);
         end;
         *)
         //=================================================================
         //
         if not guildwarkill then begin
           if (g_Config.boKillHumanWinLevel or g_Config.boKillHumanWinExp or m_PEnvir.Flag.boPKWINLEVEL or m_PEnvir.Flag.boPKWINEXP) and (m_LastHiter.m_btRaceServer = RC_PLAYOBJECT) then begin
             TPlayObject(Self).PKDie(TPlayObject(m_LastHiter));
           end else begin
             if not m_LastHiter.IsGoodKilling(self) then begin
               m_LastHiter.IncPkPoint (g_Config.nKillHumanAddPKPoint{100});
               m_LastHiter.SysMsg (g_sYouMurderedMsg, c_Red,t_Hint);
               SysMsg(format(g_sYouKilledByMsg,[m_LastHiter.m_sCharName]),c_Red,t_Hint);
               m_LastHiter.AddBodyLuck (-g_Config.nKillHumanDecLuckPoint{500});
               if PkLevel < 1 then
                 if Random(5) = 0 then
                    m_LastHiter.MakeWeaponUnlock;
               if g_FunctionNPC <> nil then begin
                 g_FunctionNPC.GotoLable(TPlayObject(m_LastHiter),'@OnMurder',False);
                 g_FunctionNPC.GotoLable(TPlayObject(Self),'@Murdered',False);
               end;
             end else
               m_LastHiter.SysMsg (g_sYouProtectedByLawOfDefense, c_Green,t_Hint);
           end;
           if m_LastHiter.m_btRaceServer = RC_PLAYOBJECT then begin
             if m_LastHiter.m_dwPKDieLostExp > 0 then begin
               if m_Abil.Exp >= m_LastHiter.m_dwPKDieLostExp then begin
                 Dec(m_Abil.Exp,m_LastHiter.m_dwPKDieLostExp);
               end else m_Abil.Exp:=0;
             end;
             if m_LastHiter.m_nPKDieLostLevel > 0 then begin
               if m_Abil.Level >= m_LastHiter.m_nPKDieLostLevel then begin
                 Dec(m_Abil.Level,m_LastHiter.m_nPKDieLostLevel);
               end else m_Abil.Level:=0;
             end;               
           end;
           
         end;

         //=================================================================
      end;
   except
      MainOutMessage (sExceptionMsg2);
   end;

   try
      if (not m_PEnvir.Flag.boFightZone) and  //004BC0C1
         (not m_PEnvir.Flag.boFight3Zone) and
         (not m_boAnimal) then begin
         AttackBaseObject:=m_ExpHitter;
         if (m_ExpHitter <> nil) and (m_ExpHitter.m_Master <> nil) then begin
           AttackBaseObject:=m_ExpHitter.m_Master;
         end;
         if m_btRaceServer <> RC_PLAYOBJECT then begin
          if m_btRaceServer <> MONSTER_CLONE then begin//clones dont drop items :p
            DropUseItems(AttackBaseObject);
            if (m_Master = nil) and (not m_boNoItem) and (not m_PEnvir.Flag.boNODROPITEM) then
              ScatterBagItems(AttackBaseObject);
            if (m_btRaceServer >= RC_ANIMAL) and (m_Master = nil) and (not m_boNoItem) and (not m_PEnvir.Flag.boNODROPITEM) then
              ScatterGolds(AttackBaseObject);
           end;
         end else begin //004BC1B0
           if (not m_boNoItem) and (not m_PEnvir.Flag.boNODROPITEM) then begin  {修改日期2004/07/21，增加此行，允许设置 m_boNoItem 后人物死亡不掉物品}
             if AttackBaseObject <> nil then begin
               if (g_Config.boKillByHumanDropUseItem and (AttackBaseObject.m_btRaceServer = RC_PLAYOBJECT)) or (g_Config.boKillByMonstDropUseItem and (AttackBaseObject.m_btRaceServer <> RC_PLAYOBJECT)) then
                 DropUseItems(nil);
             end else begin
               DropUseItems(nil);
             end;
             if g_Config.boDieScatterBag then ScatterBagItems(nil);
             if g_Config.boDieDropGold then ScatterGolds(nil);
           end;
           AddBodyLuck( -(50 - (50 - m_Abil.Level * 5)));
         end; //004BC211
      end;

      if m_PEnvir.Flag.boFight3Zone then begin
         Inc (m_nFightZoneDieCount);
         if m_MyGuild <> nil then begin
            TGuild(m_MyGuild).TeamFightWhoDead (m_sCharName);
         end;

         if (m_LastHiter <> nil) then begin
            if (m_LastHiter.m_MyGuild <> nil) and (m_MyGuild <> nil) then begin
               TGuild(m_LastHiter.m_MyGuild).TeamFightWhoWinPoint (m_LastHiter.m_sCharName, 100);  //matchpoint 刘啊, 俺牢己利 扁废
               tStr:=TGuild(m_LastHiter.m_MyGuild).sGuildName + ':' +
                      IntToStr(TGuild(m_LastHiter.m_MyGuild).nContestPoint) + '  ' +
                      TGuild(m_MyGuild).sGuildName + ':' +
                      IntToStr(TGuild(m_MyGuild).nContestPoint);
               UserEngine.CryCry (RM_CRY, m_PEnvir, m_nCurrX, m_nCurrY, 1000,g_Config.btCryMsgFColor,g_Config.btCryMsgBColor, '- ' + tStr);
            end;
         end;
      end;

      if m_btRaceServer = RC_PLAYOBJECT then begin
         //Jacky 2004/09/05
         //人物死亡立即退组，以防止组队刷经验
         if m_GroupOwner <> nil then m_GroupOwner.DelMember(Self);


         if m_LastHiter <> nil then begin
            if m_LastHiter.m_btRaceServer = RC_PLAYOBJECT then tStr := m_LastHiter.m_sCharName
            else tStr := '#' + m_LastHiter.m_sCharName;
         end else tStr := '####';
      //004BC523
      AddGameDataLog('19' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     'FZ-' + BoolToIntStr(m_PEnvir.Flag.boFightZone) +
                     '_F3-' + BoolToIntStr(m_PEnvir.Flag.boFight3Zone) + #9 +
                     '0' + #9 +
                     '1' + #9 +
                     tStr);
      end;
      //减少地图上怪物计数
      if (m_Master = nil) and (not m_boDelFormMaped) then begin
        m_PEnvir.DelObjectCount(Self);
        m_boDelFormMaped:=True;
      end;
        
      SendRefMsg (RM_DEATH, m_btDirection, m_nCurrX, m_nCurrY, 1, '');
   except
      MainOutMessage (sExceptionMsg3);
   end;
end;
procedure TPlayObject.PKDie(PlayObject:TPlayObject);
var
  nWinLevel,nLostLevel,nWinExp,nLostExp:Integer;
  boWinLEvel,boLostLevel,boWinExp,boLostExp:Boolean;
  Lover:TPlayObject;
begin
  nWinLevel:=g_Config.nKillHumanWinLevel;
  nLostLevel:=g_Config.nKilledLostLevel;
  nWinExp:=g_Config.nKillHumanWinExp;
  nLostExp:=g_Config.nKillHumanLostExp;

  boWinLEvel:=g_Config.boKillHumanWinLevel;
  boLostLevel:=g_Config.boKilledLostLevel;
  boWinExp:=g_Config.boKillHumanWinExp;
  boLostExp:=g_Config.boKilledLostExp;
  
  if m_PEnvir.Flag.boPKWINLEVEL then begin
    boWinLEvel:=True;
    nWinLevel:=m_PEnvir.Flag.nPKWINLEVEL;
  end;
  if m_PEnvir.Flag.boPKLOSTLEVEL then begin
    boLostLevel:=True;
    nLostLevel:=m_PEnvir.Flag.nPKLOSTLEVEL;
  end;
  if m_PEnvir.Flag.boPKWINEXP then begin
    boWinExp:=True;
    nWinExp:=m_PEnvir.Flag.nPKWINEXP;
  end;
  if m_PEnvir.Flag.boPKLOSTEXP then begin
    boLostExp:=True;
    nLostExp:=m_PEnvir.Flag.nPKLOSTEXP;
  end;
  
  if PlayObject.m_Abil.Level - m_Abil.Level > g_Config.nHumanLevelDiffer then begin
    if not PlayObject.IsGoodKilling(self) then begin
      PlayObject.IncPkPoint (g_Config.nKillHumanAddPKPoint{100});
      PlayObject.SysMsg (g_sYouMurderedMsg, c_Red,t_Hint);
      SysMsg(format(g_sYouKilledByMsg,[m_LastHiter.m_sCharName]),c_Red,t_Hint);

      if m_xLoveInfo.Lover <> '' then begin
        Lover:=UserEngine.GetPlayObject(m_xLoveInfo.Lover);
        if Lover <> nil then begin
          Lover.SysMsg(m_sCharName + ' has been killed by ' + m_LastHiter.m_sCharName,c_Blue,t_hint);
        end;
      end;
      PlayObject.AddBodyLuck (-g_Config.nKillHumanDecLuckPoint{500});
      if PkLevel < 1 then
        if Random(5) = 0 then
          PlayObject.MakeWeaponUnlock;

      if g_FunctionNPC <> nil then begin
        g_FunctionNPC.GotoLable(PlayObject,'@OnMurder',False);
        g_FunctionNPC.GotoLable(Self,'@Murdered',False);
      end;
    end else begin
      PlayObject.SysMsg(g_sYouProtectedByLawOfDefense, c_Green,t_Hint);
    end;
    exit;
  end;
  if boWinLEvel then begin
    //Inc(PlayObject.m_Abil.Level,nWinLevel);
    if PlayObject.m_Abil.Level + nWinLevel <= MAXUPLEVEL then begin
      Inc(PlayObject.m_Abil.Level,nWinLevel);
    end else begin
      PlayObject.m_Abil.Level:=MAXUPLEVEL;
    end;
    PlayObject.HasLevelUp(PlayObject.m_Abil.Level - nWinLevel);

    if boLostLevel then begin
      if PKLevel >= 2 then begin
        if m_Abil.Level >= nLostLevel * 2 then
          Dec(m_Abil.Level,nLostLevel * 2);
      end else begin
      if m_Abil.Level >= nLostLevel then
        Dec(m_Abil.Level,nLostLevel);
      end;
    end;

  end;

  if boWinExp then begin
    PlayObject.WinExp(nWinExp);
    if boLostExp then begin
      if m_Abil.Exp >= LongWord(nLostExp) then begin
        if m_Abil.Exp >= LongWord(nLostExp) then begin
          Dec(m_Abil.Exp,LongWord(nLostExp));
        end else begin
          m_Abil.Exp:=0;
        end;
      end else begin
        if m_Abil.Level >= 1 then begin
          Dec(m_Abil.Level);
          Inc(m_Abil.Exp,GetLevelExp(m_Abil.Level));
          if m_Abil.Exp >= LongWord(nLostExp) then begin
            Dec(m_Abil.Exp,LongWord(nLostExp));
          end else begin
            m_Abil.Exp:=0;
          end;
        end else begin
          m_Abil.Level:=0;
          m_Abil.Exp:=0;
        end;
        //HasLevelUp(m_Abil.Level + 1);
      end;
    end;
  end;
end;
procedure TBaseObject.ReAlive; //004BC710
begin
  m_boDeath:=False;
  SendRefMsg(RM_ALIVE,m_btDirection,m_nCurrX,m_nCurrY,0,'');
end;

procedure TBaseObject.SetLastHiter(BaseObject: TBaseObject); //004BC74C
begin
  m_LastHiter:=BaseObject;
  m_LastHiterTick:=GetTickCount();
  if m_ExpHitter = nil then begin
    m_ExpHitter:=BaseObject;
    m_ExpHitterTick:=GetTickCount();
  end else begin
    if m_ExpHitter = BaseObject then
      m_ExpHitterTick:=GetTickCount();
  end;
end;

procedure TBaseObject.SetPKFlag(BaseObject: TBaseObject); //004BC7BC
begin
  if (PKLevel < 2) and
     (BaseObject.PKLevel < 2) and
     (not m_PEnvir.Flag.boFightZone) and
     (not m_PEnvir.Flag.boFight3Zone) and
     (not m_boPKFlag) then begin

    BaseObject.m_dwPKTick:=GetTickCount();
    if not BaseObject.m_boPKFlag then begin
      BaseObject.m_boPKFlag:=True;
      BaseObject.RefNameColor();
    end;
  end;
end;



procedure TBaseObject.sub_4BC87C; //004BC87C
var
  I: Integer;
begin
  for I := 0 to LIst_3EC.Count - 1 do begin

  end;
  LIst_3EC.Clear;
end;

function TBaseObject.IsGoodKilling(cert: TBaseObject): Boolean; //004BC8D8
begin
  Result:=False;
  if cert.m_boPKFlag then Result:=True;
end;

//004C880C 0FFFF6
function TBaseObject.IsProtectTarget(BaseObject:TBaseObject): boolean;
begin
  Result:=True;
  if BaseObject = nil then exit;
  if (InSafeZone) or (BaseObject.InSafeZone) then Result:=False;
  if not BaseObject.m_boInFreePKArea then begin
    //新人保护
    if g_Config.boPKLevelProtect then begin
      if (m_Abil.Level > g_Config.nPKProtectLevel) then begin //如果大于指定等级
        if not BaseObject.m_boPKFlag and (BaseObject.m_Abil.Level <= g_Config.nPKProtectLevel) and (BaseObject.PKLevel < 2) then begin
          //被攻击的人物小指定等级没有红名，则不可以攻击。
          Result:=False;
          exit;
        end;
      end;
      if (m_Abil.Level <= g_Config.nPKProtectLevel) then begin //如果小于指定等级
        if not BaseObject.m_boPKFlag and (BaseObject.m_Abil.Level > g_Config.nPKProtectLevel) and (BaseObject.PKLevel < 2) then begin
          Result:=False;
          exit;
        end;
      end;
        
    end;
      


    {
    //大于指定级别的红名人物不可以杀指定级别未红名的人物。
    if (PKLevel >= 2) and (m_Abil.Level > 10) then begin
      if (BaseObject.m_Abil.Level <= 10) and (BaseObject.PKLevel < 2) then begin
        Result:=False;
        exit;
      end;
    end;

    //小于指定级别的非红名人物不可以杀指定级别红名人物。
    if (m_Abil.Level <= 10) and (PKLevel < 2) then begin
      if (BaseObject.PKLevel >= 2) and (BaseObject.m_Abil.Level > 10) then begin
        Result:=False;
        exit;
      end;
    end;
    }
    //大于指定级别的红名人物不可以杀指定级别未红名的人物。
    if (PKLevel >= 2) and (m_Abil.Level > g_Config.nRedPKProtectLevel) then begin
      if (BaseObject.m_Abil.Level <= g_Config.nRedPKProtectLevel) and (BaseObject.PKLevel < 2) then begin
        Result:=False;
        exit;
      end;
    end;

    //小于指定级别的非红名人物不可以杀指定级别红名人物。
    if (m_Abil.Level <= g_Config.nRedPKProtectLevel) and (PKLevel < 2) then begin
      if (BaseObject.PKLevel >= 2) and (BaseObject.m_Abil.Level > g_Config.nRedPKProtectLevel) then begin
        Result:=False;
        exit;
      end;
    end;

    if (GetTickCount - m_dwMapMoveTick < 3000) or (GetTickCount - BaseObject.m_dwMapMoveTick < 3000) then
      Result:=False;
  end;
end;

function TBaseObject.IsAttackTarget(BaseObject:TBaseObject): boolean; //004C89D0 0FFFF5
  function sub_4C88E4():Boolean;
  begin
    Result:=True;
  end;
var
  I:Integer;
begin
  Result:=False;
  if (BaseObject = nil) or (BaseObject = Self) then exit;
  if m_btRaceServer >= RC_ANIMAL{50} then begin
    if m_Master <> nil then begin
      if (m_Master.m_LastHiter = BaseObject) or
         (m_Master.m_ExpHitter = BaseObject) or
         (m_Master.m_TargetCret = BaseObject) then Result:=True;
      if BaseObject.m_TargetCret <> nil then begin
        if (BaseObject.m_TargetCret = m_Master) or
           (BaseObject.m_TargetCret.m_Master = m_Master) and
           (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) then
          Result:=True;
      end; //004C8AB3
      if (BaseObject.m_TargetCret = Self) and (BaseObject.m_btRaceServer >= RC_ANIMAL) then
        Result:=True;
      //004C8AD1
      if BaseObject.m_Master <> nil then begin
        if (BaseObject.m_Master = m_Master.m_LastHiter) or (BaseObject.m_Master = m_Master.m_TargetCret) then
          Result:=True;
      end;//004C8B15
      if BaseObject.m_Master = m_Master then Result:=False;
      if BaseObject.m_boHolySeize then Result:=False;
      if m_Master.m_boSlaveRelax then Result:=False;
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
        //if (m_Master.InSafeZone) or (BaseObject.InSafeZone) then begin
        if BaseObject.InSafeZone then
          Result:=False;  //004C8B6B
      end;
      BreakCrazyMode();
    end else begin  //004C8B79
      if BaseObject.m_btRaceServer = RC_PLAYOBJECT then Result:=True;
      if (m_btRaceServer > RC_PEACENPC{15}) and (m_btRaceServer < RC_ANIMAL{50}) then
        Result:=True;
      if BaseObject.m_Master <> nil then Result:=True;
    end; //004C8BB5
    if m_boCrazyMode and ((BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_btRaceServer > RC_PEACENPC)) then Result:=True;
    if m_boHallucMode then
      if (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and (BaseObject.m_Master = nil) and (BaseObject.m_btRaceServer <> RC_NPC) then
          Result:=True //Hallucination
      else
          Result:=False;
    if m_boNastyMode and ((BaseObject.m_btRaceServer < RC_NPC) or (BaseObject.m_btRaceServer > RC_PEACENPC)) then Result:=True;
  end else begin //004C8BCE
    if m_btRaceServer = RC_PLAYOBJECT then begin
      case m_btAttatckMode of    //
        HAM_ALL{0}: begin
          if (BaseObject.m_btRaceServer < RC_NPC{10}) or (BaseObject.m_btRaceServer > RC_PEACENPC{15})then
            Result:=True;
          if g_Config.boNonPKServer then
            Result:=sub_4C88E4();
        end;
        HAM_PEACE{1}: begin
          if BaseObject.m_btRaceServer >= RC_ANIMAL then
            Result:=True;
        end;
        HAM_DEAR: begin
          if BaseObject <> TPlayObject(Self).m_DearHuman then begin
            Result:=True;
          end;
        end;
        HAM_MASTER: begin
          if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
            Result:=True;
            if TPlayObject(Self).m_boMaster then begin
              for I := 0 to TPlayObject(Self).m_MasterList.Count - 1 do begin
                if TPlayObject(Self).m_MasterList.Items[I] = BaseObject then begin
                  Result:=False;
                  break;
                end;
              end;
            end;
            if TPlayObject(BaseObject).m_boMaster then begin
              for I := 0 to TPlayObject(BaseObject).m_MasterList.Count - 1 do begin
                if TPlayObject(BaseObject).m_MasterList.Items[I] = Self then begin
                  Result:=False;
                  break;
                end;
              end;
            end;
          end else Result:=True;
        end;
        HAM_GROUP{2}: begin
          if (BaseObject.m_btRaceServer < RC_NPC) or (BaseObject.m_btRaceServer > RC_PEACENPC) then
            Result:=True;
          if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
            if IsGroupMember (BaseObject) then
              Result:=False;
          if g_Config.boNonPKServer then
            Result:=sub_4C88E4();
        end;
        HAM_GUILD{3}: begin
          if (BaseObject.m_btRaceServer < RC_NPC) or (BaseObject.m_btRaceServer > RC_PEACENPC) then
            Result:=True;
          if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
            if m_MyGuild <> nil then begin
              if TGuild(m_MyGuild).IsMember(BaseObject.m_sCharName) then
                Result:=False;
              if m_boGuildWarArea and (BaseObject.m_MyGuild <> nil) then begin
                if TGuild(m_MyGuild).IsAllyGuild(TGuild(BaseObject.m_MyGuild)) then
                  Result:=False;
              end;
            end;
          if g_Config.boNonPKServer then
            Result:=sub_4C88E4();
        end;
      HAM_PKATTACK{4}: begin
          if (BaseObject.m_btRaceServer < RC_NPC) or (BaseObject.m_btRaceServer > RC_PEACENPC) then
            Result:=True;
          if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
            if PKLevel >= 2 then begin
              if BaseObject.PKLevel < 2 then
                Result:=True
              else Result:=False;
          end else begin
            if BaseObject.PKLevel >= 2 then
              Result:=True
            else Result:=False;
          end;
          if g_Config.boNonPKServer then
            Result:=sub_4C88E4();
        end;
      end;
    end else Result:= True;
  end; //004C8DF0
  if BaseObject.m_boAdminMode or BaseObject.m_boStoneMode then
    Result:=False;
end;

function TBaseObject.IsProperTarget(BaseObject:TBaseObject):Boolean; //004C8E30 0FFFF4
begin
  Result:=IsAttackTarget(BaseObject); //0FFFF5
  if Result then begin
    if (m_btRaceServer = RC_PLAYOBJECT) and (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
      Result:=IsProtectTarget(BaseObject); //0FFFF6
    end;
  end;
  if (BaseObject <> nil) and
     (m_btRaceServer = RC_PLAYOBJECT) and
     (BaseObject.m_Master <> nil) and
     (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) then begin
    if BaseObject.m_Master = Self then begin
      if m_btAttatckMode <> HAM_ALL{0} then Result:=False;
    end else begin
      Result:=IsAttackTarget(BaseObject.m_Master);
      if InSafeZone or BaseObject.InSafeZone then Result:=False;
    end;      
  end;
end;

procedure TBaseObject.WeightChanged; //004C49BC
begin
  m_WAbil.Weight:=RecalcBagWeight();
  SendUpdateMsg(Self,RM_WEIGHTCHANGED,0,0,0,0,'');
end;

function TBaseObject.InSafeZone: Boolean; //004BEE20
var
  I: Integer;
  StartPoint:pTStartPoint;
begin
  Result:=m_PEnvir.Flag.boSAFE;
  if Result then exit;
  if (m_PEnvir.sMapName <> g_Config.sRedHomeMap) or
     (abs(m_nCurrX - g_Config.nRedHomeX) > g_Config.nSafeZoneSize) or
     (abs(m_nCurrY - g_Config.nRedHomeY) > g_Config.nSafeZoneSize) then begin
    Result:=False;
  end else begin //004BEE98
    Result:=True;
  end;

  g_StartPoint.Lock;
  try
    for I := 0 to g_StartPoint.Count - 1 do begin
      StartPoint:=g_StartPoint.Items[I];
      if StartPoint.Envir = m_PEnvir then begin
        if (abs(m_nCurrX - StartPoint.nX) <= g_Config.nSafeZoneSize) and (abs(m_nCurrY - StartPoint.nY) <= g_Config.nSafeZoneSize) then begin
          Result:=True;
          break;
        end;
      end;
    end;
  finally
    g_StartPoint.UnLock;
  end;
end;

function TBaseObject.InSafeZone(Envir: TEnvirnoment; nX,
  nY: Integer): Boolean;
var
  I: Integer;
  StartPoint:pTStartPoint;
begin
  Result:=Envir.Flag.boSAFE;
  if Result then exit;
  if (Envir.sMapName <> g_Config.sRedHomeMap) or
     (abs(nX - g_Config.nRedHomeX) > g_Config.nSafeZoneSize) or
     (abs(nY - g_Config.nRedHomeY) > g_Config.nSafeZoneSize) then begin
    Result:=False;
  end else begin //004BEE98
    Result:=True;
  end;
  if Result then exit;

  try
    g_StartPoint.Lock;
    for I := 0 to g_StartPoint.Count - 1 do begin
      StartPoint:=g_StartPoint.Items[I];
      if StartPoint.Envir = m_PEnvir then begin
        if (abs(nX - StartPoint.nX) <= g_Config.nSafeZoneSize) and (abs(nY - StartPoint.nY) <= g_Config.nSafeZoneSize) then begin
          Result:=True;
          break;
        end;
      end;
    end;
  finally
    g_StartPoint.UnLock;
  end;
end;

//004BDBBC
procedure TBaseObject.OpenHolySeizeMode(dwInterval:LongWord);
begin
  m_boHolySeize:=True;
  m_dwHolySeizeTick:=GetTickCount();
  m_dwHolySeizeInterval:=dwInterval;
  RefNameColor();
end;
//004BDBF8
procedure TBaseObject.BreakHolySeizeMode;
begin
  m_boHolySeize:=False;
  RefNameColor();
end;

procedure TBaseObject.OpenCrazyMode(nTime:Integer); //004BDC14
begin
  m_boCrazyMode:=True;
  m_dwCrazyModeTick:=GetTickCount();
  m_dwCrazyModeInterval:=nTime * 1000;
  RefNameColor();
end;

procedure TBaseObject.BreakCrazyMode;  //004BDC54
begin
  if m_boCrazyMode then begin
    m_boCrazyMode:=False;
    RefNameColor();
  end;
end;

procedure TBaseObject.OpenHallucMode(nTime:Integer); //Hallucination
begin
  m_boHallucMode:=True;
  m_dwHallucModeTick:=GetTickCount();
  m_dwHallucModeInterval:=nTime * 1000;
  RefNameColor();
end;

procedure TBaseObject.BreakHallucMode; //Hallucination
begin
  if m_boHallucMode then begin
    m_boHallucMode:=False;
    RefNameColor();
  end;
end;

procedure TBaseObject.LeaveGroup; //004C3B70
ResourceString
  sExitGropMsg = '%s is out from group.';
begin
  SendGroupText(format(sExitGropMsg,[m_sCharName]));
  m_GroupOwner:=nil;
  SendMsg(Self,RM_GROUPCANCEL,0,0,0,0,'');
end;

function TPlayObject.CancelGroup: Boolean;//004C397C
ResourceString
  sCanceGrop = 'Your group is disorganized.';
begin
  Result:=True;
  if m_GroupMembers.Count <= 1 then begin
    SendGroupText(sCanceGrop);
    m_GroupMembers.Clear;
    m_GroupOwner:=nil;
    Result:=False;
  end;    
end;

procedure TPlayObject.SendGroupMembers; //004DCBA4
var
  I: Integer;
  PlayObject:TPlayObject;
  sSendMsg:String;
begin
  sSendMsg:='';
  for I := 0 to m_GroupMembers.Count - 1 do begin
    PlayObject:=TPlayObject(m_GroupMembers.Objects[i]);
    sSendMsg:=sSendMsg + PlayObject.m_sCharName + '/';
  end;
  for I := 0 to m_GroupMembers.Count - 1 do begin
    PlayObject:=TPlayObject(m_GroupMembers.Objects[i]);
    PlayObject.SendDefMessage(SM_GROUPMEMBERS,0,0,0,0,sSendMsg);
  end;
end;

function TBaseObject.GetMagicInfo(nMagicID: Integer): pTUserMagic; //004CBC7C
var
  I: Integer;
  UserMagic:pTUserMagic;
begin
  Result:=nil;
  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic:=m_MagicList.Items[i];
    if UserMagic.MagicInfo.wMagicId = nMagicID then begin
      Result:=UserMagic;
      break;
    end;
  end;
end;

function TPlayObject.GetSpellPoint(UserMagic: pTUserMagic): Integer; //004C6910
begin
  Result:=ROUND(UserMagic.MagicInfo.wSpell / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + UserMagic.MagicInfo.btDefSpell;
end;

function TPlayObject.DoMotaebo(nDir: Byte; nMagicLevel: Integer): Boolean; ////004C3130
  function CanMotaebo(BaseObject:TBaseObject):Boolean;//0x004C30B0
  var
    nC:Integer;
  begin
    Result:=False;
    if (m_Abil.Level > BaseObject.m_Abil.Level) and (not BaseObject.m_boStickMode) then begin
      nC:=m_Abil.Level - BaseObject.m_Abil.Level;
      if Random(20) < ((nMagicLevel * 4) + 6 + nC) then begin
        if IsProperTarget(BaseObject) then Result:=True;
      end;
    end;      
  end;
var
  bo35:Boolean;
  I,nDmg,n24,n28:Integer;
  PoseCreate:TBaseObject;
  BaseObject_30:TBaseObject;
  BaseObject_34:TBaseObject;
  nX,nY:integer;
begin
  Result:=False;
  bo35:=True;
  m_btDirection:=nDir;
  BaseObject_34:=nil;
  n24:=nMagicLevel + 1;
  n28:=n24;
  PoseCreate:=GetPoseCreate();
  if PoseCreate <> nil  then begin
    for I:=0 to _MAX(2,nMagicLevel + 1) do begin
      PoseCreate:=GetPoseCreate();
      if PoseCreate <> nil  then begin
        n28:=0;
        if not CanMotaebo(PoseCreate) then break;
        if nMagicLevel >= 3 then begin
          if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,m_btDirection,2,nX,nY) then begin
            BaseObject_30:=m_PEnvir.GetMovingObject(nX,nY,True);
            if (BaseObject_30 <> nil) and CanMotaebo(BaseObject_30) then
              BaseObject_30.CharPushed(m_btDirection,1);  //004C3237
          end; //004C323C
        end; //004C323C if nMagicLevel >= 3 then begin
        BaseObject_34:=PoseCreate;
        if PoseCreate.CharPushed(m_btDirection,1) <> 1 then break;
        GetFrontPosition(nX,nY);  //sub_004B2790
        if m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,nX,nY,False) > 0 then begin
          m_nCurrX:=nX;
          m_nCurrY:=nY;
          SendRefMsg(RM_RUSH,nDir,m_nCurrX,m_nCurrY,0,'');
          bo35:=False;
          Result:=True;
        end;
        Dec(n24);
      end; //004C32D7  if PoseCreate <> nil  then begin
    end; //004C32DD for i:=0 to _MAX(2,nMagicLevel + 1) do begin
  end else begin //004C32E8 if PoseCreate <> nil  then begin
    bo35:=False;
    for i:=0 to _MAX(2,nMagicLevel + 1) do begin
      GetFrontPosition(nX,nY);//sub_004B2790
      if m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,nX,nY,False) > 0 then begin
        m_nCurrX:=nX;
        m_nCurrY:=nY;
        SendRefMsg(RM_RUSH,nDir,m_nCurrX,m_nCurrY,0,'');
        Dec(n28);
      end else begin
        if m_PEnvir.CanWalk(nX,nY,True) then n28:=0
        else begin
          bo35:=True;
          break;
        end;          
      end;
    end; //004C33AD
  end; //004C33B3
  if (BaseObject_34 <> nil) then begin  //004C33B3
    if n24 < 0 then n24:=0;
    nDmg:=Random((n24 + 1) * 10) + ((n24 + 1) * 10);
    nDmg:=BaseObject_34.GetHitStruckDamage(Self,nDmg);
    BaseObject_34.StruckDamage(nDmg);
    BaseObject_34.SendRefMsg(RM_STRUCK,nDmg,BaseObject_34.m_WAbil.HP,BaseObject_34.m_WAbil.MaxHP,Integer(Self),'');
    if BaseObject_34.m_btRaceServer <> RC_PLAYOBJECT then begin
      BaseObject_34.SendMsg(BaseObject_34,RM_STRUCK,nDmg,BaseObject_34.m_WAbil.HP,BaseObject_34.m_WAbil.MaxHP,Integer(Self),'');
    end;
  end; //004C3464
  if bo35 then begin
    GetFrontPosition(nX,nY);  //sub_004B2790
    SendRefMsg(RM_RUSHKUNG,m_btDirection,nX,nY,0,'');
    SysMsg(sMateDoTooweak,c_Red,t_Hint);
  end;
  if n28 > 0 then begin
    if n24 < 0 then n24:=0;
    nDmg:=Random(n24 * 10) + ((n24 + 1) * 3);
    nDmg:=GetHitStruckDamage(Self,nDmg);
    StruckDamage(nDmg);
    SendRefMsg(RM_STRUCK,nDmg,m_WAbil.HP,m_WAbil.MaxHP,0,'');
  end;
      
end;
//004C1268
procedure TBaseObject.TrainSkill(UserMagic: pTUserMagic;
  nTranPoint: Integer);
begin
  if m_boFastTrain then
    nTranPoint:=nTranPoint * 3;
  Inc(UserMagic.nTranPoint,nTranPoint);
end;

function TBaseObject.CheckMagicLevelup(UserMagic: pTUserMagic): Boolean; //004C7054
var
  n10:Integer;
begin
  Result:=False;
  if (UserMagic.btLevel < 4) and (UserMagic.MagicInfo.btTrainLv >= UserMagic.btLevel) then
    n10:=UserMagic.btLevel
  else n10:=0;
  
  if (UserMagic.MagicInfo.btTrainLv > UserMagic.btLevel) and
     (UserMagic.MagicInfo.MaxTrain[n10] <= UserMagic.nTranPoint) then begin

    if (UserMagic.MagicInfo.btTrainLv > UserMagic.btLevel) then begin
      Dec(UserMagic.nTranPoint,UserMagic.MagicInfo.MaxTrain[n10]);
      Inc(UserMagic.btLevel);
      SendUpdateDelayMsg(Self,RM_MAGIC_LVEXP,0,UserMagic.MagicInfo.wMagicId,UserMagic.btLevel,UserMagic.nTranPoint,'',800);
      CheckMagicSpecialAbility(UserMagic);
    end else begin
      UserMagic.nTranPoint:=UserMagic.MagicInfo.MaxTrain[n10];
    end;
    Result:=True;
  end; //004C7132    
end;

function TPlayObject.DoSpell(UserMagic: pTUserMagic; nTargetX,
  nTargetY: Integer; BaseObject: TBaseObject): boolean; //004C6968
var
  nSpellPoint:integer;
begin
  Result:=False;
try
  if not MagicManager.IsWarrSkill(UserMagic.wMagIdx) then begin
    nSpellPoint:=GetSpellPoint(UserMagic);
    if nSpellPoint > 0 then begin
      if m_WAbil.MP < nSpellPoint then exit;
      DamageSpell(nSpellPoint);
      HealthSpellChanged();
    end;
    Result:=MagicManager.DoSpell(Self,UserMagic,nTargetX,nTargetY,BaseObject);
  end;
except
  on e: Exception do begin
    MainOutMessage(format('[Exception] TPlayObject.DoSpell MagID:%d X:%d Y:%d',[UserMagic.wMagIdx,nTargetX,nTargetY]));
    MainOutMessage(E.Message);
  end;

end;
end;

function TPlayObject.PileStones(nX, nY: Integer):Boolean; //004CB64C
var
  Event     :TEvent;
  PileEvent :TEvent;
  s1C       :String;
begin
  Result:=False;
  s1C:='';
  Event:=TEvent(m_PEnvir.GetEvent(nX,nY));
  if (Event <> nil) and (Event.m_nEventType = ET_MINE) then begin
    if TStoneMineEvent(Event).m_nMineCount > 0 then begin
      Dec(TStoneMineEvent(Event).m_nMineCount);
      if Random(g_Config.nMakeMineHitRate{4}) = 0 then begin
        PileEvent:=TEvent(m_PEnvir.GetEvent(m_nCurrX,m_nCurrY));
        if PileEvent = nil then begin //004CB71D
          PileEvent:=TPileStones.Create(m_PEnvir,m_nCurrX,m_nCurrY,ET_PILESTONES,5 * 60 * 1000);
          g_EventManager.AddEvent(PileEvent);
        end else begin
          if PileEvent.m_nEventType = ET_PILESTONES then
            TPileStones(PileEvent).AddEventParam;
        end;
        if Random(g_Config.nMakeMineRate{12}) = 0 then begin
          if m_PEnvir.Flag.boMINE then
            MakeMine()
          else if m_PEnvir.Flag.boMINE2 then
            MakeMine2()
          else if m_PEnvir.Flag.boMINE3 then
            MakeMine3();
        end;
        s1C:='1';
        DoDamageWeapon(Random(15) + 5);
        Result:=True;
      end; //004CB79C
    end else begin  //004CB782
      if (GetTickCount - TStoneMineEvent(Event).m_dwAddStoneMineTick) >10 * 60 * 1000 then
        TStoneMineEvent(Event).AddStoneMine();
    end;
  end; //004CB79C
  SendRefMsg(RM_HEAVYHIT,m_btDirection,m_nCurrX,m_nCurrY,0,s1C);
end;


//004C914C
procedure TBaseObject.SetTargetCreat(BaseObject: TBaseObject);
begin
  m_TargetCret:=BaseObject;
  m_dwTargetFocusTick:=GetTickCount();
end;

procedure TBaseObject.DelTargetCreat();//004C9178
begin
  m_TargetCret:=nil;
end;

procedure TBaseObject.RecallSlave(sSlaveName:String);
var
  i,nX,nY:Integer;
begin
  GetBackPosition(nX,nY);

  for i:=m_SlaveList.Count -1 downto 0 do begin
    if (TBaseObject(m_SlaveList.Items[i]).m_sCharName = sSlaveName) then begin
      TBaseObject(m_SlaveList.Items[i]).SpaceMove(m_PEnvir.sMapName, nX, nY, 1);
      Break;
    end;
  end;
end;

function TBaseObject.SlaveCount(sSlaveName:String):Integer;
var
  i:Integer;
  BaseObject:TBaseObject;
begin
  Result := 0;
  for I := 0 to m_SlaveList.Count - 1 do begin
    BaseObject:=TBaseObject(m_SlaveList.Items[I]);
    if CompareText(sSlaveName,BaseObject.m_sCharName) = 0 then begin
      Inc(Result);
    end;      
  end;
end;

procedure TBaseObject.KillClone(sCloneName:String;nSpellPoint:Integer);
var
  i:Integer;
begin
  for i:=m_SlaveList.Count -1 downto 0 do begin
    if (TBaseObject(m_SlaveList.Items[i]).m_btRaceServer = MONSTER_CLONE) then begin
      DamageSpell(nSpellPoint);
      TClone(m_SlaveList.Items[i]).m_WAbil.HP:= 0;
      Break;
    end;
  end;
end;

function TBaseObject._Attack(var wHitMode: Word;  AttackTarget: TBaseObject): Boolean;//004C1EF4
  //攻击角色
  function DirectAttack(BaseObject:TBaseObject;nSecPwr:Integer):Boolean; //004C1B04
  begin
    Result:=False;
    if (m_btRaceServer = RC_PLAYOBJECT) or
       (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or
       not (InSafeZone and BaseObject.InSafeZone)then begin
      if IsProperTarget(BaseObject) then begin
        if Random(BaseObject.m_btSpeedPoint) < m_btHitPoint then begin
          BaseObject.StruckDamage(nSecPwr);
          BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),
                                RM_10101,
                                nSecPwr,
                                BaseObject.m_WAbil.HP,
                                BaseObject.m_WAbil.MaxHP,
                                Integer(Self),
                                '',500);
          //Not needed (RM_10101)
          {if BaseObject.m_btRaceServer <> RC_PLAYOBJECT then begin
            BaseObject.SendMsg(BaseObject,
                             RM_STRUCK,
                                nSecPwr,
                                BaseObject.m_WAbil.HP,
                                BaseObject.m_WAbil.MaxHP,
                                Integer(Self),
                                '');
          end;}
          Result:=True;
        end;
      end;
    end;

  end;
  //刺杀前面一个位置的攻击
  function SwordLongAttack(nSecPwr:Integer):Boolean;  //004C1C24
  var
    nX,nY:Integer;
    BaseObject:TBaseObject;
  begin
    Result:=False;
    //Result:=g_boNotLimitSwordLong;
    nSecPwr:=ROUND(nSecPwr * g_Config.nSwordLongPowerRate / 100);
    if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,m_btDirection,2,nX,nY) then begin
      BaseObject:=m_PEnvir.GetMovingObject(nX,nY,True);
      if BaseObject <> nil then begin
        if (nSecPwr > 0) and IsProperTarget(BaseObject) then begin
          Result:=DirectAttack(BaseObject,nSecPwr);
          SetTargetCreat(BaseObject);
        end;
        Result:=True;
      end;
    end;
  end;
  //半月攻击
  function SwordWideAttack(nSecPwr:Integer):Boolean;  //004C1CDC
  var
    nC,n10:Integer;
    nX,nY:Integer;
    BaseObject:TBaseObject;
  begin
    Result:=False;
    nC:=0;
    while (True) do begin
      n10:=(m_btDirection + g_Config.WideAttack[nC]) mod 8;
      if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,n10,1,nX,nY) then begin
        BaseObject:=m_PEnvir.GetMovingObject(nX,nY,True);
        if (nSecPwr > 0) and (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
          Result:=DirectAttack(BaseObject,nSecPwr);
          SetTargetCreat(BaseObject);
        end;
      end;
      Inc(nC);
      if nC >= 3 then break;
    end;    
  end;

  function CrsWideAttack(nSecPwr:Integer):Boolean;
  var
    nC,n10:Integer;
    nX,nY:Integer;
    BaseObject:TBaseObject;
  begin
    Result:=False;
    nC:=0;
    while (True) do begin
      n10:=(m_btDirection + g_Config.CrsAttack[nC]) mod 8;
      if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,n10,1,nX,nY) then begin
        BaseObject:=m_PEnvir.GetMovingObject(nX,nY,True);
        if (nSecPwr > 0) and (BaseObject <> nil) and IsProperTarget(BaseObject) then begin
          //CHM Fix
          if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
            Result:=DirectAttack(BaseObject, nSecPwr)
          else
            Result:=DirectAttack(BaseObject, Round(nSecPwr * 0.8));

          SetTargetCreat(BaseObject);
        end;
      end;
      Inc(nC);
      if nC >= 7 then break;
    end;    
  end;
  
  procedure sub_4C1E5C(nSecPwr:Integer);  //004C1E5C
  var
    btDir:Byte;
    nX,nY:Integer;
    BaseObject:TBaseObject;
    procedure sub_4C1DC0();
    begin
      if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,btDir,1,nX,nY) then begin
        BaseObject:=m_PEnvir.GetMovingObject(nX,nY,True);
        if (nSecPwr > 0) and (BaseObject <> nil) then begin
          Result:=DirectAttack(BaseObject,nSecPwr);
        end;
      end;
    end;
  begin
    Result:=False;
    btDir:=m_btDirection;
    m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,btDir,1,nX,nY);
    sub_4C1DC0();
    btDir:=sub_4B2F80(m_btDirection,2);
    sub_4C1DC0();
    btDir:=sub_4B2F80(m_btDirection,6);
    sub_4C1DC0();
  end;
var
  nPower,nSecPwr,nWeaponDamage:Integer;
  bo21:Boolean;
  n20:Integer;
  nCheckCode:Integer;
ResourceString
  sExceptionMsg = '[Exception] TBaseObject::_Attack Name:= %s Code:=%d';
begin
  Result:=False;
  nCheckCode:=0;
try
  bo21:=False;
  nWeaponDamage:=0;
  nPower:=0;
  nSecPwr:=0;
  if AttackTarget <> nil then begin
    nPower:=GetAttackPower(LoWord(m_WAbil.DC),SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
    if (wHitMode = 3) and m_boPowerHit then begin
      m_boPowerHit:=False;
      Inc(nPower,m_nHitPlus);
      bo21:=True;
    end;
    if (wHitMode = 7) and m_boFireHitSkill then begin //烈火剑法
      m_boFireHitSkill:=False;
      m_dwLatestFireHitTick:=GetTickCount(); //Jacky 禁止双烈火
      nPower:=nPower + ROUND(nPower / 100 * (m_nHitDouble * 10));
      bo21:=True;
    end;
    if (wHitMode = 9) and m_boTwinHitSkill then begin //烈火剑法
      m_boTwinHitSkillPhase:=True;
      m_dwLatestTwinHitTick:=GetTickCount(); //TWIN DAMAGE right here
      nPower:=nPower + ROUND(nPower / 100 * (m_nHitDouble * 10));
      bo21:=True;
    end;
  end else begin
    nPower:=GetAttackPower(LoWord(m_WAbil.DC),SmallInt((HiWord(m_WAbil.DC) - LoWord(m_WAbil.DC))));
    if (wHitMode = 3) and m_boPowerHit then begin
      m_boPowerHit:=False;
      Inc(nPower,m_nHitPlus);
      bo21:=True;
    end;
    //Jacky 防止砍空刀刀烈火
    if (wHitMode = 7) and m_boFireHitSkill then begin
      m_boFireHitSkill:=False;
      m_dwLatestFireHitTick:=GetTickCount(); //Jacky 禁止双烈火
    end;

    if (wHitMode = 9) and m_boTwinHitSkill then begin
      m_boTwinHitSkill:=False;
      m_dwLatestTwinHitTick:=GetTickCount(); //Jacky 禁止双烈火
    end;
    //
  end;
  nCheckCode:=1;
  if (wHitMode = 4) then begin //004C205A 刺杀
    nSecPwr:=0;
    if m_btRaceServer = RC_PLAYOBJECT then begin
      nCheckCode:=11;
      if m_MagicErgumSkill <> nil then begin
        nCheckCode:=12;
        nSecPwr:=ROUND(nPower / (m_MagicErgumSkill.MagicInfo.btTrainLv + 2) * (m_MagicErgumSkill.btLevel + 2));
        nCheckCode:=13;
      end;
    end else nSecPwr:=nSecPwr;
    if nSecPwr > 0 then begin
      nCheckCode:=110;
      if not SwordLongAttack(nSecPwr) and g_Config.boLimitSwordLong then wHitMode:=0;
      nCheckCode:=111;
    end;
  end;
  nCheckCode:=2;
  if (wHitMode = 5) then begin
    nSecPwr:=0;
    if m_btRaceServer = RC_PLAYOBJECT then begin
      if m_MagicBanwolSkill <> nil then begin
        nSecPwr:=ROUND(nPower / (m_MagicBanwolSkill.MagicInfo.btTrainLv + 10) * (m_MagicBanwolSkill.btLevel + 2));
      end;
    end else nSecPwr:=nSecPwr;
    if nSecPwr > 0 then SwordWideAttack(nSecPwr);
  end;
  if (wHitMode = 12) then begin
    nSecPwr:=0;
    if m_btRaceServer = RC_PLAYOBJECT then begin
      if m_MagicRedBanwolSkill <> nil then begin
        nSecPwr:=ROUND(nPower / (m_MagicRedBanwolSkill.MagicInfo.btTrainLv + 10) * (m_MagicRedBanwolSkill.btLevel + 2));
      end;
    end else nSecPwr:=nSecPwr;
    if nSecPwr > 0 then SwordWideAttack(nSecPwr);
  end;
  nCheckCode:=3;
  if (wHitMode = 6) then begin
    nSecPwr:=0;
    if m_btRaceServer = RC_PLAYOBJECT then begin
    end else nSecPwr:=nSecPwr;
    if nSecPwr > 0 then sub_4C1E5C(nSecPwr);
  end;
  if (wHitMode = 8) then begin
    nSecPwr:=0;
    if m_btRaceServer = RC_PLAYOBJECT then begin
      if m_MagicCrsSkill <> nil then begin
        nSecPwr:=ROUND(nPower / (m_MagicCrsSkill.MagicInfo.btTrainLv + 11) * (m_MagicCrsSkill.btLevel + 3));
      end;
    end else nSecPwr:=nSecPwr;
    if nSecPwr > 0 then CrsWideAttack(nSecPwr);
  end;


  if AttackTarget = nil then exit; //004C218D


  nCheckCode:=4;
  if IsProperTarget{0FFF4}(AttackTarget) then begin
    nCheckCode:=41;
    if AttackTarget.m_btHitPoint > 0 then begin
      if (m_btHitPoint < Random(AttackTarget.m_btSpeedPoint)) then begin
        nCheckCode:=42;
        nPower:=0;
      end;
    end;
    nCheckCode:=43;
  end else nPower:=0;
  nCheckCode:=5;
  if nPower > 0 then begin
    nPower:=AttackTarget.GetHitStruckDamage(Self,nPower);
    nWeaponDamage:=(Random(5) + 2) - m_AddAbil.btWeaponStrong;
  end;
  nCheckCode:=600;
  if nPower > 0 then begin     //004C21FC
    nCheckCode:=601;
    AttackTarget.SetLastHiter(self);
    AttackTarget.StruckDamage(nPower);
    nCheckCode:=602;
    if m_boTwinHitSkill then begin
      m_boTwinHitSkill := false;
      AttackTarget.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,nPower,AttackTarget.m_WAbil.HP,AttackTarget.m_WAbil.MaxHP,Integer(Self),'',200);
      AttackTarget.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,nPower,AttackTarget.m_WAbil.HP,AttackTarget.m_WAbil.MaxHP,Integer(Self),'',400);
      if random(25 - m_MagicTwnHitSkill.btLevel * 5) = 0 then begin
        AttackTarget.MakePosion(POISON_DONTMOVE,(m_MagicTwnHitSkill.btLevel*1),0); //yellow effect
        AttackTarget.m_boTDBeffect := True;
      end;
    end else begin
      AttackTarget.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,nPower,AttackTarget.m_WAbil.HP,AttackTarget.m_WAbil.MaxHP,Integer(Self),'',200);
    end;
    nCheckCode:=603;
    if not AttackTarget.m_boUnParalysis and m_boParalysis and (Random(AttackTarget.m_btAntiPoison + g_Config.nAttackPosionRate{5}) = 0) then begin
      nCheckCode:=604;
      AttackTarget.MakePosion(POISON_STONE,g_Config.nAttackPosionTime{5},0);
    end;
    nCheckCode:=605;
    //虹魔，吸血
    if m_nHongMoSuite > 0 then begin
      m_db3B0:=nPower / 100 * m_nHongMoSuite;
      if m_db3B0 >= 2.0 then begin
        n20:=TRUNC(m_db3B0);
        m_db3B0:=n20;
        DamageHealth(-n20);
      end;
    end;
    nCheckCode:=606;
    if (m_MagicOneSwordSkill <> nil) and
       (m_btRaceServer = RC_PLAYOBJECT) and
       (m_MagicOneSwordSkill.btLevel < 3) and
       (m_MagicOneSwordSkill.MagicInfo.TrainLevel[m_MagicOneSwordSkill.btLevel] <= m_Abil.Level) then begin
      nCheckCode:=607;
      TPlayObject(Self).TrainSkill(m_MagicOneSwordSkill,Random(3) + 1);
      nCheckCode:=608;
      if not TPlayObject(Self).CheckMagicLevelup(m_MagicOneSwordSkill) then begin
        nCheckCode:=609;
        SendDelayMsg(Self,RM_MAGIC_LVEXP,0,m_MagicOneSwordSkill.MagicInfo.wMagicId,m_MagicOneSwordSkill.btLevel,m_MagicOneSwordSkill.nTranPoint,'',3000);
      end;
      nCheckCode:=610;
    end;
    if bo21 and (m_MagicPowerHitSkill <> nil) and
      (m_btRaceServer = RC_PLAYOBJECT) and
      (m_MagicPowerHitSkill.btLevel < 3) and
      (m_MagicPowerHitSkill.MagicInfo.TrainLevel[m_MagicPowerHitSkill.btLevel] <= m_Abil.Level) then begin
      nCheckCode:=611;
      TPlayObject(Self).TrainSkill(m_MagicPowerHitSkill,Random(3) + 1);
      nCheckCode:=612;
      if not TPlayObject(Self).CheckMagicLevelup(m_MagicPowerHitSkill) then begin
        nCheckCode:=613;
        SendDelayMsg(Self,RM_MAGIC_LVEXP,0,m_MagicPowerHitSkill.MagicInfo.wMagicId,m_MagicPowerHitSkill.btLevel,m_MagicPowerHitSkill.nTranPoint,'',3000);
      end;
      nCheckCode:=614;
    end;
    nCheckCode:=6;
    if (wHitMode = 4) and (m_MagicErgumSkill <> nil) and
       (m_btRaceServer = RC_PLAYOBJECT) and
       (m_MagicErgumSkill.btLevel < 3) and
       (m_MagicErgumSkill.MagicInfo.TrainLevel[m_MagicErgumSkill.btLevel] <= m_Abil.Level) then begin
      nCheckCode:=61;
      TPlayObject(Self).TrainSkill(m_MagicErgumSkill, 1);
      nCheckCode:=62;
      if not TPlayObject(Self).CheckMagicLevelup(m_MagicErgumSkill) then begin
        nCheckCode:=63;
        SendDelayMsg(Self,RM_MAGIC_LVEXP,0,m_MagicErgumSkill.MagicInfo.wMagicId,m_MagicErgumSkill.btLevel,m_MagicErgumSkill.nTranPoint,'',3000);
      end;
    end;
    nCheckCode:=7;
    if (wHitMode = 5) and (m_MagicBanwolSkill <> nil) and
       (m_btRaceServer = RC_PLAYOBJECT) and
       (m_MagicBanwolSkill.btLevel < 3) and
       (m_MagicBanwolSkill.MagicInfo.TrainLevel[m_MagicBanwolSkill.btLevel] <= m_Abil.Level) then begin

      TPlayObject(Self).TrainSkill(m_MagicBanwolSkill,1);
      if not TPlayObject(Self).CheckMagicLevelup(m_MagicBanwolSkill) then begin
        SendDelayMsg(Self,RM_MAGIC_LVEXP,0,m_MagicBanwolSkill.MagicInfo.wMagicId,m_MagicBanwolSkill.btLevel,m_MagicBanwolSkill.nTranPoint,'',3000);
      end;
    end;
    if (wHitMode = 12) and (m_MagicRedBanwolSkill <> nil) and
       (m_btRaceServer = RC_PLAYOBJECT) and
       (m_MagicRedBanwolSkill.btLevel < 3) and
       (m_MagicRedBanwolSkill.MagicInfo.TrainLevel[m_MagicRedBanwolSkill.btLevel] <= m_Abil.Level) then begin

      TPlayObject(Self).TrainSkill(m_MagicRedBanwolSkill,1);
      if not TPlayObject(Self).CheckMagicLevelup(m_MagicRedBanwolSkill) then begin
        SendDelayMsg(Self,RM_MAGIC_LVEXP,0,m_MagicRedBanwolSkill.MagicInfo.wMagicId,m_MagicRedBanwolSkill.btLevel,m_MagicRedBanwolSkill.nTranPoint,'',3000);
      end;
    end;
    nCheckCode:=8;
    if (wHitMode = 7) and (m_MagicFireSwordSkill <> nil) and
       (m_btRaceServer = RC_PLAYOBJECT) and
       (m_MagicFireSwordSkill.btLevel < 3) and
       (m_MagicFireSwordSkill.MagicInfo.TrainLevel[m_MagicFireSwordSkill.btLevel] <= m_Abil.Level) then begin

      TPlayObject(Self).TrainSkill(m_MagicFireSwordSkill, 1);
      if not TPlayObject(Self).CheckMagicLevelup(m_MagicFireSwordSkill) then begin
        SendDelayMsg(Self,RM_MAGIC_LVEXP,0,m_MagicFireSwordSkill.MagicInfo.wMagicId,m_MagicFireSwordSkill.btLevel,m_MagicFireSwordSkill.nTranPoint,'',3000);
      end;
    end;

    if (wHitMode = 8) and (m_MagicCrsSkill <> nil) and
       (m_btRaceServer = RC_PLAYOBJECT) and
       (m_MagicCrsSkill.btLevel < 3) and
       (m_MagicCrsSkill.MagicInfo.TrainLevel[m_MagicCrsSkill.btLevel] <= m_Abil.Level) then begin

      TPlayObject(Self).TrainSkill(m_MagicCrsSkill, 1);
      if not TPlayObject(Self).CheckMagicLevelup(m_MagicCrsSkill) then begin
        SendDelayMsg(Self,RM_MAGIC_LVEXP,0,m_MagicCrsSkill.MagicInfo.wMagicId,m_MagicCrsSkill.btLevel,m_MagicCrsSkill.nTranPoint,'',3000);
      end;
    end;

    if (wHitMode = 9) and (m_MagicTwnHitSkill <> nil) and
       (m_btRaceServer = RC_PLAYOBJECT) and
       (m_MagicTwnHitSkill.btLevel < 3) and
       (m_MagicTwnHitSkill.MagicInfo.TrainLevel[m_MagicTwnHitSkill.btLevel] <= m_Abil.Level) then begin

      TPlayObject(Self).TrainSkill(m_MagicTwnHitSkill, 1);
      if not TPlayObject(Self).CheckMagicLevelup(m_MagicTwnHitSkill) then begin
        SendDelayMsg(Self,RM_MAGIC_LVEXP,0,m_MagicTwnHitSkill.MagicInfo.wMagicId,m_MagicTwnHitSkill.btLevel,m_MagicTwnHitSkill.nTranPoint,'',3000);
      end;
    end;

    Result:=True;
  end; //004C270C
  nCheckCode:=9;
  if (nWeaponDamage > 0) and (m_UseItems[U_WEAPON].wIndex > 0) then
    DoDamageWeapon(nWeaponDamage);

  //Not needed (RM_10101 up above is sent)
//  if AttackTarget.m_btRaceServer <> RC_PLAYOBJECT then
//    AttackTarget.SendMsg(AttackTarget,RM_STRUCK,nPower,AttackTarget.m_WAbil.HP,AttackTarget.m_WAbil.MaxHP,Integer(Self),'');
except
  on e: Exception do begin
    MainOutMessage(format(sExceptionMsg,[m_sCharName,nCheckCode]));
    MainOutMessage(E.Message);
  end;
end;
end;

procedure TBaseObject.SendAttackMsg(wIdent: Word; btDir: Byte; nX,nY: Integer);//004C2E0C
begin
  SendRefMsg(wIdent,btDir,nX,nY,0,'');
end;

function TBaseObject.GetHitStruckDamage(Target:TBaseObject;nDamage: integer): Integer; //004BDD20
var
  nArmor,nRnd:Integer;
begin
  nRnd:=((HiWord(m_WAbil.AC) - LoWord(m_WAbil.AC)) + 1);
  if (nRnd > 0) then
    nArmor:=LoWord(m_WAbil.AC) + (Random(nRnd))
  else
    nArmor:=LoWord(m_WAbil.AC);

  nDamage:=_MAX(0, nDamage - nArmor);

  if (nDamage > 0) then begin
    if (m_btLifeAttrib = LA_UNDEAD) and (Target <> nil) then begin
      Inc(nDamage,Target.m_AddAbil.btUndead);
    end;
    if (m_boAbilMagBubbleDefence) and (not m_boTwinHitSkillPhase) then begin
      nDamage:=ROUND((nDamage / 1.0e2) * (m_btMagBubbleDefenceLevel + 2) * 8.0);
      DamageBubbleDefence(nDamage);
    end;
  end;
  if m_boTwinHitSkillPhase then m_boTwinHitSkillPhase:=false;
  Result:=nDamage;
end;

function TBaseObject.GetMagStruckDamage(BaseObject:TBaseObject;nDamage: Integer): Integer; //004BDDEC
var
  n14:Integer;
begin
  n14:=LoWord(m_WAbil.MAC) + Random(SmallInt(HiWord(m_WAbil.MAC) - LoWord(m_WAbil.MAC)) + 1);
  nDamage:=_MAX(0,nDamage - n14);
  if (m_btLifeAttrib = LA_UNDEAD) and (BaseObject <> nil) then begin
    Inc(nDamage,m_AddAbil.btUndead);
  end;
  if (nDamage > 0) and m_boAbilMagBubbleDefence then begin
    nDamage:=ROUND((nDamage / 1.0e2) * (m_btMagBubbleDefenceLevel + 2) * 8.0);
    DamageBubbleDefence(nDamage);
  end;

  Result:=nDamage;
end;

//004BDEB8
procedure TBaseObject.StruckDamage(nDamage: integer);
var
  I: Integer;
  nDam:Integer;
  nTdamage:integer;
  nDura,nOldDura:integer;
  boNeedRecalc:Boolean;
begin
  if nDamage <= 0 then exit;

  nDam:=Random(10) + 5;
  if m_wStatusTimeArr[POISON_DAMAGEARMOR{1 0x62}] > 0 then begin
    nDam:=ROUND(nDam * (g_Config.nPosionDamagarmor / 10){1.2});
    nDamage:=ROUND(nDamage * (g_Config.nPosionDamagarmor / 10){1.2});
  end;
 if m_wStatusTimeArr[POISON_DONTMOVE] > 0 then begin //when yellow from tdb do more damage
    nTDamage := ROUND(nDamage div 4);
    nDamage:=ROUND(nDamage + nTDamage);
  end;
  boNeedRecalc:=False;
  if (m_UseItems[U_DRESS].wIndex > 0) and m_boCanLooseDura then begin
    nDura:=m_UseItems[U_DRESS].Dura;
    nOldDura:=ROUND(nDura / 1000);
    Dec(nDura,nDam);
    if nDura <= 0 then begin
//      m_UseItems[U_DRESS].wIndex:=0;
      m_UseItems[U_DRESS].Dura:=0;
      boNeedRecalc:=True;
      SendMsg(Self,RM_DURACHANGE,U_DRESS,nDura,m_UseItems[U_DRESS].DuraMax,0,'');
    end else begin
      m_UseItems[U_DRESS].Dura:=nDura;
    end;
    if nOldDura <> ROUND(nDura / 1000) then begin
      SendMsg(Self,RM_DURACHANGE,U_DRESS,nDura,m_UseItems[U_DRESS].DuraMax,0,'');
    end;
  end;
  for I := Low(THumanUseItems) to High(THumanUseItems) do  begin
    if not m_boCanLooseDura then Continue;
    if (m_UseItems[i].wIndex > 0) and (Random(8) = 0) and (i <> U_RIGHTHAND) and (i <> U_CHARM) then begin
      nDura:=m_UseItems[i].Dura;
      nOldDura:=ROUND(nDura / 1000);
      Dec(nDura,nDam);
      if nDura <= 0 then begin
        SysMsg(UserEngine.GetStdItemName(m_UseItems[i].wIndex) + 's durability has dropped to 0.',c_Red,t_Notice);
        m_UseItems[i].Dura:=0;
        boNeedRecalc:=True;
        SendMsg(Self,RM_DURACHANGE,i,nDura,m_UseItems[i].DuraMax,0,'');
      end else begin
        m_UseItems[i].Dura:=nDura;
      end;
      if nOldDura <> ROUND(nDura / 1000) then begin
        SendMsg(Self,RM_DURACHANGE,i,nDura,m_UseItems[i].DuraMax,0,'');
      end;
    end;
  end;
  if boNeedRecalc then begin
    RecalcAbilitys();
    SendMsg(Self,RM_ABILITY,0,0,0,0,'');
    SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
  end;
  DamageHealth(nDamage);
end;


function TBaseObject.GeTBaseObjectInfo(): String; //004CF87C
begin
  Result:=m_sCharName + ' ' +
          'Map:' + m_sMapName + '(' + m_PEnvir.sMapDesc + ') ' +
          'Co-Ord:' + IntToStr(m_nCurrX) + '/' + IntToStr(m_nCurrY) + ' ' +
          'Level:' + IntToStr(m_Abil.Level) + ' ' +
          'Exp:' + IntToStr(m_Abil.Exp) + ' ' +
          'HP: ' + IntToStr(m_WAbil.HP) + '-' + IntToStr(m_WAbil.MaxHP) + ' ' +
          'MP: ' + IntToStr(m_WAbil.MP) + '-' + IntToStr(m_WAbil.MaxMP) + ' ' +
          'DC: ' + IntToStr(LoWord(m_WAbil.DC)) + '-' + IntToStr(HiWord(m_WAbil.DC)) + ' ' +
          'MC: ' + IntToStr(LoWord(m_WAbil.MC)) + '-' + IntToStr(HiWord(m_WAbil.MC)) + ' ' +
          'SC: ' + IntToStr(LoWord(m_WAbil.SC)) + '-' + IntToStr(HiWord(m_WAbil.SC)) + ' ' +
          'AC: ' + IntToStr(LoWord(m_WAbil.AC)) + '-' + IntToStr(HiWord(m_WAbil.AC)) + ' ' +
          'MAC: ' + IntToStr(LoWord(m_WAbil.MAC)) + '-' + IntToStr(HiWord(m_WAbil.MAC)) + ' ' +
          'Hit:' + IntToStr(m_btHitPoint) + ' ' +
          'Speed:' + IntToStr(m_btSpeedPoint);
end;


function TBaseObject.GetBackPosition(var nX,nY: Integer): Boolean;     //004B2900
var
  Envir:TEnvirnoment;
begin
  Envir:=m_PEnvir;
  nX:=m_nCurrX;
  nY:=m_nCurrY;
  case m_btDirection of
    DR_UP: if nY < (Envir.Header.wHeight - 1) then Inc(nY);
    DR_DOWN: if nY > 0 then Dec(nY);
    DR_LEFT: if nX < (Envir.Header.wWidth - 1) then Inc(nX);
    DR_RIGHT: if nX > 0 then Dec(nX);
    DR_UPLEFT: begin
      if (nX < (Envir.Header.wWidth - 1)) and (nY < (Envir.Header.wHeight - 1)) then begin
        Inc(nX);
        Inc(nY);
      end;
    end;
    DR_UPRIGHT: begin
      if (nX < (Envir.Header.wWidth - 1)) and (nY > 0) then begin
        Dec(nX);
        Inc(nY);
      end
    end;
    DR_DOWNLEFT: begin
      if (nX > 0) and (nY < (Envir.Header.wHeight - 1)) then begin
        Inc(nX);
        Dec(nY);
      end;
    end;
    DR_DOWNRIGHT: begin
      if (nX > 0) and (nY > 0) then begin
        Dec(nX);
        Dec(nY);
      end;
    end;
   end;
  Result:=True;
end;

procedure TAnimalObject.HitMagAttackTarget(TargeTBaseObject: TBaseObject; nHitPower,
  nMagPower: integer; boFlag: Boolean); //004C2E40
var
  I: Integer;
  nDamage:Integer;
  BaseObjectList:TList;
  BaseObject:TBaseObject;
begin
  m_btDirection:=GetNextDirection(m_nCurrx,m_nCurrY,TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY);
  BaseObjectList:=TList.Create;
  m_PEnvir.GeTBaseObjects(TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY,False,BaseObjectList);
  for I := 0 to BaseObjectList.Count - 1 do begin
    BaseObject:=TBaseObject(BaseObjectList.Items[I]);
    if IsProperTarget(BaseObject) then begin
      nDamage:=0;
      Inc(nDamage,BaseObject.GetHitStruckDamage(Self,nHitPower));
      Inc(nDamage,BaseObject.GetMagStruckDamage(Self,nMagPower));
      if nDamage > 0 then begin
        BaseObject.StruckDamage(nDamage);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,nDamage,BaseObject.m_WAbil.HP,BaseObject.m_WAbil.MaxHP,Integer(Self),'',200);
      end;
    end;
  end;
  BaseObjectList.Free;
  SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
end;

procedure TAnimalObject.DelTargetCreat;
begin
  inherited;
  m_nTargetX:=-1;
  m_nTargetY:=-1;
end;
procedure TAnimalObject.SearchTarget; //004C94B4
var
  BaseObject,BaseObject18:TBaseObject;
  i,nC,n10:integer;
begin
  BaseObject18:=nil;
  n10:=999;
  for i:=0 to m_VisibleActors.Count -1 do begin
    BaseObject:=pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject;
    if not BaseObject.m_boDeath then begin
      if IsProperTarget(BaseObject) and
         (not BaseObject.m_boHideMode or m_boCoolEye) then begin
        nC:=abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
        if nC < n10 then begin
          n10:=nC;
          BaseObject18:=BaseObject;
        end;
      end;
    end;      
  end;
  if BaseObject18 <> nil then SetTargetCreat{FFF2}(BaseObject18);
end;
procedure TAnimalObject.sub_4C959C;//004C959C
var
  I,nC,n10:integer;
  Creat,BaseObject:TBaseObject;
begin
  Creat:=nil;
  n10:=999;
  for I := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject:=pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject;
    if BaseObject.m_boDeath then Continue;
    if IsProperTarget(BaseObject) then begin
      nC:=abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
      if nC < n10 then begin
        n10:=nC;
        Creat:=BaseObject;
      end;
    end;
  end;    // for
  if Creat <> nil then
    SetTargetCreat(Creat);
end;
procedure TAnimalObject.SetTargetXY(nX, nY: Integer);//004C9668
begin
  m_nTargetX:= nX;
  m_nTargetY:= nY;
end;

procedure TAnimalObject.Wondering; //004C9810
begin
  if (Random(20)= 0) then
    if (Random(4) = 1) then TurnTo(Random(8))
    else WalkTo(m_btDirection,False);
end;


function TBaseObject.MakePosion(nType, nTime, nPoint: Integer):Boolean;  //004C35A8
var
  nOldCharStatus:Integer;
  nMinus:Integer;
begin
  Result:=False;
  if nType < MAX_STATUS_ATTRIBUTE then begin
    nOldCharStatus:=m_nCharStatus;
                               
    if (nType in [POISON_DECHEALTH, POISON_DAMAGEARMOR]) then begin
      if m_nPoisonRecover > 0 then begin
        nMinus := nTime * (m_nPoisonRecover*10) div 100;
        if nMinus > nTime then nMinus := nTime;

        Dec(nTime, nMinus);
      end;
    end;
    
    if m_wStatusTimeArr[nType] > 0 then begin
      if m_wStatusTimeArr[nType] < nTime then begin
        m_wStatusTimeArr[nType]:=nTime;
      end;
    end else begin //004C35FF
      m_wStatusTimeArr[nType]:=nTime;
      if nType = POISON_FREEZE then begin //if got frozen then slow down hitspeed and walkspeed
        m_nnonfrzWalkSpeed := m_nWalkSpeed;
        m_nWalkSpeed:= m_nWalkSpeed * 3;
        m_nnonfrzNextHitTime := m_nNextHitTime;
        m_nNextHitTime := m_nNextHitTime * 3;
      end;
    end;
    m_dwStatusArrTick[nType]:=GetTickCount();
    m_nCharStatus:=GetCharStatus();
    m_btGreenPoisoningPoint:=nPoint;
    if nOldCharStatus <> m_nCharStatus then StatusChanged();

    Result:=True;
  end;  //004C366C

end;


function TBaseObject.sub_4DD704: Boolean; //004DD704
var
  I: Integer;
  SendMessage:pTSendMessage;
begin
  Result:=False;
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    for I := 0 to m_MsgList.Count - 1 do begin
      SendMessage:=m_Msglist.Items[i];
      if SendMessage.wIdent = RM_10401 then begin
        Result:=True;
        break;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

procedure TPlayObject.SendSaveItemList(nBaseObject:Integer);//004DC120
var
  i:Integer;
  Item:TItem;
  sSendMsg:String;
  ClientItem:TClientItem;
  UserItem:PTUserItem;
begin
  sSendMsg:='';
  for I := 0 to m_StorageItemList.Count - 1 do begin
    UserItem:=m_StorageItemList.Items[i];
    Item:=UserEngine.GetStdItem(UserItem.wIndex);
    if Item <> nil then begin
      Item.GetStandardItem(ClientItem.S);
      Item.GetItemAddValue(UserItem,ClientItem.S);
      ClientItem.S.Name := GetItemName(UserItem);

      ClientItem.Dura:=UserItem.Dura;
      ClientItem.DuraMax:=UserItem.DuraMax;
      ClientItem.Amount:=UserItem.Amount;
      ClientItem.MakeIndex:=UserItem.MakeIndex;
      sSendMsg:=sSendMsg + EncodeBuffer(@ClientItem,SizeOf(TClientItem)) + '/';
    end;

  end;
  m_DefMsg:=MakeDefaultMsg(SM_SAVEITEMLIST,nBaseObject,0,0,m_StorageItemList.Count);
  SendSocket(@m_DefMsg,sSendMsg);
end;

procedure TPlayObject.SendChangeGuildName; //004DE5A4
begin
  if m_MyGuild <> nil then begin
    SendDefMessage(SM_CHANGEGUILDNAME,0,0,0,0,TGuild(m_MyGuild).sGuildName + '/' + m_sGuildRankName);
  end else begin
    SendDefMessage(SM_CHANGEGUILDNAME,0,0,0,0,'');
  end;    
end;

procedure TPlayObject.SendDelItemList(ItemList: TStringList); //004D0DAC
var
  I: Integer;
  s10:String;
begin
  s10:='';
  for I := 0 to ItemList.Count - 1 do begin
    s10:=s10 + ItemList.Strings[i] + '/' + IntToStr(Integer(ItemList.Objects[i])) + '/';
  end;
  m_DefMsg:=MakeDefaultMsg(SM_DELITEMS,0,0,0,ItemList.Count);
  SendSocket(@m_DefMsg,EncodeString(s10));
end;

procedure TPlayObject.SendDelItems(UserItem: pTUserItem);//004D0BDC
var
  StdItem:TItem;
  ClientItem:TClientItem;
begin
  StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    StdItem.GetStandardItem(ClientItem.S);
    StdItem.GetItemAddValue(UserItem,ClientItem.S);
    ClientItem.S.Name := GetItemName(UserItem);

    ClientItem.MakeIndex:=UserItem.MakeIndex;
    ClientItem.Dura:=UserItem.Dura;
    ClientItem.DuraMax:=UserItem.DuraMax;
    ClientItem.Amount:=UserItem.Amount;
    if StdItem.StdMode = 50 then begin
      ClientItem.S.Name:=ClientItem.S.Name + ' #' + IntToStr(UserItem.Dura);
    end;
    m_DefMsg:=MakeDefaultMsg(SM_DELITEM,Integer(Self),0,0,1);
    SendSocket(@m_DefMsg,EncodeBuffer(@ClientItem,SizeOf(TClientItem)));
  end;
end;

procedure TPlayObject.SendUpdateItem(UserItem: pTUserItem);//004D0A10
var
  StdItem:TItem;
  ClientItem:TClientItem;
begin

  StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
  if StdItem <> nil then begin
    StdItem.GetStandardItem(ClientItem.S);
    StdItem.GetItemAddValue(UserItem,ClientItem.S);
    ClientItem.S.Name := GetItemName(UserItem);

    ClientItem.MakeIndex:=UserItem.MakeIndex;
    ClientItem.Dura:=UserItem.Dura;
    ClientItem.DuraMax:=UserItem.DuraMax;
    ClientItem.Amount:=UserItem.Amount;
    if StdItem.StdMode = 50 then begin
      ClientItem.S.Name:=ClientItem.S.Name + ' #' + IntToStr(UserItem.Dura);
    end;
    m_DefMsg:=MakeDefaultMsg(SM_UPDATEITEM,Integer(Self),0,0,1);
    SendSocket(@m_DefMsg,EncodeBuffer(@ClientItem,SizeOf(TClientItem)));
  end;
end;

function TPlayObject.CheckTakeOnItems(nWhere: Integer;var StdItem: TStdItem): Boolean; //004C5084
var
  Castle:TUserCastle;
begin
  Result:=False;
  if (StdItem.StdMode = 10) and (m_btGender <> gMan) then begin
    SysMsg(sWearNotOfWoMan,c_Red,t_Hint);
    exit;
  end;
  if (StdItem.StdMode = 11) and (m_btGender <> gWoMan) then begin
    SysMsg(sWearNotOfMan,c_Red,t_Hint);
    exit;
  end;
  if (nWhere = 1) or (nWhere = 2) then begin
    if StdItem.Weight > m_WAbil.MaxHandWeight then begin
      SysMsg(sHandWeightNot,c_Red,t_Hint);
      exit;
    end;
  end else begin
    if (StdItem.Weight + GetUserItemWeitht(nWhere)) > m_WAbil.MaxWearWeight then begin
      SysMsg(sWearWeightNot,c_Red,t_Hint);
      exit;
    end;
  end;
  Castle:=g_CastleManager.IsCastleMember(Self);
  case StdItem.Need of    //
    0: begin
      if m_Abil.Level >= StdItem.NeedLevel then begin
        Result:=True;
      end else begin
        SysMsg(g_sLevelNot,c_Red,t_Hint);
      end;
    end;
    1: begin
      if HiWord(m_WAbil.DC) >= StdItem.NeedLevel then begin
        Result:=True;
      end else begin
        SysMsg(g_sDCNot,c_Red,t_Hint);
      end;
    end;
    10: begin
      if( m_btJob = LoWord(StdItem.NeedLevel)) and (m_Abil.Level >= HiWord(StdItem.NeedLevel)) then begin
        Result:=True;
      end else begin
        SysMsg(g_sJobOrLevelNot,c_Red,t_Hint);
      end;
    end;
    11: begin
      if( m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.DC) >= HiWord(StdItem.NeedLevel)) then begin
        Result:=True;
      end else begin
        SysMsg(g_sJobOrDCNot,c_Red,t_Hint);
      end;
    end;
    12: begin
      if( m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.MC) >= HiWord(StdItem.NeedLevel)) then begin
        Result:=True;
      end else begin
        SysMsg(g_sJobOrMCNot,c_Red,t_Hint);
      end;
    end;
    13: begin
      if( m_btJob = LoWord(StdItem.NeedLevel)) and (HiWord(m_WAbil.SC) >= HiWord(StdItem.NeedLevel)) then begin
        Result:=True;
      end else begin
        SysMsg(g_sJobOrSCNot,c_Red,t_Hint);
      end;
    end;
    2: begin
      if HiWord(m_WAbil.MC) >= StdItem.NeedLevel then begin
        Result:=True;
      end else begin
        SysMsg(g_sMCNot,c_Red,t_Hint);
      end;
    end;
    3: begin
      if HiWord(m_WAbil.SC) >= StdItem.NeedLevel then begin
        Result:=True;
      end else begin
        SysMsg(g_sSCNot,c_Red,t_Hint);
      end;
    end;
    4: begin
      if m_btReLevel >= StdItem.NeedLevel then begin
        Result:=True;
      end else begin
        SysMsg(g_sReNewLevelNot,c_Red,t_Hint);
      end;
    end;
    40: begin
      if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
        if m_Abil.Level >= HiWord(StdItem.NeedLevel) then begin
          Result:=True;
        end else begin
          SysMsg(g_sLevelNot,c_Red,t_Hint);
        end;
      end else begin
        SysMsg(g_sReNewLevelNot,c_Red,t_Hint);
      end;
    end;
    41: begin
      if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
        if HiWord(m_WAbil.DC) >= HiWord(StdItem.NeedLevel) then begin
          Result:=True;
        end else begin
          SysMsg(g_sDCNot,c_Red,t_Hint);
        end;
      end else begin
        SysMsg(g_sReNewLevelNot,c_Red,t_Hint);
      end;
    end;
    42: begin
      if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
        if HiWord(m_WAbil.MC) >= HiWord(StdItem.NeedLevel) then begin
          Result:=True;
        end else begin
          SysMsg(g_sMCNot,c_Red,t_Hint);
        end;
      end else begin
        SysMsg(g_sReNewLevelNot,c_Red,t_Hint);
      end;
    end;
    43: begin
      if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
        if HiWord(m_WAbil.SC) >= HiWord(StdItem.NeedLevel) then begin
          Result:=True;
        end else begin
          SysMsg(g_sSCNot,c_Red,t_Hint);
        end;
      end else begin
        SysMsg(g_sReNewLevelNot,c_Red,t_Hint);
      end;
    end;
    44: begin
      if m_btReLevel >= LoWord(StdItem.NeedLevel) then begin
        if m_btCreditPoint >= HiWord(StdItem.NeedLevel) then begin
          Result:=True;
        end else begin
          SysMsg(g_sCreditPointNot,c_Red,t_Hint);
        end;
      end else begin
        SysMsg(g_sReNewLevelNot,c_Red,t_Hint);
      end;
    end;
    5: begin
      if m_btCreditPoint >= StdItem.NeedLevel then begin
        Result:=True;
      end else begin
        SysMsg(g_sCreditPointNot,c_Red,t_Hint);
      end;
    end;
    6: begin
      if (m_MyGuild <> nil)then begin
        Result:=True;
      end else begin
        SysMsg(g_sGuildNot,c_Red,t_Hint);
      end;
    end;
    60: begin
      if (m_MyGuild <> nil) and (m_nGuildRankNo = 1) then begin
        Result:=True;
      end else begin
        SysMsg(g_sGuildMasterNot,c_Red,t_Hint);
      end;
    end;
    7: begin
//      if (m_MyGuild <> nil) and (UserCastle.m_MasterGuild = m_MyGuild) then begin
      if (m_MyGuild <> nil) and (Castle <> nil) then begin
        Result:=True;
      end else begin
        SysMsg(g_sSabukHumanNot,c_Red,t_Hint);
      end;
    end;
    70: begin
//      if (m_MyGuild <> nil) and (UserCastle.m_MasterGuild = m_MyGuild) and (m_nGuildRankNo = 1) then begin
      if (m_MyGuild <> nil) and (Castle <> nil) and (m_nGuildRankNo = 1) then begin
        if m_Abil.Level >= StdItem.NeedLevel then begin
          Result:=True;
        end else begin
          SysMsg(g_sLevelNot,c_Red,t_Hint);
        end;
      end else begin
        SysMsg(g_sSabukMasterManNot,c_Red,t_Hint);
      end;
    end;
    8: begin
      if m_nMemberType <> 0 then begin
        Result:=True;
      end else begin
        SysMsg(g_sMemberNot,c_Red,t_Hint);
      end;
    end;
    81: begin
      if (m_nMemberType = LoWord(StdItem.NeedLevel)) and (m_nMemberLevel >= HiWord(StdItem.NeedLevel)) then begin
        Result:=True;
      end else begin
        SysMsg(g_sMemberTypeNot,c_Red,t_Hint);
      end;
    end;
    82: begin
      if (m_nMemberType >= LoWord(StdItem.NeedLevel)) and (m_nMemberLevel >= HiWord(StdItem.NeedLevel)) then begin
        Result:=True;
      end else begin
        SysMsg(g_sMemberTypeNot,c_Red,t_Hint);
      end;
    end;
  end;
  //if not Result then SysMsg(g_sCanottWearIt,c_Red,t_Hint);

end;

function TBaseObject.sub_4C5370(nX, nY:Integer;nRange: Integer;var nDX, nDY:Integer): Boolean; //004C5370
var
  I    :Integer;
  II   :Integer;
  III  :Integer;
begin
  Result:=False;
  if m_PEnvir.GetMovingObject(nX,nY,True) = nil then begin
    Result:=True;
    nDX:=nX;
    nDY:=nY;
  end;
  if not Result then begin
    for I := 1 to nRange do begin
      for II := -I to I do begin
        for III := -I to I do begin
          nDX := nX + III;
          nDY := nY + II;
          if m_PEnvir.GetMovingObject(nDX,nDY,True) = nil then begin
            Result:=True;
            break;
          end;
        end;
        if Result then break;
      end;
      if Result then break;
    end;
  end;
  if not Result then begin
    nDX:=nX;
    nDY:=nY;
  end;    
end;

function TPlayObject.GetUserItemWeitht(nWhere: Integer): Integer; //004BF764
var
  I: Integer;
  n14:Integer;
  StdItem:TItem;
begin
  n14:=0;
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    if (nWhere = -1) or (not (i = nWhere) and not (i = 1) and not (i = 2)) then begin
      StdItem:=UserEngine.GetStdItem(m_UseItems[i].wIndex);
      if StdItem <> nil then Inc(n14,StdItem.Weight);
    end;
  end;
  Result:=n14;
end;

function TPlayObject.EatItems(StdItem: TItem;UserItem:pTUserItem): Boolean;//004C6238
var
  boNeedRecalc:Boolean;
  nOldStatus:Integer;
  nDateCreated:dWord;
  //nRealDate:longWord;
begin
  Result:=False;
  if m_PEnvir.Flag.boNODRUG then begin
    SysMsg(sCanotUseDrugOnThisMap,c_Red,t_Hint);
    exit;
  end;
  case StdItem.StdMode of
    0: begin //004C62BA
      case StdItem.Shape of
        1: begin
          IncHealthSpell(StdItem.AC,StdItem.MAC);
          Result:=True;
        end;
        2: begin
          m_boUserUnLockDurg:=True;
          Result:=True;
        end;
        3: begin
          IncHealthSpell(Round((m_WAbil.MaxHP / 100)*StdItem.AC),Round((m_WAbil.MaxMP / 100)*StdItem.MAC));
          Result:=True;
        end;
        else begin
          {
          if ((StdItem.AC + m_nIncHealth) < 500) and (StdItem.AC > 0) then begin
            Inc(m_nIncHealth,StdItem.AC);
          end;
          if ((StdItem.MAC + m_nIncSpell) < 500) and (StdItem.MAC > 0) then begin
            Inc(m_nIncSpell,StdItem.MAC);
          end;
          }
          if (StdItem.AC > 0) then begin
            Inc(m_nIncHealth,StdItem.AC);
          end;
          if (StdItem.MAC > 0) then begin
            Inc(m_nIncSpell,StdItem.MAC);
          end;
          Result:=True;
        end;
      end;
    end;
    1: begin
      nOldStatus:=GetMyStatus();
      Inc(m_nHungerStatus,StdItem.DuraMax div 10);
      m_nHungerStatus:=_MIN(5000,m_nHungerStatus);
      if nOldStatus <> GetMyStatus() then
        RefMyStatus();
      Result:=True;
    end;
    2: Result:=True;
    3: begin
      case StdItem.Shape of
      12: begin
        boNeedRecalc:=False;
        if StdItem.DC > 0 then begin
          m_wStatusArrValue[0{0x218}]:=StdItem.DC;
          m_dwStatusArrTimeOutTick[0{0x220}]:=GetTickCount + StdItem.MAC2 * 1000;
          SysMsg('Temporarily destructive power increased during ' + IntToStr(StdItem.MAC2) + 'sec.',c_Green,t_Hint);
          boNeedRecalc:=True;
        end;
        if StdItem.MC > 0 then begin
          m_wStatusArrValue[1{0x219}]:=StdItem.MC;
          m_dwStatusArrTimeOutTick[1{0x224}]:=GetTickCount + StdItem.MAC2 * 1000;
          SysMsg('Temporarily magic power increased during ' + IntToStr(StdItem.MAC2) + 'sec.',c_Green,t_Hint);
          boNeedRecalc:=True;
        end;
        if StdItem.SC > 0 then begin
          m_wStatusArrValue[2{0x21A}]:=StdItem.SC;
          m_dwStatusArrTimeOutTick[2{0x228}]:=GetTickCount + StdItem.MAC2 * 1000;
          SysMsg('Temporarily zen power increased during ' + IntToStr(StdItem.MAC2) + 'sec.',c_Green,t_Hint);
          boNeedRecalc:=True;
        end;
        if StdItem.AC2 > 0 then begin
          m_wStatusArrValue[3{0x21B}]:=StdItem.AC2;
          m_dwStatusArrTimeOutTick[3{0x22C}]:=GetTickCount + StdItem.MAC2 * 1000;
          SysMsg('Temporarily hitting speed increased during ' + IntToStr(StdItem.MAC2) + 'sec.',c_Green,t_Hint);
          boNeedRecalc:=True;
        end;
        if StdItem.AC > 0 then begin
          m_wStatusArrValue[4{0x21C}]:=StdItem.AC;
          m_dwStatusArrTimeOutTick[4{0x230}]:=GetTickCount + StdItem.MAC2 * 1000;
          SysMsg('Temporarily HP increased during ' + IntToStr(StdItem.MAC2) + 'sec.',c_Green,t_Hint);
          boNeedRecalc:=True;
        end;
        if StdItem.MAC > 0 then begin
          m_wStatusArrValue[5{0x21D}]:=StdItem.MAC;
          m_dwStatusArrTimeOutTick[5{0x234}]:=GetTickCount + StdItem.MAC2 * 1000;
          SysMsg('Temporarily MP increased during ' + IntToStr(StdItem.MAC2) + 'sec.',c_Green,t_Hint);
          boNeedRecalc:=True;
        end;
        if boNeedRecalc then begin
          RecalcAbilitys();
          SendMsg(Self,RM_ABILITY,0,0,0,0,'');
          Result:=True;
        end;
      end;
      7: begin

        nDateCreated:=MakeLong(MakeWord(UserItem.btValue[1],UserItem.btValue[2]),MakeWord(UserItem.btValue[3],UserItem.btValue[4]));
 //       nRealDate:=nDateCreated + (UserItem.btValue[5] * (Int64(high(nDateCreated))+1));
        if (nDateCreated >= DateTimeToUnix(now)) and (g_GuildTerritory.FindGuildTerritory(UserItem.btValue[0]).GuildName <> '')  then begin
          Result:= MoveToGT(UserItem.btValue[0]);
        end else
          SysMsg('This Scroll has Expired',c_Red,t_Hint);
      end;
      13: begin
        GetExp(StdItem.DuraMax);
        Result := True;
      end;
      else
        Result:=EatUseItems(StdItem.Shape);
      end;
    end;
  end;
end;

function TPlayObject.ReadBook(StdItem:TItem): Boolean; //004C67DC
var
  Magic:pTMagic;
  UserMagic:pTUserMagic;
  PlayObject:TPlayObject;
begin
  Result:=False;
  Magic:=UserEngine.FindMagic(StdItem.Name);
  if Magic <> nil then begin
    if not IsTrainingSkill(Magic.wMagicId) then begin
      if (Magic.btJob = 99) or (Magic.btJob = m_btJob) then begin
        if m_Abil.Level >= Magic.TrainLevel[0] then begin
          New(UserMagic);
          UserMagic.MagicInfo:=Magic;
          UserMagic.wMagIdx:=Magic.wMagicId;
          UserMagic.btKey:=0;
          UserMagic.btLevel:=0;
          UserMagic.nTranPoint:=0;
          m_MagicList.Add(UserMagic);
          RecalcAbilitys();
          if m_btRaceServer = RC_PLAYOBJECT  then begin
            PlayObject:=TPlayObject(Self);
            PlayObject.SendAddMagic(UserMagic);
          end;
          Result:=True;
        end;
      end;
    end;
  end;
end;

function TBaseObject.IsTrainingSkill(nIndex: Integer): Boolean; //004C6780
var
  I: Integer;
  UserMagic:pTUserMagic;
begin
  Result:=False;
  for I := 0 to m_MagicList.Count - 1 do begin
    UserMagic:=m_MagicList.Items[i];
    if (UserMagic <> nil) and (UserMagic.wMagIdx = nIndex) then begin
      Result:=True;
      break;
    end;
  end;
end;

procedure TPlayObject.SendAddMagic(UserMagic: pTUserMagic); //004D12F4
var
  ClientMagic:TClientMagic;
begin
   ClientMagic.Key:=Char(UserMagic.btKey);
   ClientMagic.Level:=UserMagic.btLevel;
   ClientMagic.CurTrain:=UserMagic.nTranPoint;
   ClientMagic.Def:=UserMagic.MagicInfo^;
   m_DefMsg:=MakeDefaultMsg(SM_ADDMAGIC,0,0,0,1);
   SendSocket(@m_DefMsg,EncodeBuffer(@ClientMagic,SizeOf(TClientMagic)));
end;
procedure TPlayObject.SendDelMagic(UserMagic: pTUserMagic);
begin
  m_DefMsg:=MakeDefaultMsg(SM_DELMAGIC,UserMagic.wMagIdx,0,0,1);
  SendSocket(@m_DefMsg,'');
end;

function TPlayObject.EatUseItems(nShape: integer): Boolean; //004BD1BC
var
  Castle:TUserCastle;
begin
  Result:=False;
  case nShape of    //
    1: begin
      SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
      BaseObjectMove(m_sHomeMap,'','');
      Result:=True;
    end;
    2: begin
      if not m_PEnvir.Flag.boNORANDOMMOVE then begin
        SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
        BaseObjectMove(m_sMapName,'','');
        Result:=True;
      end;
    end;
    3: begin
      SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
      if PKLevel < 2 then begin
        BaseObjectMove(m_sHomeMap,IntToStr(m_nHomeX),IntToStr(m_nHomeY));
      end else begin
        BaseObjectMove(g_Config.sRedHomeMap,IntToStr(g_Config.nRedHomeX),IntToStr(g_Config.nRedHomeY));
      end;
      Result:=True;
    end;
    4: begin
      if WeaptonMakeLuck() then Result:=True;
    end;
    5: begin
      if m_MyGuild <> nil then begin
        if not m_boInFreePKArea then begin
          Castle:=g_CastleManager.IsCastleMember(Self);
          {
          if UserCastle.IsMasterGuild(TGuild(m_MyGuild)) then begin
            BaseObjectMove(UserCastle.m_sHomeMap,IntToStr(UserCastle.GetHomeX),IntToStr(UserCastle.GetHomeY));
          }
          if (Castle <> nil) and Castle.IsMasterGuild(TGuild(m_MyGuild)) then begin
            BaseObjectMove(Castle.m_sHomeMap,IntToStr(Castle.GetHomeX),IntToStr(Castle.GetHomeY));
          end else begin
            SysMsg('Your guild does not own a castle',c_Red,t_Hint);
          end;
          Result:=True;
        end else begin //004BD3F7
          SysMsg('Unable to teleport from this location',c_Red,t_Hint);
        end;
      end;
    end;
    6: begin
      if m_myGuild <> nil then begin
        if TGuild(m_MyGuild).m_Territory = nil then begin
          SysMsg('Your guild does not have any territory',c_Red,t_Hint);
          exit;
        end;
        //SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
        if MoveToGT(TTerritory(TGuild(m_MyGuild).m_Territory).TerritoryNumber) then begin
          Result:=True;
        end else
          SysMsg('Your guild does not have any territory',c_Red,t_Hint);
      end else
        SysMsg('You need to be in a guild first',c_Red,t_Hint);
    end;
    9: begin
      if RepairWeapon() then Result:=True;
    end;
    10: begin
      if SuperRepairWeapon() then Result:=True;
    end;
    11: begin
      if WinLottery() then Result:=True;
    end;
  end;
end;
function TPlayObject.MoveToGT(number:integer):boolean;
var
  i:Integer;
  Envir:TEnvirnoment;
begin
  result:=False;
  envir:=nil;
  for i:=0 to g_MapManager.Count -1 do begin
    Envir:=TEnvirnoment(g_MapManager.Items[I]);
    if (Envir.Flag.nGuildTerritory = number) and (Envir.sMapName = g_Config.sGTHomeMap) then
      break;
  end;
  if envir = nil then exit;
  SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
  SpaceMoveEx(Envir.sMapName,g_Config.nGTHomeX,g_Config.nGTHomeY,0,number);
//  if EnterAnotherMap(Envir,g_Config.nGTHomeX,g_Config.nGTHomeY) then
    result:=true;
end;
procedure TPlayObject.MoveToHome;
begin
  SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
  BaseObjectMove(m_sHomeMap,IntToStr(m_nHomeX),IntToStr(m_nHomeY));
end;

procedure TPlayObject.BaseObjectMove(sMap,sX,sY:String); //004BD0C4
var
  Envir:TEnvirnoment;
  nX,nY:Integer;
begin
  Envir:=m_PEnvir;
  if sMap = '' then sMap:=m_sMapName;
  if (sX <> '') and (sY <> '') then begin
    nX:=Str_ToInt(sX,0);
    nY:=Str_ToInt(sY,0);
    SpaceMove(sMap,nX,nY,0);
  end else begin
    MapRandomMove(sMap,0);
  end;
  if (Envir <> m_PEnvir) and (m_btRaceServer = RC_PLAYOBJECT) then begin
    m_boTimeRecall:=False;
  end;

end;

function TPlayObject.WeaptonMakeLuck: Boolean; //004BD4A0
var
  StdItem:TItem;
  nRand:Integer;
  boMakeLuck:Boolean;
begin
  Result:=False;
  if m_UseItems[U_WEAPON].wIndex <= 0 then exit;
  nRand:=0;
  StdItem:=UserEngine.GetStdItem(m_UseItems[U_WEAPON].wIndex);
  if StdItem <> nil then begin
    nRand:=abs((StdItem.DC2 - StdItem.DC)) div 5;
  end;
  if Random(g_Config.nWeaponMakeUnLuckRate{20}) = 1 then begin
    MakeWeaponUnlock();
  end else begin //004BD527
    boMakeLuck:=False;
    if m_UseItems[U_WEAPON].btValue[4] > 0 then begin
      Dec(m_UseItems[U_WEAPON].btValue[4]);
      SysMsg(g_sWeaptonMakeLuck,c_Green,t_Hint);
      boMakeLuck:=True;
    end else if m_UseItems[U_WEAPON].btValue[3] < g_Config.nWeaponMakeLuckPoint1{1} then begin
      Inc(m_UseItems[U_WEAPON].btValue[3]);
      SysMsg(g_sWeaptonMakeLuck,c_Green,t_Hint);
      boMakeLuck:=True;
    end else if (m_UseItems[U_WEAPON].btValue[3] < g_Config.nWeaponMakeLuckPoint2{3}) and (Random(nRand + g_Config.nWeaponMakeLuckPoint2Rate{6}) = 1) then begin
      Inc(m_UseItems[U_WEAPON].btValue[3]);
      SysMsg(g_sWeaptonMakeLuck,c_Green,t_Hint);
      boMakeLuck:=True;
    end else if (m_UseItems[U_WEAPON].btValue[3] < g_Config.nWeaponMakeLuckPoint3{7}) and (Random(nRand * g_Config.nWeaponMakeLuckPoint3Rate{10 + 30}) = 1) then begin
      Inc(m_UseItems[U_WEAPON].btValue[3]);
      SysMsg(g_sWeaptonMakeLuck,c_Green,t_Hint);
      boMakeLuck:=True;
    end;
    if m_btRaceServer = RC_PLAYOBJECT then begin
      RecalcAbilitys();
      SendMsg(Self,RM_ABILITY,0,0,0,0,'');
      SendMsg(Self,RM_SUBABILITY,0,0,0,0,'');
    end;
    if not boMakeLuck then SysMsg(g_sWeaptonNotMakeLuck,c_Green,t_Hint);
  end;
  Result:=True;
end;

function TPlayObject.RepairWeapon: Boolean; //004BD69C
var
  nDura:Integer;
  UserItem:pTUserItem;
begin
  Result:=False;
  UserItem:=@m_UseItems[U_WEAPON];
  if (UserItem.wIndex <= 0) or (UserItem.DuraMax <= UserItem.Dura) then exit;
  Dec(UserItem.DuraMax,(UserItem.DuraMax - UserItem.Dura) div g_Config.nRepairItemDecDura{30});
  nDura:=_MIN(5000,UserItem.DuraMax - UserItem.Dura);
  if nDura > 0 then begin
    Inc(UserItem.Dura,nDura);
    SendMsg(Self,RM_DURACHANGE,1,UserItem.Dura,UserItem.DuraMax,0,'');
    SysMsg(g_sWeaponRepairSuccess,c_Green,t_Hint);
    Result:=True;
  end;    
end;

function TPlayObject.SuperRepairWeapon: Boolean; //004BD768
begin
  Result:=False;
  if m_UseItems[U_WEAPON].wIndex <= 0 then exit;
  m_UseItems[U_WEAPON].Dura:=m_UseItems[U_WEAPON].DuraMax;
  SendMsg(Self,RM_DURACHANGE,1,m_UseItems[U_WEAPON].Dura,m_UseItems[U_WEAPON].DuraMax,0,'');
  SysMsg(g_sWeaponRepairSuccess,c_Green,t_Hint);
  Result:=True;
end;

function TPlayObject.WinLottery: Boolean; //004BD7F8
var
  nGold,nWinLevel,nRate:Integer;
begin
  nGold:=0;
  nWinLevel:=0;
  {
  case Random(30000) of
    0..4999: begin //004BD866
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=500;
       nWinLevel:=6;
       Inc(nWinLotteryLevel6);
     end;
    end;
    14000..15999: begin //004BD895
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=1000;
       nWinLevel:=5;
       Inc(nWinLotteryLevel5);
     end;
    end;
    16000..16149: begin //004BD8C4
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=10000;
       nWinLevel:=4;
       Inc(nWinLotteryLevel4);
     end;
    end;
    16150..16169: begin //004BD8F0
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=100000;
       nWinLevel:=3;
       Inc(nWinLotteryLevel3);
     end;
    end;
    16170..16179: begin //004BD918
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=200000;
       nWinLevel:=2;
       Inc(nWinLotteryLevel2);
     end;
    end;
    16180 + 1820: begin //004BD940
     if nWinLotteryCount < nNoWinLotteryCount then begin
       nGold:=1000000;
       nWinLevel:=1;
       Inc(nWinLotteryLevel1);
     end;
    end;
  end;
  }
  nRate:=Random(g_Config.nWinLotteryRate);
  if nRate in [g_Config.nWinLottery6Min..g_Config.nWinLottery6Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold:=g_Config.nWinLottery6Gold;
      nWinLevel:=6;
      Inc(g_Config.nWinLotteryLevel6);
    end;
  end else
  if nRate in [g_Config.nWinLottery5Min..g_Config.nWinLottery5Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold:=g_Config.nWinLottery5Gold;
      nWinLevel:=5;
      Inc(g_Config.nWinLotteryLevel5);
    end;
  end else
  if nRate in [g_Config.nWinLottery4Min..g_Config.nWinLottery4Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold:=g_Config.nWinLottery4Gold;
      nWinLevel:=4;
      Inc(g_Config.nWinLotteryLevel4);
    end;
  end else
  if nRate in [g_Config.nWinLottery3Min..g_Config.nWinLottery3Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold:=g_Config.nWinLottery3Gold;
      nWinLevel:=3;
      Inc(g_Config.nWinLotteryLevel3);
    end;
  end else
  if nRate in [g_Config.nWinLottery2Min..g_Config.nWinLottery2Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold:=g_Config.nWinLottery2Gold;
      nWinLevel:=2;
      Inc(g_Config.nWinLotteryLevel2);
    end;
  end else
  if nRate in [g_Config.nWinLottery1Min + g_Config.nWinLottery1Max] then begin
    if g_Config.nWinLotteryCount < g_Config.nNoWinLotteryCount then begin
      nGold:=g_Config.nWinLottery1Gold;
      nWinLevel:=1;
      Inc(g_Config.nWinLotteryLevel1);
    end;
  end;
  if nGold > 0 then begin
    case nWinLevel of    //
      1: SysMsg(g_sWinLottery1Msg,c_Green,t_Hint);
      2: SysMsg(g_sWinLottery2Msg,c_Green,t_Hint);
      3: SysMsg(g_sWinLottery3Msg,c_Green,t_Hint);
      4: SysMsg(g_sWinLottery4Msg,c_Green,t_Hint);
      5: SysMsg(g_sWinLottery5Msg,c_Green,t_Hint);
      6: SysMsg(g_sWinLottery6Msg,c_Green,t_Hint);
    end;  
    if IncGold(nGold) then begin
      GoldChanged();
    end else begin
      DropGoldDown(nGold,True,nil,nil);
    end;
      
  end else begin
    Inc(g_Config.nNoWinLotteryCount,500);
    SysMsg(g_sNotWinLotteryMsg,c_Red,t_Hint);
  end;
  Result:=True;
end;



procedure TBaseObject.DamageBubbleDefence(nInt: Integer); //004C6ED0
begin
  if m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP{0x76}] > 0 then begin
    if m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP{0x76}] > 3 then
      Dec(m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP{0x76}],3)
    else m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP{0x76}]:=1;
  end;
end;



function TBaseObject.IsGuildMaster: Boolean; //004BF4A0
begin
  Result:=False;
  if (m_MyGuild <> nil) and (m_nGuildRankNo = 1) then
    Result:=True;
end;

procedure TPlayObject.ChangeServerMakeSlave(SlaveInfo: pTSlaveInfo);  //004DF84C
var
  nSlavecount:Integer;
  BaseObject:TBaseObject;
begin
  if m_btJob = jTaos then begin
    nSlavecount:=1;
  end else begin
    nSlavecount:=5;
  end;
  BaseObject:=MakeSlave(SlaveInfo.sSlaveName,3,SlaveInfo.btSlaveLevel,nSlavecount,SlaveInfo.dwRoyaltySec);
  if BaseObject <> nil then begin
    BaseObject.n294:=SlaveInfo.nKillCount;
    BaseObject.m_btSlaveExpLevel:=SlaveInfo.btSlaveExpLevel;
    BaseObject.m_WAbil.HP:=SlaveInfo.nHP;
    BaseObject.m_WAbil.MP:=SlaveInfo.nMP;
    if (1500 - SlaveInfo.btSlaveLevel * 200) < BaseObject.m_nWalkSpeed then begin
      BaseObject.m_nWalkSpeed:=1500 - SlaveInfo.btSlaveLevel * 200;
    end;
    if Integer(2000 - SlaveInfo.btSlaveLevel * 200) < BaseObject.m_nNextHitTime then begin
      BaseObject.m_nWalkSpeed:=2000 - SlaveInfo.btSlaveLevel * 200;
    end;
    RecalcAbilitys();
  end;
end;

procedure TPlayObject.SendDelDealItem(UserItem:pTUserItem); //004DD5D0
var
  pStdItem:TItem;
  ClientItem:TClientItem;
begin

  SendDefMessage(SM_DEALDELITEM_OK,0,0,0,0,'');
  if m_DealCreat <> nil then begin
      pStdItem:=UserEngine.GetStdItem(UserItem.wIndex);
      if pStdItem <> nil then begin
        pStdItem.GetStandardItem(ClientItem.S);
        ClientItem.S.Name := GetItemName(UserItem);


        ClientItem.MakeIndex:=UserItem.MakeIndex;
        ClientItem.Dura:=UserItem.Dura;
        ClientItem.DuraMax:=UserItem.DuraMax;
        ClientItem.Amount:=UserItem.Amount;
      end;
      m_DefMsg:=MakeDefaultMsg(SM_DEALREMOTEDELITEM,Integer(Self),0,0,1);
      TPlayObject(m_DealCreat).SendSocket(@m_DefMsg,EncodeBuffer(@ClientItem,SizeOf(TClientItem)));
    m_DealCreat.m_DealLastTick:=GetTickCount();
    m_DealLastTick:=GetTickCount();
  end;
end;
{
procedure TPlayObject.SendAddDealItem(UserItem: pTUserItem); //004DD464
var
  StdItem:pTStdItem;
  StdItem80:TStdItem;
  ClientItem:TClientItem;
  OClientItem:TOClientItem;
  //sItemNewName:String;
begin

  //sItemNewName:=GetItemName(UserItem.MakeIndex);
if m_nSoftVersionDateEx = 0 then begin
  SendDefMessage(SM_DEALADDITEM_OK,0,0,0,0,'');
  if m_DealCreat <> nil then begin
    StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      StdItem80:=StdItem^;
      ItemUnit.GetItemAddValue(UserItem,StdItem80);
      //OClientItem.S:=StdItem80;
      CopyStdItemToOStdItem(@StdItem80,@OClientItem.S);
      //if sItemNewName <> '' then
      //  OClientItem.S.Name:=sItemNewName;
      OClientItem.MakeIndex:=UserItem.MakeIndex;
      OClientItem.Dura:=UserItem.Dura;
      OClientItem.DuraMax:=UserItem.DuraMax;
    end;
    m_DefMsg:=MakeDefaultMsg(SM_DEALREMOTEADDITEM,Integer(Self),0,0,1);
    TPlayObject(m_DealCreat).SendSocket(@m_DefMsg,EncodeBuffer(@OClientItem,SizeOf(TOClientItem)));
    m_DealCreat.m_DealLastTick:=GetTickCount();
    m_DealLastTick:=GetTickCount();
  end;
end else begin
  SendDefMessage(SM_DEALADDITEM_OK,0,0,0,0,'');
  if m_DealCreat <> nil then begin
    StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
    if StdItem <> nil then begin
      StdItem80:=StdItem^;
      ItemUnit.GetItemAddValue(UserItem,StdItem80);
      ClientItem.S:=StdItem80;
      //if sItemNewName <> '' then
      //  ClientItem.S.Name:=sItemNewName;
      ClientItem.MakeIndex:=UserItem.MakeIndex;
      ClientItem.Dura:=UserItem.Dura;
      ClientItem.DuraMax:=UserItem.DuraMax;
    end;
    m_DefMsg:=MakeDefaultMsg(SM_DEALREMOTEADDITEM,Integer(Self),0,0,1);
    TPlayObject(m_DealCreat).SendSocket(@m_DefMsg,EncodeBuffer(@ClientItem,SizeOf(TClientItem)));
    m_DealCreat.m_DealLastTick:=GetTickCount();
    m_DealLastTick:=GetTickCount();
  end;
end;
end;
}
procedure TPlayObject.SendAddDealItem(UserItem: pTUserItem); //004DD464
var
  StdItem:TItem;
  ClientItem:TClientItem;
begin
 SendDefMessage(SM_DEALADDITEM_OK,0,0,0,0,'');
  if m_DealCreat <> nil then begin
      StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
      if StdItem <> nil then begin
       if not StdItem.boCanTrade then begin //Vexusdev
       SendDefMessage(SM_DEALADDITEM_FAIL,0,0,0,0,'');
       exit;
       end;
        StdItem.GetStandardItem(ClientItem.S);
        StdItem.GetItemAddValue(UserItem,ClientItem.S);
        ClientItem.S.Name := GetItemName(UserItem);

        
        ClientItem.MakeIndex:=UserItem.MakeIndex;
        ClientItem.Dura:=UserItem.Dura;
        ClientItem.DuraMax:=UserItem.DuraMax;
        ClientItem.Amount:=UserItem.Amount;
        m_DefMsg:=MakeDefaultMsg(SM_DEALREMOTEADDITEM,Integer(Self),0,0,1);
        TPlayObject(m_DealCreat).SendSocket(@m_DefMsg,EncodeBuffer(@ClientItem,SizeOf(TClientItem)));
        m_DealCreat.m_DealLastTick:=GetTickCount();
        m_DealLastTick:=GetTickCount();
    end;
  end;
end;
procedure TPlayObject.OpenDealDlg(BaseObject:TBaseObject); //004DD300
begin
  m_boDealing:=True;
  m_DealCreat:=BaseObject;
  GetBackDealItems();
  SendDefMessage(SM_DEALMENU,0,0,0,0,m_DealCreat.m_sCharName);
  m_DealLastTick:=GetTickCount();
end;

procedure TPlayObject.JoinGroup(PlayObject: TPlayObject); //004C3AE4
begin
  m_GroupOwner:=PlayObject;
  //SendGroupText(m_sCharName + ' 已加入小组.');
  SendGroupText(format(g_sJoinGroup,[m_sCharName]));
end;

function TBaseObject.MagCanHitTarget(nX, nY:Integer;
  TargeTBaseObject: TBaseObject): Boolean; //004C6B1C
var
  n14,n18,n1C,n20:Integer;
begin
  Result:=False;
  if TargeTBaseObject = nil then exit;
  n20:=abs(nX - TargeTBaseObject.m_nCurrX) + abs(nY - TargeTBaseObject.m_nCurrY);
  n14:=0;
  while (n14 < 13) do begin
    n18:=GetNextDirection(nX,nY,TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY);
    if m_PEnvir.GetNextPosition(nX,nY,n18,1,nX,nY) and m_PEnvir.IsValidCell(nX,nY) then begin
      if (nX = TargeTBaseObject.m_nCurrX) and (nY = TargeTBaseObject.m_nCurrY) then begin
        Result:=True;
        break;
      end else begin
        n1C:=abs(nX - TargeTBaseObject.m_nCurrX) + abs(nY - TargeTBaseObject.m_nCurrY);
        if n1C > n20 then begin
          Result:=True;
          break;
        end;
        n1C:=n20;
      end;
    end else begin
      break;
    end;
    Inc(n14);
  end;
end;

function TBaseObject.IsProperFriend(BaseObject: TBaseObject): boolean; //004C909C
  function IsFriend (cret: TBaseObject): Boolean; //004C8F08
  var
    I: Integer;
  begin
    Result:=False;
    if cret.m_btRaceServer = RC_PLAYOBJECT then begin
      case m_btAttatckMode of
        HAM_ALL:  Result:=True;
        HAM_PEACE: Result:=True;
        HAM_DEAR: begin
          if (Self = Cret) or (Cret = TPlayObject(Self).m_DearHuman) then begin
            Result:=True;
          end;            
        end;
        HAM_MASTER: begin
          if (Self = Cret) then begin
            Result:=True;
          end else
          if TPlayObject(Self).m_boMaster then begin
            for I := 0 to TPlayObject(Self).m_MasterList.Count - 1 do begin
              if TPlayObject(Self).m_MasterList.Items[I] = Cret then begin
                Result:=True;
                break;
              end;
            end;
          end else
          if TPlayObject(Cret).m_boMaster then begin
            for I := 0 to TPlayObject(Cret).m_MasterList.Count - 1 do begin
              if TPlayObject(Cret).m_MasterList.Items[I] = Self then begin
                Result:=True;
                break;
              end;
            end;
          end;
        end;
        HAM_GROUP: begin
          if cret = self then
            Result:=True;
          if IsGroupMember(cret)then
            Result:=True;
        end;
        HAM_GUILD: begin
          if cret = self then
            Result:=True;
          if m_MyGuild <> nil then begin
            if TGuild(m_MyGuild).IsMember(cret.m_sCharName) then
              Result:=True;
            if m_boGuildWarArea and (cret.m_MyGuild <> nil) then begin
              if TGuild(m_MyGuild).IsAllyGuild(TGuild(cret.m_MyGuild)) then
                Result:=True;
            end;
          end;
        end;
        HAM_PKATTACK: begin
          if cret = self then Result:=True;
          if PKLevel >= 2 then begin
            if cret.PKLevel < 2 then Result:=True;
          end else begin
            if cret.PKLevel >= 2 then Result:=True;
          end;
        end;
      end;
    end;
  end;
begin //004C909C
  Result:=False;
  if BaseObject = nil then exit;
  if (m_btRaceServer >= RC_ANIMAL) then begin
    if (BaseObject.m_btRaceServer >= RC_ANIMAL) then
      Result:=True;
    if BaseObject.m_Master <> nil then
      Result:=False;
    exit;
  end;
  if m_btRaceServer = RC_PLAYOBJECT then begin
    Result:=IsFriend(BaseObject);
    if BaseObject.m_btRaceServer < RC_ANIMAL then exit;
    if BaseObject.m_Master = self then begin
      Result:=True;
      exit;
    end;
    if BaseObject.m_Master <> nil then begin
      Result:=IsFriend(BaseObject.m_Master);
      exit;
    end;
  end else Result:=True;//004C913E    
end;

function TBaseObject.IsReincarnation(BaseObject: TBaseObject): Boolean;
begin
  Result := False;
  if (BaseObject = nil) or (BaseObject = Self) then Exit;
  if BaseObject.m_boDeath then begin
    if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
      Result := True;
  end;
end;

function TBaseObject.MagMakeDefenceArea(nX, nY, nRange, nSec: Integer;
  btState: Byte): Integer; //004C6F04
var
  III: Integer;
  I,II: Integer;
  nStartX,nStartY,nEndX,nEndY:Integer;
  MapCellInfo:pTMapCellinfo;
  OSObject:pTOSObject;
  BaseObject:TBaseObject;
begin
  Result:=0;
  nStartX:=nX - nRange;
  nEndX:=nX + nRange;
  nStartY:=nY - nRange;
  nEndY:=nY + nRange;
  for I := nStartX to nEndX do begin
    for II := nStartY to nEndY do begin
      if m_PEnvir.GetMapCellInfo(i,ii,MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for III := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject:=MapCellInfo.ObjList.Items[III];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject:=TBaseObject(OSObject.CellObj);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) then begin
              if IsProperFriend(BaseObject) then begin
                if btState = 0 then begin
                  BaseObject.DefenceUp(nSec);
                end else begin
                  BaseObject.MagDefenceUp(nSec);
                end;
                Inc(Result);
              end
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TBaseObject.MagMakeCurseArea(nX, nY, nRange, nSec, nPow: Integer): Integer; //004C6F04
var
  III: Integer;
  I,II: Integer;
  nStartX,nStartY,nEndX,nEndY:Integer;
  MapCellInfo:pTMapCellinfo;
  OSObject:pTOSObject;
  BaseObject:TBaseObject;
begin
  Result:=0;
  nStartX:=nX - nRange;
  nEndX:=nX + nRange;
  nStartY:=nY - nRange;
  nEndY:=nY + nRange;
  for I := nStartX to nEndX do begin
    for II := nStartY to nEndY do begin
      if m_PEnvir.GetMapCellInfo(i,ii,MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
        for III := 0 to MapCellInfo.ObjList.Count - 1 do begin
          OSObject:=MapCellInfo.ObjList.Items[III];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then begin
            BaseObject:=TBaseObject(OSObject.CellObj);
            if (BaseObject <> nil) and (not BaseObject.m_boGhost) and (not BaseObject.m_boDeath) and ((BaseObject.m_btRaceServer >= RC_ANIMAL) or (BaseObject.m_btRaceServer = RC_PLAYOBJECT )) then begin
              if IsProperTarget(BaseObject) then begin
                BaseObject.MakePosion(POISON_FREEZE,nSec + m_nFreezingIncrease,0);
                BaseObject.AttPowerDown(nPow,nSec);
                if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
                  BaseObject.SetPKFlag(self);
                  BaseObject.SetLastHiter(self);
                 end;
                Inc(Result);
              end
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TBaseObject.DefenceUp(nSec: Integer): Boolean; //004C6C28
begin
  Result:=False;
  if m_wStatusTimeArr[STATE_DEFENCEUP{0x72}] > 0 then begin  //004C6C5C
    if m_wStatusTimeArr[STATE_DEFENCEUP{0x72}] < nSec then begin
      m_wStatusTimeArr[STATE_DEFENCEUP{0x72}]:=nSec;
      Result:=True;
    end;
  end else begin
    m_wStatusTimeArr[STATE_DEFENCEUP{0x72}]:=nSec;
    Result:=True;
  end;
  m_dwStatusArrTick[STATE_DEFENCEUP{0x20C}]:=GetTickCount;
  SysMsg(format(g_sDefenceUpTime,[nSec]),c_Green,t_Hint);

  RecalcAbilitys();
  SendMsg(Self,RM_ABILITY,0,0,0,0,'');
end;

function TBaseObject.AttPowerUp(nPower, nTime: Integer): Boolean;
var
  nMin,nSec:Integer;
begin
  Result:=False;

  m_wStatusArrValue[0]:=nPower;
  m_dwStatusArrTimeOutTick[0]:=GetTickCount + nTime * 1000;

  nMin := nTime div 60;
  nSec := nTime mod 60;

  SysMsg(format(g_sAttPowerUpTime,[nMin, nSec]),c_Green,t_Hint);
  RecalcAbilitys();
  SendMsg(Self,RM_ABILITY,0,0,0,0,'');
  Result:=True;
end;

function TBaseObject.AttPowerDown(nPower, nTime: Integer): Boolean;
var
  nMin,nSec:Integer;
begin
  Result:=False;

  m_wStatusArrValue[6]:=nPower;
  m_dwStatusArrTimeOutTick[6]:=GetTickCount + nTime * 1000;

  nMin := nTime div 60;
  nSec := nTime mod 60;

  SysMsg(format(g_sAttPowerDownTime,[nMin, nSec]),c_Green,t_Hint);
  RecalcAbilitys();
  SendMsg(Self,RM_ABILITY,0,0,0,0,'');
  Result:=True;
end;

function TBaseObject.SCPowerUp(nSec:Integer):Boolean;
begin
  Result:=False;
  {if m_wStatusTimeArr[POISON_6C] <> 0 then exit;
  m_wStatusTimeArr[POISON_6C]:=nSec;
  m_dwStatusArrTick[POISON_6C]:=GetTickCount();

  //SysMsg(format(g_sScPowerDefenceUpTime,[nSec]),c_Green,t_Hint);
  SysMsg('抗魔法力增加 ' + IntToStr(nSec) + ' sec',c_Green,t_Hint);
  RecalcAbilitys();
  SendMsg(Self,RM_ABILITY,0,0,0,0,'');
  Result:=True;}
end;

function TBaseObject.MagDefenceUp(nSec: Integer): Boolean; //004C6D38
begin
  Result:=False;
  if m_wStatusTimeArr[STATE_MAGDEFENCEUP{0x74}] > 0 then begin //004C6D6C
    if m_wStatusTimeArr[STATE_MAGDEFENCEUP{0x74}] < nSec then begin
      m_wStatusTimeArr[STATE_MAGDEFENCEUP{0x74}]:=nSec;
      Result:=True;
    end;
  end else begin
    m_wStatusTimeArr[STATE_MAGDEFENCEUP{0x74}]:=nSec;
    Result:=True;
  end;
  m_dwStatusArrTick[STATE_MAGDEFENCEUP{0x210}]:=GetTickCount;
  SysMsg(format(g_sMagDefenceUpTime,[nSec]),c_Green,t_Hint);
  RecalcAbilitys();
  SendMsg(Self,RM_ABILITY,0,0,0,0,'');
end;
//魔法盾
function TBaseObject.MagBubbleDefenceUp(nLevel, nSec: Integer): Boolean; //004C6E4C
var
  nOldStatus:Integer;
begin
  Result:=False;
  if m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP{0x76}] <> 0 then exit;   //004C6E79
  nOldStatus:=m_nCharStatus;
  m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP{0x76}]:=nSec;
  m_dwStatusArrTick[STATE_BUBBLEDEFENCEUP{0x214}]:=GetTickCount();
  m_nCharStatus:=GetCharStatus();
  if nOldStatus <> m_nCharStatus then begin
    StatusChanged();
  end;
  m_boAbilMagBubbleDefence:=True;
  m_btMagBubbleDefenceLevel:=nLevel;
  Result:=True;
end;

function TBaseObject.CelestialDefenceUp(nLevel, nSec: Integer): Boolean; //004C6E4C
var
  nOldStatus:Integer;
  nDamage  :Integer;
begin
  Result:=False;
  if m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP] <> 0 then exit;   //004C6E79
  nOldStatus:=m_nCharStatus;
  m_wStatusTimeArr[STATE_BUBBLEDEFENCEUP]:=nSec;
  m_dwStatusArrTick[STATE_BUBBLEDEFENCEUP]:=GetTickCount();
  m_nCharStatus:=GetCharStatus();
  if nOldStatus <> m_nCharStatus then begin
    StatusChanged();
    end;
//  m_boAbilMagBubbleDefence:=True;
  m_boAbilCelestialDefence:=True;
  m_btMagBubbleDefenceLevel:=nLevel;
  Result:=True;
end;


function TPlayObject.RandomOreDura: integer;
begin
  if (m_btRaceServer = RC_PLAYOBJECT) then begin
    if m_UseItems[U_WEAPON].Dura = 0 then begin
      Result := Random(5000) + 1000;
    end else begin
      Result := Random(13000) + 3000;
      if Random(20) = 0 then begin
        Result := Result + Random(10000);
      end;
    end;
  end else begin
    Result := Random(11000) + 3000;
    if Random(20) = 0 then begin
      Result := Result + Random(10000);
    end;
  end;
end;

procedure TPlayObject.MakeMine; //004CB3AC
var
  UserItem: pTUserItem;
begin
  if m_ItemList.Count >= MAXBAGITEM then exit;

  case Random(120) of    //
    1..2: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGoldStone,UserItem) then begin
        UserItem.Dura:=RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else Dispose(UserItem);
    end;
    3..20: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sSilverStone,UserItem) then begin
        UserItem.Dura:=RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else Dispose(UserItem);
    end;
    21..45: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sSteelStone,UserItem) then begin
        UserItem.Dura:=RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else Dispose(UserItem);
    end;
    46..56: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sBlackStone,UserItem) then begin
        UserItem.Dura:=RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else Dispose(UserItem);
    end;
    else begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sCopperStone,UserItem) then begin
        UserItem.Dura:=RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else Dispose(UserItem);
    end;
  end;
end;

procedure TPlayObject.MakeMine2;
var
  UserItem: pTUserItem;
begin
  if m_ItemList.Count >= MAXBAGITEM then exit;

  case Random(120) of
    1..2: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGemStone1, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    3..20: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGemStone2, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    21..45: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGemStone3, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    else begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGemStone4, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
  end;
end;

procedure TPlayObject.MakeMine3;
var
  UserItem: pTUserItem;
begin
  if m_ItemList.Count >= MAXBAGITEM then exit;

  case Random(240) of
    1..6: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGoldStone, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    7..30: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sSilverStone, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    31..66: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sSteelStone, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    67..91: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sBlackStone, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    92..131: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sCopperStone, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    132..137: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGemStone1, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    138..161: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGemStone2, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    162..197: begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGemStone3, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
    else begin
      New(UserItem);
      if UserEngine.CopyToUserItemFromName(g_Config.sGemStone4, UserItem) then begin
        UserItem.Dura := RandomOreDura;
        m_ItemList.Add(UserItem);
        WeightChanged();
        SendAddItem(UserItem);
      end else
        Dispose(UserItem);
    end;
  end;
end;

function TPlayObject.QuestCheckItem(sItemName: String; var nCount,
  nParam: Integer; var nDura: Integer): pTUserItem; //004C4B78
var
  I: Integer;
  UserItem:pTUserItem;
  s1C:String;
begin
  Result:=nil;
  nParam:=0;
  nDura:=0;
  nCount:=0;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[i];
    s1C:=UserEngine.GetStdItemName(UserItem.wIndex);
    if CompareText(s1C,sItemName) = 0 then begin
      if UserItem.Dura > nDura then begin
        nDura:=UserItem.Dura;
        Result:=UserItem;
      end;
      Inc(nParam,UserItem.Dura);
      if Result = nil then
        Result:=UserItem;
      Inc(nCount);
    end; //004C4C97
  end;
end;

function TBaseObject.sub_4C4CD4(sItemName: String;
  var nCount: Integer): pTUserItem; //004C4CD4
var
  I: Integer;
  sName:String;
begin
  Result:=nil;
  nCount:=0;
  for I := Low(THumanUseItems) to High(THumanUseItems) do begin
    sName:=UserEngine.GetStdItemName(m_UseItems[i].wIndex);
    if CompareText(sName,sItemName) = 0 then begin
      Result:=@m_UseItems[i];
      Inc(nCount);
    end;
  end;
end;

function TPlayObject.QuestTakeCheckItem(CheckItem: pTUserItem):Boolean; //004C4F6C
var
  I: Integer;
  UserItem: pTUserItem;
begin
  Result:=False;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[I];
    if UserItem = CheckItem then begin
      SendDelItems(UserItem);
      Dispose(UserItem);
      m_ItemList.Delete(I);
      Result:=True;
      break;
    end;
  end;
  for I := Low(m_UseItems) to High(m_UseItems) do begin
    if @m_UseItems[I] = CheckItem then begin
      SendDelItems(@m_UseItems[I]);
      m_UseItems[I].wIndex:=0;
      Result:=True;
      break;
    end;
  end;
end;

procedure TPlayObject.ClientQueryRepairCost(nParam1, nInt: Integer;
  sMsg: String); //004DBCCC
var
  I: Integer;
  UserItem:pTUserItem;
  UserItemA:pTUserItem;
  Merchant:TMerchant;
  sUserItemName:String;
begin
  UserItemA:=nil;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[I];
    if (UserItem.MakeIndex = nInt) then begin
      //取自定义物品名称
      sUserItemName:=GetItemName(UserItem);

      if (CompareText(sUserItemName,sMsg) = 0) then begin
        UserItemA:=UserItem;
        break;
      end;
    end;
  end; 
  if UserItemA = nil then exit;
  Merchant:=UserEngine.FindMerchant(TObject(nParam1));
  if (Merchant <> nil) and
     ((Merchant.m_PEnvir = m_PEnvir) and
     (abs(Merchant.m_nCurrX - m_nCurrX) < 15) and
     (abs(Merchant.m_nCurrY - m_nCurrY) < 15)) then 
    Merchant.ClientQueryRepairCost(Self,UserItemA);

end;

procedure TPlayObject.ClientRepairItem(nParam1, nInt: Integer;
  sMsg: String); //004DBFC0
var
  I: Integer;
  UserItem:pTUserItem;
  Merchant:TMerchant;
  sUserItemName:String;
begin
  UserItem:=nil;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[I];
    //取自定义物品名称
    sUserItemName:=GetItemName(UserItem);

    if (UserItem.MakeIndex = nInt) and
       (CompareText(sUserItemName,sMsg) = 0) then begin
      break;
    end;
  end;    // for
  if UserItem = nil then exit;
  Merchant:=UserEngine.FindMerchant(TObject(nParam1));
  if (Merchant <> nil) and
     ((Merchant.m_PEnvir = m_PEnvir) and
     (abs(Merchant.m_nCurrX - m_nCurrX) < 15) and
     (abs(Merchant.m_nCurrY - m_nCurrY) < 15)) then
    Merchant.ClientRepairItem(Self,UserItem);
end;

procedure TPlayObject.ClientTradeGT(nParam1:integer);
var
  Value:integer;
begin
  if Not m_boDealing then exit;
  if m_DealCreat = nil then exit;
  if Not m_DealCreat.m_boDealGT then exit;
  if (nParam1 <> 1) or (m_MyGuild = nil) or (IsGuildMaster = False) or (g_GuildTerritory.FindGuildTerritoryEx(TGuild(m_MyGuild).sGuildName) <> nil) then begin
    m_DealCreat.SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'The other party rejected the deal');
    m_boDealing:=False;
    m_DealCreat.m_boDealing := False;
    m_DealCreat.m_boDealGT := False;
    m_DealCreat.m_DealCreat := nil;
    m_DealCreat := nil;
    exit;
  end;

  if (m_DealCreat.m_MyGuild = nil) or (TGuild(m_DealCreat.m_MyGuild).m_Territory = nil) or (TTerritory(TGuild(m_DealCreat.m_MyGuild).m_Territory).ForSale = False) then begin
    SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'The guild territory is no longer up for sale');
    m_boDealing:=False;
    m_DealCreat.m_boDealing := False;
    m_DealCreat.m_boDealGT := False;
    m_DealCreat.m_DealCreat := nil;
    m_DealCreat := nil;
    exit;
  end;
  Value:= TTerritory(TGuild(m_DealCreat.m_MyGuild).m_Territory).ForSaleGold;
  if (m_nGold >= Value) and ((m_DealCreat.m_nGoldMax - Value) >= m_DealCreat.m_nGold)  then begin
    if TTerritory(TGuild(m_DealCreat.m_MyGuild).m_Territory).Buy(TGuild(m_MyGuild).sGuildName) then begin
        DecGold(Value);
        GoldChanged();
        inc(m_DealCreat.m_nGold,Value);
        m_DealCreat.GoldChanged();
        SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'Congratualations you now have a guild territory');
        m_DealCreat.SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'Your guild territory is now sold');
        exit;
    end;
  end;

  m_DealCreat.SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'The deal has been canceled');
  SendMsg(g_ManageNPC,RM_MENU_OK,0,Integer(Self),0,0,'The deal has been canceled');
  m_boDealing:=False;
  m_DealCreat.m_boDealing := False;
  m_DealCreat.m_boDealGT := False;
  m_DealCreat.m_DealCreat := nil;
  m_DealCreat := nil;
end;

procedure TPlayObject.ConsignItem(NPC: TObject; nItemIdx: Integer; sMsg: String);
var
  Merchant:TMerchant;
  I:Integer;
  nerror:integer;
  UserItem:pTUserItem;
begin
  nerror:=0;
  UserItem:=nil;

  if Pos(' ',sMsg) >= 0 then
    GetValidStr3(sMsg,sMsg,[' ']);

  try
    if strtoint(sMsg) < 1000 then begin
      nerror:=1;
      SendDefMessage(SM_CONSIGN_FAIL,nerror,0,0,0,'');
      exit;
    end;
    if strtoint(sMsg) > 50000000 then begin
      nerror:=2;
      SendDefMessage(SM_CONSIGN_FAIL,nerror,0,0,0,'');
      exit;
    end;
  except
    nerror:=1;
    SendDefMessage(SM_CONSIGN_FAIL,nerror,0,0,0,'');
    exit;
  end;

  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[I];

    if (UserItem.MakeIndex = nItemIdx) then begin
      Merchant:=UserEngine.FindMerchant(NPC);
      if (Merchant <> nil) and
         (Merchant.m_boConsignment) and
         (((Merchant.m_PEnvir = m_PEnvir) and
         (abs(Merchant.m_nCurrX - m_nCurrX) < 15) and
         (abs(Merchant.m_nCurrY - m_nCurrY) < 15)) or (Merchant = g_FunctionNPC)) then begin
          if DecGold(1000) then begin
            GoldChanged();
            FrmDB.ConsignItem(UserItem,sMsg,m_sCharName);
            m_ItemList.Delete(I);
            WeightChanged();
            SendDefMessage(SM_CONSIGN_OK,0,0,0,0,'');
            exit;
          end;
          nerror:=5;
      end;
      if nerror = 3 then nerror:=4;
    end;
  end;
  if nerror = 0 then nerror:=4;
  SendDefMessage(SM_CONSIGN_FAIL,nerror,0,0,0,'');
end;

procedure TPlayObject.ClientStorageItem(NPC: TObject;
  nItemIdx: Integer; sMsg: String; nAmount:Integer); //004DC2B8
var
  Merchant:TMerchant;
  I:Integer;
  UserItem:pTUserItem;
  bo19:Boolean;
  StdItem:TItem;
  sUserItemName:String;
  UserItem2:pTUserItem;
begin
  bo19:=False;
  UserItem:=nil;

  if Pos(' ',sMsg) >= 0 then
    GetValidStr3(sMsg,sMsg,[' ']);

  if (m_nPayMent = 1) and not g_Config.boTryModeUseStorage then begin
    SysMsg(g_sTryModeCanotUseStorage,c_Red,t_Hint);
    exit;
  end;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[I];
    sUserItemName:=GetItemName(UserItem);

    if (UserItem.MakeIndex = nItemIdx) and (CompareText(sUserItemName,sMsg) = 0) then begin
      Merchant:=UserEngine.FindMerchant(NPC);
      if (Merchant <> nil) and
         (Merchant.m_boStorage) and
         (((Merchant.m_PEnvir = m_PEnvir) and
         (abs(Merchant.m_nCurrX - m_nCurrX) < 15) and
         (abs(Merchant.m_nCurrY - m_nCurrY) < 15)) or (Merchant = g_FunctionNPC)) then begin
        if m_StorageItemList.Count < STORAGELIMIT then begin
          StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
          if not StdItem.boCanStore then begin
          SendDefMessage(SM_STORAGE_FAIL,0,0,0,0,'');
          exit;
          end;
          if (StdItem.StdMode = 45) and (UserItem.Amount > nAmount) then begin
            UserItem2:=copyuseritem(UserItem);
            dec(UserItem.Amount,nAmount);
            WeightChanged();
            UserItem2.Amount:=nAmount;
            m_StorageItemList.Add(UserItem2);
          end else begin
            m_StorageItemList.Add(UserItem);
            m_ItemList.Delete(I);
          end;
          WeightChanged();
          SendAddStorage(UserItem);
          SendDefMessage(SM_STORAGE_OK,0,0,0,0,'');
          //004DC55E
          if StdItem.NeedIdentify = 1 then
            AddGameDataLog('1' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                     StdItem.Name + #9 +
                     IntToStr(UserItem.MakeIndex) + #9 +
                     '1' + #9 +
                     '0');
        end else begin
          SendDefMessage(SM_STORAGE_FULL,0,0,0,0,'');
        end;
        bo19:=True;
      end;
      break;
    end;
  end;
  if not bo19 then SendDefMessage(SM_STORAGE_FAIL,0,0,0,0,'');
end;

procedure TPlayObject.ClientTakeBackStorageItem(NPC: TObject;
  nItemIdx: Integer; sMsg: String); //004DC664
var
  Merchant:TMerchant;
  I:Integer;
  UserItem:pTUserItem;
  bo19:Boolean;
  StdItem:TItem;
  sUserItemName:String;
  boSucces:Boolean;
  UserItem2:pTUserItem;
  II:Integer;
begin
  bo19:=False;
  UserItem:=nil;
  Merchant:=UserEngine.FindMerchant(NPC);
  if Merchant = nil then exit;    
  if (m_nPayMent = 1) and not g_Config.boTryModeUseStorage then begin
    SysMsg(g_sTryModeCanotUseStorage,c_Red,t_Hint);
    exit;
  end;
  if not m_boCanGetBackItem then begin
    SendMsg(Merchant,RM_MENU_OK,0,Integer(Self),0,0,g_sStorageIsLockedMsg + '\ \'
                      + 'Unlock storage command: @' + g_GameCommand.UNLOCKSTORAGE.sCmd + '\'
                      + 'Lock storage command: @' + g_GameCommand.LOCK.sCmd + '\'
                      + 'Setpassword command: @' + g_GameCommand.SETPASSWORD.sCmd + '\'
                      + 'change password command: @' + g_GameCommand.CHGPASSWORD.sCmd);
    exit;
  end;

  for I := 0 to m_StorageItemList.Count - 1 do begin
    UserItem:=m_StorageItemList.Items[I];

    sUserItemName:=GetItemName(UserItem);

    if (UserItem.MakeIndex = nItemIdx) and
       (CompareText(sUserItemName,sMsg) = 0) then begin

      if (IsAddWeightAvailable(UserEngine.GetStdItemWeight(UserItem.wIndex))) then begin
        if (Merchant <> nil) and
           (Merchant.m_boGetback) and
           (((Merchant.m_PEnvir = m_PEnvir) and
           (abs(Merchant.m_nCurrX - m_nCurrX) < 15) and
           (abs(Merchant.m_nCurrY - m_nCurrY) < 15)) or (Merchant = g_FunctionNPC)) then begin

          boSucces:=FALSE;
          UserItem2:=nil;
          if (UserEngine.GetStdItem(UserItem.wIndex).StdMode = 45) and (CheckItems(sUserItemName) <> nil) then begin
              UserItem2:=CheckItems(sUserItemName);
              inc(UserItem2.Amount,UserItem.Amount);
              WeightChanged();
              UserItem.MakeIndex:=UserItem2.MakeIndex;
              boSucces:=TRUE;
          end else
              if AddItemToBag(UserItem) then
                boSucces:=TRUE;
//          if AddItemToBag(UserItem) then begin

          if boSucces then begin
            if UserItem2 = nil then
              SendAddItem(UserItem)
            else
              for II:=0 to UserItem.Amount-1 do //ugly i know but by far simpler then the alternative
                SendAddItem(UserItem);

            m_StorageItemList.Delete(I);
            SendDefMessage(SM_TAKEBACKSTORAGEITEM_OK,nItemIdx,0,0,0,'');
            StdItem:=UserEngine.GetStdItem(UserItem.wIndex);
            if StdItem.NeedIdentify = 1 then
              AddGameDataLog('0' +  #9 +
                     m_sMapName + #9 +
                     IntToStr(m_nCurrX) + #9 +
                     IntToStr(m_nCurrY) + #9 +
                     m_sCharName + #9 +
                     //UserEngine.GetStdItemName(UserItem.wIndex) + #9 +
                     StdItem.Name + #9 +
                     IntToStr(UserItem.MakeIndex) + #9 +
                     '1' + #9 +
                     '0');
          end else begin
            SendDefMessage(SM_TAKEBACKSTORAGEITEM_FULLBAG,0,0,0,0,'');
          end;

          bo19:=True;
        end;
      end else begin
        SysMsg(g_sCanotGetItems,c_Red,t_Hint);
      end;
      break;
    end;
  end;
  if not bo19 then SendDefMessage(SM_TAKEBACKSTORAGEITEM_FAIL,0,0,0,0,'');
end;

function TBaseObject.CheckItems(sItemName: String): pTUserItem; //004C4AB0
var
  I: Integer;
  UserItem:pTUserItem;
begin
  Result:=nil;
  for I := 0 to m_Itemlist.Count - 1 do begin
    UserItem:=m_ItemList.Items[I];
    if CompareText(UserEngine.GetStdItemName(UserItem.wIndex),sItemName) = 0 then begin
      Result:=UserItem;
      break;
    end;
  end;    // for
end;

function TBaseObject.IncreaseItem(sName: String): Boolean;
var
  I: Integer;
  UserItem:pTUserItem;
begin
  Result:=FALSE;
  if UserEngine.GetStdItem(sName).StdMode <> 45 then exit;
  for I := 0 to m_Itemlist.Count - 1 do begin
    UserItem:=m_ItemList.Items[I];
    if CompareText(UserEngine.GetStdItemName(UserItem.wIndex),sName) = 0 then begin

      inc(pTUserItem(m_ItemList.Items[i]).Amount);
      WeightChanged();WeightChanged();
      Result:=TRUE;
      break;
    end;
  end;    // for
end;

procedure TPlayObject.MakeSaveRcd(var HumanRcd: THumData);//004B3580
var
  I: Integer;
  HumItems:pTHumItems;
  BagItems:pTBagItems;
  HumMagic:pTHumMagic;
  UserMagic:pTUserMagic;
  StorageItems:pTStorageItems;
begin
  HumanRcd.sChrName:=m_sCharName;
  HumanRcd.sCurMap:=m_sMapName;
  HumanRcd.wCurX:=m_nCurrX;
  HumanRcd.wCurY:=m_nCurrY;
  HumanRcd.btDir:=m_btDirection;
  HumanRcd.btHair:=m_btHair;
  HumanRcd.btSex:=m_btGender;
  HumanRcd.btJob:=m_btJob;
  HumanRcd.nGold:=m_nGold;

  HumanRcd.Abil.Level:=m_Abil.Level;
  HumanRcd.Abil.HP:=m_Abil.HP;
  HumanRcd.Abil.MP:=m_Abil.MP;
  HumanRcd.Abil.MaxHP:=m_Abil.MaxHP;
  HumanRcd.Abil.MaxMP:=m_Abil.MaxMP;
  HumanRcd.Abil.Exp:=m_Abil.Exp;
  HumanRcd.Abil.MaxExp:=m_Abil.MaxExp;
  HumanRcd.Abil.Weight:=m_Abil.Weight;
  HumanRcd.Abil.MaxWeight:=m_Abil.MaxWeight;
  HumanRcd.Abil.WearWeight:=m_Abil.WearWeight;
  HumanRcd.Abil.MaxWearWeight:=m_Abil.MaxWearWeight;
  HumanRcd.Abil.HandWeight:=m_Abil.HandWeight;
  HumanRcd.Abil.MaxHandWeight:=m_Abil.MaxHandWeight;


  //HumanRcd.Abil:=m_Abil;
  HumanRcd.Abil.HP:=m_WAbil.HP;
  HumanRcd.Abil.MP:=m_WAbil.MP;

  HumanRcd.wStatusTimeArr:=m_wStatusTimeArr;
  HumanRcd.sHomeMap:=m_sHomeMap;
  HumanRcd.wHomeX:=m_nHomeX;
  HumanRcd.wHomeY:=m_nHomeY;
  HumanRcd.nPKPoint:=m_nPkPoint;
  HumanRcd.BonusAbil:=m_BonusAbil;// 08/09
  HumanRcd.nBonusPoint:=m_nBonusPoint;// 08/09
  HumanRcd.sStoragePwd:=m_sStoragePwd;
  HumanRcd.btCreditPoint:=m_btCreditPoint;
  HumanRcd.btReLevel:=m_btReLevel;

  HumanRcd.sMasterName:=m_sMasterName;
  HumanRcd.boMaster:=m_boMaster;
  HumanRcd.sDearName:=m_sDearName;

  HumanRcd.xLoveInfo:=m_xLoveInfo;
  
  HumanRcd.nGameGold:=m_nGameGold;
  HumanRcd.nBankGold:=m_nBankGold;
  HumanRcd.nGamePoint:=m_nGamePoint;


  if m_boAllowGroup then HumanRcd.btAllowGroup:=1
  else HumanRcd.btAllowGroup:=0;
  HumanRcd.btF9:=btB2;
  HumanRcd.btAttatckMode:=m_btAttatckMode;
  HumanRcd.btIncHealth:=m_nIncHealth;
  HumanRcd.btIncSpell:=m_nIncSpell;
  HumanRcd.btIncHealing:=m_nIncHealing;
  HumanRcd.btFightZoneDieCount:=m_nFightZoneDieCount;
  HumanRcd.sAccount:=m_sUserID;
  HumanRcd.btEE:=nC4;
  HumanRcd.boLockLogon:=m_boLockLogon;
  HumanRcd.wContribution:=m_wContribution;
  HumanRcd.btEF:=btC8;
  HumanRcd.nHungerStatus:=m_nHungerStatus;
  HumanRcd.boAllowGuildReCall:=m_boAllowGuildReCall;
  HumanRcd.wGroupRcallTime:=m_wGroupRcallTime;
  HumanRcd.dBodyLuck:=m_dBodyLuck;
  HumanRcd.boAllowGroupReCall:=m_boAllowGroupReCall;
  HumanRcd.QuestUnitOpen:=m_QuestUnitOpen;
  HumanRcd.QuestUnit:=m_QuestUnit;
  HumanRcd.QuestFlag:=m_QuestFlag;

  HumItems:=@HumanRcd.HumItems;
  HumItems[U_DRESS]:=m_UseItems[U_DRESS];
  HumItems[U_WEAPON]:=m_UseItems[U_WEAPON];
  HumItems[U_RIGHTHAND]:=m_UseItems[U_RIGHTHAND];
  HumItems[U_HELMET]:=m_UseItems[U_NECKLACE];
  HumItems[U_NECKLACE]:=m_UseItems[U_HELMET];
  HumItems[U_ARMRINGL]:=m_UseItems[U_ARMRINGL];
  HumItems[U_ARMRINGR]:=m_UseItems[U_ARMRINGR];
  HumItems[U_RINGL]:=m_UseItems[U_RINGL];
  HumItems[U_RINGR]:=m_UseItems[U_RINGR];
  HumItems[U_BUJUK]:=m_UseItems[U_BUJUK];
  HumItems[U_BELT]:=m_UseItems[U_BELT];
  HumItems[U_BOOTS]:=m_UseItems[U_BOOTS];
  HumItems[U_CHARM]:=m_UseItems[U_CHARM];

  BagItems:=@HumanRcd.BagItems;
  for I := 0 to m_ItemList.Count - 1 do begin
    if I >= MAXBAGITEM then break;
    BagItems[I]:=pTUserItem(m_ItemList.Items[I])^;
  end;
  HumMagic:=@HumanRcd.Magic;
  for I := 0 to m_MagicList.Count - 1 do begin
    if I >= MAXMAGIC then break;
    UserMagic:=m_MagicList.Items[I];
    HumMagic[I].wMagIdx:=UserMagic.wMagIdx;
    HumMagic[I].btLevel:=UserMagic.btLevel;
    HumMagic[I].btKey:=UserMagic.btKey;
    HumMagic[I].nTranPoint:=UserMagic.nTranPoint;
  end;
  StorageItems:=@HumanRcd.StorageItems;
  for I := 0 to m_StorageItemList.Count -1 do begin
    if I >= STORAGELIMIT then break;
    StorageItems[I]:=pTUserItem(m_StorageItemList.Items[I])^;
  end;
end;



function TBaseObject.sub_4C3538: Integer;//004C3538
var
  nC,n10:Integer;
begin
  Result:=0;
  nC:= -1;
  while (nC <> 2) do  begin
    n10:= -1;
    while (n10 <> 2) do  begin
      if not m_PEnvir.CanWalk(m_nCurrX + nC,m_nCurrY + n10,False) then begin
        if (nC <> 0) or (n10 <> 0) then
          Inc(Result);
      end;
      Inc(n10);
    end;
    Inc(nC);
  end;
end;

procedure TPlayObject.RefRankInfo(nRankNo:Integer;sRankName:string);//004CAE3C
begin
  m_nGuildRankNo:=nRankNo;
  m_sGuildRankName:=sRankName;
  SendMsg(Self,RM_CHANGEGUILDNAME,0,0,0,0,'');
end;

function TBaseObject.DelBagItem(nIndex: Integer): Boolean; //004C4F10
begin
  Result:=False;
  if (nIndex < 0) or (nIndex >= m_ItemList.Count) then exit;
  Dispose(pTUserItem(m_ItemList.Items[nIndex]));
  m_ItemList.Delete(nIndex);
  Result:=True;
end;

function TBaseObject.DelBagItem(nItemIndex: Integer;//004C4DFC
  sItemName: String): Boolean;
var
  I: Integer;
  UserItem:pTUserItem;
begin
  Result:=False;
  for I := 0 to m_ItemList.Count - 1 do begin
    UserItem:=m_ItemList.Items[I];
    if (UserItem.MakeIndex = nItemIndex) and
       (CompareText(UserEngine.GetStdItemName(UserItem.wIndex),sItemName) = 0) then begin
      Dispose(UserItem);
      m_ItemList.Delete(I);
      Result:=True;
      break;
    end;
  end;
  if Result then WeightChanged();
    
end;

procedure TBaseObject.ReloadMonItem();
begin
  //m_ItemList:=nil;
  //FrmDB.LoadMonitems(m_sCharName,m_ItemList);
  UserEngine.MonGetRandomItems(self);
end;



function TPlayObject.GetHitMsgCount: Integer;
var
  I: Integer;
  SendMessage:pTSendMessage;
begin
  Result:=0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for I := 0 to m_MsgList.Count - 1 do begin
      SendMessage:=m_Msglist.Items[i];
      if (SendMessage.wIdent = CM_HIT) or
         (SendMessage.wIdent = CM_HEAVYHIT) or
         (SendMessage.wIdent = CM_BIGHIT) or
         (SendMessage.wIdent = CM_POWERHIT) or
         (SendMessage.wIdent = CM_LONGHIT) or
         (SendMessage.wIdent = CM_WIDEHIT) or
         (SendMessage.wIdent = CM_FIREHIT) then begin
        Inc(Result);
      end;        
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetSpellMsgCount: Integer;
var
  I: Integer;
  SendMessage:pTSendMessage;
begin
  Result:=0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for I := 0 to m_MsgList.Count - 1 do begin
      SendMessage:=m_Msglist.Items[i];
      if (SendMessage.wIdent = CM_SPELL) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetRunMsgCount: Integer;
var
  I: Integer;
  SendMessage:pTSendMessage;
begin
  Result:=0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for I := 0 to m_MsgList.Count - 1 do begin
      SendMessage:=m_Msglist.Items[i];
      if (SendMessage.wIdent = CM_RUN) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetWalkMsgCount: Integer;
var
  I: Integer;
  SendMessage:pTSendMessage;
begin
  Result:=0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for I := 0 to m_MsgList.Count - 1 do begin
      SendMessage:=m_Msglist.Items[i];
      if (SendMessage.wIdent = CM_WALK) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetTurnMsgCount: Integer;
var
  I: Integer;
  SendMessage:pTSendMessage;
begin
  Result:=0;
  try
    EnterCriticalSection(ProcessMsgCriticalSection);
    for I := 0 to m_MsgList.Count - 1 do begin
      SendMessage:=m_Msglist.Items[i];
      if (SendMessage.wIdent = CM_TURN) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;

function TPlayObject.GetSiteDownMsgCount: Integer;
var
  I: Integer;
  SendMessage:pTSendMessage;
begin
  Result:=0;
  EnterCriticalSection(ProcessMsgCriticalSection);
  try
    for I := 0 to m_MsgList.Count - 1 do begin
      SendMessage:=m_Msglist.Items[i];
      if (SendMessage.wIdent = CM_SITDOWN) then begin
        Inc(Result);
      end;
    end;
  finally
    LeaveCriticalSection(ProcessMsgCriticalSection);
  end;
end;



function TPlayObject.CheckActionStatus(wIdent:Word;var dwDelayTime:LongWord): Boolean;
var
  dwCheckTime:LongWord;
  dwActionIntervalTime:LongWord;
begin
  Result:=False;
  dwDelayTime:=0;
  //检查人物弯腰停留时间
  if not g_Config.boDisableStruck then begin
    dwCheckTime:=GetTickCount - m_dwStruckTick;
    if g_Config.dwStruckTime > dwCheckTime then begin
      dwDelayTime:=g_Config.dwStruckTime - dwCheckTime;
      m_btOldDir:=m_btDirection;
      exit;
    end;
  end;


  dwCheckTime:=GetTickCount - m_dwActionTick;

  if m_boTestSpeedMode then begin
    SysMsg('Test Speed Mode: ' + IntToStr(dwCheckTime),c_Blue,t_Notice);
  end;

  if m_wOldIdent = wIdent then begin

    Result:=True;
    exit;
  end;
  if not g_Config.boControlActionInterval then begin
    Result:=True;
    exit;
  end;

  dwActionIntervalTime:=m_dwActionIntervalTime;
  case wIdent of
    CM_LONGHIT: begin
      //跑位刺杀
      if g_Config.boControlRunLongHit and (m_wOldIdent = CM_RUN) and (m_btOldDir <> m_btDirection) then begin
        dwActionIntervalTime:=m_dwRunLongHitIntervalTime;
      end;
    end;
    CM_HIT: begin
      //走位攻击
      if g_Config.boControlWalkHit and (m_wOldIdent = CM_WALK) and (m_btOldDir <> m_btDirection) then begin
        dwActionIntervalTime:=m_dwWalkHitIntervalTime;
      end;
      //跑位攻击
      if g_Config.boControlRunHit and (m_wOldIdent = CM_RUN) and (m_btOldDir <> m_btDirection) then begin
        dwActionIntervalTime:=m_dwRunHitIntervalTime;
      end;
    end;
    CM_RUN: begin
      //跑位刺杀
      if g_Config.boControlRunLongHit and (m_wOldIdent = CM_LONGHIT) and (m_btOldDir <> m_btDirection) then begin
        dwActionIntervalTime:=m_dwRunLongHitIntervalTime;
      end;
      //跑位攻击
      if g_Config.boControlRunHit and (m_wOldIdent = CM_HIT) and (m_btOldDir <> m_btDirection) then begin
        dwActionIntervalTime:=m_dwRunHitIntervalTime;
      end;
      //跑位魔法
      if g_Config.boControlRunMagic and (m_wOldIdent = CM_SPELL) and (m_btOldDir <> m_btDirection) then begin
        dwActionIntervalTime:=m_dwRunMagicIntervalTime;
      end;
    end;
    CM_WALK: begin
      //走位攻击
      if g_Config.boControlWalkHit and (m_wOldIdent = CM_HIT) and (m_btOldDir <> m_btDirection) then begin
        dwActionIntervalTime:=m_dwWalkHitIntervalTime;
      end;
      //跑位刺杀
      if g_Config.boControlRunLongHit and (m_wOldIdent = CM_LONGHIT) and (m_btOldDir <> m_btDirection) then begin
        dwActionIntervalTime:=m_dwRunLongHitIntervalTime;
      end;      
    end;
    CM_SPELL: begin
      //跑位魔法
      if g_Config.boControlRunMagic and (m_wOldIdent = CM_RUN) and (m_btOldDir <> m_btDirection) then begin
        dwActionIntervalTime:=m_dwRunMagicIntervalTime;
      end;
    end;
  end;

  //将几个攻击操作合并成一个攻击操作代码
  if (wIdent = CM_HIT) or
     (wIdent = CM_HEAVYHIT) or
     (wIdent = CM_BIGHIT) or
     (wIdent = CM_POWERHIT) or
//     (wIdent = CM_LONGHIT) or
     (wIdent = CM_WIDEHIT) or
     (wIdent = CM_FIREHIT) then begin

    wIdent:=CM_HIT;
  end;



  if dwCheckTime >= dwActionIntervalTime then begin
    m_dwActionTick:=GetTickCount();
    Result:=True;
  end else begin
    dwDelayTime:=dwActionIntervalTime - dwCheckTime;
  end;
  m_wOldIdent:=wIdent;
  m_btOldDir := m_btDirection;
  {
  dwCheckTime:=GetTickCount - m_dwActionTick;
  if dwCheckTime >= m_dwActionTime then begin
    m_dwActionTick:=GetTickCount();
    m_wOldIdent:=wIdent;
    Result:=True;
  end else begin
    dwDelayTime:=m_dwActionTime - dwCheckTime;
//    m_dwActionTime:=m_dwActionTime + 20;
  end;
  }
end;
procedure TPlayObject.SetScriptLabel(sLabel: String);
begin
  m_CanJmpScriptLableList.Clear;
  m_CanJmpScriptLableList.Add(sLabel);
end;
//取得当前脚本可以跳转的标签
procedure TPlayObject.GetScriptLabel(sMsg: String);
var
  sText:String;
  sData:String;
  sCmdStr,sLabel:String;
begin
  m_CanJmpScriptLableList.Clear;
  while (True) do begin
    if sMsg = '' then break;
    sMsg:=GetValidStr3(sMsg,sText,['\']);
    if sText <> '' then begin
      sData:='';
      while (Pos('<',sText) > 0) and (Pos('>',sText) > 0) and (sText <> '') do begin
        if sText[1] <> '<' then begin
          sText:='<' + GetValidStr3(sText,sData,['<']);
        end;
        sText:=ArrestStringEx(sText,'<','>',sCmdStr);
        sLabel:=GetValidStr3(sCmdStr,sCmdStr,['/']);
        if sLabel <> '' then
          m_CanJmpScriptLableList.Add(sLabel);
      end;
    end;
  end;
end;

function TPlayObject.LableIsCanJmp(sLabel: String): Boolean;
var
  I: Integer;
begin
  Result:=False;
  if CompareText(sLabel,'@main') = 0 then begin
    Result:=True;
    exit;
  end;
  for I := 0 to m_CanJmpScriptLableList.Count - 1 do begin
    if CompareText(sLabel,m_CanJmpScriptLableList.Strings[I]) = 0 then begin
      Result:=True;
      break;
    end;
  end;
  if CompareText(sLabel,m_sPlayDiceLabel) = 0 then begin
    m_sPlayDiceLabel:='';
    Result:=True;
    exit;
  end;
end;

procedure TPlayObject.RecalcAbilitys;
begin
  inherited;
  RecalcAdjusBonus();
end;

procedure TPlayObject.UpdateVisibleGay(BaseObject: TBaseObject);
var
  I                 :Integer;
  boIsVisible       :Boolean;
  VisibleBaseObject :pTVisibleBaseObject;
begin
  boIsVisible:=False;
  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) or (BaseObject.m_Master <> nil) then
    m_boIsVisibleActive:=True;//如果是人物或宝宝则置TRUE

    
  for I := 0 to m_VisibleActors.Count - 1 do begin
    VisibleBaseObject:=m_VisibleActors.Items[i];
    if VisibleBaseObject.BaseObject = BaseObject then begin
      VisibleBaseObject.nVisibleFlag:=1;
      boIsVisible:=True;
      break;
    end;
  end;
  if boIsVisible then exit;
  New(VisibleBaseObject);
  VisibleBaseObject.nVisibleFlag := 2;
  VisibleBaseObject.BaseObject   := BaseObject;
  m_VisibleActors.Add(VisibleBaseObject);
  if (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
    SendWhisperMsg(TPlayObject(BaseObject));
  end;
end;

procedure TPlayObject.SearchViewRange;
var
  I           :Integer;
  nStartX     :Integer;
  nEndX       :Integer;
  nStartY     :Integer;
  nEndY       :Integer;
  n18         :Integer;
  n1C         :Integer;
  nIdx        :Integer;
  n24         :Integer;
  MapCellInfo :pTMapCellinfo;
  OSObject    :pTOSObject;
  BaseObject  :TBaseObject;
  MapItem     :pTMapItem;
  MapEvent    :TEvent;
  VisibleBaseObject :pTVisibleBaseObject;
  VisibleMapItem    :pTVisibleMapItem;
  nCheckCode        :Integer;
  nDateDropped:DWord;
ResourceString
  sExceptionMsg1 = '[Exception] TPlayObject::SearchViewRange Code:%d';
  sExceptionMsg2 = '[Exception] TPlayObject::SearchViewRange 1-%d %s %s %d %d %d';

begin
  n24:=0;
  nCheckCode:=0;
  try
    nCheckCode:=2;
    for I := 0 to m_VisibleItems.Count - 1 do begin
      pTVisibleMapItem(m_VisibleItems.Items[I]).nVisibleFlag:=0;
    end;
    nCheckCode:=3;
    for I := 0 to m_VisibleEvents.Count - 1 do begin
      TEvent(m_VisibleEvents.Items[i]).nVisibleFlag:=0;
    end;
    nCheckCode:=4;
    for I := 0 to m_VisibleActors.Count - 1 do begin
      pTVisibleBaseObject(m_VisibleActors.Items[i]).nVisibleFlag:=0;
    end;
    nCheckCode:=5;
  except
    MainOutMessage(format(sExceptionMsg1,[nCheckCode]));
    KickException();
  end;
  nCheckCode:=6;

  nStartX :=m_nCurrX - m_nViewRange;
  nEndX   :=m_nCurrX + m_nViewRange;
  nStartY :=m_nCurrY - m_nViewRange;
  nEndY   :=m_nCurrY + m_nViewRange;
  try
    nCheckCode:=7;
    for n18:= nStartX to nEndX do begin
      nCheckCode:=8;
      for n1C:= nStartY to nEndY  do begin
        nCheckCode:=9;
        if m_PEnvir.GetMapCellInfo(n18,n1C,MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          nCheckCode:=10;
          n24:=1;
          nIdx:=0;
          while (True) do begin
            nCheckCode:=11;
            if MapCellInfo.ObjList.Count <= nIdx then break;    //004B9858
              OSObject:=MapCellInfo.ObjList.Items[nIdx];
              nCheckCode:=12;
              if OSObject <> nil then begin
                nCheckCode:=13;
                if OSObject.btType = OS_MOVINGOBJECT then begin
                  nCheckCode:=14;
                  if (GetTickCount - OSObject.dwAddTime) >= 60 * 1000 then begin
                    Dispose(OSObject);
                    MapCellInfo.ObjList.Delete(nIdx);
                    if MapCellInfo.ObjList.Count > 0 then Continue;
                    MapCellInfo.ObjList.Free;
                    MapCellInfo.ObjList:=nil;
                    break;
                  end; //004B9907
                  nCheckCode:=15;
                  BaseObject:=TBaseObject(OSObject.CellObj);
                  if BaseObject <> nil then begin
                    nCheckCode:=16;
                    if not BaseObject.m_boGhost and not BaseObject.m_boFixedHideMode and not BaseObject.m_boObMode then begin
                      nCheckCode:=17;
                      if (m_btRaceServer < RC_ANIMAL) or
                         (m_Master <> nil) or
                         m_boCrazyMode or
                         m_boNastyMode or
                         m_boHallucMode or //Hallucination 
                         m_boWantRefMsg or
                         ((BaseObject.m_Master <> nil) and (abs(BaseObject.m_nCurrX - m_nCurrX) <= 3) and (abs(BaseObject.m_nCurrY - m_nCurrY) <= 3)) or
                         (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then begin
                            nCheckCode:=18;
                            UpdateVisibleGay(BaseObject);
                            nCheckCode:=19;
                      end;//004B99E2
                    end; //004B99E2
                  end; //004B99E2 if BaseObject <> nil then begin
                end; //004B99E2 if OSObject.btType = OS_MOVINGOBJECT then begin
                nCheckCode:=20;
                if m_btRaceServer = RC_PLAYOBJECT then begin
                  if OSObject.btType = OS_ITEMOBJECT then begin
                    nCheckCode:=21;
                    if OsObject.dwAddTime = 0 then begin //gt decorations
                      nDateDropped:=Makelong(MakeWord(pTMapItem(OSObject.CellObj).UserItem.btValue[1],pTMapItem(OSObject.CellObj).UserItem.btValue[2]),MakeWord(pTMapItem(OSObject.CellObj).UserItem.btValue[3], pTMapItem(OSObject.CellObj).UserItem.btValue[4]));
                      pTMapItem(OSObject.CellObj).Name := LeftStr(pTMapItem(OSObject.CellObj).Name,Length(pTMapItem(OSObject.CellObj).Name)-3) + '[' + IntToStr(7 - DaysBetween(now(),UnixToDateTime(nDateDropped))) + ']';
                    end;
                    if ((GetTickCount - OSObject.dwAddTime) > g_Config.dwClearDropOnFloorItemTime) and (OSObject.dwAddTime > 0) then begin
                      Dispose(pTMapItem(OSObject.CellObj));//Jacky 10/22
                      Dispose(OSObject);
                      MapCellInfo.ObjList.Delete(nIdx);
                      if MapCellInfo.ObjList.Count > 0 then Continue;
                      MapCellInfo.ObjList.Free;
                      MapCellInfo.ObjList:=nil;
                      break;
                    end; //004B9A8E
                    MapItem:=pTMapItem(OSObject.CellObj);
                    nCheckCode:=28;
                    UpdateVisibleItem(n18,n1C,MapItem);
                    if (MapItem.OfBaseObject <> nil) or (MapItem.DropBaseObject <> nil) then begin
                      nCheckCode:=29;
                      if (GetTickCount - MapItem.dwCanPickUpTick) > g_Config.dwFloorItemCanPickUpTime {2 * 60 * 1000} then begin
                        nCheckCode:=30;
                        MapItem.OfBaseObject:=nil;
                        MapItem.DropBaseObject:=nil;
                      end else begin //004B9AF6
                        nCheckCode:=31;
                        if TBaseObject(MapItem.OfBaseObject) <> nil then begin
                          nCheckCode:=32;
                          if TBaseObject(MapItem.OfBaseObject).m_boGhost then MapItem.OfBaseObject:=nil;
                        end;
                        nCheckCode:=33;
                        if TBaseObject(MapItem.DropBaseObject) <> nil then begin
                          nCheckCode:=34;
                          if TBaseObject(MapItem.DropBaseObject).m_boGhost then MapItem.DropBaseObject:=nil;
                        end;
                        nCheckCode:=35;
                      end; //004B9B38
                    end;
                  end; //004B9B38 if OSObject.btType = OS_ITEMOBJECT then begin
                  nCheckCode:=36;
                  if OSObject.btType = OS_EVENTOBJECT then begin
                    nCheckCode:=37;
                    MapEvent:=TEvent(OSObject.CellObj);
                    if MapEvent.m_boVisible then begin
                      nCheckCode:=38;
                      UpdateVisibleEvent(n18,n1C,MapEvent);
                    end;
                    nCheckCode:=39;
                  end;
                end
              end; //004B9B81 if OSObject <> nil then begin
            Inc(nIdx);
          end; //while (True) do begin
        end;
      end; //for n1C:= n10 to n14  do begin
    end; //for n18:= n8 to nC do begin
  except
    on e: Exception do begin

      MainOutMessage(format(sExceptionMsg2,[n24,m_sCharName,m_sMapName,m_nCurrX,m_nCurrY,nCheckCode]));
      {
      MainOutMessage(m_sCharName + ',' +
                     m_sMapName + ',' +
                     IntToStr(m_nCurrX) + ',' +
                     IntToStr(m_nCurrY) + ',' +
                     ' SearchViewRange 1-' +
                     IntToStr(n24));
      }
      MainOutMessage(E.Message);
      KickException();
    end;
  end;
  nCheckCode:=40;
  n24:=2;
  try
    n18:=0;
    while (True) do begin
      if m_VisibleActors.Count <= n18 then break;
      nCheckCode:=41;
      VisibleBaseObject:=m_VisibleActors.Items[n18];
      nCheckCode:=42;
      if VisibleBaseObject.nVisibleFlag = 0 then begin
        nCheckCode:=43;
        if m_btRaceServer = RC_PLAYOBJECT then begin
          nCheckCode:=44;
          BaseObject:=TBaseObject(VisibleBaseObject.BaseObject);
          {
          if not BaseObject.m_boFixedHideMode then
            SendMsg(BaseObject,RM_DISAPPEAR,0,0,0,0,'');
          }
          nCheckCode:=45;
          if not BaseObject.m_boFixedHideMode and (not BaseObject.m_boGhost) then begin//01/21 修改防止人物退出时发送重复的消息占用带宽，人物进入隐身模式时人物不消失问题
            nCheckCode:=46;
            SendMsg(BaseObject,RM_DISAPPEAR,0,0,0,0,'');
          end;
          nCheckCode:=47;
        end;
        m_VisibleActors.Delete(n18);
        nCheckCode:=48;
        Dispose(VisibleBaseObject);
        nCheckCode:=49;
        Continue;
      end;
      nCheckCode:=50;
      if (m_btRaceServer = RC_PLAYOBJECT) and (VisibleBaseObject.nVisibleFlag = 2) then begin
        nCheckCode:=51;
        BaseObject:=TBaseObject(VisibleBaseObject.BaseObject);
        nCheckCode:=52;
        if BaseObject <> Self then begin
          nCheckCode:=53;
          if BaseObject.m_boDeath then begin
            nCheckCode:=54;
            if BaseObject.m_boSkeleton then begin
              nCheckCode:=55;
              SendMsg(BaseObject,RM_SKELETON,BaseObject.m_btDirection,BaseObject.m_nCurrX,BaseObject.m_nCurrY,0,'');
              nCheckCode:=56;
            end else begin //004B9DA8
              nCheckCode:=57;
              SendMsg(BaseObject,RM_DEATH,BaseObject.m_btDirection,BaseObject.m_nCurrX,BaseObject.m_nCurrY,0,'');
              nCheckCode:=58;
            end;
          end else begin //004B9DD3
            nCheckCode:=59;
            SendMsg(BaseObject,RM_TURN,BaseObject.m_btDirection,BaseObject.m_nCurrX,BaseObject.m_nCurrY,0,BaseObject.GetShowName);
            nCheckCode:=60;
          end;
        end; //004B9E09
      end;
      Inc(n18);
    end;
  except
    on e: Exception do begin
      MainOutMessage(format(sExceptionMsg2,[n24,m_sCharName,m_sMapName,m_nCurrX,m_nCurrY,nCheckCode]));
    {MainOutMessage(m_sCharName + ',' +
                   m_sMapName + ',' +
                   IntToStr(m_nCurrX) + ',' +
                   IntToStr(m_nCurrY) + ',' +
                   ' SearchViewRange 2');}
      KickException();
    end;
  end;
  try
//    if (m_btRaceServer = RC_PLAYOBJECT) then begin
      I:=0;
      while (True) do begin
        if m_VisibleItems.Count <= I then break;
        VisibleMapItem:=m_VisibleItems.Items[I];
        if VisibleMapItem.nVisibleFlag = 0 then begin
          SendMsg(Self,RM_ITEMHIDE,0,Integer(VisibleMapItem.MapItem),VisibleMapItem.nX,VisibleMapItem.nY,'');
          m_VisibleItems.Delete(I);
          Dispose(VisibleMapItem);
          Continue;
        end; //004B9F6C
        if VisibleMapItem.nVisibleFlag = 2 then begin
          if VisibleMapItem.MapItem.UserItem.Amount > 1 then
            SendRefMsg (RM_ITEMSHOW, VisibleMapItem.wLooks, integer(VisibleMapItem.MapItem), VisibleMapItem.nX,VisibleMapItem.nY, VisibleMapItem.sName + '(' + IntToStr(VisibleMapItem.MapItem.UserItem.Amount) + ')')
          else
            SendMsg(Self,RM_ITEMSHOW,VisibleMapItem.wLooks,Integer(VisibleMapItem.MapItem),VisibleMapItem.nX,VisibleMapItem.nY,VisibleMapItem.sName);
        end;
        Inc(I);
      end;
      I:=0;
      while (True) do begin
        if m_VisibleEvents.Count <= I then break;
        MapEvent:=m_VisibleEvents.Items[I];
        if MapEvent.nVisibleFlag = 0 then begin
          SendMsg(Self,RM_HIDEEVENT,0,Integer(MapEvent),MapEvent.m_nX,MapEvent.m_nY,'');
          m_VisibleEvents.Delete(I);
          Continue;
        end; //004BA053
        if MapEvent.nVisibleFlag = 2 then begin
          SendMsg(Self,RM_SHOWEVENT,MapEvent.m_nEventType,Integer(MapEvent),MakeLong(MapEvent.m_nX,MapEvent.m_nEventParam),MapEvent.m_nY,'');
        end;
        Inc(I);
      end;
//    end;
  except
    MainOutMessage(m_sCharName + ',' +
                   m_sMapName + ',' +
                   IntToStr(m_nCurrX) + ',' +
                   IntToStr(m_nCurrY) + ',' +
                   ' SearchViewRange 3');

    KickException();
  end;
end;

function TPlayObject.GetShowName: String;
var
  sShowName:String;
  sCharName:String;
  sGuildName:String;
  sDearName:String;
  sMasterName:String;
  Castle:TUserCastle;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::GetShowName';
begin
try
  //sShowName:=m_sCharName;
  sCharName:='';
  sGuildName:='';
  sDearName:='';
  sMasterName:='';
  if m_MyGuild <> nil then begin
    Castle:=g_CastleManager.IsCastleMember(Self);
    if Castle <> nil then begin
      sGuildName:=AnsiReplaceText(g_sCastleGuildName,'%castlename',Castle.m_sName);
      sGuildName:=AnsiReplaceText(sGuildName,'%guildname',TGuild(m_MyGuild).sGuildName);
      sGuildName:=AnsiReplaceText(sGuildName,'%rankname',m_sGuildRankName);
    end else begin
      Castle:=g_CastleManager.InCastleWarArea(Self);
      if g_Config.boShowGuildName or (((Castle <> nil) and Castle.m_boUnderWar) or m_boInFreePKArea) then begin
        sGuildName:=AnsiReplaceText(g_sNoCastleGuildName,'%guildname',TGuild(m_MyGuild).sGuildName);
        sGuildName:=AnsiReplaceText(sGuildName,'%rankname',m_sGuildRankName);
      end;
    end;
  end;
  if not g_Config.boShowRankLevelName then begin
    if m_btReLevel > 0 then begin
      case m_btJob of
        jWarr: sCharName:=AnsiReplaceText(g_sWarrReNewName,'%chrname',m_sCharName);
        jWizard: sCharName:=AnsiReplaceText(g_sWizardReNewName,'%chrname',m_sCharName);
        jTaos: sCharName:=AnsiReplaceText(g_sTaosReNewName,'%chrname',m_sCharName);
      end;
    end else begin
      sCharName:=m_sCharName;
    end;
  end else begin
    sCharName:=format(m_sRankLevelName,[m_sCharName]);
  end;
    

  if m_sMasterName <> '' then begin
    if m_boMaster then begin
      sMasterName:= format(g_sMasterName,[m_sMasterName]);
    end else begin
      sMasterName:= format(g_sNoMasterName,[m_sMasterName]);
    end;
  end;
  if m_sDearName <> '' then begin
    if m_btGender = gMan then begin
      sDearName:= format(g_sManDearName,[m_sDearName]);
    end else begin
      sDearName:= format(g_sWoManDearName,[m_sDearName]);
    end;
  end;
  
  sShowName:=AnsiReplaceText(g_sHumanShowName,'%chrname',sCharName);
  sShowName:=AnsiReplaceText(sShowName,'%guildname',sGuildName);
  sShowName:=AnsiReplaceText(sShowName,'%dearname',sDearName);
  sShowName:=AnsiReplaceText(sShowName,'%mastername',sMasterName);
  Result:=sShowName;
except
  on e: Exception do begin
    MainOutMessage(sExceptionMsg);
    MainOutMessage(E.Message);
  end;
end;
end;
function TPlayObject.CheckItemsNeed(StdItem:TItem): Boolean;
var
  Castle:TUserCastle;
begin
  Result:=True;
  Castle:=g_CastleManager.IsCastleMember(Self);
  case StdItem.Need of
    6: begin
      if (m_MyGuild = nil)then begin
        Result:=False;
      end;
    end;
    60: begin
      if (m_MyGuild = nil) or (m_nGuildRankNo <> 1) then begin
        Result:=False;
      end;
    end;
    7: begin
      //if (m_MyGuild = nil) or (UserCastle.m_MasterGuild <> m_MyGuild) then begin
      if Castle = nil then begin        
        Result:=False;
      end;
    end;
    70: begin
      //if (m_MyGuild = nil) or (UserCastle.m_MasterGuild <> m_MyGuild) or (m_nGuildRankNo <> 1) then begin
      if (Castle = nil) or (m_nGuildRankNo <> 1) then begin        
        Result:=False;
      end;
    end;
    8: begin
      if m_nMemberType = 0 then Result:=False;
    end;
    81: begin
      if (m_nMemberType <> LoWord(StdItem.NeedLevel)) or (m_nMemberLevel < HiWord(StdItem.NeedLevel)) then
        Result:=False;
    end;
    82: begin
      if (m_nMemberType < LoWord(StdItem.NeedLevel)) or (m_nMemberLevel < HiWord(StdItem.NeedLevel)) then
        Result:=False;
    end;
  end;

end;
procedure TPlayObject.CheckMarry;
var
  boIsfound:Boolean;
  sUnMarryFileName:String;
  LoadList:TStringList;
  I:Integer;
  sSayMsg:String;
begin
  boIsfound:=False;
  sUnMarryFileName:=g_Config.sEnvirDir + 'UnMarry.txt';
  if FileExists(sUnMarryFileName) then begin
    LoadList:=TStringList.Create;
    LoadList.LoadFromFile(sUnMarryFileName);
    for I := 0 to LoadList.Count - 1 do begin
      if CompareText(LoadList.Strings[i],m_sCharName) = 0 then begin
        LoadList.Delete(i);
        boIsfound:=True;
        break;
      end;
    end;
    LoadList.SaveToFile(sUnMarryFileName);
    LoadList.Free;
  end;
  if boIsfound then begin
    if m_btGender = gMan then begin
      sSayMsg:=AnsiReplaceText(g_sfUnMarryManLoginMsg,'%d',m_sDearName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sDearName);
    end else begin
      sSayMsg:=AnsiReplaceText(g_sfUnMarryWoManLoginMsg,'%d',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
    end;
    SysMsg(sSayMsg,c_Red,t_Hint);
    m_sDearName:='';
    RefShowName;
  end;
  m_DearHuman:=UserEngine.GeTPlayObject(m_sDearName);
  if m_DearHuman <> nil then begin
    m_DearHuman.m_DearHuman:=Self;
    if m_btGender = gMan then begin
      sSayMsg:=AnsiReplaceText(g_sManLoginDearOnlineSelfMsg,'%d',m_sDearName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_DearHuman.m_PEnvir.sMapDesc);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_DearHuman.m_nCurrX));
      sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_DearHuman.m_nCurrY));
      SysMsg(sSayMsg,c_Blue,t_Hint);

      sSayMsg:=AnsiReplaceText(g_sManLoginDearOnlineDearMsg,'%d',m_sDearName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_PEnvir.sMapDesc);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_nCurrX));
      sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_nCurrY));
      m_DearHuman.SysMsg(sSayMsg,c_Blue,t_Hint);
    end else begin
      sSayMsg:=AnsiReplaceText(g_sWoManLoginDearOnlineSelfMsg,'%d',m_sDearName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_DearHuman.m_PEnvir.sMapDesc);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_DearHuman.m_nCurrX));
      sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_DearHuman.m_nCurrY));
      SysMsg(sSayMsg,c_Blue,t_Hint);

      sSayMsg:=AnsiReplaceText(g_sWoManLoginDearOnlineDearMsg,'%d',m_sDearName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_PEnvir.sMapDesc);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_nCurrX));
      sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_nCurrY));
      m_DearHuman.SysMsg(sSayMsg,c_Blue,t_Hint);
    end;
  end else begin
    if m_btGender = gMan then begin
      SysMsg(g_sManLoginDearNotOnlineMsg,c_Red,t_Hint);
    end else begin
      SysMsg(g_sWoManLoginDearNotOnlineMsg,c_Red,t_Hint);
    end;
  end;

end;
procedure TPlayObject.CheckMaster;
var
  boIsfound:Boolean;
  sSayMsg:String;
  I:Integer;
  Human:TPlayObject;
begin
//处理强行脱离师徒关系
  boIsfound:=False;
  g_UnForceMasterList.Lock;
  try
    for I := 0 to g_UnForceMasterList.Count - 1 do begin
      if CompareText(g_UnForceMasterList.Strings[i],m_sCharName) = 0 then begin
        g_UnForceMasterList.Delete(i);
        SaveUnForceMasterList();
        boIsfound:=True;
        break;
      end;
    end;
  finally
    g_UnForceMasterList.UnLock;
  end;

  if boIsfound then begin
    if m_boMaster then begin
      sSayMsg:=AnsiReplaceText(g_sfUnMasterLoginMsg,'%d',m_sMasterName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sMasterName);
    end else begin
      sSayMsg:=AnsiReplaceText(g_sfUnMasterListLoginMsg,'%d',m_sMasterName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sMasterName);
    end;
    SysMsg(sSayMsg,c_Red,t_Hint);
    m_sMasterName:='';
    RefShowName;
  end;

  if (m_sMasterName <> '') and not m_boMaster then begin
    if m_Abil.Level >= g_Config.nMasterOKLevel then begin
      Human:=UserEngine.GeTPlayObject(m_sMasterName);
      if (Human <> nil) and (not Human.m_boDeath) and (not Human.m_boGhost) then begin
        sSayMsg:=AnsiReplaceText(g_sYourMasterListUnMasterOKMsg,'%d',m_sCharName);
        Human.SysMsg(sSayMsg,c_Red,t_Hint);
        SysMsg(g_sYouAreUnMasterOKMsg,c_Red,t_Hint);

        if m_sCharName = Human.m_sMasterName then begin
          Human.m_sMasterName:='';
          Human.RefShowName;
        end;
        for I := 0 to Human.m_MasterList.Count - 1 do begin
          if Human.m_MasterList.Items[I] = Self then begin
            Human.m_MasterList.Delete(I);
            break;
          end;
        end;
            
        m_sMasterName:='';
        RefShowName;
        if Human.m_btCreditPoint + g_Config.nMasterOKCreditPoint <= High(Byte) then begin
          Inc(Human.m_btCreditPoint,g_Config.nMasterOKCreditPoint);
        end;
        Inc(Human.m_nBonusPoint,g_Config.nMasterOKBonusPoint);
        Human.SendMsg(Human,RM_ADJUST_BONUS,0,0,0,0,'');
      end else begin
        g_UnMasterList.Lock;
        try
          boIsfound:=False;
          for I := 0 to g_UnMasterList.Count - 1 do begin
            if CompareText(g_UnMasterList.Strings[i],m_sCharName) = 0 then begin
              boIsfound:=True;
              break;
            end;
          end;
          if not boIsfound then begin
            g_UnMasterList.Add(m_sMasterName);
          end;
        finally
          g_UnMasterList.UnLock;
        end;
        if not boIsfound then begin
          SaveUnMasterList();
        end;
        SysMsg(g_sYouAreUnMasterOKMsg,c_Red,t_Hint);
        m_sMasterName:='';
        RefShowName;
      end;
    end;
  end;

  boIsfound:=False;
  g_UnMasterList.Lock;
  try
    for I := 0 to g_UnMasterList.Count - 1 do begin
      if CompareText(g_UnMasterList.Strings[i],m_sCharName) = 0 then begin
        g_UnMasterList.Delete(i);
        SaveUnMasterList();
        boIsfound:=True;
        break;
      end;
    end;
  finally
    g_UnMasterList.UnLock;
  end;
  
  if boIsfound and m_boMaster then begin
    SysMsg(g_sUnMasterLoginMsg,c_Red,t_Hint);

    m_sMasterName:='';
    RefShowName;

    if m_btCreditPoint + g_Config.nMasterOKCreditPoint <= High(Byte) then begin
      Inc(m_btCreditPoint,g_Config.nMasterOKCreditPoint);
    end;
    Inc(m_nBonusPoint,g_Config.nMasterOKBonusPoint);
    SendMsg(Self,RM_ADJUST_BONUS,0,0,0,0,'');
  end;

  if m_sMasterName = '' then exit;
  if m_boMaster then begin
    m_MasterHuman:=UserEngine.GeTPlayObject(m_sMasterName);
    if m_MasterHuman <> nil then begin
      m_MasterHuman.m_MasterHuman:=Self;
      m_MasterList.Add(m_MasterHuman);
      
      sSayMsg:=AnsiReplaceText(g_sMasterOnlineSelfMsg,'%d',m_sMasterName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_MasterHuman.m_PEnvir.sMapDesc);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_MasterHuman.m_nCurrX));
      sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_MasterHuman.m_nCurrY));
      SysMsg(sSayMsg,c_Blue,t_Hint);

      sSayMsg:=AnsiReplaceText(g_sMasterOnlineMasterListMsg,'%d',m_sMasterName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_PEnvir.sMapDesc);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_nCurrX));
      sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_nCurrY));
      m_MasterHuman.SysMsg(sSayMsg,c_Blue,t_Hint);
    end else begin
      SysMsg(g_sMasterNotOnlineMsg,c_Red,t_Hint);
    end;
  end else begin
    if m_sMasterName <> '' then begin
      m_MasterHuman:=UserEngine.GeTPlayObject(m_sMasterName);
      if m_MasterHuman <> nil then begin

        if m_MasterHuman.m_sMasterName = m_sCharName then begin
          m_MasterHuman.m_MasterHuman:=Self;
        end;

        m_MasterHuman.m_MasterList.Add(Self);

        sSayMsg:=AnsiReplaceText(g_sMasterListOnlineSelfMsg,'%d',m_sMasterName);
        sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
        sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_MasterHuman.m_PEnvir.sMapDesc);
        sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_MasterHuman.m_nCurrX));
        sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_MasterHuman.m_nCurrY));
        SysMsg(sSayMsg,c_Blue,t_Hint);

        sSayMsg:=AnsiReplaceText(g_sMasterListOnlineMasterMsg,'%d',m_sMasterName);
        sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
        sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_PEnvir.sMapDesc);
        sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_nCurrX));
        sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_nCurrY));
        m_MasterHuman.SysMsg(sSayMsg,c_Blue,t_Hint);
      end else begin
        SysMsg(g_sMasterListNotOnlineMsg,c_Red,t_Hint);
      end;
    end;
  end;
end;
procedure TPlayObject.MakeGhost; //PLAYER DISCONNECT
var
  I: Integer;
  sSayMsg:String;
  Human:TPlayObject;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::MakeGhost';
begin
try
  Self.ClientFriendChangeState(False);
  if (g_HighLevelHuman = Self)   then g_HighLevelHuman:=nil;
  if (g_HighPKPointHuman = Self) then g_HighPKPointHuman:=nil;
  if (g_HighDCHuman = Self)      then g_HighDCHuman:=nil;
  if (g_HighMCHuman = Self)      then g_HighMCHuman:=nil;
  if (g_HighSCHuman = Self)      then g_HighSCHuman:=nil;
  if (g_HighOnlineHuman = Self)  then g_HighOnlineHuman:=nil;
  if m_DearHuman <> nil then begin
    if m_btGender = gMan then begin
      sSayMsg:=AnsiReplaceText(g_sManLongOutDearOnlineMsg,'%d',m_sDearName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_PEnvir.sMapDesc);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_nCurrX));
      sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_nCurrY));
      m_DearHuman.SysMsg(sSayMsg,c_Red,t_Hint);
    end else begin
      sSayMsg:=AnsiReplaceText(g_sWoManLongOutDearOnlineMsg,'%d',m_sDearName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_PEnvir.sMapDesc);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_nCurrX));
      sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_nCurrY));
      m_DearHuman.SysMsg(sSayMsg,c_Red,t_Hint);
    end;
    m_DearHuman.m_DearHuman:=nil;
    m_DearHuman:=nil;
  end;
  if (m_MasterHuman <> nil) or (m_MasterList.Count > 0) then begin
    if m_boMaster then begin
      for I := 0 to m_MasterList.Count - 1 do begin
        Human:=TPlayObject(m_MasterList.Items[I]);
        sSayMsg:=AnsiReplaceText(g_sMasterLongOutMasterListOnlineMsg,'%s',m_sCharName);
        sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_PEnvir.sMapDesc);
        sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_nCurrX));
        sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_nCurrY));
        Human.SysMsg(sSayMsg,c_Red,t_Hint);
        Human.m_MasterHuman:=nil;
      end;
    end else begin
      if m_MasterHuman = nil then exit;
      sSayMsg:=AnsiReplaceText(g_sMasterListLongOutMasterOnlineMsg,'%d',m_sMasterName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%s',m_sCharName);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%m',m_PEnvir.sMapDesc);
      sSayMsg:=AnsiReplaceText(sSayMsg,'%x',IntToStr(m_nCurrX));
      sSayMsg:=AnsiReplaceText(sSayMsg,'%y',IntToStr(m_nCurrY));
      m_MasterHuman.SysMsg(sSayMsg,c_Red,t_Hint);

      if m_MasterHuman.m_sMasterName = m_sCharName then begin
        m_MasterHuman.m_MasterHuman:=nil;
      end;

      for I := 0 to m_MasterHuman.m_MasterList.Count - 1 do begin
        if m_MasterHuman.m_MasterList.Items[I] = Self then begin
          m_MasterHuman.m_MasterList.Delete(I);
          break;
        end;
      end;
    end;
  end;
except
  on e: Exception do begin
    MainOutMessage(sExceptionMsg);
    MainOutMessage(E.Message);
  end;

end;
  inherited;
end;

function TPlayObject.GetMyInfo: String;
var
  sMyInfo:String;
begin
  sMyInfo:=g_sMyInfo;
  sMyInfo:=AnsiReplaceText(sMyInfo,'%name',m_sCharName);
  sMyInfo:=AnsiReplaceText(sMyInfo,'%map',m_PEnvir.sMapDesc);
  sMyInfo:=AnsiReplaceText(sMyInfo,'%x',IntToStr(m_nCurrX));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%y',IntToStr(m_nCurrY));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%level',IntToStr(m_Abil.Level));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%gold',IntToStr(m_nGold));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%pk',IntToStr(m_nPkPoint));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%minhp',IntToStr(m_WAbil.HP));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%maxhp',IntToStr(m_WAbil.MaxHP));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%minmp',IntToStr(m_WAbil.MP));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%maxmp',IntToStr(m_WAbil.MaxMP));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%mindc',IntToStr(LoWord(m_WAbil.DC)));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%maxdc',IntToStr(HiWord(m_WAbil.DC)));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%minmc',IntToStr(LoWord(m_WAbil.MC)));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%maxmc',IntToStr(HiWord(m_WAbil.MC)));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%minsc',IntToStr(LoWord(m_WAbil.SC)));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%maxsc',IntToStr(HiWord(m_WAbil.SC)));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%logontime',DateTimeToStr(m_dLogonTime));
  sMyInfo:=AnsiReplaceText(sMyInfo,'%logonlong',IntToStr((GetTickCount - m_dwLogonTick) div 60000));
  Result:=sMyInfo;
end;

function TPlayObject.CheckItemBindUse(UserItem: pTUserItem): Boolean;
var
  I: Integer;
  ItemBind:pTItemBind;
begin
  Result:=True;
  g_ItemBindAccount.Lock;
  try
    for I := 0 to g_ItemBindAccount.Count - 1 do begin
      ItemBind:=g_ItemBindAccount.Items[I];
      if (ItemBind.nMakeIdex = UserItem.MakeIndex) and
         (ItemBind.nItemIdx = UserItem.wIndex) then begin
        Result:=False;
        if (CompareText(ItemBind.sBindName,m_sUserID) = 0) then begin
          Result:=True;
        end else begin
          SysMsg(g_sItemIsNotThisAccount,c_Red,t_Hint);
        end;          
        exit;
      end;
    end;
  finally
    g_ItemBindAccount.UnLock;
  end;
  
  g_ItemBindIPaddr.Lock;
  try
    for I := 0 to g_ItemBindIPaddr.Count - 1 do begin
      ItemBind:=g_ItemBindIPaddr.Items[I];
      if (ItemBind.nMakeIdex = UserItem.MakeIndex) and
         (ItemBind.nItemIdx = UserItem.wIndex) then begin
        Result:=False;
        if (CompareText(ItemBind.sBindName,m_sIPaddr) = 0) then begin
          Result:=True;
        end else begin
          SysMsg(g_sItemIsNotThisIPaddr,c_Red,t_Hint);
        end;
        exit;
      end;
    end;
  finally
    g_ItemBindIPaddr.UnLock;
  end;
  g_ItemBindCharName.Lock;
  try
    for I := 0 to g_ItemBindCharName.Count - 1 do begin
      ItemBind:=g_ItemBindCharName.Items[I];
      if (ItemBind.nMakeIdex = UserItem.MakeIndex) and
         (ItemBind.nItemIdx = UserItem.wIndex) then begin
        Result:=False;
        if (CompareText(ItemBind.sBindName,m_sCharName) = 0) then begin
          Result:=True;
        end else begin
          SysMsg(g_sItemIsNotThisCharName,c_Red,t_Hint);
        end;
        exit;
      end;
    end;
  finally
    g_ItemBindCharName.UnLock;
  end;
end;

procedure TPlayObject.ProcessClientPassword(ProcessMsg: pTProcessMessage);
var
  nLen:Integer;
  sData:String;
begin
//  SysMsg(ProcessMsg.sMsg,c_Red,t_Hint);
  if ProcessMsg.wParam = 0 then begin
    ProcessUserLineMsg('@' + g_GameCommand.UNLOCK.sCmd);
    exit;
  end;

  sData:=ProcessMsg.sMsg;
  nLen:=length(sData);
  if m_boSetStoragePwd then begin
    m_boSetStoragePwd:=False;
    if (nLen > 3) and (nLen < 8) then begin
      m_sTempPwd:=sData;
      m_boReConfigPwd:=True;
      SysMsg(g_sReSetPasswordMsg,c_Green,t_Hint);
      SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
    end else begin
      SysMsg(g_sPasswordOverLongMsg,c_Red,t_Hint);
    end;
    exit;
  end;
  if m_boReConfigPwd then begin
    m_boReConfigPwd:=False;
    if CompareStr(m_sTempPwd,sData) = 0 then begin
      m_sStoragePwd:=sData;
      m_boPasswordLocked:=True;
      m_sTempPwd:='';
      SysMsg(g_sReSetPasswordOKMsg,c_Blue,t_Hint);
    end else begin
      m_sTempPwd:='';
      SysMsg(g_sReSetPasswordNotMatchMsg,c_Red,t_Hint);
    end;
    exit;
  end;
  if m_boUnLockPwd or m_boUnLockStoragePwd then begin
    if CompareStr(m_sStoragePwd,sData) = 0 then begin
      m_boPasswordLocked:=False;
      if m_boUnLockPwd then begin
        if g_Config.boLockDealAction then m_boCanDeal:=True;
        if g_Config.boLockDropAction then m_boCanDrop:=True;
        if g_Config.boLockWalkAction then m_boCanWalk:=True;
        if g_Config.boLockRunAction then m_boCanRun:=True;
        if g_Config.boLockHitAction then m_boCanHit:=True;
        if g_Config.boLockSpellAction then m_boCanSpell:=True;
        if g_Config.boLockSendMsgAction then m_boCanSendMsg:=True;
        if g_Config.boLockUserItemAction then m_boCanUseItem:=True;
        if g_Config.boLockInObModeAction then begin
          m_boObMode:=False;
          m_boAdminMode:=False;
        end;
        m_boLockLogoned:=True;
        SysMsg(g_sPasswordUnLockOKMsg,c_Blue,t_Hint);
      end;
      if m_boUnLockStoragePwd then begin
        if g_Config.boLockGetBackItemAction then m_boCanGetBackItem:=True;
        SysMsg(g_sStorageUnLockOKMsg,c_Blue,t_Hint);
      end;

    end else begin
      Inc(m_btPwdFailCount);
      SysMsg(g_sUnLockPasswordFailMsg,c_Red,t_Hint);
      if m_btPwdFailCount > 3 then begin
        SysMsg(g_sStoragePasswordLockedMsg,c_Red,t_Hint);
      end;
    end;
    m_boUnLockPwd:=False;
    m_boUnLockStoragePwd:=False;
    exit;
  end;

  if m_boCheckOldPwd then begin
    m_boCheckOldPwd:=False;
    if m_sStoragePwd = sData then begin
      SendMsg(Self,RM_PASSWORD,0,0,0,0,'');
      SysMsg(g_sSetPasswordMsg,c_Green,t_Hint);
      m_boSetStoragePwd:=True;
    end else begin
      Inc(m_btPwdFailCount);
      SysMsg(g_sOldPasswordIncorrectMsg,c_Red,t_Hint);
      if m_btPwdFailCount > 3 then begin
        SysMsg(g_sStoragePasswordLockedMsg,c_Red,t_Hint);
        m_boPasswordLocked:=True;
      end;
    end;
    exit;
  end;
end;


procedure TPlayObject.ScatterBagItems(ItemOfCreat: TBaseObject);
const
  DropWide:Integer = 2;
var
  i:Integer;
  pu:pTUserItem;
  UserItem:pTUserItem;
  DelList:TStringList;
  boDropall:Boolean;
  temp2:pTUserItem;
ResourceString
  sExceptionMsg = '[Exception] TPlayObject::ScatterBagItems';
begin
   DelList:=nil;
   if m_boAngryRing or m_boNoDropItem or m_PEnvir.Flag.boNODROPITEM then exit; //不死戒指

   boDropall:=False;
   if g_Config.boDieRedScatterBagAll and (PKLevel >= 2 )then begin
     boDropall:=True;
   end;

   //非红名掉1/3 //红名全掉

   try
     for i:=m_ItemList.Count - 1 downto 0 do begin
       if boDropall or (Random(g_Config.nDieScatterBagRate{3}) = 0) then begin
        temp2:=m_ItemList[i];
         if (UserEngine.GetStdItem(pTUserItem(m_ItemList[i]).wIndex).StdMode = 45) and (boDropall = false) and (pTUserItem(m_ItemList[i]).Amount > 10) then begin
          UserItem:=copyuseritem(m_ItemList[i]);
          UserItem.Amount:=Random(UserItem.Amount - 2) + 1;
          dec(pTUserItem(m_ItemList[i]).Amount,UserItem.Amount);
          if DropItemDown (UserItem,DropWide,True,ItemOfCreat,Self) then begin
           if m_btRaceServer = RC_PLAYOBJECT then begin
             if DelList = nil then DelList:=TStringList.Create;
             DelList.AddObject(UserEngine.GetStdItemName (UserItem.wIndex), TObject(UserItem.MakeIndex));
           end;
          end;
          continue;
         end;

         if DropItemDown (pTUserItem(m_ItemList[i]),DropWide,True,ItemOfCreat,Self) then begin
           pu := pTUserItem(m_ItemList[i]);
           if m_btRaceServer = RC_PLAYOBJECT then begin
             if DelList = nil then DelList:=TStringList.Create;
             DelList.AddObject(UserEngine.GetStdItemName (pu.wIndex), TObject(pu.MakeIndex));
           end;
           Dispose(PTUserItem(m_ItemList[i]));
           m_ItemList.Delete (i);
         end;
      end;
     end;
     if DelList <> nil then begin
       SendMsg (self, RM_SENDDELITEMLIST,0,Integer(DelList),0,0,'');
     end;
   except
     MainOutMessage(sExceptionMsg);
   end;
end;

procedure TPlayObject.RecallHuman(sHumName: String);
var
  PlayObject:TPlayObject;
  nX,nY,n18,n1C:Integer;
begin
  PlayObject:=UserEngine.GeTPlayObject(sHumName);
  if PlayObject <> nil then begin
    if GetFrontPosition(nX,nY) then begin
      if sub_4C5370(nX,nY,3,n18,n1C) then begin
        PlayObject.SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
        PlayObject.SpaceMove(m_sMapName,n18,n1C,0);
      end;
    end else begin
      SysMsg('Cannot recall while facing a wall',c_Red,t_Hint);
    end;
  end else begin
    SysMsg(format(g_sNowNotOnLineOrOnOtherServer,[sHumName]),c_Red,t_Hint);
  end;
end;

procedure TPlayObject.ReQuestGuildWar(sGuildName: String);
var
  Guild:TGuild;
  WarGuild:pTWarGuild;
  boReQuestOK:Boolean;
begin
  if not IsGuildMaster then begin
    SysMsg('You have to be Guild Master to start a war',c_Red,t_Hint);
    exit;
  end;
  if nServerIndex <> 0 then begin
    SysMsg('You can only start a war on the main server',c_Red,t_Hint);
    exit;
  end;
  Guild:=g_GuildManager.FindGuild(sGuildName);
  if Guild = nil then begin
    SysMsg('You need to enter a real guildname to fight against',c_Red,t_Hint);
    exit;
  end;
  boReQuestOK:=False;
  WarGuild:=TGuild(m_MyGuild).AddWarGuild(Guild);
  if WarGuild <> nil then begin
    if Guild.AddWarGuild(TGuild(m_MyGuild)) = nil then begin
      WarGuild.dwWarTick:=0;
    end else begin
      boReQuestOK:=True;
    end;
  end;
  if boReQuestOK then begin
    UserEngine.SendServerGroupMsg(SS_207,nServerIndex,TGuild(m_MyGuild).sGuildName);
    UserEngine.SendServerGroupMsg(SS_207,nServerIndex,Guild.sGuildName);
  end;     
    
end;
function TPlayObject.CheckDenyLogon():Boolean;
begin
  Result:=False;
  if GetDenyIPaddrList(m_sIPaddr) then begin
    SysMsg(g_sYourIPaddrDenyLogon,c_Red,t_Hint);
    Result:=True;
  end else
  if GetDenyAccountList(m_sUserID) then begin
    SysMsg(g_sYourAccountDenyLogon,c_Red,t_Hint);
    Result:=True;
  end else
  if GetDenyChrNameList(m_sCharName) then begin
    SysMsg(g_sYourCharNameDenyLogon,c_Red,t_Hint);
    Result:=True;
  end;
  if Result then m_boEmergencyClose:=True;
end;

procedure TPlayObject.ClientRequestMailList(ProcessMsg: pTProcessMessage);
var
  I: Integer;
  Item: pTMailItem;
  DBM: TADOQuery;
begin

  FrmDB.UseSQL();
  DBM := FrmDB.Query;

  DBM.SQL.Clear;
  DBM.SQL.Add('SELECT * FROM TBL_MAIL Where FLD_RECIPIENT='''+Self.m_sCharName+''' ORDER BY FLD_ID');
  DBM.Open;

  SendDefMessage(SM_MAILLIST, 0, 0, 0, 0, '');

  new(Item);
  for I := 0 to DBM.RecordCount do begin
    if DBM.eof then break;

    Item.Id := DBM.FieldByName('FLD_ID').AsInteger;
    Item.Sender := DBM.FieldByName('FLD_Sender').AsString;
    Item.Recipient :=  DBM.FieldByName('FLD_Recipient').AsString;
    Item.Content := DBM.FieldByName('FLD_Content').AsString;
    Item.Read := FrmDB.GetBoolean(DBM,'FLD_READ');
    Item.Status := DBM.FieldByName('FLD_Status').AsInteger;
    Item.Time := DBM.FieldByName('FLD_Time').AsInteger;

    SendDefMessage(SM_MAILITEM, 0, 0, 0, 0, MailItemToString(Item));

    DBM.Next;
  end;
  Dispose(Item);
  DBM.Close;
  SendDefMessage(SM_MAILLIST, 1, 0, 0, 0, '');  
end;

procedure TPlayObject.ClientSendMail(ProcessMsg: pTProcessMessage);
var
  FriendObject: TPlayObject;
  Item: ptMailItem;
  I: Integer;
  DBMc: TADOCommand;
  DBMq: TADOQuery;
  Parts: TStringList;
  Time: LongInt;
begin
  Parts := Split(#1,ProcessMsg.sMsg);

  if lowercase(Parts.Strings[0]) = lowercase(Self.m_sCharName) then begin
    SendDefMessage(SM_MAILFAILED, 0, 0, 0, 0, Parts.Strings[0]+#1+'你不能发送邮件给自己.');
    exit;
  end;

  FrmDB.UseSQL();
  DBMq := FrmDB.Query;
  DBMq.Close;
  DBMq.SQL.Clear;
  DBMq.SQL.Add('SELECT * FROM TBL_BLOCKLIST WHERE FLD_OWNER = :FLD_OWNER and FLD_NAME = :FLD_NAME');
  DBMq.Parameters.ParamByName('FLD_OWNER').Value := Parts.Strings[0];
  DBMq.Parameters.ParamByName('FLD_NAME').Value := Self.m_sCharName;
  DBMq.Open;

  if DBMq.RecordCount > 0 then begin
    SendDefMessage(SM_MAILFAILED, 0, 0, 0, 0, Parts.Strings[0]+#1+'User has blocked you');
// Note, Euro doesn't let you know when your blocked, to emulate this comment above and uncomment below
//    SendDefMessage(SM_MAILSENT, 0, 0, 0, 0, Parts.Strings[0]);
    DBMq.Close;
    exit;
  end;
  DBMq.Close;

  Time := UnixTime();
  FrmDB.UseSQL();
  DBMc := FrmDB.QueryCommand;
  DBMc.CommandText := 'INSERT INTO TBL_MAIL (FLD_SENDER,FLD_RECIPIENT,FLD_CONTENT,FLD_READ,FLD_STATUS,FLD_TIME) values (:FLD_SENDER, :FLD_RECIPIENT, :FLD_CONTENT, :FLD_READ, :FLD_STATUS, :FLD_TIME)';
  DBMc.Parameters.ParamByName('FLD_SENDER').Value := Self.m_sCharName;
  DBMc.Parameters.ParamByName('FLD_RECIPIENT').Value := Parts.Strings[0];
  DBMc.Parameters.ParamByName('FLD_CONTENT').Value := Parts.Strings[1];
  DBMc.Parameters.ParamByName('FLD_READ').Value := 0;
  DBMc.Parameters.ParamByName('FLD_STATUS').Value := 0;
  DBMc.Parameters.ParamByName('FLD_TIME').Value := Time;
  DBMc.Execute;
  DBMc.CommandText := '';
  SendDefMessage(SM_MAILSENT, 0, 0, 0, 0, Parts.Strings[0]);

  FriendObject := UserEngine.GetPlayObject(Parts.Strings[0]);
  if FriendObject <> nil then begin
    DBMq.Close;
    DBMq.SQL.Clear;
    DBMq.SQL.Add('SELECT * FROM TBL_MAIL Where FLD_SENDER=:FLD_SENDER and FLD_RECIPIENT=:FLD_RECIPIENT and FLD_TIME=:FLD_TIME');
    DBMq.Parameters.ParamByName('FLD_SENDER').Value := Self.m_sCharName;
    DBMq.Parameters.ParamByName('FLD_RECIPIENT').Value := Parts.Strings[0];
    DBMq.Parameters.ParamByName('FLD_TIME').Value := Time;
    DBMQ.Open;
    new(Item);
    for I := 0 to DBMq.RecordCount do begin
      if DBMq.eof then break;

      Item.Id := DBMq.FieldByName('FLD_ID').AsInteger;
      Item.Sender := DBMq.FieldByName('FLD_Sender').AsString;
      Item.Recipient :=  DBMq.FieldByName('FLD_Recipient').AsString;
      Item.Content := DBMq.FieldByName('FLD_Content').AsString;
      Item.Read := FrmDB.GetBoolean(DBMq,'FLD_READ');
      Item.Status := DBMq.FieldByName('FLD_Status').AsInteger;
      Item.Time := DBMq.FieldByName('FLD_Time').AsInteger;

      FriendObject.SendDefMessage(SM_MAILITEM, 1, 0, 0, 0, MailItemToString(Item));

      DBMq.Next;
    end;
    Dispose(Item);
    DBMq.Close;
  end;
end;

procedure TPlayObject.ClientReadMail(ProcessMsg: pTProcessMessage);
var
  nID: Integer;
  DBM: TADOCommand;
begin
  nID := ProcessMsg.nParam1;

  FrmDB.UseSQL();
  DBM := FrmDB.QueryCommand;
  DBM.CommandText := 'UPDATE TBL_MAIL SET FLD_READ=:FLD_READ WHERE FLD_ID = :FLD_ID and FLD_RECIPIENT = :FLD_RECIPIENT';
  DBM.Parameters.ParamByName('FLD_READ').Value := BoolToByte(True);
  DBM.Parameters.ParamByName('FLD_ID').Value := nID;
  DBM.Parameters.ParamByName('FLD_RECIPIENT').Value := Self.m_sCharName;
  DBM.Execute;
  DBM.CommandText := '';
end;

procedure TPlayObject.ClientDeleteMail(ProcessMsg: pTProcessMessage);
var
  nID: Integer;
  DBM: TADOCommand;
begin
  nID := ProcessMsg.nParam1;

  FrmDB.UseSQL();
  DBM := FrmDB.QueryCommand;
  DBM.CommandText := 'DELETE FROM TBL_MAIL WHERE FLD_ID = :FLD_ID and FLD_RECIPIENT = :FLD_RECIPIENT';
  DBM.Parameters.ParamByName('FLD_ID').Value := nID;
  DBM.Parameters.ParamByName('FLD_RECIPIENT').Value := Self.m_sCharName;
  DBM.Execute;
  DBM.CommandText := '';
end;

procedure TPlayObject.ClientSetMailStatus(ProcessMsg: pTProcessMessage);
var
  nID,nStatus: Integer;
  DBM: TADOCommand;
begin
  nID := ProcessMsg.nParam1;
  nStatus := ProcessMsg.nParam2;  

  FrmDB.UseSQL();
  DBM := FrmDB.QueryCommand;
  DBM.CommandText := 'UPDATE TBL_MAIL SET FLD_STATUS=:FLD_STATUS WHERE FLD_ID = :FLD_ID and FLD_RECIPIENT = :FLD_RECIPIENT';
  DBM.Parameters.ParamByName('FLD_STATUS').Value := nStatus;
  DBM.Parameters.ParamByName('FLD_ID').Value := nID;
  DBM.Parameters.ParamByName('FLD_RECIPIENT').Value := Self.m_sCharName;
  DBM.Execute;
  DBM.CommandText := '';
end;

procedure TPlayObject.ClientRequestBlockList(ProcessMsg: pTProcessMessage);
var
  I: Integer;
  Item: pTBlockItem;
  DBM: TADOQuery;
begin

  FrmDB.UseSQL();
  DBM := FrmDB.Query;

  DBM.SQL.Clear;
  DBM.SQL.Add('SELECT * FROM TBL_BLOCKLIST Where FLD_OWNER='''+Self.m_sCharName+''' ORDER BY FLD_ID');
  DBM.Open;

  SendDefMessage(SM_BLOCKLIST, 0, 0, 0, 0, '');

  new(Item);
  for I := 0 to DBM.RecordCount do begin
    if DBM.eof then break;

    Item.Id := DBM.FieldByName('FLD_ID').AsInteger;
    Item.Owner := DBM.FieldByName('FLD_Owner').AsString;
    Item.Name :=  DBM.FieldByName('FLD_Name').AsString;

    SendDefMessage(SM_BLOCKLISTITEM, 0, 0, 0, 0, inttostr(Item.ID)+#1+Item.Name);

    DBM.Next;
  end;
  Dispose(Item);
  DBM.Close;
  SendDefMessage(SM_BLOCKLIST, 1, 0, 0, 0, '');
end;

procedure TPlayObject.ClientAddBlock(ProcessMsg: pTProcessMessage);
var
  DBM: TADOQuery;
  DBMc: TADOCommand;
begin
  if ProcessMsg.sMsg = Self.m_sCharName then begin
    SendDefMessage(SM_BLOCKLISTFAIL, 0, 0, 0, 0, ProcessMsg.sMsg + #1 + 'You cant block yourself.');
    exit;
  end;

  FrmDB.UseSQL();
  DBM := FrmDB.Query;
  DBM.Close;
  DBM.SQL.Clear;
  DBM.SQL.Add('SELECT * FROM TBL_BLOCKLIST WHERE FLD_OWNER = :FLD_OWNER and FLD_NAME = :FLD_NAME');
  DBM.Parameters.ParamByName('FLD_OWNER').Value := Self.m_sCharName;
  DBM.Parameters.ParamByName('FLD_NAME').Value := ProcessMsg.sMsg;
  DBM.Open;

  if DBM.RecordCount > 0 then begin
    SendDefMessage(SM_BLOCKLISTFAIL, 0, 0, 0, 0, ProcessMsg.sMsg + #1 + 'You cant block someone more than once');
  end
  else begin
    SendDefMessage(SM_BLOCKLISTADDED, 0, 0, 0, 0, ProcessMsg.sMsg);

    FrmDB.UseSQL();
    DBMc := FrmDB.QueryCommand;
    DBMc.CommandText := 'INSERT INTO TBL_BLOCKLIST (FLD_OWNER,FLD_NAME) values (:FLD_OWNER, :FLD_NAME)';
    DBMc.Parameters.ParamByName('FLD_OWNER').Value := Self.m_sCharName;
    DBMc.Parameters.ParamByName('FLD_NAME').Value := ProcessMsg.sMsg;
    DBMc.Execute;
    DBMc.CommandText := '';
  end;
  DBM.Close;
end;

procedure TPlayObject.ClientDelBlock(ProcessMsg: pTProcessMessage);
var
  DBM: TADOCommand;
begin
  // Assume name is correct, we dont care yet
  SendDefMessage(SM_BLOCKLISTDELETED, 0, 0, 0, 0, ProcessMsg.sMsg);

  // Delete from sql
  FrmDB.UseSQL();
  DBM := FrmDB.QueryCommand;
  DBM.CommandText := 'DELETE FROM TBL_BLOCKLIST WHERE FLD_OWNER = :FLD_OWNER and FLD_NAME = :FLD_NAME';
  DBM.Parameters.ParamByName('FLD_OWNER').Value := Self.m_sCharName;
  DBM.Parameters.ParamByName('FLD_NAME').Value := ProcessMsg.sMsg;
  DBM.Execute;
  DBM.CommandText := '';
end;

procedure TPlayObject.ClientRequestGTList(ProcessMsg: pTProcessMessage);
var
  Merchant:TMerchant;
begin
  try
    if m_boDealing then exit;
    Merchant:=UserEngine.FindMerchant(TObject(ProcessMsg.nParam1));
    if (Merchant = nil) or
     (not Merchant.m_bobuy) or
     (Merchant.m_PEnvir <> m_PEnvir) or
     (abs(Merchant.m_nCurrX - m_nCurrX) > 15) or
     (abs(Merchant.m_nCurrY - m_nCurrY) > 15) then exit;
      Merchant.ClientRequestGTList(self,ProcessMsg.nParam2);

  except
  on e: Exception do begin
    MainOutMessage('TUserHumah.ClientRequestGTList wIdent = ' + IntToStr(ProcessMsg.wIdent));
    MainOutMessage(E.Message);
  end;
  end;
end;

procedure TPlayObject.ClientRequestDecoList(ProcessMsg: pTProcessMessage);
var
  Merchant:TMerchant;
begin
  try
    if m_boDealing then exit;
    Merchant:=UserEngine.FindMerchant(TObject(ProcessMsg.nParam1));
    if (Merchant = nil) or
     (not Merchant.m_bobuy) or
     (Merchant.m_PEnvir <> m_PEnvir) or
     (abs(Merchant.m_nCurrX - m_nCurrX) > 15) or
     (abs(Merchant.m_nCurrY - m_nCurrY) > 15) then exit;
      Merchant.ClientRequestDecoList(self,ProcessMsg.nParam2);

  except
  on e: Exception do begin
    MainOutMessage('TUserHumah.ClientRequestDecoList wIdent = ' + IntToStr(ProcessMsg.wIdent));
    MainOutMessage(E.Message);
  end;
  end;
end;

procedure TPlayObject.ClientRequestBBSList(ProcessMsg: pTProcessMessage);
var
  Merchant:TMerchant;
begin
  try
    if m_boDealing then exit;
    Merchant:=UserEngine.FindMerchant(TObject(ProcessMsg.nParam1));
    if (Merchant = nil) or
     (not Merchant.m_bobuy) or
     (Merchant.m_PEnvir <> m_PEnvir) or
     (abs(Merchant.m_nCurrX - m_nCurrX) > 15) or
     (abs(Merchant.m_nCurrY - m_nCurrY) > 15) then exit;
      Merchant.ClientRequestBBSMsgList(self,ProcessMsg.nParam2);

  except
  on e: Exception do begin
    MainOutMessage('TUserHumah.ClientRequestBBSMsgList wIdent = ' + IntToStr(ProcessMsg.wIdent));
    MainOutMessage(E.Message);
  end;
  end;
end;

procedure TPlayObject.ClientBuyGT(ProcessMsg: pTProcessMessage);
var
  Merchant:TMerchant;
begin
  try
    if m_boDealing then exit;
    Merchant:=UserEngine.FindMerchant(TObject(ProcessMsg.nParam1));
    if (Merchant = nil) or
     (not Merchant.m_bobuy) or
     (Merchant.m_PEnvir <> m_PEnvir) or
     (abs(Merchant.m_nCurrX - m_nCurrX) > 15) or
     (abs(Merchant.m_nCurrY - m_nCurrY) > 15) then exit;
      Merchant.ClientBuyGT(self,ProcessMsg.nParam2);

  except
  on e: Exception do begin
    MainOutMessage('TUserHumah.ClientBuyGT wIdent = ' + IntToStr(ProcessMsg.wIdent));
    MainOutMessage(E.Message);
  end;
  end;
end;

procedure TPlayObject.ClientBuyDecoItem(ProcessMsg: pTProcessMessage);
var
  Merchant:TMerchant;
begin
  try
    if m_boDealing then exit;
    Merchant:=UserEngine.FindMerchant(TObject(ProcessMsg.nParam1));
    if (Merchant = nil) or
     (not Merchant.m_bobuy) or
     (Merchant.m_PEnvir <> m_PEnvir) or
     (abs(Merchant.m_nCurrX - m_nCurrX) > 15) or
     (abs(Merchant.m_nCurrY - m_nCurrY) > 15) then exit;
      Merchant.ClientBuyDecoItem(self,ProcessMsg.nParam2);

  except
  on e: Exception do begin
    MainOutMessage('TUserHumah.ClientBuyDecoItem wIdent = ' + IntToStr(ProcessMsg.wIdent));
    MainOutMessage(E.Message);
  end;
  end;
end;

procedure TPlayObject.ClientRequestBBSMsg(ProcessMsg: pTProcessMessage);
var
  Merchant:TMerchant;
begin
  try
    if m_boDealing then exit;
    Merchant:=UserEngine.FindMerchant(TObject(ProcessMsg.nParam1));
    if (Merchant = nil) or
     (not Merchant.m_bobuy) or
     (Merchant.m_PEnvir <> m_PEnvir) or
     (abs(Merchant.m_nCurrX - m_nCurrX) > 15) or
     (abs(Merchant.m_nCurrY - m_nCurrY) > 15) then exit;
      Merchant.ClientRequestBBSMsg(self,ProcessMsg.nParam2);

  except
  on e: Exception do begin
    MainOutMessage('TUserHumah.ClientRequestBBSMsg wIdent = ' + IntToStr(ProcessMsg.wIdent));
    MainOutMessage(E.Message);
  end;
  end;
end;

procedure TPlayObject.ClientPostBBSMsg(ProcessMsg: pTProcessMessage;Body:String);
var
  Merchant:TMerchant;
  boSticky:boolean;
  msg,str:string;
  count:integer;
begin
  try
    if m_boDealing then exit;
    if Body = '' then exit;
    Body := DecodeString(Body);
    if Length(Body) > 255 then begin
      SendMsg(Self,RM_MENU_OK,0,Integer(Self),0,0,'Messages can not be longer then 255 chars');
      exit;
    end;
    msg := body;
    count := 0;
    while (msg <> '' ) and (count < 9) do begin
      msg:=GetValidStr3 (msg, str,[#13]);
      inc(count);
    end;
    if count > 8 then begin
      SendMsg(Self,RM_MENU_OK,0,Integer(Self),0,0,'Messages can not be longer then 8 lines');
      exit;
    end;
    Body:=StringReplace(Body,#039,'a',[rfReplaceAll]);
    boSticky:=False;
    if ProcessMsg.nParam2 = 1 then
      boSticky:=True;
    Merchant:=UserEngine.FindMerchant(TObject(ProcessMsg.nParam1));
    if (Merchant = nil) or
     (not Merchant.m_bobuy) or
     (Merchant.m_PEnvir <> m_PEnvir) or
     (abs(Merchant.m_nCurrX - m_nCurrX) > 15) or
     (abs(Merchant.m_nCurrY - m_nCurrY) > 15) then exit;
      Merchant.ClientPostBBSMsg(self,Body,boSticky, makeWord(ProcessMsg.nParam3,ProcessMsg.wParam));

  except
  on e: Exception do begin
    MainOutMessage('TUserHumah.ClientPostBBSMsg wIdent = ' + IntToStr(ProcessMsg.wIdent));
    MainOutMessage(E.Message);
  end;
  end;
end;

procedure TPlayObject.ClientDeleteBBSMsg(ProcessMsg: pTProcessMessage);
var
  Merchant:TMerchant;
begin
  try
    if m_boDealing then exit;
    Merchant:=UserEngine.FindMerchant(TObject(ProcessMsg.nParam1));
    if (Merchant = nil) or
     (not Merchant.m_bobuy) or
     (Merchant.m_PEnvir <> m_PEnvir) or
     (abs(Merchant.m_nCurrX - m_nCurrX) > 15) or
     (abs(Merchant.m_nCurrY - m_nCurrY) > 15) then exit;
      Merchant.ClientDeleteBBSMsg(self,ProcessMsg.nParam2);

  except
  on e: Exception do begin
    MainOutMessage('TUserHumah.ClientRequestBBSMsg wIdent = ' + IntToStr(ProcessMsg.wIdent));
    MainOutMessage(E.Message);
  end;
  end;
end;

procedure TPlayObject.ClientOpenShop(nParam1:integer;sData:String);
begin
//
end;

procedure TPlayObject.ClientRequestGameShopList;
var
  nPrice,nlooks: Integer;
  PlayObject:TPlayObject;
  PageCount:byte;
  sSendMsg,sName:String;
  i,Count:integer;
  ItemShopItem:TItemShopItem;
  ClientItem:TClientItem;
  MsgList:TList;
  TotalCount:integer;
begin
  sSendMsg:='';
  count:=0;
  TotalCount:=0;
  MsgList:=FrmDB.LoadGameShopItemList(PageCount);
  if MsgList.Count > 0 then begin
    for i:= 0 to MsgList.Count -1 do begin
      if (I < PageCount * 8) or (I > (PageCount + 1) * 8) then
        continue;

    sName:= pTItemShopItem(g_GameShopItemList[i]).Name;
    nPrice:= pTItemShopItem(g_GameShopItemList[i]).Price;
    nlooks:=ClientItem.S.Looks;
    sSendMsg:=sSendMsg + sName + '/' + IntToStr(nPrice) + '/' + IntToStr(nlooks) + '/';
    //sSendMsg:=sSendMsg + EncodeBuffer(@ItemShopItem,SizeOf(ItemShopItem)) + '/';
    inc(Count);
    //if Count = 8 then break;
    end;
    end;
    PlayObject.SendMsg(Self,RM_SENGGAMESHOPITEMS,0,Integer(Self),Count,0,sSendMsg);
    PlayObject.SendSocket(@PlayObject.m_DefMsg,sSendMsg);

    {TotalCount:=MsgList.count div 10;
    PlayObject.m_DefMsg:=MakeDefaultMsg(SM_SENGGAMESHOPITEMS,Integer(Self),PageCount,Count,TotalCount);
    PlayObject.SendSocket(@PlayObject.m_DefMsg,sSendMsg);
  end else begin
    PlayObject.m_DefMsg:=MakeDefaultMsg(SM_SENGGAMESHOPITEMS,Integer(Self),PageCount,0,TotalCount);
    PlayObject.SendSocket(@PlayObject.m_DefMsg,sSendMsg);
  end;
  for i:=0  to MsgList.Count -1 do begin
    dispose(MsgList[i]);
  end;
  MsgList.Free; }
end;

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: ObjBase.pas 596 2007-04-11 00:14:13Z sean $');
end.

