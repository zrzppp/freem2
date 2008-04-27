unit grobal2;

interface
uses
  svn, Windows, SysUtils, Classes, strUtils, SocketComp;

const
  {$IFDEF Timeinc}{$I TimeStamp.inc}{$ELSE}BUILDTIME = 0;{$ENDIF}
  VERSION_NUMBER = 20060715;
  CLIENT_VERSION_NUMBER = 120040918;
  CM_POWERBLOCK = 0;

  MapNameLen    = 16;
  ActorNameLen  = 14;
  GuildNameLen  = 20;

  DR_UP         =0;
  DR_UPRIGHT    =1;
  DR_RIGHT      =2;
  DR_DOWNRIGHT  =3;
  DR_DOWN       =4;
  DR_DOWNLEFT   =5;
  DR_LEFT       =6;
  DR_UPLEFT     =7;

  U_DRESS       = 0;
  U_WEAPON      = 1;
  U_RIGHTHAND   = 2;    //candle slot
  U_NECKLACE    = 3;
  U_HELMET      = 4;
  U_ARMRINGL    = 5;
  U_ARMRINGR    = 6;
  U_RINGL       = 7;
  U_RINGR       = 8;
  U_BUJUK       = 9;
  U_BELT        = 10;
  U_BOOTS       = 11;
  U_CHARM       = 12;

  DEFBLOCKSIZE  = 16;
  BUFFERSIZE    = 10000;

  LOGICALMAPUNIT= 40;

  UNITX         = 48;
  UNITY         = 32;

  HALFX         = 24;
  HALFY         = 16;

  MAXUSEITEM    = 12;
  MAXBAGITEM    = 46;
  ADDMAXBAGITEM = 6;
  STORAGELIMIT  = 80;
  HOWMANYMAGICS = 20;
  MaxSkillLevel = 3;
  MAX_STATUS_ATTRIBUTE = 12;

  ITEM_WEAPON           = 0;
  ITEM_ARMOR				    = 1;
  ITEM_ACCESSORY		    = 2;
  ITEM_ETC					    = 3;
  ITEM_GOLD				      = 10;

  POISON_DECHEALTH = 0;    //中毒类型 - 绿毒     //64h
  POISON_DAMAGEARMOR = 1;  //中毒类型 - 红毒     //66h
  POISON_FREEZE = 2;                             //68h
  POISON_STUN = 3;                               //6Ah
  POISON_SLOWDOWN = 4;                           //6Ch
  POISON_STONE = 5;                              //6Eh
  POISON_DONTMOVE = 6;                           //70h
  STATE_TRANSPARENT = 8;
  STATE_DEFENCEUP = 9;
  STATE_MAGDEFENCEUP = 10;
  STATE_BUBBLEDEFENCEUP = 11;
