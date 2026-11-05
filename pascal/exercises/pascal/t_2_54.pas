program t_2_54;
var
    f: file of longint;
    fOut: text;
    n, minVal, maxVal: longint;
    count, fi: integer;
begin
    {$I-}

    if ParamCount < 2 then begin
        writeln(ErrOutput, 'Need at least one input file and an output file name');
        halt(1);
    end;

    assign(fOut, ParamStr(ParamCount));
    rewrite(fOut);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'Couldn''t create the output file');
        halt(1);
    end;

    for fi := 1 to ParamCount - 1 do begin
        assign(f, ParamStr(fi));
        reset(f);
        if IOResult <> 0 then begin
            writeln(ErrOutput, 'Couldn''t open ', ParamStr(fi));
            halt(1);
        end;

        count := 0;
        while not Eof(f) do begin
            read(f, n);
            if count = 0 then begin
                minVal := n;
                maxVal := n;
            end
            else begin
                if n < minVal then minVal := n;
                if n > maxVal then maxVal := n;
            end;
            count := count + 1;
        end;

        close(f);

        if count = 0 then
            writeln(fOut, ParamStr(fi), ' ', count)
        else
            writeln(fOut, ParamStr(fi), ' ', count, ' ', minVal, ' ', maxVal);
    end;

    close(fOut);
end.
