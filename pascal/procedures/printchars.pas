procedure PrintChars(ch: char; count: integer);
var
    i: integer;
begin
    for i := 1 to count do
        write(ch)
end;

{
recursive:

procedure PrintChars(ch: char; count: integer);
begin
    if count > 0 then begin
        write(ch);
        PrintChars(ch, count - 1);
    end;
end;
}

begin
    PrintChars('c', 5);
end.