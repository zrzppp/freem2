unit FState;

interface

uses
  svn, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DWinCtl, StdCtrls, DXDraws, Grids, Grobal2, EdCode, clFunc, hUtil32, cliUtil,
  MapUnit, SoundUtil, Actor, nixtime, DateUtils, StrUtils;

const
   BOTTOMBOARD800 = 1;
   BOTTOMBOARD1024 = 2;
   VIEWCHATLINE = 9;
   MAXSTATEPAGE = 4;
   LISTLINEHEIGHT = 13;
   MAXMENU = 10;

   AdjustAbilHints : array[0..8] of string = (
      'Destructive power',
      'Magic power (for Wizard)',
      'Zen power (for Taoist)',
      'Defense ability',
      'Magical defense strength',
      'Physical strength',
      'Magic power',
      'Accuracy',
      'Evasion ability'
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

    DSServer3: TDButton;
    DSServer4: TDButton;
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
    DSServer5: TDButton;
    DSServer6: TDButton;
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
    DButtonHP: TDButton;
    DButtonMP: TDButton;
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
    DLoverLogo: TDButton;
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
  private
    DlgTemp: TList;
    magcur, magtop: integer;
    EdDlgEdit: TEdit;
    Memo: TMemo;

    ViewDlgEdit: Boolean;
    msglx, msgly: integer;
    MenuTop: integer;

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
    MsgText: string;
    DialogSize: integer;
    {
    m_n66C:Integer;
    m_n688:Integer;
    m_n6A4:Integer;
    m_n6A8:Integer;
    }
//    m_Dicea:array[0..35] of Integer;

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
    MenuIndex: integer;
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
    procedure ShowMDlg (face: integer; mname, msgstr: string);
    procedure ShowGuildDlg;
    procedure ShowGuildEditNotice;
    procedure ShowGuildEditGrade;

    procedure ResetMenuDlg;
    procedure ShowShopMenuDlg;
    procedure ShowShopSellDlg;
    procedure CloseDSellDlg;
    procedure CancelGemMaking;
    procedure CloseMDlg;

    procedure ToggleShowGroupDlg;
    procedure OpenDealDlg;
    procedure CloseDealDlg;

    procedure OpenFriendDlg;
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
   ClMain, MShare, Share, SDK;
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

{
   ##  MovingItem.Index
      1~n : °¡¹æÃ¢ÀÇ ¾ÆÀÌÅÛ ¼ø¼­
      -1~-8 : ÀåÂøÃ¢¿¡¼­ÀÇ ¾ÆÀÌÅÛ ¼ø¼­
      -97 : ±³È¯Ã¢ÀÇ µ·
      -98 : µ·
      -99 : ÆÈ±â Ã¢¿¡¼­ÀÇ ¾ÆÀÌÅÛ ¼ø¼­
      -20~29: ±³È¯Ã¢¿¡¼­ÀÇ ¾ÆÀÌÅÛ ¼ø¼­
}

procedure TFrmDlg.FormCreate(Sender: TObject);
begin
   MaxLineHeight := 0;
   StatePage := 0;
   DlgTemp := TList.Create;
   DialogSize := 1; //±âº» Å©±â
   m_nDiceCount:=0;
   m_boPlayDice:=False;
   magcur := 0;
   magtop := 0;
   MDlgPoints := TList.Create;
   SelectMenuStr := '';
   MenuList := TList.Create;
   MenuIndex := -1;
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
   GuildStrs2 := TStringList.Create; //¹é¾÷¿ë
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

   EdSalesEdit := TMemo.Create (FrmMain.Owner);
   with EdSalesEdit do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
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

   EdDlgEdit := TEdit.Create (FrmMain.Owner);
   with EdDlgEdit do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      MaxLength := 30;
      Height := 16;
      Ctl3d := FALSE;
      BorderStyle := bsSingle;  {OnKeyPress := EdDlgEditKeyPress;}
      Visible := FALSE;
   end;

   Memo := TMemo.Create (FrmMain.Owner);
   with Memo do begin
      Parent := FrmMain;
      Color := clBlack;
      Font.Color := clWhite;
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
   MDlgPoints.Free;  //°£´ÜÈ÷..
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

procedure TFrmDlg.Initialize;  //°ÔÀÓÀ» ¸®½ºÅä¾îÇÒ¶§¸¶´Ù È£ÃâµÊ
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

   //¸Þ¼¼Áö ´ÙÀÌ¾ó·Î±× Ã¢
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

   {-----------------------------------------------------------}

   //·Î±×ÀÎ Ã¢
   d := g_WMainImages.Images[60];
   if d <> nil then begin
      DLogIn.SetImgIndex (g_WMainImages, 60);
      DLogIn.Left := 252;
      DLogIn.Top := 182;
   end;
   DLoginNew.SetImgIndex (g_WMainImages, 61);
   DLoginNew.Left := 93;
   DLoginNew.Top  := 144;
   DLoginOk.SetImgIndex (g_WMainImages, 42);
   DLoginOk.Left := 245;
   DLoginOk.Top := 77;
   DLoginChgPw.SetImgIndex (g_WMainImages, 53);
   DLoginChgPw.Left := 142;
   DLoginChgPw.Top  := 144;
   DLoginClose.SetImgIndex (g_WMainImages, 41);
   DLoginClose.Left := 141;
   DLoginClose.Top := 171;

   {-----------------------------------------------------------}
   //·þÎñÆ÷Ñ¡Ôñ´°¿Ú
   if not EnglishVersion then begin
      d := g_WMainImages.Images[160]; //81];
      if d <> nil then begin
         DSelServerDlg.SetImgIndex (g_WMainImages, 160);
         DSelServerDlg.Left := (SCREENWIDTH - d.Width) div 2;
         DSelServerDlg.Top := (SCREENHEIGHT - d.Height) div 2;
      end;
      DSSrvClose.SetImgIndex (g_WMainImages, 64);
      DSSrvClose.Left := 448;
      DSSrvClose.Top := 33;

      DSServer1.SetImgIndex (g_WMainImages, 161); //82);
      DSServer1.Left := 134;
      DSServer1.Top  := 102;
      DSServer2.SetImgIndex (g_WMainImages, 162); //83);
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
      d := g_WMainImages.Images[256]; //81];
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
      DSServer1.Top  := 100;

      DSServer2.SetImgIndex (g_WMain2Images, 2);
      DSServer2.Left := 40;
      DSServer2.Top  := 145;

      DSServer3.SetImgIndex (g_WMain2Images, 2);
      DSServer3.Left := 40;
      DSServer3.Top  := 190;

      DSServer4.SetImgIndex (g_WMain2Images, 2);
      DSServer4.Left := 40;
      DSServer4.Top  := 235;

      DSServer5.SetImgIndex (g_WMain2Images, 2);
      DSServer5.Left := 40;
      DSServer5.Top  := 280;

      DSServer6.SetImgIndex (g_WMain2Images, 2);
      DSServer6.Left := 40;
      DSServer6.Top  := 325;

      DEngServer1.Visible := FALSE;
      DSServer1.Visible := FALSE;
      DSServer2.Visible := FALSE;
      DSServer3.Visible := FALSE;
      DSServer4.Visible := FALSE;
      DSServer5.Visible := FALSE;
      DSServer6.Visible := FALSE;

   end;

   {-----------------------------------------------------------}

   //µÇÂ¼´°¿Ú
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

   //ÐÞ¸ÄÃÜÂë´°¿Ú
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

   //Ñ¡Ôñ½ÇÉ«´°¿Ú
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

      DscSelect1.Left := (SCREENWIDTH - 800) div 2 + 111{134};
      DscSelect1.Top := (SCREENHEIGHT - 600) div 2 + 393{454};
      DscSelect2.Left := (SCREENWIDTH - 800) div 2 + 345{685};
      DscSelect2.Top := (SCREENHEIGHT - 600) div 2 + 393{454};
      DscSelect3.Left := (SCREENWIDTH - 800) div 2 + 585{685};
      DscSelect3.Top := (SCREENHEIGHT - 600) div 2 + 393{454};
      DscStart.Left := (SCREENWIDTH - 800) div 2 + 414{385};
      DscStart.Top := (SCREENHEIGHT - 600) div 2 + 437{456};
      DscNewChr.Left := (SCREENWIDTH - 800) div 2 + 414{348};
      DscNewChr.Top := (SCREENHEIGHT - 600) div 2 + 466{486};
      DscEraseChr.Left := (SCREENWIDTH - 800) div 2 + 414{347};
      DscEraseChr.Top := (SCREENHEIGHT - 600) div 2 + 495{506};
      DscCredits.Left := (SCREENWIDTH - 800) div 2 + 414{362};
      DscCredits.Top := (SCREENHEIGHT - 600) div 2 + 522{527};
      DscExit.Left := (SCREENWIDTH - 800) div 2 + 414{379};
      DscExit.Top := (SCREENHEIGHT - 600) div 2 + 551{547};

   {-----------------------------------------------------------}

   //´´½¨½ÇÉ«´°¿Ú
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
      DccWarrior.Left := 358;
      DccWarrior.Top := 205;
      DccWizzard.Left := 405;
      DccWizzard.Top := 205;
      DccMonk.Left := 455;
      DccMonk.Top := 205;
      //DccReserved.Left := 183;
      //DccReserved.Top := 157;
      DccMale.Left := 405;
      DccMale.Top := 297;
      DccFemale.Left := 455;
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
   DChgGamePwdClose.Left := 291;// 399;
   DChgGamePwdClose.Top := 8;
   DChgGamePwdClose.SetImgIndex (g_WMainImages, 64);


   //ÈËÎï×´Ì¬´°¿Ú
   d := g_WMainImages.Images[370];  //»óÅÂ
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

      DStMag1.Left := 38 + 6; //8
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

      DStMag4.Left := 38 + 6;//38+8
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

   //ÈËÎï×´Ì¬´°¿Ú(²é¿´±ðÈËÐÅÏ¢)
   d := g_WMainImages.Images[370];  //»óÅÂ
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

   // friend, group and mail buttons
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

   //±³°üÎïÆ·´°¿Ú
   DItemBag.SetImgIndex (g_WMainImages, 3);
   DItemBag.Left := 0;
   DItemBag.Top := 0;

   DItemGrid.Left := 28;       //28
   DItemGrid.Top  := 25;
   DItemGrid.Width := 288;
   DItemGrid.Height := 162;

  {-------------------------------------------------------------}
  //guild territory
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
   //options

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

   {-----------------------------------------------------------}
   // Skill Bar

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
   
   //Ö÷¿ØÃæ°å
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

   //¹¦ÄÜ°´Å¥
   DMyState.SetImgIndex (g_WMainImages, 8);
   DMyState.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (409 - 243)){503};
   DMyState.Top := 65;
   DMyBag.SetImgIndex (g_WMainImages, 9);
   DMyBag.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (407 - 282)){682};
   DMyBag.Top := 48;
   DMyMagic.SetImgIndex (g_WMainImages, 10);
   DMyMagic.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (405 - 322)){722};
   DMyMagic.Top := 38;
   DOption.SetImgIndex (g_WMainImages, 11);
   DOption.Left := SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (405 - 364)){764};
   DOption.Top := 31;


   {-----------------------------------------------------------}

   //¿ì½Ý°´Å¥


   DBotMiniMap.SetImgIndex (g_WMainImages, DlgConf.DBotMiniMap.Image{130});
   DBotMiniMap.Left := DlgConf.DBotMiniMap.Left{219};
   DBotMiniMap.Top := DlgConf.DBotMiniMap.Top{104};
   DBotMiniMap.DontDrawUp := True;
   DBotTrade.SetImgIndex (g_WMainImages,DlgConf.DBotTrade.Image{132});
   DBotTrade.Left :=DlgConf.DBotTrade.Left{219 + 30}; //560 - 30;
   DBotTrade.Top := DlgConf.DBotTrade.Top{104};
   DBotTrade.DontDrawUp := True;
   DBotGuild.SetImgIndex (g_WMainImages,DlgConf.DBotGuild.Image{134});
   DBotGuild.Left := DlgConf.DBotGuild.Left{219 + 30*2};
   DBotGuild.Top := DlgConf.DBotGuild.Top{104};
   DBotGuild.DontDrawUp := True;
   DBotGroup.SetImgIndex (g_WMainImages,DlgConf.DBotGroup.Image{128});
   DBotGroup.Left :=DlgConf.DBotGroup.Left{219 + 30*3};
   DBotGroup.Top :=DlgConf.DBotGroup.Top{104};
   DBotGroup.DontDrawUp := True;
   DBotPlusAbil.SetImgIndex (g_WMainImages,DlgConf.DBotPlusAbil.Image{140});
   DBotPlusAbil.Left :=DlgConf.DBotPlusAbil.Left{219 + 30*4};
   DBotPlusAbil.Top :=DlgConf.DBotPlusAbil.Top{104};
   DBotFriend.SetImgIndex (g_WMainImages,DlgConf.DBotFriend.Image{530});
   DBotFriend.Left :=DlgConf.DBotFriend.Left{219 + 30*5};
   DBotFriend.Top :=DlgConf.DBotFriend.Top{104};
   DBotFriend.DontDrawUp := True;
   DBotLover.SetImgIndex (g_WMainImages,DlgConf.DBotLover.Image{530});
   DBotLover.Left :=DlgConf.DBotLover.Left{219 + 30*5};
   DBotLover.Top :=DlgConf.DBotLover.Top{104};
   DBotLover.DontDrawUp := True;
   DBotMemo.SetImgIndex (g_WMainImages,DlgConf.DBotMemo.Image{532});
   DBotMemo.Left :=DlgConf.DBotMemo.Left{753};
   DBotMemo.Top :=DlgConf.DBotMemo.Top{204};
   DBotExit.SetImgIndex (g_WMainImages,DlgConf.DBotExit.Image{138});
   DBotExit.Left :=DlgConf.DBotExit.Left{560};
   DBotExit.Top :=DlgConf.DBotExit.Top{104};
   DBotExit.DontDrawUp := True;
   DBotLogout.SetImgIndex (g_WMainImages,DlgConf.DBotLogout.Image{136});
   DBotLogout.Left :=DlgConf.DBotLogout.Left{560 - 30};
   DBotLogout.Top :=DlgConf.DBotLogout.Top{104};
   DBotLogout.DontDrawUp := True;

   {-----------------------------------------------------------}

   {-----------------------------------------------------------}

   //Milo
   DGold.SetImgIndex (g_WMainImages, 29); //µ·Å©±â 3°³ °°À½
   DGold.Left := 13;
   DGold.Top  := 208;

   DRepairItem.SetImgIndex (g_WMainImages, 26);
   DRepairItem.Left := 254;
   DRepairItem.Top := 183;
   DRepairItem.Width := 48;
   DRepairItem.Height := 22;
   DClosebag.SetImgIndex (g_WMainImages, 86);
   DCloseBag.Left := 322;
   DCloseBag.Top := 6;
   DCloseBag.Width := 14;
   DCloseBag.Height := 20;

   d := g_WMainImages.Images[583];
   if d <> nil then begin
      DLoverWindow.SetImgIndex (g_WMainImages, 583);
      DLoverWindow.Left := 0;
      DLoverWindow.Top := 0;
      DLoverWindow.Width := 324;
      DLoverWindow.Height := 458;

      DLoverLogo.SetImgIndex (g_WMainImages, 582);
      DLoverLogo.Top := 25;
      DLoverLogo.Left := 25;

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

   //»óÀÎ ´ëÈ­Ã¢
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
   //ÅäÖÃ´°¿Ú
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

   //¸Þ´ºÃ¢
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

   //ÆÈ±âÃ¢
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

   //ÉèÖÃÄ§·¨¿ì½Ý¶Ô»°¿ò
   {
   d := g_WMainImages.Images[229];
   if d <> nil then begin
      DKeySelDlg.Left := (SCREENWIDTH - d.Width) div 2;
      DKeySelDlg.Top  := (SCREENHEIGHT - d.Height) div 2;
      DKeySelDlg.SetImgIndex (g_WMainImages, 229);
   end;
   DKsIcon.Left := 52;   //DMagIcon...
   DKsIcon.Top := 29;
   DKsF1.SetImgIndex (g_WMainImages, 232);
   DKsF1.Left := 34;
   DKsF1.Top  := 83;
   DKsF2.SetImgIndex (g_WMainImages, 234);
   DKsF2.Left := 66;
   DKsF2.Top  := 83;
   DKsF3.SetImgIndex (g_WMainImages, 236);
   DKsF3.Left := 98;
   DKsF3.Top  := 83;
   DKsF4.SetImgIndex (g_WMainImages, 238);
   DKsF4.Left := 130;
   DKsF4.Top  := 83;
   DKsF5.SetImgIndex (g_WMainImages, 240);
   DKsF5.Left := 171;
   DKsF5.Top  := 83;
   DKsF6.SetImgIndex (g_WMainImages, 242);
   DKsF6.Left := 203;
   DKsF6.Top  := 83;
   DKsF7.SetImgIndex (g_WMainImages, 244);
   DKsF7.Left := 235;
   DKsF7.Top  := 83;
   DKsF8.SetImgIndex (g_WMainImages, 246);
   DKsF8.Left := 267;
   DKsF8.Top  := 83;
   DKsNone.SetImgIndex (g_WMainImages, 230);
   DKsNone.Left := 299;
   DKsNone.Top  := 83;
   DKsOk.SetImgIndex (g_WMainImages, 62);
   DKsOk.Left := 222;
   DKsOk.Top  := 131;
   }
   //Milo
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
   //milo
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

   {-----------------------------------------------------------}
   //Deal Menu
   d := g_WMainImages.Images[389];  //³» ±³È¯Ã¢
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

   d := g_WMainImages.Images[390];  //»ó´ë¹æ ±³È¯Ã¢
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

   DButtonHP.Left   := 40;
   DButtonHP.Top    := 91;
   DButtonHP.Width  := 45;
   DButtonHP.Height := 90;

   DButtonMP.Left   := 40 + 47;
   DButtonMP.Top    := 91;
   DButtonMP.Width  := 45;
   DButtonMP.Height := 90;
   {
   //±³°üÎïÆ·´°¿Ú
   DItemBag.SetImgIndex (g_WMain3Images, 6);
   DItemBag.Left := 0;
   DItemBag.Top := 0;

   DItemGrid.Left := 29;
   DItemGrid.Top  := 41;
   DItemGrid.Width := 286;
   DItemGrid.Height := 162;

//   DClosebag.SetImgIndex (g_WMainImages, 372);
   DClosebag.Downed:=True;
   DCloseBag.Left := 336;
   DCloseBag.Top := 59;
   DCloseBag.Width := 14;
   DCloseBag.Height := 20;

   DGold.Left := 18;
   DGold.Top  := 218;

   d := g_WMain3Images.Images[207];  //»óÅÂ
   if d <> nil then begin
      DStateWin.SetImgIndex (g_WMain3Images, 207);
      DStateWin.Left := SCREENWIDTH - d.Width;
      DStateWin.Top := 0;
   end;
   }
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

