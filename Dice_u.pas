unit Dice_u;

interface

function ResultOfDiceRoll(): integer;
procedure ShuffleDice();

implementation

uses Board_u, SysUtils;

var
  diceResult: integer;

const
  ListOfDiceImages: array [1 .. 7] of string = ('Dice_1.png', 'Dice_2.png',
    'Dice_3.png', 'Dice_4.png', 'Dice_5.png', 'Dice_6.png', 'Dice_6.png');
  // Higher possibility of throwing a six

function ResultOfDiceRoll(): integer;
begin
  Result := diceResult;
end;

procedure ShuffleDice;
var
  roll: integer;
  previousRoll: integer;
  current, finish, start: real;

  amountOfDiceRolls: integer;
begin
  Randomize;
  finish := 1000;
  start := 0;
  current := start;
  previousRoll := 0;

  FormBoard.imgDice.Visible := True;
  while current < finish do
  begin
    roll := Random(7) + 1;
    if roll <> previousRoll then
    begin
      // including 1, excluding 7
      FormBoard.imgDice.Picture.LoadFromFile
        (GetCurrentDir + '/Media/Dice images/' + ListOfDiceImages[roll]);
      FormBoard.Update;
      Sleep(100);
      current := 100 + current;
    end;
    previousRoll := roll;
  end;
  if roll = 7 then
    diceResult := 6
  else
    diceResult := roll;

  Sleep(850);
  FormBoard.imgDice.Visible := False;
end;

end.