//  STATE_SUNCHENDEFENCEUP = 12;
  
  STATE_NORMAL     = $00000000;
  STATE_STONE_MODE = $00000001;
  STATE_OPENHEATH  = $00000002;

  ET_DIGOUTZOMBI    = 1;
  ET_MINE           = 2;
  ET_PILESTONES     = 3;
  ET_HOLYCURTAIN    = 4;
  ET_FIRE           = 5;
  ET_SCULPEICE      = 6;
  ET_FIRE2          = 7;

  RCC_MERCHANT     = 50;
  RCC_GUARD        = 12;
  RCC_USERHUMAN    = 0;

  F_GOOD = 0;
  F_BAD  = 1;
  //任务
  Q_QUEST = 0;
  Q_STORY  = 1;

  CM_QUERYUSERSTATE     = 82;

  CM_QUERYUSERNAME      = 80;
  CM_QUERYBAGITEMS      = 81;
  CM_QUERYSTORAGEITEMS  = 83;

  CM_GETAUCTION         = 8011;
  CM_BUYAUCTIONITEM     = 8012;
  CM_GETGOLDITEM        = 8013;

  CM_QUERYCHR           = 100;
  CM_NEWCHR             = 101;
  CM_DELCHR             = 102;
  CM_SELCHR             = 103;
  CM_SELECTSERVER       = 104;

  CM_OPENDOOR           = 1002;
  CM_SOFTCLOSE          = 1009;

  CM_DROPITEM           = 1000;
  CM_PICKUP             = 1001;
  CM_TAKEONITEM		      = 1003;
  CM_TAKEOFFITEM        = 1004;
  CM_1005               = 1005;
  CM_EAT                = 1006;
  CM_BUTCH              = 1007;
  CM_MAGICKEYCHANGE	= 1008;

  CM_CLICKNPC           = 1010;
  CM_MERCHANTDLGSELECT  = 1011;
  CM_MERCHANTQUERYSELLPRICE = 1012;
  CM_USERSELLITEM       = 1013;
  CM_USERBUYITEM        = 1014;
  CM_USERGETDETAILITEM  = 1015;
  CM_DROPGOLD           = 1016;
  CM_1017               = 1017;
  CM_LOGINNOTICEOK      = 1018;
  CM_GROUPMODE          = 1019;
  CM_CREATEGROUP        = 1020;
  CM_ADDGROUPMEMBER     = 1021;
  CM_DELGROUPMEMBER     = 1022;
  CM_USERREPAIRITEM     = 1023;
  CM_MERCHANTQUERYREPAIRCOST = 1024;
  CM_DEALTRY            = 1025;
  CM_DEALADDITEM        = 1026;
  CM_DEALDELITEM        = 1027;
  CM_DEALCANCEL         = 1028;
  CM_DEALCHGGOLD        = 1029;
  CM_DEALEND            = 1030;
  CM_USERSTORAGEITEM    = 1031;
  CM_CONSIGNITEM        = 10311;
  CM_USERTAKEBACKSTORAGEITEM = 1032;
  CM_USERMAKEDRUGITEM   = 1034;
  CM_OPENGUILDDLG       = 1035;
  CM_GUILDHOME          = 1036;
  CM_GUILDMEMBERLIST    = 1037;
  CM_GUILDADDMEMBER     = 1038;
  CM_GUILDDELMEMBER     = 1039;
  CM_GUILDUPDATENOTICE  = 1040;
  CM_GUILDUPDATERANKINFO= 1041;
  CM_1042               = 1042;
  CM_ADJUST_BONUS       = 1043;
  CM_GUILDALLY          = 1044;
  CM_GUILDBREAKALLY     = 1045;
  CM_SPEEDHACKUSER      = 10430;

  CM_REFINEADDITEM      = 1050;
  CM_REFINEDELITEM      = 1051;
  CM_REFINECANCEL       = 1052;


  CM_PROTOCOL           = 2000;
  CM_IDPASSWORD         = 2001;
  CM_ADDNEWUSER         = 2002;
  CM_CHANGEPASSWORD     = 2003;
  CM_UPDATEUSER         = 2004;

  CM_THROW              = 3005;
  CM_TURN               = 3010;
  CM_WALK               = 3011;
  CM_SITDOWN            = 3012;
  CM_RUN                = 3013;
  CM_HIT                = 3014;
  CM_HEAVYHIT           = 3015;
  CM_BIGHIT             = 3016;
  CM_SPELL              = 3017;
  CM_POWERHIT           = 3018;
  CM_LONGHIT            = 3019;

  CM_WIDEHIT            = 3024;
  CM_FIREHIT            = 3025;
  CM_READYFIREHIT       = 3026;

  CM_SAY                = 3030;

  CM_GEMITEM            = 3031;
  CM_REPAIRITEM         = 3032;

  CM_GEMSYSTEM          = 3033;
  CM_GEMINFO            = 3034;

  CM_ADDFRIEND          = 3041;
  CM_DELFRIEND          = 3042;
  CM_UPDATEMEMOFRIEND   = 3043;
  CM_REQMEMOFRIEND      = 3044;
  CM_ADDBADFRIEND       = 3045;

  // Mail1
  CM_REQUESTMAILLIST    = 3050;
  CM_SENDMAIL           = 3051;
  CM_READMAIL           = 3052;
  CM_DELETEMAIL         = 3053;
  CM_SETMAILSTATUS      = 3054;
  CM_REQUESTBLOCKLIST  = 3055;
  CM_ADDBLOCK          = 3056;
  CM_DELBLOCK          = 3057;

  // Next CM_ should start at 3065 to leave space;
  //Lover system CM
  CM_CHANGEAVAILABILITY = 3065;
  CM_OPENLOVERWINDOW    = 3067;
  CM_ASKRELAY           = 3068;
  CM_ASKDIVORCE         = 3069;
  CM_REQUESTRELAYOK     = 3070;
  CM_REQUESTRELAYFAIL   = 3071;

  CM_REQUESTGTLIST      =3072;
  CM_BUYGT              =3073;
  CM_REQUESTDECOLIST    =3074;
  CM_BUYDECOITEM        =3075;
  CM_TRADEGT            =3076;
  CM_BBSLIST            =3077;
  CM_BBSMSG             =3078;
  CM_BBSPOST            =3079;
  CM_BBSDELETE          =3080;

  SM_41                 = 4;
  SM_THROW              = 5;
  SM_RUSH               = 6;
  SM_RUSHKUNG           = 7;
  SM_FIREHIT            = 8;
  SM_BACKSTEP           = 9;
  SM_TURN               = 10;
  SM_WALK               = 11;
  SM_SITDOWN            = 12;
  SM_RUN                = 13;
  SM_HIT                = 14;
  SM_HEAVYHIT           = 15;
  SM_BIGHIT             = 16;
  SM_SPELL              = 17;
  SM_POWERHIT           = 18;
  SM_LONGHIT            = 19;
  SM_DIGUP              = 20;
  SM_DIGDOWN            = 21;
  SM_FLYAXE             = 22;
  SM_LIGHTING           = 23;
  SM_WIDEHIT            = 24;
  SM_CRSHIT             = 25;
  SM_TWINHIT            = 26;
  
  

  SM_ALIVE              = 27;
  SM_MOVEFAIL           = 28;
  SM_HIDE               = 29;
  SM_DISAPPEAR          = 30;
  SM_STRUCK             = 31;   
  SM_DEATH              = 32;
  SM_SKELETON           = 33;
  SM_NOWDEATH           = 34;
  SM_READYFIREHIT       = 35;

  SM_HEAR               = 40;
  SM_FEATURECHANGED     = 41;
  SM_USERNAME           = 42;
  SM_43                 = 43;
  SM_WINEXP             = 44;
  SM_LEVELUP            = 45;
  SM_DAYCHANGING        = 46;

  SM_LOGON              = 50;
  SM_NEWMAP             = 51;
  SM_ABILITY            = 52;
  SM_HEALTHSPELLCHANGED = 53;
  SM_MAPDESCRIPTION     = 54;
  SM_81                 = 81;
  SM_82                 = 82;
  SM_83                 = 83;
  SM_SPELL2             = 117;

  SM_SYSMESSAGE         = 100;
  SM_GROUPMESSAGE       = 101;
  SM_CRY                = 102;
  SM_WHISPER            = 103;
  SM_GUILDMESSAGE       = 104;

  SM_ADDITEM            = 200;
  SM_BAGITEMS           = 201;
  SM_BAGITEMS2          = 213;
  SM_AUCTIONITEMS       = 2011;
  SM_DELITEM            = 202;
  SM_UPDATEITEM         = 203;
  SM_ADDMAGIC           = 210;
  SM_SENDMYMAGIC        = 211;
  SM_DELMAGIC           = 212;
  SM_STORAGEITEMS       = 214;
  SM_STORAGEITEMS2      = 215;
  SM_ADDSTORAGE         = 216;

  SM_CERTIFICATION_SUCCESS = 500;
  SM_CERTIFICATION_FAIL = 501;
  SM_ID_NOTFOUND        = 502;
  SM_PASSWD_FAIL        = 503;
  SM_NEWID_SUCCESS      = 504;
  SM_NEWID_FAIL         = 505;
  SM_CHGPASSWD_SUCCESS  = 506;
  SM_CHGPASSWD_FAIL     = 507;
  SM_QUERYCHR           = 520;
  SM_NEWCHR_SUCCESS     = 521;
  SM_NEWCHR_FAIL        = 522;
  SM_DELCHR_SUCCESS     = 523;
  SM_DELCHR_FAIL        = 524;
  SM_STARTPLAY          = 525;
  SM_STARTFAIL          = 526;//SM_USERFULL
  SM_QUERYCHR_FAIL      = 527;
  SM_OUTOFCONNECTION    = 528;
  SM_PASSOK_SELECTSERVER= 529;
  SM_SELECTSERVER_OK    = 530;
  SM_NEEDUPDATE_ACCOUNT = 531;
  SM_UPDATEID_SUCCESS   = 532;
  SM_UPDATEID_FAIL      = 533;



  SM_DROPITEM_SUCCESS   = 600;
  SM_DROPITEM_FAIL      = 601;

  SM_ITEMSHOW           = 610;
  SM_ITEMHIDE           = 611;

  SM_OPENDOOR_OK        = 612;
  SM_OPENDOOR_LOCK      = 613;
  SM_CLOSEDOOR          = 614;

  SM_TAKEON_OK          = 615;
  SM_TAKEON_FAIL        = 616;
  SM_TAKEOFF_OK         = 619;
  SM_TAKEOFF_FAIL       = 620;
  SM_SENDUSEITEMS       = 621;
  SM_WEIGHTCHANGED      = 622;
  SM_CLEAROBJECTS       = 633;
  SM_CHANGEMAP          = 634;
  SM_EAT_OK             = 635;
  SM_EAT_FAIL           = 636;
  SM_BUTCH              = 637;
  SM_MAGICFIRE          = 638;
  SM_MAGICFIRE_FAIL     = 639;
  SM_MAGIC_LVEXP        = 640;
  SM_DURACHANGE         = 642;
  SM_MERCHANTSAY        = 643;
  SM_MERCHANTDLGCLOSE   = 644;
  SM_SENDGOODSLIST      = 645;
  SM_SENDUSERSELL       = 646;
  SM_SENDBUYPRICE       = 647;
  SM_USERSELLITEM_OK    = 648;
  SM_USERSELLITEM_FAIL  = 649;
  SM_BUYITEM_SUCCESS    = 650;
  SM_AUCTIONGIVE        = 6501;
  SM_BUYITEM_FAIL       = 651;
  SM_SENDDETAILGOODSLIST= 652;
  SM_GOLDCHANGED        = 653;
  SM_CHANGELIGHT        = 654;
  SM_LAMPCHANGEDURA     = 655;
  SM_CHANGENAMECOLOR    = 656;
  SM_CHARSTATUSCHANGED  = 657;
  SM_SENDNOTICE         = 658;
  SM_GROUPMODECHANGED   = 659;
  SM_CREATEGROUP_OK     = 660;
  SM_CREATEGROUP_FAIL   = 661;
  SM_GROUPADDMEM_OK     = 662;
  SM_GROUPDELMEM_OK     = 663;
  SM_GROUPADDMEM_FAIL   = 664;
  SM_GROUPDELMEM_FAIL   = 665;
  SM_GROUPCANCEL        = 666;
  SM_GROUPMEMBERS       = 667;
  SM_SENDUSERREPAIR     = 668;
  SM_USERREPAIRITEM_OK  = 669;
  SM_USERREPAIRITEM_FAIL= 670;
  SM_SENDREPAIRCOST     = 671;
  SM_DEALMENU           = 673;
  SM_DEALTRY_FAIL       = 674;
  SM_DEALADDITEM_OK     = 675;
  SM_DEALADDITEM_FAIL   = 676;
  SM_DEALDELITEM_OK     = 677;
  SM_DEALDELITEM_FAIL   = 678;
  SM_DEALCANCEL         = 681;
  SM_DEALREMOTEADDITEM  = 682;
  SM_DEALREMOTEDELITEM  = 683;
  SM_DEALCHGGOLD_OK     = 684;
  SM_DEALCHGGOLD_FAIL   = 685;
  SM_DEALREMOTECHGGOLD  = 686;
  SM_DEALSUCCESS        = 687;
  SM_SENDUSERSTORAGEITEM= 700;
  SM_SENDUSERCONSIGNITEM= 7001;
  SM_STORAGE_OK         = 701;
  SM_STORAGE_FULL       = 702;
  SM_STORAGE_FAIL       = 703;
  SM_CONSIGN_OK         = 7011;
  SM_CONSIGN_FAIL       = 7014;
  SM_GETAUCTIONITEMS_FAIL = 7012;
  SM_CLOSEAUCTION = 7013;
  SM_SAVEITEMLIST       = 704;
  SM_TAKEBACKSTORAGEITEM_OK = 705;
  SM_TAKEBACKSTORAGEITEM_FAIL = 706;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;

  SM_REFINECANCEL       = 720;

  SM_AREASTATE          = 766;
  SM_MYSTATUS           = 708;

  SM_DELITEMS           = 709;
  SM_SENDUSERMAKEDRUGITEMLIST = 712;
  SM_MAKEDRUG_SUCCESS   = 713;
  SM_MAKEDRUG_FAIL      = 714;

  SM_716                = 716;
  SM_GETMAKEGEMLIST     = 717;

  SM_CHANGEGUILDNAME    = 750;
  SM_SENDUSERSTATE      = 751;
  SM_SUBABILITY         = 752;
  SM_OPENGUILDDLG       = 753;
  SM_OPENGUILDDLG_FAIL  = 754;
  SM_SENDGUILDMEMBERLIST= 756;
  SM_GUILDADDMEMBER_OK  = 757;
  SM_GUILDADDMEMBER_FAIL= 758;
  SM_GUILDDELMEMBER_OK  = 759;
  SM_GUILDDELMEMBER_FAIL= 760;
  SM_GUILDRANKUPDATE_FAIL= 761;
  SM_BUILDGUILD_OK      = 762;
  SM_BUILDGUILD_FAIL    = 763;
  SM_DONATE_OK          = 764;
  SM_DONATE_FAIL        = 765;

  SM_MENU_OK            = 767;
  SM_GUILDMAKEALLY_OK   = 768;
  SM_GUILDMAKEALLY_FAIL = 769;
  SM_GUILDBREAKALLY_OK  = 770;
  SM_GUILDBREAKALLY_FAIL= 771;
  SM_DLGMSG             = 772;
  SM_SPACEMOVE_HIDE     = 800;
  SM_SPACEMOVE_SHOW     = 801;
  SM_RECONNECT          = 802;
  SM_GHOST              = 803;
  SM_SHOWEVENT          = 804;
  SM_HIDEEVENT          = 805;
  SM_SPACEMOVE_HIDE2    = 806;
  SM_SPACEMOVE_SHOW2    = 807;
  SM_TIMECHECK_MSG      = 810;
  SM_ADJUST_BONUS       = 811;

  SM_OPENHEALTH         = 1100;
  SM_CLOSEHEALTH        = 1101;
  SM_CHANGEFACE         = 1104;
  SM_BREAKWEAPON        = 1102;
  SM_INSTANCEHEALGUAGE  = 1103;
  SM_VERSION_FAIL       = 1106;


  SM_ITEMUPDATE         = 1500;
  SM_MONSTERSAY         = 1501;

  SM_REPAIRITEMOK       = 1502;
  SM_GEMSYSTEMFAIL      = 1503;

  SM_ADDFRIEND          = 1505;
  SM_DELFRIEND          = 1506;
  SM_FRIENDSTATUS       = 1507;
  SM_FRIENDLIST         = 1508;
  SM_MEMOFRIEND         = 1509;
  SM_ADDFRIENDFAIL      = 1510;

  // Mail2
  SM_MAILLIST           = 1520;  
  SM_MAILITEM           = 1521;
  SM_MAILSENT           = 1522;
  SM_MAILFAILED         = 1523;
  SM_MAILSTATUS         = 1524;
  SM_BLOCKLIST          = 1525;
  SM_BLOCKLISTITEM      = 1526;
  SM_BLOCKLISTFAIL      = 1527;
  SM_BLOCKLISTADDED     = 1528;
  SM_BLOCKLISTDELETED   = 1529;

  // Next SM_ should start at 1535 to leave space for additions
  //Lover SM
  SM_LOVERINFO = 1535;
  SM_LOVERSUCCESS = 1536;
  SM_REQUESTRELAY = 1537;
  SM_REQUESTRELAYFAIL = 1538;
  SM_LOVERNAME = 1539;

  //GT SM
  SM_GTLIST       = 1545;
  SM_GTDECOLIST   = 1546;
  SM_GTTRADE      = 1547;
  SM_BBSMSGLIST   = 1548;
  SM_BBSMSG       = 1549;

  SM_EXCHGTAKEON_OK=65023;
  SM_EXCHGTAKEON_FAIL=65024;

  SM_ATTATCKMODE             = 8000;

  CM_OPENGAMESHOP            = 9000;
  RM_SENGGAMESHOPITEMS       = 9001;
  SM_SENGGAMESHOPITEMS       = 9002; // SERIES 7 每页的数量    wParam 总页数
  {CM_BUYGAMESHOPITEM         = 9002;
  SM_BUYGAMESHOPITEM_SUCCESS = 9003;
  SM_BUYGAMESHOPITEM_FAIL    = 9004;}

  SM_TEST=65037;
  SM_ACTION_MIN   = 0;
  SM_ACTION_MAX   = 26;
  SM_ACTION2_MIN  = 40;
  SM_ACTION2_MAX  = 100;

  CM_SERVERREGINFO = 65074;

  //-------------------------------------

  CM_GETGAMELIST = 5001;
  SM_SENDGAMELIST = 5002;
  CM_GETBACKPASSWORD = 5003;
  SM_GETBACKPASSWD_SUCCESS = 5005;
  SM_GETBACKPASSWD_FAIL    = 5006;
  SM_SERVERCONFIG = 5007;
  SM_GAMEGOLDNAME = 5008;
  SM_PASSWORD     = 5009;
  SM_HORSERUN     = 5010;
  SM_BANKGOLDCHANGED= 5011;

  UNKNOWMSG           = 199;
  SS_OPENSESSION      = 100;
  SS_CLOSESESSION     = 101;
  SS_KEEPALIVE        = 104;
  SS_KICKUSER         = 111;
  SS_SERVERLOAD       = 113;

  SS_200              = 200;
  SS_201              = 201;
  SS_202              = 202;
  SS_203              = 203;
  SS_204              = 204;
  SS_205              = 205;
  SS_206              = 206;
  SS_207              = 207;
  SS_208              = 208;
  SS_209              = 209;
  SS_210              = 210;
  SS_211              = 211;
  SS_212              = 212;
  SS_213              = 213;
  SS_214              = 214;
  SS_WHISPER          = 299;

  SS_SERVERINFO       = 103;
  SS_SOFTOUTSESSION   = 102;
  //SS_SERVERINFO       = 30001;
  //SS_SOFTOUTSESSION   = 30002;
  SS_LOGINCOST        = 30002;

  DBR_FAIL            = 2000;
  DB_LOADHUMANRCD     = 100;
  DB_SAVEHUMANRCD     = 101;
  DB_SAVEHUMANRCDEX   = 102;//?
  DBR_LOADHUMANRCD    = 1100;
  DBR_SAVEHUMANRCD    = 1102; //?
  {DBR_FAIL            = 31001;
  DB_LOADHUMANRCD     = 31002;
  DB_SAVEHUMANRCD     = 31003;
  DB_SAVEHUMANRCDEX   = 31004;
  DBR_LOADHUMANRCD    = 31005;
  DBR_SAVEHUMANRCD    = 31006;}

  RUNGATECODE = $AB36AB68;

  GM_OPEN             = 1;
  GM_CLOSE            = 2;
  GM_CHECKSERVER      = 3;// Send check signal to Server
  GM_CHECKCLIENT      = 4;// Send check signal to Client
  GM_DATA             = 5;
  GM_SERVERUSERINDEX  = 6;
  GM_RECEIVE_OK       = 7;
  GM_TEST             = 20;


  SG_FORMHANDLE       = 32001;
  SG_STARTNOW         = 32002;
  SG_STARTOK          = 32003;
  SG_CHECKCODEADDR    = 32004;
  SG_USERACCOUNT      = 32005;
  SG_USERACCOUNTCHANGESTATUS = 32006;
  SG_USERACCOUNTNOTFOUND     = 32007;

  GS_QUIT             = 32101;
  GS_USERACCOUNT      = 32102;
  GS_CHANGEACCOUNTINFO = 32103;

