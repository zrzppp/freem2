unit GuildManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmGuildManage = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  frmGuildManage: TfrmGuildManage;

implementation

{$R *.dfm}

procedure TfrmGuildManage.Open();
begin
  Show;
end;

end.
