unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
type
  TProgram = record
    boGetStart   :Boolean;
    boReStart    :Boolean; //程序异常停止，是否重新启动
    btStartStatus:Byte; //0,1,2,3 未启动，正在启动，已启动,正在关闭
    sProgramFile :String[50];
    sDirectory   :String[100];
    ProcessInfo  :TProcessInformation;
    ProcessHandle:THandle;
    MainFormHandle:THandle;
    nMainFormX     :Integer;
    nMainFormY     :Integer;
  end;
  pTProgram = ^TProgram;
type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MyMessage(var MsgData:TWmCopyData);message WM_COPYDATA;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function RunApp(AppName: string; I: Integer): Integer; //运行程序
var
  Sti: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillMemory(@Sti, SizeOf(Sti), 0);
  Sti.wShowWindow := I;
  Sti.dwFlags := STARTF_USEFILLATTRIBUTE;
  Sti.dwFillAttribute := FOREGROUND_INTENSITY or BACKGROUND_BLUE;
  if CreateProcess(PChar(AppName), nil,
    nil, nil, FALSE,
    0, nil, PChar(ExtractFilePath(AppName)),
    Sti, ProcessInfo) then begin
    Result := ProcessInfo.dwProcessId;
  end
  else
    Result := -1;
end;
function RunProgram(var ProgramInfo:TProgram;sHandle:String;dwWaitTime:LongWord):LongWord;
var
  StartupInfo:TStartupInfo;
  sCommandLine:String;
  sCurDirectory:String;
begin
  Result:=0;
  FillChar(StartupInfo,SizeOf(TStartupInfo),#0);
  {
  StartupInfo.cb:=SizeOf(TStartupInfo);
  StartupInfo.lpReserved:=nil;
  StartupInfo.lpDesktop:=nil;
  StartupInfo.lpTitle:=nil;
  StartupInfo.dwFillAttribute:=0;
  StartupInfo.cbReserved2:=0;
  StartupInfo.lpReserved2:=nil;
  }
  GetStartupInfo(StartupInfo);
  sCommandLine:=format('%s%s %s %d %d',[ProgramInfo.sDirectory,ProgramInfo.sProgramFile,sHandle,ProgramInfo.nMainFormX,ProgramInfo.nMainFormY]);
  sCurDirectory:=ProgramInfo.sDirectory;
  if not CreateProcess(nil,                //lpApplicationName,
                  PChar(sCommandLine),     //lpCommandLine,
                  nil,                     //lpProcessAttributes,
                  nil,                     //lpThreadAttributes,
                  True,                   //bInheritHandles,
                  0,                       //dwCreationFlags,
                  nil,                     //lpEnvironment,
                  PChar(sCurDirectory),    //lpCurrentDirectory,
                  StartupInfo,             //lpStartupInfo,
                  ProgramInfo.ProcessInfo) then begin //lpProcessInformation

    Result:=GetLastError();
  end;
  Sleep(dwWaitTime);
end;

procedure TForm1.MyMessage(var MsgData: TWmCopyData);
var
  sData:String;
  //ProgramType:TProgamType;
  wIdent:Word;
begin
  wIdent:=HiWord(MsgData.From);
  //ProgramType:=TProgamType(LoWord(MsgData.From));
  sData:=StrPas(MsgData.CopyDataStruct^.lpData);
  Memo1.Lines.Add('HiWord(MsgData.From): '+IntToStr(HiWord(MsgData.From))+' '+'LoWord(MsgData.From): '+IntToStr(LoWord(MsgData.From))+' '+'Data: '+sData);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  M2Server       :TProgram;
begin
  FillChar(M2Server,SizeOf(TProgram),#0);
  M2Server.boGetStart:=TRUE;
  M2Server.boReStart:=True;
  M2Server.sDirectory:=ExtractFilePath(ParamStr(0));
  M2Server.sProgramFile:=Edit1.Text;
  M2Server.nMainFormX:=Self.Top;
  M2Server.nMainFormY:=Self.Left;
  RunProgram(M2Server,IntToStr(Self.Handle),0);
  //RunApp(ExtractFilePath(ParamStr(0)) + Edit1.Text,1);
end;

end.
