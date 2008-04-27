object FrmIDSoc: TFrmIDSoc
  Left = 239
  Top = 94
  Width = 169
  Height = 160
  Caption = 'FrmIDSoc'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object IDSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnRead = IDSocketRead
    OnError = IDSocketError
    Left = 44
    Top = 40
  end
  object Timer1: TTimer
    Interval = 30000
    OnTimer = Timer1Timer
    Left = 80
    Top = 40
  end
  object KeepAliveTimer: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = KeepAliveTimerTimer
    Left = 80
    Top = 64
  end
end
