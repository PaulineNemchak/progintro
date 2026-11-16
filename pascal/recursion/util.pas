program Util;

function ItemListSum(p: itemptr) : integer;
begin
    if p = nil then
        ItemListSum := 0
    else
        ItemListSum := p^.data + ItemListSum(p^.next);
end;

procedure DisposeItemList(p: itemptr);
begin
    if p = nil then
        exit;
    DisposeItemList(p^.next);
    dispose(p);
end;

procedure AddNumIntoSortedList(var p: itemptr; n: integer);
var
    tmp: itemptr;
begin
    if (p = nil) or (p^.data > n) then begin
        new(tmp);
        tmp^.data := n;
        tmp^.next := p;
        p := tmp;
    end
    else
        AddNumIntoSortedList(p^.next, n)
end;