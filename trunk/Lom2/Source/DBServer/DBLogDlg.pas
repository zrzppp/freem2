unit DBLogDlg;

interface

uses
  svn, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TLoginDialog = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    Panel: TPanel;
    Label3: TLabel;
    DatabaseName: TLabel;
    Bevel: TBevel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    UserName: TEdit;
    Password: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginDialog: TLoginDialog;

implementation

{$R *.dfm}


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: DBLogDlg.pas 121 2006-08-06 01:10:41Z Dataforce $');
end.
