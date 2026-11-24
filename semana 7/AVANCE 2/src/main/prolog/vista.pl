:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Módulo  : vista.pl
%  Generación del HTML de la página con la DCG html//1 de
%  SWI-Prolog. Cada componente visual es un no-terminal.
% ============================================================

:- module(vista, [pagina/1]).

:- use_module(library(http/html_write)).
:- use_module(library(lists)).
:- use_module(catalogo).
:- use_module(logica).

% pagina(+Estado)
% Estado = estado(Categoria, Carrito, Descuento, Toast, Modal, Quieto)
pagina(estado(Cat, Carrito, Desc, Toast, Modal, Quieto)) :-
    reply_html_page(
        [ title('CaféExpress — Pedidos Online'),
          meta([name(viewport), content('width=device-width, initial-scale=1.0')]),
          meta([name(description),
                content('CaféExpress: pide café artesanal, postres frescos y sándwiches en línea.')]),
          link([rel(stylesheet), href('/css/estilos.css')])
        ],
        [ \barra_navegacion(Carrito),
          \hero,
          \seccion_principal(Cat, Carrito, Desc, Quieto),
          \toast(Toast),
          \modal(Modal, Cat)
        ]).

% ------------------------------------------------------------
% Barra de navegación
% ------------------------------------------------------------
barra_navegacion(Carrito) -->
    { cantidad_total(Carrito, N) },
    html(nav([ div(class(logo), [&(9749), ' ', span('Café'), 'Express']),
               ul(class('nav-links'),
                  [ li(a(href('#'), 'Inicio')),
                    li(a(href('#menu'), 'Menú')),
                    li(a(href('/consulta'), 'Consulta')),
                    li(a(href('#'), 'Nosotros')),
                    li(a(href('#'), 'Contacto'))
                  ]),
               a([class('cart-btn'), href('#carrito-panel')],
                 [ &(128722), ' Mi pedido ',
                   span([class('cart-count'), id('cart-count')], N)
                 ])
             ])).

% ------------------------------------------------------------
% Hero
% ------------------------------------------------------------
hero -->
    html(div(class(hero),
             div(class('hero-text'),
                 [ h1(['El mejor café,', br([]), span('en tus manos')]),
                   p('Pide desde donde estés. Café artesanal, postres frescos y más, listos en minutos.'),
                   a([class('hero-badge'), href('#menu')], ['Ver menú ', &(darr)])
                 ]))).

% ------------------------------------------------------------
% Sección principal: menú + carrito
% ------------------------------------------------------------
seccion_principal(Cat, Carrito, Desc, Quieto) -->
    { productos_por_categoria(Cat, Productos),
      ( Quieto == true -> GridCls = 'productos-grid quieto' ; GridCls = 'productos-grid' )
    },
    html(div([class(main), id(menu)],
             [ div(class('menu-section'),
                   [ h2(class('section-title'), 'Nuestro Menú'),
                     p(class('section-sub'),
                       'Selecciona una categoría y agrega lo que desees a tu pedido'),
                     % Semana 3 — filtrar_productos (orden superior)
                     \filtros(Cat),
                     div([class(GridCls), id('productos-grid')],
                         \tarjetas(Productos, 0, Cat))
                   ]),
               \panel_carrito(Cat, Carrito, Desc)
             ])).

% Botones de filtro por categoría
filtros(Actual) -->
    { findall(C-E, filtro_boton(C, E), Botones) },
    html(div(class(filtros), \botones_filtro(Botones, Actual))).

botones_filtro([], _) --> [].
botones_filtro([C-Etiqueta|Resto], Actual) -->
    { ( C == Actual -> Cls = 'filtro-btn activo' ; Cls = 'filtro-btn' ),
      format(atom(Href), '/?cat=~w#menu', [C])
    },
    html(a([class(Cls), href(Href)], Etiqueta)),
    botones_filtro(Resto, Actual).

% Tarjetas de producto (recursión con índice para el retardo de animación)
tarjetas([], _, _) --> [].
tarjetas([P|Ps], I, Cat) -->
    tarjeta(P, I, Cat),
    { I1 is I + 1 },
    tarjetas(Ps, I1, Cat).

tarjeta(producto(Id, Nombre, Precio, Categoria, Img, _Emoji, Desc), I, CatActual) -->
    { Retardo is I * 0.05,
      format(atom(Estilo), 'animation-delay: ~2fs', [Retardo]),
      format(atom(PrecioTxt), 'S/ ~2f', [Precio]),
      format(atom(IdHtml), 'producto-~w', [Id]),
      format(atom(Src), '/img/~w', [Img])
    },
    html(div([class('producto-card'), id(IdHtml), style(Estilo), 'data-cat'(Categoria)],
             [ div(class('producto-img-wrap'),
                   [ img([src(Src), alt(Nombre), loading(lazy)]),
                     span(class('producto-cat-tag'), Categoria)
                   ]),
               div(class('producto-info'),
                   [ div(class('producto-nombre'), Nombre),
                     div(class('producto-desc'), Desc),
                     div(class('producto-footer'),
                         [ span(class('producto-precio'), PrecioTxt),
                           form([class('form-inline'), method(post), action('/agregar')],
                                [ input([type(hidden), name(id), value(Id)]),
                                  input([type(hidden), name(cat), value(CatActual)]),
                                  button([class('add-btn'), type(submit), title('Agregar')], '+')
                                ])
                         ])
                   ])
             ])).