//°¡¹æ ¿­±â
procedure TFrmDlg.OpenItemBag;
begin
   DItemBag.Visible := not DItemBag.Visible;
   if DItemBag.Visible then
      ArrangeItemBag;
end;

//ÇÏ´Ü »óÅÂ¹Ù º¸±â
procedure TFrmDlg.ViewBottomBox (visible: Boolean);
begin
   DBottom.Visible := visible;
end;


// ¾ÆÀÌÅÛ ¸¶¿ì½º·Î ÀÌµ¿Áß Ãë¼Ò
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

//ÀÌµ¿ÁßÀÎ ¾ÆÀÌÅÛÀ» ¹Ù´Ú¿¡ ¶³¾î ¶ß¸²...
//°¡¹æ(º§Æ®)¿¡¼­ ¹ö¸°°Í¸¸ È£ÃâµÊ
procedure TFrmDlg.DropMovingItem;
var
   idx: integer;
   Amount: Integer;
   valstr: String;
begin
   if g_boItemMoving then begin
      g_boItemMoving := FALSE;
      if g_MovingItem.Item.S.Name <> '' then begin
      //gotta add a quest box here
        if g_MovingItem.Item.S.StdMode = 45 then begin
          FrmDlg.DMessageDlg ('How many would you like to drop?', [mbOk, mbAbort]);
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

procedure TFrmDlg.DBackgroundBackgroundClick(Sender: TObject);
var
   dropgold: integer;
   valstr: string;
begin
   if g_boItemMoving then begin
      DBackground.WantReturn := TRUE;
      if g_MovingItem.Item.S.Name = g_sGoldName{'½ð±Ò'} then begin
         g_boItemMoving := FALSE;
         g_MovingItem.Item.S.Name := '';
         //¾ó¸¶¸¦ ¹ö¸± °ÇÁö ¹°¾îº»´Ù.
         DialogSize := 1;
         DMessageDlg ('How much ' +g_sGoldName+ ' do you want to drop?', [mbOk, mbAbort]);
         GetValidStrVal (DlgEditText, valstr, [' ']);
         dropgold := Str_ToInt (valstr, 0);
         //
         FrmMain.SendDropGold (dropgold);
      end;
      if g_MovingItem.Index >= 0 then //¾ÆÀÌÅÛ °¡¹æ¿¡¼­ ¹ö¸°°Í¸¸..
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
   //Ã¤ÆÃÃ¢¿¡ Å¬¸¯ÇÏ¸é, '/'±Ó¼Ó¸» ÀÏ¶§ Å¬¸¯ÇÑ ´ëÈ­¸¦ ÇÑ»ç¶÷ÀÇ ÀÌ¸§ÀÌ ±Ó¸»´ë»óÀÚ°¡ µÇ°Ô ÇÑ´Ù.
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

////¸Þ¼¼Áö ´ÙÀÌ¾ó·Î±× ¹Ú½º


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
   if DConfigDlg.Visible  then begin //´ò¿ªÌáÊ¾¿òÊ±¹Ø±ÕÑ¡Ïî¿ò
     DOptionClick();
   end;
     
   lx := XBase;
   ly := 126;
   case DialogSize of
      0:  //ÀÛÀº°Å
         begin
            d := g_WMainImages.Images[381];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (g_WMainImages, 381);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               msglx := 39;   //39
               msgly := 38;   //38
               lx := 90;   //90
               ly := 36;   //36
            end;
         end;
      1:  //³Ð°í Å«°Å
         begin
            d := g_WMainImages.Images[360];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (g_WMainImages, 360);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               msglx := 39;  //39
               msgly := 38;  //38
               lx := XBase;
               ly := 155;
            end;
         end;
      2:  //±æÀº°Å
         begin
            d := g_WMainImages.Images[380];
            if d <> nil then begin
               DMsgDlg.SetImgIndex (g_WMainImages, 380);
               DMsgDlg.Left := (SCREENWIDTH - d.Width) div 2;
               DMsgDlg.Top := (SCREENHEIGHT - d.Height) div 2;
               //Notice Screen
               msglx := 33;  //23
               msgly := 25;  //20
               lx := 145;   //90
               ly := 425;  //305
            end;
         end;
   end;
   MsgText := msgstr;
   ViewDlgEdit := FALSE;
   DMsgDlg.Floating := TRUE;   //¸Þ¼¼Áö ¹Ú½º°¡ ¶°´Ù´Ô..
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
      ViewDlgEdit := TRUE; //¿¡µåÆ® ÄÁÆ®·ÑÀÌ º¸¿©¾ß ÇÏ´Â °æ¿ì.
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
   DialogSize := 1; //±âº»»óÅÂ
   m_nDiceCount:=0;
   m_boPlayDice:=False;
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
      Color:=clYellow;
      {case nStatus of    //
        0: begin
          tStr:=tStr + '(Î¬»¤)';
          Color:=clDkGray;
        end;
        1: begin
          tStr:=tStr + '(¿ÕÏÐ)';
          Color:=clLime;
        end;
        2: begin
          tStr:=tStr + '(Á¼ºÃ)';
          Color:=clGreen;
        end;
        3: begin
          tStr:=tStr + '(·±Ã¦)';
          Color:=clMaroon;
        end;
        4: begin
          tStr:=tStr + '(ÂúÔ±)';
          Color:=clRed;
        end;
      end;}
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

