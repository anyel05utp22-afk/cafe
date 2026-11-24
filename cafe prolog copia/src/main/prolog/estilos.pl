:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Módulo  : estilos.pl
%  Hoja de estilos de la página expresada como HECHOS Prolog.
%  Cada regla CSS es un hecho regla(Selector, Declaraciones) y
%  el servidor la traduce a texto CSS al vuelo (/css/estilos.css).
%
%  Formas especiales:
%    regla(import(Url), [])               -> @import url(...)
%    regla(keyframes(Nombre), [Paso-Ds])  -> @keyframes
%    regla(media(Consulta), [Sel-Ds])     -> @media
% ============================================================

:- module(estilos, [servir_css/1, regla/2]).

% ------------------------------------------------------------
% Tipografía y paleta de colores
% ------------------------------------------------------------
regla(import('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap'), []).

regla(':root', [
    "--cafe: #3b1f0e", "--gold: #c8893a", "--cream: #fdf6ec", "--light: #fff9f2",
    "--text: #2d1a0e", "--gray: #8a7060", "--green: #2d7a4f",
    "--shadow: 0 4px 24px rgba(59,31,14,0.10)" ]).

regla('*', ["box-sizing: border-box", "margin: 0", "padding: 0"]).
regla('html', ["scroll-behavior: smooth"]).
regla('body', ["font-family: 'Poppins', sans-serif", "background: var(--cream)",
               "color: var(--text)", "min-height: 100vh"]).
regla('[id]', ["scroll-margin-top: 80px"]).

% ------------------------------------------------------------
% Barra de navegación
% ------------------------------------------------------------
regla('nav', [
    "background: var(--cafe)", "padding: 0 40px",
    "display: flex", "align-items: center", "justify-content: space-between",
    "height: 64px", "position: sticky", "top: 0", "z-index: 100",
    "box-shadow: 0 2px 12px rgba(0,0,0,0.3)" ]).
regla('.logo', ["display: flex", "align-items: center", "gap: 10px", "color: #fff",
                "font-size: 1.3rem", "font-weight: 700", "letter-spacing: 1px"]).
regla('.logo span', ["color: var(--gold)"]).
regla('.nav-links', ["display: flex", "gap: 28px", "list-style: none"]).
regla('.nav-links a', ["color: rgba(255,255,255,0.75)", "text-decoration: none",
                       "font-size: 0.88rem", "font-weight: 500", "transition: color 0.2s"]).
regla('.nav-links a:hover', ["color: var(--gold)"]).
regla('.cart-btn', [
    "background: var(--gold)", "color: #fff", "border: none", "border-radius: 50px",
    "padding: 8px 20px", "font-family: 'Poppins', sans-serif", "font-size: 0.88rem",
    "font-weight: 600", "cursor: pointer", "display: flex", "align-items: center",
    "gap: 8px", "transition: background 0.2s, transform 0.1s", "text-decoration: none" ]).
regla('.cart-btn:hover', ["background: #b07828", "transform: scale(1.03)"]).
regla('.cart-count', [
    "background: #fff", "color: var(--cafe)", "border-radius: 50%",
    "width: 20px", "height: 20px", "display: flex", "align-items: center",
    "justify-content: center", "font-size: 0.75rem", "font-weight: 700" ]).

% ------------------------------------------------------------
% Hero
% ------------------------------------------------------------
regla('.hero', [
    "background: linear-gradient(135deg, rgba(35, 17, 7, 0.88) 0%, rgba(61, 31, 13, 0.80) 100%), url('/img/hero_bg.jpg') center/cover no-repeat",
    "color: #fff", "padding: 75px 40px", "position: relative",
    "box-shadow: inset 0 0 80px rgba(0,0,0,0.3)" ]).
regla('.hero-text h1', ["font-size: 2.4rem", "font-weight: 700", "line-height: 1.2"]).
regla('.hero-text h1 span', ["color: var(--gold)"]).
regla('.hero-text p', ["color: rgba(255,255,255,0.7)", "margin-top: 10px",
                       "font-size: 1rem", "max-width: 500px"]).
regla('.hero-badge', [
    "background: var(--gold)", "color: #fff", "padding: 12px 28px",
    "border-radius: 50px", "font-weight: 600", "font-size: 0.95rem", "margin-top: 24px",
    "display: inline-block", "cursor: pointer", "text-decoration: none",
    "transition: background 0.2s" ]).
regla('.hero-badge:hover', ["background: #b07828"]).

