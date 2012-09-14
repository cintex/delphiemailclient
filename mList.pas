(*
 * Materialien zu den zentralen Abiturpruefungen
 * im Fach Informatik ab 2012 in Nordrhein-Westfalen.
 *
 * Klasse TList
 *
 * NW-Arbeitsgruppe:
 * Materialentwicklung zum Zentralabitur im Fach Informatik
 *
 * Version 2010-12-28
 *)

UNIT mList;

interface
type
  TNode = class
 private
    content: TObject;
    nextNode: TNode;
    constructor create(pObject: TObject);
    procedure setContent(pObject: TObject);
    procedure setNext(pNext: TNode);
    function getContent: TObject;
    function getNext: TNode;
    destructor destroy; override;
  end;

  TList = class
  private
    first: TNode;
    tail: TNode;
    current: TNode;
   public
     constructor create; virtual;
     function isEmpty: boolean; virtual;
     function hasAccess: boolean; virtual;
     procedure next; virtual;
     procedure toFirst; virtual;
     procedure toLast; virtual;
     function getObject: TObject; virtual;
     procedure setObject(pObject: TObject); virtual;
     procedure append(pObject: TObject); virtual;
     procedure insert(pObject: TObject); virtual;
     procedure concat(pList: TList); virtual;
     procedure remove; virtual;
     destructor destroy; override;
   end;

implementation

// TNode

constructor TNode.create(pObject: TObject);
begin
  content := pObject;
  nextNode := nil;
end;

procedure TNode.setContent(pObject: TObject);
begin
  content := pObject;
end;

procedure TNode.setNext(pNext: TNode);
begin
  nextNode := pNext;
end;

function TNode.getContent: TObject;
begin
  result := content;
end;

function TNode.getNext: TNode;
begin
  result := nextNode;
end;

destructor TNode.destroy;
begin
  inherited destroy;
end;

// TList

constructor TList.create;
begin
  tail := TNode.create(nil); // dummy
  first := tail;
  tail.setNext(tail); // dummy.next toLast
  current := first;
end;

function TList.isEmpty: boolean;
begin
  result := first = tail;
end;

function TList.hasAccess: boolean;
begin
  result := not self.isEmpty and (current <> tail);
end;

procedure TList.next;
begin
  if self.hasAccess then
    current := current.getNext;
end;

procedure TList.toFirst;
begin
  if not self.isEmpty then
    current := first;
end;

procedure TList.toLast;
begin
  if not self.isEmpty then
    current := tail.getNext;
end;

function TList.getObject: tObject;
begin
  if self.hasAccess then
    result := current.getContent
  else
    result := nil;
end;

procedure TList.setObject(pObject: TObject);
begin
  if (pObject <> nil) and self.hasAccess then
    current.setContent(pObject)
end;

procedure TList.insert(pObject: TObject);
var
  currentPos, aktPos, newNode, frontNode:TNode;
begin
  if pObject <> nil then
  begin
    if self.isEmpty then
      self.append(pObject)
    else
    begin
      if self.hasAccess then
      begin
        currentPos := current;
        aktPos := current;
        newNode := TNode.create(pObject);
        newNode.setNext(current);
        if aktPos = first then
          first := newNode
        else
        begin
          self.toFirst;
          frontNode := current;
          while self.hasAccess and (current <> aktPos) do
          begin
            frontNode := current;
            self.next;
          end;
          frontNode.setNext(newNode);
        end;
        current := currentPos;
      end;
    end;
  end;
end;

procedure TList.append(pObject: TObject);
var
  currentPos, newNode, previousNode: TNode;
begin
  if pObject <> nil then
  begin
    currentPos := current;
    newNode := TNode.create(pObject);
    newNode.setNext(tail);
    if self.isEmpty then
      first := newNode
    else
    begin
      previousNode := tail.getNext;
      previousNode.setNext(newNode);
    end;
    tail.setNext(newNode);
    current := currentPos;
  end;
end;

procedure TList.concat(pList: TList);
var
  currentPos,lastNode,dummy: TNode;
begin
  if (pList <> nil) and not pList.isEmpty then
  begin
    if self.isEmpty then
    begin
      first := pList.first;
      tail := pList.tail;
      current := tail;
    end
    else
    begin
      currentPos := current;
      lastNode := tail.getNext;
      tail := pList.tail;
      dummy := lastNode.nextNode;
      lastNode.setNext(pList.first);
      if currentPos = dummy then
        current := tail
      else
       current := currentPos;
      dummy.destroy;
    end;
      pList.tail := TNode.create(nil);
      pList.first := pList.tail;
      pList.tail.setNext(pList.tail);
      pList.current := pList.first;
  end;
end;

procedure TList.remove;
var
  currentPos, markPos, frontPos: TNode;
begin
  if not self.isEmpty and self.hasAccess then
  begin
    currentPos := current;
    if current = first then
    begin
      first := current.getNext;
      if current.getNext = tail then
        tail.setNext(first);
      current := first;
    end else
    begin
      markPos := current;
      self.toFirst;
      frontPos := current;
      while self.hasAccess and (current <> markPos) do
      begin
        frontPos := current;
        self.next;
      end;
      frontPos.setNext(markPos.getNext);
      current := frontPos.getNext;
      if current = tail then
        tail.setNext(frontPos);
    end;
    currentPos.destroy;
  end;
end;


destructor TList.destroy;
begin
  while not self.isEmpty do
  begin
    self.toFirst;
    self.remove;
  end;
  tail.destroy;
  inherited destroy;
end;

end.
