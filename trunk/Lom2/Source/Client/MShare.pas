unit MShare;

interface
uses
  svn, Windows, Classes, SysUtils, cliutil, Forms, DXDraws, DWinCtl,
  WIL, Actor, Grobal2, SDK, DXSounds, IniFiles, Share; 

type
  TTimerCommand = (tcSoftClose, tcReSelConnect, tcFastQueryChr, tcQueryItemPrice);
  TChrAction = (caWalk, caRun, caHorseRun, caHit, caSpell, caSitdown);
  TConnectionStep = (cnsLogin, cnsSelChr, cnsReSelChr, cnsPlay);
  TMovingItem = record
    Index: integer;
    Item: TClientItem;
  end;
  TPowerBlock = array[0..100-1] of Word;
  pTMovingItem = ^TMovingItem;
  TItemType = (i_HPDurg,i_MPDurg,i_HPMPDurg,i_OtherDurg,i_Weapon,i_Dress,i_Helmet,i_Necklace,i_Armring,i_Ring,i_Belt,i_Boots,i_Charm,i_Book,i_PosionDurg,i_UseItem,i_Scroll,i_Stone,i_Gold,i_Other);
  TShowItem = record
    sItemName    :String;
    ItemType     :TItemType;
    boAutoPickup :Boolean;
    boShowName   :Boolean;
    nFColor      :Integer;
    nBColor      :Integer;
  end;
  pTShowItem = ^TShowItem;
  TControlInfo = record
    Image       :Integer;
    Left        :Integer;
    Top         :Integer;
    Width       :Integer;
    Height      :Integer;
    Obj         :TDControl;
  end;
  pTControlInfo = ^TControlInfo;
  TConfig = record
    DMsgDlg       :TControlInfo;
    DMsgDlgOk     :TControlInfo;
    DMsgDlgYes    :TControlInfo;
    DMsgDlgCancel :TControlInfo;
    DMsgDlgNo     :TControlInfo;
    DLogIn        :TControlInfo;
    DLoginNew     :TControlInfo;
    DLoginOk      :TControlInfo;
    DLoginChgPw   :TControlInfo;
    DLoginClose   :TControlInfo;
    DSelServerDlg :TControlInfo;
    DSSrvClose    :TControlInfo;
    DSServer1     :TControlInfo;
    DSServer2     :TControlInfo;
    DSServer3     :TControlInfo;
    DSServer4     :TControlInfo;
    DSServer5     :TControlInfo;
    DSServer6     :TControlInfo;
    DSServer7     :TControlInfo;
    DSServer8     :TControlInfo;
    DNewAccount   :TControlInfo;
    DNewAccountOk :TControlInfo;
    DNewAccountCancel :TControlInfo;
    DNewAccountClose  :TControlInfo;
    DChgPw        :TControlInfo;
    DChgpwOk      :TControlInfo;
    DChgpwCancel  :TControlInfo;
    DSelectChr    :TControlInfo;
    DBottom       :TControlInfo;
    DMyState      :TControlInfo;
    DMyBag        :TControlInfo;
    DMyMagic      :TControlInfo;
    DOption       :TControlInfo;
    DBotMiniMap   :TControlInfo;
    DBotTrade     :TControlInfo;
    DBotGuild     :TControlInfo;
    DBotGroup     :TControlInfo;
    DBotFriend    :TControlInfo;
    DBotLover     :TControlInfo;
    DBotLogout    :TControlInfo;    
    DBotExit      :TControlInfo;
    DBotPlusAbil  :TControlInfo;
    DBotMemo      :TControlInfo;
    DBelt1        :TControlInfo;
    DBelt2        :TControlInfo;
    DBelt3        :TControlInfo;
    DBelt4        :TControlInfo;
    DBelt5        :TControlInfo;
    DBelt6        :TControlInfo;
    DGold         :TControlInfo;
    DRepairItem   :TControlInfo;
    DClosebag     :TControlInfo;
    DMerchantDlg  :TControlInfo;
    DMerchantDlgClose :TControlInfo;
    DConfigDlg        :TControlInfo;
    DConfigDlgOk      :TControlInfo;
    DConfigDlgClose   :TControlInfo;
    DMenuDlg          :TControlInfo;
    DMenuPrev         :TControlInfo;
    DMenuNext         :TControlInfo;
    DMenuBuy          :TControlInfo;
    DMenuClose        :TControlInfo;
    DSellDlg          :TControlInfo;
    DSellDlgOk        :TControlInfo;
    DHold             :TControlInfo;
    DSellDlgClose     :TControlInfo;
    DSellDlgSpot      :TControlInfo;
    DKeySelDlg        :TControlInfo;
    DKsIcon           :TControlInfo;
    DKsF1             :TControlInfo;
    DKsF2             :TControlInfo;
    DKsF3             :TControlInfo;
    DKsF4             :TControlInfo;
    DKsF5             :TControlInfo;
    DKsF6             :TControlInfo;
    DKsF7             :TControlInfo;
    DKsF8             :TControlInfo;
    DKsConF1          :TControlInfo;
    DKsConF2          :TControlInfo;
    DKsConF3          :TControlInfo;
    DKsConF4          :TControlInfo;
    DKsConF5          :TControlInfo;
    DKsConF6          :TControlInfo;
    DKsConF7          :TControlInfo;
    DKsConF8          :TControlInfo;
    DKsNone           :TControlInfo;
    DKsOk             :TControlInfo;
    DChgGamePwd       :TControlInfo;
    DChgGamePwdClose  :TControlInfo;
    DItemGrid         :TControlInfo;
    DScrollTop        :TControlInfo;
    DScrollUp         :TControlInfo;
    DScrollDown       :TControlInfo;
    DScrollBottom     :TControlInfo;
    DBotItemShop      :TControlInfo;
    DItemShopJobAll   :TControlInfo;
    DItemShopJobWarrior:TControlInfo;
    DItemShopJobWizard:TControlInfo;
    DItemShopJobMonk  :TControlInfo;
    DItemShopJobCommon:TControlInfo;
    DGrpPgUp          :TControlInfo;
    DGrpPgDn          :TControlInfo;
    DItemShopFind     :TControlInfo;
    DItemShopCaNew     :TControlInfo;
    DItemShopCaAll     :TControlInfo;
    DItemShopCaWeapon     :TControlInfo;
    DItemShopCaArmor     :TControlInfo;
    DItemShopCaAcc     :TControlInfo;
    DItemShopCasSubitem     :TControlInfo;
    DItemShopCaOther     :TControlInfo;
    DItemShopCaPackage     :TControlInfo;
    DItemShopCaSub1     :TControlInfo;
    DItemShopCaSub2     :TControlInfo;
    DItemShopCaSub3     :TControlInfo;
    DItemShopCaSub4     :TControlInfo;
    DItemShopCaSub5     :TControlInfo;
    DItemShopCaSub6     :TControlInfo;
    DItemShopCaSub7     :TControlInfo;
    DItemShopGetGift     :TControlInfo;
    DItemShopAddFav     :TControlInfo;
    DItemShopBye     :TControlInfo;
    DItemShopGift     :TControlInfo;
    DItemShopPayMoney     :TControlInfo;
    DItemShopWear     :TControlInfo;
    DItemShopWearLturn     :TControlInfo;
    DItemShopWearChange     :TControlInfo;
    DItemShopWearRturn     :TControlInfo;
    DItemShopListPrev     :TControlInfo;
    DItemShopListNext     :TControlInfo;
    DShopScrollBarUp     :TControlInfo;
    DShopScrollBarDown     :TControlInfo;
    DShopScrollBar     :TControlInfo;
    DItemShopCaFav     :TControlInfo;
    DItemShopInPackBack     :TControlInfo;
    DItemShopCashRefresh     :TControlInfo;
    DItemShopPackSub1     :TControlInfo;
    DItemShopPackSub2     :TControlInfo;
    DItemShopPackSub3     :TControlInfo;
    DItemShopPackSub4     :TControlInfo;
    DItemShopPackSub5     :TControlInfo;
    DItemShopPackSub6     :TControlInfo;
    DItemShopPackSub7     :TControlInfo;
    DItemShopPackSub8     :TControlInfo;
    DItemShopFavDel1     :TControlInfo;
    DItemShopFavDel2     :TControlInfo;
    DItemShopFavDel3     :TControlInfo;
    DItemShopFavDel4     :TControlInfo;
    DItemShopFavDel5     :TControlInfo;
    DItemShopFavDel6     :TControlInfo;
    DItemShopFavDel7     :TControlInfo;
    DItemShopFavDel8     :TControlInfo;
    DItemShopPriceUp     :TControlInfo;
    DItemShopPriceDn     :TControlInfo;
    DItemShopCheckSort     :TControlInfo;
  end;

  pTItemEffect = ^TItemEffect;
  TItemEffect = record
    Idx: integer;
    n_CurrentFrame: integer;
    n_StartFrame: integer;
    n_EndFrame: integer;
    n_NextFrame: integer;
    n_LastFrame: longword;
  end;