% ------------------------------------------------------------
% Sección principal y menú
% ------------------------------------------------------------
regla('.main', ["display: flex", "gap: 0", "max-width: 1200px", "margin: 0 auto",
                "padding: 40px 20px", "align-items: flex-start"]).
regla('.menu-section', ["flex: 1"]).
regla('.section-title', ["font-size: 1.3rem", "font-weight: 700", "color: var(--cafe)",
                         "margin-bottom: 6px"]).
regla('.section-sub', ["font-size: 0.83rem", "color: var(--gray)", "margin-bottom: 20px"]).

regla('.filtros', ["display: flex", "gap: 10px", "margin-bottom: 28px", "flex-wrap: wrap"]).
regla('.filtro-btn', [
    "padding: 7px 20px", "border-radius: 50px", "border: 2px solid var(--gold)",
    "background: transparent", "color: var(--gold)", "font-family: 'Poppins', sans-serif",
    "font-size: 0.83rem", "font-weight: 600", "cursor: pointer", "transition: all 0.2s",
    "text-decoration: none", "display: inline-block" ]).
regla('.filtro-btn:hover, .filtro-btn.activo', ["background: var(--gold)", "color: #fff"]).

regla('.productos-grid', ["display: grid",
                          "grid-template-columns: repeat(auto-fill, minmax(190px, 1fr))",
                          "gap: 18px"]).
regla('.producto-card', [
    "background: #fff", "border-radius: 16px", "overflow: hidden",
    "box-shadow: var(--shadow)", "transition: transform 0.2s, box-shadow 0.2s",
    "cursor: pointer", "animation: fadeIn 0.35s ease both" ]).
regla('.productos-grid.quieto .producto-card', ["animation: none"]).
regla('.producto-card:hover', ["transform: translateY(-4px)",
                               "box-shadow: 0 8px 32px rgba(59,31,14,0.15)"]).
regla(keyframes(fadeIn), [
    from - ["opacity: 0", "transform: translateY(12px)"],
    to   - ["opacity: 1", "transform: translateY(0)"] ]).

regla('.producto-img-wrap', ["position: relative", "height: 140px", "overflow: hidden",
                             "border-radius: 16px 16px 0 0"]).
regla('.producto-img-wrap img', ["width: 100%", "height: 100%", "object-fit: cover",
                                 "transition: transform 0.35s ease", "display: block"]).
regla('.producto-card:hover .producto-img-wrap img', ["transform: scale(1.06)"]).
regla('.producto-cat-tag', [
    "position: absolute", "top: 8px", "right: 8px",
    "background: var(--cafe)", "color: var(--gold)",
    "font-size: 0.62rem", "font-weight: 700", "padding: 2px 8px",
    "border-radius: 20px", "text-transform: uppercase", "letter-spacing: 0.5px", "z-index: 1" ]).
regla('.producto-info', ["padding: 12px 14px 14px"]).
regla('.producto-nombre', ["font-size: 0.9rem", "font-weight: 600", "color: var(--text)",
                           "margin-bottom: 2px"]).
regla('.producto-desc', ["font-size: 0.72rem", "color: var(--gray)", "margin-bottom: 10px",
                         "line-height: 1.4"]).
regla('.producto-footer', ["display: flex", "align-items: center",
                           "justify-content: space-between"]).
regla('.producto-precio', ["font-size: 1rem", "font-weight: 700", "color: var(--gold)"]).
regla('.form-inline', ["display: inline-flex", "align-items: center"]).
regla('.add-btn', [
    "background: var(--cafe)", "color: #fff", "border: none", "border-radius: 50%",
    "width: 32px", "height: 32px", "font-size: 1.2rem", "cursor: pointer",
    "display: flex", "align-items: center", "justify-content: center",
    "transition: background 0.2s, transform 0.1s" ]).
regla('.add-btn:hover', ["background: var(--gold)", "transform: scale(1.1)"]).

% ------------------------------------------------------------
% Panel del carrito
% ------------------------------------------------------------
regla('.carrito-panel', ["width: 320px", "flex-shrink: 0", "margin-left: 32px",
                         "position: sticky", "top: 80px"]).
regla('.carrito-box', ["background: #fff", "border-radius: 20px", "box-shadow: var(--shadow)",
                       "overflow: hidden"]).
regla('.carrito-header', ["background: var(--cafe)", "color: #fff", "padding: 18px 22px",
                          "display: flex", "align-items: center", "gap: 10px"]).
