declare
fun {IsInList L E}
   case L of nil then false
   [] H|T then
      if H == E then true
      else {IsInList T E}
      end
   end
end

declare
fun {MemberBothLists Xs Ys Z}
   local
      T1 = thread {IsInList Xs Z} end
      T2 = thread {IsInList Ys Z} end
   in
      if T1 then T2 else false end
   end
end

{Browse {MemberBothLists [a b c] [a b c d] b}}
{Browse {MemberBothLists [a b c] [a c d] b}}
{Browse {MemberBothLists [a d c] [a c b d] b}}