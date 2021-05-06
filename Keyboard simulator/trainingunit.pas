unit TrainingUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls;

type

  { TTrainingForm }

  TTrainingForm = class(TForm)
    CorrectDisplay: TEdit;
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
    procedure FormActivate(Sender: TObject);
    procedure MoveTimerTimer(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
  private

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
  RusCapitalLetters:array of string = ('А', 'Б', 'В', 'Г', 'Д');

procedure TTrainingForm.StartBtnClick(Sender: TObject);

var
  i:integer;
  s:string;
  p:^TLabel;

begin
  TimeEdit.Enabled:=false;
  StartBtn.Enabled:=False;
  StopBtn.Enabled:=True;
  TimeDisplay.Text:=TimeEdit.Text;
  LetterList:=Tlist.Create;
  for i:=1 to NumLetters do
  begin
    new(p);
    p^:=TLabel.Create(TrainingForm);
    p^.Top :=0;
    p^.Left := Random(MovePanel.Width);
    s:=RusCapitalLetters[random(SizeOf(RusCapitalLetters)+1)];
    p^.Caption :=s;
    p^.Font.Color:=clBlue;
    p^.Font.Size:=14;
    p^.Visible:=True;
    p^.Parent:=MovePanel;
    LetterList.Add(p);
  end;
  MoveTimer.Enabled:=true;
end;

procedure TTrainingForm.StopBtnClick(Sender: TObject);
var i:integer;
    p:^TLabel;
begin
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

procedure TTrainingForm.MoveTimerTimer(Sender: TObject);

var i: integer;
    p:^TLabel;
    timeout:boolean = false;

begin

  for i:=0 to LetterList.Count-1 do
  begin
      p:=LetterList[i];
      p^.Top:=p^.Top + 10;
      timeout:= p^.Top > MovePanel.Height;
  end;
  if timeout then
  begin
        StopBtnClick(Sender);
  end;
end;

end.

