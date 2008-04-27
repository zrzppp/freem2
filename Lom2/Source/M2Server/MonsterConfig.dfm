object frmMonsterConfig: TfrmMonsterConfig
  Left = 227
  Top = 251
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #24618#29289#35774#32622
  ClientHeight = 209
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 4
    Top = 4
    Width = 317
    Height = 201
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412#21442#25968
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 293
        Height = 157
        TabOrder = 0
        object GroupBox8: TGroupBox
          Left = 8
          Top = 16
          Width = 153
          Height = 77
          Caption = #37329#24065#29190#29575#35774#32622
          TabOrder = 0
          object Label23: TLabel
            Left = 11
            Top = 24
            Width = 42
            Height = 12
            Caption = #26368#22823#20540':'
          end
          object EditMonOneDropGoldCount: TSpinEdit
            Left = 56
            Top = 20
            Width = 77
            Height = 21
            Hint = 
              'The maximum gold that will drop from a mob in one pile before cr' +
              'eating a new one'
            MaxValue = 99999999
            MinValue = 1
            TabOrder = 0
            Value = 5000
            OnChange = EditMonOneDropGoldCountChange
          end
          object CheckBoxDropGoldToPlayBag: TCheckBox
            Left = 12
            Top = 48
            Width = 117
            Height = 17
            Caption = #37329#24065#30452#25509#20837#32972#21253
            TabOrder = 1
            OnClick = CheckBoxDropGoldToPlayBagClick
          end
        end
        object ButtonGeneralSave: TButton
          Left = 192
          Top = 117
          Width = 65
          Height = 25
          Hint = 'Save settings'
          Caption = #20445#23384'(&S)'
          TabOrder = 1
          OnClick = ButtonGeneralSaveClick
        end
      end
    end
  end
end
