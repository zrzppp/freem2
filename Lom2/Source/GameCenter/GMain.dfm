object frmMain: TfrmMain
  Left = 250
  Top = 134
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Game Centre'
  ClientHeight = 470
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 10
    Top = 10
    Width = 650
    Height = 450
    ActivePage = TabSheet1
    HotTrack = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Load up'
      object GroupBox5: TGroupBox
        Left = 10
        Top = 10
        Width = 621
        Height = 391
        Caption = 'Programs to run'
        TabOrder = 0
        object EditM2ServerProgram: TEdit
          Left = 590
          Top = 80
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 0
          Visible = False
        end
        object EditDBServerProgram: TEdit
          Left = 590
          Top = 20
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 1
          Visible = False
        end
        object EditLoginSrvProgram: TEdit
          Left = 590
          Top = 50
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 2
          Visible = False
        end
        object EditLogServerProgram: TEdit
          Left = 590
          Top = 110
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 3
          Visible = False
        end
        object EditLoginGateProgram: TEdit
          Left = 590
          Top = 140
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 4
          Visible = False
        end
        object EditSelGateProgram: TEdit
          Left = 590
          Top = 170
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 5
          Visible = False
        end
        object EditRunGateProgram: TEdit
          Left = 590
          Top = 200
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 6
          Visible = False
        end
        object ButtonStartGame: TButton
          Left = 220
          Top = 340
          Width = 181
          Height = 41
          Caption = 'Start Services (&S)'
          TabOrder = 7
          OnClick = ButtonStartGameClick
        end
        object CheckBoxM2Server: TCheckBox
          Left = 10
          Top = 55
          Width = 201
          Height = 21
          Caption = 'Run(M2Server):'
          TabOrder = 8
          OnClick = CheckBoxM2ServerClick
        end
        object CheckBoxDBServer: TCheckBox
          Left = 10
          Top = 25
          Width = 201
          Height = 21
          Caption = 'Run(DBServer):'
          TabOrder = 9
          OnClick = CheckBoxDBServerClick
        end
        object CheckBoxLoginServer: TCheckBox
          Left = 230
          Top = 25
          Width = 221
          Height = 21
          Caption = 'Run(LoginSrv):'
          TabOrder = 10
          OnClick = CheckBoxLoginServerClick
        end
        object CheckBoxLogServer: TCheckBox
          Left = 230
          Top = 55
          Width = 221
          Height = 21
          Caption = 'Run(LogServer):'
          TabOrder = 11
          OnClick = CheckBoxLogServerClick
        end
        object CheckBoxLoginGate: TCheckBox
          Left = 10
          Top = 85
          Width = 201
          Height = 21
          Caption = 'Run(LoginGate):'
          TabOrder = 12
          OnClick = CheckBoxLoginGateClick
        end
        object CheckBoxSelGate: TCheckBox
          Left = 230
          Top = 85
          Width = 201
          Height = 21
          Caption = 'Run1(SelGate):'
          TabOrder = 13
          OnClick = CheckBoxSelGateClick
        end
        object CheckBoxRunGate: TCheckBox
          Left = 10
          Top = 115
          Width = 201
          Height = 21
          Caption = 'Run2(RunGate):'
          TabOrder = 14
          OnClick = CheckBoxRunGateClick
        end
        object CheckBoxRunGate1: TCheckBox
          Left = 230
          Top = 115
          Width = 201
          Height = 21
          Caption = 'Run3(RunGate):'
          TabOrder = 15
          OnClick = CheckBoxRunGate1Click
        end
        object EditRunGate1Program: TEdit
          Left = 590
          Top = 230
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 16
          Visible = False
        end
        object CheckBoxRunGate2: TCheckBox
          Left = 10
          Top = 145
          Width = 201
          Height = 21
          Caption = 'Run4(RunGate):'
          TabOrder = 17
          OnClick = CheckBoxRunGate2Click
        end
        object EditRunGate2Program: TEdit
          Left = 590
          Top = 260
          Width = 371
          Height = 23
          ReadOnly = True
          TabOrder = 18
          Visible = False
        end
        object MemoLog: TMemo
          Left = 10
          Top = 190
          Width = 591
          Height = 131
          Color = clNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clLime
          Font.Height = -15
          Font.Name = '??'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
          OnChange = MemoLogChange
        end
      end
    end
    object TabSheet14: TTabSheet
      Caption = 'Game List'
      ImageIndex = 4
      object GroupBox21: TGroupBox
        Left = 10
        Top = 10
        Width = 621
        Height = 401
        Caption = 'Connect to'
        TabOrder = 0
        object Label24: TLabel
          Left = 10
          Top = 20
          Width = 60
          Height = 15
          Caption = 'Game List:'
        end
        object Label25: TLabel
          Left = 10
          Top = 195
          Width = 69
          Height = 15
          Caption = 'Home Page:'
        end
        object Label26: TLabel
          Left = 10
          Top = 220
          Width = 37
          Height = 15
          Caption = 'Memo:'
        end
        object LabelConnect: TLabel
          Left = 150
          Top = 220
          Width = 3
          Height = 15
        end
        object Label27: TLabel
          Left = 360
          Top = 195
          Width = 38
          Height = 15
          Caption = '?????:'
        end
        object MemoGameList: TMemo
          Left = 10
          Top = 40
          Width = 501
          Height = 141
          Lines.Strings = (
            
              '????|????|219.153.11.60|7000|MirClient.dat|http://www.lingame.co' +
              'm'
            '')
          ScrollBars = ssHorizontal
          TabOrder = 0
          OnChange = MemoGameListChange
        end
        object EditNoticeUrl: TEdit
          Left = 80
          Top = 190
          Width = 251
          Height = 23
          TabOrder = 1
          Text = 'www.lingame.com'
          OnChange = EditNoticeUrlChange
        end
        object Memo1: TMemo
          Left = 10
          Top = 240
          Width = 501
          Height = 141
          TabOrder = 2
        end
        object Button2: TButton
          Left = 520
          Top = 40
          Width = 91
          Height = 31
          Caption = '????'
          Enabled = False
          TabOrder = 3
          OnClick = Button2Click
        end
        object EditClientForm: TSpinEdit
          Left = 450
          Top = 190
          Width = 61
          Height = 24
          MaxValue = 20
          MinValue = -1
          TabOrder = 4
          Value = -1
          OnChange = EditClientFormChange
        end
      end
    end
    object TabSheet15: TTabSheet
      Caption = 'Character info'
      ImageIndex = 5
      object GroupBox25: TGroupBox
        Left = 10
        Top = 10
        Width = 621
        Height = 401
        Caption = '??????'
        TabOrder = 0
        object Label30: TLabel
          Left = 20
          Top = 30
          Width = 85
          Height = 15
          Caption = 'Search account'
        end
        object EditSearchLoginAccount: TEdit
          Left = 90
          Top = 25
          Width = 131
          Height = 23
          TabOrder = 0
        end
        object ButtonSearchLoginAccount: TButton
          Left = 230
          Top = 20
          Width = 81
          Height = 31
          Caption = 'Search(&S)'
          TabOrder = 1
          OnClick = ButtonSearchLoginAccountClick
        end
        object GroupBox26: TGroupBox
          Left = 10
          Top = 60
          Width = 601
          Height = 331
          Caption = 'Details'
          TabOrder = 2
          object Label31: TLabel
            Left = 57
            Top = 20
            Width = 31
            Height = 15
            Alignment = taRightJustify
            Caption = 'Login'
          end
          object Label32: TLabel
            Left = 272
            Top = 20
            Width = 56
            Height = 15
            Alignment = taRightJustify
            Caption = 'Password'
          end
          object Label33: TLabel
            Left = 24
            Top = 50
            Width = 64
            Height = 15
            Alignment = taRightJustify
            Caption = 'User Name'
          end
          object Label34: TLabel
            Left = 296
            Top = 50
            Width = 32
            Height = 15
            Alignment = taRightJustify
            Caption = 'SSNo'
          end
          object Label35: TLabel
            Left = 42
            Top = 80
            Width = 46
            Height = 15
            Alignment = taRightJustify
            Caption = 'BirthDay'
          end
          object Label36: TLabel
            Left = 57
            Top = 170
            Width = 31
            Height = 15
            Alignment = taRightJustify
            Caption = 'Quiz1'
          end
          object Label37: TLabel
            Left = 37
            Top = 200
            Width = 51
            Height = 15
            Alignment = taRightJustify
            Caption = 'Answer 1'
          end
          object Label38: TLabel
            Left = 54
            Top = 230
            Width = 34
            Height = 15
            Alignment = taRightJustify
            Caption = 'Quiz 2'
          end
          object Label39: TLabel
            Left = 37
            Top = 260
            Width = 51
            Height = 15
            Alignment = taRightJustify
            Caption = 'Answer 2'
          end
          object Label40: TLabel
            Left = 33
            Top = 140
            Width = 55
            Height = 15
            Alignment = taRightJustify
            Caption = 'Mobile No'
          end
          object Label41: TLabel
            Left = 284
            Top = 80
            Width = 44
            Height = 15
            Alignment = taRightJustify
            Caption = 'Memo 1'
          end
          object Label42: TLabel
            Left = 284
            Top = 110
            Width = 44
            Height = 15
            Alignment = taRightJustify
            Caption = 'Memo 2'
          end
          object Label43: TLabel
            Left = 17
            Top = 293
            Width = 81
            Height = 15
            Alignment = taRightJustify
            Caption = 'Email Address'
          end
          object Label44: TLabel
            Left = 33
            Top = 110
            Width = 55
            Height = 15
            Alignment = taRightJustify
            Caption = 'Phone No'
          end
          object EditLoginAccount: TEdit
            Left = 100
            Top = 20
            Width = 151
            Height = 23
            Enabled = False
            MaxLength = 10
            TabOrder = 0
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountPasswd: TEdit
            Left = 340
            Top = 20
            Width = 121
            Height = 23
            MaxLength = 10
            TabOrder = 1
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountUserName: TEdit
            Left = 100
            Top = 50
            Width = 151
            Height = 23
            MaxLength = 20
            TabOrder = 2
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountSSNo: TEdit
            Left = 340
            Top = 50
            Width = 151
            Height = 23
            MaxLength = 14
            TabOrder = 3
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountBirthDay: TEdit
            Left = 100
            Top = 80
            Width = 151
            Height = 23
            MaxLength = 10
            TabOrder = 4
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountQuiz: TEdit
            Left = 100
            Top = 170
            Width = 261
            Height = 23
            MaxLength = 20
            TabOrder = 5
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountAnswer: TEdit
            Left = 100
            Top = 200
            Width = 261
            Height = 23
            MaxLength = 12
            TabOrder = 6
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountQuiz2: TEdit
            Left = 100
            Top = 230
            Width = 261
            Height = 23
            MaxLength = 20
            TabOrder = 7
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountAnswer2: TEdit
            Left = 100
            Top = 260
            Width = 261
            Height = 23
            MaxLength = 12
            TabOrder = 8
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountMobilePhone: TEdit
            Left = 100
            Top = 140
            Width = 151
            Height = 23
            MaxLength = 13
            TabOrder = 9
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountMemo1: TEdit
            Left = 340
            Top = 80
            Width = 251
            Height = 23
            MaxLength = 20
            TabOrder = 10
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountEMail: TEdit
            Left = 100
            Top = 290
            Width = 261
            Height = 23
            MaxLength = 40
            TabOrder = 11
            OnChange = EditLoginAccountChange
          end
          object EditLoginAccountMemo2: TEdit
            Left = 340
            Top = 110
            Width = 251
            Height = 23
            MaxLength = 20
            TabOrder = 12
            OnChange = EditLoginAccountChange
          end
          object CkFullEditMode: TCheckBox
            Left = 470
            Top = 20
            Width = 121
            Height = 21
            Caption = 'Full Edit'
            TabOrder = 13
            OnClick = CkFullEditModeClick
          end
          object ButtonLoginAccountOK: TButton
            Left = 510
            Top = 280
            Width = 81
            Height = 31
            Caption = 'OK(&O)'
            Enabled = False
            TabOrder = 14
            OnClick = ButtonLoginAccountOKClick
          end
          object EditLoginAccountPhone: TEdit
            Left = 100
            Top = 110
            Width = 151
            Height = 23
            MaxLength = 13
            TabOrder = 15
            OnChange = EditLoginAccountChange
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Server Controls'
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 600
        Top = 180
        Width = 361
        Height = 241
        TabOrder = 0
      end
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 642
        Height = 420
        ActivePage = TabSheet5
        Align = alClient
        TabOrder = 1
        TabPosition = tpBottom
        object TabSheet4: TTabSheet
          Caption = 'ServerDetails'
          object GroupBox1: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = 'Server Info'
            TabOrder = 0
            object Label1: TLabel
              Left = 10
              Top = 35
              Width = 88
              Height = 15
              Caption = 'Game Directory:'
            end
            object Label2: TLabel
              Left = 10
              Top = 65
              Width = 57
              Height = 15
              Caption = 'Database:'
            end
            object Label3: TLabel
              Left = 10
              Top = 95
              Width = 74
              Height = 15
              Caption = 'Game Name:'
            end
            object Label4: TLabel
              Left = 10
              Top = 125
              Width = 71
              Height = 15
              Caption = 'Ext Server IP:'
            end
            object EditGameDir: TEdit
              Left = 170
              Top = 30
              Width = 281
              Height = 23
              Hint = '???????????????'#8220'D:\GameOfmir\'#8221'?'
              TabOrder = 0
              Text = 'D:\GameOfMir\'
            end
            object Button1: TButton
              Left = 500
              Top = 25
              Width = 91
              Height = 31
              Caption = 'Browse&B)'
              TabOrder = 1
              Visible = False
            end
            object EditHeroDB: TEdit
              Left = 170
              Top = 60
              Width = 281
              Height = 23
              Hint = '????BDE ?????,??? '#8220'HeroDB'#8221'?'
              TabOrder = 2
              Text = 'HeroDB'
            end
            object EditGameName: TEdit
              Left = 170
              Top = 90
              Width = 201
              Height = 23
              Hint = '????????'
              TabOrder = 3
              Text = '????'
            end
            object EditGameExtIPaddr: TEdit
              Left = 170
              Top = 120
              Width = 121
              Height = 23
              Hint = '????????IP???'
              TabOrder = 4
              Text = '192.168.1.8'
            end
            object CheckBoxDynamicIPMode: TCheckBox
              Left = 300
              Top = 120
              Width = 101
              Height = 21
              Hint = '??IP????,??????IP????,??????,??????????IP,??????IP???'
              Caption = 'Allways use IP'
              TabOrder = 5
              OnClick = CheckBoxDynamicIPModeClick
            end
            object ButtonGeneralDefalult: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = 'Default(&D)'
              TabOrder = 6
              OnClick = ButtonGeneralDefalultClick
            end
          end
          object ButtonNext1: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Next(&N)'
            TabOrder = 1
            OnClick = ButtonNext1Click
          end
          object GroupBox4: TGroupBox
            Left = 10
            Top = 240
            Width = 351
            Height = 131
            Caption = 'RegServer'
            TabOrder = 2
            object Label7: TLabel
              Left = 10
              Top = 85
              Width = 109
              Height = 15
              Caption = 'Reg Key(DBServer):'
            end
            object Label6: TLabel
              Left = 10
              Top = 55
              Width = 106
              Height = 15
              Caption = 'Reg Key(RunGate):'
            end
            object Label5: TLabel
              Left = 10
              Top = 25
              Width = 108
              Height = 15
              Caption = 'Reg Key(M2Server):'
            end
            object EditM2ServerRegKey: TEdit
              Left = 140
              Top = 20
              Width = 111
              Height = 23
              Hint = '????????M2Server???,???????????????'
              TabOrder = 0
              Text = '0123456789'
            end
            object EditRunGateRegKey: TEdit
              Left = 140
              Top = 50
              Width = 111
              Height = 23
              Hint = '???????RunGate???,???????????????'
              TabOrder = 1
              Text = '0123456789'
            end
            object EditDBServerRegKey: TEdit
              Left = 140
              Top = 80
              Width = 111
              Height = 23
              Hint = '????????DBServer???,??????????????(?????????????????????)?'
              TabOrder = 2
              Text = '0123456789'
            end
            object ButtonAdv: TButton
              Left = 270
              Top = 80
              Width = 71
              Height = 31
              Caption = 'ADV(&A)'
              TabOrder = 3
              OnClick = ButtonAdvClick
            end
          end
          object ButtonReLoadConfig: TButton
            Left = 510
            Top = 279
            Width = 101
            Height = 41
            Caption = 'Reload(&R)'
            TabOrder = 3
            OnClick = ButtonReLoadConfigClick
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Login Gate'
          ImageIndex = 1
          object ButtonNext2: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = 'next(&N)'
            TabOrder = 0
            OnClick = ButtonNext2Click
          end
          object GroupBox2: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = 'LoginGate'
            TabOrder = 1
            object GroupBox7: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label9: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label10: TLabel
                Left = 10
                Top = 55
                Width = 24
                Height = 15
                Caption = '??Y:'
              end
              object EditLoginGate_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 24
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginGate_MainFormXChange
              end
              object EditLoginGate_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 24
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginGate_MainFormYChange
              end
            end
            object ButtonLoginGateDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = 'Default(&D)'
              TabOrder = 1
              OnClick = ButtonLoginGateDefaultClick
            end
            object GroupBox23: TGroupBox
              Left = 180
              Top = 20
              Width = 161
              Height = 61
              Caption = 'Port'
              TabOrder = 2
              object Label28: TLabel
                Left = 10
                Top = 25
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object EditLoginGate_GatePort: TEdit
                Left = 70
                Top = 20
                Width = 51
                Height = 23
                TabOrder = 0
                Text = '7000'
              end
            end
            object GroupBox27: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 51
              Caption = 'Logingate'
              TabOrder = 3
              object CheckBoxboLoginGate_GetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 121
                Height = 21
                Caption = 'Gate Start'
                TabOrder = 0
                OnClick = CheckBoxboLoginGate_GetStartClick
              end
            end
          end
          object ButtonPrv2: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Previous(&P)'
            TabOrder = 2
            OnClick = ButtonPrv2Click
          end
        end
        object TabSheet6: TTabSheet
          Caption = 'SelGate'
          ImageIndex = 2
          object GroupBox3: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = 'SelGate'
            TabOrder = 0
            object GroupBox8: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label11: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label12: TLabel
                Left = 10
                Top = 55
                Width = 24
                Height = 15
                Caption = '??Y:'
              end
              object EditSelGate_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 24
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditSelGate_MainFormXChange
              end
              object EditSelGate_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 24
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditSelGate_MainFormYChange
              end
            end
            object ButtonSelGateDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = 'Default(&D)'
              TabOrder = 1
              OnClick = ButtonSelGateDefaultClick
            end
            object GroupBox24: TGroupBox
              Left = 180
              Top = 20
              Width = 161
              Height = 91
              Caption = 'Ports'
              TabOrder = 2
              object Label29: TLabel
                Left = 10
                Top = 25
                Width = 51
                Height = 15
                Caption = 'GatePort:'
              end
              object Label49: TLabel
                Left = 10
                Top = 55
                Width = 51
                Height = 15
                Caption = 'GatePort:'
              end
              object EditSelGate_GatePort: TEdit
                Left = 70
                Top = 20
                Width = 51
                Height = 23
                TabOrder = 0
                Text = '7100'
              end
              object EditSelGate_GatePort1: TEdit
                Left = 70
                Top = 50
                Width = 51
                Height = 23
                TabOrder = 1
                Text = '7100'
              end
            end
            object GroupBox28: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 51
              Caption = 'Selgate'
              TabOrder = 3
              object CheckBoxboSelGate_GetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 121
                Height = 21
                Caption = 'SelGate Start'
                TabOrder = 0
                OnClick = CheckBoxboSelGate_GetStartClick
              end
            end
          end
          object ButtonPrv3: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Previous(&P)'
            TabOrder = 1
            OnClick = ButtonPrv3Click
          end
          object ButtonNext3: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Next(&N)'
            TabOrder = 2
            OnClick = ButtonNext3Click
          end
        end
        object TabSheet12: TTabSheet
          Caption = 'Rungate'
          ImageIndex = 8
          object ButtonPrv4: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Previous&P)'
            TabOrder = 0
            OnClick = ButtonPrv4Click
          end
          object ButtonNext4: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Next(&N)'
            TabOrder = 1
            OnClick = ButtonNext4Click
          end
          object GroupBox17: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = 'RunGate'
            TabOrder = 2
            object GroupBox18: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              Enabled = False
              TabOrder = 0
              object Label21: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
                Enabled = False
              end
              object Label22: TLabel
                Left = 10
                Top = 55
                Width = 24
                Height = 15
                Caption = '??Y:'
                Enabled = False
              end
              object EditRunGate_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 24
                Hint = '?????????????,??X?'
                Enabled = False
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
              end
              object EditRunGate_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 24
                Hint = '?????????????,??Y?'
                Enabled = False
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
              end
            end
            object GroupBox19: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 71
              Caption = 'RunGate'
              TabOrder = 1
              object Label23: TLabel
                Left = 10
                Top = 25
                Width = 17
                Height = 15
                Caption = '??:'
              end
              object EditRunGate_Connt: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 24
                Hint = '??????????,??200?????????,400?????????,400??????????'
                MaxValue = 8
                MinValue = 1
                TabOrder = 0
                Value = 1
                OnChange = EditRunGate_ConntChange
              end
            end
            object GroupBox22: TGroupBox
              Left = 180
              Top = 20
              Width = 261
              Height = 171
              Caption = 'Ports'
              TabOrder = 2
              object LabelRunGate_GatePort1: TLabel
                Left = 10
                Top = 25
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object LabelLabelRunGate_GatePort2: TLabel
                Left = 10
                Top = 55
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object LabelRunGate_GatePort3: TLabel
                Left = 2
                Top = 85
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object LabelRunGate_GatePort4: TLabel
                Left = 10
                Top = 115
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object LabelRunGate_GatePort5: TLabel
                Left = 10
                Top = 145
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object LabelRunGate_GatePort6: TLabel
                Left = 130
                Top = 25
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object LabelRunGate_GatePort7: TLabel
                Left = 130
                Top = 55
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object LabelRunGate_GatePort78: TLabel
                Left = 130
                Top = 85
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object EditRunGate_GatePort1: TEdit
                Left = 70
                Top = 20
                Width = 51
                Height = 23
                TabOrder = 0
                Text = '7200'
              end
              object EditRunGate_GatePort2: TEdit
                Left = 70
                Top = 50
                Width = 51
                Height = 23
                TabOrder = 1
                Text = '7200'
              end
              object EditRunGate_GatePort3: TEdit
                Left = 70
                Top = 80
                Width = 51
                Height = 23
                TabOrder = 2
                Text = '7200'
              end
              object EditRunGate_GatePort4: TEdit
                Left = 70
                Top = 110
                Width = 51
                Height = 23
                TabOrder = 3
                Text = '7200'
              end
              object EditRunGate_GatePort5: TEdit
                Left = 70
                Top = 140
                Width = 51
                Height = 23
                TabOrder = 4
                Text = '7200'
              end
              object EditRunGate_GatePort6: TEdit
                Left = 190
                Top = 20
                Width = 51
                Height = 23
                TabOrder = 5
                Text = '7200'
              end
              object EditRunGate_GatePort7: TEdit
                Left = 190
                Top = 50
                Width = 51
                Height = 23
                TabOrder = 6
                Text = '7200'
              end
              object EditRunGate_GatePort8: TEdit
                Left = 190
                Top = 80
                Width = 51
                Height = 23
                TabOrder = 7
                Text = '7200'
              end
            end
            object ButtonRunGateDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = 'Default(&D)'
              TabOrder = 3
              OnClick = ButtonRunGateDefaultClick
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'LoginServer'
          ImageIndex = 3
          object GroupBox9: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = 'Login Server'
            TabOrder = 0
            object GroupBox10: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label13: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label14: TLabel
                Left = 10
                Top = 55
                Width = 24
                Height = 15
                Caption = '??Y:'
              end
              object EditLoginServer_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 24
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginServer_MainFormXChange
              end
              object EditLoginServer_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 24
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginServer_MainFormYChange
              end
            end
            object ButtonLoginServerConfig: TButton
              Left = 390
              Top = 180
              Width = 101
              Height = 31
              Caption = 'Login Config'
              TabOrder = 1
              Visible = False
              OnClick = ButtonLoginServerConfigClick
            end
            object ButtonLoginSrvDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = 'Default(&D)'
              TabOrder = 2
              OnClick = ButtonLoginSrvDefaultClick
            end
            object GroupBox33: TGroupBox
              Left = 180
              Top = 20
              Width = 261
              Height = 91
              Caption = 'Ports'
              TabOrder = 3
              object Label50: TLabel
                Left = 10
                Top = 25
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object Label51: TLabel
                Left = 10
                Top = 55
                Width = 54
                Height = 15
                Caption = 'Gate Port:'
              end
              object EditLoginServerGatePort: TEdit
                Left = 80
                Top = 20
                Width = 51
                Height = 23
                TabOrder = 0
                Text = '7200'
              end
              object EditLoginServerServerPort: TEdit
                Left = 80
                Top = 50
                Width = 51
                Height = 23
                TabOrder = 1
                Text = '7200'
              end
            end
            object GroupBox34: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 51
              Caption = 'Login Server'
              TabOrder = 4
              object CheckBoxboLoginServer_GetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 131
                Height = 21
                Caption = 'Server Start'
                TabOrder = 0
                OnClick = CheckBoxboLoginServer_GetStartClick
              end
            end
          end
          object ButtonPrv5: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Previous(&P)'
            TabOrder = 1
            OnClick = ButtonPrv5Click
          end
          object ButtonNext5: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Next(&N)'
            TabOrder = 2
            OnClick = ButtonNext5Click
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'DB Server'
          ImageIndex = 4
          object GroupBox11: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = 'DBServer'
            TabOrder = 0
            object GroupBox12: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label15: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label16: TLabel
                Left = 10
                Top = 55
                Width = 24
                Height = 15
                Caption = '??Y:'
              end
              object EditDBServer_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 24
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditDBServer_MainFormXChange
              end
              object EditDBServer_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 24
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditDBServer_MainFormYChange
              end
            end
            object GroupBox20: TGroupBox
              Left = 180
              Top = 120
              Width = 161
              Height = 81
              Caption = 'Hum'
              TabOrder = 1
              object Label59: TLabel
                Left = 10
                Top = 45
                Width = 31
                Height = 15
                Caption = 'Time:'
              end
              object Label60: TLabel
                Left = 120
                Top = 45
                Width = 26
                Height = 15
                Caption = 'Mins'
              end
              object CheckBoxAutoBackupHumData: TCheckBox
                Left = 10
                Top = 20
                Width = 131
                Height = 21
                Caption = 'AutoBackup'
                TabOrder = 0
                OnClick = CheckBoxAutoBackupHumDataClick
              end
              object EditBackupTime: TSpinEdit
                Left = 50
                Top = 40
                Width = 61
                Height = 24
                MaxValue = 0
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditBackupTimeChange
              end
            end
            object ButtonDBServerDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = 'Default(&D)'
              TabOrder = 2
              OnClick = ButtonDBServerDefaultClick
            end
            object GroupBox35: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 51
              Caption = 'DBServer'
              TabOrder = 3
              object CheckBoxDBServerGetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 141
                Height = 21
                Caption = 'DBServer Start'
                TabOrder = 0
                OnClick = CheckBoxDBServerGetStartClick
              end
            end
            object GroupBox36: TGroupBox
              Left = 180
              Top = 20
              Width = 261
              Height = 91
              Caption = 'Ports'
              TabOrder = 4
              object Label52: TLabel
                Left = 10
                Top = 25
                Width = 51
                Height = 15
                Caption = 'GatePort:'
              end
              object Label53: TLabel
                Left = 10
                Top = 55
                Width = 63
                Height = 15
                Caption = 'Server Port:'
              end
              object EditDBServerGatePort: TEdit
                Left = 80
                Top = 20
                Width = 51
                Height = 23
                TabOrder = 0
                Text = '5100'
              end
              object EditDBServerServerPort: TEdit
                Left = 80
                Top = 50
                Width = 51
                Height = 23
                TabOrder = 1
                Text = '6000'
              end
            end
          end
          object ButtonPrv6: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Previous(&P)'
            TabOrder = 1
            OnClick = ButtonPrv6Click
          end
          object ButtonNext6: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Next(&N)'
            TabOrder = 2
            OnClick = ButtonNext6Click
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'LogServer'
          ImageIndex = 5
          object GroupBox13: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = 'LogServer'
            TabOrder = 0
            object GroupBox14: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label17: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label18: TLabel
                Left = 10
                Top = 55
                Width = 24
                Height = 15
                Caption = '??Y:'
              end
              object EditLogServer_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 24
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLogServer_MainFormXChange
              end
              object EditLogServer_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 24
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLogServer_MainFormYChange
              end
            end
            object ButtonLogServerDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = 'Default(&D)'
              TabOrder = 1
              OnClick = ButtonLogServerDefaultClick
            end
            object GroupBox37: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 51
              Caption = 'LogServer'
              TabOrder = 2
              object CheckBoxLogServerGetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 141
                Height = 21
                Caption = 'LogServer Start'
                TabOrder = 0
                OnClick = CheckBoxLogServerGetStartClick
              end
            end
            object GroupBox38: TGroupBox
              Left = 180
              Top = 20
              Width = 261
              Height = 91
              Caption = 'Port'
              TabOrder = 3
              object Label54: TLabel
                Left = 10
                Top = 25
                Width = 63
                Height = 15
                Caption = 'Server Port:'
              end
              object EditLogServerPort: TEdit
                Left = 80
                Top = 20
                Width = 51
                Height = 23
                TabOrder = 0
                Text = '10000'
              end
            end
          end
          object ButtonPrv7: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Previous(&P)'
            TabOrder = 1
            OnClick = ButtonPrv7Click
          end
          object ButtonNext7: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Next(&N)'
            TabOrder = 2
            OnClick = ButtonNext7Click
          end
        end
        object TabSheet10: TTabSheet
          Caption = 'M2 Server'
          ImageIndex = 6
          object GroupBox15: TGroupBox
            Left = 10
            Top = 10
            Width = 611
            Height = 221
            Caption = '?????????'
            TabOrder = 0
            object GroupBox16: TGroupBox
              Left = 10
              Top = 20
              Width = 161
              Height = 91
              Caption = '????'
              TabOrder = 0
              object Label19: TLabel
                Left = 10
                Top = 25
                Width = 24
                Height = 15
                Caption = '??X:'
              end
              object Label20: TLabel
                Left = 10
                Top = 55
                Width = 24
                Height = 15
                Caption = '??Y:'
              end
              object EditM2Server_MainFormX: TSpinEdit
                Left = 60
                Top = 20
                Width = 81
                Height = 24
                Hint = '?????????????,??X?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditM2Server_MainFormXChange
              end
              object EditM2Server_MainFormY: TSpinEdit
                Left = 60
                Top = 50
                Width = 81
                Height = 24
                Hint = '?????????????,??Y?'
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditM2Server_MainFormYChange
              end
            end
            object ButtonM2ServerDefault: TButton
              Left = 500
              Top = 180
              Width = 101
              Height = 31
              Caption = 'Default(&D)'
              TabOrder = 1
              OnClick = ButtonM2ServerDefaultClick
            end
            object GroupBox32: TGroupBox
              Left = 180
              Top = 120
              Width = 181
              Height = 91
              Caption = 'Test Info'
              TabOrder = 2
              object Label61: TLabel
                Left = 10
                Top = 25
                Width = 59
                Height = 15
                Caption = 'Test Level:'
              end
              object Label62: TLabel
                Left = 10
                Top = 55
                Width = 56
                Height = 15
                Caption = 'Test Gold:'
              end
              object EditM2Server_TestLevel: TSpinEdit
                Left = 85
                Top = 20
                Width = 86
                Height = 24
                Hint = '???????'
                MaxValue = 20000
                MinValue = 0
                TabOrder = 0
                Value = 10
                OnChange = EditM2Server_TestLevelChange
              end
              object EditM2Server_TestGold: TSpinEdit
                Left = 85
                Top = 50
                Width = 86
                Height = 24
                Hint = '????????????'
                Increment = 1000
                MaxValue = 20000000
                MinValue = 0
                TabOrder = 1
                Value = 10
                OnChange = EditM2Server_TestGoldChange
              end
            end
            object GroupBox39: TGroupBox
              Left = 180
              Top = 28
              Width = 261
              Height = 91
              Caption = '??'
              TabOrder = 3
              object Label55: TLabel
                Left = 10
                Top = 25
                Width = 56
                Height = 15
                Caption = 'Gate POrt:'
              end
              object Label56: TLabel
                Left = 10
                Top = 55
                Width = 51
                Height = 15
                Caption = 'Msg Port:'
              end
              object EditM2ServerGatePort: TEdit
                Left = 80
                Top = 20
                Width = 51
                Height = 23
                TabOrder = 0
                Text = '5000'
              end
              object EditM2ServerMsgSrvPort: TEdit
                Left = 80
                Top = 50
                Width = 51
                Height = 23
                TabOrder = 1
                Text = '4900'
              end
            end
            object GroupBox40: TGroupBox
              Left = 10
              Top = 120
              Width = 161
              Height = 51
              Caption = 'M2Server'
              TabOrder = 4
              object CheckBoxM2ServerGetStart: TCheckBox
                Left = 10
                Top = 20
                Width = 141
                Height = 21
                Caption = 'Start'
                TabOrder = 0
                OnClick = CheckBoxM2ServerGetStartClick
              end
            end
          end
          object ButtonPrv8: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Previous(&P)'
            TabOrder = 1
            OnClick = ButtonPrv8Click
          end
          object ButtonNext8: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Next(&N)'
            TabOrder = 2
            OnClick = ButtonNext8Click
          end
        end
        object TabSheet11: TTabSheet
          Caption = 'General Game Config'
          ImageIndex = 7
          object ButtonSave: TButton
            Left = 510
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Save(&S)'
            TabOrder = 0
            OnClick = ButtonSaveClick
          end
          object ButtonGenGameConfig: TButton
            Left = 290
            Top = 329
            Width = 101
            Height = 41
            Caption = 'GameConfig(&G)'
            TabOrder = 1
            OnClick = ButtonGenGameConfigClick
          end
          object ButtonPrv9: TButton
            Left = 400
            Top = 329
            Width = 101
            Height = 41
            Caption = 'Previous(&P)'
            TabOrder = 2
            OnClick = ButtonPrv9Click
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = '????'
      ImageIndex = 2
      object GroupBox6: TGroupBox
        Left = 10
        Top = 10
        Width = 311
        Height = 181
        Caption = '???'
        TabOrder = 0
        object Label8: TLabel
          Left = 10
          Top = 35
          Width = 31
          Height = 15
          Caption = '????:'
        end
        object EditSkin: TSpinEdit
          Left = 80
          Top = 30
          Width = 101
          Height = 24
          MaxValue = 0
          MinValue = -1
          TabOrder = 0
          Value = 0
          OnChange = EditSkinChange
        end
        object ButtonFormSave: TButton
          Left = 220
          Top = 140
          Width = 81
          Height = 31
          Caption = 'Save'
          TabOrder = 1
          OnClick = ButtonFormSaveClick
        end
      end
    end
    object TabSheet13: TTabSheet
      Caption = '????'
      ImageIndex = 3
    end
    object TabSheetDebug: TTabSheet
      Caption = 'Debug'
      ImageIndex = 6
      object GroupBox29: TGroupBox
        Left = 10
        Top = 0
        Width = 621
        Height = 411
        Caption = 'Codes'
        TabOrder = 0
        object GroupBox30: TGroupBox
          Left = 10
          Top = 20
          Width = 331
          Height = 141
          Caption = 'M2 Codes'
          TabOrder = 0
          object Label45: TLabel
            Left = 10
            Top = 25
            Width = 55
            Height = 15
            Caption = 'CodeAddr'
          end
          object Label46: TLabel
            Left = 10
            Top = 55
            Width = 30
            Height = 15
            Caption = 'Code'
          end
          object Label58: TLabel
            Left = 10
            Top = 85
            Width = 35
            Height = 15
            Caption = 'String:'
          end
          object EditM2CheckCodeAddr: TEdit
            Left = 70
            Top = 20
            Width = 121
            Height = 23
            TabOrder = 0
          end
          object EditM2CheckCode: TEdit
            Left = 70
            Top = 50
            Width = 121
            Height = 23
            TabOrder = 1
          end
          object ButtonM2Suspend: TButton
            Left = 240
            Top = 40
            Width = 81
            Height = 31
            Caption = 'M2Suspend'
            TabOrder = 2
            Visible = False
            OnClick = ButtonM2SuspendClick
          end
          object EditM2CheckStr: TEdit
            Left = 70
            Top = 80
            Width = 251
            Height = 23
            TabOrder = 3
          end
        end
        object GroupBox31: TGroupBox
          Left = 10
          Top = 170
          Width = 331
          Height = 131
          Caption = 'DB Codes'
          TabOrder = 1
          object Label47: TLabel
            Left = 10
            Top = 25
            Width = 55
            Height = 15
            Caption = 'CodeAddr'
          end
          object Label48: TLabel
            Left = 10
            Top = 55
            Width = 30
            Height = 15
            Caption = 'Code'
          end
          object Label57: TLabel
            Left = 10
            Top = 85
            Width = 32
            Height = 15
            Caption = 'String'
          end
          object EditDBCheckCodeAddr: TEdit
            Left = 70
            Top = 20
            Width = 121
            Height = 23
            TabOrder = 0
          end
          object EditDBCheckCode: TEdit
            Left = 70
            Top = 50
            Width = 121
            Height = 23
            TabOrder = 1
          end
          object Button3: TButton
            Left = 240
            Top = 40
            Width = 81
            Height = 31
            Caption = 'DB Suspend'
            TabOrder = 2
            Visible = False
            OnClick = ButtonM2SuspendClick
          end
          object EditDBCheckStr: TEdit
            Left = 70
            Top = 80
            Width = 251
            Height = 23
            TabOrder = 3
          end
        end
      end
    end
  end
  object TimerStartGame: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerStartGameTimer
    Left = 376
  end
  object TimerStopGame: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerStopGameTimer
    Left = 408
  end
  object TimerCheckRun: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TimerCheckRunTimer
    Left = 440
  end
  object ServerSocket: TServerSocket
    Active = False
    Address = '0.0.0.0'
    Port = 6350
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 504
    Top = 64
  end
  object Timer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerTimer
    Left = 504
    Top = 32
  end
  object TimerCheckDebug: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerCheckDebugTimer
    Left = 504
    Top = 96
  end
end
