program t_2_22;

function isDigit(c: char): boolean;
begin
    isDigit := c in ['0'..'9'];
end;

function isLetter(c: char): boolean;
begin
    isLetter := ((c >= 'a') and (c <= 'z')) or ((c >= 'A') and (c <= 'Z'));
end;

function toLowerChar(s: string): string;
var
    l: integer;
    c: char;
    res: string;
begin
    res := '';
    for l := 1 to length(s) do begin
        c := s[l];
        if (c >= 'A') and (c <= 'Z') then
            res := res + chr(ord(c) + 32)
        else
            res := res + c;
    end;
    toLowerChar := res;
end;

function hasRepeatingChars(s: string): boolean;
var
    j, k: integer;
    lowS: string;
begin
    lowS := toLowerChar(s);
    for j := 1 to length(lowS) - 1 do
        if isLetter(lowS[j]) then
            for k := j + 1 to length(lowS) do
                if lowS[k] = lowS[j] then begin
                    hasRepeatingChars := true;
                    exit;
                end;
    hasRepeatingChars := false;
end;

function hasEmail(s: string): boolean;
var
    hasAt: boolean;
    hasDot: boolean;
    m: integer;
    c: char;
begin
    hasAt := false;
    hasDot := false;

    for m := 1 to length(s) do begin
        c := s[m];
        if c = '@' then begin
            if hasAt then begin
                hasEmail := false;
                exit;
            end
            else
                hasAt := true;
        end            
        else if c = '.' then
            hasDot := true;
    end;
    
    if hasAt and hasDot then
        hasEmail := true
    else
        hasEmail := false;
end;

function isAllDigits(s: string): boolean;
var
    c: char;
    n: integer;
begin
    if length(s) < 1 then begin
        isAllDigits := false;
        exit;
    end;
    for n := 1 to length(s) do begin
        c := s[n];
        if not isDigit(c) then begin
            isAllDigits := false;
            exit;
        end;
    end;
    isAllDigits := true;
end;

function isSameChar(s: string): boolean;
var
    c: char;
    prevC: char;
    i: integer;
begin
    if length(s) < 1 then begin
        isSameChar := false;
        exit;
    end;
    if length(s) = 1 then begin
        isSameChar := true;
        exit;
    end;
    prevC := s[1];
    
    for i := 2 to length(s) do begin
        c := s[i];
        if prevC <> c then begin
            isSameChar := false;
            exit;
        end;
    end;
    isSameChar := true;        
end;

function hasAtLOneLetter(s: string): boolean;
var
    c: char;
    i: integer;
begin
    for i := 1 to length(s) do begin
        c := s[i];
        if isLetter(c) then begin
            hasAtLOneLetter := true;
            exit;
        end;
    end;
    hasAtLOneLetter := false;
end;

function sameSym(p1, p2: string): boolean;
var
    i: integer;
    j: integer;
begin
    for i := 1 to length(p1) do begin
        for j := 1 to length(p2) do begin
            if p1[i] = p2[j] then begin
                sameSym := true;
                exit;
            end;
        end;
    end;
    sameSym := false;
end;

type
    TArgs = array of string;
function isDuplicate(const args: TArgs; startIdx, idx: integer): boolean;
var
    i: integer;
begin
    for i := startIdx to idx - 1 do
        if args[i] = args[idx] then begin
            isDuplicate := true;
            exit;
        end;
    isDuplicate := false;
end;

var
    args: TArgs;
    i: integer;
    s: string;
    longest: string;
begin
    if ParamCount < 1 then
        Halt;
    SetLength(args, ParamCount + 1);
    for i := 1 to ParamCount do
        args[i] := ParamStr(i);

    longest := '';
    for i := 1 to ParamCount do begin
        s := ParamStr(i);
        if length(s) > length(longest) then
            longest := s;
        if not isDuplicate(args, 1, i) then begin
            if not hasRepeatingChars(s) then
                writeln(s, ' doesn''t have repeating letters');
            if hasEmail(s) then
                writeln(s, ' has @ and at least one dot');
            if isAllDigits(s) then
                writeln(s, ' has only digits');
            if isSameChar(s) then
                writeln(s, ' repeats the same symbol');
            if hasAtLOneLetter(s) then
                writeln(s, ' has at least one latin letter');
        end;

        if (i >= 2) and not isDuplicate(args, 2, i) then
            if sameSym(ParamStr(1), s) then
                writeln(s, ' has at least one common symbol with the first parameter');
    end;
    writeln('Longest argument: ', longest, ', length: ', length(longest));
end.