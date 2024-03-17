% Filter positive even elements from list of integers

declare
fun {FilterElems Cond Ls}
   case Ls of
      nil then nil
   [] H|T then
      if {Cond H} then H|{FilterElems Cond T}
      else {FilterElems Cond T} end
   end
end

{Browse {FilterElems (fun {$ N} if N mod 2 == 0 then N >= 0 else false end end) [1 ~2 3 4]}}


declare
fun {IsMember Xs Y}
   case Xs of
      nil then false
   [] H|T then
      if H == Y then true
      else {IsMember T Y}
      end
   end
end

{Browse {IsMember [a b c] b}}
{Browse {IsMember [a b c] d}}
