unit ObjMon3;

interface

uses
  svn, Windows,Classes,Grobal2, StrUtils,ObjBase,ObjMon,ObjMon2;

type

  TRonObject=class(TMonster)
  public
    constructor Create();override;
    destructor Destroy; override;
	  procedure AroundAttack;
	  procedure Run; override;
  end;

  TMinorNumaObject=class(TATMonster)
  public
    constructor Create();override;
    destructor Destroy; override;
	  procedure Run; override;
  end;

  TSandMobObject=class(TStickMonster)
  private
	  m_dwAppearStart:LongWord;

  public
	  constructor Create();override;
    destructor Destroy; override;
	  procedure Run; override;
  end;

  TRockManObject=class(TATMonster)
  public
	  constructor Create();override;
    destructor Destroy; override;
	  procedure Run; override;
  end;

  TMagicMonObject = class(TMonster)
  private
    m_boUseMagic:Boolean;

    procedure LightingAttack(nDir:Integer);

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;

  TBoneKingMonster = class(TMonster)
  private
    m_nDangerLevel       :Integer;
    m_SlaveObjectList  :TList;//0x55C

    procedure MagicAttack(nDir:integer);
    procedure CallSlave;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer);override; //0FFED
    procedure Run;override;
  end;




  TPercentMonster = class(TAnimalObject)
    n54C           :Integer;
    m_dwThinkTick  :LongWord;
    bo554          :Boolean;
    m_boDupMode    :Boolean;
  private
    function Think: Boolean;
//    function MakeClone(sMonName:String;OldMon:TBaseObject):TBaseObject;
  public
    constructor Create();override;
    destructor Destroy; override;
    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;
    function AttackTarget():Boolean; virtual;
    procedure Run; override;
  end;

  TMagicMonster = class(TAnimalObject)
    n54C           :Integer;
    m_dwThinkTick  :LongWord;
    m_dwSpellTick  :LongWord;
    bo554          :Boolean;
    m_boDupMode    :Boolean;
  private
    function Think: Boolean;
