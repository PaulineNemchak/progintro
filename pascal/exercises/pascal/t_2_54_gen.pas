program t_2_54_gen;
var
    f: file of longint;
    n: longint;
begin
    {$I-}

    if ParamCount < 1 then begin
        writeln(ErrOutput, 'Need an output file name');
        halt(1);
    end;

    assign(f, ParamStr(1));
    rewrite(f);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'Couldn''t create the file');
        halt(1);
    end;

    while not Eof(Input) do begin
        read(n);
        write(f, n);
    end;

    close(f);
end.
