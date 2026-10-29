program t_2_55;

type
    TRecord = record
        id: string[59];
        counter: longint;
    end;

var
    f: file of TRecord;
    rec: TRecord;
    fileName, command, itemId: string;
    found: boolean;
    idx: longint;
begin
    {$I-}

    if ParamCount < 2 then begin
        writeln(ErrOutput, 'Need a file name and a command');
        halt(1);
    end;

    fileName := ParamStr(1);
    command := ParamStr(2);
    itemId := '';

    if (command = 'add') or (command = 'query') then begin
        if ParamCount < 3 then begin
            writeln(ErrOutput, 'Need an identifier');
            halt(1);
        end;
        itemId := ParamStr(3);
        if length(itemId) > 59 then begin
            writeln(ErrOutput, 'Identifier is too long (max 59 characters)');
            halt(1);
        end;
    end
    else if command <> 'list' then begin
        writeln(ErrOutput, 'Unknown command: ', command);
        halt(1);
    end;

    assign(f, fileName);
    reset(f);
    if IOResult <> 0 then begin
        rewrite(f);
        if IOResult <> 0 then begin
            writeln(ErrOutput, 'Couldn''t open ', fileName);
            halt(1);
        end;
    end;

    if command = 'list' then begin
        while not Eof(f) do begin
            read(f, rec);
            writeln(rec.id, ' ', rec.counter);
        end;
    end
    else if command = 'query' then begin
        found := false;
        while (not Eof(f)) and (not found) do begin
            read(f, rec);
            if rec.id = itemId then found := true;
        end;
        if found then
            writeln(rec.counter)
        else
            writeln(0);
    end
    else begin
        found := false;
        idx := 0;
        while (not Eof(f)) and (not found) do begin
            read(f, rec);
            if rec.id = itemId then
                found := true
            else
                idx := idx + 1;
        end;

        if found then begin
            rec.counter := rec.counter + 1;
            seek(f, idx);
            write(f, rec);
        end
        else begin
            rec.id := itemId;
            rec.counter := 1;
            seek(f, FileSize(f));
            write(f, rec);
        end;
    end;

    close(f);
end.
