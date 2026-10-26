program t_2_33;
uses crt;
{
    2.33 - 2.35
}
const
    DelayDuration = 100;
    ChangeProbability = 0.1;

type
    TDirection = (dLeft, dRight, dTop, dBottom);
    TPoint = record
        x, y: integer;
    end;

const
    DirectionDelta: array[TDirection] of TPoint = (
        (x: -1; y: 0),
        (x: 1; y: 0),
        (x: 0; y: -1),
        (x: 0; y: 1)
    );

const
    KeyLeft = -75;
    KeyRight = -77;
    KeyUp = -72;
    KeyDown = -80;
    KeyEscape = 27;

procedure GetKey(var code: integer);
var
    c: char;
begin
    c := ReadKey;
    if c = #0 then begin
        c := ReadKey;
        code := - ord(c);
    end
    else begin
        code := ord(c);
    end;
end;

procedure ShowStar(var p: TPoint);
begin
    GotoXY(p.x, p.y);
    write('*');
end;

procedure HideStar(var p: TPoint);
begin
    GotoXY(p.x, p.y);
    write(' ');
end;

procedure Move(var p: TPoint; d: TDirection);
begin
    p.x := p.x + DirectionDelta[d].x;
    p.y := p.y + DirectionDelta[d].y;

    if p.x < 1 then p.x := ScreenWidth;
    if p.x > ScreenWidth then p.x := 1;
    if p.y < 1 then p.y := ScreenHeight;
    if p.y > ScreenHeight then p.y := 1;
end;

function RandomPerpendicularDirection(d: TDirection): TDirection;
var
    n: integer;
begin
    if d in [dLeft, dRight] then
        n := Ord(dTop) + random(2)
    else
        n := Ord(dLeft) + random(2);
    RandomPerpendicularDirection := TDirection(n);
end;

var
    p: TPoint;
    d: TDirection;
    c: integer;
begin
    Randomize;
    clrscr;
    p.x := ScreenWidth div 2;
    p.y := ScreenHeight div 2;
    d := TDirection(random(Ord(High(TDirection)) + 1));

    repeat
        ShowStar(p);
        delay(DelayDuration);
        HideStar(p);

        if KeyPressed then begin
            GetKey(c);
            case c of
                KeyLeft: d := dLeft;
                KeyRight: d := dRight;
                KeyUp: d := dTop;
                KeyDown: d := dBottom;
                ord(' '): break;
                KeyEscape: break;
            end;
        end
        else if random < ChangeProbability then
            d := RandomPerpendicularDirection(d);

        Move(p, d);
    until false;

    clrscr;
end.
