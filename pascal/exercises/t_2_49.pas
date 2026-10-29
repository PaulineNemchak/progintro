program t_2_49;
var
    f: text;
    line: string;
begin
    {$I-}

    if ParamCount < 1 then begin
        writeln(ErrOutput, 'Expected a file name');
        halt(1);
    end;

    assign(f, ParamStr(1));
    rewrite(f);
    if IOResult <> 0 then begin
        writeln('Couldn''t open the file');
        halt(1);
    end;

    while not eof do begin
        readln(line);
        writeln(f, line);
    end;

    close(f);
end.