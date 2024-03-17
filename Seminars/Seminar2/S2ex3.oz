% Ex3 - infinite structures

declare
fun lazy {Sieve L}
   case L of
      nil then nil
   [] H|T then H|{Sieve {Filter T H}}
   end
end

fun lazy {Filter L H}
   case L of
      nil then nil
   [] A|As then
      if (A mod H) == 0 then {Filter As H}
      else A|{Filter As H} end
   end
end

fun lazy {Prime}
   {Sieve {Gen 2}}
end

declare
fun lazy {Gen N}
   N | {Gen N+1}
end

{Browse {Prime}} % shows _ at first because Browser does not cause lazy funcs to be evaluated
{Browse {Prime.1}}

declare List =  {Gen 3}
{Browse List.1} % first element
{Browse List.2} % tail of the list

% function to return the first prime number after a given value

declare
fun {GetAfterAux N L}
   case L of
      H|T then
      if H > N then H else {GetAfterAux N T}
      end
   end
end

declare
fun {GetAfter N}
   {GetAfterAux N {Prime}} % list returned by Prime is lazy so it won't be evaluated until actually required
end

declare Result = {GetAfter 13}
{Browse Result}   
   