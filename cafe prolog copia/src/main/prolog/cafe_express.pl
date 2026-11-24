:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Curso: Lenguaje de Programación
%  Propuesta Semanas 1 a 9 — Programación Declarativa y Lógica en Prolog
%  (versión de consola con todas las semanas integradas)
%
%  Ejecutar:  swipl src/main/prolog/cafe_express.pl
% ============================================================

:- use_module(library(yall)).
:- use_module(library(apply)).
:- use_module(library(lists)).

% Módulos integrados del proyecto
:- use_module(catalogo, []).
:- use_module(logica, [sugerir_combo/4]).
:- use_module(semana6, [semana6/0]).
:- use_module(consulta, [semana7/0]).
:- use_module(control, [semana8/0]).

:- initialization(main, main).

% Modelo de datos: producto del menú  ->  producto(Nombre, Precio, Categoria)
menu([ producto('Café Americano',     8.0,  bebida),
       producto('Capuchino',          12.0, bebida),
       producto('Torta de Chocolate', 15.0, postre),
       producto('Galleta',            5.0,  postre),
       producto('Jugo de Naranja',    9.0,  bebida) ]).

% ----------------------------------------------------------
% SEMANA 1 — Predicados como programas / Valores inmutables
% Problema: el dueño suma los precios del carrito a mano
% y comete errores. calcular_total lo hace automáticamente
% usando una lista INMUTABLE (el carrito nunca se altera).
% ----------------------------------------------------------
carrito([12.0, 8.0, 15.0]).   % inmutable

calcular_total(Precios, Total) :-
    foldl([P, Acc0, Acc]>>(Acc is Acc0 + P), Precios, 0.0, Total).

% ----------------------------------------------------------
% SEMANA 2 — Predicados definidos + anónimos + en listas
% Problema: aplicar un descuento del 10% a cada producto
% manualmente toma mucho tiempo en horas pico.
% aplicar_descuento (predicado definido) + maplist con un
% predicado anónimo (lambda) recorre toda la lista.
% ----------------------------------------------------------
aplicar_descuento(Precio, Nuevo) :- Nuevo is Precio * 0.9.   % predicado definido

con_descuento(Precios, Nuevos) :-
    maplist([P, N]>>(N is P * 0.9), Precios, Nuevos).          % predicado anónimo

% ----------------------------------------------------------
% SEMANA 3 — Predicados de orden superior
% Problema: un cliente pide "algo de menos de S/10" y el
% dueño revisa el menú completo a mano.
% filtrar_productos recibe OTRO PREDICADO como parámetro
% (Condicion) -> eso es un predicado de ORDEN SUPERIOR.
% ----------------------------------------------------------
:- meta_predicate filtrar_productos(+, 1, -).
filtrar_productos(Lista, Condicion, Resultado) :-
    include(Condicion, Lista, Resultado).

mostrar_producto(producto(Nombre, Precio, _)) :-
    format('  ✔ ~w — S/ ~w~n', [Nombre, Precio]).

% ----------------------------------------------------------
% Programa principal: ejecuta todas las semanas (1 a 9)
% ----------------------------------------------------------
main :-
    set_stream(user_output, encoding(utf8)),
    format('╔══════════════════════════════════════════════════════════╗~n'),
    format('║            SISTEMA CaféExpress v2.0 (Consola)            ║~n'),
    format('║    Demostración Completa de Programación Lógica          ║~n'),
    format('╚══════════════════════════════════════════════════════════╝~n'),

    % Semana 1
    carrito(Carrito),
    calcular_total(Carrito, Total),
    format('~n── SEMANA 1: Total del pedido (Inmutabilidad) ──~n'),
    format('Pedido recibido : ~w~n', [Carrito]),
    format('Total a cobrar  : S/ ~w~n', [Total]),

    % Semana 2
    con_descuento(Carrito, ConDescuento),
    calcular_total(ConDescuento, NuevoTotal),
    format('~n── SEMANA 2: Descuento del 10% (Lambdas y Maplist) ──~n'),
    format('Precios originales : ~w~n', [Carrito]),
    format('Precios con -10%   : ~w~n', [ConDescuento]),
    format('Nuevo total        : S/ ~w~n', [NuevoTotal]),

    % Semana 3
    format('~n── SEMANA 3: Filtrar productos (Orden Superior) ──~n'),
    menu(Menu),
    filtrar_productos(Menu, [producto(_, P, _)]>>(P < 10.0), Baratos),
    filtrar_productos(Menu, [producto(_, _, C)]>>(C == bebida), Bebidas),
    format('Productos menores a S/10:~n'),
    maplist(mostrar_producto, Baratos),
    format('Solo bebidas:~n'),
    maplist(mostrar_producto, Bebidas),

    % Semana 6 — Especificación de programas y extracción de respuestas
    semana6,

    % Semana 7 — Unificación y resolución (problema WhatsApp de diapositiva)
    semana7,

    % Semana 8 — Control de ejecución (operador -> ;, cortes y iteración forall)
    semana8,

    % Semana 9 — Indeterminismo (Backtracking en exploración de combinaciones)
    format('~n── SEMANA 9: Indeterminismo (Sugerencia de combos hasta S/ 20) ──~n'),
    findall(combo(B, P, T), sugerir_combo(20.0, B, P, T), Combos),
    format('Combos encontrados por backtracking en catálogo:~n'),
    maplist([combo(B, P, T)]>>(format('  ☕ ~w + 🍰 ~w -> S/ ~2f~n', [B, P, T])), Combos),

    format('~n✅ Todas las funcionalidades (Semanas 1 a 9) ejecutadas correctamente.~n').
