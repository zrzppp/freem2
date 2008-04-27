unit frmcpyrcd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons;

type
  TFrmCopyRcd = class(TForm)
    Edit1:    TEdit;
    Edit2:    TEdit;
    BitBtn1:  TBitBtn;
    BitBtn2:  TBitBtn;
    Label1:   TLabel;
    Label2:   TLabel;
    Label3:   TLabel;
    EdWithID: TEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    sSrcCharName, sDestCharName, sUserID: string;
    function sub_49C09C(): boolean;
    { Public declarations }
  end;

var
  FrmCopyRcd: TFrmCopyRcd;

implementation

{$R *.DFM}

procedure TFrmCopyRcd.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

function TFrmCopyRcd.sub_49C09C: boolean;
  //0x0049C09C
begin
  sSrcCharName := '';
  sDestCharName := '';
  sUserID := '';
  Edit1.Text := sSrcCharName;
  Edit2.Text := sDestCharName;
  if Self.ShowModal = mrOk then begin
    sSrcCharName   := Trim(Edit1.Text);
    sDestCharName   := Trim(Edit2.Text);
    sUserID   := Trim(EdWithID.Text);
    Result := True;
  end else
    Result := False;
end;

end.
