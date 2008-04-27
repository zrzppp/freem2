unit ObjMon2;

interface
uses
  svn, Windows,Classes,Grobal2,ObjBase, ObjMon, sysutils;
type
  TStickMonster = class(TAnimalObject)
    n54C    :Integer;
    bo550   :Boolean;
    nComeOutValue   :Integer;
    nAttackRange    :Integer;
  private

  public
    constructor Create();override;
    destructor Destroy; override;
    function  AttackTarget():Boolean;virtual;
    function  CheckComeOut:Boolean;virtual;
    procedure ComeOut;virtual;
    procedure ComeDown;virtual;//FFE8
    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;//FFFC
    procedure Run;override;
  end;
  TBeeQueen = class(TAnimalObject)
    n54C      :Integer;
    BBList   :TList;
  private
    procedure MakeChildBee;
  public
    constructor Create();override;
    destructor Destroy; override;
    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;//FFFC
    procedure Run;override;
  end;
  TCentipedeKingMonster = class(TStickMonster)
    m_dwAttickTick    :LongWord; //0x560
  private
    function sub_4A5B0C: Boolean;
  public
    constructor Create();override;
    destructor Destroy; override;
    function  AttackTarget():Boolean;override;
    procedure ComeOut;override;
    procedure Run;override;
  end;
  TBigHeartMonster = class(TAnimalObject)
  private

  public
    constructor Create();override;
    destructor Destroy; override;

    function AttackTarget():Boolean;virtual;
    procedure Run;override;
  end;

  TBamTreeMonster = class(TAnimalObject)
  private
    m_nStruckCount :Integer;  //0x798
    m_nHealth      :Integer;  //0x79C

  public
    constructor Create();override; //0x00504AD8
    destructor Destroy; override;

    procedure Struck(hiter: TBaseObject);override; //0x00504B3C
    procedure Run;override; //0x00504B60
    procedure StruckDamage(nDamage:integer);override;
  end;

  TSpiderHouseMonster = class(TAnimalObject)
    n54C    :Integer;
    BBList  :TList;
  private
    procedure GenBB;
  public
    constructor Create();override;
    destructor Destroy; override;
    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;//FFFC
    procedure Run;override;
  end;
  TExplosionSpider = class(TMonster)
    dw558    :LongWord;
  private
    procedure sub_4A65C4;

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run; override;
    function AttackTarget():Boolean; override; //FFEB
  end;
  TGuardUnit = class(TAnimalObject)
    dw54C              :LongWord;       //0x54C
    m_nX550            :Integer;      //0x550
    m_nY554            :Integer;      //0x554
    m_nDirection       :Integer;      //0x558
  public
    function  IsProperTarget(BaseObject:TBaseObject):boolean; override; //FFF4
    procedure Struck(hiter: TBaseObject);override; //FFEC
  end;
  TArcherGuard = class(TGuardUnit)
  private
    procedure sub_4A6B30(TargeTBaseObject:TBaseObject);

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Run;override;
  end;
  TArcherPolice = class(TArcherGuard)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
  end;
  TCastleDoor = class(TGuardUnit)
    dw55C              :LongWord;      //0x55C
    dw560              :LongWord;      //0x560
    m_boOpened         :Boolean;      //0x564
    bo565n             :Boolean;      //0x565
    bo566n             :Boolean;      //0x566
    bo567n             :Boolean;      //0x567
  private
    procedure SetMapXYFlag(nFlag:Integer);
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Die;override;
    procedure Run;override;
    procedure Initialize();override;
    procedure Close;
    procedure Open;
    procedure RefStatus;
  end;
  TWallStructure = class(TGuardUnit)
    n55C:Integer;
    dw560:LongWord;
    boSetMapFlaged:Boolean;
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Initialize;override;
    procedure Die;override;
    procedure Run;override;
    procedure RefStatus;    
  end;
  TSoccerBall = class(TAnimalObject)
    nMoveCount:Integer;
  private

  public
    constructor Create();override;
    destructor Destroy; override;
    procedure Struck(hiter: TBaseObject);override;
    procedure Run;override;
  end;


  TEvilMir = class(TAnimalObject)
    m_dwSpellTick  :LongWord;
    boSlaves:Boolean;
  private
      procedure FlameCircle(nDir: Integer);
      procedure MassThunder();
      procedure CallSlaves();
  public
    constructor Create();override;
    destructor Destroy; override;
    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;
    procedure Run;override;
    procedure Die; override;
  end;

  TFoxOrbSpirit = class(TAnimalObject)
    m_dwSpellTick  :LongWord;
    boSlaves:Boolean;
  private
      procedure FlameCircle(nDir: Integer);
      procedure MassThunder();
//      procedure CallSlaves();
      procedure FoxYell();
  public
    constructor Create();override;
    destructor Destroy; override;
//    function  Operate(ProcessMsg:pTProcessMessage):Boolean; override;
    procedure Run;override;
//    procedure Die; override;
  end;

  THellGuard = class(TAnimalObject)
  private
    m_dwSpellTick:LongWord;
    procedure RepulseCircle();
  public
    constructor Create();override;
    destructor Destroy; override;

    function AttackTarget():Boolean;virtual;
    procedure Run;override;
  end;

  TGuardianRock = class(TAnimalObject)
  private
  public
    constructor Create();override;
    destructor Destroy; override;
    function AttackTarget():Boolean;virtual;
    procedure Run;override;
  end;

var
  g_DragonSearchPath:Array[0..41,0..1] of Integer = (
  (0, -5), (1, -5), (-1, -4), (0, -4),
  (1, -4), (2, -4), (-2, -3), (-1, -3),
  (0, -3), (1, -3), (2, -3),  (-3, -2),
  (-2, -2),(-1, -3),(0, -2),  (1, -2),
  (2, -2), (-3, -1),(-2, -1), (-1, -1),
  (0, -1), (1, -1), (2, -1),  (-3, 0),
  (-2, 0), (-1, 0), (0, 0),   (1, 0),
  (2, 0),  (3, 0),  (-2, 1),  (-1, 1),
  (0, 1),  (1, 1),  (2, 1),   (3, 1),
  (-1, 2), (0, 2),  (1, 2),   (2, 2),
  (0, 3),  (1, 3)
  );

