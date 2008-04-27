object FrmMain: TFrmMain
  Left = 413
  Top = 352
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Lom2'#24080#21495#30331#24405#26381#21153#22120
  ClientHeight = 195
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 39
    Width = 303
    Height = 156
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    Color = clTeal
    TabOrder = 0
    object BtnDump: TSpeedButton
      Left = 568
      Top = 2
      Width = 57
      Height = 17
      Caption = 'Dump'
    end
    object MonitorGrid: TStringGrid
      Left = 0
      Top = 39
      Width = 303
      Height = 117
      Align = alClient
      ColCount = 3
      DefaultRowHeight = 17
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 0
      ColWidths = (
        153
        69
        54)
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 303
      Height = 39
      Align = alTop
      Caption = ' '
      ParentColor = True
      TabOrder = 1
      OnDblClick = Panel2DblClick
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 12
        Height = 12
        Caption = '00'
      end
      object SpeedButton1: TSpeedButton
        Left = 99
        Top = 2
        Width = 62
        Height = 17
        Caption = #24080#21495#31649#29702
        Flat = True
        OnClick = SpeedButton1Click
      end
      object LbMasCount: TLabel
        Left = 131
        Top = 24
        Width = 60
        Height = 12
        Caption = 'LbMasCount'
      end
      object BtnView: TSpeedButton
        Left = 165
        Top = 2
        Width = 65
        Height = 17
        Caption = #20805#20540#35760#24405
        Flat = True
        OnClick = BtnViewClick
      end
      object BtnShowServerUsers: TSpeedButton
        Left = 232
        Top = 2
        Width = 65
        Height = 17
        Caption = #20154#25968#38480#21046
        Flat = True
        OnClick = BtnShowServerUsersClick
      end
      object SpeedButton2: TSpeedButton
        Left = 81
        Top = 2
        Width = 15
        Height = 17
        Caption = '#'
        Flat = True
        OnClick = SpeedButton2Click
      end
      object CkLogin: TCheckBox
        Left = 8
        Top = 1
        Width = 65
        Height = 17
        Caption = #36830#25509' (0)'
        Enabled = False
        TabOrder = 0
      end
      object CbViewLog: TCheckBox
        Left = 56
        Top = 22
        Width = 73
        Height = 17
        Caption = #26174#31034#20449#24687
        TabOrder = 1
        OnClick = CbViewLogClick
      end
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 303
    Height = 39
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnDblClick = Memo1DblClick
  end
  object GSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = GSocketClientConnect
    OnClientDisconnect = GSocketClientDisconnect
    OnClientRead = GSocketClientRead
    OnClientError = GSocketClientError
    Left = 17
    Top = 123
  end
  object ExecTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = ExecTimerTimer
    Left = 57
    Top = 123
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 97
    Top = 123
  end
  object StartTimer: TTimer
    OnTimer = StartTimerTimer
    Left = 57
    Top = 155
  end
  object WebLogTimer: TTimer
    Interval = 60000
    Left = 97
    Top = 155
  end
  object LogTimer: TTimer
    Left = 136
    Top = 155
  end
  object CountLogTimer: TTimer
    Interval = 300000
    OnTimer = CountLogTimerTimer
    Left = 177
    Top = 155
  end
  object MonitorTimer: TTimer
    Interval = 3000
    OnTimer = MonitorTimerTimer
    Left = 216
    Top = 123
  end
  object MainMenu: TMainMenu
    Left = 164
    Top = 128
    object MENU_CONTROL: TMenuItem
      Caption = #25511#21046'(&C)'
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = #36864#20986'(&X)'
        OnClick = MENU_CONTROL_EXITClick
      end
    end
    object MENU_VIEW: TMenuItem
      Caption = #26597#30475'(&V)'
      object MENU_VIEW_SESSION: TMenuItem
        Caption = #20840#23616#20250#35805'(&G)'
        OnClick = MENU_VIEW_SESSIONClick
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&O)'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        Visible = False
      end
      object MENU_OPTION_ROUTE: TMenuItem
        Caption = #32593#20851#35774#32622'(&R)'
        OnClick = MENU_OPTION_ROUTEClick
      end
    end
    object MENU_TOOLS: TMenuItem
      Caption = #24037#20855'(&T)'
      Visible = False
    end
    object MENU_HELP: TMenuItem
      Caption = #24110#21161'(&H)'
      Visible = False
      object MENU_HELP_ABOUT: TMenuItem
        Caption = #20851#20110'(&A)'
        Visible = False
      end
    end
  end
end
