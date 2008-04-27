unit HumDB;

interface

uses
  Windows, Classes, Dialogs, SysUtils, Forms, MudUtil, Grobal2, ActiveX,
  DB, DBAccess, MSAccess, MemDS, MemData;

const
  SQLDTFORMAT = 'mm"/"dd"/"yyyy hh":"nn":"ss';

resourcestring
  sDBHeaderDesc    = 'Lom II Database file 2005/04/20';
  sDBIdxHeaderDesc = 'Lom II Index file 2005/04/20';

type
  pTDBHeader = ^TDBHeader;
  TDBHeader = record
    sDesc: string[35];       //0x00
    n24:   integer;          //0x24
    n28:   integer;          //0x28
    n2C:   integer;          //0x2C
    n30:   integer;          //0x30
    n34:   integer;          //0x34
    n38:   integer;          //0x38
    n3C:   integer;          //0x3C
    n40:   integer;          //0x40
    n44:   integer;          //0x44
    n48:   integer;          //0x48
    n4C:   integer;          //0x4C
    n50:   integer;          //0x50
    n54:   integer;          //0x54
    n58:   integer;          //0x58
    nLastIndex: integer;     //0x5C
    dLastDate: TDateTime;    //0x60
    nHumCount: integer;      //0x68
    n6C:   integer;          //0x6C
    n70:   integer;          //0x70
    dUpdateDate: TDateTime;  //0x74
  end;

  TIdxHeader = record
    sDesc: string[40];        //0x00
    n2C:   integer;           //0x2C
    n30:   integer;           //0x30
    n34:   integer;           //0x34
    n38:   integer;           //0x38
    n3C:   integer;           //0x3C
    n40:   integer;           //0x40
    n44:   integer;           //0x44
    n48:   integer;           //0x48
    n4C:   integer;           //0x4C
    n50:   integer;           //0x50
    n54:   integer;           //0x54
    n58:   integer;           //0x58
    n5C:   integer;           //0x5C
    n60:   integer;           //0x60
    nQuickCount: integer;     //0x64
    nHumCount: integer;       //0x68
    nDeleteCount: integer;    //0x6C
    nLastIndex: integer;      //0x70
    dUpdateDate: TDateTime;   //0x74
  end;

  pTIdxRecord = ^TIdxRecord;
  TIdxRecord = record
    sChrName: string[15];
    nIndex:   integer;
  end;


  TFileHumDB = class
    m_nCurIndex: integer;      //0x04
    m_nFileHandle: integer;      //0x08
    n0C: integer;      //0x0C
    m_OnChange: TNotifyEvent;

    m_boChanged:   boolean;      //0x18
    m_Header:      TDBHeader;    //0x1C
    m_QuickList:   TQuickList;   //0x98
    m_QuickIDList: TQuickIDList; //0x9C
    m_DeletedList: TList;        //0xA0 已被删除的记录号
    m_sDBFileName: string;       //0xA4
  private
    procedure LoadQuickList;
    procedure Lock;
    procedure UnLock;
    function UpdateRecord(nIndex: integer; HumRecord: THumInfo; boNew: boolean): boolean;
    function DeleteRecord(nIndex: integer): boolean;
    function GetRecord(nIndex: integer; var HumDBRecord: THumInfo): boolean;
  public
    constructor Create(sFileName: string);
    destructor Destroy; override;

    function Open(): boolean;
    function OpenEx(): boolean;
    procedure Close();
    function Index(sName: string): integer;
    function Get(nIndex: integer; var HumDBRecord: THumInfo): integer;
    function GetBy(nIndex: integer; var HumDBRecord: THumInfo): boolean;
    function FindByName(sChrName: string; ChrList: TStringList): integer;
    function FindByAccount(sAccount: string; var ChrList: TStringList): integer;
    function ChrCountOfAccount(sAccount: string): integer;
    function Add(HumRecord: THumInfo): boolean;
    function Delete(sName: string): boolean;
    function Update(nIndex: integer; var HumDBRecord: THumInfo): boolean;
    function UpdateBy(nIndex: integer; var HumDBRecord: THumInfo): boolean;
  end;

  TFileDB = class
    m_OnChange        :TNotifyEvent;       //0x10
    m_boChanged       :Boolean;           //0x18

    m_QuickList       :TQuickList;        //0xA4

    m_sDBFileName     :String;          //0xAC
    m_sIdxFileName    :String;         //0xB0

    nRecordCount      :Integer;
  private
    procedure LoadQuickList;
    function GetRecord(nIndex: integer; var HumanRCD: THumDataInfo): boolean;
    function UpdateRecord(nIndex: integer; var HumanRCD: THumDataInfo; boNew: boolean): boolean;
    function DeleteRecord(nIndex: integer): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
    function Open: boolean;
    procedure Close;
    function Index(sName: string): integer;
    function Get(nIndex: integer; var HumanRCD: THumDataInfo): integer;
    function GetQryChar(nIndex: integer; var QueryChrRcd: TQueryChr): integer;
    function GetUserCurMap(nIndex: integer): String;
    function Update(nIndex: integer; var HumanRCD: THumDataInfo): boolean;
    function Add(var HumanRCD: THumDataInfo): boolean;
    function Find(sChrName: string; List: TStrings): integer;
    procedure Rebuild();
    function Count(): integer;
    function Delete(sChrName: string): boolean; overload;
    function Delete(nIndex: integer): boolean; overload;
  end;

  function InitializeSQL:Boolean;

var
  ADOConnection     :TMSConnection;
  dbQry             :TMSQuery;
  g_boSQLIsReady    :Boolean = False;

  HumChrDB          :TFileHumDB;
  HumDataDB         :TFileDB;

implementation

uses
  DBShare, HUtil32;

function InitializeSQL:Boolean;
begin
  Result := False;
  if g_boSQLIsReady then exit;

  ADOConnection.Database := g_sSQLDatabase;
  ADOConnection.Server := g_sSQLHost;
  ADOConnection.UserName := g_sSQLUserName;
  ADOConnection.Password := g_sSQLPassword;

  ADOConnection.LoginPrompt := False;

  dbQry.Connection := ADOConnection;

  try
    ADOConnection.Connect;
    g_boSQLIsReady := True;
  except
    OutMainMessage('[警告] SQL连接失败! => 请详细检查!');
    Result := False;
    Exit;
  end;

  Result := True;
end;

{ TFileHumDB }

constructor TFileHumDB.Create(sFileName: string);//0x0048B73C
begin
  m_sDBFileName := sFileName;
  m_QuickList  := TQuickList.Create;
  m_QuickIDList := TQuickIDList.Create;
  m_DeletedList := TList.Create;
  n4ADAFC      := 0;
  n4ADB04      := 0;
  boHumDBReady := False;
  LoadQuickList();
end;

destructor TFileHumDB.Destroy;
begin
  m_QuickList.Free;
  m_QuickIDList.Free;
  inherited;
end;

procedure TFileHumDB.Lock();//0x0048B870
begin
  EnterCriticalSection(HumDB_CS);
end;

procedure TFileHumDB.UnLock();//0x0048B888
begin
  LeaveCriticalSection(HumDB_CS);
end;

procedure TFileHumDB.LoadQuickList();
//0x48BA64
var
  nRecordIndex: integer;
  nIndex:      integer;
  AccountList: TStringList;
  ChrNameList: TStringList;
  DBHeader:    TDBHeader;
  DBRecord:    THumInfo;
