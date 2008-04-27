unit FSMemo;

interface

uses
  svn, Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons;
type
  TFrmSysMemo=class(TForm)
    EdMemo: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end ;

var
  FrmSysMemo: TFrmSysMemo;

implementation

{$R *.DFM}


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: FSMemo.pas 121 2006-08-06 01:10:41Z Dataforce $');
end.
