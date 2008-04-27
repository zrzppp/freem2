unit GuildTerritory;

interface
uses
  svn, Windows, SysUtils, Classes,IniFiles,Guild, DateUtils, Grobal2;
Type
  pTGTDecoration = ^TGTDecoration;
  TGTDecoration=record
    Appr:integer;
    X:integer;
    Y:integer;
    Starttime:DWord;
    Map:TObject;
  end;

  TTerritory= class
    TerritoryNumber:Byte;
    GuildName:String;
    RegDate:TDateTime;
    RegEnd:TDateTime;
    ForSale:Boolean;
    ForSaleGold:LongWord;
    BuyerGName:String;
    ForSaleEnd:TDateTime;
    Decorations: TList;
  public
    constructor Create();
    destructor Destroy; override;
    function  GetGuildname():String;
    function  ExpireDate():String;
    function  DaysRemaining():String;
    function  UserLogon():String;
    procedure NewOwner(newGuildName:String);
    function  Buy(newGuildName:String):boolean;
    procedure Extend();
    function  DecoCount(Envir:TObject):integer;
    function  GetClientGT():TClientGT;
    function  StartSale(Price:Integer):boolean;
    function  StopSale():boolean;
    procedure Revolt();
    procedure KickPlayers();
    procedure NewDecoration(UserItem:pTUserITem;X,Y:integer;Map:TObject;Save:boolean);
    procedure DeleteDecoration(X,Y:integer;Map:TObject);
    procedure Wipe();
    procedure SendGuildMsg(sMsg:String);
  end;

  TGTManager= class
    ProcessTick:LongWord;
  private
  //In
  public
    GTlist: TList;
    constructor Create();
    destructor Destroy; override;
    procedure Run();//still need to add this
    procedure SaveAll();
    procedure LoadAll(); //after mapinfo is fully loaded load the stats for guild territory's
    procedure AddEmptyGT(number:integer); //when loading mapinfo add an empty value first
    function  FindGuildTerritory(Number:Integer):TTerritory;overload;
    function  FindGuildTerritory(GuildName:String):TTerritory;overload;
    function  FindGuildTerritoryEx(GuildName:String):TTerritory;
    function  BuyFirstFreeGT(GuildName:String):boolean;
//    function GetGTHomeMap(
  end;
implementation
uses LocalDB, ObjBase, Envir, ItmUnit, M2Share, HUtil32, svMain;

constructor TGTManager.Create;
begin
  GTList:=TList.Create;
  ProcessTick:=GetTickCount();
end;

destructor TGTManager.Destroy;
begin
  GTList.Free();
  inherited;
end;

procedure TGTManager.SaveAll();
var
  i:integer;
begin
  for i:=0 to GTList.count -1 do begin
    FrmDB.SaveGT(GTList[i]);
  end;
end;
procedure TGTManager.LoadAll();
var
  i:integer;
begin
  for i:=0 to GTList.count -1 do begin
    FrmDB.LoadGT(TTerritory(GTList[i]).TerritoryNumber, i);
  end;
end;

procedure TGTManager.AddEmptyGT(number: integer);
var
  GT:TTerritory;
begin
  GT := TTerritory.Create;
  GT.TerritoryNumber := number;
  GT.GuildName :='';
  GT.RegDate := now();
  GT.RegEnd := now();
  GT.ForSale:=True;
  GT.ForSaleEnd := now();
  GT.ForSaleGold := g_config.nGTBuyFee;
  GT.BuyerGName := '';
  GTList.Add(GT)
end;

function TGTManager.FindGuildTerritoryEx(GuildName:String):TTerritory;
var
  i:integer;
begin
  result:=nil;
  for i:=0 to GTList.count -1 do begin
    if (TTerritory(GTList[i]).GuildName = GuildName) or (TTerritory(GTList[i]).BuyerGName = GuildName) then begin
      result:= GTList[i];
      exit;
    end;
  end;
end;

function TGTManager.FindGuildTerritory(GuildName:String):TTerritory;
var
  i:integer;
begin
  result:=nil;
  for i:=0 to GTList.count -1 do begin
    if TTerritory(GTList[i]).GuildName = GuildName then begin
      result:= GTList[i];
      exit;
    end;
  end;
end;



