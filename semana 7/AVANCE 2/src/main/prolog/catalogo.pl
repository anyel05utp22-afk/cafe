:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Módulo  : catalogo.pl
%  Base de conocimiento: productos del menú (hechos Prolog)
% ============================================================

:- module(catalogo, [
       producto/7,          % producto(Id, Nombre, Precio, Categoria, Imagen, Emoji, Descripcion)
       menu/1,              % menu(-ListaDeProductos)
       categoria/1,         % categoria(?Categoria)
       filtro_boton/2       % filtro_boton(?Clave, ?Etiqueta)
   ]).

% ------------------------------------------------------------
% Catálogo de productos (equivalente a List[Producto] en Scala)
% producto(Id, Nombre, Precio, Categoria, Imagen, CodigoEmoji, Descripcion)
% ------------------------------------------------------------
producto(1,  'Cafe Americano',     8.0,  bebida,   'americano.png',      9749,   'Espresso con agua caliente, sabor suave y reconfortante.').
producto(2,  'Capuchino',          12.0, bebida,   'capuchino.png',      9749,   'Espresso con leche vaporizada y espuma cremosa.').
producto(3,  'Cafe Frio',          14.0, bebida,   'cafe_frio.png',      127867, 'Cold brew con hielo, suave y refrescante.').
producto(4,  'Chocolate Caliente', 10.0, bebida,   'chocolate.png',      127851, 'Chocolate artesanal con leche entera.').
producto(5,  'Torta de Chocolate', 15.0, postre,   'torta.png',          127856, 'Tres capas de bizcocho con ganache de cacao.').
producto(6,  'Galleta Artesanal',  5.0,  postre,   'galleta.png',        127850, 'Galleta con chips de chocolate horneada al momento.').
producto(7,  'Cheesecake',         14.0, postre,   'cheesecake.png',     127856, 'Base de galleta con crema de queso y frutos rojos.').
producto(8,  'Croissant',          9.0,  postre,   'croissant.png',      129360, 'Hojaldre mantecoso recien horneado.').
producto(9,  'Sandwich de Pollo',  16.0, sandwich, 'sandwich_pollo.png', 129386, 'Pan artesanal, pollo a la plancha, lechuga y tomate.').
producto(10, 'Club Sandwich',      18.0, sandwich, 'club_sandwich.png',  129386, 'Triple pan, jamon, queso, huevo y vegetales frescos.').
producto(11, 'Sandwich Veggie',    13.0, sandwich, 'veggie.png',         129367, 'Aguacate, queso, rucula y tomate cherry.').
producto(12, 'Jugo de Naranja',    9.0,  bebida,   'naranja.png',        127818, 'Naranja natural exprimida al momento.').

% Categorías válidas del menú
categoria(bebida).
categoria(postre).
categoria(sandwich).

% Botones de filtro (clave, contenido HTML del botón)
filtro_boton(todos,    ['Todo']).
filtro_boton(bebida,   [&(9749), ' Bebidas']).
filtro_boton(postre,   ['Postres']).
filtro_boton(sandwich, ['Sandwiches']).

% menu(-Lista): todo el catálogo como una lista inmutable de términos producto/7
menu(Lista) :-
    findall(producto(Id, N, P, C, I, E, D), producto(Id, N, P, C, I, E, D), Lista).
