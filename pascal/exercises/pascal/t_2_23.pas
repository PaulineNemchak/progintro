program t_2_23;

var
    count: integer;
    hasWord: boolean;
    s: string;
    c: char;
    i: integer;
begin
    if ParamCount <> 1 then begin
        writeln(stderr, 'There should be only one argument, but found ', ParamCount);
        halt(1);
    end;

    count := 0;
    hasWord := false;

    s := ParamStr(1);

    for i := 1 to length(s) do begin
        c := s[i];

        if (c <= ' ') then begin
            if hasWord then
                count := count + 1;
            hasWord := false;
        end
        else
            hasWord := true;            
    end;

    if hasWord then
        count := count + 1;
    
    writeln('Number of words received: ', count);
end.