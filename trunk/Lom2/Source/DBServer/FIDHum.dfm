object FrmIDHum: TFrmIDHum
  Left = 210
  Top = 47
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'DB Tool'
  ClientHeight = 537
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 568
    Top = 508
    Width = 35
    Height = 15
    Caption = 'lAbEl1'
  end
  object Label3: TLabel
    Left = 270
    Top = 15
    Width = 57
    Height = 15
    Caption = 'Character:'
  end
  object Label4: TLabel
    Left = 10
    Top = 50
    Width = 38
    Height = 15
    Caption = 'ID Info:'
    Visible = False
  end
  object Label5: TLabel
    Left = 10
    Top = 170
    Width = 80
    Height = 15
    Caption = 'Character Info:'
  end
  object BtnCreateChr: TSpeedButton
    Left = 10
    Top = 410
    Width = 101
    Height = 31
    Caption = '&Create Chr'
    OnClick = BtnCreateChrClick
  end
  object BtnEraseChr: TSpeedButton
    Left = 256
    Top = 410
    Width = 101
    Height = 31
    Caption = '&Erase Chr'
    OnClick = BtnEraseChrClick
  end
  object BtnChrNameSearch: TSpeedButton
    Left = 500
    Top = 10
    Width = 71
    Height = 31
    Caption = '&Find'
    OnClick = BtnChrNameSearchClick
  end
  object BtnSelAll: TSpeedButton
    Left = 580
    Top = 10
    Width = 101
    Height = 31
    Caption = '&Search All'
    OnClick = BtnSelAllClick
  end
  object BtnDeleteChr: TSpeedButton
    Left = 366
    Top = 410
    Width = 101
    Height = 31
    Caption = '&Delete Chr'
    OnClick = BtnDeleteChrClick
  end
  object BtnRevival: TSpeedButton
    Left = 476
    Top = 410
    Width = 101
    Height = 31
    Caption = '&Revive'
    OnClick = BtnRevivalClick
  end
  object SpeedButton1: TSpeedButton
    Left = 10
    Top = 450
    Width = 351
    Height = 31
    Caption = 'DB E&xplorer'
    OnClick = SpeedButton1Click
  end
  object Label2: TLabel
    Left = 10
    Top = 15
    Width = 45
    Height = 15
    Caption = 'User ID:'
  end
  object BtnDeleteChrAllInfo: TSpeedButton
    Left = 370
    Top = 450
    Width = 351
    Height = 31
    Caption = 'Delete &All Char Info'
    OnClick = BtnDeleteChrAllInfoClick
  end
  object SpeedButton2: TSpeedButton
    Left = 586
    Top = 410
    Width = 121
    Height = 31
    Caption = 'Find &Index'
    OnClick = SpeedButton2Click
  end
  object LabelCount: TLabel
    Left = 90
    Top = 170
    Width = 3
    Height = 15
  end
  object SpeedButtonEditData: TSpeedButton
    Left = 116
    Top = 410
    Width = 121
    Height = 31
    Caption = 'Edit &Chr'
    OnClick = SpeedButtonEditDataClick
  end
  object Edit1: TEdit
    Left = 260
    Top = 500
    Width = 141
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 414
    Top = 500
    Width = 141
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'fds'
    OnKeyPress = Edit2KeyPress
  end
  object EdChrName: TEdit
    Left = 350
    Top = 10
    Width = 141
    Height = 23
    TabOrder = 2
    OnKeyPress = EdChrNameKeyPress
  end
  object IdGrid: TStringGrid
    Left = 10
    Top = 70
    Width = 761
    Height = 91
    ColCount = 8
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    TabOrder = 3
    Visible = False
    ColWidths = (
      69
      70
      77
      95
      70
      78
      194
      64)
  end
  object ChrGrid: TStringGrid
    Left = 10
    Top = 190
    Width = 761
    Height = 211
    ColCount = 7
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    TabOrder = 4
    OnClick = ChrGridClick
    OnDblClick = ChrGridDblClick
    ColWidths = (
      66
      74
      75
      80
      159
      64
      64)
  end
  object CbShowDelChr: TCheckBox
    Left = 354
    Top = 44
    Width = 137
    Height = 21
    Caption = 'Search Deleted'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object Button1: TButton
    Left = 10
    Top = 495
    Width = 206
    Height = 31
    Caption = 'Refresh Manager Info'
    TabOrder = 6
    OnClick = Button1Click
  end
  object EdUserId: TEdit
    Left = 85
    Top = 10
    Width = 166
    Height = 23
    TabOrder = 7
    OnKeyPress = EdUserIdKeyPress
  end
  object Query1: TQuery
    DatabaseName = 'mud_db'
    Left = 488
    Top = 432
  end
end
