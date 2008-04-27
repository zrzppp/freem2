object frmOnlineMsg: TfrmOnlineMsg
  Left = 292
  Top = 164
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #22312#32447#28040#24687
  ClientHeight = 343
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '??'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 169
    Width = 30
    Height = 12
    Caption = #20449#24687':'
  end
  object ComboBoxMsg: TComboBox
    Left = 56
    Top = 165
    Width = 381
    Height = 20
    Hint = 'Type message here to be sent then click send or add'
    Style = csSimple
    ItemHeight = 12
    TabOrder = 0
    OnChange = ComboBoxMsgChange
    OnKeyPress = ComboBoxMsgKeyPress
  end
  object MemoMsg: TMemo
    Left = 0
    Top = 0
    Width = 449
    Height = 153
    Hint = 'Sent messages'
    Align = alTop
    TabOrder = 1
    OnChange = MemoMsgChange
  end
  object StringGrid: TStringGrid
    Left = 0
    Top = 224
    Width = 449
    Height = 119
    Hint = 'Stored mesage list'
    Align = alBottom
    ColCount = 1
    DefaultColWidth = 430
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    ScrollBars = ssVertical
    TabOrder = 2
    OnClick = StringGridClick
    OnDblClick = StringGridDblClick
  end
  object ButtonAdd: TButton
    Left = 367
    Top = 191
    Width = 67
    Height = 23
    Hint = 'Adds the typed mesage to the stored message list'
    Caption = #28155#21152'(&A)'
    Enabled = False
    TabOrder = 3
    OnClick = ButtonAddClick
  end
  object ButtonDelete: TButton
    Left = 293
    Top = 191
    Width = 67
    Height = 23
    Hint = 'Deletes the selected message from the stored mesage list'
    Caption = #21024#38500'(&D)'
    Enabled = False
    TabOrder = 4
    OnClick = ButtonDeleteClick
  end
  object ButtonSend: TButton
    Left = 148
    Top = 190
    Width = 67
    Height = 23
    Hint = 'Will send message and display it ingame'
    Caption = #21457#36865'(&S)'
    TabOrder = 5
    OnClick = ButtonSendClick
  end
end