% ------------------------------------------------------------
% Panel del carrito
% ------------------------------------------------------------
panel_carrito(Cat, Carrito, Desc) -->
    { subtotal_original(Carrito, Sub),
      calcular_total(Carrito, Total),          % Semana 1
      format(atom(SubTxt), 'S/ ~2f', [Sub]),
      format(atom(TotTxt), 'S/ ~2f', [Total]),
      Ahorro is Sub - Total,
      estado_boton_descuento(Carrito, Desc, AttrDesc, TxtDesc),
      ( Carrito == [] -> AttrPedir = [disabled(disabled)] ; AttrPedir = [] )
    },
    html(div([class('carrito-panel'), id('carrito-panel')],
             div(class('carrito-box'),
                 [ div(class('carrito-header'), [span(&(128722)), h3('Mi Pedido')]),
                   div([class('carrito-items'), id('carrito-items')],
                       \items_carrito(Carrito, Cat)),
                   div(class('carrito-resumen'),
                       [ div(class('resumen-fila'),
                             [span('Subtotal'), span(id('r-subtotal'), SubTxt)]),
                         \fila_descuento(Desc, Ahorro),
                         div(class('resumen-fila total'),
                             [span('Total'), span(id('r-total'), TotTxt)]),
                         % Semana 2 — aplicar_descuento + maplist
                         form([method(post), action('/descuento')],
                              [ input([type(hidden), name(cat), value(Cat)]),
                                button([class('btn-descuento'), id('btn-desc'), type(submit)|AttrDesc],
                                       TxtDesc)
                              ]),
                         % Semana 1 — calcular_total
                         form([method(post), action('/confirmar')],
                              [ input([type(hidden), name(cat), value(Cat)]),
                                button([class('btn-pedir'), id('btn-pedir'), type(submit)|AttrPedir],
                                       ['Confirmar pedido ', &(rarr)])
                              ])
                       ])
                 ]))).

estado_boton_descuento(_, true, [disabled(disabled)], 'Descuento aplicado') :- !.
estado_boton_descuento([], _, [disabled(disabled)], 'Aplicar descuento 10%') :- !.
estado_boton_descuento(_, _, [], 'Aplicar descuento 10%').

fila_descuento(true, Ahorro) --> !,
    { format(atom(Txt), '-S/ ~2f', [Ahorro]) },
    html(div([class('resumen-fila descuento'), id('r-desc-fila')],
             [span('Descuento 10%'), span(id('r-desc-val'), Txt)])).
fila_descuento(_, _) --> [].

items_carrito([], _) --> !,
    html(div([class('carrito-vacio'), id('carrito-vacio')],
             [ span(&(128218)),
               p(['Tu carrito está vacío.', br([]), '¡Agrega algo del menú!'])
             ])).
items_carrito(Items, Cat) -->
    filas_carrito(Items, Cat).

filas_carrito([], _) --> [].
filas_carrito([item(Id, Precio, Cant)|T], Cat) -->
    { producto(Id, Nombre, _, _, _, Emoji, _),
      format(atom(PrecioTxt), 'S/ ~2f c/u', [Precio])
    },
    html(div(class('item-row'),
             [ div(class('item-emoji'), &(Emoji)),
               div(class('item-info'),
                   [ div(class('item-nombre'), Nombre),
                     div(class('item-precio'), PrecioTxt)
                   ]),
               div(class('item-controles'),
                   [ \boton_cantidad(Id, -1, Cat, &(8722)),
                     span(class('item-cant'), Cant),
                     \boton_cantidad(Id, 1, Cat, '+')
                   ])
             ])),
    filas_carrito(T, Cat).

boton_cantidad(Id, Delta, Cat, Etiqueta) -->
    html(form([class('form-inline'), method(post), action('/cantidad')],
              [ input([type(hidden), name(id), value(Id)]),
                input([type(hidden), name(delta), value(Delta)]),
                input([type(hidden), name(cat), value(Cat)]),
                button([class('ctrl-btn'), type(submit)], Etiqueta)
              ])).

% ------------------------------------------------------------
% Toast y modal
% ------------------------------------------------------------
toast(none) --> !, [].
toast(Mensaje) -->
    html(div([class('toast show'), id(toast)], Mensaje)).

modal(none, _) --> !, [].
modal(pedido(Items, Total), Cat) -->
    { format(atom(TotTxt), 'S/ ~2f', [Total]),
      format(atom(Volver), '/?cat=~w#menu', [Cat])
    },
    html(div([class('overlay show'), id(overlay)],
             [ a([class('overlay-cerrar'), href(Volver), 'aria-label'('Cerrar')], []),
               div(class(modal),
                   [ div(class('modal-icon'), &(9989)),
                     h2('¡Pedido confirmado!'),
                     p(id('modal-texto'),
                       [ strong(Items), br([]), br([]),
                         'Total pagado: ', strong(TotTxt), br([]), br([]),
                         'Tu pedido esta en preparacion. Listo en 10 minutos!'
                       ]),
                     a([class('modal-btn'), href(Volver)], 'Hacer otro pedido')
                   ])
             ])).
