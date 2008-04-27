unit FunctionConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, EngineAPI, EngineType, Menus, IniFiles;

type
  TFrmFunctionConfig = class(TForm)
    FunctionConfigControl: TPageControl;
    Label14: TLabel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox52: TGroupBox;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label128: TLabel;
    SpinEditStartHPRock: TSpinEdit;
    SpinEditRockAddHP: TSpinEdit;
    SpinEditHPRockDecDura: TSpinEdit;
    SpinEditHPRockSpell: TSpinEdit;
    CheckBoxStartHPRock: TCheckBox;
    GroupBox53: TGroupBox;
    Label122: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label123: TLabel;
    Label129: TLabel;
    SpinEditStartMPRock: TSpinEdit;
    SpinEditRockAddMP: TSpinEdit;
    SpinEditMPRockDecDura: TSpinEdit;
    SpinEditMPRockSpell: TSpinEdit;
    CheckBoxStartMPRock: TCheckBox;
    ButtonSuperRockSave: TButton;
    Label1: TLabel;
    EditStartHPRockMsg: TEdit;
    Label2: TLabel;
    EditStartMPRockMsg: TEdit;
    GroupBox21: TGroupBox;
    ListBoxitemList: TListBox;
    ButtonDisallowDel: TButton;
    ButtonDisallowSave: TButton;
    GroupBox22: TGroupBox;
    ListViewMsgFilter: TListView;
    GroupBox23: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    EditFilterMsg: TEdit;
    EditNewMsg: TEdit;
    ButtonMsgFilterAdd: TButton;
    ButtonMsgFilterDel: TButton;
    ButtonMsgFilterSave: TButton;
    ButtonMsgFilterChg: TButton;
    GroupBox5: TGroupBox;
    ListBoxUserCommand: TListBox;
    Label3: TLabel;
    EditCommandName: TEdit;
    ButtonUserCommandAdd: TButton;
    Label4: TLabel;
    SpinEditCommandIdx: TSpinEdit;
    ButtonUserCommandDel: TButton;
    ButtonUserCommandChg: TButton;
    GroupBox1: TGroupBox;
    ButtonDisallowDrop: TButton;
    ButtonDisallowDeal: TButton;
    ButtonDisallowStorage: TButton;
    ListViewDisallow: TListView;
    ButtonDisallowRepair: TButton;
    ButtonUserCommandSave: TButton;
    ButtonLoadCheckItemList: TButton;
    ButtonLoadUserCommandList: TButton;
    ButtonLoadMsgFilterList: TButton;
    GroupBoxAttack: TGroupBox;
    CheckBoxAttack1: TCheckBox;
    CheckBoxAttack2: TCheckBox;
    CheckBoxAttack3: TCheckBox;
    SpinEditAttack1: TSpinEdit;
    SpinEditAttack2: TSpinEdit;
    SpinEditAttack3: TSpinEdit;
    ButtonAttackSave: TButton;
    CheckBoxStart: TCheckBox;
    procedure CheckBoxStartHPRockClick(Sender: TObject);
    procedure CheckBoxStartMPRockClick(Sender: TObject);
    procedure EditStartHPRockMsgChange(Sender: TObject);
    procedure EditStartMPRockMsgChange(Sender: TObject);
    procedure ButtonSuperRockSaveClick(Sender: TObject);
    procedure SpinEditStartHPRockChange(Sender: TObject);
    procedure SpinEditHPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddHPChange(Sender: TObject);
    procedure SpinEditHPRockDecDuraChange(Sender: TObject);
    procedure SpinEditMPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddMPChange(Sender: TObject);
    procedure SpinEditMPRockDecDuraChange(Sender: TObject);
    procedure SpinEditStartMPRockChange(Sender: TObject);
    procedure ListBoxUserCommandClick(Sender: TObject);
    procedure ButtonUserCommandAddClick(Sender: TObject);
    procedure ButtonUserCommandDelClick(Sender: TObject);
    procedure ButtonUserCommandChgClick(Sender: TObject);
    procedure ButtonUserCommandSaveClick(Sender: TObject);
    procedure ButtonLoadUserCommandListClick(Sender: TObject);
    procedure ListBoxitemListDblClick(Sender: TObject);
    procedure ListViewDisallowClick(Sender: TObject);
    procedure ButtonDisallowDropClick(Sender: TObject);
    procedure ButtonDisallowDealClick(Sender: TObject);
    procedure ButtonDisallowStorageClick(Sender: TObject);
    procedure ButtonDisallowRepairClick(Sender: TObject);
    procedure ButtonDisallowDelClick(Sender: TObject);
    procedure ButtonDisallowSaveClick(Sender: TObject);
    procedure ButtonLoadCheckItemListClick(Sender: TObject);
    procedure ListViewMsgFilterClick(Sender: TObject);
    procedure ButtonLoadMsgFilterListClick(Sender: TObject);
    procedure ButtonMsgFilterSaveClick(Sender: TObject);
    procedure ButtonMsgFilterAddClick(Sender: TObject);
    procedure ButtonMsgFilterChgClick(Sender: TObject);
    procedure ButtonMsgFilterDelClick(Sender: TObject);
    procedure CheckBoxAttack1Click(Sender: TObject);
    procedure CheckBoxAttack2Click(Sender: TObject);
    procedure CheckBoxAttack3Click(Sender: TObject);
    procedure SpinEditAttack1Change(Sender: TObject);
    procedure SpinEditAttack2Change(Sender: TObject);
    procedure SpinEditAttack3Change(Sender: TObject);
    procedure ButtonAttackSaveClick(Sender: TObject);
    procedure CheckBoxStartClick(Sender: TObject);
  private
    { Private declarations }
    procedure uModValue;
    procedure ModValue;
    procedure RefSuperRock();
    procedure RefLoadMsgFilterList();
    procedure RefLoadDisallowStdItems();
    procedure RefLoadAttackInfo();
    function InCommandListOfName(sCommandName: string): Boolean;
    function InCommandListOfIndex(nIndex: Integer): Boolean;
    function InListBoxitemList(sItemName: string): Boolean;
    function InFilterMsgList(sFilterMsg: string): Boolean;
  public
    { Public declarations }
    procedure Open();
  end;
