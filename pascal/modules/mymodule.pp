unit mymodule;
interface

type
    gString = string;

function GoodBye(s: gString): gString;

implementation
{ add other modelus here with uses }
const
    byeStr = 'Goodbye, ';

function GoodBye(s: gString): gString;
begin
    GoodBye := byeStr + s;
end;

end.