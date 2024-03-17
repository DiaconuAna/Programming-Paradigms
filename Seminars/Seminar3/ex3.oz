declare
Tuple1 = [1 2]

{Browse Tuple1.1}
{Browse Tuple1.2}

declare
List1 = [1 2 3]

% List.nth List Index - Index'th element of the List
{Browse {List.nth List1  1}}
{Browse {List.mapInd [d a e] fun {$ I List1} I#List1 end}}

% Zip[1 2 3]#[a b c]
% Tuple1 - first list of the tuple aka [1 2 3]
% Tuple2 - second list of the tuple aka [a b c]

% Use function mapInd which applies the ternary procedure with the index to the first actual argument
declare
fun {Zip Tuple}
   {List.mapInd Tuple.1
    fun {$ Index Element}
       Element#{List.nth Tuple.2 Index} end}
end

declare
Tuple = [1 2 3]#[a b c]
{Browse Tuple.1} % [1 2 3]
{Browse Tuple.2} % [a b c]

% UnZip [a#1 b#2 c#3] => [a b c]#[1 2 3]
% apply List.append to construct the 2 lists
% the first list will contain the first element of the first element of the tuple
% the 2nd - 2nd element of the 2nd part of the tuple
% once the Tuple is empty - the two lists will be separated by #

declare
fun {UnzipAux Tuple List1 List2}
   case Tuple of
      nil then List1#List2
   [] H|T then {UnzipAux T {List.append List1 [H.1]} {List.append List2 [H.2]}}
   end
end

fun {Unzip Tuple}
   {UnzipAux Tuple nil nil}
end

{Browse {Unzip [1#a 2#b 3#c]}}
