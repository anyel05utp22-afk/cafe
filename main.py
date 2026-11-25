# -*- coding: utf-8 -*-
"""
Lanzador raíz de conveniencia para CaféExpress en Python (Semanas 11 a 16).
Delega directamente a: cafe prolog copia/main.py

Uso:
  python main.py                -> Servidor web Python en http://localhost:8080
  python main.py --consola      -> Demostración completa en consola (Semanas 11-16)
  python main.py --interactivo  -> Consola interactiva con input()
"""

import os
import runpy
import sys

ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
TARGET_MAIN = os.path.join(ROOT_DIR, "cafe prolog copia", "main.py")

if __name__ == "__main__":
    sys.argv[0] = TARGET_MAIN
    runpy.run_path(TARGET_MAIN, run_name="__main__")
