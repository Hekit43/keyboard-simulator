unit common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

procedure PlaySoundAsync(SoundFileName: PChar);

implementation

uses SettingsUnit, MMsystem;

procedure PlaySoundAsync(SoundFileName: PChar);
begin
  if Settings.SoundOn then sndPlaysound(SoundFileName, SND_ASYNC);
end;

end.

