% 1. Assume Y is an element in X
% Mathematical Model

% GetPosition(List, Element, Position) =
% Position, if List is empty or List[1] = Element
% GetPosition(List, Element, Position + 1), otherwise

declare
fun {GetPositionAux List Element Position}
   case List of
      nil then Position
   [] H|T then
      if H == Element then Position
      else {GetPositionAux T Element {fun{$} Position + 1 end}}
      end
   end
end

fun {GetPositionV1 List Element}
   {GetPositionAux List Element 1}
end

{Browse {GetPositionV1 [1 2 3 4 5] 3}}

% 2. 0 is returned if element is not in list

declare
fun {GetPositionAuxV2 List Element Position}
   case List of
      nil then 0
   [] H|T then
      if H == Element then Position
      else {GetPositionAux T Element {fun{$} Position + 1 end}}
      end
   end
end

fun {GetPositionV2 List Element}
   {GetPositionAuxV2 List Element 1}
end

{Browse {GetPositionV2 [1 2 3 4 5] 3}}
{Browse {GetPositionV2 [a b c] 2}}