program t_2_52;

type
    TBuffer = record
        data: array of char;
        len: integer;
    end;
    TFileResult = record
        name: string;
        line: TBuffer;
    end;

procedure BufInit(var b: TBuffer);
begin
    b.len := 0;
    SetLength(b.data, 0);
end;

procedure BufAppend(var b: TBuffer; ch: char);
begin
    if b.len >= length(b.data) then begin
        if length(b.data) = 0 then
            SetLength(b.data, 16)
        else
            SetLength(b.data, length(b.data) * 2);
    end;
    b.data[b.len] := ch;
    b.len := b.len + 1;
end;

procedure BufCopy(var dst: TBuffer; const src: TBuffer);
var
    i: integer;
begin
    SetLength(dst.data, src.len);
    dst.len := src.len;
    for i := 0 to src.len - 1 do
        dst.data[i] := src.data[i];
end;

procedure BufWrite(const b: TBuffer);
var
    i: integer;
begin
    for i := 0 to b.len - 1 do
        write(b.data[i]);
end;

var
    results: array of TFileResult;
    f: text;
    line, best: TBuffer;
    ch: char;
    fi, globalMax: integer;
    hasBest: boolean;
begin
    {$I-}

    if ParamCount < 1 then begin
        writeln(ErrOutput, 'Expected at least one file name');
        halt(1);
    end;

    SetLength(results, ParamCount);

    for fi := 1 to ParamCount do begin
        results[fi - 1].name := ParamStr(fi);
        BufInit(results[fi - 1].line);

        assign(f, ParamStr(fi));
        reset(f);
        if IOResult <> 0 then begin
            writeln(ErrOutput, 'Couldn''t open ', ParamStr(fi));
            halt(1);
        end;

        hasBest := false;
        BufInit(best);

        while not Eof(f) do begin
            BufInit(line);
            while not Eoln(f) do begin
                read(f, ch);
                BufAppend(line, ch);
            end;
            readln(f);

            if (not hasBest) or (line.len > best.len) then begin
                BufCopy(best, line);
                hasBest := true;
            end;
        end;

        close(f);
        BufCopy(results[fi - 1].line, best);
    end;

    globalMax := -1;
    for fi := 0 to ParamCount - 1 do
        if results[fi].line.len > globalMax then
            globalMax := results[fi].line.len;

    for fi := 0 to ParamCount - 1 do begin
        if results[fi].line.len = globalMax then
            write('*');
        write(results[fi].name, ':');
        BufWrite(results[fi].line);
        writeln;
    end;
end.
