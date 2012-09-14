(*
 * Materialien zu den zentralen Abiturpruefungen
 * im Fach Informatik ab 2012 in Nordrhein-Westfalen.
 *
 * Klasse TClient
 *
 * NW-Arbeitsgruppe:
 * Materialentwicklung zum Zentralabitur im Fach Informatik
 *
 * Version 2011-01-17
 *)

unit mClient;

interface

uses  mConnection, mList, scktComp;

type

  TClient = class(TConnection)
                       protected
                       procedure ClientSocketRead(Sender: TObject;Socket: TCustomWinSocket); override;
                       public
                       procedure processMessage(pMessage:string);virtual;
                       destructor destroy;override;
                     end;
implementation

    procedure TClient.ClientSocketRead(Sender: TObject;Socket: TCustomWinSocket);
    var
      lNachricht:string;
    begin
      inherited ClientSocketRead(Sender,Socket);
      while not liste.isEmpty do begin
        liste.toFirst;
        lNachricht:=StringObjekt(liste.getObject).gibInhalt;
        liste.remove;
        processMessage(lNachricht);
      end;
    end;

    procedure TClient.processMessage(pMEssage:String);
    begin end;

    destructor TClient.destroy;
    var
     lNachricht:string;
    begin
      while not liste.isEmpty do begin
        liste.toFirst;
        lNachricht:=StringObjekt(liste.getObject).gibInhalt;
        liste.remove;
        processMessage(lNachricht);
      end;
      inherited destroy;
    end;

end.