//·Î±×ÀÎ Ã¢


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
//¼­¹ö ¼±ÅÃ Ã¢
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
         DSServer1.Top:=204;
         DSServer2.Visible:=False;
         DSServer3.Visible:=False;
         DSServer4.Visible:=False;
         DSServer5.Visible:=False;
         DSServer6.Visible:=False;
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
     else begin
         DSServer1.Visible:=True;
         DSServer2.Visible:=True;
         DSServer3.Visible:=True;
         DSServer4.Visible:=True;
         DSServer5.Visible:=True;
         DSServer6.Visible:=True;
       end;
   end;
   DSelServerDlg.Visible:=TRUE;
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
   if Sender = DSServer2 then begin //¼­¹ö 4¹ø..
     tServer:=tGame.ServerList.Items[1];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer3 then begin //¼­¹ö 1¹ø..
     tServer:=tGame.ServerList.Items[2];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer4 then begin //¼­¹ö 2¹ø..
     tServer:=tGame.ServerList.Items[3];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer5 then begin //¼­¹ö 3¹ø..
     tServer:=tGame.ServerList.Items[4];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if Sender = DSServer6 then begin //¼­¹ö 4¹ø..
     tServer:=tGame.ServerList.Items[5];
      svname :=tServer.ServerName;
      ServerMiniName :=tServer.ServerName;
   end;
   if svname <> '' then begin
      if BO_FOR_TEST then begin
         svname := 'Çö¹«¼­¹ö';
         ServerMiniName := 'Çö¹«';
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
   if Sender = DSServer2 then begin //¼­¹ö 4¹ø..
     svname:=g_ServerList.Strings[1];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer3 then begin //¼­¹ö 1¹ø..
     svname:=g_ServerList.Strings[2];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer4 then begin //¼­¹ö 2¹ø..
     svname:=g_ServerList.Strings[3];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer5 then begin //¼­¹ö 3¹ø..
     svname:=g_ServerList.Strings[4];
     g_sServerMiniName:=svname;
   end;
   if Sender = DSServer6 then begin //¼­¹ö 4¹ø..
     svname:=g_ServerList.Strings[5];
     g_sServerMiniName:=svname;
   end;
   if svname <> '' then begin
      if BO_FOR_TEST then begin
         svname := 'Çö¹«¼­¹ö';
         g_sServerMiniName := 'Çö¹«';
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
//»õ °èÁ¤ ¸¸µé±â Ã¢


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
         //TextOut (79 + 386 + 10, 64 + 119 + 5 + i*14, NAHelps[i]);
         TextOut ((SCREENWIDTH div 2 - 320) + 386 + 10, (SCREENHEIGHT div 2 - 238) + 119 + 5 + i*14, NAHelps[i]);
      end;
      BoldTextOut (dsurface, 79+283, 64 + 57, clWhite, clBlack, NewAccountTitle);
      Release;
   end;
end;



{------------------------------------------------------------------------}
////Chg pw ¹Ú½º


procedure TFrmDlg.DChgpwOkClick(Sender: TObject; X, Y: Integer);
begin
   if Sender = DChgpwOk then LoginScene.ChgpwOk;
   if Sender = DChgpwCancel then LoginScene.ChgpwCancel;
end;




{------------------------------------------------------------------------}
//Ä³¸¯ÅÍ ¼±ÅÃ


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
//»õ Ä³¸¯ÅÍ ¸¸µé±â Ã¢


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
           dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, FALSE);
           img := 20 + SelectChrScene.ChrArr[SelectChrScene.NewIndex].UserChr.Job * 40 + SelectChrScene.ChrArr[SelectChrScene.NewIndex].UserChr.Sex * 120;
           img := img+SelectChrScene.ChrArr[SelectChrScene.NewIndex].aniIndex;
           e := g_WChrSelImages.GetCachedImage(img,ax,ay);
          // FixMe: TD Can you put the code needed to workout the offset in here somewhere
          // So that teh dude doesn't jump around!
           if e <> nil then dsurface.Draw (220 + ax, 296 + ay, e.ClientRect, e, TRUE);
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

//»óÅÂÃ¢...

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
         0: begin //Âø¿ë»óÅÂ
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
            //¿Ê, ¹«±â, ¸Ó¸® ½ºÅ¸ÀÏ
            idx := 440 + g_MySelf.m_btHair div 2; //¸Ó¸® ½ºÅ¸ÀÏ
            if g_MySelf.m_btSex = 1 then idx := 480 + g_MySelf.m_btHair div 2;
            if idx > 0 then begin
               d := g_WMainImages.GetCachedImage (idx, ax, ay);
               if d <> nil then
                  dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
            end;
            if g_UseItems[U_DRESS].S.Name <> '' then begin
               idx := g_UseItems[U_DRESS].S.Looks; //¿Ê if Myself.m_btSex = 1 then idx := 80; //¿©ÀÚ¿Ê
               if idx >= 0 then begin
                  //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  d := FrmMain.GetWStateImg(idx,ax,ay);
                  if d <> nil then
                     dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
               end;
            end;
            if g_UseItems[U_WEAPON].S.Name <> '' then begin
               idx := g_UseItems[U_WEAPON].S.Looks;
               if idx >= 0 then begin
                  //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
                  d := FrmMain.GetWStateImg(idx,ax,ay);
                  if d <> nil then
                     dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
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
         1: begin //´É·ÂÄ¡
            l := Left + 103; //66;
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
         2: begin //´É·ÂÄ¡ ¼³¸íÃ¢
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
               TextOut (bbx, bby, 'Exp.');
               TextOut (mmx, bby, FloatToStrFixFmt (100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) + '%');
               //TextOut (bbx, bby+14*1, 'ÃÖ´ë°æÇè');
               //TextOut (mmx, bby+14*1, IntToStr(Myself.Abil.MaxExp));

               TextOut (bbx, bby+14*1, 'Bag weight');
               if g_MySelf.m_Abil.Weight > g_MySelf.m_Abil.MaxWeight then
                  Font.Color := clRed;
               TextOut (mmx, bby+14*1, IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight));

               Font.Color := clSilver;
               TextOut (bbx, bby+14*2, 'C. Weight');
               if g_MySelf.m_Abil.WearWeight > g_MySelf.m_Abil.MaxWearWeight then
                  Font.Color := clRed;
               TextOut (mmx, bby+14*2, IntToStr(g_MySelf.m_Abil.WearWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWearWeight));

               Font.Color := clSilver;
               TextOut (bbx, bby+14*3, 'Hands W.');
               if g_MySelf.m_Abil.HandWeight > g_MySelf.m_Abil.MaxHandWeight then
                  Font.Color := clRed;
               TextOut (mmx, bby+14*3, IntToStr(g_MySelf.m_Abil.HandWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxHandWeight));

               Font.Color := clSilver;
               TextOut (bbx, bby+14*4, 'Accuracy');
               TextOut (mmx, bby+14*4, IntToStr(g_nMyHitPoint));

               TextOut (bbx, bby+14*5, 'Agility');
               TextOut (mmx, bby+14*5, IntToStr(g_nMySpeedPoint));

               TextOut (bbx, bby+14*6, 'M. Resistance');
               TextOut (mmx, bby+14*6, '+' + IntToStr(g_nMyAntiMagic * 10) + '%');

               TextOut (bbx, bby+14*7, 'P. Resistance');
               TextOut (mmx, bby+14*7, '+' + IntToStr(g_nMyAntiPoison * 10) + '%');

               TextOut (bbx, bby+14*8, 'P. Recovery');
               TextOut (mmx, bby+14*8, '+' + IntToStr(g_nMyPoisonRecover * 10) + '%');

               TextOut (bbx, bby+14*9, 'HP Recovery');
               TextOut (mmx, bby+14*9, '+' + IntToStr(g_nMyHealthRecover * 10) + '%');

               TextOut (bbx, bby+14*10, 'MP Recovery');
               TextOut (mmx, bby+14*10, '+' + IntToStr(g_nMySpellRecover * 10) + '%');
               //Milo
               TextOut (bbx, bby+14*11, g_sGameGoldName);
               TextOut (mmx, bby+14*11, IntToStr(g_MySelf.m_nGameGold * 1));

               TextOut (bbx, bby+14*12, g_sGamePointName);
               TextOut (mmx, bby+14*12, IntToStr(g_MySelf.m_nGamePoint * 1));

               Release;
            end;
         end;
         3: begin //Magic Screen
            bbx := Left + 38; //38
            bby := Top + 59;  //53
            d := g_WMainImages.Images[383];
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);

            //Å° Ç¥½Ã, lv, exp
            magtop := MagicPage * 5;
            magline := _MIN(MagicPage*5+5, g_MagicList.Count);
            for i:=magtop to magline-1 do begin
               pm := PTClientMagic (g_MagicList[i]);
               m := i - magtop;
               keyimg := 0;
               case byte(pm.Key) of
                  {
                  byte('1'): keyimg := 248;
                  byte('2'): keyimg := 249;
                  byte('3'): keyimg := 250;
                  byte('4'): keyimg := 251;
                  byte('5'): keyimg := 252;
                  byte('6'): keyimg := 253;
                  byte('7'): keyimg := 254;
                  byte('8'): keyimg := 255;
                  }
                  //Milo
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
                  if d <> nil then        //145   //8  //37
                     dsurface.Draw (bbx + 138, bby+35+m*37, d.ClientRect, d, TRUE);
               end;
               d := g_WMainImages.Images[112]; //lv
               if d <> nil then              //8 15   37
                  dsurface.Draw (bbx + 48, bby+8+40+m*37, d.ClientRect, d, TRUE);
               d := g_WMainImages.Images[111]; //exp
               if d <> nil then                   //8 15   37
                  dsurface.Draw (bbx + 48 + 26, bby+8+40+m*37, d.ClientRect, d, TRUE);
            end;

            with dsurface.Canvas do begin
               SetBkMode (Handle, TRANSPARENT);
               Font.Color := clSilver;
               for i:=magtop to magline-1 do begin
                  pm := PTClientMagic (g_MagicList[i]);
                  m := i - magtop;
                  if not (pm.Level in [0..3]) then pm.Level := 0;
                                          //8
                  TextOut (bbx + 48, bby + 32 + m*37,
                              pm.Def.sMagicName);
                  if pm.Level in [0..3] then trainlv := pm.Level
                  else trainlv := 0;           //8  15     37
                  TextOut (bbx + 48 + 16, bby + 8 + 40 + m*37, IntToStr(pm.Level));
                  if pm.Def.MaxTrain[trainlv] > 0 then begin
                     if trainlv < 3 then              //8  15     37
                        TextOut (bbx + 48 + 46, bby + 8 + 40 + m*37, IntToStr(pm.CurTrain) + '/' + IntToStr(pm.Def.MaxTrain[trainlv]))
                                                      //8  15     37
                     else TextOut (bbx + 48 + 46, bby + 8 + 40 + m*37, '-');
                  end;
               end;
               Release;
            end;
         end;
      end;
      {Ô­Îª´ò¿ª£¬±¾´úÂëÎªÏÔÊ¾ÈËÎïÉíÉÏËù´øÎïÆ·ÐÅÏ¢£¬ÏÔÊ¾Î»ÖÃÎªÈËÎïÏÂ·½
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

      //ÀÌ¸§

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := g_MySelf.m_nNameColor;
         TextOut (SurfaceX(Left + 122 - TextWidth(FrmMain.CharName) div 2),
                  SurfaceY(Top + 10), g_MySelf.m_sUserName);
         if StatePage = 0 then begin
            Font.Color := clSilver;
            output:= g_sGuildName + ' ' + g_sGuildRankName;
            TextOut (SurfaceX(Left + 120) - TextWidth(output) div 2, SurfaceY(Top + 23),
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
      3: begin //Ä§·¨ »óÅÂÃ¢
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
                   if g_MySelf.m_btSex = 0 then //³²ÀÚ
                     if g_MovingItem.Item.S.StdMode = 11 then //male trying to put on female armour
                        exit;
                  if g_MySelf.m_btSex = 1 then //¿©ÀÚ
                     if g_MovingItem.Item.S.StdMode = 10 then //¿©ÀÚ¿Ê
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
            U_ARMRINGR: begin  //ÆÈÂî
               if Sender = DSWArmRingL then begin
                  where := U_ARMRINGL;
                  flag := TRUE;
               end;
               if Sender = DSWArmRingR then begin
                  where := U_ARMRINGR;
                  flag := TRUE;
               end;
            end;
            U_ARMRINGL: begin  //25,  µ¶°¡·ç,ÆÈÂî
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
      if Sender = DSWBelt then sel := U_BELT;  //
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
         else hcolor := g_UseItems[sel].S.Color;   //clWhite

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
      //

   end;
end;

procedure TFrmDlg.DStateWinMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
  g_MouseStateItem.S.Name := '';
end;


//»óÅÂÃ¢ : Ä§·¨ ÆäÀÌÁö

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
         if icon >= 0 then begin //¾ÆÀÌÄÜÀÌ ¾ø´Â°Å..
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
         //if pm.Def.EffectType <> 0 then begin //°Ë¹ýÀº Å°¼³Á¤À» ¸øÇÔ.
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

//¹Ù´Ú »óÅÂ

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
      0: d := g_WMainImages.Images[15];  // Dawn
      1: d := g_WMainImages.Images[12];  // Daylight
      2: d := g_WMainImages.Images[13];  // Evening
      3: d := g_WMainImages.Images[14];  // Night
   end;
   if d <> nil then
     dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (380 - 346)){748}, 97+DBottom.Top, d.ClientRect, d, TRUE);
   if g_MySelf <> nil then begin
         PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (382 - 260)){660}, SCREENHEIGHT - 88, IntToStr(g_MySelf.m_Abil.Level));
      //ÏÔÊ¾HP¼°MP Í¼ÐÎ
      if (g_MySelf.m_Abil.MaxHP > 0) and (g_MySelf.m_Abil.MaxMP > 0) then begin
         if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level < 26 {10/08 - Damian}) then begin //ÎäÊ¿
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
               //HP Í¼ÐÎ
               rc := d.ClientRect;
               rc.Right := d.ClientRect.Right div 2 - 1;
               rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
               dsurface.Draw (45, btop+62+rc.Top, rc, d, FALSE);
               //MP Í¼ÐÎ
               rc := d.ClientRect;
               rc.Left := d.ClientRect.Right div 2 + 1;
               rc.Right := d.ClientRect.Right - 1;
               rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxMP * (g_MySelf.m_Abil.MaxMP - g_MySelf.m_Abil.MP));
               dsurface.Draw (45 + rc.Left, btop+62+rc.Top, rc, d, FALSE);
            end;
         end;
      end;

      //µÈ¼¶
      with dsurface.Canvas do begin
        PomiTextOut (dsurface, SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (382 - 260)){660}, SCREENHEIGHT - 88, IntToStr(g_MySelf.m_Abil.Level));
      end;
      
      if (g_MySelf.m_Abil.MaxExp > 0) and (g_MySelf.m_Abil.MaxWeight > 0) then begin
         d := g_WMainImages.Images[7];
         if d <> nil then begin
            //¾­ÑéÌõ
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

            //±³°üÖØÁ¿Ìõ
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
      //¼¢¶ö³Ì¶È
      if g_nMyHungryState in [1..4] then begin
        d := g_WMainImages.Images[16 + g_nMyHungryState-1];
        if d <> nil then begin
          dsurface.Draw (SCREENWIDTH div 2 + (SCREENWIDTH div 2 - (400 - 354)){754}, 553, d.ClientRect, d, TRUE);
        end;
      end;
   end;

   //ÏÔÊ¾ÁÄÌì¿òÎÄ×Ö
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

      
                 //Draw only hp
          if (g_Myself.m_Abil.Level < 26) and (g_Myself.m_btJob = 0) then begin
          SetBKMode(Dsurface.Canvas.Handle, TRANSPARENT);
          BoldTextOut (dsurface,62,btop+115,clwhite, clblack, 'HP(' + IntToStr(g_Myself.m_Abil.HP) + '/' + IntToStr(g_Myself.m_Abil.MaxHP) + ')');
          end else begin
          SetBKMode(Dsurface.Canvas.Handle, TRANSPARENT);
          BoldTextOut (dsurface,62,btop+115,clwhite, clblack, 'HP(' + IntToStr(g_Myself.m_Abil.HP) + '/' + IntToStr(g_Myself.m_Abil.MaxHP) + ')');
          BoldTextOut (dsurface,62,btop+128,clwhite, clblack, 'MP(' + IntToStr(g_Myself.m_Abil.MP) + '/' + IntToStr(g_Myself.m_Abil.MaxMP) + ')');
          end;
   end;
   dsurface.Canvas.Release;

