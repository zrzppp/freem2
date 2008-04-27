unit DlgConfig;

interface

uses
  svn, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,MShare,DWinCtl;

type
  TfrmDlgConfig = class(TForm)
    DlgList: TListBox;
    Label1: TLabel;
    GameWindowName: TGroupBox;
    EditTop: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditLeft: TSpinEdit;
    EditHeight: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    EditWidth: TSpinEdit;
    EditImage: TSpinEdit;
    Label6: TLabel;
    ButtonShow: TButton;
    GroupBox1: TGroupBox;
    EditTestX: TSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditTestY: TSpinEdit;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    EditSpellTime: TSpinEdit;
    EditHitTime: TSpinEdit;
    GroupBox3: TGroupBox;
    CheckBoxDrawTileMap: TCheckBox;
    CheckBoxDrawDropItem: TCheckBox;
    GroupBox4: TGroupBox;
    Label11: TLabel;
    EditKey: TEdit;
    Label12: TLabel;
    EditServerName: TEdit;
    Label13: TLabel;
    EditRegIPaddr: TEdit;
    Label14: TLabel;
    EditRegPort: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure DlgListClick(Sender: TObject);
    procedure EditTopChange(Sender: TObject);
    procedure EditLeftChange(Sender: TObject);
    procedure EditWidthChange(Sender: TObject);
    procedure EditHeightChange(Sender: TObject);
    procedure EditImageChange(Sender: TObject);
    procedure ButtonShowClick(Sender: TObject);
    procedure EditTestYChange(Sender: TObject);
    procedure EditTestXChange(Sender: TObject);
    procedure EditSpellTimeChange(Sender: TObject);
    procedure EditHitTimeChange(Sender: TObject);
    procedure CheckBoxDrawTileMapClick(Sender: TObject);
    procedure CheckBoxDrawDropItemClick(Sender: TObject);
  private
    GameControl:pTControlInfo;
    boChange:Boolean;
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmDlgConfig: TfrmDlgConfig;

implementation

uses FState, ClMain;

{$R *.dfm}

{ TfrmDlgConfig }

procedure TfrmDlgConfig.Open;
begin
  EditTestX.Value:=g_nTestX;
  EditTestY.Value:=g_nTestY;
  EditSpellTime.Value:=g_dwSpellTime;
  EditHitTime.Value:=g_nHitTime;

  CheckBoxDrawTileMap.Checked:=g_boDrawTileMap;
  CheckBoxDrawDropItem.Checked:=g_boDrawDropItem;
  EditKey.Text        :=g_RegInfo.sKey;
  EditServerName.Text :=g_RegInfo.sServerName;
  EditRegIPaddr.Text  :=g_RegInfo.sRegSrvIP;
  EditRegPort.Text    :=IntToStr(g_RegInfo.nRegPort);

  //ShowModal();
  Show;

end;