type
//-----------------------------------------
  pTDefaultMessage=^TDefaultMessage;
  TDefaultMessage = record
    Recog    :Integer;
    Ident    :Word;
    Param    :Word;
    Tag      :Word;
    Series   :Word;
  end;

  TChrMsg =record
    Ident    :Integer;
    X        :Integer;
    Y        :Integer;
    Dir      :Integer;
    State    :Integer;
    feature  :Integer;
    saying   :String;
    Sound    :Integer;
  end;
  PTChrMsg = ^TChrMsg;


  pTStdItem=^TStdItem;
  TStdItem=packed record
     Name               :String[20];
     StdMode            :Byte;
     Shape              :Byte;
     Weight             :Byte;
     AniCount           :Byte;
     Source             :shortint;
     reserved           :byte;
     NeedIdentify       :byte;
     Looks              :Word;
     DuraMax            :DWord;
     AC                 :Dword;
     MAC                :Dword;
     DC                 :Dword;
     MC                 :Dword;
     SC                 :DWord;
     Need               :DWord;
     NeedLevel          :DWord;
     Price              :UINT;
     Color              :Integer;
     Tox                :Word;
     ToxAvoid           :Word;
     SlowDown           :Word;
     MagAvoid           :Word;
     HpAdd              :Word;
     MpAdd              :Word;
  end;

  PTClientItem =^TClientItem;
  TClientItem = record
    S         :TStdItem;
    MakeIndex :Integer;
    Dura      :Word;
    DuraMax   :Word;
    Amount    :Integer;
  end;

  TUserStateInfo =record
    Feature       :Integer;
    UserName      :String[19];
    GuildName     :String[14];
    GuildRankName :String[14];
    LoverName     :String[ActorNameLen];
    NameColor     :Integer;
    UseItems      :array [0..12] of TClientItem;
  end;
  TUserCharacterInfo =record
    Name:String[19];
    Job:Byte;
    Hair:Byte;
    Level:Integer;
    Sex:Byte;
  end;
  TUserEntry =record
    sAccount      :String[10];
    sPassword     :String[10];
    sUserName     :String[20];
    sSSNo         :String[14];
    sPhone        :String[14];
    sQuiz         :String[20];
    sAnswer       :String[12];
    sEMail        :String[40];
  end;
  TUserEntryAdd =record
    sQuiz2        :String[20];
    sAnswer2      :String[12];
    sBirthDay     :String[10];
    sMobilePhone  :String[15];
    sMemo         :String[40];
    sMemo2        :String[40];
  end;


  TDropItem =record
    X:Integer;
    Y:Integer;
    Id:integer;
    Looks:integer;
    Name:String;
    FlashTime:Dword;
    FlashStepTime:Dword;
    FlashStep:Integer;
    BoFlash:Boolean;
  end;
  PTDropItem = ^TDropItem;

  pTMagic=^TMagic;
  TMagic =record
    wMagicID:Word;
    wMimicID:Word;
    sMagicName:String[20];
    btEffectType:Byte;
    btEffect:Byte;
    wSpell:Word;
    wPower:Word;
    TrainLevel:Array[0..3] of Byte;
    MaxTrain:Array[0..3] of Integer;
    btTrainLv:Byte;
    btJob:Byte;
    dwDelayTime:Integer;
    btDefSpell:Byte;
    btDefPower:Byte;
    wMaxPower:Word;
    btDefMaxPower:Byte;
    sDescr:String[15];
  end;
  TClientMagic = record
    Key    :Char;
    Level  :Byte;
    CurTrain:Integer;
    Def    :TMagic;
  end;
  PTClientMagic = ^TClientMagic;


  pTNakedAbility=^TNakedAbility;
  TNakedAbility =record
    DC    :Word;
    MC    :Word;
    SC    :Word;
    AC    :Word;
    MAC   :Word;
    HP    :Word;
    MP    :Word;
    Hit   :Byte;
    Speed :integer;
    X2    :byte;
  end;



  TShortMessage = record
    Ident    :Word;
    wMsg     :Word;
  end;

  TMessageBodyW = record
    Param1:Word;
    Param2:Word;
    Tag1:Word;
    Tag2:Word;
  end;

  TMessageBodyWL = record 
    lParam1    :Integer;
    lParam2    :Integer;
    lTag1      :Integer;
    lTag2      :Integer;
  end;

  TCharDesc =record
    Feature  :Integer;
    Status   :Integer;
  end;
  TClientGoods = record
    Name    :String;
    SubMenu :Integer;
    Price   :Integer;
    Stock   :Integer;
    Grade   :Integer;
    looks   :Integer;
    Item: TClientItem;
  end;
  pTClientGoods=^TClientGoods;

  pTItemShopItem=^TItemShopItem;
  TItemShopItem = record
    Name            :String;
    Price           :integer;
    looks           :integer;
  end;

  TShopInfo = record
    StdItem: pTSTDITEM;
    sIntroduce:array [0..50] of Char;
  end;
  pTShopInfo = ^TShopInfo;

  pTClientFriends=^TClientFriends;
  TClientFriends = record
    Id        :Word;
    Name      :String;
    Status    :Byte;
    Memo      :String;
    Blacklist :Boolean;
  end;

  pTAbility=^TAbility;
  TAbility= packed record
     Level              :Word;
     AC                 :DWord;
     MAC                :DWord;
     DC                 :DWord;
     MC                 :DWord;
     SC                 :DWord;
     HP                 :Word;
     MP                 :Word;
     MaxHP              :Word;
     MaxMP              :Word;
     Exp                :DWord;
     MaxExp             :DWord;
     Weight             :Word;
     MaxWeight          :Word;
     WearWeight         :Word;
     MaxWearWeight      :Word;
     HandWeight         :Word;
     MaxHandWeight      :Word;
  end;

  //---------------------------------------------

type
  TProgamType=(tDBServer,tLoginSrv,tLogServer,tM2Server,tLoginGate,
    tLoginGate1,tSelGate,tSelGate1,tRunGate,tRunGate1,tRunGate2,
    tRunGate3,tRunGate4,tRunGate5,tRunGate6,tRunGate7);

  TRecordHeader = packed record
     sAccount:String[16];
     sChrName:String[20];

     nSelectID:integer;
     dCreateDate:TDateTime;
     boDeleted:boolean;
     UpdateDate:TDateTime;
     CreateDate:TDateTime;
  end;

  THumInfo = record
     boDeleted:Boolean;
     boSelected:Boolean;
     sAccount:String[10];
     dModDate:TDateTime;
     sChrName:String[20];
     btCount:Byte;
     Header:TRecordHeader;
  end;

  pTUserItem=^TUserItem;
  TUserItem=record                         //=24
    MakeIndex       :Integer;              //+4
    wIndex          :Word;                 //+2
    Dura            :word;                 //+2
    DuraMax         :Word;                 //+2
    btValue         :Array[0..17] of byte; //+16
    Count           :word;
    Color           :Integer;
    Amount          :Integer;
  end;

  pTUserMagic=^TUserMagic;
  TUserMagic=record
    MagicInfo:pTMagic;
    btLevel:byte;
    wMagIdx:word;
    nTranPoint:integer;
    btKey:byte;
  end;

  pTLover=^TLover;
  TLover = record
    Lover           :String[ActorNameLen];
    StartDate       :TDateTime;
    TotalDays       :Integer;
    boHasLover      :Boolean;
  end;

  pTClientGT=^TClientGT;
  TClientGT = record
    Number          :byte;
    GuildName       :String[GuildNameLen];
    GuildMasters    :Array[0..1] of String[ActorNameLen];
    SalePrice       :Integer;
    Status          :byte;//0=normal, 1= onsale, 2= sold, pending activation
  end;

  pTDecoItem=^TDecoItem;
  TDecoItem = record
    Appr            :Word;
    Name            :String[20];
    Price           :integer;
    Location        :byte;
  end;

  THumanUseItems=array[0..12] of TUserItem;
  THumItems=array[0..12] of TUserItem;
  pTHumItems=^THumItems;
  
  pTBagItems=^TBagItems;
  TBagItems=array[0..MAXBAGITEM] of  TUserItem;

  pTStorageItems=^TStorageItems;
  TStorageItems=array[0..STORAGELIMIT] of TUserItem;

  pTHumMagic=^THumMagic;
  THumMagic=Array[0..HOWMANYMAGICS-1] of TUserMagic;

  pTHumMagicInfo=^THumMagicInfo;
  THumMagicInfo=TUserMagic;

  TStatusTime=array [0..MAX_STATUS_ATTRIBUTE - 1] of Word;

  TQuestUnit=array[0..13] of Byte;
  TQuestFlag=array[0..104] of Byte;


  pTHumData=^THumData;
  THumData = packed record       //3164
    sChrName        :String[ActorNameLen];
    sCurMap         :String[MapNameLen];
    wCurX           :Word;
    wCurY           :Word;
    btDir           :Byte;
    btHair          :Byte;
    btSex           :Byte;
    btJob           :Byte;
    nGold           :Integer;

    Abil            :TAbility;         //+40
    wStatusTimeArr  :TStatusTime;
    sHomeMap        :String[MapNameLen];
    wHomeX          :Word;
    wHomeY          :Word;
    BonusAbil       :TNakedAbility;     //+20
    nBonusPoint     :Integer;
    btCreditPoint   :Byte;
    btReLevel       :Byte;

    sMasterName     :String[ActorNameLen];
    boMaster        :Boolean;
    sDearName       :String[ActorNameLen];
    sStoragePwd     :String[10];

    xLoveInfo       :TLover;

    nGameGold       :Integer;
    nBankGold       :Integer;
    nGamePoint      :Integer;
    nPayMentPoint   :Integer;
    nPKPoint        :Integer;

    btAllowGroup    :Byte;
    btFreeGuiltyCount: byte;
    btF9            :Byte;
    btAttatckMode   :Byte;

    btIncHealth     :Byte;
    btIncSpell      :Byte;
    btIncHealing    :Byte;
    btFightZoneDieCount:Byte;
    btEE            :Byte;
    btEF            :Byte;
    btFirstLogin    :byte;

    sAccount        :String[16];
    boLockLogon     :Boolean;

    wContribution   :Word;
    nHungerStatus   :Integer;
    boAllowGuildReCall:Boolean;
    wGroupRcallTime :Word;
    dBodyLuck       :TDateTime;
    boAllowGroupReCall:Boolean;
    QuestUnitOpen   :TQuestUnit;
    QuestUnit       :TQuestUnit;
    QuestFlag       :TQuestFlag;

    btMarryCount    :Byte;


    HumItems        :THumItems;
    BagItems        :TBagItems;
    Magic           :THumMagic;
    StorageItems    :TStorageItems;
  end;

  THumDataInfo= packed record
    Header:TRecordHeader;
    Data:THumData;
  end;

  pTGlobaSessionInfo=^TGlobaSessionInfo;
  TGlobaSessionInfo=record
     sAccount:String[16];
     nSessionID:integer;
     boLoadRcd:Boolean;
     boStartPlay:Boolean;
     sIPaddr:String[15];
     n24:integer;
     dwAddTick:DWord;
     dAddDate:TDateTime;
  end;

  TCheckCode = packed record
     dwThread0:DWord;
     sThread0:String;
  end;

  TAccountDBRecord = record
     Header:TRecordHeader;
     nErrorCount:integer;
     dwActionTick:DWord;
     UserEntry:TUserEntry;
     UserEntryAdd:TUserEntryAdd;
  end;


  pTConnInfo=^TConnInfo;
  TConnInfo=record

  end;

  pTQueryChr=^TQueryChr;
  TQueryChr=packed record
    btClass:Byte;
    btHair:Byte;
    btGender:Byte;
    btLevel:Byte;
    sName:String[ActorNameLen];
  end;


  pTMsgHeader=^TMsgHeader;
  TMsgHeader = record
    dwCode:DWord;
    nSocket:integer;
    wGSocketIdx:word;
    wIdent:word;
    wUserListIndex:word;
    nLength:integer;
  end;

  pTBBSMSGL = ^TBBSMSGL;
  TBBSMSGL = record
    index:integer;
    Sticky:Boolean;
    Poster:String[ActorNameLen];
    Msg:String;
    MasterIndex: integer;
  end;

  pTBBSMSG  = ^TBBSMSG;
  TBBSMSG = record
    index:integer;
    Sticky:Boolean;
    Poster:String[ActorNameLen];
    Msg:String[20];
    MasterIndex: integer;
  end;

//M2Server

