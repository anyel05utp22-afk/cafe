# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 Archivo : cafe_express.py
 Curso   : Lenguajes de Programación (UTP)
 Propuesta Semanas 11 a 16 — Programación Multiparadigma en Python
 (versión de consola con todas las semanas 11 a 16 integradas)

 Ejecutar:
   python src/main/python/cafe_express.py              (demostración completa)
   python src/main/python/cafe_express.py --interactivo (incluye ingreso por input())
============================================================
"""

import sys

try:
    from .semana11_secuencial import semana11
    from .semana12_cadenas_condicionales import semana12
    from .semana13_bucles_listas import semana13
    from .semana14_colecciones_funciones import semana14
    from .semana15_poo_herencia import semana15
    from .semana16_ciencia_datos_numpy import semana16
except ImportError:
    from semana11_secuencial import semana11
    from semana12_cadenas_condicionales import semana12
    from semana13_bucles_listas import semana13
    from semana14_colecciones_funciones import semana14
    from semana15_poo_herencia import semana15
    from semana16_ciencia_datos_numpy import semana16


def ejecutar_consola(interactivo=False):
    if hasattr(sys.stdout, "reconfigure"):
        try:
            sys.stdout.reconfigure(encoding="utf-8")
        except Exception:
            pass

    print("╔══════════════════════════════════════════════════════════════╗")
    print("║            SISTEMA CaféExpress v3.0 (Python)                 ║")
    print("║  Programación Multiparadigma y Ciencia de Datos (Sem 11-16)  ║")
    print("╚══════════════════════════════════════════════════════════════╝")

    # Semana 11 — Características de Python e Instrucciones Secuenciales
    semana11(interactivo=interactivo)

    # Semana 12 — Cadenas de Texto e Instrucciones Condicionales
    semana12()

    # Semana 13 — Instrucciones Repetitivas (for/while) y Listas
    semana13()

    # Semana 14 — Listas, Tuplas, Diccionarios, Funciones y Módulos
    semana14()

    # Semana 15 — Clases, Objetos, Encapsulamiento, Herencia y Singleton
    semana15()

    # Semana 16 — Introducción a la Ciencia de Datos con NumPy
    semana16()

    print("\n✅ Todas las funcionalidades en Python (Semanas 11 a 16) ejecutadas correctamente.")


if __name__ == "__main__":
    modo_interactivo = "--interactivo" in sys.argv or "-i" in sys.argv
    ejecutar_consola(interactivo=modo_interactivo)