begin
  m_nCurIndex := 0;
  m_QuickList.Clear;
  m_QuickIDList.Clear;
  m_DeletedList.Clear;
  nRecordIndex := 0;
  n4ADAFC      := 0;
  n4ADB00      := 0;
  n4ADB04      := 0;
  AccountList  := TStringList.Create;
  ChrNameList  := TStringList.Create;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      begin
        n4ADB04 := DBHeader.nHumCount;
        for nIndex := 0 to DBHeader.nHumCount - 1 do begin
          Inc(n4ADAFC);
          if FileRead(m_nFileHandle, DBRecord, SizeOf(THumInfo)) <> SizeOf(THumInfo) then
          begin
            break;
          end;
          if not DBRecord.Header.boDeleted then begin
            m_QuickList.AddObject(DBRecord.Header.sChrName, TObject(nRecordIndex));
            AccountList.AddObject(DBRecord.sAccount, TObject(DBRecord.Header.nSelectID));
            ChrNameList.AddObject(DBRecord.sChrName, TObject(nRecordIndex));
            Inc(n4ADB00);
          end else begin //0x0048BC04
            m_DeletedList.Add(TObject(nIndex));
          end;
          Inc(nRecordIndex);
          Application.ProcessMessages;
          if Application.Terminated then begin
            Close;
            exit;
          end;
        end;
      end; //0x0048BC52
    end;
  finally
    Close();
  end;
  for nIndex := 0 to AccountList.Count - 1 do begin
    m_QuickIDList.AddRecord(AccountList.Strings[nIndex],
      ChrNameList.Strings[nIndex],
      integer(ChrNameList.Objects[nIndex]),
      integer(AccountList.Objects[nIndex]));
    if (nIndex mod 100) = 0 then Application.ProcessMessages;
  end;
  //0x0048BCF4
  AccountList.Free;
  ChrNameList.Free;
  m_QuickList.SortString(0, m_QuickList.Count - 1);
  boHumDBReady := True;
end;

procedure TFileHumDB.Close;//0x0048BA24
begin
  FileClose(m_nFileHandle);
  if m_boChanged and Assigned(m_OnChange) then begin
    m_OnChange(Self);
  end;
  UnLock();
end;

function TFileHumDB.Open: boolean;//0x0048B928
begin
  Lock();
  m_nCurIndex := 0;
  m_boChanged := False;
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader));
  end else begin //0x0048B999
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      FillChar(m_Header, SizeOf(TDBHeader), #0);
      m_Header.sDesc := sDBHeaderDesc;
      m_Header.nHumCount := 0;
      m_Header.n6C := 0;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    end;
  end;
  if m_nFileHandle > 0 then Result := True
  else
    Result := False;
end;

function TFileHumDB.OpenEx: boolean;//0x0048B8A0
var
  DBHeader: TDBHeader;
begin
  Lock();
  m_boChanged   := False;
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := True;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      m_Header := DBHeader;
    m_nCurIndex := 0;
  end else
    Result := False;
end;

function TFileHumDB.Index(sName: string): integer;//0x0048C384
begin
  Result := m_QuickList.GetIndex(sName);
end;

function TFileHumDB.Get(nIndex: integer; var HumDBRecord: THumInfo): integer;//0x0048C0CC
var
  nResult: integer;
begin
  nResult := integer(m_QuickList.Objects[nIndex]);
  if GetRecord(nIndex, HumDBRecord) then Result := nResult
  else
    Result := -1;
end;

function TFileHumDB.GetRecord(nIndex: integer; var HumDBRecord: THumInfo): boolean;
  //0x0048BEEC
begin
  if FileSeek(m_nFileHandle, SizeOf(THumInfo) * nIndex + SizeOf(TDBHeader), 0) <> -1 then
  begin
    FileRead(m_nFileHandle, HumDBRecord, SizeOf(THumInfo));
    FileSeek(m_nFileHandle, -SizeOf(THumInfo) * nIndex + SizeOf(TDBHeader), 1);
    m_nCurIndex := nIndex;
    Result      := True;
  end else
    Result := False;
end;

function TFileHumDB.FindByName(sChrName: string; ChrList: TStringList): integer;
  //0x0048C3E0
var
  I: integer;
begin
  for I := 0 to m_QuickList.Count - 1 do begin
    if CompareLStr(m_QuickList.Strings[I], sChrName, length(sChrName)) then begin
      ChrList.AddObject(m_QuickList.Strings[I], m_QuickList.Objects[I]);
    end;
  end;
  Result := ChrList.Count;
end;

function TFileHumDB.GetBy(nIndex: integer; var HumDBRecord: THumInfo): boolean;
  //0x0048C118
begin
  if nIndex >= 0 then Result := GetRecord(nIndex, HumDBRecord)
  else
    Result := False;
end;

function TFileHumDB.FindByAccount(sAccount: string; var ChrList: TStringList): integer;
  //0x0048C4DC
var
  ChrNameList: TList;
  QuickID: pTQuickID;
  i: integer;
begin
  ChrNameList := nil;
  m_QuickIDList.GetChrList(sAccount, ChrNameList);
  if ChrNameList <> nil then begin
    for i := 0 to ChrNameList.Count - 1 do begin
      QuickID := ChrNameList.Items[i];
      ChrList.AddObject(QuickID.sAccount, TObject(QuickID));
    end;
  end;
  Result := ChrList.Count;
end;

function TFileHumDB.ChrCountOfAccount(sAccount: string): integer;//0x0048C5B0
var
  ChrList: TList;
  I: integer;
  HumDBRecord: THumInfo;
begin
  Result  := 0;
  ChrList := nil;
  m_QuickIDList.GetChrList(sAccount, ChrList);
  if ChrList <> nil then begin
    for I := 0 to ChrList.Count - 1 do begin
      if GetBy(pTQuickID(ChrList.Items[I]).nIndex, HumDBRecord) and
        (not HumDBRecord.boDeleted) then Inc(Result);
    end;
  end;
end;

function TFileHumDB.Add(HumRecord: THumInfo): boolean;//0x0048C1F4
var
  Header: TDBHeader;
  nIndex: integer;
begin
  if m_QuickList.GetIndex(HumRecord.Header.sChrName) >= 0 then Result := False
  else begin
    Header := m_Header;
    if m_DeletedList.Count > 0 then begin
      nIndex := integer(m_DeletedList.Items[0]);
      m_DeletedList.Delete(0);
    end else begin
      nIndex := m_Header.nHumCount;
      Inc(m_Header.nHumCount);
    end;
    if UpdateRecord(nIndex, HumRecord, True) then begin
      m_QuickList.AddRecord(HumRecord.Header.sChrName, nIndex);
      m_QuickIDList.AddRecord(HumRecord.sAccount, HumRecord.sChrName,
        nIndex, HumRecord.Header.nSelectID);
      Result := True;
    end else begin
      m_Header := Header;
      Result   := False;
    end;
  end;
end;

function TFileHumDB.UpdateRecord(nIndex: integer; HumRecord: THumInfo;
  boNew: boolean): boolean;//0x0048BF5C
var
  HumRcd: THumInfo;
  nPosion, n10: integer;
begin
  nPosion := nIndex * SizeOf(THumInfo) + SizeOf(TDBHeader);
  if FileSeek(m_nFileHandle, nPosion, 0) = nPosion then begin
    n10 := FileSeek(m_nFileHandle, 0, 1);
    if boNew and (FileRead(m_nFileHandle, HumRcd, SizeOf(THumInfo)) =
      SizeOf(THumInfo)) and (not HumRcd.Header.boDeleted) and
      (HumRcd.Header.sChrName <> '') then Result := True
    else begin
      HumRecord.Header.boDeleted := False;
      HumRecord.Header.dCreateDate := Now();
      m_Header.dUpdateDate := Now();
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      FileSeek(m_nFileHandle, n10, 0);
      FileWrite(m_nFileHandle, HumRecord, SizeOf(THumInfo));
      FileSeek(m_nFileHandle, -SizeOf(THumInfo), 1);
      m_nCurIndex := nIndex;
      m_boChanged := True;
      Result      := True;
    end;
  end else
    Result := False;
end;

function TFileHumDB.Delete(sName: string): boolean;//0x0048BDE0
var
  n10: integer;
  HumRecord: THumInfo;
  ChrNameList: TList;
  n14: integer;
begin
  Result := False;
  n10    := m_QuickList.GetIndex(sName);
  if n10 < 0 then exit;
  Get(n10, HumRecord);
  if DeleteRecord(integer(m_QuickList.Objects[n10])) then begin
    m_QuickList.Delete(n10);
    Result := True;
  end;
  n14 := m_QuickIDList.GetChrList(HumRecord.sAccount, ChrNameList);
  if n14 >= 0 then begin
    m_QuickIDList.DelRecord(n14, HumRecord.sChrName);
  end;

end;

function TFileHumDB.DeleteRecord(nIndex: integer): boolean;//0x0048BD58
var
  HumRcdHeader: TRecordHeader;
begin
  Result := False;
  if FileSeek(m_nFileHandle, nIndex * SizeOf(THumInfo) + SizeOf(TDBHeader), 0) = -1 then
    exit;
  HumRcdHeader.boDeleted   := True;
  HumRcdHeader.dCreateDate := Now();
  FileWrite(m_nFileHandle, HumRcdHeader, SizeOf(TRecordHeader));
  m_DeletedList.Add(Pointer(nIndex));
  m_boChanged := True;
  Result      := True;
end;

function TFileHumDB.Update(nIndex: integer; var HumDBRecord: THumInfo): boolean;
  //0x0048C14C
begin
  Result := False;
  if nIndex < 0 then exit;
  if m_QuickList.Count <= nIndex then exit;
  if UpdateRecord(integer(m_QuickList.Objects[nIndex]), HumDBRecord, False) then
    Result := True;
end;



function TFileHumDB.UpdateBy(nIndex: integer; var HumDBRecord: THumInfo): boolean;
  //00048C1B4
begin
  Result := False;
  if UpdateRecord(nIndex, HumDBRecord, False) then Result := True;
end;



{ TFileDB }

constructor TFileDB.Create;
begin
  boDataDBReady := False;
  m_QuickList  := TQuickList.Create;

  n4ADAE4      := 0;
  n4ADAF0      := 0;
  nRecordCount := -1;

  if g_boSQLIsReady then LoadQuickList;
end;

destructor TFileDB.Destroy;
begin
  m_QuickList.Free;

  inherited;
end;

procedure TFileDB.LoadQuickList;
var
  nIndex    :Integer;
  boDeleted :Boolean;
  sChrName  :String;
resourcestring
  sSQL = 'SELECT * FROM TBL_CHARACTER';
begin
  nRecordCount   := -1;
  m_QuickList.Clear;
  n4ADAE4 := 0;
  n4ADAE8 := 0;
  n4ADAF0 := 0;

  Lock;
  try
    try
      dbQry.SQL.Clear;
      dbQry.SQL.Add(sSQL);
      try
        dbQry.Open;
      except
        OutMainMessage('[Exception] TFileDB.LoadQuickList');
      end;

      nRecordCount := dbQry.RecordCount;
      n4ADAF0 := nRecordCount;
      for nIndex := 0 to nRecordCount - 1 do begin
        Inc(n4ADAE4);

        boDeleted   := dbQry.FieldByName('FLD_DELETED').AsBoolean;
        sChrName    := Trim(dbQry.FieldByName('FLD_CHARNAME').AsString);

        if (not boDeleted) and (sChrName <> '') then begin
          m_QuickList.AddObject(sChrName, TObject(nIndex));
          Inc(n4ADAE8);
        end else begin
          Inc(n4ADAEC);
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

  boDataDBReady := True;
end;

procedure TFileDB.Lock;
begin
  EnterCriticalSection(HumDB_CS);
end;

procedure TFileDB.UnLock;
begin
  LeaveCriticalSection(HumDB_CS);
end;

function TFileDB.Open: boolean;
begin
  Result := False;
  Lock();

  m_boChanged := False;

  Result := True
end;

procedure TFileDB.Close;
begin
  if m_boChanged and Assigned(m_OnChange) then begin
    m_OnChange(Self);
  end;
  UnLock();
end;

function TFileDB.Index(sName: string): integer;
begin
  Result := m_QuickList.GetIndex(sName);
end;

function TFileDB.Get(nIndex: integer; var HumanRCD: THumDataInfo): integer;
begin
  Result := -1;
  if nIndex < 0 then exit;
  if m_QuickList.Count <= nIndex then exit;
  if GetRecord(nIndex, HumanRCD) then Result := nIndex;
end;

function TFileDB.GetQryChar(nIndex: integer; var QueryChrRcd: TQueryChr): integer;
var
  sChrName  :String;
resourcestring
  sSQL = 'SELECT * FROM TBL_CHARACTER WHERE FLD_CHARNAME=''%s''';
begin
  Result := -1;
  if nIndex < 0 then exit;
  if m_QuickList.Count <= nIndex then exit;

  sChrName := m_QuickList[nIndex];

  try
    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL, [sChrName]));
    try
      dbQry.Open;
    except
      OutMainMessage('[Exception] TFileDB.GetQryChar (1)');
      Exit;
    end;

    if dbQry.RecordCount > 0 then begin
      QueryChrRcd.sName     := Trim(dbQry.FieldByName('FLD_CHARNAME').AsString);
      QueryChrRcd.btClass   := dbQry.FieldByName('FLD_JOB').AsInteger;
      QueryChrRcd.btHair    := dbQry.FieldByName('FLD_HAIR').AsInteger;
      QueryChrRcd.btGender  := dbQry.FieldByName('FLD_SEX').AsInteger;
      QueryChrRcd.btLevel   := dbQry.FieldByName('FLD_LEVEL').AsInteger;
    end;
  finally
    dbQry.Close;
  end;

  Result := nIndex;
