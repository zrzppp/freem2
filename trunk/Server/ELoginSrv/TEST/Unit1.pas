unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grobal2, StdCtrls;
type
  TRecordHeader =   packed record
    boDeleted     :Boolean;
    bt1           :Byte;
    bt2           :Byte;
    bt3           :Byte;
    CreateDate    :TDateTime; //0x04
    UpdateDate    :TDateTime; //0x0C
    sAccount      :String[11];
  end;
  TAccountDBRecord = packed record
    Header       :TRecordHeader;
    UserEntry    :TUserEntry;
    UserEntryAdd :TUserEntryAdd;
    nErrorCount  :Integer;
    dwActionTick :LongWord;
    n            :array [0..38] of Byte;
  end;
type

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  m_sDBFileName:String='Id.DB';
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  m_nFileHandle, I:Integer;
  AccountDBRecord:TAccountDBRecord ;
  RecordHeader:TRecordHeader;
  UserEntry:TUserEntry;
  UserEntryAdd :TUserEntryAdd;
begin
  Showmessage('TRecordHeader:'+IntToStr(SizeOf(TRecordHeader)));
  Showmessage('TAccountDBRecord:'+IntToStr(SizeOf(TAccountDBRecord)));
    m_nFileHandle:=FileOpen(m_sDBFileName,fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then begin
      FileSeek(m_nFileHandle,124,0);
      FileRead(m_nFileHandle,AccountDBRecord,SizeOf(TAccountDBRecord));
      Edit1.Text:=AccountDBRecord.Header.sAccount;
      Edit2.Text:=DateTimeToStr(AccountDBRecord.Header.CreateDate);
      Edit3.Text:=DateTimeToStr(AccountDBRecord.Header.UpdateDate);
      //FileSeek(m_nFileHandle,124+SizeOf(TRecordHeader),0);
      //FileRead(m_nFileHandle,UserEntry,SizeOf(TUserEntry));
      with AccountDBRecord.UserEntry do begin
      Edit4.Text:=sAccount;
      Edit5.Text:=sPassword;
      Edit6.Text:=sUsername;
      Edit7.Text:=sSSNo;
      end;
       with AccountDBRecord.UserEntryAdd do begin
      //FileSeek(m_nFileHandle,124+SizeOf(TRecordHeader)+SizeOf(TUserEntry),0);
      //FileRead(m_nFileHandle,UserEntryAdd,SizeOf(TUserEntryAdd));
      Edit8.Text:=sQuiz2;
      Edit9.Text:=sAnswer2;
      Edit10.Text:=sBirthDay;
      Edit11.Text:=sMobilePhone;
      Edit12.Text:=sMemo;
      Edit13.Text:=sMemo2;
      end;
    end;
end;

end.
