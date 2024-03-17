% Environment Mapping

% <Env> = <List>(<Id>#<Expr>)
%IsMember :: {<Env><Id>} -> {Boolean}

declare
fun {IsMember Env Id}
   % env is a list consisting of (id expr) pairs - if the first element is equal to our parameter Id => return true
   % if env is nil -> list has ended and no occurrence of Id has been found => return false
   case Env
   of nil then false
   [] H|T then
      if H.1 == Id then true
      else {IsMember T Id} % keep looking for Id in the environment
      end
   end
end

{Browse {IsMember [a#1 b#2 c#3] c}}
{Browse {IsMember [a#1 b#2 c#3] d}}

% Fetch :: { <Env><Id> } -> <Expr>
% <Expr> = <Id> | lam(<Id> <Expr>) | apply(<Expr> <Expr>) | let(<Id>#<Expr> <Expr>)

% fetch returns the expression of the present identifier in the environment

declare
fun {Fetch Env Id}
   case Env of nil then Id
   [] H|T then
      if H.1 == Id then H.2
      else {Fetch T Id}
      end
   end
end

declare E3 = [1 2 3]
declare E1 = 'ABC'
{Browse {Fetch [a#1 b#2 c#E3] c}}
{Browse {Fetch [a#1 b#2 c#E3] d}}

% Adjoin :: {<Env> <Id#Expr>} -> {Expr}
% add a new pair to the env
% prev mapping of identifier is overriden, if exists

declare
fun {Adjoin Env Pair}
   % use the List.filter function - function checks if any of the env mappings Id corresponds to the pair Id
   Pair | {List.filter Env
	   % Element is of type Id#Expr
	   fun{$ Element} {Not Element.1 == Pair.1}
	   end
	  }
end

declare E3 = [1 2 3]
declare E1 = 'ABC'
declare E4 = [0 1]
{Browse {Adjoin [a#1 b#2 c#E3] c#E4}}
{Browse {Adjoin [a#1 b#2 c#E3] d#E4}}
{Browse {Fetch{Adjoin [a#1 b#2 c#E3] c#E4} c}}
{Browse {Fetch{Adjoin [a#1 b#2 c#E3] d#E4} d}}