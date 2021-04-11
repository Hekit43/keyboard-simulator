unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TChoose }

  TChoose = class(TForm)
    Easy: TButton;
    Medium: TButton;
    Hard: TButton;
    Label1: TLabel;
    procedure EasyClick(Sender: TObject);
    procedure MediumClick(Sender: TObject);
    procedure HardClick(Sender: TObject);
  private

  public

  end;

var
  Choose: TChoose;

implementation
uses Unit3;
{$R *.lfm}

{ TChoose }

procedure TChoose.EasyClick(Sender: TObject);
begin
 Choose.close;
    Training.Show;
end;

procedure TChoose.MediumClick(Sender: TObject);
begin
 Choose.close;
    Training.Show;
end;

procedure TChoose.HardClick(Sender: TObject);
begin
  Choose.close;
    Training.Show;
end;

end.

