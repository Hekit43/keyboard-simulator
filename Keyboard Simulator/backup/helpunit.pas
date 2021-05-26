unit HelpUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, Common;

type

  { THelpForm }

  THelpForm = class(TForm)
    ExitBtn: TBitBtn;
    Image1: TImage;
    Panel1: TPanel;
    procedure ExitBtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure THelpForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then Close;
end;

end.
