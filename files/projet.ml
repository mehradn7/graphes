(*Section 1*)

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

let contract g o a = [];;

let insert g o a la = 
   begin
      add_vertex g a;
      List.iter (fun n -> begin remove_edge g o n; add_edge g a n end) la;
      add_edge g o a
   end;;


(*Section 2*)

let equals_aux g1 v1 g2 v2 = (true,[]);;

let equals g1 v1 g2 v2 = (true,[]);;


(*Section 3*)

let distance_aux g1 v1 g2 v2 = (0,[],[],[]);;

let distance g1 v1 g2 v2 = (0,[],[],[]);;


(*Section 4*)

let distance_opti g1 v1 g2 v2 = (0,[],[],[]);;
