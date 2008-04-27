object frmViewOnlineHuman: TfrmViewOnlineHuman
  Left = 96
  Top = 215
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22312#32447#29609#23478
  ClientHeight = 277
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 121
    Top = 253
    Width = 22
    Height = 13
    Caption = 'Sort:'
  end
  object PanelStatus: TPanel
    Left = 0
    Top = 0
    Width = 745
    Height = 235
    Align = alTop
    Caption = '??????...'
    TabOrder = 0
    object GridHuman: TStringGrid
      Left = 1
      Top = 1
      Width = 743
      Height = 233
      Align = alClient
      ColCount = 15
      DefaultRowHeight = 18
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      OnDblClick = GridHumanDblClick
      ColWidths = (
        33
        78
        31
        44
        39
        37
        47
        74
        89
        32
        138
        59
        55
        57
        64)
    end
  end
  object ButtonRefGrid: TButton
    Left = 9
    Top = 244
    Width = 79
    Height = 27
    Hint = 'Refresh the list'
    Caption = '&Refresh'
    TabOrder = 1
    OnClick = ButtonRefGridClick
  end
  object ComboBoxSort: TComboBox
    Left = 165
    Top = 251
    Width = 122
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnClick = ComboBoxSortClick
    Items.Strings = (
      'Name'
      'Gender'
      'Job'
      'Level'
      'Map'
      'IP Address'
      'Permission Level'
      'Local IP')
  end
  object EditSearchName: TEdit
    Left = 347
    Top = 251
    Width = 139
    Height = 21
    TabOrder = 3
  end
  object ButtonSearch: TButton
    Left = 494
    Top = 244
    Width = 79
    Height = 27
    Caption = '&Search'
    TabOrder = 4
    OnClick = ButtonSearchClick
  end
  object ButtonView: TButton
    Left = 652
    Top = 244
    Width = 87
    Height = 27
    Hint = 'View the selected characters full data card'
    Caption = '&View'
    TabOrder = 5
    OnClick = ButtonViewClick
  end
  object Timer: TTimer
    Enabled = False
    Left = 288
    Top = 232
  end
end
