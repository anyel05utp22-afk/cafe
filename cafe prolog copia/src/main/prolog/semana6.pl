:- encoding(utf8).
% ============================================================
% PROYECTO: CaféExpress — Sistema de Pedidos
% ARCHIVO : semana6.pl
% TEMA    : SEMANA 6 — Especificación de programas: términos,
%           átomos, constantes, predicados.
%           Reglas y programas — Extracción de respuestas.
% ============================================================

:- module(semana6, [
       producto/3,              % producto(?Nombre, ?Precio, ?Categoria)
       dentro_presupuesto/2,    % dentro_presupuesto(?Producto, +Presupuesto)
       es_bebida/1,             % es_bebida(?Producto)
       bebida_economica/1,      % bebida_economica(?Producto)
       recomendar/3,            % recomendar(?Producto, +Presupuesto, +Categoria)
       semana6/0                % demostración por consola
   ]).

% ------------------------------------------------------------
% 1. HECHOS / BASE DE CONOCIMIENTO
% Cada hecho producto/3 es un término compuesto:
%   producto(Nombre, Precio, Categoria).
% Átomos y constantes simbólicas:
%   cafe_americano, capuchino, torta_chocolate, galleta, jugo_naranja, bebida, postre.
% Constantes numéricas:
%   8.0, 12.0, 15.0, 5.0, 9.0
% Predicado:
%   producto/3  (nombre + aridad 3)
% ------------------------------------------------------------

producto(cafe_americano,     8.0,  bebida).
producto(capuchino,          12.0, bebida).
producto(torta_chocolate,    15.0, postre).
producto(galleta,            5.0,  postre).
producto(jugo_naranja,       9.0,  bebida).

% ------------------------------------------------------------
% 2. REGLAS
% ------------------------------------------------------------

% Un producto está dentro del presupuesto si su precio es
% menor o igual al monto indicado por el cliente.
dentro_presupuesto(Producto, Presupuesto) :-
    producto(Producto, Precio, _),
    Precio =< Presupuesto.

% Un producto es una bebida si en la base de conocimiento
% aparece con la categoría bebida.
es_bebida(Producto) :-
    producto(Producto, _, bebida).

% Regla compuesta:
% Una bebida económica debe ser bebida y además costar como máximo S/ 10.
bebida_economica(Producto) :-
    es_bebida(Producto),
    dentro_presupuesto(Producto, 10.0).

% Regla relacionada con la problemática:
% Recomendar un producto según presupuesto y categoría.
recomendar(Producto, Presupuesto, Categoria) :-
    producto(Producto, Precio, Categoria),
    Precio =< Presupuesto.

% ------------------------------------------------------------
% 3. EXTRACCIÓN DE RESPUESTAS (Demostración de consola)
% ------------------------------------------------------------
semana6 :-
    catch(set_stream(user_output, encoding(utf8)), _, true),
    format('~n── SEMANA 6: Especificación de programas y extracción de respuestas ──~n'),

    findall(P, dentro_presupuesto(P, 10.0), Economicos),
    format('Productos dentro de S/ 10       : ~w~n', [Economicos]),

    findall(P, bebida_economica(P), BebidasEconomicas),
    format('Bebidas económicas (máx S/ 10)  : ~w~n', [BebidasEconomicas]),

    findall(P, recomendar(P, 10.0, bebida), Recomendados),
    format('Recomendados (bebida, máx S/ 10): ~w~n', [Recomendados]).
