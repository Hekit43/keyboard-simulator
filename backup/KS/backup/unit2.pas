unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation
uses Unit3;
{$R *.lfm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
begin
 Form2.close;
    Form3.Show;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
 Form2.close;
    Form3.Show;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Form2.close;
    Form3.Show;
end;

end.

