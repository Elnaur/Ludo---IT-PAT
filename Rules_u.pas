unit Rules_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormRules = class(TForm)
    LblRulesListText: TLabel;
    BtnExitRulesList: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnExitRulesListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRules: TFormRules;

implementation

{$R *.dfm}

procedure TFormRules.BtnExitRulesListClick(Sender: TObject);
begin
  FormRules.hide;
end;

procedure TFormRules.FormCreate(Sender: TObject);
var
  RulesList: TextFile;
  line: string;
begin
  text := '';
  if FileExists(GetCurrentDir + '/Media/Text/LudoRules.txt') then
    begin
      Assignfile(rulesList, GetCurrentDir + '/Media/Text/LudoRules.txt');
      Reset(rulesList);
      while not(Eof(RulesList)) do
      begin
        Readln(rulesList, line);
        lblRulesListText.Caption := LblRulesListText.Caption + #13#10 + Line;
      end;
      CloseFile(rulesList);
    end
  else
    ShowMessage('File ''LudoRules.txt'' does not exist.');

end;

end.
