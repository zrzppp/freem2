unit Mudutil;

interface
uses
  svn, Classes;
type
  TQuickList = class(TStringList)
  
  end;
implementation


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: MudUtil.pas 121 2006-08-06 01:10:41Z Dataforce $');
end.
