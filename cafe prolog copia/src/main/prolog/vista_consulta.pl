:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Módulo  : vista_consulta.pl
%  SEMANA 7 — Unificación y resolución (página /consulta)
%
%  Página que responde la pregunta del cliente de WhatsApp
%  usando las reglas de consulta.pl (opcion_sin/3, disponible/1,
%  combo/3). Igual que vista.pl, cada componente visual es un
%  no-terminal de la DCG html//1 de SWI-Prolog.
% ============================================================

:- module(vista_consulta, [pagina_consulta/1]).

:- use_module(library(http/html_write)).
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(consulta).

% pagina_consulta(+Estado)
% Estado = estado(IngredientesExcluidos, PrecioMax, Bebida, Postre)
pagina_consulta(estado(Sins, Max, Beb, Pos)) :-
    reply_html_page(
        [ title('CaféExpress — Consulta de opciones'),
          meta([name(viewport), content('width=device-width, initial-scale=1.0')]),
          link([rel(stylesheet), href('/css/estilos.css')])
        ],
        [ \barra,
          \hero_consulta(Sins, Max),
          \contenido(Sins, Max, Beb, Pos)
        ]).

% ------------------------------------------------------------
% Barra de navegación y cabecera
% ------------------------------------------------------------
barra -->
    html(nav([ div(class(logo), [&(9749), ' ', span('Café'), 'Express']),
               ul(class('nav-links'),
                  [ li(a(href('/'), 'Inicio')),
                    li(a(href('/#menu'), 'Menú')),
                    li(a(href('/consulta'), 'Consulta'))
                  ]),
               a([class('cart-btn'), href('/#carrito-panel')],
                 [&(128722), ' Mi pedido'])
             ])).

hero_consulta(Sins, Max) -->
    { pregunta(Sins, Max, Pregunta) },
    html(div(class(hero),
             div(class('hero-text'),
                  [ h1(['Consulta rápida', br([]), span('por WhatsApp')]),
                    p(Pregunta),
                    p('Semana 7 — Unificación y resolución en Prolog.')
                  ]))).

pregunta([], Max, Texto) :- !,
    format(atom(Texto), '"¿Tienen algo de menos de S/~w?"', [Max]).
pregunta(Sins, Max, Texto) :-
    lista_texto(Sins, Lista),
    format(atom(Texto), '"¿Tienen algo sin ~w y de menos de S/~w?"', [Lista, Max]).

% ------------------------------------------------------------
% Contenido: formulario + resultados
% ------------------------------------------------------------
contenido(Sins, Max, Beb, Pos) -->
    { findall(P-C-Pr, ( opcion_sin(P, Max, Sins), producto(P, C, Pr) ), Opciones),
      (   combo(Beb, Pos, Total) -> true ; Total = none ),
      findall(P2-C2-Pr2, producto(P2, C2, Pr2), Todos)
    },
    html(div([class('cq-wrap'), id(resultados)],
             [ \formulario(Sins, Max, Beb, Pos),
               div(class('cq-grid'),
                   [ \tarjeta_opciones(Sins, Max, Opciones),
                     \tarjeta_combo(Beb, Pos, Total)
                   ]),
               \tarjeta_disponibilidad(Todos, Sins)
             ])).

% Formulario (GET /consulta)
formulario(Sins, Max, Beb, Pos) -->
    { ingredientes(Ings),
      findall(B, producto(B, bebida, _), Bebidas),
      findall(Po, producto(Po, postre, _), Postres)
    },
    html(div(class('cq-card'),
             [ div(class('cq-head'), 'Consulta del cliente'),
               div(class('cq-body'),
                   form([class('cq-form'), method(get), action('/consulta')],
                        [ input([type(hidden), name(f), value(1)]),
                          fieldset(class('cq-chips-box'),
                                   [ legend('Sin ingredientes (puedes elegir varios)'),
                                     div(class('cq-chips'), \chips(Ings, Sins))
                                   ]),
                          div(class('cq-row'),
                              [ label(class('cq-field'),
                                      [ span('Precio máximo (S/)'),
                                        input([type(number), name(max), value(Max),
                                               min(0), step('0.5')]) ]),
                                label(class('cq-field'),
                                      [ span('Bebida del combo'),
                                        select(name(bebida), \opciones_select(Bebidas, Beb)) ]),
                                label(class('cq-field'),
                                      [ span('Postre del combo'),
                                        select(name(postre), \opciones_select(Postres, Pos)) ]),
                                button([class('cq-btn'), type(submit)], 'Consultar')
                              ])
                        ]))
             ])).

% Casillas de ingredientes (selección múltiple)
chips([], _) --> [].
chips([I|Is], Sel) -->
    { nombre_legible(I, Texto),
      (   memberchk(I, Sel) -> Attr = [checked(checked)] ; Attr = [] )
    },
    html(label(class('cq-chip'),
               [ input([type(checkbox), name(sin), value(I)|Attr]),
                 span(Texto)
               ])),
    chips(Is, Sel).

% Lista desplegable con los productos del menú (nombres legibles)
opciones_select([], _) --> [].
opciones_select([V|Vs], Sel) -->
    { nombre_producto(V, Texto),
      (   V == Sel -> Attr = [selected(selected)] ; Attr = [] )
    },
    html(option([value(V)|Attr], Texto)),
    opciones_select(Vs, Sel).

