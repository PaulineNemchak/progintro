program sortedlist;
type
    LongItemPtr = ^LongItem;
    LongItem = record
        data: longint;
        next: LongItemPtr;
    end;

var
    first, tmp: LongItemPtr;
    pp: ^LongItemPtr;
    n: longint;

procedure SortedInsert(var first: LongItemPtr; n: longint);
var
    pp: ^LongItemPtr;
    tmp: LongItemPtr;
begin
    pp := @first;
    while pp^ <> nil do begin
        if pp^^.data >= n then
            break;
        pp := @(pp^^.next);
    end;
    new(tmp);
    tmp^.next := pp^;
    tmp^.data := n;
    pp^ := tmp;
end;

procedure PrintList(first: LongItemPtr);
var
    cur: LongItemPtr;
begin
    cur := first;
    while cur <> nil do begin
        writeln(cur^.data);
        cur := cur^.next;
    end;
end;

procedure FreeList(var first: LongItemPtr);
var
    tmp: LongItemPtr;
begin
    while first <> nil do begin
        tmp := first;
        first := first^.next;
        dispose(tmp);
    end;
end;

begin
    first := nil;

    while not eof do begin
        readln(n);
        SortedInsert(first, n);
    end;

    PrintList(first);
    FreeList(first);
end.