//    function MakeClone(sMonName:String;OldMon:TBaseObject):TBaseObject;
  public
    constructor Create();override;
    destructor Destroy; override;
    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;
    function AttackTarget():Boolean; virtual;
    procedure Run; override;
  end;

  TFireballMonster = class(TMagicMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TFireMonster = class(TMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

 TFrostTiger = class(TMonster)
    m_dwSpellTick:LongWord;
    m_dwLastWalkTick:LongWord;
  private
    procedure FrostAttack();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

 TGreenMonster = class(TMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TRedMonster = class(TMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TKhazard = class(TMonster)
    m_dwDragTick  :LongWord;
  private
    procedure Drag();
  public
  function AttackTarget():boolean;override;
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TRunAway = class(TMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TTeleMonster = class(TMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TDefendMonster = class(TMonster)
  private
   // m_GuardObjects  :TList;

    //procedure CallGuard(mapmap:string; xx,yy:integer);
  public
    callguardrun:boolean;
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TClone = class(TMonster)
    m_dwThinkTick : LongWord;
    m_dwMpLossTick    : LongWord;
    nMpLoss       : Integer;
  private
    function MPow(UserMagic:pTUserMagic):Integer;
    function GetPower(nPower:Integer;UserMagic:pTUserMagic):Integer;
    procedure MagicAttack();
    procedure FindTarget();
  public
    procedure SetMpLoss(nMpReduction:Integer);
    procedure StruckDamage(nDamage:integer);override;
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
    procedure Die;override;
    function GetShowName: String;override;
  end;

  TMinotaurKing = class(TMonster)
  private
    MassAttackMode:Boolean;
    MassAttackCount:Byte;
    NextTarget:TBaseObject;
    nextx,nexty:Integer;
    boMoving:Boolean;
    procedure RedCircle(nDir:Integer);
  public
    constructor Create();override;
    function  Operate(ProcessMsg:pTProcessMessage):boolean; override;
    destructor Destroy; override;
    procedure Run;override;
  end;

  TMinoGuard = class(TMonster)
  private
   procedure MagicAttack(nDir:Integer);
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

   TNodeMonster = class(TAnimalObject)
    hitcount : integer;
    private
      procedure search();
      procedure castshield(BaseObject: TBaseObject);
    public
      constructor Create();override;
      destructor Destroy; override;
      procedure Run;override;
    end;

    TNewMonsterBoss = class(TAnimalObject)
  private
    ldistx:Integer;
    ldisty:Integer;
    m_dwSpellTick  :LongWord;
    function AttackTarget():boolean;
    procedure RepulseCircle();
    procedure RedCircle();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

    TOmaKing = class(TAnimalObject)
  private
    ldistx:Integer;
    ldisty:Integer;
    m_dwSpellTick  :LongWord;
    function AttackTarget():boolean;
    procedure RepulseCircle();
    procedure BlueCircle();
  public

    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;

  TDragonStatue = class(TAnimalObject)
  private
    procedure FireBang();
  public
    constructor Create();override;
    destructor Destroy; override;
	  procedure Run; override;
  end;

  TDragonPart = class(TAnimalObject)
    boisactive: Boolean;
    m_nHealth      :Integer;  //0x79C
  private
    procedure DropItems();
    procedure massthunder();
  public
    constructor Create();override; //0x00504AD8
    destructor Destroy; override;
    function  GetMagStruckDamage(BaseObject:TBaseObject;nDamage:Integer):Integer;override;
    procedure StruckDamage(nDamage:integer);override;
    procedure Run;override; //0x00504B60
  end;

  THolyDeva = class(TMonster)
    m_dwThinkTick : LongWord;
    m_boSpawned       : Boolean;
  private
    procedure MagicAttack();
    procedure FindTarget();
  public
  constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;

  TYimoogi = class(TMonster)
    m_boActive     : boolean; //if this is true then someone hit it and it's on the offence if not it's on the defence
    m_dwSpellTick  : LongWord;
    m_dwPoisonTick : LongWord;
    m_dwThinkTick  : LongWord;
    m_counterpart  : TBaseObject;
    m_boDied       : boolean;
  private
    procedure MagicAttack();
    procedure PoisonAttack();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;

  TYimoogiMaster = class(TYimoogi)
    m_dwLastRecall : LongWord;
    m_dwCloneSpawn : LongWord;
  private
    function FindYimoogi(sname: String):TBaseObject;
    procedure CallGuard;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
    function GetFrontPosition(var nX:Integer;var nY:Integer):Boolean;override;
    procedure CloneDied();
  end;

    TBlackFox  = class(TMonster)
  private
    m_boUseMagic:Boolean;
    procedure ThrustAttack(nDir:Integer);

  public
    constructor Create();override;
    destructor Destroy; override;
    function  MagCanHitTarget(nX, nY:Integer;TargeTBaseObject: TBaseObject): Boolean;override;
    procedure Run;override;
  end;

    TRedFox  = class(TMonster)
    m_dwSpellTick : LongWord;
    m_counterpart  : TBaseObject;
  private
    procedure MagicAttack();
  public
    constructor Create();override;
    destructor Destroy; override;
    function AttackTarget():Boolean;virtual;
    procedure Run;override;
  end;
    TWhiteFox = class(TMonster)
    m_dwSpellTick : LongWord;
  private
    procedure MagicAttack();
    procedure CallDragon();
  public
    constructor Create();override;
    destructor Destroy; override;
    function AttackTarget():Boolean;virtual;
    procedure Run;override;
  end;

implementation

uses
  UsrEngn, M2Share, Envir, Event, HUtil32, Castle, Guild, SysUtils;




constructor TRonObject.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TRonObject.Destroy;
begin
  inherited;
end;

procedure TRonObject.AroundAttack;
var
  xTargetList:TList;
  BaseObject:TBaseObject;
  wHitMode:Word;
  i:Integer;
begin
  wHitMode:=0;
  GetAttackDir(m_TargetCret,m_btDirection);

  xTargetList := TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,1,xTargetList);

	if (xTargetList.Count>0) then begin
    for i:=xTargetList.Count-1 downto 0 do begin
      BaseObject := TBaseObject(xTargetList.Items[i]);

      if (BaseObject<>nil) then begin
        _Attack(wHitMode,BaseObject); //CM_HIT

        xTargetList.Delete(i);
		  end;
    end;
	end;
  xTargetList.Free;

  SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
end;

procedure TRonObject.Run;
begin
  if CanMove then begin
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;

    if (m_TargetCret <> nil) and
       (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 6) and
       (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 6) and
       (GetCurrentTime - m_dwHitTick > GetHitSpeed) then begin

      m_dwHitTick:=GetCurrentTime;
      AroundAttack;
    end;
	end;

	inherited;
end;

constructor TMinorNumaObject.Create;
begin
  inherited;
end;

destructor TMinorNumaObject.Destroy;
begin
  inherited;
end;

procedure TMinorNumaObject.Run;
begin
  if CanMove then begin
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;

	inherited;
end;

constructor TSandMobObject.Create;
begin
  inherited;
  //m_boHideMode := TRUE;
  nComeOutValue := 8;
end;

destructor TSandMobObject.Destroy;
begin
  inherited;
end;

procedure TSandMobObject.Run;
begin
  if CanMove then begin
		if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
			m_dwWalkTick := GetCurrentTime;

			if (m_boFixedHideMode) then begin
				if (((m_WAbil.HP > (m_WAbil.MaxHP / 20)) and CheckComeOut())) then
					m_dwAppearStart := GetTickCount;
			end else begin
				if ((m_WAbil.HP > 0) and (m_WAbil.HP < (m_WAbil.MaxHP / 20)) and (GetTickCount - m_dwAppearStart > 3000)) then
					ComeDown
				else if (m_TargetCret<>nil) then begin
					if (abs(m_nCurrX - m_TargetCret.m_nCurrX) > 15) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) > 15) then begin
						ComeDown;
						exit;
					end;
				end;

				if GetCurrentTime - m_dwHitTick > GetHitSpeed then
				  SearchTarget();
				
				if (not m_boFixedHideMode) then begin
					if (AttackTarget) then
						inherited;
				end;
			end;
		end;
	end;

	inherited;
end;

constructor TRockManObject.Create;
begin
  inherited;
  //m_dwSearchTick := 2500 + Random(1500);
  //m_dwSearchTime := GetTickCount();

  m_boHideMode := TRUE;
end;

destructor TRockManObject.Destroy;
begin
  inherited;
end;

procedure TRockManObject.Run;
begin
  {if CanMove then begin
		if (m_fHideMode) then begin
			if (CheckComeOut(8)) then
				ComeOut;

			m_dwWalkTime := GetTickCount + 1000;
		end else begin
			if ((GetTickCount - m_dwSearchEnemyTime > 8000) or ((GetTickCount - m_dwSearchEnemyTime > 1000) and (m_pTargetObject=nil))) then begin
				m_dwSearchEnemyTime := GetTickCount;
				MonsterNormalAttack;

				if (m_pTargetObject=nil) then
					ComeDown;
			end;
		end;
	end;}

	inherited;
end;


{ TMagicMonObject }

constructor TMagicMonObject.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_boUseMagic:=False;
end;

destructor TMagicMonObject.Destroy;
begin

  inherited;
end;

procedure TMagicMonObject.LightingAttack(nDir: Integer);
begin

end;

procedure TMagicMonObject.Run;
var
  nAttackDir:Integer;
  nX,nY:Integer;
begin
  if (not bo554) and CanMove then begin

     //血量低于一半时开始用魔法攻击
    if m_WAbil.HP < m_WAbil.MaxHP div 2 then m_boUseMagic:=True
    else m_boUseMagic:=False;

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
    if m_Master = nil then exit;

    nX:=abs(m_nCurrX - m_Master.m_nCurrX);
    nY:=abs(m_nCurrY - m_Master.m_nCurrY);

    if (nX <= 5) and (nY <= 5) then begin
      if m_boUseMagic or ((nX = 5) or (nY = 5)) then begin
        if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
          m_dwHitTick:=GetCurrentTime;
          nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_Master.m_nCurrX,m_Master.m_nCurrY);
          LightingAttack(nAttackDir);
        end;
      end;
    end;
  end;
  inherited Run;
end;


{ TBoneKingMonster }

constructor TBoneKingMonster.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_nViewRange:=8;
  m_btDirection:=5;
  m_nDangerLevel:=5;
  m_SlaveObjectList:=TList.Create;
end;

destructor TBoneKingMonster.Destroy;
begin
  m_SlaveObjectList.Free;
  inherited;
end;

procedure TBoneKingMonster.MagicAttack(nDir:Integer);
var
Target:TBaseObject;
magpwr:Integer;
WAbil:pTAbility;
begin
  if m_TargetCret =  nil then exit;
  Target:=m_TargetCret;
    sendrefmsg(RM_FLYAXE,nDir,m_nCurrx,m_nCurry,Integer(Target),'');

  {hit first target}
  if IsProperTarget(Target) then begin
    if Random(50) >= Target.m_nantiMagic then begin
      WAbil:=@m_WAbil;
      magpwr:=(Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
      Target.SendDelayMsg(self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
    end;
  end;
end;

procedure TBoneKingMonster.CallSlave;
const
  sMonName:array[0..2] of String = ('BoneCaptain', 'BoneArcher', 'BoneSpearman');
var
  I: Integer;
  nC:Integer;
  n10,n14:Integer;
  BaseObject:TBaseObject;
begin
  nC:=Random(6) + 6;
  GetFrontPosition(n10,n14);

  if m_SlaveObjectList.Count <= 30 then //gotta make sure he has room for extra slaves before he raises his staff lol
    sendrefmsg(RM_LIGHTING,1,m_nCurrx,m_nCurry,integer(self),''); //make him raise his staff

  for I := 1 to nC do begin
    if m_SlaveObjectList.Count >= 30 then break;
    BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,n10,n14,sMonName[Random(3)]);
    if BaseObject <> nil then begin
      m_SlaveObjectList.Add(BaseObject);
    end;
  end;    // for
end;
procedure TBoneKingMonster.Attack(TargeTBaseObject: TBaseObject;nDir: Integer);
var
  WAbil:pTAbility;
  nPower:Integer;
begin
  WAbil:=@m_WAbil;
  nPower:=GetAttackPower(LoWord(WAbil.DC),SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject,0,nPower,True);
end;
procedure TBoneKingMonster.Run;
var
  I: Integer;
  BaseObject:TBaseObject;
  nAttackDir:Integer;
begin
  if CanMove and (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin

    if (m_TargetCret <> nil) and
        (abs(m_nCurrX - m_TargetCret.m_nCurrx) >= 2) and (abs(m_nCurry - m_TargetCret.m_nCurry) >= 2) and
        (Integer(GetTickCount - m_dwHitTick) > 2200) then begin
      if MagCanHitTarget(m_nCurrX,m_nCurrY,m_targetCret) then begin //make sure the 'line' in wich magic will go isnt blocked
        m_dwHitTick:=GetCurrentTime;
        nAttackDir:=GetNextDirection(m_nCurrx,m_nCurry,m_TargetCret.m_nCurrx,m_TargetCret.m_nCurry);
        MagicAttack(nAttackDir);
      end;
    end;


    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();

      if (m_nDangerLevel > m_WAbil.HP / m_WAbil.MaxHP * 5) and (m_nDangerLevel > 0) then begin
        Dec(m_nDangerLevel);
        CallSlave();
      end;
      if m_WAbil.HP = m_WAbil.MaxHP then
        m_nDangerLevel:=5;
    end;

    for I := m_SlaveObjectList.Count - 1 downto 0 do begin
      BaseObject:=TBaseObject(m_SlaveObjectList.Items[I]);
      if BaseObject.m_boDeath or BaseObject.m_boGhost then
        m_SlaveObjectList.Delete(I);
    end;    // for
  end;
  inherited;
end;






constructor TPercentMonster.Create;
begin
  inherited;
  m_boDupMode:=False;
  bo554:=False;
  m_dwThinkTick:=GetTickCount();
  m_nViewRange:=5;
  m_nRunTime:=250;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_btRaceServer:=80;
end;

destructor TPercentMonster.Destroy;
begin
  inherited;
end;
{
function TPercentMonster.MakeClone(sMonName: String;OldMon:TBaseObject): TBaseObject; //004A8C58
var
  ElfMon:TBaseObject;
begin
  Result:=nil;
  ElfMon:=UserEngine.RegenMonsterByName(m_PEnvir.sMapName,m_nCurrX,m_nCurrY,sMonName);
  if ElfMon <> nil then begin
    ElfMon.m_Master:=OldMon.m_Master;
    ElfMon.m_dwMasterRoyaltyTick:=OldMon.m_dwMasterRoyaltyTick;
    ElfMon.m_btSlaveMakeLevel:=OldMon.m_btSlaveMakeLevel;
    ElfMon.m_btSlaveExpLevel:=OldMon.m_btSlaveExpLevel;
    ElfMon.RecalcAbilitys;
    ElfMon.RefNameColor;
    if OldMon.m_Master <> nil then
      OldMon.m_Master.m_SlaveList.Add(ElfMon);
    ElfMon.m_WAbil:=OldMon.m_WAbil;
    ElfMon.m_wStatusTimeArr:=OldMon.m_wStatusTimeArr;
    ElfMon.m_TargetCret:=OldMon.m_TargetCret;
    ElfMon.m_dwTargetFocusTick:=OldMon.m_dwTargetFocusTick;
    ElfMon.m_LastHiter:=OldMon.m_LastHiter;
    ElfMon.m_LastHiterTick:=OldMon.m_LastHiterTick;
    ElfMon.m_btDirection:=OldMon.m_btDirection;
    Result:=ElfMon;
  end;
end;
}
function TPercentMonster.Operate(ProcessMsg: pTProcessMessage):Boolean;
begin
  Result:=inherited Operate(ProcessMsg);

end;
function TPercentMonster.Think():Boolean; //004A8E54
var
  nOldX,nOldY:integer;
begin
  Result:=False;
  if (GetTickCount - m_dwThinkTick) > 3 * 1000 then begin
    m_dwThinkTick:=GetTickCount();
    if m_PEnvir.GetXYObjCount(m_nCurrX,m_nCurrY) >= 2 then m_boDupMode:=True;
    if not IsProperTarget{FFFF4}(m_TargetCret) then m_TargetCret:=nil;
  end; //004A8ED2
  if m_boDupMode then begin
    nOldX:=m_nCurrX;
    nOldY:=m_nCurrY;
    WalkTo(Random(8),False);
    if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then begin
      m_boDupMode:=False;
      Result:=True;
    end;
  end;
end;

function TPercentMonster.AttackTarget():Boolean; //004A8F34
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret,btDir) then begin
      if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
        m_dwHitTick:=GetCurrentTime;
        m_dwTargetFocusTick:=GetTickCount();
        Attack(m_TargetCret,btDir);  //FFED
        BreakHolySeizeMode();
      end;
      Result:=True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end else begin
        DelTargetCreat();{0FFF1h}
        //004A9009
      end;
    end;
  end;
end;

procedure TPercentMonster.Run; //004A9020
var
  nX,nY:Integer;
begin
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin
    if Think then begin
      inherited;
      exit;
    end;
    if m_boWalkWaitLocked then begin
      if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
        m_boWalkWaitLocked:=False;
      end;
    end;
    if not m_boWalkWaitLocked and (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      Inc(m_nWalkCount);
      if m_nWalkCount > m_nWalkStep then begin
        m_nWalkCount:=0;
        m_boWalkWaitLocked:=True;
        m_dwWalkWaitTick:=GetTickCount();
      end; //004A9151
      if not m_boRunAwayMode then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            if AttackTarget{FFEB} then begin
              inherited;
              exit;
            end;
          end else begin
            m_nTargetX:=-1;
            if m_boMission then begin
              m_nTargetX:=m_nMissionX;
              m_nTargetY:=m_nMissionY;
            end; //004A91D3
          end;
        end; //004A91D3  if not bo2C0 then begin
        if m_Master <> nil then begin
          if m_TargetCret = nil then begin
            m_Master.GetBackPosition(nX,nY);
            if (abs(m_nTargetX - nX) > 1) or (abs(m_nTargetY - nY{nX}) > 1) then begin //004A922D
              m_nTargetX:=nX;
              m_nTargetY:=nY;
              if (abs(m_nCurrX - nX) <= 2) and (abs(m_nCurrY - nY) <= 2) then begin
                if m_PEnvir.GetMovingObject(nX,nY,True) <> nil then begin
                  m_nTargetX:=m_nCurrX;
                  m_nTargetY:=m_nCurrY;
                end //004A92A5
              end;
            end; //004A92A5
          end; //004A92A5 if m_TargetCret = nil then begin
          if (not m_Master.m_boSlaveRelax) and
             ((m_PEnvir <> m_Master.m_PEnvir) or
             (abs(m_nCurrX-m_Master.m_nCurrX) > 20) or
             (abs(m_nCurrY-m_Master.m_nCurrY) > 20)) then begin
           //  sysmsg('recalling to my master',c_red,t_hint);
          SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
          end; // 004A937E
        end;// 004A937E if m_Master <> nil then begin
      end else begin //004A9344
        if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then begin
          m_boRunAwayMode:=False;
          m_dwRunAwayTime:=0;
        end;
      end; //004A937E
      if (m_Master <> nil) and m_Master.m_boSlaveRelax then begin
        inherited ;
        exit;
      end;  //004A93A6
      if m_nTargetX <> -1 then begin
         GotoTargetXY(); //004A93B5 0FFEF
      end else begin
        if m_TargetCret = nil then Wondering();// FFEE   //Jacky
      end; //004A93D8
    end;
  end; //004A93D8

  inherited;
end;




constructor TMagicMonster.Create; //004A8B74
begin
  inherited;
  m_boDupMode:=False;
  bo554:=False;
  m_dwThinkTick:=GetTickCount();
  m_nViewRange:=8;
  m_nRunTime:=250;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_btRaceServer:=215;
end;

destructor TMagicMonster.Destroy; //004A8C24
begin
  inherited;
end;
{
function TMagicMonster.MakeClone(sMonName: String;OldMon:TBaseObject): TBaseObject; //004A8C58
var
  ElfMon:TBaseObject;
begin
  Result:=nil;
  ElfMon:=UserEngine.RegenMonsterByName(m_PEnvir.sMapName,m_nCurrX,m_nCurrY,sMonName);
  if ElfMon <> nil then begin
    ElfMon.m_Master:=OldMon.m_Master;
    ElfMon.m_dwMasterRoyaltyTick:=OldMon.m_dwMasterRoyaltyTick;
    ElfMon.m_btSlaveMakeLevel:=OldMon.m_btSlaveMakeLevel;
    ElfMon.m_btSlaveExpLevel:=OldMon.m_btSlaveExpLevel;
    ElfMon.RecalcAbilitys;
    ElfMon.RefNameColor;
    if OldMon.m_Master <> nil then
      OldMon.m_Master.m_SlaveList.Add(ElfMon);
    ElfMon.m_WAbil:=OldMon.m_WAbil;
    ElfMon.m_wStatusTimeArr:=OldMon.m_wStatusTimeArr;
    ElfMon.m_TargetCret:=OldMon.m_TargetCret;
    ElfMon.m_dwTargetFocusTick:=OldMon.m_dwTargetFocusTick;
    ElfMon.m_LastHiter:=OldMon.m_LastHiter;
    ElfMon.m_LastHiterTick:=OldMon.m_LastHiterTick;
    ElfMon.m_btDirection:=OldMon.m_btDirection;
    Result:=ElfMon;
  end;
end;
}
function TMagicMonster.Operate(ProcessMsg: pTProcessMessage):Boolean;
begin
  Result:=inherited Operate(ProcessMsg);

end;
function TMagicMonster.Think():Boolean; //004A8E54
var
  nOldX,nOldY:integer;
begin
  Result:=False;
  if (GetTickCount - m_dwThinkTick) > 3 * 1000 then begin
    m_dwThinkTick:=GetTickCount();
    if m_PEnvir.GetXYObjCount(m_nCurrX,m_nCurrY) >= 2 then m_boDupMode:=True;
    if not IsProperTarget{FFFF4}(m_TargetCret) then m_TargetCret:=nil;
  end; //004A8ED2
  if m_boDupMode then begin
    nOldX:=m_nCurrX;
    nOldY:=m_nCurrY;
    WalkTo(Random(8),False);
    if (nOldX <> m_nCurrX) or (nOldY <> m_nCurrY) then begin
      m_boDupMode:=False;
      Result:=True;
    end;
  end;
end;

function TMagicMonster.AttackTarget():Boolean; //004A8F34
var
  bt06:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
 if m_TargetCret = m_Master then begin //nicky
    m_TargetCret := nil;
 end else begin
    if GetAttackDir(m_TargetCret,bt06) then begin
      if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
        m_dwHitTick:=GetCurrentTime;
        m_dwTargetFocusTick:=GetTickCount();
  // Attack(m_TargetCret,bt06);  //FFED
      end;
      Result:=True;
    end else begin
      if m_TargetCret.m_PEnvir = m_PEnvir then begin
        SetTargetXY(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY); {0FFF0h}
        //004A8FE3
      end else begin
        DelTargetCreat();{0FFF1h}
        //004A9009
      end;
    end;
  end;
  end;
end;
procedure TMagicMonster.Run; //004A9020
var
  nX,nY:Integer;
begin
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin
    if Think then begin
      inherited;
      exit;
    end;
    if m_boWalkWaitLocked then begin
      if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
        m_boWalkWaitLocked:=False;
      end;
    end;
    if not m_boWalkWaitLocked and (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      Inc(m_nWalkCount);
      if m_nWalkCount > m_nWalkStep then begin
        m_nWalkCount:=0;
        m_boWalkWaitLocked:=True;
        m_dwWalkWaitTick:=GetTickCount();
      end; //004A9151
      if not m_boRunAwayMode then begin
        if not m_boNoAttackMode then begin
          if m_TargetCret <> nil then begin
            if AttackTarget{FFEB} then begin
              inherited;
              exit;
            end;
          end else begin
            m_nTargetX:=-1;
            if m_boMission then begin
              m_nTargetX:=m_nMissionX;
              m_nTargetY:=m_nMissionY;
            end; //004A91D3
          end;
        end; //004A91D3  if not bo2C0 then begin
        if m_Master <> nil then begin
          if m_TargetCret = nil then begin
            m_Master.GetBackPosition(nX,nY);
            if (abs(m_nTargetX - nX) > 1) or (abs(m_nTargetY - nY{nX}) > 1) then begin //004A922D
              m_nTargetX:=nX;
              m_nTargetY:=nY;
              if (abs(m_nCurrX - nX) <= 2) and (abs(m_nCurrY - nY) <= 2) then begin
                if m_PEnvir.GetMovingObject(nX,nY,True) <> nil then begin
                  m_nTargetX:=m_nCurrX;
                  m_nTargetY:=m_nCurrY;
                end //004A92A5
              end;
            end; //004A92A5
          end; //004A92A5 if m_TargetCret = nil then begin
          if (not m_Master.m_boSlaveRelax) and
             ((m_PEnvir <> m_Master.m_PEnvir) or
             (abs(m_nCurrX-m_Master.m_nCurrX) > 20) or
             (abs(m_nCurrY-m_Master.m_nCurrY) > 20)) then begin
           //  sysmsg('recalling to my master',c_red,t_hint);
          SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
          end; // 004A937E
        end;// 004A937E if m_Master <> nil then begin
      end else begin //004A9344
        if (m_dwRunAwayTime > 0) and ((GetTickCount - m_dwRunAwayStart) > m_dwRunAwayTime) then begin
          m_boRunAwayMode:=False;
          m_dwRunAwayTime:=0;
        end;
      end; //004A937E
      if (m_Master <> nil) and m_Master.m_boSlaveRelax then begin
        inherited ;
        exit;
      end;  //004A93A6
      if m_nTargetX <> -1 then begin
         GotoTargetXY(); //004A93B5 0FFEF
      end else begin
        if m_TargetCret = nil then Wondering();// FFEE   //Jacky
      end; //004A93D8
    end;
  end; //004A93D8

  inherited;

end;
{ end }


{TFireballMonster}

constructor TFireballMonster.Create; //004A9690
begin
  inherited;
  m_dwSpellTick:=GetTickCount();
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TFireballMonster.Destroy;
begin
  inherited;
end;

procedure TFireballMonster.Run;//004A9720
var
baseobject:TBaseObject;
nPower:integer;
  //UserMagic: pTUserMagic;
begin
  if not bo554 and CanMove then begin
if m_targetcret <> nil then begin
if self.MagCanHitTarget(m_targetcret.m_nCurrX, m_targetcret.m_nCurrY, m_targetcret) then begin
if self.IsProperTarget (m_targetcret) then begin
  if (abs(m_nTargetX-m_nCurrX) <= 8) and (abs(m_nTargety-m_nCurry) <= 8) then begin
       nPower:=Random(SmallInt(HiWord(m_wabil.MC) - LoWord(m_WAbil.MC)) + 1) + LoWord(m_WAbil.MC);
if nPower > 0 then begin
    BaseObject:=GetPoseCreate();
if (BaseObject <> nil) and
       IsProperTarget(BaseObject) and
       (m_nAntiMagic >= 0) then begin
      nPower:=BaseObject.GetMagStruckDamage(Self,nPower);
if nPower > 0 then begin
        BaseObject.StruckDamage(nPower);
if Integer((GetTickCount - m_dwSpellTick)) > self.m_nNextHitTime  then begin
        m_dwSpellTick:=GetTickCount();
          self.SendRefMsg(RM_SPELL,48,m_targetcret.m_nCurrX,m_targetcret.m_nCurry,48,'');
          self.SendRefMsg(RM_MAGICFIRE,0,
                        MakeWord(2,48),
                        MakeLong(m_targetcret.m_nCurrX,m_targetcret.m_nCurry),
                        Integer(m_TargetCret),
                        '');

   self.SendDelayMsg (TBaseObject(RM_STRUCK), RM_DELAYMAGIC, nPower, MakeLong(m_targetcret.m_nCurrX, m_targetcret.m_nCurrY), 2, integer(m_targetcret), '', 600);
end;//if npower
end;//if wait
end;
end;
end;
end;
end;
                    BreakHolySeizeMode();
      end else
      m_targetcret := nil;
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;





constructor TFireMonster.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TFireMonster.Destroy;
begin

  inherited;
end;

procedure TFireMonster.Run;//004A9720
var
FireBurnEvent:TFireBurnEvent;
nx,ny,ndamage,ntime:integer;
begin
  if not bo554 and CanMove then begin
// do sqaure around boss
 ntime:=20;
 ndamage:=10;
    nx:=m_ncurrx;
    ny:=m_ncurry;
 //bx:=bx+1;
// by:=by+1;

  if m_PEnvir.GetEvent(nX,nY-1) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY-1,ET_FIRE,nTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492CFC   x //
    if m_PEnvir.GetEvent(nX,nY-2) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY-2,ET_FIRE,nTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492CFC   x

  if m_PEnvir.GetEvent(nX-1,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX-1,nY,ET_FIRE,nTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492D4D //
  if m_PEnvir.GetEvent(nX-2,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX-2,nY,ET_FIRE,nTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //0492D4D

  if m_PEnvir.GetEvent(nX,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY,ET_FIRE,nTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492D9C


  if m_PEnvir.GetEvent(nX+1,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX+1,nY,ET_FIRE,nTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492DED
    if m_PEnvir.GetEvent(nX+2,nY) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX+2,nY,ET_FIRE,nTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492DED

  if m_PEnvir.GetEvent(nX,nY+1) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY+1,ET_FIRE,nTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492E3E
    if m_PEnvir.GetEvent(nX,nY+2) = nil then begin
    FireBurnEvent:=TFireBurnEvent.Create(self,nX,nY+2,ET_FIRE,nTime * 1000 ,nDamage);
    g_EventManager.AddEvent(FireBurnEvent);
  end; //00492E3E


 {do flames behind}
{if m_PEnvir.GetEvent(bx,by) = nil then begin  //behind
    FireBurnEvent:=TFireBurnEvent.Create(Self,bx,by,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(bx+1,by+1) = nil then begin  //behind
    FireBurnEvent:=TFireBurnEvent.Create(Self,bx+1,by+1,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(fx,fy) = nil then begin  //behind
    FireBurnEvent:=TFireBurnEvent.Create(Self,fx,fy,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(fx+1,fy+1) = nil then begin  //behind
    FireBurnEvent:=TFireBurnEvent.Create(Self,fx+1,fy+1,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;    }

{if m_PEnvir.GetEvent(bx-1,by) = nil then begin  //behind
    FireBurnEvent:=TFireBurnEvent.Create(Self,bx-1,by,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(bx-2,by) = nil then begin  //behind
    FireBurnEvent:=TFireBurnEvent.Create(Self,bx-2,by,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(bx-2,by+1) = nil then begin  //down left
    FireBurnEvent:=TFireBurnEvent.Create(Self,bx-2,by+1,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(bx-2,by+2) = nil then begin  //down left
    FireBurnEvent:=TFireBurnEvent.Create(Self,bx-2,by+2,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(fx,fy) = nil then begin  //front
    FireBurnEvent:=TFireBurnEvent.Create(Self,fx,fy,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(fx-1,fy) = nil then begin  //front
    FireBurnEvent:=TFireBurnEvent.Create(Self,fx-1,fy,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(fx+1,fy) = nil then begin  //front
    FireBurnEvent:=TFireBurnEvent.Create(Self,fx+1,fy,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(fx+2,fy) = nil then begin  //front
    FireBurnEvent:=TFireBurnEvent.Create(Self,fx+2,fy,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(fx+2,fy-1) = nil then begin  //front
    FireBurnEvent:=TFireBurnEvent.Create(Self,fx+2,fy-1,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;
if m_PEnvir.GetEvent(fx+2,fy-2) = nil then begin  //front
    FireBurnEvent:=TFireBurnEvent.Create(Self,fx+2,fy-2,ET_FIRE,ntime * 1000 ,ndamage);
    g_EventManager.AddEvent(FireBurnEvent);
end;  }


    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;



{ TFrostTigerMonster }

constructor TFrostTiger.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwSpellTick:=GetTickCount();
  m_dwLastWalkTick:=GetTickCount();
  m_boApproach:=FALSE;
end;

destructor TFrostTiger.Destroy;
begin
  inherited;
end;

procedure TFrostTiger.Run;//004A9720
begin
  if (not bo554) and CanMove then begin

    if m_TargetCret = nil then begin  //if theres no target stay transparent

      if not m_boHideMode then begin
        if (gettickcount - m_dwLastWalkTick > 2000) then begin
          m_dwLastWalkTick := GetTickCount();
          MagicManager.MagMakePrivateTransparent(Self,180);
          SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
        end;
      end else
        m_dwLastWalkTick := GetTickCount();
    end else begin
    //there is a target so take of transparency
      if not m_TargetCret.m_boDeath then begin
        if m_boHideMode then begin
          m_wStatusTimeArr[STATE_TRANSPARENT{0x70}]:=1;
          SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
        end;
      end else
        m_TargetCret := nil;

      if (Integer(GetTickCount - m_dwLastWalkTick) > m_nWalkSpeed) then begin //check if we should walk closer or not and do it :p
        m_dwLastWalkTick:=GetTickCount();
        m_nTargetX:=m_TargetCret.m_nCurrX;
        m_nTargetY:=m_TargetCret.m_nCurry;
        GotoTargetXY();
      end;
    end;

    if ((GetTickCount - m_dwSpellTick) > 3000) and (m_TargetCret <> nil) then begin
      if (abs(m_TargetCret.m_nCurrX-m_nCurrX) >= 2) or (abs(m_TargetCret.m_nCurrY-m_nCurry) >= 2) then begin
        m_dwSpellTick:=GetTickCount();
        FrostAttack();
      end;
    end;

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      //SearchTarget();
    end;
  end;
  inherited;
end;

procedure TFrostTiger.FrostAttack();
var
Target:TBaseObject;
magpwr:Integer;
WAbil:pTAbility;
begin
  if m_TargetCret = nil then exit;
  Target:=m_TargetCret;
  SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(Target),'');

 if IsProperTarget (Target) then begin
  if Random(50) >= Target.m_nAntiMagic then begin
      WAbil:=@m_WAbil;
      magpwr:=(Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
      Target.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
      if (Random(15) <= 3) and (Random(Target.m_btAntiPoison) = 0) then begin
        Target.MakePosion(POISON_FREEZE,(2 * 3),0);
      end;

      if (Random(40) <= 3) and (Random(Target.m_btAntiPoison) = 0) then begin
        Target.MakePosion(POISON_SLOWDOWN,5,0);
        Target.MakePosion(POISON_STONE,5,0);
      end;
    end;
  end;
end;

{ TGreenMonster }

constructor TGreenMonster.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TGreenMonster.Destroy;
begin

  inherited;
end;

procedure TGreenMonster.Run;//004A9720
begin
  if not bo554 and CanMove then begin
       if m_TargetCret <> nil then begin
      m_nTargetX:=m_TargetCret.m_nCurrX;
     m_nTargetY:=m_TargetCret.m_nCurrY;
  if (abs(m_nTargetX-m_nCurrX) = 1) and (abs(m_nTargety-m_nCurry)=1) then begin
  if (Random(m_TargetCret.m_btAntiPoison + 7) <= 6) and (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) then begin
   m_TargetCret.MakePosion(POISON_DECHEALTH,30,1);
 end;
  end;
  end;
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

{ TRedMonster }

constructor TRedMonster.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TRedMonster.Destroy;
begin

  inherited;
end;

procedure TRedMonster.Run;//004A9720
begin
  if not bo554 and CanMove then begin
  if m_TargetCret <> nil then begin
      m_nTargetX:=m_TargetCret.m_nCurrX;
     m_nTargetY:=m_TargetCret.m_nCurrY;
  if (abs(m_nTargetX-m_nCurrX) = 1) and (abs(m_nTargety-m_nCurry)=1) then begin
  if (Random(m_TargetCret.m_btAntiPoison + 7) <= 6) and (m_TargetCret.m_wStatusTimeArr[POISON_DECHEALTH] = 0) then begin
   m_TargetCret.MakePosion(POISON_DAMAGEARMOR,30,1);
 end;
  end;
  end;
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

{ khazard }
constructor TKhazard.Create; //004A9690
begin
  inherited;
  m_dwThinkTick:=GetTickCount();
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TKhazard.Destroy;
begin

  inherited;
end;

procedure TKhazard.Run;//004A9720
var
  time1 : integer;
begin
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin
    time1:=random(2);
    if m_TargetCret <> nil then begin

    //attack code
      if IsProperTarget(m_TargetCret) then begin
        m_nTargetX:=m_TargetCret.m_nCurrX;
        m_nTargetY:=m_TargetCret.m_nCurrY;
        if (abs(m_nTargetX-m_nCurrX) = 2) or (abs(m_nTargety-m_nCurry)=2) then begin
          if (GetTickCount - m_dwThinkTick) > 1000 then begin //do drag back on random
            m_dwThinkTick:=GetTickCount();
            if time1 < 2 then
              drag();
          end else
            AttackTarget();
        end;
      end;
    end;
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

procedure TKhazard.Drag();
var
  nx,ny: Integer;
  nAttackDir: Integer;
begin
  nAttackDir:=GetNextDirection(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,m_nCurrX,m_nCurrY); //technicaly this is the dir the target would be facing if he was hitting us
  GetFrontPosition(nx,ny);
  SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');

  m_TargetCret.CharPushed(nAttackDir,1);
  if (Random(1) = 0) and (Random(m_TargetCret.m_btAntiPoison + 7) <= 6) then begin
    m_TargetCret.MakePosion(POISON_DECHEALTH,35,2);
    exit;
  end;
end;

function TKhazard.AttackTarget():Boolean; //004A8F34
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret,btDir) then begin
      if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
        m_dwHitTick:=GetCurrentTime;
        m_dwTargetFocusTick:=GetTickCount();
        Attack(m_TargetCret,btDir);  //FFED
        if (Random(1) = 0) and (Random(m_TargetCret.m_btAntiPoison + 7) <= 6) then begin
            m_TargetCret.MakePosion(POISON_DECHEALTH,35,2);
            exit;
        end;
      end;
      Result:=True;
    end;
  end;
end;

{ end }

{ runaway }
constructor TRunAway.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TRunAway.Destroy;
begin

  inherited;
end;

procedure TRunAway.Run;//004A9720
var
time1,nx,ny:integer;
borunaway:boolean;
begin
  if (not bo554) and CanMove then begin
if m_TargetCret <> nil then begin
      m_nTargetX:=m_TargetCret.m_nCurrX;
     m_nTargetY:=m_TargetCret.m_nCurrY;
 if (m_wabil.HP <= round(m_wabil.MaxHP div 2)) and (borunaway=false) then begin //if health less then 1/2
    GetFrontPosition(nx,ny);
       SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
       SpaceMove(M_sMapName, nx - 2, ny - 2, 0);  //move backwards 3 spaces
    borunaway:=true;
    end else begin
 if m_wabil.HP >= round(m_wabil.MaxHP div 2) then begin
    borunaway:=false;
 end;
 end;
  if borunaway then begin
     if Integer(GetTickCount - time1) > 5000 then begin
  if (abs(m_nTargetX-m_ncurrx)=1) and (abs(m_nTargety-m_ncurry)=1) then begin
     walkto(random(4),true);
  end else begin
     walkto(random(7),true);
  end;
     end else begin
       time1:=GetTickCount();
     end;
     end;
     end;
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;
{ end }

{ Tele mob }
constructor TTeleMonster.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TTeleMonster.Destroy;
begin

  inherited;
end;

procedure TTeleMonster.Run;//004A9720
begin
  if (not bo554) and CanMove then begin
  //if it finds a target tele to him!
  if m_TargetCret <> nil then begin
    if  (abs(m_nCurrX-m_nTargetX) > 5) or
             (abs(m_nCurrY-m_nTargetY) > 5) then begin
           // if 5 spaces away teleport to the enemy!
            SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
          SpaceMove(m_TargetCret.M_sMapName, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 0);
          end;
  end;
  //end
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;
{ end }

{ Defend Monster }
constructor TDefendMonster.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TDefendMonster.Destroy;
begin

  inherited;
end;

procedure TDefendMonster.Run;//004A9720
begin
  {if (not bo554) and CanMove then begin
  //if it finds a target 15 spaces away start sequence
  if (m_TargetCret <> nil) and (callguardrun=false) then begin

           // call guards!
           mainoutmessage('CALL GUARD' + inttostr(m_nCurrX) + ' ' + inttostr(m_nCurrY));
           callguard(m_sMapName,m_nCurrX,m_nCurrY);
          end;

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;   }
  inherited;
end;
{
procedure TDefendMonster.callguard(mapmap:string; xx,yy:integer);
var
  I: Integer;
  nC:Integer;
  nx,ny:Integer;
  sMonName:array[0..3] of String;
  BaseObject:TBaseObject;
begin
  nC:=7; //how many areas around the boss
 // GetFrontPosition(nx,ny);
  sMonName[0]:='Hen';
 // sMonName[1]:=sZuma2;
 // sMonName[2]:=sZuma3;
 // sMonName[3]:=sZuma4;
    nx:=xx;
    ny:=yy;

  for I := 0 to nC do begin
  { case i of
    0: begin
    Dec(nY);
    end;
    1: begin
       Inc(nX);
       Dec(nY);
      end;
    2: begin
     Inc(nX)
     end;
    3: begin
    Inc(nX);
       Inc(nY);
       end;
    4: begin
     Inc(nY);
     end;
    5: begin
             Dec(nX);
       Inc(nY);
       end;
    6: begin
     Dec(nX);
     end;
    7: begin
             Dec(nX);
        Dec(nY);
        end;
    end;}
   // if m_GuardObjects.Count >= 5 then break;
   {
    BaseObject:=UserEngine.RegenMonsterByName(mapmap,nx,ny,sMonName[0]);
    if BaseObject <> nil then begin
      m_GuardObjects.Add(BaseObject);
    end;
  end;    // for
  callguardrun:=true;//tell it its already been run!
end;

}


constructor TClone.Create;//004AA4B4
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwMpLossTick:= GetTickCount();
  m_boNOITEM:=TRUE;
  m_boNoTame:=TRUE;
end;

procedure TClone.Die;
begin
  SendRefMsg(RM_10205,0,m_nCurrX,m_nCurrY,3{type},'');
  SendDelayMsg(self, RM_DISAPPEAR, 0, 0, 0, 0, '', 600);
  m_boObMode:=True;//hopefully switching to observer also makes us invisible to others when we die :p;
  inherited;
end;


destructor TClone.Destroy;
begin
  inherited;
end;


procedure TClone.StruckDamage(nDamage:integer);
begin
  if m_Master <> nil then begin
    if (m_Master.m_WAbil.MaxHP < nDamage) or (m_Master.m_WAbil.MP < nDamage) then begin
      m_WAbil.HP := 0;
      exit;
    end;
    m_Master.DamageSpell(nDamage);
    m_Master.HealthSpellChanged();
  end;
end;

procedure TClone.SetMpLoss(nMpReduction:Integer);
begin
  nMpLoss:=nMpReduction;
end;

procedure TClone.Run;
var
  nx,ny: Integer;
begin
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin

     if m_Master <> nil then begin
      if (GetTickCount - m_dwMpLossTick) > 3000 then begin //drain our masters mp
        m_dwMpLossTick:=GetTickCount();
        m_Master.DamageSpell(nMpLoss);
        m_Master.HealthSpellChanged();
      end;
      if m_Master.m_WAbil.MP < (m_Master.m_WAbil.MaxMP div 10) then begin  //if our master has to little mp die :p
        m_WAbil.HP:=0;
        inherited;
        exit;
      end;
     end;

     if (GetTickCount - m_dwThinkTick) > 1000 then begin
      m_dwThinkTick:=GetTickCount();
      FindTarget();
     end;

      //some 'mobs' get locked after x steps i guess we could leave this part in :p
    if m_boWalkWaitLocked then begin    //this unlocks the 'walkwaitlock' after it's been locked
      if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
        m_boWalkWaitLocked:=False;
      end;
    end;

    //if we are walkwaitlocked then just exit :p
    if m_boWalkWaitLocked then begin
      inherited;
      exit;
    end;

    if m_Master <> nil then begin
      //if m_TargetCret = nil then begin //if we have no target follow our master
        m_Master.GetBackPosition(nX,nY);
        if (abs(m_nTargetX - nX) > 0) or (abs(m_nTargetY - nY{nX}) > 0) then begin //004A922D
          m_nTargetX:=nX;
          m_nTargetY:=nY;
          if (abs(m_nCurrX - nX) <= 1) and (abs(m_nCurrY - nY) <= 1) then begin
            if m_PEnvir.GetMovingObject(nX,nY,True) <> nil then begin  //if there is already an 'object' behind our master then dont try to go to him
              m_nTargetX:=m_nCurrX;
              m_nTargetY:=m_nCurrY;
            end //004A92A5
          end;
        end; //004A92A5
      //end; //004A92A5 if m_TargetCret = nil then begin
      if (not m_Master.m_boSlaveRelax) and
             ((m_PEnvir <> m_Master.m_PEnvir) or
             (abs(m_nCurrX-m_Master.m_nCurrX) > 20) or
             (abs(m_nCurrY-m_Master.m_nCurrY) > 20)) then begin //if slave isnt set to rest and the master is out of our normal walking range teleport to him
        SpaceMove(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1);
      end; // 004A937E
    end;// 004A937E if m_Master <> nil then begin


    if (m_Master <> nil) and m_Master.m_boSlaveRelax then begin
      //if we have a master and he set petmode to rest then the pet should do absolutely nothing
      inherited ;
      exit;
    end;

    if m_nTargetX <> -1 then begin // if we have targetcoords to go towards then go there (or stay there if coords are same as where you are atm)
        // this locks the walkwaitlock after m_nwalkstep  amount of steps
      if not m_boWalkWaitLocked and (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
        m_dwWalkTick:=GetCurrentTime;
        GotoTargetXY(); //004A93B5 0FFEF
        Inc(m_nWalkCount);
        if m_nWalkCount > m_nWalkStep then begin
          m_nWalkCount:=0;
          m_boWalkWaitLocked:=True;
          m_dwWalkWaitTick:=GetTickCount();
        end; //004A9151
      end;                              

    end else begin //if there's no targetcoords and no real target to attack then walk arround @ random
      if m_TargetCret = nil then Wondering();// FFEE   //Jacky
    end;

    if (m_TargetCret <> nil) and (GetCurrentTime - m_dwHitTick > GetHitSpeed * 3) then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
        m_dwHitTick:=GetCurrentTime;
        MagicAttack();
      end;
    end;

  end;

  inherited;
end;

procedure TClone.MagicAttack();
var
  nPower:Integer;
  UserMagic     :pTUserMagic;
  MirrorMagic   :pTUserMagic;
begin
  nPower:=0;
  if (m_Master <> nil) and (m_TargetCret <> nil) then
    m_Master.DamageSpell(10);//gues this needs to be configurable but for now i'm trying to get this working and dont know how it should work :p
    m_Master.HealthSpellChanged();
  if IsProperTarget (m_TargetCret) then begin
    UserMagic:=GetMagicInfo(11);
    MirrorMagic:=GetMagicInfo(SKILL_MIRROR);
    if (UserMagic = nil) or (MirrorMagic = nil) then exit;

    SendRefMsg(RM_SPELL,UserMagic.MagicInfo.btEffect,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,UserMagic.MagicInfo.wMagicId,'');

    if (Random(50) >= m_TargetCret.m_nAntiMagic) and (Random(9) <= MirrorMagic.btLevel * 3) then begin
      nPower:= GetPower(Mpow(UserMagic),UserMagic) + GetPower(Mpow(MirrorMagic),MirrorMagic);
      if m_TargetCret.m_btLifeAttrib = LA_UNDEAD then nPower:=ROUND(nPower * 1.5);
    end;
    
     SendRefMsg(RM_MAGICFIRE,0,MakeWord(UserMagic.MagicInfo.btEffectType,UserMagic.MagicInfo.btEffect), MakeLong(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY),Integer(m_TargetCret),'');
     SendDelayMsg(self,RM_DELAYMAGIC,nPower,MakeLong(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY),2,Integer(m_TargetCret),'',600);
  end;
end;

function TClone.MPow(UserMagic:pTUserMagic):Integer; //004921C8
begin
  Result:=UserMagic.MagicInfo.wPower + Random(UserMagic.MagicInfo.wMaxPower - UserMagic.MagicInfo.wPower);
end;

function TClone.GetPower(nPower:Integer;UserMagic:pTUserMagic):Integer;
var
nCPower:Integer;
begin
  Result:=0;
  //Safe check so you don't have any negitive one hit kills.
  nCPower:=ROUND(nPower / (UserMagic.MagicInfo.btTrainLv + 1) * (UserMagic.btLevel + 1)) + (UserMagic.MagicInfo.btDefPower + Random(UserMagic.MagicInfo.btDefMaxPower - UserMagic.MagicInfo.btDefPower));
  if nCPower > 0 then Result:=nCPower;
end;

procedure TClone.FindTarget();
begin
  if m_TargetCret <> nil then begin //check if our old target is still valid
    if (m_TargetCret.m_PEnvir <> m_PEnvir) or (m_TargetCret.m_boDeath) or (m_TargetCret.m_boGhost) then
      m_TargetCret := nil;
  end;

  if (m_LastHiter <> nil) and (m_TargetCret = nil) and (ispropertarget(m_LastHiter)) then begin //if we get attacked
    m_TargetCret := m_LastHiter;
  end;

  if m_Master.m_TargetCret <> nil then begin // if our master has a target
    if (m_Master.m_TargetCret.m_PEnvir = m_PEnvir) and (ispropertarget(m_Master.m_TargetCret)) then //if the target is on same map as us
      m_TargetCret := m_Master.m_TargetCret
  end;
  if m_Master.m_LastHiter <> nil then begin  //if someone hit our master
    if (m_Master.m_LastHiter.m_PEnvir = m_PEnvir) and (ispropertarget(m_Master.m_LastHiter)) then // if whoever hit our master is also on same map as us
      m_TargetCret := m_Master.m_LastHiter;
  end;
end;

function TClone.GetShowName: String;
begin
  Result := 'TClone';

  try
    if m_Master <> nil then begin
      Result := m_Master.GetShowName;
    end;
  except
    MainOutMessage('[Exception] TClone.GetShowName');
  end;
end;


{Minotaur King}
constructor TMinotaurKing.Create;//004AA4B4
begin
  inherited;
  nextx:=0;
  nexty:=0;
  boMoving:=FALSE;
  MassAttackMode:=FALSE;
  MassAttackCount:=0;
  NextTarget:=nil;
  m_boApproach:=FALSE;//stops mtk from going towards players
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TMinotaurKing.Destroy;
begin
  inherited;
end;

function TMinotaurKing.Operate(ProcessMsg:pTProcessMessage):boolean;
begin
  if (ProcessMsg.wIdent = RM_MAGSTRUCK) and (not MassAttackMode) then begin
    //they used magic now pwn them with redcircle!!!!!!
    MassAttackMode:=True;
    MassAttackCount:=0;
  end;
  Result := inherited Operate(ProcessMsg);
end;

procedure TMinotaurKing.RedCircle(nDir:Integer);
var
  I:Integer;
  magpwr:Integer;
  WAbil:pTAbility;
  BaseObject:TBaseObject;
  Target:TBaseObject;
begin
//target selected
 m_btDirection:=nDir;
 { get first target }
 if NextTarget <> nil then begin
  Target:=NextTarget;
  NextTarget:=nil;
 end else begin
  Target := m_TargetCret;
 end;
 {do spell effect}
 SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(Target),'');

 {do hit radius around target}
  for i:=0 to Target.m_VisibleActors.Count-1 do begin
    BaseObject:= TBaseObject (pTVisibleBaseObject(Target.m_VisibleActors[i]).BaseObject);
    if (abs(Target.m_nCurrX-BaseObject.m_nCurrX) <= 3) and (abs(Target.m_nCurrY-BaseObject.m_nCurrY) <= 3) then begin
     //if in 3 radious range get hit
      if BaseObject <> nil then begin
        if IsProperTarget (BaseObject) then begin
          if random(3) = 0 then NextTarget:=BaseObject;
          if Random(50) >= BaseObject.m_nAntiMagic then begin
            WAbil:=@m_WAbil;
            magpwr:=(Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
            BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
          end;
        end;
      end;
     end;
  end;
end;


procedure TMinotaurKing.Run;//004AA604
var
  nAttackDir:Integer;
  distx,disty,distx2,disty2:Integer;
begin

  if (not bo554) and CanMove then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;

    //walk code (only make him to towards a target if it's just at the edge of our view range
    if (m_TargetCret <> nil) then begin
      distx := abs(m_nCurrX - m_TargetCret.m_nCurrX);
      disty := abs(m_nCurrY - m_TargetCret.m_nCurrY);
      if (nextx = 0) and (nexty = 0) then begin
        nextx:=m_TargetCret.m_nCurrX ;
        nexty:=m_TargetCret.m_nCurrY;
      end;
    end;
    if boMoving then begin //if moving is true check if we havent reached our destination
      if ((m_nCurrx = nextx) and (m_nCurry = nexty)) then begin
        boMoving:=False;
        nextx:=0;
        nexty:=0;
      end;
      distx2 := abs(m_nCurrX - nextx);
      disty2 := abs(m_nCurrY - nexty);
      if (distx2 < 2) and (disty2 < 2) and (m_PEnvir.MoveToMovingObject(m_nCurrX,m_nCurrY,Self,nextx,nexty,FALSE) <= 0) then begin //if we reached our destination, should add a code to check if there's nobody else there later
        boMoving:=False;
        nextx:=0;
        nexty:=0;
      end;
    end;
    if ((m_TargetCret = nil) or ((distx > 7) or (disty > 7))) and (nextx <> 0) and (nexty <> 0) then
      boMoving:=True;

    if boMoving then begin
      if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin //check if we should walk closer or not and do it :p
        m_dwWalkTick:=GetCurrentTime;
        m_nTargetX:=nextx;
        m_nTargetY:=nexty;
        GotoTargetXY();
      end;
    end;

    {attack them at distance}
    if (m_TargetCret <> nil) and
        (_max(distx,disty) > 1) and
        (Integer(GetTickCount - m_dwHitTick) > 1200) and
        (not MassAttackMode) then begin
      nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
      m_dwHitTick:=GetCurrentTime;
      RedCircle(nAttackDir);
    end;

    {Actual magic attack if hes hit by magic}
    if (Integer(GetTickCount - m_dwHitTick) > 1200) and (m_TargetCret <> nil) then begin
      if (MassAttackMode) then begin
        if (MassAttackCount <= 5) then begin
          m_dwHitTick:=GetCurrentTime;
          inc(MassAttackCount);
          nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
          RedCircle(nAttackDir);
        end else begin
          MassAttackCount := 0;
          MassAttackMode := False;
        end;
      end;
    end;
  end;
  inherited;
end;

 {LEFT & RIGHT GUARDS}

constructor TMinoGuard.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwHitTick:=GetCurrentTime;
end;

destructor TMinoGuard.Destroy;
begin
  inherited;
end;

procedure TMinoGuard.MagicAttack(nDir:Integer);
var
Target:TBaseObject;
magpwr:Integer;
WAbil:pTAbility;
begin
if m_TargetCret <> nil then Target:=m_TargetCret;

SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(Target),'');

 {Hit first Target}
 if IsProperTarget (Target) then begin
  if Random(50) >= Target.m_nAntiMagic then begin
       WAbil:=@m_WAbil;
       magpwr:=(Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
       Target.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
  end;
 end;
end;

procedure TMinoGuard.Run;//004A9720
var
nAttackDir:integer;
begin
  if not bo554 and CanMove then begin

     if (m_TargetCret <> nil) and
       ((abs(m_nCurrX - m_TargetCret.m_nCurrX) >= 2) or
       (abs(m_nCurrY - m_TargetCret.m_nCurrY) >= 2)) and
       (Integer(GetTickCount - m_dwHitTick) > 2200) then begin
      if (MagCanHitTarget(m_nCurrX,m_nCurrY,m_targetCret)) or (m_btRaceImg <> 70) then begin //make sure the 'line' in wich magic will go isnt blocked
        m_dwHitTick:=GetCurrentTime;
        nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
        MagicAttack(nAttackDir);
      end;
     end;

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

constructor TNodeMonster.Create;
begin
  inherited;
  m_boAnimal:=False;
end;

destructor TNodeMonster.Destroy;
begin

  inherited;
end;

procedure TNodeMonster.Run;//004A617C
begin
  if (not m_boDeath) and (not m_boGhost) then begin
    if ((GetTickCount - m_dwSearchEnemyTick) > 18000) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      Search();
    end;
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      SendRefMsg(RM_TURN,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    end;
  end;
  inherited;
end;

procedure TNodeMonster.Search(); //find all the 'allies' (aka other mobs) nearby
var
  xTargetList:TList;
  BaseObject:TBaseObject;
  i:Integer;
begin
  xTargetList := TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,12,xTargetList);
	if (xTargetList.Count>0) then begin
    SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    for i:=xTargetList.Count-1 downto 0 do begin
      BaseObject := TBaseObject(xTargetList.Items[i]);

      if (BaseObject<>nil) then begin
      if BaseObject.m_btRaceServer <> RC_PLAYOBJECT then begin //basicaly if it's not a player then we shield it (even if it's an npc :p)
        CastShield(BaseObject)
      end;
        xTargetList.Delete(i);
		  end;
    end;
	end;
  xTargetList.Free;
end;

procedure TNodeMonster.CastShield(BaseObject: TBaseObject);//give our friend his shield
var
  nSec:integer;
begin
  nSec:=20;//set it to 20 seconds 'shield' since the search is only done every 18seconds this means the shield lasts forever technicaly (provided mob stays in range)
  if m_btRaceImg = 75 then begin  //red one: give dc
    BaseObject.AttPowerUp(m_WAbil.MC,nsec)
  end else begin           //blue one: give ac+amc
    BaseObject.DefenceUp(nSec);
    BaseObject.MagDefenceUp(nSec);
  end;
end;

constructor TOmaKing.Create;
begin
  ldistx:=0;
  ldisty:=0;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwSpellTick:=GetTickCount();
  m_boAnimal:=False;
  inherited;
end;

destructor TOmaKing.Destroy;
begin
  inherited;
end;

procedure TOmaKing.Run;//004AA604
var
  distx,disty:integer;
  nDir:integer;
begin
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin
//walk codes next (since ok doesnt go near players like other mobs do this is hopefully a correct code)
  if (m_TargetCret <> nil) then begin
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin //check if we should walk closer or not and do it :p
      m_dwWalkTick:=GetCurrentTime;
      distx:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
      disty := abs(m_nCurrY - m_TargetCret.m_nCurrY);
      nDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
      if (distx > ldistx) or (disty > ldisty) or (distx > 5) or (disty > 5) then begin //if the last distance from us is further then the current (aka if they running)
        if ((distx > 2) or (disty > 2)) and ((distx < 12) and (disty < 12)) then begin //restrict the maximum pursuit distance to 12 coords away
          //WalkTo(nDir,False);
          m_nTargetX := m_TargetCret.m_nCurrX;
          m_nTargetY := m_TargetCret.m_nCurrY;
          GotoTargetXY;
          ldistx:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
          ldisty := abs(m_nCurrY - m_TargetCret.m_nCurrY);
          exit;
        end;
      end;

      ldistx :=distx;
      ldisty :=disty;
    end;
  end;
//regular attack code
  if (m_TargetCret <> nil) and (GetCurrentTime - m_dwHitTick > GetHitSpeed) and
   (Integer(GetTickCount - m_dwSpellTick) > m_nNextHitTime) and
   (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2)
     and ((abs(m_nCurrY - m_TargetCret.m_nCurrY) + abs(m_nCurrX - m_TargetCret.m_nCurrX)) <= 3) then begin
    m_dwHitTick:=GetCurrentTime;
    if( Random(8) = 0) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1)and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin //10% chance he just attacks)
      attacktarget(); //no point trying to hit something that isnt close enough :p
      if (Random(10) = 0) then begin
        m_TargetCret.MakePosion(POISON_STONE,5,0);
      end;
    end else //does repulse
      RepulseCircle();
  end;

//magic attack code
  if (m_TargetCret <> nil) and
       (Integer(GetTickCount - m_dwSpellTick) > m_nNextHitTime * 4) then begin
        m_dwSpellTick:=GetTickCount();
        BlueCircle();
     end;

//search for targets nearbye
  if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
  end;
  end;
  inherited;
end;

procedure TOmaKing.BlueCircle();
var
  I:Integer;
  magpwr:Integer;
  WAbil:pTAbility;
  BaseObject:TBaseObject;
  Target:TBaseObject;
  nDir:integer;
begin
//target selected
 Target := m_TargetCret;
 nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  m_btDirection:=nDir;
 {do spell effect}
 SendRefMsg(RM_LIGHTING,nDir,m_nCurrX,m_nCurrY,Integer(self),'');

 for i:=0 to self.m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(Target.m_VisibleActors[i]).BaseObject);
   if (abs(Target.m_nCurrX-BaseObject.m_nCurrX) <= 8) and (abs(Target.m_nCurrY-BaseObject.m_nCurrY) <= 8) then begin

    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(50) >= BaseObject.m_nAntiMagic then begin
          WAbil:=@m_WAbil;
          magpwr:=(baseobject.m_WAbil.MaxHP * LoWord(WAbil.MC)) div 100;
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
          if Random(3) <> 0 then
            BaseObject.MakePosion(POISON_STONE,5,0);
        end;
      end;
    end;
   end;
  end;
end;


procedure TOmaKing.RepulseCircle();
var
  I:Integer;
  BaseObject:TBaseObject;
  nDir:Byte;
  push:integer;
begin

 {do spell effect}

 nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
 m_btDirection:=nDir;
 SendAttackMsg(RM_hit,nDir,m_nCurrX,m_nCurrY);


 {do repule radius around 'ourself'}
 for i:=0 to m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(m_VisibleActors[i]).BaseObject);
   if (abs(m_nCurrX-BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY-BaseObject.m_nCurrY) <= 2)
    and ((abs(m_nCurrY - m_TargetCret.m_nCurrY) + abs(m_nCurrX - m_TargetCret.m_nCurrX)) <= 3) then begin

    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(50) >= BaseObject.m_nAntiMagic then begin
          push := 1 + Random(3);
          nDir:= GetNextDirection (m_nCurrX, m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
          BaseObject.CharPushed (nDir, push);
        end;
      end;
    end;
   end;
  end;
end;

function TOmaKing.AttackTarget():Boolean; //004A8F34
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret,btDir) then begin
      if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
        m_dwHitTick:=GetCurrentTime;
        m_dwTargetFocusTick:=GetTickCount();
        Attack(m_TargetCret,btDir);  //FFED
      end;
      Result:=True;
    end;
  end;
end;

constructor TDragonStatue.Create;
begin
m_nViewRange:=15;
  inherited;
  m_boAnimal:=False;
end;

destructor TDragonStatue.Destroy;
begin

  inherited;
end;

procedure TDragonStatue.Run;//004A617C
begin
  if (not m_boDeath) and (not m_boGhost) then begin
  //doing firebang thing
    if (m_TargetCret <> nil) and (GetCurrentTime - m_dwHitTick > GetHitSpeed) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 12) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 12) then begin
      m_dwHitTick:=GetCurrentTime;
      FireBang();
     end;
     //search for targets nearbye(rather then using official search this thing has wider range :p)
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
   end;

  end;
  inherited;
end;

procedure TDragonStatue.FireBang();
var
  nSX,nSY,nTX,nTY,nPwr:Integer;
  I:Integer;
  magpwr:Integer;
  TargetNum:Integer;
  WAbil:pTAbility;
  BaseObject:TBaseObject;
  Target:TBaseObject;
begin
//target selected
 Target := m_TargetCret;

 {do spell effect}
 SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(Target),'');

 for i:=0 to Target.m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(Target.m_VisibleActors[i]).BaseObject);
   if (abs(Target.m_nCurrX-BaseObject.m_nCurrX) <= 1) and (abs(Target.m_nCurrY-BaseObject.m_nCurrY) <= 1) then begin

    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(50) >= BaseObject.m_nAntiMagic then begin
          WAbil:=@m_WAbil;
          magpwr:=(Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
        end;
      end;
    end;
   end;
  end;
end;

{ TDragonPart }


constructor TDragonPart.Create;
begin
  inherited;
  m_boAnimal:=FALSE;
  m_nHealth := 0;
  m_dwHitTick:=0;
  m_boNOITEM:=TRUE;
  dwEMSpellTick:=GetTickCount();
  boIsActive:=FALSE;
  m_nViewRange:=15;
end;

destructor TDragonPart.Destroy;
begin

  inherited;
end;

procedure TDragonPart.StruckDamage(nDamage:integer);
begin
  if boIsActive then begin
    Inc(nEMHitCount);
    if (nEMHitCount >= m_WAbil.MaxHP) and (nEMdrops >= 9)  then //if this is the 10th drop then stop bothering
      m_WAbil.HP:=0;
    if nEMdrops >= 10 then //already had 10 drops total so kill them all :p
      m_WAbil.HP:=0;
  end;
end;

procedure TDragonPart.Run;
begin
  if not m_boGhost and not m_boDeath then begin
    if boIsActive = false then
      m_WAbil.HP:=m_WAbil.MaxHP; //if it's inactive then our hp stays full :p
    if (boIsActive = FALSE) and (dwEMDied <> 0) then
      boIsActive:=true; // if its inactive but em died then activate it
    if (boIsActive = TRUE) and (dwEMDied = 0) then begin //if em respawned while this mob was still here
      boIsActive:=FALSE;
      m_WAbil.HP := 0;
    end;


    if boIsActive then begin
      if ((GetTickCount - dwEMDied) > 600000) or (nEMdrops >= 10) then begin   //if the mob should be dead< kill it
        m_dwHitTick:=GetCurrentTime;  //after 10 mins the mob dies on it's own (no exp for ppl if he dies this way :p)
        m_WAbil.HP := 0;
      end else begin //if it's not time to die yet keep getting struck :p
          m_WAbil.HP:=m_WAbil.MaxHP;
          if (nEMHitCount >= m_WAbil.MaxHP) and (nEMdrops < 10)  then begin
            nEMHitCount:= 0;
            inc(nEMDrops);
            DropItems();
        end;

        if (m_TargetCret <> nil) and (Integer(GetTickCount - dwEMSpellTick) > 3500) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
          dwEMSpellTick:=GetTickCount();
          MassThunder;
        end;

        //search for targets nearbye
        if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
         (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
         m_dwSearchEnemyTick:=GetTickCount();
         SearchTarget();
        end;
      end;
    end;

  end;
  inherited;
end;

function  TDragonPart.GetMagStruckDamage(BaseObject:TBaseObject;nDamage:Integer):Integer;
begin
  if boIsActive then begin
    result:=1;
  end else
    result:=0;
end;

procedure TDragonPart.DropItems();
begin
    ReLoadMonItem();
    ScatterBagItems(self);
end;

procedure TDragonPart.MassThunder();
var
  xTargetList:TList;
  BaseObject:TBaseObject;
  WAbil:pTAbility;
  magpwr:Integer;
  i:Integer;
begin

SendAttackMsg(RM_hit,0,m_nCurrX,m_nCurrY);//make client show random tbolting;
  xTargetList := TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,14,xTargetList);

	if (xTargetList.Count>0) then begin
    for i:=xTargetList.Count-1 downto 0 do begin
      BaseObject := TBaseObject(xTargetList.Items[i]);

      if (BaseObject<>nil) then begin
      if IsProperTarget(BaseObject) then begin
         WAbil:=@m_WAbil;
          magpwr:=(Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
      end;
        xTargetList.Delete(i);
		  end;
    end;
	end;
  xTargetList.Free;
end;

{ holydeva}
constructor THolyDeva.Create;
begin
  inherited;
  m_boAnimal:=FALSE;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_boSpawned:=False;
  m_boFixedHideMode:=True;
end;

destructor THolyDeva.Destroy;
begin

  inherited;
end;

procedure THolyDeva.run();
var
  nX,nY:Integer;
begin
  if m_boSpawned = FALSE then begin
    m_boSpawned := TRUE;
    m_boFixedHideMode:=False;
    SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  end;
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin
     if (GetTickCount - m_dwThinkTick) > 1000 then begin
      m_dwThinkTick:=GetTickCount();
      FindTarget();
     end;

      //some 'mobs' get locked after x steps i guess we could leave this part in :p
    if m_boWalkWaitLocked then begin    //this unlocks the 'walkwaitlock' after it's been locked
      if (GetTickCount - m_dwWalkWaitTick) > m_dwWalkWait then begin
        m_boWalkWaitLocked:=False;
      end;
    end;
    // this locks the walkwaitlock after m_nwalkstep  amount of steps
    if not m_boWalkWaitLocked and (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      Inc(m_nWalkCount);
      if m_nWalkCount > m_nWalkStep then begin
        m_nWalkCount:=0;
        m_boWalkWaitLocked:=True;
        m_dwWalkWaitTick:=GetTickCount();
      end; //004A9151
    end;

    //if we are walkwaitlocked then just exit :p
    if m_boWalkWaitLocked then begin
      inherited;
      exit;
    end;

    if m_Master <> nil then begin
      if m_TargetCret = nil then begin //if we have no target follow our master
        m_Master.GetBackPosition(nX,nY);
        if (abs(m_nTargetX - nX) > 0) or (abs(m_nTargetY - nY{nX}) > 0) then begin //004A922D
          m_nTargetX:=nX;
          m_nTargetY:=nY;
          if (abs(m_nCurrX - nX) <= 1) and (abs(m_nCurrY - nY) <= 1) then begin
            if m_PEnvir.GetMovingObject(nX,nY,True) <> nil then begin  //if there is already an 'object' behind our master then dont try to go to him
              m_nTargetX:=m_nCurrX;
              m_nTargetY:=m_nCurrY;
            end //004A92A5
          end;
        end; //004A92A5
      end; //004A92A5 if m_TargetCret = nil then begin
      if (not m_Master.m_boSlaveRelax) and
             ((m_PEnvir <> m_Master.m_PEnvir) or
             (abs(m_nCurrX-m_Master.m_nCurrX) > 20) or
             (abs(m_nCurrY-m_Master.m_nCurrY) > 20)) then begin //if slave isnt set to rest and the master is out of our normal walking range teleport to him
        SpaceMoveEX(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1,m_Master.m_PEnvir.Flag.nGuildTerritory);
      end; // 004A937E
    end;// 004A937E if m_Master <> nil then begin


    if (m_Master <> nil) and m_Master.m_boSlaveRelax then begin
      //if we have a master and he set petmode to rest then the pet should do absolutely nothing
      inherited ;
      exit;
    end;

    if m_nTargetX <> -1 then begin // if we have targetcoords to go towards then go there (or stay there if coords are same as where you are atm)
      GotoTargetXY(); //004A93B5 0FFEF
    end else begin //if there's no targetcoords and no real target to attack then walk arround @ random
      if m_TargetCret = nil then Wondering();// FFEE   //Jacky
    end;

    if (m_TargetCret <> nil) and (GetCurrentTime - m_dwHitTick > GetHitSpeed) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
      m_dwHitTick:=GetCurrentTime;
      MagicAttack();
    end;

  end;
  inherited;
end;

procedure THolyDeva.MagicAttack();
var
  WAbil:pTAbility;
  nPwr:Integer;
begin
  SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');

  if IsProperTarget(m_TargetCret) then begin
    WAbil:=@m_WAbil;
    nPwr:=(Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
    if nPwr > 0 then
    m_TargetCret.SendDelayMsg (self, RM_MAGSTRUCK, 0, npwr, 1, 0, '', 600);
  end;
end;

procedure THolyDeva.FindTarget();
begin
  if m_Master.m_TargetCret <> nil then begin // if our master has a target
    if (m_Master.m_TargetCret.m_PEnvir = m_PEnvir) and (ispropertarget(m_Master.m_TargetCret)) then //if the target is on same map as us
      m_TargetCret := m_Master.m_TargetCret
  end;
  if m_Master.m_LastHiter <> nil then begin  //if someone hit our master
    if (m_Master.m_LastHiter.m_PEnvir = m_PEnvir) and (ispropertarget(m_Master.m_LastHiter)) then // if whoever hit our master is also on same map as us
      m_TargetCret := m_Master.m_LastHiter;
  end;
end;

{ yimoogi}
constructor TYimoogi.Create;
begin
  m_boFixedHideMode := True;
  inherited;
  m_boAnimal:=FALSE;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_dwThinkTick:=GetTickCount();
  m_dwSpellTick:=GetTickCount();
  m_dwPoisonTick:=GetTickCount();
  m_nViewRange := 15;
  m_boApproach:=FALSE;
  m_boActive:=False;
  m_boNoAttackMode := True;
  m_boDied:=False;
end;

destructor TYimoogi.Destroy;
begin
  inherited;
  if m_CounterPart <> nil then begin
    if (m_CounterPart is TYimoogi) or (m_CounterPart is TYimoogiMaster) then begin
      TYimoogi(m_CounterPart).m_counterpart := nil;
    end;
  end;
end;

procedure TYimoogi.Run;//004AA604
var
  dist: integer;
begin
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin
    if  m_TargetCret <> nil then
      m_boActive := True;
    if m_boActive  then begin//if we are on active mode then we go hunting
      if (GetTickCount - m_dwThinkTick) > 5000 then begin
        m_dwThinkTick:=GetTickCount();
        SearchTarget;
        if m_TargetCret = nil then //if we hunted and there's still no target then go inactive
          m_boActive := False;
      end;
    end;
    if m_TargetCret <> nil then begin //if we have a target we walk, we kill it
{walking part}
      dist := 0;
      dist:=_Max(Abs(m_nCurrx - m_TargetCret.m_nCurrX),Abs(m_nCurrY - m_TargetCret.m_nCurrY));
      if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin //check if we should walk closer or not and do it
        m_dwWalkTick:=GetCurrentTime;
        if dist > 13 then begin
          m_nTargetX:=m_TargetCret.m_nCurrX;
          m_nTargetY:=m_TargetCret.m_nCurrY;
          GotoTargetXY;
        end;
      end;
      m_btDirection := GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
{regular attack part}
      if (GetCurrentTime - m_dwHitTick > GetHitSpeed) and (dist <= 1) then begin
        //m_dwHitTick:=GetCurrentTime;
        attacktarget();
      end;
{ranged attack part}
      if (GetCurrentTime - m_dwHitTick > GetHitSpeed * 2) and (dist > 1) then begin
        m_dwHitTick:=GetCurrentTime;
        MagicAttack();
      end;
{red poison part} //random between 4 and 10 seconds
      if (Integer(GetTickCount - m_dwPoisonTick) > (random(6)+4)*1000) then begin
        m_dwPoisonTick:=GetTickCount();
        m_dwHitTick:=GetCurrentTime;
        PoisonAttack;
        if (m_CounterPart <> nil) and (m_CounterPart is TYimoogi) then begin
          TYimoogi(m_CounterPart).m_dwPoisonTick := GetTickCount();
        end;
      end;
    end;
  end else begin
    if m_boDied = False then begin
      m_boDied := True;
      if (m_CounterPart <> nil) and (m_CounterPart is TYimoogiMaster) then begin
        TYimoogiMaster(m_CounterPart).CloneDied;
      end else if(m_CounterPart <> nil) and (m_CounterPart is TYimoogi) then begin
         TYimoogiMaster(self).CallGuard;
      end;
    end;
  end;
  if m_WAbil.HP <= 0 then begin
    if m_CounterPart <> nil then begin
      if (m_CounterPart is TYimoogi) or (m_CounterPart is TYimoogiMaster) then begin
        TYimoogi(m_CounterPart).m_counterpart := nil;
        m_CounterPart := nil;
      end;
    end;
  end;
  inherited;
end;

procedure TYimoogi.MagicAttack();
var
magpwr:Integer;
WAbil:pTAbility;
begin
  SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
  if IsProperTarget (m_TargetCret) then begin
    if Random(50) >= m_TargetCret.m_nAntiMagic then begin
      WAbil:=@m_WAbil;
      magpwr:=(Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
      m_TargetCret.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 0, 0, '', 600);
      m_TargetCret.SendDelayMsg(m_TargetCret,RM_10205,0,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,14{type},'',1000);
    end;
  end;
end;

procedure TYimoogi.PoisonAttack();
var
  xTargetList:TList;
  BaseObject:TBaseObject;
  i:Integer;
begin
  xTargetList := TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,15,xTargetList);
	if (xTargetList.Count>0) then begin
    SendRefMsg(RM_FLYAXE,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
    for i:=xTargetList.Count-1 downto 0 do begin
      BaseObject := TBaseObject(xTargetList.Items[i]);

      if (BaseObject<>nil) then begin
      if IsProperTarget(BaseObject) then begin
        if Random(BaseObject.m_btAntiPoison + 5) <= 6 then
          BaseObject.SendDelayMsg(self,RM_POISON,POISON_DAMAGEARMOR,20,Integer(self),3,'',1000);
      end;
        xTargetList.Delete(i);
		  end;
    end;
	end;
  xTargetList.Free;
end;

constructor TYimoogiMaster.Create;
begin
  inherited;
  m_dwLastRecall := GetTickCount();
  m_dwCloneSpawn := 0;
end;

destructor TYimoogiMaster.Destroy;
begin
  inherited;
  m_dwLastRecall := GetTickCount();
end;

procedure TYimoogiMaster.Run;
var
  dist: integer;
  nx,ny: integer;
begin
  if not m_boGhost and
     not m_boDeath and
     not m_boFixedHideMode and
      (m_TargetCret <> nil) then begin
     if (m_dwCloneSpawn <> 0) and (GetTickCount - m_dwCloneSpawn > 500) then begin
      GetFrontPosition(nX,nY);
      m_CounterPart := UserEngine.RegenMonsterByName(m_PEnvir,nX,nY,FilterShowName(m_sCharName) + '1');
      m_dwCloneSpawn := 0;
      if (m_CounterPart <> nil) AND (m_CounterPart is TYimoogi) then begin
        TYimoogi(m_CounterPart).m_counterpart := self;
        m_CounterPart.m_TargetCret := m_TargetCret;
      end else
          //something wrong here cant spawn second yimoogi
     end;
     if (m_CounterPart = nil) and (GetTickCount - m_dwLastRecall > 2000) then begin
      m_dwLastRecall:= GetTickCount();
      //find the fake yimoogi on this map or spawn a new one
      m_CounterPart := FindYimoogi(FilterShowName(m_sCharName) + '1');
      if m_CounterPart = nil then begin //didnt find one on map so we're spawning one instead
        SendRefMsg(RM_LIGHTING,m_btDirection,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
        m_dwCloneSpawn:=GetTickCount;
      end;
    end;
  end;
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin
    if  m_TargetCret <> nil then begin
      if m_CounterPart <> nil then begin
        dist := 0;
        dist:=_Max(Abs(m_nCurrx - m_CounterPart.m_nCurrX),Abs(m_nCurrY - m_CounterPart.m_nCurrY));
        GetFrontPosition(nX,nY);
        if (dist > 12) and (GetTickCount - m_dwLastRecall > 1000) then begin
          m_dwLastRecall:= GetTickCount();
          //somehow tell our other half that it needs to come to us
          m_CounterPart.SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
          m_CounterPart.SpaceMove(m_sMapName,nX,nY,0);
        end;
      end;
    end;
  end;
  inherited;
end;

function TYimoogiMaster.FindYimoogi(sname: String):TBaseObject;
var
  MonList:TList;
  I: integer;
  BaseObject:TBaseObject;
begin
  result:= nil;
  MonList:=TList.Create;
  UserEngine.GetMapMonster(m_PEnvir,MonList);
  for I := 0 to MonList.Count - 1 do begin
    BaseObject:=TBaseObject(MonList.Items[I]);
    if BaseObject.m_sCharName = sname then begin
      result:= BaseObject;
      break;
    end;
  end;
  MonList.Free;
end;

function TYimoogiMaster.GetFrontPosition(var nX:Integer;var nY:Integer):Boolean;
var
  Envir:TEnvirnoment;
begin
  Envir:=m_PEnvir;
  nX:=m_nCurrX;
  nY:=m_nCurrY;
  case m_btDirection of    //
    DR_UP: begin
      if nY > 0 then Dec(nY,2);
    end;
    DR_UPRIGHT: begin
      if (nX < (Envir.Header.wWidth -2)) and (nY > 0) then begin
       Inc(nX,2);
       Dec(nY,2);
      end;
    end;
    DR_RIGHT: begin
     if nX < (Envir.Header.wWidth -2) then Inc(nX,2);
    end;
    DR_DOWNRIGHT: begin
      if (nX < (Envir.Header.wWidth -2)) and (nY < (Envir.Header.wHeight -2)) then begin
       Inc(nX,2);
       Inc(nY,2);
      end;
    end;
    DR_DOWN: begin
     if nY < (Envir.Header.wHeight -2) then Inc(nY,2);
    end;
    DR_DOWNLEFT: begin
      if (nX > 0) and (nY < (Envir.Header.wHeight -2)) then begin
       Dec(nX,2);
       Inc(nY,2);
      end;
    end;
    DR_LEFT: begin
      if nX > 0 then Dec(nX,2);
    end;
    DR_UPLEFT: begin
      if (nX > 0) and (nY > 0) then begin
        Dec(nX,2);
        Dec(nY,2);
      end;
    end;
  end;
  Result:=True;
end;

procedure TYimoogiMaster.CallGuard;
const
  sMonName:String = 'GuardianViper';
var
  n10,n14:Integer;
  BaseObject:TBaseObject;
begin
  GetFrontPosition(n10,n14);
  BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,n10,n14,sMonName);
  GetBackPosition(n10,n14);
  BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,n10,n14,sMonName);
end;

procedure TYimoogiMaster.CloneDied();
begin
  CallGuard;
  m_TargetCret := nil;
  m_boActive := False;
  m_dwLastRecall := GetTickCount() + 2000;
  SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
  MapRandomMove(m_sMapName,0);
end;

{ TBlackFox }

constructor TBlackFox.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_boUseMagic:=False;
  m_boApproach:=FALSE;
end;

destructor TBlackFox.Destroy;
begin

  inherited;
end;

function TBlackFox.MagCanHitTarget(nX, nY:Integer;
  TargeTBaseObject: TBaseObject): Boolean; //004C6B1C
var
  n14,n18,n19,n1C,n20:Integer;
begin
  Result:=False;
  if TargeTBaseObject = nil then exit;
  n20:=abs(nX - TargeTBaseObject.m_nCurrX) + abs(nY - TargeTBaseObject.m_nCurrY);
  n14:=0;
  n18:=GetNextDirection(nX,nY,TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY);
  while (n14 < 13) do begin
    n19:=GetNextDirection(nX,nY,TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY);
    if n18 <> n19 then
      break;
    if m_PEnvir.GetNextPosition(nX,nY,n18,1,nX,nY) and m_PEnvir.IsValidCell(nX,nY) then begin
      if (nX = TargeTBaseObject.m_nCurrX) and (nY = TargeTBaseObject.m_nCurrY) then begin
        Result:=True;
        break;
      end else begin
        n1C:=abs(nX - TargeTBaseObject.m_nCurrX) + abs(nY - TargeTBaseObject.m_nCurrY);
        if n1C > n20 then begin
          Result:=True;
          break;
        end;
        n1C:=n20;
      end;
    end else begin
      break;
    end;
    Inc(n14);
  end;
end;

procedure TBlackFox.ThrustAttack(nDir: Integer);
var
  WAbil:pTAbility;
  nSX,nSY,nTX,nTY,nPwr:Integer;

begin
  m_btDirection:=nDir;
  if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,nDir,1,nSX,nSY) then begin
    m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,nDir,3,nTX,nTY);
    WAbil:=@m_WAbil;
    nPwr:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    MagPassThroughMagic(nSX,nSY,nTX,nTY,nDir,nPwr,True);
  end;
  SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
end;

procedure TBlackFox.Run;
var
  nAttackDir,nDir,distx,disty:Integer;
  nX,nY:Integer;
begin
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin

    if m_WAbil.HP < m_WAbil.MaxHP div 2 then m_boUseMagic:=True
    else m_boUseMagic:=False;

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
    if m_TargetCret <> nil then begin
    //walking
     if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin //check if we should walk closer or not and do it :p
        distx:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
        disty := abs(m_nCurrY - m_TargetCret.m_nCurrY);
        nDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
        if (((distx > 2) or (disty > 2)) and ((distx < 12) and (disty < 12))) or (MagCanHitTarget(m_nCurrX,m_nCurrY,m_targetCret) = false) then begin //restrict the maximum pursuit distance to 12 coords away
          m_dwWalkTick:=GetCurrentTime;
          m_nTargetX := m_TargetCret.m_nCurrX;
          m_nTargetY := m_TargetCret.m_nCurrY;
          GotoTargetXY
//          WalkTo(nDir,False);
        end;
      end;
      nX:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
      nY:=abs(m_nCurrY - m_TargetCret.m_nCurrY);
      if MagCanHitTarget(m_nCurrX,m_nCurrY,m_targetCret) then begin //make sure the 'line' in wich magic will go isnt blocked
        if (nX <= 3) and (nY <= 3) then begin
          if m_boUseMagic or ((nX = 2) or (nY = 2)) then begin
            if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
              m_dwHitTick:=GetCurrentTime;
              nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
              ThrustAttack(nAttackDir);
            end;
          end;
        end;
      end;
    end;
  end;
  inherited Run;
end;

{ TRedFox }

constructor TRedFox.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwHitTick:=GetCurrentTime;
end;

destructor TRedFox.Destroy;
begin
  inherited;
end;

function TRedFox.AttackTarget():Boolean;
var
  I: Integer;
  BaseObject:TBaseObject;
  nPower:Integer;
  WAbil:pTAbility;
begin
  Result:=False;
  if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
    m_dwHitTick:=GetCurrentTime;
    SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    WAbil:=@m_WAbil;
    nPower:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) +1) + LoWord(WAbil.DC));
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then begin
          SendDelayMsg(Self,RM_DELAYMAGIC,nPower,MakeLong(BaseObject.m_nCurrX,BaseObject.m_nCurrY),1,Integer(BaseObject),'',200);
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,19{type},'');
        end;
      end;
    end;
    Result:=True;
  end;
  if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 5) then begin
   SetTargetXY(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
  end;
end;

procedure TRedFox.MagicAttack;
var
  I: Integer;
  BaseObject:TBaseObject;
  nPower:Integer;
  WAbil:pTAbility;
begin
//  Result:=False;
  if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
    m_dwHitTick:=GetCurrentTime;
    SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    WAbil:=@m_WAbil;
    nPower:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) +1) + LoWord(WAbil.DC));
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then begin
          SendDelayMsg(Self,RM_DELAYMAGIC,nPower,MakeLong(BaseObject.m_nCurrX,BaseObject.m_nCurrY),1,Integer(BaseObject),'',200);
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,20{type},'');
        end;
      end;
    end;
//    Result:=True;
  end;
end;

procedure TRedFox.Run;
var
nAttackDir:integer;
begin
  if CanMove then begin

  if m_TargetCret <> nil then begin
    if  (abs(m_nCurrX-m_nTargetX) > 5) or (abs(m_nCurrY-m_nTargetY) > 5) then begin
          SendRefMsg(RM_SPACEMOVE_FIRE,0,0,0,0,'');
          SpaceMove(m_TargetCret.m_sMapName, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY, 0);
    end;
  end;

    if m_TargetCret <> nil then begin
      if (Integer(GetTickCount - m_dwSpellTick) > 2500) then begin
        m_dwSpellTick:=GetTickCount();
        if (Random(4) = 0) then begin
        MagicAttack();
        end else begin
        AttackTarget();
        end;
      end;
    end;

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
    
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) and (m_TargetCret <> nil) then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 8) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 8) then begin
        if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 6) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 6) then begin
          if Random(5) = 0 then begin
            GetBackPosition(m_nTargetX,m_nTargetY);
          end;
        end else begin
          GetBackPosition(m_nTargetX,m_nTargetY);
        end;
      end;
    end;
  end;
  inherited;
end;

{ TWhiteFox }
constructor TWhiteFox.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwHitTick:=GetCurrentTime;
end;

destructor TWhiteFox.Destroy;
begin
  inherited;
end;

function TWhiteFox.AttackTarget():Boolean;
var
  I: Integer;
  BaseObject:TBaseObject;
  nPower:Integer;
  WAbil:pTAbility;
begin
  Result:=False;
  if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
    m_dwHitTick:=GetCurrentTime;
    SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    WAbil:=@m_WAbil;
    nPower:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) +1) + LoWord(WAbil.DC));
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then begin
          SendDelayMsg(Self,RM_DELAYMAGIC,nPower,MakeLong(BaseObject.m_nCurrX,BaseObject.m_nCurrY),2,Integer(BaseObject),'',200);
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,22{type},'');
          BaseObject.MakePosion(POISON_SLOWDOWN,4,0);
        end;
      end;
    end;
    Result:=True;
  end;
