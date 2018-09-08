unit Dice_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, StdCtrls, Math, ExtCtrls, JPEG, pngimage;

type
  TForm1 = class(TForm)
    BtnRollDice: TButton;
    LblDisplayRoll: TLabel;
    ImgDice: TImage;
    procedure FormCreate(Sender: TObject);
    procedure BtnRollDiceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  DiceResult: array [1 .. 6] of string = ('1_Dice.jpg', '2_Dice.jpg',
    '3_Dice.jpg', '4_Dice.jpg', '5_Dice.jpg', '6_Dice.jpg');

implementation

{$R *.dfm}

procedure TForm1.BtnRollDiceClick(Sender: TObject);
var
  diceRoll: integer;
  current, finish, start: extended;

begin
  LblDisplayRoll.Caption := '';

  finish := 1000;
  start := 0;
  current := start;

  while current < finish do
  begin
    diceRoll := RandomRange(1, 7); // including 1, excluding 7
    ImgDice.Picture.LoadFromFile(GetCurrentDir + '/Pictures/' + DiceResult
        [diceRoll]);
    Update;
    Sleep(100);
    current := 100 + current;
  end;
  LblDisplayRoll.Caption := IntToStr(diceRoll);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  ImgDice.Picture := nil;
end;

end.
