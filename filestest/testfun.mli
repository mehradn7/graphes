open Skeleton
module Testprojet :
sig
	val test_associate : (Skeleton.V.t -> Skeleton.V.t -> unit) -> Skeleton.V.t -> Skeleton.V.t -> bool
	val test_separate : (Skeleton.V.t -> Skeleton.V.t -> unit) -> Skeleton.V.t -> Skeleton.V.t -> bool
	
	val test_contract :
		(Skeleton.t -> Skeleton.V.t -> Skeleton.V.t -> Skeleton.V.t list) -> 
		Skeleton.t -> Skeleton.V.t -> Skeleton.V.t -> bool
	val test_insert :
		(Skeleton.t -> Skeleton.V.t -> Skeleton.V.t -> Skeleton.V.t list -> unit) ->
		Skeleton.t -> Skeleton.V.t -> Skeleton.V.t -> bool
	
	val test_equals_aux :
		(Skeleton.t -> Skeleton.V.t -> Skeleton.t -> Skeleton.V.t -> bool*((Skeleton.V.t*Skeleton.V.t) list)) ->
		Skeleton.t -> Skeleton.V.t -> Skeleton.t -> Skeleton.V.t -> bool
	val test_equals :
		(Skeleton.t -> Skeleton.V.t -> Skeleton.t -> Skeleton.V.t -> bool*((Skeleton.V.t*Skeleton.V.t) list)) ->
		Skeleton.t -> Skeleton.V.t -> Skeleton.t -> Skeleton.V.t -> bool
		
	val test_dist_and_opti :
		(Skeleton.t -> Skeleton.V.t -> Skeleton.t -> Skeleton.V.t -> int*((Skeleton.V.t*Skeleton.V.t) list)*((Skeleton.V.t*Skeleton.V.t) list)*((Skeleton.V.t*Skeleton.V.t) list)) ->
		(Skeleton.t -> Skeleton.V.t -> Skeleton.t -> Skeleton.V.t -> int*((Skeleton.V.t*Skeleton.V.t) list)*((Skeleton.V.t*Skeleton.V.t) list)*((Skeleton.V.t*Skeleton.V.t) list)) ->
		Skeleton.t -> Skeleton.V.t -> Skeleton.t -> Skeleton.V.t -> bool
end

