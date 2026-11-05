program Numbers3;
{ insert left in the beginning of the list}
type
    item2ptr = ^item2;
    item2 = record
        data: integer;
        prev, next: item2ptr;
    end;
var
    first, tmp, last: item2ptr;
    n: integer;
begin
    first := nil;
    last := nil;

    while not SeekEof do begin
        read(n);
        new(tmp);
        tmp^.data := n;
        tmp^.prev := nil;
        tmp^.next := first;
        if first = nil then
            last := tmp
        else
            first^.prev := tmp;
        first := tmp;
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
    insert left general:
    new(tmp);
    if current = nil then
        tmp^.prev := last
    else
        tmp^.prev := current^.prev;
    tmp^.next := current;
    tmp^.data := n;
    if tmp^.prev = nil then
        first := tmp
    else
        tmp^.prev^.next := tmp;
    if tmp^.next = nil then
        last := tmp
    else
        tmp^.next^.prev := tmp;
}
{
    insert right in the end of the list:
    new(tmp);
    tmp^.data := n;
    tmp^.prev := last;
    tmp^.next := nil;
    if last = nil then
    first := tmp
        else
    last^.next := tmp;
        last := tmp;
}
{
    insert right general:
    new(tmp);
    tmp^.prev := current;
    if current = nil then
        tmp^.next := first
    else
        tmp^.next := current^.next;
    tmp^.data := n;
    if tmp^.prev = nil then
        first := tmp
    else
        tmp^.prev^.next := tmp;
    if tmp^.next = nil then
        last := tmp
    else
        tmp^.next^.prev := tmp;
}

{
    delete general:
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