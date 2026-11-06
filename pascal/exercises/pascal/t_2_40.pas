program t_2_40;

type
    LongRecPtr = ^LongRec;
    LongRec = record
        n: longint;
        counter: integer;
        next: LongRecPtr;
    end;

type
    QueueOfLongints = record
        first, last: LongRecPtr;
    end;

procedure QOLInit(var q: QueueOfLongints);
begin
    q.first := nil;
    q.last := nil;
end;

procedure QOLPut(var q: QueueOfLongints; n: longint);
var
    cur: LongRecPtr;
begin
    cur := q.first;
    while cur <> nil do begin
        if cur^.n = n then begin
            cur^.counter := cur^.counter + 1;
            exit;
        end;
        cur := cur^.next;
    end;

    if q.first = nil then begin
        new(q.first);
        q.last := q.first;
    end
    else begin
        new(q.last^.next);
        q.last := q.last^.next;
    end;

    q.last^.n := n;
    q.last^.next := nil;
    q.last^.counter := 1;
end;

procedure QOLRemove(var q: QueueOfLongints);
var
    tmp: LongRecPtr;
begin
    tmp := q.first;
    q.first := q.first^.next;
    if q.first = nil then
        q.last := nil;
    dispose(tmp);
end;

function QIsEmpty(var q: QueueOfLongints): boolean;
begin
    QIsEmpty := q.first = nil;
end;

var
    q: QueueOfLongints;
    cur: LongRecPtr;
    n: longint;
begin
    QOLInit(q);

    while not SeekEof do begin
        read(n);
        QOLPut(q, n);
    end;

    cur := q.first;
    while cur <> nil do begin
        if cur^.counter = 3 then
            writeln(cur^.n);
        cur := cur^.next;
    end;

    while not QIsEmpty(q) do
        QOLRemove(q);
end.