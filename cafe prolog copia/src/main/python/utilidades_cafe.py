# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 MÓDULO  : utilidades_cafe.py
 TEMA    : SEMANA 14 — Creación de Módulo Propio en Python
           (Sección 4.3: Crear tu propio módulo + uso de
           módulos estándar math, random y os)
============================================================
"""

import math
import os
import random
from math import sqrt


def calcular_igv(monto, tasa=0.18):
    """Calcula el IGV de un monto dado."""
    return round(float(monto) * float(tasa), 2)


def formatear_soles(monto):
    """Formatea un monto numérico como moneda peruana (S/)."""
    return f"S/ {float(monto):.2f}"


def calcular_distancia_delivery_km(coord_tienda, coord_cliente):
    """
    Usa el módulo estándar math (from math import sqrt) para estimar la
    distancia euclidiana aproximada en kilómetros entre dos coordenadas (lat, lon).
    """
    d_lat = (coord_cliente[0] - coord_tienda[0]) * 111.0
    d_lon = (coord_cliente[1] - coord_tienda[1]) * 111.0
    distancia = sqrt(d_lat ** 2 + d_lon ** 2)
    return round(distancia, 2)


def calcular_tiempo_estimado_min(distancia_km):
    """Usa math.ceil() para redondear hacia arriba los minutos de entrega."""
    return int(math.ceil(8 + float(distancia_km) * 4.5))


def generar_codigo_boleta(prefijo="CE"):
    """Usa el módulo estándar random para generar un código de boleta."""
    numero = random.randint(1000, 9999)
    return f"{prefijo}-{numero}"


def obtener_info_entorno_modulo():
    """Usa el módulo estándar os para inspeccionar el nombre del archivo/carpeta."""
    return {
        "archivo_modulo": os.path.basename(__file__),
        "sistema_operativo": os.name,
    }
