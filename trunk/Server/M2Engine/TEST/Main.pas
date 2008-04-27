unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TUserItem =record
    MakeIndex :Integer;
    wIndex    :Word;   //物品id
    Dura      :Word;   //当前持久值
    DuraMax   :Word;   //最大持久值
    btValue   :array [0..13] of Byte;
  end;
  pTUserItem = ^TUserItem;

  {TUserItem =record
    MakeIndex :Integer;
    DuraMax   :Word;   //最大持久值
    Dura      :Word;   //当前持久值
    wIndex    :Word;   //物品id
    btValue   :array [0..13] of Byte;
  end; }

  TSellOffHeader = record
    nCount         :Integer;
  end;

  TSellOffInfo = packed record        //OK
    sCharName      :String[14]; // 15
    dSellDateTime  :TDateTime;  //8
    nGameGold      :Integer;   //4
    n01              :Integer;
    {n02              :byte;
    n03              :byte;
    n04              :byte;  }
    UseItems       :TUserItem;  //24
    n1             :Integer;
  end;

  TSellOffRecord = packed record        //OK

    SellOffInfo    :TSellOffInfo;
  end;
  TFormTest = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button2: TButton;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit10: TEdit;
    Label10: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Label22: TLabel;
    Edit25: TEdit;
    SpinEdit1: TSpinEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTest: TFormTest;
  m_sHumDBFileName:String='装备寄售-3.sell';
implementation
uses EDcode;
{$R *.dfm}

procedure TFormTest.Button1Click(Sender: TObject);
var
  m_nFileHandle, I:Integer;
  SellOffInfo:TSellOffInfo ;
  SellOffHeader:TSellOffHeader;
begin
    //Showmessage(IntToStr(SizeOf(TSellOffInfo)));
    m_nFileHandle:=FileOpen(m_sHumDBFileName,fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then begin
      FileRead(m_nFileHandle,SellOffHeader,SizeOf(TSellOffHeader));
      FileSeek(m_nFileHandle,0,SizeOf(TSellOffHeader)+SizeOf(TSellOffInfo)*SpinEdit1.Value);
      FileRead(m_nFileHandle,SellOffInfo,SizeOf(TSellOffInfo));
      Edit1.Text:=IntToStr(SellOffHeader.nCount);
      Edit2.Text:=SellOffInfo.sCharName;
      Edit3.Text:=DateTimeToStr(SellOffInfo.dSellDateTime);
      Edit4.Text:=IntToStr(SellOffInfo.nGameGold);
      Edit5.Text:=IntToStr(SellOffInfo.UseItems.wIndex);
      Edit7.Text:=IntToStr(SellOffInfo.UseItems.Dura);
      Edit8.Text:=IntToStr(SellOffInfo.UseItems.DuraMax);
      Edit9.Text:=IntToStr(SellOffInfo.UseItems.MakeIndex);


      Edit24.Text:=IntToStr(LoWord(SellOffInfo.n01));
      Edit25.Text:=IntToStr(HiWord(SellOffInfo.n01));
      {Edit24.Text:=IntToStr(SellOffInfo.n03);
      Edit25.Text:=IntToStr(SellOffInfo.n04);}


      Edit10.Text:=IntToStr(SellOffInfo.UseItems.btValue[0]);
      Edit11.Text:=IntToStr(SellOffInfo.UseItems.btValue[1]);
      Edit12.Text:=IntToStr(SellOffInfo.UseItems.btValue[2]);
      Edit13.Text:=IntToStr(SellOffInfo.UseItems.btValue[3]);
      Edit14.Text:=IntToStr(SellOffInfo.UseItems.btValue[4]);
      Edit15.Text:=IntToStr(SellOffInfo.UseItems.btValue[5]);
      Edit16.Text:=IntToStr(SellOffInfo.UseItems.btValue[6]);
      Edit17.Text:=IntToStr(SellOffInfo.UseItems.btValue[7]);
      Edit18.Text:=IntToStr(SellOffInfo.UseItems.btValue[8]);
      Edit19.Text:=IntToStr(SellOffInfo.UseItems.btValue[9]);
      Edit20.Text:=IntToStr(SellOffInfo.UseItems.btValue[10]);
      Edit21.Text:=IntToStr(SellOffInfo.UseItems.btValue[11]);
      Edit22.Text:=IntToStr(SellOffInfo.UseItems.btValue[12]);
      Edit23.Text:=IntToStr(SellOffInfo.UseItems.btValue[13]);
      FileClose(m_nFileHandle);
    end;
end;

procedure TFormTest.Button2Click(Sender: TObject);
var
  SellOffInfo:TSellOffInfo ;
  Str:String;
begin
  Str:=Edit6.Text;
  Showmessage(IntToStr(Length(Str)));
  DecodeBuffer(Str,@SellOffInfo,SizeOf(TSellOffInfo));
  Edit2.Text:=SellOffInfo.sCharName;
  Edit3.Text:=DateTimeToStr(SellOffInfo.dSellDateTime);
  Edit4.Text:=IntToStr(SellOffInfo.nGameGold);
end;

end.