implementation

uses
  M2Share, HUtil32, Castle, Guild;


{ TStickMonster }
constructor TStickMonster.Create;//004A51C0
begin
  inherited;
  bo550:=False;
  m_nViewRange:=7;
  m_nRunTime:=250;
  m_dwSearchTime:=Random(1500) + 2500;
  m_dwSearchTick:=GetTickCount();
  nComeOutValue:=4;
  nAttackRange:=4;
  m_boFixedHideMode:=True;
  m_boStickMode:=True;
  m_boAnimal:=True;
end;

destructor TStickMonster.Destroy;//004A5290
begin

  inherited;
end;
function TStickMonster.AttackTarget: Boolean;
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret = nil then exit;
  if GetAttackDir(m_TargetCret,btDir) then begin
    if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
      m_dwHitTick:=GetCurrentTime;
      m_dwTargetFocusTick:=GetTickCount();
      Attack(m_TargetCret,btDir);
    end;
    Result:=True;
    exit;
  end;
  if m_TargetCret.m_PEnvir = m_PEnvir then begin
    SetTargetXY(m_TargetCret.m_nCurrX,m_TargetCret.m_nCurrY); {0FFF0h}
  end else begin
    DelTargetCreat();{0FFF1h}
  end;
end;

procedure TStickMonster.ComeOut();
begin
  m_boFixedHideMode:=False;
  SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
end;
procedure TStickMonster.ComeDown();//004A53E4
var
  I:Integer;
ResourceString
  sExceptionMsg = '[Exception] TStickMonster::VisbleActors Dispose';
begin
  SendRefMsg(RM_DIGDOWN,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  try
    for I := 0 to m_VisibleActors.Count - 1 do begin
      Dispose(pTVisibleBaseObject(m_VisibleActors.Items[I]));
    end;
    m_VisibleActors.Clear;
  except
    MainOutMessage(sExceptionMsg);
  end;
  m_boFixedHideMode:=True;
end;
function TStickMonster.CheckComeOut():Boolean;//004A53E4
var
  I:Integer;
  BaseObject:TBaseObject;
begin
  Result := FALSE;
  for I := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if BaseObject.m_boDeath then Continue;
    if IsProperTarget(BaseObject) then begin
      if not BaseObject.m_boHideMode or m_boCoolEye then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) < nComeOutValue) and (abs(m_nCurrY - BaseObject.m_nCurrY) < nComeOutValue) then begin
          Result := TRUE;
          break;
        end;
      end;
    end;
  end;    // for
end;

function TStickMonster.Operate(ProcessMsg: pTProcessMessage):Boolean;
begin
  Result:=inherited Operate(ProcessMsg);
end;

procedure TStickMonster.Run;//004A5614
var
  bo05:Boolean;
begin
  if CanMove then begin
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      if m_boFixedHideMode then begin
        if CheckComeOut() then
          ComeOut();
      end else begin
        if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
          SearchTarget();
        end;
        bo05:=False;
        if m_TargetCret <> nil then begin
          if (abs(m_TargetCret.m_nCurrX - m_nCurrX) > nAttackRange) or
             (abs(m_TargetCret.m_nCurrY - m_nCurrY) > nAttackRange) then begin
            bo05:=True;
          end;
        end else bo05:=True;
        if bo05 then begin
          ComeDown();
        end else begin
          if AttackTarget then begin
            inherited;
            exit;
          end;
        end;
      end;
    end;
  end;
  inherited;
end;



{ TSoccerBall }

constructor TSoccerBall.Create;//004A764C
begin
  inherited;
  m_boAnimal:=False;
  m_boSuperMan:=True;
  nMoveCount:=0;
  m_nTargetX:= -1;
end;

destructor TSoccerBall.Destroy;
begin

  inherited;
end;



procedure TSoccerBall.Run;
var
  nX,nY:Integer;
begin
  if nMoveCount > 0 then begin
    if m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,m_btDirection,1,nX,nY) then begin
      if m_PEnvir.CanWalk(nX,nY,True) then begin
        case m_btDirection of    //
          0: m_btDirection:=4;
          1: m_btDirection:=7;
          2: m_btDirection:=6;
          3: m_btDirection:=5;
          4: m_btDirection:=0;
          5: m_btDirection:=3;
          6: m_btDirection:=2;
          7: m_btDirection:=1;
        end;    // case
        m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,m_btDirection,nMoveCount,nX,nY);
      end;
    end;
  end else begin//004A78A1
    m_nTargetX:= -1;
  end;
  if m_nTargetX <> -1 then begin
    GotoTargetXY();
    if (m_nTargetX = m_nCurrX) and (m_nTargetY = m_nCurrY) then
      nMoveCount:=0;
  end;
  inherited;
end;

procedure TSoccerBall.Struck(hiter: TBaseObject);
begin
  if hiter = nil then exit;
  m_btDirection:=hiter.m_btDirection;
  nMoveCount:=Random(4) + (nMoveCount + 4);
  nMoveCount:=_MIN(20,nMoveCount);
  m_PEnvir.GetNextPosition(m_nCurrX,m_nCurrY,m_btDirection,nMoveCount,m_nTargetX,m_nTargetY);
end;

{ TBeeQueen }

constructor TBeeQueen.Create;//004A5750
begin
  inherited;
  m_nViewRange:=9;
  m_nRunTime:=250;
  m_dwSearchTime:=Random(1500) + 2500;
  m_dwSearchTick:=GetTickCount();
  m_boStickMode:=True;
  BBList:=TList.Create;
