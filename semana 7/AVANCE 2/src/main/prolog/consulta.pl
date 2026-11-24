:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Módulo  : consulta.pl
%  SEMANA 7 — Unificación y resolución
%
%  Problema: un cliente escribe por WhatsApp:
%    "¿Tienen algo sin leche y de menos de S/10?"
%  El dueño revisa a mano las recetas y el stock, tarda horas
%  pico y a veces ofrece productos agotados.
%
%  Solución: HECHOS (recetas y stock) + REGLAS (disponible,
%  opcion, combo). Prolog resuelve la pregunta por unificación
%  y búsqueda (resolución SLD con backtracking).
%
%  Los productos y precios salen del MISMO catálogo del menú
%  (catalogo.pl): producto/3 es una regla que los lee de allí.
%  El identificador es el nombre en minúsculas con guiones
%  bajos:  'Cafe Americano' -> cafe_americano
%
%  Probar en consola:   swipl src/main/prolog/consulta.pl
%     ?- opcion(P, 10, leche).
%     ?- opcion_sin(P, 10, [leche, harina]).
%     ?- disponible(sandwich_de_pollo).
%     ?- combo(cafe_americano, galleta_artesanal, T).
%     ?- semana7.            % ejecuta las consultas de ejemplo
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

:- use_module(catalogo).

% ------------------------------------------------------------
% HECHOS — productos (leídos del catálogo del menú)
% producto(Id, Categoria, Precio)
% ------------------------------------------------------------
producto(Id, Categoria, Precio) :-
    catalogo:producto(_, Nombre, Precio, Categoria, _, _, _),
    nombre_a_id(Nombre, Id).

nombre_producto(Id, Nombre) :-
    catalogo:producto(_, Nombre, _, _, _, _, _),
    nombre_a_id(Nombre, Id),
    !.

nombre_a_id(Nombre, Id) :-
    downcase_atom(Nombre, Minusculas),
    atomic_list_concat(Palabras, ' ', Minusculas),
    atomic_list_concat(Palabras, '_', Id).

% ------------------------------------------------------------
% HECHOS — recetas: contiene(Producto, Ingrediente)
% ------------------------------------------------------------
contiene(cafe_americano,     cafe).
contiene(capuchino,          cafe).
contiene(capuchino,          leche).
contiene(cafe_frio,          cafe).
contiene(cafe_frio,          hielo).
contiene(chocolate_caliente, chocolate).
contiene(chocolate_caliente, leche).
contiene(torta_de_chocolate, harina).
contiene(torta_de_chocolate, huevo).
contiene(torta_de_chocolate, chocolate).
contiene(torta_de_chocolate, leche).
contiene(galleta_artesanal,  harina).
contiene(galleta_artesanal,  chocolate).
contiene(galleta_artesanal,  mantequilla).
contiene(cheesecake,         harina).
contiene(cheesecake,         queso).
contiene(cheesecake,         frutos_rojos).
contiene(croissant,          harina).
contiene(croissant,          mantequilla).
contiene(sandwich_de_pollo,  pan).
contiene(sandwich_de_pollo,  pollo).
contiene(sandwich_de_pollo,  lechuga).
contiene(sandwich_de_pollo,  tomate).
contiene(club_sandwich,      pan).
contiene(club_sandwich,      jamon).
contiene(club_sandwich,      queso).
contiene(club_sandwich,      huevo).
contiene(club_sandwich,      lechuga).
contiene(sandwich_veggie,    pan).
contiene(sandwich_veggie,    aguacate).
contiene(sandwich_veggie,    queso).
contiene(sandwich_veggie,    rucula).
contiene(sandwich_veggie,    tomate).
contiene(jugo_de_naranja,    naranja).

% ------------------------------------------------------------
% HECHOS — ingredientes en stock (el pollo está agotado)
% ------------------------------------------------------------
stock(cafe).
stock(leche).
stock(hielo).
stock(chocolate).
stock(harina).
stock(huevo).
stock(mantequilla).
stock(queso).
stock(frutos_rojos).
stock(pan).
stock(lechuga).
stock(tomate).
stock(jamon).
stock(aguacate).
stock(rucula).
stock(naranja).
stock(pollo).

