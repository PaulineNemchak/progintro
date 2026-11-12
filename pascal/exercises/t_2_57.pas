program t_2_57;

type
    TRecord = record
        id: string[59];
        counter: longint;
    end;
    TRecFile = file of TRecord;

var
    f: TRecFile;
    rec: TRecord;
    fileName, command, itemId: string;
    found: boolean;
    idx: longint;

function findPosition(var f: TRecFile; const targetId: string; var found: boolean; var rec: TRecord): longint;
var
    lo, hi, mid: longint;
begin
    lo := 0;
    hi := FileSize(f) - 1;
    found := false;
    while (lo <= hi) and (not found) do begin
        mid := (lo + hi) div 2;
        seek(f, mid);
        read(f, rec);
        if rec.id = targetId then begin
            found := true;
            lo := mid;
        end
        else if rec.id < targetId then
            lo := mid + 1
        else
            hi := mid - 1;
    end;
    findPosition := lo;
end;

procedure insertAt(var f: TRecFile; idx: longint; newRec: TRecord);
var
    i: longint;
    tmp: TRecord;
begin
    for i := FileSize(f) - 1 downto idx do begin
        seek(f, i);
        read(f, tmp);
        seek(f, i + 1);
        write(f, tmp);
    end;
    seek(f, idx);
    write(f, newRec);
end;

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
        idx := findPosition(f, itemId, found, rec);
        if found then
            writeln(rec.counter)
        else
            writeln(0);
    end
    else begin
        idx := findPosition(f, itemId, found, rec);
        if found then begin
            rec.counter := rec.counter + 1;
            seek(f, idx);
            write(f, rec);
        end
        else begin
            rec.id := itemId;
            rec.counter := 1;
            insertAt(f, idx, rec);
        end;
    end;

    close(f);
end.
