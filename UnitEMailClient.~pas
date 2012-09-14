unit UnitEMailClient;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, UnitPOPClient;

type
  TFormEMail = class(TForm)
    LabelUsername: TLabel;
    EditUsername: TEdit;
    LabelPass: TLabel;
    EditPassword: TEdit;
    LabelPOP: TLabel;
    EditPOP: TEdit;
    LabelPort: TLabel;
    EditPort: TEdit;
    ButtonConnect: TButton;
    ButtonMailList: TButton;
    MemoOutput: TMemo;
    EditMailNr: TEdit;
    LabelMailNr: TLabel;
    ButtonRead: TButton;
    ButtonDeleteMail: TButton;
    ButtonUndeleteAll: TButton;
    procedure ButtonConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


var
  FormEMail: TFormEMail;
  ClientConnection: TPopClient;


implementation

{$R *.DFM}

procedure TFormEMail.ButtonConnectClick(Sender: TObject);
var
   answer: string;
begin
     ClientConnection := TPopClient.create(EditPOP.text, StrToIntDef(EditPort.text,110));
     
     ClientConnection.authenticate(EditUsername.text, EditPassword.text);

end;

procedure TFormEMail.FormCreate(Sender: TObject);
begin
     ConnectionStatus := Disconnect;
end;

end.
