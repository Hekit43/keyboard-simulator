unit TrainingUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, LCLType, Common, SettingsUnit;

type

  { TTrainingForm }

  TTrainingForm = class(TForm)
    TimeDisplay: TPanel;
    ErrorDisplay: TPanel;
    AverageDisplay: TPanel;
    inputEdit: TEdit;
    ExitBtn: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MovePanel: TPanel;
    CorrectDisplay: TPanel;
    StartBtn: TBitBtn;
    RestartBtn: TBitBtn;
    StopBtn: TBitBtn;
    Label1: TLabel;
    TimeEdit: TComboBox;
    Panel1: TPanel;
    CountDownTimer: TTimer;
    MoveTimer: TTimer;
    procedure CountDownTimerTimer(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure inputEditChange(Sender: TObject);
    procedure MoveTimerTimer(Sender: TObject);
    procedure RestartBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure TimeEditEditingDone(Sender: TObject);
  private
    procedure DeleteLetterFromList(n: integer);
    procedure StopMoving;
    function EqualLetter(a, b : string):boolean;
  public

  end;

var
  TrainingForm: TTrainingForm;
  LetterList: TList;
  LevelIntervals: array [0..2] of Integer = (50, 25, 15);

implementation

{$R *.lfm}

{ TTrainingForm }

var
  RusCapitalLetters: array of string = ('А', 'Б', 'В', 'Г', 'Д',
    'Е', 'Ё', 'Ж', 'З', 'И', 'Й', 'К', 'Л', 'М', 'Н', 'О',
    'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ',
    'Ъ', 'Ы', 'Ь', 'Э', 'Ю', 'Я');
  RusLowercaseLetters:array of string = ('а', 'б', 'в', 'г', 'д','е','ё','ж','з','и','й','к','л','м','н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы','ь','э','ю','я');
  EngCapitalLetters:array of string =   ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','Y','W','X','Y','Z');
  EngLowercaseLetters:array of string = ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','y','w','x','y','z');
  Specialcharacters: array of string = ('!','"','’','#','!','@','№',';','$','%',':','^','&','?','*','(',')','-','_','+','=','~','`','[',']','{','}','|','\','/','.','/',',');
  Digitals: array of string =('1','2','3','4','5','6','7','8','9','0');

  prev_letter_time: TTime; // Время появления предыдущей буквы

procedure TTrainingForm.StartBtnClick(Sender: TObject);
begin
  PlaySoundAsync('hitsound.wav');
  RestartBtn.Enabled := True;
  TimeEdit.Enabled := False;
  StartBtn.Enabled := False;
  StopBtn.Enabled := True;
  TimeDisplay.Caption := TimeEdit.Text;
  ErrorDisplay.Caption := '0';
  CorrectDisplay.Caption := '0';
  AverageDisplay.Caption := '0';
  prev_letter_time := -1;
  MoveTimer.Interval:=LevelIntervals[CurrentLevel];
  MoveTimer.Enabled := True;
  CountDownTimer.Enabled := True;
  inputEdit.Clear;
  InputEdit.SetFocus;
end;

procedure TTrainingForm.DeleteLetterFromList(n: integer);
var
  p: ^TLabel;

begin
  p := LetterList[n];
  p^.Free;
  LetterList.Delete(n);
end;

procedure TTrainingForm.StopMoving;
var
  i: integer;
begin
  MoveTimer.Enabled := False;
  CountDownTimer.Enabled := False;
  PlaySoundAsync('hitsound.wav');
  for i := LetterList.Count - 1 downto 0 do
        DeleteLetterFromList(i);
  StartBtn.Enabled := True;
  RestartBtn.Enabled := False;
  StopBtn.Enabled := False;
  TimeEdit.Enabled := True;
end;

procedure TTrainingForm.StopBtnClick(Sender: TObject);
begin
  StopMoving;
  PlaySoundAsync('Endsound.wav');
  MessageDlg('Результаты', 'Правильно: ' + CorrectDisplay.Caption + '  Неправильно: ' + ErrorDisplay.Caption + '  Срзнач: ' + AverageDisplay.Caption,
              mtInformation, [mbOk], '');
end;

procedure TTrainingForm.TimeEditEditingDone(Sender: TObject);
begin
  TimeEdit.Text := IntToStr(StrToIntDef(TimeEdit.Text, 60));
end;

procedure TTrainingForm.FormActivate(Sender: TObject);
begin
  TimeDisplay.Caption := TimeEdit.Text;
end;

procedure TTrainingForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  StopMoving;
end;

procedure TTrainingForm.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  CorrectDisplay.Caption := IntToHex(Ord(Key), 4);
  ErrorDisplay.Caption := IntToHex(key, 4);
end;

function TTrainingForm.EqualLetter(a, b: string):boolean;
begin
  if Settings.UseReg then Result := a = b
  else Result := AnsiUpperCase(a) = AnsiUpperCase(b);
end;

procedure TTrainingForm.inputEditChange(Sender: TObject);
var
  s: string;
  i: integer;
  p: ^TLabel;
  f: boolean;
begin
  s := inputEdit.Text;
  inputEdit.Clear;
  if s <> '' then
  begin
    f := False;
    for i := 0 to LetterList.Count - 1 do
    begin
      p := LetterList[i];
      if EqualLetter(p^.Caption, s) then // Нажата правильная клавиша
      begin
        PlaySoundAsync('CorrectSound.wav');
        DeleteLetterFromList(i);
        // Удаляем символ из списка движения
        f := True;
        break;
      end;
    end;
    if f then
      CorrectDisplay.Caption := IntToStr(StrToIntDef(CorrectDisplay.Caption, 0) + 1)
    else
      begin
        ErrorDisplay.Caption := IntToStr(StrToIntDef(ErrorDisplay.Caption, 0) + 1);
        PlaySoundAsync('ErrorSound.wav');
      end;
  end;
end;

procedure TTrainingForm.CountDownTimerTimer(Sender: TObject);
var
  t, dt, sum, avg: integer;
begin
  inputEdit.SetFocus;
  t := StrToIntDef(TimeDisplay.Caption, 60) - 1;
  TimeDisplay.Text := IntToStr(t);
  if t < 1 then
    StopBtnClick(Sender);
  dt := StrToIntDef(TimeEdit.Text, 60) - t;
  sum := StrToIntDef(CorrectDisplay.Caption, 0) - StrToIntDef(ErrorDisplay.Caption, 0);
  if sum < 0 then
    sum := 0;
  if dt <> 0 then
    avg := Round(sum * 60 / dt)
  else
    avg := 0;
  AverageDisplay.Caption := IntToStr(avg);
end;

procedure TTrainingForm.ExitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TTrainingForm.MoveTimerTimer(Sender: TObject);
const
  delta_y = 1; // Смещение букв за один период таймера

var
  i, NumLetters: integer;
  p, q: ^TLabel;
  f: boolean;
  timeout: boolean = False;
  letter_exist: boolean;
  s: string;
  ls: array of string;
  next_letter_delay:real;

begin
  next_letter_delay:= Settings.Levels[CurrentLevel].Interval / 86400000;
  NumLetters := Settings.Levels[CurrentLevel].NumLetters;
  for i := 0 to LetterList.Count - 1 do
  begin
    p := LetterList[i];
    p^.Top := p^.Top + delta_y;
    timeout := p^.Top + p^.Height > MovePanel.Height;
    if timeout then
    begin
      f := True;
      DeleteLetterFromList(i);
      if f then
      begin
        ErrorDisplay.Caption := IntToStr(StrToIntDef(ErrorDisplay.Caption, 0) + 1);
        PlaySoundAsync('ErrorSound.wav');
      end;
      break;
    end;
  end;
  if (LetterList.Count < NumLetters) and (now - prev_letter_time >
    next_letter_delay) then
  begin
    new(p);
    p^ := TLabel.Create(TrainingForm);
    p^.Top := 0;
    p^.Left := Random(MovePanel.Width - 20);
    letter_exist := False;
    ls:=[];
    if Rus in Settings.Chars then ls:=Concat(RusLowercaseLetters);
    if RusCap in Settings.Chars then ls:=Concat(ls, RusCapitalLetters);
    if Eng in Settings.Chars then ls:=Concat(ls, EngLowercaseLetters);
    if EngCap in Settings.Chars then ls:=Concat(ls, EngCapitalLetters);
    if Spec in Settings.Chars then ls:=Concat(ls, Specialcharacters);
    if Dig in Settings.Chars then ls:=Concat(ls, Digitals);
    if length(ls) > LetterList.Count then // Падающие символы не повторяются,
    // если их меньше, чем количество символов в наборе
    repeat
      s := ls[random(Length(ls))];
      i := 0;
      while i < LetterList.Count do
      begin
        q := LetterList[i];
        letter_exist := q^.Caption = s;
        if letter_exist then
          break;
        inc(i);
      end;
    until not letter_exist // Чтобы не повторялись падающие буквы
    else
        s := ls[random(Length(ls))];
    p^.Caption := s;
    p^.Font.Color := Settings.FontColor;
    p^.Font.FontData := Settings.Font;
    p^.Visible := True;
    p^.Parent := MovePanel;
    LetterList.Add(p);
    prev_letter_time := now;
  end;
end;

procedure TTrainingForm.RestartBtnClick(Sender: TObject);
begin
  StopMoving;
  StartBtnClick(Sender);
end;

end.
