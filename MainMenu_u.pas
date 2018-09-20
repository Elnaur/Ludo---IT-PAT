unit MainMenu_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus;

type
  TFormMainMenu = class(TForm)
    PnlPlayer1: TPanel;
    PnlPlayer4: TPanel;
    PnlPlayer2: TPanel;
    PnlPlayer3: TPanel;
    BtnChangePlayer1: TButton;
    BtnChangePlayer2: TButton;
    BtnChangePlayer3: TButton;
    BtnChangePlayer4: TButton;
    BtnPlay: TButton;
    BtnExit: TButton;
    LblMMHeading: TLabel;
    BtnRules: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnChangePlayer1Click(Sender: TObject);
    procedure BtnChangePlayer2Click(Sender: TObject);
    procedure BtnChangePlayer3Click(Sender: TObject);
    procedure BtnChangePlayer4Click(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure BtnRulesClick(Sender: TObject);
    procedure BtnPlayClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPlayerTypeArray = class // Class containing different player types to be chosen by the player
  var
    currentIndex: integer;

  const
    ListOfPlayerTypes: array [0 .. 2] of string = ('None', 'Person',
      'Computer');
    // List of different player types
    // None: No player. A player typed 'None' will not be part of the game.
    // Person: A human player.
    // Computer: A computerised player that will not be controlled by a human, but by an algorithm.

    function nextInCycle(): string; // Cycles through the list in the panals
  end;

var
  FormMainMenu: TFormMainMenu;
  Player1TypeArray, Player2TypeArray, Player3TypeArray,
    Player4TypeArray: TPlayerTypeArray;

  PlayerTypeSettings: TextFile;
  ListOfPlayers: array [1 .. 4] of TPlayerTypeArray;
  ListOfPanels: array [1 .. 4] of TPanel;

  line: string;

const
  // Custom colours used in the board.
  // Delphi's color hex codes are BGR, not RGB.
  // Something to do with how old intel processors worked.
  clRed_board = $0000D4;
  clDarkRed_board = $000055;

  clYellow_board = $55DDFF;
  clDarkYellow_board = $0088AA;

  clBlue_board = $D4AA00;
  clDarkBlue_board = $554400;

  clGreen_board = $00D455;
  clDarkGreen_board = $008033;

implementation

uses
  Rules_u, Board_u;
{$R *.dfm}

function TPlayerTypeArray.nextInCycle(): string;
begin
  if currentIndex = 2 then
  begin
    Result := ListOfPlayerTypes[0];
    currentIndex := 0;
  end
  else
  begin
    Result := ListOfPlayerTypes[currentIndex + 1];
    currentIndex := currentIndex + 1;
  end;
end;

procedure TFormMainMenu.BtnChangePlayer1Click(Sender: TObject);
begin
  PnlPlayer1.Caption := Player1TypeArray.nextInCycle;
end;

procedure TFormMainMenu.BtnChangePlayer2Click(Sender: TObject);
begin
  PnlPlayer2.Caption := Player2TypeArray.nextInCycle;
end;

procedure TFormMainMenu.BtnChangePlayer3Click(Sender: TObject);
begin
  PnlPlayer3.Caption := Player3TypeArray.nextInCycle;
end;

procedure TFormMainMenu.BtnChangePlayer4Click(Sender: TObject);
begin
  PnlPlayer4.Caption := Player4TypeArray.nextInCycle;
end;

procedure TFormMainMenu.BtnExitClick(Sender: TObject); // Exits the game
begin
  Application.Terminate;
  CloseFile(PlayerTypeSettings);
end;

procedure TFormMainMenu.BtnPlayClick(Sender: TObject);
var
  i: integer;
begin
  try
    ReWrite(PlayerTypeSettings);
    for i := 1 to 4 do
    begin
      Write(PlayerTypeSettings, ListOfPlayers[i].currentIndex);
    end;
    CloseFile(PlayerTypeSettings);
  except
    on E: Exception do
    begin
      ShowMessage('Error writing settings to ''PlayerTypeSettings.txt''');
    end
  end;
  FormMainMenu.Hide;
  FormRules.Hide;
  FormBoard.Show;
end;

procedure TFormMainMenu.BtnRulesClick(Sender: TObject); // Opens the rules from
begin
  FormRules.Show;
end;

procedure TFormMainMenu.FormCreate(Sender: TObject);
// Initialises TFormMainMenu
var
  i: integer;

begin
  left := (Screen.Width div 2) - (FormMainMenu.Width div 2);
  top := (Screen.WorkAreaHeight div 2) - (FormMainMenu.Height div 2);

  begin
    if FileExists(GetCurrentDir + '\Media\Text\PlayerTypeSettings.txt') then
    begin
      AssignFile(PlayerTypeSettings,
        GetCurrentDir + '\Media\Text\PlayerTypeSettings.txt');
      FileMode := fmOpenReadWrite; // It throws Access Violations unless I put this here, although Read and Write mode is supposed to be the default.
      Reset(PlayerTypeSettings);
      readln(PlayerTypeSettings, line);
    end
    else
      ShowMessage('File ''PlayerTypeSettings.txt'' does not exist');
  end;

  PnlPlayer1.Color := clRed_board;
  Player1TypeArray := TPlayerTypeArray.Create;

  PnlPlayer2.Color := clYellow_board;
  Player2TypeArray := TPlayerTypeArray.Create;

  PnlPlayer3.Color := clBlue_board;
  Player3TypeArray := TPlayerTypeArray.Create;

  PnlPlayer4.Color := clGreen_board;
  Player4TypeArray := TPlayerTypeArray.Create;

  ListOfPlayers[1] := Player1TypeArray;
  ListOfPlayers[2] := Player2TypeArray;
  ListOfPlayers[3] := Player3TypeArray;
  ListOfPlayers[4] := Player4TypeArray;

  ListOfPanels[1] := PnlPlayer1;
  ListOfPanels[2] := PnlPlayer2;
  ListOfPanels[3] := PnlPlayer3;
  ListOfPanels[4] := PnlPlayer4;

  for i := 1 to 4 do
  begin
    try
      ListOfPlayers[i].currentIndex := StrToInt(line[i]);
      ListOfPanels[i].Caption := ListOfPlayers[i].ListOfPlayerTypes
        [ListOfPlayers[i].currentIndex];
    except
      on E: Exception do
      begin
        line := '1200';
      end;
    end;
  end;

end;

end.