// Ignore  
//  TMonImg = record
//    Img: TWMImages;
//  end;

var
//  MonImg            :Array[0..100] of TMonImg;
  g_sLogoText       :String = 'wf>QKZtS=Ap[icP';
  g_sGoldName       :String = '金币';
  g_sGameGoldName   :String = 'GameGold';
  g_sGamePointName  :String = 'GamePoint';
  g_sWarriorName    :String = '战士';    //职业名称
  g_sWizardName     :String = '法师';  //职业名称
  g_sTaoistName     :String = '道士';    //职业名称
  g_sUnKnowName     :String = '未知';

  g_sMainParam1     :String; //读取设置参数
  g_sMainParam2     :String; //读取设置参数
  g_sMainParam3     :String; //读取设置参数
  g_sMainParam4     :String; //读取设置参数
  g_sMainParam5     :String; //读取设置参数
  g_sMainParam6     :String; //读取设置参数
//攻击模式设置
  g_AttackModeOfAll            :String = '[全体]';
  g_AttackModeOfPeaceful       :String = '[和平]';
  g_AttackModeOfDear           :String = '[夫妻]';
  g_AttackModeOfMaster         :String = '[主人]';
  g_AttackModeOfGroup          :String = '[编组]';
  g_AttackModeOfGuild          :String = '[公会]';
  g_AttackModeOfRedWhite       :String = '[善恶]';

  g_DXDraw           :TDXDraw;
  g_DWinMan          :TDWinManager;
  g_DXSound          :TDXSound;
  g_Sound            :TSoundEngine;

  g_WMainImages      :TWMImages;
  g_WMain2Images     :TWMImages;
  g_WMain3Images     :TWMImages;
  g_WChrSelImages    :TWMImages;
  g_WMMapImages      :TWMImages;
  g_WTilesImages     :TWMImages;
  g_WSmTilesImages   :TWMImages;
  g_WHumWingImages   :TWMImages;
  g_WBagItemImages   :TWMImages;
  g_WStateItemImages :TWMImages;
  g_WDnItemImages    :TWMImages;
  g_WHumImgImages    :TWMImages;
  g_WHum2ImgImages   :TWMImages;
  g_WHairImgImages   :TWMImages;
  g_WHorseImgImages  :TWMImages;
  g_WHelmetImgImages :TWMImages;
  g_WTransFormImages :TWMImages;
  g_WWeaponImages    :TWMImages;
  g_WMagIconImages   :TWMImages;
  g_WNpcImgImages    :TWMImages;
  g_WMagicImages     :TWMImages;
  g_WMagic2Images    :TWMImages;
  g_WMagic3Images    :TWMImages;
  g_WMagic4Images    :TWMImages;
  g_WDecoImages      :TWMImages;
  g_WEventEffectImages:TWMImages;
  g_WObjectArr       :array[0..12] of TWMImages;
  g_WMonImagesArr    :array[0..9999] of TWMImages;
