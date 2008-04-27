unit EDcode;
//±àÂë/½âÂëº¯Êý¿â
interface

uses
  svn, Windows, SysUtils, Classes, Hutil32, Grobal2;


const
  OLDMODE      = 0; //ÀÏ°æ±¾±àÂë
  NEWMODE      = 1; //ÐÂ°æ±¾±àÂë
  ENDECODEMODE = NEWMODE;

   function  EncodeMessage (smsg: TDefaultMessage): string;
   function DecodeMessage (str: string): TDefaultMessage;
   function EncodeString (str: string): string;
   function DecodeString (str: string): string;
   function  EncodeBuffer (buf: pChar; bufsize: integer): string;
   procedure DecodeBuffer (src: string; buf: PChar; bufsize: integer);
   function  MakeDefaultMsg(wIdent: Word;nRecog: Integer; wParam, wTag, wSeries: Word):TDefaultMessage;

//var
//	CSEncode: TRTLCriticalSection;

implementation

var
//	EncBuf, TempBuf: PChar;

  n4CEEF4 :Integer = $408D4D;
  n4CEEF8 :DWord = $0C08BE531;
  w4CEF00 :Word = $8D34;

  n4CEEFC :Integer = $408D97;

  EncodeBitMasks:array[0..255] of Byte = (
  $2F, $52, $03, $D2, $6B, $05, $8E, $CA, $60, $E4, $8F, $BC, $27, $36, $97, $FF,
  $68, $41, $FB, $16, $2D, $E0, $B0, $51, $2A, $83, $FE, $46, $82, $12, $C4, $E5,
  $18, $42, $EE, $C0, $7C, $28, $0D, $45, $DA, $73, $1A, $8C, $F5, $4E, $E3, $43,
  $6A, $2C, $3E, $FA, $AF, $3F, $32, $67, $62, $64, $66, $E1, $DF, $D1, $F8, $58,
  $C2, $57, $91, $89, $BF, $B3, $48, $E7, $53, $14, $7B, $F1, $B2, $DC, $EF, $DE,
  $1C, $34, $93, $35, $A8, $40, $AB, $EB, $2E, $5C, $09, $5D, $0F, $06, $CD, $6E,
  $7F, $B1, $A4, $5E, $39, $20, $AC, $FC, $65, $E6, $0A, $25, $50, $98, $85, $00,
  $BA, $6F, $10, $D8, $E8, $95, $3C, $4A, $17, $24, $C8, $A1, $1D, $C3, $A5, $1E,
  $31, $33, $8A, $F6, $77, $9F, $90, $0C, $CF, $C9, $79, $71, $BE, $B4, $4F, $B7,
  $9B, $0E, $22, $F0, $87, $D6, $9D, $96, $0B, $08, $59, $FD, $3D, $AD, $D7, $47,
  $38, $3B, $DB, $B9, $61, $80, $F7, $72, $04, $4B, $88, $A6, $B8, $F3, $E2, $DD,
  $44, $49, $15, $54, $C1, $B6, $21, $7D, $81, $86, $F9, $D3, $76, $CB, $5A, $9A,
  $11, $78, $D0, $7A, $5F, $B5, $37, $9C, $AA, $26, $8B, $C7, $7E, $5B, $D4, $94,
  $E9, $1B, $01, $6C, $56, $A0, $30, $29, $A7, $A9, $2B, $AE, $07, $A2, $1F, $4C,
  $69, $9E, $A3, $D9, $F4, $23, $55, $BD, $6D, $70, $3A, $ED, $F2, $74, $84, $75,
  $EA, $BB, $92, $C5, $EC, $13, $99, $02, $8D, $D5, $19, $4D, $C6, $63, $CE, $CC);

  DecodeBitMasks:array[0..255] of Byte = (
  $3A, $A3, $41, $FB, $66, $C6, $76, $B2, $B1, $D5, $A2, $F3, $A4, $8B, $C2, $59,
  $A0, $8D, $5A, $DA, $2D, $28, $8C, $91, $3E, $32, $CC, $1F, $FE, $B6, $77, $9E,
  $BB, $81, $F1, $B9, $71, $78, $55, $22, $70, $B8, $D3, $3F, $C5, $44, $97, $98,
  $EC, $9F, $4A, $56, $D6, $E9, $4F, $E1, $00, $EF, $A9, $52, $62, $FC, $ED, $60,
  $AA, $A1, $CD, $FA, $8F, $37, $09, $F6, $08, $7B, $9B, $79, $96, $1C, $D7, $47,
  $FF, $C8, $C7, $2A, $49, $74, $80, $17, $BC, $CA, $6A, $CB, $89, $33, $BD, $4E,
  $92, $B7, $18, $D0, $99, $D8, $7F, $A7, $3B, $2E, $AF, $53, $26, $07, $8E, $0A,
  $73, $5D, $2B, $3D, $1A, $9A, $0F, $21, $7A, $16, $DF, $C0, $63, $C4, $E4, $40,
  $4C, $27, $86, $7D, $C1, $29, $F4, $46, $EA, $4B, $48, $64, $E5, $1E, $CE, $14,
  $E8, $69, $31, $9C, $36, $C3, $E6, $5B, $68, $A5, $12, $B3, $AC, $5E, $6E, $AD,
  $F2, $39, $67, $65, $B5, $02, $B4, $E2, $01, $06, $A8, $42, $95, $DE, $50, $94,
  $38, $FD, $5F, $4D, $D1, $A6, $82, $51, $34, $6C, $20, $05, $EE, $2C, $E3, $11,
  $75, $E0, $D2, $87, $7C, $35, $23, $58, $F0, $57, $6F, $6D, $F9, $8A, $AE, $0B,
  $AB, $2F, $13, $84, $1B, $15, $25, $61, $BA, $19, $CF, $EB, $9D, $43, $85, $72,
  $B0, $88, $DB, $D9, $1D, $93, $BF, $DD, $54, $F8, $83, $10, $7E, $F7, $BE, $F5,
  $03, $0E, $5C, $0D, $C9, $0C, $90, $3C, $45, $6B, $DC, $E7, $30, $04, $D4, $24);
