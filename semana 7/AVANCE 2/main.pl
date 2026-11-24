:- encoding(utf8).
% ============================================================
%  PROYECTO: CaféExpress — Sistema de Pedidos
%  Curso   : Lenguaje de Programación
%  Archivo : main.pl  (punto de entrada de la aplicación web)
%
%  Ejecutar:   swipl main.pl
%  Abrir   :   http://localhost:8080
% ============================================================

% Rutas del proyecto (relativas a este archivo)
:- prolog_load_context(directory, Dir),
   atom_concat(Dir, '/src/main/prolog', Src),
   atom_concat(Dir, '/img', Img),
   asserta(user:file_search_path(cafe, Src)),
   asserta(user:file_search_path(img, Img)).

:- use_module(cafe(servidor)).

puerto(8080).

iniciar :-
    catch(set_stream(user_output, encoding(utf8)), _, true),
    puerto(P),
    iniciar_servidor(P).

:- initialization(iniciar).
