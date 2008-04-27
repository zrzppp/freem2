object FrmAccServer: TFrmAccServer
  Left = 453
  Top = 112
  Width = 207
  Height = 145
  Caption = 'FrmAccServer'
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
  object SServer: TServerSocket
    Active = False
    Port = 3100
    ServerType = stNonBlocking
    Left = 28
    Top = 16
  end
  object DecodeTimer: TTimer
    Interval = 1
    OnTimer = DecodeTimerTimer
    Left = 64
    Top = 16
  end
  object TimeOutTimer: TTimer
    OnTimer = TimeOutTimerTimer
    Left = 96
    Top = 16
  end
  object CheckTimeoutTimer: TTimer
    Enabled = False
    OnTimer = CheckTimeoutTimerTimer
    Left = 64
    Top = 52
  end
end
