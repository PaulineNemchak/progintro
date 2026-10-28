program t_2_16;

function CountChar(s: string; c: char): integer;
var
    count, j: integer;
begin
    count := 0;
    for j := 1 to length(s) do begin
        if s[j] = c then
            count := count + 1;
    end;
    CountChar := count;
end;

var
    s: string;
    i, j: integer;
    c: char;
    alreadyPrinted: boolean;
begin
    write('type a string: ');
    readln(s);
    
    for i := 1 to length(s) do begin
        c := s[i];

        if c = ' ' then
            continue;
        
        alreadyPrinted := false;

        for j := 1 to i - 1 do begin
            if(s[j] = c) and (s[j] <> ' ') then begin
                alreadyPrinted := true;
                break;
            end;
        end;

        if alreadyPrinted then
            continue;

        if CountChar(s, c) > 1 then
            write(c);
    end;

    writeln;
end.