end;

function TFileDB.GetUserCurMap(nIndex: integer): String;
var
  sChrName  :String;
resourcestring
  sSQL = 'SELECT * FROM TBL_CHARACTER WHERE FLD_CHARNAME=''%s''';
begin
  Result := '';
  if nIndex < 0 then exit;
  if m_QuickList.Count <= nIndex then exit;

  sChrName := m_QuickList[nIndex];

  try
    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL, [sChrName]));
    try
      dbQry.Open;
    except
      OutMainMessage('[Exception] TFileDB.GetUserCurMap');
      Exit;
    end;

    if dbQry.RecordCount > 0 then begin
      Result     := Trim(dbQry.FieldByName('FLD_MAPNAME').AsString);
    end;
  finally
    dbQry.Close;
  end;
end;

function TFileDB.Update(nIndex: integer; var HumanRCD: THumDataInfo): boolean;
begin
  Result := False;
  if (nIndex >= 0) and (m_QuickList.Count > nIndex) then
    if UpdateRecord(nIndex, HumanRCD, False) then
      Result := True;
end;

function TFileDB.Add(var HumanRCD: THumDataInfo): boolean;
var
  sChrName: string;
  nIndex: integer;
begin
  sChrName := HumanRCD.Header.sChrName;
  if m_QuickList.GetIndex(sChrName) >= 0 then begin
    Result := False;
  end else begin
    nIndex := nRecordCount;
    Inc(nRecordCount);

    if UpdateRecord(nIndex, HumanRCD, True) then begin
      m_QuickList.AddRecord(sChrName, nIndex);
      Result := True;
    end else begin
      Result   := False;
    end;
  end;
end;

function TFileDB.GetRecord(nIndex: integer; var HumanRCD: THumDataInfo): boolean;
var
  sChrName  :String;
  sTmp      :String;
  str       :String;
  i         :Integer;
  nCount    :Integer;
  nPosition :Integer;
  Blob      :TBlob;
resourcestring
  sSQL = 'SELECT * FROM TBL_CHARACTER WHERE FLD_CHARNAME=''%s''';
  sSQL2 = 'SELECT * FROM TBL_ADDABILITY WHERE FLD_CHARNAME=''%s''';
  sSQL3 = 'SELECT * FROM TBL_QUEST WHERE FLD_CHARNAME=''%s''';
  sSQL4 = 'SELECT * FROM TBL_CHARACTER_MAGIC WHERE FLD_CHARNAME=''%s''';
  sSQL5 = 'SELECT * FROM TBL_CHARACTER_ITEM WHERE FLD_CHARNAME=''%s''';
  sSQL6 = 'SELECT * FROM TBL_CHARACTER_STORAGE WHERE FLD_CHARNAME=''%s''';
