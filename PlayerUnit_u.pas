unit PlayerUnit_u;
interface

uses
  StdCtrls, ExtCtrls, pngimage, SysUtils, Dialogs, Forms, Graphics;

type
  TImageArray = array of TImage;

type
  TToken = class
    Position: TImage;

    isinHome: boolean;
    isInYard: boolean;
    isInBoard: boolean;
    isFinished: boolean;
    timesPassedHome: byte;

    constructor Create();

    procedure MoveOutOfYard;
    procedure MoveForward;
    procedure MoveOnToHome;
    procedure MoveForwardOnHome;
  end;

type
  TPlayer = class

    Token1, Token2, Token3, Token4: TToken;

    playerType: string;
    ListOfTokens: array [0 .. 3] of TToken;
    StartSpace: TImage;
    ListOfYardSpaces, ListOfHomeSpaces: TImageArray;
    PanelDice: TPanel;
    ActivePanelColor: integer;
    DarkColor: integer;
    tokenPath: string;
    playerNumber: integer;
    IndexOfEnterHomeSpace: integer;
    AmountOfTokensHome: TLabel;
    AmountFinished: integer;

    procedure StartComputerTurn;
    procedure StartDiceRoll();
    procedure FinishDiceRoll();
    procedure StartNextTurn();
    procedure EnablePlayerColourSpaces(bool: boolean);
    constructor Create(number: integer);

  end;

implementation

uses
  MainMenu_u, Rules_u, Board_u, Dice_u, Victory_u;

constructor TToken.Create();
begin
  isinHome := False;
  isInYard := True;
  isInBoard := False;
  isFinished := False;

  timesPassedHome := 0;
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
        IndexOfEnterHomeSpace := 27;
        PanelDice := FormBoard.pnlPlayer1RollDice;
        ActivePanelColor := clRed_Board;
        DarkColor := clDarkRed_Board;

        tokenPath := GetCurrentDir +
          '\Media\Token images\Red player 1 token.png';
        AmountOfTokensHome := FormBoard.lblPlayer1AmountOfTokensHome;
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
        IndexOfEnterHomeSpace := 14;
        PanelDice := FormBoard.pnlPlayer2RollDice;
        ActivePanelColor := clYellow_Board;
        DarkColor := clDarkYellow_Board;

        tokenPath := GetCurrentDir +
          '\Media\Token images\Yellow player 2 token.png';
        AmountOfTokensHome := FormBoard.lblPlayer2AmountOfTokensHome;

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
        IndexOfEnterHomeSpace := 41;
        PanelDice := FormBoard.pnlPlayer3RollDice;
        ActivePanelColor := clBlue_Board;
        DarkColor := clDarkBlue_Board;

        tokenPath := GetCurrentDir +
          '\Media\Token images\Blue player 3 token.png';
        AmountOfTokensHome := FormBoard.lblPlayer3AmountOfTokensHome;

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
        IndexOfEnterHomeSpace := 1;
        PanelDice := FormBoard.pnlPlayer4RollDice;
        ActivePanelColor := clGreen_Board;
        DarkColor := clDarkGreen_Board;

        tokenPath := GetCurrentDir +
          '\Media\Token images\Green player 4 token.png';
        AmountOfTokensHome := FormBoard.lblPlayer4AmountOfTokensHome;
      end;
  end;
  AmountFinished := 0;
  playerType := MainMenu_u.ListOfActivePlayerTypes[playerNumber];

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
begin
  PanelDice.Enabled := False;
  if lastRoll <> 6 then
  begin
    if ((Token1.isInYard = True) and (Token2.isInYard = True)) and
      ((Token3.isInYard = True) and (Token4.isInYard = True)) then
    // if all tokens are still in their Yard and the throw is not six
    begin
      // ShowMessage('all tokens are still in their Yard and the throw is not six');
      StartNextTurn;
    end
    else // one of the tokens is out and the roll is not six
    begin
      // Showmessage('one of the tokens is out and the roll is not six');
      EnablePlayerColourSpaces(True);
    end;
  end
  else // the roll is six, so it does not matter if tokens are out or not
  begin
    // ShowMessage('the roll is six, so it does not matter if tokens are out or not');
    EnablePlayerColourSpaces(True);
  end;

end;

