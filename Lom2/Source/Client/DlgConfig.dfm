object frmDlgConfig: TfrmDlgConfig
  Left = 324
  Top = 196
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'WIL'#37197#32622#22120
  ClientHeight = 208
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 12
    Caption = 'WIL'#21015#34920':'
  end
  object DlgList: TListBox
    Left = 8
    Top = 24
    Width = 153
    Height = 177
    ItemHeight = 12
    TabOrder = 0
    OnClick = DlgListClick
  end
  object GameWindowName: TGroupBox
    Left = 168
    Top = 16
    Width = 129
    Height = 177
    Caption = #37197#32622
    Enabled = False
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 18
      Width = 30
      Height = 12
      Caption = #39030#37096':'
    end
    object Label3: TLabel
      Left = 8
      Top = 42
      Width = 30
      Height = 12
      Caption = #24038#38754':'
    end
    object Label4: TLabel
      Left = 8
      Top = 66
      Width = 30
      Height = 12
      Caption = #23485#24230':'
    end
    object Label5: TLabel
      Left = 8
      Top = 90
      Width = 30
      Height = 12
      Caption = #39640#24230':'
    end
    object Label6: TLabel
      Left = 8
      Top = 114
      Width = 42
      Height = 12
      Caption = #22270#35937#20540':'
    end
    object EditTop: TSpinEdit
      Left = 56
      Top = 16
      Width = 65
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = EditTopChange
    end
    object EditLeft: TSpinEdit
      Left = 56
      Top = 40
      Width = 65
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EditLeftChange
    end
    object EditHeight: TSpinEdit
      Left = 56
      Top = 88
      Width = 65
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = EditHeightChange
    end
    object EditWidth: TSpinEdit
      Left = 56
      Top = 64
      Width = 65
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
      OnChange = EditWidthChange
    end
    object EditImage: TSpinEdit
      Left = 56
      Top = 112
      Width = 65
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 0
      OnChange = EditImageChange
    end
    object ButtonShow: TButton
      Left = 24
      Top = 144
      Width = 81
      Height = 25
      Caption = #27979#35797#26174#31034
      TabOrder = 5
      OnClick = ButtonShowClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 304
    Top = 16
    Width = 129
    Height = 73
    Caption = #25991#23383
    TabOrder = 2
    object Label7: TLabel
      Left = 8
      Top = 18
      Width = 12
      Height = 12
      Caption = 'X:'
    end
    object Label8: TLabel
      Left = 8
      Top = 42
      Width = 12
      Height = 12
      Caption = 'Y:'
    end
    object EditTestX: TSpinEdit
      Left = 48
      Top = 16
      Width = 65
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = EditTestXChange
    end
    object EditTestY: TSpinEdit
      Left = 48
      Top = 40
      Width = 65
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EditTestYChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 304
    Top = 96
    Width = 129
    Height = 73
    Caption = #36895#24230
    TabOrder = 3
    object Label9: TLabel
      Left = 8
      Top = 18
      Width = 30
      Height = 12
      Caption = #25216#33021':'
    end
    object Label10: TLabel
      Left = 8
      Top = 42
      Width = 30
      Height = 12
      Caption = #25915#20987':'
    end
    object EditSpellTime: TSpinEdit
      Left = 48
      Top = 16
      Width = 65
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = EditSpellTimeChange
    end
    object EditHitTime: TSpinEdit
      Left = 48
      Top = 40
      Width = 65
      Height = 21
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = EditHitTimeChange
    end
  end
  object GroupBox3: TGroupBox
    Left = 440
    Top = 144
    Width = 185
    Height = 57
    Caption = #26174#31034
    TabOrder = 4
    object CheckBoxDrawTileMap: TCheckBox
      Left = 8
      Top = 16
      Width = 121
      Height = 17
      Caption = #26174#31034#22320#22270#26631#39064
      TabOrder = 0
      OnClick = CheckBoxDrawTileMapClick
    end
    object CheckBoxDrawDropItem: TCheckBox
      Left = 8
      Top = 32
      Width = 153
      Height = 17
      Caption = #26174#31034#22320#38754#29289#21697#21517#23383
      TabOrder = 1
      OnClick = CheckBoxDrawDropItemClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 440
    Top = 16
    Width = 185
    Height = 121
    Caption = #36755#20837
    TabOrder = 5
    object Label11: TLabel
      Left = 8
      Top = 20
      Width = 30
      Height = 12
      Caption = #23494#38053':'
    end
    object Label12: TLabel
      Left = 8
      Top = 44
      Width = 54
      Height = 12
      Caption = #26381#21153#22120#21517':'
    end
    object Label13: TLabel
      Left = 8
      Top = 68
      Width = 54
      Height = 12
      Caption = #26381#21153#22120'IP:'
    end
    object Label14: TLabel
      Left = 8
      Top = 92
      Width = 54
      Height = 12
      Caption = #36830#25509#31471#21475':'
    end
    object EditKey: TEdit
      Left = 64
      Top = 16
      Width = 105
      Height = 20
      TabOrder = 0
    end
    object EditServerName: TEdit
      Left = 64
      Top = 40
      Width = 105
      Height = 20
      TabOrder = 1
    end
    object EditRegIPaddr: TEdit
      Left = 64
      Top = 64
      Width = 105
      Height = 20
      TabOrder = 2
    end
    object EditRegPort: TEdit
      Left = 64
      Top = 88
      Width = 105
      Height = 20
      TabOrder = 3
    end
  end
end
