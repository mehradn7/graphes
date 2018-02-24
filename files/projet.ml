(*Section 1*)
#use "src/skeleton.ml";;

let associate v1 v2 = 
   begin
      Mark.set v1 (Vertex.indice(V.label v2));
      Mark.set v2 (Vertex.indice(V.label v1))
   end;;


let separate v1 v2 = 
   begin
      Mark.set v1 0;
      Mark.set v2 0
   end;;

let contract g o a = 
	begin
		remove_edge g o a;
		let voisins = succ g a in
			List.iter (fun s -> begin remove_edge g a s;
								add_edge g o s end;) voisins;
			remove_vertex g a;
	voisins;
	end;;
			

let insert g o a la = 
   begin
      add_vertex g a;
      List.iter (fun n -> begin remove_edge g o n; add_edge g a n end) la;
      add_edge g o a
   end;;


(*Section 2*)

let unmarked l = List.fold_right (fun s non_marques -> begin 
														if Mark.get s == 0 then 
															non_marques@[s]
														else
															non_marques
													   end) l [];;


let rec equals_aux g1 v1 g2 v2 = 
	let s1 = unmarked (ordered_succ g1 v1) and s2 = unmarked (ordered_succ g2 v2) in
		if s1 == [] && s2 == [] then
			(true,[])
		else
			if s1 == [] || s2 == [] then
				(false,[])
			else
				let h1 = List.hd s1 and h2 = List.hd s2 in
					begin
						associate h1 h2;
						let (bh,lh) = equals_aux g1 h1 g2 h2 and
						(bq,lq) = equals_aux g1 v1 g2 v2 in
							separate h1 h2;
							let lf = lh@lq in
								(bh && bq,[h1]@[h2]@lf);
					end;;

let equals g1 v1 g2 v2 = 
	begin
		associate v1 v2;
		let (b,lr) = equals_aux g1 v1 g2 v2 in
			let l = [v1]@[v2]@lr in
				separate v1 v2;
				(b,l);
	end;;
		


(*Section 3*)

let distance_aux g1 v1 g2 v2 = (0,[],[],[]);;

let distance g1 v1 g2 v2 = (0,[],[],[]);;


(*Section 4*)

let distance_opti g1 v1 g2 v2 = (0,[],[],[]);;
