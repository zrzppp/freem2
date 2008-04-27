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
  SVNRevision('$Id: DBPWDlg.pas 121 2006-08-06 01:10:41Z Dataforce $');
end.