% ------------------------------------------------------------
% Tarjeta 1: opcion_sin(P, Max, Excluidos)
% ------------------------------------------------------------
tarjeta_opciones(Sins, Max, Opciones) -->
    { titulo_opciones(Sins, Max, Titulo) },
    html(div(class('cq-card'),
             [ div(class('cq-head'), Titulo),
               div(class('cq-body'), \filas_opciones(Opciones))
             ])).

titulo_opciones([], Max, Titulo) :- !,
    format(atom(Titulo), 'Opciones hasta S/ ~w', [Max]).
titulo_opciones(Sins, Max, Titulo) :-
    lista_texto(Sins, Lista),
    format(atom(Titulo), 'Opciones sin ~w, hasta S/ ~w', [Lista, Max]).

filas_opciones([]) -->
    html(p(class('cq-vacio'),
           'Ninguna opción cumple con lo pedido (o está agotada).')).
filas_opciones(Opciones) -->
    { Opciones \== [] },
    filas_producto(Opciones).

filas_producto([]) --> [].
filas_producto([P-C-Pr|T]) -->
    { nombre_producto(P, Nombre),
      format(atom(PrecioTxt), 'S/ ~2f', [Pr])
    },
    html(div(class('cq-item'),
             [ div([span(class('cq-nombre'), Nombre), span(class('cq-tag'), C)]),
               span(class('cq-precio'), PrecioTxt)
             ])),
    filas_producto(T).

% ------------------------------------------------------------
% Tarjeta 2: combo(Bebida, Postre, Total) con 10% de descuento
% ------------------------------------------------------------
tarjeta_combo(_, _, none) -->
    html(div(class('cq-card'),
             [ div(class('cq-head'), 'Combo bebida + postre'),
               div(class('cq-body'), p(class('cq-vacio'), 'No se pudo armar el combo.'))
             ])).
tarjeta_combo(Beb, Pos, Total) -->
    { Total \== none,
      producto(Beb, _, P1), producto(Pos, _, P2),
      nombre_producto(Beb, NB), nombre_producto(Pos, NP),
      Sub is P1 + P2,
      format(atom(T1), 'S/ ~2f', [P1]),
      format(atom(T2), 'S/ ~2f', [P2]),
      format(atom(TS), 'S/ ~2f', [Sub]),
      format(atom(TT), 'S/ ~2f', [Total])
    },
    html(div(class('cq-card'),
             [ div(class('cq-head'), 'Combo bebida + postre'),
               div(class('cq-body'),
                   [ div(class('resumen-fila'), [span(NB), span(T1)]),
                     div(class('resumen-fila'), [span(NP), span(T2)]),
                     div(class('resumen-fila'), [span('Subtotal'), span(TS)]),
                     div(class('resumen-fila descuento'),
                          [span('Descuento 10%'), span('aplicado')]),
                     div(class('resumen-fila total'),
                          [span('Total del combo'), span(TT)])
                   ])
             ])).

% ------------------------------------------------------------
% Tarjeta 3: disponibilidad de TODO el menú según el stock y
% según los ingredientes que el cliente quiere evitar
% ------------------------------------------------------------
tarjeta_disponibilidad(Todos, Sins) -->
    html(div(class('cq-card'),
             [ div(class('cq-head'), 'Disponibilidad según stock'),
               div([class('cq-body cq-cols')], \filas_disponibilidad(Todos, Sins))
             ])).

filas_disponibilidad([], _) --> [].
filas_disponibilidad([P-C-_|T], Sins) -->
    { nombre_producto(P, Nombre),
      faltantes(P, Falt),
      excluidos(P, Sins, Exc),
      estados(Falt, Exc, Estados)
    },
    html(div(class('cq-item'),
             [ div([span(class('cq-nombre'), Nombre), span(class('cq-tag'), C)]),
               div(class('cq-estados'), Estados)
             ])),
    filas_disponibilidad(T, Sins).

% estados(+Agotados, +ExcluidosPresentes, -ListaDeSpans)
estados([], [], [span(class('cq-ok'), 'Disponible')]) :- !.
estados(Falt, Exc, Estados) :-
    (   Falt == []
    ->  E1 = []
    ;   E1 = [span(class('cq-no'), 'No disponible')]
    ),
    (   Exc == []
    ->  E2 = []
    ;   textos_ing(Exc, ET), atomic_list_concat(ET, ', ', EL),
        format(atom(M2), 'Contiene ~w', [EL]),
        E2 = [span(class('cq-warn'), M2)]
    ),
    append(E1, E2, Estados).

% ------------------------------------------------------------
% Utilidades de texto
% ------------------------------------------------------------
sin_guion(Atomo, Texto) :-
    atomic_list_concat(Partes, '_', Atomo),
    atomic_list_concat(Partes, ' ', Texto).

textos_ing(Atomos, Textos) :- maplist(sin_guion, Atomos, Textos).

lista_texto(Atomos, Texto) :-
    textos_ing(Atomos, Ts),
    unir_con_y(Ts, Texto).

unir_con_y([], '') :- !.
unir_con_y([X], X) :- !.
unir_con_y(Ts, Texto) :-
    append(Inicio, [Ultimo], Ts),
    atomic_list_concat(Inicio, ', ', Antes),
    atomic_list_concat([Antes, ' y ', Ultimo], Texto).
