# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 MÓDULO  : semana16_ciencia_datos_numpy.py
 TEMA    : SEMANA 16 — Introducción a la Ciencia de Datos
           con la biblioteca NumPy

 Conceptos implementados (según temario Sesión 16):
   1. Arreglos multidimensionales (ndarray): vector 1D, matriz 2D, np.arange()
   2. Operaciones matemáticas vectorizadas: suma escalar, producto escalar,
      suma elemento a elemento entre arreglos (a + b)
   3. Estadística descriptiva: np.sum(), np.mean(), np.median(), np.std(),
      np.min(), np.max()
   4. Álgebra lineal: multiplicación de matrices / vector con np.dot()
   5. Manejo de datos faltantes: np.nan, máscara booleana np.isnan(),
      np.nanmean() y np.nan_to_num()
   6. Generación de datos aleatorios: np.random.rand() (matriz 3x3 y vector)
      y np.random.randint() con cálculo de desviación estándar
   7. Manipulación de datos: indexación matriz[fila, col] y slicing matriz[1:, 1:]
   8. Optimización y velocidad: benchmark real con time.time() comparando
      suma en lista nativa de Python vs arreglo NumPy (ndarray)
============================================================
"""

import time
import numpy as np


# Productos analizados y días de la semana para las matrices de ventas
PRODUCTOS_TOP = [
    "Café Americano",
    "Capuchino",
    "Café Frío",
    "Croissant",
    "Torta de Chocolate",
]
PRECIOS_TOP = np.array([8.0, 12.0, 14.0, 9.0, 15.0], dtype=float)
DIAS_SEMANA = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"]

# Matriz 2D (5 productos x 7 días): unidades vendidas en una semana típica
MATRIZ_VENTAS_SEMANALES = np.array(
    [
        [28, 32, 30, 35, 42, 55, 48],  # Café Americano
        [22, 25, 27, 30, 38, 50, 44],  # Capuchino
        [12, 15, 18, 20, 26, 34, 30],  # Café Frío
        [18, 20, 19, 22, 28, 36, 32],  # Croissant
        [10, 12, 14, 15, 22, 30, 26],  # Torta de Chocolate
    ],
    dtype=int,
)


# ------------------------------------------------------------
# 1. Arreglos 1D/2D + Operaciones Vectorizadas + Estadística
# ------------------------------------------------------------
def analizar_ventas_estadisticas(descuento_promo=0.10):
    """
    Aplica arreglos 1D/2D, operaciones vectorizadas (suma y producto escalar),
    y estadísticas con np.sum, np.mean, np.median, np.std, np.min, np.max.
    """
    # Operaciones vectorizadas sobre vector 1D de precios
    precios_con_descuento = np.round(PRECIOS_TOP * (1.0 - float(descuento_promo)), 2)
    precios_con_empaque = np.round(PRECIOS_TOP + 1.50, 2)  # Suma escalar

    # Suma de dos arreglos (turno mañana + turno tarde)
    ventas_manana = np.array([15, 14, 6, 12, 5])
    ventas_tarde = np.array([13, 11, 9, 8, 7])
    ventas_dia_total = ventas_manana + ventas_tarde  # Suma elemento a elemento

    # Estadísticas sobre la matriz 2D semanal
    unidades_por_producto = np.sum(MATRIZ_VENTAS_SEMANALES, axis=1)
    unidades_por_dia = np.sum(MATRIZ_VENTAS_SEMANALES, axis=0)

    media_diaria = float(np.mean(unidades_por_dia))
    mediana_diaria = float(np.median(unidades_por_dia))
    desviacion_std_diaria = float(np.std(unidades_por_dia))

    return {
        "productos": PRODUCTOS_TOP,
        "dias": DIAS_SEMANA,
        "precios_originales": PRECIOS_TOP.tolist(),
        "precios_con_descuento": precios_con_descuento.tolist(),
        "precios_con_empaque": precios_con_empaque.tolist(),
        "ventas_manana": ventas_manana.tolist(),
        "ventas_tarde": ventas_tarde.tolist(),
        "ventas_dia_suma_vectorial": ventas_dia_total.tolist(),
        "matriz_ventas_5x7": MATRIZ_VENTAS_SEMANALES.tolist(),
        "unidades_por_producto": unidades_por_producto.tolist(),
        "unidades_por_dia": unidades_por_dia.tolist(),
        "total_unidades_semana": int(np.sum(MATRIZ_VENTAS_SEMANALES)),
        "media_unidades_por_dia": round(media_diaria, 2),
        "mediana_unidades_por_dia": round(mediana_diaria, 2),
        "desviacion_estandar_diaria": round(desviacion_std_diaria, 2),
        "dia_menor_venta": DIAS_SEMANA[int(np.argmin(unidades_por_dia))],
        "dia_mayor_venta": DIAS_SEMANA[int(np.argmax(unidades_por_dia))],
    }


# ------------------------------------------------------------
# 2. Álgebra Lineal con np.dot() (Ingresos por Día y Matriz Costos)
# ------------------------------------------------------------
def calcular_ingresos_algebra_lineal():
    """
    Usa np.dot() (Sección 4.3 de Sesión 16):
      - Producto matriz-vector: np.dot(MATRIZ_VENTAS_SEMANALES.T, PRECIOS_TOP)
        obtiene los ingresos diarios en soles para cada día de la semana.
      - Producto matriz-matriz 2x2: np.dot(A, B) entre consumo de 2 turnos y
        costos de 2 proveedores.
    """
    ingresos_por_dia = np.dot(MATRIZ_VENTAS_SEMANALES.T, PRECIOS_TOP)
    ingresos_por_producto = np.sum(MATRIZ_VENTAS_SEMANALES, axis=1) * PRECIOS_TOP

    # Producto matricial A (2x2: turnos x insumos) . B (2x2: insumos x proveedores)
    matriz_consumo = np.array([[10, 20], [15, 25]])
    matriz_costos_prov = np.array([[5, 6], [7, 8]])
    matriz_costos_totales = np.dot(matriz_consumo, matriz_costos_prov)

    return {
        "dias": DIAS_SEMANA,
        "ingresos_diarios_soles": [round(float(x), 2) for x in ingresos_por_dia],
        "ingreso_total_semanal": round(float(np.sum(ingresos_por_dia)), 2),
        "ingresos_por_producto": {
            PRODUCTOS_TOP[i]: round(float(ingresos_por_producto[i]), 2)
            for i in range(len(PRODUCTOS_TOP))
        },
        "producto_matricial_2x2": {
            "A_consumo": matriz_consumo.tolist(),
            "B_costos_proveedor": matriz_costos_prov.tolist(),
            "resultado_np_dot": matriz_costos_totales.tolist(),
        },
    }


# ------------------------------------------------------------
# 3. Manejo de Datos Faltantes (np.nan, np.isnan, np.nanmean, np.nan_to_num)
# ------------------------------------------------------------
def limpiar_datos_faltantes_pos(lecturas=None):
    """
    Sección 4.4 de Sesión 16: identifica registros faltantes (NaN) usando
    máscara booleana np.isnan(), calcula la media ignorando NaN con np.nanmean()
    y reemplaza los faltantes con np.nan_to_num().
    """
    if lecturas is None:
        datos = np.array([185.0, 210.0, np.nan, 240.0, np.nan, 310.0, 275.0], dtype=float)
    else:
        datos = np.array([np.nan if v is None else float(v) for v in lecturas], dtype=float)

    mascara_nan = np.isnan(datos)
    cantidad_faltantes = int(np.sum(mascara_nan))
    media_valida = float(np.nanmean(datos)) if not np.all(mascara_nan) else 0.0
    datos_limpios = np.nan_to_num(datos, nan=media_valida)

    return {
        "datos_originales": [None if np.isnan(x) else round(float(x), 2) for x in datos],
        "mascara_faltantes_bool": mascara_nan.tolist(),
        "cantidad_nan_detectados": cantidad_faltantes,
        "media_sin_nan": round(media_valida, 2),
        "datos_imputados_sin_nan": [round(float(x), 2) for x in datos_limpios],
    }


# ------------------------------------------------------------
# 4. Generación de Datos Aleatorios (np.random.rand / randint)
# ------------------------------------------------------------
def simular_demanda_aleatoria(semilla=None):
    """
    Sección 4.5 + Casos 2 y 4 de Sesión 16:
      - Crea una matriz 3x3 con números aleatorios entre 0 y 1 (np.random.rand(3, 3))
      - Crea un arreglo de 10 ventas aleatorias entre 1 y 100 (np.random.randint)
        y calcula su media y desviación estándar (np.std).
    """
    rng = np.random.default_rng(semilla) if semilla is not None else np.random.default_rng()
    matriz_3x3 = np.round(rng.random((3, 3)), 4)
    muestra_10_ventas = rng.integers(1, 101, size=10)

    return {
        "matriz_3x3_aleatoria_0_a_1": matriz_3x3.tolist(),
        "arreglo_10_ventas_1_a_100": muestra_10_ventas.tolist(),
        "media_muestra": round(float(np.mean(muestra_10_ventas)), 2),
        "desviacion_estandar_muestra": round(float(np.std(muestra_10_ventas)), 4),
    }


# ------------------------------------------------------------
# 5. Manipulación de Datos: Indexación y Slicing de Matrices
# ------------------------------------------------------------
def explorar_slicing_matriz():
    """
    Sección 4.6 de Sesión 16:
      - Indexación directa matriz[0, 1] (primera fila, segunda columna)
      - Slicing matriz[1:, 1:] (submatriz desde la segunda fila y segunda columna)
      - Arreglo secuencial np.arange(1, 11) (Caso 1 de práctica)
    """
    elemento_0_1 = int(MATRIZ_VENTAS_SEMANALES[0, 1])  # Café Americano el Martes
    submatriz_fin_semana = MATRIZ_VENTAS_SEMANALES[1:, 4:]  # Productos 2..5, Vie-Sáb-Dom
    serie_1_al_10 = np.arange(1, 11)
    serie_escalada_x2 = serie_1_al_10 * 2

    return {
        "elemento_0_1_americano_martes": elemento_0_1,
        "etiqueta_slicing": "MATRIZ_VENTAS_SEMANALES[1:, 4:] (Capuchino..Torta en Vie-Sáb-Dom)",
        "productos_submatriz": PRODUCTOS_TOP[1:],
        "dias_submatriz": DIAS_SEMANA[4:],
        "submatriz": submatriz_fin_semana.tolist(),
        "arange_1_a_10": serie_1_al_10.tolist(),
        "arange_por_escalar_2": serie_escalada_x2.tolist(),
    }


# ------------------------------------------------------------
# 6. Optimización y Velocidad: Lista Python vs NumPy ndarray
# ------------------------------------------------------------
def benchmark_lista_vs_numpy(n_elementos=1_000_000):
    """
    Sección 4.7 de Sesión 16: mide con time.time() el tiempo que toma sumar
    un gran volumen de elementos con una lista tradicional de Python frente
    a un arreglo vectorizado de NumPy (np.arange + np.sum).
    """
    n = max(10_000, min(int(n_elementos), 10_000_000))

    # 1. Lista tradicional de Python
    lista_py = list(range(n))
    t0 = time.perf_counter()
    suma_lista = sum(lista_py)
    tiempo_lista = time.perf_counter() - t0

    # 2. Arreglo NumPy (dtype int64 para evitar desbordamiento en Windows)
    arreglo_np = np.arange(n, dtype=np.int64)
    t1 = time.perf_counter()
    suma_numpy = int(np.sum(arreglo_np))
    tiempo_numpy = time.perf_counter() - t1

    aceleracion = round(tiempo_lista / max(tiempo_numpy, 1e-9), 2)

    return {
        "n_elementos": n,
        "suma_lista_python": suma_lista,
        "tiempo_lista_seg": round(tiempo_lista, 6),
        "suma_arreglo_numpy": suma_numpy,
        "tiempo_numpy_seg": round(tiempo_numpy, 6),
        "factor_aceleracion_x": aceleracion,
        "resultados_iguales": suma_lista == suma_numpy,
    }


# ------------------------------------------------------------
# 7. Demostración consolidada de Semana 16
# ------------------------------------------------------------
def semana16():
    print("\n── SEMANA 16: Introducción a la Ciencia de Datos con NumPy ──")
    est = analizar_ventas_estadisticas()
    print(f"1. Estadística semanal (ndarray 5x7): Total={est['total_unidades_semana']} uds | "
          f"Media/día={est['media_unidades_por_dia']} | Mediana={est['mediana_unidades_por_dia']} | "
          f"Desv. Estándar={est['desviacion_estandar_diaria']}")
    print(f"   Día pico: {est['dia_mayor_venta']} | Día menor venta: {est['dia_menor_venta']}")

    alg = calcular_ingresos_algebra_lineal()
    print(f"2. Álgebra lineal (np.dot): Ingreso semanal total = S/ {alg['ingreso_total_semanal']:.2f}")
    print(f"   Ingresos diarios (Lun..Dom): {alg['ingresos_diarios_soles']}")

    nan_res = limpiar_datos_faltantes_pos()
    print(f"3. Datos faltantes (np.nan / np.nanmean / np.nan_to_num):")
    print(f"   Original : {nan_res['datos_originales']}")
    print(f"   Imputado : {nan_res['datos_imputados_sin_nan']} (media válida={nan_res['media_sin_nan']})")

    rnd = simular_demanda_aleatoria(semilla=42)
    print(f"4. Aleatorios (np.random): 10 ventas = {rnd['arreglo_10_ventas_1_a_100']} | "
          f"Desv. Estándar = {rnd['desviacion_estandar_muestra']}")

    slc = explorar_slicing_matriz()
    print(f"5. Indexación & Slicing: matriz[0, 1] = {slc['elemento_0_1_americano_martes']} uds | "
          f"Submatriz [1:, 4:] shape = {len(slc['submatriz'])}x{len(slc['submatriz'][0])}")

    bench = benchmark_lista_vs_numpy(1_000_000)
    print(f"6. Benchmark ({bench['n_elementos']:,} elementos): "
          f"Lista Python = {bench['tiempo_lista_seg']:.5f}s | "
          f"NumPy = {bench['tiempo_numpy_seg']:.5f}s -> NumPy es {bench['factor_aceleracion_x']}x más rápido")


if __name__ == "__main__":
    semana16()
