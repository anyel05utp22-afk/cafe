% ============================================================
% PROYECTO: CafeExpress - Sistema de Pedidos
% BLOQUE 6 / SEMANA 6 - PROGRAMACION LOGICA EN PROLOG
% Tema: terminos, atomos, constantes, predicados,
%       reglas, programas y extraccion de respuestas.
%
% IMPORTANTE:
% Este archivo es un aporte independiente. No modifica ni
% reemplaza CafeExpress.scala. Puede integrarse despues al
% proyecto grupal sin romper el codigo base.
% ============================================================

% ------------------------------------------------------------
% 1. HECHOS / BASE DE CONOCIMIENTO
%
% Cada hecho producto/3 es un termino compuesto:
%   producto(Nombre, Precio, Categoria).
%
% Atomos y constantes simbolicas:
%   cafe_americano, capuchino, bebida, postre, etc.
%
% Constantes numericas:
%   8.0, 12.0, 15.0, 5.0, 9.0
%
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

% Un producto esta dentro del presupuesto si su precio es
% menor o igual al monto indicado por el cliente.
%
% Predicado: dentro_presupuesto/2
% Variables: Producto, Presupuesto y Precio

dentro_presupuesto(Producto, Presupuesto) :-
    producto(Producto, Precio, _),
    Precio =< Presupuesto.

% Un producto es una bebida si en la base de conocimiento
% aparece con la categoria bebida.
%
% Predicado: es_bebida/1

es_bebida(Producto) :-
    producto(Producto, _, bebida).

% Regla compuesta:
% Una bebida economica debe ser bebida y ademas costar
% como maximo S/ 10.
%
% Predicado: bebida_economica/1

bebida_economica(Producto) :-
    es_bebida(Producto),
    dentro_presupuesto(Producto, 10.0).

% Regla relacionada directamente con la problematica:
% recomendar un producto segun presupuesto y categoria.
%
% Predicado: recomendar/3

recomendar(Producto, Presupuesto, Categoria) :-
    producto(Producto, Precio, Categoria),
    Precio =< Presupuesto.

% ------------------------------------------------------------
% 3. EXTRACCION DE RESPUESTAS
%
% Consultas que pueden ejecutarse en Prolog:
%
% ?- dentro_presupuesto(Producto, 10).
% Producto = cafe_americano ;
% Producto = galleta ;
% Producto = jugo_naranja.
%
% ?- bebida_economica(Producto).
% Producto = cafe_americano ;
% Producto = jugo_naranja.
%
% ?- recomendar(Producto, 10, bebida).
% Producto = cafe_americano ;
% Producto = jugo_naranja.
%
% Estas respuestas no estan escritas manualmente: Prolog las
% obtiene consultando los hechos y aplicando las reglas.
% ------------------------------------------------------------

% Punto de entrada para poder ejecutarlo directamente en
% SWI-Prolog / OneCompiler y obtener una demostracion rapida.

:- initialization(main).

main :-
    writeln('==============================================='),
    writeln(' CafeExpress - Bloque 6: Programacion Logica'),
    writeln('==============================================='),

    findall(P, dentro_presupuesto(P, 10.0), Economicos),
    write('Productos dentro de S/ 10: '),
    writeln(Economicos),

    findall(P, bebida_economica(P), BebidasEconomicas),
    write('Bebidas economicas: '),
    writeln(BebidasEconomicas),

    findall(P, recomendar(P, 10.0, bebida), Recomendados),
    write('Recomendados (bebida, max. S/ 10): '),
    writeln(Recomendados).
