program t_2_47;
var
    f: text;
    line: string;
begin
    {$I-}

    if ParamCount < 1 then begin
        writeln(ErrOutput, 'Experted file name to read');
        halt(1);
    end;

    assign(f, ParamStr(1));
    Reset(f);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'Couldn''t read the file');
        halt(1);
    end;

    while not SeekEof(f) do begin
        readln(f, line);
        writeln(line);
    end;

    close(f);
end.