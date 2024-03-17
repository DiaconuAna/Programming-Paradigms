declare X0 X1 X2 X3
thread X1 = 1 + X0 end
thread X3 = X1 + X2 end

X0 = 4
{Browse [X0 X1 X2 X3]}
X2 = 2


declare X
{Browse X}

local Y in
   thread {Delay 1000} Y = 10*10 end
   X = Y + 100*100
end

declare
fun {CMap Xs F}
   case Xs
   of nil then nil
   [] X|Xr then
      thread {F X} end | {CMap Xr F}
   end
end

declare F
{Browse {CMap [1 2 3 4] F}}
F = fun {$ X} X + 1 end

declare
fun {Fib X}
   if X==0 then 0
   elseif X==1 then 1
   else
      thread {Fib X-1} end + {Fib X-2}
      end
end

{Browse {Fib 5 }}

% Producer/Consumer

declare
fun {Produce N Limit}
   if N<Limit then
      N|{Produce N+1 Limit}
   else nil end
end

fun {Consume Xs Acc}
   case Xs of X|Xr then
      {Consume Xr Acc+X}
   [] nil then Acc
   end
end

declare
thread Stream = {Produce 0 1000} end
declare
thread FilterResult = {Filter Stream IsOdd} end
declare
thread Result = {Consume FilterResult 0} end

{Browse Stream}

% ByNeed
declare X5 = {ByNeed fun {$} 4 end}

{Browse X5} % displays nothing -> X5 is not triggered yet and Browse does not need value of X5

declare Z = X5 + 1 % X5 is needed here - ByNeed thread creates and binds X5 to 4 and thread T resumes and binds Z to 5

declare
fun {F1 X} {ByNeed fun {$} 2*X end} end
fun {F2 Y} {ByNeed fun {$} Y*Y end} end
B = {F1 3}
{Browse B}
C = {F2 4}
{Browse C}
A = B + C

declare thread X6 = {ByNeed fun {$} 3 end} end
declare thread X7 = {ByNeed fun {$} 4 end} end
declare thread Z = X + Y end
{Browse Z}