Const

  GROUPMAX        = 11;

  CM_42HIT        = 42;

  CM_PASSWORD     = 2001;
  CM_CHGPASSWORD  = 2002;
  CM_SETPASSWORD  = 2004;


  CM_HORSERUN     = 3035;
  CM_CRSHIT       = 3036;
  CM_3037         = 3037;
  CM_TWINHIT      = 3038;
  CM_QUERYUSERSET = 3040;

  SM_PLAYDICE    = 8001;
  SM_PASSWORDSTATUS = 8002;
  SM_NEEDPASSWORD = 8003; 
  SM_GETREGINFO = 8004;

  DATA_BUFSIZE        = 1024;

  RUNGATEMAX          = 8;

  //MAX_STATUS_ATTRIBUTE = 13;
  MAXMAGIC             = 54;

  PN_GETRGB            = 'GetRGB';
  PN_GAMEDATALOG       = 'GameDataLog';
  PN_SENDBROADCASTMSG  = 'SendBroadcastMsg';

  sSTRING_GOLDNAME     = '金币';
  MAXLEVEL             = 500;
  SLAVEMAXLEVEL        = 50;

  LOG_GAMEGOLD         = 1;
  LOG_GAMEPOINT        = 2;

  RC_PLAYOBJECT  = 0;
  RC_GUARD       = 11;
  RC_PEACENPC    = 15;
  RC_ANIMAL      = 50;
  RC_MONSTER     = 80;
  RC_NPC         = 10;
  RC_ARCHERGUARD = 112;


  RM_TURN              = 10001;
  RM_WALK              = 10002;
  RM_HORSERUN          = 50003;
  RM_RUN               = 10003;
  RM_HIT               = 10004;
  RM_BIGHIT            = 10006;
  RM_HEAVYHIT          = 10007;
  RM_SPELL             = 10008;
  RM_SPELL2            = 10009;
  RM_MOVEFAIL          = 10010;
  RM_LONGHIT           = 10011;
  RM_WIDEHIT           = 10012;
  RM_FIREHIT           = 10014;
  RM_CRSHIT            = 10015;
  RM_DEATH             = 10021;
  RM_SKELETON          = 10024;
  RM_READYFIREHIT      = 10026;
  
  RM_LOGON             = 10050;
  RM_ABILITY           = 10051;
  RM_HEALTHSPELLCHANGED= 10052;
  RM_DAYCHANGING       = 10053;
  RM_81                = 10054;
  RM_82                = 10055;
  RM_83                = 10056;

  RM_10101             = 10101;
  RM_WEIGHTCHANGED     = 10115;
  RM_FEATURECHANGED    = 10116;
  RM_BUTCH             = 10119;
  RM_MAGICFIRE         = 10120;
  RM_MAGICFIREFAIL     = 10121;
  RM_SENDMYMAGIC       = 10122;

  RM_MAGIC_LVEXP       = 10123;
  RM_DURACHANGE        = 10125;
  RM_MERCHANTDLGCLOSE  = 10127;
  RM_SENDGOODSLIST     = 10128;
  RM_SENDUSERSELL      = 10129;
  RM_SENDBUYPRICE      = 10130;
  RM_USERSELLITEM_OK   = 10131;
  RM_USERSELLITEM_FAIL = 10132;
  RM_BUYITEM_SUCCESS   = 10133;
  RM_AUCTIONGIVE       = 11133;
  RM_BUYITEM_FAIL      = 10134;
  RM_SENDDETAILGOODSLIST=10135;
  RM_GOLDCHANGED       = 10136;
  RM_CHANGELIGHT       = 10137;
  RM_LAMPCHANGEDURA    = 10138;
  RM_CHARSTATUSCHANGED = 10139;
  RM_GROUPCANCEL       = 10140;
  RM_SENDUSERREPAIR    = 10141;

  RM_SENDUSERSREPAIR   = 50142;
  RM_SENDREPAIRCOST    = 10142;
  RM_USERREPAIRITEM_OK = 10143;
  RM_USERREPAIRITEM_FAIL=10144;
  RM_USERSTORAGEITEM   = 10146;
  RM_USERGETBACKITEM   = 10147;
  RM_SENDDELITEMLIST   = 10148;
  RM_USERMAKEDRUGITEMLIST=10149;
  RM_MAKEDRUG_SUCCESS  = 10150;
  RM_MAKEDRUG_FAIL     = 10151;
  RM_ALIVE             = 10153;

  RM_USERCONSIGN       = 10145;

  RM_10155             = 10155;
  RM_DIGUP             = 10200;
  RM_DIGDOWN           = 10201;
  RM_FLYAXE            = 10202;
  RM_LIGHTING          = 10204;
  RM_10205             = 10205;

  RM_CHANGEGUILDNAME   = 10301;
  RM_SUBABILITY        = 10302;
  RM_BUILDGUILD_OK     = 10303;
  RM_BUILDGUILD_FAIL   = 10304;
  RM_DONATE_OK         = 10305;
  RM_DONATE_FAIL       = 10306;

  RM_MENU_OK           = 10309;

  RM_RECONNECTION      = 10332;
  RM_HIDEEVENT         = 10333;
  RM_SHOWEVENT         = 10334;

  RM_10401             = 10401;
  RM_OPENHEALTH        = 10410;
  RM_CLOSEHEALTH       = 10411;
  RM_BREAKWEAPON       = 10413;
  RM_10414             = 10414;
  RM_CHANGEFACE        = 10415;
  RM_PASSWORD          = 10416;

  RM_PLAYDICE          = 10500;


  RM_HEAR              = 11001;
  RM_WHISPER           = 11002;
  RM_CRY               = 11003;
  RM_SYSMESSAGE        = 11004;
  RM_GROUPMESSAGE      = 11005;
  RM_SYSMESSAGE2       = 11006;
  RM_GUILDMESSAGE      = 11007;
  RM_SYSMESSAGE3       = 11008;
  RM_MERCHANTSAY       = 11009;

  RM_ATTATCKMODE       = 8000;

  RM_ZEN_BEE           = 8020;
  RM_DELAYMAGIC        = 8021;
  RM_STRUCK            = 8018;
  RM_MAGSTRUCK_MINE    = 8030;
  RM_MAGHEALING        = 8034;

  RM_POISON            = 8037;
  
  RM_DOOPENHEALTH      = 8040;
  RM_SPACEMOVE_FIRE2   = 8042;
  RM_DELAYPUSHED       = 8043;
  RM_MAGSTRUCK         = 8044;
  RM_TRANSPARENT       = 8045;

  RM_DOOROPEN          = 8046;
  RM_DOORCLOSE         = 8047;
  RM_DISAPPEAR         = 8061;
  RM_SPACEMOVE_FIRE    = 8062;
  RM_SENDUSEITEMS      = 8074;
  RM_WINEXP            = 8075;
  RM_ADJUST_BONUS      = 8078;
  RM_ITEMSHOW          = 8082;
  RM_GAMEGOLDCHANGED   = 8084;
  RM_ITEMHIDE          = 8085;
  RM_LEVELUP           = 8086;
  RM_BACKGOLDCHANGED   = 8087;
  
  RM_CHANGENAMECOLOR   = 8090;
  RM_PUSH              = 8092;

  RM_CLEAROBJECTS      = 8097;
  RM_CHANGEMAP         = 8098;
  RM_SPACEMOVE_SHOW2   = 8099;
  RM_SPACEMOVE_SHOW    = 8100;
  RM_USERNAME          = 8101;
  RM_MYSTATUS          = 8102;
  RM_STRUCK_MAG        = 8103;
  RM_RUSH              = 8104;
  RM_RUSHKUNG          = 8105;
  RM_PASSWORDSTATUS    = 8106;
  RM_POWERHIT          = 8107;
  RM_41                = 9041;
  RM_TWINHIT           = 9042;
  RM_43                = 9043;

  RM_GETMAKEGEMLIST    = 9044;



  OS_EVENTOBJECT       = 1;
  OS_MOVINGOBJECT      = 2;
  OS_ITEMOBJECT        = 3;
  OS_GATEOBJECT        = 4;
  OS_MAPEVENT          = 5;
  OS_DOOR              = 6;
  OS_ROON              = 7;


  //技能编号（正确）
    //OFFICIAL SKILLS
  SKILL_FIREBALL       = 1;  //Fireball
  SKILL_HEALLING       = 2;  //Healing
  SKILL_ONESWORD       = 3;  //Fencing
  SKILL_ILKWANG        = 4;
  SKILL_FIREBALL2      = 5;  //GFireball
  SKILL_AMYOUNSUL      = 6;
  SKILL_YEDO           = 7;
  SKILL_FIREWIND       = 8;
  SKILL_FIRE           = 9;
  SKILL_SHOOTLIGHTEN   = 10;
  SKILL_LIGHTENING     = 11;
  SKILL_ERGUM          = 12;
  SKILL_FIRECHARM      = 13;
  SKILL_HANGMAJINBUB   = 14;
  SKILL_DEJIWONHO      = 15;
  SKILL_HOLYSHIELD     = 16;
  SKILL_SKELLETON      = 17; //SummonSkeleton
  SKILL_CLOAK          = 18; //Hiding
  SKILL_BIGCLOAK       = 19; //MassHiding
  SKILL_TAMMING        = 20; //ElectricShock
  SKILL_SPACEMOVE      = 21;
  SKILL_EARTHFIRE      = 22;
  SKILL_FIREBOOM       = 23;
  SKILL_LIGHTFLOWER    = 24;
  SKILL_BANWOL         = 25;
  SKILL_FIRESWORD      = 26; //FlamingSword
  SKILL_MOOTEBO        = 27;
  SKILL_SHOWHP         = 28; //Revelation
  SKILL_BIGHEALLING    = 29; //MassHealing
  SKILL_SINSU          = 30; //SummonShinsoo
  SKILL_SHIELD         = 31; //MagicShield
  SKILL_KILLUNDEAD     = 32; //TurnUndead
  SKILL_SNOWWIND       = 33; //IceStorm
  SKILL_CROSSMOON      = 34; //CrossHalfMoon
  SKILL_FLAMEDIS       = 35; //FlameDisruptor
  SKILL_ENHANCER       = 36; //UltimateEnhancer
  SKILL_ENERGYREPULSOR = 37; //EnergyRepulse
  SKILL_TWINBLADE      = 38; //TwinDragonBlade
  SKILL_FROST          = 39; //FrostCrunch
  SKILL_PURI           = 40; //Purification
  SKILL_ANGEL          = 41; //SummonHolyDeva
  SKILL_MIRROR         = 42; //Mirroring
  SKILL_LION           = 43; //LionRoar
  SKILL_BLADEAV        = 44; //BladeAvalance
  SKILL_FLAMEFIELD     = 45; //FlameField
  SKILL_CURSE          = 46; //Curse
  SKILL_ENTRAP         = 47; //Entrapment
  SKILL_VAMP           = 48; //Vampirism
  SKILL_HALLUC         = 49; //Hallucination
  SKILL_RAGE           = 50; //Rage
  SKILL_PROTECTIONFIELD= 51; //ProtectionField
  SKILL_ICESHOWER      = 52; //Blizzard
  SKILL_FIRESHOWER     = 53; //MeteorShower
  SKILL_RESURRECTION   = 54; //Reincarnation
  SKILL_MASSPOISON     = 55; //PoisonCloud
  SKILL_REDBANWOL      = 56; //useless warrior spell
  SKILL_WINDSTAINED    = 57;
  SKILL_SUNCHEN        = 58;

  LA_UNDEAD            = 1;

  sENCYPTSCRIPTFLAG= '不知道是什么字符串';
  sSTATUS_FAIL     = '+FAIL/';
  sSTATUS_GOOD     = '+GOOD/';
  nMAIL_LOCKED     = 1;
  nMAIL_SPECIAL    = 2;  

