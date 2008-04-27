unit newchr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
  TFrmNewChr = class(TForm)
    EdName:  TEdit;
    Button1: TButton;
    Label1:  TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdNameKeyPress(Sender: TObject; var Key: Char);
  private

  public
    function sub_49BD60(var sChrName: string): boolean;

  end;

var
  FrmNewChr: TFrmNewChr;

implementation

{$R *.DFM}

procedure TFrmNewChr.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmNewChr.FormShow(Sender: TObject);
begin
  EdName.SetFocus;
end;

procedure TFrmNewChr.EdNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then exit;
  Button1.Click;
end;

function TFrmNewChr.sub_49BD60(var sChrName: string): boolean;
begin
  Result      := False;
  EdName.Text := '';
  Self.ShowModal;
  sChrName := Trim(EdName.Text);
  if sChrName <> '' then Result := True;
end;

end.
