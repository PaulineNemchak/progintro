program quadratic;

procedure CalculateQuadratic(a, b, c: real; var ok: boolean; var x1, x2: real);
var
    d: real;
begin
    ok := false;
    if a = 0 then
        exit;

    d := b*b - 4*a*c;
    if d < 0 then
        exit;
    d := sqrt(d);
    x1 := (-b - d) / (2*a);
    x2 := (-b + d) / (2*a);
    ok := true
end;

var
    a, b, c, x1, x2: real;
    ok: boolean;
begin
    write('type your 3 coefficients: ');
    readln(a, b, c);

    CalculateQuadratic(a, b, c, ok, x1, x2);

    if ok then begin
        writeln('x1 = ', x1:0:4);
        writeln('x2 = ', x2:0:4);
    end

    else
        writeln('No real solutions (or a = 0).');
end.