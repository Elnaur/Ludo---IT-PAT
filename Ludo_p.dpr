program Ludo_p;

uses
  Forms,
  MainMenu_u in 'MainMenu_u.pas' {FormMainMenu},
  Rules_u in 'Rules_u.pas' {FormRules},
  Board_u in 'Board_u.pas' {FormBoard},
  AskToExitBoard_u in 'AskToExitBoard_u.pas' {FormAskToExitBoard},
  TPlayerUnit_u in 'TPlayerUnit_u.pas',
  DiceRoll_u in 'DiceRoll_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMainMenu, FormMainMenu);
  Application.CreateForm(TFormRules, FormRules);
  Application.CreateForm(TFormBoard, FormBoard);
  Application.CreateForm(TFormAskToExitBoard, FormAskToExitBoard);
  Application.Run;
end.
