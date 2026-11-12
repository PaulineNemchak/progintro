program t_2_43;

type
    TWord = record
        start: PChar;
        len: integer;
    end;

var
    buf: array of char;
    words: array of TWord;
    len, count, maxLen, j, k: integer;
    p, pEnd: PChar;
    c: char;

function isSpace(ch: char): boolean;
begin
    isSpace := (ch = ' ') or (ch = #9) or (ch = #10) or (ch = #11) or (ch = #12) or (ch = #13);
end;

begin
    SetLength(buf, 16);
    SetLength(words, 4);

    while not eof do begin
        len := 0;

        while not eoln do begin
            read(c);
            if len = Length(buf) then
                SetLength(buf, 2 * Length(buf));
            buf[len] := c;
            len := len + 1;
        end;
        readln;

        count := 0;
        maxLen := 0;
        p := @buf[0];
        pEnd := p + len;

        while p < pEnd do begin
            while (p < pEnd) and isSpace(p^) do
                p := p + 1;
            if p >= pEnd then
                break;
            if count = Length(words) then
                SetLength(words, 2 * Length(words));

            words[count].start := p;
            while(p < pEnd) and not isSpace(p^) do
                p := p + 1;
            words[count].len := p - words[count].start;
            if words[count].len > maxLen then
                maxLen := words[count].len;
            count := count + 1;
        end;

        for j := 0 to maxLen - 1 do begin
            for k := 0 to count - 1 do
                if j < words[k].len then
                    write(words[k].start[j])
                else
                    write(' ');
            writeln;
        end;
    end;
end.