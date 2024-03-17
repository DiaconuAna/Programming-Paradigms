
declare
fun {Member Xs Ys E}
   case Xs#Ys
   of nil#Ys then false
   [] Xs#nil then false
   [] (X|Xr)#(Y|Yr) then
      if X == E then
	 if Y == E
	 then true
	 else {Member Xs Yr E}
	 end
      else
	 {Member Xr Ys E}
      end
      
   end
end

{Browse {Member [a b c] [a a a b] b}}
{Browse {Member [a b c] [a b c d] b}}
{Browse {Member [a b c] [a c d] b}}
{Browse {Member [a d c] [a c b d] c}}

declare
fun {SMerge Xs Ys}
   case Xs#Ys
   of nil#Ys then Ys
   [] Xs#nil then Xs
   [] (X|Xr)#(Y|Yr) then
      if X=<Y then X|{SMerge Xr Ys}
      else Y|{SMerge Xs Yr} end
   end
end
