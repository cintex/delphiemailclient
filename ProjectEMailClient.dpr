program ProjectEMailClient;

uses
  Forms,
  UnitEMailClient in 'UnitEMailClient.pas' {FormEMail},
  mClient in 'mClient.pas',
  mConnection in 'mConnection.pas',
  mList in 'mList.pas',
  UnitPOPClient in 'UnitPOPClient.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormEMail, FormEMail);
  Application.Run;
end.
