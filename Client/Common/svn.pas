// Undefine this to disable SVN Tracking
{$DEFINE SvnTracking}

{*
 * svn - Store global SVN Revision information. 
 * Copyright (C) 2006 Shane "Dataforce" Mc Cormack
 * For conditions of distribution and use, see copyright notice in http://home.dataforce.org.uk/index.php?p=license&l=zlib
 *
 * Based on http://hinata.zipplet.co.uk/wiki/index.php?svntracking2
 * Copywrite (C) 2005 Michael "Zipplet" Nixon
 *
 * SVN: $Id: svn.pas 500 2006-11-01 20:40:19Z damian $
 *}
unit svn;

Interface

uses sysutils, classes;

var
  SVN_ISTracking: Boolean;
{$IFDEF SvnTracking}
  SVN_REVISION: Integer;
  SVN_DETAILS: TStringList;
  SVN_ISCREATED: Boolean;
{$ENDIF}

procedure SVNRevision(IDString: string);

Implementation

{$IFDEF SvnTracking}
function DF_Split(Deliminator: Char; Target: String): TStringList;
var
 i: Integer;
 t: String;
begin
 Result := TStringList.Create;
 t := '';
 for i := 1 to Length(Target) do begin
  if Copy(Target,i,1) = Deliminator then begin
   Result.Add(t);
   t := '';
  end else
   t := t + Copy(Target,i,1);
 end;
 if t <> '' then Result.Add(t);
end;

Function DF_isint(S: String; AllowNegative: Boolean = False): Boolean;
var
  i: integer;
begin
  Result := true;
  if S <> '' then begin
    for i := 1 to length(S) do begin
      if (ord(S[i]) < 48) or (ord(S[i]) > 57) then begin
        if (ord(S[i]) = 45) and (I = 1) and (AllowNegative) then continue;
        Result := false;
        break;
      end;
    end;
  end
  else Result := false;
end;
{$ENDIF}

procedure SVNRevision(IDString: string);
{$IFDEF SvnTracking}
var
  List: TStringList;
  I: Integer;
begin
  if not SVN_ISCREATED then begin
    SVN_REVISION := 0;
    SVN_DETAILS := TStringList.create;
    SVN_ISCREATED := True;
    SVNRevision('$Id: svn.pas 500 2006-11-01 20:40:19Z damian $');
  end;

  SVN_DETAILS.Add(IDString);
  List := DF_Split(' ',IDString);
  if List.count > 3 then begin
    if DF_IsInt(List[2]) then begin
      I := strtoint(List[2]);
      if I > SVN_REVISION then SVN_REVISION := I;
    end;
  end;
{$ELSE}
begin
{$ENDIF}
end;

Initialization
  // Nothing
  {$IFDEF SvnTracking}SVN_ISTracking := True;{$ELSE}SVN_ISTracking := False;{$ENDIF}
Finalization
  {$IFDEF SvnTracking}SVN_DETAILS.destroy;{$ENDIF}
end.








