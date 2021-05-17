unit LevelchooseUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TLevelForm }

  TLevelForm = class(TForm)
    EasyLevelBtn: TBitBtn;
    MediumLevelBtn: TBitBtn;
    HaldLevelBtn: TBitBtn;
    Label1: TLabel;
    procedure MediumLevelBtnClick(Sender: TObject);
  private

  public

  end;

var
  LevelForm: TLevelForm;

implementation

{$R *.lfm}

{ TLevelForm }

procedure TLevelForm.MediumLevelBtnClick(Sender: TObject);
begin

end;

end.
