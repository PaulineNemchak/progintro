program t_2_48;
var
    f: text;
    count: integer;
begin
    {$I-}

    if ParamCount < 1 then begin
        writeln(ErrOutput, 'Expected a text file name');
        halt(1);
    end;

    assign(f, ParamStr(1));
    Reset(f);
    if IOResult <> 0 then begin
        writeln('Couldn''t read the file');
        halt(1);
    end;

    count := 0;
    while not Eof(f) do begin
        readln(f);
        count := count + 1;
    end;
    close(f);
    writeln(count);
end.