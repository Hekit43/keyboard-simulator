unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TTraining }

  TTraining = class(TForm)
    Back: TButton;
    procedure BackClick(Sender: TObject);
  private

  public

  end;

var
  Training: TTraining;

implementation
 uses Unit1;
{$R *.lfm}

 { TTraining }

 procedure TTraining.BackClick(Sender: TObject);
 begin
   Training.close;
  KS.Show;
 end;

end.

