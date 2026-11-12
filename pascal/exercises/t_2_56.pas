program t_2_56;

type
    TRecord = record
        id: string[59];
        counter: longint;
    end;

var
    f1, f2, f3: file of TRecord;
    rec1, rec2, rec3: TRecord;
    idx: longint;
    found: boolean;
begin
    {$I-}

    if ParamCount < 3 then begin
        writeln(ErrOutput, 'Need 3 parameters: 2 files to read and 1 file to write');
        halt(1);
    end;

    assign(f1, ParamStr(1));
    reset(f1);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'couldn''t read the first file');
        halt(1);
    end;

    assign(f2, ParamStr(2));
    reset(f2);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'couldn''t read the second file');
        halt(1);
    end;

    assign(f3, ParamStr(3));
    rewrite(f3);
    if IOResult <> 0 then begin
        writeln(ErrOutput, 'couldn''t write the third file');
        halt(1);
    end;

    while not Eof(f1) do begin
        read(f1, rec1);
        write(f3, rec1);
    end;

    while not Eof(f2) do begin
        read(f2, rec2);
        found := false;
        idx := 0;
        seek(f3, 0);
        while (not Eof(f3)) and (not found) do begin
            read(f3, rec3);
            if rec3.id = rec2.id then
                found := true
            else
                idx := idx + 1;
        end;

        if found then begin
            rec3.counter := rec3.counter + rec2.counter;
            seek(f3, idx);
            write(f3, rec3);
        end
        else begin
            seek(f3, FileSize(f3));
            write(f3, rec2);
        end;
    end;

    close(f1);
    close(f2);
    close(f3);
end.
