unit ClFunc;

interface

uses
  svn, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DirectX, DXClass, Grobal2, ExtCtrls, HUtil32, EdCode;


const
   DR_0      = 0;
   DR_1      = 1;
   DR_2      = 2;
   DR_3      = 3;
   DR_4      = 4;
   DR_5      = 5;
   DR_6      = 6;
   DR_7      = 7;
   DR_8      = 8;
   DR_9      = 9;
   DR_10      = 10;
   DR_11      = 11;
   DR_12      = 12;
   DR_13      = 13;
   DR_14      = 14;
   DR_15      = 15;

type
   TDynamicObject = record
      X: integer;
      Y: integer;
      px: integer;  //shiftx ,y
      py: integer;
      DSurface: TDirectDrawSurface;
   end;
   PTDynamicObject = ^TDynamicObject;
var
   DropItems: TList;  //lsit of TClientItem

function  fmStr (str: string; len: integer): string;
function  GetGoldStr (gold: integer): string;
procedure SaveBags (flname: string; pbuf: Pbyte);
procedure Loadbags (flname: string; pbuf: Pbyte);
procedure SaveStores (flname: string; pbuf: Pbyte);
procedure LoadStores (flname: string; pbuf: Pbyte);
procedure ClearBag;
procedure ClearStore;
function  AddItemBag (cu: TClientItem): Boolean;
function AddItemStore (cu: TClientItem): Boolean;
function  AddItemBagst (cu: TClientItem): Boolean;
procedure Fillquickslots(sname: String;position: integer);
function  UpdateItemBag (cu: TClientItem): Boolean;
function  DelItemBag (iname: string; iindex: integer): Boolean;
procedure ArrangeItemBag;
procedure ArrangeItemStore;
procedure AddDropItem (ci: TClientItem);
function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
procedure DelDropItem (iname: string; MakeIndex: integer);
procedure AddRefineItem (ci: TClientItem);
procedure DelRefineItem (ci: TClientItem);
procedure AddDealItem (ci: TClientItem);
procedure DelDealItem (ci: TClientItem);
procedure MoveDealItemToBag;
procedure MoveRefineItemToBag;
procedure AddDealRemoteItem (ci: TClientItem);
procedure DelDealRemoteItem (ci: TClientItem);
function  GetDistance (sx, sy, dx, dy: integer): integer;
procedure GetNextPosXY (dir: byte; var x, y:Integer);
procedure GetNextRunXY (dir: byte; var x, y:Integer);
procedure GetNextHorseRunXY (dir: byte; var x, y:Integer);
function  GetNextDirection (sx, sy, dx, dy: Integer): byte;
function  GetBack (dir: integer): integer;
procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
function  PrivDir (ndir: integer): integer;
function  NextDir (ndir: integer): integer;
procedure BoldTextOut (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);
function  GetTakeOnPosition (smode: integer): integer;
function  IsKeyPressed (key: byte): Boolean;

procedure AddChangeFace (recogid: integer);
procedure DelChangeFace (recogid: integer);
function  IsChangingFace (recogid: integer): Boolean;

procedure LoadDecoList();
function  FindDecoration(Number:integer):pTDecoItem;

implementation

uses
   clMain, MShare, Share;


function fmStr (str: string; len: integer): string;
var i: integer;
begin
try
   Result := str + ' ';
   for i:=1 to len - Length(str)-1 do
      Result := Result + ' ';
except
	Result := str + ' ';
end;
end;

function  GetGoldStr (gold: integer): string;
var
   i, n: integer;
   str: string;
begin
   str := IntToStr (gold);
   n := 0;
   Result := '';
   for i:=Length(str) downto 1 do begin
      if n = 3 then begin
         Result := str[i] + ',' + Result;
         n := 1;
      end else begin
         Result := str[i] + Result;
         Inc(n);
      end;
   end;
end;

