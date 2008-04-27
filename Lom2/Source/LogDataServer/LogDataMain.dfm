object Form1: TForm1
  Left = 520
  Top = 856
  BorderStyle = bsSingle
  Caption = 'LogDataServer'
  ClientHeight = 42
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 36
    Height = 13
    Caption = 'Status: '
  end
  object Label2: TLabel
    Left = 32
    Top = 24
    Width = 71
    Height = 13
    Caption = 'Last File: None'
  end
  object CheckBox1: TRadioButton
    Left = 8
    Top = 14
    Width = 17
    Height = 17
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object Button1: TButton
    Left = 344
    Top = 24
    Width = 57
    Height = 17
    Caption = 'Button1'
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object ProcessList: TTimer
    Interval = 5000
    OnTimer = ProcessListTimer
    Left = 432
    Top = 8
  end
end