procedure TPlayer.StartNextTurn();
begin
  PanelDice.Color := clGray;
  EnablePlayerColourSpaces(False);
  FormBoard.lblDiceResult.Caption := '';

  if CurrentPlayerIndex < High(ListOfActivePlayers) then
    CurrentPlayerIndex := CurrentPlayerIndex + 1
  else
    CurrentPlayerIndex := Low(ListOfActivePlayers);

  if ListOfActivePlayers[CurrentPlayerIndex].playerType = 'Computer' then
    ListOfActivePlayers[CurrentPlayerIndex].StartComputerTurn()
  else
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

procedure TToken.MoveOutOfYard;
var
  i: integer;
begin
  for i := 0 to 3 do
    if ListOfActivePlayers[CurrentPlayerIndex].StartSpace = ListOfActivePlayers
      [CurrentPlayerIndex].ListOfTokens[i].Position then
    begin
      ShowMessage(
        'Please choose another token to move. The token you selected will move on to another of your tokens and you cannot do that.');
      Abort;
    end;

  CurrentSelectedToken.Position.Picture.Graphic := Nil;
  Position := ListOfActivePlayers[CurrentPlayerIndex].StartSpace;
  CurrentSelectedToken.Position.Picture.LoadFromFile
    (ListOfActivePlayers[CurrentPlayerIndex].tokenPath);
  isInYard := False;
  isInBoard := True;
  DidSomethingWithToken := True;
end;

procedure TToken.MoveForward;
var
  i, j, k: byte;
  PossiblePosition: TImage;
begin

  for i := 0 to high(ListOfBoardSpaces) do
  begin
    if ListOfBoardSpaces[i] = CurrentSelectedImageSpace then
      if (i + lastRoll) <= high(ListOfBoardSpaces) then
        PossiblePosition := ListOfBoardSpaces[i + lastRoll]
      else
        PossiblePosition := ListOfBoardSpaces
          [(lastRoll - ( high(ListOfBoardSpaces) - i)) - 1];
  end;

  for i := 0 to 3 do
    if PossiblePosition = ListOfActivePlayers[CurrentPlayerIndex].ListOfTokens
      [i].Position then
    begin
      if ListOfActivePlayers[CurrentPlayerIndex].playerType <> 'Computer' then
      begin
        ShowMessage(
          'Please choose another token to move. The token you selected will move on to another of your tokens and you cannot do that.');
        Abort;
      end
      else
        exit;
    end;

  Position.Picture.Assign(Nil);
  Position := PossiblePosition;

  if CurrentSelectedToken.Position <> Nil then // If there is already another token's image in it
  begin
    for i := 0 to high(ListOfActivePlayers) do
      for j := 0 to 3 do
      begin

        if (ListOfActivePlayers[i].ListOfTokens[j].Position =
            CurrentSelectedToken.Position) and
          (ListOfActivePlayers[i].ListOfTokens[j] <> CurrentSelectedToken) then
        // find which token from which player it is that the current selected token will land on
        begin
          for k := 0 to 3 do
          begin
            if ListOfActivePlayers[i].ListOfYardSpaces[k]
              .Picture.Graphic = Nil then
            begin
              ListOfActivePlayers[i].ListOfYardSpaces[k].Picture.LoadFromFile
                (ListOfActivePlayers[i].tokenPath);
              ListOfActivePlayers[i].ListOfTokens[j].isInYard := True;
              ListOfActivePlayers[i].ListOfTokens[j].isInBoard := False;
              ListOfActivePlayers[i].ListOfTokens[j].Position :=
                ListOfActivePlayers[i].ListOfYardSpaces[k];
              ListOfActivePlayers[i].ListOfTokens[j].timesPassedHome := 0;
              break;
            end;
          end;

        end;

      end;

  end;

  CurrentSelectedToken.Position.Picture.LoadFromFile
    (ListOfActivePlayers[CurrentPlayerIndex].tokenPath);
  DidSomethingWithToken := True;

end;

procedure TToken.MoveOnToHome;
var
  i: integer;
