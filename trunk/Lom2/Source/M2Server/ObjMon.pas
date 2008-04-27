unit ObjMon;

interface
uses
  svn, Windows,Classes,HUtil32,Grobal2,ObjBase;
type
  TMonster = class(TAnimalObject)
    n54C           :Integer;     //0x54C
    m_dwThinkTick  :LongWord;    //0x550
    bo554          :Boolean;     //0x554
    m_boDupMode    :Boolean; //0x555
    m_boApproach   :Boolean; //wether or not a mob should go near his target or not
  private
    function Think: Boolean;
    function MakeClone(sMonName:String;OldMon:TBaseObject):TBaseObject;

  public
    constructor Create();override;
    destructor Destroy; override;

    {procedure ComeOut;
    procedure ComeDown;
    function  CheckComeOut(nValue:Integer):Boolean;}

    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;//FFFC
    function AttackTarget():Boolean; virtual; //FFEB
    procedure Run; override;
  end;
  TChickenDeer = class(TMonster)
  private

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;
  TATMonster = class(TMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
  end;
  TSlowATMonster = class(TATMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
  end;
  TScorpion = class(TATMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
  end;
  TSpitSpider = class(TATMonster)
    m_boUsePoison    :Boolean;
  private
    procedure SpitAttack(btDir:Byte);
  public
    constructor Create();override;
    destructor Destroy; override;
    function AttackTarget():Boolean; override;
  end;
  THighRiskSpider = class(TSpitSpider)
  private

  public
    constructor Create();override;
    destructor Destroy; override;
  end;
  TBigPoisionSpider = class(TSpitSpider)
  private

  public
    constructor Create();override;
    destructor Destroy; override;
  end;
  TGasAttackMonster = class(TATMonster)
  private

  public
    constructor Create();override;
    destructor Destroy; override;
    function  AttackTarget:Boolean;override;
    function  sub_4A9C78(bt05:Byte):TBaseObject;virtual;//FFEA
  end;
  TCowMonster = class(TATMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
  end;
  TMagCowMonster = class(TATMonster)
  private
    procedure sub_4A9F6C(btDir:Byte);
  public
    constructor Create();override;
    destructor Destroy; override;
    function  AttackTarget:Boolean;override;
  end;
  TCowKingMonster = class(TATMonster)
    dw558    :LongWord;
    bo55C    :Boolean;
    bo55D    :Boolean;
    n560     :integer;
    dw564    :LongWord;
    dw568    :LongWord;
    dw56C    :LongWord;
    dw570    :LongWord;
  private

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer);override;
    procedure Initialize();override;
  end;
  TElectronicScolpionMon  = class(TMonster)
  private
    m_boUseMagic:Boolean;
    procedure LightingAttack(nDir:Integer);

  public
    constructor Create();override;
    destructor Destroy; override;

    function MagCanHitTarget(nX, nY:Integer;TargeTBaseObject: TBaseObject): Boolean;override;
    procedure Run;override;
  end;

  TCrystalSpider = class (TElectronicScolpionMon)
  private
  public
    function AttackTarget():Boolean; override;//FFEB
    constructor Create();override;
    destructor Destroy; override;
  end;
  TLightingZombi = class(TMonster)
  private
    procedure LightingAttack(nDir:Integer);

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;
  TDigOutZombi = class(TMonster)
  private
    procedure sub_4AA8DC;

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;
  TZilKinZombi = class(TATMonster)
    dw558   :LongWord;
    nZilKillCount    :Integer;
    dw560    :LongWord;
  private

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Die;override;
    procedure Run;override;
  end;
  TWhiteSkeleton = class(TATMonster)
  private
    m_boIsFirst    :Boolean; //0x7A0
  
    procedure Reset; //0x00509C88
  public
    constructor Create();override; //0x00509C08
    destructor Destroy; override;
    procedure RecalcAbilitys();override; //0x00509C74
    procedure Run;override; //0x00509CE8
  end;
  TScultureMonster = class(TMonster)
  private
    procedure MeltStone;//
    procedure MeltStoneAll;

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;
  TScultureKingMonster = class(TMonster)
  private
    m_nDangerLevel       :Integer;
    m_SlaveObjectList  :TList;//0x55C

    procedure MeltStone;
    procedure CallSlave;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Attack(TargeTBaseObject: TBaseObject; nDir: Integer);override; //0FFED
    procedure Run;override;
  end;
  TGasMothMonster = class(TGasAttackMonster) //Ð¨¶ê
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
    function  sub_4A9C78(bt05:Byte):TBaseObject;override;//FFEA
  end;
  TGasDungMonster = class(TGasAttackMonster)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
  end;
  TElfMonster = class(TMonster)
  private
    boIsFirst    :Boolean;  //0x7A0
  
    procedure AppearNow;
    procedure ResetElfMon;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;
  TElfWarriorMonster = class(TSpitSpider)
  private
    boIsFirst    :Boolean;    //0x560
    dwDigDownTick:LongWord;   //0x564
  
    procedure AppearNow;
    procedure ResetElfMon;
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure RecalcAbilitys(); override;
    procedure Run; override;
  end;
  TDoubleCriticalMonster = class(TATMonster)
  private
    m_n7A0    :Integer;
  public
    constructor Create();override; //0x0050ACB4
    destructor Destroy; override;

    procedure Run; override; //0x0050AD00
    procedure Attack(Target:TBaseObject; nDir:Integer);override; //0x0050AE74
  end;
  TDDevil  = class(TMonster)
  m_dwSpellTick  :LongWord;
  private
    m_boUseMagic:Boolean;

    procedure LightingAttack(nDir:Integer);

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;

  TRedThunderZuma = class(TScultureMonster)
    m_dwSpellTick : LongWord;
  private
    procedure MagicAttack();
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;

  TStoneMonster = class(TMonster)
  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run; override;
  end;


implementation

uses
  UsrEngn, M2Share, Event;

  
{ TMonster }
constructor TMonster.Create; //004A8B74
begin
  inherited;
  m_boDupMode:=False;
  bo554:=False;
  m_dwThinkTick:=GetTickCount();
  m_nViewRange:=5;
  m_nRunTime:=250;
  m_dwSearchTime:=3000 + Random(2000);
  m_dwSearchTick:=GetTickCount();
  m_boApproach:=TRUE;
end;

destructor TMonster.Destroy; //004A8C24
begin
  inherited;
end;
function TMonster.MakeClone(sMonName: String;OldMon:TBaseObject): TBaseObject; //004A8C58
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




(*procedure TMonster.ComeOut;
begin
	m_boHideMode := FALSE;
	SendRefMsg(RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
end;

procedure TMonster.ComeDown;
var
  i:Integer;
  pVisibleObject:pTVisibleBaseObject;
begin
	SendRefMsg(RM_DIGDOWN, m_btDirection, m_nCurrX, m_nCurrY, 0, '');

  for i := 0 to m_VisibleActors.Count - 1 do begin
    pVisibleObject:=pTVisibleBaseObject(m_VisibleActors.Items[i]);

    if (pVisibleObject <> nil) then
  end;

	CVisibleObject* pVisibleObject;

	if (m_xVisibleObjectList.GetCount())
	{
		PLISTNODE pListNode = m_xVisibleObjectList.GetHead();

		while (pListNode)
		{
			if (pVisibleObject = m_xVisibleObjectList.GetData(pListNode))
			{
				delete pVisibleObject;
				pVisibleObject = NULL;
			}

			pListNode = m_xVisibleObjectList.RemoveNode(pListNode);
		} // while (pListNode)
	}

	m_boHideMode := TRUE;
end;

function TMonster.CheckComeOut(nValue:Integer):Boolean;
var
  i:Integer;
  BaseObject:TBaseObject;
begin
  Result := FALSE;
  for i := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject:=pTVisibleBaseObject(m_VisibleActors.Items[i]).BaseObject;
    if (not BaseObject.m_boDeath) and IsProperTarget(BaseObject) and (not BaseObject.m_boObMode) then begin
      if (abs(m_nCurrX - BaseObject.m_nCurrX) <= nValue) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= nValue) then begin
        Result := TRUE;
        Exit;
      end;
    end;
  end;
end;*)




function TMonster.Operate(ProcessMsg: pTProcessMessage):Boolean;
begin
  Result:=inherited Operate(ProcessMsg);
end;
function TMonster.Think():Boolean; //004A8E54
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

function TMonster.AttackTarget():Boolean; //004A8F34
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret <> nil then begin
    if GetAttackDir(m_TargetCret,btDir) then begin
      if GetCurrentTime - m_dwHitTick > GetHitSpeed  then begin
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

procedure TMonster.Run; //004A9020
var
  nX,nY:Integer;
begin
  if not m_boFixedHideMode and not m_boStoneMode and CanMove then begin
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
            SpaceMoveEX(m_Master.m_PEnvir.sMapName, m_nTargetX, m_nTargetY, 1,m_Master.m_PEnvir.Flag.nGuildTerritory);
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
      if (m_nTargetX <> -1) and ((m_boApproach) or (m_Master <> nil)) then begin
         GotoTargetXY(); //004A93B5 0FFEF
      end else begin
        if m_TargetCret = nil then Wondering();// FFEE   //Jacky
      end; //004A93D8
    end;
  end; //004A93D8

  inherited;

end;

{ TChickenDeer }

constructor TChickenDeer.Create;//004A93E8
begin
  inherited;
  m_nViewRange:=5;
end;

destructor TChickenDeer.Destroy;
begin 
  inherited;
end;

procedure TChickenDeer.Run;//004A9438
var
  I:Integer;
  n10,nC,nDir:Integer;
  BaseObject1C,BaseObject:TBaseObject;
begin
  n10:=9999;
  BaseObject:=nil;
  BaseObject1C:=nil;
  if not bo554 and CanMove then begin
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            nC:=abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
            if nC < n10 then begin
              n10:=nC;
              BaseObject1C:=BaseObject;
            end;
          end;
        end;
      end;    // for
      if BaseObject1C <> nil then begin
        m_boRunAwayMode:=True;
        m_TargetCret:=BaseObject1C;
      end else begin
        m_boRunAwayMode:=False;
        m_TargetCret:=nil;
      end;
    end;//
    if m_boRunAwayMode and
      (m_TargetCret <> nil) and
      (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 6) and (abs(m_nCurrX - BaseObject.m_nCurrX) <= 6) then begin
        nDir:=GetNextDirection(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,m_nCurrX,m_nCurrY); //25/07 Damian
        m_PEnvir.GetNextPosition(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY,nDir,5,m_nTargetX,m_nTargetY);
      end;
    end;
  end;
  inherited;

end;

{ TATMonster }

constructor TATMonster.Create; //004A9690
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TATMonster.Destroy;
begin

  inherited;
end;

procedure TATMonster.Run;//004A9720
begin
  if not bo554 and CanMove then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
  end;
  inherited;
end;

{ TSlowATMonster }

constructor TSlowATMonster.Create;//004A97AC
begin
  inherited;
end;

destructor TSlowATMonster.Destroy;
begin

  inherited;
end;

{ TScorpion }

constructor TScorpion.Create;//004A97F0
begin
  inherited;
  m_boAnimal:=True;
end;

destructor TScorpion.Destroy;
begin

  inherited;
end;

{ TSpitSpider }
constructor TSpitSpider.Create;//004A983C
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_boAnimal:=True;
  m_boUsePoison:=True;
end;

destructor TSpitSpider.Destroy;
begin

  inherited;
end;

procedure TSpitSpider.SpitAttack(btDir:Byte); //004A98AC
var
  WAbil:pTAbility;
  i,k,nX,nY,nDamage:Integer;
  BaseObject:TBaseObject;
begin
  m_btDirection:=btDir;
  WAbil:=@m_WAbil;
  nDamage:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) +1) + LoWord(WAbil.DC));
  if nDamage <= 0 then exit;
  SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');

  for i:=0 to 4 do begin
		for k:=0 to 4 do begin
			if (g_Config.SpitMap[btDir,i,k] = 1) then begin
				nX := m_nCurrX - 2 + k;
				nY := m_nCurrY - 2 + i;

        BaseObject:=m_PEnvir.GetMovingObject(nX,nY,True);
        if (BaseObject <> nil) and
           (BaseObject <> Self) and
           (IsProperTarget(BaseObject)) and
           (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
          nDamage:=BaseObject.GetMagStruckDamage(Self,nDamage);
          if nDamage > 0 then begin
            BaseObject.StruckDamage(nDamage);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,nDamage,m_WAbil.HP,m_WAbil.MaxHP,Integer(Self),'',300);
            if m_boUsePoison then begin
              if (Random(m_btAntiPoison + 20) = 0) then
                BaseObject.MakePosion(POISON_DECHEALTH,30,1);
              //if Random(2) = 0 then
              //  BaseObject.MakePosion(POISON_STONE,5,1);
            end;
          end;
        end;
      end;
    end;
  end;
