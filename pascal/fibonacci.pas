program fibonacci;

function Fibonacci(n: integer): longint;
var
    i: integer;
    p, q, r: longint;
begin
    if n <= 0 then
        Fibonacci := 0
    else begin
        q := 0;
        r := 1;
        for i := 2 to n do begin
            p := q;
            q := r;
            r := p + q;
        end;
        Fibonacci := r;
    end;
end;

var
    t: integer;
    num: longint;
begin
    write('Enter the number of the number: ');
    readln(t);

    num := Fibonacci(t);
    writeln(num);
end.

{
function IsDigit(ch: char): boolean;
begin
    IsDigit := (ch >= ’0’) and (ch <= ’9’)
end;
}