#use "skeltest.ml";;

(* Tests associate *)
associate obj1_1v2 obj1_1v3;;
Mark.get obj1_1v2 == 3;;
Mark.get obj1_1v3 == 2;;

associate obj1_2v2 obj1_1v3;;
Mark.get obj1_2v2 == 3;;
Mark.get obj1_1v3 == 2;;

(* Tests separate *)
separate obj1_1v2 obj1_1v3;;
separate obj1_2v2 obj1_1v3;;
Mark.get obj1_1v2 == 0;;
Mark.get obj1_2v2 == 0;;
Mark.get obj1_1v3 == 0;;


(*let copie_1 = copy obj1_1;;
let copie_2 = copy obj1_2;;
let copie_3 = copy obj1_3;;*)


(* Test equals *)
let (b1, l1) = equals obj1_1 obj1_1v5 obj1_2 obj1_2v4;;
b1;;
let (b2, l2) =  equals obj1_1 obj1_1v5 obj1_3 obj1_3v3;;
not(b2);;
let (b3, l3) = equals obj2_1 obj2_1v3 obj2_2 obj2_2v1;;
not(b3);;


(* Tests contract *)
let la1 = contract obj1_1 obj1_1v2 obj1_1v1;;
not (mem_vertex obj1_1 obj1_1v1);;
not (mem_edge obj1_1 obj1_1v2 obj1_1v1);;
mem_edge obj1_1 obj1_1v2 obj1_1v6;;
mem_edge obj1_1 obj1_1v2 obj1_1v3;;

let la2= contract obj1_2 obj1_2v2 obj1_2v1;;
not (mem_vertex obj1_2 obj1_2v1);;
not (mem_edge obj1_2 obj1_2v2 obj1_2v1);;
mem_edge obj1_2 obj1_2v2 obj1_2v5;;
mem_edge obj1_2 obj1_2v2 obj1_2v3;;


let la3= contract obj1_3 obj1_3v1 obj1_3v5;;
not (mem_vertex obj1_3 obj1_3v5);;
not (mem_edge obj1_3 obj1_3v1 obj1_3v5);;


(* Tests insert *)
insert obj1_1 obj1_1v2 obj1_1v1 la1;;
mem_vertex obj1_1 obj1_1v1;;
mem_edge obj1_1 obj1_1v2 obj1_1v1;;
not (mem_edge obj1_1 obj1_1v2 obj1_1v6);;
not (mem_edge obj1_1 obj1_1v2 obj1_1v3);;


insert obj1_2 obj1_2v2 obj1_2v1 la2;;
mem_vertex obj1_2 obj1_2v1;;
mem_edge obj1_2 obj1_2v2 obj1_2v1;;
not (mem_edge obj1_2 obj1_2v2 obj1_2v5);;
not (mem_edge obj1_2 obj1_2v2 obj1_2v3);;

insert obj1_3 obj1_3v1 obj1_3v5 la3;;
mem_vertex obj1_3 obj1_3v5;;
mem_edge obj1_3 obj1_3v1 obj1_3v5;;

(* Tests distance 
let (c1, l1_0, l1_1, l1_2) = distance obj1_1 obj1_1v5 obj1_3 obj1_3v3;;
c1 == 2;;
let (c2, l2_0, l2_1, l2_2) = distance obj1_1 obj1_1v5 obj1_2 obj1_2v4;;
c2 == 0;;
let (c3, l3_0, l3_1, l3_2) = distance obj2_1 obj2_1v3 obj2_2 obj2_2v1;;
c3 == 2;;
let (c4, l4_0, l4_1, l4_2) = distance obj1_1 obj1_1v5 obj1_1 obj1_1v5;;
c4 == 0;;
let (c5, l5_0, l5_1, l5_2) = distance obj1_1 obj1_1v5 obj1_1 obj1_1v1;;
c5 == 2;;*)

let (c1, l1_0, l1_1, l1_2) = distance_opti obj1_1 obj1_1v5 obj1_3 obj1_3v3;;
c1 == 2;;



(* Test equals apres distance *)
let (b1, l1) = equals obj1_1 obj1_1v5 obj1_2 obj1_2v4 in b1;;
let (b2, l2) = equals obj1_1 obj1_1v5 obj1_3 obj1_3v3 in not(b2);;
let (b3, l3) = equals obj2_1 obj2_1v3 obj2_2 obj2_2v1 in not(b3);;


