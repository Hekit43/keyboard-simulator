unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls;

type

  { TMainForm }

  TMainForm = class(TForm)
    StartBtn: TBitBtn;
    ExitBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SettingsBtn: TBitBtn;
    Panel1: TPanel;
    procedure ExitBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;
  Currentlevel: (level_easy, level_medium, level_hard, level_none);

implementation
 uses LevelchooseUnit, TrainingUnit;
{$R *.lfm}

{ TMainForm }

procedure TMainForm.ExitBtnClick(Sender: TObject);
begin
  Exit;
end;

procedure TMainForm.StartBtnClick(Sender: TObject);
begin
  currentlevel := level_none;
  MainForm.Visible := false;
  case LevelForm.Showmodal of
  mrYes: currentlevel:= level_medium;
  mrNo: currentlevel:= level_easy;
  mrAll: currentlevel:= level_hard;
  end;
  if currentlevel <> level_none then
     TrainingForm.ShowModal;
  MainForm.Visible := true;
end;

end.