function TGTManager.FindGuildTerritory(number:Integer):TTerritory;
var
  i:integer;
begin
  result:=nil;
  for i:=0 to GTList.count -1 do begin
    if TTerritory(GTList[i]).TerritoryNumber = number then begin
      result:=GTList[i];
      exit;
    end;
  end;
end;

function TGTManager.BuyFirstFreeGT(GuildName:String):boolean;
var
  i:integer;
  GT:TTerritory;
begin
  result:=false;
  for i:=0 to GTList.count -1 do begin
    GT:=GTList[i];
    if (GT.GuildName = '') and (GT.BuyerGName = '') and (GT.ForSale) then begin
      result:=GT.Buy(GuildName);
      exit;
    end;
  end;
end;

procedure TGTManager.Run();
var
  I,II,III    :integer;
  GT          :TTerritory;
  Decoration  :pTGTDecoration;
  MapCellInfo :pTMapCellinfo;
  OSObject    :pTOSObject;
begin
  if (GetTickCount - ProcessTick) < 60000 then exit; //only process every minute no need to do more
  ProcessTick := GetTickCount;
  for I:=0 to GTList.count -1 do begin
    GT:=GTList[I];
    if (IncDay(GT.RegEnd,7) < now) and (GT.GuildName <> '') then begin//if territory expired (give them 7days extra)
      GT.Revolt;
      //tell everyone in guild that we just lost our gt
      continue;
    end;
    if (IncDay(GT.ForSaleEnd,1) <= now) and (GT.buyerGName <> '') then begin
      GT.NewOwner(GT.BuyerGName);
      GT.SendGuildMsg('Your Guild Territory is now ready for use');
      continue;
    end;
    for II:= 1 to 10 do begin
      if (IncDay(GT.RegEnd,7) < IncMinute(now(),II)) and (GT.GuildName <> '') then begin
        GT.SendGuildMsg('你的公会领土在 ' + IntToStr(II) + ' 分钟后将会到期');
        continue;
      end;
    end;
    for II:= 0 to GT.Decorations.Count -1 do begin
      Decoration:=GT.Decorations.Items[II];
      if IncDay(UnixToDateTime(Decoration.Starttime),7) < now() then begin
        if TEnvirnoment(Decoration.Map).GetMapCellInfo(Decoration.X,Decoration.Y,MapCellInfo) and (MapCellInfo.ObjList <> nil) then begin
          for III:= 0 to MapCellInfo.ObjList.Count -1 do begin
            OSObject:=MapCellInfo.ObjList.Items[III];
            if (OSObject.btType = OS_ITEMOBJECT) and (pTMapItem(OSObject.CellObj).UserItem.wIndex = UserEngine.GetStdItemIdx(g_Config.sGTDeco)) then begin
              Dispose(pTMapItem(OSObject.CellObj));
              Dispose(OSObject);
              MapCellInfo.ObjList.Delete(III);
              if MapCellInfo.ObjList.Count > 0 then Continue;
              MapCellInfo.ObjList.Free;
              MapCellInfo.ObjList:=nil;
              break;
            end;
          end;
        end;
        GT.DeleteDecoration(Decoration.X,Decoration.Y, Decoration.Map);
        break;
      end;
    end;
  end;
end;

{TTerritory starts here}

constructor TTerritory.Create;
begin
  inherited;
  decorations:= TList.create;
end;

destructor TTerritory.Destroy;
begin
  inherited;
end;

function TTerritory.GetGuildname():String;
begin
  result:='没有拥有者';
  if BuyerGName <> '' then
    result:=BuyerGName;
  if GuildName <> '' then
    result:=GuildName;
end;

function TTerritory.ExpireDate():String;
begin
  result:='期满';
  if RegEnd > now() then
    result:=DateToStr(RegEnd);
end;

function TTerritory.DaysRemaining():String;
begin
  result:='没有人';
  if RegEnd > now() then
    result:=IntToStr(DaysBetween(now(),RegEnd));
end;


function TTerritory.UserLogon():String;
var
  Hour, Min, Sec, MSec: Word;
  Hour2, Min2, Sec2, MSec2: Word;
