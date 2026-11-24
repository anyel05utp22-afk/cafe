:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  MÓDULO  : control.pl
%  SEMANA 8 — Control de ejecución
%
%  Control de flujo y ejecución mediante:
%    - Operador condicional / corte condicional: ( Condición -> Entonces ; SiNo )
%    - Operador de corte (!)
%    - Iteración exhaustiva con forall/2
%    - Búsqueda y manipulación determinista con select/3
% ==========================================

:- module(control, [
       carrito_inicial/1,
       agregar_producto/3,
       mostrar_carrito/1,
       semana8/0
   ]).

% Carrito inicial 
carrito_inicial([
    item(cafe, 2),
    item(galleta, 1)
]).

% Agregar un producto al carrito utilizando control de ejecución (-> ;)
agregar_producto(Id, Carrito, NuevoCarrito) :-
    (
        select(item(Id, Cantidad), Carrito, Resto)
        ->
        % Si el producto ya existe, aumentar cantidad
        NuevaCantidad is Cantidad + 1,
        NuevoCarrito = [item(Id, NuevaCantidad)|Resto]
        ;
        % Si el producto no existe, agregarlo con cantidad 1
        NuevoCarrito = [item(Id, 1)|Carrito]
    ).

% Mostrar el resultado del carrito iterando con forall/2
mostrar_carrito(Carrito) :-
    writeln('--- CARRITO DE CAFEEXPRESS ---'),
    forall(
        member(item(Producto, Cantidad), Carrito),
        format('Producto: ~w | Cantidad: ~w~n',
               [Producto, Cantidad])
    ).

% Demostración de consola para la Semana 8
semana8 :-
    catch(set_stream(user_output, encoding(utf8)), _, true),
    format('~n── SEMANA 8: Control de ejecución ──~n'),
    carrito_inicial(C0),
    writeln('1. Carrito inicial:'),
    mostrar_carrito(C0),
    writeln('2. Agregando "cafe" (producto ya en carrito -> incrementa cantidad):'),
    agregar_producto(cafe, C0, C1),
    mostrar_carrito(C1),
    writeln('3. Agregando "te" (producto nuevo -> añade nuevo item con cantidad 1):'),
    agregar_producto(te, C1, C2),
    mostrar_carrito(C2).