begin
  Result := True;
  sChrName := m_QuickList[nIndex];

  try
    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL, [sChrName]));
    try
      dbQry.Open;
    except
      Result := False;
      OutMainMessage('[Exception] TFileDB.GetRecord (1)');
      Exit;
    end;

    if dbQry.RecordCount > 0 then begin
      HumanRCD.Header.sAccount      := Trim(dbQry.FieldByName('FLD_LOGINID').AsString);
      HumanRCD.Header.sChrName      := Trim(dbQry.FieldByName('FLD_CHARNAME').AsString);
      HumanRCD.Header.boDeleted     := dbQry.FieldByName('FLD_DELETED').AsBoolean;
      HumanRCD.Header.UpdateDate    := dbQry.FieldByName('FLD_LASTUPDATE').AsDateTime;
      HumanRCD.Header.CreateDate    := dbQry.FieldByName('FLD_CREATEDATE').AsDateTime;

      HumanRCD.Data.sChrName        := Trim(dbQry.FieldByName('FLD_CHARNAME').AsString);
      HumanRCD.Data.sCurMap         := Trim(dbQry.FieldByName('FLD_MAPNAME').AsString);
      HumanRCD.Data.wCurX           := dbQry.FieldByName('FLD_CX').AsInteger;
      HumanRCD.Data.wCurY           := dbQry.FieldByName('FLD_CY').AsInteger;
      HumanRCD.Data.btDir           := dbQry.FieldByName('FLD_DIR').AsInteger;
      HumanRCD.Data.btHair          := dbQry.FieldByName('FLD_HAIR').AsInteger;
      HumanRCD.Data.btSex           := dbQry.FieldByName('FLD_SEX').AsInteger;
      HumanRCD.Data.btJob           := dbQry.FieldByName('FLD_JOB').AsInteger;
      HumanRCD.Data.nGold           := dbQry.FieldByName('FLD_GOLD').AsInteger;

      HumanRCD.Data.Abil.Level      := dbQry.FieldByName('FLD_LEVEL').AsInteger;
      HumanRCD.Data.Abil.HP         := dbQry.FieldByName('FLD_HP').AsInteger;
      HumanRCD.Data.Abil.MP         := dbQry.FieldByName('FLD_MP').AsInteger;
      HumanRCD.Data.Abil.Exp        := dbQry.FieldByName('FLD_EXP').AsInteger;

      HumanRCD.Data.sHomeMap        := Trim(dbQry.FieldByName('FLD_HOMEMAP').AsString);
      HumanRCD.Data.wHomeX          := dbQry.FieldByName('FLD_HOMECX').AsInteger;
      HumanRCD.Data.wHomeY          := dbQry.FieldByName('FLD_HOMECY').AsInteger;

      HumanRCD.Data.nBonusPoint     := dbQry.FieldByName('FLD_BONUSPOINT').AsInteger;
      HumanRCD.Data.btCreditPoint   := dbQry.FieldByName('FLD_CREDITPOINT').AsInteger;

      HumanRCD.Data.btReLevel       := dbQry.FieldByName('FLD_REBIRTHLEVEL').AsInteger;
      HumanRCD.Data.sMasterName     := Trim(dbQry.FieldByName('FLD_MASTERCHARNAME').AsString);
      HumanRCD.Data.boMaster        := dbQry.FieldByName('FLD_MASTER').AsBoolean;
      HumanRCD.Data.sDearName       := Trim(dbQry.FieldByName('FLD_DEARCHARNAME').AsString);
      HumanRCD.Data.sStoragePwd     := Trim(dbQry.FieldByName('FLD_STORAGEPASSWD').AsString);
      HumanRCD.Data.nPayMentPoint   := dbQry.FieldByName('FLD_PAYPOINT').AsInteger;
      HumanRCD.Data.nPKPoint        := dbQry.FieldByName('FLD_PKPOINT').AsInteger;
      HumanRCD.Data.btAllowGroup    := Byte(dbQry.FieldByName('FLD_ALLOWPARTY').AsBoolean);
      HumanRCD.Data.btFreeGuiltyCount := dbQry.FieldByName('FLD_FREEGULITYCOUNT').AsInteger;
      HumanRCD.Data.btAttatckMode   := dbQry.FieldByName('FLD_ATTACKMODE').AsInteger;
      HumanRCD.Data.btIncHealth     := dbQry.FieldByName('FLD_INCHEALTH').AsInteger;
      HumanRCD.Data.btIncSpell      := dbQry.FieldByName('FLD_INCSPELL').AsInteger;
      HumanRCD.Data.btIncHealing    := dbQry.FieldByName('FLD_INCHEALING').AsInteger;
      HumanRCD.Data.btFightZoneDieCount := dbQry.FieldByName('FLD_FIGHTZONEDIE').AsInteger;
      HumanRCD.Data.btFirstLogin    := dbQry.FieldByName('FLD_TESTSERVERRESETCOUNT').AsInteger;

      HumanRCD.Data.sAccount        := Trim(dbQry.FieldByName('FLD_LOGINID').AsString);
      HumanRCD.Data.boLockLogon     := dbQry.FieldByName('FLD_LOCKLOGON').AsBoolean;
      HumanRCD.Data.wContribution   := dbQry.FieldByName('FLD_CONTRIBUTION').AsInteger;
      HumanRCD.Data.nHungerStatus   := dbQry.FieldByName('FLD_HUNGRYSTATE').AsInteger;
      HumanRCD.Data.boAllowGuildRecall := dbQry.FieldByName('FLD_ENABLEGRECALL').AsBoolean;
      HumanRCD.Data.wGroupRcallTime := dbQry.FieldByName('FLD_GROUPRECALLTIME').AsInteger;
      HumanRCD.Data.dBodyLuck       := dbQry.FieldByName('FLD_BODYLUCK').AsFloat;
      HumanRCD.Data.boAllowGroupRecall := dbQry.FieldByName('FLD_ENABLEGROUPRECALL').AsBoolean;
      HumanRCD.Data.btMarryCount    := dbQry.FieldByName('FLD_MARRYCOUNT').AsInteger;

      sTmp := dbQry.FieldByName('FLD_STATUS').AsString;

      i := 0;
      while True do begin
        if sTmp = '' then break;
        if i >= High(HumanRCD.Data.wStatusTimeArr) then break;
        sTmp := GetValidStr3(sTmp, str, ['/']);
        HumanRCD.Data.wStatusTimeArr[i] := StrToInt(str);
        Inc(i);
      end;
    end;

    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL2, [sChrName]));
    try
      dbQry.Open;
    except
      Result := False;
      OutMainMessage('[Exception] TFileDB.GetRecord (2)');
      Exit;
    end;

    if dbQry.RecordCount > 0 then begin
      HumanRCD.Data.BonusAbil.AC    := dbQry.FieldByName('FLD_BONUSAC').AsInteger;
      HumanRCD.Data.BonusAbil.MAC   := dbQry.FieldByName('FLD_BONUSMAC').AsInteger;
      HumanRCD.Data.BonusAbil.DC    := dbQry.FieldByName('FLD_BONUSDC').AsInteger;
      HumanRCD.Data.BonusAbil.MC    := dbQry.FieldByName('FLD_BONUSMC').AsInteger;
      HumanRCD.Data.BonusAbil.SC    := dbQry.FieldByName('FLD_BONUSSC').AsInteger;
      HumanRCD.Data.BonusAbil.HP    := dbQry.FieldByName('FLD_BONUSHP').AsInteger;
      HumanRCD.Data.BonusAbil.MP    := dbQry.FieldByName('FLD_BONUSMP').AsInteger;
      HumanRCD.Data.BonusAbil.Hit   := dbQry.FieldByName('FLD_BONUSACCURACY').AsInteger;
      HumanRCD.Data.BonusAbil.Speed := dbQry.FieldByName('FLD_BONUSAGILITY').AsInteger;
    end;

   { dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL3, [sChrName]));
    try
      dbQry.Open;
    except
      Result := False;
      OutMainMessage('[Exception] TFileDB.GetRecord (3)');
      Exit;
    end;

    if dbQry.RecordCount > 0 then begin
      sTmp := dbQry.FieldByName('FLD_QUESTOPENINDEX').AsString;

      i := 0;
      while True do begin
        if sTmp = '' then break;
        if i >= High(HumanRCD.Data.QuestUnitOpen) then break;
        sTmp := GetValidStr3(sTmp, str, ['/']);
        HumanRCD.Data.QuestUnitOpen[i] := StrToInt(str);
        Inc(i);
      end;

      sTmp := dbQry.FieldByName('FLD_QUESTFININDEX').AsString;

      i := 0;
      while True do begin
        if sTmp = '' then break;
        if i >= High(HumanRCD.Data.QuestUnit) then break;
        sTmp := GetValidStr3(sTmp, str, ['/']);
        HumanRCD.Data.QuestUnit[i] := StrToInt(str);
        Inc(i);
      end;

      sTmp := dbQry.FieldByName('FLD_QUEST').AsString;

      i := 0;
      while True do begin
        if sTmp = '' then break;
        if i >= High(HumanRCD.Data.QuestFlag) then break;
        sTmp := GetValidStr3(sTmp, str, ['/']);
        HumanRCD.Data.QuestFlag[i] := StrToInt(str);
        Inc(i);
      end;
    end;

    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL4, [sChrName]));
    try
      dbQry.Open;
    except
      Result := False;
      OutMainMessage('[Exception] TFileDB.GetRecord (4)');
      Exit;
    end;

    nCount := dbQry.RecordCount -1;
    if nCount > MAXMAGIC then nCount := MAXMAGIC;
    for i:=0 to nCount do begin
      HumanRCD.Data.Magic[i].wMagIdx    := dbQry.FieldByName('FLD_MAGICID').AsInteger;
      HumanRCD.Data.Magic[i].btLevel    := dbQry.FieldByName('FLD_LEVEL').AsInteger;
      HumanRCD.Data.Magic[i].btKey      := dbQry.FieldByName('FLD_USEKEY').AsInteger;
      HumanRCD.Data.Magic[i].nTranPoint := dbQry.FieldByName('FLD_CURRTRAIN').AsInteger;
      dbQry.Next;
    end;

    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL5, [sChrName]));
    try
      dbQry.Open;
    except
      Result := False;
      OutMainMessage('[Exception] TFileDB.GetRecord (5)');
      Exit;
    end;

    nCount := dbQry.RecordCount -1;
    if nCount > MAXBAGITEM+MAXUSEITEM then nCount := MAXBAGITEM+MAXUSEITEM;
    for i:=0 to nCount do begin
      nPosition := dbQry.FieldByName('FLD_POSITION').AsInteger -1;

      if (nPosition >= 0) and (nPosition <= MAXUSEITEM) then begin
        HumanRCD.Data.HumItems[nPosition].MakeIndex   := dbQry.FieldByName('FLD_MAKEINDEX').AsInteger;
        HumanRCD.Data.HumItems[nPosition].wIndex      := dbQry.FieldByName('FLD_STDINDEX').AsInteger;
        HumanRCD.Data.HumItems[nPosition].Dura        := dbQry.FieldByName('FLD_DURA').AsInteger;
        HumanRCD.Data.HumItems[nPosition].DuraMax     := dbQry.FieldByName('FLD_DURAMAX').AsInteger;
        HumanRCD.Data.HumItems[nPosition].Count       := dbQry.FieldByName('FLD_COUNT').AsInteger;
        HumanRCD.Data.HumItems[nPosition].Color       := dbQry.FieldByName('FLD_COLOR').AsInteger;

        HumanRCD.Data.HumItems[nPosition].btValue[0]  := dbQry.FieldByName('FLD_VALUE1').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[1]  := dbQry.FieldByName('FLD_VALUE2').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[2]  := dbQry.FieldByName('FLD_VALUE3').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[3]  := dbQry.FieldByName('FLD_VALUE4').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[4]  := dbQry.FieldByName('FLD_VALUE5').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[5]  := dbQry.FieldByName('FLD_VALUE6').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[6]  := dbQry.FieldByName('FLD_VALUE7').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[7]  := dbQry.FieldByName('FLD_VALUE8').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[8]  := dbQry.FieldByName('FLD_VALUE9').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[9]  := dbQry.FieldByName('FLD_VALUE10').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[10]  := dbQry.FieldByName('FLD_VALUE11').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[11]  := dbQry.FieldByName('FLD_VALUE12').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[12]  := dbQry.FieldByName('FLD_VALUE13').AsInteger;
        HumanRCD.Data.HumItems[nPosition].btValue[13]  := dbQry.FieldByName('FLD_VALUE14').AsInteger;
      end else begin
        HumanRCD.Data.BagItems[i].MakeIndex   := dbQry.FieldByName('FLD_MAKEINDEX').AsInteger;
        HumanRCD.Data.BagItems[i].wIndex      := dbQry.FieldByName('FLD_STDINDEX').AsInteger;
        HumanRCD.Data.BagItems[i].Dura        := dbQry.FieldByName('FLD_DURA').AsInteger;
        HumanRCD.Data.BagItems[i].DuraMax     := dbQry.FieldByName('FLD_DURAMAX').AsInteger;
        HumanRCD.Data.BagItems[i].Count       := dbQry.FieldByName('FLD_COUNT').AsInteger;
        HumanRCD.Data.BagItems[i].Color       := dbQry.FieldByName('FLD_COLOR').AsInteger;

        HumanRCD.Data.BagItems[i].btValue[0]  := dbQry.FieldByName('FLD_VALUE1').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[1]  := dbQry.FieldByName('FLD_VALUE2').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[2]  := dbQry.FieldByName('FLD_VALUE3').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[3]  := dbQry.FieldByName('FLD_VALUE4').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[4]  := dbQry.FieldByName('FLD_VALUE5').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[5]  := dbQry.FieldByName('FLD_VALUE6').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[6]  := dbQry.FieldByName('FLD_VALUE7').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[7]  := dbQry.FieldByName('FLD_VALUE8').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[8]  := dbQry.FieldByName('FLD_VALUE9').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[9]  := dbQry.FieldByName('FLD_VALUE10').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[10]  := dbQry.FieldByName('FLD_VALUE11').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[11]  := dbQry.FieldByName('FLD_VALUE12').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[12]  := dbQry.FieldByName('FLD_VALUE13').AsInteger;
        HumanRCD.Data.BagItems[i].btValue[13]  := dbQry.FieldByName('FLD_VALUE14').AsInteger;
      end;
      dbQry.Next;
    end;

    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL6, [sChrName]));
    try
      dbQry.Open;
    except
      Result := False;
      OutMainMessage('[Exception] TFileDB.GetRecord (6)');
      Exit;
    end;

    nCount := dbQry.RecordCount -1;
    if nCount > STORAGELIMIT then nCount := STORAGELIMIT;
    for i:=0 to nCount do begin
      HumanRCD.Data.StorageItems[i].MakeIndex   := dbQry.FieldByName('FLD_MAKEINDEX').AsInteger;
      HumanRCD.Data.StorageItems[i].wIndex      := dbQry.FieldByName('FLD_STDINDEX').AsInteger;
      HumanRCD.Data.StorageItems[i].Dura        := dbQry.FieldByName('FLD_DURA').AsInteger;
      HumanRCD.Data.StorageItems[i].DuraMax     := dbQry.FieldByName('FLD_DURAMAX').AsInteger;
      HumanRCD.Data.StorageItems[i].Count       := dbQry.FieldByName('FLD_COUNT').AsInteger;
      HumanRCD.Data.StorageItems[i].Color       := dbQry.FieldByName('FLD_COLOR').AsInteger;

      HumanRCD.Data.StorageItems[i].btValue[0]  := dbQry.FieldByName('FLD_VALUE1').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[1]  := dbQry.FieldByName('FLD_VALUE2').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[2]  := dbQry.FieldByName('FLD_VALUE3').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[3]  := dbQry.FieldByName('FLD_VALUE4').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[4]  := dbQry.FieldByName('FLD_VALUE5').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[5]  := dbQry.FieldByName('FLD_VALUE6').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[6]  := dbQry.FieldByName('FLD_VALUE7').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[7]  := dbQry.FieldByName('FLD_VALUE8').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[8]  := dbQry.FieldByName('FLD_VALUE9').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[9]  := dbQry.FieldByName('FLD_VALUE10').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[10]  := dbQry.FieldByName('FLD_VALUE11').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[11]  := dbQry.FieldByName('FLD_VALUE12').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[12]  := dbQry.FieldByName('FLD_VALUE13').AsInteger;
      HumanRCD.Data.StorageItems[i].btValue[13]  := dbQry.FieldByName('FLD_VALUE14').AsInteger;
      dbQry.Next;
    end;
             }
  finally
    dbQry.Close;
  end;
