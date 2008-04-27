unit DataManage;

interface

uses
  svn, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,HumDB;

type
  TfrmDataManage = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    m_FileDB    :TFileDB;
    m_FileHumDB :TFileHumDB;
    procedure Open();
    { Public declarations }
  end;

var
  frmDataManage: TfrmDataManage;

implementation

{$R *.dfm}

{ TfrmDataManage }


procedure TfrmDataManage.FormCreate(Sender: TObject);
begin
  m_FileDB    :=nil;
  m_FileHumDB :=nil;
end;

procedure TfrmDataManage.FormDestroy(Sender: TObject);
begin
//
end;


procedure TfrmDataManage.Open;
begin
  ShowModal;
end;


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: DataManage.pas 121 2006-08-06 01:10:41Z Dataforce $');
end.