end;

destructor TBeeQueen.Destroy;//004A57F0
begin
  BBList.Free;
  inherited;
end;

procedure TBeeQueen.MakeChildBee;
begin
  if BBList.Count >= 15 then exit;
  SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  SendDelayMsg(Self,RM_ZEN_BEE,0,0,0,0,'',500);  
end;

function TBeeQueen.Operate(ProcessMsg:pTProcessMessage):Boolean;
var
  BB:TBaseObject;
begin
  if ProcessMsg.wIdent = RM_ZEN_BEE then begin
    BB:=UserEngine.RegenMonsterByName(m_PEnvir.sMapName,m_nCurrX,m_nCurrY,g_Config.sBee);
    if BB <> nil then begin
      BB.SetTargetCreat(m_TargetCret);
      BBList.Add(BB);
    end;
  end;
  Result:=inherited Operate(ProcessMsg);
end;

procedure TBeeQueen.Run;
var
  I: Integer;
  BB:TBaseObject;
begin
  if CanMove then begin
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
        m_dwHitTick:=GetCurrentTime;
        SearchTarget();
        if m_TargetCret <> nil then MakeChildBee();
      end;
      for I := BBList.Count -1 downto 0 do begin
        BB:=TBaseObject(BBList.Items[I]);
        if BB.m_boDeath or (BB.m_boGhost) then BBList.Delete(I);
      end;
    end;
  end;
  inherited;
end;

{ TCentipedeKingMonster }



constructor TCentipedeKingMonster.Create;//004A5A8C
begin
  inherited;
  m_nViewRange:=6;
  nComeOutValue:=4;
  nAttackRange:=6;
  m_boAnimal:=False;
  m_dwAttickTick:=GetTickCount();
end;

destructor TCentipedeKingMonster.Destroy;
begin

  inherited;
end;
function TCentipedeKingMonster.sub_4A5B0C: Boolean;
var
  I:Integer;
  BaseObject:TBaseObject;
begin
  Result:=False;
  for I := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if BaseObject.m_boDeath then Continue;
    if IsProperTarget(BaseObject) then begin
      if (abs(m_nCurrX - BaseObject.m_nCurrX) <= m_nViewRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= m_nViewRange) then begin
        Result:=True;
        break;
      end;
    end;
  end;
end;

function TCentipedeKingMonster.AttackTarget: Boolean; //004A5BC0
var
  WAbil:pTAbility;
  nPower,I:Integer;
  BaseObject:TBaseObject;
begin
  Result:=False;
  if not sub_4A5B0C then begin
    exit;
  end;
  if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
    m_dwHitTick:=GetCurrentTime;
    SendAttackMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY);
    WAbil:=@m_WAbil;
    nPower:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) +1) + LoWord(WAbil.DC));
    for I := 0 to m_VisibleActors.Count - 1 do begin
      BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
      if BaseObject.m_boDeath then Continue;
      if IsProperTarget(BaseObject) then begin
        if (abs(m_nCurrX - BaseObject.m_nCurrX) <= nAttackRange) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= nAttackRange) then begin
          m_dwTargetFocusTick:=GetTickCount();
          SendDelayMsg(Self,RM_DELAYMAGIC,nPower,MakeLong(BaseObject.m_nCurrX,BaseObject.m_nCurrY),2,Integer(BaseObject),'',600);
          if Random(4) = 0 then begin
            if Random(3) <> 0 then begin
              BaseObject.MakePosion(POISON_DECHEALTH,60,3);
            end else begin
              BaseObject.MakePosion(POISON_STONE,5,0);
            end;
            m_TargetCret:=BaseObject;
          end;
        end;
      end;
    end;    // for
  end;
  Result:=True;
end;

procedure TCentipedeKingMonster.ComeOut;
begin
  inherited;
  m_WAbil.HP:=m_WAbil.MaxHP;
end;

procedure TCentipedeKingMonster.Run;
var
  I:Integer;
  BaseObject:TBaseObject;
begin
  if CanMove then begin
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      if m_boFixedHideMode then begin
        if (GetTickCount - m_dwAttickTick) > 10000 then begin
          for I := 0 to m_VisibleActors.Count - 1 do begin
            BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
            if BaseObject.m_boDeath then Continue;
            if IsProperTarget(BaseObject) then begin
              if not BaseObject.m_boHideMode or m_boCoolEye then begin
                if (abs(m_nCurrX - BaseObject.m_nCurrX) < nComeOutValue) and (abs(m_nCurrY - BaseObject.m_nCurrY) < nComeOutValue) then begin
                  ComeOut();
                  m_dwAttickTick:=GetTickCount();
                  break;
                end;
              end;
            end;
          end;
        end;//004A5F86
      end else begin
        if (GetTickCount - m_dwAttickTick) > 3000 then begin
          if AttackTarget() then begin
            inherited;
            exit;
          end;
          if (GetTickCount - m_dwAttickTick) > 10000 then begin
            ComeDown();
            m_dwAttickTick:=GetTickCount();
          end;
        end;
      end;
    end;
  end;
  inherited;
end;


{ TBigHeartMonster }


constructor TBigHeartMonster.Create;//004A5F94
begin
  inherited;
  m_nViewRange:=16;
  m_boAnimal:=False;
end;

destructor TBigHeartMonster.Destroy;
begin

  inherited;
end;

function TBigHeartMonster.AttackTarget():Boolean; //004A5FEC
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
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,1{type},'');
        end;
      end;
    end;    // for
    Result:=True;
  end;
//  inherited;

end;

procedure TBigHeartMonster.Run;//004A617C
begin
  if CanMove then begin
    if m_VisibleActors.Count > 0 then
      AttackTarget();
  end;
  inherited;
end;

{ TBamTreeMonster }


