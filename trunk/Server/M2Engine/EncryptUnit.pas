unit EncryptUnit;

interface
uses
  Windows, SysUtils, Classes, DES;
function CalcFileCRC(sFileName: string): Integer;
function CalcBufferCRC(Buffer: PChar; nSize: Integer): Integer;
function Base64EncodeStr(const Value: string): string;
{ Encode a string into Base64 format }
function Base64DecodeStr(const Value: string): string;
{ Decode a Base64 format string }
function Base64Encode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
{ Encode a lump of raw data (output is (4/3) times bigger than input) }
function Base64Decode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
{ Decode a lump of raw data }

function EncodeString_3des(Source, Key: string): string;
function DecodeString_3des(Source, Key: string): string;
function EncodeInfo(smsg: string): string;
function DecodeInfo(smsg: string): string;
function GetUniCode(Msg: string): Integer;
implementation
uses EDcode, HUtil32;
{$I des.inc}
const
  B64: array[0..63] of Byte = (65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
    81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108,
    109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57, 43, 47);
  Key: array[0..2, 0..7] of Byte = (($FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF), ($FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF), ($FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF));
function Base64Encode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
var
  i, iptr, optr: Integer;
  Input, Output: PByteArray;
begin
  Input := PByteArray(pInput); Output := PByteArray(pOutput);
  iptr := 0; optr := 0;
  for i := 1 to (Size div 3) do begin
    Output^[optr + 0] := B64[Input^[iptr] shr 2];
    Output^[optr + 1] := B64[((Input^[iptr] and 3) shl 4) + (Input^[iptr + 1] shr 4)];
    Output^[optr + 2] := B64[((Input^[iptr + 1] and 15) shl 2) + (Input^[iptr + 2] shr 6)];
    Output^[optr + 3] := B64[Input^[iptr + 2] and 63];
    Inc(optr, 4); Inc(iptr, 3);
  end;
  case (Size mod 3) of
    1: begin
        Output^[optr + 0] := B64[Input^[iptr] shr 2];
        Output^[optr + 1] := B64[(Input^[iptr] and 3) shl 4];
        Output^[optr + 2] := Byte('=');
        Output^[optr + 3] := Byte('=');
      end;
    2: begin
        Output^[optr + 0] := B64[Input^[iptr] shr 2];
        Output^[optr + 1] := B64[((Input^[iptr] and 3) shl 4) + (Input^[iptr + 1] shr 4)];
        Output^[optr + 2] := B64[(Input^[iptr + 1] and 15) shl 2];
        Output^[optr + 3] := Byte('=');
      end;
  end;
  Result := ((Size + 2) div 3) * 4;
end;

function Base64EncodeStr(const Value: string): string;
begin
  setlength(Result, ((Length(Value) + 2) div 3) * 4);
  Base64Encode(@Value[1], @Result[1], Length(Value));
end;

function Base64Decode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
var
  i, J, iptr, optr: Integer;
  Temp: array[0..3] of Byte;
  Input, Output: PByteArray;
begin
  Input := PByteArray(pInput); Output := PByteArray(pOutput);
  iptr := 0; optr := 0;
  Result := 0;
  for i := 1 to (Size div 4) do begin
    for J := 0 to 3 do begin
      case Input^[iptr] of
        65..90: Temp[J] := Input^[iptr] - Ord('A');
        97..122: Temp[J] := Input^[iptr] - Ord('a') + 26;
        48..57: Temp[J] := Input^[iptr] - Ord('0') + 52;
        43: Temp[J] := 62;
        47: Temp[J] := 63;
        61: Temp[J] := $FF;
      end;
      Inc(iptr);
    end;
    Output^[optr] := (Temp[0] shl 2) or (Temp[1] shr 4);
    Result := optr + 1;
    if (Temp[2] <> $FF) and (Temp[3] = $FF) then begin
      Output^[optr + 1] := (Temp[1] shl 4) or (Temp[2] shr 2);
      Result := optr + 2;
      Inc(optr)
    end
    else if (Temp[2] <> $FF) then begin
      Output^[optr + 1] := (Temp[1] shl 4) or (Temp[2] shr 2);
      Output^[optr + 2] := (Temp[2] shl 6) or Temp[3];
      Result := optr + 3;
      Inc(optr, 2);
    end;
    Inc(optr);
  end;
end;