end;
function TSpitSpider.AttackTarget: Boolean;
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret = nil then exit;
  if TargetInSpitRange(m_TargetCret,btDir) then begin
    if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
      m_dwHitTick:=GetCurrentTime;
      m_dwTargetFocusTick:=GetTickCount();
      SpitAttack(btDir);
      BreakHolySeizeMode();
    end;
    Result:=True;
    exit;
  end;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    SetTargetXY(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
  end else begin
    DelTargetCreat();
  end;

end;

{ THighRiskSpider }

constructor THighRiskSpider.Create;//004A9B64
begin
  inherited;
  m_boAnimal:=False;
  m_boUsePoison:=False;
end;

destructor THighRiskSpider.Destroy;
begin

  inherited;
end;

{ TDoubleCriticalMonster }

constructor TDoubleCriticalMonster.Create;
begin
  inherited;
  m_n7A0:=0;
end;

destructor TDoubleCriticalMonster.Destroy;
begin

  inherited;
end;

procedure TDoubleCriticalMonster.Run;
begin

  inherited;
end;

procedure TDoubleCriticalMonster.Attack(Target:TBaseObject; nDir:Integer);
var
  WAbil:pTAbility;
  nPower:Integer;
  n18:Integer;
begin
  WAbil:=@m_WAbil;
  nPower:=GetAttackPower(LoWord(WAbil.DC),SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  Inc(m_n7A0);
  if (m_n7A0 > 5) or (Random(10) = 0) then begin
    m_n7A0 := 0;
{CODE:0050AEE6                 fild    [ebp+nPower]
CODE:0050AEE9                 mov     eax, [ebp+WAbil]
CODE:0050AEEC                 movzx   eax, word ptr [eax+4Ah]
CODE:0050AEF0                 mov     [ebp+var_18], eax
CODE:0050AEF3                 fild    [ebp+var_18]
CODE:0050AEF6                 fdiv    10
CODE:0050AEFC                 fmulp   st(1), st
CODE:0050AEFE                 call    @@ROUND
CODE:0050AF03                 mov     [ebp+nPower], eax
CODE:0050AF06                 mov     cl, [ebp+var_9]
CODE:0050AF09                 mov     edx, [ebp+nPower]
CODE:0050AF0C                 mov     eax, [ebp+WAbil]}
    Run;
  end else
    HitMagAttackTarget(Target,0,nPower,True);
end;

{function TDoubleCriticalMonster.AttackTarget: Boolean;
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret = nil then exit;
  if TargetInSpitRange(m_TargetCret,btDir) then begin
    if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
      m_dwHitTick:=GetCurrentTime;
      m_dwTargetFocusTick:=GetTickCount();
      DoubleAttack(btDir);
      BreakHolySeizeMode();
    end;
    Result:=True;
    exit;
  end;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    SetTargetXY(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
  end else begin
    DelTargetCreat();
  end;

end;

procedure TDoubleCriticalMonster.DoubleAttack(btDir:Byte);
var
  WAbil:pTAbility;
  i,k,nX,nY,nDamage:Integer;
  BaseObject:TBaseObject;
begin
  m_btDirection:=btDir;
  WAbil:=@m_WAbil;
  nDamage:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) +1) + LoWord(WAbil.DC));
  if nDamage <= 0 then exit;
  SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');

  for i:=0 to 4 do begin
		for k:=0 to 4 do begin
			if (g_Config.SpitMap[btDir,i,k] = 1) then begin
				nX := m_nCurrX - 2 + k;
				nY := m_nCurrY - 2 + i;

        BaseObject:=m_PEnvir.GetMovingObject(nX,nY,True);
        if (BaseObject <> nil) and
           (BaseObject <> Self) and
           (IsProperTarget(BaseObject)) and
           (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
          nDamage:=BaseObject.GetHitStruckDamage(Self,nDamage);
          if nDamage > 0 then begin
            BaseObject.StruckDamage(nDamage);
            BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,nDamage,m_WAbil.HP,m_WAbil.MaxHP,Integer(Self),'',300);
          end;
        end;
      end;

    end;
  end;
end;}

