object frmConfigMonGen: TfrmConfigMonGen
  Left = 124
  Top = 173
  Width = 893
  Height = 602
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #21047#24618#35774#32622
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 241
    Height = 513
    Caption = #24618#29289#21047#26032#21015#34920
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object ListBoxMonGen: TListBox
      Left = 12
      Top = 19
      Width = 217
      Height = 482
      Hint = 'List of Spawned mobs and locations'
      ItemHeight = 12
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 268
    Top = 9
    Width = 606
    Height = 554
    Caption = #29190#29575#25991#20214#31649#29702
    TabOrder = 1
    object ListBox1: TListBox
      Left = 11
      Top = 17
      Width = 125
      Height = 497
      ItemHeight = 12
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object Edit1: TEdit
      Left = 11
      Top = 523
      Width = 125
      Height = 20
      TabOrder = 1
      Text = #36755#20837#35201#26597#23547#30340#24618#29289#21517
    end
    object Button1: TButton
      Left = 147
      Top = 521
      Width = 75
      Height = 25
      Caption = #26597#25214
      TabOrder = 2
    end
    object Button3: TButton
      Left = 517
      Top = 521
      Width = 75
      Height = 25
      Caption = #20445#23384'(&S)'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Memo1: TMemo
      Left = 148
      Top = 16
      Width = 449
      Height = 497
      Hint = #20462#25913#24618#29289#29190#29575'.'
      ScrollBars = ssBoth
      TabOrder = 4
    end
    object Button4: TButton
      Left = 252
      Top = 520
      Width = 75
      Height = 25
      Caption = #21152#36733'(&S)'
      TabOrder = 5
      Visible = False
      OnClick = Button4Click
    end
  end
  object Button2: TButton
    Left = 179
    Top = 534
    Width = 75
    Height = 25
    Caption = #37325#35835#29190#29575
    TabOrder = 2
    OnClick = Button2Click
  end
end