function Base64DecodeStr(const Value: string): string;
begin
  setlength(Result, (Length(Value) div 4) * 3);
  setlength(Result, Base64Decode(@Value[1], @Result[1], Length(Value)));
end;

function CalcFileCRC(sFileName: string): Integer;
var
  i: Integer;
  nFileHandle: Integer;
  nFileSize, nBuffSize: Integer;
  Buffer: PChar;
  INT: ^Integer;
  nCrc: Integer;
begin
  Result := 0;
  if not FileExists(sFileName) then Exit;
  nFileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
  if nFileHandle = 0 then
    Exit;
  nFileSize := FileSeek(nFileHandle, 0, 2);
  nBuffSize := (nFileSize div 4) * 4;
  GetMem(Buffer, nBuffSize);
  FillChar(Buffer^, nBuffSize, 0);
  FileSeek(nFileHandle, 0, 0);
  FileRead(nFileHandle, Buffer^, nBuffSize);
  FileClose(nFileHandle);
  INT := Pointer(Buffer);
  nCrc := 0;
  Exception.Create(IntToStr(SizeOf(Integer)));
  for i := 0 to nBuffSize div 4 - 1 do begin
    nCrc := nCrc xor INT^;
    INT := Pointer(Integer(INT) + 4);
  end;
  FreeMem(Buffer);
  Result := nCrc;
end;

function CalcBufferCRC(Buffer: PChar; nSize: Integer): Integer;
var
  i: Integer;
  INT: ^Integer;
  nCrc: Integer;
begin
  INT := Pointer(Buffer);
  nCrc := 0;
  for i := 0 to nSize div 4 - 1 do begin
    nCrc := nCrc xor INT^;
    INT := Pointer(Integer(INT) + 4);
  end;
  Result := nCrc;
end;

function Chinese2UniCode(AiChinese: string): Integer;
var
  ch, cl: string[2];
  a: array[1..2] of Char;
begin
  StringToWideChar(Copy(AiChinese, 1, 2), @(a[1]), 2);
  ch := IntToHex(Integer(a[2]), 2);
  cl := IntToHex(Integer(a[1]), 2);
  Result := StrToInt('$' + ch + cl);
end;

function GetUniCode(Msg: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 1 to Length(Msg) do begin
    Result := Result + Chinese2UniCode(Msg[i]) * i;
  end;
end;

function DecodeString_3des(Source, Key: string): string;
var
  Decode: TDCP_3des;
begin
  try
    Result := '';
    Decode := TDCP_3des.Create(nil);
    Decode.InitStr(Key);
    Decode.Reset;
    Result := Decode.DecryptString(Source);
    Decode.Reset;
    Decode.Free;
  except
    Result := '';
  end;
end;

function EncodeString_3des(Source, Key: string): string;
var
  Encode: TDCP_3des;
begin
  try
    Result := '';
    Encode := TDCP_3des.Create(nil);
    Encode.InitStr(Key);
    Encode.Reset;
    Result := Encode.EncryptString(Source);
    Encode.Reset;
    Encode.Free;
  except
    Result := '';
  end;
end;

function DecodeInfo(smsg: string): string;
var
  i: Integer;
  sEncodeStr, sEncodeUniCode: string;
  nEncodeStr, nEncodeUniCode: Integer;
  Str, sDecodeStr, sDecodeUniCode: string;
begin
  Result := '';
  Str := DecodeString_3des(smsg, '');
  i := Pos('|', Str);
  if i <= 0 then Exit;
  sEncodeStr := Copy(Str, 1, i - 1);
  sEncodeUniCode := Copy(Str, i + 1, Length(Str) - i);
  sDecodeStr := DecodeString_3des(sEncodeStr, sEncodeUniCode);
  sDecodeUniCode := DecodeString(sEncodeUniCode);
  nEncodeUniCode := Str_ToInt(sDecodeUniCode, 0);
  nEncodeStr := GetUniCode(sDecodeStr);
  if nEncodeUniCode <> nEncodeStr then Exit;
  Result := sDecodeStr;
end;

function EncodeInfo(smsg: string): string;
var
  sEncodeStr, sEncodeUniCode: string;
  nEncodeStr: Integer;
begin
  nEncodeStr := GetUniCode(smsg);
  sEncodeUniCode := EncodeString(IntToStr(nEncodeStr));
  sEncodeStr := EncodeString_3des(smsg, sEncodeUniCode);
  Result := EncodeString_3des(sEncodeStr + '|' + sEncodeUniCode, '');
end;

end.