end;

function TFileDB.UpdateRecord(nIndex: integer; var HumanRCD: THumDataInfo; boNew: boolean): boolean;//0x0048B134
var
  sdt       :String;
  i         :Integer;
  sTmp      :String;
  hd        :pTHumData;
  m         :TMemoryStream;
begin
  Result := True;
  sdt := FormatDateTime(SQLDTFORMAT, Now);

  try
    dbQry.SQL.Clear;

    if boNew then begin
      hd := @HumanRCD.Data;
      //New Character
      dbQry.SQL.Clear;
      dbQry.SQL.Add(format('INSERT INTO TBL_CHARACTER ('+
						               'FLD_LOGINID, FLD_CHARNAME, FLD_JOB, FLD_SEX, FLD_DIR, '+
                           'FLD_ATTACKMODE, FLD_CX, FLD_CY, FLD_MAPNAME, FLD_GOLD, FLD_HAIR, '+
                           'FLD_ISADMIN, FLD_DELETED, FLD_CREATEDATE, FLD_LASTUPDATE) VALUES ( '+
                           '''%s'', ''%s'', %d, %d, 0, '+
                           '1, %d, %d, ''%s'', 0, %d, '+
						               '0, 0, ''%s'', ''%s'' )',
                           [hd.sAccount, hd.sChrName, hd.btJob, hd.btSex,
                           hd.wCurX, hd.wCurY, hd.sCurMap, hd.btHair,
                           sdt, sdt]));


      try
        dbQry.Execute;
      except
        Result := False;
        OutMainMessage('[Exception] TFileDB.UpdateRecord (1)');
        Exit;
      end;

      dbQry.SQL.Clear;
      dbQry.SQL.Add(format('INSERT INTO TBL_ADDABILITY(FLD_CHARNAME, FLD_LEVEL) '+
                           'VALUES( ''%s'', %d )',
                           [hd.sChrName,
                           hd.Abil.Level]));

      try
        dbQry.Execute;
      except
        Result := False;
        OutMainMessage('[Exception] TFileDB.UpdateRecord (2)');
        Exit;
      end;
    end else begin
      hd := @HumanRCD.Data;

      //General Update
      sTmp := '';
      for i:=0 to High(HumanRCD.Data.wStatusTimeArr) do
        sTmp := sTmp + IntToStr(HumanRCD.Data.wStatusTimeArr[i]) + '/';
      
      dbQry.SQL.Clear;
      dbQry.SQL.Add(format('UPDATE TBL_CHARACTER SET FLD_JOB=%d, FLD_SEX=%d, FLD_HAIR=%d, ' +
                           'FLD_DIR=%d, FLD_CX=%d, FLD_CY=%d, ' +
                           'FLD_LEVEL=%d, FLD_HP=%d, FLD_MP=%d, FLD_EXP=%d, ' +
						               'FLD_ATTACKMODE=%d, FLD_MAPNAME=''%s'', FLD_GOLD=%d, ' +
                           'FLD_ISADMIN=%d, FLD_DELETED=%d, FLD_HOMEMAP=''%s'', FLD_HOMECX=%d, FLD_HOMECY=%d, ' +
                           'FLD_BONUSPOINT=%d, FLD_CREDITPOINT=%d, FLD_MASTERCHARNAME=''%s'', FLD_MASTER=%d, ' +
                           'FLD_REBIRTHLEVEL=%d, FLD_TESTSERVERRESETCOUNT=%d, FLD_FREEGULITYCOUNT=%d, '+
                           'FLD_DEARCHARNAME=''%s'', FLD_STORAGEPASSWD=''%s'', FLD_PAYPOINT=%d, FLD_PKPOINT=%d, FLD_ALLOWPARTY=%d, ' +
                           'FLD_INCHEALTH=%d, FLD_INCSPELL=%d, FLD_INCHEALING=%d, FLD_FIGHTZONEDIE=%d, ' +
                           'FLD_LOCKLOGON=%d, FLD_CONTRIBUTION=%d, FLD_HUNGRYSTATE=%d, FLD_ENABLEGRECALL=%d, ' +
                           'FLD_GROUPRECALLTIME=%d, FLD_BODYLUCK=%F, FLD_ENABLEGROUPRECALL=%d, FLD_MARRYCOUNT=%d, ' +
                           'FLD_STATUS=''%s'', FLD_LASTUPDATE=''%s'' WHERE FLD_CHARNAME=''%s''',
                           [hd.btJob, hd.btSex, hd.btHair,
                           hd.btDir, hd.wCurX, hd.wCurY,
                           hd.Abil.Level, hd.Abil.HP, hd.Abil.MP, hd.Abil.Exp,
                           hd.btAttatckMode, hd.sCurMap, hd.nGold,
                           0, 0, hd.sHomeMap, hd.wHomeX, hd.wHomeY,
                           hd.nBonusPoint, hd.btCreditPoint, hd.sMasterName, BoolToInt(hd.boMaster),
                           hd.btReLevel, hd.btFirstLogin, hd.btFreeGuiltyCount,
                           hd.sDearName, hd.sStoragePwd, hd.nPayMentPoint, hd.nPKPoint, hd.btAllowGroup,
                           hd.btIncHealth, hd.btIncSpell, hd.btIncHealing, hd.btFightZoneDieCount,
                           BoolToInt(hd.boLockLogon), hd.wContribution, hd.nHungerStatus, BoolToInt(hd.boAllowGuildReCall),
                           hd.wGroupRcallTime, hd.dBodyLuck, BoolToInt(hd.boAllowGroupReCall), hd.btMarryCount,
                           sTmp, FormatDateTime(SQLDTFORMAT, HumanRCD.Header.UpdateDate), HumanRCD.Header.sChrName]));

      try
        dbQry.Execute;
      except
        Result := False;
        OutMainMessage('[Exception] TFileDB.UpdateRecord (4)');
        Exit;
      end;


      dbQry.SQL.Clear;
      dbQry.SQL.Add(format('UPDATE TBL_ADDABILITY SET ' +
                           'FLD_BONUSAC=%d, FLD_BONUSMAC=%d, FLD_BONUSDC=%d, FLD_BONUSMC=%d, FLD_BONUSSC=%d, ' +
						               'FLD_BONUSHP=%d, FLD_BONUSMP=%d, FLD_BONUSACCURACY=%d, FLD_BONUSAGILITY=%d ' +
						               'WHERE FLD_CHARNAME=''%s''',
                           [hd.BonusAbil.AC, hd.BonusAbil.MAC, hd.BonusAbil.DC, hd.BonusAbil.MC,
                           hd.BonusAbil.SC, hd.BonusAbil.HP, hd.BonusAbil.MP, hd.BonusAbil.Hit, hd.BonusAbil.Speed,
                           HumanRCD.Header.sChrName]));

      try
        dbQry.Execute;
      except
        Result := False;
        OutMainMessage('[Exception] TFileDB.UpdateRecord (4)');
      end;


      dbQry.SQL.Clear;
      dbQry.SQL.Add(format('DELETE FROM TBL_QUEST WHERE FLD_CHARNAME=''%s''',
                           [HumanRCD.Header.sChrName]));

      // Delete Quest Data
      try
        dbQry.Execute;
      except
        Result := False;
        OutMainMessage('[Exception] TFileDB.UpdateRecord (6)');
      end;

      try
        dbQry.SQL.Clear;
        dbQry.SQL.Text := 'INSERT INTO TBL_QUEST (FLD_CHARNAME, FLD_QUESTOPENINDEX, FLD_QUESTFININDEX, FLD_QUEST) '+
                          'VALUES(:FLD_CHARNAME, :FLD_QUESTOPENINDEX, :FLD_QUESTFININDEX, :FLD_QUEST)';

        dbQry.ParamByName('FLD_CHARNAME').Value := HumanRCD.Header.sChrName;

        sTmp := '';
        for i:=0 to High(HumanRCD.Data.QuestUnitOpen) do
          sTmp := sTmp + IntToStr(HumanRCD.Data.QuestUnitOpen[i]) + '/';
        dbQry.ParamByName('FLD_QUESTOPENINDEX').Value := sTmp;

        sTmp := '';
        for i:=0 to High(HumanRCD.Data.QuestUnit) do
          sTmp := sTmp + IntToStr(HumanRCD.Data.QuestUnit[i]) + '/';
        dbQry.ParamByName('FLD_QUESTFININDEX').Value := sTmp;

        sTmp := '';
        for i:=0 to High(HumanRCD.Data.QuestFlag) do
          sTmp := sTmp + IntToStr(HumanRCD.Data.QuestFlag[i]) + '/';
        dbQry.ParamByName('FLD_QUEST').Value := sTmp;

        dbQry.Execute;
      except
        Result := False;
        OutMainMessage('[Exception] TFileDB.UpdateRecord => TBL_QUEST!!');
      end;



      dbQry.SQL.Clear;
      dbQry.SQL.Add(format('DELETE FROM TBL_CHARACTER_MAGIC WHERE FLD_CHARNAME=''%s''',
                           [HumanRCD.Header.sChrName]));

      // Delete Magic Data
      try
        dbQry.Execute;
      except
        Result := False;
        OutMainMessage('[Exception] TFileDB.UpdateRecord (6)');
      end;

      for i:=0 to High(hd.Magic) do begin
        if hd.Magic[i].wMagIdx > 0 then begin
          dbQry.SQL.Clear;
          dbQry.SQL.Add(format('INSERT TBL_CHARACTER_MAGIC(FLD_LOGINID, FLD_CHARNAME, FLD_MAGICID, FLD_LEVEL, FLD_USEKEY, FLD_CURRTRAIN) VALUES '+
							                 '( ''%s'', ''%s'', %d, %d, %d, %d )',
                               [HumanRCD.Header.sAccount, HumanRCD.Header.sChrName,
                               hd.Magic[i].wMagIdx, hd.Magic[i].btLevel,
                               hd.Magic[i].btKey,hd.Magic[i].nTranPoint]));

          try
            dbQry.Execute;
          except
            Result := False;
            OutMainMessage('[Exception] TFileDB.UpdateRecord (7)');
          end;
        end;
      end;

      dbQry.SQL.Clear;
      dbQry.SQL.Add(format('DELETE FROM TBL_CHARACTER_ITEM WHERE FLD_CHARNAME=''%s''',
                           [HumanRCD.Header.sChrName]));

      // Delete Item Data
      try
        dbQry.Execute;
      except
        Result := False;
        OutMainMessage('[Exception] TFileDB.UpdateRecord (8)');
      end;

      for i:=0 to High(hd.BagItems) do begin
        if (hd.BagItems[i].wIndex > 0) and (hd.BagItems[i].MakeIndex > 0) then begin
          dbQry.SQL.Clear;
          dbQry.SQL.Add(format('INSERT TBL_CHARACTER_ITEM(FLD_LOGINID, FLD_CHARNAME, FLD_POSITION, FLD_MAKEINDEX, FLD_STDINDEX, FLD_DURA, FLD_DURAMAX, '+
                               'FLD_COUNT, FLD_COLOR, FLD_VALUE1, FLD_VALUE2, FLD_VALUE3, FLD_VALUE4, FLD_VALUE5, FLD_VALUE6, FLD_VALUE7, FLD_VALUE8, '+
                               'FLD_VALUE9, FLD_VALUE10, FLD_VALUE11, FLD_VALUE12, FLD_VALUE13, FLD_VALUE14) VALUES '+
							                 '( ''%s'', ''%s'', %d, %d, %d, %d, %d, '+
                               '%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, '+
                               '%d, %d, %d, %d, %d, %d )',
                               [HumanRCD.Header.sAccount, HumanRCD.Header.sChrName, 0,
                               hd.BagItems[i].MakeIndex, hd.BagItems[i].wIndex, hd.BagItems[i].Dura,
                               hd.BagItems[i].DuraMax, hd.BagItems[i].Count, hd.BagItems[i].Color,
                               hd.BagItems[i].btValue[0], hd.BagItems[i].btValue[1], hd.BagItems[i].btValue[2],
                               hd.BagItems[i].btValue[3], hd.BagItems[i].btValue[4], hd.BagItems[i].btValue[5],
                               hd.BagItems[i].btValue[6], hd.BagItems[i].btValue[7], hd.BagItems[i].btValue[8],
                               hd.BagItems[i].btValue[9], hd.BagItems[i].btValue[10], hd.BagItems[i].btValue[11],
                               hd.BagItems[i].btValue[12], hd.BagItems[i].btValue[13]]));

          try
            dbQry.Execute;
          except
            Result := False;
            OutMainMessage('[Exception] TFileDB.UpdateRecord (9)');
          end;
        end;
      end;

      for i:=0 to High(hd.HumItems) do begin
        if (hd.HumItems[i].wIndex > 0) and (hd.HumItems[i].MakeIndex > 0) then begin
          dbQry.SQL.Clear;
          dbQry.SQL.Add(format('INSERT TBL_CHARACTER_ITEM(FLD_LOGINID, FLD_CHARNAME, FLD_POSITION, FLD_MAKEINDEX, FLD_STDINDEX, FLD_DURA, FLD_DURAMAX, '+
                               'FLD_COUNT, FLD_COLOR, FLD_VALUE1, FLD_VALUE2, FLD_VALUE3, FLD_VALUE4, FLD_VALUE5, FLD_VALUE6, FLD_VALUE7, FLD_VALUE8, '+
                               'FLD_VALUE9, FLD_VALUE10, FLD_VALUE11, FLD_VALUE12, FLD_VALUE13, FLD_VALUE14) VALUES '+
							                 '( ''%s'', ''%s'', %d, %d, %d, %d, %d, '+
                               '%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, '+
                               '%d, %d, %d, %d, %d, %d )',
                               [HumanRCD.Header.sAccount, HumanRCD.Header.sChrName, i+1,
                               hd.HumItems[i].MakeIndex, hd.HumItems[i].wIndex, hd.HumItems[i].Dura,
                               hd.HumItems[i].DuraMax, hd.HumItems[i].Count, hd.HumItems[i].Color,
                               hd.HumItems[i].btValue[0], hd.HumItems[i].btValue[1], hd.HumItems[i].btValue[2],
                               hd.HumItems[i].btValue[3], hd.HumItems[i].btValue[4], hd.HumItems[i].btValue[5],
                               hd.HumItems[i].btValue[6], hd.HumItems[i].btValue[7], hd.HumItems[i].btValue[8],
                               hd.HumItems[i].btValue[9], hd.HumItems[i].btValue[10], hd.HumItems[i].btValue[11],
                               hd.HumItems[i].btValue[12], hd.HumItems[i].btValue[13]]));

          try
            dbQry.Execute;
          except
            Result := False;
            OutMainMessage('[Exception] TFileDB.UpdateRecord (13)');
          end;
        end;
      end;


      dbQry.SQL.Clear;
      dbQry.SQL.Add(format('DELETE FROM TBL_CHARACTER_STORAGE WHERE FLD_CHARNAME=''%s''',
                           [HumanRCD.Header.sChrName]));

      // Delete Store Item Data
      try
        dbQry.Execute;
      except
        Result := False;
        OutMainMessage('[Exception] TFileDB.UpdateRecord (10)');
      end;

      for i:=0 to High(hd.StorageItems) do begin
        if (hd.StorageItems[i].wIndex > 0) and (hd.StorageItems[i].MakeIndex > 0) then begin
          dbQry.SQL.Clear;
          dbQry.SQL.Add(format('INSERT TBL_CHARACTER_STORAGE(FLD_LOGINID, FLD_CHARNAME, FLD_MAKEINDEX, FLD_STDINDEX, FLD_DURA, FLD_DURAMAX, '+
                               'FLD_COUNT, FLD_COLOR, FLD_VALUE1, FLD_VALUE2, FLD_VALUE3, FLD_VALUE4, FLD_VALUE5, FLD_VALUE6, FLD_VALUE7, FLD_VALUE8, '+
                               'FLD_VALUE9, FLD_VALUE10, FLD_VALUE11, FLD_VALUE12, FLD_VALUE13, FLD_VALUE14) VALUES '+
							                 '( ''%s'', ''%s'', %d, %d, %d, %d, '+
                               '%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, '+
                               '%d, %d, %d, %d, %d, %d )',
                               [HumanRCD.Header.sAccount, HumanRCD.Header.sChrName,
                               hd.StorageItems[i].MakeIndex, hd.StorageItems[i].wIndex, hd.StorageItems[i].Dura,
                               hd.StorageItems[i].DuraMax, hd.StorageItems[i].Count, hd.StorageItems[i].Color,
                               hd.StorageItems[i].btValue[0], hd.StorageItems[i].btValue[1], hd.StorageItems[i].btValue[2],
                               hd.StorageItems[i].btValue[3], hd.StorageItems[i].btValue[4], hd.StorageItems[i].btValue[5],
                               hd.StorageItems[i].btValue[6], hd.StorageItems[i].btValue[7], hd.StorageItems[i].btValue[8],
                               hd.StorageItems[i].btValue[9], hd.StorageItems[i].btValue[10], hd.StorageItems[i].btValue[11],
                               hd.StorageItems[i].btValue[12], hd.StorageItems[i].btValue[13]]));

          try
            dbQry.Execute;
          except
            Result := False;
            OutMainMessage('[Exception] TFileDB.UpdateRecord (11)');
          end;
        end;
      end;
    end;

    m_boChanged := True;
  finally
    dbQry.Close;
  end;

