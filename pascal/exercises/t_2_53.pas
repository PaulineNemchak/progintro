program t_2_53;
var
    f1, f2: text;
    f3: file of integer;
    line: string;
begin
    {$I-}
    if ParamCount < 3 then begin
        writeln(ErrOutput, 'Need 3 file names');
        halt(1);
    end;

    assign(f1, ParamStr(1));
    reset(f1);
    if IOResult <> 0 then begin
        writeln('Couldn''t open the first file');
        halt(1);
    end;

    assign(f2, ParamStr(2));
    rewrite(f2);
    if IOResult <> 0 then begin
        writeln('Couldn''t open the second file');
        halt(1);
    end;

    assign(f3, ParamStr(3));
    rewrite(f3);
    if IOResult <> 0 then begin
        writeln('Couldn''t open the third file');
        halt(1);
    end;

    while not Eof(f1) do begin
        readln(f1, line);
        if (length(line) > 0) and (line[1] = ' ') then
            writeln(f2, line);
        write(f3, length(line));
    end;

    close(f1);
    close(f2);
    close(f3);
end.
