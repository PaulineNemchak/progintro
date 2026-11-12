program t_2_26;
uses crt;

const
    DelayDuration = 100;

var
    x, y, dx: integer;
    counter: integer;
begin
    clrscr;
    counter := 0;
    x := 1;
    dx := 1;
    y := ScreenHeight div 2;

    while (counter < 3) and (not KeyPressed) do begin
        GotoXY(x, y);
        write('*');
        delay(DelayDuration);
        GotoXY(x, y);
        write(' ');

        if (x = ScreenWidth - 1) and (dx = 1) then
            dx := -1
        else if (x = 1) and (dx = -1) then begin
            dx := 1;
            counter := counter + 1;
        end;

        x := x + dx;
    end;
    clrscr;
end.