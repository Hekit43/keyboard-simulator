unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls, MMsystem;

type

  { TMainForm }

  TMainForm = class(TForm)
    StartBtn: TBitBtn;
    ExitBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SettingsBtn: TBitBtn;
    Panel1: TPanel;
    procedure ExitBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;
  Currentlevel: (level_easy, level_medium, level_hard, level_none);

implementation
 uses LevelchooseUnit, TrainingUnit, SettingsUnit,HelpUnit;
{$R *.lfm}

{ TMainForm }

procedure TMainForm.ExitBtnClick(Sender: TObject);
begin
  sndPlaysound('hitsound.wav', SND_ASYNC );
  Exit;
end;

procedure TMainForm.HelpBtnClick(Sender: TObject);
begin
  sndPlaysound('hitsound.wav', SND_ASYNC );
 MainForm.Visible:=false;
  HelpForm.ShowModal;
end;

procedure TMainForm.SettingsBtnClick(Sender: TObject);
begin
  sndPlaysound('hitsound.wav', SND_ASYNC );
  MainForm.Visible:=false;
  SettingsForm.ShowModal;
end;

procedure TMainForm.StartBtnClick(Sender: TObject);
begin
  sndPlaysound('hitsound.wav', SND_ASYNC );
  currentlevel := level_none;
  MainForm.Visible := false;
  case LevelForm.Showmodal of
  mrYes: currentlevel:= level_medium;
  mrNo: currentlevel:= level_easy;
  mrAll: currentlevel:= level_hard;
  end;
  sndPlaysound('hitsound.wav', SND_ASYNC );
  if currentlevel <> level_none then
     TrainingForm.ShowModal;
  MainForm.Visible := true;
end;

end.