{ TBigPoisionSpider }

constructor TBigPoisionSpider.Create;//004A9BBC
begin
  inherited;
  m_boAnimal:=False;
  m_boUsePoison:=True;
end;

destructor TBigPoisionSpider.Destroy;
begin

  inherited;
end;

{ TGasAttackMonster }

constructor TGasAttackMonster.Create; //004A9C14
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_boAnimal:=True;
end;

destructor TGasAttackMonster.Destroy;
begin

  inherited;
end;

function TGasAttackMonster.sub_4A9C78(bt05: Byte):TBaseObject;
var
  WAbil:pTAbility;
  n10:integer;
  BaseObject:TBaseObject;
begin
  Result:=nil;
  m_btDirection:=bt05;
  WAbil:=@m_WAbil;
  n10:=Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC);
  if n10 > 0 then begin
    SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    BaseObject:=GetPoseCreate();
    if (BaseObject <> nil) and
       IsProperTarget(BaseObject) and
       (Random(BaseObject.m_btSpeedPoint) < m_btHitPoint) then begin
      n10:=BaseObject.GetMagStruckDamage(Self,n10);
      if n10 > 0 then begin
        BaseObject.StruckDamage(n10);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,n10,BaseObject.m_WAbil.HP,BaseObject.m_WAbil.MaxHP,Integer(Self),'',300);
        if Random(BaseObject.m_btAntiPoison + 20) = 0 then begin
          BaseObject.MakePosion(POISON_STONE,5,0)
        end;
        Result:=BaseObject;
      end;
    end;
  end;

