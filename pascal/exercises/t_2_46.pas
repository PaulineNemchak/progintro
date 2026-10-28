program t_2_46;
const
    Poem = 'Humpty Dumpty sat on a wall.' + #10 +
           'Humpty Dumpty had a great fall.' + #10 +
           'All the king''s horses and all the king''s men' + #10 +
           'Couldn''t put Humpty together again.';
var
    f: text;
begin
    {$I-}

    if ParamCount < 1 then begin
        writeln(ErrOutput, 'Please specify the file to write');
        halt(1);
    end;

    assign(f, ParamStr(1));
    rewrite(f);
    writeln(f, Poem);
    close(f);
end.