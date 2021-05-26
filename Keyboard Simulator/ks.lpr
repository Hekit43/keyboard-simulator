program ks;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  MainUnit,
  LevelchooseUnit,
  TrainingUnit,
  SettingsUnit,
  HelpUnit, common, lazcontrols { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Title := 'Keyboard simulator';
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLevelForm, LevelForm);
  Application.CreateForm(TTrainingForm, TrainingForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(THelpForm, HelpForm);
  Application.Run;
end.