end;




{--------------------------------------------------------------}
//¹Ù´Ú »óÅÂ¹ÙÀÇ 4°³ ¹öÆ°


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

//±×·ì, ±³È¯, ¸Ê ¹öÆ°
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

    // skill setting (false = CTRL, true = Y)
    if g_boSkillSetting then begin
      DOptionsSkillMode1.SetImgIndex (g_WMainImages, 771);
      DOptionsSkillMode2.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsSkillMode1.SetImgIndex (g_WMainImages, -1);
      DOptionsSkillMode2.SetImgIndex (g_WMainImages, 772);
    end;

    // skill bar
    if DSkillBar.Visible then begin
      DOptionsSkillBarOn.SetImgIndex (g_WMainImages, 773);
      DOptionsSkillBarOff.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsSkillBarOn.SetImgIndex (g_WMainImages, -1);
      DOptionsSkillBarOff.SetImgIndex (g_WMainImages, 774);
    end;

    // sound
    if g_boSound then begin
      DOptionsSoundOn.SetImgIndex (g_WMainImages, 773);
      DOptionsSoundOff.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsSoundOn.SetImgIndex (g_WMainImages, -1);
      DOptionsSoundOff.SetImgIndex (g_WMainImages, 774);
    end;

    // drop view
    if g_boShowAllItem then begin
      DOptionsDropViewOn.SetImgIndex (g_WMainImages, 773);
      DOptionsDropViewOff.SetImgIndex (g_WMainImages, -1);
    end else begin
      DOptionsDropViewOn.SetImgIndex (g_WMainImages, -1);
      DOptionsDropViewOff.SetImgIndex (g_WMainImages, 774);
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
         if g_MovingItem.Item.S.StdMode <= 3 then begin
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
         end;
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
   if g_MySelf = nil then exit;
   iname := ''; line1 := ''; line2 := ''; line3 := '';
   useable := TRUE;

   if g_MouseItem.S.Name <> '' then begin
      iname := g_MouseItem.S.Name + ' ';
      sWgt := 'W.';
      case g_MouseItem.S.StdMode of
         0: begin
              line1 := line1 + ' W.' + IntToStr(g_MouseItem.S.Weight);

              case g_MouseItem.S.Shape of
              0: begin
                if (g_MouseItem.S.AC > 0) and (g_MouseItem.S.MAC = 0) then
                  line2 := 'Restores ' + IntToStr(g_MouseItem.S.AC) + 'HP'
                else if (g_MouseItem.S.MAC > 0) and (g_MouseItem.S.AC = 0) then
                  line2 := 'Restores ' + IntToStr(g_MouseItem.S.MAC) + 'MP'
                else
                  line2 := 'Restores ' + IntToStr(g_MouseItem.S.AC) + 'HP and ' + IntToStr(g_MouseItem.S.MAC) + 'MP';
              end;
              1: begin
                if (g_MouseItem.S.AC > 0) and (g_MouseItem.S.MAC = 0) then
                  line2 := 'Instantly restores ' + IntToStr(g_MouseItem.S.AC) + 'HP'
                else if (g_MouseItem.S.MAC > 0) and (g_MouseItem.S.AC = 0) then
                  line2 := 'Instantly restores' + IntToStr(g_MouseItem.S.MAC) + 'MP'
                else
                  line2 := 'Instantly restores ' + IntToStr(g_MouseItem.S.AC) + 'HP and ' + IntToStr(g_MouseItem.S.MAC) + 'MP';
              end;
              3: begin
                if (g_MouseItem.S.AC > 0) and (g_MouseItem.S.MAC = 0) then
                  line2 := 'Instantly restores ' + IntToStr(g_MouseItem.S.AC) + '%HP'
                else if (g_MouseItem.S.MAC > 0) and (g_MouseItem.S.AC = 0) then
                  line2 := 'Instantly restores' + IntToStr(g_MouseItem.S.MAC) + '%MP'
                else
                  line2 := 'Instantly restores ' + IntToStr(g_MouseItem.S.AC) + '%HP and ' + IntToStr(g_MouseItem.S.MAC) + '%MP';
              end;
              end;
            end;
         1..3:
            begin
               line1 := line1 + 'W.' +  IntToStr(g_MouseItem.S.Weight);
               if (g_MouseItem.S.Shape = 7) and (g_MouseItem.S.StdMode = 3) then begin
                line2:= 'Expires on: ' + DateTimeToStr(UnixToDateTime(MakeLong(g_MouseItem.DuraMax,g_MouseItem.dura)));
               end;

               if (g_MouseItem.S.Shape = 13) and (g_MouseItem.S.StdMode = 3) then
                 line2 := 'Grants the user ' +inttostr(g_MouseItem.S.DuraMax) +' experience points'
            end;
         4:
            begin
               line1 := line1 + 'W. ' +  IntToStr(g_MouseItem.S.Weight);
               line3 := 'Necessary level ' + IntToStr(g_MouseItem.S.DuraMax);
               useable := FALSE;
               case g_MouseItem.S.Shape of
                  0: begin
                        line2 := 'Secret martial art skill of Warrior';
                        if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level >= g_MouseItem.S.DuraMax) then
                           useable := TRUE;
                     end;
                  1: begin
                        line2 := 'Spellbook of wizard';
                        if (g_MySelf.m_btJob = 1) and (g_MySelf.m_Abil.Level >= g_MouseItem.S.DuraMax) then
                           useable := TRUE;
                     end;
                  2: begin
                        line2 := 'Secret martial art skill of Taoist';
                        if (g_MySelf.m_btJob = 2) and (g_MySelf.m_Abil.Level >= g_MouseItem.S.DuraMax) then
                           useable := TRUE;
                     end;
               end;
            end;
         5..6: //ÎäÆ÷
            begin
               useable := FALSE;
               if g_MouseItem.S.Reserved and $01 <> 0 then
                  iname := '(*)' + iname;

               line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) +
                        ' Dura'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
               if g_MouseItem.S.DC > 0 then
                  line2 := 'DC' + IntToStr(LoWord(g_MouseItem.S.DC)) + '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
               if g_MouseItem.S.MC > 0 then
                  line2 := line2 + 'MC' + IntToStr(LoWord(g_MouseItem.S.MC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
               if g_MouseItem.S.SC > 0 then
                  line2 := line2 + 'SC' + IntToStr(LoWord(g_MouseItem.S.SC)) + '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';

               if (g_MouseItem.S.Source <= -1) and (g_MouseItem.S.Source >= -50) then
                  line2 := line2 + 'Holy+' + IntToStr(-g_MouseItem.S.Source) + ' ';
               if (g_MouseItem.S.Source <= -51) and (g_MouseItem.S.Source >= -100) then
                  line2 := line2 + 'Holy-' + IntToStr(-g_MouseItem.S.Source - 50) + ' ';

               if HiByte(g_MouseItem.S.SlowDown) > 0 then
                  line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
               if HiWord(g_MouseItem.S.MAC) > 0 then begin
                  if HiWord(g_MouseItem.S.MAC) > 10 then
                     line2 := line2 + 'A.speed+' + IntToStr(HiWord(g_MouseItem.S.MAC)-10) + ' '
                  else
                     line2 := line2 + 'A.speed-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
               end;
               if LoWord(g_MouseItem.S.AC) > 0 then
                  line2 := line2 + 'Luck+' + IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
               if LoWord(g_MouseItem.S.MAC) > 0 then
                  line2 := line2 + 'Curse+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
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
                        line3 := line3 + 'Necessary Level ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        if HiWord (g_MySelf.m_Abil.DC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'Necessay DC ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        if HiWord(g_MySelf.m_Abil.MC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'Necessary MC ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        if HiWord (g_MySelf.m_Abil.SC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'Necessary SC ' + IntToStr(g_MouseItem.S.NeedLevel);
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
         10, 11,12:  //armours
            begin
               useable := FALSE;
               line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) +
                        ' Dura'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
               if g_MouseItem.S.AC > 0 then
                  line2 := 'AC' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
               if g_MouseItem.S.MAC > 0 then
                  line2 := line2 + 'AMC' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
               if g_MouseItem.S.DC > 0 then
                  line2 := line2 + 'DC' + IntToStr(LoWord(g_MouseItem.S.DC)) + '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
               if g_MouseItem.S.MC > 0 then
                  line2 := line2 + 'MC' + IntToStr(LoWord(g_MouseItem.S.MC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
               if g_MouseItem.S.SC > 0 then
                  line2 := line2 + 'SC' + IntToStr(LoWord(g_MouseItem.S.SC)) + '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
line2:= line2 + '\'; //added this as a test
               if LoByte(g_MouseItem.S.Source) > 0 then
                  line2 := line2 + 'Luck+' + IntToStr(LoByte(g_MouseItem.S.Source)) + ' ';
               if HiByte(g_MouseItem.S.Source) > 0 then
                  line2 := line2 + 'Curse+' + IntToStr(HiByte(g_MouseItem.S.Source)) + ' ';
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
                        line3 := line3 + 'Necessary Level ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        if HiWord (g_MySelf.m_Abil.DC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'Necessay DC ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        if HiWord (g_MySelf.m_Abil.MC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'Necessary MC ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        if HiWord (g_MySelf.m_Abil.SC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'Necessary SC ' + IntToStr(g_MouseItem.S.NeedLevel);
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
         19,20,21,  //necklace
         22,23,  //ring
         24,26, //brace
         62,   //boots
         63,   //stones
         64:   //belts
            begin
               useable := FALSE;
               line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight) +
                        ' Dura'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);

               case g_MouseItem.S.StdMode of
                  19,20: //necklace with luck
                     begin
                        if LoWord(g_MouseItem.S.AC) > 0 then line2 := line2 + 'A.speed+' + IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                        if HiWord(g_MouseItem.S.AC) > 0 then line2 := line2 + 'A.speed-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if LoWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + 'Curse+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                        if HiWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + 'Luck+' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                     end;
                  21:  //necklace with hp/magic recovery and aspeed
                     begin
                        if LoWord(g_MouseItem.S.MAC) > 0 then
                           line2 := line2 + 'HPR+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '0% ';
                        if HiWord(g_MouseItem.S.MAC) > 0 then
                           line2 := line2 + 'MPR+' + IntToStr(HiWord(g_MouseItem.S.MAC)) + '0% ';
                        if LoWord(g_MouseItem.S.AC) > 0 then
                           line2 := line2 + 'A.speed+' + IntToStr(LoWord(g_MouseItem.S.AC)) + ' ';
                        if HiWord(g_MouseItem.S.AC) > 0 then
                           line2 := line2 + 'A.speed-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';

                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                     end;
                  22: begin //ring with ac/amc
                        if g_MouseItem.S.AC > 0 then
                           line2 := line2 + 'AC' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if g_MouseItem.S.MAC > 0 then
                           line2 := line2 + 'AMC' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'A.speed+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                  end;
                  62:  //Boots
                     begin
                       if g_MouseItem.S.AC > 0 then
                           line2 := line2 + 'AC' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if g_MouseItem.S.MAC > 0 then
                           line2 := line2 + 'AMC' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';

                        if g_MouseItem.S.Source > 0 then
                           line2 := line2 + 'Hands W+' + IntToStr(g_MouseItem.S.Source) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then
                           line2 := line2 + 'Body W+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                     end;
                  63: //Stone
                     begin
                        line1 := '';
                        line1 := line1 + sWgt + IntToStr(g_MouseItem.S.Weight);
                        if LoWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + 'Curse+' + IntToStr(LoWord(g_MouseItem.S.MAC)) + ' ';
                        if HiWord(g_MouseItem.S.MAC) > 0 then line2 := line2 + 'Luck+' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                     end;
                  64: //belt
                      begin
                        if g_MouseItem.S.AC > 0 then
                           line2 := line2 + 'AC' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if g_MouseItem.S.MAC > 0 then
                           line2 := line2 + 'AMC' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                        if g_MouseItem.S.Source > 0 then
                           line2 := line2 + 'Bag W+' + IntToStr(g_MouseItem.S.Source) + ' ';
                     end;
                  else
                     begin
                        if g_MouseItem.S.AC > 0 then
                           line2 := line2 + 'AC' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
                        if g_MouseItem.S.MAC > 0 then
                           line2 := line2 + 'AMC' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                        if HiByte(g_MouseItem.S.Tox) > 0 then line2 := line2 + 'Agil+' + IntToStr(HiByte(g_MouseItem.S.Tox)) + ' ';
                        if HiByte(g_MouseItem.S.SlowDown) > 0 then line2 := line2 + 'Acc+' + IntToStr(HiByte(g_MouseItem.S.SlowDown)) + ' ';
                     end;
               end;
               if g_MouseItem.S.DC > 0 then
                  line2 := line2 + 'DC' + IntToStr(LoWord(g_MouseItem.S.DC)) + '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
               if g_MouseItem.S.MC > 0 then
                  line2 := line2 + 'MC' + IntToStr(LoWord(g_MouseItem.S.MC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
               if g_MouseItem.S.SC > 0 then
                  line2 := line2 + 'SC' + IntToStr(LoWord(g_MouseItem.S.SC)) + '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
line2:= line2 + '\'; //added this as a test
               if (g_MouseItem.S.Source <= -1) and (g_MouseItem.S.Source >= -50) then
                  line2 := line2 + 'Holy+' + IntToStr(-g_MouseItem.S.Source);
               if (g_MouseItem.S.Source <= -51) and (g_MouseItem.S.Source >= -100) then
                  line2 := line2 + 'Holy-' + IntToStr(-g_MouseItem.S.Source - 50);
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
                        if g_MySelf.m_Abil.Level >= g_MouseItem.S.NeedLevel then useable := TRUE;
                        line3 := line3 + 'Necessary Level ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  1: begin
                        if HiWord(g_MySelf.m_Abil.DC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'Necessay DC ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  2: begin
                        if HiWord(g_MySelf.m_Abil.MC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'Necessary MC ' + IntToStr(g_MouseItem.S.NeedLevel);
                     end;
                  3: begin
                        if HiWord(g_MySelf.m_Abil.SC) >= g_MouseItem.S.NeedLevel then
                           useable := TRUE;
                        line3 := line3 + 'Necessary SC ' + IntToStr(g_MouseItem.S.NeedLevel);
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
         25: //amulets
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight);
               line2 := 'Count '+ GetDura100Str(g_MouseItem.Dura, g_MouseItem.DuraMax);
            end;
         30: //candles
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight) + ' Durability'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
               if g_MouseItem.S.AC > 0 then
                 line2 := line2 + 'AC' + IntToStr(LoWord(g_MouseItem.S.AC)) + '-' + IntToStr(HiWord(g_MouseItem.S.AC)) + ' ';
               if g_MouseItem.S.MAC > 0 then
                 line2 := line2 + 'AMC' + IntToStr(LoWord(g_MouseItem.S.MAC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MAC)) + ' ';
                if g_MouseItem.S.DC > 0 then
                  line2 := line2 + 'DC' + IntToStr(LoWord(g_MouseItem.S.DC)) + '-' + IntToStr(HiWord(g_MouseItem.S.DC)) + ' ';
               if g_MouseItem.S.MC > 0 then
                  line2 := line2 + 'MC' + IntToStr(LoWord(g_MouseItem.S.MC)) + '-' + IntToStr(HiWord(g_MouseItem.S.MC)) + ' ';
               if g_MouseItem.S.SC > 0 then
                  line2 := line2 + 'SC' + IntToStr(LoWord(g_MouseItem.S.SC)) + '-' + IntToStr(HiWord(g_MouseItem.S.SC)) + ' ';
               if LoByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + 'HP+' + IntToStr(LoByte(g_MouseItem.S.HpAdd)) + ' ';
               if LoByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + 'MP+' + IntToStr(LoByte(g_MouseItem.S.MpAdd)) + ' ';
               if HiByte(g_MouseItem.S.HpAdd) > 0 then
                  line2 := line2 + 'HP Regen+' + IntToStr(HiByte(g_MouseItem.S.HpAdd)) + ' ';
               if HiByte(g_MouseItem.S.MpAdd) > 0 then
                  line2 := line2 + 'MP Regen+' + IntToStr(HiByte(g_MouseItem.S.MpAdd)) + ' ';
               if LoByte(g_MouseItem.S.Tox) > 0 then
                  line2 := line2 + 'PA+' + IntToStr(LoByte(g_MouseItem.S.Tox)) + ' ';
               if LoByte(g_MouseItem.S.SlowDown) > 0 then
                  line2 := line2 + 'Slow+' + IntToStr(LoByte(g_MouseItem.S.SlowDown)) + ' ';
               if g_MouseItem.S.MagAvoid > 0 then
                  line2 := line2 + 'MR+' + IntToStr(g_MouseItem.S.MagAvoid) + ' ';
               if g_MouseItem.S.ToxAvoid > 0 then
                  line2 := line2 + 'PR+' + IntToStr(g_MouseItem.S.ToxAvoid) + ' ';
            end;
         40: //meat
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight) + ' Quality'+ GetDuraStr(g_MouseItem.Dura, g_MouseItem.DuraMax);
            end;
         42: //not used in db atm
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight) + ' PoisonIngredient';
            end;
         43: //ore
            begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight) + ' Purity'+ IntToStr(Round(g_MouseItem.Dura/1000));
            end;
         45: //stacked items
            begin
              line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight * g_mouseitem.amount);
            end;
         48: //decoration item
            begin
              line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight * g_mouseitem.amount);
              if FindDecoration(g_MouseITem.Dura) <> nil then begin
                Line2 := 'Image: ' + FindDecoration(g_MouseItem.Dura).Name;
                case FindDecoration(g_MouseItem.Dura).Location of
                  0: Line3 :='Can only be placed outside';
                  1: Line3 :='Can only be placed inside';
                  2: Line3 :='Can be placed inside and outside';
                end;
              end;
            end;
         else begin
               line1 := line1 + sWgt +  IntToStr(g_MouseItem.S.Weight);
            end;
      end;
   end;
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
            TextOut (SurfaceX(Left+60), SurfaceY(Top+225), d0);
            Font.Color := g_MouseItem.S.Color;
            d1:= StringReplace(d1,'\','',[rfReplaceAll,rfIgnoreCase]);
            d2:= StringReplace(d2,'\','',[rfReplaceAll,rfIgnoreCase]);
            TextOut (SurfaceX(Left+60) + n, SurfaceY(Top+225), d1);
            TextOut (SurfaceX(Left+60), SurfaceY(Top+239), d2);
            Font.Color:= clWhite;
            if not useable then
               Font.Color := clRed;
            TextOut (SurfaceX(Left+60), SurfaceY(Top+253), d3);
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
      idx := ACol + ARow * DItemGrid.ColCount + 6{º§Æ®°ø°£};
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
   idx := ACol + ARow * DItemGrid.ColCount + 6{º§Æ®°ø°£};
   if idx in [6..MAXBAGITEM-1] then begin
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

         if (mi = -97) or (mi = -98) then exit; //µ·...
         if (mi < 0) and (mi >= -13 {-9}) then begin  //-99: SellÃ¢¿¡¼­ °¡¹æÀ¸·Î
             //»óÅÂÃ¢¿¡¼­ °¡¹æÀ¸·Î
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
            //º§Æ®Ã¢À¸·Î ¿Å±è
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
            if (g_ItemArr[idx].S.StdMode <= 4) or (g_ItemArr[idx].S.StdMode = 31) then begin //ÊýÁ¿ÇÒ ¼ö ÀÖ´Â ¾ÆÀÌÅÛ
               FrmMain.EatItem (idx);
            end;
      end else begin
         if g_boItemMoving and (g_MovingItem.Item.S.Name <> '') then begin
            FillChar(keyvalue, sizeof(TKeyboardState), #0);
            GetKeyboardState (keyvalue);
            if keyvalue[VK_CONTROL] = $80 then begin
               //º§Æ®Ã¢À¸·Î ¿Å±è
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
         g_MovingItem.Index := -98; //µ·
         g_MovingItem.Item.S.Name := g_sGoldName{'Gold'};
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin //µ·¸¸..
         g_boItemMoving := FALSE;
         g_MovingItem.Item.S.Name := '';
         if g_MovingItem.Index = -97 then begin //±³È¯Ã¢¿¡¼­ ¿Å
            DealZeroGold;
         end;
      end;
   end;
   ;
end;






{------------------------------------------------------------------------}

//»óÀÎ ´ëÈ­ Ã¢

{------------------------------------------------------------------------}


procedure TFrmDlg.ShowMDlg (face: integer; mname, msgstr: string);
var
   i: integer;
begin
   DMerchantDlg.Left := 0;  //±âº» À§Ä¡
   DMerchantDlg.Top := 0;
   MerchantFace := face;
   MerchantName := mname;
   MDlgStr := msgstr;
   DMerchantDlg.Visible := TRUE;
   DItemBag.Left := 475;  //°¡¹æÀ§Ä¡ º¯°æ
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
   for i:=0 to g_MenuItemList.Count-1 do  //¼¼ºÎ ¸Þ´ºµµ Å¬¸®¾î ÇÔ.
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
   DGemMakeItem.Visible := FALSE;

end;

procedure TFrmDlg.ShowShopMenuDlg;
begin
   MenuIndex := -1;

   DMerchantDlg.Left := 0;  //±âº» À§Ä¡
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

   DItemBag.Left := 475;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;

   LastestClickTime := GetTickCount;
end;

procedure TFrmDlg.ShowShopSellDlg;
begin
   DSellDlg.Left := 253;
   DSellDlg.Top := 206;
   DSellDlg.Visible := TRUE;

   DMenuDlg.Visible := FALSE;
   DGemMakeItem.Visible := FALSE;
   DGTList.visible :=FALSE;
   DDecoListDlg.visible:=FALSE;

   DItemBag.Left := 475;
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
   //¸Þ´ºÃ¢µµ ´ÝÀ½
   DItemBag.Left := 0;
   DItemBag.Top := 0;
   DMenuDlg.Visible := FALSE;
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


//»óÀÎ ´ëÈ­Ã¢

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
      ly := 26; //20 Milo
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
                  cmdparam := GetValidStr3 (cmdstr, cmdstr, ['/']); //cmdparam : Å¬¸¯ µÇ¾úÀ» ¶§ ¾²ÀÓ
               end else begin
                  DMenuDlg.Visible := FALSE;
                  DSellDlg.Visible := FALSE;
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
         TextOut(SX(36), SY(30), 'Item list');
         TextOut(SX(175), SY(30), 'Price');
         TextOut(SX(263), SY(30), 'Dura.');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);
         //»óÇ° ¸®½ºÆ®
         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
               Font.Color := clRed;
               TextOut (SX(29),  SY(51 + m*lh), char(7));
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
         TextOut(SX(36), SY(30), 'Custody list');
         TextOut(SX(175), SY(30), 'Dura.');
         TextOut(SX(263), SY(30), '');
         lh := LISTLINEHEIGHT;
         menuline := _MIN(MAXMENU, MenuList.Count-MenuTop);
         //»óÇ° ¸®½ºÆ®
         for i:=MenuTop to MenuTop+menuline-1 do begin
            m := i-MenuTop;
            if i = MenuIndex then begin
               Font.Color := clRed;
               TextOut (SX(29),  SY(51 + m*lh), char(7));
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
   if (lx >= 14) and (lx <= 279) and (ly >= 32) then begin
      idx := (ly-32-11) div LISTLINEHEIGHT + MenuTop;
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
   if GetTickCount < LastestClickTime then exit; //
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
      if (pg.Price = itemserverindex) then begin //º¸°ü¸ñ·ÏÀÎ°æ¿î Price = ItemServerIndexÀÓ.
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
   if GetTickCount < LastestClickTime then exit; //Å¬¸¯À» ÀÚÁÖ ¸øÇÏ°Ô Á¦ÇÑ
   L := DMerchantDlg.Left;
   T := DMerchantDlg.Top;
   with DMerchantDlg do
      for i:=0 to MDlgPoints.Count-1 do begin
         p := PTClickPoint (MDlgPoints[i]);
         if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
            (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
            PlaySound (s_glass_button_click);
            FrmMain.SendMerchantDlgSelect (g_nCurMerchant, p.RStr);
            LastestClickTime := GetTickCount + 5000; //5ÃÊÈÄ¿¡ ÊýÁ¿ °¡´É
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
   if GetTickCount < LastestClickTime then exit; //Å¬¸¯À» ÀÚÁÖ ¸øÇÏ°Ô Á¦ÇÑ
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
            dmSell:   actionname := 'Sale: ';
            dmRepair: actionname := 'Repair: ';
            dmStorage: actionname := 'Storage';
            dmConsign: actionname := 'Consign for sale';
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
         g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
         g_MovingItem.Item := g_SellDlgItem;
         g_SellDlgItem.S.Name := '';
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin //°¡¹æ,º§Æ®¿¡¼­ ¿Â°Í¸¸
         ItemClickSound (g_MovingItem.Item.S);
        if g_MovingItem.Item.S.StdMode = 45 then begin
          FrmDlg.DMessageDlg ('How many would you like to add?', [mbOk, mbAbort]);
            GetValidStrVal (DlgEditText, valstr, [' ']);
            Amount:=Str_ToInt (valstr, 0);
        end else
          Amount:=1;
        if Amount > 0 then begin
          if g_SellDlgItem.S.Name <> '' then begin //ÀÚ¸®¿¡ ÀÖÀ¸¸é
            temp := g_SellDlgItem;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBag(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_SellDlgItem := temp2;
            end else
              g_SellDlgItem := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
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
   if GetTickCount < LastestClickTime then exit; //Å¬¸¯À» ÀÚÁÖ ¸øÇÏ°Ô Á¦ÇÑ
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
          DMessageDlg ('How much do you wish to consign your "' +g_SellDlgItem.S.Name +'" for?', [mbOk, mbAbort]);
          dlgmessage := Trim(DlgEditText);

          if dlgmessage = '' then begin
            DMessageDlg ('Please enter an amount.', [mbOk]);
            exit;
          end;

          try
            amount := strtoint(dlgmessage)
          except
            DMessageDlg ('Amount can be a number only.', [mbOk]);
            exit;
          end;

          if amount < 1000 then begin
            DMessageDlg ('Minimum amount is 1,000 gold.', [mbOk]);
            exit;
          end;

          if amount > 50000000 then begin
            DMessageDlg ('Maximum amount is 50,000,000 gold.', [mbOk]);
            exit;
          end;

          if mrYes = FrmDlg.DMessageDlg ('Do you wish to consign your "' +g_SellDlgItem.S.Name +'" for ' +GetGoldStr(amount) +' gold?', [mbYes, mbNo, mbCancel]) then
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

//Ä§·¨ Å° ¼³Á¤ Ã¢ (´ÙÀÌ¾ó ·Î±×)

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
      //Ä§·¨¿ì½Ý¼ü
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

//±âº»Ã¢ÀÇ ¹Ì´Ï ¹öÆ°

{------------------------------------------------------------------------}


procedure TFrmDlg.DBotMiniMapClick(Sender: TObject; X, Y: Integer);
begin

  if (g_nMiniMapIndex < 1) then
    DScreen.AddChatBoardString('No mini map available.', clWhite, clRed)
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

//Group window

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
            TextOut (lx, ly,'Leader '+ g_GroupMembers[0]);
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
      g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5ÃÊ
      FrmMain.SendGroupMode (g_boAllowGroup);
   end;
end;

procedure TFrmDlg.DGrpCreateClick(Sender: TObject; X, Y: Integer);
var
   who: string;
begin
   if (GetTickCount > g_dwChangeGroupModeTick) and (g_GroupMembers.Count = 0) then begin
      DialogSize := 1;
      DMessageDlg ('Type the Group name you want to create.', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5ÃÊ
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
      DMessageDlg ('Type the name you want to join Group.', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5ÃÊ
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
      DMessageDlg ('Type the name you want to be deleted from Group.', [mbOk, mbAbort]);
      who := Trim (DlgEditText);
      if who <> '' then begin
         g_dwChangeGroupModeTick := GetTickCount + 5000; //timeout 5ÃÊ
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
      DScreen.AddChatBoardString ('You cannot terminate connection during fight.', clYellow, clRed);
end;

procedure TFrmDlg.DBotExitClick(Sender: TObject; X, Y: Integer);
begin
   if (GetTickCount - g_dwLatestStruckTick > 10000) and
      (GetTickCount - g_dwLatestMagicTick > 10000) and
      (GetTickCount - g_dwLatestHitTick > 10000) or
      (g_MySelf.m_boDeath) then begin
      FrmMain.AppExit;
   end else
      DScreen.AddChatBoardString ('You cannot terminate connection during fight.', clYellow, clRed);
end;

procedure TFrmDlg.DBotPlusAbilClick(Sender: TObject; X, Y: Integer);
begin
   FrmDlg.OpenAdjustAbility;
end;


{------------------------------------------------------------------------}

//trades

{------------------------------------------------------------------------}


procedure TFrmDlg.OpenDealDlg;
var
   d: TDirectDrawSurface;
begin
   DDealRemoteDlg.Left := SCREENWIDTH-236-100;
   DDealRemoteDlg.Top := 0;
   DDealDlg.Left := SCREENWIDTH-236-100;
   DDealDlg.Top  := DDealRemoteDlg.Height-15;
   DItemBag.Left := 0; //475;
   DItemBag.Top := 0;
   DItemBag.Visible := TRUE;
   DDealDlg.Visible := TRUE;
   DDealRemoteDlg.Visible := TRUE;

   FillCHar (g_DealItems, sizeof(TClientItem)*10, #0);
   FillCHar (g_DealRemoteItems, sizeof(TClientItem)*20, #0);
   g_nDealGold := 0;
   g_nDealRemoteGold := 0;
   g_boDealEnd := FALSE;

   //¾ÆÀÌÅÛ °¡¹æ¿¡ ÀÜ»óÀÌ ÀÖ´ÂÁö °Ë»ç
   ArrangeItembag;
end;

procedure TFrmDlg.CloseDealDlg;
begin
   DDealDlg.Visible := FALSE;
   DDealRemoteDlg.Visible := FALSE;

   //¾ÆÀÌÅÛ °¡¹æ¿¡ ÀÜ»óÀÌ ÀÖ´ÂÁö °Ë»ç
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
      //µô Ã¢¿¡¼­ ¸¶¿ì½º·Î ²ø°í ÀÖ´Â °ÍÀ» µôÃ¢À¸·Î ³Ö´Â´Ù. ¸¶¿ì½º¿¡ ³²´Â ÀÜ»ó(º¹»ç)À» ¾ø¾Ø´Ù.
      if g_boItemMoving then begin
         mi := g_MovingItem.Index;
         if (mi <= -20) and (mi > -30) then begin //µô Ã¢¿¡¼­ ¿Â°Í¸¸
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
         if (mi >= 0) or (mi <= -20) and (mi > -30) then begin //°¡¹æ,¿¡¼­ ¿Â°Í¸¸
            ItemClickSound (g_MovingItem.Item.S);
            g_boItemMoving := FALSE;
            if mi >= 0 then begin
              if g_MovingItem.Item.S.StdMode = 45 then begin
                FrmDlg.DMessageDlg ('How many would you like to add?', [mbOk, mbAbort]);
                GetValidStrVal (DlgEditText, valstr, [' ']);
                Amount:=Str_ToInt (valstr, 0);
              end else
                Amount:=1;
              if Amount < g_MovingItem.Item.Amount then begin
                temp2:=g_MovingItem.Item;
                dec(g_MovingItem.Item.Amount,Amount);
                AddItemBag(g_MovingItem.Item);
                temp2.Amount:=Amount;
              g_DealDlgItem := temp2; //¼­¹ö¿¡ °á°ú¸¦ ±â´Ù¸®´Âµ¿¾È º¸°ü
              end else
              g_DealDlgItem := g_MovingItem.Item; //¼­¹ö¿¡ °á°ú¸¦ ±â´Ù¸®´Âµ¿¾È º¸°ü
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
            g_MovingItem.Index := -97; //±³È¯ Ã¢¿¡¼­ÀÇ µ·
            g_MovingItem.Item.S.Name := g_sGoldName{'½ð±Ò'};
         end;
      end else begin
         if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then begin //µ·¸¸..
            if (g_MovingItem.Index = -98) then begin //°¡¹æÃ¢¿¡¼­ ¿Â µ·
               if g_MovingItem.Item.S.Name = g_sGoldName{'½ð±Ò'} then begin
                  //¾ó¸¶¸¦ ¹ö¸± °ÇÁö ¹°¾îº»´Ù.
                  DialogSize := 1;
                  g_boItemMoving := FALSE;
                  g_MovingItem.Item.S.Name := '';
                  DMessageDlg ('How much ' +g_sGoldName+ ' do you want to move?', [mbOk, mbAbort]);
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

      //Âø¿ë»óÅÂ
      sex := DRESSfeature (UserState1.Feature) mod 2;
      hair := HAIRfeature (UserState1.Feature);
      if sex = 1 then pgidx := 377   //¿©ÀÚ
      else pgidx := 376;     //³²ÀÚ
      bbx := Left + 38;
      bby := Top + 59;
      d := g_WMainImages.Images[pgidx];
      if d <> nil then
         dsurface.Draw (SurfaceX(bbx), SurfaceY(bby), d.ClientRect, d, FALSE);
      bbx := bbx - 7;
      bby := bby + 44;
      //¿Ê, ¹«±â, ¸Ó¸® ½ºÅ¸ÀÏ
      idx := 440 + hair div 2; //¸Ó¸® ½ºÅ¸ÀÏ
      if sex = 1 then idx := 480 + hair div 2;
      if idx > 0 then begin
         d := g_WMainImages.GetCachedImage (idx, ax, ay);
         if d <> nil then
            dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
      end;
      if UserState1.UseItems[U_DRESS].S.Name <> '' then begin
         idx := UserState1.UseItems[U_DRESS].S.Looks; //¿Ê if m_btSex = 1 then idx := 80; //¿©ÀÚ¿Ê
         if idx >= 0 then begin
            //d := FrmMain.WStateItem.GetCachedImage (idx, ax, ay);
            d := FrmMain.GetWStateImg(idx,ax,ay);
            if d <> nil then
               dsurface.Draw (SurfaceX(bbx+ax), SurfaceY(bby+ay), d.ClientRect, d, TRUE);
         end;
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


      {Ô­Îª´ò¿ª£¬ÏÔÊ¾ÆäËüÈËÎïÐÅÏ¢ÀïµÄ×°±¸ÐÅÏ¢£¬ÏÔÊ¾ÔÚÈËÎïÏÂ·½
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
      //ÀÌ¸§
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
         TextOut (SurfaceX(Left + 120) - TextWidth(output) div 2, SurfaceY(Top + 23),
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
    if Sender = DUSFriend then sMsg := 'Add to friend list'
    else if Sender = DUSGroup then sMsg := 'Invite to group'
    else if Sender = DUSMail then sMsg := 'Send mail';
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
      //Ô­Îª×¢ÊÍµô ÏÔÊ¾ÈËÎïÉíÉÏ´øµÄÎïÆ·ÐÅÏ¢
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
            DMessageDlg ('Last part was removed due to long length of sentence.', [mbOk]);
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
      DMessageDlg ('Press button [LIST] to call up information on Guild members.', [mbOk]);
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
         //°á°ú... ¹®ÆÄµî±ÞÀ» ¾÷µ¥ÀÌÆ® ÇÑ´Ù.
         data := '';
         for i:=0 to Memo.Lines.Count-1 do begin
            data := data + Memo.Lines[i] + #13;  //¼­¹ö¿¡¼­ ÆÄ½ÌÇÔ.
         end;
         if Length(data) > 5000 then begin
            data := Copy (data, 1, 5000);
            DMessageDlg ('Last part was removed due to long length of sentence.', [mbOk]);
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

         bx := Left + 24;
         by := Top + 60;      //55
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
   DMessageDlg ('Type character name you want to add as a member of ' + Guild + '.', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendGuildAddMem (DlgEditText);
end;

procedure TFrmDlg.DGDDelMemClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg ('Type character name you want to delete from Guild', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendGuildDelMem (DlgEditText);
end;

procedure TFrmDlg.DGDEditNoticeClick(Sender: TObject; X, Y: Integer);
begin
   GuildEditHint := '[amend Notice contents of Guild.]';
   ShowGuildEditNotice;
end;

procedure TFrmDlg.DGDEditGradeClick(Sender: TObject; X, Y: Integer);
begin
   GuildEditHint := '[amend rank and position of Guild Member . # caution : unable to AddGuildMem/DelGuilMem]';
   ShowGuildEditGrade;
end;

procedure TFrmDlg.DGDAllyClick(Sender: TObject; X, Y: Integer);
begin
   if mrOk = DMessageDlg ('To make alliance opponent Guild should be under the state of [AbleToAlly]\' +
                  'and you should face with opponent Guild chief.\' +
                  'Would you like to make alliance?', [mbOk, mbCancel])
   then
      FrmMain.SendSay ('@Alliance');
end;

procedure TFrmDlg.DGDBreakAllyClick(Sender: TObject; X, Y: Integer);
begin
   DMessageDlg ('Please type the name of Guild you want to cancel alliance.', [mbOk, mbAbort]);
   if DlgEditText <> '' then
      FrmMain.SendSay ('@CancelAlliance ' + DlgEditText);
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
//´É·ÂÄ¡ Á¶Á¤ Ã¢

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

      TextOut (l, m,      'Congratulations: you are moved up to the next level!.');
      TextOut (l, m+14,   'Choose the ability you want to raise');
      TextOut (l, m+14*2, 'You can choose only one time so');
      TextOut (l, m+14*3, 'It is better to choose very carefully.');

      Font.Color := clWhite;
      //ÇöÀçÀÇ ´É·ÂÄ¡
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
         for i:=0 to 8 do begin  //DC,MC,SC..ÀÇ ÈùÆ®°¡ ³ª¿À°Ô ÇÑ´Ù.
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
  if Sender = DBotMiniMap then sMsg:= 'MiniMap (V)'
  else if Sender = DBotTrade then sMsg:= 'Trade (T)'
  else if Sender = DBotGuild then sMsg:= 'Guild (G)'
  else if Sender = DBotGroup then sMsg:= 'Party (P)'
  else if Sender = DBotPlusAbil then sMsg:= 'Ability (M)'
  else if Sender = DBotFriend then sMsg:= 'Friend (W)'
  else if Sender = DBotLover then sMsg:= 'Relationship (L)'
  else if Sender = DBotLogout then sMsg:= 'Logout (Alt-X)'
  else if Sender = DBotExit then sMsg:= 'Exit (Alt-Q)'
  else if Sender = DBotMemo then begin
    if g_boHasMail then sMsg := 'Mailbag (M) - Unread mail'
    else sMsg := 'Mailbag (M)';
  end
  else if Sender = DMyState then sMsg:= 'Character Status (F10,C)'
  else if Sender = DMyBag then sMsg:= 'Inventory (F9,I)'
  else if Sender = DMyMagic then sMsg:= 'Skill (F11,S)'
  else if Sender = DOption then sMsg:= 'Option (F12)'
//  else if Sender = DButtonHP then sMsg:= format('HP (%d/%d)',[g_MySelf.m_Abil.HP,g_MySelf.m_Abil.MaxHP])
//  else if Sender = DButtonMP then sMsg:= format('MP (%d/%d)',[g_MySelf.m_Abil.MP,g_MySelf.m_Abil.MaxMP])
  else if Sender = DBottom then begin
     //Level
    if ((X >= SCREENWIDTH - 117) and (X <= SCREENWIDTH - 79)) and ((Y >= SCREENHEIGHT - 93) and (Y <= SCREENHEIGHT - 76)) then begin
      sMsg := 'Level (' +inttostr(g_MySelf.m_Abil.level) +')';
      nHintX := X;
      nHintY := Y;
      DScreen.ShowHint(nHintX,nHintY,sMsg, clYellow, TRUE);
      exit;
    end
     //Experience
    else if ((X >= SCREENWIDTH - 136) and (X <= SCREENWIDTH - 47)) and ((Y >= SCREENHEIGHT - 58) and (Y <= SCREENHEIGHT - 47)) then begin
      sMsg := 'Experience (' +FloatToStrFixFmt(100 * g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp, 3, 2) +'%)';
      nHintX := X;
      nHintY := Y;
      DScreen.ShowHint(nHintX,nHintY,sMsg, clYellow, TRUE);
      exit;
    end
     //Weight
    else if ((X >= SCREENWIDTH - 113) and (X <= SCREENWIDTH - 22)) and ((Y >= SCREENHEIGHT - 27) and (Y <= SCREENHEIGHT - 16)) then begin
      sMsg := format('Bag weight (%d/%d)',[g_MySelf.m_Abil.Weight,g_MySelf.m_Abil.MaxWeight]);
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
    BoldTextOut (dsurface, SurfaceX(Left + 35) , SurfaceY(Top + 70), clWhite, clBlack, 'Deposite Crafting Items');
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
         g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
         g_MovingItem.Item := g_GemItem1;
         g_GemItem1.S.Name := '';
         g_GemItem1.MakeIndex := 0;
      end;
  end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
    if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin //°¡¹æ,º§Æ®¿¡¼­ ¿Â°Í¸¸
      ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DMessageDlg ('How many would you like to add?', [mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem1.S.Name <> '' then begin //ÀÚ¸®¿¡ ÀÖÀ¸¸é
            temp:=g_GemItem1;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem1 := temp2;
            end else
              g_GemItem1 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
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
         g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
         g_MovingItem.Item := g_GemItem2;
         g_GemItem2.S.Name := '';
         g_GemItem2.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin //°¡¹æ,º§Æ®¿¡¼­ ¿Â°Í¸¸
         ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DMessageDlg ('How many would you like to add?', [mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem2.S.Name <> '' then begin //ÀÚ¸®¿¡ ÀÖÀ¸¸é
            temp:=g_GemItem2;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem2 := temp2;
            end else
              g_GemItem2 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
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
         g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
         g_MovingItem.Item := g_GemItem3;
         g_GemItem3.S.Name := '';
         g_GemItem3.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin //°¡¹æ,º§Æ®¿¡¼­ ¿Â°Í¸¸
         ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DMessageDlg ('How many would you like to add?', [mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem3.S.Name <> '' then begin //ÀÚ¸®¿¡ ÀÖÀ¸¸é
            temp:=g_GemItem3;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem3 := temp2;
            end else
              g_GemItem3 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
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
         g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
         g_MovingItem.Item := g_GemItem4;
         g_GemItem4.S.Name := '';
         g_GemItem4.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin //°¡¹æ,º§Æ®¿¡¼­ ¿Â°Í¸¸
         ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DMessageDlg ('How many would you like to add?', [mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem4.S.Name <> '' then begin //ÀÚ¸®¿¡ ÀÖÀ¸¸é
            temp:=g_GemItem4;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem4 := temp2;
            end else
              g_GemItem4 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
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
         g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
         g_MovingItem.Item := g_GemItem5;
         g_GemItem5.S.Name := '';
         g_GemItem5.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin //°¡¹æ,º§Æ®¿¡¼­ ¿Â°Í¸¸
         ItemClickSound (g_MovingItem.Item.S);
       if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DMessageDlg ('How many would you like to add?', [mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem5.S.Name <> '' then begin //ÀÚ¸®¿¡ ÀÖÀ¸¸é
            temp:=g_GemItem5;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem5 := temp2;
            end else
              g_GemItem5 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
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
         g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
         g_MovingItem.Item := g_GemItem6;
         g_GemItem6.S.Name := '';
         g_GemItem6.MakeIndex := 0;
      end;
   end else begin
      if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) then exit;
      if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -99) then begin //°¡¹æ,º§Æ®¿¡¼­ ¿Â°Í¸¸
         ItemClickSound (g_MovingItem.Item.S);
      if g_MovingItem.Item.S.StdMode = 45 then begin
        FrmDlg.DMessageDlg ('How many would you like to add?', [mbOk, mbAbort]);
        GetValidStrVal (DlgEditText, valstr, [' ']);
        Amount:=Str_ToInt (valstr, 0);
      end else
        Amount:=1;
        if Amount > 0 then begin
          if g_GemItem6.S.Name <> '' then begin //ÀÚ¸®¿¡ ÀÖÀ¸¸é
            temp:=g_GemItem6;
            if g_MovingItem.Item.Amount > Amount then begin
              temp2:=g_MovingItem.Item;
              dec(g_MovingItem.Item.Amount,Amount);
              AddItemBagst(g_MovingItem.Item);
              temp2.Amount:=Amount;
              g_GemItem6 := temp2;
            end else
              g_GemItem6 := g_MovingItem.Item;
            g_MovingItem.Index := -99; //sell Ã¢¿¡¼­ ³ª¿È..
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
    //Friends
    FrmDlg.DMessageDlg ('Please enter the name of the player you would like to add to\your friends list.', [mbOk, mbAbort]);
    sFriendAdd := Trim (FrmDlg.DlgEditText);

    if sFriendAdd = g_MySelf.m_sUserName then begin
      FrmDlg.DMessageDlg ('You cannot add yourself to your friends list.', [mbOk]);
      exit;
    end;

    if sFriendAdd <> '' then begin
      SendClientMessage(CM_ADDFRIEND, 0, 0, 0, 0, sFriendAdd);
    end;
    exit;
  end;

  //BlackList
  FrmDlg.DMessageDlg ('Please enter the name of the player you would like to add to\your black list.', [mbOk, mbAbort]);
  sFriendAdd := Trim (FrmDlg.DlgEditText);

  if sFriendAdd = g_MySelf.m_sUserName then begin
    FrmDlg.DMessageDlg ('You cannot add yourself to your black list.', [mbOk]);
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
  if FriendScreen = 0 then sListName := 'FriendsList'
  else sListName := 'BlackList';

  if FriendList[FriendScreen].Count <= 0 then begin
    FrmDlg.DMessageDlg ('You have no players on your '+sListName+' to delete.', [mbOk]);
    exit;
  end;
  if FriendIndex[FriendScreen] < 0 then begin
    FrmDlg.DMessageDlg ('Please select a player to delete from your '+sListName+'.', [mbOk]);
    exit;
  end;
  F := PTClientFriends (FriendList[FriendScreen].Items[FriendIndex[FriendScreen]]);
  if mrYes = FrmDlg.DMessageDlg ('Are you sure you would like to remove "' + F.Name + '" from your '+sListName+'?', [mbYes, mbNo]) then begin
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

  if Sender = DFrdAdd then sMsg := 'Registration'
  else if Sender = DFrdDel then sMsg := 'Delete'
  else if Sender = DFrdMemo then sMsg := 'Memo'
  else if Sender = DFrdMail then sMsg := 'Mail'
  else if Sender = DFrdWhisper then sMsg := 'Whisper'
  else begin
    F := FindFriend;
    if F <> nil then begin
      //sMsg := FindFriend.Name;
      if F.Status = 0 then sStatus := 'Offline' else sStatus := 'Online';

      sMsg := F.Memo;
      // Convert Slashes
      sMsg := StringReplace(sMsg, '\', '/', [rfReplaceAll]);
      // Convert New Lines
      sMsg := StringReplace(sMsg, #13#10, '\', [rfReplaceAll]);

      DScreen.ShowHint((X + 10), (Y + 10), 'Player: ' + F.Name + '\' + 'Status: ' + sStatus + '\' + 'Memo: ' + sMsg, clWhite, FALSE);
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

  if Button = DFrdMemo then sAction := 'add a memo about'
  else if Button = DFrdMail then sAction := 'send mail to'
  else if Button = DFrdWhisper then sAction := 'send a personal message to';

  if (Button = DFrdMemo) or (Button = DFrdMail) or (Button = DFrdWhisper) then begin
    if FriendScreen = 0 then sListName := 'FriendsList'
    else sListName := 'BlackList';

    if FriendList[FriendScreen].Count <= 0 then begin
      FrmDlg.DMessageDlg ('You have no players on your '+sListName+' '+sAction+'.', [mbOk]);
      exit;
    end;
    if FriendIndex[FriendScreen] < 0 then begin
      FrmDlg.DMessageDlg ('Please select a player from your '+sListName+' '+sAction+'.', [mbOk]);
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
  sItem = 'Item';
  sSeller = 'Seller';
  sCost = 'Cost';
  sYours = 'Your Sales';
  sAllSales = 'Item Sales';
  sStatus = 'Status';

var
  d:TDirectDrawSurface;
  i: integer;
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
          Font.Color := clRed;
        end else
          if g_AuctionItems[i].Seller = g_MySelf.m_sUserName then
            Font.Color := clLime
          else
            Font.Color := g_AuctionItems[i].Item.S.Color;

        // line by line
        TextOut (DSales.Left+101-(TextWidth(g_AuctionItems[i].Item.S.Name)div 2), 94+(19*i)+DSales.Top, g_AuctionItems[i].Item.S.Name);

        Cost := GetGoldStr(g_AuctionItems[i].Cost);
        TextOut (DSales.Left+256-(TextWidth(Cost)div 2), 94+(19*i)+DSales.Top, Cost);

        TextOut (DSales.Left+412-(TextWidth(g_AuctionItems[i].Seller)div 2), 94+(19*i)+DSales.Top, g_AuctionItems[i].Seller);

        // when clicked
        if i = AuctionMenuIndex then begin
          Font.Color := clWhite;

          // Time Left
          TextOut (DSales.Left+47, 302+DSales.Top, 'Consigned: ' +DateTimeToStr(g_AuctionItems[i].StartTime));
          TextOut (DSales.Left+47, 318+DSales.Top, 'Expires: ' +DateTimeToStr(g_AuctionItems[i].EndTime));

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
    DMessageDlg ('Search term must at least 3 characters.', [mbOk]);
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

    if g_AuctionItems[AuctionMenuIndex].Seller = 'Unsold' then begin

      if mrYes = FrmDlg.DMessageDlg ('Your "' +g_AuctionItems[AuctionMenuIndex].Item.S.Name +'" has not yet sold.\'
                                    +'Do you want your item back?', [mbYes, mbNo, mbCancel]) then
        SendClientMessage (CM_GETGOLDITEM, g_MySelf.m_nRecogId, LoWord(g_AuctionItems[AuctionMenuIndex].AuctionID), HiWord(g_AuctionItems[AuctionMenuIndex].AuctionID), 0);

      exit;
    end;

    if g_AuctionItems[AuctionMenuIndex].Seller = 'Expired' then begin

      if mrYes = FrmDlg.DMessageDlg ('Your "' +g_AuctionItems[AuctionMenuIndex].Item.S.Name +'" has expired.\'
                                    +'Do you want your item back?', [mbYes, mbNo, mbCancel]) then
        SendClientMessage (CM_GETGOLDITEM, g_MySelf.m_nRecogId, LoWord(g_AuctionItems[AuctionMenuIndex].AuctionID), HiWord(g_AuctionItems[AuctionMenuIndex].AuctionID), 0);

      exit;
    end;

    if g_AuctionItems[AuctionMenuIndex].Seller = 'Sold' then begin

      if mrYes = FrmDlg.DMessageDlg ('Your "' +g_AuctionItems[AuctionMenuIndex].Item.S.Name +'" has sold!\'
                                    +'Do you wish to recieve the gold?', [mbYes, mbNo, mbCancel]) then
        SendClientMessage (CM_GETGOLDITEM, g_MySelf.m_nRecogId, LoWord(g_AuctionItems[AuctionMenuIndex].AuctionID), HiWord(g_AuctionItems[AuctionMenuIndex].AuctionID), 0);

      exit;
    end;

  end;

  if g_AuctionItems[AuctionMenuIndex].Seller = g_MySelf.m_sUserName then begin
    DMessageDlg ('You cannot buy your own item.', [mbOk]);
    exit;
  end;

  if g_MySelf.m_nGold < g_AuctionItems[AuctionMenuIndex].Cost then begin
    DMessageDlg ('You do not have ' +GetGoldStr(g_AuctionItems[AuctionMenuIndex].Cost) +' gold.', [mbOk]);
    exit;
  end;

  if mrYes = FrmDlg.DMessageDlg ('Would you like to buy: "' +g_AuctionItems[AuctionMenuIndex].Item.S.Name +'" for '
                                  +GetGoldStr(g_AuctionItems[AuctionMenuIndex].Cost) +' gold?', [mbYes, mbNo, mbCancel]) then
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
      DMessageDlg ('Search term must at least 3 characters.', [mbOk]);
      exit;
    end;

  SendClientMessage(CM_GETAUCTION, g_MySelf.m_nRecogId, g_AuctionCurrSection, (g_AuctionCurrPage+1), 0, EdSalesEdit.Text);

end;

procedure TFrmDlg.DSalesRefreshClick(Sender: TObject; X, Y: Integer);
begin

  if g_AuctionCurrSection = 0 then exit;
  
  if EdSalesEdit.Text <> '' then
    if length(EdSalesEdit.Text) < 3 then begin
      DMessageDlg ('Search term must at least 3 characters.', [mbOk]);
      exit;
    end;

  SendClientMessage(CM_GETAUCTION, g_MySelf.m_nRecogId, g_AuctionCurrSection, g_AuctionCurrPage, 0, EdSalesEdit.Text);

end;

procedure TFrmDlg.DSalesPrevPageClick(Sender: TObject; X, Y: Integer);
begin

  if (g_AuctionCurrPage = 1) or (g_AuctionCurrSection = 0) then exit;

  if EdSalesEdit.Text <> '' then
    if length(EdSalesEdit.Text) < 3 then begin
      DMessageDlg ('Search term must at least 3 characters.', [mbOk]);
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

  if Sender = DMLReply then sMsg := 'Reply'
  else if Sender = DMLRead then sMsg := 'Read'
  else if Sender = DMLLock then sMsg := 'Protect'
  else if Sender = DMLDel then sMsg := 'Delete'
  else if Sender = DMLBlock then sMsg := 'Block List'
  else if Sender = DMailListStatus then begin
    if g_boHasMail then sMsg := 'New Mail'
    else sMsg := 'No New Mail';
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

  if Sender = DBeltSwap then sMsg := 'Belt Swap (Ctrl-Z)'
  else if Sender = DBeltClose then sMsg := 'Belt (Z)';

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
    if g_boAllowGroup then sMsg := 'Enabled'
    else sMsg := 'Disabled';
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
  if g_nMapIndex < 0 then exit; //Jacky
  d := g_WMMapImages.Images[g_nMiniMapIndex];
  if d = nil then exit;
  mx := (g_MySelf.m_nCurrX*48) div 32;
  my := (g_MySelf.m_nCurrY*32) div 32;
  rc.Left := 200; //_MAX(0, mx-60);
  rc.Top := 50;//_MAX(0, my-60);
  rc.Right := _MIN(d.ClientRect.Right, rc.Left + 600);
  rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + 400);

  if g_nViewMinMapLv = 1 then
    dSurface.StretchDraw (rc, d.ClientRect, d, TRUE)
  else dSurface.StretchDraw (rc, d.ClientRect, d, TRUE);
     //À×´ï
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
        case actor.m_btRace of    //
          50,12: btColor:=251;
          0: btColor:=255;
          else btColor:=249;
        end;    // case
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
   d: TDirectDrawSurface;
   started,total:string;
begin
   with DLoverWindow do begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
         dsurface.Draw (SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, TRUE);

      with dsurface.Canvas do begin
         SetBkMode (Handle, TRANSPARENT);
         Font.Color := clSilver;
         if g_Lovername <> '' then started := DateTimeToStr(g_StartDate);
         if g_Lovername <> '' then total := IntToStr(g_TotalDays);
         TextOut (Left+40, Top+75, 'Lover        : '+g_LoverName); //14 characters all
         TextOut (Left+40, Top+100, 'Date started : '+started); //14 characters all
         TextOut (Left+40, Top+125, 'Total days   : '+total); //14 characters all
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
 if mrOk = FrmDlg.DMessageDlg ('You will be charged 100,000 gold to break off\the relationship, continue?', [mbOk, mbCancel]) then begin
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
  if Sender = DLoverAvailable then sMsg:= 'Select Availability'
  else if Sender = DLoverAsk then sMsg:= 'Invite to a relationship'
  else if Sender = DLoverDivorce then sMsg:= 'Break the relationship';

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
    for I := PageRef to PageRef+9 do begin
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
        sStatusList.Add('U');
        ReadStatus := True;
      end;
      If (MailItem.Status and nMAIL_SPECIAL) <> 0 then sStatusList.Add('!');
      If (MailItem.Status and nMAIL_LOCKED) <> 0 then sStatusList.Add('*');
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

  MaxY := 86+(MaxLineHeight*10);
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
    FrmDlg.DMessageDlg ('There is already a Mail Window Open, please close this before reading another mail message.', [mbOk]);
  end
  else begin
    SendClientMessage(CM_READMAIL, MailItem.ID, 0, 0, 0);
    MailItem.Read := True;
    DFrdMemoClick(DMLRead,0,0);
    DMailRead.sMisc := MailItem.Sender;
    DMailRead.sMisc2 := FormatDateTime('dd/mm/yyyy hh:nn:ss:', UnixToDateTime(MailItem.Time));
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
    FrmDlg.DMessageDlg ('Please Choose a mail Item First.', [mbOk]);
  end
  else SendMail(MailItem.Sender);
end;

procedure TFrmDlg.SendMail(sTarget: String);
begin
  if DMailDlg.Visible then begin
    FrmDlg.DMessageDlg ('There is already a Mail Window Open, please close this before sending new mail.', [mbOk]);
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
    FrmDlg.DMessageDlg('You need to select an Item first to Delete it', [mbOk]);
  end
  else begin
    If (MailItem.Status and nMAIL_LOCKED) <> 0 then begin
      DMessageDlg('You can not delete a locked item. Please unlock it first.', [mbOK]);
    end
    else begin
      if mrYes = FrmDlg.DMessageDlg ('Are you sure you want to delete this Mail Item?', [mbYes, mbNo]) then begin
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
    FrmDlg.DMessageDlg('You need to select an Item first to Lock/Unlock it', [mbOk]);
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
  FrmDlg.DMessageDlg ('Please enter the name of the player you would like to add to\the block list.', [mbOk, mbAbort]);
  sBlockAdd := Trim(FrmDlg.DlgEditText);

  if sBlockAdd = g_MySelf.m_sUserName then begin
    FrmDlg.DMessageDlg ('You cannot block yourself...', [mbOk]);
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
  if mrYes = FrmDlg.DMessageDlg ('Are you sure you would like to remove "' + B.name + '" from the blocklist?', [mbYes, mbNo]) then begin
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

  if Sender = DBLAdd then sMsg := 'Add to BlockList'
  else if Sender = DMLDel then sMsg := 'Delete from Blocklist';

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
  sStatus:array[0..2] of String = ('Normal', 'On Sale', 'Sold');
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
        TextOut (SurfaceX(Left)+30, SurfaceY(Top)+48, 'Num');
        TextOut (SurfaceX(Left)+65, SurfaceY(Top)+48, 'Guild Name');
        TextOut (SurfaceX(Left)+250, SurfaceY(Top)+48, 'Guild Master');
        TextOut (SurfaceX(Left)+395, SurfaceY(Top)+48, 'Sale Price');
        TextOut (SurfaceX(Left)+475, SurfaceY(Top)+48, 'Status');
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
        TextOut (SurfaceX(Left)+110, SurfaceY(Top)+35, 'Decoration List');
        TextOut (SurfaceX(Left)+520, SurfaceY(Top)+35, IntToStr(g_GTCurrPage) + '/' + IntToStr(g_GTTotalPage));
        TextOut (SurfaceX(Left)+80, SurfaceY(Top)+65, 'Name');
        TextOut (SurfaceX(Left)+205, SurfaceY(Top)+65, 'Price');
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
      TextOut (SurfaceX(Left)+170, SurfaceY(Top)+35, 'Bulletin Board');
      TextOut (SurfaceX(Left)+350, SurfaceY(Top)+35, IntToStr(g_GTCurrPage) + '/' + IntToStr(g_GTTotalPage));
      TextOut (SurfaceX(Left)+35, SurfaceY(Top)+65, 'Poster');
      TextOut (SurfaceX(Left)+150, SurfaceY(Top)+65, 'Subject');
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
        DMessageDlg ('Last part was removed, max amount of lines = 8.', [mbOk]);
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


  DOptionsEffectOn.SetImgIndex (g_WMainImages, -1);
  DOptionsEffectOff.SetImgIndex (g_WMainImages, 774);

end;

procedure TFrmDlg.DOptionsEffectOnClick(Sender: TObject; X, Y: Integer);
begin

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

initialization
  SVNRevision('$Id: FState.pas 597 2007-04-11 19:46:11Z sean $');
end.

