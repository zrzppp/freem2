object FrmAccountForm: TFrmAccountForm
  Left = 355
  Top = 214
  Width = 518
  Height = 322
  Caption = 'Account Addition (F1: Save,  ESC: Cancel)'
  Color = clBtnFace
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '??'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    Left = 77
    Top = 18
    Width = 55
    Height = 18
    Caption = 'Login / IP'
  end
  object Label2: TLabel
    Left = 9
    Top = 50
    Width = 120
    Height = 18
    Caption = 'Nickname/Realname'
  end
  object Label3: TLabel
    Left = 62
    Top = 117
    Width = 69
    Height = 18
    Caption = 'Fee Method'
  end
  object Label4: TLabel
    Left = 87
    Top = 151
    Width = 41
    Height = 18
    Caption = 'Uptime'
  end
  object Label5: TLabel
    Left = 217
    Top = 151
    Width = 34
    Height = 18
    Caption = 'Years'
  end
  object Label6: TLabel
    Left = 302
    Top = 151
    Width = 43
    Height = 18
    Caption = 'Months'
  end
  object Label7: TLabel
    Left = 394
    Top = 151
    Width = 28
    Height = 18
    Caption = 'days'
  end
  object Label8: TLabel
    Left = 79
    Top = 183
    Width = 47
    Height = 18
    Caption = 'RegQua'
  end
  object Label9: TLabel
    Left = 255
    Top = 183
    Width = 35
    Height = 18
    Caption = 'OnMn'
  end
  object Label10: TLabel
    Left = 94
    Top = 217
    Width = 36
    Height = 18
    Caption = 'Memo'
  end
  object Label11: TLabel
    Left = 70
    Top = 84
    Width = 58
    Height = 18
    Caption = 'About*pc*'
  end
  object Label12: TLabel
    Left = 338
    Top = 117
    Width = 92
    Height = 18
    Caption = 'Duplicate Count'
  end
  object EdID: TEdit
    Tag = 1
    Left = 151
    Top = 12
    Width = 167
    Height = 26
    AutoSelect = False
    Enabled = False
    ImeName = '???(??) (MS-IME95)'
    MaxLength = 15
    TabOrder = 0
  end
  object EdChrName: TEdit
    Tag = 2
    Left = 151
    Top = 45
    Width = 300
    Height = 26
    Enabled = False
    ImeName = '???(??) (MS-IME95)'
    MaxLength = 20
    TabOrder = 1
  end
  object CbFeeMode: TComboBox
    Tag = 4
    Left = 151
    Top = 111
    Width = 167
    Height = 26
    Style = csDropDownList
    ImeName = '???(??) (MS-IME95)'
    ItemHeight = 18
    TabOrder = 3
    Items.Strings = (
      'NoCh'
      '???'
      'Quanta')
  end
  object EdYear: TEdit
    Tag = 6
    Left = 151
    Top = 145
    Width = 61
    Height = 26
    ImeName = '???(??) (MS-IME95)'
    MaxLength = 4
    TabOrder = 5
  end
  object EdMon: TEdit
    Tag = 7
    Left = 262
    Top = 145
    Width = 35
    Height = 26
    ImeName = '???(??) (MS-IME95)'
    MaxLength = 2
    TabOrder = 6
  end
  object EdDay: TEdit
    Tag = 8
    Left = 356
    Top = 145
    Width = 34
    Height = 26
    ImeName = '???(??) (MS-IME95)'
    MaxLength = 2
    TabOrder = 7
  end
  object EdCount: TEdit
    Tag = 9
    Left = 151
    Top = 178
    Width = 95
    Height = 26
    ImeName = '???(??) (MS-IME95)'
    MaxLength = 6
    TabOrder = 8
  end
  object EdMemo: TEdit
    Tag = 10
    Left = 151
    Top = 211
    Width = 349
    Height = 26
    ImeName = '???(??) (MS-IME95)'
    MaxLength = 20
    TabOrder = 9
  end
  object Button1: TButton
    Left = 181
    Top = 246
    Width = 118
    Height = 35
    Caption = 'Save (F1)'
    ModalResult = 1
    TabOrder = 10
  end
  object Button2: TButton
    Left = 347
    Top = 246
    Width = 117
    Height = 35
    Caption = 'Cancel (ESC)'
    ModalResult = 2
    TabOrder = 11
  end
  object EdOwner: TEdit
    Tag = 3
    Left = 151
    Top = 79
    Width = 105
    Height = 26
    ImeName = '???(??) (MS-IME95)'
    MaxLength = 10
    TabOrder = 2
  end
  object EdDupCount: TEdit
    Tag = 5
    Left = 440
    Top = 111
    Width = 52
    Height = 26
    ImeName = '???(??) (MS-IME95)'
    TabOrder = 4
  end
end