end;

function TGasAttackMonster.AttackTarget():Boolean;//004A9DD4
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret = nil then exit;
  if GetAttackDir(m_TargetCret,btDir) then begin
    if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
      m_dwHitTick:=GetCurrentTime;
      m_dwTargetFocusTick:=GetTickCount();
      sub_4A9C78(btDir);
      BreakHolySeizeMode();
    end;
    Result:=True;
  end else begin
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      SetTargetXY(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
    end else begin
      DelTargetCreat();
    end;
  end;
end;

{ TCowMonster }

constructor TCowMonster.Create;//004A9EB4
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TCowMonster.Destroy;
begin

  inherited;
end;

{ TMagCowMonster }

constructor TMagCowMonster.Create;//004A9F10
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TMagCowMonster.Destroy;
begin

  inherited;
end;
procedure TMagCowMonster.sub_4A9F6C(btDir: Byte);
var
  WAbil:pTAbility;
  n10:integer;
  BaseObject:TBaseObject;
begin
  m_btDirection:=btDir;
  WAbil:=@m_WAbil;
  n10:=Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC);
  if n10 > 0 then begin
    SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    BaseObject:=GetPoseCreate();
    if (BaseObject <> nil) and
       IsProperTarget(BaseObject) and
       (m_nAntiMagic >= 0) then begin
      n10:=BaseObject.GetMagStruckDamage(Self,n10);
      if n10 > 0 then begin
        BaseObject.StruckDamage(n10);
        BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,n10,BaseObject.m_WAbil.HP,BaseObject.m_WAbil.MaxHP,Integer(Self),'',300);
      end;
    end;
  end;   

end;

function TMagCowMonster.AttackTarget: Boolean;//004AA084
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret = nil then exit;
  if GetAttackDir(m_TargetCret,btDir) then begin
    if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
      m_dwHitTick:=GetCurrentTime;
      m_dwTargetFocusTick:=GetTickCount();
      sub_4A9F6C(btDir);
      BreakHolySeizeMode();
    end;
    Result:=True;
  end else begin
    if m_TargetCret.m_PEnvir = m_PEnvir then begin
      SetTargetXY(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
    end else begin
      DelTargetCreat();
    end;
  end;
end;

{ TCowKingMonster }



constructor TCowKingMonster.Create;//004AA160
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 500;
  dw558:=GetTickCount();
  bo2BF:=True;
  n560:=0;
  bo55C:=False;
  bo55D:=False;
end;

destructor TCowKingMonster.Destroy;
begin

  inherited;
end;
procedure TCowKingMonster.Attack(TargeTBaseObject: TBaseObject; nDir: Integer); //004AA1F0
var
  WAbil:pTAbility;
  nPower:integer;
begin
  WAbil:=@m_WAbil;
  nPower:=GetAttackPower(LoWord(WAbil.DC),SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject,nPower div 2,nPower div 2,True);
//  inherited;

end;
procedure TCowKingMonster.Initialize;
begin
  dw56C:=m_nNextHitTime;
  dw570:=m_nWalkSpeed;
  inherited;

end;
procedure TCowKingMonster.Run;//004AA294
var
  n8,nC,n10:Integer;
begin
  if (not m_boDeath) and
     (not bo554) and
     (not m_boGhost) and
     ((GetTickCount - dw558) > 30 * 1000) then begin

    dw558:=GetTickCount();
    if (m_TargetCret <> nil) and (sub_4C3538 >= 5) then begin
      m_TargetCret.GetBackPosition(n8,nC);
      if m_PEnvir.CanWalk(n8,nC,False) then begin
        SpaceMove(m_PEnvir.sMapName,n8,nC,0);
        exit;
      end;
      MapRandomMove(m_PEnvir.sMapName,0);
      exit;
    end;
    n10:=n560;

    n560:=7 - m_WAbil.HP div (m_WAbil.MaxHP div 7);
    if (n560 >= 2) and (n560 <> n10) then begin
      bo55C:=True;
      dw564:=GetTickCount();
    end;
    if bo55C then begin
      if (GetTickCount - dw564) < 8000 then begin
        m_nNextHitTime:=10000;
      end else begin
        bo55C:=False;
        bo55D:=True;
        dw568:=GetTickCount();
      end;
    end;//004AA43D
    if bo55D then begin
      if (GetTickCount - dw568) < 8000 then begin
        m_nNextHitTime:=500;
        m_nWalkSpeed:=400;
      end else begin
        bo55D:=False;
        m_nNextHitTime:=dw56C;
        m_nWalkSpeed:=dw570;
      end;
    end;
  end;
  inherited;
end;

{ TLightingZombi }

constructor TLightingZombi.Create;//004AA4B4
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
end;

destructor TLightingZombi.Destroy;
begin

  inherited;
end;
procedure TLightingZombi.LightingAttack(nDir:Integer);
var
  nSX,nSY,nTX,nTY,nPwr:Integer;
  WAbil:pTAbility;
begin
  m_btDirection:=nDir;
  SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
  if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,nDir,1,nSX,nSY) then begin
    m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,nDir,9,nTX,nTY);
    WAbil:=@m_WAbil;
    nPwr:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    MagPassThroughMagic(nSX,nSY,nTX,nTY,nDir,nPwr,True);
    BreakHolySeizeMode();
  end;