procedure SaveBags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then
      fhandle := FileOpen (flname, fmOpenWrite or fmShareDenyNone)
   else fhandle := FileCreate (flname);
   if fhandle > 0 then begin
      FileWrite (fhandle, pbuf^, sizeof(TClientItem) * MAXBAGITEMCL);
      FileClose (fhandle);
   end;
end;

procedure Loadbags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, pbuf^, sizeof(TClientItem) * MAXBAGITEMCL);
         FileClose (fhandle);
      end;
   end;
end;

procedure SaveStores (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then
      fhandle := FileOpen (flname, fmOpenWrite or fmShareDenyNone)
   else fhandle := FileCreate (flname);
   if fhandle > 0 then begin
      FileWrite (fhandle, pbuf^, sizeof(TClientItem) * MAXSTORAGEITEMCL);
      FileClose (fhandle);
   end;
end;

procedure LoadStores (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, pbuf^, sizeof(TClientItem) * MAXSTORAGEITEMCL);
         FileClose (fhandle);
      end;
   end;
end;

procedure ClearBag;
var
   i: integer;
begin
   for i:=0 to MAXBAGITEMCL-1 do
      g_ItemArr[i].S.Name := '';
end;

procedure ClearStore;
var
   i: integer;
begin
   for i:=0 to MAXSTORAGEITEMCL-1 do
      g_StoreItem[i].S.Name := '';
end;

function  AddItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to MAXBAGITEMCL-1 do begin
      if (g_ItemArr[i].MakeIndex = cu.MakeIndex) and (g_ItemArr[i].S.Name = cu.S.Name) then begin
         //exit;
        if cu.S.StdMode = 45 then begin
          Result := TRUE;
          inc(g_ItemArr[i].Amount);
          exit;
        end;
      end;
   end;

   if cu.S.Name = '' then exit;
   if cu.S.StdMode <= 3 then begin
      for i:=0 to 5 do
         if g_ItemArr[i].S.Name = '' then begin
            g_ItemArr[i] := cu;
            Result := TRUE;
            exit;
         end;
   end;
   for i:=6 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[i].S.Name = '' then begin
         g_ItemArr[i] := cu;
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
end;

function AddItemStore (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to MAXSTORAGEITEMCL-1 do begin
      if (g_StoreItem[i].MakeIndex = cu.MakeIndex) and (g_StoreItem[i].S.Name = cu.S.Name) then begin
         //exit;
        if cu.S.StdMode = 45 then begin
          Result := TRUE;
          inc(g_StoreItem[i].Amount);
          exit;
        end;
      end;
   end;

   if cu.S.Name = '' then exit;
   for i:=0 to MAXSTORAGEITEMCL-1 do begin
      if g_StoreItem[i].S.Name = '' then begin
         g_StoreItem[i] := cu;
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItemStore;
end;

function  AddItemBagst (cu: TClientItem): Boolean;
var
  i:integer;
begin
  Result := FALSE;

  if cu.Amount > 1 then begin
    for i:=0 to MAXBAGITEMCL-1 do begin
      if (g_ItemArr[i].MakeIndex = cu.MakeIndex) and (g_ItemArr[i].S.Name = cu.S.Name) then begin
        inc(g_ItemArr[i].Amount,cu.Amount);
        Result := TRUE;
        exit;
      end;
    end;
    Result := AddItemBag(cu);
  end else
    Result := AddItemBag (cu);
end;

procedure Fillquickslots(sname: String;position: integer);
var
  i: integer;
begin

  if position = -1 then begin
    for i := 0 to 6 do begin
      if g_ItemArr[i].S.Name = sName then begin
        position := 1;
        break
      end;
    end;
  end;
  if g_ItemArr[position].S.Name <> '' then exit;
  for i:=6 to MAXBAGITEMCL-1 do begin
    if (g_ItemArr[i].S.Name = sName) and (g_ItemArr[i].S.StdMode <= 3) then begin
      g_ItemArr[position] := g_ItemArr[i];
      FillChar (g_ItemArr[i], sizeof(TClientItem), #0);
      exit;
    end;
  end;
end;


function  UpdateItemBag (cu: TClientItem): Boolean;
var
   i: integer;
   ItemEffect:pTItemEffect;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_ItemArr[i].S.Name = cu.S.Name) and (g_ItemArr[i].MakeIndex = cu.MakeIndex) then begin
         g_ItemArr[i] := cu;
         Result := TRUE;
         //add playsound
         //startup the item effect (sparkling)
         new(ItemEffect);
         ItemEffect.Idx := i;
         ItemEffect.n_CurrentFrame := 0;
         ItemEffect.n_StartFrame := 410;
         ItemEffect.n_EndFrame := 9;
         ItemEffect.n_NextFrame := 150;
         ItemEffect.n_LastFrame := GetTickCount;
         g_ItemEffects.Add(ItemEffect);
         break;
      end;
   end;
end;

function  DelItemBag (iname: string; iindex: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_ItemArr[i].S.Name = iname) and (g_ItemArr[i].MakeIndex = iindex) then begin
         FillChar (g_ItemArr[i], sizeof(TClientItem), #0);
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
end;

procedure ArrangeItemBag;
var
   i, k: integer;
begin
   for i:=0 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[i].S.Name <> '' then begin
         for k:=i+1 to MAXBAGITEMCL-1 do begin
            if (g_ItemArr[i].S.Name = g_ItemArr[k].S.Name) and (g_ItemArr[i].MakeIndex = g_ItemArr[k].MakeIndex) then begin
              if g_ItemArr[k].S.StdMode = 45 then FillChar (g_ItemArr[k], sizeof(TClientItem), #0);
            end;
         end;
         {for k:=0 to 9 do begin
            if (ItemArr[i].S.Name = DealItems[k].S.Name) and (ItemArr[i].MakeIndex = DealItems[k].MakeIndex) then begin
               FillChar (ItemArr[i], sizeof(TClientItem), #0);
               //FillChar (DealItems[k], sizeof(TClientItem), #0);
            end;
         end; }
         if (g_ItemArr[i].S.Name = g_MovingItem.Item.S.Name) and (g_ItemArr[i].MakeIndex = g_MovingItem.Item.MakeIndex) then begin
            g_MovingItem.Index := 0;
            g_MovingItem.Item.S.Name := '';
         end;
      end;
   end;

   for i:=46 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[i].S.Name <> '' then begin
         for k:=6 to 45 do begin
            if g_ItemArr[k].S.Name = '' then begin
               g_ItemArr[k] := g_ItemArr[i];
               g_ItemArr[i].S.Name := '';
               break;
            end;
         end;
      end;
   end;
end;

procedure ArrangeItemStore;
var
   i, k: integer;
begin
   for i:=0 to MAXSTORAGEITEMCL-1 do begin
      if g_StoreItem[i].S.Name <> '' then begin
         for k:=i+1 to MAXSTORAGEITEMCL-1 do begin
            if (g_StoreItem[i].S.Name = g_StoreItem[k].S.Name) and (g_StoreItem[i].MakeIndex = g_StoreItem[k].MakeIndex) then begin
              if g_StoreItem[k].S.StdMode = 45 then FillChar (g_StoreItem[k], sizeof(TClientItem), #0);
            end;
         end;

         if (g_StoreItem[i].S.Name = g_MovingItem.Item.S.Name) and (g_StoreItem[i].MakeIndex = g_MovingItem.Item.MakeIndex) then begin
            g_MovingItem.Index := 0;
            g_MovingItem.Item.S.Name := '';
         end;
      end;
   end;

   for i:=80 to MAXSTORAGEITEMCL-1 do begin
      if g_StoreItem[i].S.Name <> '' then begin
         for k:=0 to 79 do begin
            if g_StoreItem[k].S.Name = '' then begin
               g_StoreItem[k] := g_StoreItem[i];
               g_StoreItem[i].S.Name := '';
               break;
            end;
         end;
      end;
   end;
end;
{----------------------------------------------------------}

procedure AddDropItem (ci: TClientItem);
var
   pc: PTClientItem;
begin
   new (pc);
   pc^ := ci;
   DropItems.Add (pc);
end;

function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
var
   i: integer;
begin
   Result := nil;
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Result := PTClientItem(DropItems[i]);
         break;
      end;
   end;
end;

procedure DelDropItem (iname: string; MakeIndex: integer);
var
   i: integer;
begin
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Dispose (PTClientItem(DropItems[i]));
         DropItems.Delete (i);
         break;
      end;
   end;
end;

procedure AddRefineItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 15-1 do begin
      if g_RefineItems[i].S.Name = '' then begin
         g_RefineItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelRefineItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 16-1 do begin
      if (g_RefineItems[i].S.Name = ci.S.Name) and (g_RefineItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_RefineItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;
{----------------------------------------------------------}

procedure AddDealItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if g_DealItems[i].S.Name = '' then begin
         g_DealItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelDealItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if (g_DealItems[i].S.Name = ci.S.Name) and (g_DealItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_DealItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

procedure MoveRefineItemToBag;
var
   I,II: integer;
   boAdded:Boolean;
begin
  for i:=0 to 10-1 do begin
    if g_RefineItems[i].S.Name <> '' then begin
      boAdded:=FALSE;
      if g_RefineItems[i].S.StdMode = 45 then begin //only stdmode 45 stacks
            for II:=0 to MAXBAGITEMCL-1 do begin
              if (g_ItemArr[II].MakeIndex = g_RefineItems[I].MakeIndex) and (g_ItemArr[II].S.Name = g_RefineItems[I].S.Name) then begin
                inc(g_ItemArr[II].Amount,g_RefineItems[I].Amount);
                boAdded:=TRUE;
                continue;
              end;
            end;
      end;
      if boAdded = FALSE then
        AddItemBag (g_RefineItems[i]);
    end;
  end;
  FillChar (g_RefineItems, sizeof(TClientItem)*16, #0);
end;

procedure MoveDealItemToBag;
var
   I,II: integer;
   boAdded:Boolean;
begin
  for i:=0 to 10-1 do begin
    if g_DealItems[i].S.Name <> '' then begin
      boAdded:=FALSE;
      if g_DealItems[i].S.StdMode = 45 then begin //only stdmode 45 stacks
            for II:=0 to MAXBAGITEMCL-1 do begin
              if (g_ItemArr[II].MakeIndex = g_DealItems[I].MakeIndex) and (g_ItemArr[II].S.Name = g_DealItems[I].S.Name) then begin
                inc(g_ItemArr[II].Amount,g_DealItems[I].Amount);
                boAdded:=TRUE;
                continue;
              end;
            end;
      end;
      if boAdded = FALSE then
        AddItemBag (g_DealItems[i]);
    end;
  end;
  FillChar (g_DealItems, sizeof(TClientItem)*10, #0);
end;

procedure AddDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 20-1 do begin
      if g_DealRemoteItems[i].S.Name = '' then begin
         g_DealRemoteItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 20-1 do begin
      if (g_DealRemoteItems[i].S.Name = ci.S.Name) and (g_DealRemoteItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_DealRemoteItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

{----------------------------------------------------------}

function  GetDistance (sx, sy, dx, dy: integer): integer;
begin
   Result := _MAX(abs(sx-dx), abs(sy-dy));
end;

procedure GetNextPosXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:     begin x := x;   y := y-1; end;
      DR_UPRIGHT:   begin x := x+1; y := y-1; end;
      DR_RIGHT:  begin x := x+1; y := y; end;
      DR_DOWNRIGHT:  begin x := x+1; y := y+1; end;
      DR_DOWN:   begin x := x;   y := y+1; end;
      DR_DOWNLEFT:   begin x := x-1; y := y+1; end;
      DR_LEFT:   begin x := x-1; y := y; end;
      DR_UPLEFT:  begin x := x-1; y := y-1; end;
   end;
end;

procedure GetNextRunXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:     begin x := x;   y := y-2; end;
      DR_UPRIGHT:   begin x := x+2; y := y-2; end;
      DR_RIGHT:  begin x := x+2; y := y; end;
      DR_DOWNRIGHT:  begin x := x+2; y := y+2; end;
      DR_DOWN:   begin x := x;   y := y+2; end;
      DR_DOWNLEFT:   begin x := x-2; y := y+2; end;
      DR_LEFT:   begin x := x-2; y := y; end;
      DR_UPLEFT:  begin x := x-2; y := y-2; end;
   end;
end;
procedure GetNextHorseRunXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:     begin x := x;   y := y-3; end;
      DR_UPRIGHT:   begin x := x+3; y := y-3; end;
      DR_RIGHT:  begin x := x+3; y := y; end;
      DR_DOWNRIGHT:  begin x := x+3; y := y+3; end;
      DR_DOWN:   begin x := x;   y := y+3; end;
      DR_DOWNLEFT:   begin x := x-3; y := y+3; end;
      DR_LEFT:   begin x := x-3; y := y; end;
      DR_UPLEFT:  begin x := x-3; y := y-3; end;
   end;
end;
function GetNextDirection (sx, sy, dx, dy: Integer): byte;
var
   flagx, flagy: integer;
begin
   Result := DR_DOWN;
   if sx < dx then flagx := 1
   else if sx = dx then flagx := 0
   else flagx := -1;
   if abs(sy-dy) > 2
    then if (sx >= dx-1) and (sx <= dx+1) then flagx := 0;

   if sy < dy then flagy := 1
   else if sy = dy then flagy := 0
   else flagy := -1;
   if abs(sx-dx) > 2 then if (sy > dy-1) and (sy <= dy+1) then flagy := 0;

   if (flagx = 0)  and (flagy = -1) then Result := DR_UP;
   if (flagx = 1)  and (flagy = -1) then Result := DR_UPRIGHT;
   if (flagx = 1)  and (flagy = 0)  then Result := DR_RIGHT;
   if (flagx = 1)  and (flagy = 1)  then Result := DR_DOWNRIGHT;
   if (flagx = 0)  and (flagy = 1)  then Result := DR_DOWN;
   if (flagx = -1) and (flagy = 1)  then Result := DR_DOWNLEFT;
   if (flagx = -1) and (flagy = 0)  then Result := DR_LEFT;
   if (flagx = -1) and (flagy = -1) then Result := DR_UPLEFT;
end;

function  GetBack (dir: integer): integer;
begin
   Result := DR_UP;
   case dir of
      DR_UP:     Result := DR_DOWN;
      DR_DOWN:   Result := DR_UP;
      DR_LEFT:   Result := DR_RIGHT;
      DR_RIGHT:  Result := DR_LEFT;
      DR_UPLEFT:     Result := DR_DOWNRIGHT;
      DR_UPRIGHT:    Result := DR_DOWNLEFT;
      DR_DOWNLEFT:   Result := DR_UPRIGHT;
      DR_DOWNRIGHT:  Result := DR_UPLEFT;
   end;
end;

procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
   newx := sx;
   newy := sy;
   case dir of
      DR_UP:      newy := newy+1;
      DR_DOWN:    newy := newy-1;
      DR_LEFT:    newx := newx+1;
      DR_RIGHT:   newx := newx-1;
      DR_UPLEFT:
         begin
            newx := newx + 1;
            newy := newy + 1;
         end;
      DR_UPRIGHT:
         begin
            newx := newx - 1;
            newy := newy + 1;
         end;
      DR_DOWNLEFT:
         begin
            newx := newx + 1;
            newy := newy - 1;
         end;
      DR_DOWNRIGHT:
         begin
            newx := newx - 1;
            newy := newy - 1;
         end;
   end;
end;

procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
   newx := sx;
   newy := sy;
   case dir of
      DR_UP:      newy := newy-1;
      DR_DOWN:    newy := newy+1;
      DR_LEFT:    newx := newx-1;
      DR_RIGHT:   newx := newx+1;
      DR_UPLEFT:
         begin
            newx := newx - 1;
            newy := newy - 1;
         end;
      DR_UPRIGHT:
         begin
            newx := newx + 1;
            newy := newy - 1;
         end;
      DR_DOWNLEFT:
         begin
            newx := newx - 1;
            newy := newy + 1;
         end;
      DR_DOWNRIGHT:
         begin
            newx := newx + 1;
            newy := newy + 1;
         end;
   end;
end;

function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
   fx := ttx - sx;
   fy := tty - sy;
   sx := 0;
   sy := 0;
   Result := DR_DOWN;
   if fx=0 then begin
      if fy < 0 then Result := DR_UP
      else Result := DR_DOWN;
      exit;
   end;
   if fy=0 then begin
      if fx < 0 then Result := DR_LEFT
      else Result := DR_RIGHT;
      exit;
   end;
   if (fx > 0) and (fy < 0) then begin
      if -fy > fx*2.5 then Result := DR_UP
      else if -fy < fx/3 then Result := DR_RIGHT
      else Result := DR_UPRIGHT;
   end;
   if (fx > 0) and (fy > 0) then begin
      if fy < fx/3 then Result := DR_RIGHT
      else if fy > fx*2.5 then Result := DR_DOWN
      else Result := DR_DOWNRIGHT;
   end;
   if (fx < 0) and (fy > 0) then begin
      if fy  < -fx/3 then Result := DR_LEFT
      else if fy > -fx*2.5 then Result := DR_DOWN
      else Result := DR_DOWNLEFT;
   end;
   if (fx < 0) and (fy < 0) then begin
      if -fy > -fx*2.5 then Result := DR_UP
      else if -fy < -fx/3 then Result := DR_LEFT
      else Result := DR_UPLEFT;
   end;
end;

function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
   fx := ttx - sx;
   fy := tty - sy;
   sx := 0;
   sy := 0;
   Result := 0;
   if fx=0 then begin
      if fy < 0 then Result := 0
      else Result := 8;
      exit;
   end;
   if fy=0 then begin
      if fx < 0 then Result := 12
      else Result := 4;
      exit;
   end;
   if (fx > 0) and (fy < 0) then begin
      Result := 4;
      if -fy > fx/4 then Result := 3;
      if -fy > fx/1.9 then Result := 2;
      if -fy > fx*1.4 then Result := 1;
      if -fy > fx*4 then Result := 0;
   end;
   if (fx > 0) and (fy > 0) then begin
      Result := 4;
      if fy > fx/4 then Result := 5;
      if fy > fx/1.9 then Result := 6;
      if fy > fx*1.4 then Result := 7;
      if fy > fx*4 then Result := 8;
   end;
   if (fx < 0) and (fy > 0) then begin
      Result := 12;
      if fy > -fx/4 then Result := 11;
      if fy > -fx/1.9 then Result := 10;
      if fy > -fx*1.4 then Result := 9;
      if fy > -fx*4 then Result := 8;
   end;
   if (fx < 0) and (fy < 0) then begin
      Result := 12;
      if -fy > -fx/4 then Result := 13;
      if -fy > -fx/1.9 then Result := 14;
      if -fy > -fx*1.4 then Result := 15;
      if -fy > -fx*4 then Result := 0;
   end;
end;

function  PrivDir (ndir: integer): integer;
begin
   if ndir - 1 < 0 then Result := 7
   else Result := ndir-1;
end;

function  NextDir (ndir: integer): integer;
begin
   if ndir + 1 > 7 then Result := 0
   else Result := ndir+1;
end;

procedure BoldTextOut (surface: TDirectDrawSurface; x, y, fcolor, bcolor: integer; str: string);
begin
   with surface do begin
      Canvas.Font.Color := bcolor;
      Canvas.TextOut (x-1, y, str);
      Canvas.TextOut (x+1, y, str);
      Canvas.TextOut (x, y-1, str);
      Canvas.TextOut (x, y+1, str);
      Canvas.Font.Color := fcolor;
      Canvas.TextOut (x, y, str);
   end;
end;

function  GetTakeOnPosition (smode: integer): integer;
begin
   Result := -1;
   case smode of //StdMode
      5, 6     :Result := U_WEAPON;   //ÎäÆ÷
      10, 11, 12   :Result := U_DRESS;//¿ø¼×
      15,16    :Result := U_HELMET;   //Í·¿ø
      19,20,21 :Result := U_NECKLACE; //ÏîÁ´
      22,23    :Result := U_RINGR;    //½äÖ¸
      24,26    :Result := U_ARMRINGR;
      30,28,29 :Result := U_RIGHTHAND;
      25,51    :Result := U_BUJUK; //·û
      52,62    :Result := U_BOOTS; //Ð¬
      53,63    :Result := U_CHARM; //±¦Ê¯
      54,64    :Result := U_BELT;  //Ñü´ø
   end;
end;

function  IsKeyPressed (key: byte): Boolean;
var
   keyvalue: TKeyBoardState;
begin
   Result := FALSE;
   FillChar(keyvalue, sizeof(TKeyboardState), #0);
   if GetKeyboardState (keyvalue) then
      if (keyvalue[key] and $80) <> 0 then
         Result := TRUE;
end;

procedure AddChangeFace (recogid: integer);
begin
   g_ChangeFaceReadyList.Add (pointer(recogid));
end;

procedure DelChangeFace (recogid: integer);
var
   i: integer;
begin
   for i:=0 to g_ChangeFaceReadyList.Count-1 do begin
      if integer(g_ChangeFaceReadyList[i]) = recogid then begin
         g_ChangeFaceReadyList.Delete (i);
         break;
      end;
   end;
end;

function  IsChangingFace (recogid: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to g_ChangeFaceReadyList.Count-1 do begin
      if integer(g_ChangeFaceReadyList[i]) = recogid then begin
         Result := TRUE;
         break;
      end;
   end;
end;

procedure LoadDecoList(); //00488CDC
var
  I,n14:Integer;
  s18,s20,s24:String;
  LoadList:TStringList;
  sFileName:String;
  Decoration:pTDecoItem;
begin
  g_DecoList:= TList.create;
  sFileName:= 'Data\DecoItem.txt';
  if FileExists(sFileName) then begin
    LoadList:=TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    s24:='';
    for I := 0 to LoadList.Count - 1 do begin
      s18:=Trim(LoadList.Strings[I]);
      if (s18 <> '') and (s18[1] <> ';') then begin
        new(Decoration);
        s18:=GetValidStr3(s18,s20,[' ',#9]);
        n14:=Str_ToInt(Trim(s20),0);
        Decoration.Appr := n14;
        s18:=GetValidStr3(s18,s20,[' ',#9]);
        Decoration.Name := s20;
        s18:=GetValidStr3(s18,s20,[' ',#9]);
        n14:=Str_ToInt(Trim(s20),0);
        Decoration.Location := n14;
        n14:=Str_ToInt(Trim(s18),0);
        Decoration.Price := n14;
        g_DecoList.Add(Decoration);
      end;
    end;    // for
    LoadList.Free;
  end;
end;

function FindDecoration(Number:integer):pTDecoItem;
var
  i:integer;
begin
  result := nil;
  for i:= 0 to g_DecoList.count -1 do begin
    if pTDecoItem(g_DecoList[i]).Appr = Number then begin
      result := g_DecoList[i];
      exit;
    end;
  end;
end;

Initialization
begin
  {---- Adjust global SVN revision ----}
  SVNRevision('$Id: ClFunc.pas 562 2007-01-19 16:33:33Z sean $');
  DropItems := TList.Create;
end
Finalization
DropItems.Free;

end.