//  g_WWeaponImages    :array of TWMImages;

  g_PowerBlock:TPowerBlock = (   //10
	$55, $8B, $EC, $83, $C4, $E8, $89, $55, $F8, $89, $45, $FC, $C7, $45, $EC, $E8,
	$03, $00, $00, $C7, $45, $E8, $64, $00, $00, $00, $DB, $45, $EC, $DB, $45, $E8,
	$DE, $F9, $DB, $45, $FC, $DE, $C9, $DD, $5D, $F0, $9B, $8B, $45, $F8, $8B, $00,
	$8B, $55, $F8, $89, $02, $DD, $45, $F0, $8B, $E5, $5D, $C3,
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
	$00, $00, $00, $00, $00, $00, $00, $00
   );
  g_PowerBlock1:TPowerBlock = (
	$55, $8B, $EC, $83, $C4, $E8, $89, $55, $F8, $89, $45, $FC, $C7, $45, $EC, $64,
	$00, $00, $00, $C7, $45, $E8, $64, $00, $00, $00, $DB, $45, $EC, $DB, $45, $E8,
	$DE, $F9, $DB, $45, $FC, $DE, $C9, $DD, $5D, $F0, $9B, $8B, $45, $F8, $8B, $00,
	$8B, $55, $F8, $89, $02, $DD, $45, $F0, $8B, $E5, $5D, $C3,
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
	$00, $00, $00, $00, $00, $00, $00, $00
   );
  g_RegInfo          :TRegInfo;
  g_nThisCRC         :Integer;
  g_sServerName      :String; //服务器显示名称
  g_sServerMiniName  :String; //服务器名称
  g_sServerAddr      :String = '127.0.0.1';
  g_nServerPort      :Integer = 7000;

  g_sSelectServerAddr:String = '127.0.0.1';
  g_nSelectServerPort:Integer = 7100;
  g_sGameServerAddr  :String = '127.0.0.1';
  g_nGameServerPort  :Integer = 7200;

  g_nTopDrawPos      :Integer = 0;
  g_nLeftDrawPos     :Integer = 0;

  g_sSelChrAddr      :String;
  g_nSelChrPort      :Integer;
  g_sRunServerAddr   :String;
  g_nRunServerPort   :Integer;

  g_boSendLogin      :Boolean; //是否发送登录消息
  g_boServerConnected:Boolean;
  g_SoftClosed       :Boolean; //小退游戏
  g_ChrAction        :TChrAction;
  g_ConnectionStep   :TConnectionStep;

  g_boSound          :Boolean; //开启声音
  g_boBGSound        :Boolean; //开启背景音乐

  g_boSkillSetting   :Boolean;
  g_boSkillBarNum    :Boolean;
  g_boShowSkillBar   :Boolean;
  g_boEffect         :Boolean = False;
  g_boNameAllView    :Boolean = False;
  g_boHPView         :Boolean = True;

  g_FontArr          :array[0..MAXFONT-1] of string = (
                     '宋体',
                     '新宋体',
                     '仿宋',
                     '楷体',
                     'Courier New',
                     'Arial',
                     'MS Sans Serif',
                     'Microsoft Sans Serif'
                     );

  g_nCurFont         :Integer = 0;
  g_sCurFontName     :String = '新宋体';
  g_boFullScreen     :Boolean = True;
  g_boDisableFlip    :Boolean = False;
  g_boWindowTest     :Boolean = False;  

  g_boForceAddr      :Boolean = False;

  g_boAutoLogin      :Boolean = False;
  g_boAutoServer     :Boolean = False;
  g_sAutoID          :String = 'username';
  g_sAutoPass        :String = 'password';
  g_sAutoServerName  :String = '龙之传奇';

  g_ImgMixSurface    :TDirectDrawSurface;
  g_MiniMapSurface   :TDirectDrawSurface;
  g_MapSurface       :TDirectDrawSurface;

  g_boFirstTime      :Boolean;
  g_sMapTitle        :String;
  g_nMapMusic        :Integer;

  g_ServerList           :TStringList;
  g_MagicList            :TList;
  g_GroupMembers         :TStringList;
  g_SaveItemList         :TList;
  g_MenuItemList         :TList;
  g_DropedItemList       :TList;
  g_ChangeFaceReadyList  :TList;
  g_FreeActorList        :TList;
  g_SoundList            :TStringList;
  g_nAttatckMode         :Integer;
  g_nBonusPoint          :Integer;
  g_nSaveBonusPoint      :Integer;
  g_BonusTick            :TNakedAbility;
  g_BonusAbil            :TNakedAbility;
  g_NakedAbil            :TNakedAbility;
  g_BonusAbilChg         :TNakedAbility;

  g_sGuildName           :String;
  g_sGuildRankName       :String;

  g_dwLastAttackTick     :LongWord;
  g_dwLastMoveTick       :LongWord;
  g_dwLatestStruckTick   :LongWord;
  g_dwLatestSpellTick    :LongWord;
  g_dwLatestFireHitTick  :LongWord;
  g_dwLatestRushRushTick :LongWord;
  g_dwLatestHitTick      :LongWord;
  g_dwLatestMagicTick    :LongWord;

  g_dwMagicDelayTime     :LongWord;
  g_dwMagicPKDelayTime   :LongWord;

  g_nMouseCurrX          :Integer;
  g_nMouseCurrY          :Integer;
  g_nMouseX              :Integer;
  g_nMouseY              :Integer;

  g_nTargetX             :Integer;
  g_nTargetY             :Integer;
  g_TargetCret           :TActor;
  g_FocusCret            :TActor;
  g_MagicTarget          :TActor;

  g_boAttackSlow         :Boolean;
  g_boMoveSlow           :Boolean;
  g_boFrozen            :Boolean;   //true if frostrcrunch turned self purple
  g_nMoveSlowLevel       :Integer;
  g_boMapMoving          :Boolean;
  g_boMapMovingWait         :Boolean;
  g_boCheckBadMapMode       :Boolean;
  g_boCheckSpeedHackDisplay :Boolean;
  g_boShowGreenHint         :Boolean;
  g_boShowWhiteHint         :Boolean;
  g_boViewMiniMap           :Boolean;
  g_nViewMinMapLv           :Integer;
  g_nMiniMapIndex           :Integer;

  g_boViewMap           :Boolean;
  g_nViewMapLv           :Integer;
  g_nMapIndex           :Integer;

  //NPC
  g_nCurMerchant            :Integer;
  g_nMDlgX                  :Integer;
  g_nMDlgY                  :Integer;
  g_dwChangeGroupModeTick   :LongWord;
  g_dwDealActionTick        :LongWord;
  g_dwQueryMsgTick          :LongWord;
  g_nDupSelection           :Integer;
  g_dwRefineActionTick      :LongWord;

  g_boAllowGroup            :Boolean;

  //人物信息相关
  g_nMySpeedPoint           :Integer; //敏捷
  g_nMyHitPoint             :Integer; //准确
  g_nMyAntiPoison           :Integer; //魔法躲避
  g_nMyPoisonRecover        :Integer; //中毒恢复
  g_nMyHealthRecover        :Integer; //体力恢复
  g_nMySpellRecover         :Integer; //魔法恢复
  g_nMyAntiMagic            :Integer; //魔法躲避
  g_nMyHungryState          :Integer; //饥饿状态

  g_wAvailIDDay             :Word;
  g_wAvailIDHour            :Word;
  g_wAvailIPDay             :Word;
  g_wAvailIPHour            :Word;

  g_MySelf                  :THumActor;
  g_MyDrawActor             :THumActor; //未用
  g_UseItems                :array[0..12] of TClientItem;
  g_ItemArr                 :array[0..MAXBAGITEMCL-1] of TClientItem;
  g_StoreItem               :array[0..MAXSTORAGEITEMCL-1] of TClientItem;

  g_BankItem                :array[0..2] of TClientItem;

  g_RefineItems             :array[0..15] of TClientItem;

  g_boRefineEnd             :Boolean;

  g_boBagLoaded             :Boolean;
  g_boStoreLoaded           :Boolean;
  g_boServerChanging        :Boolean;

  g_AuctionItems            :array[0..9] of TAuctionItem;
  g_AuctionCurrPage         :Integer;
  g_AuctionAmountofPages    :Integer;
  g_AuctionCurrSection      :Integer;

  //商城相关
  g_ItemShopItems            :array[0..7] of TItemShopItem;
  g_ItemShopCurrPage         :Integer;
  g_ItemShopTotalPage        :integer;
  g_ItemShopAmountofPages    :Integer;
  g_ItemShopCurrSection      :Integer;
  //gt
  g_GTItems                 :array[0..9] of TClientGT;
  g_DecoItems               :array[0..12] of TDecoItem;
  g_BBSMsgList              :array[0..9] of TBBSMSG;
  g_GTCurrPage              :integer;
  g_GTTotalPage             :integer;
  g_GTAmountOnPage          :integer;
  g_DecoList                :TList;
  g_BBSMSG                  :String;
  g_BBSPoster               :String;
  g_MasterPost              :integer;
  //end of gt

  //键盘相关
  g_ToolMenuHook            :HHOOK;
  g_nLastHookKey            :Integer;
  g_dwLastHookKeyTime       :LongWord;

  g_nCaptureSerial          :Integer; //抓图文件名序号
  g_nSendCount              :Integer; //发送操作计数
  g_nReceiveCount           :Integer; //接改操作状态计数
  g_nTestSendCount          :Integer;
  g_nTestReceiveCount       :Integer;
  g_nSpellCount             :Integer; //使用魔法计数
  g_nSpellFailCount         :Integer; //使用魔法失败计数
  g_nFireCount              :Integer; //
  g_nDebugCount             :Integer;
  g_nDebugCount1            :Integer;
  g_nDebugCount2            :Integer;

  //买卖相关
  g_SellDlgItem             :TClientItem;
  g_SellDlgItemSellWait     :TClientItem;
  g_DealDlgItem             :TClientItem;

  g_boQueryPrice            :Boolean;
  g_boQuickSell             :Boolean;
  g_dwQueryPriceTime        :LongWord;
  g_sSellPriceStr           :String;

  g_RefineDlgItem           :TClientItem;

  //Gemming system
  g_GemItem1             :TClientItem;
  g_GemItem2             :TClientItem;
  g_GemItem3             :TClientItem;
  g_GemItem4             :TClientItem;
  g_GemItem5             :TClientItem;
  g_GemItem6             :TClientItem;

  g_GemItem1s             :TClientItem;
  g_GemItem2s             :TClientItem;
  g_GemItem3s             :TClientItem;
  g_GemItem4s             :TClientItem;
  g_GemItem5s             :TClientItem;
  g_GemItem6s             :TClientItem;

  g_LoverName             :String[ActorNameLen];
  g_StartDate             :TDateTime;
  g_TotalDays             :Integer;
  
  //交易相关
  g_DealItems               :array[0..9] of TClientItem;
  g_DealRemoteItems         :array[0..19] of TClientItem;
  g_nDealGold               :Integer;
  g_nDealRemoteGold         :Integer;
  g_boDealEnd               :Boolean;
  g_sDealWho                :String;  //交易对方名字
  g_MouseItem               :TClientItem;
  g_MouseStateItem          :TClientItem;
  g_MouseUserStateItem      :TClientItem;
//  g_MouseShopItem           :TClientItem;

  g_boBagToStore            :Boolean;
  g_boStoreToBag            :Boolean;

  g_boItemMoving            :Boolean;  //正在移动物品
  g_MovingItem              :TMovingItem;
  g_WaitingUseItem          :TMovingItem;
  g_FocusItem               :pTDropItem;
  g_ItemEffects             :TList;

  g_boViewFog               :Boolean;  //是否显示黑暗
  g_boForceNotViewFog       :Boolean = TRUE;  //免蜡烛
  g_nDayBright              :Integer;
  g_nAreaStateValue         :Integer;  //显示当前所在地图状态(攻城区域、)

  g_boNoDarkness            :Boolean;
  g_nRunReadyCount          :Integer; //助跑就绪次数，在跑前必须走几步助跑

  g_EatingItem              :TClientItem;
  g_dwEatTime               :LongWord; //timeout...

  g_dwDizzyDelayStart       :LongWord;
  g_dwDizzyDelayTime        :LongWord;

  g_boDoFadeOut             :Boolean;
  g_boDoFadeIn              :Boolean;
  g_nFadeIndex              :Integer;
  g_boDoFastFadeOut         :Boolean;

  g_LoverNameClient         :String;
  g_LoverNameState          :String;

  g_boAutoDig               :Boolean;  //自动锄矿
  g_boSelectMyself          :Boolean;  //鼠标是否指到自己

  //游戏速度检测相关变量
  g_dwFirstServerTime       :LongWord;
  g_dwFirstClientTime       :LongWord;
  //ServerTimeGap: int64;
  g_nTimeFakeDetectCount    :Integer;
  g_dwSHGetTime             :LongWord;
  g_dwSHTimerTime           :LongWord;
  g_nSHFakeCount            :Integer;   //检查机器速度异常次数，如果超过4次则提示速度不稳定

  g_dwLatestClientTime2     :LongWord;
  g_dwFirstClientTimerTime  :LongWord; //timer
  g_dwLatestClientTimerTime :LongWord;
  g_dwFirstClientGetTime    :LongWord; //gettickcount
  g_dwLatestClientGetTime   :LongWord;
  g_nTimeFakeDetectSum      :Integer;
  g_nTimeFakeDetectTimer    :Integer;

  g_dwLastestClientGetTime  :LongWord;

