unit SQLIDDB;

interface

uses
  Windows, SysUtils, Classes, Dialogs, Grobal2, MudUtil, DB, ADODB, ActiveX;

type
  TFileIDDB = class
  private
    ADOConnection     :TADOConnection;
    dbQry             :TADOQuery;

    m_boChanged       :Boolean;
    m_OnChange        :TNotifyEvent;
    m_QuickList       :TQuickList;
    nRecordCount      :Integer;

    FCriticalSection  :TRTLCriticalSection;
  private
    procedure LoadQuickList;
    function GetRecord(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
    function UpdateRecord(nIndex: integer; DBRecord: TAccountDBRecord; btFlag: Byte): boolean;

  public
    constructor Create(sSQL:String);
    destructor Destroy; override;

    procedure Lock;
    procedure UnLock;

    function Open: boolean;
    procedure Close;
    function Index(sName: string): integer;
    function Get(nIndex: integer; var DBRecord: TAccountDBRecord): integer;
    function FindByName(sName: string; var List: TStringList): integer;
    function GetBy(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
    function Update(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
    function Add(var DBRecord: TAccountDBRecord): boolean;
    function Delete(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
  end;

var
  AccountDB: TFileIDDB;

implementation

uses
  LSShare, HUtil32;

constructor TFileIDDB.Create(sSQL:String);
begin
  inherited Create;
  CoInitialize(nil);

  InitializeCriticalSection(FCriticalSection);

  m_QuickList    := TQuickList.Create;
  m_QuickList.boCaseSensitive := False;
  m_boChanged    := False;
  nRecordCount   := -1;
  g_n472A6C      := 0;
  g_n472A74      := 0;
  g_boDataDBReady := False;

  ADOConnection := TADOConnection.Create(nil);
  dbQry := TADOQuery.Create(nil);

  ADOConnection.ConnectionString := sSQL;
  ADOConnection.LoginPrompt := False;
  ADOConnection.KeepConnection := True;

  dbQry.Connection := ADOConnection;
  dbQry.Prepared := True;

  try
    ADOConnection.Connected := True;
    LoadQuickList;
  except
    MainOutMessage('[警告] Account数据库连接失败！请检查IDDB目录Account.mdb数据库是否正确。。。');
  end;
end;






destructor TFileIDDB.Destroy;
begin
  m_QuickList.Free;
  DeleteCriticalSection(FCriticalSection);

  dbQry.Free;
  ADOConnection.Free;

  CoUnInitialize;
  inherited;
end;

function TFileIDDB.Open: boolean;
begin
  Result := False;
  Lock();

  m_boChanged    := False;
  Result := True;
end;

procedure TFileIDDB.Close;
begin
  if m_boChanged and Assigned(m_OnChange) then begin
    m_OnChange(Self);
  end;

  UnLock();
end;






procedure TFileIDDB.LoadQuickList;
var
  nIndex:   integer;
  boDeleted :Boolean;
  sAccount  :String;
resourcestring
  sSQL = 'SELECT * FROM TBL_ACCOUNT';
begin
  nRecordCount := -1;
  g_n472A6C := 0;
  g_n472A70 := 0;
  g_n472A74 := 0;
  m_QuickList.Clear;

  Lock;
  try
    try
      dbQry.SQL.Clear;
      dbQry.SQL.Add(sSQL);
      try
        dbQry.Open;
      except
        MainOutMessage('[Exception] TFileIDDB.LoadQuickList');
      end;

      nRecordCount := dbQry.RecordCount;
      g_n472A74 := nRecordCount;
      for nIndex := 0 to nRecordCount - 1 do begin
        Inc(g_n472A6C);

        boDeleted   := dbQry.FieldByName('FLD_DELETED').AsBoolean;
        sAccount    := Trim(dbQry.FieldByName('FLD_LOGINID').AsString);

        if (not boDeleted) and (sAccount <> '') then begin
          m_QuickList.AddObject(sAccount, TObject(nIndex));
          Inc(g_n472A70);
        end;

        dbQry.Next;
      end;
    finally
      dbQry.Close;
    end;
  finally
    UnLock;
  end;

  m_QuickList.SortString(0, m_QuickList.Count - 1);
  g_boDataDBReady := True;
end;


procedure TFileIDDB.Lock;
begin
  EnterCriticalSection(FCriticalSection);
end;

procedure TFileIDDB.UnLock;
begin
  LeaveCriticalSection(FCriticalSection);
end;

function TFileIDDB.FindByName(sName: string; var List: TStringList): integer;
var
  I: integer;
begin
  for I := 0 to m_QuickList.Count - 1 do begin
    if CompareLStr(m_QuickList.Strings[I], sName, length(sName)) then begin
      List.AddObject(m_QuickList.Strings[I], m_QuickList.Objects[I]);
    end;
  end;
  Result := List.Count;
end;

function TFileIDDB.GetBy(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
begin
  if (nIndex >= 0) and (m_QuickList.Count > nIndex) then Result := GetRecord(nIndex, DBRecord)
  else
    Result := False;
end;

function TFileIDDB.GetRecord(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
var
  sAccount:String;
resourcestring
  sSQL = 'SELECT * FROM TBL_ACCOUNT WHERE FLD_LOGINID=''%s''';
  sSQL2 = 'SELECT * FROM TBL_ACCOUNTADD WHERE FLD_LOGINID=''%s''';
begin
  Result := True;
  sAccount := m_QuickList[nIndex];


  try
    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL, [sAccount]));
    try
      dbQry.Open;
    except
      Result := False;
      MainOutMessage('[Exception] TFileIDDB.GetRecord (1)');
      Exit;
    end;

    DBRecord.Header.sAccount      := Trim(dbQry.FieldByName('FLD_LOGINID').AsString);
    DBRecord.Header.sChrName      := '';
    DBRecord.Header.boDeleted     := dbQry.FieldByName('FLD_DELETED').AsBoolean;
    DBRecord.Header.CreateDate    := dbQry.FieldByName('FLD_CREATEDATE').AsDateTime;
    DBRecord.Header.UpdateDate    := dbQry.FieldByName('FLD_LASTUPDATE').AsDateTime;

    DBRecord.nErrorCount          := dbQry.FieldByName('FLD_ERRORCOUNT').AsInteger;
    DBRecord.dwActionTick         := dbQry.FieldByName('FLD_ACTIONTICK').AsInteger;

    DBRecord.UserEntry.sAccount   := Trim(dbQry.FieldByName('FLD_LOGINID').AsString);
    DBRecord.UserEntry.sPassword  := Trim(dbQry.FieldByName('FLD_PASSWORD').AsString);
    DBRecord.UserEntry.sUserName  := Trim(dbQry.FieldByName('FLD_USERNAME').AsString);

    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL2, [sAccount]));
    try
      dbQry.Open;
    except
      Result := False;
      MainOutMessage('[Exception] TFileIDDB.GetRecord (2)');
    end;

    DBRecord.UserEntry.sSSNo      := Trim(dbQry.FieldByName('FLD_SSNO').AsString);
    DBRecord.UserEntry.sPhone     := Trim(dbQry.FieldByName('FLD_PHONE').AsString);
    DBRecord.UserEntry.sQuiz      := Trim(dbQry.FieldByName('FLD_QUIZ1').AsString);
    DBRecord.UserEntry.sAnswer    := Trim(dbQry.FieldByName('FLD_ANSWER1').AsString);
    DBRecord.UserEntry.sEMail     := Trim(dbQry.FieldByName('FLD_EMAIL').AsString);
    //--------------------------------------------------------------------------------
    DBRecord.UserEntryAdd.sQuiz2  := Trim(dbQry.FieldByName('FLD_QUIZ2').AsString);
    DBRecord.UserEntryAdd.sAnswer2 := Trim(dbQry.FieldByName('FLD_ANSWER2').AsString);
    DBRecord.UserEntryAdd.sBirthDay := Trim(dbQry.FieldByName('FLD_BIRTHDAY').AsString);
    DBRecord.UserEntryAdd.sMobilePhone := Trim(dbQry.FieldByName('FLD_MOBILEPHONE').AsString);
    DBRecord.UserEntryAdd.sMemo   := Trim(dbQry.FieldByName('FLD_MEMO1').AsString);
    DBRecord.UserEntryAdd.sMemo2  := Trim(dbQry.FieldByName('FLD_MEMO2').AsString);
  finally
    dbQry.Close;
  end;
end;

function TFileIDDB.Index(sName: string): integer;
begin
  Result := m_QuickList.GetIndex(sName);
end;

function TFileIDDB.Get(nIndex: integer; var DBRecord: TAccountDBRecord): integer;
begin
  Result := -1;
  if nIndex < 0 then exit;
  if m_QuickList.Count <= nIndex then exit;
  if GetRecord(nIndex, DBRecord) then Result := nIndex
end;



function TFileIDDB.UpdateRecord(nIndex: integer; DBRecord: TAccountDBRecord; btFlag: Byte): boolean;
var
  sdt:String;
begin
  Result := True;
  sdt := FormatDateTime('mm"/"dd"/"yyyy hh":"nn":"ss', Now);

  try
    dbQry.SQL.Clear;

    case btFlag of
      1: begin // New
        dbQry.SQL.Add(format('INSERT INTO TBL_ACCOUNT(FLD_LOGINID, FLD_PASSWORD, FLD_USERNAME, FLD_CREATEDATE, FLD_LASTUPDATE, FLD_DELETED) '+
				                     'VALUES( ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', 0 )',
                             [DBRecord.UserEntry.sAccount,
                             DBRecord.UserEntry.sPassword,
                             DBRecord.UserEntry.sUserName,
                             sdt,
                             sdt]));

        try
          dbQry.ExecSQL;
        except
          Result := False;
          MainOutMessage('[Exception] TFileIDDB.UpdateRecord (1)');
          Exit;
        end;

        dbQry.SQL.Clear;
        dbQry.SQL.Add(format('INSERT INTO TBL_ACCOUNTADD(FLD_LOGINID, FLD_SSNO, FLD_BIRTHDAY, '+
									           'FLD_PHONE, FLD_MOBILEPHONE, FLD_EMAIL, FLD_QUIZ1, FLD_ANSWER1, FLD_QUIZ2, FLD_ANSWER2) '+
                             'VALUES( ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'' )',
                             [DBRecord.UserEntry.sAccount,
                             DBRecord.UserEntry.sSSNo,
                             DBRecord.UserEntryAdd.sBirthDay,
                             DBRecord.UserEntry.sPhone,
                             DBRecord.UserEntryAdd.sMobilePhone,
                             DBRecord.UserEntry.sEMail,
                             DBRecord.UserEntry.sQuiz,
                             DBRecord.UserEntry.sAnswer,
                             DBRecord.UserEntryAdd.sQuiz2,
                             DBRecord.UserEntryAdd.sAnswer2]));

        try
          dbQry.ExecSQL;
        except
          Result := False;
          MainOutMessage('[Exception] TFileIDDB.UpdateRecord (2)');
        end;
      end;

      2: begin // Delete
        dbQry.SQL.Add(format('UPDATE TBL_ACCOUNT SET FLD_DELETED=1, FLD_CREATEDATE=''%s'' '+
                             'WHERE FLD_LOGINID=''%s''',
                             [sdt,
                             DBRecord.UserEntry.sAccount]));

        try
          dbQry.ExecSQL;
        except
          Result := False;
          MainOutMessage('[Exception] TFileIDDB.UpdateRecord (3)');
        end;
      end;
      else begin //General Update
        dbQry.SQL.Add(format('UPDATE TBL_ACCOUNT SET FLD_PASSWORD=''%s'', FLD_USERNAME=''%s'', '+
                             'FLD_LASTUPDATE=''%s'', FLD_ERRORCOUNT=%d, FLD_ACTIONTICK=%d WHERE FLD_LOGINID=''%s''',
                             [DBRecord.UserEntry.sPassword,
                             DBRecord.UserEntry.sUserName,
                             sdt,
                             DBRecord.nErrorCount,
                             DBRecord.dwActionTick,
                             DBRecord.UserEntry.sAccount]));

        try
          dbQry.ExecSQL;
        except
          Result := False;
          MainOutMessage('[Exception] TFileIDDB.UpdateRecord (4)');
          Exit;
        end;

        dbQry.SQL.Clear;
        dbQry.SQL.Add(format('UPDATE TBL_ACCOUNTADD SET FLD_SSNO=''%s'', FLD_BIRTHDAY=''%s'', FLD_PHONE=''%s'', '+
                             'FLD_MOBILEPHONE=''%s'', FLD_EMAIL=''%s'', FLD_QUIZ1=''%s'', FLD_ANSWER1=''%s'', FLD_QUIZ2=''%s'', '+
                             'FLD_ANSWER2=''%s'', FLD_MEMO1=''%s'', FLD_MEMO2=''%s'' WHERE FLD_LOGINID=''%s''',
                             [DBRecord.UserEntry.sSSNo,
                             DBRecord.UserEntryAdd.sBirthDay,
                             DBRecord.UserEntry.sPhone,
                             DBRecord.UserEntryAdd.sMobilePhone,
                             DBRecord.UserEntry.sEMail,
                             DBRecord.UserEntry.sQuiz,
                             DBRecord.UserEntry.sAnswer,
                             DBRecord.UserEntryAdd.sQuiz2,
                             DBRecord.UserEntryAdd.sAnswer2,
                             DBRecord.UserEntryAdd.sMemo,
                             DBRecord.UserEntryAdd.sMemo2,
                             DBRecord.UserEntry.sAccount]));

        try
          dbQry.ExecSQL;
        except
          Result := False;
          MainOutMessage('[Exception] TFileIDDB.UpdateRecord (5)');
        end;
      end;
    end;

    m_boChanged := True;
  finally
    dbQry.Close;
  end;
end;

function TFileIDDB.Update(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
begin
  Result := False;
  if nIndex < 0 then exit;
  if m_QuickList.Count <= nIndex then exit;
  if UpdateRecord(nIndex, DBRecord, 0) then
    Result := True;
end;


function TFileIDDB.Add(var DBRecord: TAccountDBRecord): boolean;
var
  sAccount: string;
  nIndex: integer;
begin
  sAccount := DBRecord.UserEntry.sAccount;
  if m_QuickList.GetIndex(sAccount) >= 0 then begin
    Result := False;
  end else begin
    nIndex := nRecordCount;
    Inc(nRecordCount);

    if UpdateRecord(nIndex, DBRecord, 1) then begin
      m_QuickList.AddRecord(sAccount, nIndex);
      Result := True;
    end else begin
      Result   := False;
    end;
  end;
end;


function TFileIDDB.Delete(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
begin
  Result := False;
  if nIndex < 0 then exit;
  if m_QuickList.Count <= nIndex then exit;
  if UpdateRecord(nIndex, DBRecord, 2) then begin
    m_QuickList.Delete(nIndex);
    Result := True;
  end;
end;

end.
