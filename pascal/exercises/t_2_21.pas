program t_2_21;
var
    c: char;
    firstC, secondC: char;
    chCount: int64;
begin
    chCount := 0;
    while not eof do begin
        read(c);
        if (c = ' ') or (c = #9) or (c = #10) or (c = #13) then begin
            if chCount = 2 then
                write(firstC, secondC, c)
            else if c = #10 then
                writeln;
            chCount := 0;
        end
        else begin
            chCount := chCount + 1;
            if chCount = 1 then
                firstC := c
            else if chCount = 2 then
                secondC := c;
        end;
    end;
    if chCount = 2 then
        writeln(firstC, secondC);
end.