//外挂功能变量开始
  g_dwDropItemFlashTime  :LongWord = 5 * 1000; //地面物品闪时间间隔
  g_nHitTime             :Integer  = 1400;  //攻击间隔时间间隔
  g_nItemSpeed           :Integer  = 60;
  g_dwSpellTime          :LongWord = 500;  //魔法攻间隔时间

  g_DeathColorEffect     :TColorEffect = ceGrayScale;
  g_boClientCanSet       :Boolean  = True;
  g_boCanRunHuman        :Boolean  = False;
  g_boCanRunMon          :Boolean  = False;
  g_boCanRunNpc          :Boolean  = False;
  g_boCanRunAllInWarZone :Boolean  = False;
  g_boCanStartRun        :Boolean  = False; //是否允许免助跑
  g_boParalyCanRun       :Boolean  = False;//麻痹是否可以跑
  g_boParalyCanWalk      :Boolean  = False;//麻痹是否可以走
  g_boParalyCanHit       :Boolean  = False;//麻痹是否可以攻击
  g_boParalyCanSpell     :Boolean  = False;//麻痹是否可以魔法

  g_boShowRedHPLable     :Boolean  = True; //显示血条
  g_boShowHPNumber       :Boolean  = True; //显示血量数字
  g_boShowJobLevel       :Boolean  = True; //显示职业等级
  g_boDuraAlert          :Boolean  = True; //物品持久警告
  g_boMagicLock          :Boolean  = False; //魔法锁定
  g_boAutoPuckUpItem     :Boolean  = False;

  g_boShowHumanInfo      :Boolean  = True;
  g_boShowMonsterInfo    :Boolean  = False;
  g_boShowNpcInfo        :Boolean  = False;
//外挂功能变量结束
  g_dwAutoPickupTick     :LongWord;
  g_dwAutoPickupTime     :LongWord = 50; //自动捡物品间隔
  g_AutoPickupList       :TList;
  g_MagicLockActor       :TActor;
  g_boNextTimePowerHit   :Boolean;
  g_boCanLongHit         :Boolean;
  g_boCanWideHit         :Boolean;
  g_boCanCrsHit          :Boolean;
  g_boCanTwnHit          :Boolean;
  g_boCanStnHit          :Boolean;
  g_boCanAkcHit          :Boolean;
  g_boNextTimeFireHit    :Boolean;

  g_ShowItemList         :TGList;
  g_boShowAllItem        :Boolean = False;//显示地面所有物品名称

  g_boDrawTileMap        :Boolean = True;
  g_boDrawDropItem       :Boolean = True;

  g_boVerticalBelt       :Boolean = False;  

  // Mail
  g_boHasMail            :Boolean = False;
  g_boIsMinTimerTime     :Boolean = False; // Haxed MinTimer

  g_nTestX:Integer = 71;
  g_nTestY:Integer = 212;
  DlgConf        :TConfig = (
                            DScrollTop     :(Image:911;Left:586;Top:78;Width:0;Height:0);
                            DScrollUp      :(Image:912;Left:586;Top:89;Width:0;Height:0);
                            DScrollDown    :(Image:913;Left:586;Top:184;Width:0;Height:0);
                            DScrollBottom  :(Image:914;Left:586;Top:192;Width:0;Height:0);
                            DBotItemShop   :(Image:827;Left:628;Top:98;Width:0;Height:0);
                            DItemShopJobAll      :(Image:801;Left:149;Top:47;Width:0;Height:0);
                            DItemShopJobWarrior  :(Image:803;Left:183;Top:47;Width:0;Height:0);
                            DItemShopJobWizard   :(Image:805;Left:217;Top:47;Width:0;Height:0);
                            DItemShopJobMonk     :(Image:807;Left:251;Top:47;Width:0;Height:0);
                            DItemShopJobCommon   :(Image:809;Left:285;Top:47;Width:0;Height:0);
                            DGrpPgUp       :(Image:373;Left:265;Top:94;Width:0;Height:0);
                            DGrpPgDn       :(Image:372;Left:265;Top:153;Width:0;Height:0);
                            DItemShopFind   :(Image:781;Left:617;Top:45;Width:0;Height:0);

                            DItemShopCaNew   :(Image:790;Left:26;Top:78;Width:0;Height:0);
                            DItemShopCaAll   :(Image:790;Left:26;Top:99;Width:0;Height:0);
                            DItemShopCaWeapon   :(Image:790;Left:26;Top:120;Width:0;Height:0);
                            DItemShopCaArmor   :(Image:790;Left:26;Top:141;Width:0;Height:0);
                            DItemShopCaAcc   :(Image:790;Left:26;Top:162;Width:0;Height:0);
                            DItemShopCasSubitem   :(Image:790;Left:26;Top:183;Width:0;Height:0);
                            DItemShopCaOther   :(Image:790;Left:26;Top:225;Width:0;Height:0);
                            DItemShopCaPackage   :(Image:790;Left:26;Top:204;Width:0;Height:0);
                            DItemShopCaSub1   :(Image:817;Left:26;Top:246;Width:0;Height:0);
                            DItemShopCaSub2   :(Image:817;Left:26;Top:263;Width:0;Height:0);
                            DItemShopCaSub3   :(Image:817;Left:26;Top:280;Width:0;Height:0);
                            DItemShopCaSub4   :(Image:817;Left:26;Top:297;Width:0;Height:0);
                            DItemShopCaSub5   :(Image:817;Left:26;Top:314;Width:0;Height:0);
                            DItemShopCaSub6   :(Image:817;Left:26;Top:331;Width:0;Height:0);
                            DItemShopCaSub7   :(Image:817;Left:26;Top:348;Width:0;Height:0);
                            DItemShopGetGift   :(Image:768;Left:202;Top:430;Width:0;Height:0);
                            DItemShopAddFav   :(Image:831;Left:243;Top:430;Width:0;Height:0);
                            DItemShopBye   :(Image:787;Left:284;Top:430;Width:0;Height:0);
                            DItemShopGift   :(Image:789;Left:325;Top:430;Width:0;Height:0);
                            DItemShopPayMoney   :(Image:833;Left:366;Top:430;Width:0;Height:0);
                            DItemShopWear   :(Image:782;Left:539;Top:303;Width:0;Height:0);
                            DItemShopWearLturn   :(Image:784;Left:590;Top:305;Width:0;Height:0);
                            DItemShopWearChange   :(Image:783;Left:616;Top:304;Width:0;Height:0);
                            DItemShopWearRturn   :(Image:785;Left:641;Top:305;Width:0;Height:0);
                            DItemShopListPrev   :(Image:798;Left:345;Top:402;Width:0;Height:0);
                            DItemShopListNext   :(Image:799;Left:412;Top:402;Width:0;Height:0);
                            DShopScrollBarUp   :(Image:815;Left:122;Top:77;Width:0;Height:0);
                            DShopScrollBarDown   :(Image:816;Left:122;Top:403;Width:0;Height:0);
                            DShopScrollBar   :(Image:814;Left:122;Top:94;Width:0;Height:0);
                            DItemShopCaFav   :(Image:834;Left:26;Top:399;Width:0;Height:0);
                            DItemShopInPackBack   :(Image:796;Left:496;Top:78;Width:0;Height:0);
                            DItemShopCashRefresh   :(Image:810;Left:639;Top:435;Width:0;Height:0);
                            DItemShopPackSub1   :(Image:812;Left:216;Top:193;Width:0;Height:0);
                            DItemShopPackSub2   :(Image:812;Left:308;Top:193;Width:0;Height:0);
                            DItemShopPackSub3   :(Image:812;Left:400;Top:193;Width:0;Height:0);
                            DItemShopPackSub4   :(Image:812;Left:492;Top:193;Width:0;Height:0);
                            DItemShopPackSub5   :(Image:812;Left:216;Top:308;Width:0;Height:0);
                            DItemShopPackSub6   :(Image:812;Left:308;Top:308;Width:0;Height:0);
                            DItemShopPackSub7   :(Image:812;Left:400;Top:308;Width:0;Height:0);
                            DItemShopPackSub8   :(Image:812;Left:492;Top:308;Width:0;Height:0);
                            DItemShopFavDel1   :(Image:836;Left:152;Top:208;Width:0;Height:0);
                            DItemShopFavDel2   :(Image:836;Left:244;Top:208;Width:0;Height:0);
                            DItemShopFavDel3   :(Image:836;Left:336;Top:208;Width:0;Height:0);
                            DItemShopFavDel4   :(Image:836;Left:428;Top:208;Width:0;Height:0);
                            DItemShopFavDel5   :(Image:836;Left:152;Top:323;Width:0;Height:0);
                            DItemShopFavDel6   :(Image:836;Left:244;Top:323;Width:0;Height:0);
                            DItemShopFavDel7   :(Image:836;Left:336;Top:323;Width:0;Height:0);
                            DItemShopFavDel8   :(Image:836;Left:428;Top:323;Width:0;Height:0);
                            DItemShopPriceUp   :(Image:794;Left:374;Top:51;Width:0;Height:0);
                            DItemShopPriceDn   :(Image:792;Left:374;Top:51;Width:0;Height:0);
                            DItemShopCheckSort   :(Image:819;Left:354;Top:52;Width:0;Height:0);
                           );
  procedure InitObj();
  procedure LoadWMImagesLib(AOwner: TComponent);
  procedure InitWMImagesLib(DDxDraw: TDxDraw);
  procedure UnLoadWMImagesLib();
  function  GetObjs (nUnit,nIdx:Integer):TDirectDrawSurface;
  function  GetObjsEx (nUnit,nIdx:Integer; var px, py: integer): TDirectDrawSurface;
  function  GetMonImg (nAppr:Integer):TWMImages;
  function  GetMonAction (nAppr:Integer):pTMonsterAction;
  function  GetJobName (nJob:Integer):String;
  function  GetAttatckMode (m_btAttatckMode:Integer):String;
  procedure ClearShowItemList();
  function  GetItemType(ItemType:TItemType):String;
  function  GetShowItem(sItemName:String):pTShowItem;
  procedure LoadUserConfig(sUserName:String);
  procedure SaveUserConfig(sUserName:String);
  procedure SendClientMessage(msg, Recog, param, tag, series: integer; sMsg: String = '');
