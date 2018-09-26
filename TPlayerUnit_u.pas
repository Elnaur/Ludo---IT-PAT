unit TPlayerUnit_u;

interface

uses
  ExtCtrls, pngimage, SysUtils, Dialogs, Forms, Graphics;

type
  TImageArray = array of TImage;

type
  TPlayer = class
  type
    TToken = class
      position: TImage;

      isSelected: boolean;
      isinHome: boolean;
      isInYard: boolean;
      isInBoard: boolean;

      procedure MoveForward(numberOfSpaces: integer);
    end;

  var
    RedToken1, RedToken2, RedToken3, RedToken4: TToken;
    YellowToken1, YellowToken2, YellowToken3, YellowToken4: TToken;
    BlueToken1, BlueToken2, BLueToken3, BlueToken4: TToken;
    GreenToken1, GreenToken2, GreenToken3, GreenToken4: TToken;

    playerType: string;
    ListOfTokens: array [0 .. 3] of TToken;
    StartSpace: TImage;
    ListOfYardSpaces, ListOfHomeSpaces: TImageArray;
    PanelDice: TPanel;
    ActivePanelColor: integer;
    isActive: boolean;
    tokenPath: string;

    procedure StartDiceRoll();
    procedure FinishDiceRoll();
    procedure StartNextTurn();
    // procedure StartMoveToken;
    // procedure FinishMoveToken;
    constructor Create(playerNumber: integer);

  end;

implementation

uses
  MainMenu_u, Board_u;

constructor TPlayer.Create(playerNumber: integer);

const
  Red = 1;
  Yellow = 2;
  Blue = 3;
  Green = 4;

begin
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

        RedToken1 := TToken.Create;
        RedToken2 := TToken.Create;
        RedToken3 := TToken.Create;
        RedToken4 := TToken.Create;
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

        YellowToken1 := TToken.Create;
        YellowToken2 := TToken.Create;
        YellowToken3 := TToken.Create;
        YellowToken4 := TToken.Create;
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

        BlueToken1 := TToken.Create;
        BlueToken2 := TToken.Create;
        BLueToken3 := TToken.Create;
        BlueToken4 := TToken.Create;
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

        GreenToken1 := TToken.Create;
        GreenToken2 := TToken.Create;
        GreenToken3 := TToken.Create;
        GreenToken4 := TToken.Create;
      end;
  end;
end;

procedure TPlayer.StartDiceRoll();
begin
  PanelDice.Color := ActivePanelColor;
  PanelDice.Enabled := True;
end;

procedure TPlayer.FinishDiceRoll();
begin
  PanelDice.Color := clGray;
  PanelDice.Enabled := False;
end;

procedure TPlayer.StartNextTurn();
begin
  if CurrentPlayerIndex < High(ListOfActivePlayers) then
    CurrentPlayerIndex := CurrentPlayerIndex + 1
  else
    CurrentPlayerIndex := Low(ListOfActivePlayers);

  ListOfActivePlayers[CurrentPlayerIndex].StartDiceRoll();
end;

procedure TPlayer.TToken.MoveForward(numberOfSpaces: integer);
begin
  //k
end;

end.
