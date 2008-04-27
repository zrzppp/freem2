unit IntroScn;

interface

uses
  svn, Windows, Messages, SysUtils, Classes, Graphics, StdCtrls, Controls, Forms, Dialogs,
  extctrls, DXDraws, DXClass, FState, Grobal2, cliUtil, clFunc, SoundUtil, DWinCtl,
  DXSounds, HUtil32;


const
   SELECTEDFRAME = 16;
   FREEZEFRAME = 13;
   EFFECTFRAME = 14;

type
   TLoginState = (lsLogin, lsNewid, lsNewidRetry, lsChgpw, lsCloseAll);
   TSceneType = (stIntro, stLogin, stSelectCountry, stSelectChr, stNewChr{, stLoading,
                   stLoginNotice}, stPlayGame);
   TSelChar = record
      Valid: Boolean;
      UserChr: TUserCharacterInfo;
      Selected: Boolean;
      FreezeState: Boolean;
      Unfreezing: Boolean;
      Freezing: Boolean;
      AniIndex: integer;
      DarkLevel: integer;
      EffIndex: integer;
      StartTime: longword;
      moretime: longword;
      startefftime: longword;
      IsCreating: boolean;
   end;

   TScene = class
   private
   public
      SceneType: TSceneType;
      constructor Create (scenetype: TSceneType);
      procedure Initialize; dynamic;
      procedure Finalize; dynamic;
      procedure OpenScene; dynamic;
      procedure CloseScene; dynamic;
      procedure OpeningScene; dynamic;
      procedure KeyPress (var Key: Char); dynamic;
      procedure KeyDown (var Key: Word; Shift: TShiftState); dynamic;
      procedure MouseMove (Shift: TShiftState; X, Y: Integer); dynamic;
      procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
      procedure PlayScene (MSurface: TDirectDrawSurface); dynamic;
   end;

   TIntroScene = class (TScene)
   private
   public
      constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TDirectDrawSurface); override;
   end;

   TLoginScene = class (TScene)
   private
     m_EdId           :TEdit;
     m_EdPasswd       :TEdit;
     m_EdNewId        :TEdit;
     m_EdNewPasswd    :TEdit;
     m_EdConfirm      :TEdit;
     m_EdYourName     :TEdit;
     m_EdSSNo         :TEdit;
     m_EdBirthDay     :TEdit;
     m_EdQuiz1        :TEdit;
     m_EdAnswer1      :TEdit;
     m_EdQuiz2        :TEdit;
     m_EdAnswer2      :TEdit;
     m_EdPhone        :TEdit;
     m_EdMobPhone     :TEdit;
     m_EdEMail        :TEdit;
     m_EdChgId        :TEdit;
     m_EdChgCurrentpw :TEdit;
     m_EdChgNewPw     :TEdit;
     m_EdChgRepeat    :TEdit;
     m_nCurFrame      :Integer;
     m_nMaxFrame      :Integer;
     m_dwStartTime    :LongWord;
     m_boNowOpening   :Boolean;
     m_boOpenFirst    :Boolean;
     m_NewIdRetryUE   :TUserEntry;
     m_NewIdRetryAdd  :TUserEntryAdd;
     procedure EdLoginIdKeyPress (Sender: TObject; var Key: Char);
     procedure EdLoginPasswdKeyPress (Sender: TObject; var Key: Char);
     procedure EdNewIdKeyPress (Sender: TObject; var Key: Char);
     procedure EdNewOnEnter (Sender: TObject);
     function  CheckUserEntrys: Boolean;
     function  NewIdCheckNewId: Boolean;
     function  NewIdCheckSSno: Boolean;
     function  NewIdCheckBirthDay: Boolean;
   public
     m_sLoginId            :String;
     m_sLoginPasswd        :String;
     m_boUpdateAccountMode :Boolean;
     constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TDirectDrawSurface); override;
      procedure ChangeLoginState (state: TLoginState);
      procedure NewClick;
      procedure NewIdRetry (boupdate: Boolean);
      procedure UpdateAccountInfos (ue: TUserEntry);
      procedure OkClick;
      procedure ChgPwClick;
      procedure NewAccountOk;
      procedure NewAccountClose;
      procedure ChgpwOk;
      procedure ChgpwCancel;
      procedure HideLoginBox;
      procedure OpenLoginDoor;
      procedure PassWdFail;
   end;

   TSelectChrScene = class (TScene)
   private
      SoundTimer: TTimer;
      CreateChrMode: Boolean;
      EdChrName: TEdit;
      m_dwStartTime :LongWord;
      Numbert :integer;
      Help1   :integer;
      Help2   :integer;
      logodxdindex :integer;
      m_LoadingTime :LongWord;
      m_LoadingWaitTime :LongWord;
      m_boNowLoading :Boolean;
      m_nCurFrame :Integer;
      m_nMaxFrame :Integer;
      procedure SoundOnTimer (Sender: TObject);
      procedure MakeNewChar (index: integer);
      procedure EdChrnameKeyPress (Sender: TObject; var Key: Char);
   public
      NewIndex: integer;
      OldIndex: integer;
      ChrArr: array[0..2] of TSelChar;
      constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TDirectDrawSurface); override;
      procedure SelChrSelect1Click;
      procedure SelChrSelect2Click;
      procedure SelChrSelect3Click;      
      procedure SelChrStartClick;
      procedure SelChrNewChrClick;
      procedure SelChrEraseChrClick;
      procedure SelChrCreditsClick;
      procedure SelChrExitClick;
      procedure SelChrNewClose;
      procedure SelChrNewJob (job: integer);
      procedure SelChrNewm_btSex (sex: integer);
      procedure SelChrNewPrevHair;
      procedure SelChrNewNextHair;
      procedure SelChrNewOk;
      procedure ClearChrs;
      procedure AddChr (uname: string; job, hair, level, sex: integer);
      procedure SelectChr (index: integer);
      procedure OpenLoading;
      procedure HideSelectChrBox;
      procedure LoadHelp1;
      procedure LoadHelp2;
   end;

{   TLoading = class (TScene)
   private
     m_nCurFrame      :Integer;
     m_nMaxFrame      :Integer;
   public
      constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TDirectDrawSurface); override;
   end;}

{   TLoginNotice = class (TScene)
   private
   public
      constructor Create;
      destructor Destroy; override;
   end;}

implementation

uses
   ClMain, MShare, Share;


constructor TScene.Create (scenetype: TSceneType);
begin
   SceneType := scenetype;
end;

procedure TScene.Initialize;
begin
end;

procedure TScene.Finalize;
begin
end;

procedure TScene.OpenScene;
begin
   ;
end;

procedure TScene.CloseScene;
begin
   ;
end;

procedure TScene.OpeningScene;
begin
end;

procedure TScene.KeyPress (var Key: Char);
begin
end;

procedure TScene.KeyDown (var Key: Word; Shift: TShiftState);
begin
end;