regla('.carrito-header h3', ["font-size: 1rem", "font-weight: 600"]).
regla('.carrito-items', ["padding: 16px", "min-height: 160px", "max-height: 320px",
                         "overflow-y: auto"]).
regla('.carrito-vacio', ["display: flex", "flex-direction: column", "align-items: center",
                         "justify-content: center", "height: 140px", "color: var(--gray)",
                         "font-size: 0.85rem", "gap: 8px"]).
regla('.carrito-vacio span', ["font-size: 2.5rem"]).
regla('.item-row', ["display: flex", "align-items: center", "gap: 10px", "padding: 10px 0",
                    "border-bottom: 1px solid #f0e8de", "animation: slideIn 0.25s ease"]).
regla(keyframes(slideIn), [
    from - ["opacity: 0", "transform: translateX(12px)"],
    to   - ["opacity: 1", "transform: translateX(0)"] ]).
regla('.item-emoji', ["font-size: 1.6rem", "min-width: 36px", "text-align: center"]).
regla('.item-info', ["flex: 1"]).
regla('.item-nombre', ["font-size: 0.83rem", "font-weight: 600", "color: var(--text)"]).
regla('.item-precio', ["font-size: 0.78rem", "color: var(--gray)"]).
regla('.item-controles', ["display: flex", "align-items: center", "gap: 6px"]).
regla('.ctrl-btn', [
    "background: var(--cream)", "border: none", "border-radius: 6px",
    "width: 26px", "height: 26px", "font-size: 0.9rem", "cursor: pointer",
    "display: flex", "align-items: center", "justify-content: center",
    "font-weight: 700", "color: var(--cafe)", "transition: background 0.15s" ]).
regla('.ctrl-btn:hover', ["background: var(--gold)", "color: #fff"]).
regla('.item-cant', ["font-size: 0.88rem", "font-weight: 600", "min-width: 16px",
                     "text-align: center"]).
regla('.carrito-resumen', ["padding: 16px 22px", "border-top: 2px solid var(--cream)",
                           "background: var(--light)"]).
regla('.resumen-fila', ["display: flex", "justify-content: space-between",
                        "font-size: 0.85rem", "color: var(--gray)", "margin-bottom: 6px"]).
regla('.resumen-fila.descuento', ["color: var(--green)", "font-weight: 600"]).
regla('.resumen-fila.total', ["color: var(--text)", "font-size: 1.05rem", "font-weight: 700",
                              "margin-top: 10px", "padding-top: 10px",
                              "border-top: 1px solid #e8ddd4"]).
regla('.btn-descuento', [
    "width: 100%", "padding: 9px", "background: transparent", "border: 2px solid var(--green)",
    "color: var(--green)", "font-family: 'Poppins', sans-serif", "font-size: 0.83rem",
    "font-weight: 600", "border-radius: 10px", "cursor: pointer", "margin-top: 12px",
    "transition: all 0.2s" ]).
regla('.btn-descuento:hover:not(:disabled)', ["background: var(--green)", "color: #fff"]).
regla('.btn-descuento:disabled', ["opacity: 0.45", "cursor: default"]).
regla('.btn-pedir', [
    "width: 100%", "padding: 13px", "background: var(--gold)", "color: #fff", "border: none",
    "font-family: 'Poppins', sans-serif", "font-size: 0.95rem", "font-weight: 700",
    "border-radius: 12px", "cursor: pointer", "margin-top: 10px",
    "transition: background 0.2s, transform 0.1s" ]).
regla('.btn-pedir:hover:not(:disabled)', ["background: #b07828", "transform: scale(1.01)"]).
regla('.btn-pedir:disabled', ["opacity: 0.45", "cursor: default"]).

% ------------------------------------------------------------
% Notificación (toast) — aparece y se oculta sola con CSS
% ------------------------------------------------------------
regla('.toast', [
    "position: fixed", "bottom: 30px", "right: 30px", "background: var(--cafe)", "color: #fff",
    "padding: 12px 22px", "border-radius: 12px", "font-size: 0.88rem", "font-weight: 500",
    "box-shadow: 0 6px 24px rgba(0,0,0,0.25)", "transform: translateY(80px)", "opacity: 0",
    "transition: all 0.35s cubic-bezier(.4,0,.2,1)", "z-index: 999", "display: flex",
    "align-items: center", "gap: 8px", "pointer-events: none" ]).