end;
procedure TLightingZombi.Run;//004AA604
var
  nAttackDir:Integer;
begin
  if (not bo554) and CanMove and ((GetTickCount - m_dwSearchEnemyTick) > 8000) then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) and
       (m_TargetCret <> nil) and
       (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 4) and
       (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 4) then begin
      if (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 2) and
         (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 2) and
         (Random(3) <> 0)then begin
        inherited;
        exit;
      end;
      GetBackPosition(m_nTargetX,m_nTargetY);
    end;
    if (m_TargetCret <> nil) and
       (abs(m_nCurrX - m_TargetCret.m_nCurrX) < 6) and
       (abs(m_nCurrY - m_TargetCret.m_nCurrY) < 6) and
       (GetCurrentTime - m_dwHitTick > GetHitSpeed) then begin

      m_dwHitTick:=GetCurrentTime;
      nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
      LightingAttack(nAttackDir);
    end;
  end;
  inherited;
end;

{ TDigOutZombi }

constructor TDigOutZombi.Create;//004AA848
begin
  inherited;
  bo554:=False;
  m_nViewRange:=7;
  m_dwSearchTime:=Random(1500) + 2500;
  m_dwSearchTick:=GetTickCount();
  m_boFixedHideMode:=True;
end;

destructor TDigOutZombi.Destroy;
begin

  inherited;
end;

procedure TDigOutZombi.sub_4AA8DC;
var
  Event:TEvent;
begin
  Event:=TEvent.Create(m_PEnvir,m_nCurrX,m_nCurrY,1,5 * 60 * 1000,True);
  g_EventManager.AddEvent(Event);
  m_boFixedHideMode:=False;
  SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,Integer(Event),'');
end;
procedure TDigOutZombi.Run;//004AA95C
var
  I: Integer;
  BaseObject:TBaseObject;
begin
  if CanMove and (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin

    if m_boFixedHideMode then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 3) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 3) then begin
              sub_4AA8DC();
              m_dwWalkTick:=GetCurrentTime + 1000;
              break;
            end;
          end;
        end;
      end;    // for
    end else begin //004AB0C7
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
         (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick:=GetTickCount();
        SearchTarget();
      end;
    end;       
  end;
  inherited;
end;


{ TZilKinZombi }

constructor TZilKinZombi.Create;
begin
  inherited;
  m_nViewRange:=6;
  m_dwSearchTime:=Random(1500) + 2500;
  m_dwSearchTick:=GetTickCount();
  nZilKillCount:=0;
  if Random(3) = 0 then begin
    nZilKillCount:=Random(3) + 1;
  end;
end;

destructor TZilKinZombi.Destroy;
begin
  inherited;


end;

procedure TZilKinZombi.Die;
begin
  inherited;
  if nZilKillCount > 0 then begin
    dw558:=GetTickCount();
    dw560:=(Random(20) + 4) * 1000;
  end;
  Dec(nZilKillCount);
end;

procedure TZilKinZombi.Run;//004AABE4
begin
  if m_boDeath and (not m_boGhost) and (nZilKillCount >= 0) and
    (m_wStatusTimeArr[POISON_STONE] = 0) and
    (m_wStatusTimeArr[POISON_FREEZE] = 0) and
    (m_wStatusTimeArr[POISON_STUN] = 0) and
    (m_wStatusTimeArr[POISON_DONTMOVE] = 0) and 
    (m_VisibleActors.Count > 0) and
    ((GetTickCount - dw558) >= dw560) then begin
    m_Abil.MaxHP:=m_Abil.MaxHP shr 1;
    m_dwFightExp:=m_dwFightExp div 2;
    m_Abil.HP:=m_Abil.MaxHP;
    m_WAbil.HP:=m_Abil.MaxHP;
    ReAlive();
    m_dwWalkTick:=GetCurrentTime + 1000
  end;
  inherited;
end;

{ TWhiteSkeleton }

constructor TWhiteSkeleton.Create;
begin
  inherited;
  m_boIsFirst:=True;
  m_boFixedHideMode:=True;
  m_btRaceServer:=100;
  m_nViewRange:=6;
end;

destructor TWhiteSkeleton.Destroy;
begin

  inherited;
end;

procedure TWhiteSkeleton.RecalcAbilitys;
begin
  inherited;
end;
procedure TWhiteSkeleton.Run;
begin
  if m_boIsFirst then begin
    m_boIsFirst:=False;
    m_btDirection:=5;
    m_boFixedHideMode:=False;
    SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    Reset;
  end;
  inherited;
end;

procedure TWhiteSkeleton.Reset;
begin
  m_nNextHitTime:=3000 - m_btSlaveMakeLevel * 600;
  m_nWalkSpeed:=1200 - m_btSlaveMakeLevel * 250;
  m_dwWalkTick:=GetCurrentTime + 2000;
end;

{ TScultureMonster }

constructor TScultureMonster.Create;//004AAE20
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_nViewRange:=7;
  m_boStoneMode:=True;
  m_nCharStatusEx:=STATE_STONE_MODE;
end;

destructor TScultureMonster.Destroy;
begin

  inherited;
end;
procedure TScultureMonster.MeltStone;
begin
  m_nCharStatusEx:=0;
  m_nCharStatus:=GetCharStatus();
  SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  m_boStoneMode:=False;
end;
procedure TScultureMonster.MeltStoneAll;
var
  I: Integer;
  List10:TList;
  BaseObject:TBaseObject;
begin
  MeltStone();
  List10:=TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,7,List10);
  for I := 0 to List10.Count - 1 do begin
    BaseObject:=TBaseObject(List10.Items[I]);
    if BaseObject.m_boStoneMode then begin
      if BaseObject is TScultureMonster then begin
        TScultureMonster(BaseObject).MeltStone
      end;
    end;
  end;    // for
  List10.Free;
