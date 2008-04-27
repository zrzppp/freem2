unit ConfigMonGen;

interface

uses
  svn, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmConfigMonGen = class(TForm)
    GroupBox1: TGroupBox;
    ListBoxMonGen: TListBox;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmConfigMonGen: TfrmConfigMonGen;

implementation

uses UsrEngn, M2Share, Grobal2, LocalDB;

{$R *.dfm}

{ TfrmConfigMonGen }

procedure TfrmConfigMonGen.Open;
var
  I: Integer;
  MonGen:pTMonGenInfo;
begin
  for I := 0 to UserEngine.m_MonGenList.Count - 1 do begin
    MonGen:=UserEngine.m_MonGenList.Items[I];
    ListBoxMonGen.Items.AddObject(MonGen.sMapName + '(' + IntToStr(MonGen.nX) + ':' + IntToStr(MonGen.nY) + ')' + ' - ' + MonGen.sMonName,TObject(MonGen));
  end;
  Self.ShowModal;
end;

{---- Adjust global SVN revision ----}
procedure TfrmConfigMonGen.Button2Click(Sender: TObject);
var
  I: Integer;
  Monster: pTMonInfo;
begin
  try
    for I := 0 to UserEngine.MonsterList.Count - 1 do begin
      Monster := UserEngine.MonsterList.Items[I];
      FrmDB.LoadMonitems(Monster.sName, Monster.ItemList);
    end;
    MainOutMessage('怪物爆物品列表重加载完成...');
  except
    MainOutMessage('怪物爆物品列表重加载失败！！！');
  end;
end;

procedure TfrmConfigMonGen.ListBox1Click(Sender: TObject);
var
  LoadList		: TStringList;
  I			      : Integer;
  LineText		: String;
  sMonGenFile	: String;
begin
  Memo1.Clear;
  sMonGenFile:=g_Config.sEnvirDir + 'MonItems\' + ListBox1.Items.Strings [ListBox1.ItemIndex];
  if FileExists(sMonGenFile) then begin
    LoadList:=TStringList.Create;
    LoadList.LoadFromFile(sMonGenFile);
    for I := 0 to LoadList.Count - 1 do begin
      LineText:=LoadList.Strings[I];
      if (LineText = '') or (LineText[1] = ';') then Continue;
      Memo1.Lines.Add(LineText);
    end;
  end;
//   LoadList.Free;
end;

procedure TfrmConfigMonGen.Button4Click(Sender: TObject);
var
  sr:TSearchRec;
begin
  listbox1.Items.Clear;
  if   FindFirst('.\Envir\MonItems'+'\*.*',   faAnyFile,   sr)   =   0   then
  begin
  if (sr.Name <> '.') and (sr.Name <> '..') then listbox1.Items.Add(sr.Name);
  while   FindNext(sr)   =   0   do
  if (sr.Name <> '.') and (sr.Name <> '..') then listbox1.Items.Add(sr.name);
    FindClose(SR);
  end;
end;

procedure TfrmConfigMonGen.Button3Click(Sender: TObject);
var
  LoadList		: TStringList;
    i       :Integer;
      sMonGenFile	: String;
begin
    sMonGenFile:=g_Config.sEnvirDir + 'MonItems\' + ListBox1.Items.Strings [ListBox1.ItemIndex];
    LoadList:=TStringList.Create;
    for i:=0 to  Memo1.Lines.Count - 1 do begin
      LoadList.Add(Memo1.Lines.Strings[i]);
    end;
    LoadList.SaveToFile(sMonGenFile);
    LoadList.free;
end;


procedure TfrmConfigMonGen.FormCreate(Sender: TObject);
var
  sr:TSearchRec;
begin
  listbox1.Items.Clear;
  if   FindFirst('.\Envir\MonItems'+'\*.*',   faAnyFile,   sr)   =   0   then
  begin
  if (sr.Name <> '.') and (sr.Name <> '..') then listbox1.Items.Add(sr.Name);
  while   FindNext(sr)   =   0   do
  if (sr.Name <> '.') and (sr.Name <> '..') then listbox1.Items.Add(sr.name);
    FindClose(SR);
  end;
end;

initialization
  SVNRevision('$Id: ConfigMonGen.pas 327 2006-08-24 20:30:52Z Dataforce $');
end.
