declare
fun {ReverseList L R}
   case L of
      nil then R
   [] H|T then {ReverseList T H|R}
   end
end

{Browse {ReverseList [1 2 3] nil}}

% and make it local to use it directly in an aux function

declare
local
   fun {RevList L R}
      case L of
	 nil then R
      [] H|T then {RevList T H|R}
      end
   end
in
   fun {Rev Xs} {RevList Xs nil} end
end

{Browse {Rev [1 2 3]}}