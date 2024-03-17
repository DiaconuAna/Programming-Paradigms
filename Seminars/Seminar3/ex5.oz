declare
fun {Eval ArithExpr}
   case ArithExpr
   of int(N) then N
   [] add(X Y) then {Eval X} + {Eval Y}
   [] mul(X Y) then {Eval X} * {Eval Y}
   end
end


Tuple = add(int(1) mul(int(3) int(4)))

{Browse {Eval Tuple}}