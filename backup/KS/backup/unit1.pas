unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TKS }

  TKS = class(TForm)
    Start1: TButton;
    Settings1: TButton;
    Help: TButton;
    Exit1: TButton;
    procedure Start1Click(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private

  public

  end;

var
  KS: TKS;

implementation
 uses Unit2, Unit3, Unit4, Unit5;
{$R *.lfm}

{ TKS }

procedure TKS.Start1Click(Sender: TObject);
begin
  KS.Visible:=false;
  Choose.ShowModal;

end;

procedure TKS.Settings1Click(Sender: TObject);
begin
 KS.Visible:=false;
  Settings1.ShowModal;
end;

procedure TKS.HelpClick(Sender: TObject);
begin
  KS.Visible:=false;
    Instr.ShowModal;
end;

procedure TKS.Exit1Click(Sender: TObject);
begin
  KS.close;
end;

procedure TKS.Panel1Click(Sender: TObject);
begin

end;

end.

