:- encoding(utf8).

% ==========================================
% CAFEEXPRESS - CONTROL DE EJECUCION
% Semana 8
% ==========================================

% Carrito inicial 
carrito_inicial([
    item(cafe, 2),
    item(galleta, 1)
]).

% Agregar un producto al carrito
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

% Mostrar el resultado del carrito
mostrar_carrito(Carrito) :-
    writeln('--- CARRITO DE CAFEEXPRESS ---'),
    forall(
        member(item(Producto, Cantidad), Carrito),
        format('Producto: ~w | Cantidad: ~w~n',
               [Producto, Cantidad])
    ).