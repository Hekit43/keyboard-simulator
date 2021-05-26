unit SettingsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, Common;

const
  SettingsFileName = 'ks.ini';

type
  TCharSet = (Rus, RusCap, Eng, EngCap, Dig, Spec);
  TLevel = record
     NumLetters,
     Interval: integer;
  end;

  TLevels = array [0..2] of TLevel;

  TSettingRec = record
    SoundOn: boolean;
    Chars: set of TCharSet;
    UseReg: boolean;
    Font: TFontData;
    FontColor: TColor;
    PanelColor: TColor;
    Levels: TLevels;
  end;

  { TSettingsForm }

  TSettingsForm = class(TForm)
    SaveBtn: TBitBtn;
    CharSetCheckGroup: TCheckGroup;
    LevelBox: TComboBox;
    NumLettersBox: TComboBox;
    LettersIntervalBox: TComboBox;
    FontBtn: TBitBtn;
    ColorBtn: TBitBtn;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ExitBtn: TBitBtn;
    Label5: TLabel;
    Panel1: TPanel;
    SoundOnCheckBox: TCheckBox;
    procedure CharSetCheckGroupControlBorderSpacingChange(Sender: TObject);
    procedure CharSetCheckGroupItemClick(Sender: TObject; Index: integer);
    procedure ColorBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure FontBtnClick(Sender: TObject);
    procedure LettersIntervalBoxEditingDone(Sender: TObject);
    procedure LevelBoxChange(Sender: TObject);
    procedure NumLettersBoxEditingDone(Sender: TObject);
    procedure LoadSettings;
    procedure SaveBtnClick(Sender: TObject);
    procedure SetSettings;
  private
    procedure GetSettings;
    procedure SaveSettings;
  public

  end;

var
  SettingsForm: TSettingsForm;

  Settings: TSettingRec;
  Levels: TLevels;

implementation

uses MainUnit;

{$R *.lfm}

{ TSettingsForm }

procedure TSettingsForm.ExitBtnClick(Sender: TObject);
begin
  PlaySoundAsync('hitsound.wav');
  MainForm.Visible := True;
  SettingsForm.Close;
end;

procedure TSettingsForm.FontBtnClick(Sender: TObject);
begin
     FontDialog1.Execute;
end;

procedure TSettingsForm.LettersIntervalBoxEditingDone(Sender: TObject);
var n:integer;
begin
  n:=StrToIntDef(LettersIntervalBox.Text, 0);
  if (n<10) or (n>10000) then
  begin
     n:=500;
     LettersIntervalBox.Text:=IntToStr(n);
  end;
  Levels[LevelBox.ItemIndex].Interval:=n;
end;

procedure TSettingsForm.LevelBoxChange(Sender: TObject);
begin
  NumLettersBox.Text:=IntToStr(Levels[LevelBox.ItemIndex].NumLetters);
  LettersIntervalBox.Text:=IntToStr(Levels[LevelBox.ItemIndex].Interval);
end;

procedure TSettingsForm.NumLettersBoxEditingDone(Sender: TObject);
var n:integer;
begin
  n:=StrToIntDef(NumLettersBox.Text, 0);
  if (n<1) or (n>100) then
  begin
     n:=5;
     NumLettersBox.Text:=IntToStr(n);
  end;
  Levels[LevelBox.ItemIndex].NumLetters:=n;
end;

procedure TSettingsForm.SetSettings;
begin
  SoundOnCheckBox.Checked := Settings.SoundOn;
  CharSetCheckGroup.Checked[0] := Rus in Settings.Chars;
  CharSetCheckGroup.Checked[1] := RusCap in Settings.Chars;
  CharSetCheckGroup.Checked[2] := Eng in Settings.Chars;
  CharSetCheckGroup.Checked[3] := EngCap in Settings.Chars;
  CharSetCheckGroup.Checked[5] := Dig in Settings.Chars;
  CharSetCheckGroup.Checked[6] := Spec in Settings.Chars;
  CharSetCheckGroup.Checked[4] := Settings.UseReg;
  ColorDialog1.Color := Settings.PanelColor;
  FontDialog1.Font.FontData := Settings.Font;
  FontDialog1.Font.Color := Settings.FontColor;
  Levels := Settings.Levels;
  LevelBox.ItemIndex:=0;
  LevelBoxChange(Self);
end;

procedure TSettingsForm.GetSettings;
begin
  Settings.SoundOn := SoundOnCheckBox.Checked;
  Settings.Chars := [];
  if CharSetCheckGroup.Checked[0] then
    Settings.Chars := Settings.Chars + [Rus];
  if CharSetCheckGroup.Checked[1] then
    Settings.Chars := Settings.Chars + [RusCap];
  if CharSetCheckGroup.Checked[2] then
    Settings.Chars := Settings.Chars + [Eng];
  if CharSetCheckGroup.Checked[3] then
    Settings.Chars := Settings.Chars + [EngCap];
  if CharSetCheckGroup.Checked[5] then
    Settings.Chars := Settings.Chars + [Dig];
  if CharSetCheckGroup.Checked[6] then
    Settings.Chars := Settings.Chars + [Spec];
  Settings.UseReg := CharSetCheckGroup.Checked[4];
  Settings.PanelColor := ColorDialog1.Color;
  Settings.Font := FontDialog1.Font.FontData;
  Settings.FontColor := FontDialog1.Font.Color;
  Settings.Levels := Levels;
end;

procedure TSettingsForm.SaveSettings;
var
  f: file of TSettingRec;
begin
  AssignFile(f, SettingsFileName);
  Rewrite(f);
  Write(f, Settings);
  CloseFile(f);
end;

procedure TSettingsForm.LoadSettings;
var
  f: file of TSettingRec;
begin
  Levels[0].NumLetters:=5;
  Levels[0].Interval:=1000;
  Levels[1].NumLetters:=10;
  Levels[1].Interval:=500;
  Levels[2].NumLetters:=15;
  Levels[2].Interval:=200;
  ColorDialog1.Color := clWhite;
//  FontDialog1.Font.FontData := Settings.Font;
  FontDialog1.Font.Color := clBlue;

  if FileExists(SettingsFileName) then
  begin
    AssignFile(f, SettingsFileName);
    try
      Reset(f);
      Read(f, Settings);
      CloseFile(f);
    finally
    end;
  end
  else GetSettings;
end;

procedure TSettingsForm.SaveBtnClick(Sender: TObject);
begin
  GetSettings;
  SaveSettings;
end;

procedure TSettingsForm.ColorBtnClick(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin

  end;
end;

procedure TSettingsForm.CharSetCheckGroupControlBorderSpacingChange(
  Sender: TObject);
begin
end;

procedure TSettingsForm.CharSetCheckGroupItemClick(Sender: TObject;
  Index: integer);
var i: integer;
    f: boolean;
begin
    f:=false;
    for i:=0 to CharSetCheckGroup.Items.Count - 1 do
        if i<>4 then f:=f or CharSetCheckGroup.Checked[i];
    if not f then CharSetCheckGroup.Checked[Index]:=True;
end;



end.
