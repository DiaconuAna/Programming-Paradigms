declare
proc {DataDriven PAcc PState Term CAcc CState CResult}
   
   local
      
      proc {Produce Acc Xs}
	 if {Term Acc} then
	    local Xr NAcc X in
	       X#NAcc = {PState Acc}
	       Xs=X|Xr
	       {Produce NAcc Xr} end
	 else Xs=nil {Browse "Term Producer"}
	 end
      end
      
      fun {Consume Xs Acc} NAcc in
	 case Xs of X|Xr then
	    NAcc = {CState X Acc}
%{Browse X}
	    {Consume Xr NAcc}
	 else {Browse "Term Consumer"} {CResult Acc}
	 end
      end
      
   in
      
      local Result Xs in
	 thread {Produce PAcc Xs} end
	 thread Result={Consume Xs CAcc} end
	 {Delay 1000} {Browse Result}
      end
      
   end
end

{DataDriven
 0 % PAcc - Producer Accumulator
 (fun {$ N} N*N#N+1 end) % PState - Producer State
 (fun {$ N} N=<100 end) % Term 
 0#0 % CAcc - Consumer Accumulator
 (fun {$ X Min#Max} {Value.min Min X}#{Value.max Max X} end) %CState - Consumer State
 (fun {$ Acc} Acc end) %CResult - Consumer Result
}