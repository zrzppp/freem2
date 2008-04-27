unit LDServer;

interface

uses svn, IniFiles, WinSock, WSocket, nixtime, SysUtils, grobal2, Classes, Types;

type
  {$IFDEF WIN32}
     tinetsockaddr = tsockaddrin;
  {$ENDIF}

  tLogItemData = packed record
    nNothing: Byte;
    nServerNumber: Byte;
    nServerIndex: Byte;
    nType: Byte;
    sMapName: String;
    nPositionX: LongInt;
    nPositionY: LongInt;
    sCharName: String;
    sItem: String;
    nData: LongInt;
    sData: String;
    sExtraData: String;
    nTime: LongInt;
  end;

  tLogItem = record
    Data: tLogItemData;
    sFullString: String;
    CleanUp: Boolean;
  end;
  ptLogItem = ^tLogItem;


  tLDSConfig = record
    sListenAddr: String;
    nListenPort: Integer;
    sOutputDir: String;
    sServerName: String;
  end;

  tLDItem = procedure (Sender: TObject; Item: ptLogItem) of object;
  tLDEvent = procedure (Sender: TObject) of object;
  tLDServer = class(TObject)
//    Destructor Destroy; Override;
    constructor Create(ConfigFile: String; Section: String);
    private
      UDPSocket: TWSocket;
      TotalBuffer: String;

      FTag: Integer;
      FConfig: tLDSConfig;
      FOnNewItem: tLDItem;
      FOnErrorItem: tLDItem;

      procedure DataAvail(Sender: TObject; Error: word);
      procedure ProcessUDP(IPInt: longint; Line: String);
    public
      property Tag: integer read FTag write FTag;
      property Config: tLDSConfig read FConfig;      
      property OnNewItem: tLDItem read FOnNewItem write FOnNewItem;
      property OnItemError: tLDItem read FOnErrorItem write FOnErrorItem;

      procedure Test;
      procedure Start;
      procedure Stop;
  end;

implementation  

constructor tLDServer.Create(ConfigFile: String; Section: String);
var
  ini: TMemIniFile;
  sTemp: String;
begin
  ini := TMemIniFile.create(ConfigFile);
  FConfig.sListenAddr := ini.ReadString(Section,'ListenAddr','0.0.0.0');
  FConfig.sServerName := ini.ReadString(Section,'ServerName','');
  FConfig.sOutputDir := ini.ReadString(Section,'OutputDir','.\BaseDir\');
  sTemp := ini.ReadString(Section,'Port','10000');
  try
    FConfig.nListenPort := strtoint(sTemp);
  except
    FConfig.nListenPort := 10000;
  end;
  ini.Free;

  if FConfig.sOutputDir[Length(FConfig.sOutputDir)] <> '\' then FConfig.sOutputDir := FConfig.sOutputDir+'\';

  UDPSocket := TWSocket.Create(nil);
  UDPSocket.Close;
  UDPSocket.Proto := 'UDP';
  UDPSocket.Addr := FConfig.sListenAddr;
  UDPSocket.Port := inttostr(FConfig.nListenPort);
  UDPSocket.OnDataAvailable := Self.DataAvail;
  Start();
end;

procedure tLDServer.Stop;
begin
  TotalBuffer := '';
  UDPSocket.Close;
end;

procedure tLDServer.Start;
begin
  TotalBuffer := '';
  UDPSocket.Listen;
end;

procedure tLDServer.DataAvail(Sender: TObject; Error: word);
var
  f: tsockaddrin;
  Len,I: integer;
  buffer: Array[0..1024]of char;
  IPInt: LongInt;
begin
  // Nothing
    I := sizeof(tsockaddrin);
    Len := TWSocket(Sender).Receivefrom(@Buffer, SizeOf(Buffer), f, I);
    IPInt := f.sin_addr.S_addr;

    for I := 0 to Len-1 do begin
      if Buffer[I] <> #2 then TotalBuffer := TotalBuffer+Buffer[I]
      else begin
        try
          ProcessUDP(IPInt,TotalBuffer);
        finally
          TotalBuffer := '';
        end;
      end;
    end;
end;

procedure tLDServer.Test;
begin
  ProcessUDP(0,'1'+#9+'1'+#9+'1'+#9+'5'+#9+'REALLY LONG SUPER HUGE MAPNAME GOES HERE!'+#9+'300'+#9+'300'+#9+'TestChar'+#9+'VALID PACKET'+#9+'100000000'+#9+'1'+#9+'0');
//  ProcessUDP(0,'0'+#9+'0'+#9+'27'+#9+'LOMCN'+#9+'0'+#9+'1'+#9+'INVALID PACKET'+#9+'Dataforce'+#9+'0'+#9+'1'+#9+'0');
end;

procedure tLDServer.ProcessUDP(IPInt: longint; Line: String);
var
  Parts: TStringList;
  Item: ptLogItem;
  I: Integer;
  Errored: Boolean;
begin
  Errored := False;
  Parts := Split(#9,Line);

  New(Item);

  try
    if Parts.Count >= 5 then Item.Data.sMapName := Parts[4];
    if Parts.Count >= 8 then Item.Data.sCharName := Parts[7];
    if Parts.Count >= 9 then Item.Data.sItem := Parts[8];
    if Parts.Count >= 11 then Item.Data.sData := Parts[10];
    if Parts.Count >= 12 then Item.Data.sExtraData := Parts[11];

    if Parts.Count >= 1 then Item.Data.nNothing := strtoint(Parts[0]);
    if Parts.Count >= 2 then Item.Data.nServerNumber := strtoint(Parts[1]);
    if Parts.Count >= 3 then Item.Data.nServerIndex := strtoint(Parts[2]);
    if Parts.Count >= 4 then Item.Data.nType := strtoint(Parts[3]);
    if Parts.Count >= 6 then Item.Data.nPositionX := strtoint(Parts[5]);
    if Parts.Count >= 7 then Item.Data.nPositionY := strtoint(Parts[6]);
    if Parts.Count >= 10 then Item.Data.nData := strtoint(Parts[9]);
  except
    Errored := True;
  end;

  Item.Data.nTime := UnixTime();
  Item.sFullString := Line;
  Item.CleanUp := True;
  
  Parts.Clear;

  if Errored and Assigned(FOnErrorItem) then FOnErrorItem(Self,Item)
  else if Assigned(FOnNewItem) then FOnNewItem(Self,Item);

  if Item.CleanUp then Dispose(Item);
end;

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: LDServer.pas 258 2006-08-16 14:18:46Z Dataforce $');
end.

