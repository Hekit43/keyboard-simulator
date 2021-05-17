unit HelpUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, Common;

type

  { THelpForm }

  THelpForm = class(TForm)
    ExitBtn: TBitBtn;
    Panel1: TPanel;
    procedure ExitBtnClick(Sender: TObject);
  private

  public

  end;

var
  HelpForm: THelpForm;

implementation

uses MainUnit;

{$R *.lfm}

{ THelpForm }

procedure THelpForm.ExitBtnClick(Sender: TObject);
begin
  PlaySoundAsync('hitsound.wav');
  MainForm.Visible := True;
  HelpForm.Close;
end;

end.