{var
  nPosion, n10: integer;
  dt20:    TDateTime;
  ReadRCD: THumDataInfo;
begin
  nPosion := nIndex * SizeOf(THumDataInfo) + SizeOf(TDBHeader);
  if FileSeek(m_nFileHandle, nPosion, 0) = nPosion then begin
    dt20 := Now();
    m_nLastIndex := nIndex;
    m_dUpdateTime := dt20;
    n10  := FileSeek(m_nFileHandle, 0, 1);
    if boNew and (FileRead(m_nFileHandle, ReadRCD, SizeOf(THumDataInfo)) =
      SizeOf(THumDataInfo)) and not ReadRCD.Header.boDeleted and
      (ReadRCD.Header.sName <> '') then begin
      Result := False;
    end else begin //0048B1F5
      HumanRCD.Header.boDeleted := False;
      HumanRCD.Header.dCreateDate := Now();
      m_Header.nLastIndex  := m_nLastIndex;
      m_Header.dLastDate   := m_dUpdateTime;
      m_Header.dUpdateDate := Now();
      FileSeek(m_nFileHandle, 0, 0);
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
      FileSeek(m_nFileHandle, n10, 0);
      FileWrite(m_nFileHandle, HumanRCD, SizeOf(THumDataInfo));
      FileSeek(m_nFileHandle, -SizeOf(THumDataInfo), 1);
      m_nCurIndex := nIndex;
      m_boChanged := True;
      Result      := True;
    end;
  end else
    Result := False;}
