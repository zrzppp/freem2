object frmTestSelGate: TfrmTestSelGate
  Left = 281
  Top = 272
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gate tester'
  ClientHeight = 150
  ClientWidth = 261
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 10
    Top = 10
    Width = 241
    Height = 131
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 25
      Width = 66
      Height = 15
      Caption = 'Select Gate:'
    end
    object Label2: TLabel
      Left = 10
      Top = 55
      Width = 66
      Height = 15
      Caption = 'Game Gate:'
    end
    object EditSelGate: TEdit
      Left = 104
      Top = 20
      Width = 117
      Height = 23
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object EditGameGate: TEdit
      Left = 104
      Top = 50
      Width = 117
      Height = 23
      TabOrder = 1
    end
    object ButtonTest: TButton
      Left = 20
      Top = 90
      Width = 81
      Height = 31
      Caption = '&Test'
      TabOrder = 2
      OnClick = ButtonTestClick
    end
    object Button1: TButton
      Left = 140
      Top = 90
      Width = 81
      Height = 31
      Caption = '&Change'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
end