begin

  for i := 0 to 3 do
    if (ListOfActivePlayers[CurrentPlayerIndex].ListOfHomeSpaces[lastRoll -
        (ListOfActivePlayers[CurrentPlayerIndex].IndexOfEnterHomeSpace -
          indexOfImageSpace) - 1] = CurrentSelectedToken.Position) and
      (isFinished = False) then
    begin
      ShowMessage(
        'Please choose another token to move. The token you selected will move on to another of your tokens and you cannot do that.');
      Abort;
    end;

  isInBoard := False;
  isinHome := True;
  Position.Picture.Graphic := Nil;
  Position := ListOfActivePlayers[CurrentPlayerIndex].ListOfHomeSpaces
    [lastRoll - (ListOfActivePlayers[CurrentPlayerIndex]
      .IndexOfEnterHomeSpace - indexOfImageSpace) - 1];
  Position.Picture.LoadFromFile(ListOfActivePlayers[CurrentPlayerIndex]
      .tokenPath);
  DidSomethingWithToken := True;
end;

procedure TToken.MoveForwardOnHome;
var
  i: integer;
  PossiblePosition: TImage;
begin
  for i := 0 to 4 do
  begin
    if ListOfActivePlayers[CurrentPlayerIndex].ListOfHomeSpaces[i] =
      CurrentSelectedImageSpace then
    begin
      if (i + lastRoll <= 4) then
      begin
        PossiblePosition := ListOfActivePlayers[CurrentPlayerIndex]
          .ListOfHomeSpaces[i + lastRoll];
      end
      else
      begin
        PossiblePosition := ListOfActivePlayers[CurrentPlayerIndex]
          .ListOfHomeSpaces[4];
      end;
    end;
  end;

  for i := 0 to 3 do
    if (PossiblePosition = ListOfActivePlayers[CurrentPlayerIndex].ListOfTokens
        [i].Position) and (PossiblePosition <> ListOfActivePlayers
        [CurrentPlayerIndex].ListOfHomeSpaces[4]) then
    begin
      if ListOfActivePlayers[CurrentPlayerIndex].playerType <> 'Computer' then
      begin
        ShowMessage(
          'Please choose another token to move. The token you selected will move on to another of your tokens and you cannot do that.');
        Abort;
      end
      else
        exit;
    end;

  Position.Picture.Graphic := Nil;
  Position := PossiblePosition;
  Position.Picture.LoadFromFile(ListOfActivePlayers[CurrentPlayerIndex]
      .tokenPath);

  if Position = ListOfActivePlayers[CurrentPlayerIndex].ListOfHomeSpaces[4] then
  begin
    isFinished := True;
    ListOfActivePlayers[CurrentPlayerIndex].AmountFinished :=
      ListOfActivePlayers[CurrentPlayerIndex].AmountFinished + 1;

    ListOfActivePlayers[CurrentPlayerIndex].AmountOfTokensHome.Caption := copy
      (ListOfActivePlayers[CurrentPlayerIndex].AmountOfTokensHome.Caption, 1,
      26) + IntToStr(ListOfActivePlayers[CurrentPlayerIndex].AmountFinished);

    if ListOfActivePlayers[CurrentPlayerIndex].AmountFinished = 4 then
    begin
      Winner := ListOfActivePlayers[CurrentPlayerIndex];
      FormBoard.Enabled := False;
      FormRules.Hide;
      FormVictory.Show;
    end;

  end;
  DidSomethingWithToken := True;

end;

procedure TPlayer.StartComputerTurn;
var
  i, j: integer;
  ListOfIndexes: array [0 .. 3] of integer;
  tmp: integer;

begin
  PanelDice.Color := ActivePanelColor;
  ShuffleDice;
  lastRoll := ResultOfDiceRoll;

  for i := 0 to 3 do
  begin
    ListOfIndexes[i] := i;
  end;

  for i := high(ListOfIndexes) downto 1 do // Shuffle array using Fisher-Yates algorithm
  begin
    j := random(i + 1);

    tmp := ListOfIndexes[i];
    ListOfIndexes[i] := ListOfIndexes[j];
    ListOfIndexes[j] := tmp;

  end;

  for i := 0 to 3 do
  begin
    CurrentSelectedToken := ListOfTokens[ListOfIndexes[i]];
    CurrentSelectedImageSpace := CurrentSelectedToken.Position;
    FormBoard.ChooseHowToMoveToken;
    if DidSomethingWithToken = True then
      break;
  end;
  StartNextTurn;

end;

end.