constructor TBamTreeMonster.Create;
begin
  inherited;
  m_boAnimal:=False;
  m_nStruckCount := 0;
  m_nHealth := 0;
end;

destructor TBamTreeMonster.Destroy;
begin

  inherited;
end;

procedure TBamTreeMonster.Struck(hiter: TBaseObject);
begin
  inherited;
  Inc(m_nStruckCount);
end;

procedure TBamTreeMonster.Run;
begin
  if m_nHealth = 0 then begin
    m_nHealth := m_WAbil.MaxHP;
  end else begin
    m_WAbil.HP:=m_WAbil.MaxHP;
    if m_nStruckCount >= m_nHealth then
      m_WAbil.HP := 0;
  end;

  inherited;
end;

procedure TBamTreeMonster.StruckDamage(nDamage:integer);
begin
  nDamage:=0;
  inherited StruckDamage(nDamage);
end;

{ TSpiderHouseMonster }

constructor TSpiderHouseMonster.Create;//004A61D0
begin
  inherited;
  m_nViewRange:=9;
  m_nRunTime:=250;
  m_dwSearchTime:=Random(1500) + 2500;
  m_dwSearchTick:=0;
  m_boStickMode:=True;
  BBList:=TList.Create;
end;

destructor TSpiderHouseMonster.Destroy;
//004A6270
begin
  BBList.Free;
  inherited;
end;
procedure TSpiderHouseMonster.GenBB;//004A62B0
begin
  if BBList.Count < 15 then begin
    SendRefMsg(RM_HIT,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    SendDelayMsg(Self,RM_ZEN_BEE,0,0,0,0,'',500);
  end;
    
end;
function TSpiderHouseMonster.Operate(ProcessMsg:pTProcessMessage):Boolean;
var
  BB:TBaseObject;
  n08,n0C:Integer;
begin
  if ProcessMsg.wIdent = RM_ZEN_BEE then begin
    n08:=m_nCurrX;
    n0C:=m_nCurrY + 1;
    if m_PEnvir.CanWalk(n08,n0C,True) then begin
      BB:=UserEngine.RegenMonsterByName(m_PEnvir.sMapName,n08,n0C,g_Config.sSpider);
      if BB <> nil then begin
        BB.SetTargetCreat(m_TargetCret);
        BBList.Add(BB);
      end;
    end;
  end;    
  Result:= inherited Operate(ProcessMsg);
end;

procedure TSpiderHouseMonster.Run;
var
  I: Integer;
  BB:TBaseObject;
begin
  if CanMove then begin
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
        m_dwHitTick:=GetCurrentTime;
        SearchTarget();
        if m_TargetCret <> nil then GenBB();
      end;
      for I := BBList.Count -1 downto 0 do begin
        BB:=TBaseObject(BBList.Items[I]);
        if BB.m_boDeath or (BB.m_boGhost) then BBList.Delete(I);
          
      end;    // for
    end;


  end;
  inherited;
end;

{ TExplosionSpider }

constructor TExplosionSpider.Create;
//004A6538
begin
  inherited;
  m_nViewRange:=5;
  m_nRunTime:=250;
  m_dwSearchTime:=Random(1500) + 2500;
  m_dwSearchTick:=0;
  dw558:=GetTickcount();
end;

destructor TExplosionSpider.Destroy;
begin

  inherited;
end;
procedure TExplosionSpider.sub_4A65C4;
var
  WAbil:pTAbility;
  I,nPower,n10:Integer;
  BaseObject:TBaseObject;
begin
  m_WAbil.HP:=0;
  WAbil:=@m_WAbil;
  nPower:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) +1) + LoWord(WAbil.DC));
  for I := 0 to m_VisibleActors.Count - 1 do begin
    BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
    if BaseObject.m_boDeath then Continue;
    if IsProperTarget(BaseObject) then begin
      if (abs(m_nCurrX - BaseObject.m_nCurrX) <= 1) and (abs(m_nCurrY - BaseObject.m_nCurrY) <= 1) then begin
        n10:=0;
        Inc(n10,BaseObject.GetHitStruckDamage(Self,nPower div 2));
        Inc(n10,BaseObject.GetMagStruckDamage(Self,nPower div 2));
        if n10 > 0 then begin
          BaseObject.StruckDamage(n10);
          BaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,n10,BaseObject.m_WAbil.HP,BaseObject.m_WAbil.MaxHP,Integer(Self),'',700);
        end;
      end;
    end;
  end;    // for
end;
function TExplosionSpider.AttackTarget: Boolean;
var
  btDir:Byte;
begin
  Result:=False;
  if m_TargetCret = nil then exit;
  if GetAttackDir(m_TargetCret,btDir) then begin
    if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
      m_dwHitTick:=GetCurrentTime;
      m_dwTargetFocusTick:=GetTickCount();
      sub_4A65C4();
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

procedure TExplosionSpider.Run;
begin
  if not m_boDeath and not m_boGhost then
    if (GetTickCount - dw558) > 60 * 1000 then begin
      dw558:=GetTickcount();
      sub_4A65C4();
    end;
      
  inherited;
end;

{ TGuardUnit }
procedure TGuardUnit.Struck(hiter: TBaseObject);
begin
  inherited;
  if m_Castle <> nil then begin
    bo2B0:=True;
    m_dw2B4Tick:=GetTickCount();
  end;

end;

