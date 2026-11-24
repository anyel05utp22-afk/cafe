:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Módulo  : servidor.pl
%  Servidor HTTP en SWI-Prolog: rutas, sesiones y acciones.
%  Patrón POST -> Redirect -> GET: cada acción calcula un
%  carrito NUEVO con logica.pl y lo guarda en la sesión.
% ============================================================

:- module(servidor, [iniciar_servidor/1, detener_servidor/1]).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_session)).
:- use_module(library(http/http_server_files)).
:- use_module(catalogo).
:- use_module(logica).
:- use_module(vista).
:- use_module(estilos).

% ------------------------------------------------------------
% Rutas
% ------------------------------------------------------------
:- http_handler(root(.),                pagina_principal, []).
:- http_handler(root(agregar),          accion_agregar,   [method(post)]).
:- http_handler(root(cantidad),         accion_cantidad,  [method(post)]).
:- http_handler(root(descuento),        accion_descuento, [method(post)]).
:- http_handler(root(confirmar),        accion_confirmar, [method(post)]).
:- http_handler(root(css/'estilos.css'), servir_css,      []).
:- http_handler(root(img),              serve_files_in_directory(img), [prefix]).

iniciar_servidor(Puerto) :-
    http_set_session_options([timeout(3600), cookie(cafeexpress_sesion)]),
    http_server(http_dispatch, [port(Puerto)]),
    format('~n  ☕ CaféExpress en ejecución: http://localhost:~w~n', [Puerto]),
    format('     (escribe  halt.  para detener el servidor)~n~n').

detener_servidor(Puerto) :-
    http_stop_server(Puerto, []).

% ------------------------------------------------------------
% Parámetros comunes
% ------------------------------------------------------------
param_categoria(Cat, cat(Cat, [oneof([todos, bebida, postre, sandwich]), default(todos)])).

% ------------------------------------------------------------
% GET /  — página principal
% ------------------------------------------------------------
pagina_principal(Request) :-
    param_categoria(Cat, PCat),
    http_parameters(Request, [PCat]),
    carrito_sesion(Carrito),
    descuento_sesion(Desc),
    tomar_flash(toast, Toast),
    tomar_flash(modal, Modal),
    tomar_flash(quieto, Q),
    ( Q == none -> Quieto = false ; Quieto = true ),
    pagina(estado(Cat, Carrito, Desc, Toast, Modal, Quieto)).

% ------------------------------------------------------------
% POST /agregar — agrega un producto al carrito
% ------------------------------------------------------------
accion_agregar(Request) :-
    param_categoria(Cat, PCat),
    http_parameters(Request, [id(Id, [integer]), PCat]),
    carrito_sesion(C0),
    (   agregar_al_carrito(Id, C0, C)
    ->  guardar_carrito(C),
        producto(Id, Nombre, _, _, _, _, _),
        format(atom(Msg), '~w agregado al pedido', [Nombre]),
        poner_flash(toast, Msg)
    ;   true
    ),
    poner_flash(quieto, true),
    format(atom(Url), '/?cat=~w#producto-~w', [Cat, Id]),
    http_redirect(see_other, Url, Request).

% ------------------------------------------------------------
% POST /cantidad — suma o resta una unidad
% ------------------------------------------------------------
accion_cantidad(Request) :-
    param_categoria(Cat, PCat),
    http_parameters(Request, [ id(Id, [integer]),
                               delta(Delta, [integer, between(-1, 1)]),
                               PCat ]),
    carrito_sesion(C0),
    cambiar_cantidad(Id, Delta, C0, C),
    guardar_carrito(C),
    poner_flash(quieto, true),
    format(atom(Url), '/?cat=~w#carrito-panel', [Cat]),
    http_redirect(see_other, Url, Request).

% ------------------------------------------------------------
% POST /descuento — Semana 2: aplica 10% a todo el carrito
% ------------------------------------------------------------
accion_descuento(Request) :-
    param_categoria(Cat, PCat),
    http_parameters(Request, [PCat]),
    carrito_sesion(C0),
    descuento_sesion(Desc),
    (   Desc == false, C0 \== []
    ->  descontar_carrito(C0, C),
        guardar_carrito(C),
        guardar_descuento(true),
        poner_flash(toast, 'Descuento del 10% aplicado!')
    ;   true
    ),
    poner_flash(quieto, true),
    format(atom(Url), '/?cat=~w#carrito-panel', [Cat]),
    http_redirect(see_other, Url, Request).

% ------------------------------------------------------------
% POST /confirmar — Semana 1: calcula el total y vacía el carrito
% ------------------------------------------------------------
accion_confirmar(Request) :-
    param_categoria(Cat, PCat),
    http_parameters(Request, [PCat]),
    carrito_sesion(C0),
    (   C0 \== []
    ->  calcular_total(C0, Total),
        resumen_pedido(C0, Texto),
        poner_flash(modal, pedido(Texto, Total)),
        guardar_carrito([])
    ;   true
    ),
    poner_flash(quieto, true),
    format(atom(Url), '/?cat=~w#menu', [Cat]),
    http_redirect(see_other, Url, Request).

% ------------------------------------------------------------
% Estado de la sesión (carrito, descuento y mensajes "flash")
% ------------------------------------------------------------
carrito_sesion(C) :-
    ( http_session_data(carrito(C0)) -> C = C0 ; C = [] ).

guardar_carrito(C) :-
    http_session_retractall(carrito(_)),
    http_session_assert(carrito(C)),
    ( C == [] -> guardar_descuento(false) ; true ).   % carrito vacío => sin descuento

descuento_sesion(D) :-
    ( http_session_data(descuento(D0)) -> D = D0 ; D = false ).

guardar_descuento(D) :-
    http_session_retractall(descuento(_)),
    http_session_assert(descuento(D)).

poner_flash(Clave, Valor) :-
    http_session_retractall(flash(Clave, _)),
    http_session_assert(flash(Clave, Valor)).

tomar_flash(Clave, Valor) :-
    (   http_session_data(flash(Clave, V0))
    ->  http_session_retractall(flash(Clave, _)),
        Valor = V0
    ;   Valor = none
    ).