regla('.toast.show', ["animation: toastCiclo 2.85s cubic-bezier(.4,0,.2,1) both"]).
regla(keyframes(toastCiclo), [
    '0%'   - ["transform: translateY(80px)", "opacity: 0"],
    '12%'  - ["transform: translateY(0)", "opacity: 1"],
    '88%'  - ["transform: translateY(0)", "opacity: 1"],
    '100%' - ["transform: translateY(80px)", "opacity: 0"] ]).

% ------------------------------------------------------------
% Modal de confirmación
% ------------------------------------------------------------
regla('.overlay', [
    "position: fixed", "inset: 0", "background: rgba(30,15,5,0.55)",
    "display: flex", "align-items: center", "justify-content: center",
    "z-index: 200", "opacity: 0", "pointer-events: none", "transition: opacity 0.3s" ]).
regla('.overlay.show', ["opacity: 1", "pointer-events: all", "animation: overlayIn 0.3s ease both"]).
regla('.overlay-cerrar', ["position: absolute", "inset: 0", "cursor: default"]).
regla('.modal', ["position: relative", "z-index: 1",
                 "background: #fff", "border-radius: 20px", "padding: 36px", "text-align: center",
                 "max-width: 380px", "width: 90%", "transform: scale(0.9)",
                 "transition: transform 0.3s"]).
regla('.overlay.show .modal', ["transform: scale(1)", "animation: modalIn 0.3s ease both"]).
regla(keyframes(overlayIn), [from - ["opacity: 0"], to - ["opacity: 1"]]).
regla(keyframes(modalIn), [from - ["transform: scale(0.9)"], to - ["transform: scale(1)"]]).
regla('.modal-icon', ["font-size: 3.5rem", "margin-bottom: 12px"]).
regla('.modal h2', ["font-size: 1.3rem", "color: var(--cafe)", "margin-bottom: 8px"]).
regla('.modal p', ["font-size: 0.88rem", "color: var(--gray)", "line-height: 1.6"]).
regla('.modal-btn', [
    "margin-top: 22px", "padding: 12px 36px", "background: var(--gold)", "color: #fff",
    "border: none", "border-radius: 50px", "font-family: 'Poppins', sans-serif",
    "font-size: 0.95rem", "font-weight: 700", "cursor: pointer", "transition: background 0.2s",
    "display: inline-block", "text-decoration: none" ]).
regla('.modal-btn:hover', ["background: #b07828"]).

% ------------------------------------------------------------
% Diseño responsive
% ------------------------------------------------------------
regla(media('(max-width: 768px)'), [
    '.main'          - ["flex-direction: column", "padding: 20px"],
    '.carrito-panel' - ["width: 100%", "margin-left: 0", "margin-top: 28px", "position: static"],
    '.hero'          - ["padding: 40px 20px"],
    '.hero-text h1'  - ["font-size: 1.8rem"] ]).

% ------------------------------------------------------------
% Semana 7 — página /consulta (prefijo cq- para no chocar con
% ningún estilo existente)
% ------------------------------------------------------------
regla('.cq-wrap', ["max-width: 1100px", "margin: 0 auto", "padding: 32px 40px",
                   "display: grid", "gap: 24px"]).
regla('.cq-grid', ["display: grid", "grid-template-columns: 1fr 1fr", "gap: 24px",
                   "align-items: start"]).
regla('.cq-card', ["background: #fff", "border-radius: 20px", "box-shadow: var(--shadow)",
                   "overflow: hidden"]).
regla('.cq-head', ["background: var(--cafe)", "color: #fff", "padding: 14px 22px",
                   "font-size: 1rem", "font-weight: 600"]).
regla('.cq-body', ["padding: 18px 22px"]).
regla('.cq-form', ["display: flex", "flex-direction: column", "gap: 18px"]).
regla('.cq-row', ["display: flex", "flex-wrap: wrap", "gap: 16px", "align-items: flex-end"]).
regla('.cq-chips-box', ["border: none", "padding: 0", "margin: 0"]).
regla('.cq-chips-box legend', ["font-size: 0.8rem", "font-weight: 600", "color: var(--gray)",
                               "margin-bottom: 10px", "padding: 0"]).
regla('.cq-chips', ["display: flex", "flex-wrap: wrap", "gap: 8px"]).
regla('.cq-chip', ["display: inline-flex", "align-items: center", "gap: 6px", "padding: 6px 14px",
                   "border: 2px solid #eadfd3", "border-radius: 50px", "font-size: 0.82rem",
                   "font-weight: 500", "color: var(--text)", "background: var(--light)",
                   "cursor: pointer", "transition: all 0.15s", "user-select: none"]).
