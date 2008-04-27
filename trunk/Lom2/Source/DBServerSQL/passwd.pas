unit passwd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
  TPasswordDlg = class(TForm)
    Label1:    TLabel;
    Password:  TEdit;
    OKBtn:     TButton;
    CancelBtn: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasswordDlg: TPasswordDlg;


implementation

{$R *.DFM}

end.
