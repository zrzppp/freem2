object FrmAccountView: TFrmAccountView
  Left = 377
  Top = 120
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20805#20540#35760#24405
  ClientHeight = 456
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object EdFindID: TEdit
    Left = 8
    Top = 408
    Width = 193
    Height = 20
    TabOrder = 0
    OnKeyPress = EdFindIDKeyPress
  end
  object EdFindIP: TEdit
    Left = 208
    Top = 408
    Width = 185
    Height = 20
    TabOrder = 1
    OnKeyPress = EdFindIPKeyPress
  end
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 193
    Height = 393
    ItemHeight = 12
    TabOrder = 2
  end
  object ListBox2: TListBox
    Left = 208
    Top = 8
    Width = 193
    Height = 393
    ItemHeight = 12
    TabOrder = 3
  end
end