end;

procedure TScultureMonster.Run;//004AAF98
var
  I: Integer;
  BaseObject:TBaseObject;
begin
  if CanMove and
     (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin

    if m_boStoneMode then begin
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 2) then begin
              MeltStoneAll();
              break;
            end;
          end;
        end;
      end;    // for
    end else begin //004AB0C7
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
         (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick:=GetTickCount();
        SearchTarget();
      end;
    end;
  end;
  inherited;
end;

{ TScultureKingMonster }

constructor TScultureKingMonster.Create;//004AB120
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_nViewRange:=8;
  m_boStoneMode:=True;
  m_nCharStatusEx:=STATE_STONE_MODE;
  m_btDirection:=5;
  m_nDangerLevel:=5;
  m_SlaveObjectList:=TList.Create;
end;

destructor TScultureKingMonster.Destroy;//004AB1C8
begin
  m_SlaveObjectList.Free;
  inherited;
end;
procedure TScultureKingMonster.MeltStone; //004AB208
var
  Event:TEvent;
begin
  m_nCharStatusEx:=0;
  m_nCharStatus:=GetCharStatus();
  SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  m_boStoneMode:=False;
  Event:=TEvent.Create(m_PEnvir,m_nCurrX,m_nCurrY,6,5 * 60 * 1000,True);
  g_EventManager.AddEvent(Event);
end;
procedure TScultureKingMonster.CallSlave; //004AB29C
var
  I: Integer;
  nCount:Integer;
  nX,nY:Integer;
  //sMonName:array[0..3] of String;
  BaseObject:TBaseObject;
begin
  nCount:=Random(6) + 6;
  GetFrontPosition(nX,nY);
  {
  sMonName[0]:=sZuma1;
  sMonName[1]:=sZuma2;
  sMonName[2]:=sZuma3;
  sMonName[3]:=sZuma4;
  }
  for I := 1 to nCount do begin
    if m_SlaveObjectList.Count >= 30 then break;
    BaseObject:=UserEngine.RegenMonsterByName(m_sMapName,nX,nY,g_Config.sZuma[Random(4)]);
    if BaseObject <> nil then begin
      //BaseObject.m_Master:=Self;
      //BaseObject.m_dwMasterRoyaltyTick:=GetTickCount + 24 * 60 * 60 * 1000;
      m_SlaveObjectList.Add(BaseObject);
    end;
  end;    // for
end;
procedure TScultureKingMonster.Attack(TargeTBaseObject: TBaseObject;nDir: Integer);//004AB3E8
var
  WAbil:pTAbility;
  nPower:Integer;
begin
  WAbil:=@m_WAbil;
  nPower:=GetAttackPower(LoWord(WAbil.DC),SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)));
  HitMagAttackTarget(TargeTBaseObject,0,nPower,True);
end;
procedure TScultureKingMonster.Run;//004AB444
var
  I: Integer;
  BaseObject:TBaseObject;
