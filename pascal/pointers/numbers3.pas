program Numbers3;
type
    item2ptr = ^item2;
    item2 = record
        data: integer;
        prev, next: item2ptr;
    end;
var
    first, tmp, last, current: item2ptr;
    n: integer;
begin
    first := nil;
    last := nil;
    current := first;

    while not SeekEof do begin
        read(n);
        new(tmp);
        tmp^.data := n;

        if current = nil then begin
            tmp^.prev := nil;
            tmp^.next := nil;
            first := tmp;
            last := tmp;
        end else begin
            tmp^.prev := current^.prev;
            tmp^.next := current;
            if current^.prev = nil then
                first := tmp
            else
                current^.prev^.next := tmp;
            current^.prev := tmp;
        end;

        current := first;
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

{
    insert right:
    new(tmp);
    tmp^.prev := current;
    tmp^.next := current^.next;
    tmp^.data := n;
    if current^.next = nil then
        last := tmp
    else
        current^.next^.prev := tmp;
    current^.next := tmp;
}

{
    delete:
    if current^.prev = nil then
        first := current^.next
    else
        current^.prev^.next := current^.next;
    if current^.next = nil then
        last := current^.prev
    else
        current^.next^.prev := current^.prev;
    dispose(current);
}