% Seminar 4 - Free Variables

% expression = <Id> | lam(<Id> <Expr>) | apply(<Expr> <Expr>) | let(<Id>#<Expr> <Expr>)

declare
fun {FreeSetAux Expression FreeVars}
   case Expression of nil
   then FreeVars
   [] lam(Id Expr) then
      % filter expects a list and a test functions and returns only those elems for which the test function returns true - we want to filter the vars from the body that are not equal to element Id - because Id, being part of lam is bound and we want to find OTHER bound vars
      {List.filter {FreeSetAux Expr FreeVars}
       fun {$ Element} {Not Element == Id} end
      }
   % an expression in apply will always be unbound so no filter is needed, just gathering all vars in a single list   
   [] apply(Expression1 Expression2) then
      {List.flatten FreeVars | {FreeSetAux Expression1 nil} | {FreeSetAux Expression2 nil}}
% in let - Id is the bound var so we further filter the vars in the expression which are not Id
   [] let(Id#Expression1 Expression2) then
      {List.filter {List.flatten FreeVars |  {FreeSetAux Expression1 nil} | {FreeSetAux Expression2 nil}} fun {$ Element} {Not Element == Id} end}
   [] Id then
      Id| FreeVars
   end
end

declare
fun {FreeSet Expression}
   {FreeSetAux Expression nil}
end

      

{Browse {FreeSet apply(x let(x#y x))}}
{Browse {FreeSet apply(y apply(let(x#x x) y))}}




{Browse {List.flatten [1 2 3]| [4 3 5 6]}}