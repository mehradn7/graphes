(* Mehrad RAFII x Robin XAMBILI *)

(*Section 1*)

open Skeleton.Skeleton;;

(* Associer les sommets v1 et v2 *)
let associate v1 v2 = 
   begin
      Mark.set v1 (Vertex.indice(V.label v2));
      Mark.set v2 (Vertex.indice(V.label v1))
   end;;


(* Séparer les sommets v1 et v2 *)
let separate v1 v2 = 
   begin
      Mark.set v1 0;
      Mark.set v2 0
   end;;

(* Contracter l'arête (o,a) selon l'algorithme décrit dans le sujet *)
let contract g o a = 
	begin
		remove_edge g o a;
		let voisins = succ g a in
			List.iter (fun s -> begin remove_edge g a s;
								add_edge g o s end;) voisins;
			remove_vertex g a;
	voisins;
	end;;
			
(* Insérer l'arête (o,a) à partir de la liste de voisins la *)
let insert g o a la = 
   begin
      add_vertex g a;
      List.iter (fun n -> begin remove_edge g o n; add_edge g a n end) la;
      add_edge g o a
   end;;


(*Section 2*)

(* Calculer la liste des sommets non marqués à partir d'une liste de sommets l *)
let unmarked l = List.fold_right (fun s non_marques -> begin 
														if Mark.get s == 0 then 
															non_marques@[s]
														else
															non_marques
													   end) l [];;


(* Fonction récursive auxiliaire *)
let rec equals_aux g1 v1 g2 v2 = 
	(* Calculer la liste des sommets non marqués de chaque racine *)
	let s1 = unmarked (ordered_succ g1 v1) and s2 = unmarked (ordered_succ g2 v2) in
		(* Si l'une des deux listes est vide, alors on peut conclure *)
		if s1 == [] && s2 == [] then
			(true,[])
		else
			if s1 == [] || s2 == [] then
				(false,[])
			else
				let h1 = List.hd s1 and h2 = List.hd s2 in
					begin
						(* Associer les premiers voisins et faire l'appel récursif *)
						associate h1 h2;
						let (bh,lh) = equals_aux g1 h1 g2 h2 and
						(bq,lq) = equals_aux g1 v1 g2 v2 in
							(* Séparer les deux sommets pour restituer le graphe dans son état initial *)
							separate h1 h2;
							(* Calculer la solution retournée *)
							let lf = lh@lq in
								(bh && bq,(h1,h2)::lf);
					end;;

(* Vérifier si deux arbres sont égaux et renvoyer la liste des sommets appariés *)
let equals g1 v1 g2 v2 = 
	begin
		(* Nettoyer tous les sommets *)
		Mark.clear g1;
		Mark.clear g2;
		(* Associer les deux racines et appeler la fonction auxiliaire *)
		associate v1 v2;
		let (b,lr) = equals_aux g1 v1 g2 v2 in
			let l = (v1,v2)::lr in
				separate v1 v2;
				(b,l);
	end;;
		

		


(*Section 3*)

(* Fonctions auxiliaires mutuellement récursives *)
(* Contracter le deuxième graphe et faire l'appel récursif *)
let rec contract_g2 g1 v1 g2 v2 h = 
	let la_g2= contract g2 v2 h in
	let (ch, l0, l1, l2) = distance_aux g1 v1 g2 v2 in
	insert g2 v2 h la_g2;
	(ch+1, l0, l1, (v2, h)::l2)

(* Contracter le premier graphe et faire l'appel récursif *)
and contract_g1 g1 v1 g2 v2 h = 
	let la_g1= contract g1 v1 h in
	let (ch, l0, l1, l2) = distance_aux g1 v1 g2 v2 in
	insert g1 v1 h la_g1;
	(ch+1, l0, (v1, h)::l1, l2)
	
and distance_aux g1 v1 g2 v2 = 
	let s1 = unmarked (ordered_succ g1 v1) and s2 = unmarked (ordered_succ g2 v2) in
	if s1 == [] && s2 == [] then
		(0,[],[],[])
	else if s1 == [] then 
		contract_g2 g1 v1 g2 v2 (List.hd s2)
	else if s2 == [] then
		contract_g1 g1 v1 g2 v2 (List.hd s1)
	else
		let h1 = List.hd s1 and h2 = List.hd s2 in
		
		(* Association *)
		associate h1 h2;
		let (ch,lh0,lh1,lh2) = distance_aux g1 h1 g2 h2 and
		(cq,lq0,lq1,lq2) = distance_aux g1 v1 g2 v2 in
		separate h1 h2;
		
		(* Contraction de g1 (v1,h1)*)
		let (cg1,lg1_0,lg1_1,lg1_2) = contract_g1 g1 v1 g2 v2 h1 in

		(* Contraction de g2 (v2,h2)*)
		let (cg2,lg2_0,lg2_1,lg2_2) = contract_g2 g1 v1 g2 v2 h2 in

		(* Calcul du minimum du nombre de contractions*)
		let min_c = min (ch+cq) (min cg1 cg2) in
		
		if min_c == ch+cq then (* L'association donne le minimum d'éditions *)
			(ch+cq, ((h1,h2)::lh0)@lq0, lh1@lq1, lh2@lq2)
		else if min_c == cg1 then (* La contraction sur g1 donne le minimum d'éditions*)
			(cg1, lg1_0, lg1_1, lg1_2)
		else  (* La contraction sur g2 donne le minimum d'éditions *)
			(cg2, lg2_0, lg2_1, lg2_2)
;;

let distance g1 v1 g2 v2 = 
	(* Nettoyer tous les sommets *)
	Mark.clear g1;
	Mark.clear g2;
	(* Associer les deux racines et appeler la fonction auxiliaire *)
	associate v1 v2;
	let (c,l0,l1,l2) = distance_aux g1 v1 g2 v2 in
	let l = (v1,v2)::l0 in
	separate v1 v2;
	(c,l,l1,l2);

	;;


(*Section 4*)

(* Fonctions auxiliaires mutuellement récursives *)
(* Contracter le deuxième graphe et faire l'appel récursif *)
let rec contract_g2_opti g1 v1 g2 v2 h nb_edit min_edit = 
	let la_g2= contract g2 v2 h in
	let (ch, l0, l1, l2) = distance_aux_opti g1 v1 g2 v2 (nb_edit+1) min_edit in
	insert g2 v2 h la_g2;
	(ch+1, l0, l1, (v2, h)::l2)

(* Contracter le premier graphe et faire l'appel récursif *)
and contract_g1_opti g1 v1 g2 v2 h nb_edit min_edit = 
	let la_g1= contract g1 v1 h in
	let (ch, l0, l1, l2) = distance_aux_opti g1 v1 g2 v2 (nb_edit+1) min_edit in
	insert g1 v1 h la_g1;
	(ch+1, l0, (v1, h)::l1, l2)
	
and distance_aux_opti g1 v1 g2 v2 nb_edit min_edit = 
	let s1 = unmarked (ordered_succ g1 v1) and s2 = unmarked (ordered_succ g2 v2) in
	let (c_min,l0_min,l1_min,l2_min) = min_edit in
	(* Si on a déjà fait plus de c_min éditions, alors on renvoie directement le tuple min_edit *)
	if (nb_edit >= c_min) then
		min_edit
	(* Sinon, dérouler les différents cas de l'algorithme *)
	else if s1 == [] && s2 == [] then
		(0,[],[],[])
	else if s1 == [] then 
		contract_g2_opti g1 v1 g2 v2 (List.hd s2) nb_edit min_edit
	else if s2 == [] then
		contract_g1_opti g1 v1 g2 v2 (List.hd s1) nb_edit min_edit
	else 
		let h1 = List.hd s1 and h2 = List.hd s2 in
		
		(* Association *)
		associate h1 h2;
		let (ch,lh0,lh1,lh2) = distance_aux_opti g1 h1 g2 h2 nb_edit min_edit in
		let (cq,lq0,lq1,lq2) = distance_aux_opti g1 v1 g2 v2 nb_edit min_edit in
		separate h1 h2;
		
		(* Mettre à jour le minimum d'éditions si l'association a nécessité moins d'éditions *)
		let new_min = 
			if (ch+cq < c_min) then
				(ch+cq, ((h1,h2)::lh0)@lq0, lh1@lq1, lh2@lq2)
			else min_edit in

						
		(* Contraction de g1 (v1,h1) *)
		let (cg1,lg1_0,lg1_1,lg1_2) = contract_g1_opti g1 v1 g2 v2 h1 nb_edit new_min in

		(* Mettre à jour le minimum d'éditions si la contraction a nécessité moins d'éditions *)
		let new_min2 = 
			if (cg1< c_min && cg1<ch+cq) then
				(cg1, lg1_0, lg1_1, lg1_2)
			else new_min in


		(* Contraction de g2 (v2,h2) *)
		let (cg2,lg2_0,lg2_1,lg2_2) = contract_g2_opti g1 v1 g2 v2 h2 nb_edit new_min2 in

		(* Calcul du minimum du nombre de contractions*)
		let min_c = min (ch+cq) (min cg1 cg2) in
		
		if min_c == ch+cq then (* L'association donne le minimum d'éditions *)
			(ch+cq, ((h1,h2)::lh0)@lq0, lh1@lq1, lh2@lq2)
		else if min_c == cg1 then (* La contraction sur g1 donne le minimum d'éditions *)
			(cg1, lg1_0, lg1_1, lg1_2)
		else  (* La contraction sur g2 donne le minimum d'éditions *)
			(cg2, lg2_0, lg2_1, lg2_2)
;;


let distance_opti g1 v1 g2 v2 = 
	(* Nettoyer tous les sommets *)
	Mark.clear g1;
	Mark.clear g2;
	(* Associer les deux racines et appeler la fonction auxiliaire en spécifiant le paramètre nb_edit initial *)
	associate v1 v2;
	let (c,l0,l1,l2) = distance_aux_opti g1 v1 g2 v2 0 (2*(nb_edges g1)+1,[],[],[]) in
	let l = (v1,v2)::l0 in
	separate v1 v2;
	(c,l,l1,l2);

	;;

