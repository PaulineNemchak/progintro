program t_2_33;
uses crt;

type
    TDirection = (dLeft, dRight, dTop, dBottom);
    TPoint = record
        x, y: integer;
    end;
    TLimit = record
        moves, changes: integer;
    end;

const
    DelayDuration = 100;
    ChangeProbability = 0.1;
    ChangeCooldown = 10;

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

const
    MaxMov = 1000;
    MaxChange = 50;
    AreaW = 3;
    AreaH = 3;
    WinPhrase = 'YOU WIN';
    LosePhrase = 'GAME OVER';

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

    if p.x < 1 then p.x := ScreenWidth - 1;
    if p.x > ScreenWidth - 1 then p.x := 1;
    if p.y < 2 then p.y := ScreenHeight;
    if p.y > ScreenHeight then p.y := 2;
end;

procedure SetPendingDirection(newDirection: TDirection; var pendingDirection: TDirection; var hasPending: boolean);
begin
    pendingDirection := newDirection;
    hasPending := true;
end;

procedure DrawCentre();
var
    coordX: integer;
    coordY: integer;
    i, j: integer;
begin
    coordX := ScreenWidth div 2 - 1;
    coordY := ScreenHeight div 2 - 1;
    for i := 0 to (AreaH - 1) do
        for j := 0 to (AreaW - 1) do begin
            GotoXY(coordX + j, coordY + i);
            write('@');
        end;
end;

procedure DrawEnd(isWon: boolean);
var
    coordX, coordY: integer;
    p: string;
    l: integer;
begin
    if isWon then
        p := WinPhrase
    else
        p := LosePhrase;
    l := length(p);
    coordY := ScreenHeight div 2;
    coordX := ScreenWidth div 2 - l div 2;

    clrscr;
    GotoXY(coordX, coordY);
    write(p);

    while not KeyPressed do ;
    ReadKey;

    clrscr;
    Halt;
end;

procedure DrawLimit(l: TLimit);
var
    m, c: integer;
    mStr, cStr, s: string;
    coordX, coordY: integer;
begin
    m := MaxMov - l.moves;
    c := MaxChange - l.changes;
    if m < 0 then m := 0;
    if c < 0 then c := 0;

    Str(m, mStr);
    Str(c, cStr);
    s := 'Moves remained: ' + mStr + '; Changes remained: ' + cStr;

    coordX := ScreenWidth - length(s);
    coordY := 1;

    GotoXY(1, coordY);
    ClrEol;
    GotoXY(coordX, coordY);
    write(s);
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
    pendingDirection: TDirection;
    hasPending: boolean;
    movesSinceChange: integer;
    c: integer;
    wLocation: TPoint;
    isPaused: boolean;
    limit: TLimit;
begin
    Randomize;
    clrscr;
    wLocation.x := ScreenWidth div 2 - AreaW div 2;
    wLocation.y := ScreenHeight div 2 - AreaH div 2;
    p.x := 1;
    p.y := 2;
    d := dRight;
    limit.moves := 0;
    limit.changes := 0;
    hasPending := false;
    isPaused := false;
    movesSinceChange := ChangeCooldown; {so the first keypress can apply right away}

    DrawCentre();
    DrawLimit(limit);

    repeat
        if (limit.moves >= MaxMov) or (limit.changes >= MaxChange) then
            DrawEnd(false);
        if (p.x >= wLocation.x) and (p.x < wLocation.x + AreaW) and (p.y >= wLocation.y) and (p.y < wLocation.y + AreaH) then
            DrawEnd(true);

        ShowStar(p);
        delay(DelayDuration);
        HideStar(p);
        limit.moves := limit.moves + 1;

        if KeyPressed then begin
            GetKey(c);
            case c of
                KeyLeft: SetPendingDirection(dLeft, pendingDirection, hasPending);
                KeyRight: SetPendingDirection(dRight, pendingDirection, hasPending);
                KeyUp: SetPendingDirection(dTop, pendingDirection, hasPending);
                KeyDown: SetPendingDirection(dBottom, pendingDirection, hasPending);
                ord(' '): isPaused := not isPaused;
                KeyEscape: break;
            end;
        end
        else if random < ChangeProbability then
            d := RandomPerpendicularDirection(d);

        if hasPending and (movesSinceChange >= ChangeCooldown) then begin
            limit.changes := limit.changes + 1;
            d := pendingDirection;
            hasPending := false;
            movesSinceChange := 0;
        end;

        DrawLimit(limit);

        if (not isPaused) then begin
            Move(p, d);
            movesSinceChange := movesSinceChange + 1;
        end;
    until false;

    clrscr;
end.
