% Seminar 2 - ex2 Reverse

declare
fun {Append L1 L2}
   case L1 of
      nil then L2
   [] H|T then H|{Append T L2}
   end
end

fun {Reverse L1}
   case L1
   of nil then nil
   [] H|T then {Append {Reverse T} [H]}
   end
end

{Browse {Reverse ['I' 'want' 2 go 'there']}}

% version 2

declare
fun {ReverseAux L1 L2}
   case L1
   of nil then L2
   [] H|T then {Reverse2 T H|L2}
   end
end

declare
fun {Reverse2 L1}
   {ReverseAux L1 nil}
end


{Browse {Reverse [1 2 3 4 5]}}
{Browse {Reverse2 [1 2 3 4 5]}}