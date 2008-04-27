unit passwd;

interface

uses
  svn, Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;
type
  TPasswordDlg=class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
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


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: passwd.pas 121 2006-08-06 01:10:41Z Dataforce $');
end.
