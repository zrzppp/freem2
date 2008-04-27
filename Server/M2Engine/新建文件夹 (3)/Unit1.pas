unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EncryptUnit, StdCtrls;

type
  TIPAddr = record
    dIPaddr :String[15];
    sIPaddr :String[15];
  end;
  pTIPAddr =^TIPAddr;
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  IPAddr:TIPAddr=(dIPaddr:'127.0.0.1';sIPaddr:'192.168.0.1');
  IP,sip:TIPAddr;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit2.Text:=Base64EncodeStr(Edit1.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.Text:=Base64DecodeStr(Edit2.Text);
end;

end.
