object FrmCreateChr: TFrmCreateChr
  Left = 423
  Top = 356
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Character Creation'
  ClientHeight = 163
  ClientWidth = 313
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
    Left = 7
    Top = 23
    Width = 45
    Height = 15
    Caption = 'User ID:'
  end
  object Label2: TLabel
    Left = 7
    Top = 53
    Width = 94
    Height = 15
    Caption = 'Character Name:'
  end
  object Label3: TLabel
    Left = 7
    Top = 83
    Width = 52
    Height = 15
    Caption = 'Select ID:'
  end
  object EdUserId: TEdit
    Left = 112
    Top = 18
    Width = 182
    Height = 23
    TabOrder = 0
  end
  object EdChrName: TEdit
    Left = 112
    Top = 46
    Width = 182
    Height = 23
    TabOrder = 1
  end
  object BitBtnOK: TBitBtn
    Left = 29
    Top = 113
    Width = 116
    Height = 38
    Caption = '&Ok'
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtnCancel: TBitBtn
    Left = 171
    Top = 113
    Width = 115
    Height = 38
    Caption = '&Cancel'
    TabOrder = 3
    Kind = bkCancel
  end
  object EditSelectID: TEdit
    Left = 112
    Top = 76
    Width = 182
    Height = 23
    TabOrder = 4
    Text = '0'
  end
end
