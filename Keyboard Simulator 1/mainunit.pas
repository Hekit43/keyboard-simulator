unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls, common;

type

  { TMainForm }

  TMainForm = class(TForm)
    StartBtn: TBitBtn;
    ExitBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SettingsBtn: TBitBtn;
    Panel1: TPanel;
    procedure ExitBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;

implementation
 uses LevelchooseUnit, TrainingUnit, SettingsUnit,HelpUnit;
{$R *.lfm}

var activated:boolean = False;

{ TMainForm }

procedure TMainForm.ExitBtnClick(Sender: TObject);
begin
  PlaySoundAsync('hitsound.wav');
  Exit;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  if not Activated then
     begin
       SettingsForm.LoadSettings;
       Activated := True;
     end;
end;

procedure TMainForm.HelpBtnClick(Sender: TObject);
begin
 PlaySoundAsync('hitsound.wav');
 MainForm.Visible:=false;
 HelpForm.ShowModal;
end;

procedure TMainForm.SettingsBtnClick(Sender: TObject);
begin
  PlaySoundAsync('hitsound.wav');
  MainForm.Visible:=false;
  SettingsForm.SetSettings;
  SettingsForm.ShowModal;
  MainForm.Visible:=True;
end;

procedure TMainForm.StartBtnClick(Sender: TObject);
begin
  PlaySoundAsync('hitsound.wav');
  LetterList:= TList.Create;
  MainForm.Visible := false;
  currentlevel:= -1;
  case LevelForm.Showmodal of
  mrYes: currentlevel:= 1;
  mrNo: currentlevel:= 0;
  mrAll: currentlevel:= 2;
  end;
  TrainingForm.MovePanel.Color:=Settings.PanelColor;
  PlaySoundAsync('hitsound.wav');
  if currentlevel >= 0 then
     TrainingForm.ShowModal;
  MainForm.Visible := true;
  LetterList.Free;
end;

end.

