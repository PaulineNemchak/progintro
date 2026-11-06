program t_2_42;

type
    WordT = array of char;
type
    WItemPtr = ^WItem;
    WItem = record
        data: WordT;
        next: WItemPtr;
    end;
type
    StackOfWords = WItemPtr;
const
    DefaultArrSize = 16;

procedure SOLInit(var stack: StackOfWords);
begin
    stack := nil;
end;

procedure SOLPush(var stack: StackOfWords; w: WordT);
var
    tmp: WItemPtr;
begin
    new(tmp);
    tmp^.data := w;
    tmp^.next := stack;
    stack := tmp;
end;

procedure SOLPop(var stack: StackOfWords; var w: WordT);
var
    tmp: WItemPtr;
begin
    w := stack^.data;
    tmp := stack;
    stack := stack^.next;
    dispose(tmp);
end;

function SOLIsEmpty(var stack: StackOfWords): boolean;
begin
    SOLIsEmpty := stack = nil;
end;

procedure PrintReversed(var stack: StackOfWords);
var
    w: WordT;
    i: integer;
    isFirst: boolean;
begin
    isFirst := true;
    while not SOLIsEmpty(stack) do begin
        SOLPop(stack, w);
        if not isFirst then
            write(' ');
        for i := 0 to Length(w) - 1 do
            write(w[i]);
        isFirst := false;
    end;
    writeln;
end;

var
    s: StackOfWords;
    w: WordT;
    c: char;
    count: integer;
begin
    SOLInit(s);
    count := 0;
    SetLength(w, DefaultArrSize);

    while not eof do begin
        read(c);
        if c = #10 then begin
            if count > 0 then begin
                SetLength(w, count);
                SOLPush(s, w);
                SetLength(w, DefaultArrSize);
                count := 0;
            end;
            PrintReversed(s);
        end
        else if (c = #9) or (c = #11) or (c = #32) or (c = #13) then begin
            if count > 0 then begin
                SetLength(w, count);
                SOLPush(s, w);
                SetLength(w, DefaultArrSize);
                count := 0;
            end;
        end
        else begin
            if count = Length(w) then
                SetLength(w, Length(w) * 2);
            w[count] := c;
            count := count + 1;
        end;
    end;

    if count > 0 then begin
        SetLength(w, count);
        SOLPush(s, w);
    end;
    if not SOLIsEmpty(s) then
        PrintReversed(s);
end.