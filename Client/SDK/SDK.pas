unit SDK;

interface

uses
  svn, Windows, Classes;

type

  TGList=Class(TList)
  private
    CriticalSection:TRTLCriticalSection;

  public
    Constructor Create;
    Destructor  Destroy;override;

    procedure Lock;
    Procedure UnLock;
  end;

  TGStringList=Class(TStringList)
  private
    CriticalSection:TRTLCriticalSection;

  public
    Constructor Create;
    Destructor  Destroy;override;
    
    procedure Lock;
    Procedure UnLock;
  end;

implementation


{ TGList }

constructor TGList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TGList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

procedure TGList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TGList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

{ TGStringList }

constructor TGStringList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TGStringList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

procedure TGStringList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TGStringList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: SDK.pas 121 2006-08-06 01:10:41Z Dataforce $');
end.

