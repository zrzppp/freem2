object FrmFDBExplore: TFrmFDBExplore
  Left = 289
  Top = 149
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'DB Explorer'
  ClientHeight = 246
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 20
    Top = 190
    Width = 84
    Height = 15
    Caption = 'Find Character:'
  end
  object ListBox1: TListBox
    Left = 20
    Top = 10
    Width = 111
    Height = 171
    ImeName = '???(??) (MS-IME95)'
    ItemHeight = 15
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object EdFind: TEdit
    Left = 20
    Top = 210
    Width = 151
    Height = 23
    Hint = '???????????(Enter)????'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnKeyPress = EdFindKeyPress
  end
  object BtnAdd: TButton
    Left = 330
    Top = 10
    Width = 111
    Height = 31
    Hint = '??????????'
    Caption = 'Add'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnAddClick
  end
  object BtnDel: TButton
    Left = 330
    Top = 48
    Width = 111
    Height = 31
    Hint = '???????????'
    Caption = 'Delete'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BtnDelClick
  end
  object ListBox2: TListBox
    Left = 140
    Top = 10
    Width = 171
    Height = 171
    ImeName = '???(??) (MS-IME95)'
    ItemHeight = 15
    TabOrder = 4
  end
  object BtnRebuild: TButton
    Left = 330
    Top = 160
    Width = 111
    Height = 31
    Caption = 'Rebuild'
    TabOrder = 5
    OnClick = BtnRebuildClick
  end
  object BtnBlankCount: TButton
    Left = 180
    Top = 210
    Width = 131
    Height = 26
    Caption = '&Clear'
    TabOrder = 6
    OnClick = BtnBlankCountClick
  end
  object GroupBox1: TGroupBox
    Left = 470
    Top = 9
    Width = 147
    Height = 142
    Caption = 'Clean Options'
    TabOrder = 7
    object BtnAutoClean: TButton
      Left = 10
      Top = 88
      Width = 121
      Height = 33
      Caption = 'Cleaning On'
      TabOrder = 0
      OnClick = BtnAutoCleanClick
    end
    object CkLv1: TCheckBox
      Left = 10
      Top = 15
      Width = 119
      Height = 31
      Caption = 'Level 1 (1 Week)'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CkLv7: TCheckBox
      Left = 10
      Top = 40
      Width = 119
      Height = 21
      Caption = 'Level 7 (1 Week)'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CkLv14: TCheckBox
      Left = 10
      Top = 60
      Width = 135
      Height = 21
      Caption = 'Level 14 (4 Weeks)'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object BtnCopyRcd: TButton
    Left = 330
    Top = 85
    Width = 111
    Height = 31
    Hint = '????????????????????'
    Caption = 'Copy'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = BtnCopyRcdClick
  end
  object BtnCopyNew: TButton
    Left = 330
    Top = 123
    Width = 111
    Height = 31
    Hint = '????????,???????????????'
    Caption = 'New'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = BtnCopyNewClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 352
    Top = 200
  end
end