begin
  result:='';
  if GuildName <> '' then begin
    if RegEnd < now() then begin
      result:='公会领土 ' +  IntToStr(DaysBetween(now(),RegEnd)) + ' 天前期满';
    end else
      result:='公会领土离到期还有 ' + IntToStr(DaysBetween(now(),RegEnd)) + ' 天';
      exit;
  end else if BuyerGName <> '' then begin
    DecodeTime(ForSaleEnd,Hour, Min, Sec, MSec);
    DecodeTime(now(),Hour2, Min2, Sec2, MSec2);
    result:='GuildTerritory will activate in ' + IntToStr(Hour2 - Hour) + 'Hours ' + IntToStr(Min2 - Min) + 'Minutes';
    exit;
  end;
end;

procedure TTerritory.NewOwner(newGuildName:String);
var
  Guild:TGuild;
begin
  GuildName :=newGuildName;
  RegDate := now();
  RegEnd := IncDay(RegDate,7);//7days
  ForSale := FALSE;
  ForSaleGold := 0;
  BuyerGName := '';
  FrmDB.SaveGT(self);
  KickPlayers();
  Wipe();
  if Guildname <> '' then begin
    Guild:= g_GuildManager.FindGuild(GuildName);
    if Guild <> nil then
      Guild.m_Territory := self;
  end;
end;

procedure TTerritory.Revolt();
var
  Guild:TGuild;
begin
  if Guildname <> '' then begin
    Guild:= g_GuildManager.FindGuild(GuildName);
    if Guild <> nil then
      Guild.m_Territory := nil;
  end;
  GuildName :='';
  RegDate := now();
  RegEnd := now();
  ForSale := True;
  ForSaleGold := g_config.nGTBuyFee;
  BuyerGName := '';
  FrmDB.SaveGT(self);
  KickPlayers();
  Wipe();
end;

function TTerritory.Buy(newGuildName:String):boolean;
var
  Guild:TGuild;
begin
  result:=False;
  if not ForSale then exit; //if it's not for sale then we cant buy it
  if Guildname <> '' then begin
    Guild:= g_GuildManager.FindGuild(GuildName);
    if Guild <> nil then
      Guild.m_Territory := nil;
  end;
  result:=True;
  GuildName:='';
  BuyerGName := newGuildName;
  ForSaleEnd := now();
  ForSale:=False;
  ForSaleGold:=0;
  FrmDB.SaveGT(self);
  KickPlayers();
  Wipe();
end;

procedure TTerritory.Wipe();
var
  Decoration:pTGTDecoration;
  i,ii,itemcount:integer;
  MapItem:pTMapItem;
  StdItem:TItem;
begin
  for i:=0 to Decorations.count -1 do begin
    Decoration := Decorations.Items[i];

    TEnvirnoment(Decoration.Map).GetItemEx(Decoration.X,Decoration.Y,ItemCount);
    for II:= 0 to ItemCount -1 do begin
      if TEnvirnoment(Decoration.Map).DeleteFromMap (Decoration.x, Decoration.y, OS_ITEMOBJECT, TObject(MapItem)) = 1 then begin
        StdItem:=UserEngine.GetStdItem (MapItem.UserItem.wIndex);
        if StdItem.StdMode = 48 then begin
          Dispose(MapItem);
          break;
        end else
          TEnvirnoment(Decoration.Map).AddToMap(Decoration.x, Decoration.y, OS_ITEMOBJECT, TObject(MapItem));
      end;
    end;
    DeleteDecoration(Decoration.X,Decoration.Y, Decoration.Map);
  end;
end;

procedure TTerritory.Extend();
begin
  RegEnd:=IncDay(RegEnd, 7);
  FrmDB.SaveGT(self);
end;

function TTerritory.DecoCount(Envir:TObject):integer;
var
  i,count:integer;
begin
  count:=0;
  for i:=0 to Decorations.count -1 do begin
    if pTGTDecoration(Decorations.items[i]).Map = Envir then
      inc(Count);
  end;
  result:=Count;
end;

function TTerritory.GetClientGT():TClientGT;
var
  output:TClientGT;
  Guild:TGuild;
  GuildRank:pTGuildRank;
