unit DBPWDlg;

interface

uses
  svn, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TPasswordDialog = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    GroupBox1: TGroupBox;
    Edit: TEdit;
    AddButton: TButton;
    RemoveButton: TButton;
    RemoveAllButton: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasswordDialog: TPasswordDialog;

implementation

{$R *.dfm}

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: DBPWDlg.pas 327 2006-08-24 20:30:52Z Dataforce $');
end.
