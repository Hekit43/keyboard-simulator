unit SettingsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons,MMsystem;

type

  { TSettingsForm }

  TSettingsForm = class(TForm)
    ExitBtn: TBitBtn;
    EngCheckBox: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    RusCheckBox: TCheckBox;
    VolumeCheckBox: TCheckBox;
    procedure ExitBtnClick(Sender: TObject);
  private

  public

  end;

var
  SettingsForm: TSettingsForm;

implementation
 uses MainUnit;
{$R *.lfm}

{ TSettingsForm }



procedure TSettingsForm.ExitBtnClick(Sender: TObject);
begin
  sndPlaysound('hitsound.wav', SND_ASYNC );
  MainForm.Visible := true;
  SettingsForm.close;
end;

end.

