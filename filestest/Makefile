all: clean result.tar

projet.cmi: projet.mli
	@ocamlc -I /usr/lib/ocaml/ocamlgraph graph.cma projet.mli
projet.cma: projet.cmi projet.ml
	@ocamlc -a -I /usr/lib/ocaml/ocamlgraph graph.cma projet.ml -o projet.cma
	@rm -f a.out

maintest: skeleton.cma projet.cma testfun.cma 
	@ocamlc -I /usr/lib/ocaml/ocamlgraph skeleton.cma projet.cma testfun.cma maintest.ml -o maintest

res.txt: maintest
	@./maintest | tee res.txt

result.tar: res.txt
	@tar cf result.tar res.txt projet.ml

clean:
	@rm -f maintest
	@rm -f projet.cmi projet.cma 
	@rm -f a.out