//------------------------------------------------------------------------------

function MakeDefaultMsg(wIdent: Word;nRecog: Integer; wParam, wTag, wSeries: Word):TDefaultMessage;
begin
  Result.Recog:=nRecog;
  Result.Ident:=wIdent;
  Result.Param:=wParam;
  Result.Tag:=wTag;
  Result.Series:=wSeries;
end;

procedure Encode6BitBuf (src, dest: PChar; srclen, destlen: integer);
var
   i, restcount, destpos: integer;
   made, btch, rest: byte;
begin
try
   restcount := 0;
   rest 		 := 0;
   destpos	 := 0;
   for i:=0 to srclen - 1 do begin
      if destpos >= destlen then break;
      btch := byte (src[i]);

{$IF ENDECODEMODE = NEWMODE}
      asm
        push    edx
        mov     dl, [btch]
        rol     dl, 3
        mov     [btch], dl
        pop     edx
      end;

      btch:=(EncodeBitMasks[btch] xor n4CEEFC) xor n4CEEF4;
      btch:=btch xor (HiByte(LoWord(n4CEEF8)) + LoByte(LoWord(n4CEEF8)));
{$IFEND}

      made := byte ((rest or (btch shr (2+restcount))) and $3F);
      rest := byte (((btch shl (8 - (2+restcount))) shr 2) and $3F);
      Inc (restcount, 2);

      if restcount < 6 then begin
      	dest[destpos] := char(made + $3C);
         Inc (destpos);
      end else begin
      	if destpos < destlen-1 then begin
            dest[destpos]   := char(made + $3C);
            dest[destpos+1] := char(rest + $3C);
            Inc (destpos, 2);
         end else begin
            dest[destpos]   := char(made + $3C);
            Inc (destpos);
         end;
         restcount := 0;
         rest := 0;
      end;

   end;
   if restcount > 0 then begin
   	dest[destpos] := char (rest + $3C);
      Inc (destpos);
   end;
   dest[destpos] := #0;
except
end;
end;

procedure Decode6BitBuf (source: string; buf: PChar; buflen: integer);
const
	Masks: array[2..6] of byte = ($FC, $F8, $F0, $E0, $C0);
var
	i, len, bitpos, madebit, bufpos: integer;
   ch, tmp, _byte: Byte;
begin
try
	len := Length (source);
   bitpos  := 2;
   madebit := 0;
   bufpos  := 0;
   tmp	   := 0;
   ch      := 0;
   for i:=1 to len do begin
      if (Integer(source[i]) - $3C >= 0) and (Integer(source[i]) - $3C <= $40) then
   		  ch := Byte(source[i]) - $3C
    	else begin
        bufpos := 0;
      	break;
      end;

      if bufpos >= buflen then break;

      if (madebit+6) >= 8 then begin
         _byte := Byte(tmp or ((ch and $3F) shr (6-bitpos)));

{$IF ENDECODEMODE = NEWMODE}
        _byte:=_byte xor (HiByte(LoWord(n4CEEF8)) +  LoByte(LoWord(n4CEEF8)));
        _byte:=_byte xor LoByte(LoWord(n4CEEF4));
        _byte:=DecodeBitMasks[_byte] xor LoByte(w4CEF00);

        asm
          push    edx
          mov     dl, [_byte]
          ror     dl, 3
          mov     [_byte], dl
          pop     edx
        end;
{$IFEND}
         buf[bufpos] := Char(_byte);
         Inc (bufpos);
         madebit := 0;
         if bitpos < 6 then Inc (bitpos, 2)
         else begin
         	bitpos := 2;
            continue;
         end;
      end;

      tmp := Byte (Byte(ch shl bitpos) and Masks[bitpos]);   // #### ##--
      Inc (madebit, 8-bitpos);
   end;
   buf [bufpos] := #0;
