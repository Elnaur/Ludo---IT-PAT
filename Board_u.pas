unit Board_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, jpeg, TPlayerUnit_u, Dice_u;

type
  TFormBoard = class(TForm)
    BtnExitBoard: TButton;
    pnlRight: TPanel;
    pnlLeft: TPanel;
    pnlBoard: TPanel;
    imgBoard: TImage;

    // Game track spaces
    imgBoardSpace_1: TImage;
    imgBoardSpace_2: TImage;
    imgBoardSpace_3: TImage;
    imgBoardSpace_4: TImage;
    imgBoardSpace_5: TImage;
    imgBoardSpace_6: TImage;
    imgBoardSpace_7: TImage;
    imgBoardSpace_8: TImage;
    imgBoardSpace_9: TImage;
    imgBoardSpace_10: TImage;
    imgBoardSpace_11: TImage;
    imgBoardSpace_12: TImage;
    imgBoardSpace_13: TImage;
    imgBoardSpace_14: TImage;
    imgBoardSpace_15: TImage;
    imgBoardSpace_16: TImage;
    imgBoardSpace_17: TImage;
    imgBoardSpace_18: TImage;
    imgBoardSpace_19: TImage;
    imgBoardSpace_20: TImage;
    imgBoardSpace_21: TImage;
    imgBoardSpace_22: TImage;
    imgBoardSpace_23: TImage;
    imgBoardSpace_24: TImage;
    imgBoardSpace_25: TImage;
    imgBoardSpace_26: TImage;
    imgBoardSpace_27: TImage;
    imgBoardSpace_28: TImage;
    imgBoardSpace_29: TImage;
    imgBoardSpace_30: TImage;
    imgBoardSpace_31: TImage;
    imgBoardSpace_32: TImage;
    imgBoardSpace_33: TImage;
    imgBoardSpace_34: TImage;
    imgBoardSpace_35: TImage;
    imgBoardSpace_36: TImage;
    imgBoardSpace_37: TImage;
    imgBoardSpace_39: TImage;
    imgBoardSpace_40: TImage;
    imgBoardSpace_41: TImage;
    imgBoardSpace_42: TImage;
    imgBoardSpace_43: TImage;
    imgBoardSpace_44: TImage;
    imgBoardSpace_45: TImage;
    imgBoardSpace_46: TImage;
    imgBoardSpace_47: TImage;
    imgBoardSpace_48: TImage;
    imgBoardSpace_49: TImage;
    imgBoardSpace_50: TImage;
    imgBoardSpace_51: TImage;
    imgBoardSpace_52: TImage;
    imgBoardSpace_53: TImage;

    // Home track spaces
    imgBoardSpace_GreenHome1: TImage;
    imgBoardSpace_GreenHome2: TImage;
    imgBoardSpace_GreenHome3: TImage;
    imgBoardSpace_GreenHome4: TImage;
    imgBoardSpace_GreenHome5: TImage;

    imgBoardSpace_YellowHome1: TImage;
    imgBoardSpace_YellowHome2: TImage;
    imgBoardSpace_YellowHome3: TImage;
    imgBoardSpace_YellowHome4: TImage;
    imgBoardSpace_YellowHome5: TImage;

    imgBoardSpace_RedHome1: TImage;
    imgBoardSpace_RedHome2: TImage;
    imgBoardSpace_RedHome3: TImage;
    imgBoardSpace_RedHome4: TImage;
    imgBoardSpace_RedHome5: TImage;

    imgBoardSpace_BlueHome1: TImage;
    imgBoardSpace_BlueHome2: TImage;
    imgBoardSpace_BlueHome3: TImage;
    imgBoardSpace_BlueHome4: TImage;
    imgBoardSpace_BlueHome5: TImage;

    // Yard spaces
    imgBoardSpace_GreenTopLeft: TImage;
    imgBoardSpace_GreenTopRight: TImage;
    imgBoardSpace_GreenBottomLeft: TImage;
    imgBoardSpace_GreenBottomRight: TImage;

    imgBoardSpace_YellowTopLeft: TImage;
    imgBoardSpace_YellowTopRight: TImage;
    imgBoardSpace_YellowBottomLeft: TImage;
    imgBoardSpace_YellowBottomRight: TImage;

    imgBoardSpace_RedTopLeft: TImage;
    imgBoardSpace_RedTopRight: TImage;
    imgBoardSpace_RedBottomLeft: TImage;
    imgBoardSpace_RedBottomRight: TImage;

    imgBoardSpace_BlueTopLeft: TImage;
    imgBoardSpace_BlueBottomLeft: TImage;
    imgBoardSpace_BlueTopRight: TImage;
    imgBoardSpace_BlueBottomRight: TImage;

    pnlPlayer1: TPanel;
    pnlPlayer2: TPanel;
    pnlPlayer3: TPanel;
    pnlPlayer1RollDice: TPanel;
    pnlPlayer2RollDice: TPanel;
    pnlPlayer3RollDice: TPanel;
    imgDice: TImage;
    lblDiceResult: TLabel;
    pnlPlayer4: TPanel;
    pnlPlayer4RollDice: TPanel;
    pnlPlayer1Heading: TPanel;
    pnlPlayer2Heading: TPanel;
    pnlPlayer3Heading: TPanel;
    pnlPlayer4Heading: TPanel;
    procedure BtnExitBoardClick(Sender: TObject);
    procedure ActiveDiceButtonClick(Sender: TObject);
    procedure SelectedTokenToMove(Sender: TObject);
    procedure CalculateSpacesTokensMayMoveTo();
    procedure PlayGame;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

