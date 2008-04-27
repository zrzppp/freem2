unit WebForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OleCtrls, SHDocVw, MShare;

type
  TForm1 = class(TForm)
    DelTimer: TTimer;
    WebBrowser: TWebBrowser;
    procedure DelTimerTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BackImgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BackImgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses FState, ClMain;

{$R *.dfm}

procedure TForm1.Open;
begin
  Show;
end;

procedure TForm1.DelTimerTimer(Sender: TObject);
begin
  Self.ParentWindow:=FrmMain.Handle;
  WebBrowser.Navigate('http://www.lom2.net/');
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
//
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
//
end;

procedure TForm1.BackImgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TForm1.BackImgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//
end;

procedure TForm1.ImgCloseClick(Sender: TObject);
begin
//
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//
end;

end.
