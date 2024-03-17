declare
fun {Member Xs Ys Z}
   case Xs of
      nil then false
   [] Hx|Tx then
      case Ys of
	 nil then false
      [] Hy|Ty then
	 if {And Z == Hx Z == Hy} then true
	 else
	    {Member Xs Ty Z}
	 end
      end
      %{Member Tx Ys Z}
   end
end

declare
fun {MemberBothLists Xs Ys Z}
   case Xs of
      nil then false
      [] Hx|Tx then
	 case Ys of
	    nil then false
	 [] Hy|Ty then
	    if Z == Hx then true
	    else
	        {MemberBothLists Tx Ys Z}
	    end
	 end
   end	 
end


   