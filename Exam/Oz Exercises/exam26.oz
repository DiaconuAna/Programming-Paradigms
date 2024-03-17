declare
fun {Fact N}
   case N of 0 then 1
   [] N then N*{Fact (N-1)} end
end

declare
fun {Eval Expr}
   case Expr
   of intval(N) then N
   [] intfact(X) then {Fact {Eval X}}
   [] intminus(X Y) then {Eval X} - {Eval Y}
   end
end


declare
fun {Eval2 Expr}
   case Expr
   of boolval(N) then N
   [] booland(X Y) then {And {Eval2 X} {Eval2 Y}}
   [] boolor(X Y) then {Or {Eval2 X} {Eval2 Y}}
   end
end

{Browse {Eval2 booland(boolval(true) boolor(boolval(true) boolval(false)))}}
{Browse {Eval2 booland(boolval(true) boolor(boolval(false) boolval(false)))}}


declare
local
   fun {NoOcc Xs Y}
      case Xs of
	 nil then 0
      [] H|T then
	 if H == Y then 1 + {NoOcc T Y}
	 else {NoOcc T Y}
	 end
      end
   end
in
   fun {MemberTwice Xs Y}
      if {NoOcc Xs Y} >= 2 then true else false end
   end
end

{Browse {MemberTwice [a b c d b e] b}}
{Browse {MemberTwice [a a h a n m] a}}
{Browse {MemberTwice [a b c] b}}
{Browse {MemberTwice [a b c d] e}}

3declare
proc {WaitOr X Y}
   ShVar in
   thread {Wait X} ShVar = true {Browse "X"} end
   thread {Wait Y} ShVar = true {Browse "Y"} end
   {Wait ShVar}
   {Browse 1}
end

{WaitOr 1 _}
{WaitOr _ 1}
{WaitOr _ _}