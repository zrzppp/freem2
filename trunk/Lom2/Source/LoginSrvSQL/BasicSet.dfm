object FrmBasicSet: TFrmBasicSet
  Left = 570
  Top = 319
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 241
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 417
    Height = 193
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #26222#36890#35774#32622
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 73
        Caption = #21151#33021#35774#32622
        TabOrder = 0
        object CheckBoxTestServer: TCheckBox
          Left = 16
          Top = 16
          Width = 97
          Height = 17
          Caption = #27979#35797#27169#24335
          TabOrder = 0
          OnClick = CheckBoxTestServerClick
        end
        object CheckBoxEnableMakingID: TCheckBox
          Left = 16
          Top = 32
          Width = 97
          Height = 17
          Caption = #20801#35768#21019#24314#36134#21495
          TabOrder = 1
          OnClick = CheckBoxEnableMakingIDClick
        end
        object CheckBoxEnableGetbackPassword: TCheckBox
          Left = 16
          Top = 48
          Width = 97
          Height = 17
          Caption = #20801#35768#21462#22238#23494#30721
          Enabled = False
          TabOrder = 2
        end
      end
      object GroupBox2: TGroupBox
        Left = 200
        Top = 8
        Width = 201
        Height = 73
        Caption = #28165#29702#36134#21495#35774#32622
        TabOrder = 1
        object Label1: TLabel
          Left = 16
          Top = 40
          Width = 54
          Height = 12
          Caption = #28165#29702#38388#38548':'
        end
        object Label2: TLabel
          Left = 144
          Top = 40
          Width = 12
          Height = 12
          Caption = #31186
        end
        object CheckBoxAutoClear: TCheckBox
          Left = 16
          Top = 16
          Width = 97
          Height = 17
          Caption = #33258#21160#28165#29702#36134#21495
          Enabled = False
          TabOrder = 0
        end
        object SpinEditAutoClearTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 65
          Height = 21
          Enabled = False
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 1
        end
      end
      object ButtonRestoreBasic: TButton
        Left = 336
        Top = 136
        Width = 67
        Height = 25
        Caption = #40664#35748'(&D)'
        Enabled = False
        TabOrder = 2
        OnClick = ButtonRestoreBasicClick
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 88
        Width = 177
        Height = 65
        Caption = #33258#21160#35299#38500#38145#23450#36134#21495
        TabOrder = 3
        object Label9: TLabel
          Left = 8
          Top = 40
          Width = 78
          Height = 12
          Caption = #35299#38500#31561#24453#26102#38388':'
        end
        object Label10: TLabel
          Left = 160
          Top = 40
          Width = 12
          Height = 12
          Caption = #20998
        end
        object CheckBoxAutoUnLockAccount: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Caption = #33258#21160#35299#38500#38145#23450#36134#21495
          Enabled = False
          TabOrder = 0
        end
        object SpinEditUnLockAccountTime: TSpinEdit
          Left = 88
          Top = 36
          Width = 65
          Height = 21
          Enabled = False
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 1
        end
      end
      object CheckBoxMinimize: TCheckBox
        Left = 200
        Top = 136
        Width = 121
        Height = 17
        Caption = #21551#21160#25104#21151#21518#26368#23567#21270
        TabOrder = 4
      end
      object GroupBox8: TGroupBox
        Left = 200
        Top = 88
        Width = 153
        Height = 41
        Caption = #39564#35777#30721#35774#32622
        TabOrder = 5
        object Label12: TLabel
          Left = 160
          Top = 40
          Width = 12
          Height = 12
          Caption = #20998
        end
        object CheckBoxRandomCode: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Hint = #38656#35201#36755#20837#27491#30830#30340#39564#35777#30721#65292#25165#33021#27880#20876#36134#21495#65281#24320#21551#21518#38656#35201#26377#39564#35777#30721#21151#33021#30340#30331#38470#22120#37197#21512#20351#29992#65292#21542#21017#29992#25143#26080#27861#27491#24120#27880#20876#36134#21495#12290
          Caption = #24320#21551#39564#35777#30721#31995#32479
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #32593#32476#35774#32622
      ImageIndex = 1
      object ButtonRestoreNet: TButton
        Left = 320
        Top = 136
        Width = 67
        Height = 25
        Caption = #40664#35748'(&D)'
        TabOrder = 0
        OnClick = ButtonRestoreNetClick
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 185
        Height = 65
        Caption = #32593#20851#35774#32622
        TabOrder = 1
        object Label3: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #32465#23450#22320#22336':'
        end
        object Label4: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #32593#20851#31471#21475':'
        end
        object EditGateAddr: TEdit
          Left = 72
          Top = 14
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditGateAddrChange
        end
        object EditGatePort: TEdit
          Left = 72
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditGatePortChange
        end
      end
      object GroupBox4: TGroupBox
        Left = 208
        Top = 8
        Width = 185
        Height = 65
        Caption = #36828#31243#30417#25511#35774#32622
        TabOrder = 2
        object Label5: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #32465#23450#22320#22336':'
        end
        object Label6: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #32593#20851#31471#21475':'
        end
        object EditMonAddr: TEdit
          Left = 72
          Top = 14
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditMonAddrChange
        end
        object EditMonPort: TEdit
          Left = 72
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditMonPortChange
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 88
        Width = 185
        Height = 65
        Caption = #26381#21153#22120#32593#32476#35774#32622
        TabOrder = 3
        object Label7: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #32465#23450#22320#22336':'
        end
        object Label8: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20351#29992#31471#21475':'
        end
        object EditServerAddr: TEdit
          Left = 72
          Top = 14
          Width = 105
          Height = 20
          TabOrder = 0
          OnChange = EditServerAddrChange
        end
        object EditServerPort: TEdit
          Left = 72
          Top = 38
          Width = 57
          Height = 20
          TabOrder = 1
          OnChange = EditServerPortChange
        end
      end
      object GroupBox6: TGroupBox
        Left = 208
        Top = 88
        Width = 113
        Height = 41
        Caption = #21160#24577#22495#21517#27169#24335
        TabOrder = 4
        object CheckBoxDynamicIPMode: TCheckBox
          Left = 16
          Top = 16
          Width = 73
          Height = 17
          Caption = #21160#24577#22495#21517
          TabOrder = 0
          OnClick = CheckBoxDynamicIPModeClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25968#25454#24211#35774#32622
      ImageIndex = 2
      object Label11: TLabel
        Left = 24
        Top = 144
        Width = 324
        Height = 12
        Caption = #27880#24847#65306#20462#25913#25968#25454#24211#36830#25509#35774#32622#65292#24517#39035#37325#26032#21551#21160#31243#24207#21518#25165#21487#29983#25928#65281
        Color = clBtnFace
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object GroupBox9: TGroupBox
        Left = 16
        Top = 8
        Width = 241
        Height = 129
        Caption = 'MSSQL'#25968#25454#24211#36830#25509
        TabOrder = 0
        object Label13: TLabel
          Left = 16
          Top = 28
          Width = 78
          Height = 12
          Caption = 'SQL'#25968#25454#24211#22320#22336
        end
        object Label14: TLabel
          Left = 16
          Top = 52
          Width = 66
          Height = 12
          Caption = 'SQL'#25968#25454#24211#21517
        end
        object Label15: TLabel
          Left = 16
          Top = 76
          Width = 66
          Height = 12
          Caption = 'SQL'#36830#25509#24080#21495
        end
        object Label16: TLabel
          Left = 16
          Top = 100
          Width = 66
          Height = 12
          Caption = 'SQL'#36830#25509#23494#30721
        end
        object EditSQLHost: TEdit
          Left = 104
          Top = 24
          Width = 121
          Height = 20
          Hint = #22914#26524'MSSQL'#35013#22312#26412#26426#36890#24120#20026'(local),'#25968#25454#24211#35013#13#10#22312#20854#20182#26426#22120#35831#36755#20837#20854#20182#26426#22120#30340'IP'#22320#22336#12290
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = EditSQLHostChange
        end
        object EditSQLDatabase: TEdit
          Left = 104
          Top = 48
          Width = 121
          Height = 20
          Hint = #40664#35748#25968#25454#24211#20026'Account'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnChange = EditSQLDatabaseChange
        end
        object EditSQLUsername: TEdit
          Left = 104
          Top = 72
          Width = 121
          Height = 20
          Hint = #35831#36755#20837#20320#30340'SQL'#24080#21495#65292#40664#35748#20026'sa.'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnChange = EditSQLUsernameChange
        end
        object EditSQLPassword: TEdit
          Left = 104
          Top = 96
          Width = 121
          Height = 20
          Hint = #35831#36755#20837'SQL'#36830#25509#23494#30721
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnChange = EditSQLPasswordChange
        end
      end
    end
  end
  object ButtonSave: TButton
    Left = 248
    Top = 208
    Width = 75
    Height = 25
    Caption = #20445#23384'(&S)'
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 334
    Top = 208
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    TabOrder = 2
    OnClick = ButtonCloseClick
  end
end