end;

procedure TWhiteFox.MagicAttack;
var
  I: Integer;
  BaseObject:TBaseObject;
  nPower:Integer;
  WAbil:pTAbility;
begin
  if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
    m_dwHitTick:=GetCurrentTime;
    SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    WAbil:=@m_WAbil;
    nPower:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) +1) + LoWord(WAbil.DC));
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then begin
          SendDelayMsg(Self,RM_DELAYMAGIC,nPower,MakeLong(BaseObject.m_nCurrX,BaseObject.m_nCurrY),1,Integer(BaseObject),'',200);
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,21{type},'');

        end;
      end;
    end;
  end;
end;

procedure TWhiteFox.CallDragon;
var
  nX,nY:Integer;
  MonObj:TBaseObject;
  PlayObject: TPlayObject;
begin
  if PlayObject.SlaveCount(g_Config.sDragon) > 0 then begin
    PlayObject.RecallSlave(g_Config.sDragon);
    exit;
  end;
  if PlayObject.SlaveCount(g_Config.sDragon1) > 0 then begin
    PlayObject.RecallSlave(g_Config.sDragon1);
    exit;
  end;
    GetFrontPosition(nX,nY);
    MonObj:=UserEngine.RegenMonsterByName(m_PEnvir,nX,nY,g_Config.sDragon1);
    SendRefMsg(RM_10205,0,m_nCurrX,m_nCurrY,25,'');
