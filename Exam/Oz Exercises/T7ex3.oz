% Producer Consumer Stream

% plain solution

declare
fun {Min A B}
   if A < B then A
   else B
   end
end

fun {Max A B}
   if A>B then A
   else B
   end
end


declare
fun {Produce N Limit}
   if Limit >= 0 then
      N*N|{Produce N+1 Limit-1}
   else nil end
end

fun {Consume Xs Minim#Maxim}
   case Xs of X|Xr then
      {Consume Xr {Min Minim X}#{Max Maxim X}}
   [] nil then Minim#Maxim
   end
end

declare N = 4
local X Result in
   thread X = {Produce N 10} end
   thread Result = {Consume X N#0} end
   
   {Browse Result}
end


% Consumer driven concurrent communication

declare
fun {DrivenConsumer ?Xs Minim#Maxim Limit}
   if Limit >= 0 then
      local X Xr in
	 Xs = X|Xr {DrivenConsumer Xr {Min Minim X}#{Max Maxim X} Limit-1}
      end
   else Xs=nil Minim#Maxim
   end
end

proc {DrivenProducer N Xs}
   case Xs of X|Xr then
      X = N*N
      {DrivenProducer N+1 Xr}
   else Xs=nil
   end
end

local Xs S in
   thread {DrivenProducer 4 Xs} end
   thread S = {DrivenConsumer Xs 10000#0 10} end
   {Browse S}
end

% bounded buffer of size 3

declare
proc {DrivenProd N Xs}
   case Xs of X|Xr then
      X = N*N
      {DrivenProd N+1 Xr}
   end
end

fun {DrivenCons ?Xs Minim#Maxim Limit}
   if Limit > 0 then
      X|Xr = Xs in {DrivenCons Xr {Min Minim X}#{Max Maxim X} Limit-1}
   else
      Minim#Maxim end
end

proc {Buffer N ?Xs Ys}
   fun {Startup N ?Xs}
      if N == 0 then Xs
      else
	 Xr in Xs=_|Xr{Startup N-1 Xr}
      end
   end

   proc {AskLoop Ys ?Xs ?End}
      case Ys of Y|Yr then Xr End2 in
	 Xs = Y | Xr % get element from the buffer
	 End = _|End2 % replenish the buffer
	 {AskLoop Yr Xr End2}
      [] nil then End = nil
      end
   end

   End = {Startup N Xs} in
   {AskLoop Ys Xs End}
   
end

local Xs Ys S in
thread {DrivenProd 4 Xs} end
thread {Buffer 3 Xs Ys} end
thread S={DrivenCons Ys 9000#0 11} end
{Browse Xs} {Browse Ys} {Browse S}
end