procedure InitUserConfig();
procedure InitSuperRock();
procedure UnInitSuperRock();
procedure SuperRock(PlayObject: TPlayObject; var m_UseItems: _TPLAYUSEITEMS; var m_WAbil: _TABILITY); stdcall;
var
  FrmFunctionConfig: TFrmFunctionConfig;
  boModValued, boOpened: Boolean;
implementation
uses
  PlayUserCmd, PlayUser, PlugShare;
{$R *.dfm}
procedure InitSuperRock();
begin
  dwRockAddHPTick := GetTickCount;
  dwRockAddMPTick := GetTickCount;
  TPlayObject_SetHookUserRunMsg(SuperRock);
end;
procedure UnInitSuperRock();
begin
  TPlayObject_SetHookUserRunMsg(nil);
end;
procedure SuperRock(PlayObject: TPlayObject; var m_UseItems: _TPLAYUSEITEMS; var m_WAbil: _TABILITY);
var
  StdItem: _LPTSTDITEM;
  nAddHP, nAddMP: Integer;
begin
  //气血石 魔血石
  if (PlayObject <> nil) and (not TBaseObject_boDeath(PlayObject)^) and (not TBaseObject_boGhost(PlayObject)^) then begin
    if m_UseItems[U_CHARM].wIndex > 0 then begin
      if m_UseItems[U_CHARM].wDura > 0 then begin
        StdItem := TUserEngine_GetStdItemByIndex(m_UseItems[U_CHARM].wIndex);
        if (StdItem <> nil) and (StdItem.btAniCount > 0) then begin
          case StdItem.btAniCount of
            1: begin
                if m_WAbil.wHP <= ((m_WAbil.wMaxHP * nStartHPRock) div 100) then begin
                  if GetTickCount - dwRockAddHPTick > nHPRockSpell * 1000 then begin
                    dwRockAddHPTick := GetTickCount;
                    if (boStartHPRockMsg) and (sStartHPRockMsg <> '') then TBaseObject_SysMsg(PlayObject, PChar(sStartHPRockMsg), mc_Red, mt_Hint);
                    if m_UseItems[U_CHARM].wDura > nHPRockDecDura then begin
                      nAddHP := (m_UseItems[U_CHARM].wDuraMax * nRockAddHP) div 100;
                      if nAddHP > m_WAbil.wMaxHP then nAddHP := m_WAbil.wMaxHP;
                      if m_WAbil.wHP + nAddHP > m_WAbil.wMaxHP then begin
                        m_WAbil.wHP := m_WAbil.wMaxHP;
                      end else begin
                        Inc(m_WAbil.wHP, nAddHP);
                      end;
                      Dec(m_UseItems[U_CHARM].wDura, nHPRockDecDura);
                      TBaseObject_SendMsg(PlayObject, PlayObject, RM_ABILITY, 0, 0, 0, 0, nil);
                      TBaseObject_SendMsg(PlayObject, PlayObject, RM_DURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);
                    end else begin
                      nAddHP := (m_UseItems[U_CHARM].wDuraMax * nRockAddHP) div 100;
                      if nAddHP > m_WAbil.wMaxHP then nAddHP := m_WAbil.wMaxHP;
                      if m_WAbil.wHP + nAddHP > m_WAbil.wMaxHP then begin
                        m_WAbil.wHP := m_WAbil.wMaxHP;
                      end else begin
                        Inc(m_WAbil.wHP, nAddHP);
                      end;
                      m_UseItems[U_CHARM].wDura := 0;
                      TBaseObject_SendMsg(PlayObject, PlayObject, RM_ABILITY, 0, 0, 0, 0, nil);
                      TBaseObject_SendMsg(PlayObject, PlayObject, RM_DURACHANGE, U_CHARM, m_UseItems[U_CHARM].wDura, m_UseItems[U_CHARM].wDuraMax, 0, nil);
                    end;
                  end;
                end;
              end;
            2: begin
                if m_WAbil.wMP <= ((m_WAbil.wMaxMP * nStartMPRock) div 100) then begin
                  if GetTickCount - dwRockAddMPTick > nMPRockSpell * 1000 then begin
                    dwRockAddMPTick := GetTickCount;
                    if (boStartMPRockMsg) and (sStartMPRockMsg <> '') then TBaseObject_SysMsg(PlayObject, PChar(sStartMPRockMsg), mc_Red, mt_Hint);
                    if m_UseItems[U_CHARM].wDura > nMPRockDecDura then begin
                      nAddMP := (m_UseItems[U_CHARM].wDuraMax * nRockAddMP) div 100;
                      if nAddMP > m_WAbil.wMaxMP then nAddMP := m_WAbil.wMaxMP;
                      if m_WAbil.wMP + nAddMP > m_WAbil.wMaxMP then begin
                        m_WAbil.wMP := m_WAbil.wMaxMP;
                      end else begin
                        Inc(m_WAbil.wMP, nAddMP);
                      end;
                      Dec(m_UseItems[U_CHARM].wDura, nMPRockDecDura);
                      TBaseObject_SendMsg(PlayObject, PlayObject, RM_ABILITY, 0, 0, 0, 0, nil);
                    end else begin
                      if nAddMP > m_WAbil.wMaxMP then nAddMP := m_WAbil.wMaxMP;
                      if m_WAbil.wMP + nAddMP > m_WAbil.wMaxMP then begin
                        m_WAbil.wMP := m_WAbil.wMaxMP;
                      end else begin
                        Inc(m_WAbil.wMP, nAddMP);
                      end;
                      m_UseItems[U_CHARM].wDura := 0;
                      TBaseObject_SendMsg(PlayObject, PlayObject, RM_ABILITY, 0, 0, 0, 0, nil);
                    end;
                  end;
                end;
              end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonSuperRockSaveClick(Sender: TObject);
