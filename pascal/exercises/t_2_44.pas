program LongestDigits;

type
    PDigit = ^TDigit;
    TDigit = record
        ch: char;
        next: PDigit;
    end;

    PSeq = ^TSeq;
    TSeq = record
        first, last: PDigit;
        len: int64;
        next: PSeq;
    end;

var
    cur: PSeq;
    resFirst, resLast: PSeq;
    maxLen: int64;

procedure FreeSeq(var s: PSeq);
var
    d, tmp: PDigit;
begin
    if s = nil then
        exit;
    d := s^.first;
    while d <> nil do begin
        tmp := d;
        d := d^.next;
        dispose(tmp)
    end;
    dispose(s);
    s := nil
end;

procedure FreeResult;
var
    tmp: PSeq;
begin
    while resFirst <> nil do begin
        tmp := resFirst;
        resFirst := resFirst^.next;
        FreeSeq(tmp)
    end;
    resLast := nil;
    maxLen := 0
end;

procedure AddDigit(c: char);
var
    d: PDigit;
begin
    new(d);
    d^.ch := c;
    d^.next := nil;
    if cur = nil then begin
        new(cur);
        cur^.first := d;
        cur^.len := 0;
        cur^.next := nil
    end
    else
        cur^.last^.next := d;
    cur^.last := d;
    cur^.len := cur^.len + 1
end;

procedure FinishSeq;
begin
    if cur = nil then
        exit;
    if cur^.len > maxLen then begin
        FreeResult;
        resFirst := cur;
        resLast := cur;
        maxLen := cur^.len
    end
    else if cur^.len = maxLen then begin
        resLast^.next := cur;
        resLast := cur
    end
    else
        FreeSeq(cur);
    cur := nil
end;

procedure EndLine;
var
    s: PSeq;
    d: PDigit;
begin
    FinishSeq;
    s := resFirst;
    while s <> nil do begin
        d := s^.first;
        while d <> nil do begin
            write(d^.ch);
            d := d^.next
        end;
        if s^.next <> nil then
            write(' ');
        s := s^.next
    end;
    writeln;
    FreeResult
end;

var
    c: char;
    pending: boolean;
begin
    cur := nil;
    resFirst := nil;
    resLast := nil;
    maxLen := 0;
    pending := false;
    while not eof do begin
        read(c);
        if c = #10 then begin
            EndLine;
            pending := false
        end
        else begin
            pending := true;
            if (c >= '0') and (c <= '9') then
                AddDigit(c)
            else
                FinishSeq
        end
    end;
    if pending then
        EndLine
end.