type
  pTAuctionItem=^TAuctionItem;
  TAuctionItem = record
    AuctionID: Integer;
    StartTime: TDateTime;
    EndTime: TDateTime;
    Cost: Integer;
    Seller: String[ActorNameLen];
    Item: TClientItem;
  end;

  pTMapItem=^TMapItem;
  TMapItem=record
    Name            :String[40];
    Looks           :word;
    AniCount        :byte;
    Reserved        :integer;
    Count           :integer;
    DropBaseObject  :TObject;
    OfBaseObject    :TObject;
    dwCanPickUpTick :Dword;
    UserItem        :TUserItem;
  end;

  pTMailItem=^TMailItem;
  TMailItem = record
    Id        :Integer;
    Sender    :String;
    Recipient :String; // Should Always be me
    Content   :String;
    Read      :Boolean;
    Status    :Integer;
    Time      :Integer;
  end;

  pTBlockItem=^TBlockItem;
  TBlockItem = record
    Id        :Integer;
    Owner     :String; // Should Always be me
    Name      :String;
  end;

  pTGemSystem=^TGemSystem;
  TGemSystem = record
    Gem      :String;
    Item1    :Integer;
    Item2    :Integer;
    Item3    :Integer;
    Item4    :Integer;
    Item5    :Integer;
    Item6    :Integer;
  end;

   {
    TTerritory=record
   TerritoryNumber:Byte;
   GuildName:String;
   GuildMaster:String;
   RegDate:String;
   RemainingDays:Integer;
   TerritoryGold:LongWord;
   ForSale:Boolean;
   ForSaleGold:LongWord;
   ForSaleRemainDays:Integer;
   BidderGuildName:String;
   BidderGuildMaster:String;
   ForSaleEnd:String;
  end;
 }

  pTDoorStatus=^TDoorStatus;
  TDoorStatus=record
    bo01:boolean;
    n04:integer;
    boOpened:Boolean;
    dwOpenTick:dword;
    nRefCount:integer;
  end;

  pTDoorInfo=^TDoorInfo;
  TDoorInfo=record
    nX,nY:Integer;
    Status:pTDoorStatus;
    nPoint:integer;
  end;

  pTMapFlag=^TMapFlag;
  TMapFlag=record
     boSAFE:Boolean;
     nL:integer;
     nNEEDSETONFlag:integer;
     nNeedONOFF:integer;
     nMUSICID:integer;
     boDarkness:boolean;
     boDayLight:boolean;
     boFightZone:boolean;
     boFight3Zone:boolean;
     boQUIZ:boolean;
     boNORECONNECT:boolean;
     sNoReConnectMap:string;
     boMUSIC:boolean;
     boEXPRATE:boolean;
     nEXPRATE:integer;
     boPKWINLEVEL:boolean;
     nPKWINLEVEL:integer;
     boPKWINEXP:boolean;
     nPKWINEXP:integer;
     boPKLOSTLEVEL:boolean;
     nPKLOSTLEVEL:integer;
     boPKLOSTEXP:boolean;
     nPKLOSTEXP:integer;
     boDECHP:boolean;
     nDECHPPOINT:integer;
     nDECHPTIME:integer;
     boINCHP:boolean;
     nINCHPPOINT:integer;
     nINCHPTIME:integer;
     boDECGAMEGOLD:boolean;
     nDECGAMEGOLD:integer;
     nDECGAMEGOLDTIME:integer;
     boDECGAMEPOINT:boolean;
     nDECGAMEPOINT:integer;
     nDECGAMEPOINTTIME:integer;
     boINCGAMEGOLD:boolean;
     nINCGAMEGOLD:integer;
     nINCGAMEGOLDTIME:integer;
     boINCGAMEPOINT:boolean;
     nINCGAMEPOINT:integer;
     nINCGAMEPOINTTIME:integer;
     boRUNHUMAN:boolean;
     boRUNMON:boolean;
     boNEEDHOLE:boolean;
     boNORECALL:boolean;
     boNOGUILDRECALL:boolean;
     boNODEARRECALL:boolean;
     boNOMASTERRECALL:boolean;
     boNORANDOMMOVE:boolean;
     boNODRUG:boolean;
     boMINE:boolean;
     boMINE2:boolean;
     boMINE3:boolean;
     boNOPOSITIONMOVE:boolean;
     boNODROPITEM:boolean;
     boNOTHROWITEM:boolean;
     boNOHORSE:Boolean;
     boNOCHAT:Boolean;
     nThunder:Integer;
     nLava:Integer;
     nGuildTerritory:Integer;
  end;

  TAddAbility=record
     wHP,wMP:Word;
     wHitPoint,wSpeedPoint:Word;
     wAC,wMAC,wDC,wMC,wSC:DWord;
     wAntiPoison,wPoisonRecover,
     wPoisonIncrease,wFreezingIncrease,
     wTox,wSlowDown,
     wHealthRecover,wSpellRecover:Word;
     wAntiMagic:Word;
     btLuck,btUnLuck:Byte;
     btWeaponStrong:BYTE;
     nHitSpeed:Word;
     btUndead:Byte;


     Weight,WearWeight,HandWeight:Word;

  end;


  TMsgColor=(c_Red,c_Green,c_Blue,c_White,c_RedWhite);
  TMsgType=(t_System,t_Notice,t_Hint,t_Say,t_Castle,t_Cust,t_GM,t_Mon,t_SVN1,t_SVN2,t_SVN3);

  pTProcessMessage=^TProcessMessage;
  TProcessMessage=record
     wIdent:word;
     wParam:word;
     nParam1:integer;
     nParam2:integer;
     nParam3:integer;
     dwDeliveryTime:dword;
     BaseObject:TObject;
     boLateDelivery:Boolean;
     sMsg:String;
  end;

  pTSessInfo=^TSessInfo;
  TSessInfo=record
     nSessionID       :Integer;
     sAccount         :String[10];
     sIPaddr          :String;
     nPayMent         :integer;
     nPayMode         :integer;
     nSessionStatus   :integer;
     dwStartTick      :dword;
     dwActiveTick     :dword;
     nRefCount        :integer;
     nSocket          :integer;
     nGateIdx         :integer;
     nGSocketIdx      :integer;
     dwNewUserTick    :dword;
     nSoftVersionDate :integer;
  end;

  TScriptQuestInfo=record
     wFlag:word;
     btValue:byte;
     nRandRage:integer;
  end;
  TQuestInfo=array of TScriptQuestInfo;

  pTScript=^TScript;
  TScript=record
     boQuest:boolean;
     QuestInfo:TQuestInfo;
     RecordList:TList;
     nQuest:Integer;
  end;

  pTGameCmd=^TGameCmd;
  TGameCmd=record
     sCmd           :String;
     nPerMissionMin :integer;
     nPerMissionMax :integer;
  end;

  TQuestUnitStatus = record
    nQuestUnit: Integer;
    boOpen: Boolean;
  end;
  pTQuestUnitStatus = ^TQuestUnitStatus;

  TMapCondition = record
    nHumStatus: Integer;
    sItemName: string[14];
    boNeedGroup: Boolean;
  end;
  pTMapCondition = ^TMapCondition;

  TStartScript = record
    nLable: Integer;
    sLable: string[100];
  end;

  TMapEvent = record
    m_sMapName: string[MAPNAMELEN];
    m_nCurrX: Integer;
    m_nCurrY: Integer;
    m_nRange: Integer;
    m_MapFlag: TQuestUnitStatus;
    m_nRandomCount: Integer; //; 范围:(0 - 999999) 0 的机率为100% ; 数字越大，机率越低
    m_Condition: TMapCondition; //触发条件
    m_StartScript: TStartScript;
  end;
  pTMapEvent = ^TMapEvent;

  pTLoadDBInfo=^TLoadDBInfo;
  TLoadDBInfo=record
    nGateIdx:integer;
    nSocket:integer;
    sAccount:String[10];
    sCharName:String[20];
    nSessionID:integer;
    sIPaddr:String[15];
    nSoftVersionDate:integer;
    nPayMent:integer;
    nPayMode:integer;
    nGSocketIdx:integer;
    dwNewUserTick:dword;
    PlayObject:TObject;
    nReLoadCount:Integer;
  end;

  pTGoldChangeInfo=^TGoldChangeInfo;
  TGoldChangeInfo=record
     sGameMasterName:string;
     sGetGoldUser:String;
     nGold:integer;
  end;

  pTSaveRcd=^TSaveRcd;
  TSaveRcd=record
    sAccount:String[16];
    sChrName:String[20];
    nSessionID:integer;
    PlayObject:TObject;
    HumanRcd:THumData;
    nReTryCount:integer;
  end;

  pTMonGenInfo=^TMonGenInfo;
  TMonGenInfo=record
     sMapName:String;
     nX,nY:Integer;
     sMonName:String;
     nRange:Integer;
     nCount:Integer;
     dwZenTime:dword;
     nMissionGenRate:integer;
     CertList:TList;
     Envir:TObject;
     nRace:integer;
     dwStartTick:dword;
  end;

  pTMonInfo=^TMonInfo;
  TMonInfo=record
    ItemList:TList;
    sName:String;
    btRace:Byte;
    btRaceImg:byte;
    wAppr:word;
    wLevel:word;
    btLifeAttrib:byte;
    wCoolEye:word;
    dwExp:dword;
    wHP,wMP:word;
    wAC,wMAC,wDC,wMaxDC,wMC,wSC:Word;
    wSpeed,wHitPoint,wWalkSpeed,wWalkStep,wWalkWait,wAttackSpeed:Word;
    wAntiPush:Word;
    boAggro,boTame:Boolean;
  end;

  pTMonItem=^TMonItem;
  TMonItem=record
    MaxPoint:integer;
    SelPoint:integer;
    ItemName:String;
    Count:integer;
  end;

  pTUnbindInfo=^TUnbindInfo;
  TUnbindInfo=record
    nUnbindCode  :Integer;
    sItemName    :String;
  end;

  TSlaveInfo=record
    sSlaveName:String;
    btSlaveLevel:byte;
    dwRoyaltySec:dword;
    nKillCount:integer;
    btSlaveExpLevel:byte;
    nHP,nMP:integer;
  end;
  pTSlaveInfo=^TSlaveInfo;

  pTSwitchDataInfo=^TSwitchDataInfo;
  TSwitchDataInfo=record
     sMap:String;
     wX,wY:word;
     Abil:TAbility;
     sChrName:String;
     nCode:integer;
     boC70:boolean;
     boBanShout:boolean;
     boHearWhisper:boolean;
     boBanGuildChat:boolean;
     boAdminMode:boolean;
     boObMode:boolean;
     BlockWhisperArr:array of string;
     SlaveArr:array of TSlaveInfo;
     StatusValue:Array [0..5] of word;
     StatusTimeOut:array [0..5] of LongWord;
  end;

  TIPaddr=record
    sIpaddr:String;
    dIPaddr:String;
  end;

  pTGateInfo=^TGateInfo;
  TGateInfo=record
    boUsed:Boolean;
    Socket:TCustomWinSocket;
    sAddr :String;
    nPort :integer;
    n520  :integer;
    UserList :TList;
    nUserCount :Integer;
    Buffer:pchar;
    nBuffLen:integer;
    BufferList:TList;
    boSendKeepAlive:Boolean;
    nSendChecked:integer;
    nSendBlockCount:integer;
    dwStartTime:dword;
    nSendMsgCount:integer;
    nSendRemainCount:integer;
    dwSendTick:Dword;
    nSendMsgBytes:integer;
    nSendBytesCount:integer;
    nSendedMsgCount:integer;
    nSendCount:integer;
    dwSendCheckTick:dword;
  end;

  pTGateUserInfo=^TGateUserInfo;
  TGateUserInfo=record
     PlayObject:TObject;
     nSessionID:integer;
     sAccount:String[10];
     nGSocketIdx:integer;
     sIPaddr:string[15];
     boCertification:boolean;
     sCharName:String[20];
     nClientVersion:integer;
     SessInfo:pTSessInfo;
     nSocket:integer;
     FrontEngine:TObject;
     UserEngine:TObject;
     dwNewUserTick:Dword;
  end;

  TClassProc=procedure(Sender:TObject);


  TCheckVersion=class

  end;

  TGameDataLog=function (p:Pchar;len:integer):Boolean;
  TMainMessageProc=procedure (Msg:PChar;nMsgLen:Integer;nMode:Integer);stdcall;
  TFindProcTableProc=function (ProcName:PChar;nNameLen:Integer):Pointer;stdcall;
  TSetProcTableProc=function(ProcAddr:Pointer;ProcName:PChar;nNameLen:Integer):Boolean;stdcall;
  TFindObj=function(ObjName:PChar;nNameLen:Integer):TObject;stdcall;
  TPlugInit=function (hnd:THandle;p:TMainMessageProc;p2:TFindProcTableProc;p3:TSetProcTableProc;p4:TFindOBj):Pchar;
  TDeCryptString=Procedure (src:Pointer;dest:pointer;srcLen:integer;var destLen:Integer);
  TMsgProc=procedure (Msg:PChar;nMsgLen:Integer;nMode:Integer);stdcall;
  TFindProc=function(sProcName:Pchar;len:Integer):Pointer;
  TSetProc=function (ProcAddr:Pointer;ProcName:PChar;len:integer):Boolean;




  TSpitMap=array [0..7] of array[0..4,0..4] of integer;

  TLevelNeedExp=Array[1..500] of dword;

  TClientConf=record
     boClientCanSet    :boolean;
     boRunHuman        :boolean;
     boRunMon          :boolean;
     boRunNpc          :boolean;
     boWarRunAll       :boolean;
     btDieColor        :byte;
     wSpellTime        :word;
     wHitIime          :word;
     wItemFlashTime    :word;
     btItemSpeed       :byte;
     boCanStartRun     :boolean;
     boParalyCanRun    :boolean;
     boParalyCanWalk   :boolean;
     boParalyCanHit    :boolean;
     boParalyCanSpell  :boolean;
     boShowRedHPLable  :boolean;
     boShowHPNumber    :boolean;
     boShowJobLevel    :boolean;
     boDuraAlert       :boolean;
     boMagicLock       :boolean;
     boAutoPuckUpItem  :boolean;
  end;

  TRecallMigic=record
    nHumLevel:integer;
    sMonName:String;
    nCount:integer;
    nLevel:integer;
  end;

  pTM2Config=^TM2Config;
  pTThreadInfo=^TThreadInfo;
  TThreadInfo=Record
    dwRunTick       :dword;
    boTerminaled    :boolean;
    nRunTime        :integer;
    nMaxRunTime     :integer;
    boActived       :boolean;
    nRunFlag        :integer;
    Config          :pTM2Config;
    hThreadHandle   :THandle;
    dwThreadID      :dword;
  end;

  TGlobaDyMval=Array of word;

  TM2Config=record
    nConfigSize             :integer;
    sServerName             :String;
    sServerIPaddr           :String;
    sWebSite                :String;
    sBbsSite                :String;
    sClientDownload         :String;
    sQQ                     :String;
    sPhone                  :String;
    sBankAccount0           :String;
    sBankAccount1           :String;
    sBankAccount2           :String;
    sBankAccount3           :String;
    sBankAccount4           :String;
    sBankAccount5           :String;
    sBankAccount6           :String;
    sBankAccount7           :String;
    sBankAccount8           :String;
    sBankAccount9           :String;
    nServerNumber           :integer;
    boVentureServer         :boolean;
    boTestServer            :boolean;
    boServiceMode           :boolean;
    boNonPKServer           :boolean;
    nTestLevel              :integer;
    nTestGold               :integer;
    nTestUserLimit          :integer;
    nSendBlock              :integer;
    nCheckBlock             :integer;
    boDropLargeBlock        :Boolean;
    nAvailableBlock         :integer;
    nGateLoad               :integer;
    nUserFull               :integer;
    nZenFastStep            :integer;
    sGateAddr               :String[15];
    nGatePort               :integer;
    sDBAddr                 :String[15];
    nDBPort                 :integer;
    sIDSAddr                :String[15];
    nIDSPort                :integer;
    sMsgSrvAddr             :String[15];
    nMsgSrvPort             :integer;
    sLogServerAddr          :String[15];
    nLogServerPort          :integer;
    boDiscountForNightTime  :boolean;
    nHalfFeeStart           :integer;
    nHalfFeeEnd             :integer;
    boViewHackMessage       :Boolean;
    boViewAdmissionFailure  :Boolean;
    sBaseDir                :String;
    sGuildDir               :String;
    sGuildFile              :String;
    sVentureDir             :String;
    sConLogDir              :String;
    sCastleDir              :String;
    sCastleFile             :String;
    sEnvirDir               :String;
    sMapDir                 :String;
    sNoticeDir              :String;
    sLogDir                 :String;
    sPlugDir                :String;
    sClientFile1            :String;
    sClientFile2            :String;
    sClientFile3            :String;
    sClothsMan              :String;
    sClothsWoman            :String;
    sWoodenSword            :String;
    sCandle                 :String;
    sBasicDrug              :String;
    sGoldStone              :String;
    sSilverStone            :String;
    sSteelStone             :String;
    sCopperStone            :String;
    sBlackStone             :String;
    sGemStone1              :String;
    sGemStone2              :String;
    sGemStone3              :String;
    sGemStone4              :String;

    sZuma                   :Array[0..3] of String[ActorNameLen];
    sBee                    :String[ActorNameLen];
    sSpider                 :String[ActorNameLen];
    sWoomaHorn              :String;
    sZumaPiece              :String;
    sGameGoldName           :String;
    sGamePointName          :String;
    sPayMentPointName       :String;
    DBSocket                :integer;
    nHealthFillTime         :integer;
    nSpellFillTime          :integer;
    nMonUpLvNeedKillBase    :integer;
    nMonUpLvRate            :integer;
    MonUpLvNeedKillCount    :Array[0..7] of integer;
    SlaveColor              :Array[0..8] of Byte;
    dwNeedExps              :TLevelNeedExp;
    WideAttack              :Array[0..2] of integer;
    CrsAttack               :Array [0..6] of integer;
    SpitMap                 :TSpitMap;
    sHomeMap                :String;
    nHomeX                  :integer;
    nHomeY                  :integer;
    sRedHomeMap             :String;
    nRedHomeX               :integer;
    nRedHomeY               :integer;
    sRedDieHomeMap          :String;
    nRedDieHomeX            :integer;
    nRedDieHomeY            :integer;

    boJobHomePoint          :Boolean;
    sWarriorHomeMap         :String;
    nWarriorHomeX           :integer;
    nWarriorHomeY           :integer;
    sWizardHomeMap          :String;
    nWizardHomeX            :integer;
    nWizardHomeY            :integer;
    sTaoistHomeMap          :String;
    nTaoistHomeX            :integer;
    nTaoistHomeY            :integer;
    dwDecPkPointTime        :dword;
    nDecPkPointCount        :integer;
    dwPKFlagTime            :dword;
    nKillHumanAddPKPoint    :integer;
    nKillHumanDecLuckPoint  :integer;
    dwDecLightItemDrugTime  :dword;
    nSafeZoneSize           :integer;
    nStartPointSize         :integer;
    dwHumanGetMsgTime       :dword;
    nGroupMembersMax        :integer;
    sFireBallSkill          :String[12];
    sHealSkill              :String[12];
    sRingSkill              :Array[0..10] of String[12];
    ReNewNameColor          :Array[0..9] of byte;
    dwReNewNameColorTime    :dword;
    boReNewChangeColor      :boolean;
    boReNewLevelClearExp    :boolean;
    BonusAbilofWarr,
    BonusAbilofWizard,
    BonusAbilofTaos,
    NakedAbilofWarr,
    NakedAbilofWizard,
    NakedAbilofTaos         :TNakedAbility;
    nUpgradeWeaponMaxPoint  :integer;
    nUpgradeWeaponPrice     :integer;
    dwUPgradeWeaponGetBackTime     :dword;
    nClearExpireUpgradeWeaponDays  :integer;
    nUpgradeWeaponDCRate           :integer;
    nUpgradeWeaponDCTwoPointRate   :integer;
    nUpgradeWeaponDCThreePointRate :integer;
    nUpgradeWeaponSCRate           :integer;
    nUpgradeWeaponSCTwoPointRate   :integer;
    nUpgradeWeaponSCThreePointRate :integer;
    nUpgradeWeaponMCRate           :integer;
    nUpgradeWeaponMCTwoPointRate   :integer;
    nUpgradeWeaponMCThreePointRate :integer;
    dwProcessMonstersTime          :dword;
    dwRegenMonstersTime            :dword;
    nMonGenRate                    :integer;
    nProcessMonRandRate            :integer;
    nProcessMonLimitCount          :integer;
    nSoftVersionDate               :integer;
    boCanOldClientLogon            :boolean;
    dwConsoleShowUserCountTime     :dword;
    dwShowLineNoticeTime           :dword;
    nLineNoticeColor               :integer;
    nStartCastleWarDays            :integer;
    nStartCastlewarTime            :integer;
    dwShowCastleWarEndMsgTime      :dword;
    dwCastleWarTime                :dword;
    dwGetCastleTime                :dword;
    dwGuildWarTime                 :dword;
    nBuildGuildPrice               :integer;
    nGuildWarPrice                 :integer;
    nMakeDurgPrice                 :integer;
    nHumanMaxGold                  :integer;
    nHumanTryModeMaxGold           :integer;
    nTryModeLevel                  :integer;
    boTryModeUseStorage            :boolean;
    nCanShoutMsgLevel              :integer;
    boShowMakeItemMsg              :boolean;
    boShutRedMsgShowGMName         :boolean;
    nSayMsgMaxLen                  :integer;
    dwSayMsgTime                   :dword;
    nSayMsgCount                   :integer;
    dwDisableSayMsgTime            :dword;
    nSayRedMsgMaxLen               :integer;
    boShowGuildName                :boolean;
    boShowRankLevelName            :boolean;
    boMonSayMsg                    :boolean;
    nStartPermission               :integer;
    boKillHumanWinLevel            :boolean;
    boKilledLostLevel              :boolean;
    boKillHumanWinExp              :boolean;
    boKilledLostExp                :boolean;
    nKillHumanWinLevel             :integer;
    nKilledLostLevel               :integer;
    nKillHumanWinExp               :integer;
    nKillHumanLostExp              :integer;
    nHumanLevelDiffer              :integer;
    nMonsterPowerRate              :integer;
    nItemsPowerRate                :integer;
    nItemsACPowerRate              :integer;
    boSendOnlineCount              :boolean;
    nSendOnlineCountRate           :integer;
    dwSendOnlineTime               :dword;
    dwSaveHumanRcdTime             :dword;
    dwHumanFreeDelayTime           :dword;
    dwMakeGhostTime                :dword;
    dwClearDropOnFloorItemTime     :dword;
    dwFloorItemCanPickUpTime       :dword;
    boPasswordLockSystem           :boolean;  //是否启用密码保护系统
    boLockDealAction               :boolean;  //是否锁定交易操作
    boLockDropAction               :boolean;  //是否锁定扔物品操作
    boLockGetBackItemAction        :boolean;  //是否锁定取仓库操作
    boLockHumanLogin               :boolean;  //是否锁定走操作
    boLockWalkAction               :boolean;  //是否锁定走操作
    boLockRunAction                :boolean;  //是否锁定跑操作
    boLockHitAction                :boolean;  //是否锁定攻击操作
    boLockSpellAction              :boolean;  //是否锁定魔法操作
    boLockSendMsgAction            :boolean;  //是否锁定发信息操作
    boLockUserItemAction           :boolean;  //是否锁定使用物品操作
    boLockInObModeAction           :boolean;  //锁定时进入隐身状态
    nPasswordErrorCountLock        :integer;  //输入密码错误超过 指定次数则锁定密码
    boPasswordErrorKick            :boolean;  //输入密码错误超过限制则踢下线
    nSendRefMsgRange               :integer;
    boDecLampDura                  :boolean;
    boHungerSystem                 :boolean;
    boHungerDecHP                  :boolean;
    boHungerDecPower               :boolean;
    boDiableHumanRun               :boolean;
    boRunHuman                     :boolean;
    boRunMon                       :boolean;
    boRunNpc                       :boolean;
    boRunGuard                     :boolean;
    boWarDisHumRun                 :boolean;
    boGMRunAll                     :boolean;
    boSafeZoneRunAll               :Boolean;
    dwTryDealTime                  :dword;
    dwDealOKTime                   :dword;
    boCanNotGetBackDeal            :boolean;
    boDisableDeal                  :boolean;
    nMasterOKLevel                 :integer;
    nMasterOKCreditPoint           :integer;
    nMasterOKBonusPoint            :integer;
    boPKLevelProtect               :boolean;
    nPKProtectLevel                :integer;
    nRedPKProtectLevel             :integer;
    nItemPowerRate                 :integer;
    nItemExpRate                   :integer;
    nScriptGotoCountLimit          :integer;
    btHearMsgFColor                :byte; //前景
    btHearMsgBColor                :byte; //背景
    btWhisperMsgFColor             :byte; //前景
    btWhisperMsgBColor             :byte; //背景
    btGMWhisperMsgFColor           :byte; //前景
    btGMWhisperMsgBColor           :byte; //背景
    btCryMsgFColor                 :byte; //前景
    btCryMsgBColor                 :byte; //背景
    btGreenMsgFColor               :byte; //前景
    btGreenMsgBColor               :byte; //背景
    btBlueMsgFColor                :byte; //前景
    btBlueMsgBColor                :byte; //背景
    btRedMsgFColor                 :byte; //前景
    btRedMsgBColor                 :byte; //背景
    btGuildMsgFColor               :byte; //前景
    btGuildMsgBColor               :byte; //背景
    btGroupMsgFColor               :byte; //前景
    btGroupMsgBColor               :byte; //背景
    btCustMsgFColor                :byte; //前景
    btCustMsgBColor                :byte; //背景
    nMonRandomAddValue             :integer;
    nMakeRandomAddValue            :integer;
    nWeaponDCAddValueMaxLimit      :integer;
    nWeaponDCAddValueRate          :integer;
    nWeaponMCAddValueMaxLimit      :integer;
    nWeaponMCAddValueRate          :integer;
    nWeaponSCAddValueMaxLimit      :integer;
    nWeaponSCAddValueRate          :integer;
    nDressDCAddRate                :integer;
    nDressDCAddValueMaxLimit       :integer;
    nDressDCAddValueRate           :integer;
    nDressMCAddRate                :integer;
    nDressMCAddValueMaxLimit       :integer;
    nDressMCAddValueRate           :integer;
    nDressSCAddRate                :integer;
    nDressSCAddValueMaxLimit       :integer;
    nDressSCAddValueRate           :integer;
    nNeckLace202124DCAddRate                    :integer;
    nNeckLace202124DCAddValueMaxLimit           :integer;
    nNeckLace202124DCAddValueRate               :integer;
    nNeckLace202124MCAddRate                    :integer;
    nNeckLace202124MCAddValueMaxLimit           :integer;
    nNeckLace202124MCAddValueRate               :integer;
    nNeckLace202124SCAddRate                    :integer;
    nNeckLace202124SCAddValueMaxLimit           :integer;
    nNeckLace202124SCAddValueRate               :integer;
    nNeckLace19DCAddRate                    :integer;
    nNeckLace19DCAddValueMaxLimit           :integer;
    nNeckLace19DCAddValueRate               :integer;
    nNeckLace19MCAddRate                    :integer;
    nNeckLace19MCAddValueMaxLimit           :integer;
    nNeckLace19MCAddValueRate               :integer;
    nNeckLace19SCAddRate                    :integer;
    nNeckLace19SCAddValueMaxLimit           :integer;
    nNeckLace19SCAddValueRate               :integer;
    nArmRing26DCAddRate                    :integer;
    nArmRing26DCAddValueMaxLimit           :integer;
    nArmRing26DCAddValueRate               :integer;
    nArmRing26MCAddRate                    :integer;
    nArmRing26MCAddValueMaxLimit           :integer;
    nArmRing26MCAddValueRate               :integer;
    nArmRing26SCAddRate                    :integer;
    nArmRing26SCAddValueMaxLimit           :integer;
    nArmRing26SCAddValueRate               :integer;
    nRing22DCAddRate                    :integer;
    nRing22DCAddValueMaxLimit           :integer;
    nRing22DCAddValueRate               :integer;
    nRing22MCAddRate                    :integer;
    nRing22MCAddValueMaxLimit           :integer;
    nRing22MCAddValueRate               :integer;
    nRing22SCAddRate                    :integer;
    nRing22SCAddValueMaxLimit           :integer;
    nRing22SCAddValueRate               :integer;
    nRing23DCAddRate                    :integer;
    nRing23DCAddValueMaxLimit           :integer;
    nRing23DCAddValueRate               :integer;
    nRing23MCAddRate                    :integer;
    nRing23MCAddValueMaxLimit           :integer;
    nRing23MCAddValueRate               :integer;
    nRing23SCAddRate                    :integer;
    nRing23SCAddValueMaxLimit           :integer;
    nRing23SCAddValueRate               :integer;
    nHelMetDCAddRate                    :integer;
    nHelMetDCAddValueMaxLimit           :integer;
    nHelMetDCAddValueRate               :integer;
    nHelMetMCAddRate                    :integer;
    nHelMetMCAddValueMaxLimit           :integer;
    nHelMetMCAddValueRate               :integer;
    nHelMetSCAddRate                    :integer;
    nHelMetSCAddValueMaxLimit           :integer;
    nHelMetSCAddValueRate               :integer;
    nUnknowHelMetACAddRate              :integer;
    nUnknowHelMetACAddValueMaxLimit     :integer;
    nUnknowHelMetMACAddRate             :integer;
    nUnknowHelMetMACAddValueMaxLimit    :integer;
    nUnknowHelMetDCAddRate              :integer;
    nUnknowHelMetDCAddValueMaxLimit     :integer;
    nUnknowHelMetMCAddRate              :integer;
    nUnknowHelMetMCAddValueMaxLimit     :integer;
    nUnknowHelMetSCAddRate              :integer;
    nUnknowHelMetSCAddValueMaxLimit     :integer;
    nUnknowRingACAddRate                :integer;
    nUnknowRingACAddValueMaxLimit       :integer;
    nUnknowRingMACAddRate               :integer;
    nUnknowRingMACAddValueMaxLimit      :integer;
    nUnknowRingDCAddRate                :integer;
    nUnknowRingDCAddValueMaxLimit       :integer;
    nUnknowRingMCAddRate                :integer;
    nUnknowRingMCAddValueMaxLimit       :integer;
    nUnknowRingSCAddRate                :integer;
    nUnknowRingSCAddValueMaxLimit       :integer;
    nUnknowNecklaceACAddRate            :integer;
    nUnknowNecklaceACAddValueMaxLimit   :integer;
    nUnknowNecklaceMACAddRate           :integer;
    nUnknowNecklaceMACAddValueMaxLimit  :integer;
    nUnknowNecklaceDCAddRate            :integer;
    nUnknowNecklaceDCAddValueMaxLimit   :integer;
    nUnknowNecklaceMCAddRate            :integer;
    nUnknowNecklaceMCAddValueMaxLimit   :integer;
    nUnknowNecklaceSCAddRate            :integer;
    nUnknowNecklaceSCAddValueMaxLimit   :integer;
    nMonOneDropGoldCount                :integer;
    nMakeMineHitRate                    :integer; //挖矿命中率
    nMakeMineRate                       :integer; //挖矿率
    nStoneTypeRate                      :integer;
    nStoneTypeRateMin                   :integer;
    nGoldStoneMin                       :integer;
    nGoldStoneMax                       :integer;
    nSilverStoneMin                     :integer;
    nSilverStoneMax                     :integer;
    nSteelStoneMin                      :integer;
    nSteelStoneMax                      :integer;
    nBlackStoneMin                      :integer;
    nBlackStoneMax                      :integer;
    nStoneMinDura                       :integer;
    nStoneGeneralDuraRate               :integer;
    nStoneAddDuraRate                   :integer;
    nStoneAddDuraMax                    :integer;
    nWinLottery6Min                     :integer;
    nWinLottery6Max                     :integer;
    nWinLottery5Min                     :integer;
    nWinLottery5Max                     :integer;
    nWinLottery4Min                     :integer;
    nWinLottery4Max                     :integer;
    nWinLottery3Min                     :integer;
    nWinLottery3Max                     :integer;
    nWinLottery2Min                     :integer;
    nWinLottery2Max                     :integer;
    nWinLottery1Min                     :integer;
    nWinLottery1Max                     :integer;//16180 + 1820;
    nWinLottery1Gold                    :integer;
    nWinLottery2Gold                    :integer;
    nWinLottery3Gold                    :integer;
    nWinLottery4Gold                    :integer;
    nWinLottery5Gold                    :integer;
    nWinLottery6Gold                    :integer;
    nWinLotteryRate                     :integer;
    nWinLotteryCount                    :integer;
    nNoWinLotteryCount                  :integer;
    nWinLotteryLevel1                   :integer;
    nWinLotteryLevel2                   :integer;
    nWinLotteryLevel3                   :integer;
    nWinLotteryLevel4                   :integer;
    nWinLotteryLevel5                   :integer;
    nWinLotteryLevel6                   :integer;
    GlobalVal                           :Array[0..19] of integer;
    nItemNumber                         :integer;
    nItemNumberEx                       :integer;
    nGuildRecallTime                    :integer;
    nGroupRecallTime                    :integer;
    boControlDropItem                   :boolean;
    boInSafeDisableDrop                 :boolean;
    nCanDropGold                        :integer;
    nCanDropPrice                       :integer;
    boSendCustemMsg                     :boolean;
    boSubkMasterSendMsg                 :boolean;
    nSuperRepairPriceRate               :integer; //特修价格倍数
    nRepairItemDecDura                  :integer; //普通修理掉持久数(特持久上限减下限再除以此数为减的数值)
    boDieScatterBag                     :boolean;
    nDieScatterBagRate                  :integer;
    boDieRedScatterBagAll               :boolean;
    nDieDropUseItemRate                 :integer;
    nDieRedDropUseItemRate              :integer;
    boDieDropGold                       :boolean;
    boKillByHumanDropUseItem            :boolean;
    boKillByMonstDropUseItem            :boolean;
    boKickExpireHuman                   :boolean;
    nGuildRankNameLen                   :integer;
    nGuildMemberMaxLimit                :integer;
    nGuildNameLen                       :integer;
    nCastleNameLen                      :Integer;
    nAttackPosionRate                   :integer;
    nAttackPosionTime                   :integer;
    dwRevivalTime                       :dword; //复活间隔时间
    boUserMoveCanDupObj                 :boolean;
    boUserMoveCanOnItem                 :boolean;
    dwUserMoveTime                      :integer;
    dwPKDieLostExpRate                  :integer;
    nPKDieLostLevelRate                 :integer;
    btPKFlagNameColor                   :Byte;
    btPKLevel1NameColor                 :Byte;
    btPKLevel2NameColor                 :Byte;
    btAllyAndGuildNameColor             :Byte;
    btWarGuildNameColor                 :Byte;
    btInFreePKAreaNameColor             :Byte;
    boSpiritMutiny                      :boolean;
    dwSpiritMutinyTime                  :dword;
    nSpiritPowerRate                    :integer;
    boMasterDieMutiny                   :boolean;
    nMasterDieMutinyRate                :integer;
    nMasterDieMutinyPower               :integer;
    nMasterDieMutinySpeed               :integer;
    boBBMonAutoChangeColor              :boolean;
    dwBBMonAutoChangeColorTime          :integer;
    boOldClientShowHiLevel              :boolean;
    boShowScriptActionMsg               :boolean;
    nRunSocketDieLoopLimit              :integer;
    boThreadRun                         :boolean;
    boShowExceptionMsg                  :boolean;
    boShowPreFixMsg                     :boolean;
    nMagicAttackRage                    :integer; //魔法锁定范围
    sSkeleton                           :String[ActorNameLen];
    nSkeletonCount                      :integer;
    SkeletonArray                       :array[0..9] of TRecallMigic;
    sDragon                             :String[ActorNameLen];
    sDragon1                            :String[ActorNameLen];
    nDragonCount                        :integer;
    DragonArray                         :array[0..9] of TRecallMigic;
    sAngel                              :String[ActorNameLen];
    SClone                              :String[ActorNameLen];
    nAmyOunsulPoint                     :integer;
    boDisableInSafeZoneFireCross        :boolean;
    boGroupMbAttackPlayObject           :boolean;
    dwPosionDecHealthTime               :dword;
    nPosionDamagarmor                   :integer;//中红毒着持久及减防量（实际大小为 12 / 10）
    boLimitSwordLong                    :boolean;
    nSwordLongPowerRate                 :integer;
    nFireBoomRage                       :integer;
    nSnowWindRange                      :integer;
    nElecBlizzardRange                  :integer;
    nMagTurnUndeadLevel                 :integer; //圣言怪物等级限制
    nMagTammingLevel                    :integer; //诱惑之光怪物等级限制
    nMagTammingTargetLevel              :integer; //诱惑怪物相差等级机率，此数字越小机率越大；
    nMagTammingHPRate                   :integer; //成功机率=怪物最高HP 除以 此倍率，此倍率越大诱惑机率越高
    nMagTammingCount                    :integer;
    nMabMabeHitRandRate                 :integer;
    nMabMabeHitMinLvLimit               :integer;
    nMabMabeHitSucessRate               :integer;
    nMabMabeHitMabeTimeRate             :integer;
    sCastleName                         :String;
    sCastleHomeMap                      :String;
    nCastleHomeX                        :integer;
    nCastleHomeY                        :integer;
    nCastleWarRangeX                    :integer;
    nCastleWarRangeY                    :integer;
    nCastleTaxRate                      :integer;
    boGetAllNpcTax                      :boolean;
    nHireGuardPrice                     :integer;
    nHireArcherPrice                    :integer;
    nCastleGoldMax                      :integer;
    nCastleOneDayGold                   :integer;
    nRepairDoorPrice                    :integer;
    nRepairWallPrice                    :integer;
    nCastleMemberPriceRate              :integer;
    sGTHomeMap                          :String[20];
    nGTHomeX                            :integer;
    nGTHomeY                            :integer;
    nGTExtendFee                        :integer;
    nGTBuyFee                           :integer;
    sGTDeco                             :String;
    nMaxHitMsgCount                     :integer;
    nMaxSpellMsgCount                   :integer;
    nMaxRunMsgCount                     :integer;
    nMaxWalkMsgCount                    :integer;
    nMaxTurnMsgCount                    :integer;
    nMaxSitDonwMsgCount                 :integer;
    nMaxDigUpMsgCount                   :integer;
    boSpellSendUpdateMsg                :boolean;
    boActionSendActionMsg               :boolean;
    boKickOverSpeed                     :boolean;
    btSpeedControlMode                  :integer;
    nOverSpeedKickCount                 :integer;
    dwDropOverSpeed                     :dword;
    dwHitIntervalTime                   :dword; //攻击间隔
    dwMagicHitIntervalTime              :dword; //魔法间隔
    dwRunIntervalTime                   :dword; //跑步间隔
    dwWalkIntervalTime                  :dword; //走路间隔
    dwTurnIntervalTime                  :dword; //换方向间隔
    boControlActionInterval             :boolean;
    boControlWalkHit                    :boolean;
    boControlRunLongHit                 :boolean;
    boControlRunHit                     :boolean;
    boControlRunMagic                   :boolean;
    dwActionIntervalTime                :dword; //组合操作间隔
    dwRunLongHitIntervalTime            :dword; //跑位刺杀间隔
    dwRunHitIntervalTime                :dword; //跑位攻击间隔
    dwWalkHitIntervalTime               :dword; //走位攻击间隔
    dwRunMagicIntervalTime              :dword; //跑位魔法间隔
    boDisableStruck                     :boolean; //不显示人物弯腰动作
    boDisableSelfStruck                 :boolean; //自己不显示人物弯腰动作
    dwStruckTime                        :dword; //人物弯腰停留时间
    dwKillMonExpMultiple                :dword; //杀怪经验倍数
    dwRequestVersion                    :dword;
    boHighLevelKillMonFixExp            :boolean;
    boHighLevelGroupFixExp              :Boolean;
    boAddUserItemNewValue               :boolean;
    sLineNoticePreFix                   :String;
    sSysMsgPreFix                       :String;
    sGuildMsgPreFix                     :String;
    sGroupMsgPreFix                     :String;
    sHintMsgPreFix                      :String;
    sGMRedMsgpreFix                     :String;
    sMonSayMsgpreFix                    :String;
    sCustMsgpreFix                      :String;
    sCastleMsgpreFix                    :String;
    sGuildNotice                        :String;
    sGuildWar                           :String;
    sGuildAll                           :String;
    sGuildMember                        :String;
    sGuildMemberRank                    :String;
    sGuildChief                         :String;
    boKickAllUser                       :boolean;
    boTestSpeedMode                     :boolean;
    ClientConf                          :TClientConf;
    nWeaponMakeUnLuckRate               :integer;
    nWeaponMakeLuckPoint1               :integer;
    nWeaponMakeLuckPoint2               :integer;
    nWeaponMakeLuckPoint3               :integer;
    nWeaponMakeLuckPoint2Rate           :integer;
    nWeaponMakeLuckPoint3Rate           :integer;
    boCheckUserItemPlace                :boolean;
    nClientKey                          :integer;
    nLevelValueOfTaosHP                 :integer;
    nLevelValueOfTaosHPRate             :double;
    nLevelValueOfTaosMP                 :integer;
    nLevelValueOfWizardHP               :integer;
    nLevelValueOfWizardHPRate           :double;
    nLevelValueOfWarrHP                 :integer;
    nLevelValueOfWarrHPRate             :double;
    nProcessMonsterInterval             :integer;

    boIDSocketConnected                 :Boolean;
    UserIDSection                       :TRTLCriticalSection;
    sIDSocketRecvText                   :String;
    IDSocket                            :integer;
    nIDSocketRecvIncLen                 :integer;
    nIDSocketRecvMaxLen                 :integer;
    nIDSocketRecvCount                  :integer;
    nIDReceiveMaxTime                   :integer;
    nIDSocketWSAErrCode                 :integer;
    nIDSocketErrorCount                 :integer;
    nLoadDBCount                        :integer;
    nLoadDBErrorCount                   :integer;
    nSaveDBCount                        :integer;
    nDBQueryID                          :integer;
    UserEngineThread                    :TThreadInfo;
    IDSocketThread                      :TThreadInfo;
    DBSocketThread                      :TThreadInfo;
    boDBSocketConnected                 :boolean;
    nDBSocketRecvIncLen                 :integer;
    nDBSocketRecvMaxLen                 :integer;
    sDBSocketRecvText                   :String;
    boDBSocketWorking                   :boolean;
    nDBSocketRecvCount                  :integer;
    nDBReceiveMaxTime                   :integer;
    nDBSocketWSAErrCode                 :integer;
    nDBSocketErrorCount                 :integer;
    nM2Crc                              :integer;
    nClientFile1_CRC                    :integer;
    nClientFile2_CRC                    :integer;
    nClientFile3_CRC                    :integer;
    GlobaDyMval                         :TGlobaDyMval;
    nCheckLicenseFail                   :integer;
    dwCheckTick                         :LongWord;
    nCheckFail                          :Integer;
    boDropGoldToPlayBag                 :Boolean;
    boSendCurTickCount                  :Boolean;
    dwSendWhisperTime                   :LongWord;
    nSendWhisperPlayCount               :Integer;
    boMoveCanDupObj                     :Boolean;
    nProcessTick                        :integer;
    nProcessTime                        :integer;
    nDBSocketSendLen                    :Integer;
    sTestGAPassword                     :String;
    boUseSQL                            :boolean;
    SQLHost                             :string;
    SQLPort                             :integer;
    SQLUsername                         :string;
    SQLPassword                         :string;
    SQLDatabase                         :string;
    SQLType                             :string;
    PosFile                             :string;
  end;


  TGameCommand=record
    DATA,
    PRVMSG,
    ALLOWMSG,
    LETSHOUT,
    LETTRADE,
    LETGUILD,
    ENDGUILD,
    BANGUILDCHAT,
    AUTHALLY,
    ALLIANCE,
    CANCELALLIANCE,
    DIARY,
    USERMOVE,
    SEARCHING,
    ALLOWGROUPCALL,
    GROUPRECALLL,
    ALLOWGUILDRECALL,
    GUILDRECALLL,
    UNLOCKSTORAGE,
    UNLOCK,
    LOCK,
    PASSWORDLOCK,
    SETPASSWORD,
    CHGPASSWORD,
    CLRPASSWORD,
    UNPASSWORD,
    MEMBERFUNCTION,
    MEMBERFUNCTIONEX,
    DEAR,
    ALLOWDEARRCALL,
    DEARRECALL,
    MASTER,
    ALLOWMASTERRECALL,
    MASTERECALL,
    ATTACKMODE,
    REST,
    TAKEONHORSE,
    TAKEOFHORSE,
    HUMANLOCAL,
    MOVE,
    POSITIONMOVE,
    INFO,
    MOBLEVEL,
    MOBCOUNT,
    HUMANCOUNT,
    MAP,
    KICK,
    TING,
    SUPERTING,
    MAPMOVE,
    SHUTUP,
    RELEASESHUTUP,
    SHUTUPLIST,
    SVNINFO,
    GAMEMASTER,
    OBSERVER ,
    SUEPRMAN,
    LEVEL,
    SABUKWALLGOLD,
    RECALL,
    REGOTO,
    SHOWFLAG,
    SHOWOPEN,
    SHOWUNIT,
    ATTACK,
    MOB,
    MOBNPC,
    DELNPC,
    NPCSCRIPT,
    RECALLMOB,
    LUCKYPOINT,
    LOTTERYTICKET,
    RELOADGUILD,
    RELOADLINENOTICE,
    RELOADABUSE,
    BACKSTEP,
    BALL,
    FREEPENALTY,
    PKPOINT,
    INCPKPOINT,
    CHANGELUCK,
    HUNGER,
    HAIR,
    TRAINING,
    DELETESKILL,
    CHANGEJOB,
    CHANGEGENDER,
    NAMECOLOR,
    MISSION,
    MOBPLACE,
    TRANSPARECY,
    DELETEITEM,
    LEVEL0,
    CLEARMISSION,
    SETFLAG,
    SETOPEN,
    SETUNIT,
    RECONNECTION,
    DISABLEFILTER,
    CHGUSERFULL,
    CHGZENFASTSTEP,
    CONTESTPOINT,
    STARTCONTEST,
    ENDCONTEST,
    ANNOUNCEMENT,
    OXQUIZROOM,
    GSA,
    CHANGEITEMNAME,
    DISABLESENDMSG,
    ENABLESENDMSG,
    DISABLESENDMSGLIST,
    KILL,
    MAKE,
    SMAKE,
    BONUSPOINT,
    DELBONUSPOINT,
    RESTBONUSPOINT,
    FIREBURN,
    TESTFIRE,
    TESTSTATUS,
    DELGOLD,
    ADDGOLD,
    DELGAMEGOLD,
    ADDGAMEGOLD,
    GAMEGOLD,
    GAMEPOINT,
    CREDITPOINT,
    TESTGOLDCHANGE,
    REFINEWEAPON,
    RELOADADMIN,
    RELOADNPC,
    RELOADMANAGE,
    RELOADROBOTMANAGE,
    RELOADROBOT,
    RELOADMONITEMS,
    RELOADDIARY,
    RELOADITEMDB,
    RELOADMAGICDB,
    RELOADMONSTERDB,
    RELOADMINMAP,
    RELOADBIGMAP,
    REALIVE,
    ADJUESTLEVEL,
    ADJUESTEXP,
    ADDGUILD,
    DELGUILD,
    CHANGESABUKLORD,
    FORCEDWALLCONQUESTWAR,
    ADDTOITEMEVENT,
    ADDTOITEMEVENTASPIECES,
    ITEMEVENTLIST,
    STARTINGGIFTNO,
    DELETEALLITEMEVENT,
    STARTITEMEVENT,
    ITEMEVENTTERM,
    ADJUESTTESTLEVEL,
    TRAININGSKILL,
    OPDELETESKILL,
    CHANGEWEAPONDURA,
    RELOADGUILDALL,
    WHO,
    TOTAL,
    TESTGA,
    MAPINFO,
    SBKDOOR,
    CHANGEDEARNAME,
    CHANGEMASTERNAME,
    STARTQUEST,
    SETPERMISSION,
    CLEARMON,
    RENEWLEVEL,
    DENYIPLOGON,
    DENYACCOUNTLOGON,
    DENYCHARNAMELOGON,
    DELDENYIPLOGON,
    DELDENYACCOUNTLOGON,
    DELDENYCHARNAMELOGON,
    SHOWDENYIPLOGON,
    SHOWDENYACCOUNTLOGON,
    SHOWDENYCHARNAMELOGON,
    VIEWWHISPER,
    SPIRIT,
    SPIRITSTOP,
    SETMAPMODE,
    SHOWMAPMODE,
    TESTSERVERCONFIG,
    SERVERSTATUS ,
    TESTGETBAGITEM,
    CLEARBAG,
    SHOWUSEITEMINFO,
    BINDUSEITEM,
    MOBFIREBURN,
    TESTSPEEDMODE,
    LOCKLOGON,
    TRADEGT    :TGameCmd;
  end;

  TIPLocal=procedure (sIPaddr:Pchar;sLocal:Pchar;len:integer);

  pTAdminInfo=^TAdminInfo;
  TAdminInfo=record
    nLv:integer;
    sChrName:String[20];
    sIPaddr:String[15];
  end;

  pTMonDrop=^TMonDrop;
  TMonDrop=record
    sItemName:String;
    nDropCount:integer;
    nNoDropCount:integer;
    nCountLimit:integer;
  end;

  TMonStatus=(s_KillHuman,s_UnderFire,s_Die,s_MonGen);

  pTMonSayMsg=^TMonSayMsg;
  TMonSayMsg=record
    State:TMonStatus;
    Color:TMsgColor;
    nRate:integer;
    sSayMsg:String;
  end;

  

  TVarType=(vNone,VInteger,VString);
  pTDynamicVar=^TDynamicVar;
  TDynamicVar=record
     sName:String;
     VarType:TVarType;
     nInternet:Integer;
     sString:String;
  end;

  pTItemName=^TItemName;
  TItemName=record
    nMakeIndex:integer;
    nItemIndex:integer;
    sItemName:String;
  end;

  TLoadHuman=record
    sAccount:String[16];
    sChrName:String[20];
    sUserAddr:String[15];
    nSessionID:integer;
  end;

  pTSrvNetInfo=^TSrvNetInfo;
  TSrvNetInfo=record
    sIPaddr  :String;
    nPort    :Integer;
  end;

  pTUserOpenInfo=^TUserOpenInfo;
  TUserOpenInfo=record
     sChrName:String[20];
     LoadUser:TLoadDBInfo;
     HumanRcd:THumData;
  end;

  pTGateObj=^TGateObj;
  TGateObj=record
     DEnvir:TObject;
     nDMapX,
     nDMapY:integer;
     boFlag:Boolean;
  end;

  pTMapQuestInfo=^TMapQuestInfo;
  TMapQuestInfo=record
     nFlag:integer;
     nValue:integer;
     sMonName:string;
     sItemName:String;
     boGrouped:boolean;
     NPC:TObject;
  end;

  TRegInfo = record
    sKey:String;
    sServerName:String;
    sRegSrvIP:String[15];
    nRegPort:Integer;
  end;


  pTPowerBlock = ^TPowerBlock;
  TPowerBlock = array[0..100-1] of Word;

  function MakeDefaultMsg (msg:smallint; Recog:integer; param, tag, series:word):TDefaultMessage;
  function APPRfeature(cfeature:integer):Word;
  function RACEfeature(cfeature:integer):Byte;
  function HAIRfeature(cfeature:integer):Byte;
  function HELMETfeature(cfeature:integer):Byte;
  function DRESSfeature(cfeature:integer):Byte;
  function WEAPONfeature(cfeature:integer):Byte;
  function Horsefeature(cfeature:integer):Byte;
  function Effectfeature(cfeature:integer):Byte;
  function MakeHumanFeature(btRaceImg,btDress,btWeapon,btHair:Byte):Integer;
  function MakeMonsterFeature(btRaceImg,btWeapon:Byte;wAppr:Word):Integer;
  function StringToMailItem(Msg: String): pTMailItem;
  function MailItemToString(Item: pTMailItem): String;
  function Split(Deliminator: Char; Target: String): TStringList;
  function Join(Glue: String; Target: TStringList): String; overload;
  function Join(Glue: String; Target: TStringList; Start,Finish: Integer): String; overload;
  function BoolToByte(boBool: Boolean): Byte;

