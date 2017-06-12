## Practica 8 - Derivaciones

### Ejercicio 1

* $ f.xs = \langle \forall_i : 0 < i < \#xs : xs.i = xs.0 \rangle $

**Casos base**
$ f.[] $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 < i < \#[] : [].i = \{].0 \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \forall_i : 0 < i < 0 : [].i = \{].0 \rangle $
$ = \{\text{Rango vacío}\} $
$ True $

$ f.[x] $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 < i < \#[x] : [x].i = \{x].0 \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \forall_i : 0 < i < 1 : [x].i = \{x].0 \rangle $
$ = \{\text{Rango vacío}\} $
$ True $

**Caso inductivo**
$ f.(x\triangleright xs) $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 < i < \#(x\triangleright xs) : (x\triangleright xs).i = (x\triangleright xs).0 \rangle $
$ = \{\text{Definición de #}]$
$ \langle \forall_i : 0 < i < 1 + \#xs : (x\triangleright xs).i = (x\triangleright xs).0 \rangle $
$ = \{\text{Propiedad de .}]$
$ \langle \forall_i : 0 < i < 1 + \#xs : (x\triangleright xs).i = x \rangle $
$ = \{\text{Separación de un término}]$
$ (x \triangleright xs).1 = x \land \langle \forall_i : 0 < i < \#xs : (x\triangleright xs).(i + 1) = x \rangle $
$ = \{\text{Propiedad de .}\} $
$ xs.0 = x \land \langle \forall_i : 0 < i < \#xs : xs.i = x \rangle $
$ = \{\text{Hipótesis inductiva}\} $
$ xs.0 = x \land f.xs $

---

* $ f.xs.x = \langle \exists_i : 0 \le i < \#xs : xs.i = x \rangle $

**Caso base**
$ f.[].x $
$ = \{\text{Especificación}\} $
$ \langle \exists_i : 0 \le i < \#[] : [].i = x \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \exists_i : 0 \le i < 0 : [].i = x \rangle $
$ = \{\text{Rango vacío}\} $
$ False $

**Caso inductivo**
$ f.(y \triangleright xs).x $
$ = \{\text{Especificación}\} $
$ \langle \exists_i : 0 \le i < \#(y \triangleright xs) : (y \triangleright xs).i = x \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \exists_i : 0 \le i < 1 + \#xs : (y \triangleright xs).i = x \rangle $
$ = \{\text{Separación de un término}\} $
$ (y \triangleright xs).0 = x \lor \langle \exists_i : 0 \le i < \#xs : (y \triangleright xs).(i + 1) = x \rangle $
$ = \{\text{Propiedad de .}\} $
$ y = x \lor \langle \exists_i : 0 \le i < \#xs : xs.i = x \rangle $
$ = \{\text{Hipótesis inductiva}\} $
$ y = x \lor f.xs.x $

---

* $ f.xs.x = \langle \forall_i : 0 \le i < \#xs : xs.i = x \rangle $

**Caso base**
$ f.[].x $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 \le i < \#[] : [].i = x \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \forall_i : 0 \le i < 0 : [].i = x \rangle $
$ = \{\text{Rango vacío}\} $
$ True $

**Caso inductivo**
$ f.(y \triangleright xs).x $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 \le i < \#(y \triangleright xs) : (y \triangleright xs).i = x \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \forall_i : 0 \le i < 1 + \#xs : (y \triangleright xs).i = x \rangle $
$ = \{\text{Separación de un término}\} $
$ (y \triangleright xs).0 = x \land \langle \forall_i : 0 \le i < \#xs : (y \triangleright xs).(i + 1) = x \rangle $
$ = \{\text{Propiedad de .}\} $
$ y = x \land \langle \forall_i : 0 \le i < \#xs : xs.i = x \rangle $
$ = \{\text{Hipótesis inductiva}\} $
$ y = x \land f.xs.x $

---

* $ f.xs.ys = \langle \forall_i : 0 \le i < \#xs \lor 0 \le i < \#ys : \#xs = \#ys \land xs.i = ys.i \rangle $

**Casos base**

$ f.[].[] $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 \le i < \#[] \lor 0 \le i < \#[] : \#[] = \#[] \land [].i = [].i \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \forall_i : 0 \le i < 0 \lor 0 \le i < 0 : 0 = 0 \land [].i = [].i \rangle $
$ = \{\text{Rango vacío}\} $
$ True $

$ f.(x \triangleright xs).[] $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 \le i < \#(x \triangleright xs) \lor 0 \le i < \#[] : \#(x \triangleright xs) = \#[] \land (x \triangleright xs).i = [].i \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \forall_i : 0 \le i < 1 + \#xs \lor 0 \le i < 0 : 1 + \#xs = 0 \land (x \triangleright xs).i = [].i \rangle $
$ = \{\text{Lógica y álgebra}\} $
$ \langle \forall_i : 0 \le i < 1 + \#xs : False \land (x \triangleright xs).i = [].i \rangle $
$ = \{\text{Lógica}\} $
$ \langle \forall_i : 0 \le i < 1 + \#xs : False \rangle $
$ = \{\text{Término constante}\} $
$ False $

Análogamente se resuelve $ f.[].(y \triangleright ys) $

$ f.(x \triangleright xs).(y \triangleright ys) $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 \le i < \#(x \triangleright xs) \lor 0 \le i < \#(y \triangleright ys) : \#(x \triangleright xs) = \#(y \triangleright ys) \land (x \triangleright xs).i = (y \triangleright ys).i \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \forall_i : 0 \le i < 1 + \#xs \lor 0 \le i < 1 + \#ys : 1 + \#xs = 1 + \#ys \land (x \triangleright xs).i = (y \triangleright ys).i \rangle $
$ = \{\text{Aritmética}\} $
$ \langle \forall_i : 0 \le i < 1 + \#xs \lor 0 \le i < 1 + \#ys : \#xs = \#ys \land (x \triangleright xs).i = (y \triangleright ys).i \rangle $
$ = \{\text{Separación de un término}\} $
$ \#xs = \#ys \land (x \triangleright xs).0 = (y \triangleright ys).0 \land \langle \forall_i : 0 \le i < \#xs \lor 0 \le i < \#ys : \#xs = \#ys \land (x \triangleright xs).(i + 1) = (y \triangleright ys).(i + 1) \rangle $
$ = \{\text{Propiedad de .}\} $
$ \#xs = \#ys \land x = y \land \langle \forall_i : 0 \le i < \#xs \lor 0 \le i < \#ys : \#xs = \#ys \land xs.i = ys.i \rangle $
$ = \{\text{Hipótesis inductiva}\} $
$ \#xs = \#ys \land x = y \land f.xs.ys $

### Ejercicio 2

$ f.xs = \langle \forall_i : 0 \le i < \#xs - 1: xs.i < xs.(i + 1) \rangle $

**Casos base**

$ f.[] $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 \le i < \#[] - 1: [].i < [].(i + 1) \rangle $
$ = \{\text{Definición de #, aritmética}\} $
$ \langle \forall_i : 0 \le i < -1: [].i < [].(i + 1) \rangle $
$ = \{\text{Rango vacío}\} $
$ True $

$ f.[x] $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 \le i < \#[x] - 1: [x].i < [x].(i + 1) \rangle $
$ = \{\text{Definición de #, aritmética}\} $
$ \langle \forall_i : 0 \le i < 0: [x].i < [x].(i + 1) \rangle $
$ = \{\text{Rango vacío}\} $
$ True $

**Caso inductivo**

$ f.(x \triangleright xs) $
$ = \{\text{Especificación}\} $
$ \langle \forall_i : 0 \le i < \#(x \triangleright xs) - 1: (x \triangleright xs).i < (x \triangleright xs).(i + 1) \rangle $
$ = \{\text{Definición de #}\} $
$ \langle \forall_i : 0 \le i < \#xs: (x \triangleright xs).i < (x \triangleright xs).(i + 1) \rangle $
$ = \{\text{Separación de un término, aritmética}\} $
$ (x \triangleright xs).0 < (x \triangleright xs).1 \land \langle \forall_i : 0 \le i < \#xs: (x \triangleright xs).(i + 1) < (x \triangleright xs).(i + 2) \rangle $
$ = \{\text{Propiedad de .}\} $
$ x < xs.0 \land \langle \forall_i : 0 \le i < \#xs: xs.i < xs.(i + 1) \rangle $
$ = \{\text{Hipótesis inductiva}\} $
$ x < xs.0 \land f.xs $