function TGuardUnit.IsProperTarget(BaseObject: TBaseObject): boolean; //004A6890
begin
  Result:=False;
  if m_Castle <> nil then begin
    if m_LastHiter = BaseObject then Result:=True;
    if BaseObject.bo2B0 then begin
      if (GetTickCount - BaseObject.m_dw2B4Tick) < 2 * 60 * 1000 then begin
        Result:=True;
      end else BaseObject.bo2B0:=False;
      if BaseObject.m_Castle <> nil then begin
        BaseObject.bo2B0:=False;
        Result:=False;
      end;
    end; //004A690D
    if TUserCastle(m_Castle).m_boUnderWar then Result:=True;
    if TUserCastle(m_Castle).m_MasterGuild <> nil then begin
      if BaseObject.m_Master = nil then begin
        if (TUserCastle(m_Castle).m_MasterGuild = BaseObject.m_MyGuild) or
           (TUserCastle(m_Castle).m_MasterGuild.IsAllyGuild(TGuild(BaseObject.m_MyGuild))) then begin
           if m_LastHiter <> BaseObject then Result:=False;
         end;
      end else begin//004A6988
        if (TUserCastle(m_Castle).m_MasterGuild = BaseObject.m_Master.m_MyGuild) or
           (TUserCastle(m_Castle).m_MasterGuild.IsAllyGuild(TGuild(BaseObject.m_Master.m_MyGuild))) then begin
           if (m_LastHiter <> BaseObject.m_Master) and (m_LastHiter <> BaseObject) then Result:=False;
         end;
      end;        
    end; //004A69EF
    if BaseObject.m_boAdminMode or
       BaseObject.m_boStoneMode or
       ((BaseObject.m_btRaceServer >= RC_NPC{10}) and
       (BaseObject.m_btRaceServer < RC_ANIMAL{50})) or
       (BaseObject = Self) or (BaseObject.m_Castle = Self.m_Castle) then begin
      Result:=False;
    end;
    exit;
  end; //004A6A41
  if m_LastHiter = BaseObject then Result:=True;
  if (BaseObject.m_TargetCret <> nil) and (BaseObject.m_TargetCret.m_btRaceServer = 112)then
    Result:=True;
  if BaseObject.PKLevel >= 2 then Result:=True;
  if BaseObject.m_boAdminMode or
     BaseObject.m_boStoneMode or
     (BaseObject = Self) then Result:=False;

end;



{ TArcherGuard }

constructor TArcherGuard.Create;//004A6AB4
begin
  inherited;
  m_nViewRange   := 12;
  m_boWantRefMsg := True;
  m_Castle       := nil;
  m_nDirection   := -1;
end;

destructor TArcherGuard.Destroy;
begin

  inherited;
end;

procedure TArcherGuard.sub_4A6B30(TargeTBaseObject:TBaseObject);//004A6B30
var
  nPower:Integer;
  WAbil:pTAbility;
begin
  m_btDirection:=GetNextDirection(m_nCurrX,m_nCurrY,TargeTBaseObject.m_nCurrX,TargeTBaseObject.m_nCurrY);
  WAbil:=@m_WAbil;
  nPower:=(Random(SmallInt(HiWord(WAbil.DC) - LoWord(WAbil.DC)) +1) + LoWord(WAbil.DC));
  if nPower > 0 then
    nPower:=TargeTBaseObject.GetHitStruckDamage(Self,nPower);
  if nPower > 0 then begin
    TargeTBaseObject.SetLastHiter(Self);
    TargeTBaseObject.m_ExpHitter:=nil;
    TargeTBaseObject.StruckDamage(nPower);
    TargeTBaseObject.SendDelayMsg(TBaseObject(RM_STRUCK),RM_10101,nPower,TargeTBaseObject.m_WAbil.HP,TargeTBaseObject.m_WAbil.MaxHP,Integer(Self),'',
                                _MAX(abs(m_nCurrX - TargeTBaseObject.m_nCurrX),abs(m_nCurrY - TargeTBaseObject.m_nCurrY)) * 50 + 600);
  end;
  SendRefMsg(RM_FLYAXE,m_btDirection,m_nCurrX,m_nCurrY,Integer(TargeTBaseObject),'');
end;
procedure TArcherGuard.Run;//004A6C64
var
  I                :Integer;
  nAbs             :Integer;
  nRage            :Integer;
  BaseObject       :TBaseObject;
  TargetBaseObject :TBaseObject;
begin
  nRage            := 9999;
  TargetBaseObject := nil;
  if CanMove then begin
    if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      for I := 0 to m_VisibleActors.Count - 1 do begin
        BaseObject:=TBaseObject(pTVisibleBaseObject(m_VisibleActors.Items[I]).BaseObject);
        if BaseObject.m_boDeath then Continue;
        if IsProperTarget(BaseObject) then begin
          nAbs:=abs(m_nCurrX - BaseObject.m_nCurrX) + abs(m_nCurrY - BaseObject.m_nCurrY);
          if nAbs < nRage then begin
            nRage:=nAbs;
            TargetBaseObject:=BaseObject;
          end;
        end;
      end;    
      if TargetBaseObject <> nil then begin
        SetTargetCreat(TargetBaseObject);
      end else begin
        DelTargetCreat();
      end;
    end;
    if m_TargetCret <> nil then begin
      if GetCurrentTime - m_dwHitTick > GetHitSpeed then begin
        m_dwHitTick:=GetCurrentTime;
        sub_4A6B30(m_TargetCret);
      end;
    end else begin
      if (m_nDirection >= 0) and (m_btDirection <> m_nDirection) then begin
        TurnTo(m_nDirection);
      end;        
    end;
      
  end;
  inherited;
end;

{ TArcherPolice }

constructor TArcherPolice.Create;//004A6E14
begin
  inherited;
  m_btRaceServer:=20;
end;

destructor TArcherPolice.Destroy;
begin

  inherited;
end;


{ TCastleDoor }

constructor TCastleDoor.Create;//004A6E60
begin
  inherited;
  m_boAnimal:=False;
  m_boStickMode:=True;
  m_boOpened:=False;
  m_btAntiPoison:=200;
end;

destructor TCastleDoor.Destroy;
begin

  inherited;
end;
procedure TCastleDoor.SetMapXYFlag(nFlag:Integer);//004A6FB4
var
  bo06:Boolean;
