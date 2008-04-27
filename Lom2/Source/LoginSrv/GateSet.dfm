object FrmGateSetting: TFrmGateSetting
  Left = 247
  Top = 41
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #32593#20851#36335#30001#37197#32622
  ClientHeight = 348
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object BtnOk: TBitBtn
    Left = 64
    Top = 320
    Width = 105
    Height = 25
    Hint = #23558#32593#20851#36335#30001#35774#32622#20445#23384#21040#37197#32622#25991#20214#20013#12290
    Caption = #20445#23384'(&S)'
    TabOrder = 0
    OnClick = BtnOkClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BtnClose: TBitBtn
    Left = 336
    Top = 320
    Width = 75
    Height = 25
    Hint = #36864#20986#32593#20851#36335#30001#37197#32622
    Caption = #30830#23450'(&O)'
    ModalResult = 1
    TabOrder = 1
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 152
    Width = 433
    Height = 161
    Caption = #35282#33394#32593#20851#35774#32622
    TabOrder = 2
    object Label5: TLabel
      Left = 32
      Top = 16
      Width = 54
      Height = 12
      Caption = #35282#33394#32593#20851':'
    end
    object Label6: TLabel
      Left = 168
      Top = 16
      Width = 48
      Height = 12
      Caption = #26159#21542#21551#29992
    end
    object Label7: TLabel
      Left = 240
      Top = 16
      Width = 54
      Height = 12
      Caption = #35282#33394#32593#20851':'
    end
    object Label8: TLabel
      Left = 376
      Top = 16
      Width = 48
      Height = 12
      Caption = #26159#21542#21551#29992
    end
    object Label9: TLabel
      Left = 15
      Top = 36
      Width = 6
      Height = 12
      Caption = '1'
    end
    object Label10: TLabel
      Left = 15
      Top = 60
      Width = 6
      Height = 12
      Caption = '2'
    end
    object Label11: TLabel
      Left = 15
      Top = 84
      Width = 6
      Height = 12
      Caption = '3'
    end
    object Label12: TLabel
      Left = 15
      Top = 108
      Width = 6
      Height = 12
      Caption = '4'
    end
    object Label13: TLabel
      Left = 15
      Top = 132
      Width = 6
      Height = 12
      Caption = '5'
    end
    object Label14: TLabel
      Left = 223
      Top = 36
      Width = 6
      Height = 12
      Caption = '6'
    end
    object Label15: TLabel
      Left = 223
      Top = 60
      Width = 6
      Height = 12
      Caption = '7'
    end
    object Label16: TLabel
      Left = 223
      Top = 84
      Width = 6
      Height = 12
      Caption = '8'
    end
    object Label17: TLabel
      Left = 223
      Top = 108
      Width = 6
      Height = 12
      Caption = '9'
    end
    object Label18: TLabel
      Left = 223
      Top = 132
      Width = 12
      Height = 12
      Caption = '10'
    end
    object CkGate1: TCheckBox
      Left = 184
      Top = 32
      Width = 15
      Height = 17
      Caption = 'CkGate1'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object EdGate1: TEdit
      Left = 32
      Top = 32
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 1
      Text = '210.121.143.202'
    end
    object CkGate2: TCheckBox
      Left = 184
      Top = 56
      Width = 15
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object EdGate2: TEdit
      Left = 32
      Top = 56
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 3
      Text = '210.121.143.203'
    end
    object CkGate3: TCheckBox
      Left = 184
      Top = 80
      Width = 15
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object EdGate3: TEdit
      Left = 32
      Top = 80
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 5
      Text = '210.121.143.203'
    end
    object CkGate4: TCheckBox
      Left = 184
      Top = 104
      Width = 15
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object EdGate4: TEdit
      Left = 32
      Top = 104
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 7
      Text = '210.121.143.203'
    end
    object CkGate5: TCheckBox
      Left = 184
      Top = 128
      Width = 15
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object EdGate5: TEdit
      Left = 32
      Top = 128
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 9
      Text = '210.121.143.203'
    end
    object CkGate6: TCheckBox
      Left = 392
      Top = 32
      Width = 15
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object EdGate6: TEdit
      Left = 240
      Top = 32
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 11
      Text = '210.121.143.203'
    end
    object CkGate7: TCheckBox
      Left = 392
      Top = 56
      Width = 15
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object EdGate7: TEdit
      Left = 240
      Top = 56
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 13
      Text = '210.121.143.203'
    end
    object CkGate8: TCheckBox
      Left = 392
      Top = 80
      Width = 15
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 14
    end
    object EdGate8: TEdit
      Left = 240
      Top = 80
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 15
      Text = '210.121.143.203'
    end
    object CkGate9: TCheckBox
      Left = 392
      Top = 104
      Width = 15
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 16
    end
    object EdGate9: TEdit
      Left = 240
      Top = 104
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 17
      Text = '210.121.143.203'
    end
    object CkGate10: TCheckBox
      Left = 392
      Top = 128
      Width = 15
      Height = 17
      Caption = 'CheckBox1'
      Checked = True
      State = cbChecked
      TabOrder = 18
    end
    object EdGate10: TEdit
      Left = 240
      Top = 128
      Width = 137
      Height = 20
      Hint = #35282#33394#36873#25321#32593#20851'IP'#65292#21450#31471#21475#12290
      TabOrder = 19
      Text = '210.121.143.203'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 88
    Width = 433
    Height = 57
    Caption = #30331#24405#32593#20851#20449#24687
    TabOrder = 3
    object Label4: TLabel
      Left = 200
      Top = 28
      Width = 54
      Height = 12
      Caption = #22806#37096#22320#22336':'
    end
    object Label3: TLabel
      Left = 8
      Top = 28
      Width = 54
      Height = 12
      Caption = #20869#37096#22320#22336':'
    end
    object EdPublicAddr: TEdit
      Left = 256
      Top = 24
      Width = 121
      Height = 20
      Hint = #30331#24405#32593#20851#23545#22806#26381#21153#30340'IP'#22320#22336#12290
      TabOrder = 0
      Text = '210.121.143.202'
    end
    object EdPrivateAddr: TEdit
      Left = 72
      Top = 24
      Width = 121
      Height = 20
      Hint = #30331#24405#32593#20851#36830#25509#21040#30331#24405#26381#21153#22120'IP'#22320#22336#12290
      TabOrder = 1
      Text = '5.5.2.1'
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 433
    Height = 73
    Caption = #32593#20851#36335#30001#26631#35782
    TabOrder = 4
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 54
      Height = 12
      Caption = #36335#30001#26631#35782':'
    end
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 54
      Height = 12
      Caption = #26381#21153#22120#21517':'
    end
    object BtnChangeTitle: TSpeedButton
      Left = 368
      Top = 40
      Width = 57
      Height = 22
      Caption = #20462#25913'(&M)'
      OnClick = BtnChangeTitleClick
    end
    object CbGateList: TComboBox
      Left = 72
      Top = 40
      Width = 161
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 0
      OnChange = CbGateListChange
    end
    object CbServerList: TComboBox
      Left = 72
      Top = 16
      Width = 161
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 1
      OnChange = CbServerListChange
    end
    object EdTitle: TEdit
      Left = 240
      Top = 40
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object UseRanPass: TCheckBox
      Left = 240
      Top = 16
      Width = 161
      Height = 17
      Caption = #21551#29992#30331#38470#38543#26426#23494#30721#39564#35777
      TabOrder = 3
    end
  end
end
