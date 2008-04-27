unit qrfilename;

interface

uses
  svn, Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons;
type
  TFrmQueryFileName=class(TForm)
    EdFileName: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end ;

var
  FrmQueryFileName: TFrmQueryFileName;

implementation

{$R *.DFM}


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: qrfilename.pas 121 2006-08-06 01:10:41Z Dataforce $');
end.
