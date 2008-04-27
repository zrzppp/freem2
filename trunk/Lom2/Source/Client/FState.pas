unit FState;

interface

uses
  svn, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DWinCtl, StdCtrls, DXDraws, Grids, Grobal2, EdCode, clFunc, hUtil32, cliUtil,
  MapUnit, SoundUtil, Actor, nixtime, DateUtils, StrUtils, Wil;

const
   BOTTOMBOARD800 = 1;
   BOTTOMBOARD1024 = 2;
   VIEWCHATLINE = 9;
   MAXSTATEPAGE = 4;
   MAXHELPPAGE = 11;
   LISTLINEHEIGHT = 13;
   NEWLISTLINEHEIGHT = 35;
   MAXMENU = 10;
   NEWMAXMENU = 5;
   SHOPMAXMENU = 4;
   SHOPLISTLINEWIDTH = 93;

   AdjustAbilHints : array[0..8] of string = (
      '攻击力',
      '魔法(魔法师)',
      '道术(道士)',
      '防御',
      '魔法防御',
      '生命值',
      '魔法值',
      '准确',
      '敏捷'
   );

type
  TSpotDlgMode = (dmSell, dmRepair, dmStorage, dmConsign);

  TClickPoint = record
     rc: TRect;
     RStr: string;
  end;
  pTClickPoint = ^TClickPoint;
  TDiceInfo = record
    nDicePoint :Integer;      //0x66C
    nPlayPoint :Integer;      //0x670
    nX         :Integer;      //0x674
    nY         :Integer;      //0x678
    n67C       :Integer;      //0x67C
    n680       :Integer;      //0x680
    dwPlayTick :LongWord;     //0x684
  end;
  pTDiceInfo = ^TDiceInfo;
  TFrmDlg = class(TForm)
    DStateWin: TDWindow;
    DBackground: TDWindow;
    DItemBag: TDWindow;
    DBottom: TDWindow;
    DMyState: TDButton;
    DMyBag: TDButton;
    DMyMagic: TDButton;
    DOption: TDButton;
    DGold: TDButton;
    DPrevState: TDButton;
    DRepairItem: TDButton;
    DCloseBag: TDButton;
    DCloseState: TDButton;
    DLogIn: TDWindow;
    DLoginNew: TDButton;
    DLoginOk: TDButton;
    DNewAccount: TDWindow;
    DNewAccountOk: TDButton;
    DLoginClose: TDButton;
    DNewAccountClose: TDButton;
    DSelectChr: TDWindow;
    DscSelect1: TDButton;
    DscSelect2: TDButton;
    DscStart: TDButton;
    DscNewChr: TDButton;
    DscEraseChr: TDButton;
    DscCredits: TDButton;
    DscExit: TDButton;
    DCreateChr: TDWindow;
    DccWarrior: TDButton;
    DccWizzard: TDButton;
    DccMonk: TDButton;
    DccReserved: TDButton;
    DccMale: TDButton;
    DccFemale: TDButton;
    DccOk: TDButton;
    DccClose: TDButton;
    DItemGrid: TDGrid;
    DLoginChgPw: TDButton;
    DMsgDlg: TDWindow;
    DMsgDlgOk: TDButton;
    DMsgDlgYes: TDButton;
    DMsgDlgCancel: TDButton;
    DMsgDlgNo: TDButton;
    DNextState: TDButton;
    DSWNecklace: TDButton;
    DSWLight: TDButton;
    DSWArmRingR: TDButton;
    DSWArmRingL: TDButton;
    DSWRingR: TDButton;
    DSWRingL: TDButton;
    DSWWeapon: TDButton;
    DSWDress: TDButton;
    DSWHelmet: TDButton;
    DSWBujuk: TDButton;
    DSWBelt: TDButton;
    DSWBoots: TDButton;
    DSWCharm: TDButton;
    DChgPw: TDWindow;
    DChgpwOk: TDButton;
    DChgpwCancel: TDButton;
    DMerchantDlg: TDWindow;
    DMerchantDlgClose: TDButton;
    DMenuDlg: TDWindow;
    DMenuPrev: TDButton;
    DMenuNext: TDButton;
    DMenuBuy: TDButton;
    DMenuClose: TDButton;
    DSellDlg: TDWindow;
    DSellDlgOk: TDButton;
    DSellDlgClose: TDButton;
    DSellDlgSpot: TDButton;
    DStMag1: TDButton;
    DStMag2: TDButton;
    DStMag3: TDButton;
    DStMag4: TDButton;
    DStMag5: TDButton;
    DKeySelDlg: TDWindow;
    DKsIcon: TDButton;
    DKsF1: TDButton;
    DKsF2: TDButton;
    DKsF3: TDButton;
    DKsF4: TDButton;
    DKsNone: TDButton;
    DKsOk: TDButton;
    DBotGroup: TDButton;
    DBotTrade: TDButton;
    DBotMiniMap: TDButton;
    DBotFriend: TDButton;
    DGroupDlg: TDWindow;
    DGrpAllowGroup: TDButton;
    DGrpDlgClose: TDButton;
    DGrpCreate: TDButton;
    DGrpAddMem: TDButton;
    DGrpDelMem: TDButton;
    DBotLogout: TDButton;
    DBotExit: TDButton;
    DBotGuild: TDButton;
    DStPageUp: TDButton;
    DStPageDown: TDButton;
    DDealRemoteDlg: TDWindow;
    DDealDlg: TDWindow;
    DDRGrid: TDGrid;
    DDGrid: TDGrid;
    DDealOk: TDButton;
    DDealClose: TDButton;
    DDGold: TDButton;
    DDRGold: TDButton;
    DSelServerDlg: TDWindow;
    DSSrvClose: TDButton;
    DSServer1: TDButton;
    DSServer2: TDButton;
    DSServer3: TDButton;
    DSServer4: TDButton;
    DSServer5: TDButton;
    DSServer6: TDButton;
    DSServer7: TDButton;
    DSServer8: TDButton;
    DUserState1: TDWindow;
    DCloseUS1: TDButton;
    DWeaponUS1: TDButton;
    DHelmetUS1: TDButton;
    DNecklaceUS1: TDButton;
    DDressUS1: TDButton;
    DLightUS1: TDButton;
    DArmringRUS1: TDButton;
    DRingRUS1: TDButton;
    DArmringLUS1: TDButton;
    DRingLUS1: TDButton;
    DBujukUS1: TDButton;
    DBeltUS1: TDButton;
    DBootsUS1: TDButton;
    DCharmUS1: TDButton;
    DGuildDlg: TDWindow;
    DGDHome: TDButton;
    DGDList: TDButton;
    DGDChat: TDButton;
    DGDAddMem: TDButton;
    DGDDelMem: TDButton;
    DGDEditNotice: TDButton;
    DGDEditGrade: TDButton;
    DGDAlly: TDButton;
    DGDBreakAlly: TDButton;
    DGDWar: TDButton;
    DGDCancelWar: TDButton;
    DGDUp: TDButton;
    DGDDown: TDButton;
    DGDClose: TDButton;
    DGuildEditNotice: TDWindow;
    DGEClose: TDButton;
    DGEOk: TDButton;
    DNewAccountCancel: TDButton;
    DAdjustAbility: TDWindow;
    DPlusDC: TDButton;
    DPlusMC: TDButton;
    DPlusSC: TDButton;
    DPlusAC: TDButton;
    DPlusMAC: TDButton;
    DPlusHP: TDButton;
    DPlusMP: TDButton;
    DPlusHit: TDButton;
    DPlusSpeed: TDButton;
    DMinusDC: TDButton;
    DMinusMC: TDButton;
    DMinusSC: TDButton;
    DMinusAC: TDButton;
    DMinusMAC: TDButton;
    DMinusMP: TDButton;
    DMinusHP: TDButton;
    DMinusHit: TDButton;
    DMinusSpeed: TDButton;
    DAdjustAbilClose: TDButton;
    DAdjustAbilOk: TDButton;
    DBotPlusAbil: TDButton;
    DKsF5: TDButton;
    DKsF6: TDButton;
    DKsF7: TDButton;
    DKsF8: TDButton;
    DEngServer1: TDButton;
    DConfigDlg: TDWindow;
    DConfigDlgClose: TDButton;
    DConfigDlgOK: TDButton;
    DKsConF1: TDButton;
    DKsConF2: TDButton;
    DKsConF3: TDButton;
    DKsConF4: TDButton;
    DKsConF5: TDButton;
    DKsConF6: TDButton;
    DKsConF7: TDButton;
    DKsConF8: TDButton;
    DBotMemo: TDButton;
    DFriendDlg: TDWindow;
    DFrdFriend: TDButton;
    DFrdBlackList: TDButton;
    DFrdClose: TDButton;
    DFrdPgUp: TDButton;
    DFrdPgDn: TDButton;
    DFrdAdd: TDButton;
    DFrdDel: TDButton;
    DFrdMemo: TDButton;
    DFrdMail: TDButton;
    DFrdWhisper: TDButton;
    DBLDel: TDButton;
    DBLAdd: TDButton;
    DMemoB2: TDButton;
    DMemoB1: TDButton;
    DMailListDlg: TDWindow;
    DMailDlg: TDWindow;
    DBlockListDlg: TDWindow;
    DBLPgUp: TDButton;
    DBLPgDn: TDButton;
    DBlockListClose: TDButton;
    DMemo: TDWindow;
    DMemoClose: TDButton;
    DChgGamePwd: TDWindow;
    DChgGamePwdClose: TDButton;
    DGemMakeItem: TDWindow;
    DGemMakeOK: TDButton;
    DGemMakeCancel: TDButton;
    DGemSlot1: TDButton;
    DGemSlot2: TDButton;
    DGemSlot3: TDButton;
    DGemSlot4: TDButton;
    DGemSlot5: TDButton;
    DGemSlot6: TDButton;
    DGemCancel: TDButton;
    DSales: TDWindow;
    DSalesFind: TDButton;
    DSalesBuy: TDButton;
    DSalesCancel: TDButton;
    DSalesClose: TDButton;
    DSalesPrevPage: TDButton;
    DSalesRefresh: TDButton;
    DSalesNextPage: TDButton;
    DAuctionImg: TDButton;
    DMLReply: TDButton;
    DMailListPgDn: TDButton;
    DMLRead: TDButton;
    DMailListPgUp: TDButton;
    DMLLock: TDButton;
    DMLDel: TDButton;
    DMLBlock: TDButton;
    DMailListClose: TDButton;
    DMailDlgClose: TDButton;
    DMailDlgB1: TDButton;
    DMailDlgb2: TDButton;
    DMailName: TDButton;
    DMemoName: TDButton;
    DMailListTitle: TDButton;
    DMailListStatus: TDButton;
    DBotLover: TDButton;
    DBeltWindow: TDWindow;
    DBelt1: TDButton;
    DBelt2: TDButton;
    DBelt3: TDButton;
    DBelt4: TDButton;
    DBelt5: TDButton;
    DBelt6: TDButton;
    DBeltClose: TDButton;
    DBeltSwap: TDButton;
    DscSelect3: TDButton;
    DLoverWindow: TDWindow;
    DLoverAvailable: TDButton;
    DLoverAsk: TDButton;
    DLoverDivorce: TDButton;
    DLoverExit: TDButton;
    DLoverCaption: TDButton;
    DMasterCaption: TDButton;
    DLoverHeart: TDButton;
    DMailRead: TDWindow;
    DMailReadClose: TDButton;
    DMailReadB1: TDButton;
    DMailReadName: TDButton;
    DHeartMyState: TDButton;
    DChgGamePwdB2: TDButton;
    DChgGamePwdB1: TDButton;
    DUSGroup: TDButton;
    DUSFriend: TDButton;
    DUSMail: TDButton;
    DHold: TDButton;
    DBlockListTitle: TDButton;
    DGTList: TDWindow;
    DGTListClose: TDButton;
    DGTListPrev: TDButton;
    DGTListNext: TDButton;
    DGTListMail: TDButton;
    DDecoListDlg: TDWindow;
    DDecoListExit: TDButton;
    DDecoListPrev: TDButton;
    DDecoListNext: TDButton;
    DDecoListCancel: TDButton;
    DDecoListBuy: TDButton;
    DBBSListDlg: TDWindow;
    DBBSListClose: TDButton;
    DBBSListPrev: TDButton;
    DBBSListNext: TDButton;
    DBBSListRefresh: TDButton;
    DBBSListOK: TDButton;
    DBBSListWrite: TDButton;
    DBBSListNotice: TDButton;
    DBBSMsgDlg: TDWindow;
    DBBSMsgClose: TDButton;
    DBBSMsgOk: TDButton;
    DBBSMsgMail: TDButton;
    DBBSMsgReply: TDButton;
    DBBSMsgCancel: TDButton;
    DBBSMsgDelete: TDButton;
    DOptions: TDWindow;
    DOptionsClose: TDButton;
    DOptionsSoundOn: TDButton;
    DOptionsSoundOff: TDButton;
    DOptionsEffectOn: TDButton;
    DOptionsEffectOff: TDButton;
    DOptionsSkillBarOn: TDButton;
    DOptionsSkillBarOff: TDButton;
    DOptionsDropViewOn: TDButton;
    DOptionsDropViewOff: TDButton;
    DOptionsSkillMode2: TDButton;
    DOptionsSkillMode1: TDButton;
    DSkillBar: TDWindow;
    DSkillBar1: TDButton;
    DSkillBar2: TDButton;
    DSkillBar3: TDButton;
    DSkillBar4: TDButton;
    DSkillBar5: TDButton;
    DSkillBar6: TDButton;
    DSkillBar7: TDButton;
    DSkillBar8: TDButton;
    DSalesMail: TDButton;
    DScrollUp: TDButton;
    DScrollTop: TDButton;
    DScrollBar: TDButton;
    DScrollDown: TDButton;
    DScrollBottom: TDButton;
    DInputKey: TDWindow;
    DInputKeyEsc: TDButton;
    DInputKey0: TDButton;
    DInputKey6: TDButton;
    DInputKeya: TDButton;
    DInputKeyg: TDButton;
    DInputKeym: TDButton;
    DInputKeys: TDButton;
    DInputKeyy: TDButton;
    DInputKeyz: TDButton;
    DInputKeyt: TDButton;
    DInputKeyn: TDButton;
    DInputKeyh: TDButton;
    DInputKeyb: TDButton;
    DInputKey7: TDButton;
    DInputKey1: TDButton;
    DInputKey2: TDButton;
    DInputKey8: TDButton;
    DInputKeyc: TDButton;
    DInputKeyi: TDButton;
    DInputKeyo: TDButton;
    DInputKeyu: TDButton;
    DInputKeyRand: TDButton;
    DInputKeyv: TDButton;
    DInputKeyEnter: TDButton;
    DInputKeyw: TDButton;
    DInputKeyx: TDButton;
    DInputKeyr: TDButton;
    DInputKeyq: TDButton;
    DInputKeyp: TDButton;
    DInputKeyj: TDButton;
    DInputKeyk: TDButton;
    DInputKeyl: TDButton;
    DInputKeyf: TDButton;
    DInputKeye: TDButton;
    DInputKeyd: TDButton;
    DInputKey9: TDButton;
    DInputKeyDel: TDButton;
    DInputKey3: TDButton;
    DInputKey4: TDButton;
    DInputKey5: TDButton;
    DHelpWin: TDWindow;
    DHelpClose: TDButton;
    DHelpPrev: TDButton;
    DHelpNext: TDButton;
    DMsgSimpleDlg: TDWindow;
    DMsgSimpleDlgOk: TDButton;
    DMsgSimpleDlgCancel: TDButton;
    DLoginViewKey: TDButton;
    DBotItemShop: TDButton;
    DBotHelp: TDButton;
    DBotGift: TDButton;
    DBotQuest: TDButton;
    DOptionsNameAllViewOn: TDButton;
    DOptionsNameAllViewOff: TDButton;
    DOptionsHPView2: TDButton;
    DOptionsHPView1: TDButton;
    DItemShopDlg: TDWindow;
    DItemShopFind: TDButton;
    DItemShopWear: TDButton;
    DItemShopInPackBack: TDButton;
    DItemShopWearLturn: TDButton;
    DItemShopCashRefresh: TDButton;
    DItemShopWearChange: TDButton;
    DItemShopWearRturn: TDButton;
    DItemShopClose: TDButton;
    DItemShopBye: TDButton;
    DItemShopGift: TDButton;
    DItemShopAddFav: TDButton;
    DItemShopPriceUp: TDButton;
    DItemShopPriceDn: TDButton;
    DItemShopJobAll: TDButton;
    DItemShopJobWarrior: TDButton;
    DItemShopJobWizard: TDButton;
    DItemShopJobMonk: TDButton;
    DItemShopJobCommon: TDButton;
    DItemShopCaFav: TDButton;
    DItemShopCheckSort: TDButton;
    DItemShopListPrev: TDButton;
    DItemShopListNext: TDButton;
    DItemShopGetGift: TDButton;
    DItemShopPayMoney: TDButton;
    DItemShopCaNew: TDButton;
    DShopScrollBar: TDButton;
    DShopScrollBarUp: TDButton;
    DShopScrollBarDown: TDButton;
    DItemShopCaAll: TDButton;
    DItemShopCaWeapon: TDButton;
    DItemShopCaArmor: TDButton;
    DItemShopCasSubitem: TDButton;
    DItemShopCaAcc: TDButton;
    DItemShopCaPackage: TDButton;
    DItemShopCaOther: TDButton;
    DItemShopCaSub1: TDButton;
    DItemShopCaSub2: TDButton;
    DItemShopCaSub3: TDButton;
    DItemShopCaSub4: TDButton;
    DItemShopCaSub5: TDButton;
    DItemShopCaSub6: TDButton;
    DItemShopCaSub7: TDButton;
    DItemShopPackSub8: TDButton;
    DItemShopPackSub7: TDButton;
    DItemShopPackSub6: TDButton;
    DItemShopPackSub5: TDButton;
    DItemShopPackSub4: TDButton;
    DItemShopPackSub3: TDButton;
    DItemShopPackSub2: TDButton;
    DItemShopPackSub1: TDButton;
    DItemShopFavDel1: TDButton;
    DItemShopFavDel2: TDButton;
    DItemShopFavDel3: TDButton;
    DItemShopFavDel4: TDButton;
    DItemShopFavDel5: TDButton;
    DItemShopFavDel6: TDButton;
    DItemShopFavDel7: TDButton;
    DItemShopFavDel8: TDButton;
    DAddBag8: TDWindow;
    DAddBag7: TDWindow;
    DAddBag6: TDWindow;
    DAddBag5: TDWindow;
    DAddBag4: TDWindow;
    DAddBag3: TDWindow;
    DAddBag3Grid: TDGrid;
    DAddBag3Close: TDButton;
    DAddBag4Close: TDButton;
    DAddBag4Grid: TDGrid;
    DAddBag5Grid: TDGrid;
    DAddBag5Close: TDButton;
    DAddBag6Grid: TDGrid;
    DAddBag6Close: TDButton;
    DAddBag7Grid: TDGrid;
    DAddBag7Close: TDButton;
    DAddBag8Grid: TDGrid;
    DAddBag8Close: TDButton;
    DItemStore: TDWindow;
    DItemStoreClose: TDButton;
    DStoreGrid: TDGrid;
    DShopMenuDlg: TDWindow;
    DShopMenuClose: TDButton;
    DShopMenuOk: TDButton;
    DShopMenuScrollBar: TDButton;
    DShopMenuScrollDown: TDButton;
    DShopMenuScrollUp: TDButton;
    DRefineDlg: TDWindow;
    DRefineGrid: TDGrid;
    DRefineOk: TDButton;
    DRefineDlgClose: TDButton;
    DQuestAccept: TDWindow;
    DBtnQuestAccept: TDButton;
    DBtnQuestFinish: TDButton;
    DQuestAcceptClose: TDButton;
    DStoragePassSet: TDWindow;
    DStoragePassReset: TDWindow;
    DStoragePass: TDWindow;
    DStoragePassSetSafe: TDButton;
    DStoragePassSetOk: TDButton;
    DStoragePassSetDel: TDButton;
    DStoragePassSetClose: TDButton;
    DStoragePassSafe: TDButton;
    DStoragePassOk: TDButton;
    DStoragePassDel: TDButton;
    DStoragePassClose: TDButton;
    DStoragePassResetSafe: TDButton;
    DStoragePassResetOk: TDButton;
    DStoragePassResetDel: TDButton;
    DStoragePassResetClose: TDButton;
    DBank: TDWindow;
    DBankCell1: TDButton;
    DBankSlot1: TDButton;
    DBankGold: TDButton;
    DBankSlot2: TDButton;
    DBankSlot3: TDButton;
    DBankSlotAdd: TDButton;
    DBankSlot4: TDButton;
    DBankSlot5: TDButton;
    DBankPassSet: TDButton;
    DBankWinSlot5: TDWindow;
    DBankWinSlot4: TDWindow;
    DBankWinSlot3: TDWindow;
    DBankWinSlot2: TDWindow;
    DBankWinSlot1: TDWindow;
    DBankCloseSlot1: TDButton;
    DBankCloseSlot2: TDButton;
    DBankCloseSlot3: TDButton;
    DBankCloseSlot4: TDButton;
    DBankCloseSlot5: TDButton;
    DBankGridSlot1: TDGrid;
    DBankGridSlot2: TDGrid;
    DBankGridSlot3: TDGrid;
    DBankGridSlot4: TDGrid;
    DBankGridSlot5: TDGrid;
    DSafeKeyStorage: TDWindow;
    DSafeKeyStorage0: TDButton;
    DSafeKeyStorage6: TDButton;
    DSafeKeyStorage1: TDButton;
    DSafeKeyStorage7: TDButton;
    DSafeKeyStorage2: TDButton;
    DSafeKeyStorage8: TDButton;
    DSafeKeyStorage3: TDButton;
    DSafeKeyStorage9: TDButton;
    DSafeKeyStorage4: TDButton;
    DSafeKeyStorage5: TDButton;
    DSafeKeyStorageDel: TDButton;
    DSafeKeyStorageEnter: TDButton;
    DSafeKeyStorageEsc: TDButton;
    DBankCell2: TDButton;
    DBankCell3: TDButton;
    DBankClose: TDButton;
    DDcJunsaBuff: TDWindow;
    DMcBuff: TDWindow;
    DExUpBuff: TDWindow;
    DAgilityBuff: TDWindow;
    DAccBuff: TDWindow;
    DLuckBuff: TDWindow;
    DScBuff: TDWindow;
    DAcJunsaBuff: TDWindow;
    DDcBuff: TDWindow;
    DAttSBuff: TDWindow;
    DHPUpBuff: TDWindow;
    DToxAvoidBuff: TDWindow;
    DBagWUpBuff: TDWindow;
    DAcBuff: TDWindow;
    DMPUpBuff: TDWindow;
    DHorseBuff: TDWindow;
    DMacBuff: TDWindow;
    DHandWUpBuff: TDWindow;
    DCashBuff: TDWindow;
    DPcBuff: TDWindow;
    DCashBuff2: TDWindow;
    DWemadeBuff: TDWindow;
    DCashBuff3: TDWindow;
    DWemadeBuff2: TDWindow;
    DCashBuff4: TDWindow;
    DRestBuff: TDWindow;
    DCashBuff5: TDWindow;
    DCashBuff7: TDWindow;
    DCashBuff6: TDWindow;
    DCountDlg: TDWindow;
    DCountDlgMax: TDButton;
    DCountDlgCancel: TDButton;
    DCountDlgOk: TDButton;
    DCountDlgClose: TDButton;
    DGetGiftDlg: TDWindow;
    DGetGift: TDButton;
    DGetGiftReply: TDButton;
    DGetGiftDel: TDButton;
    DGetGiftClose: TDButton;
    DGiftListDlg: TDWindow;
    DGiftListPrev: TDButton;
    DGiftListNext: TDButton;
    DGiftRead: TDButton;
    DGiftReply: TDButton;
    DGiftListClose: TDButton;
    DGrpPgUp: TDButton;
    DGrpPgDn: TDButton;
    DItemStorePassReset: TDButton;
    DBotExpand: TDButton;
    DAbout: TDWindow;
    DAboutClose: TDButton;


    procedure DBottomInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DBottomDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMyStateDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DOptionClick();
    procedure DItemBagDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DRepairItemDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DRepairItemInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DStateWinDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure FormCreate(Sender: TObject);
    procedure DPrevStateDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLoginNewDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DscSelect1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSalesCancelDirectPaintt(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DItemGridDblClick(Sender: TObject);
    procedure DMsgDlgOkDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMsgDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMsgDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCloseBagDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBackgroundBackgroundClick(Sender: TObject);
    procedure DItemGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DBelt1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure FormDestroy(Sender: TObject);
    procedure DBelt1DblClick(Sender: TObject);
    procedure DLoginCloseClick(Sender: TObject; X, Y: Integer);
    procedure DLoginOkClick(Sender: TObject; X, Y: Integer);
    procedure DLoginNewClick(Sender: TObject; X, Y: Integer);
    procedure DLoginChgPwClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountOkClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountCloseClick(Sender: TObject; X, Y: Integer);
    procedure DccCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgpwOkClick(Sender: TObject; X, Y: Integer);
    procedure DscSelect1Click(Sender: TObject; X, Y: Integer);
    procedure DCloseStateClick(Sender: TObject; X, Y: Integer);
    procedure DPrevStateClick(Sender: TObject; X, Y: Integer);
    procedure DNextStateClick(Sender: TObject; X, Y: Integer);
    procedure DSWWeaponClick(Sender: TObject; X, Y: Integer);
    procedure DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DCloseBagClick(Sender: TObject; X, Y: Integer);
    procedure DBelt1Click(Sender: TObject; X, Y: Integer);
    procedure DMyStateClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinClick(Sender: TObject; X, Y: Integer);
    procedure DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBelt1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMerchantDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantDlgClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantDlgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMenuCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMenuDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMenuDlgClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgSpotClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgSpotDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSellDlgSpotMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DSellOk();
    procedure DMenuBuyClick(Sender: TObject; X, Y: Integer);
    procedure DMenuPrevClick(Sender: TObject; X, Y: Integer);
    procedure DMenuNextClick(Sender: TObject; X, Y: Integer);
    procedure DGoldClick(Sender: TObject; X, Y: Integer);
    procedure DSWLightDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DStateWinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DLoginNewClickSound(Sender: TObject;
      Clicksound: TClickSound);
    procedure DStMag1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DStMag1Click(Sender: TObject; X, Y: Integer);
    procedure DKsIconDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DKsF1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DKsOkClick(Sender: TObject; X, Y: Integer);
    procedure DKsF1Click(Sender: TObject; X, Y: Integer);
    procedure DKeySelDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotGroupDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGrpAllowGroupDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGrpDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpCreateClick(Sender: TObject; X, Y: Integer);
    procedure DGroupDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGrpAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGrpDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DBotLogoutClick(Sender: TObject; X, Y: Integer);
    procedure DBotExitClick(Sender: TObject; X, Y: Integer);
    procedure DStPageUpClick(Sender: TObject; X, Y: Integer);
    procedure DBottomMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DDealOkClick(Sender: TObject; X, Y: Integer);
    procedure DDealCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotTradeClick(Sender: TObject; X, Y: Integer);
    procedure DDealRemoteDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDealDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DDGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DDRGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DDGoldClick(Sender: TObject; X, Y: Integer);
    procedure DSServer1Click(Sender: TObject; X, Y: Integer);
    procedure DSSrvCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotMiniMapClick(Sender: TObject; X, Y: Integer);
    procedure DMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUserState1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DUserState1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DCloseUS1Click(Sender: TObject; X, Y: Integer);
    procedure DNecklaceUS1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotGuildClick(Sender: TObject; X, Y: Integer);
    procedure DGuildDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGDUpClick(Sender: TObject; X, Y: Integer);
    procedure DGDDownClick(Sender: TObject; X, Y: Integer);
    procedure DGDCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGDHomeClick(Sender: TObject; X, Y: Integer);
    procedure DGDListClick(Sender: TObject; X, Y: Integer);
    procedure DGDAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGDDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
    procedure DGDEditGradeClick(Sender: TObject; X, Y: Integer);
    procedure DGECloseClick(Sender: TObject; X, Y: Integer);
    procedure DGEOkClick(Sender: TObject; X, Y: Integer);
    procedure DGuildEditNoticeDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGDChatClick(Sender: TObject; X, Y: Integer);
    procedure DGoldDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DNewAccountDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DAdjustAbilCloseClick(Sender: TObject; X, Y: Integer);
    procedure DAdjustAbilityDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
    procedure DPlusDCClick(Sender: TObject; X, Y: Integer);
    procedure DMinusDCClick(Sender: TObject; X, Y: Integer);
    procedure DAdjustAbilOkClick(Sender: TObject; X, Y: Integer);
    procedure DBotPlusAbilDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DAdjustAbilityMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DUserState1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DEngServer1Click(Sender: TObject; X, Y: Integer);
    procedure DGDAllyClick(Sender: TObject; X, Y: Integer);
    procedure DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
    procedure DSelServerDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBotFriendClick(Sender: TObject; X, Y: Integer);
    procedure DFrdCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgGamePwdCloseClick(Sender: TObject; X, Y: Integer);
    procedure DChgGamePwdDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGemMakeItemDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
(*    procedure int(Sender: TObject;
      dsurface: TDirectDrawSurface); *)
    procedure DGemMakeOKDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGemMakeCancelDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGemMakeCancelClick(Sender: TObject; X, Y: Integer);
    procedure DGemSlot1Click(Sender: TObject; X, Y: Integer);
    procedure DGemSlot1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGemSlot1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGemSlot2Click(Sender: TObject; X, Y: Integer);
    procedure DGemSlot2DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGemSlot2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGemSlot3Click(Sender: TObject; X, Y: Integer);
    procedure DGemSlot3DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGemSlot3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGemSlot4Click(Sender: TObject; X, Y: Integer);
    procedure DGemSlot4DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGemSlot4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGemSlot5Click(Sender: TObject; X, Y: Integer);
    procedure DGemSlot5DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGemSlot5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGemSlot6Click(Sender: TObject; X, Y: Integer);
    procedure DGemSlot6DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGemSlot6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGemMakeOKClick(Sender: TObject; X, Y: Integer);
    procedure DFrdAddClick(Sender: TObject; X, Y: Integer);
    procedure DFriendDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DFriendDlgClick(Sender: TObject; X, Y: Integer);
    procedure DFrdDelClick(Sender: TObject; X, Y: Integer);
    procedure DFrdMemoClick(Sender: TObject; X, Y: Integer);
    procedure DFriendDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMailReadPostDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
    procedure DMemoPostDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMemoB1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMemoB2DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMemoB1Click(Sender: TObject; X, Y: Integer);
    procedure DSalesDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSalesCancelDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSalesCloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSalesCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSalesPrevPageClick(Sender: TObject; X, Y: Integer);
    procedure DSalesNextPageClick(Sender: TObject; X, Y: Integer);
    procedure DSalesRefreshClick(Sender: TObject; X, Y: Integer);
    procedure DSalesClick(Sender: TObject; X, Y: Integer);
    procedure DSalesBuyClick(Sender: TObject; X, Y: Integer);
    procedure DSalesCancelClick(Sender: TObject; X, Y: Integer);
    procedure ClearAuctionDlg;
    procedure DSalesFindClick(Sender: TObject; X, Y: Integer);
    procedure DFrdBlackListClick(Sender: TObject; X, Y: Integer);
    procedure DFrdFriendClick(Sender: TObject; X, Y: Integer);
    procedure DBotMemoClick(Sender: TObject; X, Y: Integer);
    procedure DMailDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMailDlgPostDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMailListDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMailListDlgPostDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBlockListDlgPostDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DRepairItemClick(Sender: TObject; X, Y: Integer);
    procedure DBeltSwapClick(Sender: TObject; X, Y: Integer);
    procedure DBeltCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotLoverClick(Sender: TObject; X, Y: Integer);
    procedure DBeltWindowMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGroupDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMailListStatusDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DFrdPgDnClick(Sender: TObject; X, Y: Integer);
    procedure DFrdPgUpClick(Sender: TObject; X, Y: Integer);
    procedure DCreateChrDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure GetPageInfo(pList: Pointer; var PageNumber: Integer; var PageTotal: Integer; var PageRef: Integer);
    function FindFriend(Select: Boolean = False): PTClientFriends;
    function FindMail(Select: Boolean = False): ptMailItem;
    function FindBlock(Select: Boolean = False): PTBlockItem;
    procedure DMemoCloseClick(Sender: TObject; X, Y: Integer);
    procedure DGenericMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBigMapDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLoverWindowDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLoverAvailableDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLoverAskDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLoverDivorceDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLoverExitDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DLoverExitClick(Sender: TObject; X, Y: Integer);
    procedure DLoverAvailableClick(Sender: TObject; X, Y: Integer);
    procedure DLoverAskClick(Sender: TObject; X, Y: Integer);
    procedure DLoverDivorceClick(Sender: TObject; X, Y: Integer);
    procedure DLoverWindowMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMailListDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMailListPgDnClick(Sender: TObject; X, Y: Integer);
    procedure DMailListPgUpClick(Sender: TObject; X, Y: Integer);
    procedure DMailListDlgClick(Sender: TObject; X, Y: Integer);
    procedure DMailListDlgDblClick(Sender: TObject);
    procedure DMLReplyClick(Sender: TObject; X, Y: Integer);
    procedure TextAreaNotify(Sender: TObject);
    procedure BBSTextNotify(Sender: TObject);
    procedure EdSalesEditKeyPress (Sender: TObject; var Key: Char);
    procedure SendMail(sTarget: String);
    procedure DMailDlgb1Click(Sender: TObject; X, Y: Integer);
    procedure DMailReadCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMLReadClick(Sender: TObject; X, Y: Integer);
    procedure DMLDelClick(Sender: TObject; X, Y: Integer);
    procedure DMLLockClick(Sender: TObject; X, Y: Integer);
    procedure DMailReadDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMailDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBeltWindowDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBLAddClick(Sender: TObject; X, Y: Integer);
    procedure DBLDelClick(Sender: TObject; X, Y: Integer);
    procedure DBlockListDlgClick(Sender: TObject; X, Y: Integer);
    procedure DBlockListDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBLPgDnClick(Sender: TObject; X, Y: Integer);
    procedure DBLPgUpClick(Sender: TObject; X, Y: Integer);
    procedure DMLBlockClick(Sender: TObject; X, Y: Integer);
    procedure DBlockListDlgMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DBotMemoDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DFriendDlgPostDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DHoldClick(Sender: TObject; X, Y: Integer);
    procedure DSellDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DGTListDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DGTListCloseClick(Sender: TObject; X, Y: Integer);
    procedure ClearGTlist();
    procedure ClearDecolist();
    procedure ClearGameShoplist();
    procedure ClearBBSList();
    procedure DGTListClick(Sender: TObject; X, Y: Integer);
    procedure DGTListPrevClick(Sender: TObject; X, Y: Integer);
    procedure DGTListNextClick(Sender: TObject; X, Y: Integer);
    procedure DGTListDblClick(Sender: TObject);
    procedure DDecoListNextClick(Sender: TObject; X, Y: Integer);
    procedure DDecoListPrevClick(Sender: TObject; X, Y: Integer);
    procedure DDecoListDlgClick(Sender: TObject; X, Y: Integer);
    procedure DDecoListExitClick(Sender: TObject; X, Y: Integer);
    procedure DDecoListDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DDecoListBuyClick(Sender: TObject; X, Y: Integer);
    procedure DBBSListDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBBSListDlgClick(Sender: TObject; X, Y: Integer);
    procedure DBBSListPrevClick(Sender: TObject; X, Y: Integer);
    procedure DBBSListNextClick(Sender: TObject; X, Y: Integer);
    procedure DBBSListRefreshClick(Sender: TObject; X, Y: Integer);
    procedure DBBSListCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBBSListOKClick(Sender: TObject; X, Y: Integer);
    procedure DBBSMsgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBBSMsgDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBBSListWriteClick(Sender: TObject; X, Y: Integer);
    procedure DBBSListNoticeClick(Sender: TObject; X, Y: Integer);
    procedure DBBSMsgOkClick(Sender: TObject; X, Y: Integer);
    procedure DBBSMsgReplyClick(Sender: TObject; X, Y: Integer);
    procedure DBBSMsgDeleteClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsCloseClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsSoundOffClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsSoundOnClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsDropViewOnClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsDropViewOffClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsEffectOffClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsEffectOnClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsSkillBarOffClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsSkillBarOnClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsSkillMode1Click(Sender: TObject; X, Y: Integer);
    procedure DOptionsSkillMode2Click(Sender: TObject; X, Y: Integer);
    procedure DSkillBarDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSkillBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUSGroupClick(Sender: TObject; X, Y: Integer);
    procedure DUSFriendClick(Sender: TObject; X, Y: Integer);
    procedure DUSMailClick(Sender: TObject; X, Y: Integer);
    procedure DSalesMailClick(Sender: TObject; X, Y: Integer);
    procedure DSelectChrClick(Sender: TObject; X, Y: Integer);
    procedure DScrollTopClick(Sender: TObject; X, Y: Integer);
    procedure DScrollUpClick(Sender: TObject; X, Y: Integer);
    procedure DScrollDownClick(Sender: TObject; X, Y: Integer);
    procedure DScrollBottomClick(Sender: TObject; X, Y: Integer);
    procedure DInputKeyEscClick(Sender: TObject; X, Y: Integer);
    procedure DLoginViewKeyClick(Sender: TObject; X, Y: Integer);
    procedure DMsgSimpleDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DMsgSimpleDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DMsgSimpleDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBotHelpDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DInputKeyEscDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DInputKeyEscMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DInputKey0Click(Sender: TObject; X, Y: Integer);
    procedure DInputKeyDelClick(Sender: TObject; X, Y: Integer);
    procedure DInputKeyEnterClick(Sender: TObject; X, Y: Integer);
    procedure DInputKeyRandClick(Sender: TObject; X, Y: Integer);
    procedure DBotHelpClick(Sender: TObject; X, Y: Integer);
    procedure DHelpCloseClick(Sender: TObject; X, Y: Integer);
    procedure DHelpWinDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DOptionsNameAllViewOnClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsNameAllViewOffClick(Sender: TObject; X, Y: Integer);
    procedure DOptionsHPView1Click(Sender: TObject; X, Y: Integer);
    procedure DOptionsHPView2Click(Sender: TObject; X, Y: Integer);
    procedure DHelpPrevClick(Sender: TObject; X, Y: Integer);
    procedure DHelpNextClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemShopDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DItemShopDlgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DItemShopDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DItemShopCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotItemShopClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopJobAllDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemShopJobAllMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DItemShopJobAllClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopJobWarriorClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopJobWizardClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopJobMonkClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopJobCommonClick(Sender: TObject; X, Y: Integer);
    procedure DGrpPgUpClick(Sender: TObject; X, Y: Integer);
    procedure DGrpPgDnClick(Sender: TObject; X, Y: Integer);
    procedure DGTListMailClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopDlgClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopCaAllDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemShopCaAllMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DCountDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCountDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCountDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DCountDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopGetGiftDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemShopGetGiftMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DShopMenuDlgClick(Sender: TObject; X, Y: Integer);
    procedure DShopMenuDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DShopMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DShopMenuScrollUpClick(Sender: TObject; X, Y: Integer);
    procedure DShopMenuScrollDownClick(Sender: TObject; X, Y: Integer);
    procedure DShopMenuScrollBarMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DShopMenuScrollBarMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DShopScrollBarMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DShopScrollBarDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DShopScrollBarMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DShopMenuOkClick(Sender: TObject; X, Y: Integer);
    procedure DShopMenuCloseClick(Sender: TObject; X, Y: Integer);
    procedure DWemadeBuffMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DDcJunsaBuffDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DItemBagClick(Sender: TObject; X, Y: Integer);
    procedure DItemStoreDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DStoreGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DStoreGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DStoreGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DItemStoreCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSafeKeyStorageEscClick(Sender: TObject; X, Y: Integer);
    procedure DSafeKeyStorage0Click(Sender: TObject; X, Y: Integer);
    procedure DSafeKeyStorage0DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DSafeKeyStorageEnterClick(Sender: TObject; X, Y: Integer);
    procedure DSafeKeyStorageDelClick(Sender: TObject; X, Y: Integer);
    procedure DSafeKeyStorageDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DAddBag3DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DAddBag3GridDblClick(Sender: TObject);
    procedure DAddBag3GridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DAddBag3GridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DAddBag3GridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DAddBag3CloseClick(Sender: TObject; X, Y: Integer);
    procedure DAddBag3CloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBotQuestClick(Sender: TObject; X, Y: Integer);
    procedure DRefineDlgDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DRefineGridGridMouseMove(Sender: TObject; ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DRefineGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DRefineGridGridSelect(Sender: TObject; ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DRefineDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DAddBag4GridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DAddBag7GridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DAddBag5GridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DAddBag6GridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DAddBag8GridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
    procedure DItemShopFindClick(Sender: TObject; X, Y: Integer);
    procedure DItemShopPayMoneyClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassSetDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DStoragePassSetKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DStoragePassSetMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DStoragePassSetSafeClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassSetOkClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassSetDelClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DStoragePassKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DStoragePassSetCloseClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DStoragePassOkClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassDelClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassCloseClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassResetDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DStoragePassResetKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DStoragePassResetMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure DStoragePassResetOkClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassResetDelClick(Sender: TObject; X, Y: Integer);
    procedure DStoragePassResetCloseClick(Sender: TObject; X, Y: Integer);
    procedure DItemStorePassResetClick(Sender: TObject; X, Y: Integer);
    procedure DBankDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBankGoldClick(Sender: TObject; X, Y: Integer);
    procedure DBankSlotAddClick(Sender: TObject; X, Y: Integer);
    procedure DBankCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBankPassSetClick(Sender: TObject; X, Y: Integer);
    procedure DBankCell1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBankCell1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBankCell1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBankSlot1Click(Sender: TObject; X, Y: Integer);
    procedure DBankSlot1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DScrollBarDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DScrollBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DScrollBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DGDWarClick(Sender: TObject; X, Y: Integer);
    procedure DGDCancelWarClick(Sender: TObject; X, Y: Integer);
    procedure DAboutDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DAboutCloseClick(Sender: TObject; X, Y: Integer);
    procedure DBotExpandClick(Sender: TObject; X, Y: Integer);

  private
    DlgTemp: TList;
    magcur, magtop: integer;
    EdDlgEdit: TEdit;
    Memo: TMemo;

    ViewDlgEdit: Boolean;
    msglx, msgly: integer;
    MenuTop: integer;
    ShopMenuTop: integer;

    MagKeyIcon, MagKeyCurKey: integer;
    MagKeyMagName: string;
    MagicPage: integer;

    BlinkTime: longword;
    BlinkCount: integer;  //0..9


    procedure HideAllControls;
    procedure RestoreHideControls;
    procedure PageChanged;
    procedure DealItemReturnBag (mitem: TClientItem);
    procedure DealZeroGold;
  public
    MaxLineHeight: Integer;
    StatePage: integer;
    HelpPage: integer;
    MsgText: string;
    DialogSize: integer;
    {
    m_n66C:Integer;
    m_n688:Integer;
    m_n6A4:Integer;
    m_n6A8:Integer;
    }
//    m_Dicea:array[0..35] of Integer;
    m_boMouseMove:Boolean;

    m_nDiceCount:Integer;
    m_boPlayDice:Boolean;
    m_Dice:array[0..9] of TDiceInfo;

    MerchantName: string;
    MerchantFace: integer;
    MDlgStr: string;
    MDlgPoints: TList;
    RequireAddPoints: Boolean;
    SelectMenuStr: string;
    LastestClickTime: longword;
    SpotDlgMode: TSpotDlgMode;

    MenuList: TList; //list of PTClientGoods
    ShopMenuList: TList;
    MenuIndex: integer;
    ShopMenuIndex: integer;
    GameShopMenuIndex: integer;
    CurDetailItem: string;
    AuctionMenuIndex: Integer;
    GTListMenuIndex: Integer;
    MenuTopLine: integer;
    BoDetailMenu: Boolean;
    BoStorageMenu: Boolean;
    BoNoDisplayMaxDura: Boolean;
    BoMakeDrugMenu: Boolean;
    BoMakeGem:Boolean;
    sMakeGemName:String;
    NAHelps: TStringList;
    NewAccountTitle: string;

    DlgEditText: string;
    UserState1: TUserStateInfo;

    Guild: string;
    GuildFlag: string;
    GuildCommanderMode: Boolean;
    GuildStrs: TStringList;
    GuildStrs2: TStringList;
    GuildNotice: TStringList;
    GuildMembers: TStringList;
    GuildTopLine: integer;
    GuildEditHint: string;
    GuildChats: TStringList;
    BoGuildChat: Boolean;
    
    FriendList: Array[0..1] of TList; //List of PTClientFriends
    FriendIndex: Array[0..1] of Integer;
    FriendPage: Integer;
    FriendScreen: Byte; //0 = FriendList, 1 = BlackList

    EdSalesEdit: TMemo;
    EdMemo: TMemo;
    EdMail: TMemo;
    EdMailRead: TMemo;
    BBSMemo: TMemo;    
    EdShopEdit: TMemo;
    EnterPasswd: TEdit;
    EdSetPasswd: TEdit;
    EdSetConfirm: TEdit;
    EdOldPasswd: TEdit;
    EdNewPasswd: TEdit;
    EdConfirm: TEdit;
    
    MailList: TList; //List of pTMailItem
    BlockList: TList; //List of pTBlockItem
    MailIndex: Integer;
    BlockIndex: Integer;    
    MailPage: Integer;
    BlockPage: Integer;

    BBSSticky: integer;

    LastBeltDoubleClick: integer;
    
    procedure Initialize;
    procedure DoBeltSetup;    
    procedure OpenMyStatus;
    procedure OpenUserState (UserState: TUserStateInfo);
    procedure OpenItemBag;
    procedure ViewBottomBox (visible: Boolean);
    procedure CancelItemMoving;
    procedure DropMovingItem;
    procedure OpenAdjustAbility;

    procedure ShowSelectServerDlg;
    function  DMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
    function  DSimpleMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
    function  DCountMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
    procedure ShowMDlg (face: integer; mname, msgstr: string);
    procedure ShowGuildDlg;
    procedure ShowGuildEditNotice;
    procedure ShowGuildEditGrade;

    procedure ResetMenuDlg;
    procedure ShowShopMenuDlg;
    procedure ShowNewShopMenuDlg;
    procedure ShowShopSellDlg;
    procedure ShowStoreDlg;
    procedure CloseDSellDlg;
    procedure CancelGemMaking;
    procedure CloseMDlg;

    procedure ToggleShowGroupDlg;
    procedure OpenDealDlg;
    procedure CloseDealDlg;

    procedure OpenFriendDlg;
    procedure OpenHelpWin;
    procedure OpenQuestAccept;
    procedure OpenItemShopDlg;
    procedure OpenMailDlg;
    procedure OpenBlockListDlg;        

    procedure ToggleAuctionWindow;

    procedure SoldOutGoods (itemserverindex: integer);
    procedure DelStorageItem (itemserverindex: integer);
    procedure GetMouseItemInfo (var iname, line1, line2, line3: string; var useable: boolean);
    procedure SetMagicKeyDlg (icon: integer; magname: string; var curkey: word);
    procedure AddGuildChat (str: string);

    function FindFriendObject(sName: String): pTClientFriends;
    
    procedure ToggleGTListWindow;
    procedure ToggleDecoListWindow;
    procedure ToggleBBSListWindow;
    procedure ToggleBBSMsgWindow;
  end;

var
  FrmDlg: TFrmDlg;

implementation

uses
   ClMain, MShare, Share, SDK, WebForm;
{$R *.DFM}

function TFrmDlg.FindFriendObject(sName: String): pTClientFriends;
var
  A,I: Integer;
  Friend: ptClientFriends;
begin
  for A := 0 to 1 do begin
    for I := 0 to FriendList[A].Count-1 do begin
      Friend := PTClientFriends(FriendList[A].Items[I]);
      if Friend <> nil then begin
        if LowerCase(Friend.Name) = LowerCase(sName) then begin
          Result := Friend;
          exit;
        end;
      end;
    end;
  end;
  Result := nil;
end;

procedure TFrmDlg.FormCreate(Sender: TObject);
begin
   MaxLineHeight := 0;
   StatePage := 0;
   DlgTemp := TList.Create;
   DialogSize := 1;
   m_nDiceCount:=0;
   m_boPlayDice:=False;
   magcur := 0;
   magtop := 0;
   MDlgPoints := TList.Create;
   SelectMenuStr := '';
   MenuList := TList.Create;
   MenuIndex := -1;
   ShopMenuList := TList.Create;
   ShopMenuIndex := -1;
   MenuTopLine := 0;
   BoDetailMenu := FALSE;
   BoStorageMenu := FALSE;
   BoNoDisplayMaxDura := FALSE;
   BoMakeDrugMenu := FALSE;
   MagicPage := 0;
   NAHelps := TStringList.Create;
   BlinkTime := GetTickCount;
   BlinkCount := 0;

   g_SellDlgItem.S.Name := '';
   Guild := '';
   GuildFlag := '';
   GuildCommanderMode := FALSE;
   GuildStrs := TStringList.Create;
   GuildStrs2 := TStringList.Create;
   GuildNotice := TStringList.Create;
   GuildMembers := TStringList.Create;
   GuildChats := TStringList.Create;

   FriendList[F_GOOD] := TList.Create;
   FriendList[F_BAD] := TList.Create;
   FriendIndex[F_GOOD] := -1;
   FriendIndex[F_BAD] := -1;
   FriendScreen := F_GOOD;

   EdMemo := TMemo.Create (FrmMain.Owner);
   with EdMemo do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Name := g_sCurFontName;
      Font.Size := 9;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 100;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
   end;

   EdSalesEdit := TMemo.Create (FrmMain.Owner);
   with EdSalesEdit do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Name := g_sCurFontName;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 100;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
      Left := 34;
      Top := 414;
      Width := 143;
      Height := 19;
   end;

   EdShopEdit := TMemo.Create (FrmMain.Owner);
   with EdShopEdit do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;
      Visible := FALSE;
      MaxLength := 100;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
      Left := 470;
      Top := 45;
      Width := 143;
      Height := 19;
   end;

   EdDlgEdit := TEdit.Create (FrmMain.Owner);
   with EdDlgEdit do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Name := g_sCurFontName;
      Font.Size := 10;
      MaxLength := 30;
      Height := 16;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
   end;

   EnterPasswd := TEdit.Create (FrmMain.Owner);
   with EnterPasswd do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 30;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
      Width := 190;
      Height := 16;
      PasswordChar := '*';
   end;

   EdSetPasswd := TEdit.Create (FrmMain.Owner);
   with EdSetPasswd do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 30;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
      Width := 262;
      Height := 16;
      PasswordChar := '*';
   end;

   EdSetConfirm := TEdit.Create (FrmMain.Owner);
   with EdSetConfirm do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 30;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
      Width := 262;
      Height := 16;
      PasswordChar := '*';
   end;

   EdOldPasswd := TEdit.Create (FrmMain.Owner);
   with EdOldPasswd do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 30;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
      Width := 262;
      Height := 16;
      PasswordChar := '*';
   end;

   EdNewPasswd := TEdit.Create (FrmMain.Owner);
   with EdNewPasswd do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 30;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
      Width := 262;
      Height := 16;
      PasswordChar := '*';
   end;

   EdConfirm := TEdit.Create (FrmMain.Owner);
   with EdConfirm do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 30;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
      Width := 262;
      Height := 16;
      PasswordChar := '*';
   end;

   Memo := TMemo.Create (FrmMain.Owner);
   with Memo do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Name := g_sCurFontName;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
   end;

   MailList := TList.Create;   
   BlockList := TList.Create;

   EdMail := TMemo.Create (FrmMain.Owner);
   with EdMail do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Name := g_sCurFontName;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 100;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
   end;
   EdMailRead := TMemo.Create (FrmMain.Owner);
   with EdMailRead do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Name := g_sCurFontName;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      MaxLength := 100;
      OnMouseMove := DGenericMouseMove;
      OnChange := TextAreaNotify;
      OnClick := TextAreaNotify;
      OnDblClick := TextAreaNotify;
   end;

   BBSMemo := TMemo.Create (FrmMain.Owner);
   with BBSMemo do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Name := g_sCurFontName;
      Font.Size := 10;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
      OnChange := BBSTextNotify;
      //OnMouseMove := DGenericMouseMove;
      //OnChange := TextAreaNotify;
      //OnClick := TextAreaNotify;
      //OnDblClick := TextAreaNotify;
   end;

end;

procedure TFrmDlg.FormDestroy(Sender: TObject);
begin
   DlgTemp.Free;
   MDlgPoints.Free;
   MenuList.Free;
   NAHelps.Free;
   GuildStrs.Free;
   GuildStrs2.Free;
   GuildNotice.Free;
   GuildMembers.Free;
   GuildChats.Free;
   FriendList[F_GOOD].Free;
   FriendList[F_BAD].Free;  
   MailList.Free;
   BlockList.Free;      
end;

procedure TFrmDlg.HideAllControls;
var
   i: integer;
   c: TControl;
begin
   DlgTemp.Clear;
   with FrmMain do
      for i:=0 to ControlCount-1 do begin
         c := Controls[i];
         if c is TEdit then
            if (c.Visible) and (c <> EdDlgEdit) then begin
               DlgTemp.Add (c);
               c.Visible := FALSE;
            end;
      end;
end;

procedure TFrmDlg.RestoreHideControls;
var
   i: integer;
   c: TControl;
begin
   for i:=0 to DlgTemp.Count-1 do begin
      TControl(DlgTemp[i]).Visible := TRUE;
   end;
end;

procedure TFrmDlg.Initialize;
var
   i: integer;
   d: TDirectDrawSurface;
begin
   g_DWinMan.ClearAll;

   DBackground.Left := 0;
   DBackground.Top := 0;
   DBackground.Width := SCREENWIDTH;
   DBackground.Height := SCREENHEIGHT;
   DBackground.Background := TRUE;
   g_DWinMan.AddDControl (DBackground, TRUE);

   {-----------------------------------------------------------}

   d := g_WMainImages.Images[361];
   if d <> nil then begin
      DMsgDlg.SetImgIndex (g_WMainImages, 361);
      DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DMsgDlgOk.SetImgIndex (g_WMainImages, 350);
   DMsgDlgYes.SetImgIndex (g_WMainImages, 352);
   DMsgDlgCancel.SetImgIndex (g_WMainImages, 354);
   DMsgDlgNo.SetImgIndex (g_WMainImages, 356);
   DMsgDlgOk.Top := 106;
   DMsgDlgYes.Top := 106;
   DMsgDlgCancel.Top := 106;
   DMsgDlgNo.Top := 106;

   d := g_WMainImages.Images[990];
   if d <> nil then begin
      DMsgSimpleDlg.SetImgIndex (g_WMainImages, 990);
      DMsgSimpleDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DMsgSimpleDlg.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DMsgSimpleDlgOk.SetImgIndex (g_WMainImages, 991);
   DMsgSimpleDlgCancel.SetImgIndex (g_WMainImages, 993);
   DMsgSimpleDlgOk.Top := 56;
   DMsgSimpleDlgCancel.Top := 56;

   {-----------------------------------------------------------}

   d := g_WMainImages.Images[60];
   if d <> nil then begin
      DLogIn.SetImgIndex (g_WMainImages, 60);
      DLogIn.Left := 230;
      DLogIn.Top := 182;
   end;
   DLoginNew.SetImgIndex (g_WMainImages, 61);
   DLoginNew.Left := 93;
   DLoginNew.Top  := 144;
   DLoginOk.SetImgIndex (g_WMainImages, 42);
   DLoginOk.Left := 245;
   DLoginOk.Top := 77;
   DLoginChgPw.SetImgIndex (g_WMainImages, 53);
   DLoginChgPw.Left := 141;
   DLoginChgPw.Top  := 145;
   DLoginClose.SetImgIndex (g_WMainImages, 41);
   DLoginClose.Left := 141;
   DLoginClose.Top := 171;
   DLoginViewKey.SetImgIndex (g_WMainImages, 1093);
   DLoginViewKey.Left := 93;
   DLoginViewKey.Top := 170;

   d := g_WMainImages.Images[1080];
   if d <> nil then begin
      DInputKey.SetImgIndex (g_WMainImages, 1080);
      DInputKey.Left := 580;
      DInputKey.Top := 315;
   end;
   DInputKeyEsc.SetImgIndex (g_WMainImages, 1090);
   DInputKeyEsc.Left := 10;
   DInputKeyEsc.Top  := 10;
   DInputKey0.SetImgIndex (g_WMainImages, 1081);
   DInputKey0.Left := 10;
   DInputKey0.Top  := 42;
   DInputKey1.SetImgIndex (g_WMainImages, 1081);
   DInputKey1.Left := 41;
   DInputKey1.Top  := 42;
   DInputKey2.SetImgIndex (g_WMainImages, 1081);
   DInputKey2.Left := 72;
   DInputKey2.Top  := 42;
   DInputKey3.SetImgIndex (g_WMainImages, 1081);
   DInputKey3.Left := 103;
   DInputKey3.Top  := 42;
   DInputKey4.SetImgIndex (g_WMainImages, 1081);
   DInputKey4.Left := 133;
   DInputKey4.Top  := 42;
   DInputKey5.SetImgIndex (g_WMainImages, 1081);
   DInputKey5.Left := 164;
   DInputKey5.Top  := 42;
   DInputKey6.SetImgIndex (g_WMainImages, 1081);
   DInputKey6.Left := 10;
   DInputKey6.Top  := 74;
   DInputKey7.SetImgIndex (g_WMainImages, 1081);
   DInputKey7.Left := 41;
   DInputKey7.Top  := 74;
   DInputKey8.SetImgIndex (g_WMainImages, 1081);
   DInputKey8.Left := 72;
   DInputKey8.Top  := 74;
   DInputKey9.SetImgIndex (g_WMainImages, 1081);
   DInputKey9.Left := 103;
   DInputKey9.Top  := 74;
   DInputKeyDel.SetImgIndex (g_WMainImages, 1084);
   DInputKeyDel.Left := 133;
   DInputKeyDel.Top  := 74;
   DInputKeya.SetImgIndex (g_WMainImages, 1081);
   DInputKeya.Left := 10;
   DInputKeya.Top  := 106;
   DInputKeyb.SetImgIndex (g_WMainImages, 1081);
   DInputKeyb.Left := 41;
   DInputKeyb.Top  := 106;
   DInputKeyc.SetImgIndex (g_WMainImages, 1081);
   DInputKeyc.Left := 72;
   DInputKeyc.Top  := 106;
   DInputKeyd.SetImgIndex (g_WMainImages, 1081);
   DInputKeyd.Left := 103;
   DInputKeyd.Top  := 106;
   DInputKeye.SetImgIndex (g_WMainImages, 1081);
   DInputKeye.Left := 133;
   DInputKeye.Top  := 106;
   DInputKeyf.SetImgIndex (g_WMainImages, 1081);
   DInputKeyf.Left := 164;
   DInputKeyf.Top  := 106;
   DInputKeyg.SetImgIndex (g_WMainImages, 1081);
   DInputKeyg.Left := 10;
   DInputKeyg.Top  := 138;
   DInputKeyh.SetImgIndex (g_WMainImages, 1081);
   DInputKeyh.Left := 41;
   DInputKeyh.Top  := 138;
   DInputKeyi.SetImgIndex (g_WMainImages, 1081);
   DInputKeyi.Left := 72;
   DInputKeyi.Top  := 138;
   DInputKeyj.SetImgIndex (g_WMainImages, 1081);
   DInputKeyj.Left := 103;
   DInputKeyj.Top  := 138;
   DInputKeyk.SetImgIndex (g_WMainImages, 1081);
   DInputKeyk.Left := 133;
   DInputKeyk.Top  := 138;
   DInputKeyl.SetImgIndex (g_WMainImages, 1081);
   DInputKeyl.Left := 164;
   DInputKeyl.Top  := 138;
   DInputKeym.SetImgIndex (g_WMainImages, 1081);
   DInputKeym.Left := 10;
   DInputKeym.Top  := 170;
   DInputKeyn.SetImgIndex (g_WMainImages, 1081);
   DInputKeyn.Left := 41;
   DInputKeyn.Top  := 170;
   DInputKeyo.SetImgIndex (g_WMainImages, 1081);
   DInputKeyo.Left := 72;
   DInputKeyo.Top  := 170;
   DInputKeyp.SetImgIndex (g_WMainImages, 1081);
   DInputKeyp.Left := 103;
   DInputKeyp.Top  := 170;
   DInputKeyq.SetImgIndex (g_WMainImages, 1081);
   DInputKeyq.Left := 133;
   DInputKeyq.Top  := 170;
   DInputKeyr.SetImgIndex (g_WMainImages, 1081);
   DInputKeyr.Left := 164;
   DInputKeyr.Top  := 170;
   DInputKeys.SetImgIndex (g_WMainImages, 1081);
   DInputKeys.Left := 10;
   DInputKeys.Top  := 202;
   DInputKeyt.SetImgIndex (g_WMainImages, 1081);
   DInputKeyt.Left := 41;
   DInputKeyt.Top  := 202;
   DInputKeyu.SetImgIndex (g_WMainImages, 1081);
   DInputKeyu.Left := 72;
   DInputKeyu.Top  := 202;
   DInputKeyv.SetImgIndex (g_WMainImages, 1081);
   DInputKeyv.Left := 103;
   DInputKeyv.Top  := 202;
   DInputKeyw.SetImgIndex (g_WMainImages, 1081);
   DInputKeyw.Left := 133;
   DInputKeyw.Top  := 202;
   DInputKeyx.SetImgIndex (g_WMainImages, 1081);
   DInputKeyx.Left := 164;
   DInputKeyx.Top  := 202;
   DInputKeyy.SetImgIndex (g_WMainImages, 1081);
   DInputKeyy.Left := 10;
   DInputKeyy.Top  := 234;
   DInputKeyz.SetImgIndex (g_WMainImages, 1081);
   DInputKeyz.Left := 41;
   DInputKeyz.Top  := 234;
   DInputKeyRand.SetImgIndex (g_WMainImages, 1098);
   DInputKeyRand.Left := 72;
   DInputKeyRand.Top  := 234;
   DInputKeyEnter.SetImgIndex (g_WMainImages, 1087);
   DInputKeyEnter.Left := 133;
   DInputKeyEnter.Top  := 234;
   {-----------------------------------------------------------}
   //服务器选择窗口
   if not EnglishVersion then begin
      d := g_WMainImages.Images[160];
      if d <> nil then begin
         DSelServerDlg.SetImgIndex (g_WMainImages, 160);
         DSelServerDlg.Left := (SCREENWIDTH - d.Width) div 2;
         DSelServerDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      DSSrvClose.SetImgIndex (g_WMainImages, 64);
      DSSrvClose.Left := 448;
      DSSrvClose.Top := 33;

      DSServer1.SetImgIndex (g_WMainImages, 161);
      DSServer1.Left := 134;
      DSServer1.Top  := 102;
      DSServer2.SetImgIndex (g_WMainImages, 162);
      DSServer2.Left := 236;
      DSServer2.Top  := 101;
      DSServer3.SetImgIndex (g_WMainImages, 163);
      DSServer3.Left := 87;
      DSServer3.Top  := 190;
      DSServer4.SetImgIndex (g_WMainImages, 164);
      DSServer4.Left := 280;
      DSServer4.Top  := 190;
      DSServer5.SetImgIndex (g_WMainImages, 165);
      DSServer5.Left := 134;
      DSServer5.Top  := 280;
      DSServer6.SetImgIndex (g_WMainImages, 166);
      DSServer6.Left := 236;
      DSServer6.Top  := 280;
      DEngServer1.Visible := FALSE;
   end else begin
      d := g_WMainImages.Images[256];
      if d <> nil then begin
         DSelServerDlg.SetImgIndex (g_WMainImages, 256);
         DSelServerDlg.Left := (SCREENWIDTH - d.Width) div 2;
         DSelServerDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      DSSrvClose.SetImgIndex (g_WMainImages, 41);
      DSSrvClose.Left := 100;
      DSSrvClose.Top := 481;
{
      DEngServer1.SetImgIndex (g_WMainImages, 257);
      DEngServer1.Left := 65;
      DEngServer1.Top  := 204;
}

      DSServer1.SetImgIndex (g_WMain2Images, 2);
      DSServer1.Left := 40;
      DSServer1.Top  := 75;

      DSServer2.SetImgIndex (g_WMain2Images, 2);
      DSServer2.Left := 40;
      DSServer2.Top  := 120;

      DSServer3.SetImgIndex (g_WMain2Images, 2);
      DSServer3.Left := 40;
      DSServer3.Top  := 165;

      DSServer4.SetImgIndex (g_WMain2Images, 2);
      DSServer4.Left := 40;
      DSServer4.Top  := 210;

      DSServer5.SetImgIndex (g_WMain2Images, 2);
      DSServer5.Left := 40;
      DSServer5.Top  := 255;

      DSServer6.SetImgIndex (g_WMain2Images, 2);
      DSServer6.Left := 40;
      DSServer6.Top  := 300;

      DSServer7.SetImgIndex (g_WMain2Images, 2);
      DSServer7.Left := 40;
      DSServer7.Top  := 345;

      DSServer8.SetImgIndex (g_WMain2Images, 2);
      DSServer8.Left := 40;
      DSServer8.Top  := 390;

      DEngServer1.Visible := FALSE;
      DSServer1.Visible := FALSE;
      DSServer2.Visible := FALSE;
      DSServer3.Visible := FALSE;
      DSServer4.Visible := FALSE;
      DSServer5.Visible := FALSE;
      DSServer6.Visible := FALSE;
      DSServer7.Visible := FALSE;
      DSServer8.Visible := FALSE;
   end;

   {-----------------------------------------------------------}

   //登录窗口
   d := g_WMainImages.Images[63];
   if d <> nil then begin
      DNewAccount.SetImgIndex (g_WMainImages, 63);
      DNewAccount.Left := (SCREENWIDTH - d.Width) div 2;
      DNewAccount.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DNewAccountOk.SetImgIndex (g_WMainImages, 47);
   DNewAccountOk.Left := 160;
   DNewAccountOk.Top := 417;
   DNewAccountCancel.SetImgIndex (g_WMainImages, 48);
   DNewAccountCancel.Left := 448;
   DNewAccountCancel.Top := 419;
   DNewAccountClose.SetImgIndex (g_WMainImages, 86);
   DNewAccountClose.Left := 587;
   DNewAccountClose.Top := 33;

   {-----------------------------------------------------------}

   //修改密码窗口
   d := g_WMainImages.Images[50];
   if d <> nil then begin
      DChgPw.SetImgIndex (g_WMainImages, 50);
      DChgPw.Left := (SCREENWIDTH - d.Width) div 2;
      DChgPw.Top  := (SCREENHEIGHT - d.Height) div 2;
   end;
   DChgpwOk.SetImgIndex (g_WMainImages, 47);
   DChgPwOk.Left := 182;
   DChgPwOk.Top := 252;
   DChgpwCancel.SetImgIndex (g_WMainImages, 48);
   DChgPwCancel.Left := 277;
   DChgPwCancel.Top := 251;

   {-----------------------------------------------------------}

   //选择角色窗口
   DSelectChr.Left := 0;
   DSelectChr.Top := 0;
   DSelectChr.Width := SCREENWIDTH;
   DSelectChr.Height := SCREENHEIGHT;
   DscSelect1.SetImgIndex (g_WMainImages, 66);
   DscSelect2.SetImgIndex (g_WMainImages, 66);
   DscSelect3.SetImgIndex (g_WMainImages, 66);   
   DscStart.SetImgIndex (g_WMainImages, 68);
   DscNewChr.SetImgIndex (g_WMainImages, 69);
   DscEraseChr.SetImgIndex (g_WMainImages, 70);
   DscCredits.SetImgIndex (g_WMainImages, 71);
   DscExit.SetImgIndex (g_WMainImages, 72);

      DscSelect1.Left := (SCREENWIDTH - 800) div 2 + 111;
      DscSelect1.Top := (SCREENHEIGHT - 600) div 2 + 393;
      DscSelect2.Left := (SCREENWIDTH - 800) div 2 + 345;
      DscSelect2.Top := (SCREENHEIGHT - 600) div 2 + 393;
      DscSelect3.Left := (SCREENWIDTH - 800) div 2 + 585;
      DscSelect3.Top := (SCREENHEIGHT - 600) div 2 + 393;
      DscStart.Left := (SCREENWIDTH - 800) div 2 + 413;
      DscStart.Top := (SCREENHEIGHT - 600) div 2 + 436;
      DscNewChr.Left := (SCREENWIDTH - 800) div 2 + 413;
      DscNewChr.Top := (SCREENHEIGHT - 600) div 2 + 465;
      DscEraseChr.Left := (SCREENWIDTH - 800) div 2 + 413;
      DscEraseChr.Top := (SCREENHEIGHT - 600) div 2 + 494;
      DscCredits.Left := (SCREENWIDTH - 800) div 2 + 413;
      DscCredits.Top := (SCREENHEIGHT - 600) div 2 + 523;
      DscExit.Left := (SCREENWIDTH - 800) div 2 + 413;
      DscExit.Top := (SCREENHEIGHT - 600) div 2 + 552;

   {-----------------------------------------------------------}

   //创建角色窗口
   d := g_WMainImages.Images[73];
   if d <> nil then begin
      DCreateChr.SetImgIndex (g_WMainImages, 73);
      DCreateChr.Left := (SCREENWIDTH - d.Width) div 2;
      DCreateChr.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DccWarrior.SetImgIndex (g_WMainImages, 55);
   DccWizzard.SetImgIndex (g_WMainImages, 56);
   DccMonk.SetImgIndex (g_WMainImages, 57);
   //DccReserved.SetImgIndex (g_WMainImages.Images[76], TRUE);
   DccMale.SetImgIndex (g_WMainImages, 58);
   DccFemale.SetImgIndex (g_WMainImages, 59);
   DccOk.SetImgIndex (g_WMainImages, 47);
   DccClose.SetImgIndex (g_WMainImages, 48);
      DccWarrior.Left := 360;
      DccWarrior.Top := 206;
      DccWizzard.Left := 407;
      DccWizzard.Top := 206;
      DccMonk.Left := 454;
      DccMonk.Top := 206;
      //DccReserved.Left := 183;
      //DccReserved.Top := 157;
      DccMale.Left := 407;
      DccMale.Top := 297;
      DccFemale.Left := 454;
      DccFemale.Top := 297;
      DccOk.Left := 359;
      DccOk.Top := 399;
      DccClose.Left := 471;
      DccClose.Top := 399;


   {-----------------------------------------------------------}
   d := g_WMainImages.Images[50];
   if d <> nil then begin
      DChgGamePwd.SetImgIndex (g_WMainImages, 689);
      DChgGamePwd.Left := (SCREENWIDTH - d.Width) div 2;
      DChgGamePwd.Top  := (SCREENHEIGHT - d.Height) div 2;
   end;
   DChgGamePwdClose.Left := 291;
   DChgGamePwdClose.Top := 8;
   DChgGamePwdClose.SetImgIndex (g_WMainImages, 64);


   //人物状态窗口
   d := g_WMainImages.Images[370];
   if d <> nil then begin
      DStateWin.SetImgIndex (g_WMainImages, 370);
      DStateWin.Left := SCREENWIDTH - d.Width;
      DStateWin.Top := 0;
   end;
      DSWNecklace.Left := 38 + 130;
      DSWNecklace.Top  := 59 + 35;
      DSWNecklace.Width := 34;
      DSWNecklace.Height := 31;
      DSWHelmet.Left := 38 + 77;
      DSWHelmet.Top  := 59 + 41;
      DSWHelmet.Width := 18;
      DSWHelmet.Height := 18;
      DSWLight.Left := 38 + 130;
      DSWLight.Top  := 59 + 73;
      DSWLight.Width := 34;
      DSWLight.Height := 31;
      DSWArmRingR.Left := 38 + 4;
      DSWArmRingR.Top  := 59 + 124;
      DSWArmRingR.Width := 34;
      DSWArmRingR.Height := 31;
      DSWArmRingL.Left := 38 + 130;
      DSWArmRingL.Top  := 59 + 124;
      DSWArmRingL.Width := 34;
      DSWArmRingL.Height := 31;
      DSWRingR.Left := 38 + 4;
      DSWRingR.Top  := 59 + 163;
      DSWRingR.Width := 34;
      DSWRingR.Height := 31;
      DSWRingL.Left := 38 + 130;
      DSWRingL.Top  := 59 + 163;
      DSWRingL.Width := 34;
      DSWRingL.Height := 31;
      DSWWeapon.Left := 38 + 9;
      DSWWeapon.Top  := 59 + 28;
      DSWWeapon.Width := 47;
      DSWWeapon.Height := 87;
      DSWDress.Left := 38 + 58;
      DSWDress.Top  := 59 + 70;
      DSWDress.Width := 53;
      DSWDress.Height := 112;

      DSWBujuk.Left := 42;
      DSWBujuk.Top  := 261;
      DSWBujuk.Width := 34;
      DSWBujuk.Height := 31;

      DSWBelt.Left := 84;
      DSWBelt.Top  := 261;
      DSWBelt.Width := 34;
      DSWBelt.Height := 31;

      DSWBoots.Left := 126;
      DSWBoots.Top  := 261;
      DSWBoots.Width := 34;
      DSWBoots.Height := 31;

      DSWCharm.Left := 168;
      DSWCharm.Top  := 261;
      DSWCharm.Width := 34;
      DSWCharm.Height := 31;

      DStMag1.Left := 38 + 6;
      DStMag1.Top := 59 + 7+20;
      DStMag1.Width := 31;
      DStMag1.Height := 33;

      DStMag2.Left := 38 + 6;
      DStMag2.Top := 59 + 44+20;
      DStMag2.Width := 31;
      DStMag2.Height := 33;

      DStMag3.Left := 38 + 6;
      DStMag3.Top := 59 + 82+20;
      DStMag3.Width := 31;
      DStMag3.Height := 33;

      DStMag4.Left := 38 + 6;
      DStMag4.Top := 59 + 119+20;
      DStMag4.Width := 31;
      DStMag4.Height := 33;

      DStMag5.Left := 38 + 6;
      DStMag5.Top := 59 + 156+20;
      DStMag5.Width := 31;
      DStMag5.Height := 33;

      DStPageUp.SetImgIndex (g_WMainImages, 398);
      DStPageDown.SetImgIndex (g_WMainImages, 396);
      DStPageUp.Left := 213+4;
      DStPageUp.Top  := 113+32;
      DStPageDown.Left := 213+4;
      DStPageDown.Top  := 143+33;

   DCloseState.SetImgIndex (g_WMainImages, 86);
   DCloseState.Left := 208;
   DCloseState.Top := 5;
   DPrevState.SetImgIndex (g_WMainImages, 373);
   DNextState.SetImgIndex (g_WMainImages, 372);
   DPrevState.Left := 5;
   DPrevState.Top := 138;
   DNextState.Left := 5;
   DNextState.Top := 197;

   {-----------------------------------------------------------}

   //人物状态窗口(查看别人信息)
   d := g_WMainImages.Images[370];
   if d <> nil then begin
      DUserState1.SetImgIndex (g_WMainImages, 430);
      DUserState1.Left := SCREENWIDTH - d.Width - d.Width;
      DUserState1.Top := 0;
   end;
      DNecklaceUS1.Left := 38 + 130;
      DNecklaceUS1.Top  := 59 + 35;
      DNecklaceUS1.Width := 34;
      DNecklaceUS1.Height := 31;

      DHelmetUS1.Left := 38 + 77;
      DHelmetUS1.Top  := 59 + 41;
      DHelmetUS1.Width := 18;
      DHelmetUS1.Height := 18;

      DLightUS1.Left := 38 + 130;
      DLightUS1.Top  := 59 + 73;
      DLightUS1.Width := 34;
      DLightUS1.Height := 31;

      DArmRingRUS1.Left := 38 + 4;
      DArmRingRUS1.Top  := 59 + 124;
      DArmRingRUS1.Width := 34;
      DArmRingRUS1.Height := 31;

      DArmRingLUS1.Left := 38 + 130;
      DArmRingLUS1.Top  := 59 + 124;
      DArmRingLUS1.Width := 34;
      DArmRingLUS1.Height := 31;
      
      DRingRUS1.Left := 38 + 4;
      DRingRUS1.Top  := 59 + 163;
      DRingRUS1.Width := 34;
      DRingRUS1.Height := 31;

      DRingLUS1.Left := 38 + 130;
      DRingLUS1.Top  := 59 + 163;
      DRingLUS1.Width := 34;
      DRingLUS1.Height := 31;

      DWeaponUS1.Left := 38 + 9;
      DWeaponUS1.Top  := 59 + 28;
      DWeaponUS1.Width := 47;
      DWeaponUS1.Height := 87;

      DDressUS1.Left := 38 + 58;
      DDressUS1.Top  := 59 + 70;
      DDressUS1.Width := 53;
      DDressUS1.Height := 112;

      DBujukUS1.Left := 42;
      DBujukUS1.Top  := 261;
      DBujukUS1.Width := 34;
      DBujukUS1.Height := 31;

      DBeltUS1.Left := 84;
      DBeltUS1.Top  := 261;
      DBeltUS1.Width := 34;
      DBeltUS1.Height := 31;

      DBootsUS1.Left := 126;
      DBootsUS1.Top  := 261;
      DBootsUS1.Width := 34;
      DBootsUS1.Height := 31;

      DCharmUS1.Left := 168;
      DCharmUS1.Top  := 261;
      DCharmUS1.Width := 34;
      DCharmUS1.Height := 31;

   // 好友, 组队和邮件按钮
   DUSFriend.Left := 104;
   DUSFriend.Top := 303;
   DUSFriend.SetImgIndex (g_WMainImages, 432);

   DUSMail.Left := 137;
   DUSMail.Top := 303;
   DUSMail.SetImgIndex (g_WMainImages, 433);

   DUSGroup.Left := 71;
   DUSGroup.Top := 303;
   DUSGroup.SetImgIndex (g_WMainImages, 431);

   DCloseUS1.SetImgIndex (g_WMainImages, 86);
   DCloseUS1.Left := 208;
   DCloseUS1.Top := 5;

  {-------------------------------------------------------------}

   //背包物品窗口
   DItemBag.SetImgIndex (g_WMainImages, 3);
   DItemBag.Left := 0;
   DItemBag.Top := 0;

   DItemGrid.Left := 28;
   DItemGrid.Top  := 25;
   DItemGrid.Width := 288;
   DItemGrid.Height := 162;

  {-------------------------------------------------------------}
  //公会领土
  DGTList.SetImgIndex(g_WMainImages, 680);
  DGTList.Left := 0;
  DGTList.Top := 209;

  DGTListClose.SetImgIndex(g_WMainImages, 86);
  DGTListClose.Left := 534;
  DGTListClose.Top := 5;

  DGTListPrev.SetImgIndex(g_WMainImages, 388);
  DGTListPrev.Left :=214;
  DGTListPrev.Top := 213;

  DGTListNext.SetImgIndex(g_WMainImages, 387);
  DGTListNext.Left :=317;
  DGTListNext.Top := 213;

  DGTListMail.SetImgIndex(g_WMainImages, 666);
  DGTListMail.Left :=265;
  DGTListMail.Top := 210;

  DDecoListDlg.SetImgIndex(g_WMainImages, 702);
  DDecoListDlg.Left := 0;
  DDecoListDlg.Top  := 20;

  DDecoListExit.SetImgIndex(g_WMainImages, 86);
  DDecoListExit.Left := 606;
  DDecoListExit.Top  := 5;

  DDecoListPrev.SetImgIndex(g_WMainImages, 388);
  DDecoListPrev.Left :=255;
  DDecoListPrev.Top  := 382;

  DDecoListNext.SetImgIndex(g_WMainImages, 387);
  DDecoListNext.Left :=358;
  DDecoListNext.Top  := 382;

  DDecoListBuy.SetImgIndex (g_WMainImages, 678);
  DDecoListBuy.Left := 220;
  DDecoListBuy.Top  := 320;

  DDecoListCancel.SetImgIndex (g_WMainImages, 652);
  DDecoListCancel.Left := 220;
  DDecoListCancel.Top  := 352;

  DBBSListDlg.SetImgIndex(g_WMainImages, 688);
  DBBSListDlg.Left := 0;
  DBBSListDlg.Top  := 40;

  DBBSListClose.SetImgIndex(g_WMainImages, 86);
  DBBSListClose.Left := 432;
  DBBSListClose.Top  := 5;

  DBBSListPrev.SetImgIndex(g_WMainImages, 388);
  DBBSListPrev.Left :=163;
  DBBSListPrev.Top  := 321;

  DBBSListNext.SetImgIndex(g_WMainImages, 387);
  DBBSListNext.Left :=266;
  DBBSListNext.Top  := 321;

  DBBSListRefresh.SetImgIndex(g_WMainImages, 665);
  DBBSListRefresh.Left :=214;
  DBBSListRefresh.Top  := 321;

  DBBSListOk.SetImgIndex(g_WMainImages, 650);
  DBBSListOk.Left :=223;
  DBBSListOk.Top  := 280;

  DBBSListWrite.SetImgIndex(g_WMainImages, 693);
  DBBSListWrite.Left :=291;
  DBBSListWrite.Top  := 280;

  DBBSListNotice.SetImgIndex(g_WMainImages, 695);
  DBBSListNotice.Left :=360;
  DBBSListNotice.Top  := 280;

  DBBSMsgDlg.SetImgIndex(g_WMainImages, 689);
  DBBSMsgDlg.Left := 200;
  DBBSMsgDlg.Top  := 150;

  DBBSMsgClose.SetImgIndex(g_WMainImages, 86);
  DBBSMsgClose.Left := 324;
  DBBSMsgClose.Top  := 5;

  DBBSMsgOk.SetImgIndex(g_WMainImages, 650);
  DBBSMsgOk.Left :=188;
  DBBSMsgOk.Top  := 210;

  DBBSMsgCancel.SetImgIndex(g_WMainImages, 652);
  DBBSMsgCancel.Left :=255;
  DBBSMsgCancel.Top  := 210;

  DBBSMsgReply.SetImgIndex(g_WMainImages, 699);
  DBBSMsgReply.Left :=125;
  DBBSMsgReply.Top  := 210;

  DBBSMsgMail.SetImgIndex(g_WMainImages, 666);
  DBBSMsgMail.Left :=102;
  DBBSMsgMail.Top  := 210;

  DBBSMsgDelete.SetImgIndex(g_WMainImages, 697);
  DBBSMsgDelete.Left :=38;
  DBBSMsgDelete.Top  := 210;
  {-------------------------------------------------------------}
  //sales

   DSales.SetImgIndex (g_WMainImages, 670);
   DSales.Left := 0;
   DSales.Top := 60;

   DSalesFind.SetImgIndex (g_WMainImages, 676);
   DSalesFind.Left := 180;
   DSalesFind.Top := 353;

   DSalesBuy.SetImgIndex (g_WMainImages, 678);
   DSalesBuy.Left := 346;
   DSalesBuy.Top := 353;

   DSalesCancel.SetImgIndex (g_WMainImages, 652);
   DSalesCancel.Left := 415;
   DSalesCancel.Top := 353;

   DSalesMail.SetImgIndex (g_WMainImages, 666);
   DSalesMail.Left := 317;
   DSalesMail.Top := 353;

   DSalesClose.SetImgIndex (g_WMainImages, 86);
   DSalesClose.Left := 491;
   DSalesClose.Top := 5;

   DSalesRefresh.SetImgIndex(g_WMainImages, 665);
   DSalesRefresh.Left := 248;
   DSalesRefresh.Top := 389;

   DSalesNextPage.SetImgIndex(g_WMainImages, 387);
   DSalesNextPage.Left := 301;
   DSalesNextPage.Top := 389;

   DSalesPrevPage.SetImgIndex(g_WMainImages, 388);
   DSalesPrevPage.Left := 198;
   DSalesPrevPage.Top := 389;

   DAuctionImg.Left := 253;
   DAuctionImg.Top := 304;
   DAuctionImg.Width := 36;
   DAuctionImg.Height := 45;

   {-----------------------------------------------------------}
   //选项

   DOptions.SetImgIndex (g_WMainImages, 770);
   DOptions.Left := 0;
   DOptions.Top := 60;

   DOptionsClose.SetImgIndex (g_WMainImages, 86);
   DOptionsClose.Left := 274;
   DOptionsClose.Top := 5;

   DOptionsSkillMode1.Left := 166;
   DOptionsSkillMode1.Top := 77; 

   DOptionsSkillMode2.Left := 208;
   DOptionsSkillMode2.Top := 77;

   DOptionsSkillBarOn.Left := 166;
   DOptionsSkillBarOn.Top := 99;

   DOptionsSkillBarOff.Left := 208;
   DOptionsSkillBarOff.Top := 99;

   DOptionsEffectOn.Left := 166;
   DOptionsEffectOn.Top := 121;

   DOptionsEffectOff.Left := 208;
   DOptionsEffectOff.Top := 121;

   DOptionsSoundOn.Left := 166;
   DOptionsSoundOn.Top := 143;

   DOptionsSoundOff.Left := 208;
   DOptionsSoundOff.Top := 143;

   DOptionsDropViewOn.Left := 166;
   DOptionsDropViewOn.Top := 165;

   DOptionsDropViewOff.Left := 208;
   DOptionsDropViewOff.Top := 165;

   DOptionsNameAllViewOn.Left := 166;
   DOptionsNameAllViewOn.Top := 187;

   DOptionsNameAllViewOff.Left := 208;
   DOptionsNameAllViewOff.Top := 187;

   DOptionsHPView1.Left := 166;
   DOptionsHPView1.Top := 209;

   DOptionsHPView2.Left := 208;
   DOptionsHPView2.Top := 209;

   {-----------------------------------------------------------}
   // 技能条

   DSkillBar.Left := 0;
   DSkillBar.Top := 0;

   DSkillBar1.Left := 7;
   DSkillBar1.Top := 6;

   DSkillBar2.Left := 39;
   DSkillBar2.Top := 6;

   DSkillBar3.Left := 71;
   DSkillBar3.Top := 6;

   DSkillBar4.Left := 103;
   DSkillBar4.Top := 6;

   DSkillBar5.Left := 140;
   DSkillBar5.Top := 6;

   DSkillBar6.Left := 172;
   DSkillBar6.Top := 6;

   DSkillBar7.Left := 204;
   DSkillBar7.Top := 6;

   DSkillBar8.Left := 236;
   DSkillBar8.Top := 6;

   {-----------------------------------------------------------}
   
   //主控面板
{$IF SWH = SWH800}
   d := g_WMainImages.Images[BOTTOMBOARD800];
{$ELSEIF SWH = SWH1024}
   d := g_WMainImages.Images[BOTTOMBOARD1024];
{$IFEND}
   if d <> nil then begin
      DBottom.Left := 0;
      DBottom.Top  := SCREENHEIGHT - d.Height;
      DBottom.Width := d.Width;
      DBottom.Height := d.Height;
   end;
   {-----------------------------------------------------------}
   //功能按钮
   DMyState.SetImgIndex (g_WMainImages, 8);
   DMyState.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (409 - 244));
   DMyState.Top := 65;
   DMyBag.SetImgIndex (g_WMainImages, 9);
   DMyBag.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (407 - 282));
   DMyBag.Top := 49;
   DMyMagic.SetImgIndex (g_WMainImages, 10);
   DMyMagic.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (405 - 322));
   DMyMagic.Top := 38;
   DOption.SetImgIndex (g_WMainImages, 11);
   DOption.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (405 - 364));
   DOption.Top := 31;

   {-----------------------------------------------------------}
   //快捷按钮
   DBotMiniMap.SetImgIndex (g_WMainImages, 131);
   DBotMiniMap.Left := 181;
   DBotMiniMap.Top := 85;
   DBotMiniMap.DontDrawUp := True;
   DBotTrade.SetImgIndex (g_WMainImages,133);
   DBotTrade.Left := 181;
   DBotTrade.Top := 110;
   DBotTrade.DontDrawUp := True;
   DBotGuild.SetImgIndex (g_WMainImages,135);
   DBotGuild.Left := 181;
   DBotGuild.Top := 135;
   DBotGuild.DontDrawUp := True;
   DBotGroup.SetImgIndex (g_WMainImages,129);
   DBotGroup.Left := 181;
   DBotGroup.Top := 160;
   DBotGroup.DontDrawUp := True;
   DBotFriend.SetImgIndex (g_WMainImages,531);
   DBotFriend.Left := 181;
   DBotFriend.Top := 184;
   DBotFriend.DontDrawUp := True;
   DBotLover.SetImgIndex (g_WMainImages,529);
   DBotLover.Left := 603;
   DBotLover.Top := 85;
   DBotLover.DontDrawUp := True;
   DBotQuest.SetImgIndex (g_WMainImages,962);
   DBotQuest.Left := 603;
   DBotQuest.Top := 110;
   DBotQuest.DontDrawUp := True;
   DBotExpand.SetImgIndex (g_WMain3Images,1);
   DBotExpand.Left := 603;
   DBotExpand.Top := 135;
   DBotExpand.DontDrawUp := True;
   DBotHelp.SetImgIndex (g_WMainImages,921);
   DBotHelp.Left := 603;
   DBotHelp.Top := 184;
   DBotHelp.DontDrawUp := True;
   DBotExit.SetImgIndex (g_WMainImages,139);
   DBotExit.Left := 589;
   DBotExit.Top := 56;
   DBotExit.DontDrawUp := True;
   DBotLogout.SetImgIndex (g_WMainImages,137);
   DBotLogout.Left := 565;
   DBotLogout.Top := 56;
   DBotLogout.DontDrawUp := True;
   DBotMemo.SetImgIndex (g_WMainImages,533);
   DBotMemo.Left := 720;
   DBotMemo.Top := 83;

   DBotItemShop.SetImgIndex (g_WMainImages,DlgConf.DBotItemShop.Image{826});
   DBotItemShop.Left := DlgConf.DBotItemShop.Left{680};
   DBotItemShop.Top := DlgConf.DBotItemShop.Top{90};
   DBotItemShop.DontDrawUp := True;
   DBotGift.SetImgIndex (g_WMainImages,533);
   DBotGift.Left := 720;
   DBotGift.Top := 83;
   DBotItemShop.DontDrawUp := True;

   DBotPlusAbil.SetImgIndex (g_WMainImages,141);
   DBotPlusAbil.Left := 181;
   DBotPlusAbil.Top := 1;
   {-----------------------------------------------------------}
   DScrollTop.SetImgIndex (g_WMainImages, DlgConf.DScrollTop.Image{130});
   DScrollTop.Left := DlgConf.DScrollTop.Left{219};
   DScrollTop.Top := DlgConf.DScrollTop.Top{104};
   DScrollUp.SetImgIndex (g_WMainImages, DlgConf.DScrollUp.Image{130});
   DScrollUp.Left := DlgConf.DScrollUp.Left{219};
   DScrollUp.Top := DlgConf.DScrollUp.Top{104};
   DScrollDown.SetImgIndex (g_WMainImages, DlgConf.DScrollDown.Image{130});
   DScrollDown.Left := DlgConf.DScrollDown.Left{219};
   DScrollDown.Top := DlgConf.DScrollDown.Top{104};
   DScrollBottom.SetImgIndex (g_WMainImages, DlgConf.DScrollBottom.Image{130});
   DScrollBottom.Left := DlgConf.DScrollBottom.Left{219};
   DScrollBottom.Top := DlgConf.DScrollBottom.Top{104};
   {-----------------------------------------------------------}

   DGold.SetImgIndex (g_WMainImages, 29);
   DGold.Left := 13;
   DGold.Top  := 208;

   DRepairItem.SetImgIndex (g_WMainImages, 26);
   DRepairItem.Left := 254;
   DRepairItem.Top := 183;
   DRepairItem.Width := 48;
   DRepairItem.Height := 22;
   DClosebag.SetImgIndex (g_WMainImages, 86);
   DCloseBag.Left := 322;
   DCloseBag.Top := 5;
   DCloseBag.Width := 14;
   DCloseBag.Height := 20;

   d := g_WMainImages.Images[583];
   if d <> nil then begin
      DLoverWindow.SetImgIndex (g_WMainImages, 583);
      DLoverWindow.Left := 0;
      DLoverWindow.Top := 0;
      DLoverWindow.Width := 324;
      DLoverWindow.Height := 458;

      DLoverAvailable.SetImgIndex (g_WMainImages, 600);
      DLoverAvailable.Top := 155;
      DLoverAvailable.Left := 40;

      DLoverAsk.SetImgIndex (g_WMainImages, 598);
      DLoverAsk.Top := 155;
      DLoverAsk.Left := 32+45;

      DLoverDivorce.SetImgIndex (g_WMainImages, 594);
      DLoverDivorce.Top := 155;
      DLoverDivorce.Left := 32+32+50;

      DLoverExit.SetImgIndex (g_WMainImages, 86);
      DLoverExit.Top := 5;
      DLoverExit.Left := 300;

      DLoverCaption.SetImgIndex (g_WMainImages, 580);
      DLoverCaption.Top := 160;
      DLoverCaption.Left := 146+40;

      DMasterCaption.SetImgIndex (g_WMainImages, 581);
      DMasterCaption.Top := 408-25;
      DMasterCaption.Left := 55;

      DLoverHeart.SetImgIndex (g_WMainImages, 604);
      DLoverHeart.Top := DLoverWindow.Left + 11;
      DLoverHeart.Left := DLoverWindow.Top + 72;

      DHeartMyState.SetImgIndex (g_WMainImages, 604);
      DHeartMyState.Top := DLoverWindow.Left + 11;
      DHeartMyState.Left := DLoverWindow.Top + 72;
      //SurfaceX(Left + 45), SurfaceY(Top + 23),
   end;

   {-----------------------------------------------------------}

   d := g_WMainImages.Images[384];
   if d <> nil then begin
   //milo
      DMerchantDlg.Left := 0;
      DMerchantDlg.Top := 0;
      DMerchantDlg.SetImgIndex (g_WMainImages, 384);
   end;
   DMerchantDlgClose.Left := 409;
   DMerchantDlgClose.Top := 5;
   DMerchantDlgClose.SetImgIndex (g_WMainImages, 86);
   {-----------------------------------------------------------}
   //配置窗口
   d := g_WMainImages.Images[204];
   if d <> nil then begin
      DConfigDlg.SetImgIndex (g_WMainImages, 204);
      DConfigDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DConfigDlg.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DConfigDlgOk.SetImgIndex (g_WMainImages, 361);
   DConfigDlgOk.Left := 514;
   DConfigDlgOk.Top := 287;
   DConfigDlgClose.Left := 584;
   DConfigDlgClose.Top := 6;
   DConfigDlgClose.SetImgIndex (g_WMainImages, 86);

   {-----------------------------------------------------------}

   d := g_WMainImages.Images[385];
   if d <> nil then begin
      DMenuDlg.Left := 138;
      DMenuDlg.Top  := 163;
      DMenuDlg.SetImgIndex (g_WMainImages, 385);
   end;
   DMenuPrev.Left := 43+32;
   DMenuPrev.Top := 175+16;
   DMenuPrev.SetImgIndex (g_WMainImages, 388);
   DMenuNext.Left := 90+44;
   DMenuNext.Top := 175+16;
   DMenuNext.SetImgIndex (g_WMainImages, 387);
   DMenuBuy.Left := 210;
   DMenuBuy.Top := 187;
   DMenuBuy.SetImgIndex (g_WMainImages, 386);
   DMenuClose.Left := 291+14;
   DMenuClose.Top := 0+5;
   DMenuClose.SetImgIndex (g_WMainImages, 86);

   {-----------------------------------------------------------}
//新商店菜单
   d := g_WMainImages.Images[1000];
   if d <> nil then begin
      DShopMenuDlg.Left := 138;
      DShopMenuDlg.Top  := 163;
      DShopMenuDlg.SetImgIndex (g_WMainImages, 1000);
   end;
   DShopMenuOk.SetImgIndex (g_WMainImages, 991);
   DShopMenuOk.Left := 157;
   DShopMenuOk.Top := 206;
   DShopMenuClose.SetImgIndex (g_WMainImages, 86);
   DShopMenuClose.Left := 257;
   DShopMenuClose.Top := 5;
   DShopMenuScrollUp.SetImgIndex (g_WMainImages, 979);
   DShopMenuScrollUp.Left := 239;
   DShopMenuScrollUp.Top := 28;
   DShopMenuScrollBar.SetImgIndex (g_WMainImages, 982);
   DShopMenuScrollBar.Left := 239;
   DShopMenuScrollBar.Top := 100;
   DShopMenuScrollDown.SetImgIndex (g_WMainImages, 980);
   DShopMenuScrollDown.Left := 239;
   DShopMenuScrollDown.Top := 190;


   d := g_WMainImages.Images[1002];
   if d <> nil then begin
      DRefineDlg.Left := 138;
      DRefineDlg.Top  := 163;
      DRefineDlg.SetImgIndex (g_WMainImages, 1002);
   end;
   DRefineGrid.Left := 29;
   DRefineGrid.Top := 55;
   DRefineGrid.Width := 144;
   DRefineGrid.Height := 130;
   DRefineDlgClose.SetImgIndex (g_WMainImages, 86);
   DRefineDlgClose.Left := 172;
   DRefineDlgClose.Top := 5;
   DRefineOk.SetImgIndex (g_WMainImages, 1003);
   DRefineOk.Left := 62;
   DRefineOk.Top := 188;
   {-----------------------------------------------------------}

   d := g_WMainImages.Images[392];
   if d <> nil then begin
      DSellDlg.Left := 328;
      DSellDlg.Top  := 163;
      DSellDlg.SetImgIndex (g_WMainImages, 392);
   end;
   DSellDlgOk.Left := 114;
   DSellDlgOk.Top := 72;
   DSellDlgOk.SetImgIndex (g_WMainImages, 393);
   DSellDlgClose.Left := 147;
   DSellDlgClose.Top := 16;
   DSellDlgClose.SetImgIndex (g_WMainImages, 86);
   DHold.Left := 114;
   DHold.Top := 43;
   DHold.SetImgIndex (g_WMainImages, 404);
   DSellDlgSpot.Left := 27;
   DSellDlgSpot.Top  := 67;
   DSellDlgSpot.Width := 61;
   DSellDlgSpot.Height := 52;

   {-----------------------------------------------------------}

   //设置魔法快捷对话框
   d := g_WMainImages.Images[710];
   if d <> nil then begin
      DKeySelDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DKeySelDlg.Top  := (SCREENHEIGHT - d.Height) div 2;
      DKeySelDlg.SetImgIndex (g_WMainImages, 710);
   end;
   DKsIcon.Left := 50;
   DKsIcon.Top := 36;
   DKsF1.SetImgIndex (g_WMainImages, 713);
   DKsF1.Left := 52;
   DKsF1.Top  := 80;
   DKsF2.SetImgIndex (g_WMainImages, 715);
   DKsF2.Left := 57+27;
   DKsF2.Top  := 80;
   DKsF3.SetImgIndex (g_WMainImages, 717);
   DKsF3.Left := 89 + 27;
   DKsF3.Top  := 80;
   DKsF4.SetImgIndex (g_WMainImages, 719);
   DKsF4.Left := 121+27;
   DKsF4.Top  := 80;
   DKsF5.SetImgIndex (g_WMainImages, 721);
   DKsF5.Left := 160+25;
   DKsF5.Top  := 80;
   DKsF6.SetImgIndex (g_WMainImages, 723);
   DKsF6.Left := 192+25;
   DKsF6.Top  := 80;
   DKsF7.SetImgIndex (g_WMainImages, 725);
   DKsF7.Left := 224+25;
   DKsF7.Top  := 80;
   DKsF8.SetImgIndex (g_WMainImages, 727);
   DKsF8.Left := 256+25;
   DKsF8.Top := 80;

   DKsConF1.SetImgIndex (g_WMainImages, 729);
   DKsConF1.Left := 25+27;
   DKsConF1.Top  := 117;
   DKsConF2.SetImgIndex (g_WMainImages, 731);
   DKsConF2.Left := 57+27;
   DKsConF2.Top  := 117;
   DKsConF3.SetImgIndex (g_WMainImages, 733);
   DKsConF3.Left := 89+27;
   DKsConF3.Top  := 117;
   DKsConF4.SetImgIndex (g_WMainImages, 735);
   DKsConF4.Left := 121+27;
   DKsConF4.Top  := 117;
   DKsConF5.SetImgIndex (g_WMainImages, 737);
   DKsConF5.Left := 160+25;
   DKsConF5.Top  := 117;
   DKsConF6.SetImgIndex (g_WMainImages, 739);
   DKsConF6.Left := 192+25;
   DKsConF6.Top  := 117;
   DKsConF7.SetImgIndex (g_WMainImages, 741);
   DKsConF7.Left := 224+25;
   DKsConF7.Top  := 117;
   DKsConF8.SetImgIndex (g_WMainImages, 743);
   DKsConF8.Left := 256+25;
   DKsConF8.Top := 117;


   DKsNone.SetImgIndex (g_WMainImages, 748);
   DKsNone.Left := 324;
   DKsNone.Top  := 84;

   DKsOk.SetImgIndex (g_WMainImages, 544);
   DKsOk.Left := 324;
   DKsOk.Top  := 121;
   {-----------------------------------------------------------}

   d := g_WMainImages.Images[120];
   if d <> nil then begin
      DGroupDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DGroupDlg.Top  := (SCREENHEIGHT - d.Height) div 2;
      DGroupDlg.SetImgIndex (g_WMainImages, 120);
   end;
   DGrpDlgClose.SetImgIndex (g_WMainImages, 86);
   DGrpDlgClose.Left := 260;
   DGrpDlgClose.Top := 0+5;
   DGrpAllowGroup.SetImgIndex (g_WMainImages, 122);
   DGrpAllowGroup.Left := 38;
   DGrpAllowGroup.Top := 37;
   DGrpCreate.SetImgIndex (g_WMainImages, 123);
   DGrpCreate.Left := 29+1;
   DGrpCreate.Top := 215+1;
   DGrpAddMem.SetImgIndex (g_WMainImages, 124);
   DGrpAddMem.Left := 107+1;
   DGrpAddMem.Top := 215+1;
   DGrpDelMem.SetImgIndex (g_WMainImages, 125);
   DGrpDelMem.Left := 183+1;
   DGrpDelMem.Top := 215+1;
   DGrpPgUp.SetImgIndex (g_WMainImages, DlgConf.DGrpPgUp.Image{373});
   DGrpPgUp.Left := DlgConf.DGrpPgUp.Left{183};
   DGrpPgUp.Top := DlgConf.DGrpPgUp.Top{60};
   DGrpPgDn.SetImgIndex (g_WMainImages, DlgConf.DGrpPgDn.Image{372});
   DGrpPgDn.Left := DlgConf.DGrpPgDn.Left{183};
   DGrpPgDn.Top := DlgConf.DGrpPgDn.Top{150};

   {-----------------------------------------------------------}
   //Deal Menu
   d := g_WMainImages.Images[389];
   if d <> nil then begin
      DDealDlg.Left := SCREENWIDTH - d.Width;
      DDealDlg.Top  := 0;
      DDealDlg.SetImgIndex (g_WMainImages, 389);
   end;
   DDGrid.Left := 21+9;
   DDGrid.Top  := 56-16;
   DDGrid.Width := 36 * 5;
   DDGrid.Height := 33 * 2;
   DDealOk.SetImgIndex (g_WMainImages, 391);
   DDealOk.Left := 155+3;
   DDealOk.Top := 193-65-23;  //65
   DDealClose.SetImgIndex (g_WMainImages, 86);
   DDealClose.Left := 220-8;
   DDealClose.Top := 42-25;
   DDGold.SetImgIndex (g_WMainImages, 28);
   DDGold.Left := 11+3;
   DDGold.Top  := 202-65-10;

   d := g_WMainImages.Images[390];
   if d <> nil then begin
      DDealRemoteDlg.Left := DDealDlg.Left - d.Width;
      DDealRemoteDlg.Top  := 0;
      DDealRemoteDlg.SetImgIndex (g_WMainImages, 390);
   end;
   DDRGrid.Left := 21+9;
   DDRGrid.Top  := 56-16;
   DDRGrid.Width := 36 * 5;
   DDRGrid.Height := 33 * 2;
   DDRGold.SetImgIndex (g_WMainImages, 28);
   DDRGold.Left := 11+3;
   DDRGold.Top  := 202-65-10;

   {-----------------------------------------------------------}
   //Guild Menu
   d := g_WMainImages.Images[180];
   if d <> nil then begin
      DGuildDlg.Left := 0;
      DGuildDlg.Top := 0;
      DGuildDlg.SetImgIndex (g_WMainImages, 180);
   end;
   DGDClose.Left := 602;
   DGDClose.Top  := 5;
   DGDClose.SetImgIndex (g_WMainImages, 86);
   DGDHome.Left := 30;
   DGDHome.Top  := 407;
   DGDHome.SetImgIndex (g_WMainImages, 198);
   DGDList.Left := 30;
   DGDList.Top  := 425;
   DGDList.SetImgIndex (g_WMainImages, 200);
   DGDChat.Left := 114;
   DGDChat.Top  := 425;
   DGDChat.SetImgIndex (g_WMainImages, 190);
   DGDAddMem.Left := 243;
   DGDAddMem.Top  := 407;
   DGDAddMem.SetImgIndex (g_WMainImages, 182);
   DGDDelMem.Left := 243;
   DGDDelMem.Top  := 425;
   DGDDelMem.SetImgIndex (g_WMainImages, 192);
   DGDEditNotice.Left := 325;
   DGDEditNotice.Top  := 407;
   DGDEditNotice.SetImgIndex (g_WMainImages, 196);
   DGDEditGrade.Left := 325;
   DGDEditGrade.Top  := 425;
   DGDEditGrade.SetImgIndex (g_WMainImages, 194);
   DGDAlly.Left := 407;
   DGDAlly.Top  := 407;
   DGDAlly.SetImgIndex (g_WMainImages, 184);
   DGDBreakAlly.Left := 407;
   DGDBreakAlly.Top  := 425;
   DGDBreakAlly.SetImgIndex (g_WMainImages, 186);
   DGDWar.Left := 513;
   DGDWar.Top  := 407;
   DGDWar.SetImgIndex (g_WMainImages, 202);
   DGDCancelWar.Left := 513;
   DGDCancelWar.Top  := 425;
   DGDCancelWar.SetImgIndex (g_WMainImages, 188);

   DGDUp.Left := 607;
   DGDUp.Top  := 215;
   DGDUp.SetImgIndex (g_WMainImages, 373);
   DGDDown.Left := 607;
   DGDDown.Top  := 274;
   DGDDown.SetImgIndex (g_WMainImages, 372);

   //Edit notice and edit grade info
   DGuildEditNotice.SetImgIndex (g_WMainImages, 204);
   DGEOk.SetImgIndex (g_WMainImages, 651);
   DGEOk.Left := 523;
   DGEOk.Top := 314;
   DGEClose.SetImgIndex (g_WMainImages, 86);
   DGEClose.Left := 602;
   DGEClose.Top := 5;

   {-----------------------------------------------------------}
   //Ability Menu
   DAdjustAbility.SetImgIndex (g_WMainImages, 226);
   DAdjustAbilClose.SetImgIndex (g_WMainImages, 64);
   DAdjustAbilClose.Left := 316;
   DAdjustAbilClose.Top := 1;
   DAdjustAbilOk.SetImgIndex (g_WMainImages, 62);
   DAdjustAbilOk.Left := 220;
   DAdjustAbilOk.Top := 298;

   DPlusDC.SetImgIndex (g_WMainImages, 227);
   DPlusDC.Left := 217;
   DPlusDC.Top := 101;
   DPlusMC.SetImgIndex (g_WMainImages, 227);
   DPlusMC.Left := 217;
   DPlusMC.Top := 121;
   DPlusSC.SetImgIndex (g_WMainImages, 227);
   DPlusSC.Left := 217;
   DPlusSC.Top := 140;
   DPlusAC.SetImgIndex (g_WMainImages, 227);
   DPlusAC.Left := 217;
   DPlusAC.Top := 160;
   DPlusMAC.SetImgIndex (g_WMainImages, 227);
   DPlusMAC.Left := 217;
   DPlusMAC.Top := 181;
   DPlusHP.SetImgIndex (g_WMainImages, 227);
   DPlusHP.Left := 217;
   DPlusHP.Top := 201;
   DPlusMP.SetImgIndex (g_WMainImages, 227);
   DPlusMP.Left := 217;
   DPlusMP.Top := 220;
   DPlusHit.SetImgIndex (g_WMainImages, 227);
   DPlusHit.Left := 217;
   DPlusHit.Top := 240;
   DPlusSpeed.SetImgIndex (g_WMainImages, 227);
   DPlusSpeed.Left := 217;
   DPlusSpeed.Top := 261;

   DMinusDC.SetImgIndex (g_WMainImages, 228);
   DMinusDC.Left := 227;
   DMinusDC.Top := 101;
   DMinusMC.SetImgIndex (g_WMainImages, 228);
   DMinusMC.Left := 227;
   DMinusMC.Top := 121;
   DMinusSC.SetImgIndex (g_WMainImages, 228);
   DMinusSC.Left := 227;
   DMinusSC.Top := 140;
   DMinusAC.SetImgIndex (g_WMainImages, 228);
   DMinusAC.Left := 227;
   DMinusAC.Top := 160;
   DMinusMAC.SetImgIndex (g_WMainImages, 228);
   DMinusMAC.Left := 227;
   DMinusMAC.Top := 181;
   DMinusHP.SetImgIndex (g_WMainImages, 228);
   DMinusHP.Left := 227;
   DMinusHP.Top := 201;
   DMinusMP.SetImgIndex (g_WMainImages, 228);
   DMinusMP.Left := 227;
   DMinusMP.Top := 220;
   DMinusHit.SetImgIndex (g_WMainImages, 228);
   DMinusHit.Left := 227;
   DMinusHit.Top := 240;
   DMinusSpeed.SetImgIndex (g_WMainImages, 228);
   DMinusSpeed.Left := 227;
   DMinusSpeed.Top := 261;


   {GemMakeItem Form}
   DGemMakeItem.SetImgIndex (g_WMainImages, 661);
   DGemMakeItem.Left := 200;
   DGemMakeItem.Top := 200;
   {GemMakeOK button}
   DGemMakeOK.SetImgIndex (g_WMainImages, 650);
   DGemMakeOK.Left := 91;
   DGemMakeOK.Top := 119;
   {GemMakeCancel button}
   DGemMakeCancel.SetImgIndex (g_WMainImages, 652);
   DGemMakeCancel.Left := 161;
   DGemMakeCancel.Top := 119;
   DGemCancel.SetImgIndex(g_WMainImages, 86);
   DGemCancel.Left :=242;
   DGemCancel.Top := 5;
   {Black item boxes}
   DGemSlot1.Left := 27;
   DGemSlot1.Top  := 25;
   DGemSlot1.Width := 35;
   DGemSlot1.Height := 35;

   DGemSlot2.Left := 62;
   DGemSlot2.Top  := 25;
   DGemSlot2.Width := 35;
   DGemSlot2.Height := 35;

   DGemSlot3.Left := 97;
   DGemSlot3.Top  := 25;
   DGemSlot3.Width := 35;
   DGemSlot3.Height := 35;

   DGemSlot4.Left := 132;
   DGemSlot4.Top  := 25;
   DGemSlot4.Width := 35;
   DGemSlot4.Height := 35;

   DGemSlot5.Left := 167;
   DGemSlot5.Top  := 25;
   DGemSlot5.Width := 35;
   DGemSlot5.Height := 35;

   DGemSlot6.Left := 203;
   DGemSlot6.Top  := 25;
   DGemSlot6.Width := 35;
   DGemSlot6.Height := 35;

   d := g_WMainImages.Images[536];
   if d <> nil then begin
      DFriendDlg.SetImgIndex (g_WMainImages, 536);
      DFriendDlg.Left := 0;
      DFriendDlg.Top := 0;
   end;
   DFrdClose.SetImgIndex(g_WMainImages, 86);
   DFrdClose.Left:=270;
   DFrdClose.Top:=5;
   DFrdPgUp.SetImgIndex(g_WMainImages, 373);
   DFrdPgUp.Left:=275;
   DFrdPgUp.Top:=116;
   DFrdPgDn.SetImgIndex(g_WMainImages, 372);
   DFrdPgDn.Left:=275;
   DFrdPgDn.Top:=175;
   DFrdFriend.SetImgIndex(g_WMainImages, 540);
   DFrdFriend.Left:=27;
   DFrdFriend.Top:=61;
   DFrdBlackList.SetImgIndex(g_WMainImages, 574);
   DFrdBlackList.Left:=147;
   DFrdBlackList.Top:=61;

   DFrdAdd.SetImgIndex(g_WMainImages, 554);
   DFrdAdd.Left:=90;
   DFrdAdd.Top:=259;
   DFrdDel.SetImgIndex(g_WMainImages, 556);
   DFrdDel.Left:=124;
   DFrdDel.Top:=259;
   DFrdMemo.SetImgIndex(g_WMainImages, 558);
   DFrdMemo.Left:=158;
   DFrdMemo.Top:=259;
   DFrdMail.SetImgIndex(g_WMainImages, 560);
   DFrdMail.Left:=192;
   DFrdMail.Top:=259;
   DFrdWhisper.SetImgIndex(g_WMainImages, 562);
   DFrdWhisper.Left:=226;
   DFrdWhisper.Top:=259;

   // Floating Belt
   g_boVerticalBelt := False;
   DoBeltSetup;

   //Mail Menu
   d := g_WMainImages.Images[536];
   if d <> nil then begin
      DMailListDlg.SetImgIndex (g_WMainImages, 536);
      DMailListDlg.Left := 512;
      DMailListDlg.Top := 0;
   end;

   DMailListTitle.SetImgIndex(g_WMainImages, 543);
   DMailListTitle.Left:=27;
   DMailListTitle.Top:=61;
   DMailListTitle.Height:=20;
   DMailListTitle.Width:=236;

   DMailListStatus.SetImgIndex(g_WMainImages, 403);
   DMailListStatus.Left:=34;
   DMailListStatus.Top:=34;
   DMailListStatus.Height:=17;
   DMailListStatus.Width:=20;

   DMailListClose.SetImgIndex(g_WMainImages, 86);
   DMailListClose.Left:=270;
   DMailListClose.Top:=5;
   DMailListPgUp.SetImgIndex(g_WMainImages, 373);
   DMailListPgUp.Left:=275;
   DMailListPgUp.Top:=116;
   DMailListPgDn.SetImgIndex(g_WMainImages, 372);
   DMailListPgDn.Left:=275;
   DMailListPgDn.Top:=175;
   DMLReply.SetImgIndex(g_WMainImages, 564);
   DMLReply.Left:=90;
   DMLReply.Top:=259;
   DMLRead.SetImgIndex(g_WMainImages, 566);
   DMLRead.Left:=124;
   DMLRead.Top:=259;
   DMLDel.SetImgIndex(g_WMainImages, 556);
   DMLDel.Left:=158;
   DMLDel.Top:=259;
   DMLLock.SetImgIndex(g_WMainImages, 568);
   DMLLock.Left:=192;
   DMLLock.Top:=259;
   DMLBlock.SetImgIndex(g_WMainImages, 570);
   DMLBlock.Left:=226;
   DMLBlock.Top:=259;

   // Block List
   d := g_WMainImages.Images[536];
   if d <> nil then begin
      DBlockListDlg.SetImgIndex (g_WMainImages, 536);
      DBlockListDlg.Left := 512;
      DBlockListDlg.Top := 0;
   end;
   DBlockListTitle.SetImgIndex(g_WMainImages, 542);
   DBlockListTitle.Left:=27;
   DBlockListTitle.Top:=61;
   DBlockListTitle.Height:=20;
   DBlockListTitle.Width:=236;
   DBlockListClose.SetImgIndex(g_WMainImages, 86);
   DBlockListClose.Left:=270;
   DBlockListClose.Top:=5;
   DBLPgUp.SetImgIndex(g_WMainImages, 373);
   DBLPgUp.Left:=275;
   DBLPgUp.Top:=116;
   DBLPgDn.SetImgIndex(g_WMainImages, 372);
   DBLPgDn.Left:=275;
   DBLPgDn.Top:=175;
   DBLAdd.SetImgIndex(g_WMainImages, 554);
   DBLAdd.Left:=192;
   DBLAdd.Top:=259;
   DBLDel.SetImgIndex(g_WMainImages, 556);
   DBLDel.Left:=226;
   DBLDel.Top:=259;        

// DMailRead
   d := g_WMainImages.Images[537];
   if d <> nil then begin
      DMailRead.SetImgIndex (g_WMainImages, 537);
      DMailRead.Left := 290;
      DMailRead.Top := 0;
   end;

   DMailReadName.Top := 35;
   DMailReadName.Left := 25;
   DMailReadName.SetImgIndex (g_WMainImages, 552);

   DMailReadClose.SetImgIndex(g_WMainImages, 86);
   DMailReadClose.Left:=208;
   DMailReadClose.Top:=5;
   DMailReadB1.SetImgIndex(g_WMainImages, 544);
   DMailReadB1.Left:=134;
   DMailReadB1.Top:=146;

//   DMailDlg
   d := g_WMainImages.Images[537];
   if d <> nil then begin
      DMailDlg.SetImgIndex (g_WMainImages, 537);
      DMailDlg.Left := 290;
      DMailDlg.Top := 0;
   end;

   DMailName.Top := 35;
   DMailName.Left := 25;
   DMailName.SetImgIndex (g_WMainImages, 551);

   DMailDlgClose.SetImgIndex(g_WMainImages, 86);
   DMailDlgClose.Left:=208;
   DMailDlgClose.Top:=5;
   DMailDlgB1.SetImgIndex(g_WMainImages, 544);
   DMailDlgB1.Left:=63;
   DMailDlgB1.Top:=146;
   DMailDlgB2.SetImgIndex(g_WMainImages, 538);
   DMailDlgB2.Left:=134;
   DMailDlgB2.Top:=146;

   d := g_WMainImages.Images[537];
   if d <> nil then begin
      DMemo.SetImgIndex (g_WMainImages, 537);
      DMemo.Left := 290;
      DMemo.Top := 0;
   end;
   DMemoName.Top := 35;
   DMemoName.Left := 25;
   DMemoName.SetImgIndex (g_WMainImages, 550);
   DMemoClose.SetImgIndex(g_WMainImages, 86);
   DMemoClose.Left:=208;
   DMemoClose.Top:=5;
   DMemoB1.SetImgIndex(g_WMainImages, 544);
   DMemoB1.Left:=63;
   DMemoB1.Top:=146;
   DMemoB2.SetImgIndex(g_WMainImages, 538);
   DMemoB2.Left:=134;
   DMemoB2.Top:=146;

   d := g_WMainImages.Images[920];
   if d <> nil then begin
      DHelpWin.SetImgIndex (g_WMainImages, 920);
      DHelpWin.Left := (SCREENWIDTH - d.Width) div 2;
      DHelpWin.Top := 0;
   end;
   DHelpClose.SetImgIndex(g_WMainImages, 86);
   DHelpClose.Left:=579;
   DHelpClose.Top:=5;
   DHelpPrev.SetImgIndex(g_WMainImages, 388);
   DHelpPrev.Left:=236;
   DHelpPrev.Top:=533;
   DHelpNext.SetImgIndex(g_WMainImages, 387);
   DHelpNext.Left:=325;
   DHelpNext.Top:=533;

   d := g_WMainImages.Images[780];
   if d <> nil then begin
      DItemShopDlg.SetImgIndex (g_WMainImages, 780);
      DItemShopDlg.Left := 0;
      DItemShopDlg.Top := 0;
   end;
   DItemShopClose.SetImgIndex(g_WMainImages, 86);
   DItemShopClose.Left:=670;
   DItemShopClose.Top:=17;
   DItemShopJobAll.SetImgIndex(g_WMainImages, DlgConf.DItemShopJobAll.Image);
   DItemShopJobAll.Left:=DlgConf.DItemShopJobAll.Left;
   DItemShopJobAll.Top:=DlgConf.DItemShopJobAll.Top;
   DItemShopJobWarrior.SetImgIndex(g_WMainImages, DlgConf.DItemShopJobWarrior.Image);
   DItemShopJobWarrior.Left:=DlgConf.DItemShopJobWarrior.Left;
   DItemShopJobWarrior.Top:=DlgConf.DItemShopJobWarrior.Top;
   DItemShopJobWizard.SetImgIndex(g_WMainImages, DlgConf.DItemShopJobWizard.Image);
   DItemShopJobWizard.Left:=DlgConf.DItemShopJobWizard.Left;
   DItemShopJobWizard.Top:=DlgConf.DItemShopJobWizard.Top;
   DItemShopJobMonk.SetImgIndex(g_WMainImages, DlgConf.DItemShopJobMonk.Image);
   DItemShopJobMonk.Left:=DlgConf.DItemShopJobMonk.Left;
   DItemShopJobMonk.Top:=DlgConf.DItemShopJobMonk.Top;
   DItemShopJobCommon.SetImgIndex(g_WMainImages, DlgConf.DItemShopJobCommon.Image);
   DItemShopJobCommon.Left:=DlgConf.DItemShopJobCommon.Left;
   DItemShopJobCommon.Top:=DlgConf.DItemShopJobCommon.Top;
   DItemShopFind.SetImgIndex(g_WMainImages, DlgConf.DItemShopFind.Image);
   DItemShopFind.Left:=DlgConf.DItemShopFind.Left;
   DItemShopFind.Top:=DlgConf.DItemShopFind.Top;

   DItemShopCaNew.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaNew.Image);
   DItemShopCaNew.Left:=DlgConf.DItemShopCaNew.Left;
   DItemShopCaNew.Top:=DlgConf.DItemShopCaNew.Top;
   DItemShopCaAll.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaAll.Image);
   DItemShopCaAll.Left:=DlgConf.DItemShopCaAll.Left;
   DItemShopCaAll.Top:=DlgConf.DItemShopCaAll.Top;
   DItemShopCaWeapon.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaWeapon.Image);
   DItemShopCaWeapon.Left:=DlgConf.DItemShopCaWeapon.Left;
   DItemShopCaWeapon.Top:=DlgConf.DItemShopCaWeapon.Top;
   DItemShopCaArmor.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaArmor.Image);
   DItemShopCaArmor.Left:=DlgConf.DItemShopCaArmor.Left;
   DItemShopCaArmor.Top:=DlgConf.DItemShopCaArmor.Top;
   DItemShopCaAcc.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaAcc.Image);
   DItemShopCaAcc.Left:=DlgConf.DItemShopCaAcc.Left;
   DItemShopCaAcc.Top:=DlgConf.DItemShopCaAcc.Top;
   DItemShopCasSubitem.SetImgIndex(g_WMainImages, DlgConf.DItemShopCasSubitem.Image);
   DItemShopCasSubitem.Left:=DlgConf.DItemShopCasSubitem.Left;
   DItemShopCasSubitem.Top:=DlgConf.DItemShopCasSubitem.Top;
   DItemShopCaOther.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaOther.Image);
   DItemShopCaOther.Left:=DlgConf.DItemShopCaOther.Left;
   DItemShopCaOther.Top:=DlgConf.DItemShopCaOther.Top;
   DItemShopCaPackage.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaPackage.Image);
   DItemShopCaPackage.Left:=DlgConf.DItemShopCaPackage.Left;
   DItemShopCaPackage.Top:=DlgConf.DItemShopCaPackage.Top;
   DItemShopCaSub1.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaSub1.Image);
   DItemShopCaSub1.Left:=DlgConf.DItemShopCaSub1.Left;
   DItemShopCaSub1.Top:=DlgConf.DItemShopCaSub1.Top;
   DItemShopCaSub2.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaSub2.Image);
   DItemShopCaSub2.Left:=DlgConf.DItemShopCaSub2.Left;
   DItemShopCaSub2.Top:=DlgConf.DItemShopCaSub2.Top;
   DItemShopCaSub3.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaSub3.Image);
   DItemShopCaSub3.Left:=DlgConf.DItemShopCaSub3.Left;
   DItemShopCaSub3.Top:=DlgConf.DItemShopCaSub3.Top;
   DItemShopCaSub4.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaSub4.Image);
   DItemShopCaSub4.Left:=DlgConf.DItemShopCaSub4.Left;
   DItemShopCaSub4.Top:=DlgConf.DItemShopCaSub4.Top;
   DItemShopCaSub5.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaSub5.Image);
   DItemShopCaSub5.Left:=DlgConf.DItemShopCaSub5.Left;
   DItemShopCaSub5.Top:=DlgConf.DItemShopCaSub5.Top;
   DItemShopCaSub6.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaSub6.Image);
   DItemShopCaSub6.Left:=DlgConf.DItemShopCaSub6.Left;
   DItemShopCaSub6.Top:=DlgConf.DItemShopCaSub6.Top;
   DItemShopCaSub7.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaSub7.Image);
   DItemShopCaSub7.Left:=DlgConf.DItemShopCaSub7.Left;
   DItemShopCaSub7.Top:=DlgConf.DItemShopCaSub7.Top;
   //下面的功能按钮
   DItemShopGetGift.SetImgIndex(g_WMainImages, DlgConf.DItemShopGetGift.Image);
   DItemShopGetGift.Left:=DlgConf.DItemShopGetGift.Left;
   DItemShopGetGift.Top:=DlgConf.DItemShopGetGift.Top;
   DItemShopAddFav.SetImgIndex(g_WMainImages, DlgConf.DItemShopAddFav.Image);
   DItemShopAddFav.Left:=DlgConf.DItemShopAddFav.Left;
   DItemShopAddFav.Top:=DlgConf.DItemShopAddFav.Top;
   DItemShopBye.SetImgIndex(g_WMainImages, DlgConf.DItemShopBye.Image);
   DItemShopBye.Left:=DlgConf.DItemShopBye.Left;
   DItemShopBye.Top:=DlgConf.DItemShopBye.Top;
   DItemShopGift.SetImgIndex(g_WMainImages, DlgConf.DItemShopGift.Image);
   DItemShopGift.Left:=DlgConf.DItemShopGift.Left;
   DItemShopGift.Top:=DlgConf.DItemShopGift.Top;
   DItemShopPayMoney.SetImgIndex(g_WMainImages, DlgConf.DItemShopPayMoney.Image);
   DItemShopPayMoney.Left:=DlgConf.DItemShopPayMoney.Left;
   DItemShopPayMoney.Top:=DlgConf.DItemShopPayMoney.Top;
   DItemShopWear.SetImgIndex(g_WMainImages, DlgConf.DItemShopWear.Image);
   DItemShopWear.Left:=DlgConf.DItemShopWear.Left;
   DItemShopWear.Top:=DlgConf.DItemShopWear.Top;
   DItemShopWearLturn.SetImgIndex(g_WMainImages, DlgConf.DItemShopWearLturn.Image);
   DItemShopWearLturn.Left:=DlgConf.DItemShopWearLturn.Left;
   DItemShopWearLturn.Top:=DlgConf.DItemShopWearLturn.Top;
   DItemShopWearChange.SetImgIndex(g_WMainImages, DlgConf.DItemShopWearChange.Image);
   DItemShopWearChange.Left:=DlgConf.DItemShopWearChange.Left;
   DItemShopWearChange.Top:=DlgConf.DItemShopWearChange.Top;
   DItemShopWearRturn.SetImgIndex(g_WMainImages, DlgConf.DItemShopWearRturn.Image);
   DItemShopWearRturn.Left:=DlgConf.DItemShopWearRturn.Left;
   DItemShopWearRturn.Top:=DlgConf.DItemShopWearRturn.Top;
   DItemShopListPrev.SetImgIndex(g_WMainImages, DlgConf.DItemShopListPrev.Image);
   DItemShopListPrev.Left:=DlgConf.DItemShopListPrev.Left;
   DItemShopListPrev.Top:=DlgConf.DItemShopListPrev.Top;
   DItemShopListNext.SetImgIndex(g_WMainImages, DlgConf.DItemShopListNext.Image);
   DItemShopListNext.Left:=DlgConf.DItemShopListNext.Left;
   DItemShopListNext.Top:=DlgConf.DItemShopListNext.Top;
   DShopScrollBarUp.SetImgIndex(g_WMainImages, DlgConf.DShopScrollBarUp.Image);
   DShopScrollBarUp.Left:=DlgConf.DShopScrollBarUp.Left;
   DShopScrollBarUp.Top:=DlgConf.DShopScrollBarUp.Top;
   DShopScrollBarDown.SetImgIndex(g_WMainImages, DlgConf.DShopScrollBarDown.Image);
   DShopScrollBarDown.Left:=DlgConf.DShopScrollBarDown.Left;
   DShopScrollBarDown.Top:=DlgConf.DShopScrollBarDown.Top;
   DShopScrollBar.SetImgIndex(g_WMainImages, DlgConf.DShopScrollBar.Image);
   DShopScrollBar.Left:=DlgConf.DShopScrollBar.Left;
   DShopScrollBar.Top:=DlgConf.DShopScrollBar.Top;
   DItemShopCaFav.SetImgIndex(g_WMainImages, DlgConf.DItemShopCaFav.Image);
   DItemShopCaFav.Left:=DlgConf.DItemShopCaFav.Left;
   DItemShopCaFav.Top:=DlgConf.DItemShopCaFav.Top;
   DItemShopInPackBack.SetImgIndex(g_WMainImages, DlgConf.DItemShopInPackBack.Image);
   DItemShopInPackBack.Left:=DlgConf.DItemShopInPackBack.Left;
   DItemShopInPackBack.Top:=DlgConf.DItemShopInPackBack.Top;
   DItemShopCashRefresh.SetImgIndex(g_WMainImages, DlgConf.DItemShopCashRefresh.Image);
   DItemShopCashRefresh.Left:=DlgConf.DItemShopCashRefresh.Left;
   DItemShopCashRefresh.Top:=DlgConf.DItemShopCashRefresh.Top;
   DItemShopPackSub1.SetImgIndex(g_WMainImages, DlgConf.DItemShopPackSub1.Image);
   DItemShopPackSub1.Left:=DlgConf.DItemShopPackSub1.Left;
   DItemShopPackSub1.Top:=DlgConf.DItemShopPackSub1.Top;
   DItemShopPackSub2.SetImgIndex(g_WMainImages, DlgConf.DItemShopPackSub2.Image);
   DItemShopPackSub2.Left:=DlgConf.DItemShopPackSub2.Left;
   DItemShopPackSub2.Top:=DlgConf.DItemShopPackSub2.Top;
   DItemShopPackSub3.SetImgIndex(g_WMainImages, DlgConf.DItemShopPackSub3.Image);
   DItemShopPackSub3.Left:=DlgConf.DItemShopPackSub3.Left;
   DItemShopPackSub3.Top:=DlgConf.DItemShopPackSub3.Top;
   DItemShopPackSub4.SetImgIndex(g_WMainImages, DlgConf.DItemShopPackSub4.Image);
   DItemShopPackSub4.Left:=DlgConf.DItemShopPackSub4.Left;
   DItemShopPackSub4.Top:=DlgConf.DItemShopPackSub4.Top;
   DItemShopPackSub5.SetImgIndex(g_WMainImages, DlgConf.DItemShopPackSub5.Image);
   DItemShopPackSub5.Left:=DlgConf.DItemShopPackSub5.Left;
   DItemShopPackSub5.Top:=DlgConf.DItemShopPackSub5.Top;
   DItemShopPackSub6.SetImgIndex(g_WMainImages, DlgConf.DItemShopPackSub6.Image);
   DItemShopPackSub6.Left:=DlgConf.DItemShopPackSub6.Left;
   DItemShopPackSub6.Top:=DlgConf.DItemShopPackSub6.Top;
   DItemShopPackSub7.SetImgIndex(g_WMainImages, DlgConf.DItemShopPackSub7.Image);
   DItemShopPackSub7.Left:=DlgConf.DItemShopPackSub7.Left;
   DItemShopPackSub7.Top:=DlgConf.DItemShopPackSub7.Top;
   DItemShopPackSub8.SetImgIndex(g_WMainImages, DlgConf.DItemShopPackSub8.Image);
   DItemShopPackSub8.Left:=DlgConf.DItemShopPackSub8.Left;
   DItemShopPackSub8.Top:=DlgConf.DItemShopPackSub8.Top;
   DItemShopFavDel1.SetImgIndex(g_WMainImages, DlgConf.DItemShopFavDel1.Image);
   DItemShopFavDel1.Left:=DlgConf.DItemShopFavDel1.Left;
   DItemShopFavDel1.Top:=DlgConf.DItemShopFavDel1.Top;
   DItemShopFavDel2.SetImgIndex(g_WMainImages, DlgConf.DItemShopFavDel2.Image);
   DItemShopFavDel2.Left:=DlgConf.DItemShopFavDel2.Left;
   DItemShopFavDel2.Top:=DlgConf.DItemShopFavDel2.Top;
   DItemShopFavDel3.SetImgIndex(g_WMainImages, DlgConf.DItemShopFavDel3.Image);
   DItemShopFavDel3.Left:=DlgConf.DItemShopFavDel3.Left;
   DItemShopFavDel3.Top:=DlgConf.DItemShopFavDel3.Top;
   DItemShopFavDel4.SetImgIndex(g_WMainImages, DlgConf.DItemShopFavDel4.Image);
   DItemShopFavDel4.Left:=DlgConf.DItemShopFavDel4.Left;
   DItemShopFavDel4.Top:=DlgConf.DItemShopFavDel4.Top;
   DItemShopFavDel5.SetImgIndex(g_WMainImages, DlgConf.DItemShopFavDel5.Image);
   DItemShopFavDel5.Left:=DlgConf.DItemShopFavDel5.Left;
   DItemShopFavDel5.Top:=DlgConf.DItemShopFavDel5.Top;
   DItemShopFavDel6.SetImgIndex(g_WMainImages, DlgConf.DItemShopFavDel6.Image);
   DItemShopFavDel6.Left:=DlgConf.DItemShopFavDel6.Left;
   DItemShopFavDel6.Top:=DlgConf.DItemShopFavDel6.Top;
   DItemShopFavDel7.SetImgIndex(g_WMainImages, DlgConf.DItemShopFavDel7.Image);
   DItemShopFavDel7.Left:=DlgConf.DItemShopFavDel7.Left;
   DItemShopFavDel7.Top:=DlgConf.DItemShopFavDel7.Top;
   DItemShopFavDel8.SetImgIndex(g_WMainImages, DlgConf.DItemShopFavDel8.Image);
   DItemShopFavDel8.Left:=DlgConf.DItemShopFavDel8.Left;
   DItemShopFavDel8.Top:=DlgConf.DItemShopFavDel8.Top;
   DItemShopPriceUp.SetImgIndex(g_WMainImages, DlgConf.DItemShopPriceUp.Image);
   DItemShopPriceUp.Left:=DlgConf.DItemShopPriceUp.Left;
   DItemShopPriceUp.Top:=DlgConf.DItemShopPriceUp.Top;
   DItemShopPriceDn.SetImgIndex(g_WMainImages, DlgConf.DItemShopPriceDn.Image);
   DItemShopPriceDn.Left:=DlgConf.DItemShopPriceDn.Left;
   DItemShopPriceDn.Top:=DlgConf.DItemShopPriceDn.Top;
   DItemShopCheckSort.SetImgIndex(g_WMainImages, DlgConf.DItemShopCheckSort.Image);
   DItemShopCheckSort.Left:=DlgConf.DItemShopCheckSort.Left;
   DItemShopCheckSort.Top:=DlgConf.DItemShopCheckSort.Top;

   //计数窗口
   d := g_WMainImages.Images[660];
   if d <> nil then begin
      DCountDlg.SetImgIndex (g_WMainImages, 660);
      DCountDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DCountDlg.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DCountDlgClose.SetImgIndex(g_WMainImages, 86);
   DCountDlgClose.Left:=298;
   DCountDlgClose.Top:=5;
   DCountDlgMax.SetImgIndex(g_WMainImages, 654);
   DCountDlgMax.Left:=45;
   DCountDlgMax.Top:=135;
   DCountDlgOk.SetImgIndex(g_WMainImages, 650);
   DCountDlgOk.Left:=128;
   DCountDlgOk.Top:=135;
   DCountDlgCancel.SetImgIndex(g_WMainImages, 652);
   DCountDlgCancel.Left:=211;
   DCountDlgCancel.Top:=135;

   d := g_WMainImages.Images[903];
   if d <> nil then begin
      DWemadeBuff.SetImgIndex (g_WMainImages, 903);
      DWemadeBuff.Left := (SCREENWIDTH - d.Width) div 2 + 265;
      DWemadeBuff.Top := 5;
   end;
   //新仓库窗口
   d := g_WMainImages.Images[586];
   if d <> nil then begin
      DItemStore.SetImgIndex (g_WMainImages, 586);
      DItemStore.Left := 0;
      DItemStore.Top := 0;
   end;
   DItemStoreClose.SetImgIndex(g_WMainImages, 86);
   DItemStoreClose.Left:=396;
   DItemStoreClose.Top:=5;
   DStoreGrid.Left := 27;
   DStoreGrid.Top  := 57;
   DStoreGrid.Width := 370;
   DStoreGrid.Height := 265;
   DItemStorePassReset.SetImgIndex(g_WMainImages, 1120);
   DItemStorePassReset.Left:=310;
   DItemStorePassReset.Top:=30;
   //仓库软键盘
   d := g_WMainImages.Images[1101];
   if d <> nil then begin
      DSafeKeyStorage.SetImgIndex (g_WMainImages, 1101);
      DSafeKeyStorage.Left := 50;
      DSafeKeyStorage.Top := 50;
   end;
   DSafeKeyStorageEsc.SetImgIndex(g_WMainImages, 1090);
   DSafeKeyStorageEsc.Left:=32;
   DSafeKeyStorageEsc.Top:=32;

   DSafeKeyStorage0.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage0.Left:=32;
   DSafeKeyStorage0.Top:=64;
   DSafeKeyStorage1.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage1.Left:=63;
   DSafeKeyStorage1.Top:=64;
   DSafeKeyStorage2.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage2.Left:=94;
   DSafeKeyStorage2.Top:=64;
   DSafeKeyStorage3.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage3.Left:=125;
   DSafeKeyStorage3.Top:=64;
   DSafeKeyStorage4.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage4.Left:=156;
   DSafeKeyStorage4.Top:=64;
   DSafeKeyStorage5.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage5.Left:=32;
   DSafeKeyStorage5.Top:=96;
   DSafeKeyStorage6.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage6.Left:=63;
   DSafeKeyStorage6.Top:=96;
   DSafeKeyStorage7.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage7.Left:=94;
   DSafeKeyStorage7.Top:=96;
   DSafeKeyStorage8.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage8.Left:=125;
   DSafeKeyStorage8.Top:=96;
   DSafeKeyStorage9.SetImgIndex(g_WMainImages, 1095);
   DSafeKeyStorage9.Left:=156;
   DSafeKeyStorage9.Top:=96;
   DSafeKeyStorageDel.SetImgIndex(g_WMainImages, 1084);
   DSafeKeyStorageDel.Left:=63;
   DSafeKeyStorageDel.Top:=128;
   DSafeKeyStorageEnter.SetImgIndex(g_WMainImages, 1087);
   DSafeKeyStorageEnter.Left:=125;
   DSafeKeyStorageEnter.Top:=128;

   d := g_WMainImages.Images[970];
   if d <> nil then begin
      DQuestAccept.SetImgIndex (g_WMainImages, 970);
      DQuestAccept.Left := 0;
      DQuestAccept.Top := 0;
   end;

   d := g_WMainImages.Images[640];
   if d <> nil then begin
      DAddBag3.SetImgIndex (g_WMainImages, 640);
      DAddBag3.Left := 50;
      DAddBag3.Top := 50;
   end;
   DAddBag3Close.SetImgIndex(g_WMainImages, 86);
   DAddBag3Close.Left:=30;
   DAddBag3Close.Top:=5;
   DAddBag3Grid.Left := 17;
   DAddBag3Grid.Top  := 11;
   DAddBag3Grid.Width := 111;
   DAddBag3Grid.Height := 35;

   d := g_WMainImages.Images[641];
   if d <> nil then begin
      DAddBag4.SetImgIndex (g_WMainImages, 641);
      DAddBag4.Left := 50;
      DAddBag4.Top := 50;
   end;
   DAddBag4Close.SetImgIndex(g_WMainImages, 86);
   DAddBag4Close.Left:=30;
   DAddBag4Close.Top:=5;
   DAddBag4Grid.Left := 17;
   DAddBag4Grid.Top  := 11;
   DAddBag4Grid.Width := 111;
   DAddBag4Grid.Height := 35;

   d := g_WMainImages.Images[642];
   if d <> nil then begin
      DAddBag5.SetImgIndex (g_WMainImages, 642);
      DAddBag5.Left := 50;
      DAddBag5.Top := 50;
   end;
   DAddBag5Close.SetImgIndex(g_WMainImages, 86);
   DAddBag5Close.Left:=30;
   DAddBag5Close.Top:=5;
   DAddBag5Grid.Left := 17;
   DAddBag5Grid.Top  := 11;
   DAddBag5Grid.Width := 111;
   DAddBag5Grid.Height := 35;

   d := g_WMainImages.Images[643];
   if d <> nil then begin
      DAddBag6.SetImgIndex (g_WMainImages, 643);
      DAddBag6.Left := 50;
      DAddBag6.Top := 50;
   end;
   DAddBag6Close.SetImgIndex(g_WMainImages, 86);
   DAddBag6Close.Left:=30;
   DAddBag6Close.Top:=5;
   DAddBag6Grid.Left := 17;
   DAddBag6Grid.Top  := 11;
   DAddBag6Grid.Width := 111;
   DAddBag6Grid.Height := 35;

   d := g_WMainImages.Images[644];
   if d <> nil then begin
      DAddBag7.SetImgIndex (g_WMainImages, 644);
      DAddBag7.Left := 50;
      DAddBag7.Top := 50;
   end;
   DAddBag7Close.SetImgIndex(g_WMainImages, 86);
   DAddBag7Close.Left:=30;
   DAddBag7Close.Top:=5;
   DAddBag7Grid.Left := 17;
   DAddBag7Grid.Top  := 11;
   DAddBag7Grid.Width := 111;
   DAddBag7Grid.Height := 35;

   d := g_WMainImages.Images[645];
   if d <> nil then begin
      DAddBag8.SetImgIndex (g_WMainImages, 645);
      DAddBag8.Left := 50;
      DAddBag8.Top := 50;
   end;
   DAddBag8Close.SetImgIndex(g_WMainImages, 86);
   DAddBag8Close.Left:=30;
   DAddBag8Close.Top:=5;
   DAddBag8Grid.Left := 17;
   DAddBag8Grid.Top  := 11;
   DAddBag8Grid.Width := 111;
   DAddBag8Grid.Height := 35;

   d := g_WMainImages.Images[1103];
   if d <> nil then begin
      DStoragePass.SetImgIndex (g_WMainImages, 1103);
      DStoragePass.Left := (SCREENWIDTH - d.Width) div 2;
      DStoragePass.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DStoragePassClose.SetImgIndex(g_WMainImages, 86);
   DStoragePassClose.Left:=237;
   DStoragePassClose.Top:=5;
   DStoragePassSafe.SetImgIndex(g_WMainImages, 1106);
   DStoragePassSafe.Left:=92;
   DStoragePassSafe.Top:=88;
   DStoragePassOk.SetImgIndex(g_WMainImages, 991);
   DStoragePassOk.Left:=161;
   DStoragePassOk.Top:=88;

   d := g_WMainImages.Images[1104];
   if d <> nil then begin
      DStoragePassSet.SetImgIndex (g_WMainImages, 1104);
      DStoragePassSet.Left := (SCREENWIDTH - d.Width) div 2;
      DStoragePassSet.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DStoragePassSetClose.SetImgIndex(g_WMainImages, 86);
   DStoragePassSetClose.Left:=317;
   DStoragePassSetClose.Top:=5;
   DStoragePassSetSafe.SetImgIndex(g_WMainImages, 1106);
   DStoragePassSetSafe.Left:=100;
   DStoragePassSetSafe.Top:=186;
   DStoragePassSetOk.SetImgIndex(g_WMainImages, 991);
   DStoragePassSetOk.Left:=169;
   DStoragePassSetOk.Top:=186;
   DStoragePassSetDel.SetImgIndex(g_WMainImages, 1108);
   DStoragePassSetDel.Left:=238;
   DStoragePassSetDel.Top:=186;

   d := g_WMainImages.Images[1105];
   if d <> nil then begin
      DStoragePassReset.SetImgIndex (g_WMainImages, 1105);
      DStoragePassReset.Left := (SCREENWIDTH - d.Width) div 2;
      DStoragePassReset.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DStoragePassResetClose.SetImgIndex(g_WMainImages, 86);
   DStoragePassResetClose.Left:=317;
   DStoragePassResetClose.Top:=5;
   DStoragePassResetSafe.SetImgIndex(g_WMainImages, 1106);
   DStoragePassResetSafe.Left:=100;
   DStoragePassResetSafe.Top:=230;
   DStoragePassResetOk.SetImgIndex(g_WMainImages, 991);
   DStoragePassResetOk.Left:=169;
   DStoragePassResetOk.Top:=230;
   DStoragePassResetDel.SetImgIndex(g_WMainImages, 1108);
   DStoragePassResetDel.Left:=238;
   DStoragePassResetDel.Top:=230;

   d := g_WMainImages.Images[1110];
   if d <> nil then begin
      DBank.SetImgIndex (g_WMainImages, 1110);
      DBank.Left := (SCREENWIDTH - d.Width) div 2;
      DBank.Top := (SCREENHEIGHT - d.Height) div 2;
   end;
   DBankClose.SetImgIndex(g_WMainImages, 86);
   DBankClose.Left:=237;
   DBankClose.Top:=5;
   DBankPassSet.SetImgIndex(g_WMainImages, 1116);
   DBankPassSet.Left:=174;
   DBankPassSet.Top:=29;
   DBankSlotAdd.SetImgIndex(g_WMainImages, 1118);
   DBankSlotAdd.Left:=202;
   DBankSlotAdd.Top:=182;
   DBankGold.SetImgIndex (g_WMainImages, 28);
   DBankGold.Left := 14;
   DBankGold.Top  := 189;

   d := g_WMainImages.Images[1111];
   if d <> nil then begin
      DBankWinSlot1.SetImgIndex (g_WMainImages, 1111);
      DBankWinSlot1.Left := 50;
      DBankWinSlot1.Top := 50;
   end;
   DBankCloseSlot1.SetImgIndex(g_WMainImages, 86);
   DBankCloseSlot1.Left:=30;
   DBankCloseSlot1.Top:=5;
   DBankGridSlot1.Left := 17;
   DBankGridSlot1.Top  := 11;
   DBankGridSlot1.Width := 111;
   DBankGridSlot1.Height := 35;

   d := g_WMain3Images.Images[0];
   if d <> nil then begin
      DAbout.SetImgIndex (g_WMain3Images, 0);
      DAbout.Left := 0;
      DAbout.Top := 0;
   end;
   DAboutClose.SetImgIndex(g_WMainImages, 86);
   DAboutClose.Left:=409;
   DAboutClose.Top:=5;
end;

procedure TFrmDlg.DoBeltSetup;
var
   d: TDirectDrawSurface;
begin
  DBelt1.Width := 32;
  DBelt1.Height := 29;
  DBelt2.Width := 32;
  DBelt2.Height := 29;
  DBelt3.Width := 32;
  DBelt3.Height := 29;
  DBelt4.Width := 32;
  DBelt4.Height := 29;
  DBelt5.Width := 32;
  DBelt5.Height := 29;
  DBelt6.Width := 32;
  DBelt6.Height := 29;

  DBeltSwap.DontDrawUp := True;
  DBeltClose.DontDrawUp := True;


  if g_boVerticalBelt then begin
    d := g_WMainImages.Images[83];
    if d <> nil then begin
      DBeltWindow.SetImgIndex (g_WMainImages, 83);
      DBeltWindow.Left := 0;
      DBeltWindow.Top := 144;
    end;

    DBelt1.Left := 5;
    DBelt1.Top := 19;

    DBelt2.Left := 5;
    DBelt2.Top := 56;

    DBelt3.Left := 5;
    DBelt3.Top := 92;

    DBelt4.Left := 5;
    DBelt4.Top := 128;

    DBelt5.Left := 5;
    DBelt5.Top := 165;

    DBelt6.Left := 5;
    DBelt6.Top := 200;

    DBeltSwap.SetImgIndex (g_WMainImages, 84);
    DBeltSwap.Top := 239;
    DBeltSwap.Left := 20;

    DBeltClose.SetImgIndex (g_WMainImages, 85);
    DBeltClose.Top := 239;
    DBeltClose.Left := 1;
  end
  else begin
    d := g_WMainImages.Images[80];
    if d <> nil then begin
      DBeltWindow.SetImgIndex (g_WMainImages, 80);
      DBeltWindow.Left := 242;
      DBeltWindow.Top := 419;
    end;

    DBelt1.Left := 21;
    DBelt1.Top := 5;

    DBelt2.Left := 56;
    DBelt2.Top := 5;

    DBelt3.Left := 92;
    DBelt3.Top := 5;

    DBelt4.Left := 128;
    DBelt4.Top := 5;

    DBelt5.Left := 165;
    DBelt5.Top := 5;

    DBelt6.Left := 200;
    DBelt6.Top := 5;

    DBeltSwap.SetImgIndex (g_WMainImages, 81);
    DBeltSwap.Top := 1;
    DBeltSwap.Left := 239;

    DBeltClose.SetImgIndex (g_WMainImages, 82);
    DBeltClose.Top := 21;
    DBeltClose.Left := 239;
  end;
end;

{------------------------------------------------------------------------}

procedure TFrmDlg.OpenMyStatus;
begin
   DStateWin.Visible := not DStateWin.Visible;
   PageChanged;
end;

procedure TFrmDlg.OpenUserState (UserState: TUserStateInfo);
begin
   UserState1 := UserState;
   DUserState1.Visible := TRUE;
end;

procedure TFrmDlg.OpenItemBag;
begin
   DItemBag.Visible := not DItemBag.Visible;
   if DItemBag.Visible then
      ArrangeItemBag;
end;

procedure TFrmDlg.ViewBottomBox (visible: Boolean);
begin
   DBottom.Visible := visible;
end;

procedure TFrmDlg.CancelItemMoving;
var
   idx, n: integer;
begin
   if g_boItemMoving then begin
      g_boItemMoving := FALSE;
      idx := g_MovingItem.Index;
      if idx < 0 then begin
         if (idx <= -20) and (idx > -30) then begin
            AddDealItem (g_MovingItem.Item);
         end else begin
            n := -(idx+1);
            if n in [0..12] then begin
               g_UseItems[n] := g_MovingItem.Item;
            end;
         end;
      end else
         if idx in [0..MAXBAGITEM-1] then begin
            if g_ItemArr[idx].S.Name = '' then begin
               g_ItemArr[idx] := g_MovingItem.Item;
            end else begin
               AddItemBag (g_MovingItem.Item);
            end;
         end;
      g_MovingItem.Item.S.Name := '';
   end;
   ArrangeItemBag;
end;
//丢物品到地上
procedure TFrmDlg.DropMovingItem;
var
   idx: integer;
   Amount: Integer;
   valstr: String;
begin
   if g_boItemMoving then begin
      g_boItemMoving := FALSE;
      if g_MovingItem.Item.S.Name <> '' then begin
      //必须在这里增加检测窗口
        if g_MovingItem.Item.S.StdMode = 45 then begin
          FrmDlg.DMessageDlg ('您要丢多少个'+g_MovingItem.Item.S.Name+'到地上？', [mbOk, mbAbort]);
            GetValidStrVal (DlgEditText, valstr, [' ']);
            Amount:=Str_ToInt (valstr, 0);
        end else
          Amount:=1;
        if Amount > 0 then begin
          FrmMain.SendDropItem (g_MovingItem.Item.S.Name, g_MovingItem.Item.MakeIndex,Amount);
          if g_MovingItem.Item.Amount > Amount then begin
            dec(g_MovingItem.Item.Amount,Amount);
            AddItemBag(g_MovingItem.Item);
            g_MovingItem.Item.Amount:=1;
          end;
          AddDropItem (g_MovingItem.Item);
          g_MovingItem.Item.S.Name := '';
        end else begin
          AddItemBag(g_MovingItem.Item);
          g_MovingItem.Item.S.Name := '';
        end;
      end;
   end;
end;

procedure TFrmDlg.OpenAdjustAbility;
begin
   DAdjustAbility.Left := 0;
   DAdjustAbility.Top := 0;
   g_nSaveBonusPoint := g_nBonusPoint;
   FillChar (g_BonusAbilChg, sizeof(TNakedAbility), #0);
   DAdjustAbility.Visible := TRUE;
end;
//丢金币到地上
procedure TFrmDlg.DBackgroundBackgroundClick(Sender: TObject);
var
   dropgold: integer;
   valstr: string;
begin
   if g_boItemMoving then begin
      DBackground.WantReturn := TRUE;
      if g_MovingItem.Item.S.Name = g_sGoldName then begin
         g_boItemMoving := FALSE;
         g_MovingItem.Item.S.Name := '';
         DialogSize := 1;
         DMessageDlg ('你要丢多少' +g_sGoldName+ '到地上？', [mbOk, mbAbort]);
         GetValidStrVal (DlgEditText, valstr, [' ']);
         dropgold := Str_ToInt (valstr, 0);
         FrmMain.SendDropGold (dropgold);
      end;
      if g_MovingItem.Index >= 0 then
         DropMovingItem;
   end;
end;

procedure TFrmDlg.DBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if g_boItemMoving then begin
      DBackground.WantReturn := TRUE;
   end;
end;

procedure TFrmDlg.DBottomMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
   function ExtractUserName (line: string): string;
   var
      uname: string;
   begin
      GetValidStr3 (line, line, ['(', '!', '*', '/', ')']);
      GetValidStr3 (line, uname, [' ', '=', ':']);
      if uname <> '' then
         if (uname[1] = '/') or (uname[1] = '(') or (uname[1] = ' ') or (uname[1] = '[') then
            uname := '';
      Result := uname;
   end;
var
   n: integer;
   str: string;
begin
   if (X >= 208) and (X <= 208+374) and (Y >= SCREENHEIGHT-130) and (Y <= SCREENHEIGHT-130 + 12*9) then begin
      n := DScreen.ChatBoardTop + (Y - (SCREENHEIGHT-130)) div 12;
      if (n < DScreen.ChatStrs.Count) then begin
         if not PlayScene.EdChat.Visible then begin
            PlayScene.EdChat.Visible := TRUE;
            PlayScene.EdChat.SetFocus;
         end;
         PlayScene.EdChat.Text := '/' + ExtractUserName (DScreen.ChatStrs[n]) + ' ';
         PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
         PlayScene.EdChat.SelLength := 0;
      end else
         PlayScene.EdChat.Text := ''; 
   end;
end;

{------------------------------------------------------------------------}

function  TFrmDlg.DMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
const
   XBase = 384;
var
  I: Integer;
   lx, ly: integer;
   d: TDirectDrawSurface;
  procedure ShowDice();
  var
    I: Integer;
    bo05:Boolean;
  begin
    if m_nDiceCount = 1 then begin
      if m_Dice[0].n67C < 20 then begin
        if GetTickCount - m_Dice[0].dwPlayTick > 100 then begin
          if m_Dice[0].n67C div 5 = 4 then begin
            m_Dice[0].nPlayPoint:=Random(6) + 1;
          end else begin
            m_Dice[0].nPlayPoint:=m_Dice[0].n67C div 5 + 8;
          end;
          m_Dice[0].dwPlayTick:=GetTickCount();
          Inc(m_Dice[0].n67C);
        end;
        exit;
      end;//00491461
      m_Dice[0].nPlayPoint:= m_Dice[0].nDicePoint;
      if GetTickCount - m_Dice[0].dwPlayTick > 1500 then begin
        DMsgDlg.Visible:=False;
      end;
      exit;
    end;//004914AD
    
    bo05:=True;
    for I := 0 to m_nDiceCount - 1 do begin
      if m_Dice[I].n67C < m_Dice[I].n680 then begin
        if GetTickCount - m_Dice[I].dwPlayTick > 100 then begin
          if m_Dice[I].n67C div 5 = 4 then begin
            m_Dice[I].nPlayPoint:=Random(6) + 1;
          end else begin
            m_Dice[I].nPlayPoint:=m_Dice[I].n67C div 5 + 8;
          end;
          m_Dice[I].dwPlayTick:=GetTickCount();
          Inc(m_Dice[I].n67C);
        end;
        bo05:=False;
      end else begin  //004915E4
        m_Dice[I].nPlayPoint:= m_Dice[I].nDicePoint;
        if GetTickCount - m_Dice[I].dwPlayTick < 2000 then begin
          bo05:=False;
        end;
      end;
    end; //for
    if bo05 then begin
      DMsgDlg.Visible:=False;
    end;
      
  end;
begin
   if DConfigDlg.Visible  then begin //打开提示框时关闭选项框
     DOptionClick();
   end;
     
   lx := XBase;
   ly := 126;
   case DialogSize of
      0:
         begin
            d := g_WMainImages.Images[381];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (g_WMainImages, 381);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               msglx := 39;
               msgly := 38;
               lx := 90;
               ly := 36;
            end;
         end;
      1:
         begin
            d := g_WMainImages.Images[360];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (g_WMainImages, 360);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               msglx := 39;
               msgly := 38;
               lx := XBase;
               ly := 155;
            end;
         end;
      2:
         begin
            d := g_WMainImages.Images[380];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (g_WMainImages, 380);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               //公告窗口
               msglx := 33;
               msgly := 25;
               lx := 145;
               ly := 425;
            end;
         end;
   end;
   MsgText := msgstr;
   ViewDlgEdit := FALSE;
   DMsgDlg.Floating := TRUE;
   DMsgDlgOk.Visible := FALSE;
   DMsgDlgYes.Visible := FALSE;
   DMsgDlgCancel.Visible := FALSE;
   DMsgDlgNo.Visible := FALSE;
   DMsgDlg.Left := (SCREENWIDTH - DMsgDlg.Width) div 2;
   DMsgDlg.Top := (SCREENHEIGHT - DMsgDlg.Height) div 2;

   for I := 0 to m_nDiceCount - 1 do begin
     m_Dice[I].n67C:=0;
     m_Dice[I].n680:=Random(m_nDiceCount + 2) * 5 + 10;
     m_Dice[I].nPlayPoint:=1;
     m_Dice[I].dwPlayTick:=GetTickCount();
   end;

   if mbCancel in DlgButtons then begin
      DMsgDlgCancel.Left := lx;
      DMsgDlgCancel.Top := ly;
      DMsgDlgCancel.Visible := TRUE;
      lx := lx - 100;
   end;
   if mbNo in DlgButtons then begin
      DMsgDlgNo.Left := lx;
      DMsgDlgNo.Top := ly;
      DMsgDlgNo.Visible := TRUE;
      lx := lx - 100;
   end;
   if mbYes in DlgButtons then begin
      DMsgDlgYes.Left := lx;
      DMsgDlgYes.Top := ly;
      DMsgDlgYes.Visible := TRUE;
      lx := lx - 100;
   end;
   if (mbOk in DlgButtons) or (lx = XBase) then begin
      DMsgDlgOk.Left := lx;
      DMsgDlgOk.Top := ly;
      DMsgDlgOk.Visible := TRUE;
      lx := lx - 100;
   end;
   HideAllControls;
   DMsgDlg.ShowModal;
   if mbAbort in DlgButtons then begin
      ViewDlgEdit := TRUE;
      DMsgDlg.Floating := FALSE;
      with EdDlgEdit do begin
         Text := '';
         Width := DMsgDlg.Width - 70;
         Left := (SCREENWIDTH - EdDlgEdit.Width) div 2;
         Top  := (SCREENHEIGHT - EdDlgEdit.Height) div 2 - 10;
      end;
   end;
   Result := mrOk;

   while TRUE do begin
      if not DMsgDlg.Visible then break;
      //FrmMain.DXTimerTimer (self, 0);
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;

      if m_nDiceCount > 0 then begin
        m_boPlayDice:=True;

        for I := 0 to m_nDiceCount - 1 do begin
          m_Dice[I].nX:=((DMsgDlg.Width div 2 + 6) - ((m_nDiceCount * 32 + m_nDiceCount) div 2)) + (I * 32 + I);
          m_Dice[I].nY:=DMsgDlg.Height div 2 - 14;
        end;
        ShowDice();
      end;
      if Application.Terminated then exit;
   end;
   
   EdDlgEdit.Visible := FALSE;
   RestoreHideControls;
   DlgEditText := EdDlgEdit.Text;
   if PlayScene.EdChat.Visible then PlayScene.EdChat.SetFocus;
   ViewDlgEdit := FALSE;
   Result := DMsgDlg.DialogResult;
   DialogSize := 1;
   m_nDiceCount:=0;
   m_boPlayDice:=False;
end;

function  TFrmDlg.DSimpleMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
const
   XBase = 384;
var
  I: Integer;
  lx, ly: integer;
  d: TDirectDrawSurface;
begin
  begin
     d := g_WMainImages.Images[990];
       if d <> nil then begin
         DMsgSimpleDlg.SetImgIndex (g_WMainImages, 990);
         DMsgSimpleDlg.Left := (SCREENWIDTH - d.Width) div 2;
         DMsgSimpleDlg.Top := (SCREENHEIGHT - d.Height) div 2;
         msglx := 39;
         msgly := 38;
         lx := 240;
         ly := 70;
       end;
     end;
   MsgText := msgstr;
   ViewDlgEdit := FALSE;
   DMsgSimpleDlg.Floating := TRUE;
   DMsgSimpleDlgOk.Visible := FALSE;
   DMsgSimpleDlgCancel.Visible := FALSE;
   DMsgSimpleDlg.Left := (SCREENWIDTH - DMsgSimpleDlg.Width) div 2;
   DMsgSimpleDlg.Top := (SCREENHEIGHT - DMsgSimpleDlg.Height) div 2;

   if g_MySelf.m_boDeath then begin
      FrmDlg.DMsgSimpleDlg.Left := 0;
      FrmDlg.DMsgSimpleDlg.Top := 0;
   end;

   if mbCancel in DlgButtons then begin
      DMsgSimpleDlgCancel.Left := lx;
      DMsgSimpleDlgCancel.Top := ly;
      DMsgSimpleDlgCancel.Visible := TRUE;
      lx := lx - 100;
   end;
   if (mbOk in DlgButtons) or (lx = XBase) then begin
      DMsgSimpleDlgOk.Left := lx;
      DMsgSimpleDlgOk.Top := ly;
      DMsgSimpleDlgOk.Visible := TRUE;
      lx := lx - 100;
   end;
   HideAllControls;
   DMsgSimpleDlg.ShowModal;
   if mbAbort in DlgButtons then begin
      ViewDlgEdit := TRUE;
      DMsgSimpleDlg.Floating := FALSE;
      with EdDlgEdit do begin
         Text := '';
         Width := DMsgDlg.Width - 70;
         Left := (SCREENWIDTH - EdDlgEdit.Width) div 2;
         Top  := (SCREENHEIGHT - EdDlgEdit.Height) div 2 - 10;
      end;
   end;
   Result := mrOk;

   while TRUE do begin
      if not DMsgSimpleDlg.Visible then break;
      //FrmMain.DXTimerTimer (self, 0);
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;
      if Application.Terminated then exit;
   end;

   EdDlgEdit.Visible := FALSE;
   RestoreHideControls;
   DlgEditText := EdDlgEdit.Text;
   if PlayScene.EdChat.Visible then PlayScene.EdChat.SetFocus;
   ViewDlgEdit := FALSE;
   Result := DMsgSimpleDlg.DialogResult;
end;

function  TFrmDlg.DCountMessageDlg (msgstr: string; DlgButtons: TMsgDlgButtons): TModalResult;
const
   XBase = 100;
var
  I: Integer;
  lx, ly: integer;
  d: TDirectDrawSurface;
begin
  begin
     d := g_WMainImages.Images[660];
       if d <> nil then begin
         DCountDlg.SetImgIndex (g_WMainImages, 660);
         DCountDlg.Left := (SCREENWIDTH - d.Width) div 2;
         DCountDlg.Top := (SCREENHEIGHT - d.Height) div 2;
         msglx := 43;
         msgly := 44;
         lx := 130;
         ly := 135;
       end;
     end;
   MsgText := msgstr;
   ViewDlgEdit := FALSE;
   DCountDlg.Floating := TRUE;
   DCountDlgMax.Visible := FALSE;
   DCountDlgOk.Visible := FALSE;
   DCountDlg.Left := (SCREENWIDTH - DCountDlg.Width) div 2;
   DCountDlg.Top := (SCREENHEIGHT - DCountDlg.Height) div 2;

   if mbYesToAll in DlgButtons then begin
      DCountDlgMax.Left := lx;
      DCountDlgMax.Top := ly;
      DCountDlgMax.Visible := TRUE;
      lx := lx - 80;
   end;

   if (mbOk in DlgButtons) or (lx = XBase) then begin
      DCountDlgOk.Left := lx;
      DCountDlgOk.Top := ly;
      DCountDlgOk.Visible := TRUE;
      lx := lx - 85;
   end;
   HideAllControls;
   DCountDlg.ShowModal;
   if mbAbort in DlgButtons then begin
      ViewDlgEdit := TRUE;
      DCountDlg.Floating := FALSE;
      with EdDlgEdit do begin
         Text := '';
         Width := DCountDlg.Width - 84;
         Left := (SCREENWIDTH - EdDlgEdit.Width) div 2;
         Top  := (SCREENHEIGHT - EdDlgEdit.Height) div 2 + 16;
      end;
   end;
   Result := mrOk;

   while TRUE do begin
      if not DCountDlg.Visible then break;
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;
      if Application.Terminated then exit;
   end;

   EdDlgEdit.Visible := FALSE;
   RestoreHideControls;
   DlgEditText := EdDlgEdit.Text;
   if PlayScene.EdChat.Visible then PlayScene.EdChat.SetFocus;
   ViewDlgEdit := FALSE;
   Result := DCountDlg.DialogResult;
end;

procedure TFrmDlg.DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DMsgDlgOk then DMsgDlg.DialogResult := mrOk;
   if Sender = DMsgDlgYes then DMsgDlg.DialogResult := mrYes;
   if Sender = DMsgDlgCancel then DMsgDlg.DialogResult := mrCancel;
   if Sender = DMsgDlgNo then DMsgDlg.DialogResult := mrNo;
   DMsgDlg.Visible := FALSE;
end;

procedure TFrmDlg.DMsgDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = 13 then begin
      if DMsgDlgOk.Visible and not (DMsgDlgYes.Visible or DMsgDlgCancel.Visible or DMsgDlgNo.Visible) then begin
         DMsgDlg.DialogResult := mrOk;
         DMsgDlg.Visible := FALSE;
      end;
      if DMsgDlgYes.Visible and not (DMsgDlgOk.Visible or DMsgDlgCancel.Visible or DMsgDlgNo.Visible) then begin
         DMsgDlg.DialogResult := mrYes;
         DMsgDlg.Visible := FALSE;
      end;
   end;
   if Key = 27 then begin
      if DMsgDlgCancel.Visible then begin
         DMsgDlg.DialogResult := mrCancel;
         DMsgDlg.Visible := FALSE;
      end;
   end;
end;
{
procedure TFrmDlg.DMsgDlgOkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  tGame:pGameInfo;
  tServer:pServerInfo;
  tStr:String;
begin
   with Sender as TDButton do begin
      if not Downed then
         d := WLib.Images[FaceIndex]
      else d := WLib.Images[FaceIndex+1];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      tGame:=GameList.Items[SelServerIndex];
      if (Name = 'DSServer1') and (tGame.ServerList.Count > 0) then begin
         tServer:=tGame.ServerList[0];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer2') and (tGame.ServerList.Count > 1) then begin
         tServer:=tGame.ServerList[1];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer3') and (tGame.ServerList.Count > 2) then begin
         tServer:=tGame.ServerList[2];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer4') and (tGame.ServerList.Count > 3) then begin
         tServer:=tGame.ServerList[3];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer5') and (tGame.ServerList.Count > 4) then begin
         tServer:=tGame.ServerList[4];
         tStr:=tServer.CaptionName;
      end;
      if (Name = 'DSServer6') and (tGame.ServerList.Count > 5) then begin
         tServer:=tGame.ServerList[5];
         tStr:=tServer.CaptionName;
      end;
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Size :=12;
          BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(tStr)) div 2), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(tStr)) div 2), clYellow, clBlack, tStr);
          dsurface.Canvas.Font.Size :=9;          
//          dsurface.Canvas.Font:=oFont;
          dsurface.Canvas.Release;
   end;
end;
}
procedure TFrmDlg.DMsgDlgOkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  tStr:String;
  Color:TColor;
  nStatus:Integer;
begin
try
   nStatus:=-1;
   with Sender as TDButton do begin
      if not Downed then
         d := WLib.Images[FaceIndex]
      else d := WLib.Images[FaceIndex+1];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      if (Name = 'DSServer1') and (g_ServerList.Count >= 1) then begin
        tStr:=g_ServerList.Strings[0];
        nStatus:=Integer(g_ServerList.Objects[0]);
      end;
      if (Name = 'DSServer2') and (g_ServerList.Count >= 2) then begin
        tStr:=g_ServerList.Strings[1];
        nStatus:=Integer(g_ServerList.Objects[1]);
      end;
      if (Name = 'DSServer3') and (g_ServerList.Count >= 3) then begin
        tStr:=g_ServerList.Strings[2];
        nStatus:=Integer(g_ServerList.Objects[2]);
      end;
      if (Name = 'DSServer4') and (g_ServerList.Count >= 4) then begin
        tStr:=g_ServerList.Strings[3];
        nStatus:=Integer(g_ServerList.Objects[3]);
      end;
      if (Name = 'DSServer5') and (g_ServerList.Count >= 5) then begin
        tStr:=g_ServerList.Strings[4];
        nStatus:=Integer(g_ServerList.Objects[4]);
      end;
      if (Name = 'DSServer6') and (g_ServerList.Count >= 6) then begin
        tStr:=g_ServerList.Strings[5];
        nStatus:=Integer(g_ServerList.Objects[5]);
      end;
      if (Name = 'DSServer7') and (g_ServerList.Count >= 7) then begin
        tStr:=g_ServerList.Strings[6];
        nStatus:=Integer(g_ServerList.Objects[6]);
      end;
      if (Name = 'DSServer8') and (g_ServerList.Count >= 8) then begin
        tStr:=g_ServerList.Strings[7];
        nStatus:=Integer(g_ServerList.Objects[7]);
      end;
      Color:=clYellow;
      case nStatus of
        0: begin
          tStr:=tStr + '(维护)';
          Color:=clDkGray;
        end;
        1: begin
          tStr:=tStr + '(空闲)';
          Color:=clLime;
        end;
        2: begin
          tStr:=tStr + '(良好)';
          Color:=clGreen;
        end;
        3: begin
          tStr:=tStr + '(繁忙)';
          Color:=clMaroon;
        end;
        4: begin
          tStr:=tStr + '(满员)';
          Color:=clRed;
        end;
      end;
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          if TDButton(Sender).Downed then begin
            BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(tStr)) div 2) + 2, SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(tStr)) div 2) + 7, Color{clYellow}, clBlack, tStr);
          end else begin
            BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(tStr)) div 2), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(tStr)) div 2) + 5, Color{clYellow}, clBlack, tStr);
          end;
          dsurface.Canvas.Font.Style:=[];
          dsurface.Canvas.Font.Size :=9;
          dsurface.Canvas.Release;
   end;
except
  on e: Exception do begin
    ShowMessage(E.Message);
  end;
end;
end;

procedure TFrmDlg.DMsgDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  I: Integer;
  d: TDirectDrawSurface;
  ly: integer;
  str, data: string;
  nX,nY:Integer;
begin
   with Sender as TDWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      if m_boPlayDice then begin
        for I := 0 to m_nDiceCount - 1 do begin
          d:=g_WBagItemImages.GetCachedImage(m_Dice[I].nPlayPoint + 376 - 1,nX,nY);
          if d <> nil then begin
            dsurface.Draw (SurfaceX(Left) + m_Dice[I].nX + nX - 14, SurfaceY(Top) + m_Dice[I].nY + nY + 38, d.ClientRect, d, TRUE);
          end;
        end;
      end;

      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      ly := msgly;
      str := MsgText;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then
            BoldTextOut (dsurface, SurfaceX(Left+msglx), SurfaceY(Top+ly), clWhite, clBlack, data);
         ly := ly + 14;
      end;
      dsurface.Canvas.Release;
   end;
   if ViewDlgEdit then begin
      if not EdDlgEdit.Visible then begin
         EdDlgEdit.Visible := TRUE;
         EdDlgEdit.SetFocus;
      end;
   end;
end;

{------------------------------------------------------------------------}

procedure TFrmDlg.DLoginNewDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if TDButton(Sender).Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DLoginNewClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.NewClick;
end;

procedure TFrmDlg.DLoginOkClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.OkClick;
end;

procedure TFrmDlg.DLoginCloseClick(Sender: TObject; X, Y: Integer);
begin
   FrmMain.Close;
end;

procedure TFrmDlg.DLoginChgPwClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.ChgPwClick;
end;

procedure TFrmDlg.DLoginNewClickSound(Sender: TObject;
  Clicksound: TClickSound);
begin
   case Clicksound of
      csNorm:  PlaySound (s_norm_button_click);
      csStone: PlaySound (s_rock_button_click);
      csGlass: PlaySound (s_glass_button_click);
   end;
end;

{------------------------------------------------------------------------}
{
procedure TFrmDlg.ShowSelectServerDlg;
var
  tGame:pGameInfo;
  tServer:pServerInfo;
begin
  tGame:=GameList.Items[SelServerIndex];
   case tGame.ServerList.Count of
     1:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=204;
         DSServer2.Visible:=False;
         DSServer3.Visible:=False;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     2:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=200;
         DSServer2.Visible:=True;
         DSServer2.Top:=250;
         DSServer3.Visible:=False;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     3:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     4:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
       end;
     5:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=False;
       end;
     6:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=True;
       end;
   end;
   DSelServerDlg.Visible := TRUE;
end;
}
procedure TFrmDlg.ShowSelectServerDlg;
begin
   case g_ServerList.Count of
     1:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=205;
         DSServer2.Visible:=False;
         DSServer3.Visible:=False;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
         DSServer7.Visible:=False;
         DSServer8.Visible:=False;
       end;
     2:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=190;
         DSServer2.Visible:=True;
         DSServer2.Top:=235;
         DSServer3.Visible:=False;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
         DSServer7.Visible:=False;
         DSServer8.Visible:=False;
       end;
     3:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=175;
         DSServer2.Visible:=True;
         DSServer2.Top:=220;
         DSServer3.Visible:=True;
         DSServer3.Top:=265;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
         DSServer7.Visible:=False;
         DSServer8.Visible:=False;
       end;
     4:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=160;
         DSServer2.Visible:=True;
         DSServer2.Top:=205;
         DSServer3.Visible:=True;
         DSServer3.Top:=250;
         DSServer4.Visible:=True;
         DSServer4.Top:=295;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
         DSServer7.Visible:=False;
         DSServer8.Visible:=False;
       end;
     5:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=145;
         DSServer2.Visible:=True;
         DSServer2.Top:=190;
         DSServer3.Visible:=True;
         DSServer3.Top:=235;
         DSServer4.Visible:=True;
         DSServer4.Top:=280;
         DSServer5.Visible:=True;
         DSServer5.Top:=325;
         DSServer6.Visible:=False;
         DSServer7.Visible:=False;
         DSServer8.Visible:=False;
       end;
     6:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=125;
         DSServer2.Visible:=True;
         DSServer2.Top:=170;
         DSServer3.Visible:=True;
         DSServer3.Top:=215;
         DSServer4.Visible:=True;
         DSServer4.Top:=260;
         DSServer5.Visible:=True;
         DSServer5.Top:=305;
         DSServer6.Visible:=True;
         DSServer6.Top:=350;
         DSServer7.Visible:=False;
         DSServer8.Visible:=False;
       end;
     7:begin
         DSServer1.Visible:=True;
         DSServer1.Top:=100;
         DSServer2.Visible:=True;
         DSServer2.Top:=145;
         DSServer3.Visible:=True;
         DSServer3.Top:=190;
         DSServer4.Visible:=True;
         DSServer4.Top:=235;
         DSServer5.Visible:=True;
         DSServer5.Top:=280;
         DSServer6.Visible:=True;
         DSServer6.Top:=325;
         DSServer7.Visible:=True;
         DSServer7.Top:=370;
         DSServer8.Visible:=False;
       end;
     8:begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=True;
         DSServer7.Visible:=True;
         DSServer8.Visible:=True;
       end;
     else begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=True;
         DSServer7.Visible:=True;
         DSServer8.Visible:=True;
       end;
   end;
   DSelServerDlg.Visible:=TRUE;

   if g_boAutoServer then FrmMain.SendSelectServer(g_sAutoServerName); 
end;
procedure TFrmDlg.DSelServerDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var  
   d: TDirectDrawSurface;
begin

end;
{
procedure TFrmDlg.DSServer1Click(Sender: TObject; X, Y: Integer);
var
  svname: string;
  tGame:pGameInfo;
  tServer:pServerInfo;
begin
   svname := '';
   tGame:=GameList.Items[SelServerIndex];
   if Sender = DSServer1 then begin
     tServer:=tGame.ServerList.Items[0];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer2 then begin
     tServer:=tGame.ServerList.Items[1];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer3 then begin
     tServer:=tGame.ServerList.Items[2];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer4 then begin
     tServer:=tGame.ServerList.Items[3];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer5 then begin
     tServer:=tGame.ServerList.Items[4];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer6 then begin
     tServer:=tGame.ServerList.Items[5];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if svname <> '' then begin
      if BO_FOR_TEST then begin
         svname := '泅公辑滚';
         ServerMiniName := '泅公';
      end;
      FrmMain.SendSelectServer (svname);
      DSelServerDlg.Visible := FALSE;
      ServerName := svname;
   end;
end;
}
procedure TFrmDlg.DSServer1Click(Sender: TObject; X, Y: Integer);
var
  svname: string;
begin
   svname := '';
   if Sender = DSServer1 then begin
     svname:=g_ServerList.Strings[0];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer2 then begin
     svname:=g_ServerList.Strings[1];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer3 then begin
     svname:=g_ServerList.Strings[2];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer4 then begin
     svname:=g_ServerList.Strings[3];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer5 then begin
     svname:=g_ServerList.Strings[4];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer6 then begin
     svname:=g_ServerList.Strings[5];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer7 then begin
     svname:=g_ServerList.Strings[6];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer8 then begin
     svname:=g_ServerList.Strings[7];
     g_sServerMiniName:=svname;
   end;
   if svname <> '' then begin
      if BO_FOR_TEST then begin
         svname := '传奇体验区';
         g_sServerMiniName := '传奇';
      end;
      FrmMain.SendSelectServer (svname);
      DSelServerDlg.Visible := FALSE;
      g_sServerName := svname;
   end;
end;

procedure TFrmDlg.DEngServer1Click(Sender: TObject; X, Y: Integer);
var
   svname: string;
begin
   svname := 'DragonServer';
   g_sServerMiniName := svname;

   if svname <> '' then begin
      FrmMain.SendSelectServer (svname);
      DSelServerDlg.Visible := FALSE;
      g_sServerName := svname;
   end;
end;


procedure TFrmDlg.DSSrvCloseClick(Sender: TObject; X, Y: Integer);
begin
   DSelServerDlg.Visible := FALSE;
   FrmMain.Close;
end;

{------------------------------------------------------------------------}

procedure TFrmDlg.DNewAccountOkClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.NewAccountOk;
end;

procedure TFrmDlg.DNewAccountCloseClick(Sender: TObject; X, Y: Integer);
begin
   LoginScene.NewAccountClose;
end;

procedure TFrmDlg.DNewAccountDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   i: integer;
begin
   with dsurface.Canvas do begin
      with DNewAccount do begin
         d := DMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clSilver;
      for i:=0 to NAHelps.Count-1 do begin
         TextOut ((SCREENWIDTH div 2 - 320) + 386 + 10, (SCREENHEIGHT div 2 - 238) + 119 + 5 + i*14, NAHelps[i]);
      end;
      BoldTextOut (dsurface, 79+283, 64 + 57, clWhite, clBlack, NewAccountTitle);
      Release;
   end;
end;

{------------------------------------------------------------------------}

procedure TFrmDlg.DChgpwOkClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DChgpwOk then LoginScene.ChgpwOk;
   if Sender = DChgpwCancel then LoginScene.ChgpwCancel;
end;

{------------------------------------------------------------------------}

procedure TFrmDlg.DscSelect1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (Left, Top, d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DscSelect1Click(Sender: TObject; X, Y: Integer);
begin
   if Sender = DscSelect1 then SelectChrScene.SelChrSelect1Click;
   if Sender = DscSelect2 then SelectChrScene.SelChrSelect2Click;
   if Sender = DscSelect3 then SelectChrScene.SelChrSelect3Click;   
   if Sender = DscStart then SelectChrScene.SelChrStartClick;
   if Sender = DscNewChr then SelectChrScene.SelChrNewChrClick;
   if Sender = DscEraseChr then SelectChrScene.SelChrEraseChrClick;
   if Sender = DscCredits then SelectChrScene.SelChrCreditsClick;
   if Sender = DscExit then SelectChrScene.SelChrExitClick;
end;

{------------------------------------------------------------------------}

procedure TFrmDlg.DSalesCancelDirectPaintt(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   e: TDirectDrawSurface;
//   f: TDirectDrawSurface;
   img: Integer;
   ax,ay: integer;
begin
   with Sender as TDButton do begin
      if Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then begin
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
         end;
       end else begin
         d := nil;
         e := nil;
         if Sender = DccWarrior then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Job = 0 then
                 d := WLib.Images[55];
         end;
         if Sender = DccWizzard then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Job = 1 then
                 d := WLib.Images[56];
         end;
         if Sender = DccMonk then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Job = 2 then
                 d := WLib.Images[57];
         end;
         if Sender = DccMale then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Sex = 0 then d := WLib.Images[58];
         end;
         if Sender = DccFemale then begin
            with SelectChrScene do
               if ChrArr[NewIndex].UserChr.Sex = 1 then d := WLib.Images[59];
         end;

         if d <> nil then begin
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
           img := 20 + SelectChrScene.ChrArr[SelectChrScene.NewIndex].UserChr.Job * 40 + SelectChrScene.ChrArr[SelectChrScene.NewIndex].UserChr.Sex * 120;
           img := img+SelectChrScene.ChrArr[SelectChrScene.NewIndex].aniIndex;
           e := g_WChrSelImages.GetCachedImage(img,ax,ay);
          // FixMe: TD Can you put the code needed to workout the offset in here somewhere
          // So that teh dude doesn't jump around!
           if e <> nil then dsurface.Draw (240 + ax, 296 + ay, e.ClientRect, e, TRUE);
         end;
      end;
   end;
end;

procedure TFrmDlg.DccCloseClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DccClose then SelectChrScene.SelChrNewClose;
   if Sender = DccWarrior then SelectChrScene.SelChrNewJob (0);
   if Sender = DccWizzard then SelectChrScene.SelChrNewJob (1);
   if Sender = DccMonk then SelectChrScene.SelChrNewJob (2);
   if Sender = DccReserved then SelectChrScene.SelChrNewJob (3);
   if Sender = DccMale then SelectChrScene.SelChrNewm_btSex (0);
   if Sender = DccFemale then SelectChrScene.SelChrNewm_btSex (1);
   if Sender = DccOk then SelectChrScene.SelChrNewOk;
end;

{------------------------------------------------------------------------}

{------------------------------------------------------------------------}

procedure TFrmDlg.DStateWinDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   i, l, m, pgidx, magline, bbx, bby, mmx, idx, ax, ay, trainlv: integer;
   pm: PTClientMagic;
   d: TDirectDrawSurface;
   hcolor, old, keyimg: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
   output:string;
begin
   if g_MySelf = nil then exit;
   with DStateWin do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      if g_LoverNameClient <> '' then begin
       DHeartMyState.Visible := True;
      end else begin
       DHeartMyState.Visible := False;
      end;

      case StatePage of
         0: begin
            pgidx := 376;
            if g_MySelf <> nil then
               if g_MySelf.m_btSex = 1 then pgidx := 377;
            bbx := Left + 38;
            bby := Top + 59;
            d := g_WMainImages.Images[pgidx];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);
            bbx := bbx - 7;
            bby := bby + 44;
            //显示衣服
            if g_UseItems[U_DRESS].S.Name <> '' then begin
               idx := g_UseItems[U_DRESS].S.Looks; //if Myself.m_btSex = 1 then idx := 80;
               if idx >= 0 then begin
                  //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  d := FrmMain.GetWStateImg(idx,ax,ay);
                  if d <> nil then
                     dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
               end;
            end;
            //显示头发
            idx := 440 + g_MySelf.m_btHair div 2;
            if g_MySelf.m_btSex = 1 then idx := 480 + g_MySelf.m_btHair div 2;
            if idx > 0 then begin
               d := g_WMainImages.GetCachedImage (idx, ax, ay);
               if d <> nil then
                  dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
            end;
            //显示武器
            if g_UseItems[U_WEAPON].S.Name <> '' then begin
               idx := g_UseItems[U_WEAPON].S.Looks;
               if idx >= 0 then begin
                  //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  d := FrmMain.GetWStateImg(idx,ax,ay);
                  if d <> nil then
                     dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
                 if idx = 923 then begin
                    d := FrmMain.GetWStateImg(idx-1,ax,ay);
                    if d <> nil then
                    DrawBlend (dsurface,bbx + ax,bby + ay,d, 1);
                 end;
              end;
            end;
            if g_UseItems[U_HELMET].S.Name <> '' then begin
               idx := g_UseItems[U_HELMET].S.Looks;
               if idx >= 0 then begin
                  //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  d := FrmMain.GetWStateImg(idx,ax,ay);
                  if d <> nil then
                     dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
               end;
            end;
         end;
         1: begin
            l := Left + 103;
            m := Top + 99;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(l+0), SurfaceY(m+15), IntToStr(LoWord(g_MySelf.m_Abil.AC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.AC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+37), IntToStr(LoWord(g_MySelf.m_Abil.MAC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MAC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+59), IntToStr(LoWord(g_MySelf.m_Abil.DC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.DC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+81), IntToStr(LoWord(g_MySelf.m_Abil.MC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+103), IntToStr(LoWord(g_MySelf.m_Abil.SC)) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.SC)));
               TextOut (SurfaceX(l+0), SurfaceY(m+125), IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP));
               TextOut (SurfaceX(l+0), SurfaceY(m+146), IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP));
               Release;
            end;
         end;
         2: begin
            bbx := Left + 38;
            bby := Top + 59;
            d := g_WMainImages.Images[382];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);

            bbx := bbx + 20;
            bby := bby + 10;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               mmx := bbx + 85;
               Font.Color := clSilver;
               TextOut (bbx, bby, '经验值');
               TextOut (mmx, bby, FloatToStrFixFmt (100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) + '%');
               //TextOut (bbx, bby+14*1, '弥措版氰');
               //TextOut (mmx, bby+14*1, IntToStr(Myself.Abil.MaxExp));

               TextOut (bbx, bby+14*1, '背包重量');
               if g_MySelf.m_Abil.Weight > g_MySelf.m_Abil.MaxWeight then
                  Font.Color := clRed;
               TextOut (mmx, bby+14*1, IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight));

               Font.Color := clSilver;
               TextOut (bbx, bby+14*2, '人物负量');
               if g_MySelf.m_Abil.WearWeight > g_MySelf.m_Abil.MaxWearWeight then
                  Font.Color := clRed;
               TextOut (mmx, bby+14*2, IntToStr(g_MySelf.m_Abil.WearWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWearWeight));

               Font.Color := clSilver;
               TextOut (bbx, bby+14*3, '腕力');
               if g_MySelf.m_Abil.HandWeight > g_MySelf.m_Abil.MaxHandWeight then
                  Font.Color := clRed;
               TextOut (mmx, bby+14*3, IntToStr(g_MySelf.m_Abil.HandWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxHandWeight));

               Font.Color := clSilver;
               TextOut (bbx, bby+14*4, '准确');
               TextOut (mmx, bby+14*4, IntToStr(g_nMyHitPoint));

               TextOut (bbx, bby+14*5, '敏捷');
               TextOut (mmx, bby+14*5, IntToStr(g_nMySpeedPoint));

               TextOut (bbx, bby+14*6, '魔法躲避');
               TextOut (mmx, bby+14*6, '+' + IntToStr(g_nMyAntiMagic * 10) + '%');

               TextOut (bbx, bby+14*7, '毒物躲避');
               TextOut (mmx, bby+14*7, '+' + IntToStr(g_nMyAntiPoison * 10) + '%');

               TextOut (bbx, bby+14*8, '中毒恢复');
               TextOut (mmx, bby+14*8, '+' + IntToStr(g_nMyPoisonRecover * 10) + '%');

               TextOut (bbx, bby+14*9, '体力恢复');
               TextOut (mmx, bby+14*9, '+' + IntToStr(g_nMyHealthRecover * 10) + '%');

               TextOut (bbx, bby+14*10, '魔法恢复');
               TextOut (mmx, bby+14*10, '+' + IntToStr(g_nMySpellRecover * 10) + '%');

               //TextOut (bbx, bby+14*11, g_sGameGoldName);
               //TextOut (mmx, bby+14*11, IntToStr(g_MySelf.m_nGameGold * 1));

               //TextOut (bbx, bby+14*12, g_sGamePointName);
               //TextOut (mmx, bby+14*12, IntToStr(g_MySelf.m_nGamePoint * 1));

               Release;
            end;
         end;
         3: begin //魔法窗口
            bbx := Left + 38;
            bby := Top + 59;
            d := g_WMainImages.Images[383];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);

            //等级, 经验
            magtop := MagicPage * 5;
            magline := _MIN(MagicPage*5+5, g_MagicList.Count);
            for i:=magtop to magline-1 do begin
               pm := PTClientMagic (g_MagicList[i]);
               m := i - magtop;
               keyimg := 0;
               case byte(pm.Key) of
                  byte('1'): keyimg := 750;
                  byte('2'): keyimg := 751;
                  byte('3'): keyimg := 752;
                  byte('4'): keyimg := 753;
                  byte('5'): keyimg := 754;
                  byte('6'): keyimg := 755;
                  byte('7'): keyimg := 756;
                  byte('8'): keyimg := 757;
                  byte('E'): keyimg := 758;
                  byte('F'): keyimg := 759;
                  byte('G'): keyimg := 760;
                  byte('H'): keyimg := 761;
                  byte('I'): keyimg := 762;
                  byte('J'): keyimg := 763;
                  byte('K'): keyimg := 764;
                  byte('L'): keyimg := 765;
               end;
               if keyimg > 0 then begin
                  d := g_WMainImages.Images[keyimg];
                  if d <> nil then
                     dsurface.Draw (bbx + 138, bby+35+m*37, d.ClientRect, d, TRUE);
               end;
               d := g_WMainImages.Images[112];
               if d <> nil then
                  dsurface.Draw (bbx + 48, bby+8+40+m*37, d.ClientRect, d, TRUE);
               d := g_WMainImages.Images[111];
               if d <> nil then
                  dsurface.Draw (bbx + 48 + 26, bby+8+40+m*37, d.ClientRect, d, TRUE);
            end;

            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clSilver;
               for i:=magtop to magline-1 do begin
                  pm := PTClientMagic (g_MagicList[i]);
                  m := i - magtop;
                  if not (pm.Level in [0..3]) then pm.Level := 0;

                  TextOut (bbx + 48, bby + 32 + m*37,
                              pm.Def.sMagicName);
                  if pm.Level in [0..3] then trainlv := pm.Level
                  else trainlv := 0;
                  TextOut (bbx + 48 + 16, bby + 8 + 40 + m*37, IntToStr(pm.Level));
                  if pm.Def.MaxTrain[trainlv] > 0 then begin
                     if trainlv < 3 then
                        TextOut (bbx + 48 + 46, bby + 8 + 40 + m*37, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]))

                     else TextOut (bbx + 48 + 46, bby + 8 + 40 + m*37, '-');
                  end;
               end;
               Release;
            end;
         end;
      end;
      {原为打开，本代码为显示人物身上所带物品信息，显示位置为人物下方
      if g_MouseStateItem.S.Name <> '' then begin
         g_MouseItem := g_MouseStateItem;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         if iname <> '' then begin
            if g_MouseItem.Dura = 0 then hcolor := clRed
            else hcolor := clWhite;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               old := Font.Size;
               Font.Size := 8;
               Font.Color := clYellow;
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272), iname);
               Font.Color := hcolor;
               TextOut (SurfaceX(Left+37+TextWidth(iname)), SurfaceY(Top+272), d1);
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272+TextHeight('A')+2), d2);
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272+(TextHeight('A')+2)*2), d3);
               Font.Size := old;
               Release;
            end;
         end;
         g_MouseItem.S.Name := '';
      end;
      }

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := g_MySelf.m_nNameColor;
         TextOut (SurfaceX(Left + 122 - TextWidth(FrmMain.CharName) div 2),
                  SurfaceY(Top + 10), g_MySelf.m_sUserName);
         if StatePage = 0 then begin
            Font.Color := clSilver;
            output:= g_sGuildName + ' ' + g_sGuildRankName;
            TextOut (SurfaceX(Left + 120) - TextWidth(output) div 2, SurfaceY(Top + 25),
                     output);
         end;
         Release;
      end;
   end;
end;

procedure TFrmDlg.DSWLightDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
   tidx:integer;
begin
   if StatePage = 0 then begin
      if Sender = DSWNecklace then begin
         if g_UseItems[U_NECKLACE].S.Name <> '' then begin
            idx := g_UseItems[U_NECKLACE].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWNecklace.SurfaceX(DSWNecklace.Left + (DSWNecklace.Width - d.Width) div 2),
                                 DSWNecklace.SurfaceY(DSWNecklace.Top + (DSWNecklace.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWLight then begin
         if g_UseItems[U_RIGHTHAND].S.Name <> '' then begin
            idx := g_UseItems[U_RIGHTHAND].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWLight.SurfaceX(DSWLight.Left + (DSWLight.Width - d.Width) div 2),
                                 DSWLight.SurfaceY(DSWLight.Top + (DSWLight.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWArmRingR then begin
         if g_UseItems[U_ARMRINGR].S.Name <> '' then begin
            idx := g_UseItems[U_ARMRINGR].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWArmRingR.SurfaceX(DSWArmRingR.Left + (DSWArmRingR.Width - d.Width) div 2),
                                 DSWArmRingR.SurfaceY(DSWArmRingR.Top + (DSWArmRingR.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWArmRingL then begin
         if g_UseItems[U_ARMRINGL].S.Name <> '' then begin
            idx := g_UseItems[U_ARMRINGL].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWArmRingL.SurfaceX(DSWArmRingL.Left + (DSWArmRingL.Width - d.Width) div 2),
                                 DSWArmRingL.SurfaceY(DSWArmRingL.Top + (DSWArmRingL.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWRingR then begin
         if g_UseItems[U_RINGR].S.Name <> '' then begin
            idx := g_UseItems[U_RINGR].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWRingR.SurfaceX(DSWRingR.Left + (DSWRingR.Width - d.Width) div 2),
                                 DSWRingR.SurfaceY(DSWRingR.Top + (DSWRingR.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
      if Sender = DSWRingL then begin
         if g_UseItems[U_RINGL].S.Name <> '' then begin
            idx := g_UseItems[U_RINGL].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWRingL.SurfaceX(DSWRingL.Left + (DSWRingL.Width - d.Width) div 2),
                                 DSWRingL.SurfaceY(DSWRingL.Top + (DSWRingL.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;

      if Sender = DSWBujuk then begin
         if g_UseItems[U_BUJUK].S.Name <> '' then begin
            idx := g_UseItems[U_BUJUK].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWBujuk.SurfaceX(DSWBujuk.Left + (DSWBujuk.Width - d.Width) div 2),
                                 DSWBujuk.SurfaceY(DSWBujuk.Top + (DSWBujuk.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;

      if Sender = DSWBelt then begin
         if g_UseItems[U_BELT].S.Name <> '' then begin
            idx := g_UseItems[U_BELT].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWBelt.SurfaceX(DSWBelt.Left + (DSWBelt.Width - d.Width) div 2),
                                 DSWBelt.SurfaceY(DSWBelt.Top + (DSWBelt.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;

      if Sender = DSWBoots then begin
         if g_UseItems[U_BOOTS].S.Name <> '' then begin
            idx := g_UseItems[U_BOOTS].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWBoots.SurfaceX(DSWBoots.Left + (DSWBoots.Width - d.Width) div 2),
                                 DSWBoots.SurfaceY(DSWBoots.Top + (DSWBoots.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;

      if Sender = DSWCharm then begin
         if g_UseItems[U_CHARM].S.Name <> '' then begin
            idx := g_UseItems[U_CHARM].S.Looks;
            if idx >= 0 then begin
               //d := FrmMain.WStateItem.Images[idx];
               d := FrmMain.GetWStateImg(idx);
               if d <> nil then
                  dsurface.Draw (DSWCharm.SurfaceX(DSWCharm.Left + (DSWCharm.Width - d.Width) div 2),
                                 DSWCharm.SurfaceY(DSWCharm.Top + (DSWCharm.Height - d.Height) div 2),
                                 d.ClientRect, d, TRUE);
            end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DStateWinClick(Sender: TObject; X, Y: Integer);
begin
   if StatePage = 3 then begin
      X := DStateWin.LocalX (X) - DStateWin.Left;
      Y := DStateWin.LocalY (Y) - DStateWin.Top;
      if (X >= 33) and (X <= 33+166) and (Y >= 55) and (Y <= 55+37*5) then begin
         magcur := (Y-55) div 37;
         if (magcur+magtop) >= g_MagicList.Count then
            magcur := (g_MagicList.Count-1) - magtop;
      end;
   end;
end;

procedure TFrmDlg.DCloseStateClick(Sender: TObject; X, Y: Integer);
begin
   DStateWin.Visible := FALSE;
end;

procedure TFrmDlg.DPrevStateDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if TDButton(Sender).Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.PageChanged;
begin
   DScreen.ClearHint;
   case StatePage of
      3: begin
         DStMag1.Visible := TRUE;  DStMag2.Visible := TRUE;
         DStMag3.Visible := TRUE;  DStMag4.Visible := TRUE;
         DStMag5.Visible := TRUE;
         DStPageUp.Visible := TRUE;
         DStPageDown.Visible := TRUE;
         MagicPage := 0;
      end;
      else begin
         DStMag1.Visible := FALSE;  DStMag2.Visible := FALSE;
         DStMag3.Visible := FALSE;  DStMag4.Visible := FALSE;
         DStMag5.Visible := FALSE;
         DStPageUp.Visible := FALSE;
         DStPageDown.Visible := FALSE;
      end;
   end;
end;

procedure TFrmDlg.DPrevStateClick(Sender: TObject; X, Y: Integer);
begin
   Dec (StatePage);
   if StatePage < 0 then
      StatePage := MAXSTATEPAGE-1;
   PageChanged;
end;

procedure TFrmDlg.DNextStateClick(Sender: TObject; X, Y: Integer);
begin
   Inc (StatePage);
   if StatePage > MAXSTATEPAGE-1 then
      StatePage := 0;
   PageChanged;
end;

procedure TFrmDlg.DSWWeaponClick(Sender: TObject; X, Y: Integer);
var
   where, n, sel: integer;
   flag, movcancel: Boolean;
begin
   if g_MySelf = nil then exit;
   if StatePage <> 0 then exit;
   if g_boItemMoving then begin
      flag := FALSE;
      movcancel := FALSE;
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Item.S.Name = '') or (g_WaitingUseItem.Item.S.Name <> '') then exit;
      where := GetTakeOnPosition (g_MovingItem.Item.S.StdMode);
      if g_MovingItem.Index >= 0 then begin
         case where of
            U_DRESS: begin
               if Sender = DSWDress then begin
                   if g_MySelf.m_btSex = 0 then
                     if g_MovingItem.Item.S.StdMode = 11 then //male trying to put on female armour
                        exit;
                  if g_MySelf.m_btSex = 1 then
                     if g_MovingItem.Item.S.StdMode = 10 then
                        exit;
                  flag := TRUE;
               end;
            end;
            U_WEAPON: begin
               if Sender = DSWWEAPON then begin
                  flag := TRUE;
               end;
            end;
            U_NECKLACE: begin
               if Sender = DSWNecklace then
                  flag := TRUE;
            end;
            U_RIGHTHAND: begin
               if Sender = DSWLight then
                  flag := TRUE;
            end;
            U_HELMET: begin
               if Sender = DSWHelmet then
                  flag := TRUE;
            end;
            U_RINGR, U_RINGL: begin
               if Sender = DSWRingL then begin
                  where := U_RINGL;
                  flag := TRUE;
               end;
               if Sender = DSWRingR then begin
                  where := U_RINGR;
                  flag := TRUE;
               end;
            end;
            U_ARMRINGR: begin
               if Sender = DSWArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
               if Sender = DSWArmRingR then begin
                  where := U_ARMRINGR;
                  flag := TRUE;
               end;
            end;
            U_ARMRINGL: begin
               if Sender = DSWArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
            end;
            U_BUJUK: begin
               if Sender = DSWBujuk then begin
                  where := U_BUJUK;
                  flag := TRUE;
               end;
               if Sender = DSWArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;               
            end;
            U_BELT: begin
               if Sender = DSWBelt then begin
                  where := U_BELT;
                  flag := TRUE;
               end;
            end;
            U_BOOTS: begin
               if Sender = DSWBoots then begin
                  where := U_BOOTS;
                  flag := TRUE;
               end;
            end;
            U_CHARM: begin
               if Sender = DSWCharm then begin
                  where := U_CHARM;
                  flag := TRUE;
               end;
            end;
         end;
      end else begin
         n := -(g_MovingItem.Index+1);
         if n in [0..12] then begin
            ItemClickSound (g_MovingItem.Item.S);
            g_UseItems[n] := g_MovingItem.Item;
            g_MovingItem.Item.S.Name := '';
            g_boItemMoving := FALSE;
         end;
      end;
      if flag then begin
         ItemClickSound (g_MovingItem.Item.S);
         g_WaitingUseItem := g_MovingItem;
         g_WaitingUseItem.Index := where;

         FrmMain.SendTakeOnItem (where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
         g_MovingItem.Item.S.Name := '';
         g_boItemMoving := FALSE;
      end;
   end else begin
      flag := FALSE;
      if (g_MovingItem.Item.S.Name <> '') or (g_WaitingUseItem.Item.S.Name <> '') then exit;
      sel := -1;
      if Sender = DSWDress then sel := U_DRESS;
      if Sender = DSWWeapon then sel := U_WEAPON;
      if Sender = DSWHelmet then sel := U_HELMET;
      if Sender = DSWNecklace then sel := U_NECKLACE;
      if Sender = DSWLight then sel := U_RIGHTHAND;
      if Sender = DSWRingL then sel := U_RINGL;
      if Sender = DSWRingR then sel := U_RINGR;
      if Sender = DSWArmRingL then sel := U_ARMRINGL;
      if Sender = DSWArmRingR then sel := U_ARMRINGR;

      if Sender = DSWBujuk then sel := U_BUJUK;
      if Sender = DSWBelt then sel := U_BELT;
      if Sender = DSWBoots then sel := U_BOOTS;
      if Sender = DSWCharm then sel := U_CHARM;

      if sel >= 0 then begin
         if g_UseItems[sel].S.Name <> '' then begin
            ItemClickSound (g_UseItems[sel].S);
            g_MovingItem.Index := -(sel+1);
            g_MovingItem.Item := g_UseItems[sel];
            g_UseItems[sel].S.Name := '';
            g_boItemMoving := TRUE;
         end;
      end;
   end;
end;

procedure TFrmDlg.DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  sel: integer;
  iname, d1, d2, d3: string;
  useable: Boolean;
  hcolor: TColor;
  Butt:TDButton;
begin
   if StatePage <> 0 then exit;
   sel := -1;
   Butt:=TDButton(Sender);
   if Sender = DSWDress then sel := U_DRESS
   else if Sender = DSWWeapon then sel := U_WEAPON
   else if Sender = DSWHelmet then sel := U_HELMET
   else if Sender = DSWNecklace then sel := U_NECKLACE
   else if Sender = DSWLight then sel := U_RIGHTHAND
   else if Sender = DSWRingL then sel := U_RINGL
   else if Sender = DSWRingR then sel := U_RINGR
   else if Sender = DSWArmRingL then sel := U_ARMRINGL
   else if Sender = DSWArmRingR then sel := U_ARMRINGR
   else if Sender = DSWBujuk then sel := U_BUJUK
   else if Sender = DSWBelt then sel := U_BELT
   else if Sender = DSWBoots then sel := U_BOOTS
   else if Sender = DSWCharm then sel := U_CHARM;

   if sel >= 0 then begin
      g_MouseStateItem := g_UseItems[sel];
      g_MouseItem := g_UseItems[sel];
      GetMouseItemInfo (iname, d1, d2, d3, useable);
      if iname <> '' then begin
         if g_UseItems[sel].Dura = 0 then hcolor := clRed
         else hcolor := g_UseItems[sel].S.Color;   //clWhite白色

         nLocalX:=Butt.LocalX(X - Butt.Left);
         nLocalY:=Butt.LocalY(Y - Butt.Top);
         if d1 <> '' then
          inc(nLocalY,18);
         if d2 <> '' then
          inc(nLocalY,18);
         if d3 <> '' then
          inc(nLocalY,18);
         nHintX:=Butt.SurfaceX(Butt.Left) + DStateWin.SurfaceX(DStateWin.Left) + nLocalX;
         nHintY:=Butt.SurfaceY(Butt.Top) + DStateWin.SurfaceY(DStateWin.Top) + nLocalY;

         with Butt as TDButton do
          DScreen.ShowHint(nHintX,nHintY,
                             iname + d1 + '\' + d2 + '\' + d3, hcolor, TRUE);
      end;
      g_MouseItem.S.Name := '';
   end;
end;

procedure TFrmDlg.DStateWinMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
  g_MouseStateItem.S.Name := '';
end;

procedure TFrmDlg.DStMag1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx, icon: integer;
   d: TDirectDrawSurface;
   pm: PTClientMagic;
begin
   with Sender as TDButton do begin
      idx := _Max(Tag + MagicPage * 5, 0);
      if idx < g_MagicList.Count then begin
         pm := PTClientMagic (g_MagicList[idx]);
         icon := pm.Def.btEffect * 2;
         if icon >= 0 then begin
            if not Downed then begin
               d := g_WMagIconImages.Images[icon];
               if d <> nil then
                  dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
            end else begin
               d := g_WMagIconImages.Images[icon+1];
               if d <> nil then
                  dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
            end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DStMag1Click(Sender: TObject; X, Y: Integer);
var
   i, idx: integer;
   selkey: word;
   keych: char;
   pm: PTClientMagic;
begin
   if StatePage = 3 then begin
      idx := TDButton(Sender).Tag + magtop;
      if (idx >= 0) and (idx < g_MagicList.Count) then begin

         pm := PTClientMagic (g_MagicList[idx]);
         selkey := word(pm.Key);
         SetMagicKeyDlg (pm.Def.btEffect * 2, pm.Def.sMagicName, selkey);
         keych := char(selkey);

         for i:=0 to g_MagicList.Count-1 do begin
            pm := PTClientMagic (g_MagicList[i]);
            if pm.Key = keych then begin
               pm.Key := #0;
               FrmMain.SendMagicKeyChange (pm.Def.wMagicId, #0);
            end;
         end;
         pm := PTClientMagic (g_MagicList[idx]);
         //if pm.Def.EffectType <> 0 then begin
         pm.Key := keych;
         FrmMain.SendMagicKeyChange (pm.Def.wMagicId, keych);
         //end;
      end;
   end;
end;

procedure TFrmDlg.DStPageUpClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DStPageUp then begin
      if MagicPage > 0 then
         Dec (MagicPage);
   end else begin
      if MagicPage < (g_MagicList.Count+4) div 5 - 1 then
         Inc (MagicPage);
   end;
end;

{------------------------------------------------------------------------}


{------------------------------------------------------------------------}

procedure TFrmDlg.DBottomDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d:TDirectDrawSurface;
  rc:TRect;
  btop, sx, sy, i, fcolor, bcolor: integer;
  r: Real;
  str: string;
begin
 if g_Myself = nil then exit;
{$IF SWH = SWH800}
  d:=g_WMainImages.Images[BOTTOMBOARD800];
{$ELSEIF SWH = SWH1024}
  d:=g_WMainImages.Images[BOTTOMBOARD1024];
{$IFEND}
  if d <> nil then
    dsurface.Draw (DBottom.Left, DBottom.Top, d.ClientRect, d, TRUE);
  btop := 0;
  if d <> nil then begin
    with d.ClientRect do
       rc := Rect (Left, Top, Right, Top+120);
    btop := SCREENHEIGHT - d.height;
    dsurface.Draw (0,
                   btop,
                   rc,
                   d, TRUE);
    with d.ClientRect do
      rc := Rect (Left, Top+120, Right, Bottom);
    dsurface.Draw (0,
                   btop + 120,
                   rc,
                   d, FALSE);
    end;

   d := nil;
   case g_nDayBright of
      0: d := g_WMainImages.Images[15];  // 黎明
      1: d := g_WMainImages.Images[12];  // 白天
      2: d := g_WMainImages.Images[13];  // 傍晚
      3: d := g_WMainImages.Images[14];  // 夜晚
   end;
   if d <> nil then
     dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (380 - 346)){748}, 97+DBottom.Top, d.ClientRect, d, TRUE);
   if g_MySelf <> nil then begin
         PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (382 - 260)){660}, SCREENHEIGHT - 88, IntToStr(g_MySelf.m_Abil.Level));
      //显示HP及MP 图形
      if (g_MySelf.m_Abil.MaxHP > 0) and (g_MySelf.m_Abil.MaxMP > 0) then begin
         if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level < 26 ) then begin //武士
            d := g_WMainImages.Images[5];
            if d <> nil then begin
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right - 2;
               dsurface.Draw (45, btop+62, rc, d, FALSE);
            end;
            d := g_WMainImages.Images[6];
            if d <> nil then begin
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right - 2;
               rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
               dsurface.Draw (45, btop+62+rc.Top, rc, d, FALSE);
            end;
         end else begin
            d := g_WMainImages.Images[4];
            if d <> nil then begin
               //HP 图形
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right div 2 - 1;
               rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
               dsurface.Draw (45, btop+62+rc.Top, rc, d, FALSE);
               //MP 图形
               rc := d.ClientRect;
               rc.Left := d.ClientRect.Right div 2 + 1;
               rc.Right := d.ClientRect.Right - 1;
               rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxMP * (g_MySelf.m_Abil.MaxMP - g_MySelf.m_Abil.MP));
               dsurface.Draw (45 + rc.Left, btop+62+rc.Top, rc, d, FALSE);
            end;
         end;
      end;

      //等级
      with dsurface.Canvas do begin
        PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (382 - 260)){660}, SCREENHEIGHT - 88, IntToStr(g_MySelf.m_Abil.Level));
      end;
      
      if (g_MySelf.m_Abil.MaxExp > 0) and (g_MySelf.m_Abil.MaxWeight > 0) then begin
         d := g_WMainImages.Images[7];
         if d <> nil then begin
            //经验条
            rc := d.ClientRect;
            if g_MySelf.m_Abil.Exp > 0 then r := g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp
            else r := 0;
            if r > 0 then rc.Right := Round (rc.Right / r)
            else rc.Right := 0;
            {
            dsurface.Draw (666, 527, rc, d, FALSE);
            PomiTextOut (dsurface, 660, 528, IntToStr(Myself.Abil.Exp));
            }
            dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (402 - 266)){666}, SCREENHEIGHT - 54, rc, d, FALSE);
            //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 72, FloatToStrFixFmt (100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) + '%');
            //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 57, IntToStr(g_MySelf.m_Abil.MaxExp));

            //背包重量条
            rc := d.ClientRect;
            if g_MySelf.m_Abil.Weight > 0 then r := g_MySelf.m_Abil.MaxWeight / g_MySelf.m_Abil.Weight
            else r := 0;
            if r > 0 then rc.Right := Round (rc.Right / r)
            else rc.Right := 0;
            {
            dsurface.Draw (666, 560, rc, d, FALSE);
            PomiTextOut (dsurface, 660, 561, IntToStr(Myself.Abil.Weight));
            }
            dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (379 - 266)){666}, SCREENHEIGHT - 23, rc, d, FALSE);
            //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 39, IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight));
            //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 260)){660}, SCREENHEIGHT - 24, IntToStr(g_MySelf.m_Abil.MaxWeight));
         end;
      end;
      //PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 355)){755}, SCREENHEIGHT - 15, IntToStr(g_nMyHungryState));
      //饥饿程度
      if g_nMyHungryState in [1..4] then begin
        d := g_WMainImages.Images[16 + g_nMyHungryState-1];
        if d <> nil then begin
          dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 354)){754}, 553, d.ClientRect, d, TRUE);
        end;
      end;
   end;

   //显示聊天框文字
   sx := 208;
   sy := SCREENHEIGHT - 130;
   with DScreen do begin
      SetBkMode (dsurface.Canvas.Handle, OPAQUE);
      for i := ChatBoardTop to ChatBoardTop + VIEWCHATLINE-1 do begin
         if i > ChatStrs.Count-1 then break;
         fcolor := integer(ChatStrs.Objects[i]);
         bcolor := integer(ChatBks[i]);
         dsurface.Canvas.Font.Color := fcolor;
         dsurface.Canvas.Brush.Color := bcolor;
         dsurface.Canvas.TextOut (sx, sy+(i-ChatBoardTop)*12, ChatStrs.Strings[i]);
      end;
        if g_boHPView then begin
          if (g_Myself.m_Abil.Level < 26) and (g_Myself.m_btJob = 0) then begin
          SetBKMode(Dsurface.Canvas.Handle, TRANSPARENT);
          BoldTextOut (dsurface,63,btop+110,clwhite, clblack, 'HP(' + IntToStr(g_Myself.m_Abil.HP) + '/' + IntToStr(g_Myself.m_Abil.MaxHP) + ')');
          end else begin
          SetBKMode(Dsurface.Canvas.Handle, TRANSPARENT);
          BoldTextOut (dsurface,63,btop+110,clwhite, clblack, 'HP(' + IntToStr(g_Myself.m_Abil.HP) + '/' + IntToStr(g_Myself.m_Abil.MaxHP) + ')');
          BoldTextOut (dsurface,63,btop+123,clwhite, clblack, 'MP(' + IntToStr(g_Myself.m_Abil.MP) + '/' + IntToStr(g_Myself.m_Abil.MaxMP) + ')');
          end;
        end else begin
          if (g_Myself.m_Abil.Level < 26) and (g_Myself.m_btJob = 0) then begin
          SetBKMode(Dsurface.Canvas.Handle, TRANSPARENT);
          BoldTextOut (dsurface,85,btop+100,clwhite, clblack, IntToStr(g_Myself.m_Abil.HP));
          BoldTextOut (dsurface,80,btop+115,clwhite, clblack, '-----');
          BoldTextOut (dsurface,85,btop+130,clwhite, clblack, IntToStr(g_Myself.m_Abil.MaxHP));
          end else begin
          SetBKMode(Dsurface.Canvas.Handle, TRANSPARENT);
          BoldTextOut (dsurface,65,btop+100,clwhite, clblack, IntToStr(g_Myself.m_Abil.HP));
          BoldTextOut (dsurface,60,btop+115,clwhite, clblack, '-----');
          BoldTextOut (dsurface,65,btop+130,clwhite, clblack, IntToStr(g_Myself.m_Abil.MaxHP));
          BoldTextOut (dsurface,110,btop+100,clwhite, clblack, IntToStr(g_Myself.m_Abil.MP));
          BoldTextOut (dsurface,105,btop+115,clwhite, clblack, '-----');
          BoldTextOut (dsurface,110,btop+130,clwhite, clblack, IntToStr(g_Myself.m_Abil.MaxMP));
          end;
        end;
     end;
   dsurface.Canvas.Release;
end;

{--------------------------------------------------------------}

procedure TFrmDlg.DBottomInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
var
   d: TDirectDrawSurface;
begin
{$IF SWH = SWH800}
   d := g_WMainImages.Images[BOTTOMBOARD800];
{$ELSEIF SWH = SWH1024}
   d := g_WMainImages.Images[BOTTOMBOARD1024];
{$IFEND}
   if d <> nil then begin
      if d.Pixels[X, Y] > 0 then IsRealArea := TRUE
      else IsRealArea := FALSE;
   end;
end;

procedure TFrmDlg.DMyStateDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if d.Downed then begin
         dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DBotGroupDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if d.Downed then begin
         if not d.DontDrawUp then dd := d.WLib.Images[d.FaceIndex+1]
         else  dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end
      else if not d.DontDrawUp then begin
         dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DBotPlusAbilDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if not d.Downed then begin
         if (BlinkCount mod 2 = 0) and (not DAdjustAbility.Visible) then dd := d.WLib.Images[d.FaceIndex]
         else dd := d.WLib.Images[d.FaceIndex + 2];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end else begin
         dd := d.WLib.Images[d.FaceIndex+1];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;

      if GetTickCount - BlinkTime >= 500 then begin
         BlinkTime := GetTickCount;
         Inc (BlinkCount);
         if BlinkCount >= 10 then BlinkCount := 0;
      end;
   end;
end;

procedure TFrmDlg.DMyStateClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DMyState then begin
      StatePage := 0;
      OpenMyStatus;
   end;
   if Sender = DMyBag then OpenItemBag;
   if Sender = DMyMagic then begin
      StatePage := 3;
      OpenMyStatus;
   end;
   if Sender = DOption then DOptionClick;
end;

procedure TFrmDlg.DOptionClick();
begin
  if DOptions.Visible = false then begin
    // 技能设置 (关闭 = CTRL, 开启 = Y)
    if g_boSkillSetting then begin
      DOptionsSkillMode1.SetImgIndex (g_WMainImages, 771);
      DOptionsSkillMode2.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsSkillMode1.SetImgIndex (g_WMainImages, -1);
      DOptionsSkillMode2.SetImgIndex (g_WMainImages, 772);
    end;
    // 技能框
    if DSkillBar.Visible then begin
      DOptionsSkillBarOn.SetImgIndex (g_WMainImages, 773);
      DOptionsSkillBarOff.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsSkillBarOn.SetImgIndex (g_WMainImages, -1);
      DOptionsSkillBarOff.SetImgIndex (g_WMainImages, 774);
    end;
    if g_boEffect then begin
      DOptionsEffectOn.SetImgIndex (g_WMainImages, 773);
      DOptionsEffectOff.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsEffectOn.SetImgIndex (g_WMainImages, -1);
      DOptionsEffectOff.SetImgIndex (g_WMainImages, 774);
    end;
    // 声音
    if g_boSound then begin
      DOptionsSoundOn.SetImgIndex (g_WMainImages, 773);
      DOptionsSoundOff.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsSoundOn.SetImgIndex (g_WMainImages, -1);
      DOptionsSoundOff.SetImgIndex (g_WMainImages, 774);
    end;
    // 物品显示
    if g_boShowAllItem then begin
      DOptionsDropViewOn.SetImgIndex (g_WMainImages, 773);
      DOptionsDropViewOff.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsDropViewOn.SetImgIndex (g_WMainImages, -1);
      DOptionsDropViewOff.SetImgIndex (g_WMainImages, 774);
    end;
    if g_boNameAllView then begin
      DOptionsNameAllViewOn.SetImgIndex (g_WMainImages, 773);
      DOptionsNameAllViewOff.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsNameAllViewOn.SetImgIndex (g_WMainImages, -1);
      DOptionsNameAllViewOff.SetImgIndex (g_WMainImages, 774);
    end;
    if g_boHPView then begin
      DOptionsHPView1.SetImgIndex (g_WMainImages, 775);
      DOptionsHPView2.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsHPView1.SetImgIndex (g_WMainImages, -1);
      DOptionsHPView2.SetImgIndex (g_WMainImages, 776);
    end;
    // centre the window and move it above the bottom bar
    DOptions.Left := (SCREENWIDTH div 2) - ((DOptions.Width) div 2);
    DOptions.Top := (SCREENHEIGHT div 2) - ((DOptions.Height) div 2) - 65;
  end;
  DOptions.Visible := not DOptions.Visible;
end;

{------------------------------------------------------------------------}


{------------------------------------------------------------------------}

procedure TFrmDlg.DBelt1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      idx := Tag;
      if idx in [0..5] then begin
         if g_ItemArr[idx].S.Name <> '' then begin
            d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
            if d <> nil then
               dsurface.Draw (SurfaceX(Left+(Width-d.Width) div 2), SurfaceY(Top+(Height-d.Height) div 2), d.ClientRect, d, TRUE);
         end;
      end;
      PomiTextOut (dsurface, SurfaceX(Left+13), SurfaceY(Top+19), IntToStr(idx+1));
   end;
end;

procedure TFrmDlg.DBelt1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   idx: integer;
begin
   idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         g_MouseItem := g_ItemArr[idx];
      end;
   end;
end;

procedure TFrmDlg.DBelt1Click(Sender: TObject; X, Y: Integer);
var
   idx: integer;
   temp: TClientItem;
begin
   idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
      if not g_boItemMoving then begin
         if (g_ItemArr[idx].S.Name <> '') and ((GetTickCount - LastBeltDoubleClick) > 400) then begin
            ItemClickSound (g_ItemArr[idx].S);
            g_boItemMoving := TRUE;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := g_ItemArr[idx];
            g_ItemArr[idx].S.Name := '';
         end;
      end else begin
         if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
         //if g_MovingItem.Item.S.StdMode <= 3 then begin
            //ItemClickSound (MovingItem.Item.S.StdMode);
            if g_ItemArr[idx].S.Name <> '' then begin
               temp := g_ItemArr[idx];
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Index := idx;
               g_MovingItem.Item := temp
            end else begin
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Item.S.name := '';
               g_boItemMoving := FALSE;
            end;
        // end;
      end;
   end;
end;

procedure TFrmDlg.DBelt1DblClick(Sender: TObject);
var
   idx: integer;
begin
   LastBeltDoubleClick := GetTickCount;
   idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         if (g_ItemArr[idx].S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31) then begin
            FrmMain.EatItem (idx);
         end;
      end else begin
         if g_boItemMoving and (g_MovingItem.Index = idx) and
           (g_MovingItem.Item.S.StdMode <= 4) or (g_MovingItem.Item.S.StdMode = 31)
         then begin
            FrmMain.EatItem (-1);
         end;
      end;
   end;
end;

{----------------------------------------------------------}

{----------------------------------------------------------}

procedure TFrmDlg.GetMouseItemInfo (var iname, line1, line2, line3: string; var useable: boolean);
   function GetDuraStr (dura, maxdura: integer): string;
   begin
      if not BoNoDisplayMaxDura then
         Result := IntToStr(Round(dura/1000)) + '/' + IntToStr(Round(maxdura/1000))
      else
         Result := IntToStr(Round(dura/1000));
   end;
   function GetDura100Str (dura, maxdura: integer): string;
   begin
      if not BoNoDisplayMaxDura then
         Result := IntToStr(Round(dura/100)) + '/' + IntToStr(Round(maxdura/100))
      else
         Result := IntToStr(Round(dura/100));
   end;
var
  sWgt:String;
begin
//   if g_MySelf = nil then exit;
   iname := ''; line1 := ''; line2 := ''; line3 := '';
   useable := TRUE;

   if g_MouseItem.S.Name <> '' then begin
      iname := g_MouseItem.S.Name + ' ';
      sWgt := '重量';
      case g_MouseItem.S.StdMode of
         0: begin
              line1 := line1 + ' W.' + IntToStr(g_MouseItem.S.Weight);

              case g_MouseItem.S.Shape of
              0: begin
                if (g_MouseItem.S.AC > 0) and (g_MouseItem.S.MAC = 0) then
                  line2 := '恢复 ' + IntToStr(g_MouseItem.S.AC) + 'HP'
                else if (g_MouseItem.S.MAC > 0) and (g_MouseItem.S.AC = 0) then
                  line2 := '恢复 ' + IntToStr(g_MouseItem.S.MAC) + 'MP'
                else
                  line2 := '恢复 ' + IntToStr(g_MouseItem.S.AC) + 'HP 和 ' + IntToStr(g_MouseItem.S.MAC) + 'MP';
              end;
              1: begin
                if (g_MouseItem.S.AC > 0) and (g_MouseItem.S.MAC = 0) then
                  line2 := '立即恢复 ' + IntToStr(g_MouseItem.S.AC) + 'HP'
                else if (g_MouseItem.S.MAC > 0) and (g_MouseItem.S.AC = 0) then
                  line2 := '立即恢复' + IntToStr(g_MouseItem.S.MAC) + 'MP'
                else
                  line2 := '立即恢复 ' + IntToStr(g_MouseItem.S.AC) + 'HP 和 ' + IntToStr(g_MouseItem.S.MAC) + 'MP';
              end;
              3: begin
                if (g_MouseItem.S.AC > 0) and (g_MouseItem.S.MAC = 0) then
                  line2 := '立即恢复 ' + IntToStr(g_MouseItem.S.AC) + '%HP'
                else if (g_MouseItem.S.MAC > 0) and (g_MouseItem.S.AC = 0) then
                  line2 := '立即恢复 ' + IntToStr(g_MouseItem.S.MAC) + '%MP'
                else
                  line2 := '立即恢复 ' + IntToStr(g_MouseItem.S.AC) + '%HP 和 ' + IntToStr(g_MouseItem.S.MAC) + '%MP';
              end;
              end;
            end;
         1..3:
            begin
               line1 := line1 + '重量' +  IntToStr(g_MouseItem.S.Weight);
               if (g_MouseItem.S.Shape = 7) and (g_MouseItem.S.StdMode = 3) then begin
                line2:= '到期: ' + DateTimeToStr(UnixToDateTime(MakeLong(g_MouseItem.DuraMax,g_MouseItem.dura)));
               end;

               if (g_MouseItem.S.Shape = 13) and (g_MouseItem.S.StdMode = 3) then
                 line2 := '授予用户 ' +inttostr(g_MouseItem.S.DuraMax) +' 点经验值'
            end;
         4:
            begin
               line1 := line1 + '重量' +  IntToStr(g_MouseItem.S.Weight);
               line3 := '需要等级 ' + IntToStr(g_MouseItem.S.DuraMax);
               useable := FALSE;
               case g_MouseItem.S.Shape of
                  0: begin
                        line2 := '战士技能书';
                        if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level >= g_MouseItem.S.DuraMax) then
                           useable := TRUE;
                     end;
                  1: begin
                        line2 := '法师技能书';
                        if (g_MySelf.m_btJob = 1) and (g_MySelf.m_Abil.Level >= g_MouseItem.S.DuraMax) then
                           useable := TRUE;
                     end;
                  2: begin
                        line2 := '道士技能书';
                        if (g_MySelf.m_btJob = 2) and (g_MySelf.m_Abil.Level >= g_MouseItem.S.DuraMax) then
                           useable := TRUE;
                     end;
               end;
            end;
         5..6: //武器
            begin
               useable := FALSE;
               if g_MouseItem.S.Reserved and $01 <> 0 then
                  iname := '(*)' + iname;

               line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) +
                        ' 持久度'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
               if g_MouseItem.S.DC > 0 then
                  line2 := '攻击' + IntToStr(LoWord(g_MouseItem.S.DC)) + '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
               if g_MouseItem.S.MC > 0 then
                  line2 := line2 + '魔法' + IntToStr(LoWord(g_MouseItem.S.MC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
               if g_MouseItem.S.SC > 0 then
                  line2 := line2 + '道术' + IntToStr(LoWord(g_MouseItem.S.SC)) + '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';

               if (g_MouseItem.S.Source <= -1) and (g_MouseItem.S.Source >= -50) then
                  line2 := line2 + '神圣+' + IntToStr(-g_MouseItem.S.Source) + ' ';
               if (g_MouseItem.S.Source <= -51) and (g_MouseItem.S.Source >= -100) then
                  line2 := line2 + '神圣-' + IntToStr(-g_MouseItem.S.Source - 50) + ' ';

               if HiByte(g_MouseItem.S.SlowDown) > 0 then
                  line2 := line2 + '准确+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
               if HiWord(g_MouseItem.S.MAC) > 0 then begin
                  if HiWord(g_MouseItem.S.MAC) > 10 then
                     line2 := line2 + '攻击速度+' + IntToStr(HiWord(g_MouseItem.S.MAC)-10) + ' '
                  else
                     line2 := line2 + '攻击速度-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
               end;
               if LoWord(g_MouseItem.S.AC) > 0 then
                  line2 := line2 + '幸运+' + IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
               if LoWord(g_MouseItem.S.MAC) > 0 then
                  line2 := line2 + '诅咒+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
               if HiByte(g_MouseItem.S.Tox) > 0 then
                  line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
               if LoByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + 'HP+' + IntToStr(LoByte(g_MouseItem.S.HpAdd)) + ' ';
               if LoByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + 'MP+' + IntToStr(LoByte(g_MouseItem.S.MpAdd)) + ' ';
               if HiByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + 'HP Regen+' + IntToStr(HiByte(g_MouseItem.S.HpAdd)) + '0% ';
               if HiByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + 'MP Regen+' + IntToStr(HiByte(g_MouseItem.S.MpAdd)) + '0% ';
               if LoByte(g_MouseItem.S.Tox) > 0 then
                  line2 := line2 + 'PA+' + IntToStr(LoByte(g_MouseItem.S.Tox)) + ' ';
               if LoByte(g_MouseItem.S.SlowDown) > 0 then
                  line2 := line2 + 'Slow+' + IntToStr(LoByte(g_MouseItem.S.SlowDown)) + ' ';
               if g_MouseItem.S.MagAvoid > 0 then
                  line2 := line2 + 'MR+' + IntToStr(g_MouseItem.S.MagAvoid) + ' ';
               if g_MouseItem.S.ToxAvoid > 0 then
                  line2 := line2 + 'PR+' + IntToStr(g_MouseItem.S.ToxAvoid) + ' ';
               case g_MouseItem.S.Need of
                  0: begin
                        if g_MySelf.m_Abil.Level >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要等级 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        if HiWord (g_MySelf.m_Abil.DC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要攻击 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        if HiWord(g_MySelf.m_Abil.MC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要魔法 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        if HiWord (g_MySelf.m_Abil.SC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要道术 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  4: begin
                        useable := TRUE;
                        line3 := line3 + '转生 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  40: begin
                        useable := TRUE;
                        line3 := line3 + '转生 + 等级 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  41: begin
                        useable := TRUE;
                        line3 := line3 + '转生 + 攻击 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  42: begin
                        useable := TRUE;
                        line3 := line3 + '转生 + 魔法 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  43: begin
                        useable := TRUE;
                        line3 := line3 + '转生 + 道术 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  44: begin
                        useable := TRUE;
                        line3 := line3 + '转生 + 信用 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  5: begin
                        useable := TRUE;
                        line3 := line3 + '信用 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  6: begin
                        useable := TRUE;
                        line3 := line3 + '公会成员';
                     end;
                  60: begin
                        useable := TRUE;
                        line3 := line3 + '公会领袖';
                     end;
                  7: begin
                        useable := TRUE;
                        line3 := line3 + '沙巴克公会';
                     end;
                  70: begin
                        useable := TRUE;
                        line3 := line3 + '沙巴克公会领袖';
                     end;
                  8: begin
                        useable := TRUE;
                        line3 := line3 + '会员';
                     end;
                  81: begin
                        useable := TRUE;
                        line3 := line3 + '会员 =' + IntToStr(LoWord(g_MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                     end;
                  82: begin
                        useable := TRUE;
                        line3 := line3 + '会员 >=' + IntToStr(LoWord(g_MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                     end;
               end;
            end;
         10, 11,12:  //盔甲
            begin
               useable := FALSE;
               line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) +
                        ' 持久度'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
               if g_MouseItem.S.AC > 0 then
                  line2 := '防御' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
               if g_MouseItem.S.MAC > 0 then
                  line2 := line2 + '魔法防御' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
               if g_MouseItem.S.DC > 0 then
                  line2 := line2 + '攻击' + IntToStr(LoWord(g_MouseItem.S.DC)) + '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
               if g_MouseItem.S.MC > 0 then
                  line2 := line2 + '魔法' + IntToStr(LoWord(g_MouseItem.S.MC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
               if g_MouseItem.S.SC > 0 then
                  line2 := line2 + '道术' + IntToStr(LoWord(g_MouseItem.S.SC)) + '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
                  //line2:= line2 + '\'; //added this as a test
               if LoByte(g_MouseItem.S.Source) > 0 then
                  line2 := line2 + '幸运+' + IntToStr(LoByte(g_MouseItem.S.Source)) + ' ';
               if HiByte(g_MouseItem.S.Source) > 0 then
                  line2 := line2 + '诅咒+' + IntToStr(HiByte(g_MouseItem.S.Source)) + ' ';
               if HiByte(g_MouseItem.S.Tox) > 0 then
                  line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
               if HiByte(g_MouseItem.S.SlowDown) > 0 then
                  line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
               if LoByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + 'HP+' + IntToStr(LoByte(g_MouseItem.S.HpAdd)) + ' ';
               if LoByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + 'MP+' + IntToStr(LoByte(g_MouseItem.S.MpAdd)) + ' ';
               if HiByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + 'HP Regen+' + IntToStr(HiByte(g_MouseItem.S.HpAdd)) + '0% ';
               if HiByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + 'MP Regen+' + IntToStr(HiByte(g_MouseItem.S.MpAdd)) + '0% ';
               if LoByte(g_MouseItem.S.Tox) > 0 then
                  line2 := line2 + 'PA+' + IntToStr(LoByte(g_MouseItem.S.Tox)) + ' ';
               if LoByte(g_MouseItem.S.SlowDown) > 0 then
                  line2 := line2 + 'Slow+' + IntToStr(LoByte(g_MouseItem.S.SlowDown)) + ' ';
               if g_MouseItem.S.MagAvoid > 0 then
                  line2 := line2 + 'MR+' + IntToStr(g_MouseItem.S.MagAvoid) + ' ';
               if g_MouseItem.S.ToxAvoid > 0 then
                  line2 := line2 + 'PR+' + IntToStr(g_MouseItem.S.ToxAvoid) + ' ';
               case g_MouseItem.S.Need of
                  0: begin
                        if g_MySelf.m_Abil.Level >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要等级' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        if HiWord (g_MySelf.m_Abil.DC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要攻击 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        if HiWord (g_MySelf.m_Abil.MC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要魔法 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        if HiWord (g_MySelf.m_Abil.SC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要道术 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  4: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnated ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  40: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnatated + level ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  41: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnated + dc ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  42: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnated + mc ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  43: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnated + sc ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  44: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincaranated + creditpoints ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  5: begin
                        useable := TRUE;
                        line3 := line3 + 'Creditpoints ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  6: begin
                        useable := TRUE;
                        line3 := line3 + 'Being in a guild';
                     end;
                  60: begin
                        useable := TRUE;
                        line3 := line3 + 'Being guild leader';
                     end;
                  7: begin
                        useable := TRUE;
                        line3 := line3 + 'Being in SabukWall guild';
                     end;
                  70: begin
                        useable := TRUE;
                        line3 := line3 + 'Being guild leader of SW guild';
                     end;
                  8: begin
                        useable := TRUE;
                        line3 := line3 + 'membertype above 0';
                     end;
                  81: begin
                        useable := TRUE;
                        line3 := line3 + 'membertype =' + IntToStr(LoWord(g_MouseItem.S.NeedLevel)) + 'memberlevel >=' + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                     end;
                  82: begin
                        useable := TRUE;
                        line3 := line3 + 'membertype >=' + IntToStr(LoWord(g_MouseItem.S.NeedLevel)) + 'memberlevel >=' + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                     end;
               end;
            end;
         15,     //helm
         19,20,21,  //项链
         22,23,  //戒指
         24,26, //brace
         62,   //靴子
         63,   //宝石
         64:   //腰带
            begin
               useable := FALSE;
               line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) +
                        ' 持久度'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);

               case g_MouseItem.S.StdMode of
                  19,20: //项链 with luck
                     begin
                        if LoWord(g_MouseItem.S.AC) > 0 then line2 := line2 + '攻击速度+' + IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                        if HiWord(g_MouseItem.S.AC) > 0 then line2 := line2 + '攻击速度-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if LoWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + '诅咒+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                        if HiWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + '幸运+' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                     end;
                  21:  //项链 with hp/magic recovery and aspeed
                     begin
                        if LoWord(g_MouseItem.S.MAC) > 0 then
                           line2 := line2 + '体力恢复+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '0% ';
                        if HiWord(g_MouseItem.S.MAC) > 0 then
                           line2 := line2 + '魔法恢复+' + IntToStr(HiWord(g_MouseItem.S.MAC)) + '0% ';
                        if LoWord(g_MouseItem.S.AC) > 0 then
                           line2 := line2 + '攻击速度+' + IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                        if HiWord(g_MouseItem.S.AC) > 0 then
                           line2 := line2 + '攻击速度-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';

                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                     end;
                  22: begin //戒指 with ac/amc
                        if g_MouseItem.S.AC > 0 then
                           line2 := line2 + '防御' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if g_MouseItem.S.MAC > 0 then
                           line2 := line2 + '魔法防御' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + '攻击速度+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                  end;
                  62:  //靴子
                     begin
                       if g_MouseItem.S.AC > 0 then
                           line2 := line2 + '防御' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if g_MouseItem.S.MAC > 0 then
                           line2 := line2 + '魔法防御' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';

                        if g_MouseItem.S.Source > 0 then
                           line2 := line2 + '腕力+' + IntToStr(g_MouseItem.S.Source) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then
                           line2 := line2 + '背包重量+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                     end;
                  63: //宝石
                     begin
                        line1 := '';
                        line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight);
                        if LoWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + '诅咒+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                        if HiWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + '幸运+' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                     end;
                  64: //腰带
                      begin
                        if g_MouseItem.S.AC > 0 then
                           line2 := line2 + '防御' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if g_MouseItem.S.MAC > 0 then
                           line2 := line2 + '魔法防御' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                        if g_MouseItem.S.Source > 0 then
                           line2 := line2 + 'Bag W+' + IntToStr(g_MouseItem.S.Source) + ' ';
                     end;
                  else
                     begin
                        if g_MouseItem.S.AC > 0 then
                           line2 := line2 + '防御' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if g_MouseItem.S.MAC > 0 then
                           line2 := line2 + '魔法防御' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                     end;
               end;
               if g_MouseItem.S.DC > 0 then
                  line2 := line2 + '攻击' + IntToStr(LoWord(g_MouseItem.S.DC)) + '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
               if g_MouseItem.S.MC > 0 then
                  line2 := line2 + '魔法' + IntToStr(LoWord(g_MouseItem.S.MC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
               if g_MouseItem.S.SC > 0 then
                  line2 := line2 + '道术' + IntToStr(LoWord(g_MouseItem.S.SC)) + '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
                  line2:= line2 + '\'; //added this as a test
               if (g_MouseItem.S.Source <= -1) and (g_MouseItem.S.Source >= -50) then
                  line2 := line2 + '神圣+' + IntToStr(-g_MouseItem.S.Source);
               if (g_MouseItem.S.Source <= -51) and (g_MouseItem.S.Source >= -100) then
                  line2 := line2 + '神圣-' + IntToStr(-g_MouseItem.S.Source - 50);
               if LoByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + '体力+' + IntToStr(LoByte(g_MouseItem.S.HpAdd)) + ' ';
               if LoByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + '魔法+' + IntToStr(LoByte(g_MouseItem.S.MpAdd)) + ' ';
               if HiByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + '体力恢复+' + IntToStr(HiByte(g_MouseItem.S.HpAdd)) + '0% ';
               if HiByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + '魔法恢复+' + IntToStr(HiByte(g_MouseItem.S.MpAdd)) + '0% ';
               if LoByte(g_MouseItem.S.Tox) > 0 then
                  line2 := line2 + 'PA+' + IntToStr(LoByte(g_MouseItem.S.Tox)) + ' ';
               if LoByte(g_MouseItem.S.SlowDown) > 0 then
                  line2 := line2 + 'Slow+' + IntToStr(LoByte(g_MouseItem.S.SlowDown)) + ' ';
               if g_MouseItem.S.MagAvoid > 0 then
                  line2 := line2 + 'MR+' + IntToStr(g_MouseItem.S.MagAvoid) + ' ';
               if g_MouseItem.S.ToxAvoid > 0 then
                  line2 := line2 + 'PR+' + IntToStr(g_MouseItem.S.ToxAvoid) + ' ';
               case g_MouseItem.S.Need of
                  0: begin
                        if g_MySelf.m_Abil.Level >= g_MouseItem.S.NeedLevel then useable := TRUE;
                        line3 := line3 + '需要等级 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        if HiWord(g_MySelf.m_Abil.DC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要攻击 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        if HiWord(g_MySelf.m_Abil.MC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要魔法 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        if HiWord(g_MySelf.m_Abil.SC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + '需要道术 ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  4: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnated ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  40: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnatated + level ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  41: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnated + dc ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  42: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnated + mc ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  43: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincarnated + sc ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  44: begin
                        useable := TRUE;
                        line3 := line3 + 'Reincaranated + creditpoints ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  5: begin
                        useable := TRUE;
                        line3 := line3 + 'Creditpoints ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  6: begin
                        useable := TRUE;
                        line3 := line3 + 'Being in a guild';
                     end;
                  60: begin
                        useable := TRUE;
                        line3 := line3 + 'Being guild leader';
                     end;
                  7: begin
                        useable := TRUE;
                        line3 := line3 + 'Being in SabukWall guild';
                     end;
                  70: begin
                        useable := TRUE;
                        line3 := line3 + 'Being guild leader of SW guild';
                     end;
                  8: begin
                        useable := TRUE;
                        line3 := line3 + '会员';
                     end;
                  81: begin
                        useable := TRUE;
                        line3 := line3 + '会员 =' + IntToStr(LoWord(g_MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                     end;
                  82: begin
                        useable := TRUE;
                        line3 := line3 + '会员 >=' + IntToStr(LoWord(g_MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(g_MouseItem.S.NeedLevel));
                     end;
               end;
            end;
         25: //护身符
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight);
               line2 := 'Count '+ GetDura100Str(g_MouseItem.Dura, g_MouseItem.DuraMax);
            end;
         30: //蜡烛
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight) + ' 持久度'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
               if g_MouseItem.S.AC > 0 then
                 line2 := line2 + '防御' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
               if g_MouseItem.S.MAC > 0 then
                 line2 := line2 + '魔法防御' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                if g_MouseItem.S.DC > 0 then
                  line2 := line2 + '攻击' + IntToStr(LoWord(g_MouseItem.S.DC)) + '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
               if g_MouseItem.S.MC > 0 then
                  line2 := line2 + '魔法' + IntToStr(LoWord(g_MouseItem.S.MC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
               if g_MouseItem.S.SC > 0 then
                  line2 := line2 + '道术' + IntToStr(LoWord(g_MouseItem.S.SC)) + '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
               if LoByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + '体力+' + IntToStr(LoByte(g_MouseItem.S.HpAdd)) + ' ';
               if LoByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + '魔法+' + IntToStr(LoByte(g_MouseItem.S.MpAdd)) + ' ';
               if HiByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + '体力恢复+' + IntToStr(HiByte(g_MouseItem.S.HpAdd)) + ' ';
               if HiByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + '魔法恢复+' + IntToStr(HiByte(g_MouseItem.S.MpAdd)) + ' ';
               if LoByte(g_MouseItem.S.Tox) > 0 then
                  line2 := line2 + 'PA+' + IntToStr(LoByte(g_MouseItem.S.Tox)) + ' ';
               if LoByte(g_MouseItem.S.SlowDown) > 0 then
                  line2 := line2 + 'Slow+' + IntToStr(LoByte(g_MouseItem.S.SlowDown)) + ' ';
               if g_MouseItem.S.MagAvoid > 0 then
                  line2 := line2 + 'MR+' + IntToStr(g_MouseItem.S.MagAvoid) + ' ';
               if g_MouseItem.S.ToxAvoid > 0 then
                  line2 := line2 + 'PR+' + IntToStr(g_MouseItem.S.ToxAvoid) + ' ';
            end;
         40: //肉
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight) + ' 质量'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
            end;
         42: //not used in db atm
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight) + ' 毒药成分';
            end;
         43: //矿石
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight) + ' 纯度'+ IntToStr(Round(g_MouseItem.Dura/1000));
            end;
         45: //stacked items
            begin
              line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight * g_mouseitem.amount);
            end;
         48: //decoration item
            begin
              line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight * g_mouseitem.amount);
              if FindDecoration(g_MouseITem.Dura) <> nil then begin
                Line2 := '图像: ' + FindDecoration(g_MouseItem.Dura).Name;
                case FindDecoration(g_MouseItem.Dura).Location of
                  0: Line3 :='只能安置在外面 ';
                  1: Line3 :='只能安置在里面';
                  2: Line3 :='能安置里面和外面';
                end;
              end;
            end;
         else begin
              line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight);
         end;
      end;
   end;
end;

procedure TFrmDlg.DItemBagClick(Sender: TObject; X, Y: Integer);
var
 ACol,ARow,idx:integer;
begin
{   idx := ACol + ARow * DItemGrid.ColCount + 6;
   if idx in [6..MAXBAGITEM-1] then begin
    g_ItemArr[idx] := g_MovingItem.Item;
    g_boBagToStore:=True;
   end;}
end;

procedure TFrmDlg.DItemBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d0, d1, d2, d3: string;
   n: integer;
   useable: Boolean;
   d: TDirectDrawSurface;
begin
   if g_MySelf = nil then exit;
   with DItemBag do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      GetMouseItemInfo (d0, d1, d2, d3, useable);
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (SurfaceX(Left+64), SurfaceY(Top+185+16), GetGoldStr(g_MySelf.m_nGold));
         if d0 <> '' then begin
            n := TextWidth (d0);
            Font.Color := clYellow;
            TextOut (SurfaceX(Left+60), SurfaceY(Top+227), d0);
            Font.Color := g_MouseItem.S.Color;
            d1:= StringReplace(d1,'\','',[rfReplaceAll,rfIgnoreCase]);
            d2:= StringReplace(d2,'\','',[rfReplaceAll,rfIgnoreCase]);
            TextOut (SurfaceX(Left+60) + n, SurfaceY(Top+227), d1);
            TextOut (SurfaceX(Left+60), SurfaceY(Top+241), d2);
            Font.Color:= clWhite;
            if not useable then
               Font.Color := clRed;
            TextOut (SurfaceX(Left+60), SurfaceY(Top+255), d3);
         end;
         Release;
      end;
   end;
end;

procedure TFrmDlg.DRepairItemInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
begin
   if (X >= 0) and (Y >= 0) and (X <= DRepairItem.Width) and
      (Y <= DRepairItem.Height) then
         IsRealArea := TRUE
   else IsRealArea := FALSE;
end;

procedure TFrmDlg.DRepairItemDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DRepairItem do begin
      d := WLib.Images[FaceIndex];
      if DRepairItem.Downed and (d <> nil) then
         dsurface.Draw (SurfaceX(254), SurfaceY(183), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DCloseBagDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DCloseBag do begin
      if DCloseBag.Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DCloseBagClick(Sender: TObject; X, Y: Integer);
begin
   DItemBag.Visible := FALSE;
end;

procedure TFrmDlg.DItemGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
   temp: TClientItem;
   iname, d1, d2, d3: string;
   useable: Boolean;
   hcolor: TColor;
begin
   if ssRight in Shift then begin
      if g_boItemMoving then
         DItemGridGridSelect (self, ACol, ARow, Shift);
   end else begin
      idx := ACol + ARow * DItemGrid.ColCount+ 6;
      if idx in [6..MAXBAGITEM-1] then begin
         g_MouseItem := g_ItemArr[idx];
        { GetMouseItemInfo (iname, d1, d2, d3, useable);
         if iname <> '' then begin
            if useable then hcolor := g_ItemArr[idx].S.Color
            else hcolor := clRed;
            with DItemGrid do
               DScreen.ShowHint (SurfaceX(Left + ACol*ColWidth),
                                 SurfaceY(Top + (ARow+1)*RowHeight),
                                 iname + d1 + '\' + d2 + '\' + d3, hcolor, FALSE);
         end;
         g_MouseItem.S.Name := '';
         }
      end;
   end;
end;

procedure TFrmDlg.DItemGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
   idx, mi: integer;
   temp: TClientItem;
keyvalue: TKeyBoardState;
  i:Integer;
  msg:TDefaultMessage;
begin
   FillChar(keyvalue, sizeof(TKeyboardState), #0);
   GetKeyboardState (keyvalue);
   idx := ACol + ARow * DItemGrid.ColCount + 6;

   if ssCtrl in Shift then begin
    if not (idx in [6..MAXBAGITEM-1]) then exit;
    if g_ItemArr[idx].S.Name = '' then exit;
    if (g_MovingItem.item.S.Name <> '') and (g_MovingItem.item.S.StdMode = 37) then begin //Gems
      msg := MakeDefaultMsg (CM_GEMITEM, g_MovingItem.Item.makeindex, LoWord(g_ItemArr[idx].MakeIndex), HiWord(g_ItemArr[idx].MakeIndex),0);
      frmmain.SendSocket (EncodeMessage (msg));
      g_boItemMoving := FALSE;
      g_MovingItem.Item.S.Name := '';
      exit;
    end;
    exit;
   end;
   idx := ACol + ARow * DItemGrid.ColCount + 6;
   if idx in [6..MAXBAGITEM-1] then begin
      if not g_boItemMoving then begin
         if g_ItemArr[idx].S.Name <> '' then begin
            g_boItemMoving := TRUE;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := g_ItemArr[idx];
            g_ItemArr[idx].S.Name := '';
            ItemClickSound (g_ItemArr[idx].S);
            g_boBagToStore := TRUE;
         end;
      end else begin
         if (SpotDlgMode = dmStorage) and g_boStoreToBag then begin
         FrmMain.SendTakeBackStorageItem (g_nCurMerchant, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
         g_MovingItem.Item.S.name := '';
         g_boItemMoving := FALSE;
         g_boStoreToBag := FALSE;
         exit;
         end;
         //ItemClickSound (MovingItem.Item.S.StdMode);
         mi := g_MovingItem.Index;

         if (mi = -97) or (mi = -98) then exit;
         if (mi < 0) and (mi >= -13 {-9}) then begin  //-99: Sell

            g_WaitingUseItem := g_MovingItem;
            FrmMain.SendTakeOffItem (-(g_MovingItem.Index+1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
         end else begin
            if (mi <= -20) and (mi > -30) then
               DealItemReturnBag (g_MovingItem.Item);
            if g_ItemArr[idx].S.Name <> '' then begin

               temp := g_ItemArr[idx];
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Index := idx;
               g_MovingItem.Item := temp
            end else begin
              if g_MovingItem.Item.S.StdMode = 45 then
                for i:=0 to g_MovingItem.Item.Amount -1 do
                  AddItemBag(g_MovingItem.Item)
              else
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Item.S.name := '';
               g_boItemMoving := FALSE;
            end;
         end;
      end;
   end;
   ArrangeItemBag;
end;

procedure TFrmDlg.DItemGridDblClick(Sender: TObject);
var
   where, idx, i: integer;
   keyvalue: TKeyBoardState;
   cu: TClientItem;
begin
   idx := DItemGrid.Col + DItemGrid.Row * DItemGrid.ColCount + 6;
   if idx in [6..MAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
       {  FillChar(keyvalue, sizeof(TKeyboardState), #0);
         GetKeyboardState (keyvalue);
         if keyvalue[VK_CONTROL] = $80 then begin
            cu := g_ItemArr[idx];
            g_ItemArr[idx].S.Name := '';
            AddItemBag (cu); }
         FillChar(keyvalue, sizeof(TKeyboardState), #0);
         GetKeyboardState (keyvalue);

         // Sewing, Bonehammer (Control held)
         if keyvalue[VK_CONTROL] = $80 then begin
          if (g_MovingItem.item.S.Name <> '') and (g_MovingItem.item.S.StdMode = 38) then begin
              SendClientMessage(CM_REPAIRITEM, g_MovingItem.Item.makeindex, LoWord(g_ItemArr[idx].MakeIndex), HiWord(g_ItemArr[idx].MakeIndex),0);
            exit;
          end;
            cu := g_ItemArr[idx];
            g_ItemArr[idx].S.Name := '';
            AddItemBag (cu);
         end else
            if (g_ItemArr[idx].S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31) then begin
               FrmMain.EatItem (idx);
            end;
      end else begin
         if g_boItemMoving and (g_MovingItem.Item.S.Name <> '') then begin
            FillChar(keyvalue, sizeof(TKeyboardState), #0);
            GetKeyboardState (keyvalue);
            if keyvalue[VK_CONTROL] = $80 then begin

               cu := g_MovingItem.Item;
               g_MovingItem.Item.S.Name := '';
               g_boItemMoving := FALSE;
               AddItemBag (cu);
            end else if (g_MovingItem.Index = idx) and
                  (g_MovingItem.Item.S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31) then begin
                  FrmMain.EatItem (-1);
            end else begin
              //Equip item from dbl click ^_~
              where := GetTakeOnPosition(g_MovingItem.Item.S.StdMode);

              if (where <> -1) then begin
                if ((where = U_RINGR) and (g_UseItems[U_RINGR].S.Name <> '')) then where := U_RINGL;
                if ((where = U_ARMRINGR) and (g_UseItems[U_ARMRINGR].S.Name <> '')) then where := U_ARMRINGL;

                g_WaitingUseItem.Item := g_MovingItem.Item;
                g_WaitingUseItem.Index := where;

                FrmMain.SendTakeOnItem(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
                DelItemBag(g_MovingItem.Item.S.Name, g_MovingItem.Item.MakeIndex);

                g_MovingItem.Item.S.Name := '';
              end;
            end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx,i, ii, ax, ay: integer;
   d,e: TDirectDrawSurface;
   tempsize:integer;
   ItemEffect:pTItemEffect;
begin
   idx := ACol + ARow * DItemGrid.ColCount + 6;
   if idx in [6..MAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
         if d <> nil then
          with DItemGrid do begin
            dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol,
                            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow,
                              d.ClientRect,
                              d, TRUE);
            if g_ItemArr[idx].Amount > 1 then begin
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              tempsize:=dsurface.Canvas.Font.Size;
              dsurface.Canvas.Font.Size :=8;
              BoldTextOut (dsurface, SurfaceX(Rect.BottomRight.x + 18),
              SurfaceY(Rect.BottomRight.y + 18), clYellow, clBlack, IntToStr(g_ItemArr[idx].Amount));
              dsurface.Canvas.Font.Size:=tempsize;
              dsurface.Canvas.Release;
            end;

            for i:= 0 to g_ItemEffects.Count -1 do begin //check if there's an effect going on this item and draw if there is
              if pTItemEffect(g_ItemEffects[i]).Idx = idx then begin
                ItemEffect := g_ItemEffects[i];
                e := g_WMainImages.GetCachedImage (ItemEffect.n_StartFrame + ItemEffect.n_CurrentFrame, ax, ay);
                if e <> nil then
                  for ii:= 0 to 5 do
                  DrawBlend(dsurface,(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
                    (SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, e, 1);
//                  dsurface.Draw ((SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
//                  (SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, e.ClientRect, e, TRUE);
                if (GetTickCount() - ItemEffect.n_LastFrame) < ItemEffect.n_NextFrame then exit;
                if ItemEffect.n_CurrentFrame = 0 then
                  PlaySound(10310);
                ItemEffect.n_LastFrame:= GetTickCount;
                inc(ItemEffect.n_CurrentFrame);
                if ItemEffect.n_CurrentFrame = ItemEffect.n_EndFrame then begin
                  g_ItemEffects.Delete(i);
                  dispose(ItemEffect);
                end;
              end;
            end;
          end;
      end;
   end;
end;

procedure TFrmDlg.DGoldClick(Sender: TObject; X, Y: Integer);
begin
   if g_MySelf = nil then exit;
   if not g_boItemMoving then begin
      if g_MySelf.m_nGold > 0 then begin
         PlaySound (s_money);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -98;
         g_MovingItem.Item.S.Name := g_sGoldName;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin
         g_boItemMoving := FALSE;
         g_MovingItem.Item.S.Name := '';
         if g_MovingItem.Index = -97 then begin
            DealZeroGold;
         end;
      end;
   end;
   ;
end;

{------------------------------------------------------------------------}
//NPC对话框
{------------------------------------------------------------------------}

procedure TFrmDlg.ShowMDlg (face: integer; mname, msgstr: string);
var
   i: integer;
begin
   DMerchantDlg.Left := 0;
   DMerchantDlg.Top := 0;
   MerchantFace := face;
   MerchantName := mname;
   MDlgStr := msgstr;
   DMerchantDlg.Visible := TRUE;
   DItemBag.Left := 455;
   DItemBag.Top := 0;
   for i:=0 to MDlgPoints.Count-1 do
      Dispose (pTClickPoint (MDlgPoints[i]));
   MDlgPoints.Clear;
   RequireAddPoints := TRUE;
   LastestClickTime := GetTickCount;
end;


procedure TFrmDlg.ResetMenuDlg;
var
   i: integer;
begin
   CloseDSellDlg;
   for i:=0 to g_MenuItemList.Count-1 do
      Dispose(PTClientItem(g_MenuItemList[i]));
   g_MenuItemList.Clear;

   for i:=0 to MenuList.Count-1 do
      Dispose (PTClientGoods(MenuList[i]));
   MenuList.Clear;

   //CurDetailItem := '';
   MenuIndex := -1;
   MenuTopLine := 0;
   BoDetailMenu := FALSE;
   BoStorageMenu := FALSE;
   BoMakeDrugMenu := FALSE;

   DGTList.visible :=FALSE;
   DDecoListDlg.visible:=FALSE;
   DSellDlg.Visible := FALSE;
   DMenuDlg.Visible := FALSE;
   DShopMenuDlg.Visible := FALSE;
   DGemMakeItem.Visible := FALSE;

end;

procedure TFrmDlg.ShowShopMenuDlg;
begin
   MenuIndex := -1;

   DMerchantDlg.Left := 0;
   DMerchantDlg.Top := 0;
   DMerchantDlg.Visible := TRUE;

   DSellDlg.Visible := FALSE;
   DGemMakeItem.Visible := FALSE;
   DGTList.visible :=FALSE;
   DDecoListDlg.visible:=FALSE;

   DMenuDlg.Left := 0;
   DMenuDlg.Top  := 208;
   DMenuDlg.Visible := TRUE;
   MenuTop := 0;

   DItemBag.Left := 455;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;

   LastestClickTime := GetTickCount;
end;

procedure TFrmDlg.ShowNewShopMenuDlg;
begin
   MenuIndex := -1;

   DMerchantDlg.Left := 0;
   DMerchantDlg.Top := 0;
   DMerchantDlg.Visible := TRUE;

   //DSellDlg.Visible := FALSE;
   DGemMakeItem.Visible := FALSE;
   DGTList.visible :=FALSE;
   DDecoListDlg.visible:=FALSE;

   if not BoMakeGem then begin
   DSellDlg.Left := 289;
   DSellDlg.Top := 208;
   DSellDlg.Visible := TRUE;
   end;
   
   DShopMenuDlg.Left := 0;
   DShopMenuDlg.Top  := 208;
   DShopMenuDlg.Visible := TRUE;
   MenuTop := 0;

   DItemBag.Left := 455;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;

   LastestClickTime := GetTickCount;
end;

procedure TFrmDlg.ShowStoreDlg;
begin
   DMerchantDlg.visible:=FALSE;

   DItemStore.Left := 0;
   DItemStore.Top := 0;
   DItemStore.Visible := TRUE;

   DItemBag.Left := 455;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;
end;

procedure TFrmDlg.ShowShopSellDlg;
begin
   DSellDlg.Left := 289;
   DSellDlg.Top := 208;
   DSellDlg.Visible := TRUE;

   DMenuDlg.Visible := FALSE;
   DShopMenuDlg.Visible := FALSE;
   DGemMakeItem.Visible := FALSE;
   DGTList.visible :=FALSE;
   DDecoListDlg.visible:=FALSE;

   DItemBag.Left := 455;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;

   LastestClickTime := GetTickCount;
   g_sSellPriceStr := '';
   g_boQuickSell:=FALSE;
end;

procedure TFrmDlg.CloseMDlg;
var
   i: integer;
begin
   MDlgStr := '';
   DMerchantDlg.Visible := FALSE;
   if DSales.Visible = TRUE then
     ToggleAuctionWindow;
   for i:=0 to MDlgPoints.Count-1 do
      Dispose (PTClickPoint (MDlgPoints[i]));
   MDlgPoints.Clear;
   DItemBag.Left := 0;
   DItemBag.Top := 0;
   DMenuDlg.Visible := FALSE;
   DShopMenuDlg.Visible := FALSE;
   DGemMakeItem.Visible := FALSE;
   CancelGemMaking;
   CloseDSellDlg;
   DGTList.visible :=FALSE;
   DDecoListDlg.visible:=FALSE;
end;

procedure TFrmDlg.CloseDSellDlg;
var
i:integer;
begin
   DSellDlg.Visible := FALSE;
   if g_SellDlgItem.S.Name <> '' then
    if g_SellDlgItem.S.StdMode = 45 then begin
      for i:=0 to MAXBAGITEMCL-1 do begin
        if (g_ItemArr[i].MakeIndex = g_SellDlgItem.MakeIndex) and (g_ItemArr[i].S.Name = g_SellDlgItem.S.Name) then begin
          inc(g_ItemArr[i].Amount,g_SellDlgItem.Amount);
          exit;
        end;
      end;
      AddItemBag(g_SellDlgItem);
    end else
      AddItemBag (g_SellDlgItem);
   g_SellDlgItem.S.Name := '';
end;

procedure TFrmDlg.DMerchantDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   str, data, fdata, cmdstr, cmdmsg, cmdparam: string;
   lx, ly, sx: integer;
   drawcenter: Boolean;
   pcp: PTClickPoint;
begin

   with Sender as TDWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      lx := 30;
      ly := 30;
      str := MDlgStr;
      drawcenter := FALSE;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then begin
            sx := 0;
            fdata := '';
            while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
               if data[1] <> '<' then begin
                  data := '<' + GetValidStr3 (data, fdata, ['<']);
               end;
               data := ArrestStringEx (data, '<', '>', cmdstr);

               //fdata + cmdstr + data
               if cmdstr <> '' then begin
                  if Uppercase(cmdstr) = 'C' then begin
                     drawcenter := TRUE;
                     continue;
                  end;
                  if UpperCase(cmdstr) = '/C' then begin
                     drawcenter := FALSE;
                     continue;
                  end;
                  cmdparam := GetValidStr3 (cmdstr, cmdstr, ['/']);
               end else begin
                  DMenuDlg.Visible := FALSE;
                  DSellDlg.Visible := FALSE;
                  DShopMenuDlg.Visible := FALSE;
               end;

               if fdata <> '' then begin
                  BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, fdata);
                  sx := sx + dsurface.Canvas.TextWidth(fdata);
               end;
               if cmdstr <> '' then begin
                  if RequireAddPoints then begin
                     new (pcp);
                     pcp.rc := Rect (lx+sx, ly, lx+sx + dsurface.Canvas.TextWidth(cmdstr), ly + 14);
                     pcp.RStr := cmdparam;
                     MDlgPoints.Add (pcp);
                  end;
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style + [fsUnderline];
                  if SelectMenuStr = cmdparam then
                     BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clRed, clBlack, cmdstr)
                  else BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clYellow, clBlack, cmdstr);
                  sx := sx + dsurface.Canvas.TextWidth(cmdstr);
                  dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
               end;
            end;
            if data <> '' then
               BoldTextOut (dsurface, SurfaceX(Left+lx+sx), SurfaceY(Top+ly), clWhite, clBlack, data);
         end;
         ly := ly + 16;
      end;
      dsurface.Canvas.Release;
      RequireAddPoints := FALSE;
   end;

end;

procedure TFrmDlg.DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   CloseMDlg;
end;

procedure TFrmDlg.DMenuDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
      Result := DMenuDlg.SurfaceX (DMenuDlg.Left + x);
  end;
  function SY(y: integer): integer;
  begin
      Result := DMenuDlg.SurfaceY (DMenuDlg.Top + y);
  end;
var
   i, lh, k, m, menuline: integer;
   d: TDirectDrawSurface;
   pg: PTClientGoods;
   str: string;
begin
   with dsurface.Canvas do begin
      with DMenuDlg do begin
         d := DMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      SetBkMode (Handle, TRANSPARENT);
      //title
      Font.Color := clWhite;
      if not BoStorageMenu then begin
         TextOut(SX(36), SY(30), '物品列表');
         TextOut(SX(175), SY(30), '价格');
         TextOut(SX(263), SY(30), '持久度');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);

         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
               Font.Color := clRed;
               //TextOut (SX(29),  SY(51 + m*lh), char(7));
            end else Font.Color := clWhite;
            pg := PTClientGoods (MenuList[i]);
            TextOut (SX(36),  SY(51 + m*lh), pg.Name);
            if pg.SubMenu >= 1 then
               TextOut (SX(137), SY(51 + m*lh), #31);
            TextOut (SX(175), SY(51 + m*lh), IntToStr(pg.Price) + ' ' + g_sGoldName);
            str := '';
            if pg.Grade = -1 then str := '-'
            else TextOut (SX(263), SY(51 + m*lh), IntToStr(pg.Grade));
            {else for k:=0 to pg.Grade-1 do
               str := str + '*';
            if Length(str) >= 4 then begin
               Font.Color := clYellow;
               TextOut (SX(245), SY(32 + m*lh), str);
            end else
               TextOut (SX(245), SY(32 + m*lh), str);}
         end;
      end else begin
         TextOut(SX(36), SY(30), '物品列表');
         TextOut(SX(175), SY(30), '持久度');
         TextOut(SX(263), SY(30), '');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);

         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
               Font.Color := clRed;
               //TextOut (SX(29),  SY(51 + m*lh), char(7));
            end else Font.Color := clWhite;
            pg := PTClientGoods (MenuList[i]);
            TextOut (SX(36),  SY(51 + m*lh), pg.Name);
            if pg.SubMenu >= 1 then
               TextOut (SX(137), SY(51 + m*lh), #31);
            TextOut (SX(175), SY(51 + m*lh), IntToStr(pg.Stock) + '/' + IntToStr(pg.Grade));
         end;
      end;
      //TextOut (0, 0, IntToStr(MenuTopLine));

      Release;
   end;
end;

procedure TFrmDlg.DMenuDlgClick(Sender: TObject; X, Y: Integer);
var
   lx, ly, idx: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
   tempi:PTClientGoods;
begin
   DScreen.ClearHint;
   lx := DMenuDlg.LocalX (X) - DMenuDlg.Left;
   ly := DMenuDlg.LocalY (Y) - DMenuDlg.Top;
   if (lx >= 14) and (lx <= 279) and (ly >= 50) then begin
      idx := (ly-32-20) div LISTLINEHEIGHT + MenuTop;
      if idx < MenuList.Count then begin
         PlaySound (s_glass_button_click);
         MenuIndex := idx;
      end;
   end;

   if BoStorageMenu then begin
      if (MenuIndex >= 0) and (MenuIndex < g_SaveItemList.Count) then begin
         g_MouseItem := PTClientItem(g_SaveItemList[MenuIndex])^;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         if iname <> '' then begin
            lx := 240;
            ly := 32+(MenuIndex-MenuTop) * LISTLINEHEIGHT;
            with Sender as TDButton do
               DScreen.ShowHint (DMenuDlg.SurfaceX(Left + lx),
                                 DMenuDlg.SurfaceY(Top + ly),
                                 iname + d1 + '\' + d2 + '\' + d3, clYellow, FALSE);
         end;
         g_MouseItem.S.Name := '';
      end;
   end else if FrmDlg.BoMakeGem then begin
   tempi := PTClientGoods(MenuList[MenuIndex]);
   SendClientMessage(CM_GEMINFO, g_nCurMerchant, 0, 0, 0, '@Info' + tempi.name);
    end;

      if (MenuIndex >= 0) and (MenuIndex < g_MenuItemList.Count) and (PTClientGoods (MenuList[MenuIndex]).SubMenu = 0) then begin
         g_MouseItem := PTClientItem(g_MenuItemList[MenuIndex])^;
         BoNoDisplayMaxDura := TRUE;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         BoNoDisplayMaxDura := FALSE;
         if iname <> '' then begin
            lx := 240;
            ly := 32+(MenuIndex-MenuTop) * LISTLINEHEIGHT;
            with Sender as TDButton do
               DScreen.ShowHint (DMenuDlg.SurfaceX(Left + lx),
                                 DMenuDlg.SurfaceY(Top + ly),
                                 iname + d1 + '\' + d2 + '\' + d3, clYellow, FALSE);
         end;
         g_MouseItem.S.Name := '';
      end;
   end;

procedure TFrmDlg.DMenuDlgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   with DMenuDlg do
      if (X < SurfaceX(Left+10)) or (X > SurfaceX(Left+Width-20)) or (Y < SurfaceY(Top+30)) or (Y > SurfaceY(Top+Height-50)) then begin
         DScreen.ClearHint;
      end;
end;

procedure TFrmDlg.DMenuBuyClick(Sender: TObject; X, Y: Integer);
var
   pg: PTClientGoods;
   tempi: PTClientGoods;
begin
   if GetTickCount < LastestClickTime then exit;
   if (MenuIndex >= 0) and (MenuIndex < MenuList.Count) then begin
      pg := PTClientGoods (MenuList[MenuIndex]);
      LastestClickTime := GetTickCount + 5000;
      if pg.SubMenu > 0 then begin
         FrmMain.SendGetDetailItem (g_nCurMerchant, 0, pg.Name);
         MenuTopLine := 0;
         CurDetailItem := pg.Name;
      end else begin
         if BoStorageMenu then begin
            FrmMain.SendTakeBackStorageItem (g_nCurMerchant, pg.Price{MakeIndex}, pg.Name);
            exit;
         end;
         if BoMakeDrugMenu then begin
            FrmMain.SendMakeDrugItem (g_nCurMerchant, pg.Name);
            exit;
         end;
         if BoMakeGem then begin
          sMakeGemName:=pg.Name;
          g_GemItem1.S.Name := '';
          g_GemItem1.MakeIndex :=0;
          g_GemItem2.S.Name := '';
          g_GemItem2.MakeIndex :=0;
          g_GemItem3.S.Name := '';
          g_GemItem3.MakeIndex :=0;
          g_GemItem4.S.Name := '';
          g_GemItem4.MakeIndex :=0;
          g_GemItem5.S.Name := '';
          g_GemItem5.MakeIndex :=0;
          g_GemItem6.S.Name := '';
          g_GemItem6.MakeIndex :=0;
          DGemMakeItem.Visible := True;
          exit;
         end;
         FrmMain.SendBuyItem (g_nCurMerchant, pg.Stock, pg.Name)
      end;
   end;
end;

procedure TFrmDlg.DMenuPrevClick(Sender: TObject; X, Y: Integer);
begin
   if not BoDetailMenu then begin
      if MenuTop > 0 then Dec (MenuTop, MAXMENU-1);
      if MenuTop < 0 then MenuTop := 0;
   end else begin
      if MenuTopLine > 0 then begin
         MenuTopLine := _MAX(0, MenuTopLine-10);
         FrmMain.SendGetDetailItem (g_nCurMerchant, MenuTopLine, CurDetailItem);
      end;
   end;
end;

procedure TFrmDlg.DMenuNextClick(Sender: TObject; X, Y: Integer);
begin
   if not BoDetailMenu then begin
      if MenuTop + MAXMENU < MenuList.Count then Inc (MenuTop, MAXMENU-1);
   end else begin
      MenuTopLine := MenuTopLine + 10;
      FrmMain.SendGetDetailItem (g_nCurMerchant, MenuTopLine, CurDetailItem);
   end;
end;

procedure TFrmDlg.SoldOutGoods (itemserverindex: integer);
var
   i: integer;
   pg: PTClientGoods;
begin
   for i:=0 to MenuList.Count-1 do begin
      pg := PTClientGoods (MenuList[i]);
      if (pg.Grade >= 0) and (pg.Stock = itemserverindex) then begin
         Dispose (pg);
         MenuList.Delete (i);
         if i < g_MenuItemList.Count then g_MenuItemList.Delete (i);
         if MenuIndex > MenuList.Count-1 then MenuIndex := MenuList.Count-1;
         break;
      end;
   end;
end;

procedure TFrmDlg.DelStorageItem (itemserverindex: integer);
var
   i: integer;
   pg: PTClientGoods;
begin
   for i:=0 to MenuList.Count-1 do begin
      pg := PTClientGoods (MenuList[i]);
      if (pg.Price = itemserverindex) then begin
         Dispose (pg);
         MenuList.Delete (i);
         if i < g_SaveItemList.Count then g_SaveItemList.Delete (i);
         if MenuIndex > MenuList.Count-1 then MenuIndex := MenuList.Count-1;
         break;
      end;
   end;
end;

procedure TFrmDlg.DMenuCloseClick(Sender: TObject; X, Y: Integer);
begin
   DMenuDlg.Visible := FALSE;
end;

procedure TFrmDlg.DMerchantDlgClick(Sender: TObject; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   if GetTickCount < LastestClickTime then exit;
   L := DMerchantDlg.Left;
   T := DMerchantDlg.Top;
   with DMerchantDlg do
      for i:=0 to MDlgPoints.Count-1 do begin
         p := PTClickPoint (MDlgPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            PlaySound (s_glass_button_click);
            FrmMain.SendMerchantDlgSelect (g_nCurMerchant, p.RStr);
            LastestClickTime := GetTickCount + 5000;
            break;
         end;
      end;
end;

procedure TFrmDlg.DMerchantDlgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   i, L, T: integer;
   p: PTClickPoint;
begin
   if GetTickCount < LastestClickTime then exit;
   SelectMenuStr := '';
   L := DMerchantDlg.Left;
   T := DMerchantDlg.Top;
   with DMerchantDlg do
      for i:=0 to MDlgPoints.Count-1 do begin
         p := PTClickPoint (MDlgPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            SelectMenuStr := p.RStr;
            break;
         end;
      end;
end;

procedure TFrmDlg.DMerchantDlgMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   SelectMenuStr := '';
end;

procedure TFrmDlg.DSellDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d,e: TDirectDrawSurface;
   actionname: string;
begin
   with DSellDlg do begin
      d := DMenuDlg.WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      e := DMenuDlg.WLib.Images[403];
      if (e <> nil) and (g_boQuickSell) then
        dsurface.Draw (SurfaceX(Left) + 94, SurfaceY(Top) + 43, e.ClientRect, e, TRUE);
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         actionname := '';
         case SpotDlgMode of
            dmSell:   actionname := '出售: ';
            dmRepair: actionname := '修理: ';
            dmStorage: actionname := '储存: ';
            dmConsign: actionname := '寄售: ';
         end;
         TextOut (SurfaceX(Left+34), SurfaceY(Top+6), actionname + g_sSellPriceStr);
         Release;
      end;
   end;
end;

procedure TFrmDlg.DSellDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   CloseDSellDlg;
end;

procedure TFrmDlg.DSellDlgSpotClick(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   temp2: TClientItem;
   Amount:Integer;
   valstr:String;
begin
   g_sSellPriceStr := '';
   if not g_boItemMoving then begin
      if g_SellDlgItem.S.Name <> '' then begin
         ItemClickSound (g_SellDlgItem.S);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -99;
         g_MovingItem.Item := g_SellDlgItem;
         g_SellDlgItem.S.Name := '';
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin
         ItemClickSound (g_MovingItem.Item.S);
        if g_MovingItem.Item.S.StdMode = 45 then begin
          FrmDlg.DMessageDlg ('你需要增加多少？', [mbOk, mbAbort]);
            GetValidStrVal (DlgEditText, valstr, [' ']);
            Amount:=Str_ToInt (valstr, 0);
        end else
          Amount:=1;
        if Amount > 0 then begin
          if g_SellDlgItem.S.Name <> '' then begin
            temp := g_SellDlgItem;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBag(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_SellDlgItem := temp2;
            end else
              g_SellDlgItem := g_MovingItem.Item;
            g_MovingItem.Index := -99;
            g_MovingItem.Item := temp
          end else begin
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBag(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_SellDlgItem := temp2;
            end else
              g_SellDlgItem := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;
          if not g_boQuickSell then begin
            g_boQueryPrice := TRUE;
            g_dwQueryPriceTime := GetTickCount;
          end else begin
            DSellOk();
          end;
        end;
      end;
   end;

end;

procedure TFrmDlg.DSellDlgSpotDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   if g_SellDlgItem.S.Name <> '' then begin
      d := g_WBagItemImages.Images[g_SellDlgItem.S.Looks];
      if d <> nil then
         with DSellDlgSpot do
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2),
                           SurfaceY(Top + (Height - d.Height) div 2),
                           d.ClientRect,
                           d, TRUE);
   end;
end;

procedure TFrmDlg.DSellDlgSpotMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   g_MouseItem := g_SellDlgItem;
end;

procedure TFrmDlg.DSellOk();
var
  dlgmessage: string;
  amount: integer;

begin
   if (g_SellDlgItem.S.Name = '') and (g_SellDlgItemSellWait.S.Name = '') then exit;
   if GetTickCount < LastestClickTime then exit;
   case SpotDlgMode of
      dmSell: begin
        FrmMain.SendSellItem (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name, g_sellDlgItem.Amount);
        LastestClickTime := GetTickCount + 5000;
      end;
      dmRepair: begin
        FrmMain.SendRepairItem (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name);
        LastestClickTime := GetTickCount + 5000;
      end;
      dmStorage: begin
        FrmMain.SendStorageItem (g_nCurMerchant, g_SellDlgItem.MakeIndex, g_SellDlgItem.S.Name, g_sellDlgItem.Amount);
        LastestClickTime := GetTickCount + 5000;
      end;
      dmConsign:
        begin
          DialogSize := 1;
          DMessageDlg ('你需要寄售多少个 "' +g_SellDlgItem.S.Name +'" ?', [mbOk, mbAbort]);
          dlgmessage := Trim(DlgEditText);

          if dlgmessage = '' then begin
            DMessageDlg ('请输入价格。', [mbOk]);
            exit;
          end;

          try
            amount := strtoint(dlgmessage)
          except
            DMessageDlg ('价格必须是数字。', [mbOk]);
            exit;
          end;

          if amount < 1000 then begin
            DMessageDlg ('价格最少是1,000金币。', [mbOk]);
            exit;
          end;

          if amount > 50000000 then begin
            DMessageDlg ('价格最多是50,000,000金币。', [mbOk]);
            exit;
          end;

          if mrYes = FrmDlg.DMessageDlg ('你需要寄售 "' +g_SellDlgItem.S.Name +'" 为 ' +GetGoldStr(amount) +' 金币吗？', [mbYes, mbNo, mbCancel]) then
            FrmMain.SendConsignItem (g_nCurMerchant, g_SellDlgItem.MakeIndex, dlgmessage)
          else
            AddItemBag (g_SellDlgItem);

        end;
   end;
   g_SellDlgItemSellWait := g_SellDlgItem;
   g_SellDlgItem.S.Name := '';
   g_sSellPriceStr := '';
end;





{------------------------------------------------------------------------}

//魔法

{------------------------------------------------------------------------}


procedure TFrmDlg.SetMagicKeyDlg (icon: integer; magname: string; var curkey: word);
begin
   MagKeyIcon := icon;
   MagKeyMagName := magname;
   MagKeyCurKey := curkey;


   DKeySelDlg.Left := (SCREENWIDTH - DKeySelDlg.Width) div 2;
   DKeySelDlg.Top  := (SCREENHEIGHT - DKeySelDlg.Height) div 2;
   HideAllControls;
   DKeySelDlg.ShowModal;

   while TRUE do begin
      if not DKeySelDlg.Visible then break;
      //FrmMain.DXTimerTimer (self, 0);
      FrmMain.ProcOnIdle;
      Application.ProcessMessages;
      if Application.Terminated then exit;
   end;

   RestoreHideControls;
   curkey := MagKeyCurKey;
end;

procedure TFrmDlg.DKeySelDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DKeySelDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      //魔法快捷键
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clSilver;
         TextOut (SurfaceX(Left + 95), SurfaceY(Top + 38), MagKeyMagName + ' key is.');
         Release;
      end;
   end;
end;

procedure TFrmDlg.DKsIconDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DksIcon do begin
      d := g_WMagIconImages.Images[MagKeyIcon];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DKsF1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   b: TDButton;
   d: TDirectDrawSurface;
begin
   b := nil;
   case MagKeyCurKey of
      word('1'): b := DKsF1;
      word('2'): b := DKsF2;
      word('3'): b := DKsF3;
      word('4'): b := DKsF4;
      word('5'): b := DKsF5;
      word('6'): b := DKsF6;
      word('7'): b := DKsF7;
      word('8'): b := DKsF8;
      word('E'): b := DKsConF1;
      word('F'): b := DKsConF2;
      word('G'): b := DKsConF3;
      word('H'): b := DKsConF4;
      word('I'): b := DKsConF5;
      word('J'): b := DKsConF6;
      word('K'): b := DKsConF7;
      word('L'): b := DKsConF8;
      else b := DKsNone;
   end;
   if b = Sender then begin
      with b do begin
         d := WLib.Images[FaceIndex+1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
   with Sender as TDButton do begin
      if Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DKsOkClick(Sender: TObject; X, Y: Integer);
begin
   DKeySelDlg.Visible := FALSE;
end;

procedure TFrmDlg.DKsF1Click(Sender: TObject; X, Y: Integer);
begin
   if Sender = DKsF1 then MagKeyCurKey := integer('1');
   if Sender = DKsF2 then MagKeyCurKey := integer('2');
   if Sender = DKsF3 then MagKeyCurKey := integer('3');
   if Sender = DKsF4 then MagKeyCurKey := integer('4');
   if Sender = DKsF5 then MagKeyCurKey := integer('5');
   if Sender = DKsF6 then MagKeyCurKey := integer('6');
   if Sender = DKsF7 then MagKeyCurKey := integer('7');
   if Sender = DKsF8 then MagKeyCurKey := integer('8');
   if Sender = DKsConF1 then MagKeyCurKey := integer('E');
   if Sender = DKsConF2 then MagKeyCurKey := integer('F');
   if Sender = DKsConF3 then MagKeyCurKey := integer('G');
   if Sender = DKsConF4 then MagKeyCurKey := integer('H');
   if Sender = DKsConF5 then MagKeyCurKey := integer('I');
   if Sender = DKsConF6 then MagKeyCurKey := integer('J');
   if Sender = DKsConF7 then MagKeyCurKey := integer('K');
   if Sender = DKsConF8 then MagKeyCurKey := integer('L');
   if Sender = DKsNone then MagKeyCurKey := 0;
end;

{------------------------------------------------------------------------}
//面版按钮
{------------------------------------------------------------------------}

procedure TFrmDlg.DBotMiniMapClick(Sender: TObject; X, Y: Integer);
begin

  if (g_nMiniMapIndex < 0) then
    DScreen.AddChatBoardString('没有小地图信息.', clWhite, clRed)
  else begin

    if not g_boViewMiniMap then begin
      g_nViewMinMapLv := 1;
      g_boViewMiniMap := TRUE;
    end else begin
      if g_nViewMinMapLv >= 2 then begin
        g_nViewMinMapLv:=0;
       g_boViewMiniMap := FALSE;
       end else Inc(g_nViewMinMapLv);
     end;
  end;
end;

procedure TFrmDlg.DBotTradeClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwQueryMsgTick then begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendDealTry;
   end;
end;

procedure TFrmDlg.DBotGuildClick(Sender: TObject; X, Y: Integer);
begin
   if DGuildDlg.Visible then begin
      DGuildDlg.Visible := FALSE;
   end else
      if GetTickCount > g_dwQueryMsgTick then begin
         g_dwQueryMsgTick := GetTickCount + 3000;
         FrmMain.SendGuildDlg;
      end;
end;

procedure TFrmDlg.DBotGroupClick(Sender: TObject; X, Y: Integer);
begin
   ToggleShowGroupDlg;
end;

{------------------------------------------------------------------------}
//组队窗口
{------------------------------------------------------------------------}

procedure TFrmDlg.ToggleShowGroupDlg;
begin
   DGroupDlg.Visible := not DGroupDlg.Visible;
end;

procedure TFrmDlg.DGroupDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   lx, ly, n: integer;
begin
   with DGroupDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      if g_GroupMembers.Count > 0 then begin
         with dsurface.Canvas do begin
            SetBkMode (Handle, TRANSPARENT);
            Font.Color := clSilver;
            lx := SurfaceX(28+6) + Left;
            ly := SurfaceY(80-10) + Top;
            TextOut (lx, ly,'领袖 '+ g_GroupMembers[0]);
            for n:=1 to g_GroupMembers.Count-1 do begin
               lx := SurfaceX(28+6) + Left + ((n-1) mod 2) * 100;
               ly := SurfaceY(80 + 12) + Top + ((n-1) div 2) * 16;
               TextOut (lx, ly, g_GroupMembers[n]);
            end;
            Release;
         end;
      end;
   end;
end;

procedure TFrmDlg.DGrpDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   DGroupDlg.Visible := FALSE;
end;

procedure TFrmDlg.DGrpAllowGroupDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;  
begin
   with Sender as TDButton do begin
      if not g_boAllowGroup then d := WLib.Images[FaceIndex-1]
      else d := WLib.Images[FaceIndex];

      if d <> nil then dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwChangeGroupModeTick then begin
      g_boAllowGroup := not g_boAllowGroup;
      g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5秒
      FrmMain.SendGroupMode (g_boAllowGroup);
   end;
end;

procedure TFrmDlg.DGrpCreateClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count = 0) then begin
      DialogSize := 1;
      DMessageDlg ('输入您想要创造小组的人物名。', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5秒
         FrmMain.SendCreateGroup (Trim (DlgEditText));
      end;
   end;
end;

procedure TFrmDlg.DGrpAddMemClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count > 0) then begin
      DialogSize := 1;
      DMessageDlg ('输入您想要参加小组人物的名字。', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5秒
         FrmMain.SendAddGroupMember (Trim (DlgEditText));
      end;
   end;
end;

procedure TFrmDlg.DGrpDelMemClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count > 0) then begin
      DialogSize := 1;
      DMessageDlg ('输入您想要从小组被删除的名字', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5秒
         FrmMain.SendDelGroupMember (Trim (DlgEditText));
      end;
   end;
end;

procedure TFrmDlg.DBotLogoutClick(Sender: TObject; X, Y: Integer);
begin
   if (GetTickCount - g_dwLatestStruckTick > 10000) and
      (GetTickCount - g_dwLatestMagicTick > 10000) and
      (GetTickCount - g_dwLatestHitTick > 10000) or
      (g_MySelf.m_boDeath) then begin
      FrmMain.AppLogOut;
   end else
      DScreen.AddChatBoardString ('在战斗期间，您不可能退出游戏。', clYellow, clRed);
end;

procedure TFrmDlg.DBotExitClick(Sender: TObject; X, Y: Integer);
begin
   if (GetTickCount - g_dwLatestStruckTick > 10000) and
      (GetTickCount - g_dwLatestMagicTick > 10000) and
      (GetTickCount - g_dwLatestHitTick > 10000) or
      (g_MySelf.m_boDeath) then begin
      FrmMain.AppExit;
   end else
      DScreen.AddChatBoardString ('在战斗期间，您不可能退出游戏。', clYellow, clRed);
end;

procedure TFrmDlg.DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
begin
   FrmDlg.OpenAdjustAbility;
end;


{------------------------------------------------------------------------}

//交易

{------------------------------------------------------------------------}


procedure TFrmDlg.OpenDealDlg;
var
   d: TDirectDrawSurface;
begin
   DDealRemoteDlg.Left := SCREENWIDTH-236-100;
   DDealRemoteDlg.Top := 0;
   DDealDlg.Left := SCREENWIDTH-236-100;
   DDealDlg.Top  := DDealRemoteDlg.Height-15;
   DItemBag.Left := 0;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;
   DDealDlg.Visible := TRUE;
   DDealRemoteDlg.Visible := TRUE;

   FillCHar (g_DealItems, sizeof(TClientItem)*10, #0);
   FillCHar (g_DealRemoteItems, sizeof(TClientItem)*20, #0);
   g_nDealGold := 0;
   g_nDealRemoteGold := 0;
   g_boDealEnd := FALSE;

   ArrangeItembag;
end;

procedure TFrmDlg.CloseDealDlg;
begin
   DDealDlg.Visible := FALSE;
   DDealRemoteDlg.Visible := FALSE;

   ArrangeItembag;
end;

procedure TFrmDlg.DDealOkClick(Sender: TObject; X, Y: Integer);
var
   mi: integer;
begin
   if GetTickCount > g_dwDealActionTick then begin
      //CloseDealDlg;
      FrmMain.SendDealEnd;
      g_dwDealActionTick := GetTickCount + 4000;
      g_boDealEnd := TRUE;

      if g_boItemMoving then begin
         mi := g_MovingItem.Index;
         if (mi <= -20) and (mi > -30) then begin
            AddDealItem (g_MovingItem.Item);
            g_boItemMoving := FALSE;
            g_MovingItem.Item.S.name := '';
         end;
      end;
   end;
end;

procedure TFrmDlg.DDealCloseClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwDealActionTick then begin
      CloseDealDlg;
      FrmMain.SendCancelDeal;
   end;
end;

procedure TFrmDlg.DDealRemoteDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with DDealRemoteDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (SurfaceX(Left+64), SurfaceY(Top+196-65-20), GetGoldStr(g_nDealRemoteGold));
         TextOut (SurfaceX(Left+59 + (106-TextWidth(g_sDealWho)) div 2), SurfaceY(Top+3)+3, g_sDealWho);
         Release;
      end;
   end;
end;

procedure TFrmDlg.DDealDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with DDealDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (SurfaceX(Left+64), SurfaceY(Top+196-65-20), GetGoldStr(g_nDealGold));
         TextOut (SurfaceX(Left+59 + (106-TextWidth(FrmMain.CharName)) div 2), SurfaceY(Top+3)+3, FrmMain.CharName);
         Release;
      end;
   end;
end;

procedure TFrmDlg.DealItemReturnBag (mitem: TClientItem);
begin
   if not g_boDealEnd then begin
      g_DealDlgItem := mitem;
      FrmMain.SendDelDealItem (g_DealDlgItem);
      g_dwDealActionTick := GetTickCount + 4000;
   end;
end;

procedure TFrmDlg.DDGridGridSelect(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
   temp: TClientItem;
   mi, idx: Integer;
   temp2: TClientItem;
   Amount: Integer;
   valstr:String;
begin
   if not g_boDealEnd and (GetTickCount > g_dwDealActionTick) then begin
      if not g_boItemMoving then begin
         idx := ACol + ARow * DDGrid.ColCount;
         if idx in [0..9] then
            if g_DealItems[idx].S.Name <> '' then begin
               g_boItemMoving := TRUE;
               g_MovingItem.Index := -idx - 20;
               g_MovingItem.Item := g_DealItems[idx];
               g_DealItems[idx].S.Name := '';
               ItemClickSound (g_MovingItem.Item.S);
            end;
      end else begin
         mi := g_MovingItem.Index;
         if (mi >= 0) or (mi <= -20) and (mi > -30) then begin
            ItemClickSound (g_MovingItem.Item.S);
            g_boItemMoving := FALSE;
            if mi >= 0 then begin
              if g_MovingItem.Item.S.StdMode = 45 then begin
                FrmDlg.DMessageDlg ('你需要增加多少个？', [mbOk, mbAbort]);
                GetValidStrVal (DlgEditText, valstr, [' ']);
                Amount:=Str_ToInt (valstr, 0);
              end else
                Amount:=1;
              if Amount < g_MovingItem.Item.Amount then begin
                temp2:=g_MovingItem.Item;
                dec(g_MovingItem.Item.Amount,Amount);
                AddItemBag(g_MovingItem.Item);
                temp2.Amount:=Amount;
              g_DealDlgItem := temp2;
              end else
              g_DealDlgItem := g_MovingItem.Item;
              FrmMain.SendAddDealItem (g_DealDlgItem);
              g_dwDealActionTick := GetTickCount + 4000;
            end else
               AddDealItem (g_MovingItem.Item);
            g_MovingItem.Item.S.name := '';
         end;
         if mi = -98 then DDGoldClick (self, 0, 0);
      end;
      ArrangeItemBag;
   end;
end;

procedure TFrmDlg.DDGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DDGrid.ColCount;
   if idx in [0..9] then begin
      if g_DealItems[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_DealItems[idx].S.Looks];
         if d <> nil then
            with DDGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DDGridGridMouseMove(Sender: TObject; ACol, ARow: Integer;
  Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DDGrid.ColCount;
   if idx in [0..9] then begin
      g_MouseItem := g_DealItems[idx];
   end;
end;

procedure TFrmDlg.DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DDRGrid.ColCount;
   if idx in [0..19] then begin
      if g_DealRemoteItems[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_DealRemoteItems[idx].S.Looks];
         if d <> nil then
            with DDRGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DDRGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DDRGrid.ColCount;
   if idx in [0..19] then begin
      g_MouseItem := g_DealRemoteItems[idx];
   end;
end;

procedure TFrmDlg.DealZeroGold;
begin
   if not g_boDealEnd and (g_nDealGold > 0) then begin
      g_dwDealActionTick := GetTickCount + 4000;
      FrmMain.SendChangeDealGold (0);
   end;
end;

procedure TFrmDlg.DDGoldClick(Sender: TObject; X, Y: Integer);
var
   dgold: integer;
   valstr: string;
begin
   if g_MySelf = nil then exit;
   if not g_boDealEnd and (GetTickCount > g_dwDealActionTick) then begin
      if not g_boItemMoving then begin
         if g_nDealGold > 0 then begin
            PlaySound (s_money);
            g_boItemMoving := TRUE;
            g_MovingItem.Index := -97;
            g_MovingItem.Item.S.Name := g_sGoldName;
         end;
      end else begin
         if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin
            if (g_MovingItem.Index = -98) then begin
               if g_MovingItem.Item.S.Name = g_sGoldName then begin

                  DialogSize := 1;
                  g_boItemMoving := FALSE;
                  g_MovingItem.Item.S.Name := '';
                  DMessageDlg ('你要增加' +g_sGoldName+ ' 到交易吗？', [mbOk, mbAbort]);
                  GetValidStrVal (DlgEditText, valstr, [' ']);
                  dgold := Str_ToInt (valstr, 0);
                  if (dgold <= (g_nDealGold+g_MySelf.m_nGold)) and (dgold > 0) then begin
                     FrmMain.SendChangeDealGold (dgold);
                     g_dwDealActionTick := GetTickCount + 4000;
                  end else
                     dgold := 0;
               end;
            end;
            g_boItemMoving := FALSE;
            g_MovingItem.Item.S.Name := '';
         end;
      end;
   end;
end;



{--------------------------------------------------------------}


procedure TFrmDlg.DUserState1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   i, l, m, pgidx, bbx, bby, idx, ax, ay, sex, hair: integer;
   d: TDirectDrawSurface;
   hcolor, keyimg: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
   output : string;
begin
   with DUserState1 do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      sex := DRESSfeature (UserState1.Feature) mod 2;
      hair := HAIRfeature (UserState1.Feature);
      if sex = 1 then pgidx := 377
      else pgidx := 376;
      bbx := Left + 38;
      bby := Top + 59;
      d := g_WMainImages.Images[pgidx];
      if d <> nil then
         dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);
      bbx := bbx - 7;
      bby := bby + 44;

      if UserState1.UseItems[U_DRESS].S.Name <> '' then begin
         idx := UserState1.UseItems[U_DRESS].S.Looks; //if m_btSex = 1 then idx := 80;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            d := FrmMain.GetWStateImg(idx,ax,ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
      end;

      idx := 440 + hair div 2;
      if sex = 1 then idx := 480 + hair div 2;
      if idx > 0 then begin
         d := g_WMainImages.GetCachedImage (idx, ax, ay);
         if d <> nil then
            dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
      end;

      if UserState1.UseItems[U_WEAPON].S.Name <> '' then begin
         idx := UserState1.UseItems[U_WEAPON].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            d := FrmMain.GetWStateImg(idx,ax,ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
      end;

      if UserState1.UseItems[U_HELMET].S.Name <> '' then begin
         idx := UserState1.UseItems[U_HELMET].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            d := FrmMain.GetWStateImg(idx,ax,ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
      end;

      {原为打开，显示其它人物信息里的装备信息，显示在人物下方
      if MouseUserStateItem.S.Name <> '' then begin
         MouseItem := MouseUserStateItem;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         if iname <> '' then begin
            if MouseItem.Dura = 0 then hcolor := clRed
            else hcolor := clWhite;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clYellow;
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272), iname);
               Font.Color := hcolor;
               TextOut (SurfaceX(Left+37+TextWidth(iname)), SurfaceY(Top+272), d1);
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272+TextHeight('A')+2), d2);
               TextOut (SurfaceX(Left+37), SurfaceY(Top+272+(TextHeight('A')+2)*2), d3);
               Release;
            end;
         end;
         MouseItem.S.Name := '';
      end;
      }

      if g_LoverNameState <> '' then begin
       DLoverHeart.Visible := True;
      end else begin
       DLoverHeart.Visible := False;
      end;
      
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := UserState1.NameColor;
         TextOut (SurfaceX(Left + 122 - TextWidth(UserState1.UserName) div 2),
                  SurfaceY(Top + 10), UserState1.UserName);

         Font.Color := clSilver;
         output:= UserState1.GuildName + ' ' + UserState1.GuildRankName;
         TextOut (SurfaceX(Left + 120) - TextWidth(output) div 2, SurfaceY(Top + 25),
                  output);
         Release;
      end;
   end;
end;

procedure TFrmDlg.DUserState1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   X := DUserState1.LocalX (X) - DUserState1.Left;
   Y := DUserState1.LocalY (Y) - DUserState1.Top;
   if (X > 42) and (X < 201) and (Y > 54) and (Y < 71) then begin
      //DScreen.AddSysMsg (IntToStr(X) + ' ' + IntToStr(Y) + ' ' + UserState1.GuildName);
      if UserState1.GuildName <> '' then begin
         PlayScene.EdChat.Visible := TRUE;
         PlayScene.EdChat.SetFocus;
         SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
         PlayScene.EdChat.Text := UserState1.GuildName;
         PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
         PlayScene.EdChat.SelLength := 0;
      end;
   end;
  if (x > 42) and ( x < 201) and (y > 24) and (y < 51) then begin
    if UserState1.UserName <> '' then begin
      PlayScene.EdChat.Visible :=TRUE;
      PlayScene.EdChat.SetFocus;
      SetImeMode(PlayScene.EdChat.Handle,LocalLanguage);
      PlayScene.EdChat.Text := '/'+ UserState1.UserName + ' ';
      PlayScene.EdChat.SelStart:= Length(PlayScene.EdChat.Text);
      PlayScene.EdChat.SelLength :=0;
    end;
  end;
end;

procedure TFrmDlg.DUserState1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg: String;
begin
  DScreen.ClearHint;
  Butt:=TDButton(Sender);

  if Sender = DHeartMyState then begin
    sMsg:= g_LoverNameClient;
    nLocalX:=Butt.LocalX(X - Butt.Left);
    nLocalY:=Butt.LocalY(Y - Butt.Top);
    nHintX:=Butt.SurfaceX(Butt.Left) + DStateWin.SurfaceX(DStateWin.Left) + nLocalX;
    nHintY:=Butt.SurfaceY(Butt.Top) + DStateWin.SurfaceY(DStateWin.Top) + nLocalY;
  end else begin
    if Sender = DUSFriend then sMsg := '添加到好友列表'
    else if Sender = DUSGroup then sMsg := '邀请组队'
    else if Sender = DUSMail then sMsg := '发送邮件';
    nHintX:=mouse.CursorPos.X;
    nHintY:=mouse.CursorPos.Y;
  end;

  DScreen.ShowHint(nHintX, nHintY, sMsg, clYellow, TRUE);
  g_MouseUserStateItem.S.Name := '';
end;

procedure TFrmDlg.DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
   nLocalX,nLocalY:Integer;
   nHintX,nHintY:Integer;
   sel: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
   hcolor: TColor;
   Butt:TDButton;
   
begin
   sel := -1;

   Butt:=TDButton(Sender);
   if Sender = DDressUS1 then sel := U_DRESS;
   if Sender = DWeaponUS1 then sel := U_WEAPON;
   if Sender = DHelmetUS1 then sel := U_HELMET;
   if Sender = DNecklaceUS1 then sel := U_NECKLACE;
   if Sender = DLightUS1 then sel := U_RIGHTHAND;
   if Sender = DRingLUS1 then sel := U_RINGL;
   if Sender = DRingRUS1 then sel := U_RINGR;
   if Sender = DArmRingLUS1 then sel := U_ARMRINGL;
   if Sender = DArmRingRUS1 then sel := U_ARMRINGR;

   if Sender = DBujukUS1 then sel := U_BUJUK;
   if Sender = DBeltUS1 then sel := U_BELT;
   if Sender = DBootsUS1 then sel := U_BOOTS;
   if Sender = DCharmUS1 then sel := U_CHARM;

   if sel >= 0 then begin
      g_MouseUserStateItem := UserState1.UseItems[sel];
      //原为注释掉 显示人物身上带的物品信息
      g_MouseItem := UserState1.UseItems[sel];
      GetMouseItemInfo (iname, d1, d2, d3, useable);
      if iname <> '' then begin
         if UserState1.UseItems[sel].Dura = 0 then hcolor := clRed
         else hcolor := UserState1.UseItems[sel].S.Color;

         nLocalX:=Butt.LocalX(X - Butt.Left);
         nLocalY:=Butt.LocalY(Y - Butt.Top);
         if d1 <> '' then
          inc(nLocalY,18);
         if d2 <> '' then
          inc(nLocalY,18);
         if d3 <> '' then
          inc(nLocalY,18);
         nHintX:=Butt.SurfaceX(Butt.Left) + DUserState1.SurfaceX(DUserState1.Left) + nLocalX;
         nHintY:=Butt.SurfaceY(Butt.Top) + DUserState1.SurfaceY(DUserState1.Top) + nLocalY;

         with Butt as TDButton do
          DScreen.ShowHint(nHintX,nHintY,
                             iname + d1 + '\' + d2 + '\' + d3, hcolor, TRUE);
      end;
      g_MouseItem.S.Name := '';
      //      
   end;

end;

procedure TFrmDlg.DCloseUS1Click(Sender: TObject; X, Y: Integer);
begin
   DUserState1.Visible := FALSE;
end;

procedure TFrmDlg.DNecklaceUS1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   if Sender = DNecklaceUS1 then begin
      if UserState1.UseItems[U_NECKLACE].S.Name <> '' then begin
         idx := UserState1.UseItems[U_NECKLACE].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DNecklaceUS1.SurfaceX(DNecklaceUS1.Left + (DNecklaceUS1.Width - d.Width) div 2),
                              DNecklaceUS1.SurfaceY(DNecklaceUS1.Top + (DNecklaceUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DLightUS1 then begin
      if UserState1.UseItems[U_RIGHTHAND].S.Name <> '' then begin
         idx := UserState1.UseItems[U_RIGHTHAND].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DLightUS1.SurfaceX(DLightUS1.Left + (DLightUS1.Width - d.Width) div 2),
                              DLightUS1.SurfaceY(DLightUS1.Top + (DLightUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DArmRingRUS1 then begin
      if UserState1.UseItems[U_ARMRINGR].S.Name <> '' then begin
         idx := UserState1.UseItems[U_ARMRINGR].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DArmRingRUS1.SurfaceX(DArmRingRUS1.Left + (DArmRingRUS1.Width - d.Width) div 2),
                              DArmRingRUS1.SurfaceY(DArmRingRUS1.Top + (DArmRingRUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DArmRingLUS1 then begin
      if UserState1.UseItems[U_ARMRINGL].S.Name <> '' then begin
         idx := UserState1.UseItems[U_ARMRINGL].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DArmRingLUS1.SurfaceX(DArmRingLUS1.Left + (DArmRingLUS1.Width - d.Width) div 2),
                              DArmRingLUS1.SurfaceY(DArmRingLUS1.Top + (DArmRingLUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DRingRUS1 then begin
      if UserState1.UseItems[U_RINGR].S.Name <> '' then begin
         idx := UserState1.UseItems[U_RINGR].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DRingRUS1.SurfaceX(DRingRUS1.Left + (DRingRUS1.Width - d.Width) div 2),
                              DRingRUS1.SurfaceY(DRingRUS1.Top + (DRingRUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
   if Sender = DRingLUS1 then begin
      if UserState1.UseItems[U_RINGL].S.Name <> '' then begin
         idx := UserState1.UseItems[U_RINGL].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DRingLUS1.SurfaceX(DRingLUS1.Left + (DRingLUS1.Width - d.Width) div 2),
                              DRingLUS1.SurfaceY(DRingLUS1.Top + (DRingLUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;


   if Sender = DBujukUS1 then begin
      if UserState1.UseItems[U_BUJUK].S.Name <> '' then begin
         idx := UserState1.UseItems[U_BUJUK].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DBujukUS1.SurfaceX(DBujukUS1.Left + (DBujukUS1.Width - d.Width) div 2),
                              DBujukUS1.SurfaceY(DBujukUS1.Top + (DBujukUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;

   if Sender = DBeltUS1 then begin
      if UserState1.UseItems[U_BELT].S.Name <> '' then begin
         idx := UserState1.UseItems[U_BELT].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DBeltUS1.SurfaceX(DBeltUS1.Left + (DBeltUS1.Width - d.Width) div 2),
                              DBeltUS1.SurfaceY(DBeltUS1.Top + (DBeltUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;

   if Sender = DBootsUS1 then begin
      if UserState1.UseItems[U_BOOTS].S.Name <> '' then begin
         idx := UserState1.UseItems[U_BOOTS].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DBootsUS1.SurfaceX(DBootsUS1.Left + (DBootsUS1.Width - d.Width) div 2),
                              DBootsUS1.SurfaceY(DBootsUS1.Top + (DBootsUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;

   if Sender = DCharmUS1 then begin
      if UserState1.UseItems[U_CHARM].S.Name <> '' then begin
         idx := UserState1.UseItems[U_CHARM].S.Looks;
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.Images[idx];
            d := FrmMain.GetWStateImg(idx);
            if d <> nil then
               dsurface.Draw (DCharmUS1.SurfaceX(DCharmUS1.Left + (DCharmUS1.Width - d.Width) div 2),
                              DCharmUS1.SurfaceY(DCharmUS1.Top + (DCharmUS1.Height - d.Height) div 2),
                              d.ClientRect, d, TRUE);
         end;
      end;
   end;
end;


procedure TFrmDlg.ShowGuildDlg;
begin
   DGuildDlg.Visible := TRUE;  //not DGuildDlg.Visible;
   DGuildDlg.Top := -3;
   DGuildDlg.Left := 0;
   if DGuildDlg.Visible then begin
      if GuildCommanderMode then begin
         DGDAddMem.Visible := TRUE;
         DGDDelMem.Visible := TRUE;
         DGDEditNotice.Visible := TRUE;
         DGDEditGrade.Visible := TRUE;
         DGDAlly.Visible := TRUE;
         DGDBreakAlly.Visible := TRUE;
         DGDWar.Visible := TRUE;
         DGDCancelWar.Visible := TRUE;
      end else begin
         DGDAddMem.Visible := FALSE;
         DGDDelMem.Visible := FALSE;
         DGDEditNotice.Visible := FALSE;
         DGDEditGrade.Visible := FALSE;
         DGDAlly.Visible := FALSE;
         DGDBreakAlly.Visible := FALSE;
         DGDWar.Visible := FALSE;
         DGDCancelWar.Visible := FALSE;
      end;
   end;
   GuildTopLine := 0;
end;

procedure TFrmDlg.ShowGuildEditNotice;
var
   d: TDirectDrawSurface;
   i: integer;
   data: string;
begin
   with DGuildEditNotice do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
         Left := (SCREENWIDTH - d.Width) div 2;
         Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      HideAllControls;
      DGuildEditNotice.ShowModal;

      Memo.Left := SurfaceX(Left+28);  //16
      Memo.Top  := SurfaceY(Top+61);   //36
      Memo.Width := 569;
      Memo.Height := 241;
      Memo.Lines.Assign (GuildNotice);
      Memo.Visible := TRUE;

      while TRUE do begin
         if not DGuildEditNotice.Visible then break;
         FrmMain.ProcOnIdle;
         Application.ProcessMessages;
         if Application.Terminated then exit;
      end;

      DGuildEditNotice.Visible := FALSE;
      RestoreHideControls;

      if DMsgDlg.DialogResult = mrOk then begin
         data := '';
         for i:=0 to Memo.Lines.Count-1 do begin
            if Memo.Lines[i] = '' then
               data := data + Memo.Lines[i] + ' '#13
            else data := data + Memo.Lines[i] + #13;
         end;
         if Length(data) > 4000 then begin
            data := Copy (data, 1, 4000);
            DMessageDlg ('公告内容超过限制大小，公告内容将被截短！', [mbOk]);
         end;
         FrmMain.SendGuildUpdateNotice (data);
      end;
   end;
end;

procedure TFrmDlg.ShowGuildEditGrade;
var
   d: TDirectDrawSurface;
   data: string;
   i: integer;
begin
   if GuildMembers.Count <= 0 then begin
      DMessageDlg ('请先点击 [LIST] 编辑公会成员信息。', [mbOk]);
      exit;
   end;

   with DGuildEditNotice do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
         Left := (SCREENWIDTH - d.Width) div 2;
         Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      HideAllControls;
      DGuildEditNotice.ShowModal;
      ///Guild Members Grade screen
      Memo.Left := SurfaceX(Left+28);  //16
      Memo.Top  := SurfaceY(Top+61);   //36
      Memo.Width := 569;
      Memo.Height := 241;
      Memo.Lines.Assign (GuildMembers);
      Memo.Visible := TRUE;

      while TRUE do begin
         if not DGuildEditNotice.Visible then break;
         FrmMain.ProcOnIdle;
         Application.ProcessMessages;
         if Application.Terminated then exit;
      end;

      DGuildEditNotice.Visible := FALSE;
      RestoreHideControls;

      if DMsgDlg.DialogResult = mrOk then begin
         //GuildMembers.Assign (Memo.Lines);

         data := '';
         for i:=0 to Memo.Lines.Count-1 do begin
            data := data + Memo.Lines[i] + #13;
         end;
         if Length(data) > 5000 then begin
            data := Copy (data, 1, 5000);
            DMessageDlg ('内容超过限制大小，内容将被截短！', [mbOk]);
         end;
         FrmMain.SendGuildUpdateGrade (data);
      end;
   end;
end;

procedure TFrmDlg.DGuildDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  i, n, bx, by: integer;
begin
   with DGuildDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         TextOut (Left+320, Top+36, Guild);

         bx := Left + 25;
         by := Top + 65;      //55
         for i:=GuildTopLine to GuildStrs.Count-1 do begin
            n := i-GuildTopLine;
            if n*14 > 356 then break;
            if Integer(GuildStrs.Objects[i]) <> 0 then Font.Color := TColor(GuildStrs.Objects[i])
            else begin
               if BoGuildChat then Font.Color := GetRGB (2)
               else Font.Color := clSilver;
            end;
            TextOut (bx+5, by + n*14, GuildStrs[i]);
         end;

         Release;
      end;

   end;
end;

procedure TFrmDlg.DGDUpClick(Sender: TObject; X, Y: Integer);
begin
   if GuildTopLine > 0 then Dec (GuildTopLine, 3);
   if GuildTopLine < 0 then GuildTopLine := 0;
end;

procedure TFrmDlg.DGDDownClick(Sender: TObject; X, Y: Integer);
begin
   if GuildTopLine+12 < GuildStrs.Count then Inc (GuildTopLine, 3);
end;

procedure TFrmDlg.DGDCloseClick(Sender: TObject; X, Y: Integer);
begin
   DGuildDlg.Visible := FALSE;
   BoGuildChat := FALSE;
end;

procedure TFrmDlg.DGDHomeClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwQueryMsgTick then begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendGuildHome;
      BoGuildChat := FALSE;
   end;
end;

procedure TFrmDlg.DGDListClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwQueryMsgTick then begin
      g_dwQueryMsgTick := GetTickCount + 3000;
      FrmMain.SendGuildMemberList;
      BoGuildChat := FALSE;
   end;
end;

procedure TFrmDlg.DGDAddMemClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg ('请输入想加入 ' + Guild + '的人物名称。', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendGuildAddMem (DlgEditText);
end;

procedure TFrmDlg.DGDDelMemClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg ('请输入想要开除的人物名称', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendGuildDelMem (DlgEditText);
end;

procedure TFrmDlg.DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
begin
   GuildEditHint := '[修改公会公告内容。]';
   ShowGuildEditNotice;
end;

procedure TFrmDlg.DGDEditGradeClick(Sender: TObject; X, Y: Integer);
begin
   GuildEditHint := '[修改公会成员的等级和职位。 # 警告 : 不能增加公会成员/删除公会成员。]';
   ShowGuildEditGrade;
end;

procedure TFrmDlg.DGDAllyClick(Sender: TObject; X, Y: Integer);
begin
   if mrOk = DMessageDlg ('对方结盟公会必需在 [允许结盟]状态下。\' +
                  '而且二个公会的领袖必须面对面。\' +
                  '是否确认公会结盟？', [mbOk, mbCancel])
   then
      FrmMain.SendSay ('@联盟');
end;

procedure TFrmDlg.DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg ('请输入您想取消结盟的行会的名字', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendSay ('@取消联盟 ' + DlgEditText);
end;



procedure TFrmDlg.DGuildEditNoticeDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with DGuildEditNotice do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clSilver;

         TextOut (Left+28, Top+305, GuildEditHint);
         Release;
      end;
   end;
end;

procedure TFrmDlg.DGECloseClick(Sender: TObject; X, Y: Integer);
begin
   DGuildEditNotice.Visible := FALSE;
   Memo.Visible := FALSE;
   DMsgDlg.DialogResult := mrCancel;
end;

procedure TFrmDlg.DGEOkClick(Sender: TObject; X, Y: Integer);
begin
   DGECloseClick (self, 0, 0);
   DMsgDlg.DialogResult := mrOk;
end;

procedure TFrmDlg.AddGuildChat (str: string);
var
   i: integer;
begin
   GuildChats.Add (str);
   if GuildChats.Count > 500 then begin
      for i:=0 to 100 do GuildChats.Delete(0);
   end;
   if BoGuildChat then
      GuildStrs.Assign (GuildChats);
end;

procedure TFrmDlg.DGDChatClick(Sender: TObject; X, Y: Integer);
begin
   BoGuildChat := not BoGuildChat;
   if BoGuildChat then begin
      GuildStrs2.Assign (GuildStrs);
      GuildStrs.Assign (GuildChats);
   end else
      GuildStrs.Assign (GuildStrs2);
end;

procedure TFrmDlg.DGoldDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   if g_MySelf = nil then exit;
   with DGold do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;


{--------------------------------------------------------------}

procedure TFrmDlg.DAdjustAbilCloseClick(Sender: TObject; X, Y: Integer);
begin
   DAdjustAbility.Visible := FALSE;
   g_nBonusPoint := g_nSaveBonusPoint;
end;

procedure TFrmDlg.DAdjustAbilityDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
   procedure AdjustAb (abil: byte; val: word; var lov, hiv: Word);
   var
      lo, hi: byte;
      i: integer;
   begin
      lo := Lobyte(abil);
      hi := Hibyte(abil);
      lov := 0; hiv := 0;
      for i:=1 to val do begin
         if lo+1 < hi then begin Inc(lo); Inc(lov);
         end else begin Inc(hi); Inc(hiv); end;
      end;
   end;
var
   d: TDirectDrawSurface;
   l, m, adc, amc, asc, aac, amac: integer;
   ldc, lmc, lsc, lac, lmac, hdc, hmc, hsc, hac, hmac: Word;
begin
   if g_MySelf = nil then exit;
   with dsurface.Canvas do begin
      with DAdjustAbility do begin
         d := DMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clSilver;

      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 36;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 22;

      TextOut (l, m,      '你当前还有剩余部份属性点未分配。');
      TextOut (l, m+14,   '请根据自己的意向，调整自己的属性值。');
      TextOut (l, m+14*2, '些属性点数，下不可以重新分配。');
      TextOut (l, m+14*3, '在分配时要小心选择。');

      Font.Color := clWhite;

      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 100; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

      {
      adc := (g_BonusAbil.DC + g_BonusAbilChg.DC) div g_BonusTick.DC;
      amc := (g_BonusAbil.MC + g_BonusAbilChg.MC) div g_BonusTick.MC;
      asc := (g_BonusAbil.SC + g_BonusAbilChg.SC) div g_BonusTick.SC;
      aac := (g_BonusAbil.AC + g_BonusAbilChg.AC) div g_BonusTick.AC;
      amac := (g_BonusAbil.MAC + g_BonusAbilChg.MAC) div g_BonusTick.MAC;
      }
      adc := (g_BonusAbilChg.DC) div g_BonusTick.DC;
      amc := (g_BonusAbilChg.MC) div g_BonusTick.MC;
      asc := (g_BonusAbilChg.SC) div g_BonusTick.SC;
      aac := (g_BonusAbilChg.AC) div g_BonusTick.AC;
      amac := (g_BonusAbilChg.MAC) div g_BonusTick.MAC;

      AdjustAb (g_NakedAbil.DC, adc, ldc, hdc);
      AdjustAb (g_NakedAbil.MC, amc, lmc, hmc);
      AdjustAb (g_NakedAbil.SC, asc, lsc, hsc);
      AdjustAb (g_NakedAbil.AC, aac, lac, hac);
      AdjustAb (g_NakedAbil.MAC, amac, lmac, hmac);
      //lac  := 0;  hac := aac;
      //lmac := 0;  hmac := amac;

      TextOut (l+0, m+0, IntToStr(LoWord(g_MySelf.m_Abil.DC)+ldc) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.DC) + hdc));
      TextOut (l+0, m+20, IntToStr(LoWord(g_MySelf.m_Abil.MC)+lmc) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MC) + hmc));
      TextOut (l+0, m+40, IntToStr(LoWord(g_MySelf.m_Abil.SC)+lsc) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.SC) + hsc));
      TextOut (l+0, m+60, IntToStr(LoWord(g_MySelf.m_Abil.AC)+lac) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.AC) + hac));
      TextOut (l+0, m+80, IntToStr(LoWord(g_MySelf.m_Abil.MAC)+lmac) + '-' + IntToStr(HiWord(g_MySelf.m_Abil.MAC) + hmac));
      TextOut (l+0, m+100, IntToStr(g_MySelf.m_Abil.MaxHP + (g_BonusAbil.HP + g_BonusAbilChg.HP) div g_BonusTick.HP));
      TextOut (l+0, m+120, IntToStr(g_MySelf.m_Abil.MaxMP + (g_BonusAbil.MP + g_BonusAbilChg.MP) div g_BonusTick.MP));
      TextOut (l+0, m+140, IntToStr(g_nMyHitPoint + (g_BonusAbil.Hit + g_BonusAbilChg.Hit) div g_BonusTick.Hit));
      TextOut (l+0, m+160, IntToStr(g_nMySpeedPoint + (g_BonusAbil.Speed + g_BonusAbilChg.Speed) div g_BonusTick.Speed));

      Font.Color := clYellow;
      TextOut (l+0, m+180, IntToStr(g_nBonusPoint));

      Font.Color := clWhite;
      l := DAdjustAbility.SurfaceX(DAdjustAbility.Left) + 155; //66;
      m := DAdjustAbility.SurfaceY(DAdjustAbility.Top) + 101;

      if g_BonusAbilChg.DC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+0, IntToStr(g_BonusAbilChg.DC + g_BonusAbil.DC) + '/' + IntToStr(g_BonusTick.DC));

      if g_BonusAbilChg.MC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+20, IntToStr(g_BonusAbilChg.MC + g_BonusAbil.MC) + '/' + IntToStr(g_BonusTick.MC));

      if g_BonusAbilChg.SC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+40, IntToStr(g_BonusAbilChg.SC + g_BonusAbil.SC) + '/' + IntToStr(g_BonusTick.SC));

      if g_BonusAbilChg.AC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+60, IntToStr(g_BonusAbilChg.AC + g_BonusAbil.AC) + '/' + IntToStr(g_BonusTick.AC));

      if g_BonusAbilChg.MAC > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+80, IntToStr(g_BonusAbilChg.MAC + g_BonusAbil.MAC) + '/' + IntToStr(g_BonusTick.MAC));

      if g_BonusAbilChg.HP > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+100, IntToStr(g_BonusAbilChg.HP + g_BonusAbil.HP) + '/' + IntToStr(g_BonusTick.HP));

      if g_BonusAbilChg.MP > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+120, IntToStr(g_BonusAbilChg.MP + g_BonusAbil.MP) + '/' + IntToStr(g_BonusTick.MP));

      if g_BonusAbilChg.Hit > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+140, IntToStr(g_BonusAbilChg.Hit + g_BonusAbil.Hit) + '/' + IntToStr(g_BonusTick.Hit));

      if g_BonusAbilChg.Speed > 0 then Font.Color := clWhite
      else Font.Color := clSilver;
      TextOut (l+0, m+160, IntToStr(g_BonusAbilChg.Speed + g_BonusAbil.Speed) + '/' + IntToStr(g_BonusTick.Speed));

      Release;
   end;

end;

procedure TFrmDlg.DPlusDCClick(Sender: TObject; X, Y: Integer);
var
   incp: integer;
begin
   if g_nBonusPoint > 0 then begin
      if IsKeyPressed (VK_CONTROL) and (g_nBonusPoint > 10) then incp := 10
      else incp := 1;
      Dec(g_nBonusPoint, incp);
      if Sender = DPlusDC then Inc (g_BonusAbilChg.DC, incp);
      if Sender = DPlusMC then Inc (g_BonusAbilChg.MC, incp);
      if Sender = DPlusSC then Inc (g_BonusAbilChg.SC, incp);
      if Sender = DPlusAC then Inc (g_BonusAbilChg.AC, incp);
      if Sender = DPlusMAC then Inc (g_BonusAbilChg.MAC, incp);
      if Sender = DPlusHP then Inc (g_BonusAbilChg.HP, incp);
      if Sender = DPlusMP then Inc (g_BonusAbilChg.MP, incp);
      if Sender = DPlusHit then Inc (g_BonusAbilChg.Hit, incp);
      if Sender = DPlusSpeed then Inc (g_BonusAbilChg.Speed, incp);
   end;
end;

procedure TFrmDlg.DMinusDCClick(Sender: TObject; X, Y: Integer);
var
   decp: integer;
begin
   if IsKeyPressed (VK_CONTROL) and (g_nBonusPoint-10 > 0) then decp := 10
   else decp := 1;
   if Sender = DMinusDC then
      if g_BonusAbilChg.DC >= decp then begin
         Dec(g_BonusAbilChg.DC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusMC then
      if g_BonusAbilChg.MC >= decp then begin
         Dec(g_BonusAbilChg.MC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusSC then
      if g_BonusAbilChg.SC >= decp then begin
         Dec(g_BonusAbilChg.SC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusAC then
      if g_BonusAbilChg.AC >= decp then begin
         Dec(g_BonusAbilChg.AC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusMAC then
      if g_BonusAbilChg.MAC >= decp then begin
         Dec(g_BonusAbilChg.MAC, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusHP then
      if g_BonusAbilChg.HP >= decp then begin
         Dec(g_BonusAbilChg.HP, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusMP then
      if g_BonusAbilChg.MP >= decp then begin
         Dec(g_BonusAbilChg.MP, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusHit then
      if g_BonusAbilChg.Hit >= decp then begin
         Dec(g_BonusAbilChg.Hit, decp);
         Inc (g_nBonusPoint, decp);
      end;
   if Sender = DMinusSpeed then
      if g_BonusAbilChg.Speed >= decp then begin
         Dec(g_BonusAbilChg.Speed, decp);
         Inc (g_nBonusPoint, decp);
      end;
end;

procedure TFrmDlg.DAdjustAbilOkClick(Sender: TObject; X, Y: Integer);
begin
   FrmMain.SendAdjustBonus(g_nBonusPoint, g_BonusAbilChg);
   DAdjustAbility.Visible := FALSE;
end;

procedure TFrmDlg.DAdjustAbilityMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   i, lx, ly: integer;
   flag: Boolean;
begin
   with DAdjustAbility do begin
      lx := LocalX (X - Left);
      ly := LocalY (Y - Top);
      flag := FALSE;
      if (lx >= 50) and (lx < 150) then
         for i:=0 to 8 do begin  //DC,MC,SC..
            if (ly >= 98 + i*20) and (ly < 98 + (i+1)*20) then begin
               DScreen.ShowHint (SurfaceX(Left) + lx + 10,
                                 SurfaceY(Top) + ly + 5,
                                 AdjustAbilHints[i],
                                 clWhite,
                                 FALSE);
               flag := TRUE;
               break;
            end;
         end;
      if not flag then
         DScreen.ClearHint;
   end;
end;

procedure TFrmDlg.DBotMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg:String;
begin
  Butt:=TDButton(Sender);
  if Sender = DBotMiniMap then sMsg:= '小地图(V)'
  else if Sender = DBotTrade then sMsg:= '交易(T)'
  else if Sender = DBotGuild then sMsg:= '公会(G)'
  else if Sender = DBotGroup then sMsg:= '组队(P)'
  else if Sender = DBotPlusAbil then sMsg:= '能力(M)'
  else if Sender = DBotFriend then sMsg:= '朋友(W)'
  else if Sender = DBotLover then sMsg:= '关系(L)'
  else if Sender = DBotLogout then sMsg:= '注销(Alt-X)'
  else if Sender = DBotExit then sMsg:= '退出(Alt-Q)'
  else if Sender = DBotHelp then sMsg:= '帮助(L)'
  else if Sender = DBotQuest then sMsg:= '任务(Q)'
  else if Sender = DBotExpand then sMsg:= '关于(A)'
  else if Sender = DBotItemShop then sMsg:= '物品商城(Y)'
  else if Sender = DBotMemo then begin
    if g_boHasMail then sMsg := '邮件包(M) - 未读邮件'
    else sMsg := '邮件包(M)';
  end
  else if Sender = DMyState then sMsg:= '人物状态(F10,C)'
  else if Sender = DMyBag then sMsg:= '背包(F9,I)'
  else if Sender = DMyMagic then sMsg:= '技能(F11,S)'
  else if Sender = DOption then sMsg:= '选项(O)'
  else if Sender = DBottom then begin
     //Level
    if ((X >= SCREENWIDTH - 117) and (X <= SCREENWIDTH - 79)) and ((Y >= SCREENHEIGHT - 93) and (Y <= SCREENHEIGHT - 76)) then begin
      sMsg := '等级(' +inttostr(g_MySelf.m_Abil.level) +')';
      nHintX := X;
      nHintY := Y;
      DScreen.ShowHint(nHintX,nHintY,sMsg, clYellow, TRUE);
      exit;
    end
     //Experience
    else if ((X >= SCREENWIDTH - 136) and (X <= SCREENWIDTH - 47)) and ((Y >= SCREENHEIGHT - 58) and (Y <= SCREENHEIGHT - 47)) then begin
      sMsg := '经验值(' +FloatToStrFixFmt(100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) +'%)';
      nHintX := X;
      nHintY := Y;
      DScreen.ShowHint(nHintX,nHintY,sMsg, clYellow, TRUE);
      exit;
    end
     //Weight
    else if ((X >= SCREENWIDTH - 113) and (X <= SCREENWIDTH - 22)) and ((Y >= SCREENHEIGHT - 27) and (Y <= SCREENHEIGHT - 16)) then begin
      sMsg := format('背包重量(%d/%d)',[g_MySelf.m_Abil.Weight,g_MySelf.m_Abil.MaxWeight]);
      nHintX := X;
      nHintY := Y;
      DScreen.ShowHint(nHintX,nHintY,sMsg, clYellow, TRUE);
      exit;
    end;
    //DScreen.ClearHint;
    //exit;
  end;

  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DBottom.SurfaceX(DBottom.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DBottom.SurfaceY(DBottom.Top) + nLocalY;
  DScreen.ShowHint(nHintX,nHintY,sMsg, clYellow, TRUE);
end;


procedure TFrmDlg.DBotFriendClick(Sender: TObject; X, Y: Integer);
begin
  OpenFriendDlg();
end;

procedure TFrmDlg.OpenFriendDlg();
begin
  DFriendDlg.Visible:=not DFriendDlg.Visible;
end;

procedure TFrmDlg.DFrdCloseClick(Sender: TObject; X, Y: Integer);
begin
  OpenFriendDlg();
  DScreen.ClearHint;
end;

procedure TFrmDlg.DChgGamePwdCloseClick(Sender: TObject; X, Y: Integer);
begin
  DChgGamePwd.Visible:=False;
end;

procedure TFrmDlg.DChgGamePwdDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d:TDirectDrawSurface;
  lx, ly, sx: integer;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

    SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
    BoldTextOut (dsurface, SurfaceX(Left+15), SurfaceY(Top+13), clWhite, clBlack, 'GamePoint');

    dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style + [fsUnderline];
    BoldTextOut (dsurface, SurfaceX(Left+12), SurfaceY(Top+190), clYellow, clBlack, 'GameGold');
    dsurface.Canvas.Font.Style := dsurface.Canvas.Font.Style - [fsUnderline];
    dsurface.Canvas.Release;
  end;
end;

procedure TFrmDlg.DGemMakeItemDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d:TDirectDrawSurface;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
    BoldTextOut (dsurface, SurfaceX(Left + 35) , SurfaceY(Top + 70), clWhite, clBlack, '合成制作物品');
    dsurface.Canvas.Release;
  end;
end;

(*procedure TFrmDlg.int(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
    d:TDirectDrawSurface;
begin

end;*)


procedure TFrmDlg.DGemMakeOKDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
    d:TDirectDrawSurface;
begin
   with DGemMakeOK do begin
     if DGemMakeOK.Downed then begin
       d := WLib.Images[FaceIndex + 1];
     end else
       d := WLib.Images[FaceIndex];
     if (d <> nil) then
         dsurface.Draw (SurfaceX(Left+1), SurfaceY(Top+1), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DGemMakeCancelDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
    d:TDirectDrawSurface;
begin
   with DGemMakeCancel do begin
     if DGemMakeCancel.Downed then begin
       d := WLib.Images[FaceIndex + 1];
     end else
       d := WLib.Images[FaceIndex];
     if (d <> nil) then
         dsurface.Draw (SurfaceX(Left+1), SurfaceY(Top+1), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.CancelGemMaking();
var
i:integer;
begin
  AddItemBagst(g_GemItem1);
  AddItemBagst(g_GemItem2);
  AddItemBagst(g_GemItem3);
  AddItemBagst(g_GemItem4);
  AddItemBagst(g_GemItem5);
  AddItemBagst(g_GemItem6);
  g_GemItem1.S.Name := '';
  g_GemItem1.MakeIndex :=0;
  g_GemItem2.S.Name := '';
  g_GemItem2.MakeIndex :=0;
  g_GemItem3.S.Name := '';
  g_GemItem3.MakeIndex :=0;
  g_GemItem4.S.Name := '';
  g_GemItem4.MakeIndex :=0;
  g_GemItem5.S.Name := '';
  g_GemItem5.MakeIndex :=0;
  g_GemItem6.S.Name := '';
  g_GemItem6.MakeIndex :=0;
end;

procedure TFrmDlg.DGemMakeCancelClick(Sender: TObject; X, Y: Integer);
var
i:integer;
begin
for i:= 1  to g_GemItem1.Amount do
  AddItemBagst(g_GemItem1);
for i:= 1  to g_GemItem2.Amount do
  AddItemBagst(g_GemItem2);
for i:= 1  to g_GemItem3.Amount do
  AddItemBagst(g_GemItem3);
for i:= 1  to g_GemItem4.Amount do
  AddItemBagst(g_GemItem4);
for i:= 1  to g_GemItem5.Amount do
  AddItemBagst(g_GemItem5);
for i:= 1  to g_GemItem6.Amount do
  AddItemBagst(g_GemItem6);
DGemMakeItem.Visible := False;
end;

procedure TFrmDlg.DGemSlot1Click(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   temp2: TClientItem;
   Amount:Integer;
   valstr:String;
begin
//g_GemItem1s := g_MovingItem.Item.MakeIndex;
   if not g_boItemMoving then begin
      if g_GemItem1.S.Name <> '' then begin
         ItemClickSound (g_GemItem1.S);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -99; //sell
         g_MovingItem.Item := g_GemItem1;
         g_GemItem1.S.Name := '';
         g_GemItem1.MakeIndex := 0;
      end;
  end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
    if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin
      ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DCountMessageDlg ('你需要增加多少个？', [mbYesToAll,mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem1.S.Name <> '' then begin
            temp:=g_GemItem1;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem1 := temp2;
            end else
              g_GemItem1 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell
            g_MovingItem.Item := temp

          end else begin
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem1 := temp2;
            end else
              g_GemItem1 := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;
        end;
      end;
   end;
end;

procedure TFrmDlg.DGemSlot1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   tempsize:integer;
begin
   if g_GemItem1.S.Name <> '' then begin
      d := g_WBagItemImages.Images[g_GemItem1.S.Looks];
      if d <> nil then
         with DGemSlot1 do begin
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2 - 1),
                           SurfaceY(Top + (Height - d.Height) div 2 + 1),
                           d.ClientRect,
                           d, TRUE);
           if g_GemItem1.Amount > 1 then begin
             SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
             tempsize:=dsurface.Canvas.Font.Size;
             dsurface.Canvas.Font.Size :=8;
             BoldTextOut (dsurface, SurfaceX(left + 18),
             SurfaceY(Top + 18), clYellow, clBlack, IntToStr(g_GemItem1.Amount));
             dsurface.Canvas.Font.Size:=tempsize;
             dsurface.Canvas.Release;
           end;
         end;
   end;

end;

procedure TFrmDlg.DGemSlot1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   g_MouseItem := g_GemItem1;
end;

{2}
procedure TFrmDlg.DGemSlot2Click(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   temp2: TClientItem;
   Amount:Integer;
   valstr:String;
begin
//g_GemItem2s := g_MovingItem.Item.MakeIndex;
   if not g_boItemMoving then begin
      if g_GemItem2.S.Name <> '' then begin
         ItemClickSound (g_GemItem2.S);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -99; //sell
         g_MovingItem.Item := g_GemItem2;
         g_GemItem2.S.Name := '';
         g_GemItem2.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin
         ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DCountMessageDlg ('你需要增加多少个？', [mbYesToAll,mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem2.S.Name <> '' then begin
            temp:=g_GemItem2;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem2 := temp2;
            end else
              g_GemItem2 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell
            g_MovingItem.Item := temp

          end else begin
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem2 := temp2;
            end else
              g_GemItem2 := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DGemSlot2DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   tempsize : integer;
begin
   if g_GemItem2.S.Name <> '' then begin
      d := g_WBagItemImages.Images[g_GemItem2.S.Looks];
      if d <> nil then
         with DGemSlot2 do begin
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2 - 1),
                           SurfaceY(Top + (Height - d.Height) div 2 + 1),
                           d.ClientRect,
                           d, TRUE);
           if g_GemItem2.Amount > 1 then begin
             SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
             tempsize:=dsurface.Canvas.Font.Size;
             dsurface.Canvas.Font.Size :=8;
             BoldTextOut (dsurface, SurfaceX(left + 18),
             SurfaceY(Top + 18), clYellow, clBlack, IntToStr(g_GemItem2.Amount));
             dsurface.Canvas.Font.Size:=tempsize;
             dsurface.Canvas.Release;
           end;
         end;
   end;

end;

procedure TFrmDlg.DGemSlot2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   g_MouseItem := g_GemItem2;
end;

{3}
procedure TFrmDlg.DGemSlot3Click(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   temp2: TClientItem;
   Amount:Integer;
   valstr:String;
begin
//g_GemItem3s := g_MovingItem.Item.MakeIndex;
   if not g_boItemMoving then begin
      if g_GemItem3.S.Name <> '' then begin
         ItemClickSound (g_GemItem3.S);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -99; //sell
         g_MovingItem.Item := g_GemItem3;
         g_GemItem3.S.Name := '';
         g_GemItem3.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin
         ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DCountMessageDlg ('你需要增加多少个？', [mbYesToAll,mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem3.S.Name <> '' then begin
            temp:=g_GemItem3;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem3 := temp2;
            end else
              g_GemItem3 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell
            g_MovingItem.Item := temp

          end else begin
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem3 := temp2;
            end else
              g_GemItem3 := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;

         end;
      end;
   end;
end;

procedure TFrmDlg.DGemSlot3DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   tempsize: integer;
begin
   if g_GemItem3.S.Name <> '' then begin
      d := g_WBagItemImages.Images[g_GemItem3.S.Looks];
      if d <> nil then
        with DGemSlot3 do begin
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2 - 1),
                           SurfaceY(Top + (Height - d.Height) div 2 + 1),
                           d.ClientRect,
                           d, TRUE);
           if g_GemItem3.Amount > 1 then begin
             SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
             tempsize:=dsurface.Canvas.Font.Size;
             dsurface.Canvas.Font.Size :=8;
             BoldTextOut (dsurface, SurfaceX(left + 18),
             SurfaceY(Top + 18), clYellow, clBlack, IntToStr(g_GemItem3.Amount));
             dsurface.Canvas.Font.Size:=tempsize;
             dsurface.Canvas.Release;
           end;
         end;
   end;

end;

procedure TFrmDlg.DGemSlot3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   g_MouseItem := g_GemItem3;
end;

{4}
procedure TFrmDlg.DGemSlot4Click(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   temp2: TClientItem;
   Amount:Integer;
   valstr:String;
begin
//g_GemItem4s := g_MovingItem.Item.MakeIndex;
   if not g_boItemMoving then begin
      if g_GemItem4.S.Name <> '' then begin
         ItemClickSound (g_GemItem4.S);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -99; //sell
         g_MovingItem.Item := g_GemItem4;
         g_GemItem4.S.Name := '';
         g_GemItem4.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin
         ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DCountMessageDlg ('你需要增加多少个？', [mbYesToAll,mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem4.S.Name <> '' then begin
            temp:=g_GemItem4;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem4 := temp2;
            end else
              g_GemItem4 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell
            g_MovingItem.Item := temp

          end else begin
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem4 := temp2;
            end else
              g_GemItem4 := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;

         end;
      end;
   end;
end;

procedure TFrmDlg.DGemSlot4DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   tempsize: integer;
begin
   if g_GemItem4.S.Name <> '' then begin
      d := g_WBagItemImages.Images[g_GemItem4.S.Looks];
      if d <> nil then
        with DGemSlot4 do begin
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2 - 1),
                           SurfaceY(Top + (Height - d.Height) div 2 + 1),
                           d.ClientRect,
                           d, TRUE);
           if g_GemItem4.Amount > 1 then begin
             SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
             tempsize:=dsurface.Canvas.Font.Size;
             dsurface.Canvas.Font.Size :=8;
             BoldTextOut (dsurface, SurfaceX(left + 18),
             SurfaceY(Top + 18), clYellow, clBlack, IntToStr(g_GemItem4.Amount));
             dsurface.Canvas.Font.Size:=tempsize;
             dsurface.Canvas.Release;
           end;
         end;
   end;

end;

procedure TFrmDlg.DGemSlot4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   g_MouseItem := g_GemItem4;
end;


{5}
procedure TFrmDlg.DGemSlot5Click(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   temp2: TClientItem;
   Amount:Integer;
   valstr:String;
begin
//g_GemItem5s := g_MovingItem.Item.MakeIndex;
   if not g_boItemMoving then begin
      if g_GemItem5.S.Name <> '' then begin
         ItemClickSound (g_GemItem5.S);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -99; //sell
         g_MovingItem.Item := g_GemItem5;
         g_GemItem5.S.Name := '';
         g_GemItem5.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin
         ItemClickSound (g_MovingItem.Item.S);
       if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DCountMessageDlg ('你需要增加多少个？', [mbYesToAll,mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem5.S.Name <> '' then begin
            temp:=g_GemItem5;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem5 := temp2;
            end else
              g_GemItem5 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell
            g_MovingItem.Item := temp

          end else begin
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem5 := temp2;
            end else
              g_GemItem5 := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;

         end;
      end;
   end;
end;

procedure TFrmDlg.DGemSlot5DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   tempsize: integer;
begin
   if g_GemItem5.S.Name <> '' then begin
      d := g_WBagItemImages.Images[g_GemItem5.S.Looks];
      if d <> nil then
        with DGemSlot5 do begin
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2 - 1),
                           SurfaceY(Top + (Height - d.Height) div 2 + 1),
                           d.ClientRect,
                           d, TRUE);
           if g_GemItem5.Amount > 1 then begin
             SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
             tempsize:=dsurface.Canvas.Font.Size;
             dsurface.Canvas.Font.Size :=8;
             BoldTextOut (dsurface, SurfaceX(left + 18),
             SurfaceY(Top + 18), clYellow, clBlack, IntToStr(g_GemItem5.Amount));
             dsurface.Canvas.Font.Size:=tempsize;
             dsurface.Canvas.Release;
           end;
         end;
   end;

end;

procedure TFrmDlg.DGemSlot5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   g_MouseItem := g_GemItem5;
end;



{6}
procedure TFrmDlg.DGemSlot6Click(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   temp2: TClientItem;
   Amount:Integer;
   valstr:String;
begin
//g_GemItem6s := g_MovingItem.Item.MakeIndex;
   if not g_boItemMoving then begin
      if g_GemItem6.S.Name <> '' then begin
         ItemClickSound (g_GemItem6.S);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -99; //sell
         g_MovingItem.Item := g_GemItem6;
         g_GemItem6.S.Name := '';
         g_GemItem6.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin
         ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DCountMessageDlg ('你需要增加多少个？', [mbYesToAll,mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem6.S.Name <> '' then begin
            temp:=g_GemItem6;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem6 := temp2;
            end else
              g_GemItem6 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell
            g_MovingItem.Item := temp

          end else begin
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem6 := temp2;
            end else
              g_GemItem6 := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
          end;

         end;
      end;
   end;
end;

procedure TFrmDlg.DGemSlot6DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   tempsize: integer;
begin
   if g_GemItem6.S.Name <> '' then begin
      d := g_WBagItemImages.Images[g_GemItem6.S.Looks];
      if d <> nil then
        with DGemSlot6 do begin
            dsurface.Draw (SurfaceX(Left + (Width - d.Width) div 2 - 1),
                           SurfaceY(Top + (Height - d.Height) div 2 + 1),
                           d.ClientRect,
                           d, TRUE);
           if g_GemItem6.Amount > 1 then begin
             SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
             tempsize:=dsurface.Canvas.Font.Size;
             dsurface.Canvas.Font.Size :=8;
             BoldTextOut (dsurface, SurfaceX(left + 18),
             SurfaceY(Top + 18), clYellow, clBlack, IntToStr(g_GemItem6.Amount));
             dsurface.Canvas.Font.Size:=tempsize;
             dsurface.Canvas.Release;
           end;
         end;
   end;

end;

procedure TFrmDlg.DGemSlot6MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   g_MouseItem := g_GemItem6;
end;

procedure TFrmDlg.DGemMakeOKClick(Sender: TObject; X, Y: Integer);
var
  GemSystem:TGemSystem;
  sData:string;
begin
 GemSystem.Gem   := sMakeGemName;
  GemSystem.Item1 := g_GemItem1.MakeIndex;
  GemSystem.Item2 := g_GemItem2.MakeIndex;
  GemSystem.Item3 := g_GemItem3.MakeIndex;
  GemSystem.Item4 := g_GemItem4.MakeIndex;
  GemSystem.Item5 := g_GemItem5.MakeIndex;
  GemSystem.Item6 := g_GemItem6.MakeIndex;

  SData:=GemSystem.Gem + '/' + IntToStr(GemSystem.Item1) + '/' + inttostr(GemSystem.Item2) + '/' + inttostr(GemSystem.Item3) + '/' + inttostr(GemSystem.Item4) + '/' + inttostr(GemSystem.Item5) + '/' + inttostr(GemSystem.Item6) + '/' + inttostr(g_GemItem1.Amount) + '/' + inttostr(g_GemItem2.Amount) + '/' + inttostr(g_GemItem3.Amount) + '/' + inttostr(g_GemItem4.Amount) + '/' + inttostr(g_GemItem5.Amount) + '/' + inttostr(g_GemItem6.Amount);
  SendClientMessage(CM_GEMSYSTEM, 0, 0, 0, 0, sData);
  DGemMakeItem.Visible := False;
end;

procedure TFrmDlg.DFrdFriendClick(Sender: TObject; X, Y: Integer);
begin
  FriendPage := 1;
  FriendScreen := F_GOOD;
  FriendIndex[F_GOOD] := -1;
  FriendIndex[F_BAD] := -1;
  DFrdFriend.SetImgIndex(g_WMainImages, 540);
  DFrdBlackList.SetImgIndex(g_WMainImages, 574);
end;

procedure TFrmDlg.DFrdBlackListClick(Sender: TObject; X, Y: Integer);
begin
  FriendPage := 1;
  FriendScreen := F_BAD;
  FriendIndex[F_GOOD] := -1;
  FriendIndex[F_BAD] := -1;
  DFrdFriend.SetImgIndex(g_WMainImages, 541);
  DFrdBlackList.SetImgIndex(g_WMainImages, 573);
end;

procedure TFrmDlg.DFrdAddClick(Sender: TObject; X, Y: Integer);
var
  sFriendAdd:String;
begin
  FrmDlg.DlgEditText := '';
  if FriendScreen = 0 then begin
    //好友
    FrmDlg.DMessageDlg ('请输入您想增加为您的朋友名单玩家的名字。', [mbOk, mbAbort]);
    sFriendAdd := Trim (FrmDlg.DlgEditText);

    if sFriendAdd = g_MySelf.m_sUserName then begin
      FrmDlg.DMessageDlg ('您不能增加自己到您的朋友名单。', [mbOk]);
      exit;
    end;

    if sFriendAdd <> '' then begin
      SendClientMessage(CM_ADDFRIEND, 0, 0, 0, 0, sFriendAdd);
    end;
    exit;
  end;

  //黑名单
  FrmDlg.DMessageDlg ('请输入您想增加为您的黑名单玩家的名字。', [mbOk, mbAbort]);
  sFriendAdd := Trim (FrmDlg.DlgEditText);

  if sFriendAdd = g_MySelf.m_sUserName then begin
    FrmDlg.DMessageDlg ('您不能增加自己到您的黑名单。', [mbOk]);
    exit;
  end;

  if sFriendAdd <> '' then begin
    SendClientMessage(CM_ADDBADFRIEND, 0, 0, 0, 0, sFriendAdd);
  end;
end;

procedure TFrmDlg.GetPageInfo(pList: Pointer; var PageNumber: Integer; var PageTotal: Integer; var PageRef: Integer);
var
  PageExtended: Extended;
  List: ^TList;
begin
  List := pList;
  if List.Count > 0 then begin
    PageExtended := (List.Count/10);
    PageTotal := Trunc(PageExtended);
    if Frac(PageExtended) > 0 then inc(PageTotal);
  end
  else PageTotal := 1;

  if PageNumber < 1 then PageNumber := 1
  else if PageNumber > PageTotal then PageNumber := PageTotal;

  PageRef := (PageNumber-1)*10;
end;

function TFrmDlg.FindFriend(Select: Boolean = False): PTClientFriends;
var
  List: ^TList;
  P: TPoint;
  I,MaxY: Integer;
begin
  if MaxLineHeight = 0 then MaxLineHeight := FrmMain.DXDraw.Surface.Canvas.TextHeight('dp');
  GetCursorPos(P);
  List := @FriendList[FriendScreen];
  P.X := P.X - DFriendDlg.Left;
  P.Y := P.Y - DFriendDlg.Top;

  // Reusing Var, MaxY = PageTotal | I = PageRef;
  GetPageInfo(List,FriendPage,MaxY,I);

  MaxY := 86+(MaxLineHeight*10);
  if (P.X > 28) and (P.X < 264) and (P.Y > 86) and (P.Y < MaxY) then begin
    // Inside Range of allowedness!
    I := I+((P.Y-86) div MaxLineHeight);
    if (I >= 0) and (I < List.Count) then begin
      if Select then FriendIndex[FriendScreen] := I;
      Result := PTClientFriends(List.Items[I]);
    end
    else Result := nil;
  end
  else Result := nil;
end;

procedure TFrmDlg.DFriendDlgDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  List: ^TList;
  PageRef,PageTotal: Integer;
  Me: TDWindow;
  I: Integer;
  d: TDirectDrawSurface;
  Friend: PTClientFriends;
Begin
  if g_MySelf = nil then exit;
  if MaxLineHeight = 0 then MaxLineHeight := FrmMain.DXDraw.Surface.Canvas.TextHeight('dp');
  Me := TDWindow(Sender);
  List := @FriendList[FriendScreen];

  GetPageInfo(List,FriendPage,PageTotal,PageRef);

  with dsurface.Canvas do begin
    with DFriendDlg do begin
      d := DFriendDlg.WLib.Images[FaceIndex];
      if d <> nil then dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
    SetBkMode (Handle, TRANSPARENT);

    Font.Color := clWhite;
    TextOut(Me.Left+68, Me.Top+36, g_MySelf.m_sUserName);
    TextOut(Me.Left+43, Me.Top+260, inttostr(FriendPage)+'/'+inttostr(PageTotal));

    // Draw List
    for I := PageRef to PageRef+9 do begin
      if I >= List.Count then break;
      Friend := PTClientFriends(List.Items[I]);
      if I = FriendIndex[FriendScreen] then begin
        Font.Color := clBlack;
        Brush.Color := clSilver;
      end
      else begin
        if Friend.Status = 0{Offline} then Font.Color := clSilver;
        if Friend.Status = 1{Online} then Font.Color := clLime;
        Brush.Color := clBlack;
      end;
      // 146 Is the middle of the text area. ((264-28)/2)+28 = 146
      // 86 is where the Text Starts X wise
      TextOut ((146+Me.Left)-(TextWidth(Friend.Name) div 2), Me.Top+86+(MaxLineHeight*(I-PageRef)), Friend.Name);
    end;

    release;
  end;
end;

procedure TFrmDlg.DFriendDlgClick(Sender: TObject; X, Y: Integer);
begin
  FindFriend(True);
end;

procedure TFrmDlg.DFrdDelClick(Sender: TObject; X, Y: Integer);
var
  F: PTClientFriends;
  sListName: String;
begin
  if FriendScreen = 0 then sListName := '朋友名单'
  else sListName := '黑名单';

  if FriendList[FriendScreen].Count <= 0 then begin
    FrmDlg.DMessageDlg ('你的'+sListName+'中没有你删除的玩家名字。', [mbOk]);
    exit;
  end;
  if FriendIndex[FriendScreen] < 0 then begin
    FrmDlg.DMessageDlg ('请选择一个玩家从你的'+sListName+'删除。', [mbOk]);
    exit;
  end;
  F := PTClientFriends (FriendList[FriendScreen].Items[FriendIndex[FriendScreen]]);
  if mrYes = FrmDlg.DMessageDlg ('你需要把"' + F.Name + '"从你的'+sListName+'删除吗？', [mbYes, mbNo]) then begin
    SendClientMessage(CM_DELFRIEND, 0, 0, 0, 0, F.Name);
  end;
end;

procedure TFrmDlg.DFriendDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sStatus,sMsg: String;
  F: PTClientFriends;
begin
  DScreen.ClearHint;
  Butt:=TDButton(Sender);

  if Sender = DFrdAdd then sMsg := '增加'
  else if Sender = DFrdDel then sMsg := '删除'
  else if Sender = DFrdMemo then sMsg := '备忘录'
  else if Sender = DFrdMail then sMsg := '邮件'
  else if Sender = DFrdWhisper then sMsg := '私聊'
  else begin
    F := FindFriend;
    if F <> nil then begin
      //sMsg := FindFriend.Name;
      if F.Status = 0 then sStatus := '离线' else sStatus := '在线';

      sMsg := F.Memo;
      // Convert Slashes
      sMsg := StringReplace(sMsg, '\', '/', [rfReplaceAll]);
      // Convert New Lines
      sMsg := StringReplace(sMsg, #13#10, '\', [rfReplaceAll]);

      DScreen.ShowHint((X + 10), (Y + 10), '玩家: ' + F.Name + '\' + '状态: ' + sStatus + '\' + '备忘录: ' + sMsg, clWhite, FALSE);
      exit;
    end;
  end;

  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DFriendDlg.SurfaceX(DFriendDlg.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DFriendDlg.SurfaceY(DFriendDlg.Top) + nLocalY;
  DScreen.ShowHint(nHintX, nHintY, sMsg, clYellow, TRUE);
end;

procedure TFrmDlg.DFrdMemoClick(Sender: TObject; X, Y: Integer);
var
  F: PTClientFriends;
  sAction,sMessage,sListName: String;
  Button: TDButton;
begin
  DScreen.ClearHint;
  Button := TDButton(Sender);
  if DMemo.Visible and (Button = DFrdMemo) then begin
    DMemo.Visible := FALSE;
    EdMemo.Visible := FALSE;
    DMemoName.Visible := FALSE;
    exit;  
  end
  else if DMailDlg.Visible and ((Button = DFrdMail) or (Button = DMLReply)) then begin
    DMailDlg.Visible := FALSE;
    EdMail.Visible := FALSE;
    DMailDlg.Visible := FALSE;
    exit;
  end
  else if DMailRead.Visible and (Button = DMLRead) then begin
    DMailRead.Visible := FALSE;
    EdMailRead.Visible := FALSE;
    DMailRead.Visible := FALSE;
    exit;
  end;

  if Button = DFrdMemo then sAction := '增加一个备忘录'
  else if Button = DFrdMail then sAction := '发送邮件'
  else if Button = DFrdWhisper then sAction := '发送个人消息';

  if (Button = DFrdMemo) or (Button = DFrdMail) or (Button = DFrdWhisper) then begin
    if FriendScreen = 0 then sListName := '朋友名单'
    else sListName := '黑名单';

    if FriendList[FriendScreen].Count <= 0 then begin
      FrmDlg.DMessageDlg ('You have no players on your '+sListName+' '+sAction+'.', [mbOk]);
      exit;
    end;
    if FriendIndex[FriendScreen] < 0 then begin
      FrmDlg.DMessageDlg ('请选择你的'+sListName+''+sAction+'.', [mbOk]);
      exit;
    end;
    F := PTClientFriends (FriendList[FriendScreen].Items[FriendIndex[FriendScreen]]);
  end;

  if Button = DFrdMemo then begin
    EdMemo.Width := 176;
    EdMemo.Height := 72;

    EdMemo.text := F.Memo;
    EdMemo.Visible := True;
    DMemoName.Visible := True;
//    DMemo.iMisc[0] := FriendIndex[FriendScreen];
//    DMemo.iMisc[1] := FriendScreen;
    DMemo.sMisc := F.Name;
    DMemo.Show;
    FrmDlg.EdMemo.SetFocus;
    SetDFocus (FrmDlg.DMemo);
  end
  else if (Button = DFrdMail) or (Button = DMLReply) then begin
    EdMail.Width := 176;
    EdMail.Height := 72;

    if (Button = DFrdMail) then begin
      EdMail.text := F.Memo;
      DMailDlg.sMisc := F.Name;
    end
    else begin
      EdMail.text := '';
      DMailDlg.sMisc := '';
    end;

    EdMail.Visible := True;
    DMailName.Visible := True;
    DMailDlg.Show;
    FrmDlg.EdMail.SetFocus;
    SetDFocus(FrmDlg.DMailDlg);
  end
  else if (Button = DMLRead) then begin
    if MaxLineHeight = 0 then MaxLineHeight := FrmMain.DXDraw.Surface.Canvas.TextHeight('dp');
    EdMailRead.Width := 176;
    EdMailRead.Height := 72-MaxLineHeight-2;

    EdMailRead.text := '';
    DMailRead.sMisc := '';

    EdMailRead.Visible := True;
    DMailReadName.Visible := True;
    DMailRead.Show;
    FrmDlg.EdMailRead.SetFocus;
    SetDFocus(FrmDlg.DMailRead);
  end
  else if Button = DFrdWhisper then begin
//    FrmDlg.DlgEditText := '';
//    FrmDlg.DMessageDlg ('Please enter the contents of the Personal Message.', [mbOk, mbAbort]);
//    sMessage := Trim(FrmDlg
  //  PlayScene.EdChat.Visible := TRUE;
//    PlayScene.EdChat.SetFocus;
//    SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
//    PlayScene.EdChat.Text := '/' + Friend.Name + ' ';
//    PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
  //  PlayScene.EdChat.SelLength := 0;
     PlayScene.EdChat.Visible := TRUE;
     PlayScene.EdChat.SetFocus;
     SetImeMode (PlayScene.EdChat.Handle, LocalLanguage);
     PlayScene.EdChat.Text := '/' + F.Name + ' ';
     PlayScene.EdChat.SelStart := Length(PlayScene.EdChat.Text);
     PlayScene.EdChat.SelLength := 0;
  end;
end;

procedure TFrmDlg.DMemoPostDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  Friend: PTClientFriends;
begin
//  Friend := PTClientFriends(FriendList[DMemo.iMisc[1]].Items[DMemo.iMisc[0]]);
  Friend := FindFriendObject(DMemo.sMisc);
  if Friend = nil then begin
    // Friend No longer exists, we cant make a memo for them, so close the window
    DMemoCloseClicK(NIL,0,0);
    exit;
  end;
  with dsurface.Canvas do begin
    SetBkMode (Handle, TRANSPARENT);
    Font.Color := clWhite;
    TextOut ((DMemo.Left+152)-(TextWidth(Friend.Name) div 2),  (36)+DMemo.TOP, Friend.Name);
    release;
  end;
  EdMemo.Left := 27+DMemo.Left;
  EdMemo.Top  := 61+DMemo.Top;
end;

procedure TFrmDlg.DMemoB1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if not TDButton(Sender).Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end else begin
         d := WLib.Images[FaceIndex + 1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DMemoB2DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if not TDButton(Sender).Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end else begin
         d := WLib.Images[FaceIndex + 1];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DMemoB1Click(Sender: TObject; X, Y: Integer);
var
  Friend: PTClientFriends;
begin
//  Friend := PTClientFriends(FriendList[DMemo.iMisc[1]].Items[DMemo.iMisc[0]]);
  Friend := FindFriendObject(DMemo.sMisc);
  Friend.Memo := EdMemo.Text;

  //Send Memo to Server
  SendClientMessage(CM_UPDATEMEMOFRIEND, 0, 0, 0, 0, Friend.Name + #1 + Friend.Memo);

  DMemoCloseClick(nil,0,0);
end;

procedure TFrmDlg.ToggleGTListWindow();
begin
  DGTList.Visible:=not DGTList.Visible;
end;

procedure TFrmDlg.ToggleDecoListWindow();
begin
  DDecoListDlg.Visible:=not DDecoListDlg.Visible;
end;

procedure TFrmDlg.ToggleBBSListWindow();
begin
  CloseMDlg;
  DBBSListDlg.Visible:=not DBBSListDlg.Visible;
end;

procedure TFrmDlg.ToggleBBSMsgWindow();
begin
  if DBBSMsgDlg.Visible = False then begin
    DBBSMSGReply.Visible := False;
    DBBSMSGMail.Visible := False;
    DBBSMSGDELETE.Visible := False;
    if g_BBSMSG <> '' then begin
      DBBSMSGReply.Visible:=True;
      DBBSMSGMail.Visible := True;
      if GuildCommanderMode then
        DBBSMSGDelete.Visible := True;
    end else begin
      BBSMemo.Text := '';
      BBSMemo.Width := 294;
      BBSMemo.Height := 143;
      BBSMemo.MaxLength := 240;
      BBSMemo.Visible := True;
      FrmDlg.BBSMemo.SetFocus;
      SetDFocus(FrmDlg.DBBSMsgDlg);
    end;
  end else
    BBSMemo.visible := False;
  DBBSMsgDlg.Visible:=not DBBSMsgDlg.Visible;
end;


procedure TFrmDlg.DSalesDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);

const
  sItem = '物品';
  sSeller = '卖家';
  sCost = '价格';
  sYours = '您的寄售';
  sAllSales = '物品寄售';
  sStatus = '状态';

var
  d,e:TDirectDrawSurface;
  lx,ly,i: integer;
  pagenumstring: string;

  iname, d1, d2, d3: string;
  useable: boolean;

  Cost: String;

begin
   DSales.Left := 0;
   DSales.Top := 60;
  with Sender as TDWindow do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      lx := 37;
      ly := 93+AuctionMenuIndex * 19;
       if AuctionMenuIndex > -1 then begin
          e := g_WMainImages.Images[704];
          if e <> nil then
             dsurface.Draw (SurfaceX(DSales.Left+lx), SurfaceX(DSales.Top+ly), e.ClientRect, e, TRUE);
       end;

    SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
    with dsurface.Canvas do begin
      Font.Color := clWhite;
      pagenumstring := inttostr(g_AuctionCurrPage) +' / ' +inttostr(g_AuctionAmountofPages);

      if g_AuctionCurrSection = 17 then begin
        TextOut (DSales.Left+240-(TextWidth(sYours)div 2),36+DSales.Top, sYours);
        TextOut (DSales.Left+412-(TextWidth(sStatus)div 2), 69+DSales.Top, sStatus);
      end
      else begin
        TextOut (DSales.Left+240-(TextWidth(sAllSales)div 2),36+DSales.Top, sAllSales);
        TextOut (DSales.Left+412-(TextWidth(sSeller)div 2), 69+DSales.Top, sSeller);
      end;

      TextOut (DSales.Left+411-(TextWidth(pagenumstring)div 2),36+DSales.Top,pagenumstring);

      TextOut (DSales.Left+100-(TextWidth(sItem)div 2), 69+DSales.Top, sItem);
      TextOut (DSales.Left+256-(TextWidth(sCost)div 2), 69+DSales.Top, sCost);

      for i:= 0 to 9 do begin

        if g_AuctionItems[i].StartTime = 0 then break;

        if i = AuctionMenuIndex then begin
          //Font.Color := clRed;
        end else
          if g_AuctionItems[i].Seller = g_MySelf.m_sUserName then
            Font.Color := clLime
          else
            Font.Color := g_AuctionItems[i].Item.S.Color;

        // line by line
        TextOut (DSales.Left+101-(TextWidth(g_AuctionItems[i].Item.S.Name)div 2), 95+(19*i)+DSales.Top, g_AuctionItems[i].Item.S.Name);

        Cost := GetGoldStr(g_AuctionItems[i].Cost);
        TextOut (DSales.Left+256-(TextWidth(Cost)div 2), 95+(19*i)+DSales.Top, Cost);

        TextOut (DSales.Left+412-(TextWidth(g_AuctionItems[i].Seller)div 2), 95+(19*i)+DSales.Top, g_AuctionItems[i].Seller);

        // when clicked
        if i = AuctionMenuIndex then begin
          Font.Color := clWhite;

          // Time Left
          TextOut (DSales.Left+47, 302+DSales.Top, '寄售: ' +DateTimeToStr(g_AuctionItems[i].StartTime));
          TextOut (DSales.Left+47, 318+DSales.Top, '到期: ' +DateTimeToStr(g_AuctionItems[i].EndTime));

          GetMouseItemInfo (iname, d1, d2, d3, useable);

            Font.Color := clYellow;
            TextOut (Dsales.Left+288, Dsales.Top+296, iname);
            Font.Color := clWhite;
            TextOut (Dsales.Left+288 + textwidth(iname), Dsales.Top+296, d1);
            TextOut (Dsales.Left+288, Dsales.Top+296+14, d2);
            if not useable then
               Font.Color := clRed;
            TextOut (Dsales.Left+288, Dsales.Top+296+(14*2), d3);

          DAuctionImg.SetImgIndex(g_WBagItemImages,g_AuctionItems[i].Item.S.Looks);
        end;
      end;
    end;
    dsurface.Canvas.Release;
  end;
end;

procedure TFrmDlg.ToggleAuctionWindow;
begin
  if DSales.Visible = FALSE then begin
    if DItemBag.Visible = false then
      OpenItemBag();//only open bag if we also opening sales window
  end;
  DSales.Visible := not DSales.Visible;

  if DSales.Visible = true then begin
    EdSalesEdit.Visible := true;
    EdSalesEdit.Text := '';
    SetDFocus(FrmDlg.DSales);
  end else begin
    EdSalesEdit.Visible := false;
  end;
end;

procedure TFrmDlg.DSalesFindClick(Sender: TObject; X, Y: Integer);
begin

  if (EdSalesEdit.Text <> '') and (length(EdSalesEdit.Text) < 3) then begin
    DMessageDlg ('查找至少需要3个字符。', [mbOk]);
  end else begin
    SendClientMessage(CM_GETAUCTION, g_MySelf.m_nRecogId, g_AuctionCurrSection, 1, 0, EdSalesEdit.Text);
  end;
  
end;

procedure TFrmDlg.ClearAuctionDlg;

var
 i: integer;

begin

  for i:=0 to 9 do g_AuctionItems[i].StartTime := 0;
  DScreen.ClearHint;
  DAuctionImg.FaceIndex := -1;
  AuctionMenuIndex := -1;

end;

procedure TFrmDlg.DSalesCancelClick(Sender: TObject; X, Y: Integer);
begin

  ToggleAuctionWindow;
  
end;

procedure TFrmDlg.DSalesBuyClick(Sender: TObject; X, Y: Integer);
begin

  if g_AuctionItems[AuctionMenuIndex].StartTime = 0 then exit;

  if g_AuctionCurrSection = 17 then begin

    if g_AuctionItems[AuctionMenuIndex].Seller = '未出售' then begin

      if mrYes = FrmDlg.DMessageDlg ('你的 "' +g_AuctionItems[AuctionMenuIndex].Item.S.Name +'" 未出售\'
                                    +'您是否想要取回您的物品？', [mbYes, mbNo, mbCancel]) then
        SendClientMessage (CM_GETGOLDITEM, g_MySelf.m_nRecogId, LoWord(g_AuctionItems[AuctionMenuIndex].AuctionID), HiWord(g_AuctionItems[AuctionMenuIndex].AuctionID), 0);

      exit;
    end;

    if g_AuctionItems[AuctionMenuIndex].Seller = '过期' then begin

      if mrYes = FrmDlg.DMessageDlg ('你的 "' +g_AuctionItems[AuctionMenuIndex].Item.S.Name +'" 已过期.\'
                                    +'您是否想要取回您的物品？', [mbYes, mbNo, mbCancel]) then
        SendClientMessage (CM_GETGOLDITEM, g_MySelf.m_nRecogId, LoWord(g_AuctionItems[AuctionMenuIndex].AuctionID), HiWord(g_AuctionItems[AuctionMenuIndex].AuctionID), 0);

      exit;
    end;

    if g_AuctionItems[AuctionMenuIndex].Seller = '已出售' then begin

      if mrYes = FrmDlg.DMessageDlg ('你的 "' +g_AuctionItems[AuctionMenuIndex].Item.S.Name +'" 已出售!\'
                                    +'您需要收取金币吗?', [mbYes, mbNo, mbCancel]) then
        SendClientMessage (CM_GETGOLDITEM, g_MySelf.m_nRecogId, LoWord(g_AuctionItems[AuctionMenuIndex].AuctionID), HiWord(g_AuctionItems[AuctionMenuIndex].AuctionID), 0);

      exit;
    end;

  end;

  if g_AuctionItems[AuctionMenuIndex].Seller = g_MySelf.m_sUserName then begin
    DMessageDlg ('您不能购买您自己的物品', [mbOk]);
    exit;
  end;

  if g_MySelf.m_nGold < g_AuctionItems[AuctionMenuIndex].Cost then begin
    DMessageDlg ('你没有' +GetGoldStr(g_AuctionItems[AuctionMenuIndex].Cost) +' 金币。', [mbOk]);
    exit;
  end;

  if mrYes = FrmDlg.DMessageDlg ('你购买的: "' +g_AuctionItems[AuctionMenuIndex].Item.S.Name +'" 需要 '
                                  +GetGoldStr(g_AuctionItems[AuctionMenuIndex].Cost) +' 金币，你需要购买吗？', [mbYes, mbNo, mbCancel]) then
    SendClientMessage (CM_BUYAUCTIONITEM, g_MySelf.m_nRecogId, LoWord(g_AuctionItems[AuctionMenuIndex].AuctionID),
                                HiWord(g_AuctionItems[AuctionMenuIndex].AuctionID), 0);

end;

procedure TFrmDlg.DSalesClick(Sender: TObject; X, Y: Integer);
begin

  if (((X<(36+DSales.Left)) OR (X>(477+Dsales.Left))) OR
     ((Y<(92+DSales.Top)) OR (Y>(282+DSales.Top)))) then exit;

  AuctionMenuIndex := (Y-(92+DSales.Top)) div 19;

  if g_AuctionItems[AuctionMenuIndex].StartTime <> 0 then begin
    PlaySound (s_glass_button_click);
    g_MouseItem := g_AuctionItems[AuctionMenuIndex].Item;
    //SHOW ITEM STATS
  end else begin
    DScreen.ClearHint;
    DAuctionImg.FaceIndex := -1;
  end;

end;

procedure TFrmDlg.DSalesNextPageClick(Sender: TObject; X, Y: Integer);
begin

  if (g_AuctionCurrPage = g_AuctionAmountofPages) or (g_AuctionCurrSection = 0) then exit;

  if EdSalesEdit.Text <> '' then
    if length(EdSalesEdit.Text) < 3 then begin
      DMessageDlg ('查找至少需要3个字符。', [mbOk]);
      exit;
    end;

  SendClientMessage(CM_GETAUCTION, g_MySelf.m_nRecogId, g_AuctionCurrSection, (g_AuctionCurrPage+1), 0, EdSalesEdit.Text);

end;

procedure TFrmDlg.DSalesRefreshClick(Sender: TObject; X, Y: Integer);
begin

  if g_AuctionCurrSection = 0 then exit;
  
  if EdSalesEdit.Text <> '' then
    if length(EdSalesEdit.Text) < 3 then begin
      DMessageDlg ('查找至少需要3个字符。', [mbOk]);
      exit;
    end;

  SendClientMessage(CM_GETAUCTION, g_MySelf.m_nRecogId, g_AuctionCurrSection, g_AuctionCurrPage, 0, EdSalesEdit.Text);

end;

procedure TFrmDlg.DSalesPrevPageClick(Sender: TObject; X, Y: Integer);
begin

  if (g_AuctionCurrPage = 1) or (g_AuctionCurrSection = 0) then exit;

  if EdSalesEdit.Text <> '' then
    if length(EdSalesEdit.Text) < 3 then begin
      DMessageDlg ('查找至少需要3个字符。', [mbOk]);
      exit;
    end;

  SendClientMessage(CM_GETAUCTION, g_MySelf.m_nRecogId, g_AuctionCurrSection, (g_AuctionCurrPage-1), 0, EdSalesEdit.Text);
  
end;

procedure TFrmDlg.DSalesCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if d.Downed then begin
         dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DSalesCloseClick(Sender: TObject; X, Y: Integer);
begin
  ToggleAuctionWindow;
end;

procedure TFrmDlg.DSalesCancelDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if not d.Downed then begin
         dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end else begin
         dd := d.WLib.Images[d.FaceIndex+1];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DBotMemoClick(Sender: TObject; X, Y: Integer);
begin
  OpenMailDlg;
end;

procedure TFrmDlg.OpenMailDlg;
begin
  DMailListDlg.Visible := not DMailListDlg.Visible;
  MailPage := 1;
end;

procedure TFrmDlg.OpenBlockListDlg;
begin
  DBlockListDlg.Visible := not DBlockListDlg.Visible;
  BlockPage := 1;
end;

procedure TFrmDlg.DMailDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  DFrdMemoClick(TObject(DFrdMail),X,Y);
end;

procedure TFrmDlg.DMailDlgPostDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
//var
//  Friend: PTClientFriends;
begin
//  Friend := PTClientFriends(FriendList[DMailDlg.iMisc[1]].Items[DMailDlg.iMisc[0]]);
//  Friend := FindFriendObject(DMailDlg.sMisc);
  with dsurface.Canvas do begin
    SetBkMode (Handle, TRANSPARENT);
    Font.Color := clWhite;
    TextOut ((DMailDlg.Left+152)-(TextWidth(DMailDlg.sMisc) div 2),  (36)+DMailDlg.TOP, DMailDlg.sMisc);
    release;
  end;
  EdMail.Left := 27+DMailDlg.Left;
  EdMail.Top  := 61+DMailDlg.Top;
end;

procedure TFrmDlg.DMailReadPostDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
begin
  if MaxLineHeight = 0 then MaxLineHeight := FrmMain.DXDraw.Surface.Canvas.TextHeight('dp');
  with dsurface.Canvas do begin
    SetBkMode (Handle, TRANSPARENT);
    Font.Color := clWhite;
    TextOut ((DMailRead.Left+152)-(TextWidth(DMailRead.sMisc) div 2),  (36)+DMailRead.TOP, DMailRead.sMisc);
    Brush.Color := clGray;
    Font.Size := Font.Size-1;
    TextOut (30+DMailRead.Left, 62+DMailRead.Top, DMailRead.sMisc2);
    Font.Size := Font.Size+1;    
    Brush.Color := clBlack;    
    release;
  end;
  EdMailRead.Left := 27+DMailRead.Left;
  EdMailRead.Top  := 61+DMailRead.Top+MaxLineHeight+2;
end;

procedure TFrmDlg.DMailListDlgMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg: String;
begin
  DScreen.ClearHint;
  Butt:=TDButton(Sender);

  if Sender = DMLReply then sMsg := '回复'
  else if Sender = DMLRead then sMsg := '阅读'
  else if Sender = DMLLock then sMsg := '保护'
  else if Sender = DMLDel then sMsg := '删除'
  else if Sender = DMLBlock then sMsg := '加入屏蔽列表'
  else if Sender = DMailListStatus then begin
    if g_boHasMail then sMsg := '新邮件'
    else sMsg := '没有新邮件';
  end;

  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DMailListDlg.SurfaceX(DMailListDlg.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DMailListDlg.SurfaceY(DMailListDlg.Top) + nLocalY;
  DScreen.ShowHint(nHintX, nHintY, sMsg, clYellow, TRUE);
end;

procedure TFrmDlg.DMailListDlgPostDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  if g_Myself = nil then exit;
  with dsurface.Canvas do begin
    SetBkMode (Handle, TRANSPARENT);
    Font.Color := clWhite;
    TextOut (68+DMailListDLG.Left, 36+DMailListDLG.TOP, g_MySelf.m_sUserName);
    release;
  end;
end;

procedure TFrmDlg.DBlockListDlgPostDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  if g_Myself = nil then exit;
  with dsurface.Canvas do begin
    SetBkMode (Handle, TRANSPARENT);
    Font.Color := clWhite;
    TextOut (68+DBlockListDLG.Left, 36+DBlockListDLG.TOP, g_MySelf.m_sUserName);
    release;
  end;
end;

procedure TFrmDlg.DRepairItemClick(Sender: TObject; X, Y: Integer);
begin
  frmMain.CmdShowHumanMsg('','','','','');
end;

procedure TFrmDlg.DBeltSwapClick(Sender: TObject; X, Y: Integer);
begin
  g_boVerticalBelt := Not g_boVerticalBelt;
  DoBeltSetup();
end;

procedure TFrmDlg.DBeltCloseClick(Sender: TObject; X, Y: Integer);
begin
  DBeltWindow.Visible := not DBeltWindow.Visible;
end;

procedure TFrmDlg.DBotLoverClick(Sender: TObject; X, Y: Integer);
begin
 if DLoverWindow.Visible then begin
  DLoverWindow.Visible := False;
  end else begin
   if g_LoverNameClient <> '' then begin
   SendClientMessage(CM_OPENLOVERWINDOW, 0, 0, 0, 0);
   end else begin
   DLoverWindow.Visible := True;
   end;
 end;
end;

procedure TFrmDlg.DBeltWindowMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg: String;
begin
  DScreen.ClearHint;
  Butt:=TDButton(Sender);

  if Sender = DBeltSwap then sMsg := '腰带转换(Ctrl-Z)'
  else if Sender = DBeltClose then sMsg := '腰带(Z)';

  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DBeltWindow.SurfaceX(DBeltWindow.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DBeltWindow.SurfaceY(DBeltWindow.Top) + nLocalY;
  DScreen.ShowHint(nHintX, nHintY, sMsg, clYellow, TRUE);
end;

procedure TFrmDlg.DGroupDlgMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg: String;
begin
  DScreen.ClearHint;
  Butt:=TDButton(Sender);

  if Sender = DGrpAllowGroup then begin
    if g_boAllowGroup then sMsg := '开启'
    else sMsg := '关闭';
  end;

  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DGroupDlg.SurfaceX(DGroupDlg.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DGroupDlg.SurfaceY(DGroupDlg.Top) + nLocalY;
  DScreen.ShowHint(nHintX, nHintY, sMsg, clYellow, TRUE);
end;

procedure TFrmDlg.DMailListStatusDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with Sender as TDButton do begin
    if g_boHasMail then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  end;
end;

procedure TFrmDlg.DFrdPgDnClick(Sender: TObject; X, Y: Integer);
begin
  inc(FriendPage);
end;

procedure TFrmDlg.DFrdPgUpClick(Sender: TObject; X, Y: Integer);
begin
  dec(FriendPage);
end;

procedure TFrmDlg.DCreateChrDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with sender as TDWindow do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, FALSE);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMemoCloseClick(Sender: TObject; X, Y: Integer);
begin
  DFrdMemoClick(TObject(DFrdMemo),X,Y);
end;

procedure TFrmDlg.DGenericMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg.DBigMapDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  v: Boolean;
  mx, my,nx,ny, i: integer;
  rc: TRect;
  actor:TActor;
  x,y:integer;
  btColor:Byte;
begin
  if g_nMapIndex < 0 then exit;
  d := g_WMMapImages.Images[g_nMiniMapIndex];
  if d = nil then exit;
  mx := (g_MySelf.m_nCurrX*48) div 32;
  my := (g_MySelf.m_nCurrY*32) div 32;
  rc.Left := 200;
  rc.Top := 50;
  rc.Right := _MIN(d.ClientRect.Right, rc.Left + 600);
  rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + 400);

  if g_nViewMinMapLv = 1 then
    dSurface.StretchDraw (rc, d.ClientRect, d, TRUE)
  else dSurface.StretchDraw (rc, d.ClientRect, d, TRUE);
     //雷达
  //if not m_boViewBlink then exit;
  mx := (SCREENWIDTH-120) + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left;
  my := (g_MySelf.m_nCurrY * 32) div 32 - rc.Top;
  dsurface.Pixels[mx, my] := 255;

  for nx:=g_MySelf.m_nCurrX - 30  to g_MySelf.m_nCurrX + 30 do begin
    for ny:=g_MySelf.m_nCurrY - 30 to g_MySelf.m_nCurrY + 30 do begin
      actor := PlayScene.FindActorXY(nx,ny);
      if (actor <> nil) and (actor <> g_MySelf) and (not actor.m_boDeath) then begin
        mx := (SCREENWIDTH-120) + (actor.m_nCurrX * 48) div 32 - rc.Left;
        my := (actor.m_nCurrY * 32) div 32 - rc.Top;

if (g_myself.m_boGrouped) and (frmmain.IsGroupMember(actor.m_sUserName)) then begin
         btcolor:=$FC;
         end else begin
        case actor.m_btRace of
          50,12: btColor:=251;
          0: btColor:=255;
          else btColor:=249;
        end;
       end;
        for x:=0 to 1 do
          for y:=0 to 1 do
            dsurface.Pixels[mx+x, my+y] := btColor
      end;
    end;
  end;
end;

procedure TFrmDlg.DLoverWindowDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d,e: TDirectDrawSurface;
   started,total:string;
begin
   with DLoverWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      e := g_WMainImages.Images[582];
      if e <> nil then
         dsurface.Draw (SurfaceX(Left+25), SurfaceY(Top+25), e.ClientRect, e, TRUE);

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clSilver;
         if g_Lovername <> '' then started := DateTimeToStr(g_StartDate);
         if g_Lovername <> '' then total := IntToStr(g_TotalDays);
         TextOut (Left+40, Top+75, '爱人       : '+g_LoverName); //14 characters all
         TextOut (Left+40, Top+100, '结婚日期   : '+started); //14 characters all
         TextOut (Left+40, Top+125, '总的天数   : '+total); //14 characters all
         Release;
      end;
   end;
end;

procedure TFrmDlg.DLoverAvailableDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if not Downed then
         d := WLib.Images[FaceIndex]
      else d := WLib.Images[FaceIndex+1];
   if d <> nil then dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DLoverAskDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if not Downed then
         d := WLib.Images[FaceIndex]
      else d := WLib.Images[FaceIndex+1];
   if d <> nil then dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DLoverDivorceDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if not Downed then
         d := WLib.Images[FaceIndex]
      else d := WLib.Images[FaceIndex+1];
   if d <> nil then dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DLoverExitDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then begin
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
         end;
   end;
   end;
end;

procedure TFrmDlg.DLoverExitClick(Sender: TObject; X, Y: Integer);
begin
DLoverWindow.Visible := False;
end;

procedure TFrmDlg.DLoverAvailableClick(Sender: TObject; X, Y: Integer);
begin
   SendClientMessage(CM_CHANGEAVAILABILITY, 0, 0, 0, 0);
end;

procedure TFrmDlg.DLoverAskClick(Sender: TObject; X, Y: Integer);
begin
   SendClientMessage(CM_ASKRELAY, 0, 0, 0, 0);
end;

procedure TFrmDlg.DLoverDivorceClick(Sender: TObject; X, Y: Integer);
begin
 if mrOk = FrmDlg.DMessageDlg ('你要离婚需要100000金币\结束关系，继续？', [mbOk, mbCancel]) then begin
   SendClientMessage(CM_ASKDIVORCE, 0, 0, 0, 0);
 end;
end;

procedure TFrmDlg.DLoverWindowMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg: String;
begin
  DScreen.ClearHint;
  Butt:=TDButton(Sender);
  if Sender = DLoverAvailable then sMsg:= '可以接受关系'
  else if Sender = DLoverAsk then sMsg:= '邀请到关系'
  else if Sender = DLoverDivorce then sMsg:= '打破关系';

  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DLoverWindow.SurfaceX(DLoverWindow.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DLoverWindow.SurfaceY(DLoverWindow.Top) + nLocalY;
  DScreen.ShowHint(nHintX, nHintY, sMsg, clYellow, TRUE);
end;

procedure TFrmDlg.DMailListDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  PageRef,PageTotal: Integer;
  Me: TDWindow;
  I,J: Integer;
  d: TDirectDrawSurface;
  MailItem: pTMailItem;
  r: TRect;
  sTextOut: String;
  sStatusList: TStringList;
  sStatus: String;
  ReadStatus: Boolean;
Begin
  if g_MySelf = nil then begin
    DBotMemoClick(TObject(DBotMemo),0,0);
    exit;
  end;
  ReadStatus := False;
  if MaxLineHeight = 0 then MaxLineHeight := FrmMain.DXDraw.Surface.Canvas.TextHeight('dp');
  Me := TDWindow(Sender);

  GetPageInfo(@MailList,MailPage,PageTotal,PageRef);
                   
  with dsurface.Canvas do begin
    with DMailListDlg do begin
      d := DMailListDlg.WLib.Images[FaceIndex];
      if d <> nil then dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
    SetBkMode (Handle, TRANSPARENT);

    Font.Color := clWhite;
    TextOut(Me.Left+68, Me.Top+36, g_MySelf.m_sUserName);
    TextOut(Me.Left+43, Me.Top+260, inttostr(MailPage)+'/'+inttostr(PageTotal));

    // Draw List
    sStatusList := TStringList.Create;
    for I := PageRef to PageRef+12 do begin
      if I >= MailList.Count then break;
      MailItem := PTMailItem(MailList.Items[I]);

      R.Left := 28+Me.Left;
      R.Top := Me.Top+86+(MaxLineHeight*(I-PageRef));
      R.Right := 264+Me.Left;
      R.Bottom := R.Top+MaxLineHeight;

      if I = MailIndex then begin
        Font.Color := clBlack;
        Brush.Color := clSilver;
        FillRect(R);
      end
      else begin
        Font.Color := clWhite;
        Brush.Color := clBlack;
      end;
      // 146 Is the middle of the text area. ((264-28)/2)+28 = 146
      // 86 is where the Text Starts X wise
      // 122 is the middle of the text area starting from the outlines.
      sStatusList.Clear;
      if not MailItem.Read then begin
        sStatusList.Add('未阅读');
        ReadStatus := True;
      end;
      If (MailItem.Status and nMAIL_SPECIAL) <> 0 then sStatusList.Add('特殊');
      If (MailItem.Status and nMAIL_LOCKED) <> 0 then sStatusList.Add('保护');
      if sStatusList.Count > 0 then sStatus := '['+Join('/',sStatusList)+'] ' else sStatus := ''; 

      sTextOut := sStatus+MailItem.Content;
      J := Length(sTextOut);
      if J > 38 then J := 38; // 38 Is the maximum amount of characters that will fit (a line of "i" with no status)
      while True do begin
        if R.Left+122+TextWidth(sTextOut) >= R.Right then begin
          sTextOut := sStatus+Copy(MailItem.Content,1,J)+'..';
          Dec(J);
        end
        else break;
      end;

      TextOut (R.Left+4, R.Top, MailItem.Sender);
      TextOut (R.Left+122, R.Top, sTextOut);
    end;
    sStatusList.Free;
    release;
  end;

  g_boHasMail := ReadStatus;
end;

procedure TFrmDlg.DMailListPgDnClick(Sender: TObject; X, Y: Integer);
begin
 inc(MailPage);
end;

procedure TFrmDlg.DMailListPgUpClick(Sender: TObject; X, Y: Integer);
begin
 dec(MailPage);
end;

procedure TFrmDlg.DMailListDlgClick(Sender: TObject; X, Y: Integer);
begin
  FindMail(True);
end;

function TFrmDlg.FindMail(Select: Boolean = False): PTMailItem;
var
  P: TPoint;
  I,MaxY: Integer;
begin
  if MaxLineHeight = 0 then MaxLineHeight := FrmMain.DXDraw.Surface.Canvas.TextHeight('dp');
//  New(Result);
  GetCursorPos(P);
  P.X := P.X - DMailListDlg.Left;
  P.Y := P.Y - DMailListDlg.Top;

  // Reusing Var, MaxY = PageTotal | I = PageRef;
  GetPageInfo(@MailList,MailPage,MaxY,I);

  MaxY := 86+(MaxLineHeight*13);
  if (P.X > 28) and (P.X < 264) and (P.Y > 86) and (P.Y < MaxY) then begin
    // Inside Range of allowedness!
    I := I+((P.Y-86) div MaxLineHeight);
    if (I >= 0) and (I < MailList.Count) then begin
      if Select then MailIndex := I;
      Result := PTMailItem(MailList.Items[I]);
    end
    else Result := nil;
  end
  else Result := nil;
end;

procedure TFrmDlg.EdSalesEditKeyPress (Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin
      FrmDlg.DSalesFindClick(Self,0,0);
      Key := #0;
   end;
   {if Key = #27 then begin
      EdSalesEdit.Text := '';
      EdSalesEdit.Visible := FALSE;
      Key := #0;
   end;  }
end;

procedure TFrmDlg.TextAreaNotify(Sender: TObject);
begin
  if Sender = TObject(EdMail) then DMailDlg.Show
  else if Sender = TObject(EdMailRead) then DMailRead.Show
  else if Sender = TObject(EdSalesEdit) then DSales.Show
  else if Sender = TObject(EdShopEdit) then DItemShopDlg.Show
  else if Sender = TObject(EdMemo) then DMemo.Show;
end;

procedure TFrmDlg.BBSTextNotify(Sender: TObject);
var
  i:integer;
  //str,str2,msg:string;
begin
{ started coding this to limit the amount of text that goes onto one line  but dont think that's needed really (hope not)
  msg := BBSMemo.Text;
  while msg <> '' do begin
    msg := GetValidStr3 (msg, str,[#13]);
    if Length(str) > 25 then begin
      str2 := LeftStr(str,25)
    end;
    str2 :=
  end;
}
  for i := 9 to BBSMemo.Lines.Count -1 do begin
    BBSMemo.Lines[i] := '';
  end;
end;

procedure TFrmDlg.DMailListDlgDblClick(Sender: TObject);
var
  MailItem: ptMailItem;
begin
  if Sender = nil then begin
    if (MailList.Count < 1) or (MailIndex < 0) or (MailIndex >= MailList.Count) then exit;
    MailItem := ptMailItem(MailList.Items[MailIndex])
  end
  else MailItem := FindMail(True);

  if MailItem = nil then exit;

  if DMailRead.Visible then begin
    FrmDlg.DMessageDlg ('已经有开放邮件的窗口，在读另一则邮件消息之前，请先结束。', [mbOk]);
  end
  else begin
    SendClientMessage(CM_READMAIL, MailItem.ID, 0, 0, 0);
    MailItem.Read := True;
    DFrdMemoClick(DMLRead,0,0);
    DMailRead.sMisc := MailItem.Sender;
    DMailRead.sMisc2 := FormatDateTime('yyyy/mm/dd hh:mm:ss', UnixToDateTime(MailItem.Time));
    EdMailRead.Text := MailItem.Content;
    EdMailRead.ReadOnly := True;
  end;
end;

procedure TFrmDlg.DMLReplyClick(Sender: TObject; X, Y: Integer);
var
  MailItem: ptMailItem;
begin
  if (MailList.Count < 1) or (MailIndex < 0) or (MailIndex >= MailList.Count) then exit;
  MailItem := ptMailItem(MailList.Items[MailIndex]);
  if MailItem = nil then begin
    FrmDlg.DMessageDlg ('请先选择邮件。', [mbOk]);
  end
  else SendMail(MailItem.Sender);
end;

procedure TFrmDlg.SendMail(sTarget: String);
begin
  if DMailDlg.Visible then begin
    FrmDlg.DMessageDlg ('已经有开放邮件的窗口，在读另一则邮件消息之前，请先结束。', [mbOk]);
  end
  else begin
    DFrdMemoClick(DMLReply,0,0);
    DMailDlg.sMisc := sTarget;
  end;
end;

procedure TFrmDlg.DMailDlgb1Click(Sender: TObject; X, Y: Integer);
begin
  //Send Mail to Server
  SendClientMessage(CM_SENDMAIL, 0, 0, 0, 0,DMailDlg.sMisc + #1 + edMail.Text);
  DMailDlgCloseClick(nil,0,0);
end;

{---- Adjust global SVN revision ----}
procedure TFrmDlg.DMailReadCloseClick(Sender: TObject; X, Y: Integer);
begin
  DFrdMemoClick(TObject(DMLRead),X,Y);
end;

procedure TFrmDlg.DMLReadClick(Sender: TObject; X, Y: Integer);
begin
  DMailListDlgDblClick(nil);
end;

procedure TFrmDlg.DMLDelClick(Sender: TObject; X, Y: Integer);
var
  MailItem: ptMailItem;
  I: Integer;
begin
  if (MailList.Count < 1) or (MailIndex < 0) or (MailIndex >= MailList.Count) then exit;
  MailItem := ptMailItem(MailList.Items[MailIndex]);

  if MailItem = Nil then begin
    FrmDlg.DMessageDlg('您需要删除选择的邮件吗？', [mbOk]);
  end
  else begin
    If (MailItem.Status and nMAIL_LOCKED) <> 0 then begin
      DMessageDlg('你不能删除受保护的邮件，你先解除保护。', [mbOK]);
    end
    else begin
      if mrYes = FrmDlg.DMessageDlg ('你是否要删除这个邮件？', [mbYes, mbNo]) then begin
        SendClientMessage(CM_DELETEMAIL, MailItem.ID, 0, 0, 0);
        I := MailIndex;
        MailIndex := -1;
        MailList.Delete(I);
        Dispose(MailItem);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMLLockClick(Sender: TObject; X, Y: Integer);
var
  MailItem: ptMailItem;
begin
  if (MailList.Count < 1) or (MailIndex < 0) or (MailIndex >= MailList.Count) then exit;
  MailItem := ptMailItem(MailList.Items[MailIndex]);

  if MailItem = Nil then begin
    FrmDlg.DMessageDlg('你需要先选择你要保护或解除保护的邮件。', [mbOk]);
  end
  else begin
    If (MailItem.Status and nMAIL_LOCKED) <> 0 then MailItem.Status := MailItem.Status-nMAIL_LOCKED
    else MailItem.Status := MailItem.Status+nMAIL_LOCKED;
    SendClientMessage(CM_SETMAILSTATUS, MailItem.ID, MailItem.Status, 0, 0);
  end;
end;

procedure TFrmDlg.DMailReadDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  if g_MySelf = nil then DMailReadCloseClick(TObject(DMailReadClose),0,0)
  else TDWindow(Sender).NoPaint := False;
end;

procedure TFrmDlg.DMailDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  if g_MySelf = nil then DMailDlgCloseClick(TObject(DMailDlgClose),0,0)
  else TDWindow(Sender).NoPaint := False;
end;

procedure TFrmDlg.DBeltWindowDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
begin
  if g_MySelf = nil then DBeltWindow.Visible := False
  else DBeltWindow.NoPaint := False;
end;

procedure TFrmDlg.DBLAddClick(Sender: TObject; X, Y: Integer);
var
  sBlockAdd: String;
begin
  FrmDlg.DlgEditText := '';
  FrmDlg.DMessageDlg ('请输入您想增加的屏蔽邮件列表的玩家名字。', [mbOk, mbAbort]);
  sBlockAdd := Trim(FrmDlg.DlgEditText);

  if sBlockAdd = g_MySelf.m_sUserName then begin
    FrmDlg.DMessageDlg ('你不能屏蔽你自己...', [mbOk]);
    exit;
  end;

  if sBlockAdd <> '' then begin
    SendClientMessage(CM_ADDBLOCK, 0, 0, 0, 0, sBlockAdd);
  end;
end;

procedure TFrmDlg.DBLDelClick(Sender: TObject; X, Y: Integer);
var
  B: ptBlockItem;
begin
  if (BlockList.Count < 1) or (BlockIndex < 0) or (BlockIndex >= BlockList.Count) then exit;
  B := ptBlockItem (BlockList.Items[BlockIndex]);
  if mrYes = FrmDlg.DMessageDlg ('你需要把"' + B.name + '"从屏蔽列表删除吗？', [mbYes, mbNo]) then begin
    SendClientMessage(CM_DELBLOCK, 0, 0, 0, 0, B.Name);
    BlockIndex := -1;
    BlockList.Remove(B);
  end;
end;

procedure TFrmDlg.DBlockListDlgClick(Sender: TObject; X, Y: Integer);
begin
  FindBlock(True);
end;

function TFrmDlg.FindBlock(Select: Boolean = False): PTBlockItem;
var
  P: TPoint;
  I,MaxY: Integer;
begin
  if MaxLineHeight = 0 then MaxLineHeight := FrmMain.DXDraw.Surface.Canvas.TextHeight('dp');
  New(Result);
  GetCursorPos(P);
  P.X := P.X - DBlockListDlg.Left;
  P.Y := P.Y - DBlockListDlg.Top;

  // Reusing Var, MaxY = PageTotal | I = PageRef;
  GetPageInfo(@BlockList,BlockPage,MaxY,I);

  MaxY := 86+(MaxLineHeight*10);
  if (P.X > 28) and (P.X < 264) and (P.Y > 86) and (P.Y < MaxY) then begin
    // Inside Range of allowedness!
    I := I+((P.Y-86) div MaxLineHeight);
    if (I >= 0) and (I < BlockList.Count) then begin
      if Select then BlockIndex := I;
      Result := PTBlockItem(BlockList.Items[I]);
    end
    else Result := nil;
  end;
end;

procedure TFrmDlg.DBlockListDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  PageRef,PageTotal: Integer;
  Me: TDWindow;
  I: Integer;
  d: TDirectDrawSurface;
  Block: PTBlockItem;
Begin
  if g_MySelf = nil then begin
    DMLBlockClick(TObject(DMLBlock),0,0);
    exit;
  end;
  if MaxLineHeight = 0 then MaxLineHeight := FrmMain.DXDraw.Surface.Canvas.TextHeight('dp');
  Me := TDWindow(Sender);

  GetPageInfo(@BlockList,BlockPage,PageTotal,PageRef);

  with dsurface.Canvas do begin
    with DBlockListDlg do begin
      d := DBlockListDlg.WLib.Images[FaceIndex];
      if d <> nil then dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    end;
    SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
    SetBkMode (Handle, TRANSPARENT);

    Font.Color := clWhite;
    TextOut(Me.Left+68, Me.Top+36, g_MySelf.m_sUserName);
    TextOut(Me.Left+43, Me.Top+260, inttostr(BlockPage)+'/'+inttostr(PageTotal));

    // Draw List
    for I := PageRef to PageRef+9 do begin
      if I >= BlockList.Count then break;
      Block := ptBlockItem(BlockList.Items[I]);
      if I = BlockIndex then begin
        Font.Color := clBlack;
        Brush.Color := clSilver;
      end
      else begin
        Font.Color := clSilver;
        Brush.Color := clBlack;
      end;
      // 146 Is the middle of the text area. ((264-28)/2)+28 = 146
      // 86 is where the Text Starts X wise
      TextOut ((146+Me.Left)-(TextWidth(Block.Name) div 2), Me.Top+86+(MaxLineHeight*(I-PageRef)), Block.Name);
    end;

    release;
  end;
end;

procedure TFrmDlg.DBLPgDnClick(Sender: TObject; X, Y: Integer);
begin
  Inc(BlockPage);
end;

procedure TFrmDlg.DBLPgUpClick(Sender: TObject; X, Y: Integer);
begin
  Dec(BlockPage);
end;

procedure TFrmDlg.DMLBlockClick(Sender: TObject; X, Y: Integer);
begin
  OpenBlockListDlg();
end;

procedure TFrmDlg.DBlockListDlgMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg: String;
begin
  DScreen.ClearHint;
  Butt:=TDButton(Sender);

  if Sender = DBLAdd then sMsg := '增加到屏蔽列表'
  else if Sender = DMLDel then sMsg := '从屏蔽列表删除';

  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DMailListDlg.SurfaceX(DMailListDlg.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DMailListDlg.SurfaceY(DMailListDlg.Top) + nLocalY;
  DScreen.ShowHint(nHintX, nHintY, sMsg, clYellow, TRUE);
end;

procedure TFrmDlg.DBotMemoDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  if g_MySelf <> nil then DBotMemo.NoPaint := False;
end;


procedure TFrmDlg.DFriendDlgPostDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  if g_Myself = nil then exit;
  with dsurface.Canvas do begin
    SetBkMode (Handle, TRANSPARENT);
    Font.Color := clWhite;
    TextOut (68+DFriendDlg.Left, 36+DFriendDlg.TOP, g_MySelf.m_sUserName);
    release;
  end;
end;

procedure TFrmDlg.DHoldClick(Sender: TObject; X, Y: Integer);
begin
  g_boQuickSell := not g_boQuickSell;
end;

procedure TFrmDlg.DSellDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  DSellOk();
end;

procedure TFrmDlg.DGTListDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
const
  sStatus:array[0..2] of String = ('正常', '销售中', '已出售');
var
  i,rowcount,rowoffset: integer;
  d: TDirectDrawSurface;
  output: String;
begin
    with Sender as TDWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      rowcount:=0;
      rowoffset:=12;
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      with dsurface.Canvas do begin
        Font.Color := clYellow;
        TextOut (SurfaceX(Left)+30, SurfaceY(Top)+48, '编号');
        TextOut (SurfaceX(Left)+65, SurfaceY(Top)+48, '公会名字');
        TextOut (SurfaceX(Left)+250, SurfaceY(Top)+48, '公会领袖');
        TextOut (SurfaceX(Left)+395, SurfaceY(Top)+48, '售价');
        TextOut (SurfaceX(Left)+475, SurfaceY(Top)+48, '状态');
        for i:= 0 to g_GTAmountOnPage - 1 do begin
          if g_GTItems[i].Number <=0 then continue;
          if GTListMenuIndex = i then begin
            Font.Color := clRed;
          end else
            Font.Color := clWhite;
          TextOut (SurfaceX(Left)+35, SurfaceY(Top)+64+(rowoffset*rowcount), IntToStr(g_GTItems[i].Number));
          TextOut (SurfaceX(Left)+65, SurfaceY(Top)+64+(rowoffset*rowcount), g_GTItems[i].GuildName);
          TextOut (SurfaceX(Left)+170, SurfaceY(Top)+64+(rowoffset*rowcount), g_GTItems[i].GuildMasters[0]);
          TextOut (SurfaceX(Left)+290, SurfaceY(Top)+64+(rowoffset*rowcount), g_GTItems[i].GuildMasters[1]);
          TextOut (SurfaceX(Left)+390, SurfaceY(Top)+64+(rowoffset*rowcount), IntToStr(g_GTItems[i].SalePrice));
          TextOut (SurfaceX(Left)+470, SurfaceY(Top)+64+(rowoffset*rowcount), sStatus[g_GTItems[i].Status]);
          inc(rowcount);
        end;
      end;
      dsurface.Canvas.Release;
  end;
end;

procedure TFrmDlg.DGTListCloseClick(Sender: TObject; X, Y: Integer);
begin
  DGTList.Visible := False;
  ClearGTlist();
end;

procedure TFrmDlg.ClearGTlist();
var
  i:integer;
begin
  for i:=0 to 9 do
    g_GTItems[i].Number:=0;
    g_GTCurrPage:=0;
    g_GTAmountOnPage:=0;
    GTListMenuIndex:=10;
end;

procedure TFrmDlg.ClearDecolist();
var
  i:integer;
begin
  for i:=0 to 11 do
    g_DecoItems[i].appr:=255;
    g_GTCurrPage:=0;
    g_GTAmountOnPage:=0;
    GTListMenuIndex:=13;
end;

procedure TFrmDlg.ClearGameShoplist();
var
  i:integer;
begin
  for i:=0 to 8 do
    //g_ItemShopItems[i].appr:=255;
    g_ItemShopCurrPage:=0;
    g_ItemShopAmountofPages:=0;
    GameShopMenuIndex:=9;
end;

procedure TFrmDlg.ClearBBSList();
var
  i:integer;
begin
  for i:=0 to 9 do
    g_BBSMsgList[i].index := -1;
    g_GTCurrPage:=0;
    g_GTAmountOnPage:=0;
    GTListMenuIndex:=10;
end;

procedure TFrmDlg.DGTListClick(Sender: TObject; X, Y: Integer);
begin
  if (((X<(35+DGTList.Left)) OR (X>(480+DGTList.Left))) OR
     ((Y<(64+DGTList.Top)) OR (Y>(200+DGTList.Top)))) then exit;
  GTListMenuIndex:= (Y-(64+DGTList.Top)) div 12;
end;

procedure TFrmDlg.DGTListPrevClick(Sender: TObject; X, Y: Integer);
begin
   if g_GTCurrPage > 0 then
    FrmMain.SendGTListRequest(g_nCurMerchant, g_GTCurrPage -1);
end;

procedure TFrmDlg.DGTListNextClick(Sender: TObject; X, Y: Integer);
begin
  if g_GTCurrPage + 1 <= g_GTTotalPage then
    FrmMain.SendGTListRequest(g_nCurMerchant, g_GTCurrPage +1);
end;

procedure TFrmDlg.DGTListMailClick(Sender: TObject; X, Y: Integer);
begin
  if g_GTItems[GTListMenuIndex].GuildMasters[0] <> '' then begin
    SendMail(g_GTItems[GTListMenuIndex].GuildMasters[0]);
  end;
end;

procedure TFrmDlg.DGTListDblClick(Sender: TObject);
begin
  if (GTListMenuIndex < 0) OR
     (GTListMenuIndex > 9) then exit;
  if g_GTItems[GTListMenuIndex].Number <> 0 then begin
    //FrmMain.SendBuyGT(g_nCurMerchant,g_GTItems[GTListMenuIndex].Number);
    //DGTList.Visible := False;
    //ClearGTlist();
  end;
end;

procedure TFrmDlg.DDecoListNextClick(Sender: TObject; X, Y: Integer);
begin
  if g_GTCurrPage + 1 <= g_GTTotalPage then
    FrmMain.SendDecoListRequest(g_nCurMerchant, g_GTCurrPage +1);
end;

procedure TFrmDlg.DDecoListPrevClick(Sender: TObject; X, Y: Integer);
begin
  if g_GTCurrPage > 0 then
    FrmMain.SendDecoListRequest(g_nCurMerchant, g_GTCurrPage -1);
end;

procedure TFrmDlg.DDecoListDlgClick(Sender: TObject; X, Y: Integer);
begin
  if (((X<(30+DDecoListDlg.Left)) OR (X>(300+DDecoListDlg.Left))) OR
     ((Y<(90+DDecoListDlg.Top)) OR (Y>(318+DDecoListDlg.Top)))) then exit;
  GTListMenuIndex:= (Y-(90+DDecoListDlg.Top)) div 19;
end;

procedure TFrmDlg.DDecoListExitClick(Sender: TObject; X, Y: Integer);
begin
  DDecoListDlg.Visible := False;
  ClearDecolist();
end;


procedure TFrmDlg.DDecoListDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  i,rowcount,rowoffset: integer;
  d,e: TDirectDrawSurface;
  dx,dy:integer;
begin
    with Sender as TDWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      rowcount:=0;
      rowoffset:=19;
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      with dsurface.Canvas do begin
        Font.Color := clYellow;
        TextOut (SurfaceX(Left)+110, SurfaceY(Top)+36, '装饰目录');
        TextOut (SurfaceX(Left)+520, SurfaceY(Top)+36, IntToStr(g_GTCurrPage) + '/' + IntToStr(g_GTTotalPage));
        TextOut (SurfaceX(Left)+80, SurfaceY(Top)+66, '名字');
        TextOut (SurfaceX(Left)+205, SurfaceY(Top)+66, '价格');
        for i:= 0 to g_GTAmountOnPage - 1 do begin
          if GTListMenuIndex = i then begin
            Font.Color := clRed;
          end else
            Font.Color := clWhite;
           TextOut (SurfaceX(Left)+30, SurfaceY(Top)+90+(rowoffset*rowcount),g_DecoItems[i].Name);
           TextOut (SurfaceX(Left)+165, SurfaceY(Top)+90+(rowoffset*rowcount),IntToStr(g_DecoItems[i].Price));
          inc(rowcount);
        end;
      end;
      dsurface.Canvas.Release;
      if (GTListMenuIndex >= 0) and (GTListMenuIndex <= g_GTAmountOnPage) then begin
        e := g_WDecoImages.Images[g_DecoItems[GTListMenuIndex].Appr];
        e := g_WDecoImages.GetCachedImage(g_DecoItems[GTListMenuIndex].Appr, dx, dy);
        if e <> nil then
          dsurface.Draw (SurfaceX(Left)+420+dx, SurfaceY(Top)+240+dy, e.ClientRect, e, TRUE);
      end;
  end;

end;

procedure TFrmDlg.DDecoListBuyClick(Sender: TObject; X, Y: Integer);
begin
  if (GTListMenuIndex < 0) or (GTListMenuIndex > 12) then exit;
  FrmMain.SendBuyDeco(g_nCurMerchant, g_DecoItems[GTListMenuIndex].Appr);
  GTListMenuIndex:=13;//prevent ppl from accidentaly buying 100000 times the same item in one go :p
end;

procedure TFrmDlg.DBBSListDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  i,rowcount,rowoffset: integer;
  d,e: TDirectDrawSurface;
  dx,dy:integer;
  msg:string;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    rowcount:=0;
    rowoffset:=19;
    SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
    with dsurface.Canvas do begin
      Font.Color := clYellow;
      TextOut (SurfaceX(Left)+180, SurfaceY(Top)+36, '布告栏');
      TextOut (SurfaceX(Left)+350, SurfaceY(Top)+36, IntToStr(g_GTCurrPage) + '/' + IntToStr(g_GTTotalPage));
      TextOut (SurfaceX(Left)+35, SurfaceY(Top)+66, '发布人');
      TextOut (SurfaceX(Left)+150, SurfaceY(Top)+66, '主题');
      for i:= 0 to g_GTAmountOnPage - 1 do begin
        if GTListMenuIndex = i then begin
          Font.Color := clRed;
        end else if g_BBSMsgList[i].Sticky then begin
          Font.Color := clYellow;
        end else
          Font.Color := clWhite;
        GetValidStr3 (g_BBSMsgList[i].Msg, msg,[#13]);
        TextOut (SurfaceX(Left)+30, SurfaceY(Top)+88+(rowoffset*rowcount),g_BBSMsgList[i].Poster);
        if g_BBSMsgList[i].index <> g_BBSMsgList[i].MasterIndex then begin
          TextOut (SurfaceX(Left)+160, SurfaceY(Top)+88+(rowoffset*rowcount),msg);
        end else
          TextOut (SurfaceX(Left)+140, SurfaceY(Top)+88+(rowoffset*rowcount),msg);
        inc(rowcount);
      end;
    end;
    dsurface.Canvas.Release;
    rowcount:=0;
    for i:= 0 to g_GTAmountOnPage - 1 do begin
      if g_BBSMsgList[i].index <> g_BBSMsgList[i].MasterIndex then begin
        e:= WLib.Images[690];
        if e <> nil then
          dsurface.Draw (SurfaceX(Left)+140, SurfaceY(Top)+88+(rowoffset*rowcount), e.ClientRect, e, TRUE);
      end;
      inc(rowcount);
    end;
  end;
end;

procedure TFrmDlg.DBBSListDlgClick(Sender: TObject; X, Y: Integer);
begin
 if (((X<(30+DBBSListDlg.Left)) OR (X>(450+DBBSListDlg.Left))) OR
     ((Y<(88+DBBSListDlg.Top)) OR (Y>(278+DBBSListDlg.Top)))) then exit;
  GTListMenuIndex:= (Y-(88+DBBSListDlg.Top)) div 19;
end;

procedure TFrmDlg.DBBSListPrevClick(Sender: TObject; X, Y: Integer);
begin
  if g_GTCurrPage > 0 then
    FrmMain.SendBBSListRequest(g_nCurMerchant, g_GTCurrPage - 1);
end;

procedure TFrmDlg.DBBSListNextClick(Sender: TObject; X, Y: Integer);
begin
  if g_GTCurrPage + 1 <= g_GTTotalPage then
  FrmMain.SendBBSListRequest(g_nCurMerchant, g_GTCurrPage + 1);
end;

procedure TFrmDlg.DBBSListRefreshClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendBBSListRequest(g_nCurMerchant, g_GTCurrPage);
end;

procedure TFrmDlg.DBBSListCloseClick(Sender: TObject; X, Y: Integer);
begin
  DBBSListDlg.Visible := False;
  ClearBBSlist();
end;

procedure TFrmDlg.DBBSListOKClick(Sender: TObject; X, Y: Integer);
begin
  if (GTListMenuIndex < 0) or (GTListMenuIndex > 10) then exit;
  if g_BBSMsgList[GTListMenuIndex].index <= 0 then exit;
  FrmMain.SendBBSMsgRequest(g_nCurMerchant, g_BBSMsgList[GTListMenuIndex].index);
end;

procedure TFrmDlg.DBBSMsgCloseClick(Sender: TObject; X, Y: Integer);
begin
  ToggleBBSMsgWindow;
end;

procedure TFrmDlg.DBBSMsgDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  rowcount,rowoffset: integer;
  d: TDirectDrawSurface;
  dx,dy,i:integer;
  msg,str,tempstr:string;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    if g_BBSMSG <> '' then begin
      rowcount:=0;
      rowoffset:=16;
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      msg:=g_BBSMSG;
      with dsurface.Canvas do begin
        Font.Color := clWhite;
        TextOut (SurfaceX(Left)+30, SurfaceY(Top)+37, g_BBSPoster);
        while True do begin
          if (msg = '') or (rowcount > 9) then break;
          msg := GetValidStr3 (msg, str,[#13]);
          if TextWidth(str) > 294 then begin
            tempstr:=str;
            i:=1;
            while TextWidth(tempstr) > 294 do begin
              tempstr:= LeftStr(str,Length(str) - i);
              inc(i);
            end;
            str:= RightStr(str,i);
            msg:= str + #13 + msg;
            str := tempstr;
          end;
          TextOut (SurfaceX(Left)+30, (SurfaceY(Top)+63) + (rowcount * rowoffset), Trim(str));
          inc(rowcount)
        end;
      end;
      dsurface.Canvas.Release;
    end else begin
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      with dsurface.Canvas do begin
        Font.Color := clWhite;
        TextOut (SurfaceX(Left)+30, SurfaceY(Top)+37, g_MySelf.m_sUserName);
      end;
      dsurface.Canvas.Release;
//      HideAllControls;
      BBSMemo.Left := SurfaceX(Left+28);  //16
      BBSMemo.Top  := SurfaceY(Top+61);   //36
      FrmDlg.BBSMemo.SetFocus;
      SetDFocus(FrmDlg.DBBSMsgDlg);
    end;
  end;
end;

procedure TFrmDlg.DBBSListWriteClick(Sender: TObject; X, Y: Integer);
begin
  g_MasterPost:=0;
  BBSSticky:=0;
  g_BBSMSG := '';
  ToggleBBSMsgWindow;
end;

procedure TFrmDlg.DBBSListNoticeClick(Sender: TObject; X, Y: Integer);
begin
  g_MasterPost:=0;
  BBSSticky:=1;
  g_BBSMSG := '';
  ToggleBBSMsgWindow;
end;

procedure TFrmDlg.DBBSMsgOkClick(Sender: TObject; X, Y: Integer);
var
  msg,str,output:string;
  rowcount : integer;
begin
   if g_BBSMSG <> '' then begin
    ToggleBBSMsgWindow;
  end else begin
    ToggleBBSMsgWindow;
    output:='';
    rowcount := 0;
    msg:=BBSMemo.Text;
    while True do begin
      if (msg = '') then break;
      if (rowcount > 8) then begin
        DMessageDlg ('去除了前个部分，最大限制 = 8.', [mbOk]);
        break;
      end;
      msg := GetValidStr3 (msg, str,[#13]);
      if rowcount = 0 then begin
        output := str;
      end else
        output := output + #13 + str;
      inc(rowcount)
    end;
    if output = '' then exit;
    FrmMain.SendBBSPost(g_nCurMerchant,BBSSticky, g_MasterPost,output);
  end;
end;

procedure TFrmDlg.DBBSMsgReplyClick(Sender: TObject; X, Y: Integer);
begin
  ToggleBBSMsgWindow;
  g_BBSMSG := '';
  BBSSticky:=0;
  ToggleBBSMsgWindow;
end;

procedure TFrmDlg.DBBSMsgDeleteClick(Sender: TObject; X, Y: Integer);
begin
   if (GTListMenuIndex < 0) or (GTListMenuIndex > 10) then exit;
  if g_BBSMsgList[GTListMenuIndex].index <= 0 then exit;
  FrmMain.SendBBSDelete(g_nCurMerchant, g_BBSMsgList[GTListMenuIndex].index);
  GTListMenuIndex := 13;
  g_BBSMSG := '';
  ToggleBBSMsgWindow;
end;

procedure TFrmDlg.DOptionsCloseClick(Sender: TObject; X, Y: Integer);
begin
  DOptions.Visible := false;
end;

procedure TFrmDlg.DOptionsSoundOffClick(Sender: TObject; X, Y: Integer);
begin
  g_boSound := false;
  DOptionsSoundOn.SetImgIndex (g_WMainImages, -1);
  DOptionsSoundOff.SetImgIndex (g_WMainImages, 774);
end;

procedure TFrmDlg.DOptionsSoundOnClick(Sender: TObject; X, Y: Integer);
begin
  g_boSound := true;
  DOptionsSoundOn.SetImgIndex (g_WMainImages, 773);
  DOptionsSoundOff.SetImgIndex (g_WMainImages, -1);
end;

procedure TFrmDlg.DOptionsDropViewOnClick(Sender: TObject; X, Y: Integer);
begin
  g_boShowAllItem := true;
  DOptionsDropViewOn.SetImgIndex (g_WMainImages, 773);
  DOptionsDropViewOff.SetImgIndex (g_WMainImages, -1);
end;

procedure TFrmDlg.DOptionsDropViewOffClick(Sender: TObject; X, Y: Integer);
begin
  g_boShowAllItem := false;
  DOptionsDropViewOn.SetImgIndex (g_WMainImages, -1);
  DOptionsDropViewOff.SetImgIndex (g_WMainImages, 774);
end;

procedure TFrmDlg.DOptionsEffectOffClick(Sender: TObject; X, Y: Integer);
begin
  g_boEffect := false;
  DOptionsEffectOn.SetImgIndex (g_WMainImages, -1);
  DOptionsEffectOff.SetImgIndex (g_WMainImages, 774);
end;

procedure TFrmDlg.DOptionsEffectOnClick(Sender: TObject; X, Y: Integer);
begin
  g_boEffect := true;
  DOptionsEffectOn.SetImgIndex (g_WMainImages, 773);
  DOptionsEffectOff.SetImgIndex (g_WMainImages, -1);
end;

procedure TFrmDlg.DOptionsSkillBarOffClick(Sender: TObject; X, Y: Integer);
begin
  DSkillBar.Visible := false;
  DOptionsSkillBarOn.SetImgIndex (g_WMainImages, -1);
  DOptionsSkillBarOff.SetImgIndex (g_WMainImages, 774);
end;

procedure TFrmDlg.DOptionsSkillBarOnClick(Sender: TObject; X, Y: Integer);
begin
  DSkillBar.SetImgIndex (g_WMainImages, 711);
  DSkillBar.Visible := true;
  DOptionsSkillBarOn.SetImgIndex (g_WMainImages, 773);
  DOptionsSkillBarOff.SetImgIndex (g_WMainImages, -1);
end;

procedure TFrmDlg.DOptionsSkillMode1Click(Sender: TObject; X, Y: Integer);
begin
  g_boSkillSetting := true;
  DOptionsSkillMode1.SetImgIndex (g_WMainImages, 771);
  DOptionsSkillMode2.SetImgIndex (g_WMainImages, -1);
end;

procedure TFrmDlg.DOptionsSkillMode2Click(Sender: TObject; X, Y: Integer);
begin
  g_boSkillSetting := false;
  DOptionsSkillMode1.SetImgIndex (g_WMainImages, -1);
  DOptionsSkillMode2.SetImgIndex (g_WMainImages, 772);
end;

procedure TFrmDlg.DOptionsNameAllViewOnClick(Sender: TObject; X,
  Y: Integer);
begin
  g_boNameAllView := true;
  DOptionsNameAllViewOn.SetImgIndex (g_WMainImages, 773);
  DOptionsNameAllViewOff.SetImgIndex (g_WMainImages, -1);
end;

procedure TFrmDlg.DOptionsNameAllViewOffClick(Sender: TObject; X,
  Y: Integer);
begin
  g_boNameAllView := false;
  DOptionsNameAllViewOn.SetImgIndex (g_WMainImages, -1);
  DOptionsNameAllViewOff.SetImgIndex (g_WMainImages, 774);
end;

procedure TFrmDlg.DOptionsHPView1Click(Sender: TObject; X, Y: Integer);
begin
  g_boHPView := true;
  DOptionsHPView1.SetImgIndex (g_WMainImages, 775);
  DOptionsHPView2.SetImgIndex (g_WMainImages, -1);
end;

procedure TFrmDlg.DOptionsHPView2Click(Sender: TObject; X, Y: Integer);
begin
  g_boHPView := false;
  DOptionsHPView1.SetImgIndex (g_WMainImages, -1);
  DOptionsHPView2.SetImgIndex (g_WMainImages, 776);
end;

procedure TFrmDlg.DSkillBarDirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);

var
   d: TDirectDrawSurface;
   magic: PTClientMagic;

begin

  // Is the NPC dialog open? If it is, don't draw anything!
  if DMerchantDlg.Visible then begin
    DSkillBar1.Visible := false;
    DSkillBar2.Visible := false;
    DSkillBar3.Visible := false;
    DSkillBar4.Visible := false;
    DSkillBar5.Visible := false;
    DSkillBar6.Visible := false;
    DSkillBar7.Visible := false;
    DSkillBar8.Visible := false;
    exit;
  end else if not(DSkillBar1.Visible) then begin
    DSkillBar1.Visible := true;
    DSkillBar2.Visible := true;
    DSkillBar3.Visible := true;
    DSkillBar4.Visible := true;
    DSkillBar5.Visible := true;
    DSkillBar6.Visible := true;
    DSkillBar7.Visible := true;
    DSkillBar8.Visible := true;
  end;

  //draw the window
  with Sender as TDWindow do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    dsurface.Canvas.Release;
  end;

  if DSkillBar.FaceIndex = 711 then begin
    // F keys

    //F1
    magic := frmmain.GetMagicByKey(char ((0) + byte('1')) );
    if magic <> nil then
      DSkillBar1.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar1.SetImgIndex(g_WMagIconImages, -1);

    //F2
    magic := frmmain.GetMagicByKey(char ((1) + byte('1')) );
    if magic <> nil then
      DSkillBar2.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar2.SetImgIndex(g_WMagIconImages, -1);

    //F3
    magic := frmmain.GetMagicByKey(char ((2) + byte('1')) );
    if magic <> nil then
      DSkillBar3.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar3.SetImgIndex(g_WMagIconImages, -1);

    //F4
    magic := frmmain.GetMagicByKey(char ((3) + byte('1')) );
    if magic <> nil then
      DSkillBar4.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar4.SetImgIndex(g_WMagIconImages, -1);

    //F5
    magic := frmmain.GetMagicByKey(char ((4) + byte('1')) );
    if magic <> nil then
      DSkillBar5.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar5.SetImgIndex(g_WMagIconImages, -1);

    //F6
    magic := frmmain.GetMagicByKey(char ((5) + byte('1')) );
    if magic <> nil then
      DSkillBar6.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar6.SetImgIndex(g_WMagIconImages, -1);

    //F7
    magic := frmmain.GetMagicByKey(char ((6) + byte('1')) );
    if magic <> nil then
      DSkillBar7.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar7.SetImgIndex(g_WMagIconImages, -1);

    //F8
    magic := frmmain.GetMagicByKey(char ((7) + byte('1')) );
    if magic <> nil then
      DSkillBar8.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar8.SetImgIndex(g_WMagIconImages, -1);

  end else begin
    // CTRL+F keys

    //F1
    magic := frmmain.GetMagicByKey(char ((0) + byte('1') + byte($14)) );
    if magic <> nil then
      DSkillBar1.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar1.SetImgIndex(g_WMagIconImages, -1);

    //F2
    magic := frmmain.GetMagicByKey(char ((1) + byte('1') + byte($14)) );
    if magic <> nil then
      DSkillBar2.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar2.SetImgIndex(g_WMagIconImages, -1);

    //F3
    magic := frmmain.GetMagicByKey(char ((2) + byte('1') + byte($14)) );
    if magic <> nil then
      DSkillBar3.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar3.SetImgIndex(g_WMagIconImages, -1);

    //F4
    magic := frmmain.GetMagicByKey(char ((3) + byte('1') + byte($14)) );
    if magic <> nil then
      DSkillBar4.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar4.SetImgIndex(g_WMagIconImages, -1);

    //F5
    magic := frmmain.GetMagicByKey(char ((4) + byte('1') + byte($14)) );
    if magic <> nil then
      DSkillBar5.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar5.SetImgIndex(g_WMagIconImages, -1);

    //F6
    magic := frmmain.GetMagicByKey(char ((5) + byte('1') + byte($14)) );
    if magic <> nil then
      DSkillBar6.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar6.SetImgIndex(g_WMagIconImages, -1);

    //F7
    magic := frmmain.GetMagicByKey(char ((6) + byte('1') + byte($14)) );
    if magic <> nil then
      DSkillBar7.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar7.SetImgIndex(g_WMagIconImages, -1);

    //F8
    magic := frmmain.GetMagicByKey(char ((7) + byte('1') + byte($14)) );
    if magic <> nil then
      DSkillBar8.SetImgIndex(g_WMagIconImages, magic.Def.btEffect * 2)
    else
      DSkillBar8.SetImgIndex(g_WMagIconImages, -1);

  end;
end;

procedure TFrmDlg.DSkillBarMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  magic: PTClientMagic;
  key: byte;
begin
  DScreen.ClearHint;
  key := 8;
  if Sender = DSkillBar1 then key := 0;
  if Sender = DSkillBar2 then key := 1;
  if Sender = DSkillBar3 then key := 2;
  if Sender = DSkillBar4 then key := 3;
  if Sender = DSkillBar5 then key := 4;
  if Sender = DSkillBar6 then key := 5;
  if Sender = DSkillBar7 then key := 6;
  if Sender = DSkillBar8 then key := 7;

  if DSkillBar.FaceIndex = 711 then begin
    // F keys
    magic := frmmain.GetMagicByKey(char ((key) + byte('1')) );
  end else begin
    // CTRL+F keys
    magic := frmmain.GetMagicByKey(char ((key) + byte('1') + byte($14)) );
  end;

  if magic <> nil then begin
    if magic.Level = 3 then
      DScreen.ShowHint(mouse.CursorPos.X,mouse.CursorPos.Y,magic.Def.sMagicName, clYellow, TRUE)
    else
      DScreen.ShowHint(mouse.CursorPos.X,mouse.CursorPos.Y,magic.Def.sMagicName +' '
      +inttostr(magic.Level) +'(' +inttostr(magic.CurTrain) +'/'
      +inttostr(magic.Def.MaxTrain[magic.Level]) +')', clYellow, TRUE);
  end;

end;

procedure TFrmDlg.DUSGroupClick(Sender: TObject; X, Y: Integer);
begin

  if UserState1.UserName <> '' then
    if g_GroupMembers.Count = 0 then
      FrmMain.SendCreateGroup(UserState1.UserName)
    else
      FrmMain.SendAddGroupMember(UserState1.UserName);

end;

procedure TFrmDlg.DUSFriendClick(Sender: TObject; X, Y: Integer);
begin
  if UserState1.UserName <> '' then begin
    SendClientMessage(CM_ADDFRIEND, 0, 0, 0, 0, UserState1.UserName);
  end;
end;

procedure TFrmDlg.DUSMailClick(Sender: TObject; X, Y: Integer);
begin
  if UserState1.UserName <> '' then begin
    SendMail(UserState1.UserName);
  end;
end;

procedure TFrmDlg.DSalesMailClick(Sender: TObject; X, Y: Integer);
begin
  if g_AuctionItems[AuctionMenuIndex].Seller <> '' then begin
    SendMail(g_AuctionItems[AuctionMenuIndex].Seller);
  end;
end;

procedure TFrmDlg.DSelectChrClick(Sender: TObject; X, Y: Integer);
begin
  if (((x>46) and (x<268)) and ((y>19) and (y<385))) then
    SelectChrScene.SelChrSelect1Click
  else if (((x>286) and (x<508)) and ((y>19) and (y<385))) then
    SelectChrScene.SelChrSelect2Click
  else if (((x>526) and (x<749)) and ((y>19) and (y<385))) then
    SelectChrScene.SelChrSelect3Click
end;

procedure TFrmDlg.DScrollTopClick(Sender: TObject; X, Y: Integer);
begin
   with DScreen do begin
      if ChatBoardTop > VIEWCHATLINE then
         ChatBoardTop := ChatBoardTop - VIEWCHATLINE
      else ChatBoardTop := 0;
   end;
end;

procedure TFrmDlg.DScrollUpClick(Sender: TObject; X, Y: Integer);
begin
  with DScreen do begin
    if ChatBoardTop > 0 then Dec (ChatBoardTop);
  end;
end;

procedure TFrmDlg.DScrollDownClick(Sender: TObject; X, Y: Integer);
begin
  with DScreen do begin
     if ChatBoardTop < ChatStrs.Count-1 then
        Inc (ChatBoardTop);
  end;
end;

procedure TFrmDlg.DScrollBottomClick(Sender: TObject; X, Y: Integer);
begin
   with DScreen do begin
     if ChatBoardTop + VIEWCHATLINE < ChatStrs.Count-1 then
        ChatBoardTop := ChatBoardTop + VIEWCHATLINE
     else ChatBoardTop := ChatStrs.Count-1;
   if ChatBoardTop < 0 then ChatBoardTop := 0;
  end;
end;

procedure TFrmDlg.DScrollBarDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
//
end;

procedure TFrmDlg.DScrollBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DScrollBarMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DInputKeyEscClick(Sender: TObject; X, Y: Integer);
begin
   DInputKey.Visible := FALSE;
end;

procedure TFrmDlg.DLoginViewKeyClick(Sender: TObject; X, Y: Integer);
begin
   DInputKey.Visible := TRUE;
end;

procedure TFrmDlg.DMsgSimpleDlgOkClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DMsgSimpleDlgOk then DMsgSimpleDlg.DialogResult := mrOk;
   if Sender = DMsgSimpleDlgCancel then DMsgSimpleDlg.DialogResult := mrCancel;
   DMsgSimpleDlg.Visible := FALSE;
end;

procedure TFrmDlg.DMsgSimpleDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  I: Integer;
  d: TDirectDrawSurface;
  ly: integer;
  str, data: string;
  nX,nY:Integer;
begin
   with Sender as TDWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      if m_boPlayDice then begin
        for I := 0 to m_nDiceCount - 1 do begin
          d:=g_WBagItemImages.GetCachedImage(m_Dice[I].nPlayPoint + 376 - 1,nX,nY);
          if d <> nil then begin
            dsurface.Draw (SurfaceX(Left) + m_Dice[I].nX + nX - 14, SurfaceY(Top) + m_Dice[I].nY + nY + 38, d.ClientRect, d, TRUE);
          end;
        end;
      end;

      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      ly := msgly;
      str := MsgText;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then
            BoldTextOut (dsurface, SurfaceX(Left+msglx), SurfaceY(Top+ly), clWhite, clBlack, data);
         ly := ly + 14;
      end;
      dsurface.Canvas.Release;
   end;
   if ViewDlgEdit then begin
      if not EdDlgEdit.Visible then begin
         EdDlgEdit.Visible := TRUE;
         EdDlgEdit.SetFocus;
      end;
   end;
end;

procedure TFrmDlg.DMsgSimpleDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = 13 then begin
      if DMsgSimpleDlgOk.Visible and not DMsgSimpleDlgCancel.Visible then begin
         DMsgSimpleDlg.DialogResult := mrOk;
         DMsgSimpleDlg.Visible := FALSE;
      end;
   end;
   if Key = 27 then begin
      if DMsgSimpleDlgCancel.Visible then begin
         DMsgSimpleDlg.DialogResult := mrCancel;
         DMsgSimpleDlg.Visible := FALSE;
      end;
   end;
end;

procedure TFrmDlg.DBotHelpDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if not d.Downed then begin
         dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end else begin
         dd := d.WLib.Images[d.FaceIndex+1];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DInputKeyEscDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   keyview:string;
begin
  if Sender = DInputKey0 then begin
  keyview := '0';
  end;
  if Sender = DInputKey1 then begin
  keyview := '1';
  end;
  if Sender = DInputKey2 then begin
  keyview := '2';
  end;
  if Sender = DInputKey3 then begin
  keyview := '3';
  end;
  if Sender = DInputKey4 then begin
  keyview := '4';
  end;
  if Sender = DInputKey5 then begin
  keyview := '5';
  end;
  if Sender = DInputKey6 then begin
  keyview := '6';
  end;
  if Sender = DInputKey7 then begin
  keyview := '7';
  end;
  if Sender = DInputKey8 then begin
  keyview := '8';
  end;
  if Sender = DInputKey9 then begin
  keyview := '9';
  end;
  if Sender = DInputKeya then begin
  keyview := 'A';
  end;
  if Sender = DInputKeyb then begin
  keyview := 'B';
  end;
  if Sender = DInputKeyc then begin
  keyview := 'C';
  end;
  if Sender = DInputKeyd then begin
  keyview := 'D';
  end;
  if Sender = DInputKeye then begin
  keyview := 'E';
  end;
  if Sender = DInputKeyf then begin
  keyview := 'F';
  end;
  if Sender = DInputKeyg then begin
  keyview := 'G';
  end;
  if Sender = DInputKeyh then begin
  keyview := 'H';
  end;
  if Sender = DInputKeyi then begin
  keyview := 'I';
  end;
  if Sender = DInputKeyj then begin
  keyview := 'J';
  end;
  if Sender = DInputKeyk then begin
  keyview := 'K';
  end;
  if Sender = DInputKeyl then begin
  keyview := 'L';
  end;
  if Sender = DInputKeym then begin
  keyview := 'M';
  end;
  if Sender = DInputKeyn then begin
  keyview := 'N';
  end;
  if Sender = DInputKeyo then begin
  keyview := 'O';
  end;
  if Sender = DInputKeyp then begin
  keyview := 'P';
  end;
  if Sender = DInputKeyq then begin
  keyview := 'Q';
  end;
  if Sender = DInputKeyr then begin
  keyview := 'R';
  end;
  if Sender = DInputKeys then begin
  keyview := 'S';
  end;
  if Sender = DInputKeyt then begin
  keyview := 'T';
  end;
  if Sender = DInputKeyu then begin
  keyview := 'U';
  end;
  if Sender = DInputKeyv then begin
  keyview := 'V';
  end;
  if Sender = DInputKeyw then begin
  keyview := 'W';
  end;
  if Sender = DInputKeyx then begin
  keyview := 'X';
  end;
  if Sender = DInputKeyy then begin
  keyview := 'Y';
  end;
  if Sender = DInputKeyz then begin
  keyview := 'Z';
  end;
   with Sender as TDButton do begin
      if m_boMouseMove then
         d := WLib.Images[FaceIndex];
         
      if not Downed then
         d := WLib.Images[FaceIndex+1]
      else d := WLib.Images[FaceIndex+2];

      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Size :=9;
          if TDButton(Sender).Downed then begin
            BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(keyview)) div 2 -5), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(keyview)) div 2) + 4, clWhite , clBlack, keyview);
          end else begin
            BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(keyview)) div 2 -5), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(keyview)) div 2) + 4, clWhite , clBlack, keyview);
          end;
      dsurface.Canvas.Font.Size :=9;
      dsurface.Canvas.Release;
   end;
end;

procedure TFrmDlg.DInputKeyEscMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Butt:TDButton;
begin
   Butt:=TDButton(Sender);
   if Sender = Butt then begin
     m_boMouseMove:= TRUE;
   end;
end;

procedure TFrmDlg.DInputKey0Click(Sender: TObject; X, Y: Integer);
var
  EdDlgEdit:hwnd;
  keyname:integer;
begin
  EdDlgEdit := GetFocus;
  if Sender = DInputKey0 then begin
  keyname := $30;
  end;
  if Sender = DInputKey1 then begin
  keyname := $31;
  end;
  if Sender = DInputKey2 then begin
  keyname := $32;
  end;
  if Sender = DInputKey3 then begin
  keyname := $33;
  end;
  if Sender = DInputKey4 then begin
  keyname := $34;
  end;
  if Sender = DInputKey5 then begin
  keyname := $35;
  end;
  if Sender = DInputKey6 then begin
  keyname := $36;
  end;
  if Sender = DInputKey7 then begin
  keyname := $37;
  end;
  if Sender = DInputKey8 then begin
  keyname := $38;
  end;
  if Sender = DInputKey9 then begin
  keyname := $39;
  end;
  if Sender = DInputKeya then begin
  keyname := 65;
  end;
  if Sender = DInputKeyb then begin
  keyname := 66;
  end;
  if Sender = DInputKeyc then begin
  keyname := 67;
  end;
  if Sender = DInputKeyd then begin
  keyname := 68;
  end;
  if Sender = DInputKeye then begin
  keyname := 69;
  end;
  if Sender = DInputKeyf then begin
  keyname := 70;
  end;
  if Sender = DInputKeyg then begin
  keyname := 71;
  end;
  if Sender = DInputKeyh then begin
  keyname := 72;
  end;
  if Sender = DInputKeyi then begin
  keyname := 73;
  end;
  if Sender = DInputKeyj then begin
  keyname := 74;
  end;
  if Sender = DInputKeyk then begin
  keyname := 75;
  end;
  if Sender = DInputKeyl then begin
  keyname := 76;
  end;
  if Sender = DInputKeym then begin
  keyname := 77;
  end;
  if Sender = DInputKeyn then begin
  keyname := 78;
  end;
  if Sender = DInputKeyo then begin
  keyname := 79;
  end;
  if Sender = DInputKeyp then begin
  keyname := 80;
  end;
  if Sender = DInputKeyq then begin
  keyname := 81;
  end;
  if Sender = DInputKeyr then begin
  keyname := 82;
  end;
  if Sender = DInputKeys then begin
  keyname := 83;
  end;
  if Sender = DInputKeyt then begin
  keyname := 84;
  end;
  if Sender = DInputKeyu then begin
  keyname := 85;
  end;
  if Sender = DInputKeyv then begin
  keyname := 86;
  end;
  if Sender = DInputKeyw then begin
  keyname := 87;
  end;
  if Sender = DInputKeyx then begin
  keyname := 88;
  end;
  if Sender = DInputKeyy then begin
  keyname := 89;
  end;
  if Sender = DInputKeyz then begin
  keyname := 90;
  end;
  PostMessage(EdDlgEdit,WM_KEYDOWN,keyname,0);
end;

procedure TFrmDlg.DInputKeyDelClick(Sender: TObject; X, Y: Integer);
var
  EdDlgEdit:hwnd;
  keyname:integer;
begin
  EdDlgEdit := GetFocus;
  PostMessage(EdDlgEdit,WM_KEYDOWN,8,0);
end;

procedure TFrmDlg.DInputKeyEnterClick(Sender: TObject; X, Y: Integer);
var
  EdDlgEdit:hwnd;
  keyname:integer;
begin
  EdDlgEdit := GetFocus;
  PostMessage(EdDlgEdit,WM_KEYDOWN,13,0);
end;

procedure TFrmDlg.DInputKeyRandClick(Sender: TObject; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DBotHelpClick(Sender: TObject; X, Y: Integer);
begin
  OpenHelpWin();
end;

procedure TFrmDlg.OpenHelpWin();
begin
  DHelpWin.Visible:=not DHelpWin.Visible;
end;

procedure TFrmDlg.DHelpCloseClick(Sender: TObject; X, Y: Integer);
begin
  DHelpWin.Visible:=FALSE;
end;

procedure TFrmDlg.DHelpWinDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  i, n, bx, by, bbx, bby: integer;
begin
   with DHelpWin do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      case HelpPage of
         0: begin
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+70), SurfaceY(Top+113), '快捷键');
               TextOut (SurfaceX(Left+200), SurfaceY(Top+113), '详细说明');
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '1  / 11');
               Release;
            end;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clYellow;
               TextOut (SurfaceX(Left+70), SurfaceY(Top+140), 'Alt + Q');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+160), 'Alt + X');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+180), 'F9, I');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+200), 'F10, C');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+220), 'F11, S');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+240), 'F1 ~ F8');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+260), 'W');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+280), 'P');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+300), 'T');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+320), 'V');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+340), 'G');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+360), 'Y');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+380), 'J');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+400), 'M');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+420), 'L');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+440), 'Z');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+460), 'O');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+480), 'H');
            end;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+160), SurfaceY(Top+140), '退出游戏');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+160), '重新启动游戏，退回至服务器角色选择界面');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+180), '打开/关闭角色状态窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+200), '打开/关闭包裹窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+220), '打开/关闭角色魔法能力窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+240), '由玩家自己设置的快捷键，魔法技能的快捷键');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+260), '打开/关闭好友窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+280), '打开/关闭组队窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+300), '打开交易');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+320), '打开/关闭小地图');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+340), '打开/关闭公会窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+360), '打开/关闭游戏商城窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+380), '打开/关闭礼物窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+400), '打开/关闭邮件窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+420), '打开/关闭关系窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+440), '打开/关闭腰带');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+460), '打开/关闭设置窗口');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+480), '打开/关闭帮助窗口');
               Release;
            end;
         end;
         1: begin
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+70), SurfaceY(Top+113), '快捷键');
               TextOut (SurfaceX(Left+200), SurfaceY(Top+113), '详细说明');
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '2  / 11');
               Release;
            end;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clYellow;
               TextOut (SurfaceX(Left+70), SurfaceY(Top+140), 'Ctrl + A');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+160), 'Ctrl + F');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+180), 'Ctrl + H');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+300), 'B');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+320), '~');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+340), 'R');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+360), 'D');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+380), 'U');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+400), 'Tab');
               TextOut (SurfaceX(Left+70), SurfaceY(Top+420), 'Ctrl+????');
            end;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+160), SurfaceY(Top+140), '改变宠物状态');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+160), '改版游戏的字体，你可以选择6种不同的字体');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+180), '选择自己喜欢的攻击模式');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+200), '和平攻击模式：对任何玩家攻击都无效');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+220), '行会联盟攻击模式：对自己行会内的其他玩家攻击无效');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+240), '编组攻击模式：处于同一小组的玩家攻击无效');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+260), '全体攻击模式：对所有的玩家都具有攻击效果');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+280), '善恶攻击模式：PK红名专用攻击模式');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+300), '打开/关闭大地图');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+320), '未知');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+340), '打开/关闭技能栏');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+360), '打开/关闭自动跑步');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+380), '未知');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+400), '显示地面物品');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+420), '未知');
               Release;
            end;
         end;
         2: begin
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+70), SurfaceY(Top+113), '快捷键');
               TextOut (SurfaceX(Left+200), SurfaceY(Top+113), '详细说明');
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '3  / 11');
               Release;
            end;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clYellow;
               TextOut (SurfaceX(Left+60), SurfaceY(Top+140), '/玩家名字');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+160), '!交流文字');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+180), '!!文字');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+200), '!~文字');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+220), '@拒绝私聊');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+240), '@拒绝+人名');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+260), '@拒绝公会聊天');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+280), '@退出门派');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+300), '上下方向键');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+320), ',');
            end;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+160), SurfaceY(Top+140), '向指定玩家发言');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+160), '向所有人发言');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+180), '如果你们创建了小组，你所发的信息将被组内的其他玩家看见');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+200), '这种广播功能只提供给同一行会的玩家');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+220), '拒绝所有的私人聊天的命令');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+240), '对特定的某一个人聊天文字进行屏蔽');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+260), '屏蔽行会聊天所有消息的命令');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+280), '脱离公会');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+300), '按上或者下键可查看过去的聊天信息');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+320), '未知');
               Release;
            end;
         end;
         3: begin
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+70), SurfaceY(Top+113), '等级');
               TextOut (SurfaceX(Left+200), SurfaceY(Top+113), '升级地点');
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '4  / 11');
               Release;
            end;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clYellow;
               TextOut (SurfaceX(Left+60), SurfaceY(Top+140), 'Lv 1~10');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+160), 'Lv 11~20');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+180), 'Lv 21~30');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+200), 'Lv 31~40');
               TextOut (SurfaceX(Left+60), SurfaceY(Top+220), 'Lv 41~50');
            end;
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+160), SurfaceY(Top+140), '设定中...');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+160), '设定中...');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+180), '设定中...');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+200), '设定中...');
               TextOut (SurfaceX(Left+160), SurfaceY(Top+220), '设定中...');
               Release;
            end;
         end;
         4: begin
            bbx := Left + 45;
            bby := Top + 103;
            d := g_WMainImages.Images[923];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, TRUE);
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '5  / 11');
               Release;
            end;
         end;
         5: begin
            bbx := Left + 45;
            bby := Top + 103;
            d := g_WMainImages.Images[924];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, TRUE);
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '6  / 11');
               Release;
            end;
         end;
         6: begin
            bbx := Left + 45;
            bby := Top + 103;
            d := g_WMainImages.Images[925];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, TRUE);
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '7  / 11');
               Release;
            end;
         end;
         7: begin
            bbx := Left + 45;
            bby := Top + 103;
            d := g_WMainImages.Images[926];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, TRUE);
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '8  / 11');
               Release;
            end;
         end;
         8: begin
            bbx := Left + 45;
            bby := Top + 103;
            d := g_WMainImages.Images[927];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, TRUE);
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '9  / 11');
               Release;
            end;
         end;
         9: begin
            bbx := Left + 45;
            bby := Top + 103;
            d := g_WMainImages.Images[928];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, TRUE);
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '10 / 11');
               Release;
            end;
         end;
         10: begin
            bbx := Left + 45;
            bby := Top + 103;
            d := g_WMainImages.Images[929];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, TRUE);
            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clWhite;
               TextOut (SurfaceX(Left+272), SurfaceY(Top+543), '11 / 11');
               Release;
            end;
         end;
      end;
      if HelpPage = 0 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '1.基本快捷键');
        end;
      end;
      if HelpPage = 1 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '2.辅助快捷键');
        end;
      end;
      if HelpPage = 2 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '3.特殊命令');
        end;
      end;
      if HelpPage = 3 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '4.升级地图向导');
        end;
      end;
      if HelpPage = 4 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '5.游戏操作1');
        end;
      end;
      if HelpPage = 5 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '5.游戏操作2');
        end;
      end;
      if HelpPage = 6 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '5.游戏操作3');
        end;
      end;
      if HelpPage = 7 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '5.游戏操作4');
        end;
      end;
      if HelpPage = 8 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '5.游戏操作5');
        end;
      end;
      if HelpPage = 9 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '5.游戏操作6');
        end;
      end;
      if HelpPage = 10 then begin
        with dsurface.Canvas do begin
          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Color := clWhite;
          dsurface.Canvas.Font.Size :=11;
          dsurface.Canvas.Font.Style:=[fsBold];
          TextOut (Left+240, Top+70, '5.游戏操作7');
        end;
      end;
          dsurface.Canvas.Font.Style:=[];
          dsurface.Canvas.Font.Size :=9;
          dsurface.Canvas.Release;
   end;
end;


procedure TFrmDlg.DHelpPrevClick(Sender: TObject; X, Y: Integer);
begin
   Dec (HelpPage);
   if HelpPage < 0 then
      HelpPage := MAXHELPPAGE-1;
//   PageChanged;
end;

procedure TFrmDlg.DHelpNextClick(Sender: TObject; X, Y: Integer);
begin
   Inc (HelpPage);
   if HelpPage > MAXHELPPAGE-1 then
      HelpPage := 0;
//   PageChanged;
end;

procedure TFrmDlg.DItemShopDlgClick(Sender: TObject; X, Y: Integer);
var
   lx, ly, idx: integer;
begin
   DScreen.ClearHint;
   lx := DItemShopDlg.LocalX (X) - DItemShopDlg.Left;
   ly := DItemShopDlg.LocalY (Y) - DItemShopDlg.Top;
   if (lx >= 150) and (lx <= 517) and (ly >= 107) and (ly <= 335) then begin
      idx := (lx-32-20) div SHOPLISTLINEWIDTH + ShopMenuTop;
      //if idx < ShopMenuList.Count then begin
         PlaySound (s_glass_button_click);
         ShopMenuIndex := idx;
      //end;
   end;
end;

procedure TFrmDlg.DItemShopDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
      Result := DShopMenuDlg.SurfaceX (DItemShopDlg.Left + x);
  end;
  function SY(y: integer): integer;
  begin
      Result := DShopMenuDlg.SurfaceY (DItemShopDlg.Top + y);
  end;
var
   e, d ,f: TDirectDrawSurface;
   m,lh,i,rowcount,rowoffset, idx, ax, ay,menuline: integer;
   ceff: TColorEffect;
   wimg: TWMImages;
   m_nCurrentFrame,bax,bay: integer;
   lx,ly,dx,dy:integer;
   pisi: pTItemShopItem;
//   HumActor:THumActor;
//   Actor:TActor;
begin
  m_nCurrentFrame := -1;
  with sender as TDWindow do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      lx := 57+(ShopMenuIndex-ShopMenuTop) * SHOPLISTLINEWIDTH;
      ly := 107;
       if ShopMenuIndex > -1 then begin
          e := g_WMainImages.Images[811];
          if e <> nil then
             dsurface.Draw (SX(lx), SY(ly), e.ClientRect, e, TRUE);
       end;

       if ShopMenuIndex >= -1 then begin
       lh := SHOPLISTLINEWIDTH;
       menuline := _MIN(NEWMAXMENU, MenuList.Count-MenuTop);
       for i:=ShopMenuTop to ShopMenuTop+menuline-1 do begin
       m := i-ShopMenuTop;
       pisi := pTItemShopItem (ShopMenuList[i]);
       f := g_WBagItemImages.Images[pisi.looks];
          if f <> nil then
          dsurface.Draw (Sx(DItemShopDlg.Width-f.Width) div 2 - 92, SY(DItemShopDlg.Height-f.Height) div 2 + m*lh, f.ClientRect, f, TRUE);
          end;
       end;

  { if Actor.m_btDress > 31 then
     e := FrmMain.GetWHum2Img(Actor.m_btDress - 32,Actor.m_btSex ,m_nCurrentFrame, Actor.m_nPx, Actor.m_nPy)
   else e := FrmMain.GetWHumImg(Actor.m_btDress,Actor.m_btSex ,m_nCurrentFrame, Actor.m_nPx, Actor.m_nPy);

   if e = nil then
     e := FrmMain.GetWHumImg(0,Actor.m_btSex ,m_nCurrentFrame, Actor.m_nPx, Actor.m_nPy);

     if e <> nil then begin
       dsurface.Draw (SurfaceX(Left+575), SurfaceY(Top+170), e.ClientRect, e, TRUE); }

       {HumActor.LoadSurface;
      if Actor.m_BodySurface <> nil then
         //Actor.DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
         DrawBlend (dsurface, dx + Actor.m_nShiftX, dy + Actor.m_nShiftY, Actor.m_BodySurface, 1); }

       if ShopMenuIndex >= -1 then begin
       lh := SHOPLISTLINEWIDTH;
       menuline := _MIN(SHOPMAXMENU, ShopMenuList.Count-MenuTop);
       for i:=ShopMenuTop to ShopMenuTop+menuline-1 do begin
       m := i-ShopMenuTop;
       pisi := pTItemShopItem (ShopMenuList[i]);
       f := g_WBagItemImages.Images[pisi.looks];
          if e <> nil then
          dsurface.Draw (Sx(DShopMenuDlg.Width-f.Width) div 2 - 92, SY(DShopMenuDlg.Height-f.Height) div 2 + m*lh, f.ClientRect, f, TRUE);
          end;
       end;
      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clWhite;

         lh := SHOPLISTLINEWIDTH;
         menuline := _MIN(NEWMAXMENU, MenuList.Count-MenuTop);
         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            Font.Color := clWhite;
            pisi := pTItemShopItem (ShopMenuList[i]);
            //TextOut (SX(75),  SY(33 + m*lh), pisi.Name);
            {if pisi.SubMenu >= 1 then
               TextOut (SX(137), SY(40 + m*lh), #31);
            TextOut (SX(75), SY(46 + m*lh), '价格:' +IntToStr(pg.Price) +  g_sGoldName);
            str := '';
            if pg.Grade = -1 then str := '-'
            else TextOut (SX(170), SY(40 + m*lh), '持久度:'+IntToStr(pg.Grade));
         end;  }
    Release;
  end;
end;

{      rowcount:=0;
      rowoffset:=19;

      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      with dsurface.Canvas do begin
        Font.Color := clWhite;
        TextOut (SurfaceX(Left)+375, SurfaceY(Top)+402, IntToStr(g_ItemShopCurrPage) + '/' + IntToStr(g_ItemShopTotalPage));
        for i:= 0 to g_ItemShopAmountofPages - 1 do begin
          if GameShopMenuIndex = i then begin
            Font.Color := clRed;
          end else
            Font.Color := clWhite;
           TextOut (SurfaceX(Left)+330, SurfaceY(Top)+190+(rowoffset*rowcount),g_ItemShopItems[i].Name);
           TextOut (SurfaceX(Left)+365, SurfaceY(Top)+190+(rowoffset*rowcount),IntToStr(g_ItemShopItems[i].Price));
          inc(rowcount);
        end;
      end;
      dsurface.Canvas.Release;
    end; }

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         Font.Size :=11;
         dsurface.Canvas.Font.Style:=[fsBold];
         TextOut (SurfaceX(Left + 315),SurfaceY(Top + 13), '传奇商城');
         Release;
      end;
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         Font.Style:=[];
         Font.Size :=9;
         TextOut (SurfaceX(Left+510), SurfaceY(Top+439), GetGoldStr(g_MySelf.m_nGameGold));
         Release;
      end;
         dsurface.Canvas.Font.Style:=[];
         dsurface.Canvas.Font.Size :=9;
         dsurface.Canvas.Release;
      end;
//      DItemShopDlg.Left := 470+EdShopEdit.Left;
//      DItemShopDlg.Top  := 45+EdShopEdit.Top;
//    end;
  end;
end;



procedure TFrmDlg.DItemShopDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = 13 then begin
      FrmDlg.DItemShopFindClick(Self,0,0);
   end;
end;

procedure TFrmDlg.DItemShopDlgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DItemShopDlgMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DItemShopCloseClick(Sender: TObject; X, Y: Integer);
begin
  DItemShopDlg.Visible:=FALSE;
  EdShopEdit.Visible := FALSE;
end;

procedure TFrmDlg.DBotItemShopClick(Sender: TObject; X, Y: Integer);
begin
  OpenItemShopDlg();
  ShopMenuTop:=0;
//  frmMain.SendOpenGameShop;
end;

procedure TFrmDlg.OpenItemShopDlg();
begin
  DItemShopDlg.Visible:=not DItemShopDlg.Visible;
 DItemShopJobAll.SetImgIndex (g_WMainImages, 800);
 DItemShopJobWarrior.SetImgIndex (g_WMainImages, 803);
 DItemShopJobWizard.SetImgIndex (g_WMainImages, 805);
 DItemShopJobMonk.SetImgIndex (g_WMainImages, 807);
 DItemShopJobCommon.SetImgIndex (g_WMainImages, 809);

  if DItemShopDlg.Visible = true then begin
    EdShopEdit.Visible := true;
    EdShopEdit.Text := '';
    SetDFocus(FrmDlg.DItemShopDlg);
  end else begin
    EdShopEdit.Visible := false;
  end;
end;

procedure TFrmDlg.DItemShopJobAllDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDButton;
   dd: TDirectDrawSurface;
begin
   if Sender is TDButton then begin
      d := TDButton(Sender);
      if not d.Downed then begin
         dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end else begin
         dd := d.WLib.Images[d.FaceIndex];
         if dd <> nil then
            dsurface.Draw (d.SurfaceX(d.Left), d.SurfaceY(d.Top), dd.ClientRect, dd, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DItemShopJobAllMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg: String;
begin
//  DScreen.ClearHint;
  Butt:=TDButton(Sender);
  if Sender = DItemShopJobAll then sMsg:= '全部'
  else if Sender = DItemShopJobWarrior then sMsg:= '战士'
  else if Sender = DItemShopJobWizard then sMsg:= '法师'
  else if Sender = DItemShopJobMonk then sMsg:= '道士'
  else if Sender = DItemShopJobCommon then begin sMsg:= '通用'
  end;
  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DItemShopDlg.SurfaceX(DItemShopDlg.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DItemShopDlg.SurfaceY(DItemShopDlg.Top) + nLocalY;
  DScreen.ShowHint(nHintX,nHintY,sMsg, clYellow, TRUE);
end;

procedure TFrmDlg.DItemShopJobAllClick(Sender: TObject; X, Y: Integer);
begin
 DItemShopJobAll.SetImgIndex (g_WMainImages, 800);
 DItemShopJobWarrior.SetImgIndex (g_WMainImages, 803);
 DItemShopJobWizard.SetImgIndex (g_WMainImages, 805);
 DItemShopJobMonk.SetImgIndex (g_WMainImages, 807);
 DItemShopJobCommon.SetImgIndex (g_WMainImages, 809);
end;

procedure TFrmDlg.DItemShopJobWarriorClick(Sender: TObject; X, Y: Integer);
begin
 DItemShopJobAll.SetImgIndex (g_WMainImages, 801);
 DItemShopJobWarrior.SetImgIndex (g_WMainImages, 802);
 DItemShopJobWizard.SetImgIndex (g_WMainImages, 805);
 DItemShopJobMonk.SetImgIndex (g_WMainImages, 807);
 DItemShopJobCommon.SetImgIndex (g_WMainImages, 809);
end;

procedure TFrmDlg.DItemShopJobWizardClick(Sender: TObject; X, Y: Integer);
begin
 DItemShopJobAll.SetImgIndex (g_WMainImages, 801);
 DItemShopJobWarrior.SetImgIndex (g_WMainImages, 803);
 DItemShopJobWizard.SetImgIndex (g_WMainImages, 804);
 DItemShopJobMonk.SetImgIndex (g_WMainImages, 807);
 DItemShopJobCommon.SetImgIndex (g_WMainImages, 809);
end;

procedure TFrmDlg.DItemShopJobMonkClick(Sender: TObject; X, Y: Integer);
begin
 DItemShopJobAll.SetImgIndex (g_WMainImages, 801);
 DItemShopJobWarrior.SetImgIndex (g_WMainImages, 803);
 DItemShopJobWizard.SetImgIndex (g_WMainImages, 805);
 DItemShopJobMonk.SetImgIndex (g_WMainImages, 806);
 DItemShopJobCommon.SetImgIndex (g_WMainImages, 809);
end;

procedure TFrmDlg.DItemShopJobCommonClick(Sender: TObject; X, Y: Integer);
begin
 DItemShopJobAll.SetImgIndex (g_WMainImages, 801);
 DItemShopJobWarrior.SetImgIndex (g_WMainImages, 803);
 DItemShopJobWizard.SetImgIndex (g_WMainImages, 805);
 DItemShopJobMonk.SetImgIndex (g_WMainImages, 807);
 DItemShopJobCommon.SetImgIndex (g_WMainImages, 808);
end;

procedure TFrmDlg.DGrpPgUpClick(Sender: TObject; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DGrpPgDnClick(Sender: TObject; X, Y: Integer);
begin
//
end;



procedure TFrmDlg.DItemShopCaAllDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   ShopCaView,ShopCaSubView:string;
begin
  if Sender = DItemShopCaNew then begin
  ShopCaView := '最新';
  end;
  if Sender = DItemShopCaAll then begin
  ShopCaView := '全部';
  end;
  if Sender = DItemShopCaWeapon then begin
  ShopCaView := '武器';
  end;
  if Sender = DItemShopCaArmor then begin
  ShopCaView := '盔甲';
  end;
  if Sender = DItemShopCaAcc then begin
  ShopCaView := '辅助';
  end;
  if Sender = DItemShopCasSubitem then begin
  ShopCaView := '细节';
  end;
  if Sender = DItemShopCaPackage then begin
  ShopCaView := '包囊';
  end;
  if Sender = DItemShopCaOther then begin
  ShopCaView := '特殊';
  end;
  if Sender = DItemShopCaSub1 then begin
  ShopCaSubView := '分类1';
  end;
  if Sender = DItemShopCaSub2 then begin
  ShopCaSubView := '分类2';
  end;
  if Sender = DItemShopCaSub3 then begin
  ShopCaSubView := '分类3';
  end;
  if Sender = DItemShopCaSub4 then begin
  ShopCaSubView := '分类4';
  end;
  if Sender = DItemShopCaSub5 then begin
  ShopCaSubView := '分类5';
  end;
  if Sender = DItemShopCaSub6 then begin
  ShopCaSubView := '分类6';
  end;
  if Sender = DItemShopCaSub7 then begin
  ShopCaSubView := '分类7';
  end;
  if Sender = DItemShopCaFav then begin
  ShopCaSubView := '购物车';
  end;
   with Sender as TDButton do begin
      if not Downed then
         d := WLib.Images[FaceIndex]
      else d := WLib.Images[FaceIndex+1];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Size :=9;
          if TDButton(Sender).Downed then begin
            BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(ShopCaView)) div 2), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(ShopCaView)) div 2), clWhite , clBlack, ShopCaView);
            BoldTextOut (dsurface, SurfaceX(Left + 15), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(ShopCaSubView)) div 2), clWhite , clBlack, ShopCaSubView);
          end else begin
            BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(ShopCaView)) div 2), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(ShopCaView)) div 2), clWhite , clBlack, ShopCaView);
            BoldTextOut (dsurface, SurfaceX(Left + 15), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(ShopCaSubView)) div 2), clWhite , clBlack, ShopCaSubView);
          end;
      dsurface.Canvas.Font.Size :=9;
      dsurface.Canvas.Release;
   end;
end;

procedure TFrmDlg.DItemShopCaAllMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DCountDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  I: Integer;
  d: TDirectDrawSurface;
  ly: integer;
  str, data: string;
  nX,nY:Integer;
begin
   with Sender as TDWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      if m_boPlayDice then begin
        for I := 0 to m_nDiceCount - 1 do begin
          d:=g_WBagItemImages.GetCachedImage(m_Dice[I].nPlayPoint + 376 - 1,nX,nY);
          if d <> nil then begin
            dsurface.Draw (SurfaceX(Left) + m_Dice[I].nX + nX - 14, SurfaceY(Top) + m_Dice[I].nY + nY + 38, d.ClientRect, d, TRUE);
          end;
        end;
      end;

      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      ly := msgly;
      str := MsgText;
      while TRUE do begin
         if str = '' then break;
         str := GetValidStr3 (str, data, ['\']);
         if data <> '' then
            BoldTextOut (dsurface, SurfaceX(Left+msglx), SurfaceY(Top+ly), clWhite, clBlack, data);
         ly := ly + 14;
      end;
      dsurface.Canvas.Release;
   end;
   if ViewDlgEdit then begin
      if not EdDlgEdit.Visible then begin
         EdDlgEdit.Visible := TRUE;
         EdDlgEdit.SetFocus;
      end;
   end;
end;

procedure TFrmDlg.DCountDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = 13 then begin
      if DCountDlgOk.Visible and not DCountDlgCancel.Visible then begin
         DCountDlg.DialogResult := mrOk;
         DCountDlg.Visible := FALSE;
      end;
   end;
   if Key = 27 then begin
      if DCountDlgCancel.Visible then begin
         DCountDlg.DialogResult := mrCancel;
         DCountDlg.Visible := FALSE;
      end;
   end;
end;

procedure TFrmDlg.DCountDlgOkClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DCountDlgMax then DCountDlg.DialogResult := mrYesToAll;
   if Sender = DCountDlgOk then DCountDlg.DialogResult := mrOk;
   DCountDlg.Visible := FALSE;
end;

procedure TFrmDlg.DCountDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  DCountDlg.Visible:= FALSE;
end;

procedure TFrmDlg.DItemShopGetGiftDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      if Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then begin
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
         end;
   end;
   end;
end;


procedure TFrmDlg.DItemShopGetGiftMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDButton;
  sMsg: String;
begin
//  DScreen.ClearHint;
  Butt:=TDButton(Sender);
  if Sender = DItemShopGetGift then sMsg:= '接收礼物'
  else if Sender = DItemShopAddFav then sMsg:= '增加到购物车'
  else if Sender = DItemShopBye then sMsg:= '购买'
  else if Sender = DItemShopGift then sMsg:= '发送礼物'
  else if Sender = DItemShopPayMoney then begin sMsg:= '充值'

  end;

  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DItemShopDlg.SurfaceX(DItemShopDlg.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DItemShopDlg.SurfaceY(DItemShopDlg.Top) + nLocalY;
  DScreen.ShowHint(nHintX,nHintY,sMsg, clYellow, TRUE);
end;

procedure TFrmDlg.DShopScrollBarDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
//
end;

procedure TFrmDlg.DShopScrollBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DShopScrollBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

//新商店菜单
procedure TFrmDlg.DShopMenuDlgClick(Sender: TObject; X, Y: Integer);
var
   lx, ly, idx: integer;
   iname, d1, d2, d3: string;
   useable: Boolean;
   tempi:PTClientGoods;
begin
   DScreen.ClearHint;
   lx := DShopMenuDlg.LocalX (X) - DShopMenuDlg.Left;
   ly := DShopMenuDlg.LocalY (Y) - DShopMenuDlg.Top;
   if (lx >= 28) and (lx <= 235) and (ly >= 30) and (ly <= 200)  then begin
      idx := (ly-29) div NEWLISTLINEHEIGHT + MenuTop;
      if idx < MenuList.Count then begin
         PlaySound (s_glass_button_click);
         MenuIndex := idx;
      end;
   end;

   if BoStorageMenu then begin
      if (MenuIndex >= 0) and (MenuIndex < g_SaveItemList.Count) then begin
         g_MouseItem := PTClientItem(g_SaveItemList[MenuIndex])^;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         if iname <> '' then begin
            lx := 240;
            ly := 32+(MenuIndex-MenuTop) * NEWLISTLINEHEIGHT;
            with Sender as TDButton do
               DScreen.ShowHint (DShopMenuDlg.SurfaceX(Left + lx),
                                 DShopMenuDlg.SurfaceY(Top + ly),
                                 iname + d1 + '\' + d2 + '\' + d3, clYellow, FALSE);
         end;
         g_MouseItem.S.Name := '';
      end;
   end else if FrmDlg.BoMakeGem then begin
   tempi := PTClientGoods(MenuList[MenuIndex]);
   SendClientMessage(CM_GEMINFO, g_nCurMerchant, 0, 0, 0, '@Info' + tempi.name);
    end;
      if (MenuIndex >= 0) and (MenuIndex < g_MenuItemList.Count) and (PTClientGoods (MenuList[MenuIndex]).SubMenu = 0) then begin
         g_MouseItem := PTClientItem(g_MenuItemList[MenuIndex])^;
         BoNoDisplayMaxDura := TRUE;
         GetMouseItemInfo (iname, d1, d2, d3, useable);
         BoNoDisplayMaxDura := FALSE;
         if iname <> '' then begin
            lx := 240;
            ly := 32+(MenuIndex-MenuTop) * NEWLISTLINEHEIGHT;
            with Sender as TDButton do
               DScreen.ShowHint (DShopMenuDlg.SurfaceX(Left + lx),
                                 DShopMenuDlg.SurfaceY(Top + ly),
                                 iname + d1 + '\' + d2 + '\' + d3, clYellow, FALSE);
         end;
         g_MouseItem.S.Name := '';
      end;
end;

procedure TFrmDlg.DShopMenuDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
  function SX(x: integer): integer;
  begin
      Result := DShopMenuDlg.SurfaceX (DShopMenuDlg.Left + x);
  end;
  function SY(y: integer): integer;
  begin
      Result := DShopMenuDlg.SurfaceY (DShopMenuDlg.Top + y);
  end;
var
   idx, n, lx, ly, i, lh, k, m, menuline: integer;
   d,e,f: TDirectDrawSurface;
   pg: PTClientGoods;
   str: string;
   iname, d1, d2, d3: string;
   useable:Boolean;
begin
   with dsurface.Canvas do begin
      with DShopMenuDlg do begin
         d := DShopMenuDlg.WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;

      lx := 29;
      ly := 30+(MenuIndex-MenuTop) * NEWLISTLINEHEIGHT;
       if MenuIndex > -1 then begin
          e := g_WMainImages.Images[1001];
          if e <> nil then
             dsurface.Draw (SX(lx), SY(ly), e.ClientRect, e, TRUE);
       end;

       if MenuIndex >= -1 then begin
       lh := NEWLISTLINEHEIGHT;
       menuline := _MIN(NEWMAXMENU, MenuList.Count-MenuTop);
       for i:=MenuTop to MenuTop+menuline-1 do begin
       m := i-MenuTop;
       pg := PTClientGoods (MenuList[i]);
       f := g_WBagItemImages.Images[pg.looks];
          if e <> nil then
          dsurface.Draw (Sx(DShopMenuDlg.Width-f.Width) div 2 - 92, SY(DShopMenuDlg.Height-f.Height) div 2 + m*lh, f.ClientRect, f, TRUE);
          end;
       end;


      SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
      SetBkMode (Handle, TRANSPARENT);
      Font.Color := clWhite;
         lh := NEWLISTLINEHEIGHT;
         menuline := _MIN(NEWMAXMENU, MenuList.Count-MenuTop);
         for i:=MenuTop to MenuTop+menuline-1 do begin
         //if i = MenuIndex then begin
         //g_MouseItem := PTClientGoods (MenuList[i]);
         GetMouseItemInfo (iname, d1, d2, d3, useable);
            Font.Color := clYellow;
            TextOut (DShopMenuDlg.Left+10, DShopMenuDlg.Top+240, iname);
            Font.Color := clWhite;
            TextOut (DShopMenuDlg.Left+10 + textwidth(iname), DShopMenuDlg.Top+240, d1);
            TextOut (DShopMenuDlg.Left+10, DShopMenuDlg.Top+240+14, d2);
            if not useable then
               Font.Color := clRed;
            TextOut (DShopMenuDlg.Left+10, DShopMenuDlg.Top+240+(14*2), d3);
         //end;}
            m := i-MenuTop;
            Font.Color := clWhite;
            pg := PTClientGoods (MenuList[i]);
            TextOut (SX(75),  SY(33 + m*lh), pg.Name);

            if pg.SubMenu >= 1 then
               TextOut (SX(137), SY(40 + m*lh), #31);
            TextOut (SX(75), SY(46 + m*lh), '价格:' +IntToStr(pg.Price) +  g_sGoldName);
            str := '';
            if pg.Grade = -1 then str := '-'
            else TextOut (SX(170), SY(40 + m*lh), '持久度:'+IntToStr(pg.Grade));
         end;
    Release;
  end;
end;


procedure TFrmDlg.DShopMenuDlgMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   with DShopMenuDlg do
    if (X < SurfaceX(Left+10)) or (X > SurfaceX(Left+Width-20)) or (Y < SurfaceY(Top+30)) or (Y > SurfaceY(Top+Height-50)) then begin
       DScreen.ClearHint;
    end;
end;

procedure TFrmDlg.DShopMenuScrollUpClick(Sender: TObject; X, Y: Integer);
begin
   if not BoDetailMenu then begin
      if MenuTop > 0 then Dec (MenuTop, NEWMAXMENU-1);
      if MenuTop < 0 then MenuTop := 0;
   end else begin
      if MenuTopLine > 0 then begin
         MenuTopLine := _MAX(0, MenuTopLine-3);
         FrmMain.SendGetDetailItem (g_nCurMerchant, MenuTopLine, CurDetailItem);
      end;
   end;
   MenuIndex:= -1 
end;

procedure TFrmDlg.DShopMenuScrollDownClick(Sender: TObject; X, Y: Integer);
begin
   if not BoDetailMenu then begin
      if MenuTop + NEWMAXMENU < MenuList.Count then Inc (MenuTop, NEWMAXMENU-1);
   end else begin
      MenuTopLine := MenuTopLine + 3;
      FrmMain.SendGetDetailItem (g_nCurMerchant, MenuTopLine, CurDetailItem);
   end;
   MenuIndex:= -1
end;

procedure TFrmDlg.DShopMenuScrollBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DShopMenuScrollBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DShopMenuOkClick(Sender: TObject; X, Y: Integer);
var
   pg: PTClientGoods;
   tempi: PTClientGoods;
begin
   if GetTickCount < LastestClickTime then exit;
   if (MenuIndex >= 0) and (MenuIndex < MenuList.Count) then begin
      pg := PTClientGoods (MenuList[MenuIndex]);
      LastestClickTime := GetTickCount + 5000;
      if pg.SubMenu > 0 then begin
         FrmMain.SendGetDetailItem (g_nCurMerchant, 0, pg.Name);
         MenuTopLine := 0;
         CurDetailItem := pg.Name;
      end else begin
         if BoMakeDrugMenu then begin
            FrmMain.SendMakeDrugItem (g_nCurMerchant, pg.Name);
            exit;
         end;
         if BoMakeGem then begin
          sMakeGemName:=pg.Name;
          g_GemItem1.S.Name := '';
          g_GemItem1.MakeIndex :=0;
          g_GemItem2.S.Name := '';
          g_GemItem2.MakeIndex :=0;
          g_GemItem3.S.Name := '';
          g_GemItem3.MakeIndex :=0;
          g_GemItem4.S.Name := '';
          g_GemItem4.MakeIndex :=0;
          g_GemItem5.S.Name := '';
          g_GemItem5.MakeIndex :=0;
          g_GemItem6.S.Name := '';
          g_GemItem6.MakeIndex :=0;
          DGemMakeItem.Visible := True;
          exit;
         end;
         FrmMain.SendBuyItem (g_nCurMerchant, pg.Stock, pg.Name)
      end;
   end;
end;

procedure TFrmDlg.DShopMenuCloseClick(Sender: TObject; X, Y: Integer);
begin
   DShopMenuDlg.Visible := FALSE;
end;

procedure TFrmDlg.DDcJunsaBuffDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with sender as TDWindow do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
        dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      end;
    end;
  end;
end;

procedure TFrmDlg.DWemadeBuffMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  nLocalX,nLocalY:Integer;
  nHintX,nHintY:Integer;
  Butt:TDWindow;
  sMsg: String;
begin
//  DScreen.ClearHint;
  Butt:=TDWindow(Sender);
  if Sender = DWemadeBuff then sMsg:= '经验:100%\' + '爆率:100%'
  else if Sender = DWemadeBuff2 then begin sMsg:= '????'
  end;
  nLocalX:=Butt.LocalX(X - Butt.Left);
  nLocalY:=Butt.LocalY(Y - Butt.Top);
  nHintX:=Butt.SurfaceX(Butt.Left) + DBackground.SurfaceX(DBackground.Left) + nLocalX;
  nHintY:=Butt.SurfaceY(Butt.Top) + DBackground.SurfaceY(DBackground.Top) + nLocalY +45;
  DScreen.ShowHint(nHintX,nHintY,sMsg, clYellow, TRUE);
end;

procedure TFrmDlg.DItemStoreDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d0, d1, d2, d3: string;
   n: integer;
   useable: Boolean;
   d: TDirectDrawSurface;
begin
   if g_MySelf = nil then exit;
   with DItemStore do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
      GetMouseItemInfo (d0, d1, d2, d3, useable);
      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clWhite;
         if d0 <> '' then begin
            n := TextWidth (d0);
            Font.Color := clYellow;
            TextOut (SurfaceX(Left+20), SurfaceY(Top+371), d0);
            Font.Color := g_MouseItem.S.Color;
            d1:= StringReplace(d1,'\','',[rfReplaceAll,rfIgnoreCase]);
            d2:= StringReplace(d2,'\','',[rfReplaceAll,rfIgnoreCase]);
            TextOut (SurfaceX(Left+20) + n, SurfaceY(Top+371), d1);
            TextOut (SurfaceX(Left+20), SurfaceY(Top+385), d2);
            Font.Color:= clWhite;
            if not useable then
               Font.Color := clRed;
            TextOut (SurfaceX(Left+20), SurfaceY(Top+399), d3);
         end;
         Release;
      end;
   end;
end;


procedure TFrmDlg.DStoreGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
   temp: TClientItem;
   iname, d1, d2, d3: string;
   useable: Boolean;
   hcolor: TColor;
begin
   if ssRight in Shift then begin
      if g_boItemMoving then
         DStoreGridGridSelect (self, ACol, ARow, Shift);
   end else begin
      idx := ACol + ARow * DStoreGrid.ColCount;
      if idx in [0..STORAGELIMIT-1] then begin
         g_MouseItem := g_StoreItem[idx];
      end;
   end;
end;

procedure TFrmDlg.DStoreGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDirectDrawSurface);
var
   idx,i, ii, ax, ay: integer;
   d,e: TDirectDrawSurface;
   tempsize:integer;
   ItemEffect:pTItemEffect;
begin
   idx := ACol + ARow * DStoreGrid.ColCount;
   if idx in [0..STORAGELIMIT-1] then begin
      if g_StoreItem[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_StoreItem[idx].S.Looks];
         if d <> nil then
          with DStoreGrid do begin
            dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
            if g_StoreItem[idx].Amount > 1 then begin
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              tempsize:=dsurface.Canvas.Font.Size;
              dsurface.Canvas.Font.Size :=8;
              BoldTextOut (dsurface, SurfaceX(Rect.BottomRight.x + 18),
              SurfaceY(Rect.BottomRight.y + 18), clYellow, clBlack, IntToStr(g_StoreItem[idx].Amount));
              dsurface.Canvas.Font.Size:=tempsize;
              dsurface.Canvas.Release;
            end;

            for i:= 0 to g_ItemEffects.Count -1 do begin
              if pTItemEffect(g_ItemEffects[i]).Idx = idx then begin
                ItemEffect := g_ItemEffects[i];
                e := g_WMainImages.GetCachedImage (ItemEffect.n_StartFrame + ItemEffect.n_CurrentFrame, ax, ay);
                if e <> nil then
                  for ii:= 0 to 5 do
                  DrawBlend(dsurface,(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
                    (SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, e, 1);
                if (GetTickCount() - ItemEffect.n_LastFrame) < ItemEffect.n_NextFrame then exit;
                if ItemEffect.n_CurrentFrame = 0 then
                  PlaySound(10310);
                ItemEffect.n_LastFrame:= GetTickCount;
                inc(ItemEffect.n_CurrentFrame);
                if ItemEffect.n_CurrentFrame = ItemEffect.n_EndFrame then begin
                  g_ItemEffects.Delete(i);
                  dispose(ItemEffect);
                end;
              end;
            end;
          end;
      end;
   end;
end;

procedure TFrmDlg.DStoreGridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx, mi: integer;
   temp: TClientItem;
keyvalue: TKeyBoardState;
  i:Integer;
  msg:TDefaultMessage;
begin
   FillChar(keyvalue, sizeof(TKeyboardState), #0);
   GetKeyboardState (keyvalue);
   idx := ACol + ARow * DStoreGrid.ColCount;

   if ssCtrl in Shift then begin
    if not (idx in [0..STORAGELIMIT-1]) then exit;
    if g_StoreItem[idx].S.Name = '' then exit;
    if (g_MovingItem.item.S.Name <> '') and (g_MovingItem.item.S.StdMode = 37) then begin
      msg := MakeDefaultMsg (CM_GEMITEM, g_MovingItem.Item.makeindex, LoWord(g_StoreItem[idx].MakeIndex), HiWord(g_StoreItem[idx].MakeIndex),0);
      frmmain.SendSocket (EncodeMessage (msg));
      g_boItemMoving := FALSE;
      g_MovingItem.Item.S.Name := '';
      exit;
    end;
    exit;
   end;
  idx := ACol + ARow * DStoreGrid.ColCount;
   if idx in [0..STORAGELIMIT-1] then begin
      if not g_boItemMoving then begin
         if g_StoreItem[idx].S.Name <> '' then begin
            g_boItemMoving := TRUE;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := g_StoreItem[idx];
            g_StoreItem[idx].S.Name := '';
            ItemClickSound (g_StoreItem[idx].S);
            g_boStoreToBag := TRUE;
         end;
      end else begin

         if (SpotDlgMode = dmStorage) and g_boBagToStore then begin
            FrmMain.SendStorageItem (g_nCurMerchant, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name,g_MovingItem.Item.Amount);
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
            g_boBagToStore := FALSE;
            exit;
         end;
         
         mi := g_MovingItem.Index;

         if (mi = -97) or (mi = -98) then exit;
         if (mi < 0) and (mi >= -13) then begin

            g_WaitingUseItem := g_MovingItem;
            FrmMain.SendTakeOffItem (-(g_MovingItem.Index+1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
         end else begin
            if (mi <= -20) and (mi > -30) then
               DealItemReturnBag (g_MovingItem.Item);
            if g_StoreItem[idx].S.Name <> '' then begin

               temp := g_StoreItem[idx];
               g_StoreItem[idx] := g_MovingItem.Item;
               g_MovingItem.Index := idx;
               g_MovingItem.Item := temp
            end else begin
            if g_MovingItem.Item.S.StdMode = 45 then
               for i:=0 to g_MovingItem.Item.Amount -1 do
               AddItemStore(g_MovingItem.Item)
            else
               g_StoreItem[idx] := g_MovingItem.Item;
               g_MovingItem.Item.S.name := '';
               g_boItemMoving := FALSE;
            end;
         end;
      end;
   end;
   ArrangeItemStore;
end;

procedure TFrmDlg.DItemStoreCloseClick(Sender: TObject; X, Y: Integer);
begin
   DItemStore.Visible := FALSE;
   DItemBag.Left := 0;
   DItemBag.Top := 0;
end;

procedure TFrmDlg.DSafeKeyStorage0Click(Sender: TObject; X, Y: Integer);
var
  EdDlgEdit:hwnd;
  keyname:integer;
begin
  EdDlgEdit := GetFocus;
  if Sender = DSafeKeyStorage0 then begin
  keyname := $30;
  end;
  if Sender = DSafeKeyStorage1 then begin
  keyname := $31;
  end;
  if Sender = DSafeKeyStorage2 then begin
  keyname := $32;
  end;
  if Sender = DSafeKeyStorage3 then begin
  keyname := $33;
  end;
  if Sender = DSafeKeyStorage4 then begin
  keyname := $34;
  end;
  if Sender = DSafeKeyStorage5 then begin
  keyname := $35;
  end;
  if Sender = DSafeKeyStorage6 then begin
  keyname := $36;
  end;
  if Sender = DSafeKeyStorage7 then begin
  keyname := $37;
  end;
  if Sender = DSafeKeyStorage8 then begin
  keyname := $38;
  end;
  if Sender = DSafeKeyStorage9 then begin
  keyname := $39;
  end;
  PostMessage(EdDlgEdit,WM_KEYDOWN,keyname,0);
end;

procedure TFrmDlg.DSafeKeyStorage0DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
   storagekeyview:string;
begin
  if Sender = DSafeKeyStorage0 then begin
  storagekeyview := '0';
  end;
  if Sender = DSafeKeyStorage1 then begin
  storagekeyview := '1';
  end;
  if Sender = DSafeKeyStorage2 then begin
  storagekeyview := '2';
  end;
  if Sender = DSafeKeyStorage3 then begin
  storagekeyview := '3';
  end;
  if Sender = DSafeKeyStorage4 then begin
  storagekeyview := '4';
  end;
  if Sender = DSafeKeyStorage5 then begin
  storagekeyview := '5';
  end;
  if Sender = DSafeKeyStorage6 then begin
  storagekeyview := '6';
  end;
  if Sender = DSafeKeyStorage7 then begin
  storagekeyview := '7';
  end;
  if Sender = DSafeKeyStorage8 then begin
  storagekeyview := '8';
  end;
  if Sender = DSafeKeyStorage9 then begin
  storagekeyview := '9';
  end;
   with Sender as TDButton do begin
      if not Downed then
         d := WLib.Images[FaceIndex+1]
      else d := WLib.Images[FaceIndex+2];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

          SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
          dsurface.Canvas.Font.Size :=9;
          if TDButton(Sender).Downed then begin
            BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(storagekeyview)) div 2 -5), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(storagekeyview)) div 2) + 4, clWhite , clBlack, storagekeyview);
          end else begin
            BoldTextOut (dsurface, SurfaceX(Left + (d.Width - dsurface.Canvas.TextWidth(storagekeyview)) div 2 -5), SurfaceY(Top + (d.Height -dsurface.Canvas.TextHeight(storagekeyview)) div 2) + 4, clWhite , clBlack, storagekeyview);
          end;
      dsurface.Canvas.Font.Size :=9;
      dsurface.Canvas.Release;
   end;
end;

procedure TFrmDlg.DSafeKeyStorageEscClick(Sender: TObject; X, Y: Integer);
begin
   DSafeKeyStorage.Visible := FALSE;
end;


procedure TFrmDlg.DSafeKeyStorageEnterClick(Sender: TObject; X,
  Y: Integer);
var
  EdDlgEdit:hwnd;
  keyname:integer;
begin
  EdDlgEdit := GetFocus;
  PostMessage(EdDlgEdit,WM_KEYDOWN,13,0);
end;

procedure TFrmDlg.DSafeKeyStorageDelClick(Sender: TObject; X, Y: Integer);
var
  EdDlgEdit:hwnd;
  keyname:integer;
begin
  EdDlgEdit := GetFocus;
  PostMessage(EdDlgEdit,WM_KEYDOWN,8,0);
end;

procedure TFrmDlg.DSafeKeyStorageDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with DSafeKeyStorage do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DAddBag3DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   with Sender as TDWindow do begin
     d := WLib.Images[FaceIndex];
     if d <> nil then
     dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end
end;

procedure TFrmDlg.DAddBag3GridDblClick(Sender: TObject);
var
   where, idx, i: integer;
   keyvalue: TKeyBoardState;
   cu: TClientItem;
begin
   idx := DAddBag3Grid.Col + DAddBag3Grid.Row * DAddBag3Grid.ColCount;
   if idx in [0..ADDMAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin

         FillChar(keyvalue, sizeof(TKeyboardState), #0);
         GetKeyboardState (keyvalue);

         if keyvalue[VK_CONTROL] = $80 then begin
          if (g_MovingItem.item.S.Name <> '') and (g_MovingItem.item.S.StdMode = 38) then begin
              SendClientMessage(CM_REPAIRITEM, g_MovingItem.Item.makeindex, LoWord(g_ItemArr[idx].MakeIndex), HiWord(g_ItemArr[idx].MakeIndex),0);
            exit;
          end;
            cu := g_ItemArr[idx];
            g_ItemArr[idx].S.Name := '';
            AddItemBag (cu);
         end else
            if (g_ItemArr[idx].S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31) then begin
               FrmMain.EatItem (idx);
            end;
      end else begin
         if g_boItemMoving and (g_MovingItem.Item.S.Name <> '') then begin
            FillChar(keyvalue, sizeof(TKeyboardState), #0);
            GetKeyboardState (keyvalue);
            if keyvalue[VK_CONTROL] = $80 then begin

               cu := g_MovingItem.Item;
               g_MovingItem.Item.S.Name := '';
               g_boItemMoving := FALSE;
               AddItemBag (cu);
            end else if (g_MovingItem.Index = idx) and
                  (g_MovingItem.Item.S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31) then begin
                  FrmMain.EatItem (-1);
            end else begin
              where := GetTakeOnPosition(g_MovingItem.Item.S.StdMode);

              if (where <> -1) then begin
                if ((where = U_RINGR) and (g_UseItems[U_RINGR].S.Name <> '')) then where := U_RINGL;
                if ((where = U_ARMRINGR) and (g_UseItems[U_ARMRINGR].S.Name <> '')) then where := U_ARMRINGL;

                g_WaitingUseItem.Item := g_MovingItem.Item;
                g_WaitingUseItem.Index := where;

                FrmMain.SendTakeOnItem(where, g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
                DelItemBag(g_MovingItem.Item.S.Name, g_MovingItem.Item.MakeIndex);

                g_MovingItem.Item.S.Name := '';
              end;
            end;
         end;
      end;
   end;
end;

procedure TFrmDlg.DAddBag3GridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
   temp: TClientItem;
   iname, d1, d2, d3: string;
   useable: Boolean;
   hcolor: TColor;
begin
   if ssRight in Shift then begin
      if g_boItemMoving then
         DAddBag3GridGridSelect (self, ACol, ARow, Shift);
   end else begin
      idx := ACol + ARow * DAddBag3Grid.ColCount;
      if idx in [0..ADDMAXBAGITEM-1] then begin
         g_MouseItem := g_ItemArr[idx];
      end;
   end;
end;

procedure TFrmDlg.DAddBag3GridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx,i, ii, ax, ay: integer;
   d,e: TDirectDrawSurface;
   tempsize:integer;
   ItemEffect:pTItemEffect;
begin
   idx := ACol + ARow * DAddBag3Grid.ColCount;
   if idx in [0..ADDMAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
         if d <> nil then
          with DAddBag3Grid do begin
            dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
            if g_ItemArr[idx].Amount > 1 then begin
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              tempsize:=dsurface.Canvas.Font.Size;
              dsurface.Canvas.Font.Size :=8;
              BoldTextOut (dsurface, SurfaceX(Rect.BottomRight.x + 18),
              SurfaceY(Rect.BottomRight.y + 18), clYellow, clBlack, IntToStr(g_ItemArr[idx].Amount));
              dsurface.Canvas.Font.Size:=tempsize;
              dsurface.Canvas.Release;
            end;

            for i:= 0 to g_ItemEffects.Count -1 do begin
              if pTItemEffect(g_ItemEffects[i]).Idx = idx then begin
                ItemEffect := g_ItemEffects[i];
                e := g_WMainImages.GetCachedImage (ItemEffect.n_StartFrame + ItemEffect.n_CurrentFrame, ax, ay);
                if e <> nil then
                  for ii:= 0 to 5 do
                  DrawBlend(dsurface,(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
                    (SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, e, 1);

                if (GetTickCount() - ItemEffect.n_LastFrame) < ItemEffect.n_NextFrame then exit;
                if ItemEffect.n_CurrentFrame = 0 then
                  PlaySound(10310);
                ItemEffect.n_LastFrame:= GetTickCount;
                inc(ItemEffect.n_CurrentFrame);
                if ItemEffect.n_CurrentFrame = ItemEffect.n_EndFrame then begin
                  g_ItemEffects.Delete(i);
                  dispose(ItemEffect);
                end;
              end;
            end;
          end;
      end;
   end;
end;

procedure TFrmDlg.DAddBag4GridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx,i, ii, ax, ay: integer;
   d,e: TDirectDrawSurface;
   tempsize:integer;
   ItemEffect:pTItemEffect;
begin
   idx := ACol + ARow * DAddBag3Grid.ColCount;
   if idx in [0..ADDMAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
         if d <> nil then
          with DAddBag3Grid do begin
            dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
            if g_ItemArr[idx].Amount > 1 then begin
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              tempsize:=dsurface.Canvas.Font.Size;
              dsurface.Canvas.Font.Size :=8;
              BoldTextOut (dsurface, SurfaceX(Rect.BottomRight.x + 18),
              SurfaceY(Rect.BottomRight.y + 18), clYellow, clBlack, IntToStr(g_ItemArr[idx].Amount));
              dsurface.Canvas.Font.Size:=tempsize;
              dsurface.Canvas.Release;
            end;

            for i:= 0 to g_ItemEffects.Count -1 do begin
              if pTItemEffect(g_ItemEffects[i]).Idx = idx then begin
                ItemEffect := g_ItemEffects[i];
                e := g_WMainImages.GetCachedImage (ItemEffect.n_StartFrame + ItemEffect.n_CurrentFrame, ax, ay);
                if e <> nil then
                  for ii:= 0 to 5 do
                  DrawBlend(dsurface,(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
                    (SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, e, 1);

                if (GetTickCount() - ItemEffect.n_LastFrame) < ItemEffect.n_NextFrame then exit;
                if ItemEffect.n_CurrentFrame = 0 then
                  PlaySound(10310);
                ItemEffect.n_LastFrame:= GetTickCount;
                inc(ItemEffect.n_CurrentFrame);
                if ItemEffect.n_CurrentFrame = ItemEffect.n_EndFrame then begin
                  g_ItemEffects.Delete(i);
                  dispose(ItemEffect);
                end;
              end;
            end;
          end;
      end;
   end;
end;

procedure TFrmDlg.DAddBag5GridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx,i, ii, ax, ay: integer;
   d,e: TDirectDrawSurface;
   tempsize:integer;
   ItemEffect:pTItemEffect;
begin
   idx := ACol + ARow * DAddBag3Grid.ColCount;
   if idx in [0..ADDMAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
         if d <> nil then
          with DAddBag3Grid do begin
            dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
            if g_ItemArr[idx].Amount > 1 then begin
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              tempsize:=dsurface.Canvas.Font.Size;
              dsurface.Canvas.Font.Size :=8;
              BoldTextOut (dsurface, SurfaceX(Rect.BottomRight.x + 18),
              SurfaceY(Rect.BottomRight.y + 18), clYellow, clBlack, IntToStr(g_ItemArr[idx].Amount));
              dsurface.Canvas.Font.Size:=tempsize;
              dsurface.Canvas.Release;
            end;

            for i:= 0 to g_ItemEffects.Count -1 do begin
              if pTItemEffect(g_ItemEffects[i]).Idx = idx then begin
                ItemEffect := g_ItemEffects[i];
                e := g_WMainImages.GetCachedImage (ItemEffect.n_StartFrame + ItemEffect.n_CurrentFrame, ax, ay);
                if e <> nil then
                  for ii:= 0 to 5 do
                  DrawBlend(dsurface,(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
                    (SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, e, 1);

                if (GetTickCount() - ItemEffect.n_LastFrame) < ItemEffect.n_NextFrame then exit;
                if ItemEffect.n_CurrentFrame = 0 then
                  PlaySound(10310);
                ItemEffect.n_LastFrame:= GetTickCount;
                inc(ItemEffect.n_CurrentFrame);
                if ItemEffect.n_CurrentFrame = ItemEffect.n_EndFrame then begin
                  g_ItemEffects.Delete(i);
                  dispose(ItemEffect);
                end;
              end;
            end;
          end;
      end;
   end;
end;

procedure TFrmDlg.DAddBag6GridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx,i, ii, ax, ay: integer;
   d,e: TDirectDrawSurface;
   tempsize:integer;
   ItemEffect:pTItemEffect;
begin
   idx := ACol + ARow * DAddBag3Grid.ColCount;
   if idx in [0..ADDMAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
         if d <> nil then
          with DAddBag3Grid do begin
            dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
            if g_ItemArr[idx].Amount > 1 then begin
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              tempsize:=dsurface.Canvas.Font.Size;
              dsurface.Canvas.Font.Size :=8;
              BoldTextOut (dsurface, SurfaceX(Rect.BottomRight.x + 18),
              SurfaceY(Rect.BottomRight.y + 18), clYellow, clBlack, IntToStr(g_ItemArr[idx].Amount));
              dsurface.Canvas.Font.Size:=tempsize;
              dsurface.Canvas.Release;
            end;

            for i:= 0 to g_ItemEffects.Count -1 do begin
              if pTItemEffect(g_ItemEffects[i]).Idx = idx then begin
                ItemEffect := g_ItemEffects[i];
                e := g_WMainImages.GetCachedImage (ItemEffect.n_StartFrame + ItemEffect.n_CurrentFrame, ax, ay);
                if e <> nil then
                  for ii:= 0 to 5 do
                  DrawBlend(dsurface,(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
                    (SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, e, 1);

                if (GetTickCount() - ItemEffect.n_LastFrame) < ItemEffect.n_NextFrame then exit;
                if ItemEffect.n_CurrentFrame = 0 then
                  PlaySound(10310);
                ItemEffect.n_LastFrame:= GetTickCount;
                inc(ItemEffect.n_CurrentFrame);
                if ItemEffect.n_CurrentFrame = ItemEffect.n_EndFrame then begin
                  g_ItemEffects.Delete(i);
                  dispose(ItemEffect);
                end;
              end;
            end;
          end;
      end;
   end;
end;

procedure TFrmDlg.DAddBag7GridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx,i, ii, ax, ay: integer;
   d,e: TDirectDrawSurface;
   tempsize:integer;
   ItemEffect:pTItemEffect;
begin
   idx := ACol + ARow * DAddBag3Grid.ColCount;
   if idx in [0..ADDMAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
         if d <> nil then
          with DAddBag3Grid do begin
            dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
            if g_ItemArr[idx].Amount > 1 then begin
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              tempsize:=dsurface.Canvas.Font.Size;
              dsurface.Canvas.Font.Size :=8;
              BoldTextOut (dsurface, SurfaceX(Rect.BottomRight.x + 18),
              SurfaceY(Rect.BottomRight.y + 18), clYellow, clBlack, IntToStr(g_ItemArr[idx].Amount));
              dsurface.Canvas.Font.Size:=tempsize;
              dsurface.Canvas.Release;
            end;

            for i:= 0 to g_ItemEffects.Count -1 do begin
              if pTItemEffect(g_ItemEffects[i]).Idx = idx then begin
                ItemEffect := g_ItemEffects[i];
                e := g_WMainImages.GetCachedImage (ItemEffect.n_StartFrame + ItemEffect.n_CurrentFrame, ax, ay);
                if e <> nil then
                  for ii:= 0 to 5 do
                  DrawBlend(dsurface,(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
                    (SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, e, 1);

                if (GetTickCount() - ItemEffect.n_LastFrame) < ItemEffect.n_NextFrame then exit;
                if ItemEffect.n_CurrentFrame = 0 then
                  PlaySound(10310);
                ItemEffect.n_LastFrame:= GetTickCount;
                inc(ItemEffect.n_CurrentFrame);
                if ItemEffect.n_CurrentFrame = ItemEffect.n_EndFrame then begin
                  g_ItemEffects.Delete(i);
                  dispose(ItemEffect);
                end;
              end;
            end;
          end;
      end;
   end;
end;

procedure TFrmDlg.DAddBag8GridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx,i, ii, ax, ay: integer;
   d,e: TDirectDrawSurface;
   tempsize:integer;
   ItemEffect:pTItemEffect;
begin
   idx := ACol + ARow * DAddBag3Grid.ColCount;
   if idx in [0..ADDMAXBAGITEM-1] then begin
      if g_ItemArr[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_ItemArr[idx].S.Looks];
         if d <> nil then
          with DAddBag3Grid do begin
            dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
            if g_ItemArr[idx].Amount > 1 then begin
              SetBkMode (dsurface.Canvas.Handle, TRANSPARENT);
              tempsize:=dsurface.Canvas.Font.Size;
              dsurface.Canvas.Font.Size :=8;
              BoldTextOut (dsurface, SurfaceX(Rect.BottomRight.x + 18),
              SurfaceY(Rect.BottomRight.y + 18), clYellow, clBlack, IntToStr(g_ItemArr[idx].Amount));
              dsurface.Canvas.Font.Size:=tempsize;
              dsurface.Canvas.Release;
            end;

            for i:= 0 to g_ItemEffects.Count -1 do begin
              if pTItemEffect(g_ItemEffects[i]).Idx = idx then begin
                ItemEffect := g_ItemEffects[i];
                e := g_WMainImages.GetCachedImage (ItemEffect.n_StartFrame + ItemEffect.n_CurrentFrame, ax, ay);
                if e <> nil then
                  for ii:= 0 to 5 do
                  DrawBlend(dsurface,(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
                    (SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, e, 1);

                if (GetTickCount() - ItemEffect.n_LastFrame) < ItemEffect.n_NextFrame then exit;
                if ItemEffect.n_CurrentFrame = 0 then
                  PlaySound(10310);
                ItemEffect.n_LastFrame:= GetTickCount;
                inc(ItemEffect.n_CurrentFrame);
                if ItemEffect.n_CurrentFrame = ItemEffect.n_EndFrame then begin
                  g_ItemEffects.Delete(i);
                  dispose(ItemEffect);
                end;
              end;
            end;
          end;
      end;
   end;
end;

procedure TFrmDlg.DAddBag3GridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx, mi: integer;
   temp: TClientItem;
keyvalue: TKeyBoardState;
  i:Integer;
  msg:TDefaultMessage;
begin
   FillChar(keyvalue, sizeof(TKeyboardState), #0);
   GetKeyboardState (keyvalue);
   idx := ACol + ARow * DAddBag3Grid.ColCount;

   if ssCtrl in Shift then begin
    if not (idx in [0..ADDMAXBAGITEM-1]) then exit;
    if g_ItemArr[idx].S.Name = '' then exit;
    if (g_MovingItem.item.S.Name <> '') and (g_MovingItem.item.S.StdMode = 37) then begin //Gems
      msg := MakeDefaultMsg (CM_GEMITEM, g_MovingItem.Item.makeindex, LoWord(g_ItemArr[idx].MakeIndex), HiWord(g_ItemArr[idx].MakeIndex),0);
      frmmain.SendSocket (EncodeMessage (msg));
      g_boItemMoving := FALSE;
      g_MovingItem.Item.S.Name := '';
      exit;
    end;
    exit;
   end;
   idx := ACol + ARow * DAddBag3Grid.ColCount;
   if idx in [0..ADDMAXBAGITEM-1] then begin
      if not g_boItemMoving then begin
         if g_ItemArr[idx].S.Name <> '' then begin
            g_boItemMoving := TRUE;
            g_MovingItem.Index := idx;
            g_MovingItem.Item := g_ItemArr[idx];
            g_ItemArr[idx].S.Name := '';
            ItemClickSound (g_ItemArr[idx].S);
         end;
      end else begin
         //ItemClickSound (MovingItem.Item.S.StdMode);
         mi := g_MovingItem.Index;

         if (mi = -97) or (mi = -98) then exit;
         if (mi < 0) and (mi >= -13 {-9}) then begin  //-99: Sell

            g_WaitingUseItem := g_MovingItem;
            FrmMain.SendTakeOffItem (-(g_MovingItem.Index+1), g_MovingItem.Item.MakeIndex, g_MovingItem.Item.S.Name);
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
         end else begin
            if (mi <= -20) and (mi > -30) then
               DealItemReturnBag (g_MovingItem.Item);
            if g_ItemArr[idx].S.Name <> '' then begin

               temp := g_ItemArr[idx];
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Index := idx;
               g_MovingItem.Item := temp
            end else begin
              if g_MovingItem.Item.S.StdMode = 45 then
                for i:=0 to g_MovingItem.Item.Amount -1 do
                  AddItemBag(g_MovingItem.Item)
              else
               g_ItemArr[idx] := g_MovingItem.Item;
               g_MovingItem.Item.S.name := '';
               g_boItemMoving := FALSE;
            end;
         end;
      end;
   end;
   ArrangeItemBag;
end;

procedure TFrmDlg.DAddBag3CloseClick(Sender: TObject; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DAddBag3CloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
//
end;

procedure TFrmDlg.DBotQuestClick(Sender: TObject; X, Y: Integer);
begin
  OpenQuestAccept();
end;

procedure TFrmDlg.OpenQuestAccept();
begin
  DQuestAccept.Visible:=not DQuestAccept.Visible;
end;

procedure TFrmDlg.DRefineDlgDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   if g_MySelf = nil then exit;
   with DRefineDlg do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
   end;
end;

procedure TFrmDlg.DRefineGridGridMouseMove(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   idx: integer;
begin
   idx := ACol + ARow * DRefineGrid.ColCount;
   if idx in [0..15] then begin
      g_MouseItem := g_RefineItems[idx];
   end;
end;

procedure TFrmDlg.DRefineGridGridPaint(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   idx := ACol + ARow * DRefineGrid.ColCount;
   if idx in [0..15] then begin
      if g_RefineItems[idx].S.Name <> '' then begin
         d := g_WBagItemImages.Images[g_RefineItems[idx].S.Looks];
         if d <> nil then
            with DRefineGrid do
               dsurface.Draw (SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
                              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
                              d.ClientRect,
                              d, TRUE);
      end;
   end;
end;

procedure TFrmDlg.DRefineGridGridSelect(Sender: TObject; ACol,
  ARow: Integer; Shift: TShiftState);
var
   temp: TClientItem;
   mi, idx: Integer;
   temp2: TClientItem;
   Amount: Integer;
   valstr:String;
begin
   if not g_boRefineEnd and (GetTickCount > g_dwDealActionTick) then begin
      if not g_boItemMoving then begin
         idx := ACol + ARow * DRefineGrid.ColCount;
         if idx in [0..15] then
            if g_RefineItems[idx].S.Name <> '' then begin
               g_boItemMoving := TRUE;
               g_MovingItem.Index := idx;
               g_MovingItem.Item := g_RefineItems[idx];
               g_RefineItems[idx].S.Name := '';
               ItemClickSound (g_MovingItem.Item.S);
            end;
      end else begin
         mi := g_MovingItem.Index;
         if (mi >= 0) or (mi <= -20) and (mi > -30) then begin
            ItemClickSound (g_MovingItem.Item.S);
            g_boItemMoving := FALSE;
            //if mi >= 0 then begin
            if (mi <= -20) and (mi > -30) then begin
              if g_MovingItem.Item.S.StdMode = 45 then begin
                FrmDlg.DMessageDlg ('你需要增加多少个？', [mbOk, mbAbort]);
                GetValidStrVal (DlgEditText, valstr, [' ']);
                Amount:=Str_ToInt (valstr, 0);
              end else
                Amount:=1;
              if Amount < g_MovingItem.Item.Amount then begin
                temp2:=g_MovingItem.Item;
                dec(g_MovingItem.Item.Amount,Amount);
                AddItemBag(g_MovingItem.Item);
                temp2.Amount:=Amount;
              g_RefineDlgItem := temp2;
              end else
              g_RefineDlgItem := g_MovingItem.Item;
              FrmMain.SendAddRefineItem (g_RefineDlgItem);
              g_dwRefineActionTick := GetTickCount + 4000;
            end else
               AddRefineItem (g_MovingItem.Item);
            g_MovingItem.Item.S.name := '';
         end;
      end;
      ArrangeItemBag;
   end;
end;

procedure TFrmDlg.DRefineDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
   if GetTickCount > g_dwRefineActionTick then begin
      DRefineDlg.Visible := FALSE;
      FrmMain.SendCanceRefine;
   end;
end;

procedure TFrmDlg.DItemShopFindClick(Sender: TObject; X, Y: Integer);
begin
  if (EdShopEdit.Text <> '') and (length(EdShopEdit.Text) < 3) then begin
    DMessageDlg ('查找至少需要3个字符。', [mbOk]);
  end else begin
 //   SendClientMessage(CM_GETAUCTION, g_MySelf.m_nRecogId, g_AuctionCurrSection, 1, 0, EdSalesEdit.Text);
  end;
end;

procedure TFrmDlg.DItemShopPayMoneyClick(Sender: TObject; X, Y: Integer);
begin
  Form1.Top:= 0;
  Form1.Left:= 0;
  Form1.Open;
end;

procedure TFrmDlg.DStoragePassSetDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with DStoragePassSet do begin
   d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

    with dsurface.Canvas do begin
      SetBkMode (Handle, TRANSPARENT);
      Font.Color:= clWhite;
      TextOut (SurfaceX(Left+40), SurfaceY(Top+33), '你设置的是你的仓库密码(限制六位数)');
      TextOut (SurfaceX(Left+40), SurfaceY(Top+80), '请输入密码');
      TextOut (SurfaceX(Left+40), SurfaceY(Top+133), '请再次输入密码');
      Release
    end;
    EdSetPasswd.Left := 41+DStoragePassSet.Left;
    EdSetPasswd.Top  := 101+DStoragePassSet.Top;
    EdSetConfirm.Left := 41+DStoragePassSet.Left;
    EdSetConfirm.Top  := 154+DStoragePassSet.Top;
  end;
end;


procedure TFrmDlg.DStoragePassSetKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure TFrmDlg.DStoragePassSetMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DStoragePassSetSafeClick(Sender: TObject; X, Y: Integer);
begin
  DSafeKeyStorage.Visible:=not DSafeKeyStorage.Visible;
end;

procedure TFrmDlg.DStoragePassSetOkClick(Sender: TObject; X, Y: Integer);
var
  storepasswd: string;
begin
   if EdSetPasswd.Text = EdSetConfirm.Text then begin
      storepasswd := EdSetPasswd.Text;
      //FrmMain.SendSetStorePw (storepasswd);
     // ChgpwCancel;
   end else begin
      FrmDlg.DMessageDlg ('二次输入的密码不匹配！', [mbOk]);
      EdSetPasswd.SetFocus;
   end;
end;

procedure TFrmDlg.DStoragePassSetDelClick(Sender: TObject; X, Y: Integer);
begin
   EdSetPasswd.Text := '';
   EdSetConfirm.Text := '';
end;

procedure TFrmDlg.DStoragePassSetCloseClick(Sender: TObject; X,
  Y: Integer);
begin
  DStoragePassSet.Visible := FALSE;
  EdSetPasswd.Visible := FALSE;
  EdSetConfirm.Visible := FALSE;
end;

procedure TFrmDlg.DStoragePassDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with DStoragePass do begin
   d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

    with dsurface.Canvas do begin
      SetBkMode (Handle, TRANSPARENT);
      Font.Color:= clWhite;
      TextOut (SurfaceX(Left+40), SurfaceY(Top+33), '请输入密码(限制六位数)');
      Release
    end;
    EnterPasswd.Left := 35+DStoragePass.Left;
    EnterPasswd.Top  := 54+DStoragePass.Top;
  end;
end;

procedure TFrmDlg.DStoragePassKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = 13 then begin
    //  DStoragePass.DialogResult := mrOk;
      DStoragePass.Visible := FALSE;
   end;
end;

procedure TFrmDlg.DStoragePassMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DStoragePassOkClick(Sender: TObject; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DStoragePassDelClick(Sender: TObject; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DStoragePassCloseClick(Sender: TObject; X, Y: Integer);
begin
  DStoragePass.Visible := FALSE;
  EnterPasswd.Visible := FALSE;
end;

procedure TFrmDlg.DStoragePassResetDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with DStoragePassReset do begin
   d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    with dsurface.Canvas do begin
      SetBkMode (Handle, TRANSPARENT);
      Font.Color:= clWhite;
      TextOut (SurfaceX(Left+40), SurfaceY(Top+33), '修改密码          '+g_MySelf.m_sUserName);
      TextOut (SurfaceX(Left+40), SurfaceY(Top+70), '请输入原密码');
      TextOut (SurfaceX(Left+40), SurfaceY(Top+123), '请输入新密码');
      TextOut (SurfaceX(Left+40), SurfaceY(Top+176), '请再次输入新密码');
      Release
    end;
    EdOldPasswd.Left := 41+DStoragePassReset.Left;
    EdOldPasswd.Top  := 88+DStoragePassReset.Top;
    EdNewPasswd.Left := 41+DStoragePassReset.Left;
    EdNewPasswd.Top  := 141+DStoragePassReset.Top;
    EdConfirm.Left := 41+DStoragePassReset.Left;
    EdConfirm.Top  := 194+DStoragePassReset.Top;
  end;
end;


procedure TFrmDlg.DStoragePassResetKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure TFrmDlg.DStoragePassResetMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DStoragePassResetOkClick(Sender: TObject; X, Y: Integer);
var
  storepasswd, newstorepasswd: string;
begin
   if EdNewPasswd.Text = EdConfirm.Text then begin
      storepasswd := EdOldPasswd.Text;
      newstorepasswd := EdNewPasswd.Text;
      FrmMain.SendChgStorePw (storepasswd, newstorepasswd);
     // ChgpwCancel;
   end else begin
      FrmDlg.DMessageDlg ('二次输入的密码不匹配！', [mbOk]);
      EdOldPasswd.SetFocus;
   end;
end;

procedure TFrmDlg.DStoragePassResetDelClick(Sender: TObject; X,
  Y: Integer);
begin
  EdOldPasswd.Text := '';
  EdNewPasswd.Text := '';
  EdConfirm.Text := '';
end;

procedure TFrmDlg.DStoragePassResetCloseClick(Sender: TObject; X,
  Y: Integer);
begin
  DStoragePassReset.Visible := FALSE;
  EdOldPasswd.Visible := FALSE;
  EdNewPasswd.Visible := FALSE;
  EdConfirm.Visible := FALSE;
end;

procedure TFrmDlg.DItemStorePassResetClick(Sender: TObject; X, Y: Integer);
begin
    DStoragePassSet.Visible := True;
    EdSetPasswd.Visible := true;
    EdSetPasswd.Text := '';
    EdSetConfirm.Visible := true;
    EdSetConfirm.Text := '';
    SetDFocus(FrmDlg.DStoragePassSet);
{    DStoragePassReset.Visible := True;
    EdOldPasswd.Visible := true;
    EdOldPasswd.Text := '';
    EdNewPasswd.Visible := true;
    EdNewPasswd.Text := '';
    EdConfirm.Visible := true;
    EdConfirm.Text := '';
    SetDFocus(FrmDlg.DStoragePassReset); }
end;

procedure TFrmDlg.DBankDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with DBank do begin
   d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

    with dsurface.Canvas do begin
      SetBkMode (Handle, TRANSPARENT);
      Font.Color:= clWhite;
      TextOut (SurfaceX(Left+40), SurfaceY(Top+143), '请点击ADD按钮增加包袱');
      TextOut (SurfaceX(Left+62), SurfaceY(Top+186), GetGoldStr(g_MySelf.m_nBankGold));
      Release
    end;
  end;
end;

procedure TFrmDlg.DBankGoldClick(Sender: TObject; X, Y: Integer);
begin
   if g_MySelf = nil then exit;
   if not g_boItemMoving then begin
      if g_MySelf.m_nBankGold > 0 then begin
         PlaySound (s_money);
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -98;
         g_MovingItem.Item.S.Name := g_sGoldName;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin
         g_boItemMoving := FALSE;
         g_MovingItem.Item.S.Name := '';
         if g_MovingItem.Index = -97 then begin
            DealZeroGold;
         end;
      end;
   end;
end;

procedure TFrmDlg.DBankSlotAddClick(Sender: TObject; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DBankCloseClick(Sender: TObject; X, Y: Integer);
begin
   DBank.Visible := FALSE;
end;

procedure TFrmDlg.DBankPassSetClick(Sender: TObject; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DBankCell1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   idx: integer;
   d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
      idx := Tag;
      if idx in [0..2] then begin
         if g_BankItem[idx].S.Name <> '' then begin
            d := g_WBagItemImages.Images[g_BankItem[idx].S.Looks];
            if d <> nil then
               dsurface.Draw (SurfaceX(Left+(Width-d.Width) div 2), SurfaceY(Top+(Height-d.Height) div 2), d.ClientRect, d, TRUE);
         end;
      end;
      PomiTextOut (dsurface, SurfaceX(Left+13), SurfaceY(Top+19), IntToStr(idx+1));
   end;
end;


procedure TFrmDlg.DBankCell1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DBankCell1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DBankSlot1Click(Sender: TObject; X, Y: Integer);
begin
//
end;

procedure TFrmDlg.DBankSlot1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
//
end;

procedure TFrmDlg.DGDWarClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg.DMessageDlg ('此功能未开通...', [mbOk]);
end;

procedure TFrmDlg.DGDCancelWarClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg.DMessageDlg ('此功能未开通...', [mbOk]);
end;

procedure TFrmDlg.DAboutDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
  with Sender as TDWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);
    with dsurface.Canvas do begin
      SetBkMode (Handle, TRANSPARENT);
      Font.Color:= clWhite;
      TextOut (SurfaceX(Left+40), SurfaceY(Top+40), '关于本引擎');
      TextOut (SurfaceX(Left+40), SurfaceY(Top+55), '关于本引擎');
      TextOut (SurfaceX(Left+40), SurfaceY(Top+70), '关于本引擎');
      TextOut (SurfaceX(Left+40), SurfaceY(Top+85), '关于本引擎');
      TextOut (SurfaceX(Left+40), SurfaceY(Top+100), '关于本引擎');
      Release
    end;
  end;
end;

procedure TFrmDlg.DAboutCloseClick(Sender: TObject; X, Y: Integer);
begin
  DAbout.Visible := FALSE;
end;

procedure TFrmDlg.DBotExpandClick(Sender: TObject; X, Y: Integer);
begin
  DAbout.Visible:=not DAbout.Visible;
end;

initialization
  SVNRevision('$Id: FState.pas 597 2007-04-11 19:46:11Z sean $');
end.

