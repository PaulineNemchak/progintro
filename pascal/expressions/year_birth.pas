program YearBirth;

var
    year: integer;

begin
    write('Your year of birth: ');
    readln(year);

    while (year < 1900) or (year > 2026) do begin
        writeln(year, ' is not a valid year.');
        write('Please, try again: ');
        readln(year);
    end;

    writeln('The year ', year, ' is accepted. Thank you.');
end.