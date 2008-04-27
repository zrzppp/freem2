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
  SVNRevision('$Id: DBLogDlg.pas 327 2006-08-24 20:30:52Z Dataforce $');
end.