% ------------------------------------------------------------
% REGLAS
% ------------------------------------------------------------

% Disponible: ninguno de sus ingredientes está agotado
disponible(P) :-
    producto(P, _, _),
    \+ ( contiene(P, I), \+ stock(I) ).

% Opción válida: dentro del presupuesto, sin el ingrediente
% indicado y disponible
opcion(P, Max, I) :-
    producto(P, _, Precio),
    Precio =< Max,
    \+ contiene(P, I),
    disponible(P).

% Igual que opcion/3 pero excluyendo VARIOS ingredientes a la vez
opcion_sin(P, Max, Lista) :-
    producto(P, _, Precio),
    Precio =< Max,
    forall(member(I, Lista), \+ contiene(P, I)),
    disponible(P).

% Combo bebida + postre con 10% de descuento
% (se redondea a 2 decimales, igual que aplicar_descuento/2
%  de logica.pl, para evitar 11.700000000000001)
combo(B, C, Total) :-
    producto(B, bebida, P1),
    producto(C, postre, P2),
    Total is round((P1 + P2) * 0.9 * 100) / 100.0.

% ------------------------------------------------------------
% Auxiliares (para la página web y la demo de consola)
% ------------------------------------------------------------

% ingredientes(-Lista): ingredientes distintos usados en las recetas
ingredientes(Lista) :-
    setof(I, P^contiene(P, I), Lista).

% faltantes(+Producto, -Lista): ingredientes agotados de la receta
faltantes(P, Lista) :-
    findall(I, ( contiene(P, I), \+ stock(I) ), Lista).

% excluidos(+Producto, +Lista, -Presentes): ingredientes de la
% lista que SÍ lleva el producto (los que el cliente no quiere)
excluidos(P, Lista, Presentes) :-
    findall(I, ( member(I, Lista), contiene(P, I) ), Presentes).

% nombre_legible(+cafe_americano, -'Cafe americano')
nombre_legible(Atomo, Texto) :-
    atomic_list_concat(Partes, '_', Atomo),
    atomic_list_concat(Partes, ' ', Frase),
    sub_atom(Frase, 0, 1, _, Inicial),
    sub_atom(Frase, 1, _, 0, Resto),
    upcase_atom(Inicial, Mayus),
    atom_concat(Mayus, Resto, Texto).

% ------------------------------------------------------------
% Demostración por consola
% ------------------------------------------------------------
semana7 :-
    catch(set_stream(user_output, encoding(utf8)), _, true),
    format('~n── SEMANA 7: Unificación y resolución ──~n'),
    format('Cliente: "¿Tienen algo sin leche y de menos de S/10?"~n~n'),

    format('?- opcion(P, 10, leche).~n'),
    findall(P, opcion(P, 10, leche), Opciones),
    mostrar_respuestas('P', Opciones),

    format('~n?- opcion_sin(P, 10, [leche, harina]).~n'),
    findall(P, opcion_sin(P, 10, [leche, harina]), Opciones2),
    mostrar_respuestas('P', Opciones2),

    format('~n?- disponible(sandwich_de_pollo).~n'),
    (   disponible(sandwich_de_pollo)
    ->  format('   true.~n')
    ;   format('   false.   (el pollo está agotado)~n')
    ),

    format('~n?- combo(cafe_americano, galleta_artesanal, T).~n'),
    (   combo(cafe_americano, galleta_artesanal, T)
    ->  format('   T = ~w~n', [T])
    ;   format('   false.~n')
    ).

mostrar_respuestas(_, []) :- !,
    format('   false.~n').
mostrar_respuestas(Var, Valores) :-
    forall(member(V, Valores), format('   ~w = ~w~n', [Var, V])),
    format('   false.   (no hay más soluciones)~n').