object FrmMonSoc: TFrmMonSoc
  Left = 260
  Top = 103
  Width = 210
  Height = 163
  Caption = 'FrmMonSoc'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MonSocket: TServerSocket
    Active = False
    Address = '0.0.0.0'
    Port = 0
    ServerType = stNonBlocking
    OnClientError = MonSocketClientError
    Left = 64
    Top = 48
  end
  object MonTimer: TTimer
    Interval = 5000
    OnTimer = MonTimerTimer
    Left = 96
    Top = 48
  end
end
