unit FrmInID;

interface

uses
  svn, Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons;
type
  TFrmInputID=class(TForm)
    Label1: TLabel;
    EdID: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end ;

var
  FrmInputID: TFrmInputID;

implementation

{$R *.DFM}


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: FrmInID.pas 121 2006-08-06 01:10:41Z Dataforce $');
end.