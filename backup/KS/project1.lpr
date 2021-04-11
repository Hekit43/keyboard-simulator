program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, Unit2, Unit3, Unit4, Unit5
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TKS, KS);
  Application.CreateForm(TChoose, Choose);
  Application.CreateForm(TTraining, Training);
  Application.CreateForm(TSettings, Settings);
  Application.CreateForm(TInstr, Instr);
  Application.Run;
end.

