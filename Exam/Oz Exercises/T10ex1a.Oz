% Tutorial 10 - Exercise 1 - WaitOr

declare
proc {WaitOr X Y}
   B in
   thread {Wait X} B = true {Browse "X"} end
   thread {Wait Y} B = true {Browse "Y"} end
{Wait B}
end

{WaitOr 1 _}
{WaitOr _ 1}
{WaitOr _ _}

{Browse "X"}

{Browse {Record.waitOr a(2 b:_)}}
%{Browse {Record.waitOr a(_ b:_)}}

% wait for each element and when one is bounded, exit the wait
declare
proc {WaitSome Xs}
   B
in
   {ForAll Xs proc {$ X} thread {Wait X} B = true {Browse X} end end}
   {Wait B}
end

{WaitSome [_ 2 _]}
