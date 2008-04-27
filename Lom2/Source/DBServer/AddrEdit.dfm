object FrmEditAddr: TFrmEditAddr
  Left = 228
  Top = 312
  Width = 771
  Height = 303
  Caption = 'Edit Gate Address'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object AddrGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 763
    Height = 218
    Align = alClient
    ColCount = 9
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    TabOrder = 0
    ColWidths = (
      106
      100
      55
      98
      46
      100
      64
      103
      56)
  end
  object Panel1: TPanel
    Left = 0
    Top = 218
    Width = 763
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 10
      Top = 15
      Width = 42
      Height = 17
      Caption = 'Rows:'
    end
    object BtnApplyRow: TSpeedButton
      Left = 170
      Top = 10
      Width = 111
      Height = 28
      Caption = '&Save'
      OnClick = BtnApplyRowClick
    end
    object BtnApplyAndClose: TButton
      Left = 600
      Top = 10
      Width = 141
      Height = 31
      Caption = '&Ok'
      TabOrder = 0
      OnClick = BtnApplyAndCloseClick
    end
    object ERowCount: TSpinEdit
      Left = 70
      Top = 10
      Width = 91
      Height = 27
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 2
    end
  end
end
