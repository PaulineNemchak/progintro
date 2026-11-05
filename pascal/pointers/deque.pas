program Deque;
type
    LongItem2Ptr = ^LongItem2;
    LongItem2 = record
        data: longint;
        prev, next: LongItem2Ptr;
    end;

    LongDeque = record
        first, last: LongItem2Ptr;
    end;

procedure LongDequeInit(var deque: LongDeque);
begin
    deque.first := nil;
    deque.last := nil;
end;

procedure LongDequePushFront(var deque: LongDeque; n: longint);
var
    tmp: LongItem2Ptr;
begin
    new(tmp);
    tmp^.data := n;
    tmp^.next := deque.first;
    tmp^.prev := nil;
    if deque.first = nil then
        deque.last := tmp
    else
        deque.first^.prev := tmp;
    deque.first := tmp;
end;

procedure LongDequePushBack(var deque: LongDeque; n: longint);
var
    tmp: LongItem2Ptr;
begin
    new(tmp);
    tmp^.data := n;
    tmp^.prev := deque.last;
    tmp^.next := nil;
    if deque.last = nil then
        deque.first := tmp
    else
        deque.last^.next := tmp;
    deque.last := tmp;
end;

procedure LongDequePopFront(var deque: LongDeque; var n: longint);
var
    tmp: LongItem2Ptr;
begin
    n := deque.first^.data;
    tmp := deque.first;
    deque.first := deque.first^.next;
    if deque.first = nil then
        deque.last := nil
    else
        deque.first^.prev := nil;
    dispose(tmp);
end;

procedure LongDequePopBack(var deque: LongDeque; var n: longint);
var
    tmp: LongItem2Ptr;
begin
    n := deque.last^.data;
    tmp := deque.last;
    deque.last := deque.last^.prev;
    if deque.last = nil then
        deque.first := nil
    else
        deque.last^.next := nil;
    dispose(tmp);
end;

function LongDequeIsEmpty(var deque: LongDeque): boolean;
begin
    LongDequeIsEmpty := deque.first = nil;
end;

var
    dq: LongDeque;
    n: longint;
begin
    LongDequeInit(dq);

    while not eof do begin
        readln(n);
        if n div 2 = 1 then
            LongDequePushFront(dq, n)
        else
            LongDequePushBack(dq, n);
    end;

    while not LongDequeIsEmpty(dq) do begin
        LongDequePopFront(dq, n);
        writeln(n);
    end;
end.