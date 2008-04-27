object FrmNewChr: TFrmNewChr
  Left = 205
  Top = 259
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'New Character'
  ClientHeight = 74
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False  
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 9
    Top = 9
    Width = 35
    Height = 14
    Caption = 'Name:'
  end
  object EdName: TEdit
    Left = 9
    Top = 33
    Width = 151
    Height = 22
    TabOrder = 0
  end
  object Button1: TButton
    Left = 177
    Top = 28
    Width = 88
    Height = 29
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
end
