# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 Curso   : Lenguajes de Programación (UTP)
 Archivo : main.py (punto de entrada en Python, paralelo a main.pl)

 Formas de ejecución:
   python main.py                  -> Inicia servidor web en http://localhost:8000
   python main.py --consola        -> Ejecuta demostración en consola (Semanas 11-16)
   python main.py --interactivo    -> Consola interactiva con input() (Semanas 11-16)
   python main.py --puerto 8001    -> Inicia servidor web en otro puerto
============================================================
"""

import os
import sys

# Asegura que el paquete src/main/python sea importable desde cualquier directorio
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PYTHON_SRC = os.path.join(BASE_DIR, "src", "main", "python")
if PYTHON_SRC not in sys.path:
    sys.path.insert(0, PYTHON_SRC)

from cafe_express import ejecutar_consola
from servidor_python import iniciar_servidor_python


def main():
    args = sys.argv[1:]
    if "--consola" in args or "-c" in args:
        ejecutar_consola(interactivo=False)
        return
    if "--interactivo" in args or "-i" in args:
        ejecutar_consola(interactivo=True)
        return

    puerto = 8000
    if "--puerto" in args:
        idx = args.index("--puerto")
        if idx + 1 < len(args):
            puerto = int(args[idx + 1])

    iniciar_servidor_python(puerto)


if __name__ == "__main__":
    main()