procedure TfrmDlgConfig.FormCreate(Sender: TObject);
begin
  GameControl:=nil;
  boChange:=False;
  DlgList.AddItem('DScrollTop',TObject(@DlgConf.DScrollTop));
  DlgList.AddItem('DScrollUp',TObject(@DlgConf.DScrollUp));
  DlgList.AddItem('DScrollDown',TObject(@DlgConf.DScrollDown));
  DlgList.AddItem('DScrollBottom',TObject(@DlgConf.DScrollBottom));
  DlgList.AddItem('DBotItemShop',TObject(@DlgConf.DBotItemShop));
  DlgList.AddItem('DItemShopJobAll',TObject(@DlgConf.DItemShopJobAll));
  DlgList.AddItem('DItemShopJobWarrior',TObject(@DlgConf.DItemShopJobWarrior));
  DlgList.AddItem('DItemShopJobWizard',TObject(@DlgConf.DItemShopJobWizard));
  DlgList.AddItem('DItemShopJobMonk',TObject(@DlgConf.DItemShopJobMonk));
  DlgList.AddItem('DItemShopJobCommon',TObject(@DlgConf.DItemShopJobCommon));
  DlgList.AddItem('DGrpPgUp',TObject(@DlgConf.DGrpPgUp));
  DlgList.AddItem('DGrpPgDn',TObject(@DlgConf.DGrpPgDn));
  DlgList.AddItem('DItemShopFind',TObject(@DlgConf.DItemShopFind));

  DlgList.AddItem('DItemShopCaNew',TObject(@DlgConf.DItemShopCaNew));
  DlgList.AddItem('DItemShopCaAll',TObject(@DlgConf.DItemShopCaAll));
  DlgList.AddItem('DItemShopCaWeapon',TObject(@DlgConf.DItemShopCaWeapon));
  DlgList.AddItem('DItemShopCaArmor',TObject(@DlgConf.DItemShopCaArmor));
  DlgList.AddItem('DItemShopCaAcc',TObject(@DlgConf.DItemShopCaAcc));
  DlgList.AddItem('DItemShopCasSubitem',TObject(@DlgConf.DItemShopCasSubitem));
  DlgList.AddItem('DItemShopCaOther',TObject(@DlgConf.DItemShopCaOther));
  DlgList.AddItem('DItemShopCaPackage',TObject(@DlgConf.DItemShopFind));
  DlgList.AddItem('DItemShopCaSub1',TObject(@DlgConf.DItemShopCaSub1));
  DlgList.AddItem('DItemShopCaSub2',TObject(@DlgConf.DItemShopCaSub2));
  DlgList.AddItem('DItemShopCaSub3',TObject(@DlgConf.DItemShopCaSub3));
  DlgList.AddItem('DItemShopCaSub4',TObject(@DlgConf.DItemShopCaSub4));
  DlgList.AddItem('DItemShopCaSub5',TObject(@DlgConf.DItemShopCaSub5));
  DlgList.AddItem('DItemShopCaSub6',TObject(@DlgConf.DItemShopCaSub6));
  DlgList.AddItem('DItemShopCaSub7',TObject(@DlgConf.DItemShopCaSub7));
  DlgList.AddItem('DItemShopGetGift',TObject(@DlgConf.DItemShopGetGift));
  DlgList.AddItem('DItemShopAddFav',TObject(@DlgConf.DItemShopAddFav));
  DlgList.AddItem('DItemShopBye',TObject(@DlgConf.DItemShopBye));
  DlgList.AddItem('DItemShopGift',TObject(@DlgConf.DItemShopGift));
  DlgList.AddItem('DItemShopPayMoney',TObject(@DlgConf.DItemShopPayMoney));
  DlgList.AddItem('DItemShopWear',TObject(@DlgConf.DItemShopWear));
  DlgList.AddItem('DItemShopWearLturn',TObject(@DlgConf.DItemShopWearLturn));
  DlgList.AddItem('DItemShopWearChange',TObject(@DlgConf.DItemShopWearChange));
  DlgList.AddItem('DItemShopWearRturn',TObject(@DlgConf.DItemShopWearRturn));
  DlgList.AddItem('DItemShopListPrev',TObject(@DlgConf.DItemShopListPrev));
  DlgList.AddItem('DItemShopListNext',TObject(@DlgConf.DItemShopListNext));
  DlgList.AddItem('DShopScrollBarUp',TObject(@DlgConf.DShopScrollBarUp));
  DlgList.AddItem('DShopScrollBarDown',TObject(@DlgConf.DShopScrollBarDown));
  DlgList.AddItem('DShopScrollBar',TObject(@DlgConf.DShopScrollBar));
  DlgList.AddItem('DItemShopCaFav',TObject(@DlgConf.DItemShopCaFav));
  DlgList.AddItem('DItemShopInPackBack',TObject(@DlgConf.DItemShopInPackBack));
  DlgList.AddItem('DItemShopCashRefresh',TObject(@DlgConf.DItemShopCashRefresh));
  DlgList.AddItem('DItemShopPackSub1',TObject(@DlgConf.DItemShopPackSub1));
  DlgList.AddItem('DItemShopPackSub2',TObject(@DlgConf.DItemShopPackSub2));
  DlgList.AddItem('DItemShopPackSub3',TObject(@DlgConf.DItemShopPackSub3));
  DlgList.AddItem('DItemShopPackSub4',TObject(@DlgConf.DItemShopPackSub4));
  DlgList.AddItem('DItemShopPackSub5',TObject(@DlgConf.DItemShopPackSub5));
  DlgList.AddItem('DItemShopPackSub6',TObject(@DlgConf.DItemShopPackSub6));
  DlgList.AddItem('DItemShopPackSub7',TObject(@DlgConf.DItemShopPackSub7));
  DlgList.AddItem('DItemShopPackSub8',TObject(@DlgConf.DItemShopPackSub8));
  DlgList.AddItem('DItemShopFavDel1',TObject(@DlgConf.DItemShopFavDel1));
  DlgList.AddItem('DItemShopFavDel2',TObject(@DlgConf.DItemShopFavDel2));
  DlgList.AddItem('DItemShopFavDel3',TObject(@DlgConf.DItemShopFavDel3));
  DlgList.AddItem('DItemShopFavDel4',TObject(@DlgConf.DItemShopFavDel4));
  DlgList.AddItem('DItemShopFavDel5',TObject(@DlgConf.DItemShopFavDel5));
  DlgList.AddItem('DItemShopFavDel6',TObject(@DlgConf.DItemShopFavDel6));
  DlgList.AddItem('DItemShopFavDel7',TObject(@DlgConf.DItemShopFavDel7));
  DlgList.AddItem('DItemShopFavDel8',TObject(@DlgConf.DItemShopFavDel8));
  DlgList.AddItem('DItemShopPriceUp',TObject(@DlgConf.DItemShopPriceUp));
  DlgList.AddItem('DItemShopPriceDn',TObject(@DlgConf.DItemShopPriceDn));
  DlgList.AddItem('DItemShopCheckSort',TObject(@DlgConf.DItemShopCheckSort));
  Self.ParentWindow:=FrmMain.Handle;

