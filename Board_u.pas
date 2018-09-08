unit Board_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, jpeg;

type
  TFormBoard = class(TForm)
    BtnExitBoard: TButton;
    pnlRight: TPanel;
    pnlLeft: TPanel;
    pnlBoard: TPanel;
    imgBoard: TImage;
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
    imgBoardSpace_54: TImage;
    imgBoardSpace_55: TImage;
    imgBoardSpace_56: TImage;
    imgBoardSpace_57: TImage;
    imgBoardSpace_58: TImage;
    imgBoardSpace_59: TImage;
    imgBoardSpace_60: TImage;
    imgBoardSpace_61: TImage;
    imgBoardSpace_62: TImage;
    imgBoardSpace_63: TImage;
    imgBoardSpace_64: TImage;
    imgboardSpace_65: TImage;
    imgBoardSpace_66: TImage;
    imgBoardSpace_67: TImage;
    imgBoardSpace_68: TImage;

    imgBoardSpace_73: TImage;
    imgBoardSpace_72: TImage;
    imgBoardSpace_71: TImage;
    imgBoardSpace_70: TImage;
    imgBoardSpace_69: TImage;
    imgBoardSpace_74: TImage;
    imgBoardSpace_75: TImage;
    imgBoardSpace_77: TImage;
    imgBoardSpace_76: TImage;
    imgBoardSpace_79: TImage;
    imgBoardSpace_81: TImage;
    imgBoardSpace_80: TImage;
    imgBoardSpace_78: TImage;
    imgBoardSpace_82: TImage;
    imgBoardSpace_83: TImage;
    imgBoardSpace_84: TImage;
    imgBoardSpace_85: TImage;
    imgBoardSpace_86: TImage;
    imgBoardSpace_88: TImage;
    imgBoardSpace_87: TImage;
    imgBoardSpace_89: TImage;
    pnlPlayer1: TPanel;
    pnlPlayer2: TPanel;
    pnlPlayer3: TPanel;
    pnlPlayer4: TPanel;
    pnlPlayer1RollDice: TPanel;
    pnlPlayer2RollDice: TPanel;
    pnlPlayer3RollDice: TPanel;
    pnlPlayer4RollDice: TPanel;
    imgDice: TImage;
    lblDiceResult: TLabel;
    procedure BtnExitBoardClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DiceRoll(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TPlayer = class
  var
    isActive : boolean;
  const
    tokenPath : string = '';
  //procedure MoveForward;
  end;

var
  FormBoard: TFormBoard;
  lastRoll : integer;
  ObjectIniCoordinates : array[1..89] of array[0..1] of integer;
  // --> An array of co-ordinates of each board space image box object
  // at initialisation of the form. Index if the main array is the number
  // of the image object, and in the second array the first index is the
  // left co-ordinates and the second the top.
  currentPlayer : string;
  PlayerList : array of string;

const
  DiceList: array [1 .. 6] of string = ('Dice_1.png', 'Dice_2.png',
    'Dice_3.png', 'Dice_4.png', 'Dice_5.png', 'Dice_6.png');

implementation

uses
  MainMenu_u, AskToExitBoard_u;
{$R *.dfm}

procedure TFormBoard.BtnExitBoardClick(Sender: TObject);
begin
  FormAskToExitBoard.Show;
end;

procedure TFormBoard.FormCreate(Sender: TObject);
begin
  // Colours defined in MainMenu_u
  pnlPlayer1RollDice.color := clRed_board;
  pnlPlayer2RollDice.color := clYellow_board;
  pnlPlayer3RollDice.color := clBlue_board;
  pnlPlayer4RollDice.color := clGreen_board;

  left := (Screen.Width div 2) - (FormBoard.Width div 2);
  top := (Screen.WorkAreaHeight div 2) - (FormBoard.Height div 2);
end;

// Dice:
procedure TFormBoard.DiceRoll(Sender: TObject);
var
  roll: integer;
  current, finish, start: integer;

begin
  Randomize;
  finish := 1000;
  start := 0;
  current := start;
  imgDice.Visible := True;

  while current < finish do
  begin
    roll := Random(6)+1; // including 1, excluding 7
    imgDice.Picture.LoadFromFile
      (GetCurrentDir + '/Media/Dice images/' + DiceList[roll]);
    Update;
    Sleep(100);
    lblDiceResult.Caption := IntToStr(roll);
    current := 100 + current;
  end;
  lastRoll := roll;
  Sleep(750);
  imgDice.Visible := False;
end;

end.