end;

procedure TWhiteFox.Run;
var
nAttackDir:integer;
begin
  if CanMove then begin

    if m_WAbil.HP < m_WAbil.MaxHP div 2 then begin
      if (Integer(GetTickCount - m_dwSpellTick) > 6000) then begin
        m_dwSpellTick:=GetTickCount();
        CallDragon();
      end;
    end;

    if m_TargetCret <> nil then begin
      if (Integer(GetTickCount - m_dwSpellTick) > 6000) then begin
        m_dwSpellTick:=GetTickCount();
        if (Random(4) = 0) then begin
        AttackTarget();
        end else begin
        MagicAttack();
        end;
      end;
    end;

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

{ TFoxOrbSpirit }

constructor TNewMonsterBoss.Create;
begin
  ldistx:=0;
  ldisty:=0;
  m_dwSearchTime:=Random(1500) + 1500;
  m_dwSpellTick:=GetTickCount();
  m_boAnimal:=False;
  inherited;
end;

destructor TNewMonsterBoss.Destroy;
begin
  inherited;
end;

procedure TNewMonsterBoss.Run;//004AA604
var
  distx,disty:integer;
  nDir:integer;
begin
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin
//walk codes next (since ok doesnt go near players like other mobs do this is hopefully a correct code)
  if (m_TargetCret <> nil) then begin
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin //check if we should walk closer or not and do it :p
      m_dwWalkTick:=GetCurrentTime;
      distx:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
      disty := abs(m_nCurrY - m_TargetCret.m_nCurrY);
      nDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
      if (distx > ldistx) or (disty > ldisty) or (distx > 5) or (disty > 5) then begin //if the last distance from us is further then the current (aka if they running)
        if ((distx > 2) or (disty > 2)) and ((distx < 12) and (disty < 12)) then begin //restrict the maximum pursuit distance to 12 coords away
          //WalkTo(nDir,False);
          m_nTargetX := m_TargetCret.m_nCurrX;
          m_nTargetY := m_TargetCret.m_nCurrY;
          GotoTargetXY;
          ldistx:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
          ldisty := abs(m_nCurrY - m_TargetCret.m_nCurrY);
          exit;
        end;
      end;

      ldistx :=distx;
      ldisty :=disty;
    end;
  end;
