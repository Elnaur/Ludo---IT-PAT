unit PlayerUnit_u;

interface

uses
  ExtCtrls, pngimage, SysUtils, Dialogs, Forms, Graphics;

type
  TImageArray = array of TImage;

type
  TToken = class
    Position: TImage;
    positionInBoardSpaceArray: integer;

    isSelected: boolean;
    isinHome: boolean;
    isInYard: boolean;
    isInBoard: boolean;

    constructor Create();

    procedure MoveOutOfYard(rollThrown: integer);
    // procedure MoveOnToHome(rollThrown: integer);
    // procedure MoveForward(rollThrown: integer);
  end;

type
  TPlayer = class

  var
    Token1, Token2, Token3, Token4: TToken;

    playerType: string;
    ListOfTokens: array [0 .. 3] of TToken;
    StartSpace: TImage;
    ListOfYardSpaces, ListOfHomeSpaces: TImageArray;
    PanelDice: TPanel;
    ActivePanelColor: integer;
    isActive: boolean;
    tokenPath: string;
    playerNumber: integer;

    procedure StartDiceRoll();
    procedure FinishDiceRoll();
    procedure StartNextTurn();
    procedure EnablePlayerColourSpaces(bool: boolean);
    constructor Create(number: integer);

  end;

implementation

uses
  MainMenu_u, Board_u;

constructor TToken.Create();
begin
  isSelected := False;
  isinHome := False;
  isInYard := True;
  isInBoard := False;
end;

constructor TPlayer.Create(number: integer);

const
  Red = 1;
  Yellow = 2;
  Blue = 3;
  Green = 4;

begin
  playerNumber := number;
  case playerNumber of
    Red:
      begin
        ListOfYardSpaces := TImageArray.Create
          (FormBoard.imgBoardSpace_RedTopLeft,
          FormBoard.imgBoardSpace_RedTopRight,
          FormBoard.imgBoardSpace_RedBottomLeft,
          FormBoard.imgBoardSpace_RedBottomRight);

        ListOfHomeSpaces := TImageArray.Create
          (FormBoard.imgBoardSpace_RedHome1, FormBoard.imgBoardSpace_RedHome2,
          FormBoard.imgBoardSpace_RedHome3, FormBoard.imgBoardSpace_RedHome4,
          FormBoard.imgBoardSpace_RedHome5);

        StartSpace := FormBoard.imgBoardSpace_27;
        PanelDice := FormBoard.pnlPlayer1RollDice;
        ActivePanelColor := clRed_Board;

        tokenPath := GetCurrentDir +
          '\Media\Token images\Red player 1 token.png';
      end;

    Yellow:
      begin
        ListOfYardSpaces := TImageArray.Create
          (FormBoard.imgBoardSpace_YellowTopLeft,
          FormBoard.imgBoardSpace_YellowTopRight,
          FormBoard.imgBoardSpace_YellowBottomLeft,
          FormBoard.imgBoardSpace_YellowBottomRight);

        ListOfHomeSpaces := TImageArray.Create
          (FormBoard.imgBoardSpace_YellowHome1,
          FormBoard.imgBoardSpace_YellowHome2,
          FormBoard.imgBoardSpace_YellowHome3,
          FormBoard.imgBoardSpace_YellowHome4,
          FormBoard.imgBoardSpace_YellowHome5);

        StartSpace := FormBoard.imgBoardSpace_14;
        PanelDice := FormBoard.pnlPlayer2RollDice;
        ActivePanelColor := clYellow_Board;
        tokenPath := GetCurrentDir +
          '\Media\Token images\Yellow player 2 token.png';

      end;

    Blue:
      begin
        ListOfYardSpaces := TImageArray.Create
          (FormBoard.imgBoardSpace_BlueTopLeft,
          FormBoard.imgBoardSpace_BlueTopRight,
          FormBoard.imgBoardSpace_BlueBottomLeft,
          FormBoard.imgBoardSpace_BlueBottomRight);

        ListOfHomeSpaces := TImageArray.Create
          (FormBoard.imgBoardSpace_BlueHome1,
          FormBoard.imgBoardSpace_BlueHome2,
          FormBoard.imgBoardSpace_BlueHome3,
          FormBoard.imgBoardSpace_BlueHome4,
          FormBoard.imgBoardSpace_BlueHome5);

        StartSpace := FormBoard.imgBoardSpace_41;
        PanelDice := FormBoard.pnlPlayer3RollDice;
        ActivePanelColor := clBlue_Board;
        tokenPath := GetCurrentDir +
          '\Media\Token images\Blue player 3 token.png';

      end;

    Green:
      begin
        ListOfYardSpaces := TImageArray.Create
          (FormBoard.imgBoardSpace_GreenTopLeft,
          FormBoard.imgBoardSpace_GreenTopRight,
          FormBoard.imgBoardSpace_GreenBottomLeft,
          FormBoard.imgBoardSpace_GreenBottomRight);

        ListOfHomeSpaces := TImageArray.Create
          (FormBoard.imgBoardSpace_GreenHome1,
          FormBoard.imgBoardSpace_GreenHome2,
          FormBoard.imgBoardSpace_GreenHome3,
          FormBoard.imgBoardSpace_GreenHome4,
          FormBoard.imgBoardSpace_GreenHome5);

        StartSpace := FormBoard.imgBoardSpace_1;
        PanelDice := FormBoard.pnlPlayer4RollDice;
        ActivePanelColor := clGreen_Board;
        tokenPath := GetCurrentDir +
          '\Media\Token images\Green player 4 token.png';
      end;
  end;
  Token1 := TToken.Create;
  Token2 := TToken.Create;
  Token3 := TToken.Create;
  Token4 := TToken.Create;

  ListOfTokens[0] := Token1;
  ListOfTokens[1] := Token2;
  ListOfTokens[2] := Token3;
  ListOfTokens[3] := Token4;
