unit AskToExitBoard_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormAskToExitBoard = class(TForm)
    LblWarningHeading: TLabel;
    BtnReturnToGame: TButton;
    BtnExitToMainMenu: TButton;
    BtnExitToDesktop: TButton;
    LblWarningMessage1: TLabel;
    LblWarningMessage2: TLabel;
    procedure BtnReturnToGameClick(Sender: TObject);
    procedure BtnExitToMainMenuClick(Sender: TObject);
    procedure BtnExitToDesktopClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAskToExitBoard: TFormAskToExitBoard;

implementation

uses Board_u, MainMenu_u;
{$R *.dfm}

procedure TFormAskToExitBoard.BtnReturnToGameClick(Sender: TObject);
begin
  FormAskToExitBoard.Hide;
end;

procedure TFormAskToExitBoard.BtnExitToMainMenuClick(Sender: TObject);
begin
  FormAskToExitBoard.Hide;
  FormBoard.Hide;
  FormMainMenu.Show;
end;

procedure TFormAskToExitBoard.BtnExitToDesktopClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