implementation
uses FState, HUtil32,clMain,EDCode;

procedure SendClientMessage(msg, Recog, param, tag, series: integer; sMsg: String = '');
var
   dmsg: TDefaultMessage;
begin
   dmsg := MakeDefaultMsg (msg, Recog, param, tag, series);
   if sMsg = '' then frmMain.SendSocket(EncodeMessage(dmsg))
   else frmMain.SendSocket(EncodeMessage(dmsg) + EncodeString(sMsg));
end;

procedure LoadWMImagesLib(AOwner: TComponent);
var
  I:Integer;
begin
  g_WMainImages        := TWMImages.Create(AOwner);
  g_WMain2Images       := TWMImages.Create(AOwner);
  g_WMain3Images       := TWMImages.Create(AOwner);
  g_WChrSelImages      := TWMImages.Create(AOwner);
  g_WMMapImages        := TWMImages.Create(AOwner);
  g_WTilesImages       := TWMImages.Create(AOwner);
  g_WSmTilesImages     := TWMImages.Create(AOwner);
  g_WHumWingImages     := TWMImages.Create(AOwner);
  g_WBagItemImages     := TWMImages.Create(AOwner);
  g_WStateItemImages   := TWMImages.Create(AOwner);
  g_WDnItemImages      := TWMImages.Create(AOwner);
  g_WHumImgImages      := TWMImages.Create(AOwner);
  g_WHum2ImgImages     := TWMImages.Create(AOwner);
  g_WHairImgImages     := TWMImages.Create(AOwner);
  g_WHorseImgImages    := TWMImages.Create(AOwner);
  g_WHelmetImgImages   := TWMImages.Create(AOwner);
  g_WTransFormImages   := TWMImages.Create(AOwner);
  g_WWeaponImages      := TWMImages.Create(AOwner);
  g_WMagIconImages     := TWMImages.Create(AOwner);
  g_WNpcImgImages      := TWMImages.Create(AOwner);
  g_WMagicImages       := TWMImages.Create(AOwner);
  g_WMagic2Images      := TWMImages.Create(AOwner);
  g_WMagic3Images      := TWMImages.Create(AOwner);
  g_WMagic4Images      := TWMImages.Create(AOwner);
  g_WDecoImages        := TWMImages.Create(AOwner);
{$IF CUSTOMLIBFILE = 1}  
  g_WEventEffectImages := TWMImages.Create(AOwner);
{$IFEND}
  FillChar(g_WObjectArr,SizeOf(g_WObjectArr),0);
  FillChar(g_WMonImagesArr,SizeOf(g_WMonImagesArr),0);
end;

procedure InitWMImagesLib(DDxDraw: TDxDraw);
var
  sFileName:String;
  I:Integer;