end;

procedure TPlayer.StartDiceRoll();
begin
  PanelDice.Color := ActivePanelColor;
  PanelDice.Enabled := True;
end;

procedure TPlayer.FinishDiceRoll();
var
  i: integer;
begin
  PanelDice.Enabled := False;
  if lastRoll <> 6 then
    for i := 0 to high(ListOfYardSpaces) do
    begin
      if ListOfYardSpaces[i].Picture <> Nil then
      begin
        StartNextTurn;
        break;
      end

      else
      begin
        EnablePlayerColourSpaces(True);
        break;
      end;

    end
    else
      EnablePlayerColourSpaces(True);
end;

procedure TPlayer.StartNextTurn();
begin
  PanelDice.Color := clGray;

  if CurrentPlayerIndex < High(ListOfActivePlayers) then
    CurrentPlayerIndex := CurrentPlayerIndex + 1
  else
    CurrentPlayerIndex := Low(ListOfActivePlayers);

  ListOfActivePlayers[CurrentPlayerIndex].StartDiceRoll();
end;

procedure TPlayer.EnablePlayerColourSpaces(bool: boolean);
begin
  case playerNumber of
    1:
      FormBoard.EnableRedSpaces(bool);
    2:
      FormBoard.EnableYellowSpaces(bool);
    3:
      FormBoard.EnableBlueSpaces(bool);
    4:
      FormBoard.EnableGreenSpaces(bool);
  end;
end;

procedure TToken.MoveOutOfYard(rollThrown: integer);
begin
  positionInBoardSpaceArray := 0;
  CurrentSelectedToken.Position.Picture := Nil;
  Position := ListOfActivePlayers[CurrentPlayerIndex].StartSpace;
  CurrentSelectedToken.Position.Picture.LoadFromFile
    (ListOfActivePlayers[CurrentPlayerIndex].tokenPath);

  ListOfActivePlayers[CurrentPlayerIndex].StartNextTurn();

end;

end.