var
  Config: TIniFile;
  sFileName: string;
begin
  sFileName := '.\zPlugOfEngine.ini';
  Config := TIniFile.Create(sFileName);
  if Config <> nil then begin
    Config.WriteInteger(PlugClass, 'StartHPRock', nStartHPRock);
    Config.WriteInteger(PlugClass, 'StartMPRock', nStartMPRock);
    Config.WriteInteger(PlugClass, 'HPRockSpell', nHPRockSpell);
    Config.WriteInteger(PlugClass, 'MPRockSpell', nMPRockSpell);
    Config.WriteInteger(PlugClass, 'RockAddHP', nRockAddHP);
    Config.WriteInteger(PlugClass, 'RockAddMP', nRockAddMP);
    Config.WriteInteger(PlugClass, 'HPRockDecDura', nHPRockDecDura);
    Config.WriteInteger(PlugClass, 'MPRockDecDura', nMPRockDecDura);
    Config.WriteBool(PlugClass, 'StartHPRockHint', boStartHPRockMsg);
    Config.WriteBool(PlugClass, 'StartMPRockHint', boStartMPRockMsg);
    Config.WriteString(PlugClass, 'StartHPRockMsg', sStartHPRockMsg);
    Config.WriteString(PlugClass, 'StartMPRockMsg', sStartMPRockMsg);
    Config.Free;
  end;
  uModValue();
end;

procedure InitUserConfig();
var
  Config: TIniFile;
  sFileName: string;
  nLoadInteger: Integer;
  LoadString: string;
begin
  sFileName := '.\zPlugOfEngine.ini';
  Config := TIniFile.Create(sFileName);
  if Config <> nil then begin
    nLoadInteger := Config.ReadInteger(PlugClass, 'StartHPRock', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'StartHPRock', nStartHPRock)
    else nStartHPRock := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'StartMPRock', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'StartMPRock', nStartMPRock)
    else nStartMPRock := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'HPRockSpell', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'HPRockSpell', nHPRockSpell)
    else nHPRockSpell := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'MPRockSpell', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'MPRockSpell', nMPRockSpell)
    else nMPRockSpell := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'RockAddHP', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'RockAddHP', nRockAddHP)
    else nRockAddHP := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'RockAddMP', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'RockAddMP', nRockAddMP)
    else nRockAddMP := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'HPRockDecDura', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'HPRockDecDura', nHPRockDecDura)
    else nHPRockDecDura := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'MPRockDecDura', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'MPRockDecDura', nMPRockDecDura)
    else nMPRockDecDura := nLoadInteger;

    if Config.ReadInteger(PlugClass, 'StartHPRockHint', -1) < 0 then
      Config.WriteBool(PlugClass, 'StartHPRockHint', boStartHPRockMsg);
    boStartHPRockMsg := Config.ReadBool(PlugClass, 'StartHPRockHint', boStartHPRockMsg);

    if Config.ReadInteger(PlugClass, 'StartMPRockHint', -1) < 0 then
      Config.WriteBool(PlugClass, 'StartMPRockHint', boStartMPRockMsg);
    boStartMPRockMsg := Config.ReadBool(PlugClass, 'StartMPRockHint', boStartMPRockMsg);

    LoadString := Config.ReadString(PlugClass, 'StartHPRockMsg', '');
    if LoadString = '' then
      Config.WriteString(PlugClass, 'StartHPRockMsg', sStartHPRockMsg)
    else sStartHPRockMsg := LoadString;

    LoadString := Config.ReadString(PlugClass, 'StartMPRockMsg', '');
    if LoadString = '' then
      Config.WriteString(PlugClass, 'StartMPRockMsg', sStartMPRockMsg)
    else sStartMPRockMsg := LoadString;

    ////////////////////////////////////////////////////////////////////////////////
    if Config.ReadInteger(PlugClass, 'CCAttack', -1) < 0 then
      Config.WriteBool(PlugClass, 'CCAttack', boCCAttack);
    boCCAttack := Config.ReadBool(PlugClass, 'CCAttack', boCCAttack);

    if Config.ReadInteger(PlugClass, 'DataAttack', -1) < 0 then
      Config.WriteBool(PlugClass, 'DataAttack', boDataAttack);
    boDataAttack := Config.ReadBool(PlugClass, 'DataAttack', boDataAttack);

    if Config.ReadInteger(PlugClass, 'KeepConnect', -1) < 0 then
      Config.WriteBool(PlugClass, 'KeepConnect', boKeepConnectTimeOut);
    boKeepConnectTimeOut := Config.ReadBool(PlugClass, 'KeepConnect', boKeepConnectTimeOut);

    nLoadInteger := Config.ReadInteger(PlugClass, 'CCAttackTime', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'CCAttackTime', dwAttackTick)
    else dwAttackTick := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'ReviceMsgLength', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'ReviceMsgLength', nReviceMsgLength)
    else nReviceMsgLength := nLoadInteger;

    nLoadInteger := Config.ReadInteger(PlugClass, 'KeepConnectTimeOut', -1);
    if nLoadInteger < 0 then
      Config.WriteInteger(PlugClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut)
    else dwKeepConnectTimeOut := nLoadInteger;

    if Config.ReadInteger(PlugClass, 'StartAttack', -1) < 0 then
      Config.WriteBool(PlugClass, 'StartAttack', boStartAttack);
    boStartAttack := Config.ReadBool(PlugClass, 'StartAttack', boStartAttack);

    Config.Free;
  end;
