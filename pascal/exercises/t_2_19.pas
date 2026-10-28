program t_2_19;
var
    c, prev, firstCh, lastCh: char;
    wlen: int64;
    total, evenCnt, oddCnt, longCnt, shortCnt, azCnt: int64;
    maxWord, minWord, maxSpace, curSpace: int64;
    depth, pairs: int64;
    unEven, lineHasData: boolean;

procedure ResetLine;
begin
    wlen := 0;
    total := 0;
    evenCnt := 0;
    oddCnt := 0;
    longCnt := 0; 
    shortCnt := 0;
    azCnt := 0;
    maxWord := 0;
    minWord := 0;
    maxSpace := 0;
    curSpace := 0;
    depth := 0;
    pairs := 0;
    unEven := false;
    prev := #0;
    lineHasData := false;
end;

procedure EndWord;
begin
    if wlen = 0 then Exit;
    total := total + 1;
    if wlen mod 2 = 0 then Inc(evenCnt) else Inc(oddCnt);
    if wlen > 7 then Inc(longCnt);
    if wlen <= 2 then Inc(shortCnt);
    if (firstCh = 'A') and (lastCh = 'z') then Inc(azCnt);
    if wlen > maxWord then maxWord := wlen;
    if (total = 1) or (wlen < minWord) then minWord := wlen;
    wlen := 0;
end;

procedure EndLine;
begin
    EndWord;
    if curSpace > maxSpace then maxSpace := curSpace;
    writeln('total: ', total);
    writeln('even words: ', evenCnt, ' ', 'odd words: ', oddCnt);
    writeln('more than 7 chars: ', longCnt, ' ', 'two or less: ', shortCnt);
    writeln('A-Z: ', azCnt);
    writeln('total words: ', total, ' ', 'longest word: ', maxWord, ' ', 'shortest word: ', minWord);
    writeln('longest word: ', maxWord, ' ', 'longest space: ', maxSpace);
    if (not unEven) and (depth = 0) then
        writeln('YES')
        else writeln('NO');
    writeln('pairs of brackets: ', pairs);
    ResetLine;
end;

begin
    ResetLine;
    while not eof do
    begin
        read(c);
        if c = #10 then
            EndLine
        else if c <> #13 then
        begin
            lineHasData := true;
            if (c = ' ') or (c = #9) then
            begin
                EndWord;
                Inc(curSpace);
            end
            else
            begin
                if curSpace > maxSpace then maxSpace := curSpace;
                curSpace := 0;
                if wlen = 0 then
                    firstCh := c;
                lastCh := c;
                wlen := wlen + 1;
                if c = '(' then
                    depth := depth + 1
                else if c = ')' then
                begin
                    depth := depth - 1;
                    if depth < 0 then
                        unEven := true;
                    if prev = '(' then
                        pairs := pairs + 1;
                end;
            end;
            prev := c;
        end;
    end;
    if lineHasData then EndLine;
end.