end;



function TFileDB.Find(sChrName: string; List: TStrings): integer;
var
  I: integer;
begin
  for I := 0 to m_QuickList.Count - 1 do begin
    if CompareLStr(m_QuickList.Strings[i], sChrName, length(sChrName)) then begin
      List.AddObject(m_QuickList.Strings[i], m_QuickList.Objects[i]);
    end;
  end;
  Result := List.Count;
end;

function TFileDB.Delete(nIndex: integer): boolean;
var
  I:   integer;
  s14: string;
begin
  Result := False;

  for I := 0 to m_QuickList.Count - 1 do begin
    if integer(m_QuickList.Objects[i]) = nIndex then begin
      s14 := m_QuickList.Strings[i];
      if DeleteRecord(nIndex) then begin
        m_QuickList.Delete(i); //deleting correct index? must test!
        Result := True;
        break;
      end;
    end;
  end;
end;

function TFileDB.DeleteRecord(nIndex: integer): boolean;
var
  sChrName:String;
  sdt:String;
begin
  Result := True;
  sdt := FormatDateTime(SQLDTFORMAT, Now);
  sChrName := m_QuickList[nIndex];

  try
    dbQry.SQL.Clear;
    dbQry.SQL.Add(format('UPDATE TBL_CHARACTER SET FLD_DELETED=1, FLD_CREATEDATE=''%s'' '+
                         'WHERE FLD_CHARNAME=''%s''',
                         [sdt,
                         sChrName]));

    try
      dbQry.Execute;
    except
      Result := False;
      OutMainMessage('[Exception] TFileDB.DeleteRecord');
    end;

    m_boChanged := True;
  finally
    dbQry.Close;
  end;
