object FrmSysMemo: TFrmSysMemo
  Left = 363
  Top = 226
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sysop Memo'
  ClientHeight = 126
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 19
    Top = 8
    Width = 34
    Height = 15
    Caption = 'Memo'
  end
  object EdMemo: TEdit
    Left = 19
    Top = 34
    Width = 322
    Height = 23
    ImeName = '???(??) (MS-IME95)'
    TabOrder = 0
    Text = 'EdMemo'
  end
  object BitBtn1: TBitBtn
    Left = 226
    Top = 78
    Width = 115
    Height = 33
    Caption = '&Ok'
    TabOrder = 1
    Kind = bkOK
  end
end
