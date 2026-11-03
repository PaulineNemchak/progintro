progarm types;

type
    itemptr = ^item;
    item = record
        data: integer;
        next: itemptr;
    end;

var
    first: itemptr;
begin
    new(first);
    first^.data := 25;
    new(first^.next);
    first^.next^.data := 36;
    new(first^.next^.next);
    first^.next^.next^.data := 49;
    first^.next^.next^.next := nil;

    { dispose(pointer) }
    { ^pointer, value^ }
    { do in a cycle for every pointer in the chain }
end.