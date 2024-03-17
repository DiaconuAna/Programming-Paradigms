% Tutorial 3 Ex 2

% Maximum of a list using FoldL
declare
fun {Max2 X H}
   if X == neginf then H
   else if X > H then X else H end
   end
end

declare
fun {FoldL Op X L}
   case L of
      nil then X
   [] H|T then {FoldL Op {Op X H} T}
   end
end

fun {MaxL L}
   {FoldL Max2 neginf L}
end


{Browse {MaxL [2 4 ~6 100 40]}}
{Browse {MaxL [~6 ~10]}}
{Browse {MaxL nil}}

declare
fun {FoldR Op X L}
   case L of
      nil then X
   [] H|T then {Op H {FoldR Op X T}}
   end
end

fun {MaxR L}
   {FoldR fun {$ H X} {Max2 X H} end neginf L}
end

{Browse {MaxR [2 4 ~6 100 40]}}
{Browse {MaxR [~6 ~2]}}
{Browse {MaxR nil}}