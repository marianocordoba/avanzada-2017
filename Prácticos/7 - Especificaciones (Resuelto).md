## Practica 7 - Especificaciones

#### Ejercicio 1

* $ f.xs = \langle \forall_i : 0 < i < \#xs : xs.i = xs.0 \rangle $


* $ f.xs = \langle \forall_{i,j} : 0 \le i < j < \#xs : xs.i \neq xs.j \rangle $


* $ P.xs = \langle\exists_i : 0 \le i < \#xs : xs.i = 1 \rangle \Rightarrow \langle\exists_i : 0 \le i < \#xs : xs.i = 0 \rangle $


* $ p.xs = \langle\Pi_i : 0 \le i < \#xs \ \land\ primo.(xs.i) : xs.i \rangle $

#### Ejercicio 2

* $ \langle Min_i : 0 \le i < \#xs : xs.i = True \rangle $


* $ \langle Max_i : 0 \le i < \#xs : xs.i = True \rangle $


* $ f.xs = \langle\forall_i : 0 < i < \#xs : xs.i = xs.0 \rangle $

#### Ejercicio 3

* $ f.xs = \langle N_i : o \le i < \#xs : par.(xs.i)\rangle = \langle N_i : 0 \le i < \#xs : impar.(xs.i)\rangle $


* $ f.n = |n| > 1 \ \land\ \neg\langle\exists_k : 2 \le k \le \sqrt{n} : n \bmod k = 0 \rangle $


* $ espejo.xs = \langle \forall_i : 0 \le i < \#xs : xs.(\#xs - (i + 1)) \rangle $


* $ f.xs = \langle\exists_{as,bs,cs} :: xs = as ⧺ bs ⧺ cs \ \land\ \#bs > 1 \ \land\ \langle\forall_i : 0 \le i < \#bs : bs.i = bs.(\#bs - (i + 1)) \rangle \rangle $


* $ f.xs.ys = \langle\exists_{as,bs} :: xs = as ⧺ ys ⧺ bs \rangle $


* $ f.xs.ys = \langle\exists_{as} :: xs = as ⧺ ys \rangle $

#### Ejercicio 4

* $ P.xs.ys = \langle \exists_{as,bs} :: xs = as ⧺ ys ⧺ bs \rangle $


* $ \langle Min_{as,bs,cs} : xs = as ⧺ bs ⧺ cs : sum.bs \rangle $


* $ maxigual.xs = \langle Max_{as,bs,cs} : xs = as ⧺ bs ⧺ cs\ \land\ \langle \forall_i : 0 < i < \#bs : bs.i = bs.0 \rangle : \#bs \rangle $


#### Ejercicio 5

* "Determinar si todos los elementos de la lista son mayores o iguales a cero"
* "Determinar si existe un elemento de la lista menor que el que le sigue"
* "Determinar si algún elemento de la lista es cero"
* "Determinar si todos los elementos de la lista son iguales"
