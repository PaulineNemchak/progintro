program t_2_18;

function DigitValue(c: char): integer;
begin
    if (c >= '0') and (c <='9') then
        DigitValue := ord(c) - ord('0')
    else if (c >= 'A') and (c <= 'Z') then
        DigitValue := ord(c) - ord('A') + 10
    else if (c >= 'a') and (c <= 'z') then
        DigitValue := ord(c) - ord('a') + 10
    else
        DigitValue := -1;
end;

procedure ReadLongint(var success: boolean; var result: longint; base: integer);
var
    c: char;
    res: longint;
    pos: integer;
    d: integer;
begin
    res := 0;
    pos := 0;
    repeat
        read(c);
        pos := pos + 1;
    until (c <> ' ') and (c <> #10);

    while (c <> ' ') and (c <> #10) do begin
        d := DigitValue(c);
        if (d < 0) or (d >= base) then begin
            writeln('Unexpected ''', c, ''' in pos: ', pos);
            readln;
            success := false;
            exit;
        end;
        res := res * base + d;
        read(c);
        pos := pos + 1;
    end;
    result := res;
    success := true;
end;

var
    x, y: longint;
    ok: boolean;
begin
    repeat
        write('Please type the first number (base 10): ');
        ReadLongint(ok, x, 10);
    until ok;
    repeat
        write('Please type the second number: ');
        ReadLongint(ok, y, 10);
    until ok;
    writeln(x, ' times ', y, ' is ', x * y);
end.