object FrmQueryFileName: TFrmQueryFileName
  Left = 260
  Top = 281
  Width = 365
  Height = 126
  Caption = 'Location and Name Of File To Add'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 20
    Width = 22
    Height = 13
    Caption = 'File :'
  end
  object EdFileName: TEdit
    Left = 40
    Top = 16
    Width = 305
    Height = 21
    ImeName = '???(??) (MS-IME95)'
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 64
    Top = 56
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 216
    Top = 56
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
