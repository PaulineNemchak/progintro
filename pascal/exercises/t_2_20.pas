program t_2_20;
var
    c: char;
    inWord: boolean;
begin
    inWord := false;
    while not eof do begin
        read(c);
        if (c = ' ') or (c = #9) or (c = #10) then begin
            if inWord then begin
                write(')');
                inWord := false;
            end;
            write(c);
        end
        else begin
            if not inWord then begin
                write('(');
                inWord := true;
            end;
            write(c);
        end;
    end;
    if inWord then
        write(')');   
end.