begin
  if CanMove and
     (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin

    if m_boStoneMode then begin
      //MeltStone();//
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          if not BaseObject.m_boHideMode or m_boCoolEye then begin
            if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 2) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 2) then begin
              MeltStone();
              break;
            end;
          end;
        end;
      end;    // for
    end else begin
      if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
         (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
        m_dwSearchEnemyTick:=GetTickCount();
        SearchTarget();
        //CallSlave(); //
        if (m_nDangerLevel > m_WAbil.HP / m_WAbil.MaxHP * 5) and (m_nDangerLevel > 0) then begin
          Dec(m_nDangerLevel);
          CallSlave();
        end;
        if m_WAbil.HP = m_WAbil.MaxHP then
          m_nDangerLevel:=5;
      end;
    end;
    for I := m_SlaveObjectList.Count - 1 downto 0 do begin
      BaseObject:=TBaseObject(m_SlaveObjectList.Items[I]);
      if BaseObject.m_boDeath or BaseObject.m_boGhost then
        m_SlaveObjectList.Delete(I);
    end;    // for
  end;
  inherited;
end;
{ TGasMothMonster }

constructor TGasMothMonster.Create;//004AB6B8
begin
  inherited;
  m_nViewRange:=7;
end;

destructor TGasMothMonster.Destroy;
begin

  inherited;
end;

function TGasMothMonster.sub_4A9C78(bt05: Byte): TBaseObject;//004AB708
var
  BaseObject:TBaseObject;
begin
  BaseObject:=inherited sub_4A9C78(bt05);
  if (BaseObject <> nil) and (Random(3) = 0) and (BaseObject.m_boHideMode) then begin
    BaseObject.m_wStatusTimeArr[STATE_TRANSPARENT{8 0x70}]:=1;
  end;
  Result:=BaseObject;
end;
procedure TGasMothMonster.Run;//004AB758
begin
  if (not bo554) and CanMove and
     (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      sub_4C959C();
    end;
  end;
  inherited;
end;
{ TGasDungMonster }

constructor TGasDungMonster.Create;//004AB7F4
begin
  inherited;
  m_nViewRange:=7;
end;

destructor TGasDungMonster.Destroy;
begin

  inherited;
end;





{ TElfMonster }

procedure TElfMonster.AppearNow;//004AB908
begin
   boIsFirst := FALSE;
   m_boFixedHideMode := FALSE;
   RecalcAbilitys;
   m_dwWalkTick := m_dwWalkTick + 800;
end;

constructor TElfMonster.Create;
begin
  inherited;
  m_nViewRange:=6;
  m_boFixedHideMode:=True;
  m_boNoAttackMode:=True;
  boIsFirst:=True;
end;

destructor TElfMonster.Destroy;
begin

  inherited;
end;

procedure TElfMonster.RecalcAbilitys;
begin
  inherited;
  ResetElfMon();
end;

procedure TElfMonster.ResetElfMon();
begin
  m_nWalkSpeed:=500 - m_btSlaveMakeLevel * 50;
  m_dwWalkTick:=GetCurrentTime + 2000;
end;

procedure TElfMonster.Run;
var
  boChangeFace:Boolean;
  ElfMon:TBaseObject;
begin
  if boIsFirst then begin
    boIsFirst:=False;
    m_boFixedHideMode:=False;
    SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    ResetElfMon();
  end;
  if m_boDeath then begin
    if (GetTickCount - m_dwDeathTick > 2 * 1000) then begin
       MakeGhost();
    end;
  end else begin
    boChangeFace:=False;
    if m_TargetCret <> nil then boChangeFace:=True;
    if (m_Master <> nil) and ((m_Master.m_TargetCret <> nil) or (m_Master.m_LastHiter <> nil)) then
      boChangeFace:=True;
    if boChangeFace then begin
      ElfMon:=MakeClone(g_Config.sDragon1,Self);
      if ElfMon <> nil then begin
        ElfMon.m_boAutoChangeColor:=m_boAutoChangeColor;
        if ElfMon is TElfWarriorMonster then TElfWarriorMonster(ElfMon).AppearNow;
        m_Master:=nil;
        KickException();
      end;
    end;
  end;
  inherited;
end;
{ TElfWarriorMonster }
procedure TElfWarriorMonster.AppearNow; //004ABB60
begin
   boIsFirst := FALSE;
   m_boFixedHideMode := FALSE;
   SendRefMsg (RM_DIGUP, m_btDirection, m_nCurrX, m_nCurrY, 0, '');
   RecalcAbilitys;
   m_dwWalkTick := m_dwWalkTick + 800; //º¯½ÅÈÄ ¾à°£ µô·¹ÀÌ ÀÖÀ½
   dwDigDownTick:=GetTickCount();
end;

constructor TElfWarriorMonster.Create;
begin
  inherited;
  m_nViewRange:=6;
  m_boFixedHideMode:=True;
  boIsFirst:=True;
  m_boUsePoison:=False;
end;

destructor TElfWarriorMonster.Destroy;
begin

  inherited;
end;
//004ABB08
procedure TElfWarriorMonster.RecalcAbilitys; //004ABAEC
begin
  inherited;
  ResetElfMon();
end;

procedure TElfWarriorMonster.ResetElfMon();
begin
  m_nNextHitTime:=1500 - m_btSlaveMakeLevel * 100;
  m_nWalkSpeed:=500 - m_btSlaveMakeLevel * 50;
  m_dwWalkTick:=GetCurrentTime + 2000;
end;

procedure TElfWarriorMonster.Run; //004ABBD0
var
  boChangeFace:Boolean;
  ElfMon:TBaseObject;
  ElfName:String;
begin
  ElfMon:=nil;
  if boIsFirst then begin
    boIsFirst:=False;
    m_boFixedHideMode:=False;
    SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    ResetElfMon();
  end;//004ABC27
  if m_boDeath then begin
    if (GetTickCount - m_dwDeathTick > 2 * 1000) then begin
       MakeGhost();
    end;
  end else begin
    boChangeFace:=True;
    if m_TargetCret <> nil then boChangeFace:=False;
    if (m_Master <> nil) and ((m_Master.m_TargetCret <> nil) or (m_Master.m_LastHiter <> nil)) then
      boChangeFace:=False;
    if boChangeFace then begin
      if (GetTickCount - dwDigDownTick) > 6 * 10 * 1000 then begin
      //if (GetTickCount - dwDigDownTick) > 10 * 1000 then begin
        //ElfMon:=MakeClone(sDogz,Self);

        ElfName:=m_sCharName;
        if ElfName[length(ElfName)] = '1' then begin
          ElfName:=Copy(ElfName,1,length(ElfName) -1);
          ElfMon:=MakeClone(ElfName,Self);
        end;
        if ElfMon <> nil then begin
          SendRefMsg(RM_DIGDOWN, m_btDirection,m_nCurrX,m_nCurrY,0,'');
          SendRefMsg(RM_CHANGEFACE,0,Integer(Self),Integer(ElfMon),0,'');
          ElfMon.m_boAutoChangeColor:=m_boAutoChangeColor;
          if ElfMon is TElfMonster then
            TElfMonster(ElfMon).AppearNow;
          m_Master:=nil;
          KickException();
        end;
      end;
    end else begin
      dwDigDownTick:=GetTickCount();
    end;
  end;
  inherited;
end;


{ TElectronicScolpionMon }

constructor TElectronicScolpionMon.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_boUseMagic:=False;
  m_boApproach:=FALSE;
end;

destructor TElectronicScolpionMon.Destroy;
begin

  inherited;
end;

function TElectronicScolpionMon.MagCanHitTarget(nX, nY:Integer;
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

procedure TElectronicScolpionMon.LightingAttack(nDir: Integer);
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

procedure TElectronicScolpionMon.Run;
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
              LightingAttack(nAttackDir);
            end;
          end;
        end;
      end;
    end;
  end;
  inherited Run;
end;


constructor TCrystalSpider.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_boUseMagic:=False;
end;

destructor TCrystalSpider.Destroy;
begin
  inherited;
end;

function TCrystalSpider.AttackTarget():Boolean; //004A8F34
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
        if (Random(m_TargetCret.m_btAntiPoison + 20) = 0) then
          m_TargetCret.MakePosion(POISON_DECHEALTH,30,1);
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


{ TDDevilMon }

constructor TDDevil.Create;
begin
  inherited;
  m_dwSearchTime:=Random(1500) + 1500;
  m_boUseMagic:=False;
  m_dwSpellTick:=GetTickCount();
end;

destructor TDDevil.Destroy;
begin

  inherited;
end;


procedure TDDevil.LightingAttack(nDir: Integer);
var
  WAbil:pTAbility;
  nSX,nSY,nTX,nTY,nPwr:Integer;

begin
  m_btDirection:=nDir;
  if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,nDir,1,nSX,nSY) then begin
    m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,nDir,2,nTX,nTY);
    WAbil:=@m_WAbil;
    nPwr:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) + 1) + LoWord(WAbil.DC));
    MagPassThroughMagic(nSX,nSY,nTX,nTY,nDir,nPwr,True);
  end;
  SendRefMsg(RM_LIGHTING,1,m_nCurrX,m_nCurrY,Integer(m_TargetCret),'');
