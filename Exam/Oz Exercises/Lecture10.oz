declare
fun {Produce N}
   {ByNeed fun {$} N|{Produce N+1} end}
end

declare Ns = {Produce 0}
{Browse Ns}
_=Ns.2.2.1


declare S P
P = {NewPort S}
{Browse S}

thread {Send P a} end
thread {Send P b} end

local A B C in
thread if A then B=true else B=false end end
thread if B then C=false else C=true end end
A=false
end

%Exercise2
local X Y Z in
thread if X==1 then Y=2 else Z=2 end end
thread if Y==1 then X=1 else Z=2 end end
X=1
{Browse X} {Browse Y} {Browse Z}
end

local X Y Z in
thread if X==1 then Y=2 else Z=2 end end
thread if Y==1 then X=1 else Z=2 end end
X=2
{Browse X} {Browse Y} {Browse Z}
end