implementation

function BoolToByte(boBool: Boolean): Byte;
begin
  if boBool then Result := 1
  else Result := 0;
end;

function Split(Deliminator: Char; Target: String): TStringList;
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
    end
    else t := t + Copy(Target,i,1);
  end;
  if t <> '' then Result.Add(t);
end;

function Join(Glue: String; Target: TStringList): String;
var
  i: Integer;
begin
  Result := '';

  if Target.Count = 0 then Exit;

  for i := 0 to Target.Count-1 do begin
    if Result <> '' then Result := Result + Glue;
    Result := Result + Target[i];
  end;

end;

function Join(Glue: String; Target: TStringList; Start,Finish: Integer): String;
var
  i: Integer;
begin
  Result := '';

  if Target.Count = 0 then Exit;

  if Start > Target.Count - 1 then Start := Target.Count - 1;
  if Finish > Target.Count - 1 then Finish := Target.Count - 1;
  if Finish = -1 then Finish := Target.Count - 1;
  if Start > Finish then begin
    i := Finish;
    Finish := Start;
    Start := i;
  end;

  for i := Start to Finish do begin
    if Result <> '' then Result := Result + Glue;
    Result := Result + Target[i];
  end;
end;

function MailItemToString(Item: pTMailItem): String;
begin
  Result := '';
  Result := Result+#1+inttostr(Item.Id);
  Result := Result+#1+Item.Sender;
  Result := Result+#1+Item.Recipient;
  Result := Result+#1+Item.Content;
  if Item.Read then Result := Result+#1+'1' else Result := Result+#1+'0';
  Result := Result+#1+inttostr(Item.Status);
  Result := Result+#1+IntToStr(Item.Time);
  Result := Result+#1;
