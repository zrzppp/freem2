object FrmCreateId: TFrmCreateId
  Left = 448
  Top = 199
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Create ID'
  ClientHeight = 114
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 29
    Top = 17
    Width = 15
    Height = 15
    Caption = 'ID:'
  end
  object Label2: TLabel
    Left = 29
    Top = 46
    Width = 59
    Height = 15
    Caption = 'Password:'
  end
  object EdId: TEdit
    Left = 96
    Top = 12
    Width = 165
    Height = 23
    ImeName = '???(??) (MS-IME95)'
    TabOrder = 0
  end
  object EdPasswd: TEdit
    Left = 96
    Top = 40
    Width = 165
    Height = 23
    ImeName = '???(??) (MS-IME95)'
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 24
    Top = 70
    Width = 115
    Height = 34
    Caption = '&Ok'
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 155
    Top = 70
    Width = 115
    Height = 34
    Caption = '&Cancel'
    TabOrder = 3
    Kind = bkCancel
  end
end