begin
  g_WMainImages.DxDraw    := DDxDraw;
  g_WMainImages.DDraw     := DDxDraw.DDraw;
  g_WMainImages.FileName  := MAINIMAGEFILE;
  g_WMainImages.LibType   := ltUseCache;
  g_WMainImages.Initialize;

  g_WMain2Images.DxDraw   := DDxDraw;
  g_WMain2Images.DDraw    := DDxDraw.DDraw;
  g_WMain2Images.FileName := MAINIMAGEFILE2;
  g_WMain2Images.LibType  := ltUseCache;
  g_WMain2Images.Initialize;

  g_WMain3Images.DxDraw   := DDxDraw;
  g_WMain3Images.DDraw    := DDxDraw.DDraw;
  g_WMain3Images.FileName := MAINIMAGEFILE3;
  g_WMain3Images.LibType  := ltUseCache;
  g_WMain3Images.Initialize;

  g_WChrSelImages.DxDraw   := DDxDraw;
  g_WChrSelImages.DDraw    := DDxDraw.DDraw;
  g_WChrSelImages.FileName := CHRSELIMAGEFILE;
  g_WChrSelImages.LibType  := ltUseCache;
  g_WChrSelImages.Initialize;

  g_WMMapImages.DxDraw     := DDxDraw;
  g_WMMapImages.DDraw      := DDxDraw.DDraw;
  g_WMMapImages.FileName   := MINMAPIMAGEFILE;
  g_WMMapImages.LibType    := ltUseCache;
  g_WMMapImages.Initialize;

  g_WTilesImages.DxDraw    := DDxDraw;
  g_WTilesImages.DDraw     := DDxDraw.DDraw;
  g_WTilesImages.FileName  := TITLESIMAGEFILE;
  g_WTilesImages.LibType   := ltUseCache;
  g_WTilesImages.Initialize;

  g_WSmTilesImages.DxDraw   := DDxDraw;
  g_WSmTilesImages.DDraw    := DDxDraw.DDraw;
  g_WSmTilesImages.FileName := SMLTITLESIMAGEFILE;
  g_WSmTilesImages.LibType  := ltUseCache;
  g_WSmTilesImages.Initialize;

  g_WHumWingImages.DxDraw   := DDxDraw;
  g_WHumWingImages.DDraw    := DDxDraw.DDraw;
  g_WHumWingImages.FileName := HUMWINGIMAGESFILE;
  g_WHumWingImages.LibType  := ltUseCache;
  g_WHumWingImages.Initialize;

  g_WBagItemImages.DxDraw   := DDxDraw;
  g_WBagItemImages.DDraw    := DDxDraw.DDraw;
  g_WBagItemImages.FileName := BAGITEMIMAGESFILE;
  g_WBagItemImages.LibType  := ltUseCache;
  g_WBagItemImages.Initialize;

  g_WStateItemImages.DxDraw   := DDxDraw;
  g_WStateItemImages.DDraw    := DDxDraw.DDraw;
  g_WStateItemImages.FileName := STATEITEMIMAGESFILE;
  g_WStateItemImages.LibType  := ltUseCache;
  g_WStateItemImages.Initialize;

  g_WDnItemImages.DxDraw:=DDxDraw;
  g_WDnItemImages.DDraw:=DDxDraw.DDraw;
  g_WDnItemImages.FileName:=DNITEMIMAGESFILE;
  g_WDnItemImages.LibType:=ltUseCache;
  g_WDnItemImages.Initialize;

  g_WHumImgImages.DxDraw:=DDxDraw;
  g_WHumImgImages.DDraw:=DDxDraw.DDraw;
  g_WHumImgImages.FileName:=HUMIMGIMAGESFILE;
  g_WHumImgImages.LibType:=ltUseCache;
  g_WHumImgImages.Initialize;

  g_WHum2ImgImages.DxDraw:=DDxDraw;
  g_WHum2ImgImages.DDraw:=DDxDraw.DDraw;
  g_WHum2ImgImages.FileName:=HUM2IMGIMAGESFILE;
  g_WHum2ImgImages.LibType:=ltUseCache;
  g_WHum2ImgImages.Initialize;

  g_WHairImgImages.DxDraw:=DDxDraw;
  g_WHairImgImages.DDraw:=DDxDraw.DDraw;
  g_WHairImgImages.FileName:=HAIRIMGIMAGESFILE;
  g_WHairImgImages.LibType:=ltUseCache;
  g_WHairImgImages.Initialize;

  g_WHorseImgImages.DxDraw:=DDxDraw;
  g_WHorseImgImages.DDraw:=DDxDraw.DDraw;
  g_WHorseImgImages.FileName:=HORSEIMAGEFILE;
  g_WHorseImgImages.LibType:=ltUseCache;
  g_WHorseImgImages.Initialize;

  g_WHelmetImgImages.DxDraw:=DDxDraw;
  g_WHelmetImgImages.DDraw:=DDxDraw.DDraw;
  g_WHelmetImgImages.FileName:=HELMETIMAGEFILE;
  g_WHelmetImgImages.LibType:=ltUseCache;
  g_WHelmetImgImages.Initialize;

  g_WTransFormImages.DxDraw:=DDxDraw;
  g_WTransFormImages.DDraw:=DDxDraw.DDraw;
  g_WTransFormImages.FileName:=TRANSFORMIMAGEFILE;
  g_WTransFormImages.LibType:=ltUseCache;
  g_WTransFormImages.Initialize;

  g_WWeaponImages.DxDraw:=DDxDraw;
  g_WWeaponImages.DDraw:=DDxDraw.DDraw;
  g_WWeaponImages.FileName:=WEAPONIMAGESFILE;
  g_WWeaponImages.LibType:=ltUseCache;
  g_WWeaponImages.Initialize;

  g_WMagIconImages.DxDraw:=DDxDraw;
  g_WMagIconImages.DDraw:=DDxDraw.DDraw;
  g_WMagIconImages.FileName:=MAGICONIMAGESFILE;
  g_WMagIconImages.LibType:=ltUseCache;
  g_WMagIconImages.Initialize;

  g_WNpcImgImages.DxDraw:=DDxDraw;
  g_WNpcImgImages.DDraw:=DDxDraw.DDraw;
  g_WNpcImgImages.FileName:=NPCIMAGESFILE;
  g_WNpcImgImages.LibType:=ltUseCache;
  g_WNpcImgImages.Initialize;

  g_WMagicImages.DxDraw:=DDxDraw;
  g_WMagicImages.DDraw:=DDxDraw.DDraw;
  g_WMagicImages.FileName:=MAGICIMAGESFILE;
  g_WMagicImages.LibType:=ltUseCache;
  g_WMagicImages.Initialize;

  g_WMagic2Images.DxDraw:=DDxDraw;
  g_WMagic2Images.DDraw:=DDxDraw.DDraw;
  g_WMagic2Images.FileName:=MAGIC2IMAGESFILE;
  g_WMagic2Images.LibType:=ltUseCache;
  g_WMagic2Images.Initialize;

  g_WMagic3Images.DxDraw:=DDxDraw;
  g_WMagic3Images.DDraw:=DDxDraw.DDraw;
  g_WMagic3Images.FileName:=MAGIC3IMAGESFILE;
  g_WMagic3Images.LibType:=ltUseCache;
  g_WMagic3Images.Initialize;

  g_WMagic4Images.DxDraw:=DDxDraw;
  g_WMagic4Images.DDraw:=DDxDraw.DDraw;
  g_WMagic4Images.FileName:=MAGIC4IMAGESFILE;
  g_WMagic4Images.LibType:=ltUseCache;
  g_WMagic4Images.Initialize;

  g_WDecoImages.DxDraw:=DDxDraw;
  g_WDecoImages.DDraw:=DDxDraw.DDraw;
  g_WDecoImages.FileName:=DECOIMAGEFILE;
  g_WDecoImages.LibType:=ltUseCache;
  g_WDecoImages.Initialize;
{$IF CUSTOMLIBFILE = 1}
  g_WEventEffectImages.DxDraw:=DDxDraw;
  g_WEventEffectImages.DDraw:=DDxDraw.DDraw;
  g_WEventEffectImages.FileName:=EVENTEFFECTIMAGESFILE;
  g_WEventEffectImages.LibType:=ltUseCache;
  g_WEventEffectImages.Initialize;
{$IFEND}

end;

procedure UnLoadWMImagesLib();
var
  I:Integer;
begin
  for I := Low(g_WObjectArr) to High(g_WObjectArr) do begin
    if g_WObjectArr[I] <> nil then begin
      g_WObjectArr[I].Finalize;
      g_WObjectArr[I].Free;
    end;
  end;
  for I := Low(g_WMonImagesArr) to High(g_WMonImagesArr) do begin
    if g_WMonImagesArr[I] <> nil then begin
      g_WMonImagesArr[I].Finalize;
      g_WMonImagesArr[I].Free;
    end;
  end;

  g_WMainImages.Finalize;
  g_WMainImages.Free;

  g_WMain2Images.Finalize;
  g_WMain2Images.Free;

  g_WMain3Images.Finalize;
  g_WMain3Images.Free;
  
  g_WChrSelImages.Finalize;
  g_WChrSelImages.Free;

  g_WMMapImages.Finalize;
  g_WMMapImages.Free;

  g_WTilesImages.Finalize;
  g_WTilesImages.Free;

  g_WSmTilesImages.Finalize;
  g_WSmTilesImages.Free;

  g_WHumWingImages.Finalize;
  g_WHumWingImages.Free;

  g_WBagItemImages.Finalize;
  g_WBagItemImages.Free;

  g_WStateItemImages.Finalize;
  g_WStateItemImages.Free;

  g_WDnItemImages.Finalize;
  g_WDnItemImages.Free;

  g_WHumImgImages.Finalize;
  g_WHumImgImages.Free;

  g_WHum2ImgImages.Finalize;
  g_WHum2ImgImages.Free;

  g_WHairImgImages.Finalize;
  g_WHairImgImages.Free;

  g_WHorseImgImages.Finalize;
  g_WHorseImgImages.Free;

  g_WHelmetImgImages.Finalize;
  g_WHelmetImgImages.Free;

  g_WTransFormImages.Finalize;
  g_WTransFormImages.Free;

  g_WWeaponImages.Finalize;
  g_WWeaponImages.Free;

  g_WMagIconImages.Finalize;
  g_WMagIconImages.Free;

  g_WNpcImgImages.Finalize;
  g_WNpcImgImages.Free;

  g_WMagicImages.Finalize;
  g_WMagicImages.Free;

  g_WMagic2Images.Finalize;;
  g_WMagic2Images.Free;
{$IF CUSTOMLIBFILE = 1}
  g_WEventEffectImages.Finalize;
  g_WEventEffectImages.Free;
{$IFEND}  
end;
//取地图图库
function GetObjs (nUnit,nIdx:Integer):TDirectDrawSurface;
var
  sFileName:String;
