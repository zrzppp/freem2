object FrmFindUserId: TFrmFindUserId
  Left = 113
  Top = 133
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #30331#24405#24080#21495#31649#29702
  ClientHeight = 255
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object IdGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 756
    Height = 217
    Align = alClient
    ColCount = 16
    DefaultRowHeight = 20
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
    TabOrder = 0
    OnDblClick = BtnEditClick
    ColWidths = (
      64
      64
      71
      91
      89
      150
      141
      169
      170
      83
      90
      72
      76
      182
      159
      218)
  end
  object Panel1: TPanel
    Left = 0
    Top = 217
    Width = 756
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 30
      Height = 12
      Caption = #24080#21495':'
    end
    object EdFindId: TEdit
      Left = 56
      Top = 8
      Width = 121
      Height = 20
      TabOrder = 0
      OnKeyPress = EdFindIdKeyPress
    end
    object BtnFindAll: TButton
      Left = 192
      Top = 8
      Width = 57
      Height = 21
      Caption = #25628#32034'(&S)'
      TabOrder = 1
      OnClick = BtnFindAllClick
    end
    object Button1: TButton
      Left = 576
      Top = 10
      Width = 141
      Height = 21
      Caption = #37325#26032#26381#21153#22120#34920
      TabOrder = 2
      OnClick = Button1Click
    end
    object BtnEdit: TButton
      Left = 288
      Top = 8
      Width = 75
      Height = 21
      Caption = #32534#36753'(&E)'
      TabOrder = 3
      OnClick = BtnEditClick
    end
    object Button2: TButton
      Left = 376
      Top = 8
      Width = 75
      Height = 21
      Caption = #26032#24314'(&N)'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
end