begin
  m_PEnvir.SetMapXYFlag(m_nCurrX,m_nCurrY - 2,True);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1,m_nCurrY - 1,True);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1,m_nCurrY - 2,True);
  if nFlag = 1 then bo06:=False
  else bo06:=True;
  m_PEnvir.SetMapXYFlag(m_nCurrX,m_nCurrY,bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX,m_nCurrY - 1,bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX,m_nCurrY - 2,bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1,m_nCurrY - 1,bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX + 1,m_nCurrY - 2,bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1,m_nCurrY,bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 2,m_nCurrY,bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1,m_nCurrY - 1,bo06);
  m_PEnvir.SetMapXYFlag(m_nCurrX - 1,m_nCurrY + 1,bo06);
  if nFlag = 0 then begin
    m_PEnvir.SetMapXYFlag(m_nCurrX,m_nCurrY - 2,False);
    m_PEnvir.SetMapXYFlag(m_nCurrX + 1,m_nCurrY - 1,False);
    m_PEnvir.SetMapXYFlag(m_nCurrX + 1,m_nCurrY - 2,False);
  end;
    
end;
procedure TCastleDoor.Open;//004A71B4
begin
  if m_boDeath then exit;
  m_btDirection:=7;
  SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  m_boOpened:=True;
  m_boStoneMode:=True;
  SetMapXYFlag(0);
  bo2B9:=False;
end;

procedure TCastleDoor.Close;//004A7220
begin
  if m_boDeath then exit;
  m_btDirection:=3 - ROUND(m_WAbil.HP/m_WAbil.MaxHP * 3.0);
  if (m_btDirection - 3) >= 0 then m_btDirection:=0;
  SendRefMsg(RM_DIGDOWN,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  m_boOpened:=False;
  m_boStoneMode:=False;
  SetMapXYFlag(1);
  bo2B9:=True;
end;

procedure TCastleDoor.Die;
begin
  inherited;
  dw560:=GetTickCount();
  SetMapXYFlag(2);
end;

procedure TCastleDoor.Run;//004A7304
var
  n08:Integer;
begin
  if m_boDeath and (m_Castle <> nil) then
    m_dwDeathTick:=GetTickCount()
  else m_nHealthTick:=0;
  if not m_boOpened then begin
    n08:=3 - ROUND(m_WAbil.HP/m_WAbil.MaxHP * 3.0);
    if (m_btDirection <> n08) and (n08 < 3) then begin
      m_btDirection:=n08;
      SendRefMsg(RM_TURN,m_btDirection,m_nCurrX,m_nCurrY,0,'');
    end;
  end;
  inherited;
end;

procedure TCastleDoor.RefStatus;//004A6F24
var
  n08:Integer;
begin
  n08:=3 - ROUND(m_WAbil.HP/m_WAbil.MaxHP * 3.0);
  if (n08 - 3) >= 0 then n08:=0;
  m_btDirection:=n08;
  SendRefMsg(RM_ALIVE,m_btDirection,m_nCurrX,m_nCurrY,0,'');
end;

procedure TCastleDoor.Initialize; //0x004A6ECC
begin
//  m_btDirection:=0;
  inherited;
  {
  if m_WAbil.HP > 0 then begin
    if m_boOpened then begin
      SetMapXYFlag(0);
      exit;
    end;
    SetMapXYFlag(1);
    exit;
  end;
  SetMapXYFlag(2);
  }
end;

{ TWallStructure }

constructor TWallStructure.Create;//004A73D4
begin
  inherited;
  m_boAnimal:=False;
  m_boStickMode:=True;
  boSetMapFlaged:=False;
  m_btAntiPoison:=200;
end;

destructor TWallStructure.Destroy;
begin

  inherited;
end;

procedure TWallStructure.Initialize;//004A7440
begin
  m_btDirection:=0;
  inherited;
end;

procedure TWallStructure.RefStatus;//004A745C
var
  n08:Integer;
begin
  if m_WAbil.HP > 0 then begin
    n08:=3 - ROUND(m_WAbil.HP/m_WAbil.MaxHP * 3.0);
  end else begin
    n08:=4;
  end;
  if n08 >= 5 then n08:=0;
  m_btDirection:=n08;
  SendRefMsg(RM_ALIVE,m_btDirection,m_nCurrX,m_nCurrY,0,'');
end;
procedure TWallStructure.Die;//004A74F8
begin
  inherited;
  dw560:=GetTickCount();
end;



procedure TWallStructure.Run;//004A7518
var
  n08:Integer;
begin
  if m_boDeath then begin
    m_dwDeathTick:=GetTickCount();
    if boSetMapFlaged then begin
      m_PEnvir.SetMapXYFlag(m_nCurrX,m_nCurrY,True);
      boSetMapFlaged:=False;
    end;      
  end else begin
    m_nHealthTick:=0;
    if not boSetMapFlaged then begin
      m_PEnvir.SetMapXYFlag(m_nCurrX,m_nCurrY,False);
      boSetMapFlaged:=True;      
    end;
  end;
  if m_WAbil.HP > 0 then begin
    n08:=3 - ROUND(m_WAbil.HP/m_WAbil.MaxHP * 3.0);
  end else begin
    n08:=4;
  end;
  if (m_btDirection <> n08) and (n08 < 5) then begin
    m_btDirection:=n08;
    SendRefMsg(RM_DIGUP,m_btDirection,m_nCurrX,m_nCurrY,0,'');
  end;
  inherited;
end;

{evilmir}
constructor TEvilMir.Create;
begin
  inherited;
  m_dwSpellTick:=GetTickCount();

  m_boAnimal:=False;
  //m_SlaveObjectList:=TList.Create;
  boSlaves:=False;
  dwEMDied:=0;   //this tells former pets that they should go :p
  m_nViewRange:=20;
end;

destructor TEvilMir.Destroy;
begin
//  m_SlaveObjectList.Free;
  inherited;
end;

procedure TEvilMir.Run;//004A617C
var
  nDir:Byte;
begin
  if (m_boDeath) and (boslaves = true) then begin
    boslaves:= false;
    nEMDrops:=0;//reset all the drops/hitcount on parts
    nEMHitCount:=0;
    dwEMDied:=GetTickCount();//tell our slaves that their master has passed away
    inc(nEMKills)
  end;
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin

     if boSlaves = FALSE then begin //if we dont have slaves already make them
      boSlaves:= TRUE;
      callslaves();
           end;
     //basicaly casting his normal fireball/firebang spell every 3.5seconds
     if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > 3500) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
      m_dwHitTick:=GetCurrentTime;
      nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      FlameCircle(nDir);
     end;

     if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwSpellTick) > 30000) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
      MassThunder;
     end;

    //search for targets nearby
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
   end;
  end;
  inherited;
