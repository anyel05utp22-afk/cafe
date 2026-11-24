# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 MÓDULO  : semana14_colecciones_funciones.py
 TEMA    : SEMANA 14 — Listas, Tuplas, Diccionarios,
           Funciones y Módulos en Python

 Conceptos implementados (según temario Sesión 14):
   1. Listas (colecciones ordenadas y mutables)
   2. Tuplas (colecciones ordenadas e inmutables: coordenadas,
      horarios, categorías y conteo de ocurrencias con .count())
   3. Diccionarios (pares clave-valor: precios, actualización de
      precio por clave y conversión de lista de tuplas -> dict)
   4. Funciones definidas con def, parámetros y return
   5. Módulos:
        - Biblioteca estándar: import math, from math import ceil
        - Módulo propio: import utilidades_cafe y from utilidades_cafe import ...
============================================================
"""

import math
from math import ceil

try:
    from .catalogo_py import CATALOGO_PRODUCTOS
    from . import utilidades_cafe
    from .utilidades_cafe import (
        calcular_distancia_delivery_km,
        calcular_igv,
        formatear_soles,
        generar_codigo_boleta,
    )
except ImportError:
    from catalogo_py import CATALOGO_PRODUCTOS
    import utilidades_cafe
    from utilidades_cafe import (
        calcular_distancia_delivery_km,
        calcular_igv,
        formatear_soles,
        generar_codigo_boleta,
    )


# ------------------------------------------------------------
# 1. TUPLAS (Datos Inmutables que no deben cambiar)
# ------------------------------------------------------------
COORDENADAS_TIENDA = (-12.0464, -77.0428)         # (latitud, longitud) Lima
HORARIO_ATENCION = ("07:00", "22:00")             # (apertura, cierre)
CATEGORIAS_OFICIALES = ("bebida", "postre", "sandwich")

# Registro inmutable de ventas recientes (tupla con valores duplicados — Caso 2)
VENTAS_DEL_TURNO_TUPLA = (
    "Café Americano",
    "Capuchino",
    "Café Americano",
    "Croissant",
    "Capuchino",
    "Café Americano",
    "Galleta Artesanal",
    "Capuchino",
    "Cheesecake",
)


def contar_producto_en_tupla(nombre_producto="Café Americano", registro_tupla=VENTAS_DEL_TURNO_TUPLA):
    """
    Caso 2 de la Sesión 14: recibe una tupla inmutable con valores duplicados
    y muestra cuántas veces aparece un producto específico usando .count().
    """
    ocurrencias = registro_tupla.count(nombre_producto)
    return {
        "tipo_estructura": type(registro_tupla).__name__,
        "inmutable": True,
        "total_registros": len(registro_tupla),
        "producto_buscado": nombre_producto,
        "veces_vendido": ocurrencias,
        "tupla_registros": list(registro_tupla),
    }


# ------------------------------------------------------------
# 2. DICCIONARIOS (Pares Clave-Valor) + Actualización de Precios
# ------------------------------------------------------------
def construir_diccionario_precios():
    """Crea un diccionario {nombre_producto: precio} a partir del catálogo."""
    precios = {}
    for prod in CATALOGO_PRODUCTOS:
        precios[prod["nombre"]] = prod["precio"]
    return precios


def actualizar_precio_producto(nombre_producto, nuevo_precio, diccionario_precios=None):
    """
    Caso 3 de la Sesión 14: dado un diccionario con precios de productos,
    actualiza el precio de uno de los productos por su clave.
    """
    precios = dict(diccionario_precios) if diccionario_precios is not None else construir_diccionario_precios()
    existe = nombre_producto in precios
    precio_anterior = precios.get(nombre_producto)
    precios[nombre_producto] = round(float(nuevo_precio), 2)

    return {
        "producto": nombre_producto,
        "existia_en_catalogo": existe,
        "precio_anterior": precio_anterior,
        "precio_actualizado": precios[nombre_producto],
        "precio_formateado": formatear_soles(precios[nombre_producto]),
        "diccionario_precios": precios,
    }


# ------------------------------------------------------------
# 3. Conversión Lista de Tuplas -> Diccionario (Caso 4 de práctica)
# ------------------------------------------------------------
def lista_tuplas_a_diccionario(lista_tuplas=None):
    """
    Caso 4 de la Sesión 14: recibe una lista de tuplas (clave, valor)
    —por ejemplo (producto, unidades_vendidas) o (cliente, puntos)—
    y devuelve un diccionario con el primer elemento como clave y el segundo como valor.
    """
    if lista_tuplas is None:
        lista_tuplas = [
            ("Café Americano", 18),
            ("Capuchino", 24),
            ("Croissant", 15),
            ("Galleta Artesanal", 30),
            ("Jugo de Naranja", 12),
        ]

    resultado = {}
    for clave, valor in lista_tuplas:
        resultado[clave] = valor

    return {
        "entrada_lista_de_tuplas": [list(t) for t in lista_tuplas],
        "diccionario_resultante": resultado,
        "cantidad_claves": len(resultado),
    }


# ------------------------------------------------------------
# 4. Funciones + Uso de Módulos Estándar (math) y Propio (utilidades_cafe)
# ------------------------------------------------------------
def cotizar_delivery_modular(producto="Capuchino", cantidad=2, coord_cliente=(-12.0600, -77.0350)):
    """
    Integra funciones reutilizables, listas, tuplas, diccionarios y módulos:
      - Tupla inmutable COORDENADAS_TIENDA y HORARIO_ATENCION
      - Diccionario de precios del catálogo
      - Módulo estándar math (math.sqrt dentro de utilidades_cafe y ceil)
      - Módulo propio utilidades_cafe (import y from ... import ...)
    """
    precios = construir_diccionario_precios()
    precio_unit = precios.get(producto, 10.0)
    subtotal = round(precio_unit * int(cantidad), 2)
    igv = calcular_igv(subtotal)

    distancia_km = calcular_distancia_delivery_km(COORDENADAS_TIENDA, tuple(coord_cliente))
    tiempo_min = utilidades_cafe.calcular_tiempo_estimado_min(distancia_km)
    costo_envio = round(max(4.0, ceil(distancia_km) * 1.5), 2)
    total = round(subtotal + igv + costo_envio, 2)
    codigo = generar_codigo_boleta("CE-S14")

    return {
        "codigo_boleta": codigo,
        "producto": producto,
        "cantidad": int(cantidad),
        "coordenadas_tienda_tupla": list(COORDENADAS_TIENDA),
        "coordenadas_cliente_tupla": list(coord_cliente),
        "horario_fijo_tupla": list(HORARIO_ATENCION),
        "distancia_km": distancia_km,
        "tiempo_estimado_min": tiempo_min,
        "subtotal": subtotal,
        "igv": igv,
        "costo_envio": costo_envio,
        "total": total,
        "total_formateado": formatear_soles(total),
        "raiz_ejemplo_math": math.sqrt(16),
        "info_modulo_propio": utilidades_cafe.obtener_info_entorno_modulo(),
    }


# ------------------------------------------------------------
# 5. Demostración consolidada de Semana 14
# ------------------------------------------------------------
def semana14():
    print("\n── SEMANA 14: Listas, Tuplas, Diccionarios, Funciones y Módulos ──")

    # Tuplas e inmutabilidad
    conteo = contar_producto_en_tupla("Café Americano")
    print(f"1. Tuplas inmutables -> Ubicación: {COORDENADAS_TIENDA} | Horario: {HORARIO_ATENCION}")
    print(f"   Conteo en tupla de ventas: '{conteo['producto_buscado']}' aparece {conteo['veces_vendido']} veces.")

    # Diccionario y actualización
    act = actualizar_precio_producto("Café Americano", 8.5)
    print(
        f"2. Diccionario de precios -> '{act['producto']}': "
        f"S/ {act['precio_anterior']:.2f} -> {act['precio_formateado']}"
    )

    # Lista de tuplas -> Diccionario
    conv = lista_tuplas_a_diccionario()
    print(f"3. Lista de tuplas a Diccionario -> {conv['diccionario_resultante']}")

    # Funciones y Módulos (math + utilidades_cafe)
    cot = cotizar_delivery_modular("Capuchino", 2, (-12.0600, -77.0350))
    print(
        f"4. Módulos (math + utilidades_cafe.py) -> Boleta {cot['codigo_boleta']} | "
        f"Distancia: {cot['distancia_km']} km ({cot['tiempo_estimado_min']} min) | "
        f"Total con envío e IGV: {cot['total_formateado']}"
    )


if __name__ == "__main__":
    semana14()
