unit TrainingUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, MMsystem, LCLType;

type

  { TTrainingForm }

  TTrainingForm = class(TForm)
    CorrectDisplay: TEdit;
    inputEdit: TEdit;
    ErrorDispaly: TEdit;
    AverageDisplay: TEdit;
    ExitBtn: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MovePanel: TPanel;
    StartBtn: TBitBtn;
    RestartBtn: TBitBtn;
    StopBtn: TBitBtn;
    Label1: TLabel;
    TimeEdit: TComboBox;
    TimeDisplay: TEdit;
    Panel1: TPanel;
    CountDownTimer: TTimer;
    MoveTimer: TTimer;
    procedure AverageDisplayChange(Sender: TObject);
    procedure AverageDisplayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CountDownTimerTimer(Sender: TObject);
    procedure ErrorDispalyChange(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure inputEditChange(Sender: TObject);
    procedure inputEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure MoveTimerTimer(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
  private
    procedure DeleteLetterFromList(n:integer);
  public

  end;

var
  TrainingForm: TTrainingForm;

implementation

{$R *.lfm}

{ TTrainingForm }

const NumLetters = 5;

var
  LetterList:Tlist;
  RusCapitalLetters:array of string = ('А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж',
  'З', 'И', 'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х',
  'Ц', 'Ч', 'Ш', 'Щ', 'Ъ', 'Ы', 'Ь', 'Э', 'Ю', 'Я');
  prev_letter_time:TTime; // Время появления предыдущей буквы

procedure TTrainingForm.StartBtnClick(Sender: TObject);
begin
  sndPlaysound('hitsound.wav', SND_ASYNC);
  TimeEdit.Enabled:=false;
  StartBtn.Enabled:=False;
  StopBtn.Enabled:=True;
  TimeDisplay.Text:=TimeEdit.Text;
  LetterList:=Tlist.Create;
  prev_letter_time:=-1;
  MoveTimer.Enabled:=true;
//  TrainingForm.SetFocus;
  CountDownTimer.Enabled:=True;
  inputEdit.Clear;
  InputEdit.SetFocus;
end;

procedure TTrainingForm.StopBtnClick(Sender: TObject);

var i:integer;
    p:^TLabel;
begin
  sndPlaysound('hitsound.wav', SND_ASYNC );
  MoveTimer.Enabled:=False;
  for i:=0 to LetterList.Count-1 do
  begin
      p:=LetterList[i];
      p^.Free;
  end;
  LetterList.Free;
  StartBtn.Enabled:=True;
  StopBtn.Enabled:=False;
end;

procedure TTrainingForm.FormActivate(Sender: TObject);
begin
    TimeDisplay.Text:=TimeEdit.Text;
end;

procedure TTrainingForm.FormCreate(Sender: TObject);
begin

end;

procedure TTrainingForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //if Key = VK_DOWN then;
//  inputEdit.SetFocus;
  CorrectDisplay.Text:=IntToHex(ord(Key),4);
  ErrorDispaly.Text:=IntToHex(key,4);
end;

procedure TTrainingForm.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TTrainingForm.DeleteLetterFromList(n:integer);
var p:^TLabel;

begin
  p:=LetterList[n];
  p^.free;
  LetterList.Delete(n);
end;

procedure TTrainingForm.inputEditChange(Sender: TObject);
var s:string;
    i:integer;
    p:^TLabel;
begin
  s:=inputEdit.Text;
  inputEdit.Clear;
  if s<>'' then
  begin
    for i:=0 to LetterList.Count-1 do
    begin
        p:=LetterList[i];
        if p^.Caption = s then // Нажата правильная клавиша
        begin
          DeleteLetterFromList(i); // Удаляем символ из списка движения
          break;
        end;
    end;
    AverageDisplay.Text:=s;
  end;
end;

procedure TTrainingForm.inputEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
end;



procedure TTrainingForm.CountDownTimerTimer(Sender: TObject);
begin
     CountDownTimer.Enabled:=False;

    //TimeDisplay.Caption :=  inttostr(strtoint(TimeDisplay.caption)-1);
end;

procedure TTrainingForm.AverageDisplayChange(Sender: TObject);
begin

end;

procedure TTrainingForm.AverageDisplayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TTrainingForm.ErrorDispalyChange(Sender: TObject);
begin

end;

procedure TTrainingForm.ExitBtnClick(Sender: TObject);
begin
  sndPlaysound('hitsound.wav', SND_ASYNC );
end;

procedure TTrainingForm.MoveTimerTimer(Sender: TObject);
const delta_y = 1; // Смещение букв за один период таймера
      next_letter_delay = 1/86400*0.5; // Задержка появления следующей буквы в долях суток
var i: integer;
    p, q:^TLabel;
    currentletterscount:integer;
    timeout:boolean = false;
    letter_exist:boolean;
    s: string;

begin
  currentletterscount:=LetterList.Count;

  for i:=0 to currentletterscount-1 do
  begin
      p:=LetterList[i];
      p^.Top:=p^.Top + delta_y;
      timeout:= p^.Top + p^.Height > MovePanel.Height;
      if timeout then
      begin
        StopBtnClick(Sender);
        exit;
      end;
  end;

  if (currentletterscount < NumLetters) and
     (now - prev_letter_time > next_letter_delay) then
  begin;
    new(p);
    p^:=TLabel.Create(TrainingForm);
    p^.Top :=0;
    p^.Left := Random(MovePanel.Width - 20);
    letter_exist:=false;
    repeat // Чтобы не повторялись падающие буквы
        s:=RusCapitalLetters[random(Length(RusCapitalLetters)+1)];
        for i:=0 to currentletterscount-1 do
        begin
          q:=LetterList[i];
          letter_exist:=q^.Caption = s;
          if letter_exist then break;
        end;
    until not letter_exist;
    p^.Caption :=s;
    p^.Font.Color:=clBlue;
    p^.Font.Size:=14;
    p^.Visible:=True;
    p^.Parent:=MovePanel;
    LetterList.Add(p);
    prev_letter_time:=now;
  end;

end;


end.

