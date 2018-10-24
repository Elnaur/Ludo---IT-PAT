unit Victory_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFormVictory = class(TForm)
    lblWinnerName: TLabel;
    pnlYouWon: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVictory: TFormVictory;

implementation

uses Board_u;

{$R *.dfm}


procedure TFormVictory.FormShow(Sender: TObject);
begin
  lblWinnerName.Caption := lblWinnerName.Caption + IntToStr(Winner.playerNumber) + ',';
  pnlYouWon.Color := Winner.ActivePanelColor
end;

end.
