unit Share;

interface

uses svn;

const
  RUNLOGINCODE       = 0; //进入游戏状态码,默认为0 测试为 9

  STDCLIENT          = 0;
  RMCLIENT           = 99;
  CLIENTTYPE         = RMCLIENT; //普通的为0 ,99 为管理客户端

  RMCLIENTTITLE      = 'rXyNKR^xVArFr_dx^`PS>xSRCsX';

  DEBUG         = 0;
  SWH800        = 0;
  SWH1024       = 1;
  SWH           = SWH800;

  CUSTOMLIBFILE = 0; //自定义图库位置

{$IF SWH = SWH800}
   SCREENWIDTH = 800;
   SCREENHEIGHT = 600;
{$ELSEIF SWH = SWH1024}
   SCREENWIDTH = 1024;
   SCREENHEIGHT = 768;
{$IFEND}

   MAPSURFACEWIDTH = SCREENWIDTH;
   MAPSURFACEHEIGHT = SCREENHEIGHT- 50;

   WINLEFT = 42;
   WINTOP  = 42;
   WINRIGHT = SCREENWIDTH-42;
   BOTTOMEDGE = SCREENHEIGHT-5;  // Bottom WINBOTTOM

   MAPDIR             = 'Map\'; //地图文件所在目录
   CONFIGFILE         = 'Config\%s.ini';
{$IF CUSTOMLIBFILE = 1}
   EFFECTIMAGEDIR     = 'Graphics\Effect\';
   MAINIMAGEFILE      = 'Graphics\FrmMain\Main.wil';
   MAINIMAGEFILE2     = 'Graphics\FrmMain\Main2.wil';
   MAINIMAGEFILE3     = 'Graphics\FrmMain\Main3.wil';
{$ELSE}
   MAINIMAGEFILE      = 'Data\Prguse.wil';
   MAINIMAGEFILE2     = 'Data\Prguse2.wil';
   MAINIMAGEFILE3     = 'Data\Prguse3.wil';
   EFFECTIMAGEDIR     = 'Data\';
{$IFEND}

   CHRSELIMAGEFILE    = 'Data\ChrSel.wil';
   MINMAPIMAGEFILE    = 'Data\mmap.wil';
   TITLESIMAGEFILE    = 'Data\Tiles.wil';
   SMLTITLESIMAGEFILE = 'Data\SmTiles.wil';
   HUMWINGIMAGESFILE  = 'Data\HumEffect.wil';
   MAGICONIMAGESFILE  = 'Data\MagIcon.wil';
   HUMIMGIMAGESFILE   = 'Data\Hum.wil';
   HUM2IMGIMAGESFILE  = 'Data\Hum2.wil';
   HAIRIMGIMAGESFILE  = 'Data\Hair.wil';
   HORSEIMAGEFILE     = 'Data\Horse.wil';
   HELMETIMAGEFILE    = 'Data\Helmet.wil';
   TRANSFORMIMAGEFILE = 'Data\TransForm.wil';
   WEAPONIMAGESFILE   = 'Data\Weapon.wil';
   NPCIMAGESFILE      = 'Data\Npc.wil';
   MAGICIMAGESFILE    = 'Data\Magic.wil';
   MAGIC2IMAGESFILE   = 'Data\Magic2.wil';
   MAGIC3IMAGESFILE   = 'Data\magic3.wil';
   MAGIC4IMAGESFILE   = 'Data\magic4.wil';
   EVENTEFFECTIMAGESFILE = EFFECTIMAGEDIR + 'Event.wil';
   BAGITEMIMAGESFILE   = 'Data\Items.wil';
   STATEITEMIMAGESFILE = 'Data\StateItem.wil';
   DNITEMIMAGESFILE    = 'Data\DnItems.wil';
   OBJECTIMAGEFILE     = 'Data\Objects.wil';
   OBJECTIMAGEFILE1    = 'Data\Objects%d.wil';
   MONIMAGEFILE        = 'Data\Mon%d.wil';
   DRAGONIMAGEFILE     = 'Data\Dragon.wil';
   DECOIMAGEFILE       = 'Data\Deco.wil';
   EFFECTIMAGEFILE     = 'Data\Effect.wil';

   MONIMAGEFILEEX      = 'Graphics\Monster\%d.wil';
   MONPMFILE           = 'Graphics\Monster\%d.pm';
   
  MAXX = SCREENWIDTH div 20;
  MAXY = SCREENWIDTH div 20;

  DEFAULTCURSOR = 0; //系统默认光标
  IMAGECURSOR   = 1; //图形光标

  USECURSOR     = DEFAULTCURSOR; //使用什么类型的光标

  MAXBAGITEMCL = 52;
  MAXSTORAGEITEMCL = 80;
  MAXFONT = 8;
  ENEMYCOLOR = 69;

  HAM_ALL      = 0;
  HAM_PEACE    = 1;
  HAM_DEAR     = 2;
  HAM_MASTER   = 3;
  HAM_GROUP    = 4;
  HAM_GUILD    = 5;
  HAM_PKATTACK = 6;
implementation

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: Share.pas 502 2006-11-02 08:10:23Z sean $');
end.
