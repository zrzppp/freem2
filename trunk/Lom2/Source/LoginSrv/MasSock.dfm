object FrmMasSoc: TFrmMasSoc
  Left = 870
  Top = 367
  Width = 153
  Height = 146
  Caption = 'FrmMasSoc'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MSocket: TServerSocket
    Active = False
    Address = '0.0.0.0'
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = MSocketClientConnect
    OnClientDisconnect = MSocketClientDisconnect
    OnClientRead = MSocketClientRead
    OnClientError = MSocketClientError
    Left = 40
    Top = 32
  end
end