end;

function StringToMailItem(Msg: String): pTMailItem;
var
  sTemp: String;
  P,I: Integer;
begin
  new(Result);
  // This will almost certainly be recoded in the future
  sTemp := '';
  P := 0;
  for I := 1 to Length(Msg) do begin
    if Msg[I] <> #1 then sTemp := sTemp+Msg[I]
    else begin
      Case P of
        1: begin
          Result.Id := strtoint(sTemp);
        end;
        2: begin
          Result.Sender := sTemp;
        end;
        3:  begin   
          Result.Recipient := sTemp;
        end;
        4:  begin
          Result.Content := sTemp;
        end;
        5: begin
          if sTemp = '1' then Result.Read := True
          else Result.Read := False;
        end;
        6:  begin
          Result.Status := strtoint(sTemp);
        end;
        7:  begin
          Result.Time := strtoint(sTemp);
        end;
      end; // Case
      inc(P);
      sTemp := '';
    end;
  end;
end;

function  MakeDefaultMsg (msg:smallint; Recog:integer; param, tag, series:word):TDefaultMessage;
begin
    result.Ident:=Msg;
    result.Param:=Param;
    result.Tag:=Tag;
    result.Series:=Series;
    result.Recog:=Recog;
end;

function WEAPONfeature(cfeature:integer):Byte;
begin
  Result:=HiByte(cfeature);
