program sum100;

// repeat <операторы> until <условие>
var
    sum: integer;
    x: integer;

begin
    sum := 0;
    repeat
        readln(x);
        sum := sum + x;
    until (sum > 100);
end.