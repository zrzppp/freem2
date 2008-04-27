object FrmDBSrv: TFrmDBSrv
  Left = 212
  Top = 221
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'DBServer'
  ClientHeight = 248
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object MemoLog: TMemo
    Left = 0
    Top = 65
    Width = 414
    Height = 76
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 414
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object Label1: TLabel
      Left = 10
      Top = 17
      Width = 54
      Height = 12
      Alignment = taCenter
      Caption = #26410#36830#25509'!!!'
    end
    object Label3: TLabel
      Left = 13
      Top = 1
      Width = 36
      Height = 12
      Caption = 'Label3'
    end
    object Label4: TLabel
      Left = 55
      Top = 1
      Width = 36
      Height = 12
      Caption = 'Label4'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LbAutoClean: TLabel
      Left = 358
      Top = 1
      Width = 36
      Height = 12
      Alignment = taRightJustify
      Caption = 'LbAuto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LbTransCount: TLabel
      Left = 199
      Top = 17
      Width = 72
      Height = 12
      Caption = 'LbTransCount'
    end
    object Label2: TLabel
      Left = 114
      Top = 17
      Width = 54
      Height = 12
      Alignment = taRightJustify
      Caption = #36830#25509#25968': 0'
    end
    object Label6: TLabel
      Left = 10
      Top = 33
      Width = 66
      Height = 12
      Caption = #29992#25143#36830#25509#25968':'
    end
    object LbUserCount: TLabel
      Left = 80
      Top = 33
      Width = 36
      Height = 12
      Caption = '000000'
    end
    object Label8: TLabel
      Left = 10
      Top = 48
      Width = 36
      Height = 12
      Caption = 'Label8'
    end
    object Label9: TLabel
      Left = 76
      Top = 48
      Width = 36
      Height = 12
      Caption = 'Label9'
    end
    object Label10: TLabel
      Left = 142
      Top = 48
      Width = 42
      Height = 12
      Caption = 'Label10'
    end
    object Label11: TLabel
      Left = 214
      Top = 48
      Width = 42
      Height = 12
      Caption = 'Label11'
    end
    object CkViewHackMsg: TCheckBox
      Left = 158
      Top = 29
      Width = 141
      Height = 21
      Caption = #26597#30475#24322#24120#20449#24687
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CkViewHackMsgClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 160
    Width = 414
    Height = 88
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    Visible = False
    object ListView: TListView
      Left = 0
      Top = 0
      Width = 414
      Height = 88
      Align = alClient
      Columns = <
        item
          Caption = #27169#22359#21517#31216
          Width = 80
        end
        item
          Caption = #36830#25509#22320#22336
          Width = 250
        end
        item
          Caption = #36890#35759#29366#24577
          Width = 80
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      SortType = stBoth
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 141
    Width = 414
    Height = 19
    Panels = <
      item
        Text = #25968#25454#22788#29702#26381#21153#22120
        Width = 50
      end>
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 6000
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 60
    Top = 72
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 268
    Top = 80
  end
  object AniTimer: TTimer
    Interval = 300
    OnTimer = AniTimerTimer
    Left = 236
    Top = 80
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = StartTimerTimer
    Left = 236
    Top = 112
  end
  object Timer2: TTimer
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 268
    Top = 112
  end
  object MainMenu: TMainMenu
    Left = 184
    Top = 88
    object MENU_CONTROL: TMenuItem
      Caption = #25511#21046'(&C)'
      object MENU_CONTROL_START: TMenuItem
        Caption = #21551#21160'(&S)'
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = #20572#27490'(&T)'
      end
      object Exit1: TMenuItem
        Caption = #36864#20986'(&X)'
        OnClick = Exit1Click
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&O)'
      object MENU_OPTION_GAMEGATE: TMenuItem
        Caption = #28216#25103#32593#20851'(&R)'
        OnClick = MENU_CONTROL_STARTClick
      end
    end
    object MENU_MANAGE: TMenuItem
      Caption = #31649#29702'(&M)'
      object MENU_MANAGE_DATA: TMenuItem
        Caption = #25968#25454'(&D)'
        OnClick = MENU_MANAGE_DATAClick
      end
      object MENU_MANAGE_TOOL: TMenuItem
        Caption = #24037#20855'(&T)'
        OnClick = MENU_MANAGE_TOOLClick
      end
    end
    object MENU_TEST: TMenuItem
      Caption = #27979#35797'(&T)'
      object MENU_TEST_SELGATE: TMenuItem
        Caption = #20154#29289#32593#20851'(&S)'
      end
    end
  end
end
