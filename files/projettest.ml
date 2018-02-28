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


let copie_1 = copy obj1_1;;
let copie_2 = copy obj1_2;;
let copie_3 = copy obj1_3;;


(* Test equals *)
equals obj1_1 obj1_1v5 obj1_2 obj1_2v4;;
equals obj1_1 obj1_1v5 obj1_3 obj1_3v3;;
equals obj2_1 obj2_1v3 obj2_2 obj2_2v1;;



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


let la3= contract obj1_3 obj1_3v2 obj1_3v5;;
not (mem_vertex obj1_3 obj1_3v5);;
not (mem_edge obj1_3 obj1_3v2 obj1_3v5);;


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

insert obj1_3 obj1_3v2 obj1_3v5 la3;;
mem_vertex obj1_3 obj1_3v5;;
mem_edge obj1_3 obj1_3v2 obj1_3v5;;

(* Tests distance *)


distance obj1_1 obj1_1v5 obj1_3 obj1_3v3;;
distance obj1_1 obj1_1v5 obj1_2 obj1_2v4;;

