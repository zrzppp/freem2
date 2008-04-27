unit Grobal2;

interface
uses
  Windows;
const
  DEFBLOCKSIZE = 16;
  BUFFERSIZE = 10000;
  CM_SELECTSERVER = 104;

  CM_PROTOCOL = 2000;
  CM_IDPASSWORD = 2001;
  CM_UPDATEUSER = 2004;

  SM_CERTIFICATION_FAIL = 501;
  SM_ID_NOTFOUND = 502;
  SM_STARTPLAY = 525;
  SM_STARTFAIL = 526; //SM_USERFULL
  SM_QUERYCHR_FAIL = 527;
  SM_OUTOFCONNECTION = 528; //?
  SM_PASSOK_SELECTSERVER = 529;
  SM_SELECTSERVER_OK = 530;
  SM_NEEDUPDATE_ACCOUNT = 531;
  SM_UPDATEID_SUCCESS = 532;
  SM_UPDATEID_FAIL = 533;

  CM_ADDNEWUSER = 2002; //新建账号
  CM_CHANGEPASSWORD = 2003; //修改密码
  SM_PASSWD_FAIL = 503; //修改密码失败
  SM_NEWID_SUCCESS = 504; //新建账号成功
  SM_NEWID_FAIL = 505; //新建账号失败
  SM_CHGPASSWD_SUCCESS = 506; //修改密码成功
  SM_CHGPASSWD_FAIL = 507; //修改密码失败
  CM_GETBACKPASSWORD = 2010; //密码找回
  SM_GETBACKPASSWD_SUCCESS = 508; //密码找回成功
  SM_GETBACKPASSWD_FAIL = 509; //密码找回失败
  //===========================================
  CM_START = 2200;
  SM_STARTGAME = 2201;
  SM_START_FAIL = 2202; //登陆失败
  SM_START_SUCCESS = 2203; //?     //登陆成功

  CM_SEARCH = 2205;
  SM_SEARCH_SUCCESS = 2206;
  SM_SEARCH_FAIL = 2209;

  CM_DOWMLINE = 2208;
  SM_DOWMLINE_SUCCESS = 2209;
  SM_DOWMLINE_FAIL = 2210;

  SM_CERTIFICATION_SUCCESS = 502;

  GS_USERACCOUNT =2001;
  GS_CHANGEACCOUNTINFO =2002;

  SG_USERACCOUNT =1003;
  SG_USERACCOUNTNOTFOUND =1004;       //没有找到账号
  SG_USERACCOUNTCHANGESTATUS =1005;  //账号更新成功
type
  TDefaultMessage = record
    Recog: Integer;
    Ident: word;
    Param: word;
    Tag: word;
    Series: word;
  end;

  TChrMsg = record
    Ident: Integer;
    X: Integer;
    Y: Integer;
    Dir: Integer;
    State: Integer;
    feature: Integer;
    saying: string;
    sound: Integer;
  end;
  PTChrMsg = ^TChrMsg;
  TStdItem = record //OK
    Name: string[14];
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: Byte;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: word;
    DuraMax: word;
    AC: word;
    MAC: word;
    DC: word;
    MC: word;
    SC: word;
    Need: Byte;
    NeedLevel: Byte;
    Price: DWORD;
  end;
  TClientItem = record //OK
    S: TStdItem;
    MakeIndex: Integer;
    Dura: word;
    DuraMax: word;
  end;
  PTClientItem = ^TClientItem;
  TUserStateInfo = record //OK
    feature: Integer;
    Username: string[19];
    GuildName: string[14];
    GuildRankName: string[14];
    NameColor: word;
    UseItems: array[0..8] of TClientItem;
  end;
  TUserCharacterInfo = record
    Name: string[19];
    Job: Byte;
    Hair: Byte;
    Level: Byte;
    m_btSex: Byte;
  end;
  TUserEntry = packed  record
    sAccount: string[10];
    sPassword: string[10];
    sUsername: string[20];
    sSSNo: string[14];
    sPhone: string[14];
    sQuiz: string[20];
    sAnswer: string[12];
    sEMail: string[40];
  end;
  TUserEntryAdd = packed  record
    sQuiz2: string[20];
    sAnswer2: string[12];
    sBirthDay: string[10];
    sMobilePhone: string[13];
    sMemo: string[20];
    sMemo2: string[20];
  end;
  TDropItem = record
    X: Integer;
    Y: Integer;
    Id: Integer;
    Looks: Integer;
    Name: string;
    FlashTime: DWORD;
    FlashStepTime: DWORD;
    FlashStep: Integer;
    BoFlash: Boolean;
  end;
  PTDropItem = ^TDropItem;
  TMagic = record //+
    MagicId: word;
    MagicName: string[12];
    EffectType: Byte;
    Effect: Byte;
    xx: Byte;
    Spell: word;
    DefSpell: word;
    TrainLevel: array[0..2] of Byte;
    TrainLeveX: array[0..2] of Byte;
    MaxTrain: array[0..2] of Integer;
    DelayTime: Integer;
  end;
  TClientMagic = record //84
    Key: Char;
    Level: Byte;
    CurTrain: Integer;
    Def: TMagic;
  end;
  PTClientMagic = ^TClientMagic;
  TNakedAbility = record
    DC: word;
    MC: word;
    SC: word;
    AC: word;
    MAC: word;
    HP: word;
    MP: word;
    Hit: Byte;
    Speed: Integer;
  end;

  TAbility = record //OK    //Size 40
    Level: word; //0x198
    AC: word; //0x19A
    MAC: word; //0x19C
    DC: word; //0x19E
    MC: word; //0x1A0
    SC: word; //0x1A2
    HP: word; //0x1A4
    MP: word; //0x1A6
    MaxHP: word; //0x1A8
    MaxMP: word; //0x1AA
    dw1AC: DWORD; //0x1AC
    Exp: DWORD; //0x1B0
    MaxExp: DWORD; //0x1B4
    Weight: word; //0x1B8
    MaxWeight: word; //0x1BA
    WearWeight: Byte; //0x1BC
    MaxWearWeight: Byte; //0x1BD
    HandWeight: Byte; //0x1BE
    MaxHandWeight: Byte; //0x1BF
  end;

  TShortMessage = record
    Ident: word;
    wMsg: word;
  end;

  TMessageBodyW = record
    Param1: word;
    Param2: word;
    Tag1: word;
    Tag2: word;
  end;

  TMessageBodyWL = record //16  0x10
    lParam1: Integer;
    lParam2: Integer;
    lTag1: Integer;
    lTag2: Integer;
  end;

  TCharDesc = record
    feature: Integer;
    Status: Integer;
  end;
  TClientGoods = record
    Name: string;
    SubMenu: Integer;
    Price: Integer;
    Stock: Integer;
    Grade: Integer;
  end;
  pTClientGoods = ^TClientGoods;
  //ResourceString
function APPRfeature(cfeature: Integer): word;
function RACEfeature(cfeature: Integer): Byte;
function HAIRfeature(cfeature: Integer): Byte;
function DRESSfeature(cfeature: Integer): Byte;
function WEAPONfeature(cfeature: Integer): Byte;
implementation

function WEAPONfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(cfeature);
end;
function DRESSfeature(cfeature: Integer): Byte;
begin
  Result := HiByte(HiWord(cfeature));
end;
function APPRfeature(cfeature: Integer): word;
begin
  Result := HiWord(cfeature);
end;
function HAIRfeature(cfeature: Integer): Byte;
begin
  Result := HiWord(cfeature);
end;
function RACEfeature(cfeature: Integer): Byte;
begin
  Result := cfeature;
end;

end.
