program LogDataServer;

uses
  Forms,
  LogDataMain in 'LogDataMain.pas' {Form1},
  LDServer in 'LDServer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
