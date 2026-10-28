program AbsoluteValue;
// if <условие> then <оператор1> [ else <оператор2> ]
var
    x: integer;

begin
    read(x);
    if (x > 0) then
        writeln(x)
    else
        writeln(-x);
end.