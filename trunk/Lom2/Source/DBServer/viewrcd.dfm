object FrmFDBViewer: TFrmFDBViewer
  Left = 45
  Top = 282
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Record Viewer'
  ClientHeight = 231
  ClientWidth = 913
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TabbedNotebook1: TTabbedNotebook
    Left = 0
    Top = 0
    Width = 913
    Height = 231
    Align = alClient
    TabFont.Charset = DEFAULT_CHARSET
    TabFont.Color = clBtnText
    TabFont.Height = -11
    TabFont.Name = 'MS Sans Serif'
    TabFont.Style = []
    TabOrder = 0
    object TTabPage
      Left = 4
      Top = 24
      Caption = 'Human'
      object HumanGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 905
        Height = 203
        Align = alClient
        ColCount = 12
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 15
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goThumbTracking]
        TabOrder = 0
        ColWidths = (
          64
          69
          64
          64
          64
          64
          64
          64
          64
          64
          71
          98)
        RowHeights = (
          5
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20
          20)
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      HelpContext = 1
      Caption = 'BagItems'
      object BagItemGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 905
        Height = 203
        Align = alClient
        ColCount = 4
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 63
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goThumbTracking]
        TabOrder = 0
        ColWidths = (
          48
          88
          63
          125)
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      HelpContext = 2
      Caption = 'Storage'
      object SaveItemGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 905
        Height = 203
        Align = alClient
        ColCount = 3
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 52
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goThumbTracking]
        TabOrder = 0
        ColWidths = (
          102
          57
          126)
      end
    end
    object TTabPage
      Left = 4
      Top = 24
      HelpContext = 3
      Caption = 'Magic'
      object UseMagicGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 905
        Height = 203
        Align = alClient
        ColCount = 4
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 27
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goThumbTracking]
        TabOrder = 0
        ColWidths = (
          82
          67
          66
          112)
      end
    end
  end
end
