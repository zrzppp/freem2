object FrmMain: TFrmMain
  Left = 325
  Top = 201
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'FrmMain'
  ClientHeight = 217
  ClientWidth = 315
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 197
    Width = 315
    Height = 20
    Panels = <
      item
        Alignment = taCenter
        Text = '????'
        Width = 45
      end
      item
        Alignment = taCenter
        Text = #26410#36830#25509
        Width = 60
      end
      item
        Alignment = taCenter
        Text = '????'
        Width = 70
      end
      item
        Alignment = taCenter
        Text = '????'
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 315
    Height = 197
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #26381#21153#22120#26085#24535
      object Label1: TLabel
        Left = 51
        Top = 8
        Width = 204
        Height = 12
        Caption = #20013#22269'Lom2'#24320#21457#32852#30431#28216#25103#36890#35759#32593#20851#26381#21153#22120
      end
      object MemoLog: TMemo
        Left = 0
        Top = 28
        Width = 307
        Height = 142
        Align = alBottom
        ReadOnly = True
        ScrollBars = ssHorizontal
        TabOrder = 0
        OnChange = MemoLogChange
      end
    end
    object TabSheet2: TTabSheet
      Caption = #36890#35759#20449#24687
      ImageIndex = 1
      object Panel: TPanel
        Left = 0
        Top = 0
        Width = 307
        Height = 209
        Align = alTop
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 5
          Top = 4
          Width = 296
          Height = 89
          Caption = #32593#32476#27969#37327
          TabOrder = 0
          object LabelReviceMsgSize: TLabel
            Left = 12
            Top = 21
            Width = 30
            Height = 12
            Caption = #25509#25910':'
          end
          object LabelSendBlockSize: TLabel
            Left = 12
            Top = 41
            Width = 30
            Height = 12
            Caption = #21457#36865':'
          end
          object LabelLogonMsgSize: TLabel
            Left = 92
            Top = 21
            Width = 30
            Height = 12
            Caption = #30331#24405':'
          end
          object LabelPlayMsgSize: TLabel
            Left = 92
            Top = 41
            Width = 30
            Height = 12
            Caption = #26222#36890':'
          end
          object LabelDeCodeMsgSize: TLabel
            Left = 172
            Top = 21
            Width = 30
            Height = 12
            Caption = #35299#30721':'
          end
          object LabelProcessMsgSize: TLabel
            Left = 172
            Top = 41
            Width = 30
            Height = 12
            Caption = #32534#30721':'
          end
          object LabelBufferOfM2Size: TLabel
            Left = 12
            Top = 65
            Width = 66
            Height = 12
            Caption = #26381#21153#22120#36890#35759':'
          end
          object LabelSelfCheck: TLabel
            Left = 132
            Top = 65
            Width = 54
            Height = 12
            Caption = #36890#35759#33258#26816':'
          end
          object LbLack: TLabel
            Left = 228
            Top = 65
            Width = 18
            Height = 12
            Caption = '0/0'
          end
        end
        object GroupBoxProcessTime: TGroupBox
          Left = 5
          Top = 99
          Width = 296
          Height = 66
          Caption = #22788#29702#26102#38388
          TabOrder = 1
          object LabelSendTime: TLabel
            Left = 12
            Top = 40
            Width = 30
            Height = 12
            Caption = #21457#36865':'
          end
          object LabelReceTime: TLabel
            Left = 12
            Top = 20
            Width = 30
            Height = 12
            Caption = #25509#25910':'
          end
          object LabelLoop: TLabel
            Left = 212
            Top = 20
            Width = 48
            Height = 12
            Caption = #25968#25454#22788#29702
          end
          object LabelReviceLimitTime: TLabel
            Left = 88
            Top = 20
            Width = 78
            Height = 12
            Caption = #25509#25910#22788#29702#38480#21046':'
          end
          object LabelSendLimitTime: TLabel
            Left = 88
            Top = 40
            Width = 78
            Height = 12
            Caption = #21457#36865#22788#29702#38480#21046':'
          end
          object LabelLoopTime: TLabel
            Left = 212
            Top = 40
            Width = 48
            Height = 12
            Alignment = taCenter
            AutoSize = False
            Caption = '--------'
          end
        end
      end
    end
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 82
    Top = 104
  end
  object SendTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = SendTimerTimer
    Left = 109
    Top = 104
  end
  object ClientSocket: TClientSocket
    Active = False
    Address = '127.0.0.1'
    ClientType = ctNonBlocking
    Port = 50000
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 50
    Top = 104
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 140
    Top = 104
  end
  object DecodeTimer: TTimer
    Interval = 1
    OnTimer = DecodeTimerTimer
    Left = 202
    Top = 104
  end
  object MainMenu: TMainMenu
    Left = 235
    Top = 104
    object MENU_CONTROL: TMenuItem
      Caption = #25511#21046'(&C)'
      object MENU_CONTROL_START: TMenuItem
        Caption = #21551#21160#26381#21153'(&S)'
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = #20572#27490#26381#21153'(&T)'
        OnClick = MENU_CONTROL_STOPClick
      end
      object MENU_CONTROL_RECONNECT: TMenuItem
        Caption = #21047#26032#36830#25509'(&R)'
        OnClick = MENU_CONTROL_RECONNECTClick
      end
      object MENU_CONTROL_RELOADCONFIG: TMenuItem
        Caption = #37325#21152#36733#37197#32622'(&R)'
        OnClick = MENU_CONTROL_RELOADCONFIGClick
      end
      object MENU_CONTROL_CLEAELOG: TMenuItem
        Caption = #28165#38500#26085#24535'(&C)'
        OnClick = MENU_CONTROL_CLEAELOGClick
      end
      object MENU_CONTROL_EXIT: TMenuItem
        Caption = #36864#20986'(&E)'
        OnClick = MENU_CONTROL_EXITClick
      end
    end
    object MENU_VIEW: TMenuItem
      Caption = #26597#30475'(&V)'
      Visible = False
      object MENU_VIEW_LOGMSG: TMenuItem
        Caption = #26597#30475#26085#24535'(&L)'
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&O)'
      object MENU_OPTION_GENERAL: TMenuItem
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = MENU_OPTION_GENERALClick
      end
      object MENU_OPTION_PERFORM: TMenuItem
        Caption = #24615#33021#35774#32622'(&P)'
        OnClick = MENU_OPTION_PERFORMClick
      end
      object MENU_OPTION_FILTERMSG: TMenuItem
        Caption = #28040#24687#36807#28388'(&C)'
        OnClick = MENU_OPTION_FILTERMSGClick
      end
      object MENU_OPTION_IPFILTER: TMenuItem
        Caption = #23433#20840#36807#28388'(&S)'
        OnClick = MENU_OPTION_IPFILTERClick
      end
    end
    object N2: TMenuItem
      Caption = #20851#20110
      Visible = False
    end
  end
  object StartTimer: TTimer
    Interval = 200
    OnTimer = StartTimerTimer
    Left = 172
    Top = 104
  end
  object PopupMenu: TPopupMenu
    Left = 268
    Top = 104
    object POPMENU_PORT: TMenuItem
      AutoHotkeys = maManual
      Caption = #31471#21475
    end
    object POPMENU_CONNSTAT: TMenuItem
      AutoHotkeys = maManual
      Caption = #36830#25509#29366#24577
    end
    object POPMENU_CONNCOUNT: TMenuItem
      AutoHotkeys = maManual
      Caption = #36830#25509#25968
    end
    object POPMENU_CHECKTICK: TMenuItem
      AutoHotkeys = maManual
      Caption = #36890#35759#36229#26102
    end
    object N1: TMenuItem
      Caption = '--------------------'
    end
    object POPMENU_OPEN: TMenuItem
      Caption = #25171#24320#31383#21475'(&O)'
    end
    object POPMENU_START: TMenuItem
      Caption = #21551#21160#26381#21153'(&S)'
      OnClick = MENU_CONTROL_STARTClick
    end
    object POPMENU_CONNSTOP: TMenuItem
      Caption = #20572#27490#26381#21153'(&T)'
      OnClick = MENU_CONTROL_STOPClick
    end
    object POPMENU_RECONN: TMenuItem
      Caption = #21047#26032#36830#25509'(&R)'
      OnClick = MENU_CONTROL_RECONNECTClick
    end
    object POPMENU_EXIT: TMenuItem
      Caption = #36864#20986'(&X)'
      OnClick = MENU_CONTROL_EXITClick
    end
  end
  object CnTrayIcon1: TCnTrayIcon
    AutoHide = True
    Hint = #28216#25103#32593#20851
    Icon.Data = {
      0000010001002020040000000000E80200001600000028000000200000004000
      0000010004000000000000020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      00B3111111111111000000000000000000BBB333333333110000000000000000
      008888B333333331000000000000000000033333333331100000000000000000
      000888888BBBBB10000000000000000000000333333333100000000000000000
      000008BBBB3B10000444440000000000000008BBBB3310044676764400000000
      00000888BB3310476767667640000000000000BBBB3372267676676764000000
      000000BBBB3372777767627674000000000000888BB377777772226766400000
      0000000BBBB3377777722276764000000000000BBBB337777222226766400000
      0000000888BB37877222222666400000000000008BBB33777722772222400000
      000000008BBB337F777227222240000000000000888BB378F777222224000000
      000000000BBBB3377772222224000000000000000888B3372777222240000000
      000000000088BB373277772400000000000000000088BB337222220000000000
      0000000000088BB370000000000000000000000000088BB33100000000000000
      000000000000BBB333100000000000000B3333333333BBB33310000000000000
      0BB3333333333BBB33300000000000000BBB3333333BBBBBB330000000000000
      08BBBBBBBBBBB88BBB3000000000000008B8888888888888BB30000000000000
      08888888888888888BB00000000000000000000000000000000000000000FC00
      0FFFFC000FFFFC000FFFFE001FFFFE001FFFFF801FFFFF80783FFF80600FFF80
      4007FFC00003FFC00003FFC00001FFE00001FFE00001FFE00001FFF00001FFF0
      0001FFF00003FFF80003FFF80007FFFC000FFFFC003FFFFE07FFFFFE03FFFFFF
      01FFF80001FFF80001FFF80001FFF80001FFF80001FFF80001FFFFFFFFFF}
    UseAppIcon = True
    OnDblClick = CnTrayIcon1DblClick
    Left = 20
    Top = 103
  end
end
