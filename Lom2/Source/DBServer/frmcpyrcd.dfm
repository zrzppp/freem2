object FrmCopyRcd: TFrmCopyRcd
  Left = 421
  Top = 230
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Copy Record'
  ClientHeight = 179
  ClientWidth = 323
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
    Left = 30
    Top = 30
    Width = 64
    Height = 15
    Caption = 'Replace ID:'
  end
  object Label2: TLabel
    Left = 30
    Top = 60
    Width = 62
    Height = 15
    Caption = 'Confirm ID:'
  end
  object Label3: TLabel
    Left = 30
    Top = 90
    Width = 42
    Height = 15
    Caption = 'With ID:'
  end
  object Edit1: TEdit
    Left = 120
    Top = 30
    Width = 151
    Height = 23
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 120
    Top = 60
    Width = 151
    Height = 23
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 130
    Width = 94
    Height = 31
    Caption = '&Ok'
    TabOrder = 3
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 180
    Top = 130
    Width = 94
    Height = 31
    Caption = '&Cancel'
    TabOrder = 4
    Kind = bkCancel
  end
  object EdWithID: TEdit
    Left = 120
    Top = 90
    Width = 151
    Height = 23
    TabOrder = 2
  end
end
