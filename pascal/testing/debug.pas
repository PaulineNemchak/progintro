{$ DEFINE DEBUG}
{ remove space }
{ or use fpc -dDEBUG myprog.pas}

program hello;
begin
    {$IFDEF DEBUG}
        writeln('DEBUG: string');
    {$ENDIF}
    writeln('Hello, world');
end.