end;

procedure TDDevil.Run;
var
  nAttackDir:Integer;
  nX,nY:Integer;
begin
  if (not bo554) and CanMove then begin

    if ((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
    end;
    if m_TargetCret <> nil then begin
      nX:=abs(m_nCurrX - m_TargetCret.m_nCurrX);
      nY:=abs(m_nCurrY - m_TargetCret.m_nCurrY);
      if (nX <= 2) and (nY <= 2) then begin
      //if m_boUseMagic or ((nX = 2) or (nY = 2)) then begin
        if (Integer(GetTickCount - m_dwSpellTick) > (m_nNextHitTime * 4)) then begin
          m_dwSpellTick:=GetTickCount();
          nAttackDir:=GetNextDirection(m_nCurrX,m_nCurrY,m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY);
          LightingAttack(nAttackDir);
        end;
      end;
    end;
  end;
  inherited Run;
end;


constructor TRedThunderZuma.Create;//004AAE20
begin

  m_dwSearchTime:=Random(1500) + 1500;
  m_boStoneMode:=True;
  m_nCharStatusEx:=STATE_STONE_MODE;
  m_nViewRange:=12;
  m_dwSpellTick:=GetTickCount();
  inherited;
end;

destructor TRedThunderZuma.Destroy;
begin
  inherited;
end;


procedure TRedThunderZuma.Run;//004AAF98
begin
  if (not bo554) and CanMove then begin
    if m_TargetCret <> nil then begin
      if (Integer(GetTickCount - m_dwSpellTick) > 2500) then begin
        m_dwSpellTick:=GetTickCount();
        MagicAttack();
      end;
    end;
  end;
  inherited;
end;

procedure TRedThunderZuma.MagicAttack();
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

{ TStoneMonster }

constructor TStoneMonster.Create;
begin
  inherited;
  m_nViewRange   := 6;
  m_boStickMode  := True;
end;

destructor TStoneMonster.Destroy;
begin

  inherited;
end;

procedure TStoneMonster.Run;
var
  i, x, y:     integer;
  nStartX, nStartY, nEndX, nEndY: integer;
  boRecalc:Boolean;
  BaseObject: TBaseObject;
  xList:TList;
begin
  if (not m_boGhost) and (not m_boDeath) then begin
    if GetCurrentTime - m_dwWalkTick > 5000 then begin
      m_dwWalkTick := GetCurrentTime;

      nStartX := _MAX(0, m_nCurrX-3);
      nEndX := _MIN(m_PEnvir.Header.wWidth, m_nCurrX+3);
      nStartY := _MAX(0, m_nCurrY-3);
      nEndY := _MIN(m_PEnvir.Header.wHeight, m_nCurrY+3);

      xList:=TList.Create;
      for x := nStartX to nEndX do begin
        for y := nStartY to nEndY do begin

          m_PEnvir.GetBaseObjects(x, y, True, xList);
          for i := 0 to xList.Count - 1 do begin
            BaseObject := TBaseObject(xList.Items[i]);
            boRecalc := False;
            if BaseObject<>nil then begin
              if (BaseObject.m_btRaceServer <> RC_PLAYOBJECT) and
                (BaseObject.m_Master = nil) and
                (not BaseObject.m_boGhost) and
                (not BaseObject.m_boDeath) then begin

                if BaseObject.m_btRaceServer = 138{OmaThing :P} then begin
                  if BaseObject.m_wStatusArrValue[0] = 0 then begin
                    boRecalc := True;
                    BaseObject.m_wStatusArrValue[0] := 15;
                    BaseObject.m_dwStatusArrTimeOutTick[0] := GetTickCount + 15100;
                  end;
                end else begin
                  if BaseObject.m_wStatusTimeArr[STATE_DEFENCEUP] = 0 then begin
                    boRecalc := True;
                    BaseObject.m_wStatusTimeArr[STATE_DEFENCEUP] := 8;
                    BaseObject.m_dwStatusArrTick[STATE_DEFENCEUP] := GetTickCount;
                  end;
                  if BaseObject.m_wStatusTimeArr[STATE_MAGDEFENCEUP] = 0 then begin
                    boRecalc := True;
                    BaseObject.m_wStatusTimeArr[STATE_MAGDEFENCEUP] := 8;
                    BaseObject.m_dwStatusArrTick[STATE_MAGDEFENCEUP] := GetTickCount;
                  end;
                end;

                if boRecalc then BaseObject.RecalcAbilitys();
              end;
            end;

            if (Random(6) = 0) and boRecalc then begin
              SendRefMsg(RM_HIT, 0, m_nCurrX, m_nCurrY, 0, '');
            end;
          end;
        end;
      end;
      xList.Free;

      if Random(2) = 0 then begin
        SendRefMsg(RM_TURN, 0, m_nCurrX, m_nCurrY, 0, '');
      end;
    end;
  end;
  inherited;
end;

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: ObjMon.pas 594 2007-03-09 15:00:12Z damian $');
end.
