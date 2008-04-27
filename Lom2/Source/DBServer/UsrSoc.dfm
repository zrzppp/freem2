object FrmUserSoc: TFrmUserSoc
  Left = 453
  Top = 112
  Width = 157
  Height = 140
  Caption = 'FrmUserSoc'
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
  object UserSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = UserSocketClientConnect
    OnClientDisconnect = UserSocketClientDisconnect
    OnClientRead = UserSocketClientRead
    OnClientError = UserSocketClientError
    Left = 28
    Top = 32
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 72
    Top = 32
  end
end
