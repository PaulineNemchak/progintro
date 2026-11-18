program MyProgram;
uses mymodule;

{$I greeting.pas}

begin
   Greeting('Mia');
   writeln(GoodBye('Isabella'));
end.