object FrmUserInfoEdit: TFrmUserInfoEdit
  Left = 378
  Top = 153
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #32534#36753#24080#21495#20449#24687
  ClientHeight = 414
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 40
    Top = 16
    Width = 30
    Height = 12
    Alignment = taRightJustify
    Caption = #24080#21495':'
  end
  object Label2: TLabel
    Left = 40
    Top = 40
    Width = 30
    Height = 12
    Alignment = taRightJustify
    Caption = #23494#30721':'
  end
  object Label3: TLabel
    Left = 16
    Top = 64
    Width = 54
    Height = 12
    Alignment = taRightJustify
    Caption = #29992#25143#21517#31216':'
  end
  object Label4: TLabel
    Left = 40
    Top = 112
    Width = 30
    Height = 12
    Alignment = taRightJustify
    Caption = #29983#26085':'
  end
  object Label5: TLabel
    Left = 40
    Top = 232
    Width = 30
    Height = 12
    Alignment = taRightJustify
    Caption = #30005#35805':'
  end
  object Label9: TLabel
    Left = 16
    Top = 88
    Width = 54
    Height = 12
    Alignment = taRightJustify
    Caption = #36523#20221#35777#21495':'
  end
  object Label6: TLabel
    Left = 28
    Top = 136
    Width = 42
    Height = 12
    Alignment = taRightJustify
    Caption = #38382#39064#19968':'
  end
  object Label7: TLabel
    Left = 28
    Top = 160
    Width = 42
    Height = 12
    Alignment = taRightJustify
    Caption = #31572#26696#19968':'
  end
  object Label10: TLabel
    Left = 28
    Top = 184
    Width = 42
    Height = 12
    Alignment = taRightJustify
    Caption = #38382#39064#20108':'
  end
  object Label11: TLabel
    Left = 28
    Top = 208
    Width = 42
    Height = 12
    Alignment = taRightJustify
    Caption = #31572#26696#20108':'
  end
  object Label12: TLabel
    Left = 16
    Top = 256
    Width = 54
    Height = 12
    Alignment = taRightJustify
    Caption = #31227#21160#30005#35805':'
  end
  object Label13: TLabel
    Left = 28
    Top = 280
    Width = 42
    Height = 12
    Alignment = taRightJustify
    Caption = #22791#27880#19968':'
  end
  object Label14: TLabel
    Left = 28
    Top = 304
    Width = 42
    Height = 12
    Alignment = taRightJustify
    Caption = #22791#27880#20108':'
  end
  object Label8: TLabel
    Left = 16
    Top = 328
    Width = 54
    Height = 12
    Alignment = taRightJustify
    Caption = #30005#23376#37038#31665':'
  end
  object EdId: TEdit
    Left = 80
    Top = 16
    Width = 121
    Height = 20
    Enabled = False
    MaxLength = 10
    TabOrder = 0
  end
  object EdPasswd: TEdit
    Left = 80
    Top = 40
    Width = 121
    Height = 20
    MaxLength = 10
    TabOrder = 1
  end
  object EdUserName: TEdit
    Left = 80
    Top = 64
    Width = 121
    Height = 20
    MaxLength = 20
    TabOrder = 2
  end
  object EdBirthDay: TEdit
    Left = 80
    Top = 112
    Width = 121
    Height = 20
    MaxLength = 10
    TabOrder = 4
  end
  object EdPhone: TEdit
    Left = 80
    Top = 232
    Width = 121
    Height = 20
    MaxLength = 14
    TabOrder = 9
  end
  object Button1: TButton
    Left = 72
    Top = 376
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    ModalResult = 1
    TabOrder = 14
  end
  object Button2: TButton
    Left = 208
    Top = 376
    Width = 75
    Height = 25
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 15
  end
  object CkFullEdit: TCheckBox
    Left = 216
    Top = 16
    Width = 73
    Height = 17
    Caption = #21482#35835
    TabOrder = 16
    OnClick = CkFullEditClick
  end
  object EdSSNo: TEdit
    Left = 80
    Top = 88
    Width = 121
    Height = 20
    MaxLength = 14
    TabOrder = 3
  end
  object EdQuiz: TEdit
    Left = 80
    Top = 136
    Width = 209
    Height = 20
    MaxLength = 20
    TabOrder = 5
  end
  object EdAnswer: TEdit
    Left = 80
    Top = 160
    Width = 209
    Height = 20
    MaxLength = 12
    TabOrder = 6
  end
  object EdQuiz2: TEdit
    Left = 80
    Top = 184
    Width = 209
    Height = 20
    MaxLength = 20
    TabOrder = 7
  end
  object EdAnswer2: TEdit
    Left = 80
    Top = 208
    Width = 209
    Height = 20
    MaxLength = 12
    TabOrder = 8
  end
  object EdMobilePhone: TEdit
    Left = 80
    Top = 256
    Width = 121
    Height = 20
    MaxLength = 13
    TabOrder = 10
  end
  object EdMemo1: TEdit
    Left = 80
    Top = 280
    Width = 185
    Height = 20
    MaxLength = 20
    TabOrder = 11
  end
  object EdMemo2: TEdit
    Left = 80
    Top = 304
    Width = 185
    Height = 20
    MaxLength = 20
    TabOrder = 12
  end
  object EdEMail: TEdit
    Left = 80
    Top = 328
    Width = 209
    Height = 20
    MaxLength = 40
    TabOrder = 13
  end
end
