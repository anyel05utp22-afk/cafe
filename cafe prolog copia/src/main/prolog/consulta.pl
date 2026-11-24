:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Módulo  : consulta.pl
%  SEMANA 7 — Unificación y resolución
%
%  Problema: Un cliente escribe por WhatsApp:
%    "¿Tienen algo sin leche y de menos de S/10?"
%  El dueño revisa a mano las recetas y el stock, tarda en horas
%  pico y a veces ofrece productos agotados.
% ============================================================

:- module(consulta, [
       producto/3,        % producto(?Id, ?Categoria, ?Precio)
       nombre_producto/2, % nombre_producto(?Id, ?NombreDelMenu)
       contiene/2,        % contiene(?Producto, ?Ingrediente)
       stock/1,           % stock(?Ingrediente)
       disponible/1,      % disponible(?Producto)
       opcion/3,          % opcion(?Producto, +PrecioMax, +IngredienteExcluido)
       opcion_sin/3,      % opcion_sin(?Producto, +PrecioMax, +ListaExcluidos)
       combo/3,           % combo(?Bebida, ?Postre, -TotalConDescuento)
       ingredientes/1,    % ingredientes(-Lista)
       faltantes/2,       % faltantes(+Producto, -IngredientesAgotados)
       excluidos/3,       % excluidos(+Producto, +ListaExcluidos, -Presentes)
       nombre_legible/2,  % nombre_legible(+Atomo, -Texto)
       semana7/0          % demostración por consola
   ]).

:- use_module(library(lists)).

% ============================================================
% INICIO DE PARTE EXACTA DE LA IMAGEN (SEMANA 7 - RECUADRO MORADO)
% ============================================================
% HECHOS
producto(cafe_americano, bebida, 8.0).
producto(capuchino,      bebida, 12.0).
producto(te_helado,      bebida, 7.5).
producto(sandwich_pollo, comida, 15.0).
producto(keke,           postre, 5.0).

contiene(cafe_americano, cafe).
contiene(capuchino,      cafe).
contiene(capuchino,      leche).
contiene(te_helado,      te).
contiene(sandwich_pollo, pollo).
contiene(keke,           leche).
contiene(keke,           harina).

% Ingredientes en stock (el pollo está agotado)
stock(cafe).
stock(leche).
stock(te).
stock(harina).
% ============================================================
% FIN DEL RECUADRO MORADO DE LA IMAGEN
% ============================================================

% ============================================================
% INICIO DE REGLAS DE LA IMAGEN (SEMANA 7)
% ============================================================
% REGLAS
% Disponible: ninguno de sus ingredientes está agotado
disponible(P) :- producto(P, _, _), \+ (contiene(P, I), \+ stock(I)).

% Opción válida: dentro del presupuesto, sin el ingrediente y disponible
opcion(P, Max, I) :-
    producto(P, _, Precio),
    Precio =< Max,
    \+ contiene(P, I),
    disponible(P).

% Combo bebida + postre con 10% de descuento
combo(B, C, Total) :-
    producto(B, bebida, P1),
    producto(C, postre, P2),
    Total is (P1 + P2) * 0.9.
% ============================================================
% FIN DE REGLAS DE LA IMAGEN
% ============================================================

% ------------------------------------------------------------
% Reglas auxiliares y complementarias para la web (/consulta)
% ------------------------------------------------------------

% Igual que opcion/3 pero excluyendo VARIOS ingredientes a la vez
opcion_sin(P, Max, Lista) :-
    producto(P, _, Precio),
    Precio =< Max,
    forall(member(I, Lista), \+ contiene(P, I)),
    disponible(P).

% ingredientes(-Lista): ingredientes distintos usados en las recetas
ingredientes(Lista) :-
    setof(I, P^contiene(P, I), Lista).

% faltantes(+Producto, -Lista): ingredientes agotados de la receta
faltantes(P, Lista) :-
    findall(I, ( contiene(P, I), \+ stock(I) ), Lista).

% excluidos(+Producto, +Lista, -Presentes): ingredientes de la lista
% que SÍ lleva el producto (los que el cliente desea evitar)
excluidos(P, Lista, Presentes) :-
    findall(I, ( member(I, Lista), contiene(P, I) ), Presentes).

% Nombres legibles para presentación y catálogo
nombre_producto(cafe_americano, 'Café Americano') :- !.
nombre_producto(capuchino,      'Capuchino') :- !.
nombre_producto(te_helado,      'Té Helado') :- !.
nombre_producto(sandwich_pollo, 'Sándwich de Pollo') :- !.
nombre_producto(keke,           'Keke') :- !.
nombre_producto(Id, Nombre) :-
    nombre_legible(Id, Nombre).

nombre_legible(Atomo, Texto) :-
    atomic_list_concat(Partes, '_', Atomo),
    atomic_list_concat(Partes, ' ', Frase),
    sub_atom(Frase, 0, 1, _, Inicial),
    sub_atom(Frase, 1, _, 0, Resto),
    upcase_atom(Inicial, Mayus),
    atom_concat(Mayus, Resto, Texto).

% ------------------------------------------------------------
% Demostración por consola (Ejecuta las consultas exactas de la imagen)
% ------------------------------------------------------------
semana7 :-
    catch(set_stream(user_output, encoding(utf8)), _, true),
    format('~n── SEMANA 7: Unificación y resolución ──~n'),
    format('Problema (WhatsApp): "¿Tienen algo sin leche y de menos de S/10?"~n~n'),

    format('?- opcion(P, 10, leche).~n'),
    findall(P, opcion(P, 10, leche), Opciones),
    mostrar_respuestas('P', Opciones),

    format('~n?- disponible(sandwich_pollo).~n'),
    (   disponible(sandwich_pollo)
    ->  format('   true.~n')
    ;   format('   false.   (el pollo está agotado)~n')
    ),

    format('~n?- combo(cafe_americano, keke, T).~n'),
    (   combo(cafe_americano, keke, T)
    ->  format('   T = ~1f~n', [T])
    ;   format('   false.~n')
    ).

mostrar_respuestas(_, []) :- !,
    format('   false.~n').
mostrar_respuestas(Var, Valores) :-
    forall(member(V, Valores), format('   ~w = ~w~n', [Var, V])),
    format('   false.~n').
