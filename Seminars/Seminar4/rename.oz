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


% Renaming
% Bound identifiers can be renamed without changing the meaning of a lambda

declare
Cnt={NewCell 0}

fun {NewId}
   Cnt:=@Cnt+1
   {String.toAtom {Append "id<" {Append {Int.toString @Cnt}">"}}}
end

% replace the variable Id with the value of IdNew
declare
fun {ReplaceName Expression Id IdNew}
   case Expression of nil
   then nil
   [] apply(Expr1 Expr2) then
      apply({ReplaceName Expr1 Id IdNew} {ReplaceName Expr2 Id IdNew})
   [] lam(Id1 Expr) then
      lam({ReplaceName Id1 Id IdNew} {ReplaceName Expr Id IdNew})
   [] let(Id1#Expr1 Expr2) then
      let({ReplaceName Id1 Id IdNew}#{ReplaceName Expr1 Id IdNew} {ReplaceName Expr2 Id IdNew})
   [] Id1 then
      if Id1 == Id then IdNew
      else Id1
      end
   end
end


declare
fun {RenameAux Expression FreeVars}
   case Expression of nil then nil
   [] apply(Expr1 Expr2) then
      apply({RenameAux Expr1 FreeVars} {RenameAux Expr2 FreeVars})
   [] lam(Id Expr) then
      local NewIdT in NewIdT={NewId}
	 lam({ReplaceName Id Id NewIdT} {RenameAux {ReplaceName Expr Id NewIdT} FreeVars})
      end
   [] let(Id#Expr1 Expr2) then
      local NewIdL in NewIdL={NewId}
	 let({ReplaceName Id Id NewIdL}#{RenameAux Expr1 FreeVars} {RenameAux {ReplaceName Expr2 Id NewIdL} FreeVars})
      end
   [] Id then
      if {List.sub "id<" {Atom.toString Id}} then Id
      elseif {List.member Id FreeVars} then Id
      else
	 {ReplaceName Id Id {NewId}}
      end
   end
end


declare
fun {Rename Expression}
   {RenameAux Expression {FreeSet Expression}
   }
end

{Browse {Rename lam(z lam(x z))}}
{Browse {Rename let(id#lam(z z) apply(id y))}}

% Subs

declare
fun {Subs ToReplace Expression}
   case ToReplace of
      nil then nil
   [] Id#Expr then
      {ReplaceName {Rename Expression} Id Expr}
   end
end

{Browse {Subs x#lam(z z) apply(x lam(x apply(x z)))}}
{Browse {Subs x#lam(y z) apply(x lam(z apply(x z)))}}