procedure TScene.MouseMove (Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TScene.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TScene.PlayScene (MSurface: TDirectDrawSurface);
begin
   ;
end;


{------------------- TIntroScene ----------------------}


constructor TIntroScene.Create;
begin
   inherited Create (stIntro);
end;

destructor TIntroScene.Destroy;
begin
   inherited Destroy;
end;

procedure TIntroScene.OpenScene;
begin
end;

procedure TIntroScene.CloseScene;
begin
end;

procedure TIntroScene.PlayScene (MSurface: TDirectDrawSurface);
begin
end;


{--------------------- Login ----------------------}


constructor TLoginScene.Create;
var
   nx, ny: integer;
begin
   inherited Create (stLogin);
   m_EdId := TEdit.Create (FrmMain.Owner);
   with m_EdId do begin
      Parent := FrmMain;
      Color  := clBlack;
      Font.Color := clWhite;
      Font.Size := 10;
      MaxLength := 10;
      BorderStyle := bsNone;
      OnKeyPress := EdLoginIdKeyPress;
      Visible := FALSE;
      Tag := 10;
   end;
   m_EdPasswd := TEdit.Create (FrmMain.Owner);
   with m_EdPasswd do begin
      Parent := FrmMain; Color  := clBlack; Font.Size := 10; MaxLength := 10; Font.Color := clWhite;
      BorderStyle := bsNone; PasswordChar := '*';
      OnKeyPress := EdLoginPasswdKeyPress; Visible := FALSE;
      Tag := 10;
   end;
   nx := SCREENWIDTH div 2 - 320;
   ny := SCREENHEIGHT div 2 - 238;
   m_EdNewId := TEdit.Create (FrmMain.Owner);
   with m_EdNewId do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 116;
      BorderStyle := bsNone; Color := clBlack; Font.Color := clWhite; MaxLength := 10;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdNewPasswd := TEdit.Create (FrmMain.Owner);
   with m_EdNewPasswd do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 137;
      BorderStyle := bsNone; Color := clBlack; Font.Color := clWhite; MaxLength := 10;
      PasswordChar := '*'; Visible := FALSE;  OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdConfirm := TEdit.Create (FrmMain.Owner);
   with m_EdConfirm do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 158;
      BorderStyle := bsNone; Color := clBlack; Font.Color := clWhite; MaxLength := 10;
      PasswordChar := '*';  Visible := FALSE;  OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdYourName := TEdit.Create (FrmMain.Owner);
   with m_EdYourName do begin
      Parent := FrmMain; Height := 16; Width  := 116; Left := nx + 161; Top  := ny + 187;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 20;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdSSNo := TEdit.Create (FrmMain.Owner);
   with m_EdSSNo do begin
      Parent := FrmMain; Height := 16; Width  := 116; Left := nx + 161; Top  := ny + 207;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 14;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdBirthDay := TEdit.Create (FrmMain.Owner);
   with m_EdBirthDay do begin
      Parent := FrmMain; Height := 16; Width  := 116; Left := nx + 161; Top  := ny + 227;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 10;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdQuiz1 := TEdit.Create (FrmMain.Owner);
   with m_EdQuiz1 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 256;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 20;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdAnswer1 := TEdit.Create (FrmMain.Owner);
   with m_EdAnswer1 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 276;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 12;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdQuiz2 := TEdit.Create (FrmMain.Owner);
   with m_EdQuiz2 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 297;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 20;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdAnswer2 := TEdit.Create (FrmMain.Owner);
   with m_EdAnswer2 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 317;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 12;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdPhone := TEdit.Create (FrmMain.Owner);
   with m_EdPhone do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 347;
      BorderStyle := bsNone;
      Color  := clBlack;
      Font.Color := clWhite;
      MaxLength := 14;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdMobPhone := TEdit.Create (FrmMain.Owner);
   with m_EdMobPhone do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 368;
      BorderStyle := bsNone;
      Color  := clBlack;
      Font.Color := clWhite;
      MaxLength := 13;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdEMail := TEdit.Create (FrmMain.Owner);
   with m_EdEMail do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 388;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 40;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   nx := SCREENWIDTH div 2 - 210;
   ny := SCREENHEIGHT div 2 - 150;
   m_EdChgId := TEdit.Create (FrmMain.Owner);
   with m_EdChgId do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+117;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
   m_EdChgCurrentpw := TEdit.Create (FrmMain.Owner);
   with m_EdChgCurrentpw do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+149;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      PasswordChar := '*';
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
   m_EdChgNewPw := TEdit.Create (FrmMain.Owner);
   with m_EdChgNewPw do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+176;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      PasswordChar := '*';
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
   m_EdChgRepeat := TEdit.Create (FrmMain.Owner);
   with m_EdChgRepeat do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+208;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      PasswordChar := '*';
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
end;

destructor TLoginScene.Destroy;
begin
   inherited Destroy;
end;

procedure TLoginScene.OpenScene;
var
   i: integer;
   d: TDirectDrawSurface;
begin
   m_nCurFrame := 0;
   m_nMaxFrame := 19;
   m_sLoginId := '';
   m_sLoginPasswd := '';
   with m_EdId do begin
      Left   := SCREENWIDTH div 2 - 72;
      Top    := SCREENHEIGHT div 2  - 41;
      Height := 16;
      Width  := 137;
      Visible := FALSE;
   end;
   with m_EdPasswd do begin
      Left   := SCREENWIDTH div 2 - 72;
      Top    := SCREENHEIGHT div 2  - 10;
      Height := 16;
      Width  := 137;
      Visible := FALSE;
   end;
   m_boOpenFirst := TRUE;
   FrmDlg.DLogin.Visible := TRUE;
   FrmDlg.DInputKey.Visible := TRUE;
   FrmDlg.DNewAccount.Visible := FALSE;
   m_boNowOpening := FALSE;
   PlayBGM (bmg_intro);
end;

procedure TLoginScene.CloseScene;
begin
   m_EdId.Visible := FALSE;
   m_EdPasswd.Visible := FALSE;
   FrmDlg.DInputKey.Visible := FALSE;
   FrmDlg.DLogin.Visible := FALSE;
   SilenceSound;
end;

procedure TLoginScene.EdLoginIdKeyPress (Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin
      Key := #0;
      m_sLoginId := LowerCase(m_EdId.Text);
      if m_sLoginId <> '' then begin
         m_EdPasswd.SetFocus;
      end;
   end;
end;

procedure TLoginScene.EdLoginPasswdKeyPress (Sender: TObject; var Key: Char);
begin
   if (Key = '~') or (Key = '''') then Key := '_';
   if Key = #13 then begin
      Key := #0;
      m_sLoginId := LowerCase(m_EdId.Text);
      m_sLoginPasswd := m_EdPasswd.Text;
      if (m_sLoginId <> '') and (m_sLoginPasswd <> '') then begin
         FrmMain.SendLogin (m_sLoginId, m_sLoginPasswd);
         m_EdId.Text := '';
         m_EdPasswd.Text := '';
         m_EdId.Visible := FALSE;
         m_EdPasswd.Visible := FALSE;
      end else
         if (m_EdId.Visible) and (m_EdId.Text = '') then m_EdId.SetFocus;
   end;
end;

procedure TLoginScene.PassWdFail;
begin
   m_EdId.Visible := TRUE;
   m_EdPasswd.Visible := TRUE;
   m_EdId.SetFocus;
end;


function  TLoginScene.NewIdCheckNewId: Boolean;
begin
   Result := TRUE;
   m_EdNewId.Text := Trim(m_EdNewId.Text);
   if Length(m_EdNewId.Text) < 3 then begin
      FrmDlg.DMessageDlg ('登录帐号的长度必须大于3位.', [mbOk]);
      Beep;
      m_EdNewId.SetFocus;
      Result := FALSE;
   end;
end;

function  TLoginScene.NewIdCheckSSno: Boolean;
var
   str, t1, t2, t3, syear, smon, sday: string;
   ayear, amon, aday, sex: integer;
   flag: Boolean;
begin
   Result := TRUE;
   str := m_EdSSNo.Text;
   str := GetValidStr3 (str, t1, ['-']);
   GetValidStr3 (str, t2, ['-']);
   flag := TRUE;
   if (Length(t1) = 6) and (Length(t2) = 7) then begin
      smon := Copy(t1, 3, 2);
      sday := Copy(t1, 5, 2);
      amon := Str_ToInt (smon, 0);
      aday := Str_ToInt (sday, 0);
      if (amon <= 0) or (amon > 12) then flag := FALSE;
      if (aday <= 0) or (aday > 31) then flag := FALSE;
      sex := Str_ToInt (Copy(t2, 1, 1), 0);
      if (sex <= 0) or (sex > 2) then flag := FALSE;
   end else flag := FALSE;
   if not flag then begin
      Beep;
      m_EdSSNo.SetFocus;
      Result := FALSE;
   end;
end;

function  TLoginScene.NewIdCheckBirthDay: Boolean;
var
   str, t1, t2, t3, syear, smon, sday: string;
   ayear, amon, aday, sex: integer;
   flag: Boolean;
begin
   Result := TRUE;
   flag := TRUE;
   str := m_EdBirthDay.Text;
   str := GetValidStr3 (str, syear, ['/']);
   str := GetValidStr3 (str, smon, ['/']);
   str := GetValidStr3 (str, sday, ['/']);
   ayear := Str_ToInt(syear, 0);
   amon := Str_ToInt(smon, 0);
   aday := Str_ToInt(sday, 0);
   if (ayear <= 1890) or (ayear > 2101) then flag := FALSE;
   if (amon <= 0) or (amon > 12) then flag := FALSE;
   if (aday <= 0) or (aday > 31) then flag := FALSE;
   if not flag then begin
      Beep;
      m_EdBirthDay.SetFocus;
      Result := FALSE;
   end;
end;

procedure TLoginScene.EdNewIdKeyPress (Sender: TObject; var Key: Char);
var
   str, t1, t2, t3, syear, smon, sday: string;
   ayear, amon, aday, sex: integer;
   flag: Boolean;
begin
   if (Sender = m_EdNewPasswd) or (Sender = m_EdChgNewPw) or (Sender = m_EdChgRepeat) then
      if (Key = '~') or (Key = '''') or (Key = ' ') then Key := #0;
   if Key = #13 then begin
      Key := #0;
      if Sender = m_EdNewId then begin
         if not NewIdCheckNewId then
            exit;
      end;
      if Sender = m_EdNewPasswd then begin
         if Length(m_EdNewPasswd.Text) < 4 then begin
            FrmDlg.DMessageDlg ('密码长度必须大于 4位.', [mbOk]);
            Beep;
            m_EdNewPasswd.SetFocus;
            exit;
         end;
      end;
      if Sender = m_EdConfirm then begin
         if m_EdNewPasswd.Text <> m_EdConfirm.Text then begin
            FrmDlg.DMessageDlg ('二次输入的密码不一至！！！', [mbOk]);
            Beep;
            m_EdConfirm.SetFocus;
            exit;
         end;
      end;
      if (Sender = m_EdYourName) or (Sender = m_EdQuiz1) or (Sender = m_EdAnswer1) or
         (Sender = m_EdQuiz2) or (Sender = m_EdAnswer2) or (Sender = m_EdPhone) or
         (Sender = m_EdMobPhone) or (Sender = m_EdEMail)
      then begin
         TEdit(Sender).Text := Trim(TEdit(Sender).Text);
         if TEdit(Sender).Text = '' then begin
            Beep;
            TEdit(Sender).SetFocus;
            exit;
         end;
      end;
      if (Sender = m_EdSSNo) and (not EnglishVersion) then begin
         if not NewIdCheckSSno then
            exit;
      end;
      if Sender = m_EdBirthDay then begin
         if not NewIdCheckBirthDay then
            exit;
      end;
      if TEdit(Sender).Text <> '' then begin
         if Sender = m_EdNewId then m_EdNewPasswd.SetFocus;
         if Sender = m_EdNewPasswd then m_EdConfirm.SetFocus;
         if Sender = m_EdConfirm then m_EdYourName.SetFocus;
         if Sender = m_EdYourName then m_EdSSNo.SetFocus;
         if Sender = m_EdSSNo then m_EdBirthDay.SetFocus;
         if Sender = m_EdBirthDay then m_EdQuiz1.SetFocus;
         if Sender = m_EdQuiz1 then m_EdAnswer1.SetFocus;
         if Sender = m_EdAnswer1 then m_EdQuiz2.SetFocus;
         if Sender = m_EdQuiz2 then m_EdAnswer2.SetFocus;
         if Sender = m_EdAnswer2 then m_EdPhone.SetFocus;
         if Sender = m_EdPhone then m_EdMobPhone.SetFocus;
         if Sender = m_EdMobPhone then m_EdEMail.SetFocus;
         if Sender = m_EdEMail then begin
            if m_EdNewId.Enabled then m_EdNewId.SetFocus
            else if m_EdNewPasswd.Enabled then m_EdNewPasswd.SetFocus;
         end;

         if Sender = m_EdChgId then m_EdChgCurrentpw.SetFocus;
         if Sender = m_EdChgCurrentpw then m_EdChgNewPw.SetFocus;
         if Sender = m_EdChgNewPw then m_EdChgRepeat.SetFocus;
         if Sender = m_EdChgRepeat then m_EdChgId.SetFocus;
      end;
   end;
end;

procedure TLoginScene.EdNewOnEnter (Sender: TObject);
var
   hx, hy: integer;
begin
   FrmDlg.NAHelps.Clear;
   hx := TEdit(Sender).Left + TEdit(Sender).Width + 10;
   hy := TEdit(Sender).Top + TEdit(Sender).Height - 18;
   if Sender = m_EdNewId then begin
      FrmDlg.NAHelps.Add ('您的帐号名称可以包括：');
      FrmDlg.NAHelps.Add ('字符、数字的组合。');
      FrmDlg.NAHelps.Add ('帐号名称长度必须为4或以上。');
      FrmDlg.NAHelps.Add ('登陆帐号并游戏中的人物名称。');
      FrmDlg.NAHelps.Add ('请仔细输入创建帐号所需信息。');
      FrmDlg.NAHelps.Add ('您的登陆帐号可以登陆游戏');
      FrmDlg.NAHelps.Add ('及我们网站，以取得一些相关信息。');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('建议您的登陆帐号不要与游戏中的角');
      FrmDlg.NAHelps.Add ('色名相同，');
      FrmDlg.NAHelps.Add ('以确保你的密码不会被爆力破解。');
   end;
   if Sender = m_EdNewPasswd then begin
      FrmDlg.NAHelps.Add ('您的密码可以是字符及数字的组合，');
      FrmDlg.NAHelps.Add ('但密码长度必须至少4位。');
      FrmDlg.NAHelps.Add ('建议您的密码内容不要过于简单，');
      FrmDlg.NAHelps.Add ('以防被人猜到。');
      FrmDlg.NAHelps.Add ('请记住您输入的密码，如果丢失密码');
      FrmDlg.NAHelps.Add ('将无法登录游戏。');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('');
   end;
   if Sender = m_EdConfirm then begin
      FrmDlg.NAHelps.Add ('再次输入密码');
      FrmDlg.NAHelps.Add ('以确认。');
      FrmDlg.NAHelps.Add ('');
   end;
   if Sender = m_EdYourName then begin
      FrmDlg.NAHelps.Add ('请输入您的全名.');
      FrmDlg.NAHelps.Add ('');
   end;
   if Sender = m_EdSSNo then begin
      FrmDlg.NAHelps.Add ('请输入你的身份证号');
      FrmDlg.NAHelps.Add ('例如： 720101-146720');
      FrmDlg.NAHelps.Add ('');
   end;
   if Sender = m_EdBirthDay then begin
      FrmDlg.NAHelps.Add ('请输入您的出生年月');
      FrmDlg.NAHelps.Add ('例如：1985/08/13');
      FrmDlg.NAHelps.Add ('');
   end;
   if (Sender = m_EdQuiz1) or (Sender = m_EdQuiz2) then begin
      FrmDlg.NAHelps.Add ('请输入一个密码提示问题');
      FrmDlg.NAHelps.Add ('这个提示将用于密码丢失后找');
      FrmDlg.NAHelps.Add ('回密码用。');
      FrmDlg.NAHelps.Add ('');
   end;
   if (Sender = m_EdAnswer1) or (Sender = m_EdAnswer2) then begin
      FrmDlg.NAHelps.Add ('请输入上面问题的');
      FrmDlg.NAHelps.Add ('答案。');
      FrmDlg.NAHelps.Add ('');
   end;
   if (Sender=m_EdYourName) or (Sender=m_EdSSNo) or (Sender=m_EdQuiz1) or (Sender=m_EdQuiz2) or (Sender=m_EdAnswer1) or (Sender=m_EdAnswer2) then begin
      FrmDlg.NAHelps.Add ('您输入的信息必须真实正确的信息');
      FrmDlg.NAHelps.Add ('如果使用了虚假的注册信息');
      FrmDlg.NAHelps.Add ('您的帐号将被取消。');
      FrmDlg.NAHelps.Add ('');
   end;

   if Sender = m_EdPhone then begin
      FrmDlg.NAHelps.Add ('请输入您的电话号码。');
      FrmDlg.NAHelps.Add ('');
   end;
   if Sender = m_EdMobPhone then begin
      FrmDlg.NAHelps.Add ('请输入您的手机号码。');
      FrmDlg.NAHelps.Add ('');
   end;
   if Sender = m_EdEMail then begin
      FrmDlg.NAHelps.Add ('请输入你的电子邮件帐号。');
      FrmDlg.NAHelps.Add ('你的电子邮件将会用来存取');
      FrmDlg.NAHelps.Add ('一些我们的服务。你能得到');
      FrmDlg.NAHelps.Add ('最新的更新资料。');
      FrmDlg.NAHelps.Add ('');
   end;
end;

procedure TLoginScene.HideLoginBox;
begin
   //EdId.Visible := FALSE;
   //EdPasswd.Visible := FALSE;
   //FrmDlg.DLogin.Visible := FALSE;
   ChangeLoginState (lsCloseAll);
end;

procedure TLoginScene.OpenLoginDoor;
begin
   m_boNowOpening := TRUE;
   m_dwStartTime := GetTickCount;
   HideLoginBox;
   PlaySound (s_rock_door_open);
end;

procedure TLoginScene.PlayScene (MSurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
   if m_boOpenFirst then begin
      m_boOpenFirst := FALSE;
      m_EdId.Visible := TRUE;
      m_EdPasswd.Visible := TRUE;
      m_EdId.SetFocus;
   end;
{$IF CUSTOMLIBFILE = 1}
   d := g_WMainImages.Images[83];
{$ELSE}
   d := g_WChrSelImages.Images[0];
{$IFEND}
   if d <> nil then begin
      MSurface.Draw ((SCREENWIDTH - 800) div 2, (SCREENHEIGHT - 600) div 2, d.ClientRect, d, FALSE);
   end;
   if m_boNowOpening then begin
//开门速度
      if GetTickCount - m_dwStartTime > 50 then begin
         m_dwStartTime := GetTickCount;
         Inc (m_nCurFrame);
      end;
      if m_nCurFrame >= m_nMaxFrame-1 then begin
         m_nCurFrame := m_nMaxFrame-1;
         if not g_boDoFadeOut and not g_boDoFadeIn then begin
            g_boDoFadeOut := TRUE;
            g_boDoFadeIn := TRUE;
            g_nFadeIndex := 29;
         end; 
      end;
{$IF CUSTOMLIBFILE = 1}
      d := g_WMainImages.Images[m_nCurFrame+84];
{$ELSE}
      d := g_WChrSelImages.Images[m_nCurFrame];
{$IFEND}
      if d <> nil then
         MSurface.Draw (0, 0, d.ClientRect, d, TRUE);

      if g_boDoFadeOut then begin
         if g_nFadeIndex <= 1 then begin
            g_WMainImages.ClearCache;
            g_WChrSelImages.ClearCache;
            DScreen.ChangeScene (stSelectChr);
         end;
      end;
   end;
end;

procedure TLoginScene.ChangeLoginState (state: TLoginState);
var
   i, focus: integer;
   c: TControl;
begin
   focus := -1;
   case state of
      lsLogin: focus := 10;
      lsNewIdRetry, lsNewId: focus := 11;
      lsChgpw: focus := 12;
      lsCloseAll: focus := -1;
   end;
   with FrmMain do begin
      for i:=0 to ControlCount-1 do begin
         c := Controls[i];
         if c is TEdit then begin
            if c.Tag in [10..12] then begin
               if c.Tag = focus then begin
                  c.Visible := TRUE;
                  TEdit(c).Text := '';
               end else begin
                  c.Visible := FALSE;
                  TEdit(c).Text := '';
               end;
            end;
         end;
      end;
      if EnglishVersion then  //检测是否为英文版本.
         m_EdSSNo.Visible := FALSE;

      case state of
         lsLogin:
            begin
               FrmDlg.DNewAccount.Visible := FALSE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := TRUE;
               FrmDlg.DInputKey.Visible := TRUE;
               if m_EdId.Visible then m_EdId.SetFocus;
            end;
         lsNewIdRetry,
         lsNewId:
            begin
               if m_boUpdateAccountMode then
                  m_EdNewId.Enabled := FALSE
               else
                  m_EdNewId.Enabled := TRUE;
               FrmDlg.DNewAccount.Visible := TRUE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := FALSE;
               FrmDlg.DInputKey.Visible := FALSE;
               if m_EdNewId.Visible and m_EdNewId.Enabled then begin
                  m_EdNewId.SetFocus;
               end else begin
                  if m_EdConfirm.Visible and m_EdConfirm.Enabled then
                     m_EdConfirm.SetFocus;
               end;
            end;
         lsChgpw:
            begin
               FrmDlg.DNewAccount.Visible := FALSE;
               FrmDlg.DChgPw.Visible := TRUE;
               FrmDlg.DLogin.Visible := FALSE;
               FrmDlg.DInputKey.Visible := FALSE;
               if m_EdChgId.Visible then m_EdChgId.SetFocus;
            end;
         lsCloseAll:
            begin
               FrmDlg.DNewAccount.Visible := FALSE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := FALSE;
               FrmDlg.DInputKey.Visible := FALSE;
            end;
      end;
   end;
end;

procedure TLoginScene.NewClick;
begin
   m_boUpdateAccountMode := FALSE;
   FrmDlg.NewAccountTitle := '';
   ChangeLoginState (lsNewId);
end;

procedure TLoginScene.NewIdRetry (boupdate: Boolean);
begin
   m_boUpdateAccountMode := boupdate;
   ChangeLoginState (lsNewidRetry);
   m_EdNewId.Text     := m_NewIdRetryUE.sAccount;
   m_EdNewPasswd.Text := m_NewIdRetryUE.sPassword;
   m_EdYourName.Text  := m_NewIdRetryUE.sUserName;
   m_EdSSNo.Text      := m_NewIdRetryUE.sSSNo;
   m_EdQuiz1.Text     := m_NewIdRetryUE.sQuiz;
   m_EdAnswer1.Text   := m_NewIdRetryUE.sAnswer;
   m_EdPhone.Text     := m_NewIdRetryUE.sPhone;
   m_EdEMail.Text     := m_NewIdRetryUE.sEMail;
   m_EdQuiz2.Text     := m_NewIdRetryAdd.sQuiz2;
   m_EdAnswer2.Text   := m_NewIdRetryAdd.sAnswer2;
   m_EdMobPhone.Text  := m_NewIdRetryAdd.sMobilePhone;
   m_EdBirthDay.Text  := m_NewIdRetryAdd.sBirthDay;
end;

procedure TLoginScene.UpdateAccountInfos (ue: TUserEntry);
begin
   m_NewIdRetryUE := ue;
   FillChar (m_NewIdRetryAdd, sizeof(TUserEntryAdd), #0);
   m_boUpdateAccountMode := TRUE;
   NewIdRetry (TRUE);
   FrmDlg.NewAccountTitle := '(请完成帐户的所有必需资料的填写)';
end;

procedure TLoginScene.OkClick;
var
   key: char;
begin
   key := #13;
   EdLoginPasswdKeyPress (self, key);
end;

procedure TLoginScene.ChgPwClick;
begin
   ChangeLoginState (lsChgPw);
end;

function  TLoginScene.CheckUserEntrys: Boolean;
begin
   Result := FALSE;
   m_EdNewId.Text := Trim(m_EdNewId.Text);
   m_EdQuiz1.Text := Trim(m_EdQuiz1.Text);
   m_EdYourName.Text := Trim(m_EdYourName.Text);
   if not NewIdCheckNewId then exit;
   if not EnglishVersion then begin
      if not NewIdCheckSSNo then
         exit;
   end;
   if not NewIdCheckBirthday then exit;
   if Length(m_EdNewId.Text) < 3 then begin
      m_EdNewId.SetFocus;
      exit;
   end;
   if Length(m_EdNewPasswd.Text) < 3 then begin
      m_EdNewPasswd.SetFocus;
      exit;
   end;
   if m_EdNewPasswd.Text <> m_EdConfirm.Text then begin
      m_EdConfirm.SetFocus;
      exit;
   end;
   if Length(m_EdQuiz1.Text) < 1 then begin
      m_EdQuiz1.SetFocus;
      exit;
   end;
   if Length(m_EdAnswer1.Text) < 1 then begin
      m_EdAnswer1.SetFocus;
      exit;
   end;
   if Length(m_EdQuiz2.Text) < 1 then begin
      m_EdQuiz2.SetFocus;
      exit;
   end;
   if Length(m_EdAnswer2.Text) < 1 then begin
      m_EdAnswer2.SetFocus;
      exit;
   end;
   if Length(m_EdYourName.Text) < 1 then begin
      m_EdYourName.SetFocus;
      exit;
   end;
   if not EnglishVersion then begin
      if Length(m_EdSSNo.Text) < 1 then begin
         m_EdSSNo.SetFocus;
         exit;
      end;
   end;
   Result := TRUE;
end;

procedure TLoginScene.NewAccountOk;
var
   ue: TUserEntry;
   ua: TUserEntryAdd;
begin
   if CheckUserEntrys then begin
      FillChar (ue, sizeof(TUserEntry), #0);
      FillChar (ua, sizeof(TUserEntryAdd), #0);
      ue.sAccount := LowerCase(m_EdNewId.Text);
      ue.sPassword := m_EdNewPasswd.Text;
      ue.sUserName := m_EdYourName.Text;

      if not EnglishVersion then
         ue.sSSNo := m_EdSSNo.Text
      else
          ue.sSSNo := '650101-1455111';

      ue.sQuiz := m_EdQuiz1.Text;
      ue.sAnswer := Trim(m_EdAnswer1.Text);
      ue.sPhone := m_EdPhone.Text;
      ue.sEMail := Trim(m_EdEMail.Text);

      ua.sQuiz2 := m_EdQuiz2.Text;
      ua.sAnswer2 := Trim(m_EdAnswer2.Text);
      ua.sBirthday := m_EdBirthDay.Text;
      ua.sMobilePhone := m_EdMobPhone.Text;

      m_NewIdRetryUE := ue;
      m_NewIdRetryUE.sAccount := '';
      m_NewIdRetryUE.sPassword := '';
      m_NewIdRetryAdd := ua;

      if not m_boUpdateAccountMode then
         FrmMain.SendNewAccount (ue, ua)
      else
         FrmMain.SendUpdateAccount (ue, ua);
      m_boUpdateAccountMode := FALSE;
      NewAccountClose;
   end;
end;

procedure TLoginScene.NewAccountClose;
begin
   if not m_boUpdateAccountMode then
      ChangeLoginState (lsLogin);
end;

procedure TLoginScene.ChgpwOk;
var
   uid, passwd, newpasswd: string;
begin
   if m_EdChgNewPw.Text = m_EdChgRepeat.Text then begin
      uid := m_EdChgId.Text;
      passwd := m_EdChgCurrentpw.Text;
      newpasswd := m_EdChgNewPw.Text;
      FrmMain.SendChgPw (uid, passwd, newpasswd);
      ChgpwCancel;
   end else begin
      FrmDlg.DMessageDlg ('二次输入的密码不匹配！', [mbOk]);
      m_EdChgNewPw.SetFocus;
   end;
end;

procedure TLoginScene.ChgpwCancel;
begin
   ChangeLoginState (lsLogin);
end;


{-------------------- TSelectChrScene ------------------------}

constructor TSelectChrScene.Create;
begin
   CreateChrMode := FALSE;
   FillChar (ChrArr, sizeof(TSelChar)*3, #0);
   ChrArr[0].FreezeState := TRUE;
   ChrArr[1].FreezeState := TRUE;
   ChrArr[2].FreezeState := TRUE;   
   NewIndex := 0;
   EdChrName := TEdit.Create (FrmMain.Owner);
   with EdChrName do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      ImeMode := LocalLanguage;
      MaxLength := 14;
      Visible := FALSE;
      OnKeyPress := EdChrnameKeyPress;
   end;
   SoundTimer := TTimer.Create (FrmMain.Owner);
   with SoundTimer do begin
      OnTimer := SoundOnTimer;
      Interval := 1;
      Enabled := FALSE;
   end;
   inherited Create (stSelectChr);
end;

destructor TSelectChrScene.Destroy;
begin
   inherited Destroy;
end;

procedure TSelectChrScene.OpenScene;
begin
   FrmDlg.DSelectChr.Visible := TRUE;
   SoundTimer.Enabled := TRUE;
   SoundTimer.Interval := 1;
   m_boNowLoading := FALSE;
end;

procedure TSelectChrScene.CloseScene;
begin
   SilenceSound;
//   m_boNowLoading := FALSE;
   FrmDlg.DSelectChr.Visible := FALSE;
   SoundTimer.Enabled := FALSE;
end;

procedure TSelectChrScene.SoundOnTimer (Sender: TObject);
begin
   PlayBGM (bmg_select);
   SoundTimer.Enabled := FALSE;
   //SoundTimer.Interval := 38 * 1000;
end;

procedure TSelectChrScene.SelChrSelect1Click;
begin
   if (not ChrArr[0].Selected) and (ChrArr[0].Valid) then begin
      OldIndex := 0;
      FrmMain.SelectChr(ChrArr[0].UserChr.Name);
      ChrArr[0].Selected := TRUE;
      ChrArr[1].Selected := FALSE;
      ChrArr[2].Selected := FALSE;      
      ChrArr[0].Unfreezing := TRUE;
      ChrArr[0].AniIndex := 0;
      ChrArr[0].DarkLevel := 0;
      ChrArr[0].EffIndex := 0;
      ChrArr[0].StartTime := GetTickCount;
      ChrArr[0].MoreTime := GetTickCount;
      ChrArr[0].StartEffTime := GetTickCount;
      PlaySound (s_meltstone);
   end;
end;

procedure TSelectChrScene.SelChrSelect2Click;
begin
   if (not ChrArr[1].Selected) and (ChrArr[1].Valid) then begin
      OldIndex := 1;
      FrmMain.SelectChr(ChrArr[1].UserChr.Name);
      ChrArr[0].Selected := FALSE;
      ChrArr[1].Selected := TRUE;
      ChrArr[2].Selected := FALSE;
      ChrArr[1].Unfreezing := TRUE;
      ChrArr[1].AniIndex := 0;
      ChrArr[1].DarkLevel := 0;
      ChrArr[1].EffIndex := 0;
      ChrArr[1].StartTime := GetTickCount;
      ChrArr[1].MoreTime := GetTickCount;
      ChrArr[1].StartEffTime := GetTickCount;
      PlaySound (s_meltstone);
   end;
end;

procedure TSelectChrScene.SelChrSelect3Click;
begin
   if (not ChrArr[2].Selected) and (ChrArr[2].Valid) then begin
      OldIndex := 2;   
      FrmMain.SelectChr(ChrArr[2].UserChr.Name);
      ChrArr[0].Selected := FALSE;
      ChrArr[1].Selected := FALSE;
      ChrArr[2].Selected := TRUE;
      ChrArr[2].Unfreezing := TRUE;
      ChrArr[2].AniIndex := 0;
      ChrArr[2].DarkLevel := 0;
      ChrArr[2].EffIndex := 0;
      ChrArr[2].StartTime := GetTickCount;
      ChrArr[2].MoreTime := GetTickCount;
      ChrArr[2].StartEffTime := GetTickCount;
      PlaySound (s_meltstone);
   end;
end;

procedure TSelectChrScene.SelChrStartClick;
var
  chrname: string;
begin
   chrname := '';
   if ChrArr[0].Valid and ChrArr[0].Selected then chrname := ChrArr[0].UserChr.Name;
   if ChrArr[1].Valid and ChrArr[1].Selected then chrname := ChrArr[1].UserChr.Name;
   if ChrArr[2].Valid and ChrArr[2].Selected then chrname := ChrArr[2].UserChr.Name;   
   if chrname <> '' then begin
      SelectChrScene.OpenLoading;
      FrmDlg.DSelectChr.Visible := FALSE;
      FrmMain.SendSelChr (chrname);
   end else
      FrmDlg.DMessageDlg ('还没创建游戏角色！\点击<NEW CHARACTER>按钮创建一个游戏角色。', [mbOk]);
end;

procedure TSelectChrScene.SelChrNewChrClick;
begin
   if not ChrArr[0].Valid or not ChrArr[1].Valid or not ChrArr[2].Valid then begin
      if not ChrArr[0].Valid then MakeNewChar (0)
      else if not ChrArr[1].Valid then MakeNewChar (1)
      else MakeNewChar (2);
   end else
      FrmDlg.DMessageDlg ('一个帐号最多只能创建三个游戏角色！', [mbOk]);
end;

procedure TSelectChrScene.SelChrEraseChrClick;
var
   n: integer;
begin
   n := 0;
   if ChrArr[0].Valid and ChrArr[0].Selected then n := 0;
   if ChrArr[1].Valid and ChrArr[1].Selected then n := 1;
   if ChrArr[2].Valid and ChrArr[2].Selected then n := 2;   
   if (ChrArr[n].Valid) and (not ChrArr[n].FreezeState) and (ChrArr[n].UserChr.Name <> '') then begin

      if mrYes = FrmDlg.DMessageDlg ('"' + ChrArr[n].UserChr.Name + '" 角色删除后不能恢复，\' +
                                                                    '你将不能使用同样的角色名字，\'+
                                                                    '你真的要删除你的角色吗？', [mbYes, mbNo, mbCancel]) then
         FrmMain.SendDelChr (ChrArr[n].UserChr.Name);
   end;
end;

procedure TSelectChrScene.SelChrCreditsClick;
var
  msgStr: String;
begin
  msgStr := '';
  msgStr := msgStr+'Lom2开发团队\';
  msgStr := msgStr+'----------\';
  msgStr := msgStr+'lom2\';
  msgStr := msgStr+'----------\';
  msgStr := msgStr+'http://www.lom2.net\';
  msgStr := msgStr+'----------\';

  FrmDlg.DialogSize := 2;
  FrmDlg.DMessageDlg(msgstr, [mbOk])
end;

procedure TSelectChrScene.SelChrExitClick;
begin
   FrmMain.Close;
end;

procedure TSelectChrScene.ClearChrs;
begin
   FillChar (ChrArr, sizeof(TSelChar)*3, #0);
   ChrArr[0].FreezeState := FALSE;
   ChrArr[1].FreezeState := TRUE;
   ChrArr[2].FreezeState := TRUE;
   ChrArr[0].Selected := TRUE;
   ChrArr[1].Selected := FALSE;
   ChrArr[2].Selected := FALSE;
   ChrArr[0].UserChr.Name := '';
   ChrArr[1].UserChr.Name := '';
   ChrArr[2].UserChr.Name := '';
end;

procedure TSelectChrScene.AddChr (uname: string; job, hair, level, sex: integer);
var
   n: integer;
begin
   if not ChrArr[0].Valid then n := 0
   else if not ChrArr[1].Valid then n := 1
   else if not ChrArr[2].Valid then n := 2   
   else exit;
   ChrArr[n].UserChr.Name := uname;
   ChrArr[n].UserChr.Job := job;
   ChrArr[n].UserChr.Hair := hair;
   ChrArr[n].UserChr.Level := level;
   ChrArr[n].UserChr.Sex := sex;
   ChrArr[n].Valid := TRUE;

end;

procedure TSelectChrScene.MakeNewChar (index: integer);
begin
   CreateChrMode := TRUE;
   NewIndex := index;
{   if index = 0 then begin
      FrmDlg.DCreateChr.Left := 415;
      FrmDlg.DCreateChr.Top := 15;
   end else begin}
      FrmDlg.DCreateChr.Left := 75;
      FrmDlg.DCreateChr.Top := 15;
{   end;}
   FrmDlg.DCreateChr.Visible := TRUE;
   ChrArr[NewIndex].Valid := TRUE;
   ChrArr[NewIndex].IsCreating := True;
   ChrArr[NewIndex].FreezeState := FALSE;
   EdChrName.Left := FrmDlg.DCreateChr.Left + 387;
   EdChrName.Top  := FrmDlg.DCreateChr.Top + 140;
   EdChrName.Visible := TRUE;
   EdChrName.SetFocus;
   SelectChr (NewIndex);
   FillChar (ChrArr[NewIndex].UserChr, sizeof(TUserCharacterInfo), #0);
end;

procedure TSelectChrScene.EdChrnameKeyPress (Sender: TObject; var Key: Char);
begin

end;


procedure TSelectChrScene.SelectChr (index: integer);
begin
   ChrArr[index].Selected := TRUE;
   ChrArr[index].DarkLevel := 30;
   ChrArr[index].StartTime := GetTickCount;
   ChrArr[index].Moretime := GetTickCount;

   ChrArr[0].Selected := (index = 0);
   ChrArr[1].Selected := (index = 1);
   ChrArr[2].Selected := (index = 2);
end;

procedure TSelectChrScene.SelChrNewClose;
begin
   ChrArr[NewIndex].Valid := FALSE;
   CreateChrMode := FALSE;
   FrmDlg.DCreateChr.Visible := FALSE;
   EdChrName.Visible := FALSE;

   ChrArr[0].Selected := (oldindex = 0);
   ChrArr[0].FreezeState := not (oldindex = 0);
   ChrArr[1].Selected := (oldindex = 1);
   ChrArr[1].FreezeState := not (oldindex = 1);
   ChrArr[2].Selected := (oldindex = 2);
   ChrArr[2].FreezeState := not (oldindex = 2);
end;

procedure TSelectChrScene.SelChrNewOk;
var
   chrname, shair, sjob, ssex: string;
begin
   chrname := Trim(EdChrName.Text);
   if chrname <> '' then begin
      ChrArr[NewIndex].IsCreating := False;   
      ChrArr[NewIndex].Valid := FALSE;
      CreateChrMode := FALSE;
      FrmDlg.DCreateChr.Visible := FALSE;
      EdChrName.Visible := FALSE;

      ChrArr[0].Selected := (oldindex = 0);
      ChrArr[0].FreezeState := not (oldindex = 0);
      ChrArr[1].Selected := (oldindex = 1);
      ChrArr[1].FreezeState := not (oldindex = 1);
      ChrArr[2].Selected := (oldindex = 2);
      ChrArr[2].FreezeState := not (oldindex = 2);

      shair := IntToStr(1 + Random(5)); //////****IntToStr(ChrArr[NewIndex].UserChr.Hair);
      sjob  := IntToStr(ChrArr[NewIndex].UserChr.Job);
      ssex  := IntToStr(ChrArr[NewIndex].UserChr.Sex);
      FrmMain.SendNewChr (FrmMain.LoginId, chrname, shair, sjob, ssex);
   end;
end;

procedure TSelectChrScene.SelChrNewJob (job: integer);
begin
   if (job in [0..2]) and (ChrArr[NewIndex].UserChr.Job <> job) then begin
      ChrArr[NewIndex].UserChr.Job := job;
      SelectChr (NewIndex);
   end;
end;

procedure TSelectChrScene.SelChrNewm_btSex (sex: integer);
begin
   if sex <> ChrArr[NewIndex].UserChr.Sex then begin
      ChrArr[NewIndex].UserChr.Sex := sex;
      SelectChr (NewIndex);
   end;
end;

procedure TSelectChrScene.SelChrNewPrevHair;
begin
end;

procedure TSelectChrScene.SelChrNewNextHair;
begin
end;

procedure TSelectChrScene.OpenLoading;
begin
   m_boNowLoading := TRUE;
   m_LoadingWaitTime := GetTickCount;
   m_LoadingTime := GetTickCount;
   HideSelectChrBox;
   LoadHelp1;
   LoadHelp2;
end;

procedure TSelectChrScene.LoadHelp1;
var
  indexHelp1: Integer;
begin
  Randomize;
  indexHelp1 := Random(25);
  if m_boNowLoading then begin
    case indexHelp1 of
      0: begin
          Help1 := 0;
          exit;
        end;
      1: begin
          Help1 := 1;
          exit;
        end;
      2: begin
          Help1 := 2;
          exit;
        end;
      3: begin
          Help1 := 3;
          exit;
        end;
      4: begin
          Help1 := 4;
          exit;
        end;
      5: begin
          Help1 := 5;
          exit;
        end;
      6: begin
          Help1 := 6;
          exit;
        end;
      7: begin
          Help1 := 7;
          exit;
        end;
      8: begin
          Help1 := 8;
          exit;
        end;
      9: begin
          Help1 := 9;
          exit;
        end;
      10: begin
          Help1 := 10;
          exit;
        end;
      11: begin
          Help1 := 11;
          exit;
        end;
      12: begin
          Help1 := 12;
          exit;
        end;
      13: begin
          Help1 := 13;
          exit;
        end;
      14: begin
          Help1 := 14;
          exit;
        end;
    end;
  end;
end;

procedure TSelectChrScene.LoadHelp2;
var
  indexHelp2: Integer;
begin
  Randomize;
  indexHelp2 := Random(29);
  if m_boNowLoading then begin
    case indexHelp2 of
      0: begin
          Help2 := 0;
          exit;
        end;
      1: begin
          Help2 := 1;
          exit;
        end;
      2: begin
          Help2 := 2;
          exit;
        end;
      3: begin
          Help2 := 3;
          exit;
        end;
      4: begin
          Help2 := 4;
          exit;
        end;
      5: begin
          Help2 := 5;
          exit;
        end;
      6: begin
          Help2 := 6;
          exit;
        end;
      7: begin
          Help2 := 7;
          exit;
        end;
      8: begin
          Help2 := 8;
          exit;
        end;
      9: begin
          Help2 := 9;
          exit;
        end;
      10: begin
          Help2 := 10;
          exit;
        end;
      11: begin
          Help2 := 11;
          exit;
        end;
      12: begin
          Help2 := 12;
          exit;
        end;
      13: begin
          Help2 := 13;
          exit;
        end;
      14: begin
          Help2 := 14;
          exit;
        end;
      15: begin
          Help2 := 15;
          exit;
        end;
      16: begin
          Help2 := 16;
          exit;
        end;
      17: begin
          Help2 := 17;
          exit;
        end;
      18: begin
          Help2 := 18;
          exit;
        end;
      19: begin
          Help2 := 19;
          exit;
        end;
      20: begin
          Help2 := 20;
          exit;
        end;
      21: begin
          Help2 := 21;
          exit;
        end;
      22: begin
          Help2 := 22;
          exit;
        end;
      23: begin
          Help2 := 23;
          exit;
        end;
      24: begin
          Help2 := 24;
          exit;
        end;
      25: begin
          Help2 := 25;
          exit;
        end;
      26: begin
          Help2 := 26;
          exit;
        end;
      27: begin
          Help2 := 27;
          exit;
        end;
      28: begin
          Help2 := 28;
          exit;
        end;
    end;
  end;
end;


procedure TSelectChrScene.HideSelectChrBox;
var
  indexNumber: Integer;
begin
  m_nCurFrame := 0;
  m_nMaxFrame := 10;
  Randomize;
  indexNumber := Random(3);
  if m_boNowLoading then begin
    case indexNumber of
      0: begin
          Numbert := 930;
          exit;
        end;
      1: begin
          Numbert := 931;
          exit;
        end;
      2: begin
          Numbert := 932;
          exit;
        end;
    end;
  end;
  if not g_boDoFadeOut and not g_boDoFadeIn then begin
     g_boDoFastFadeOut := TRUE;
     g_nFadeIndex := 29;
     m_boNowLoading := FALSE;
  end;
end;

procedure TSelectChrScene.PlayScene (MSurface: TDirectDrawSurface);
var
   n, bx, by, fx, fy, img: integer;
   ex, ey:Integer; //选择人物时显示的效果光位置
   d, e, f, g, dd: TDirectDrawSurface;
   ax, ay: integer;
   cx,cy: integer;
   svname: string;
begin
   bx:=0;
   by:=0;
   fx:=0;
   fy:=0;
{$IF SWH = SWH800}
   d := g_WMainImages.Images[65];
{$ELSEIF SWH = SWH1024}
   d := g_WMainImages.Images[65];
{$IFEND}
   //显示选择人物背景画面
   if d <> nil then begin
      MSurface.Draw ((SCREENWIDTH - d.Width) div 2,(SCREENHEIGHT - d.Height) div 2, d.ClientRect, d, FALSE);

   end;
   for n:=0 to 2 do begin
      if (not ChrArr[n].Valid) or (ChrArr[n].IsCreating) then begin
        d := nil;
        d := g_WMainImages.Images[44];
        if (not m_boNowLoading) then begin
        cy := 19;
        case n of
          0: begin
            cx := 47;
          end;
          1: begin
            cx := 286;
          end;
          2: begin
            cx := 526;
          end;
        end;
        end;
        MSurface.Draw (cx,cy, d.ClientRect, d, FALSE);
      end;

      if ChrArr[n].Valid then begin
         ex := (SCREENWIDTH - 800) div 2 + 90;
         ey := (SCREENHEIGHT - 600) div 2 + 58;
         case ChrArr[n].UserChr.Job of
            0: begin
               if ChrArr[n].UserChr.Sex = 0 then begin
                  bx := (SCREENWIDTH - 800) div 2 + 138;
                  by := (SCREENHEIGHT - 600) div 2 + 211;
                  fx := bx;
                  fy := by;
               end else begin
                  bx := (SCREENWIDTH - 800) div 2 + 121;
                  by := (SCREENHEIGHT - 600) div 2 + 197;
                  fx := bx;
                  fy := by;
               end;
            end;
            1: begin
               if ChrArr[n].UserChr.Sex = 0 then begin
                  bx := (SCREENWIDTH - 800) div 2 + 130;
                  by := (SCREENHEIGHT - 600) div 2 + 200;
                  fx := bx;
                  fy := by;
               end else begin
                  bx := (SCREENWIDTH - 800) div 2 + 135;
                  by := (SCREENHEIGHT - 600) div 2 + 217;
                  fx := bx;
                  fy := by;
               end;
            end;
            2: begin
               if ChrArr[n].UserChr.Sex = 0 then begin
                  bx := (SCREENWIDTH - 800) div 2 + 138;
                  by := (SCREENHEIGHT - 600) div 2 + 205;
                  fx := bx;
                  fy := by;
               end else begin
                  bx := (SCREENWIDTH - 800) div 2 + 130;
                  by := (SCREENHEIGHT - 600) div 2 + 229;
                  fx := bx;
                  fy := by;
               end;
            end;
         end;
         if n > 0 then begin
            ex := (SCREENWIDTH - 800) div 2;
            ey := (SCREENHEIGHT - 600) div 2;
            bx := bx + 240*n;
            by := by;
            fx := fx + 240*n;
            fy := fy ;
         end;
         if ChrArr[n].Unfreezing then begin
            img := 40 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
            d := g_WChrSelImages.Images[img + ChrArr[n].aniIndex];
            d := g_WChrSelImages.GetCachedImage((img + ChrArr[n].aniIndex), ax, ay);
            //e := g_WChrSelImages.Images[4 + ChrArr[n].effIndex];
            if (d <> nil) and (not ChrArr[n].IsCreating) then MSurface.Draw (bx + ax , by + ay, d.ClientRect, d, TRUE);
            //if e <> nil then DrawBlend (MSurface, ex, ey, e, 1);
            if GetTickCount - ChrArr[n].StartTime > 50{120} then begin
               ChrArr[n].StartTime := GetTickCount;
               ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
            end;
            if GetTickCount - ChrArr[n].startefftime >50{ 110} then begin
               ChrArr[n].startefftime := GetTickCount;
               ChrArr[n].effIndex := ChrArr[n].effIndex + 1;
               //if ChrArr[n].effIndex > EFFECTFRAME-1 then
               //   ChrArr[n].effIndex := EFFECTFRAME-1;
            end;
            if ChrArr[n].aniIndex > FREEZEFRAME-1 then begin
               ChrArr[n].Unfreezing := FALSE;
               ChrArr[n].FreezeState := FALSE;
               ChrArr[n].aniIndex := 0;
            end;
         end else
            if not ChrArr[n].Selected and (not ChrArr[n].FreezeState and not ChrArr[n].Freezing) then begin
               ChrArr[n].Freezing := TRUE;
               ChrArr[n].aniIndex := 0;
               ChrArr[n].StartTime := GetTickCount;
            end;
         if ChrArr[n].Freezing then begin
            img := 40 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
            //d := g_WChrSelImages.Images[img + FREEZEFRAME - ChrArr[n].aniIndex - 1];
            d := g_WChrSelImages.GetCachedImage((img + FREEZEFRAME - ChrArr[n].aniIndex - 1), ax, ay);
            if (d <> nil) and (not ChrArr[n].IsCreating) then MSurface.Draw (bx + ax, by + ay, d.ClientRect, d, TRUE);
            if GetTickCount - ChrArr[n].StartTime > 50 then begin
               ChrArr[n].StartTime := GetTickCount;
               ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
            end;
            if ChrArr[n].aniIndex > FREEZEFRAME-1 then begin
               ChrArr[n].Freezing := FALSE;
               ChrArr[n].FreezeState := TRUE;
               ChrArr[n].aniIndex := 0;
            end;
         end;
         if not ChrArr[n].Unfreezing and not ChrArr[n].Freezing then begin
            if not ChrArr[n].FreezeState then begin
               img := 20 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].aniIndex + ChrArr[n].UserChr.Sex * 120;
               //d := g_WChrSelImages.Images[img];
               d := g_WChrSelImages.GetCachedImage(img, ax, ay);
               if (d <> nil) and (not ChrArr[n].IsCreating) then begin
                  if ChrArr[n].DarkLevel > 0 then begin
                     dd := TDirectDrawSurface.Create (frmMain.DXDraw.DDraw);
                     dd.SystemMemory := TRUE;
                     dd.SetSize (d.Width, d.Height);
                     dd.Draw (0, 0, d.ClientRect, d, FALSE);
                     MakeDark (dd, 30-ChrArr[n].DarkLevel);
                     MSurface.Draw (fx, fy, dd.ClientRect, dd, TRUE);
                     dd.Free;
                  end else
                     MSurface.Draw (fx + ax, fy + ay, d.ClientRect, d, TRUE)
               end;
            end else begin
               img := 40 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
//               d := g_WChrSelImages.Images[img];
               d := g_WChrSelImages.GetCachedImage(img, ax, ay);
               if (d <> nil) and (not ChrArr[n].IsCreating) then
                  MSurface.Draw (bx + ax, by + ay, d.ClientRect, d, TRUE);
            end;
            if ChrArr[n].Selected then begin
               if GetTickCount - ChrArr[n].StartTime > 300 then begin
                  ChrArr[n].StartTime := GetTickCount;
                  ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
                  if ChrArr[n].aniIndex > SELECTEDFRAME-1 then
                     ChrArr[n].aniIndex := 0;
               end;
               if GetTickCount - ChrArr[n].moretime > 25 then begin
                  ChrArr[n].moretime := GetTickCount;
                  if ChrArr[n].DarkLevel > 0 then
                     ChrArr[n].DarkLevel := ChrArr[n].DarkLevel - 1;
               end;
            end;
         end;
         //显示选择角色时人物名称等级
            if (ChrArr[n].UserChr.Name <> '') and (ChrArr[n].Selected) then begin
               with MSurface do begin
                  SetBkMode (Canvas.Handle, TRANSPARENT);
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 167, (SCREENHEIGHT - 600) div 2 + 458, clWhite, clBlack, inttostr(n+1));
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 167, (SCREENHEIGHT - 600) div 2 + 484, clWhite, clBlack, ChrArr[n].UserChr.Name);
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 167, (SCREENHEIGHT - 600) div 2 + 510, clWhite, clBlack, IntToStr(ChrArr[n].UserChr.Level));
                  BoldTextOut (MSurface, (SCREENWIDTH - 800) div 2 + 167, (SCREENHEIGHT - 600) div 2 + 536, clWhite, clBlack, GetJobName(ChrArr[n].UserChr.Job));
                  Canvas.Release;
               end;
            end;
        if m_boNowLoading then begin
           d := g_WMainImages.Images[Numbert];
              if d <> nil then
                MSurface.Draw (0, 0, d.ClientRect, d, TRUE);

           f := g_WMainImages.Images[1010+help1];
              if d <> nil then
                MSurface.Draw ((SCREENWIDTH - f.Width) div 2, (SCREENHEIGHT - f.Height) div 2 -20, f, TRUE);

           g := g_WMainImages.Images[1040+help2];
              if f <> nil then
                MSurface.Draw ((SCREENWIDTH - g.Width) div 2, (SCREENHEIGHT - g.Height) div 2 + 200, g, TRUE);

              if GetTickCount - m_LoadingTime > 80 then begin
                m_LoadingTime := GetTickCount;
                Inc (m_nCurFrame);
              end;

                if m_nCurFrame >= m_nMaxFrame-1 then begin
                   m_nCurFrame := m_nMaxFrame-1;
                   m_nCurFrame := 0;
                end;
               e := g_WMainImages.Images[940 + m_nCurFrame];
                 if e <> nil then
                  MSurface.Draw ((SCREENWIDTH - e.Width) div 2, (SCREENHEIGHT - e.Height) div 2 + 250, e, TRUE);

        end else begin

         with MSurface do begin
            SetBkMode (Canvas.Handle, TRANSPARENT);
            if BO_FOR_TEST then svname := 'ThedeathRules'
            else svname := g_sServerName;
            BoldTextOut (MSurface, SCREENWIDTH div 2 - Canvas.TextWidth(svname) div 2, (SCREENHEIGHT - 600) div 2 + 8, clWhite, clBlack, svname);
            Canvas.Release;
         end;
      end;
   end;
end;
end;

{----------------------------- TLoading ------------------------------}

{constructor TLoading.Create;
begin
   inherited Create (stLoading);
end;

destructor TLoading.Destroy;
begin
   inherited Destroy;
end;

procedure TLoading.OpenScene;
begin
  m_nCurFrame := 0;
  m_nMaxFrame := 10;
end;

procedure TLoading.CloseScene;
begin
end;

procedure TLoading.PlayScene (MSurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  sWil:Integer;
begin
  case Random(3) of
    0:begin
      sWil:=931;
    end;
    1:begin
      sWil:=931;
    end;
    2:begin
      sWil:=931;
    end;
  end;

    d := g_WMainImages.Images[sWil];

    if d <> nil then begin
      MSurface.Draw ((SCREENWIDTH - 800) div 2, (SCREENHEIGHT - 600) div 2, d.ClientRect, d, FALSE);
    end;
end;}

{--------------------------- TLoginNotice ----------------------------}

{constructor TLoginNotice.Create;
begin
   inherited Create (stLoginNotice);
end;

destructor TLoginNotice.Destroy;
begin
   inherited Destroy;
end;}

{---- Adjust global SVN revision ----}
initialization
  SVNRevision('$Id: IntroScn.pas 326 2006-08-24 19:52:54Z Dataforce $');
end.
