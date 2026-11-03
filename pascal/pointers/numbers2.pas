program Numbers2;
type
    itemptr = ^item;
    item = record
        data: integer;
        next: itemptr;
    end;

var
    first, tmp, last: itemptr;
    n: integer;
begin
    first := nil;

    while not SeekEof do begin
        read(n);
        new(tmp);
        tmp^.data := n;
        tmp^.next := nil;

        if first = nil then
            first := tmp
        else
            last^.next := tmp;
        last := tmp;
    end;

    tmp := first;
    while tmp <> nil do begin
        writeln(tmp^.data);
        tmp := tmp^.next;
    end;

    while first <> nil do begin
        tmp := first^.next;
        dispose(first);
        first := tmp;
    end;
end.