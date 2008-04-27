object frmCastleManage: TfrmCastleManage
  Left = 240
  Top = 384
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #22478#22561#31649#29702
  ClientHeight = 333
  ClientWidth = 683
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
  object GroupBox1: TGroupBox
    Left = 6
    Top = 6
    Width = 241
    Height = 321
    Caption = #22478#22561#21015#34920
    TabOrder = 0
    object ListViewCastle: TListView
      Left = 10
      Top = 20
      Width = 221
      Height = 291
      Hint = 'List of available castles'
      Columns = <
        item
          Caption = #24207#21495
          Width = 45
        end
        item
          Caption = #32534#21495
          Width = 45
        end
        item
          Caption = #21517#31216
          Width = 125
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewCastleClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 256
    Top = 6
    Width = 421
    Height = 321
    Caption = #22478#22561#20449#24687
    TabOrder = 1
    object PageControlCastle: TPageControl
      Left = 10
      Top = 20
      Width = 403
      Height = 291
      ActivePage = TabSheet1
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #22522#26412#29366#24577
        object GroupBox3: TGroupBox
          Left = 6
          Top = 14
          Width = 303
          Height = 115
          TabOrder = 0
          object Label2: TLabel
            Left = 10
            Top = 25
            Width = 54
            Height = 12
            Caption = #25152#23646#20844#20250':'
          end
          object Label1: TLabel
            Left = 10
            Top = 55
            Width = 54
            Height = 12
            Caption = #36164#37329#24635#25968':'
          end
          object Label3: TLabel
            Left = 10
            Top = 85
            Width = 54
            Height = 12
            Caption = #24403#22825#25910#20837':'
          end
          object Label7: TLabel
            Left = 174
            Top = 55
            Width = 54
            Height = 12
            Caption = #25216#26415#31561#32423':'
          end
          object Label8: TLabel
            Left = 174
            Top = 85
            Width = 30
            Height = 12
            Caption = #21147#37327':'
          end
          object EditOwenGuildName: TEdit
            Left = 68
            Top = 20
            Width = 169
            Height = 20
            Hint = 'Guild that owns the selected castle'
            TabOrder = 0
          end
          object EditTotalGold: TSpinEdit
            Left = 68
            Top = 50
            Width = 101
            Height = 21
            Hint = 'Total amount of gold stored in castle'
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 1
            Value = 0
          end
          object EditTodayIncome: TSpinEdit
            Left = 68
            Top = 80
            Width = 101
            Height = 21
            Hint = 'Total of income made today'
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 2
            Value = 0
          end
          object EditTechLevel: TSpinEdit
            Left = 230
            Top = 50
            Width = 61
            Height = 21
            Hint = 'Tech level of castle'
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 3
            Value = 0
          end
          object EditPower: TSpinEdit
            Left = 230
            Top = 80
            Width = 61
            Height = 21
            Hint = 'Castle power level'
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = #23432#21355#29366#24577
        ImageIndex = 2
        object GroupBox5: TGroupBox
          Left = 6
          Top = 0
          Width = 383
          Height = 251
          TabOrder = 0
          object ListViewGuard: TListView
            Left = 10
            Top = 16
            Width = 363
            Height = 181
            Columns = <
              item
                Caption = #24207#21495
                Width = 45
              end
              item
                Caption = #21517#31216
                Width = 80
              end
              item
                Caption = #24231#26631
                Width = 80
              end
              item
                Caption = #34880#37327
                Width = 75
              end
              item
                Caption = #29366#24577
                Width = 75
              end>
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
          object ButtonRefresh: TButton
            Left = 276
            Top = 210
            Width = 81
            Height = 31
            Caption = #21047#26032'(&R)'
            TabOrder = 1
            OnClick = ButtonRefreshClick
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #35774#32622
        ImageIndex = 1
        object GroupBox4: TGroupBox
          Left = 6
          Top = 6
          Width = 387
          Height = 112
          TabOrder = 0
          object Label4: TLabel
            Left = 10
            Top = 25
            Width = 30
            Height = 12
            Caption = 'lbl4:'
          end
          object Label5: TLabel
            Left = 10
            Top = 55
            Width = 30
            Height = 12
            Caption = 'lbl5:'
          end
          object Label6: TLabel
            Left = 210
            Top = 25
            Width = 18
            Height = 12
            Caption = 'l6:'
          end
          object Edit4: TEdit
            Left = 80
            Top = 20
            Width = 101
            Height = 20
            TabOrder = 0
            Text = 'Edit4'
          end
          object Edit5: TEdit
            Left = 80
            Top = 50
            Width = 101
            Height = 20
            TabOrder = 1
            Text = 'Edit5'
          end
          object Edit6: TEdit
            Left = 280
            Top = 20
            Width = 101
            Height = 20
            TabOrder = 2
            Text = 'Edit6'
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = #25915#22478#30003#35831
        ImageIndex = 3
      end
    end
  end
end
