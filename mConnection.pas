(*
 * Materialien zu den zentralen Abiturpruefungen
 * im Fach Informatik ab 2012 in Nordrhein-Westfalen.
 *
 * Klasse TConnection
 *
 * NW-Arbeitsgruppe:
 * Materialentwicklung zum Zentralabitur im Fach Informatik
 *
 * Version 2011-01-17
 *)
unit mConnection;

interface

uses  ScktComp, Forms, Windows, Messages, SysUtils, Classes, Graphics, Controls,
      Dialogs, StDCtrls, mList;
const
    ZEILENENDE=#$D#$A;
    TIMEOUT:real = 20 ; // 20 Sekunden Timeout für "empfangeneNachricht"   TIMEOUT

type
  stringObjekt = class
                  private
                   inhalt:string;
                  public
                   constructor create(pInhalt:string);
                   procedure setzeInhalt(pInhalt:string);
                   function gibInhalt:string;
                   destructor destroy;override;
                 end;

  TConnection = class
                private
                 clientSocket:TClientSocket;
                 angemeldet:boolean;
                 serverPort, clientport:integer;
                 serverAdresse, clientAdresse:string;
                 nachricht:string;
                 fehler:boolean;
                protected
                 liste:TList;
                 procedure ClientSocketRead(Sender: TObject;Socket: TCustomWinSocket); virtual;
                 procedure ClientSocketError(Sender: TObject;Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: integer);
                 procedure ClientSocketConnect(Sender: TObject;Socket: TCustomWinSocket);
                public
                 constructor create(pServerIP:string; pServerPort:integer);
                 procedure send(pMessage:string);virtual;
                 function receive:string;
                 destructor destroy; override;
                end;
implementation

    constructor stringObjekt.create(pInhalt:string);
    begin
      inhalt:=pInhalt;
    end;

    procedure stringObjekt.setzeInhalt(pInhalt:string);
    begin
      inhalt:=pInhalt;
    end;

    function stringObjekt.gibInhalt:string;
    begin
      result:=inhalt;
    end;

    destructor stringObjekt.destroy;
    begin
    end;

   constructor TConnection.create(pServerIP:string; pServerPort:integer);
   begin
    liste:=TList.create;
    clientSocket:=TClientSocket.Create(nil);
    clientSocket.Host:=pServerIP;
    clientSocket.Port:=pServerPort;
    fehler:=false;
    clientSocket.onError:=clientSocketError;
    clientSocket.onRead:=ClientSocketRead;
    clientSocket.onConnect:=ClientSocketConnect;
    clientSocket.open;
    while not clientSocket.socket.connected and not fehler do
      application.processMessages;
  end;

  procedure TConnection.send(pMessage:string);
  begin
    clientSocket.socket.sendText(pMessage+ZEILENENDE);
    nachricht:='';
  end;

  function TConnection.receive:string;
  var
    lNachricht,lEnde:string;
    lStartzeit:real;
  begin
    lStartzeit := Now();
    while (liste.isEmpty) and ((Now() - lStartzeit) < TIMEOUT* 1.0/(24*60*60) ) do
      application.processMessages;
    if liste.isEmpty then
      result:=''
    else
      while not liste.isEmpty do begin
        liste.toFirst;
        lNachricht:=lNachricht+stringObjekt(liste.getObject).Inhalt;
        liste.remove;
      end;
    lEnde:=copy(lNachricht,length(lNachricht)-length(ZEILENENDE)+1,length(ZEILENENDE));
     if lEnde=ZEILENENDE then
        delete(lNachricht,length(lNachricht)-length(ZEILENENDE)+1,length(ZEILENENDE));
    result:=lNachricht;
  end;

  destructor TConnection.destroy;
  begin
    clientSocket.close;
    angemeldet:=false;
  end;

  procedure TConnection.ClientSocketRead(Sender: TObject;Socket: TCustomWinSocket);
  var
    lNachricht, lEineNachricht:string;
    lPos:integer;
  begin
    lNachricht:=Socket.receiveText;
    repeat
      lPos := pos(ZEILENENDE,lNachricht);
      if lPos>0 then begin
        lEineNachricht:=copy(lNachricht,1,lPos+length(ZEILENENDE)-1);
        delete(lNachricht,1,lPos+length(ZEILENENDE)-1);
      end else begin
        lEineNachricht := lNachricht;
        lNachricht := ''
      end;
      liste.append(stringObjekt.create(lEineNachricht));
    until lNachricht='';

  end;


  procedure TConnection.ClientSocketConnect(Sender: TObject;Socket: TCustomWinSocket);
  begin
    serverAdresse:=clientSocket.socket.remoteAddress;
    serverPort:=clientSocket.socket.remotePort;
    clientAdresse:=clientSocket.socket.localAddress;
    clientPort:=clientSocket.socket.localPort;
    angemeldet:=true;
  end;

  procedure TConnection.ClientSocketError(Sender: TObject;Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: integer);
  var
    lFehler:string;
  begin
    case ErrorEvent of
    eeGeneral:lFehler:='Unbekannter Fehler';
    eeSend:lFehler:='Der Client konnte nicht senden';
    eeReceive:lFehler:='Der Client konnte keine Nachricht empfangen';
    eeConnect:lFehler:='Der Client konnte keine TConnection aufbauen';
    eeDisconnect:lFehler:='Die TConnection konnte nicht geschlossen werden.';
    eeAccept:lFehler:='Der Client konnte keine TConnection aufbauen';
   else
      lFehler:='TConnectionsfehler';
    end;
    fehler:=true;
  end;

end.