end;

procedure TFrmFunctionConfig.Open();
var
  I: Integer;
  StdItem: _LPTOSTDITEM;
  List: Classes.TList;
begin
  boOpened := False;
  uModValue();
  ListBoxitemList.Items.Clear;
  ListBoxUserCommand.Items.Clear;
  if TUserEngine_GetStdItemList <> nil then begin
    List := Classes.TList(TUserEngine_GetStdItemList);
    for I := 0 to List.Count - 1 do begin
      StdItem := List.Items[I];
      ListBoxitemList.Items.AddObject(StdItem.szName, TObject(StdItem));
    end;
  end;
  RefSuperRock();
  RefLoadMsgFilterList();
  RefLoadDisallowStdItems();
  RefLoadAttackInfo();
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
  boOpened := TRUE;
  FunctionConfigControl.ActivePageIndex := 0;
  ShowModal;
end;

procedure TFrmFunctionConfig.ModValue;
begin
  boModValued := TRUE;
  ButtonSuperRockSave.Enabled := TRUE;
  ButtonUserCommandSave.Enabled := TRUE;
  ButtonDisallowSave.Enabled := TRUE;
  ButtonMsgFilterSave.Enabled := TRUE;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.uModValue;
begin
  boModValued := False;
  ButtonSuperRockSave.Enabled := False;
  ButtonUserCommandDel.Enabled := False;
  ButtonUserCommandChg.Enabled := False;
  ButtonDisallowDel.Enabled := False;
  ButtonMsgFilterDel.Enabled := False;
  ButtonMsgFilterChg.Enabled := False;
  ButtonAttackSave.Enabled := False;
end;

procedure TFrmFunctionConfig.RefSuperRock();
begin
  SpinEditStartHPRock.Value := nStartHPRock;
  SpinEditStartMPRock.Value := nStartMPRock;
  SpinEditHPRockSpell.Value := nHPRockSpell;
  SpinEditMPRockSpell.Value := nMPRockSpell;
  SpinEditRockAddHP.Value := nRockAddHP;
  SpinEditRockAddMP.Value := nRockAddMP;
  SpinEditHPRockDecDura.Value := nHPRockDecDura;
  SpinEditMPRockDecDura.Value := nMPRockDecDura;
  CheckBoxStartHPRock.Checked := boStartHPRockMsg;
  CheckBoxStartMPRock.Checked := boStartMPRockMsg;
  EditStartHPRockMsg.Text := sStartHPRockMsg;
  EditStartMPRockMsg.Text := sStartMPRockMsg;
end;

procedure TFrmFunctionConfig.CheckBoxStartHPRockClick(Sender: TObject);
begin
  if not boOpened then Exit;
  boStartHPRockMsg := CheckBoxStartHPRock.Checked;
  ButtonSuperRockSave.Enabled := TRUE;
  if boStartHPRockMsg then
    EditStartHPRockMsg.Enabled := TRUE
  else EditStartHPRockMsg.Enabled := False;
end;

procedure TFrmFunctionConfig.CheckBoxStartMPRockClick(Sender: TObject);
begin
  if not boOpened then Exit;
  boStartMPRockMsg := CheckBoxStartMPRock.Checked;
  ButtonSuperRockSave.Enabled := TRUE;
  if boStartMPRockMsg then
    EditStartMPRockMsg.Enabled := TRUE
  else EditStartMPRockMsg.Enabled := False;
end;

procedure TFrmFunctionConfig.EditStartHPRockMsgChange(Sender: TObject);
begin
  if not boOpened then Exit;
  sStartHPRockMsg := Trim(EditStartHPRockMsg.Text);
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.EditStartMPRockMsgChange(Sender: TObject);
begin
  if not boOpened then Exit;
  sStartMPRockMsg := Trim(EditStartMPRockMsg.Text);
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditStartHPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nStartHPRock := SpinEditStartHPRock.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditHPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nHPRockSpell := SpinEditHPRockSpell.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditRockAddHPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nRockAddHP := SpinEditRockAddHP.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditHPRockDecDuraChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nHPRockDecDura := SpinEditHPRockDecDura.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditMPRockSpellChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nMPRockSpell := SpinEditMPRockSpell.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditRockAddMPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nRockAddMP := SpinEditRockAddMP.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditMPRockDecDuraChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nMPRockDecDura := SpinEditMPRockDecDura.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditStartMPRockChange(Sender: TObject);
begin
  if not boOpened then Exit;
  nStartMPRock := SpinEditStartMPRock.Value;
  ButtonSuperRockSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.ListBoxUserCommandClick(Sender: TObject);
begin
  try
    EditCommandName.Text := ListBoxUserCommand.Items.Strings[ListBoxUserCommand.ItemIndex];
    SpinEditCommandIdx.Value := Integer(ListBoxUserCommand.Items.Objects[ListBoxUserCommand.ItemIndex]);
    ButtonUserCommandDel.Enabled := TRUE;
    ButtonUserCommandChg.Enabled := TRUE;
  except
    EditCommandName.Text := '';
    SpinEditCommandIdx.Value := 0;
    ButtonUserCommandDel.Enabled := False;
    ButtonUserCommandChg.Enabled := False;
  end;