//regular attack code
  if (m_TargetCret <> nil) and (GetCurrentTime - m_dwHitTick > GetHitSpeed) and
   (Integer(GetTickCount - m_dwSpellTick) > m_nNextHitTime) and
   (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2)
     and ((abs(m_nCurrY - m_TargetCret.m_nCurrY) + abs(m_nCurrX - m_TargetCret.m_nCurrX)) <= 3) then begin
    m_dwHitTick:=GetCurrentTime;
    if( Random(8) = 0) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 1)and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 1) then begin //10% chance he just attacks)
      attacktarget(); //no point trying to hit something that isnt close enough :p
      if (Random(10) = 0) then begin
        m_TargetCret.MakePosion(POISON_STONE,5,0);
      end;
    end else //does repulse
      RepulseCircle();
  end;
//magic attack code
  if (m_TargetCret <> nil) and
       (Integer(GetTickCount - m_dwSpellTick) > m_nNextHitTime * 4) then begin
        m_dwSpellTick:=GetTickCount();
        RedCircle();
     end;
//search for targets nearbye
  if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
  end;
  end;
  inherited;
end;

procedure TNewMonsterBoss.RedCircle();
var
  I:Integer;
  magpwr:Integer;
  WAbil:pTAbility;
  BaseObject:TBaseObject;
  Target:TBaseObject;
  nDir:integer;