begin
  Result:=nil;
  if not (nUnit in [Low(g_WObjectArr) .. High(g_WObjectArr)]) then nUnit:=0;
  if g_WObjectArr[nUnit] = nil then begin
    if nUnit = 0 then sFileName:=OBJECTIMAGEFILE
    else sFileName:=format(OBJECTIMAGEFILE1,[nUnit+1]);
    if not FileExists(sFileName) then exit;
    g_WObjectArr[nUnit]:=TWMImages.Create(nil);
    g_WObjectArr[nUnit].DxDraw:=g_DxDraw;
    g_WObjectArr[nUnit].DDraw:=g_DxDraw.DDraw;
    g_WObjectArr[nUnit].FileName:=sFileName;
    g_WObjectArr[nUnit].LibType:=ltUseCache;
    g_WObjectArr[nUnit].Initialize;
  end;
  Result:=g_WObjectArr[nUnit].Images[nIdx];
end;
//取地图图库
function  GetObjsEx (nUnit,nIdx:Integer; var px, py: integer): TDirectDrawSurface;
var
  sFileName:String;
begin
  Result:=nil;
  if not (nUnit in [Low(g_WObjectArr) .. High(g_WObjectArr)]) then nUnit:=0;
  if g_WObjectArr[nUnit] = nil then begin

    if nUnit = 0 then sFileName:=OBJECTIMAGEFILE
    else sFileName:=format(OBJECTIMAGEFILE1,[nUnit+1]);

    if not FileExists(sFileName) then exit;
    g_WObjectArr[nUnit]:=TWMImages.Create(nil);
    g_WObjectArr[nUnit].DxDraw:=g_DxDraw;
    g_WObjectArr[nUnit].DDraw:=g_DxDraw.DDraw;
    g_WObjectArr[nUnit].FileName:=sFileName;
    g_WObjectArr[nUnit].LibType:=ltUseCache;
    g_WObjectArr[nUnit].Initialize;
  end;
  Result:=g_WObjectArr[nUnit].GetCachedImage(nIdx,px,py);
end;

function GetMonImg (nAppr:Integer):TWMImages;
var
  sFileName:String;
  nUnit:Integer;
begin
  Result:=nil;
  if nAppr < 1000 then nUnit:=nAppr div 10
  else nUnit:=nAppr;
  
  if (nUnit < Low(g_WMonImagesArr)) or (nUnit > High(g_WMonImagesArr)) then nUnit:=0;
  if g_WMonImagesArr[nUnit] = nil then begin

    sFileName:=format(MONIMAGEFILE,[nUnit+1]);
    if nUnit = 80 then sFileName:=DRAGONIMAGEFILE;
    if nUnit = 90 then sFileName:=EFFECTIMAGEFILE;
    if nUnit >= 1000 then sFileName:=format(MONIMAGEFILEEX,[nUnit]); //超过1000序号的怪物取新的怪物文件
                                  
    g_WMonImagesArr[nUnit]:=TWMImages.Create(nil);
    g_WMonImagesArr[nUnit].DxDraw:=g_DxDraw;
    g_WMonImagesArr[nUnit].DDraw:=g_DxDraw.DDraw;
    g_WMonImagesArr[nUnit].FileName:=sFileName;
    g_WMonImagesArr[nUnit].LibType:=ltUseCache;
    g_WMonImagesArr[nUnit].Initialize;
  end;
  Result:=g_WMonImagesArr[nUnit];
end;

function  GetMonAction (nAppr:Integer):pTMonsterAction;
var
  FileStream:TFileStream;
  sFileName:String;
  MonsterAction:TMonsterAction;
begin
  Result:=nil;
  sFileName:=format(MONPMFILE,[nAppr]);
  if FileExists (sFileName) then begin
    FileStream:=TFileStream.Create(sFileName,fmOpenRead or fmShareDenyNone);
    FileStream.Read (MonsterAction, SizeOf(MonsterAction));
    New(Result);
    Result^:=MonsterAction;
    FileStream.Free;
  end;
end;

//取得职业名称
//0 武士
//1 魔法师
//2 道士
function  GetJobName (nJob:Integer):String;
begin
  Result:= '';
  case nJob of
    0:Result:=g_sWarriorName;
    1:Result:=g_sWizardName;
    2:Result:=g_sTaoistName;
    else begin
      Result:=g_sUnKnowName;
    end;
  end;
end;

function GetAttatckMode (m_btAttatckMode:Integer):String;
begin
  Result:= '';
  case m_btAttatckMode of
    HAM_ALL:Result:=g_AttackModeOfAll;
    HAM_PEACE:Result:=g_AttackModeOfPeaceful;
    HAM_DEAR:Result:=g_AttackModeOfDear;
    HAM_MASTER:Result:=g_AttackModeOfMaster;
    HAM_GROUP:Result:=g_AttackModeOfGroup;
    HAM_GUILD:Result:=g_AttackModeOfGuild;
    HAM_PKATTACK:Result:=g_AttackModeOfRedWhite;
  end;
end;

function GetItemType(ItemType:TItemType):String;
begin
  case ItemType of
    i_HPDurg    :Result:='金创药';
    i_MPDurg    :Result:='魔法药';
    i_HPMPDurg  :Result:='高级药';
    i_OtherDurg :Result:='其它药品';
    i_Weapon  :Result:='武器';
    i_Dress   :Result:='衣服';
    i_Helmet  :Result:='头盔';
    i_Necklace:Result:='项链';
    i_Armring :Result:='手镯';
    i_Ring    :Result:='戒指';
    i_Belt    :Result:='腰带';
    i_Boots   :Result:='鞋子';
    i_Charm   :Result:='宝石';
    i_Book    :Result:='技能书';
    i_PosionDurg :Result:='毒药';
    i_UseItem :Result:='消耗品';
    i_Scroll  :Result:='卷类';
    i_Stone   :Result:='矿石';
    i_Gold    :Result:='金币';
    i_Other   :Result:='其它';
  end;
end;

function GetShowItem(sItemName:String):pTShowItem;
var
  I:Integer;
begin
  Result:=nil;
  g_ShowItemList.Lock;
  try
    for I := 0 to g_ShowItemList.Count - 1 do begin
      if CompareText(pTShowItem(g_ShowItemList.Items[I]).sItemName,sItemName) = 0 then begin
        Result:=g_ShowItemList.Items[I];
        break;
      end;
    end;
  finally
    g_ShowItemList.UnLock;
  end;
end;

procedure ClearShowItemList();
var
  ShowItem:pTShowItem;
  I:Integer;
begin
  g_ShowItemList.Lock;
  try
    for I := 0 to g_ShowItemList.Count - 1 do begin
      ShowItem:=g_ShowItemList.Items[I];
      Dispose(ShowItem);
    end;
    g_ShowItemList.Clear;
  finally
    g_ShowItemList.UnLock;
  end;
end;

procedure SaveUserConfig(sUserName:String);
var
  ShowItem:pTShowItem;
  Ini:TIniFile;
  sFileName:String;
  I:Integer;
  sItemName,sLineText:String;
  sType,sPickup,sShow,sFColor,sBColor:String;
begin
  if sUserName <> '' then sFileName := format(CONFIGFILE,[sUserName])
  else sFileName:=format(CONFIGFILE,['Config']);
  Ini:=TIniFile.Create(sFileName);
  g_ShowItemList.Lock;
  try
    for I := 0 to g_ShowItemList.Count - 1 do begin
      ShowItem:=g_ShowItemList.Items[I];
      sType:=IntToStr(Integer(ShowItem.ItemType));
      if ShowItem.boAutoPickup then sPickup:='1'
      else sPickup:='0';
      if ShowItem.boShowName then sShow:='1'
      else sShow:='0';
      Ini.WriteString('Items',ShowItem.sItemName,format('%s,%s,%s,%d,%d',[sType,sPickup,sShow,ShowItem.nFColor,ShowItem.nBColor]));
    end;
  finally
    g_ShowItemList.UnLock;
  end;
  Ini.Free;
end;

procedure LoadUserConfig(sUserName:String);
var
  ShowItem:pTShowItem;
  Ini:TIniFile;
  sFileName:String;
  Strings: TStringList;
  I:Integer;
  sItemName,sLineText:String;
  sType,sPickup,sShow,sFColor,sBColor:String;