end;

procedure TFileDB.Rebuild;//0x0048A688
var
  sTempFileName: string;
  nHandle, n10:  integer;
//  DBHeader:      TDBHeader;
  ChrRecord:     THumDataInfo;
begin
{  sTempFileName := 'Mir#$00.DB';
  if FileExists(sTempFileName) then DeleteFile(sTempFileName);
  nHandle := FileCreate(sTempFileName);
  n10     := 0;
  if nHandle < 0 then exit;
  try
    if Open then begin
      FileSeek(m_nFileHandle, 0, 0);
      if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      begin
        FileWrite(nHandle, DBHeader, SizeOf(TDBHeader));
        while (True) do begin
          if FileRead(m_nFileHandle, ChrRecord, SizeOf(THumDataInfo)) =
            SizeOf(THumDataInfo) then begin
            if ChrRecord.Header.boDeleted then Continue;
            FileWrite(nHandle, ChrRecord, SizeOf(THumDataInfo));
            Inc(n10);
          end else
            break;
        end;
        DBHeader.nHumCount   := n10;
        DBHeader.dUpdateDate := Now();
        FileSeek(nHandle, 0, 0);
        FileWrite(nHandle, DBHeader, SizeOf(TDBHeader));
      end;
    end;
  finally
    Close;
  end;
  FileClose(nHandle);
  FileCopy(sTempFileName, m_sDBFileName);
  DeleteFile(sTempFileName);}
end;

function TFileDB.Count: integer;
begin
  Result := m_QuickList.Count;
end;

function TFileDB.Delete(sChrName: string): boolean;
var
  nIndex: integer;
begin
  Result := False;
  nIndex := m_QuickList.GetIndex(sChrName);
  if nIndex < 0 then exit;
  if DeleteRecord(nIndex) then begin
    m_QuickList.Delete(nIndex);
    Result := True;
  end;
end;





initialization
begin
  CoInitialize(nil);

  ADOConnection := TMSConnection.Create(nil);
//  ADOConnection.OnError := MSConnectionError;
  dbQry := TMSQuery.Create(nil);
end;

finalization
begin
  dbQry.Free;
  ADOConnection.Free;

  CoUnInitialize;
end;

end.