begin
//target selected
 Target := m_TargetCret;
 nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
  m_btDirection:=nDir;
 {do spell effect}
 SendRefMsg(RM_LIGHTING,nDir,m_nCurrX,m_nCurrY,Integer(self),'');

 for i:=0 to self.m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(Target.m_VisibleActors[i]).BaseObject);
   if (abs(Target.m_nCurrX-BaseObject.m_nCurrX) <= 8) and (abs(Target.m_nCurrY-BaseObject.m_nCurrY) <= 8) then begin

    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(50) >= BaseObject.m_nAntiMagic then begin
          WAbil:=@m_WAbil;
          magpwr:=(baseobject.m_WAbil.MaxHP * LoWord(WAbil.MC)) div 100;
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
          if Random(3) <> 0 then
            BaseObject.MakePosion(POISON_STONE,5,0);
            SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,18{type},'');
        end;
      end;
    end;
   end;
  end;
end;

procedure TNewMonsterBoss.RepulseCircle();
var
  I:Integer;
  BaseObject:TBaseObject;
  nDir:Byte;
  push:integer;
begin
 {do spell effect}
 nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
 m_btDirection:=nDir;
 SendAttackMsg(RM_hit,nDir,m_nCurrX,m_nCurrY);

 {do repule radius around 'ourself'}
 for i:=0 to m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(m_VisibleActors[i]).BaseObject);
   if (abs(m_nCurrX-BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY-BaseObject.m_nCurrY) <= 2)
    and ((abs(m_nCurrY - m_TargetCret.m_nCurrY) + abs(m_nCurrX - m_TargetCret.m_nCurrX)) <= 3) then begin

    {if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(50) >= BaseObject.m_nAntiMagic then begin
          push := 1 + Random(3);
          nDir:= GetNextDirection (m_nCurrX, m_nCurrY, BaseObject.m_nCurrX, BaseObject.m_nCurrY);
          BaseObject.CharPushed (nDir, push);
        end;
      end;
    end;}
   end;
  end;
end;

function TNewMonsterBoss.AttackTarget():Boolean;
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret,btDir) then begin
      if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
        m_dwHitTick:=GetCurrentTime;
        m_dwTargetFocusTick:=GetTickCount();
        Attack(m_TargetCret,btDir);
      end;
      Result:=True;
    end;
  end;
end;

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: ObjMon3.pas 594 2007-03-09 15:00:12Z damian $');
end.
