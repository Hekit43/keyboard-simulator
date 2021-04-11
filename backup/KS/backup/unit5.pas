unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TInstr }

  TInstr = class(TForm)
    Back: TButton;
    procedure BackClick(Sender: TObject);
  private

  public

  end;

var
  Instr: TInstr;

implementation
uses Unit1;
{$R *.lfm}

{ TInstr }

procedure TInstr.BackClick(Sender: TObject);
begin
  Instr.Close;
   KS.show;
end;

end.