end;

procedure TEvilMir.CallSlaves();
const
  sMonName:array[0..2] of String = ('1', '2', '3');//basicaly by adding to this you can make new 'slaves' that drop better
var
  I: Integer;
  BaseObject:TBaseObject;
begin
  for i := 0 to High(g_DragonSearchPath) do begin
    if (g_DragonSearchPath[i,0] = 0) and (g_DragonSearchPath[i,1] = 0) then Continue;
    BaseObject := UserEngine.RegenMonsterByName(m_PEnvir.sMapName, m_nCurrX+g_DragonSearchPath[i,0], m_nCurrY+g_DragonSearchPath[i,1], sMonName[_Min(nEMKills,Length(sMonName))]);
    {if BaseObject <> nil then begin
      m_xSlaveList.Add(BaseObject);
    end;}
  end;
end;

procedure TEvilMir.FlameCircle(nDir:Integer);
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
 if nDir <= 4 then
   SendRefMsg(RM_81,nDir,m_nCurrX,m_nCurrY,Integer(Target),'');
 if nDir = 5 then
   SendRefMsg(RM_82,nDir,m_nCurrX,m_nCurrY,Integer(Target),'');
 if nDir >= 6 then
   SendRefMsg(RM_83,nDir,m_nCurrX,m_nCurrY,Integer(Target),'');
 //if (nDir <> 4) and (nDir <> 5) and (nDir <> 6) then
 //Target.SendMsg(self,RM_SYSMESSAGE,0,g_Config.btGreenMsgFColor,g_Config.btGreenMsgBColor,0,'Evilmir hits in unknown direction debug required, dir:');

 for i:=0 to Target.m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(Target.m_VisibleActors[i]).BaseObject);
   if (abs(Target.m_nCurrX-BaseObject.m_nCurrX) <= 2) and (abs(Target.m_nCurrY-BaseObject.m_nCurrY) <= 2) then begin

    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(50) >= BaseObject.m_nAntiMagic then begin
          WAbil:=@m_WAbil;
          magpwr:=Random(nEMKills * 5) + (Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
        end;
      end;
    end;
   end;
  end;
end;

procedure TEvilMir.MassThunder();
var
  xTargetList:TList;
  BaseObject:TBaseObject;
  WAbil:pTAbility;
  magpwr:Integer;
  i:Integer;
begin
  m_dwSpellTick:=GetTickCount();
  SendAttackMsg(RM_hit,0,m_nCurrX,m_nCurrY);//make client show random tbolting;
  xTargetList := TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,14,xTargetList);

	if (xTargetList.Count>0) then begin
    for i:=xTargetList.Count-1 downto 0 do begin
      BaseObject := TBaseObject(xTargetList.Items[i]);

      if (BaseObject<>nil) then begin
      if IsProperTarget(BaseObject) then begin
         WAbil:=@m_WAbil;
          magpwr:=Random(nEMKills * 12) + (Random(SmallInt(HiWord(WAbil.SC) - LoWord(WAbil.SC)) + 1) + LoWord(WAbil.SC));
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
      end;
        xTargetList.Delete(i);
		  end;
    end;
	end;
  xTargetList.Free;
end;


function TEvilMir.Operate(ProcessMsg:pTProcessMessage):boolean;
begin
  if (ProcessMsg.wIdent = RM_POISON) then begin
    massthunder();
  end;
  Result:=inherited Operate(ProcessMsg);
end;

procedure TEvilMir.Die;
begin
  inherited;
  m_dwDeathTick := GetTickCount + 5*60*1000;
end;


{ THellGuard }

constructor THellGuard.Create;
begin
  inherited;
  m_nViewRange:=16;
  m_boAnimal:=False;
end;

destructor THellGuard.Destroy;
begin

  inherited;
end;

function THellGuard.AttackTarget():Boolean;
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
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,17{type},'');
        end;
      end;
    end;
    Result:=True;
  end;
end;

procedure THellGuard.Run;
begin
  if CanMove then begin
    if m_VisibleActors.Count > 0 then
      AttackTarget();
  end;
   if (Random(10) = 0) then begin
      RepulseCircle();
   end;
  inherited;
end;

procedure THellGuard.RepulseCircle();
var
  I:Integer;
  BaseObject:TBaseObject;
  nDir:Byte;
  push:integer;
begin
 nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
 m_btDirection:=nDir;

 SendRefMsg(RM_LIGHTING,nDir,m_nCurrX,m_nCurrY,Integer(self),'');

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
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,18{type},'');

          {if Random(3) <> 0 then
            BaseObject.MakePosion(POISON_STONE,5,0);
          end;}
        end;
      end;
    end;
   end;
  end;
end;

constructor TGuardianRock.Create;
begin
  inherited;
  m_nViewRange:=16;
  m_boAnimal:=False;
end;

destructor TGuardianRock.Destroy;
begin
  inherited;
end;

