unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TSettings }

  TSettings = class(TForm)
    Back: TButton;
    procedure BackClick(Sender: TObject);
  private

  public

  end;

var
  Settings: TSettings;

implementation
 uses Unit1;
{$R *.lfm}

 { TSettings }

 procedure TSettings.BackClick(Sender: TObject);
 begin
   Settings.Close;
   KS.show;
 end;

end.

