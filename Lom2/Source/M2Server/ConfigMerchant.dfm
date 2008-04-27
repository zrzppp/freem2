object frmConfigMerchant: TfrmConfigMerchant
  Left = 179
  Top = 167
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21830#20154'NPC'#31649#29702
  ClientHeight = 440
  ClientWidth = 816
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 48
    Height = 12
    Caption = 'NPC'#21015#34920':'
  end
  object ListBoxMerChant: TListBox
    Left = 10
    Top = 30
    Width = 383
    Height = 211
    Hint = 'List of NPC files'
    ItemHeight = 12
    TabOrder = 0
    OnClick = ListBoxMerChantClick
  end
  object GroupBoxNPC: TGroupBox
    Left = 10
    Top = 250
    Width = 383
    Height = 143
    Caption = #30456#20851#35774#32622
    Enabled = False
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 25
      Width = 54
      Height = 12
      Caption = #33050#26412#21517#31216':'
    end
    object Label3: TLabel
      Left = 196
      Top = 25
      Width = 54
      Height = 12
      Caption = #22320#22270#21517#31216':'
    end
    object Label4: TLabel
      Left = 8
      Top = 55
      Width = 36
      Height = 12
      Caption = #22352#26631'X:'
    end
    object Label5: TLabel
      Left = 118
      Top = 55
      Width = 12
      Height = 12
      Caption = 'Y:'
    end
    object Label6: TLabel
      Left = 8
      Top = 85
      Width = 54
      Height = 12
      Caption = #26174#31034#21517#31216':'
    end
    object Label7: TLabel
      Left = 196
      Top = 85
      Width = 30
      Height = 12
      Caption = #26041#21521':'
      WordWrap = True
    end
    object Label8: TLabel
      Left = 284
      Top = 85
      Width = 30
      Height = 12
      Caption = #22806#24418':'
    end
    object Label10: TLabel
      Left = 196
      Top = 55
      Width = 54
      Height = 12
      Caption = #22320#22270#25551#36848':'
    end
    object Label11: TLabel
      Left = 216
      Top = 115
      Width = 78
      Height = 12
      Caption = #31227#21160#38388#38548'('#20998'):'
      WordWrap = True
    end
    object EditScriptName: TEdit
      Left = 64
      Top = 20
      Width = 121
      Height = 20
      Hint = 'Filename that contains the NPC script'
      TabOrder = 0
      OnChange = EditScriptNameChange
    end
    object EditMapName: TEdit
      Left = 258
      Top = 20
      Width = 111
      Height = 20
      Hint = 'Map NPC can be found on'
      TabOrder = 1
      OnChange = EditMapNameChange
    end
    object EditShowName: TEdit
      Left = 64
      Top = 80
      Width = 121
      Height = 20
      Hint = 'Name of NPC ingame'
      TabOrder = 2
      OnChange = EditShowNameChange
    end
    object CheckBoxOfCastle: TCheckBox
      Left = 24
      Top = 110
      Width = 81
      Height = 21
      Hint = 'A % of sales price goes to castle'
      Caption = #23646#20110#22478#22561
      TabOrder = 3
      OnClick = CheckBoxOfCastleClick
    end
    object ComboBoxDir: TComboBox
      Left = 228
      Top = 80
      Width = 45
      Height = 20
      Hint = 
        'Direction the NPC faces (1 being up and counting in a clockwise ' +
        'direction)'
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 4
      OnChange = ComboBoxDirChange
    end
    object EditImageIdx: TSpinEdit
      Left = 324
      Top = 79
      Width = 45
      Height = 21
      Hint = 'Skin no in NPC.wil'
      EditorEnabled = False
      MaxValue = 65535
      MinValue = 0
      TabOrder = 5
      Value = 0
      OnChange = EditImageIdxChange
    end
    object EditX: TSpinEdit
      Left = 64
      Top = 49
      Width = 45
      Height = 21
      Hint = 'X Co-Ordinate of NPC'
      EditorEnabled = False
      MaxValue = 1000
      MinValue = 1
      TabOrder = 6
      Value = 1
      OnChange = EditXChange
    end
    object EditY: TSpinEdit
      Left = 136
      Top = 49
      Width = 47
      Height = 21
      Hint = 'Y Co-Ordinate of NPC'
      EditorEnabled = False
      MaxValue = 1000
      MinValue = 1
      TabOrder = 7
      Value = 1
      OnChange = EditYChange
    end
    object EditMapDesc: TEdit
      Left = 258
      Top = 50
      Width = 111
      Height = 20
      Enabled = False
      ReadOnly = True
      TabOrder = 8
    end
    object CheckBoxAutoMove: TCheckBox
      Left = 124
      Top = 110
      Width = 77
      Height = 21
      Hint = 'NPC can randomly teleport'
      Caption = #33258#21160#31227#21160
      TabOrder = 9
      OnClick = CheckBoxAutoMoveClick
    end
    object EditMoveTime: TSpinEdit
      Left = 310
      Top = 109
      Width = 51
      Height = 21
      Hint = 'Time between the random teleports'
      EditorEnabled = False
      MaxValue = 65535
      MinValue = 0
      TabOrder = 10
      Value = 0
      OnChange = EditMoveTimeChange
    end
  end
  object GroupBoxScript: TGroupBox
    Left = 408
    Top = 10
    Width = 401
    Height = 419
    Caption = #33050#26412#25991#20214#32534#36753
    Enabled = False
    TabOrder = 2
    object MemoScript: TMemo
      Left = 10
      Top = 160
      Width = 383
      Height = 249
      Hint = 'Selected NPC script'
      ScrollBars = ssBoth
      TabOrder = 0
      OnChange = MemoScriptChange
    end
    object ButtonScriptSave: TButton
      Left = 316
      Top = 38
      Width = 71
      Height = 31
      Hint = 'Save NPC script file'
      Caption = #20445#23384'(&S)'
      TabOrder = 1
      OnClick = ButtonScriptSaveClick
    end
    object GroupBox3: TGroupBox
      Left = 10
      Top = 20
      Width = 247
      Height = 133
      Caption = #33050#26412#21442#25968
      TabOrder = 2
      object Label9: TLabel
        Left = 10
        Top = 102
        Width = 54
        Height = 12
        Caption = #20215#26684#27604#29575':'
      end
      object CheckBoxBuy: TCheckBox
        Left = 10
        Top = 20
        Width = 41
        Height = 21
        Caption = #20080
        TabOrder = 0
        OnClick = CheckBoxBuyClick
      end
      object CheckBoxSell: TCheckBox
        Left = 10
        Top = 40
        Width = 41
        Height = 21
        Caption = #21334
        TabOrder = 1
        OnClick = CheckBoxSellClick
      end
      object CheckBoxStorage: TCheckBox
        Left = 66
        Top = 20
        Width = 63
        Height = 21
        Caption = #20179#24211
        TabOrder = 2
        OnClick = CheckBoxStorageClick
      end
      object CheckBoxGetback: TCheckBox
        Left = 10
        Top = 64
        Width = 67
        Height = 21
        Caption = #21462#20179#24211
        TabOrder = 3
        Visible = False
        OnClick = CheckBoxGetbackClick
      end
      object CheckBoxMakedrug: TCheckBox
        Left = 166
        Top = 60
        Width = 71
        Height = 21
        Caption = #21512#25104#29289#21697
        TabOrder = 4
        OnClick = CheckBoxMakedrugClick
      end
      object CheckBoxUpgradenow: TCheckBox
        Left = 166
        Top = 20
        Width = 70
        Height = 21
        Caption = #21319#32423#27494#22120
        TabOrder = 5
        OnClick = CheckBoxUpgradenowClick
      end
      object CheckBoxGetbackupgnow: TCheckBox
        Left = 166
        Top = 40
        Width = 70
        Height = 21
        Caption = #21462#22238#21319#32423
        TabOrder = 6
        OnClick = CheckBoxGetbackupgnowClick
      end
      object CheckBoxRepair: TCheckBox
        Left = 166
        Top = 84
        Width = 75
        Height = 21
        Caption = #20462#29702#29289#21697
        TabOrder = 7
        OnClick = CheckBoxRepairClick
      end
      object CheckBoxS_repair: TCheckBox
        Left = 166
        Top = 104
        Width = 70
        Height = 21
        Caption = #29305#27530#20462#29702
        TabOrder = 8
        OnClick = CheckBoxS_repairClick
      end
      object EditPriceRate: TSpinEdit
        Left = 80
        Top = 97
        Width = 61
        Height = 21
        Hint = 'NPC price rate, 80=80%'
        EditorEnabled = False
        MaxValue = 500
        MinValue = 60
        TabOrder = 9
        Value = 60
        OnChange = EditPriceRateChange
      end
      object CheckBoxSendMsg: TCheckBox
        Left = 66
        Top = 40
        Width = 63
        Height = 21
        Caption = #31069#31119#35821
        TabOrder = 10
        OnClick = CheckBoxSendMsgClick
      end
    end
    object ButtonReLoadNpc: TButton
      Left = 316
      Top = 78
      Width = 71
      Height = 31
      Hint = 'Reload NPC Script'
      HelpType = htKeyword
      Caption = #21152#36733'(&L)'
      Enabled = False
      TabOrder = 3
      OnClick = ButtonReLoadNpcClick
    end
  end
  object ButtonSave: TButton
    Left = 10
    Top = 402
    Width = 71
    Height = 31
    Hint = 'Save NPC changes'
    Caption = #20445#23384'(&S)'
    TabOrder = 3
    OnClick = ButtonSaveClick
  end
  object CheckBoxDenyRefStatus: TCheckBox
    Left = 306
    Top = 398
    Width = 71
    Height = 21
    Hint = 'THIS IS AN UNKNOWN COMMAND(SO FAR)'
    Caption = #21047#26032#29366#24577
    TabOrder = 4
    OnClick = CheckBoxDenyRefStatusClick
  end
  object ButtonClearTempData: TButton
    Left = 186
    Top = 402
    Width = 103
    Height = 31
    Hint = 'Clear any changes made'
    Caption = #28165#38500#20020#26102#25968#25454'(&C)'
    TabOrder = 5
    OnClick = ButtonClearTempDataClick
  end
  object ButtonViewData: TButton
    Left = 90
    Top = 402
    Width = 87
    Height = 31
    Hint = 'View the NPC'#39's data'
    Caption = #26174#31034#25968#25454'(&V)'
    TabOrder = 6
    Visible = False
    OnClick = ButtonClearTempDataClick
  end
end
