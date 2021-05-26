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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
  HelpForm.Close;
end;

procedure THelpForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    MainForm.Visible := True;
end;

procedure THelpForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then Close;
end;

end.
