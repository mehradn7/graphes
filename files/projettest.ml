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



