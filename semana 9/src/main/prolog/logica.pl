:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Módulo  : logica.pl
%  Reglas de negocio puras (sin efectos secundarios).
%  El carrito es una lista INMUTABLE de términos item(Id, Precio, Cantidad):
%  cada operación produce un carrito NUEVO, nunca modifica el anterior.
% ============================================================

:- module(logica, [
       calcular_total/2,         % Semana 1
       aplicar_descuento/2,      % Semana 2 (función definida)
       descontar_carrito/2,      % Semana 2 (map con lambda)
       filtrar_productos/3,      % Semana 3 (orden superior)
       productos_por_categoria/2,
       agregar_al_carrito/3,
       cambiar_cantidad/4,
       subtotal_original/2,
       cantidad_total/2,
       resumen_pedido/2,
       sugerir_combo/4
   ]).

:- use_module(library(yall)).
:- use_module(library(apply)).
:- use_module(library(lists)).
:- use_module(catalogo).

% ----------------------------------------------------------
% SEMANA 1 — calcular_total (foldl / reducción)
% Suma Precio * Cantidad de cada item del carrito.
% ----------------------------------------------------------
calcular_total(Items, Total) :-
    foldl([item(_, P, C), Acc0, Acc]>>(Acc is Acc0 + P * C), Items, 0.0, Total).

% ----------------------------------------------------------
% SEMANA 2 — aplicar_descuento (predicado definido) +
% maplist con un predicado anónimo (lambda) sobre la lista.
% ----------------------------------------------------------
aplicar_descuento(Precio, Nuevo) :-
    Nuevo is round(Precio * 0.9 * 100) / 100.0.

descontar_carrito(Items, ConDescuento) :-
    maplist([item(Id, P, C), item(Id, P2, C)]>>aplicar_descuento(P, P2),
            Items, ConDescuento).

% ----------------------------------------------------------
% SEMANA 3 — filtrar_productos: predicado de ORDEN SUPERIOR.
% Recibe OTRO predicado (Condicion) como parámetro.
% ----------------------------------------------------------
:- meta_predicate filtrar_productos(+, 1, -).
filtrar_productos(Lista, Condicion, Resultado) :-
    include(Condicion, Lista, Resultado).

% productos_por_categoria(+Categoria, -Productos)
productos_por_categoria(todos, Productos) :- !,
    menu(Productos).
productos_por_categoria(Cat, Productos) :-
    menu(Menu),
    % se pasa el predicado parcialmente aplicado es_de_categoria(Cat)
    filtrar_productos(Menu, es_de_categoria(Cat), Productos).

% Condición usada como argumento de orden superior
es_de_categoria(Cat, producto(_, _, _, Cat, _, _, _)).

% ----------------------------------------------------------
% Operaciones sobre el carrito (devuelven un carrito nuevo)
% ----------------------------------------------------------

% agregar_al_carrito(+Id, +Carrito0, -Carrito)
agregar_al_carrito(Id, C0, C) :-
    producto(Id, _, Precio, _, _, _, _),
    (   select(item(Id, P, N0), C0, item(Id, P, N), C)
    ->  N is N0 + 1
    ;   append(C0, [item(Id, Precio, 1)], C)
    ).

% cambiar_cantidad(+Id, +Delta, +Carrito0, -Carrito)
% Si la cantidad llega a 0 el item se elimina.
cambiar_cantidad(_, _, [], []).
cambiar_cantidad(Id, Delta, [item(Id, P, N0)|T], R) :- !,
    N is N0 + Delta,
    (   N =< 0
    ->  R = T
    ;   R = [item(Id, P, N)|T]
    ).
cambiar_cantidad(Id, Delta, [I|T], [I|R]) :-
    cambiar_cantidad(Id, Delta, T, R).

% subtotal_original(+Items, -Subtotal): usa los precios de catálogo
subtotal_original(Items, Subtotal) :-
    foldl([item(Id, _, C), A0, A]>>( producto(Id, _, P, _, _, _, _),
                                     A is A0 + P * C ),
          Items, 0.0, Subtotal).

% cantidad_total(+Items, -N): número total de unidades
cantidad_total(Items, N) :-
    foldl([item(_, _, C), A0, A]>>(A is A0 + C), Items, 0, N).

% resumen_pedido(+Items, -Texto): "Capuchino x2, Galleta Artesanal x1"
resumen_pedido(Items, Texto) :-
    maplist([item(Id, _, C), T]>>( producto(Id, Nom, _, _, _, _, _),
                                   format(atom(T), '~w x~w', [Nom, C]) ),
            Items, Partes),
    atomic_list_concat(Partes, ', ', Texto).

% ----------------------------------------------------------
% INDETERMINISMO — sugerir_combo(+PresupuestoMax, -NombreBebida, -NombrePostre, -Total)
% Explora automáticamente todas las combinaciones posibles
% gracias al backtracking del motor lógico.
% ----------------------------------------------------------
sugerir_combo(PresupuestoMax, NombreBebida, NombrePostre, Total) :-
    producto(_, NombreBebida, PrecioBebida, bebida, _, _, _),
    producto(_, NombrePostre, PrecioPostre, postre, _, _, _),
    Total is PrecioBebida + PrecioPostre,
    Total =< PresupuestoMax.