type
  TImageArray = array of TImage;

var
  FormBoard: TFormBoard;
  lastRoll: integer;
  GameOver: boolean;
  WaitingForButtonPress: boolean;
  CurrentPlayerIndex: integer;
  CurrentSelectedToken: TImage;

  Player1Red, Player2Yellow, Player3Blue, Player4Green: TPlayerUnit_u.TPlayer;
  // TPlayer is definied in the unit TPlayerUnit_u

  ListOfActivePlayers: array of TPlayer;

const
  ListOfDiceImages: array [1 .. 6] of string = ('Dice_1.png', 'Dice_2.png',
    'Dice_3.png', 'Dice_4.png', 'Dice_5.png', 'Dice_6.png');

implementation

uses MainMenu_u, AskToExitBoard_u;
{$R *.dfm}

procedure TFormBoard.BtnExitBoardClick(Sender: TObject);
begin
  FormAskToExitBoard.Show;
end;

procedure TFormBoard.FormShow(Sender: TObject);
var
  i, j, k: integer;
begin
  left := (Screen.Width div 2) - (FormBoard.Width div 2);
  top := (Screen.WorkAreaHeight div 2) - (FormBoard.Height div 2);

  // Initialise the players using ListOfActivePlayers from MainMenu_u

  for i := 1 to 4 do
  begin
    if ListOfActivePlayerTypes[i] <> 'None' then
    begin
      // Do stuff
    end;
  end;

  // These four if statements are really bad code, I know, but it's the easiest way to do it.
  if ListOfActivePlayerTypes[1] <> 'None' then
  begin
    Player1Red := TPlayer.Create(1);
    SetLength(ListOfActivePlayers, length(ListOfActivePlayers) + 1);
    ListOfActivePlayers[ high(ListOfActivePlayers)] := Player1Red;
  end;

  if ListOfActivePlayerTypes[2] <> 'None' then
  begin
    Player2Yellow := TPlayer.Create(2);
    SetLength(ListOfActivePlayers, length(ListOfActivePlayers) + 1);
    ListOfActivePlayers[ high(ListOfActivePlayers)] := Player2Yellow;
  end;

  if ListOfActivePlayerTypes[3] <> 'None' then
  begin
    Player3Blue := TPlayer.Create(3);
    SetLength(ListOfActivePlayers, length(ListOfActivePlayers) + 1);
    ListOfActivePlayers[ high(ListOfActivePlayers)] := Player3Blue;
  end;

  if ListOfActivePlayerTypes[4] <> 'None' then
  begin
    Player4Green := TPlayer.Create(4);
    SetLength(ListOfActivePlayers, length(ListOfActivePlayers) + 1);
    ListOfActivePlayers[ high(ListOfActivePlayers)] := Player4Green;
  end;

  for i := low(ListOfActivePlayers) to high(ListOfActivePlayers) do
  begin
    for j := low(ListOfActivePlayers[i].ListOfYardSpaces) to high
      (ListOfActivePlayers[i].ListOfYardSpaces) do
    begin
      ListOfActivePlayers[i].ListOfYardSpaces[j].Picture.LoadFromFile
        (ListOfActivePlayers[i].tokenPath);
      // for k := 1 to 4 do
      // begin
      ListOfActivePlayers[i].ListOfTokenPositions[j] := ListOfActivePlayers[i]
        .ListOfYardSpaces[j];
      // end;
    end;

    PlayGame;

  end;
end;

// Dice:
procedure TFormBoard.PlayGame();
var
  i: integer;
begin
  GameOver := False;
  CurrentPlayerIndex := 0;
  ListOfActivePlayers[CurrentPlayerIndex].StartDiceRoll();
end;

procedure TFormBoard.ActiveDiceButtonClick(Sender: TObject);
begin
  ShuffleDice;
  lastRoll := ResultOfDiceRoll();
  lblDiceResult.Caption := IntToStr(lastRoll);
  ListOfActivePlayers[CurrentPlayerIndex].FinishDiceRoll();

  ListOfActivePlayers[CurrentPlayerIndex].StartNextTurn();
end;

procedure TFormBoard.SelectedTokenToMove(Sender: TObject);
var
  ImageSender: TImage;
  i: TImage;
begin
  ImageSender := Sender as TImage;
  for i in ListOfActivePlayers[CurrentPlayerIndex].ListOfTokenPositions do
  begin
    if i = ImageSender then
      CurrentSelectedToken := ImageSender;
  end;
end;

procedure TFormBoard.CalculateSpacesTokensMayMoveTo();
var
  i, j: TImage;
  isInYard, isInHome, isInBoard: boolean;
begin
  for i in ListOfActivePlayers[CurrentPlayerIndex].ListOfTokenPositions do
  begin

    for j in ListOfActivePlayers[CurrentPlayerIndex].ListOfYardSpaces do
    begin
      if j = i then
      begin
        isInYard = True;
      end;
    end;

    for j in ListOfActivePlayers[CurrentPlayerIndex].ListOfHomeSpaces do
    begin
      if j = i then
      begin
        isInHome = True;
      end;
    end;

    if not(isInHome or isInYard) then
      isInBoard = True;

  end;
end;

end.