end;
function DRESSfeature(cfeature:integer):Byte;
begin
  Result:= HiByte(HiWord(cfeature));
end;
function APPRfeature(cfeature:integer):Word;
begin
  Result:=HiWord(cfeature);
end;
function HAIRfeature(cfeature:integer):Byte;
begin
  Result:=HiWord(cfeature);
end;
function HELMETfeature(cfeature:integer):Byte;
begin
  Result:=HiWord(cfeature);
end;

function RACEfeature(cfeature:integer):Byte;
begin
  Result:=cfeature;
end;

function Horsefeature(cfeature:integer):Byte;
begin
  Result:=LoByte(LoWord(cfeature));
end;
function Effectfeature(cfeature:integer):Byte;
begin
  Result:=HiByte(LoWord(cfeature));
end;

function MakeHumanFeature(btRaceImg,btDress,btWeapon,btHair:Byte):Integer;
begin
  Result:=MakeLong(MakeWord(btRaceImg,btWeapon),MakeWord(btHair,btDress));
end;

function MakeMonsterFeature(btRaceImg,btWeapon:Byte;wAppr:Word):Integer;
begin
  Result:=MakeLong(MakeWord(btRaceImg,btWeapon),wAppr);
end;

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: Grobal2.pas 596 2007-04-11 00:14:13Z sean $');
end.