begin
  Output.Number := TerritoryNumber;
  Output.Status := 0;
  if GuildName <> '' then begin
    Output.GuildName := GuildName;
  end else if BuyerGName <> '' then begin
    Output.GuildName := BuyerGName;
    Output.Status := 2;
  end else
    Output.GuildName := 'No owner';
  Output.SalePrice := ForSaleGold;
  if ForSale then
    Output.Status := 1;
  Output.GuildMasters[0] := '';
  Output.GuildMasters[1] := '';
  if output.GuildName <> 'No owner' then begin
    Guild:=g_GuildManager.FindGuild(Output.GuildName);
    if Guild.m_RankList.Count > 0 then begin//if the guild has no ranks then dont do this
      GuildRank:=Guild.m_RankList.Items[0];
      if GuildRank.MemberList.Count > 0 then begin
        Output.GuildMasters[0]:=GuildRank.MemberList.Strings[0];
        if GuildRank.MemberList.Count = 2 then
        Output.GuildMasters[1]:=GuildRank.MemberList.Strings[1];
      end;
    end;
  end;
  result:=output;
end;


function TTerritory.StartSale(Price:Integer):boolean;
begin
  result:=false;
  if NOT ForSale then begin
    ForSale := True;
    ForSaleGold := Price;
    result:=True;
    FrmDB.SaveGT(self);
  end;
end;

function TTerritory.StopSale():boolean;
begin
  result:=false;
  if ForSale then begin
    ForSale := False;
    ForSaleGold := 0;
    result:=True;
    FrmDB.SaveGT(self);
  end;
end;

procedure TTerritory.KickPlayers();
var
  I,II:integer;
  Envir:TEnvirnoment;
  BaseObjectList:TList;
  BaseObject:TBaseObject;
  sMapName:String;
begin
  sMapName:='0';
  for I := 0 to g_MapManager.Count - 1 do begin
    Envir:=TEnvirnoment(g_MapManager.Items[I]);
    if (Envir <> nil) and (TTerritory(Envir.m_GuildTerritory) = self) then begin
      BaseObjectList:=TList.Create;
      Envir.GetRangeBaseObject(Envir.Header.wWidth div 2,Envir.Header.wHeight div 2,999,True,BaseObjectList);
      for II := 0 to BaseObjectList.Count - 1 do begin
        BaseObject:=TBaseObject(BaseObjectList.Items[II]);
        if BaseObject.m_btRaceServer = RC_PLAYOBJECT then begin
          TPlayObject(BaseOBject).SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
          TPlayObject(BaseOBject).MapRandomMove(sMapName,0);
        end;
      end;
      BaseObjectList.Free;
    end;
  end;
end;

procedure TTerritory.NewDecoration(UserItem:pTUserITem;X,Y:integer;Map:TObject;Save:boolean);
var
  Decoration:pTGTDecoration;
begin
  new(Decoration);
  Decoration.Appr := MakeWord(UserItem.btValue[5],UserItem.btValue[6]);
  Decoration.X := X;
  Decoration.Y := Y;
  Decoration.Starttime := MakeLong(MakeWord(UserItem.btValue[1],UserItem.btValue[2]),MakeWord(UserItem.btValue[3],UserItem.btValue[4]));
  Decoration.Map := Map;
  Decorations.Add(Decoration);
  if Save then
    FrmDB.SaveDeco(Decoration.Appr,TerritoryNumber,Decoration.X,Decoration.Y,TEnvirnoment(Decoration.Map).sMapName,Decoration.Starttime);
end;

procedure TTerritory.DeleteDecoration(X,Y:integer;Map:TObject);
var
  i:integer;
  Decoration:pTGTDecoration;
begin
  for i:= 0 to Decorations.count -1 do begin
    Decoration:=Decorations.Items[i];
    if (Decoration.X = X) and (Decoration.Y = Y) and (Decoration.Map = Map) then begin
      dispose(Decoration);
      Decorations.Delete(i);
      FrmDB.DeleteDeco(TerritoryNumber, X,Y,TEnvirnoment(Map).sMapName);
      exit;
    end;
  end;
end;

procedure TTerritory.SendGuildMsg(sMsg:String);
var
  Guild:TGuild;
begin
  if GuildName <> '' then begin
    Guild:=g_GuildManager.FindGuild(GuildName);
    if Guild = nil then exit;
    Guild.SendGuildMsg(sMsg);
  end;
end;

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: GuildTerritory.pas 517 2006-12-15 14:54:40Z damian $');
end.