regla('.cq-chip:hover', ["border-color: var(--gold)"]).
regla('.cq-chip:has(input:checked)', ["background: var(--cafe)", "border-color: var(--cafe)",
                                      "color: #fff"]).
regla('.cq-chip input', ["accent-color: var(--gold)", "cursor: pointer"]).
regla('.cq-field', ["display: flex", "flex-direction: column", "gap: 6px", "font-size: 0.8rem",
                    "font-weight: 600", "color: var(--gray)", "flex: 1", "min-width: 150px"]).
regla('.cq-field select', ["padding: 10px 12px", "border: 2px solid #eadfd3", "border-radius: 10px",
                           "font-family: 'Poppins', sans-serif", "font-size: 0.9rem",
                           "background: var(--light)", "color: var(--text)"]).
regla('.cq-field input', ["padding: 10px 12px", "border: 2px solid #eadfd3", "border-radius: 10px",
                          "font-family: 'Poppins', sans-serif", "font-size: 0.9rem",
                          "background: var(--light)", "color: var(--text)"]).
regla('.cq-btn', ["padding: 12px 28px", "background: var(--gold)", "color: #fff", "border: none",
                  "border-radius: 12px", "font-family: 'Poppins', sans-serif", "font-size: 0.95rem",
                  "font-weight: 700", "cursor: pointer", "transition: background 0.2s"]).
regla('.cq-btn:hover', ["background: #b07828"]).
regla('.cq-item', ["display: flex", "justify-content: space-between", "align-items: center",
                   "padding: 12px 0", "border-bottom: 1px solid #f0e8de"]).
regla('.cq-item:last-child', ["border-bottom: none"]).
regla('.cq-nombre', ["font-weight: 600", "font-size: 0.9rem"]).
regla('.cq-tag', ["font-size: 0.68rem", "text-transform: uppercase", "background: var(--cream)",
                  "color: var(--gray)", "padding: 2px 8px", "border-radius: 50px",
                  "margin-left: 8px", "font-weight: 600"]).
regla('.cq-precio', ["color: var(--gold)", "font-weight: 700"]).
regla('.cq-ok', ["color: var(--green)", "font-weight: 600", "font-size: 0.8rem"]).
regla('.cq-no', ["color: #b3361f", "font-weight: 600", "font-size: 0.8rem"]).
regla('.cq-warn', ["color: #a8671a", "font-weight: 600", "font-size: 0.8rem"]).
regla('.cq-estados', ["display: flex", "flex-direction: column", "align-items: flex-end", "gap: 2px"]).
regla('.cq-cols', ["display: grid", "grid-template-columns: 1fr 1fr", "column-gap: 40px"]).
regla('.cq-cols .cq-item:nth-last-child(-n+2)', ["border-bottom: none"]).
regla('.cq-vacio', ["color: var(--gray)", "font-size: 0.88rem"]).
regla(media('(max-width: 768px)'), [
    '.cq-wrap' - ["padding: 20px"],
    '.cq-grid' - ["grid-template-columns: 1fr"],
    '.cq-cols' - ["grid-template-columns: 1fr"] ]).

% ============================================================
% Generador de CSS: recorre los hechos regla/2 y los escribe
% ============================================================
servir_css(_Request) :-
    format('Content-type: text/css; charset=UTF-8~n~n'),
    forall(regla(Selector, Declaraciones),
           escribir_regla(Selector, Declaraciones)).

escribir_regla(import(Url), _) :- !,
    format("@import url('~w');~n~n", [Url]).
escribir_regla(keyframes(Nombre), Pasos) :- !,
    format('@keyframes ~w {~n', [Nombre]),
    forall(member(Paso-Ds, Pasos), escribir_bloque(Paso, Ds, '  ')),
    format('}~n~n').
escribir_regla(media(Consulta), Reglas) :- !,
    format('@media ~w {~n', [Consulta]),
    forall(member(Sel-Ds, Reglas), escribir_bloque(Sel, Ds, '  ')),
    format('}~n~n').
escribir_regla(Selector, Ds) :-
    escribir_bloque(Selector, Ds, ''),
    nl.

escribir_bloque(Selector, Ds, Sangria) :-
    format('~w~w {~n', [Sangria, Selector]),
    forall(member(D, Ds), format('~w  ~w;~n', [Sangria, D])),
    format('~w}~n', [Sangria]).
