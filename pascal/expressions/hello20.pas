program hello20;

// while <условие> do <оператор>
// <> !=

var
    i: integer;

begin
    i := 0;
    while i < 20 do begin
        writeln('Hello, world');
        i := i + 1;
    end
end.