begin
  sFileName:=format(CONFIGFILE,[sUserName]);
  if not FileExists(sFileName) then begin
    sFileName:=format(CONFIGFILE,['Config']);
  end;
  if FileExists(sFileName) then begin
    Ini:=TIniFile.Create(sFileName);
    Strings:=TStringList.Create;
    g_ShowItemList.Lock;
    try
      Ini.ReadSection('Items',Strings);
      for I := 0 to Strings.Count - 1 do begin
        sItemName:=Strings.Strings[I];
        if sItemName = '' then Continue;
        sLineText:=Ini.ReadString('Items',sItemName,'');
        sLineText:=GetValidStr3(sLineText,sType,[',']);
        sLineText:=GetValidStr3(sLineText,sPickup,[',']);
        sLineText:=GetValidStr3(sLineText,sShow,[',']);
        sLineText:=GetValidStr3(sLineText,sFColor,[',']);
        sLineText:=GetValidStr3(sLineText,sBColor,[',']);
        if (sType <> '') and (sPickup <> '') and (sShow <> '') and (sFColor <> '') and (sBColor <> '') then begin
          New(ShowItem);
          ShowItem.sItemName:=sItemName;
          ShowItem.ItemType:=TItemType(Str_ToInt(sType,0));
          ShowItem.boAutoPickup:= sPickup = '1';
          ShowItem.boShowName:= sShow = '1';
          ShowItem.nFColor:=Str_ToInt(sFColor,0);
          ShowItem.nBColor:=Str_ToInt(sBColor,0);
          g_ShowItemList.Add(ShowItem);
        end;
      end;
    finally
      g_ShowItemList.UnLock;
    end;
    Strings.Free;
    Ini.Free;
    exit;
  end;
end;

procedure InitObj();
begin
  DlgConf.DScrollTop.Obj      :=FrmDlg.DScrollTop;
  DlgConf.DScrollUp.Obj       :=FrmDlg.DScrollUp;
  DlgConf.DScrollDown.Obj     :=FrmDlg.DScrollDown;
  DlgConf.DScrollBottom.Obj   :=FrmDlg.DScrollBottom;
  DlgConf.DBotItemShop.Obj    :=FrmDlg.DBotItemShop;
  DlgConf.DItemShopJobAll.Obj       :=FrmDlg.DItemShopJobAll;
  DlgConf.DItemShopJobWarrior.Obj   :=FrmDlg.DItemShopJobWarrior;
  DlgConf.DItemShopJobWizard.Obj    :=FrmDlg.DItemShopJobWizard;
  DlgConf.DItemShopJobMonk.Obj      :=FrmDlg.DItemShopJobMonk;
  DlgConf.DItemShopJobCommon.Obj    :=FrmDlg.DItemShopJobCommon;
  DlgConf.DGrpPgUp.Obj    :=FrmDlg.DGrpPgUp;
  DlgConf.DGrpPgDn.Obj    :=FrmDlg.DGrpPgDn;
  DlgConf.DItemShopFind.Obj    :=FrmDlg.DItemShopFind;
  DlgConf.DItemShopCaNew.Obj     :=FrmDlg.DItemShopCaNew;
  DlgConf.DItemShopCaAll.Obj     :=FrmDlg.DItemShopCaAll;
  DlgConf.DItemShopCaWeapon.Obj     :=FrmDlg.DItemShopCaWeapon;
  DlgConf.DItemShopCaArmor.Obj     :=FrmDlg.DItemShopCaArmor;
  DlgConf.DItemShopCaAcc.Obj     :=FrmDlg.DItemShopCaAcc;
  DlgConf.DItemShopCasSubitem.Obj     :=FrmDlg.DItemShopCasSubitem;
  DlgConf.DItemShopCaOther.Obj     :=FrmDlg.DItemShopCaOther;
  DlgConf.DItemShopCaPackage.Obj     :=FrmDlg.DItemShopCaPackage;
  DlgConf.DItemShopCaSub1.Obj     :=FrmDlg.DItemShopCaSub1;
  DlgConf.DItemShopCaSub2.Obj     :=FrmDlg.DItemShopCaSub2;
  DlgConf.DItemShopCaSub3.Obj     :=FrmDlg.DItemShopCaSub3;
  DlgConf.DItemShopCaSub4.Obj     :=FrmDlg.DItemShopCaSub4;
  DlgConf.DItemShopCaSub5.Obj     :=FrmDlg.DItemShopCaSub5;
  DlgConf.DItemShopCaSub6.Obj     :=FrmDlg.DItemShopCaSub6;
  DlgConf.DItemShopCaSub7.Obj     :=FrmDlg.DItemShopCaSub7;
  DlgConf.DItemShopGetGift.Obj     :=FrmDlg.DItemShopGetGift;
  DlgConf.DItemShopAddFav.Obj     :=FrmDlg.DItemShopAddFav;
  DlgConf.DItemShopBye.Obj     :=FrmDlg.DItemShopBye;
  DlgConf.DItemShopGift.Obj     :=FrmDlg.DItemShopGift;
  DlgConf.DItemShopPayMoney.Obj     :=FrmDlg.DItemShopPayMoney;
  DlgConf.DItemShopWear.Obj     :=FrmDlg.DItemShopWear;
  DlgConf.DItemShopWearLturn.Obj     :=FrmDlg.DItemShopWearLturn;
  DlgConf.DItemShopWearChange.Obj     :=FrmDlg.DItemShopWearChange;
  DlgConf.DItemShopWearRturn.Obj     :=FrmDlg.DItemShopWearRturn;
  DlgConf.DItemShopListPrev.Obj     :=FrmDlg.DItemShopListPrev;
  DlgConf.DItemShopListNext.Obj     :=FrmDlg.DItemShopListNext;
  DlgConf.DShopScrollBarUp.Obj     :=FrmDlg.DShopScrollBarUp;
  DlgConf.DShopScrollBarDown.Obj     :=FrmDlg.DShopScrollBarDown;
  DlgConf.DShopScrollBar.Obj     :=FrmDlg.DShopScrollBar;
  DlgConf.DItemShopCaFav.Obj     :=FrmDlg.DItemShopCaFav;
  DlgConf.DItemShopInPackBack.Obj     :=FrmDlg.DItemShopInPackBack;
  DlgConf.DItemShopCashRefresh.Obj     :=FrmDlg.DItemShopCashRefresh;
  DlgConf.DItemShopPackSub1.Obj     :=FrmDlg.DItemShopPackSub1;
  DlgConf.DItemShopPackSub2.Obj     :=FrmDlg.DItemShopPackSub2;
  DlgConf.DItemShopPackSub3.Obj     :=FrmDlg.DItemShopPackSub3;
  DlgConf.DItemShopPackSub4.Obj     :=FrmDlg.DItemShopPackSub4;
  DlgConf.DItemShopPackSub5.Obj     :=FrmDlg.DItemShopPackSub5;
  DlgConf.DItemShopPackSub6.Obj     :=FrmDlg.DItemShopPackSub6;
  DlgConf.DItemShopPackSub7.Obj     :=FrmDlg.DItemShopPackSub7;
  DlgConf.DItemShopPackSub8.Obj     :=FrmDlg.DItemShopPackSub8;
  DlgConf.DItemShopFavDel1.Obj     :=FrmDlg.DItemShopFavDel1;
  DlgConf.DItemShopFavDel2.Obj     :=FrmDlg.DItemShopFavDel2;
  DlgConf.DItemShopFavDel3.Obj     :=FrmDlg.DItemShopFavDel3;
  DlgConf.DItemShopFavDel4.Obj     :=FrmDlg.DItemShopFavDel4;
  DlgConf.DItemShopFavDel5.Obj     :=FrmDlg.DItemShopFavDel5;
  DlgConf.DItemShopFavDel6.Obj     :=FrmDlg.DItemShopFavDel6;
  DlgConf.DItemShopFavDel7.Obj     :=FrmDlg.DItemShopFavDel7;
  DlgConf.DItemShopFavDel8.Obj     :=FrmDlg.DItemShopFavDel8;
  DlgConf.DItemShopPriceUp.Obj     :=FrmDlg.DItemShopPriceUp;
  DlgConf.DItemShopPriceDn.Obj     :=FrmDlg.DItemShopPriceDn;
  DlgConf.DItemShopCheckSort.Obj     :=FrmDlg.DItemShopCheckSort;
end;

initialization
  {---- Adjust global SVN revision ----}
  SVNRevision('$Id: MShare.pas 596 2007-04-11 00:14:13Z sean $');
begin
end;

end.
