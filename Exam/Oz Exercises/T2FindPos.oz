
declare
fun {FindPos Xs Y}
   case Xs of
      nil then 0
   [] H|T then
      if H == Y then 1
      else 1 + {FindPos T Y}
      end
   end
end

{Browse {FindPos [a b c] c}}

