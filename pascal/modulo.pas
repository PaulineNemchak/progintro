program modulo;

var
    x: integer;

begin
    read(x);
    if x < 0 then
        x := -x;
    writeln(x);
end.

{
if a > b then begin
    t := a;
    a := b;
    b := t
end

or

if a > b then
begin
    t := a;
    a := b;
    b := t
end

or

if a > b then
    begin
        t := a;
        a := b;
        b := t
    end
}