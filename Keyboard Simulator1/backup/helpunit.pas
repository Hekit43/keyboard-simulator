unit HelpUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,MMsystem;

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
   sndPlaysound('hitsound.wav', SND_ASYNC );
   MainForm.Visible := true;
   HelpForm.close;
 end;

end.

