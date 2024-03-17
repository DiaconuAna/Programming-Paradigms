% Using predefined functions take and drop

declare
fun {Take Xs N}
   {List.take Xs N}
end

List1 = [1 2 3 5]
{Browse {Take List1 3}}
{Browse {Take List1 5}}

declare
fun {Drop Xs N}
   {List.drop Xs N}
end

List2 = [1 2 3 4 5 6]
{Browse {Drop List2 4}}
{Browse {Drop List2 10}}


% without predefined functions

declare
fun {Take2 Xs N}
   if N == 0 then nil
   else case Xs of
	   nil then nil
	[] H|T then H|{Take T {fun{$} N-1 end}}
	end
   end
end

List1 = [1 2 3 5]
{Browse {Take List1 3}}
{Browse {Take List1 5}}

declare
fun {Drop2 Xs N}
   if N > 0 then
      case Xs of
	 nil then nil
      [] H|T then {Drop T {fun{$} N-1 end}}
      end
   else
      case Xs of
	 nil then nil
      [] H|T then H|{Drop T N}
      end
   end
end


List2 = [1 2 3 4 5 6]
{Browse {Drop List2 4}}
{Browse {Drop List2 10}}