//  Show();
end;

procedure TfrmDlgConfig.DlgListClick(Sender: TObject);
begin
  boChange:=False;
  GameWindowName.Caption:=DlgList.Items.Strings[DlgList.ItemIndex];
  GameControl:=pTControlInfo(DlgList.Items.Objects[DlgList.ItemIndex]);
  EditTop.Value:=GameControl.Top;
  EditLeft.Value:=GameControl.Left;
  EditWidth.Value:=GameControl.Width;
  EditHeight.Value:=GameControl.Height;
  EditImage.Value:=GameControl.Image;
  if GameControl <> nil then GameWindowName.Enabled:=True;
    
  boChange:=True;
end;

procedure TfrmDlgConfig.EditTopChange(Sender: TObject);
begin
  if not boChange then exit;
  GameControl.Top:=EditTop.Value;
  GameControl.Obj.Top:=GameControl.Top;
end;

procedure TfrmDlgConfig.EditLeftChange(Sender: TObject);
begin
  if not boChange then exit;
  GameControl.Left:=EditLeft.Value;
  GameControl.Obj.Left:=GameControl.Left;

end;

procedure TfrmDlgConfig.EditWidthChange(Sender: TObject);
begin
  if not boChange then exit;
  GameControl.Width:=EditWidth.Value;
  GameControl.Obj.Width:=GameControl.Width;
end;

procedure TfrmDlgConfig.EditHeightChange(Sender: TObject);
begin
  if not boChange then exit;
  GameControl.Height:=EditHeight.Value;
  GameControl.Obj.Height:=GameControl.Height;
end;

procedure TfrmDlgConfig.EditImageChange(Sender: TObject);
begin
  if not boChange then exit;
  GameControl.Image:=EditImage.Value;
  GameControl.Obj.SetImgIndex(g_WMainImages,GameControl.Image);
end;

procedure TfrmDlgConfig.ButtonShowClick(Sender: TObject);
begin
  if GameControl <> nil then begin
    GameControl.Obj.Visible:= not GameControl.Obj.Visible;
  end;
end;

procedure TfrmDlgConfig.EditTestYChange(Sender: TObject);
begin
  g_nTestY:=EditTestY.Value;
end;

procedure TfrmDlgConfig.EditTestXChange(Sender: TObject);
begin
  g_nTestX:=EditTestX.Value;
end;

procedure TfrmDlgConfig.EditSpellTimeChange(Sender: TObject);
begin
  g_dwSpellTime:=EditSpellTime.Value;
end;

procedure TfrmDlgConfig.EditHitTimeChange(Sender: TObject);
begin
  g_nHitTime:=EditHitTime.Value;
end;

procedure TfrmDlgConfig.CheckBoxDrawTileMapClick(Sender: TObject);
begin
  g_boDrawTileMap:=CheckBoxDrawTileMap.Checked;
end;

procedure TfrmDlgConfig.CheckBoxDrawDropItemClick(Sender: TObject);
begin
  g_boDrawDropItem:=CheckBoxDrawDropItem.Checked;
end;


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: DlgConfig.pas 220 2006-08-12 00:00:32Z Dataforce $');
end.
