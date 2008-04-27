object FrmFeeUtil: TFrmFeeUtil
  Left = 193
  Top = 228
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Account Fee Utility'
  ClientHeight = 431
  ClientWidth = 989
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 989
    Height = 105
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object Label1: TLabel
      Left = 14
      Top = 55
      Width = 83
      Height = 15
      Caption = 'Login / Account'
    end
    object Label2: TLabel
      Left = 13
      Top = 13
      Width = 97
      Height = 15
      Caption = 'Player / Character'
    end
    object Label3: TLabel
      Left = 1043
      Top = 13
      Width = 3
      Height = 15
      Caption = ' '
    end
    object BtnConvert: TSpeedButton
      Left = 840
      Top = 47
      Width = 138
      Height = 26
      Caption = 'Data Convert'
      OnClick = BtnConvertClick
    end
    object BtnFindId: TSpeedButton
      Left = 359
      Top = 49
      Width = 90
      Height = 34
      Caption = 'Search ID'
      OnClick = BtnFindIDClick
    end
    object BtnFindIdAll: TSpeedButton
      Left = 455
      Top = 49
      Width = 138
      Height = 34
      Caption = 'Search All ID(F6)'
    end
    object BtnFindGroup: TSpeedButton
      Left = 359
      Top = 6
      Width = 90
      Height = 34
      Caption = 'Search Players'
    end
    object BtnFindPCAll: TSpeedButton
      Left = 455
      Top = 6
      Width = 138
      Height = 34
      Caption = 'Search All Players(F5)'
    end
    object BtnAddRcd: TSpeedButton
      Left = 609
      Top = 6
      Width = 98
      Height = 33
      Caption = 'Add Record(Ins)'
    end
    object BtnDelRcd: TSpeedButton
      Left = 721
      Top = 6
      Width = 124
      Height = 33
      Caption = 'Save(C+Del)'
    end
    object BtnChangeRcd: TSpeedButton
      Left = 851
      Top = 6
      Width = 124
      Height = 33
      Caption = 'Change(C+Ent)'
    end
    object BtnBack: TSpeedButton
      Left = 613
      Top = 46
      Width = 88
      Height = 34
      Caption = 'Back(F4)'
      OnClick = BtnBackClick
    end
    object LbPlus: TLabel
      Left = 775
      Top = 45
      Width = 14
      Height = 34
      Caption = '0'
      Font.Charset = HANGEUL_CHARSET
      Font.Color = clWindowText
      Font.Height = -25
      Font.Name = '??'
      Font.Style = []
      ParentFont = False
    end
    object EdFindID: TEdit
      Left = 120
      Top = 49
      Width = 221
      Height = 23
      ImeName = '???(??) (MS-IME95)'
      TabOrder = 1
    end
    object EdFindPC: TEdit
      Left = 120
      Top = 6
      Width = 221
      Height = 23
      ImeName = '???(??) (MS-IME95)'
      TabOrder = 0
    end
  end
  object FGrid: TStringGrid
    Left = 0
    Top = 105
    Width = 989
    Height = 326
    Align = alClient
    ColCount = 10
    DefaultRowHeight = 18
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goColSizing, goThumbTracking]
    TabOrder = 1
    ColWidths = (
      12
      107
      161
      51
      55
      34
      63
      37
      64
      138)
  end
  object OpenDialog1: TOpenDialog
    Left = 576
    Top = 64
  end
end