function TGuardianRock.AttackTarget():Boolean;
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
          //SendDelayMsg(Self,RM_DELAYMAGIC,nPower,MakeLong(BaseObject.m_nCurrX,BaseObject.m_nCurrY),1,Integer(BaseObject),'',200);
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,23{type},'');

        end;
      end;
    end;
    Result:=True;
  end;
end;

procedure TGuardianRock.Run;
begin
{  if CanMove then begin
    if m_VisibleActors.Count > 0 then
      AttackTarget();
  end;}
   if (Random(5) = 0) then begin
      AttackTarget();
   end;
  inherited;
end;

constructor TFoxOrbSpirit.Create;
begin
  inherited;
  m_dwSpellTick:=GetTickCount();
//  m_boAnimal:=False;
//  boSlaves:=False;
//  dwEMDied:=0;
//  m_nViewRange:=1;
end;

destructor TFoxOrbSpirit.Destroy;
begin
  inherited;
end;

procedure TFoxOrbSpirit.Run;
var
  nDir:Byte;
begin
  if not m_boFixedHideMode and
     not m_boStoneMode and
     CanMove then begin

     if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwHitTick) > 7000) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
      m_dwHitTick:=GetCurrentTime;
      nDir:= GetNextDirection (m_nCurrX, m_nCurrY, m_TargetCret.m_nCurrX, m_TargetCret.m_nCurrY);
      FlameCircle(nDir);
     end;

     if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwSpellTick) > 10000) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
      MassThunder;
     end;

     {if (m_TargetCret <> nil) and (Integer(GetTickCount - m_dwSpellTick) > 5000) and (abs(m_nCurrX - m_TargetCret.m_nCurrX) <= 10) and (abs(m_nCurrY - m_TargetCret.m_nCurrY) <= 10) then begin
      FoxYell;
     end;}
     if (GetCurrentTime - m_dwWalkTick > GetWalkSpeed) then begin
      m_dwWalkTick:=GetCurrentTime;
      SendRefMsg(RM_TURN,m_btDirection,m_nCurrX,m_nCurrY,0,'');
     end; 
    if ((GetTickCount - m_dwSearchEnemyTick) > 8000) or
       (((GetTickCount - m_dwSearchEnemyTick) > 1000) and (m_TargetCret = nil)) then begin
      m_dwSearchEnemyTick:=GetTickCount();
      SearchTarget();
   end;
  end;
  inherited;
end;

procedure TFoxOrbSpirit.FoxYell();
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
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,27{type},'');
          if Random(3) <> 0 then
            BaseObject.MakePosion(POISON_STONE,4,0);

        end;
      end;
    end;
   end;
  end;
end;

procedure TFoxOrbSpirit.FlameCircle(nDir:Integer);
var
  nSX,nSY,nTX,nTY,nPwr:Integer;
  I:Integer;
  magpwr:Integer;
  TargetNum:Integer;
  WAbil:pTAbility;
  BaseObject:TBaseObject;
  Target:TBaseObject;
begin
 Target := m_TargetCret;
   SendRefMsg(RM_LIGHTING,nDir,m_nCurrX,m_nCurrY,Integer(Target),'');

 for i:=0 to Target.m_VisibleActors.Count-1 do begin
  BaseObject:= TBaseObject (pTVisibleBaseObject(Target.m_VisibleActors[i]).BaseObject);
   if (abs(Target.m_nCurrX-BaseObject.m_nCurrX) <= 2) and (abs(Target.m_nCurrY-BaseObject.m_nCurrY) <= 2) then begin

    if BaseObject <> nil then begin
      if IsProperTarget (BaseObject) then begin
        if Random(50) >= BaseObject.m_nAntiMagic then begin
          WAbil:=@m_WAbil;
          magpwr:=Random(nEMKills * 5) + (Random(SmallInt(HiWord(WAbil.MC) - LoWord(WAbil.MC)) + 1) + LoWord(WAbil.MC));
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
          SendRefMsg(RM_10205,0,BaseObject.m_nCurrX,BaseObject.m_nCurrY,26{type},'');
        end;
      end;
    end;
   end;
  end;
end;

procedure TFoxOrbSpirit.MassThunder();
var
  xTargetList:TList;
  BaseObject:TBaseObject;
  WAbil:pTAbility;
  magpwr:Integer;
  i:Integer;
begin
  m_dwSpellTick:=GetTickCount();
  SendAttackMsg(RM_hit,0,m_nCurrX,m_nCurrY);
  xTargetList := TList.Create;
  GetMapBaseObjects(m_PEnvir,m_nCurrX,m_nCurrY,14,xTargetList);

	if (xTargetList.Count>0) then begin
    for i:=xTargetList.Count-1 downto 0 do begin
      BaseObject := TBaseObject(xTargetList.Items[i]);

      if (BaseObject<>nil) then begin
      if IsProperTarget(BaseObject) then begin
         WAbil:=@m_WAbil;
          magpwr:=Random(nEMKills * 12) + (Random(SmallInt(HiWord(WAbil.SC) - LoWord(WAbil.SC)) + 1) + LoWord(WAbil.SC));
          BaseObject.SendDelayMsg (self, RM_MAGSTRUCK, 0, magpwr, 1, 0, '', 600);
      end;
        xTargetList.Delete(i);
		  end;
    end;
	end;
  xTargetList.Free;
end;


{function TFoxOrbSpirit.Operate(ProcessMsg:pTProcessMessage):boolean;
begin
  if (ProcessMsg.wIdent = RM_POISON) then begin
    massthunder();
  end;
  Result:=inherited Operate(ProcessMsg);
end;  }

{procedure TFoxOrbSpirit.Die;
begin
  inherited;
  m_dwDeathTick := GetTickCount + 5*60*1000;
end;}


{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: ObjMon2.pas 594 2007-03-09 15:00:12Z damian $');
end.
