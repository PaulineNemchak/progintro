program t_2_50;
const
    AngleW = 10;
    ValW = 12;
    Undefined = 'undefined';
var
    f: text;
    stAngle, endAngle, step: real;
    angle, rad, s, c, t, ct: real;
    decimals, code, i: integer;

function FormatAngle(v: real; width: integer): string;
var
    s: string;
    p, i: integer;
begin
    Str(v:0:6, s);
    p := Pos('.', s);
    if p > 0 then begin
        i := length(s);
        while (i > p) and (s[i] = '0') do
            i := i - 1;
        if i = p then
            i := i - 1;
        s := Copy(s, 1, i);
    end;
    while length(s) < width do
        s := ' ' + s;
    FormatAngle := s;
end;

begin
    {$I-}

    if ParamCount < 5 then begin
        writeln(ErrOutput, 'The format is: file name, starting angle, ending angle, step, decimal places');
        halt(1);
    end;

    assign(f, ParamStr(1));
    rewrite(f);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'Couldn''t open the file');
        halt(1);
    end;

    Val(ParamStr(2), stAngle, code);
    if code <> 0 then begin
        writeln(ErrOutput, 'Invalid starting angle: ', ParamStr(2));
        halt(1);
    end;

    Val(ParamStr(3), endAngle, code);
    if code <> 0 then begin
        writeln(ErrOutput, 'Invalid ending angle: ', ParamStr(3));
        halt(1);
    end;

    Val(ParamStr(4), step, code);
    if (code <> 0) or (step = 0) then begin
        writeln(ErrOutput, 'Invalid step: ', ParamStr(4));
        halt(1);
    end;

    Val(ParamStr(5), decimals, code);
    if (code <> 0) or (decimals < 0) then begin
        writeln(ErrOutput, 'Invalid number of decimal places: ', ParamStr(5));
        halt(1);
    end;

    writeln(f, '| ', 'Angle':AngleW, ' | ', 'Sin':ValW, ' | ', 'Cos':ValW, ' | ', 'Tan':ValW, ' | ', 'Cot':ValW, ' |');
    for i := 1 to (2 + AngleW + 4 * (3 + ValW) + 2) do
        write(f, '-');
    writeln(f);

    angle := stAngle;
    while angle <= endAngle do begin
        rad := angle * pi / 180;
        s := sin(rad);
        c := cos(rad);
        if abs(s) < 1e-9 then s := 0;
        if abs(c) < 1e-9 then c := 0;

        write(f, '| ', FormatAngle(angle, AngleW), ' | ', s:ValW:decimals, ' | ', c:ValW:decimals, ' | ');

        if abs(c) > 1e-9 then begin
            t := s / c;
            if abs(t) < 1e-9 then t := 0;
            write(f, t:ValW:decimals, ' | ')
        end
        else
            write(f, Undefined:ValW, ' | ');

        if abs(s) > 1e-9 then begin
            ct := c / s;
            if abs(ct) < 1e-9 then ct := 0;
            writeln(f, ct:ValW:decimals, ' |')
        end
        else
            writeln(f, Undefined:ValW, ' |');

        angle := angle + step;
    end;

    close(f);
end.
