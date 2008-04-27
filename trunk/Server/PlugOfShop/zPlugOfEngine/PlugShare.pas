unit PlugShare;

interface
uses
  Windows, Classes, EngineAPI, EngineType;
type
  TShopInfo = record
    StdItem: _TSTDITEM;
    sIntroduce:array [0..50] of Char;
  end;
  pTShopInfo = ^TShopInfo;
var
  PlugHandle: Integer;
  PlugClass: string = 'Config';
  g_ShopItemList: Classes.TList;
implementation

end.

