unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
 uses Unit2;
{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
Form1.Visible:=false;
  Form2.ShowModal;
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
Form1.Visible:=false;
  Form3.ShowModal;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.

