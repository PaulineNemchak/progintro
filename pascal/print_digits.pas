program PrintDigits;

procedure PrintDigitsOfNumber(n: integer);
begin
    if n > 0 then begin
        PrintDigitsOfNumber(n div 10);
        write(n mod 10, ' ');
    end;
end;

var
    i: integer;
begin
    write('type an integer: ');
    readln(i);

    PrintDigitsOfNumber(i);
end.

{
function DoReverseNumber(n, m: longint): longint;
begin
    if n = 0 then
        DoReverseNumber := m
    else
        DoReverseNumber := DoReverseNumber(n div 10, m * 10 + n mod 10)
end;

function ReverseNumber(n: longint): longint;
begin
    ReverseNumber := DoReverseNumber(n, 0)
end;

m – accumulates the result
}