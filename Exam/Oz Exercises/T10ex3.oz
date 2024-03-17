declare
X = {MakeTuple a 3}
{Browse X.1}
{Browse X.2}
X.1=5
X.2=9

declare
X = proc {$ Y}
       {Browse 2*Y}
    end

{Browse {IsProcedure X}}

% N as input - <1!, 2!, ..., N!>

% [5 5 5 5]
declare X1 = {NewArray 1 4 5}
{Browse X1.4}

declare
fun {FactorialArray N}
   X = {NewArray 1 N 1}
in
   for I in 2..N do
      X.I := X.(I-1)*I
   end
   X
end

proc {ShowArray X N}
   for I in 1..N do
      {Browse X.I}
   end
end

{ShowArray {FactorialArray 5} 5}