end;

function TFrmFunctionConfig.InCommandListOfIndex(nIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
    if nIndex = Integer(ListBoxUserCommand.Items.Objects[I]) then begin
      Result := TRUE;
      break;
    end;
  end;
end;

function TFrmFunctionConfig.InCommandListOfName(sCommandName: string): Boolean;
var
  I, nCount: Integer;
begin
  Result := False;
  for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
    if CompareText(sCommandName, ListBoxUserCommand.Items.Strings[I]) = 0 then begin
      Result := TRUE;
      break;
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonUserCommandAddClick(Sender: TObject);
var
  sCommandName: string;
  nCommandIndex: Integer;
begin
  sCommandName := Trim(EditCommandName.Text);
  nCommandIndex := SpinEditCommandIdx.Value;
  if sCommandName = '' then begin
    Application.MessageBox('请输入命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfName(sCommandName) then begin
    Application.MessageBox('输入的命令已经存在，请选择其他命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfIndex(nCommandIndex) then begin
    Application.MessageBox('输入的命令编号已经存在，请选择其他命令编号！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListBoxUserCommand.Items.AddObject(sCommandName, TObject(nCommandIndex));
end;

procedure TFrmFunctionConfig.ButtonUserCommandDelClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认删除此命令？', '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    try
      ListBoxUserCommand.DeleteSelected;
    except
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonUserCommandChgClick(Sender: TObject);
var
  sCommandName: string;
  nCommandIndex: Integer;
  I, nItemIndex: Integer;
begin
  sCommandName := Trim(EditCommandName.Text);
  nCommandIndex := SpinEditCommandIdx.Value;
  if sCommandName = '' then begin
    Application.MessageBox('请输入命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfName(sCommandName) then begin
    Application.MessageBox('你要修改的命令已经存在，请选择其他命令！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InCommandListOfIndex(nCommandIndex) then begin
    Application.MessageBox('你要修改的命令编号已经存在，请选择其他命令编号！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  nItemIndex := ListBoxUserCommand.ItemIndex;
  try
    ListBoxUserCommand.Items.Strings[nItemIndex] := sCommandName;
    ListBoxUserCommand.Items.Objects[nItemIndex] := TObject(nCommandIndex);
    Application.MessageBox('修改完成！！！', '提示信息', MB_ICONQUESTION);
  except
    Application.MessageBox('修改失败！！！', '提示信息', MB_ICONQUESTION);
  end;
end;

procedure TFrmFunctionConfig.ButtonUserCommandSaveClick(Sender: TObject);
var
  sFileName: string;
  I: Integer;
  sCommandName: string;
  nCommandIndex: Integer;
  SaveList: Classes.TStringList;
begin
  ButtonUserCommandSave.Enabled := False;
  sFileName := '.\UserCmd.txt';
  SaveList := Classes.TStringList.Create;
  SaveList.Add(';引擎插件配置文件');
  SaveList.Add(';命令名称'#9'对应编号');
  for I := 0 to ListBoxUserCommand.Items.Count - 1 do begin
    sCommandName := ListBoxUserCommand.Items.Strings[I];
    nCommandIndex := Integer(ListBoxUserCommand.Items.Objects[I]);
    SaveList.Add(sCommandName + #9 + IntToStr(nCommandIndex));
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonUserCommandSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.ButtonLoadUserCommandListClick(
  Sender: TObject);
begin
  ButtonLoadUserCommandList.Enabled := False;
  LoadUserCmdList();
  ListBoxUserCommand.Items.Clear;
  ListBoxUserCommand.Items.AddStrings(g_UserCmdList);
  Application.MessageBox('重新加载自定义命令列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadUserCommandList.Enabled := TRUE;
end;

function TFrmFunctionConfig.InListBoxitemList(sItemName: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  ListViewDisallow.Items.BeginUpdate;
  try
    for I := 0 to ListViewDisallow.Items.Count - 1 do begin
      ListItem := ListViewDisallow.Items.Item[I];
      if CompareText(sItemName, ListItem.Caption) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;
  finally
    ListViewDisallow.Items.EndUpdate;
  end;
end;

procedure TFrmFunctionConfig.ListBoxitemListDblClick(Sender: TObject);
var
  ListItem: TListItem;
  sItemName: string;
  I: Integer;
begin
  try
    sItemName := ListBoxitemList.Items.Strings[ListBoxitemList.ItemIndex];
  except
    sItemName := '';
  end;
  if (sItemName <> '') then begin
    if InListBoxitemList(sItemName) then begin
      Application.MessageBox('你要选择的物品已经在禁止物品列表中，请选择其他物品！！！', '提示信息', MB_ICONQUESTION);
      Exit;
    end;
    ListViewDisallow.Items.BeginUpdate;
    try
      ListItem := ListViewDisallow.Items.Add;
      ListItem.Caption := sItemName;
      ListItem.SubItems.Add('0');
      ListItem.SubItems.Add('0');
      ListItem.SubItems.Add('0');
      ListItem.SubItems.Add('0');
    finally
      ListViewDisallow.Items.EndUpdate;
    end;
  end;
end;

procedure TFrmFunctionConfig.ListViewDisallowClick(Sender: TObject);
var
  ListItem: TListItem;
  boCanDrop: Boolean;
  boCanDeal: Boolean;
  boCanStorage: Boolean;
  boCanRepair: Boolean;
begin
  try
    ListItem := ListViewDisallow.Items.Item[ListViewDisallow.ItemIndex];
    boCanDrop := Boolean(StrToInt(ListItem.SubItems.Strings[0]));
    boCanDeal := Boolean(StrToInt(ListItem.SubItems.Strings[1]));
    boCanStorage := Boolean(StrToInt(ListItem.SubItems.Strings[2]));
    boCanRepair := Boolean(StrToInt(ListItem.SubItems.Strings[3]));
    ButtonDisallowDrop.Enabled := TRUE;
    ButtonDisallowDeal.Enabled := TRUE;
    ButtonDisallowStorage.Enabled := TRUE;
    ButtonDisallowRepair.Enabled := TRUE;
    ButtonDisallowDel.Enabled := TRUE;
    if not boCanDrop then begin
      ButtonDisallowDrop.Caption := '禁止仍';
      ButtonDisallowDrop.ShowHint := False;
    end else begin
      ButtonDisallowDrop.Caption := '允许仍';
      ButtonDisallowDrop.ShowHint := TRUE;
    end;
    if not boCanDeal then begin
      ButtonDisallowDeal.Caption := '禁止交易';
      ButtonDisallowDeal.ShowHint := False;
    end else begin
      ButtonDisallowDeal.Caption := '允许交易';
      ButtonDisallowDeal.ShowHint := TRUE;
    end;
    if not boCanStorage then begin
      ButtonDisallowStorage.Caption := '禁止存';
      ButtonDisallowStorage.ShowHint := False;
    end else begin
      ButtonDisallowStorage.Caption := '允许存';
      ButtonDisallowStorage.ShowHint := TRUE;
    end;
    if not boCanRepair then begin
      ButtonDisallowRepair.Caption := '禁止修理';
      ButtonDisallowRepair.ShowHint := False;
    end else begin
      ButtonDisallowRepair.Caption := '允许修理';
      ButtonDisallowRepair.ShowHint := TRUE;
    end;
  except
    ButtonDisallowDrop.Enabled := False;
    ButtonDisallowDeal.Enabled := False;
    ButtonDisallowStorage.Enabled := False;
    ButtonDisallowRepair.Enabled := False;
    ButtonDisallowDel.Enabled := False;
  end;
end;

procedure TFrmFunctionConfig.ButtonDisallowDropClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  try
    ListItem := ListViewDisallow.Items.Item[ListViewDisallow.ItemIndex];
    if ButtonDisallowDrop.ShowHint then begin
      ListItem.SubItems.Strings[0] := '0';
      ButtonDisallowDrop.ShowHint := False;
      ButtonDisallowDrop.Caption := '禁止仍';
    end else begin
      ListItem.SubItems.Strings[0] := '1';
      ButtonDisallowDrop.ShowHint := TRUE;
      ButtonDisallowDrop.Caption := '允许仍';
    end;
  except
  end;
end;

procedure TFrmFunctionConfig.ButtonDisallowDealClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  try
    ListItem := ListViewDisallow.Items.Item[ListViewDisallow.ItemIndex];
    if ButtonDisallowDeal.ShowHint then begin
      ListItem.SubItems.Strings[1] := '0';
      ButtonDisallowDeal.ShowHint := False;
      ButtonDisallowDeal.Caption := '禁止交易';
    end else begin
      ListItem.SubItems.Strings[1] := '1';
      ButtonDisallowDeal.ShowHint := TRUE;
      ButtonDisallowDeal.Caption := '允许交易';
    end;
  except
  end;
end;

procedure TFrmFunctionConfig.ButtonDisallowStorageClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  try
    ListItem := ListViewDisallow.Items.Item[ListViewDisallow.ItemIndex];
    if ButtonDisallowStorage.ShowHint then begin
      ListItem.SubItems.Strings[2] := '0';
      ButtonDisallowStorage.ShowHint := False;
      ButtonDisallowStorage.Caption := '禁止存';
    end else begin
      ListItem.SubItems.Strings[2] := '1';
      ButtonDisallowStorage.ShowHint := TRUE;
      ButtonDisallowStorage.Caption := '允许存';
    end;
  except
  end;
end;

procedure TFrmFunctionConfig.ButtonDisallowRepairClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  try
    ListItem := ListViewDisallow.Items.Item[ListViewDisallow.ItemIndex];
    if ButtonDisallowRepair.ShowHint then begin
      ListItem.SubItems.Strings[3] := '0';
      ButtonDisallowRepair.ShowHint := False;
      ButtonDisallowRepair.Caption := '禁止修理';
    end else begin
      ListItem.SubItems.Strings[3] := '1';
      ButtonDisallowRepair.ShowHint := TRUE;
      ButtonDisallowRepair.Caption := '允许修理';
    end;
  except
  end;
end;

procedure TFrmFunctionConfig.ButtonDisallowDelClick(Sender: TObject);
begin
  try
    ListViewDisallow.DeleteSelected;
  except
  end;
end;

procedure TFrmFunctionConfig.RefLoadDisallowStdItems();
var
  I: Integer;
  ListItem: TListItem;
  CheckItem: pTCheckItem;
  sItemName: string;
  sCanDrop: string;
  sCanDeal: string;
  sCanStorage: string;
  sCanRepair: string;
begin
  ListViewDisallow.Items.Clear;
  for I := 0 to g_CheckItemList.Count - 1 do begin
    CheckItem := pTCheckItem(g_CheckItemList.Items[I]);
    sItemName := CheckItem.szItemName;
    sCanDrop := IntToStr(Integer(CheckItem.boCanDrop));
    sCanDeal := IntToStr(Integer(CheckItem.boCanDeal));
    sCanStorage := IntToStr(Integer(CheckItem.boCanStorage));
    sCanRepair := IntToStr(Integer(CheckItem.boCanRepair));
    ListViewDisallow.Items.BeginUpdate;
    try
      ListItem := ListViewDisallow.Items.Add;
      ListItem.Caption := sItemName;
      ListItem.SubItems.Add(sCanDrop);
      ListItem.SubItems.Add(sCanDeal);
      ListItem.SubItems.Add(sCanStorage);
      ListItem.SubItems.Add(sCanRepair);
    finally
      ListViewDisallow.Items.EndUpdate;
    end;
  end;
end;

procedure TFrmFunctionConfig.ButtonDisallowSaveClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: Classes.TStringList;
  sFileName: string;
  sLineText: string;
  sItemName: string;
  sCanDrop: string;
  sCanDeal: string;
  sCanStorage: string;
  sCanRepair: string;
begin
  ButtonDisallowSave.Enabled := False;
  sFileName := '.\CheckItemList.txt';
  SaveList := Classes.TStringList.Create;
  SaveList.Add(';引擎插件禁止物品配置文件');
  SaveList.Add(';物品名称'#9'扔'#9'交易'#9'存'#9'修');
  ListViewDisallow.Items.BeginUpdate;
  try
    for I := 0 to ListViewDisallow.Items.Count - 1 do begin
      ListItem := ListViewDisallow.Items.Item[I];
      sItemName := ListItem.Caption;
      sCanDrop := ListItem.SubItems.Strings[0];
      sCanDeal := ListItem.SubItems.Strings[1];
      sCanStorage := ListItem.SubItems.Strings[2];
      sCanRepair := ListItem.SubItems.Strings[3];
      sLineText := sItemName + #9 + sCanDrop + #9 + sCanDeal + #9 + sCanStorage + #9 + sCanRepair;
      SaveList.Add(sLineText);
    end;
  finally
    ListViewDisallow.Items.EndUpdate;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonDisallowSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.ButtonLoadCheckItemListClick(Sender: TObject);
begin
  ButtonLoadCheckItemList.Enabled := False;
  LoadCheckItemList();
  RefLoadDisallowStdItems();
  Application.MessageBox('重新加载禁止物品配置完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadCheckItemList.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.RefLoadMsgFilterList();
var
  I: Integer;
  ListItem: TListItem;
  FilterMsg: pTFilterMsg;
begin
  ListViewMsgFilter.Items.BeginUpdate;
  ListViewMsgFilter.Items.Clear;
  try
    for I := 0 to g_MsgFilterList.Count - 1 do begin
      ListItem := ListViewMsgFilter.Items.Add;
      FilterMsg := g_MsgFilterList.Items[I];
      ListItem.Caption := FilterMsg.sFilterMsg;
      ListItem.SubItems.Add(FilterMsg.sNewMsg);
    end;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TFrmFunctionConfig.ListViewMsgFilterClick(Sender: TObject);
var
  ListItem: TListItem;
  nItemIndex: Integer;
begin
  try
    nItemIndex := ListViewMsgFilter.ItemIndex;
    ListItem := ListViewMsgFilter.Items.Item[nItemIndex];
    EditFilterMsg.Text := ListItem.Caption;
    EditNewMsg.Text := ListItem.SubItems.Strings[0];
    ButtonMsgFilterDel.Enabled := TRUE;
    ButtonMsgFilterChg.Enabled := TRUE;
  except
    EditFilterMsg.Text := '';
    EditNewMsg.Text := '';
    ButtonMsgFilterDel.Enabled := False;
    ButtonMsgFilterChg.Enabled := False;
  end;
end;

procedure TFrmFunctionConfig.ButtonLoadMsgFilterListClick(Sender: TObject);
begin
  ButtonLoadMsgFilterList.Enabled := False;
  LoadMsgFilterList();
  RefLoadMsgFilterList();
  Application.MessageBox('重新加载消息过滤列表完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonLoadMsgFilterList.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterSaveClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: Classes.TStringList;
  sFilterMsg: string;
  sNewMsg: string;
  sFileName: string;
begin
  ButtonMsgFilterSave.Enabled := False;
  sFileName := '.\MsgFilterList.txt';
  SaveList := Classes.TStringList.Create;
  SaveList.Add(';引擎插件消息过滤配置文件');
  SaveList.Add(';过滤消息'#9'替换消息');
  ListViewMsgFilter.Items.BeginUpdate;
  try
    for I := 0 to ListViewMsgFilter.Items.Count - 1 do begin
      ListItem := ListViewMsgFilter.Items.Item[I];
      sFilterMsg := ListItem.Caption;
      sNewMsg := ListItem.SubItems.Strings[0];
      SaveList.Add(sFilterMsg + #9 + sNewMsg);
    end;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Application.MessageBox('保存完成！！！', '提示信息', MB_ICONQUESTION);
  ButtonMsgFilterSave.Enabled := TRUE;
end;

function TFrmFunctionConfig.InFilterMsgList(sFilterMsg: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  ListViewMsgFilter.Items.BeginUpdate;
  try
    for I := 0 to ListViewMsgFilter.Items.Count - 1 do begin
      ListItem := ListViewMsgFilter.Items.Item[I];
      if CompareText(sFilterMsg, ListItem.Caption) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterAddClick(Sender: TObject);
var
  sFilterMsg: string;
  sNewMsg: string;
  ListItem: TListItem;
begin
  sFilterMsg := Trim(EditFilterMsg.Text);
  sNewMsg := Trim(EditNewMsg.Text);
  if sFilterMsg = '' then begin
    Application.MessageBox('请输入过滤消息！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InFilterMsgList(sFilterMsg) then begin
    Application.MessageBox('你输入的过滤消息已经存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListViewMsgFilter.Items.BeginUpdate;
  try
    ListItem := ListViewMsgFilter.Items.Add;
    ListItem.Caption := sFilterMsg;
    ListItem.SubItems.Add(sNewMsg);
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterChgClick(Sender: TObject);
var
  sFilterMsg: string;
  sNewMsg: string;
  ListItem: TListItem;
begin
  sFilterMsg := Trim(EditFilterMsg.Text);
  sNewMsg := Trim(EditNewMsg.Text);
  if sFilterMsg = '' then begin
    Application.MessageBox('请输入过滤消息！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if InFilterMsgList(sFilterMsg) then begin
    Application.MessageBox('你输入的过滤消息已经存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  ListViewMsgFilter.Items.BeginUpdate;
  try
    ListItem := ListViewMsgFilter.Items.Item[ListViewMsgFilter.ItemIndex];
    ListItem.Caption := sFilterMsg;
    ListItem.SubItems.Strings[0] := sNewMsg;
  finally
    ListViewMsgFilter.Items.EndUpdate;
  end;
end;

procedure TFrmFunctionConfig.ButtonMsgFilterDelClick(Sender: TObject);
begin
  try
    ListViewMsgFilter.DeleteSelected;
  except
  end;
end;

procedure TFrmFunctionConfig.CheckBoxAttack1Click(Sender: TObject);
begin
  if not boOpened then Exit;
  boCCAttack := CheckBoxAttack1.Checked;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.CheckBoxAttack2Click(Sender: TObject);
begin
  if not boOpened then Exit;
  boDataAttack := CheckBoxAttack2.Checked;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.CheckBoxAttack3Click(Sender: TObject);
begin
  if not boOpened then Exit;
  boKeepConnectTimeOut := CheckBoxAttack3.Checked;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditAttack1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  dwAttackTick := SpinEditAttack1.Value;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditAttack2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  nReviceMsgLength := SpinEditAttack2.Value;
  ButtonAttackSave.Enabled := TRUE;
end;

procedure TFrmFunctionConfig.SpinEditAttack3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  dwKeepConnectTimeOut := SpinEditAttack3.Value;
  ButtonAttackSave.Enabled := TRUE;
end;
procedure TFrmFunctionConfig.RefLoadAttackInfo();
begin
  CheckBoxAttack1.Checked := boCCAttack;
  CheckBoxAttack2.Checked := boDataAttack;
  CheckBoxAttack3.Checked := boKeepConnectTimeOut;
  SpinEditAttack1.Value := dwAttackTick;
  SpinEditAttack2.Value := nReviceMsgLength;
  SpinEditAttack3.Value := dwKeepConnectTimeOut;
  CheckBoxStart.Checked := boStartAttack;
  if CheckBoxStart.Checked then begin
    CheckBoxAttack1.Enabled := TRUE;
    CheckBoxAttack2.Enabled := TRUE;
    CheckBoxAttack3.Enabled := TRUE;
    SpinEditAttack1.Enabled := TRUE;
    SpinEditAttack2.Enabled := TRUE;
    SpinEditAttack3.Enabled := TRUE;
  end else begin
    CheckBoxAttack1.Enabled := False;
    CheckBoxAttack2.Enabled := False;
    CheckBoxAttack3.Enabled := False;
    SpinEditAttack1.Enabled := False;
    SpinEditAttack2.Enabled := False;
    SpinEditAttack3.Enabled := False;
  end;
end;

procedure TFrmFunctionConfig.ButtonAttackSaveClick(Sender: TObject);
var
  Config: TIniFile;
  sFileName: string;
begin
  ButtonAttackSave.Enabled := False;
  sFileName := '.\zPlugOfEngine.ini';
  Config := TIniFile.Create(sFileName);
  if Config <> nil then begin
    Config.WriteBool(PlugClass, 'CCAttack', boCCAttack);
    Config.WriteBool(PlugClass, 'DataAttack', boDataAttack);
    Config.WriteBool(PlugClass, 'KeepConnect', boKeepConnectTimeOut);
    Config.WriteBool(PlugClass, 'StartAttack', boStartAttack);
    Config.WriteInteger(PlugClass, 'CCAttackTime', dwAttackTick);
    Config.WriteInteger(PlugClass, 'ReviceMsgLength', nReviceMsgLength);
    Config.WriteInteger(PlugClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);
    Config.Free;
  end;
end;

procedure TFrmFunctionConfig.CheckBoxStartClick(Sender: TObject);
begin
  if not boOpened then Exit;
  ButtonAttackSave.Enabled := TRUE;
  CheckBoxStart.Enabled := False;
  if CheckBoxStart.Checked then begin
    InitAttack();
    boStartAttack := TRUE;
    CheckBoxAttack1.Enabled := TRUE;
    CheckBoxAttack2.Enabled := TRUE;
    CheckBoxAttack3.Enabled := TRUE;
    SpinEditAttack1.Enabled := TRUE;
    SpinEditAttack2.Enabled := TRUE;
    SpinEditAttack3.Enabled := TRUE;
  end else begin
    boStartAttack := False;
    CheckBoxAttack1.Enabled := False;
    CheckBoxAttack2.Enabled := False;
    CheckBoxAttack3.Enabled := False;
    SpinEditAttack1.Enabled := False;
    SpinEditAttack2.Enabled := False;
    SpinEditAttack3.Enabled := False;
    UnInitAttack();
  end;
  CheckBoxStart.Enabled := TRUE;
end;

end.