except
end;
end;

function DecodeMessage (str: string): TDefaultMessage;
var
  EncBuf:array[0..BUFFERSIZE - 1] of Char;
  msg: TDefaultMessage;
begin
  Decode6BitBuf (str, @EncBuf,Length(str));
  Move (EncBuf, msg, sizeof(TDefaultMessage));
  Result := msg;
   {try
      EnterCriticalSection (CSencode);
      Decode6BitBuf (str, EncBuf, 1024);
      Move (EncBuf^, msg, sizeof(TDefaultMessage));
      Result := msg;
   finally
   	LeaveCriticalSection (CSencode);
   end;}
end;


function DecodeString (str: string): string;
var
  EncBuf:array[0..BUFFERSIZE - 1] of Char;
begin
  Decode6BitBuf (str, @EncBuf,Length(str));
  Result := StrPas (EncBuf);
   {try
      EnterCriticalSection (CSencode);
      Decode6BitBuf (str, EncBuf, BUFFERSIZE);
      Result := StrPas (EncBuf); //error, 1, 2, 3,...
   finally
      LeaveCriticalSection (CSencode);
   end;}
end;

procedure DecodeBuffer (src: string; buf: PChar; bufsize: integer);
var
  EncBuf:array[0..BUFFERSIZE - 1] of Char;
begin
  Decode6BitBuf (src, @EncBuf,Length(src));
  Move (EncBuf, buf^, bufsize);
   {try
      EnterCriticalSection (CSencode);
      Decode6BitBuf (src, EncBuf, BUFFERSIZE);
      Move (EncBuf^, buf^, bufsize);
   finally
   	LeaveCriticalSection (CSencode);
   end;}
end;


function  EncodeMessage (smsg: TDefaultMessage): string;
var
  EncBuf,TempBuf:array[0..BUFFERSIZE - 1] of Char;
begin
  Move (smsg, TempBuf, sizeof(TDefaultMessage));
  Encode6BitBuf(@TempBuf, @EncBuf, sizeof(TDefaultMessage), SizeOf(EncBuf));
  Result:=StrPas(EncBuf);
   {EnterCriticalSection (CSencode);
   try
      Move (smsg, TempBuf^, sizeof(TDefaultMessage));
      Encode6BitBuf (TempBuf, EncBuf, sizeof(TDefaultMessage), 1024);
      Result := StrPas (EncBuf);  //Error: 1, 2, 3, 4, 5, 6, 7, 8, 9
   finally
   	LeaveCriticalSection (CSencode);
   end;}
end;


function EncodeString (str: string): string;
var
  EncBuf:array[0..BUFFERSIZE - 1] of Char;
begin
  Encode6BitBuf(PChar(str), @EncBuf, Length(str), SizeOf(EncBuf));
  Result:=StrPas(EncBuf);
   {EnterCriticalSection (CSencode);
   try
      Encode6BitBuf (PChar(str), EncBuf, Length(str), BUFFERSIZE);
      Result := StrPas (EncBuf);
   finally
   	LeaveCriticalSection (CSencode);
   end;}
end;


function  EncodeBuffer (buf: pChar; bufsize: integer): string;
var
  EncBuf,TempBuf:array[0..BUFFERSIZE - 1] of Char;
begin
  if bufsize < BUFFERSIZE then begin
    Move (buf^, TempBuf, bufsize);
    Encode6BitBuf (@TempBuf, @EncBuf, bufsize, SizeOf(EncBuf));
    Result := StrPas (EncBuf);
  end else Result := '';
   {EnterCriticalSection (CSencode);
   try
      if bufsize < BUFFERSIZE then begin
         Move (buf^, TempBuf^, bufsize);
         Encode6BitBuf (TempBuf, EncBuf, bufsize, BUFFERSIZE);
         Result := StrPas (EncBuf);
      end else
         Result := '';
   finally
   	LeaveCriticalSection (CSencode);
   end;}
end;

initialization
begin
  {---- Adjust global SVN revision ----}
  SVNRevision('$Id: EDcode.pas 500 2006-11-01 20:40:19Z damian $');
  
  {GetMem (EncBuf, BUFFERSIZE + 100);;
  GetMem (TempBuf, BUFFERSIZE + 100);
  InitializeCriticalSection (CSEncode);}
end;


finalization
begin
  {FreeMem (EncBuf, BUFFERSIZE + 100);
  FreeMem (TempBuf, BUFFERSIZE + 100);
  DeleteCriticalSection (CSEncode);}
end;

end.
