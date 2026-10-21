program t_2_24;

var
    x, y, p: real;
    n, code: integer;
    s: string;
begin
    if ParamCount <> 3 then begin
        writeln(stderr, 'Wrong number of arguments: ', ParamCount, '. Instruction: ', ParamStr(0), ' x y n');
        halt(1);
    end;

    Val(ParamStr(1), x, code);
    if code <> 0 then begin
        writeln(stderr, 'Error: the first parameter is not a number');
        halt(1);
    end;

    Val(ParamStr(2), y, code);
    if code <> 0 then begin
        writeln(stderr, 'Error: the second parameter is not a number');
        halt(1);
    end;

    Val(ParamStr(3), n, code);
    if (code <> 0) or (n < 0) then begin
        writeln(stderr, 'Erorr: n should be a positive integer');
        halt(1);
    end;

    p := x * y;
    Str(p:0:n, s);

    if Pos('.', s) > 0 then begin
        while s[Length(s)] = '0' do
            Delete(s, Length(s), 1);
        if s[Length(s)] = '.' then
            Delete(s, Length(s), 1);
    end;

    if s = '-0' then
        s := '0';
    
    writeln(s);
end.