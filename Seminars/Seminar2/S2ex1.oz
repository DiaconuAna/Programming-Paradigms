declare
fun {Fact N}
   if N == 0 then 1
   else N * {Fact N-1}
   end
end

fun {Comb N K}
   {Fact N} div ({Fact K} * {Fact N-K})
end

{Show {Comb 5 3}}

% A - part 1

declare
fun {PartialFact N M}
   if N == M then N
   else N * {PartialFact N-1 M}
   end
end

declare
fun {Comb2 N K}
   if K > N then ~1
   else
      if K == 0 then 1
   else {PartialFact N N-K+1} div {PartialFact K 1}
      end
   end
   
end

{Show {Comb2 5 3}}
{Show {Comb2 12 0}}
{Show {Comb2 100 12}}
{Show {Comb2 0 0}}
{Show {Comb2 0 13}}

% B

declare
fun {Fact3 N K Prod}
   if K == 1.0   then Prod * N
   else {Fact3 N K-1.0 Prod*(N-K+1.0)/ K}
   end
end

fun {Comb3 N K}
   if K == 0
   then 1
   else
      {Fact3 {IntToFloat N} {IntToFloat K} 1.0}
   end
end


{Show {Comb3 5 3}}
{Show {Comb3 12 0}}
{Show {Comb3 100 12}}
{Show {Comb3 0 0}}
{Show {Comb3 0 13}}
{Show {Comb3 999  24}}