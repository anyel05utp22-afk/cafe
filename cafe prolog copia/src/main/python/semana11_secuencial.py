# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 MÓDULO  : semana11_secuencial.py
 TEMA    : SEMANA 11 — Características del Lenguaje (Python)
           e Instrucciones de Control Secuenciales

 Conceptos implementados (según temario Sesión 11):
   1. Tipos de datos en Python: int, float, str, bool, list, tuple, dict
   2. Variables de tipado dinámico
   3. Operadores:
        - Aritméticos: +, -, *, /, //, %, **
        - Relacionales: ==, !=, <, >, <=, >=
        - Lógicos: and, or, not
        - Asignación: =, +=, -=, *=, /=
   4. Función print(), concatenación de cadenas y f-strings
   5. Ingreso de datos por teclado con input() y conversión int()/float()
   6. Instrucciones de control secuenciales (ejecución lineal paso a paso)
============================================================
"""


# ------------------------------------------------------------
# 1. Demostración de Tipos de Datos de Python en CaféExpress
# ------------------------------------------------------------
def obtener_ficha_tipos_datos():
    """
    Muestra los 7 tipos de datos fundamentales de Python aplicados
    al dominio de CaféExpress.
    """
    numero_orden = 101                                       # int (entero)
    precio_capuchino = 12.0                                  # float (flotante)
    nombre_tienda = "CaféExpress"                            # str (cadena de texto)
    tienda_abierta = True                                    # bool (booleano)
    productos_populares = ["Café Americano", "Capuchino", "Croissant"]  # list (lista)
    horario_fijo = ("07:00", "22:00")                        # tuple (tupla)
    cliente_ejemplo = {"nombre": "Juan", "edad": 25}         # dict (diccionario)

    return {
        "int": {"variable": "numero_orden", "valor": numero_orden, "tipo": type(numero_orden).__name__},
        "float": {"variable": "precio_capuchino", "valor": precio_capuchino, "tipo": type(precio_capuchino).__name__},
        "str": {"variable": "nombre_tienda", "valor": nombre_tienda, "tipo": type(nombre_tienda).__name__},
        "bool": {"variable": "tienda_abierta", "valor": tienda_abierta, "tipo": type(tienda_abierta).__name__},
        "list": {"variable": "productos_populares", "valor": productos_populares, "tipo": type(productos_populares).__name__},
        "tuple": {"variable": "horario_fijo", "valor": list(horario_fijo), "tipo": type(horario_fijo).__name__},
        "dict": {"variable": "cliente_ejemplo", "valor": cliente_ejemplo, "tipo": type(cliente_ejemplo).__name__},
    }


# ------------------------------------------------------------
# 2. Instrucciones Secuenciales + Todos los Operadores
# ------------------------------------------------------------
def calcular_boleta_secuencial(
    cliente="Juan",
    producto="Capuchino",
    precio_unitario=12.0,
    cantidad=3,
    es_cliente_frecuente=True,
    racha_visitas=2,
):
    """
    Ejecuta un flujo estrictamente SECUENCIAL (una instrucción tras otra
    de manera lineal) para calcular la boleta de un pedido en CaféExpress,
    aplicando operadores aritméticos (+, -, *, /, //, %, **),
    relacionales (==, !=, <, >, <=, >=), lógicos (and, or, not)
    y de asignación (=, +=, -=, *=, /=).
    """
    # Paso 1: Cálculo secuencial del subtotal con operador aritmético (*)
    subtotal = float(precio_unitario) * int(cantidad)

    # Paso 2: Reglas con operadores relacionales y lógicos (and, or, not)
    califica_promo_cantidad = cantidad >= 2 and subtotal > 15.0
    es_pedido_valido = (cantidad > 0) and (precio_unitario != 0) and (not (cliente == ""))
    aplica_descuento = es_cliente_frecuente or califica_promo_cantidad

    # Paso 3: Cálculo de descuento usando operadores de asignación (*=, -=, +=, /=)
    porcentaje_descuento = 0.10 * int(aplica_descuento)  # 0.10 si True, 0.0 si False
    monto_descuento = subtotal
    monto_descuento *= porcentaje_descuento              # Operador *=

    base_imponible = subtotal
    base_imponible -= monto_descuento                    # Operador -=

    # Paso 4: Cálculo de IGV (18%) y total a pagar secuencialmente
    igv = base_imponible * 0.18
    total_pagar = base_imponible
    total_pagar += igv                                   # Operador +=

    # Paso 5: Operadores de división (/), división entera (//), módulo (%) y exponente (**)
    costo_promedio_unidad = total_pagar
    costo_promedio_unidad /= max(int(cantidad), 1)       # Operador /=

    # Puntos de fidelidad: 1 punto por cada S/ 5 completos (//) y residuo (%)
    puntos_base = int(total_pagar // 5)                  # División entera (//)
    sobrante_para_punto = round(total_pagar % 5, 2)      # Módulo (%)

    # Bono exponencial por racha de visitas: 2 ** racha (**)
    racha_segura = max(0, min(int(racha_visitas), 5))
    bono_racha = 2 ** racha_segura                       # Exponente (**)
    puntos_totales = puntos_base + bono_racha            # Suma (+)

    # Empaques de 2 unidades: cuántos pares completos (//) y sueltos (%)
    pares_empaque = int(cantidad) // 2
    unidades_sueltas = int(cantidad) % 2

    # Paso 6: Construcción de mensaje con concatenación (+) y f-string
    saludo_concatenado = "Hola, " + str(cliente)
    resumen_fstring = (
        f"{saludo_concatenado}: {cantidad}x {producto} -> "
        f"Total S/ {total_pagar:.2f} (ganas {puntos_totales} pts)"
    )

    return {
        "cliente": cliente,
        "producto": producto,
        "precio_unitario": round(float(precio_unitario), 2),
        "cantidad": int(cantidad),
        "es_pedido_valido": es_pedido_valido,
        "califica_promo_cantidad": califica_promo_cantidad,
        "aplica_descuento": aplica_descuento,
        "subtotal": round(subtotal, 2),
        "monto_descuento": round(monto_descuento, 2),
        "base_imponible": round(base_imponible, 2),
        "igv": round(igv, 2),
        "total_pagar": round(total_pagar, 2),
        "costo_promedio_unidad": round(costo_promedio_unidad, 2),
        "puntos_base_div_entera": puntos_base,
        "sobrante_modulo": sobrante_para_punto,
        "bono_racha_exponente": bono_racha,
        "puntos_totales": puntos_totales,
        "pares_empaque": pares_empaque,
        "unidades_sueltas": unidades_sueltas,
        "mensaje": resumen_fstring,
    }


# ------------------------------------------------------------
# 3. Ingreso de Datos por Teclado con input() (Modo Consola)
# ------------------------------------------------------------
def tomar_pedido_rapido_consola():
    """
    Lee datos ingresados por el usuario desde el teclado usando input()
    con conversión explícita a int() y float(), y muestra la boleta con print().
    """
    print("\n--- Registro Rápido de Pedido por Teclado (input) ---")
    nombre = input("¿Cuál es tu nombre? ")
    producto = input("¿Qué producto deseas (ej. Capuchino)? ")
    precio = float(input("Ingresa el precio unitario en S/ (ej. 12.0): "))
    cantidad = int(input("¿Cuántas unidades deseas? "))
    racha = int(input("¿Cuántas visitas seguidas llevas esta semana (0-5)? "))

    boleta = calcular_boleta_secuencial(
        cliente=nombre,
        producto=producto,
        precio_unitario=precio,
        cantidad=cantidad,
        es_cliente_frecuente=True,
        racha_visitas=racha,
    )

    print("\n" + boleta["mensaje"])
    print(f"  Subtotal      : S/ {boleta['subtotal']:.2f}")
    print(f"  Descuento 10% : -S/ {boleta['monto_descuento']:.2f}")
    print(f"  IGV (18%)     : S/ {boleta['igv']:.2f}")
    print(f"  Total a pagar : S/ {boleta['total_pagar']:.2f}")
    print(f"  Puntos totales: {boleta['puntos_totales']} pts (base {boleta['puntos_base_div_entera']} + bono {boleta['bono_racha_exponente']})")
    return boleta


# ------------------------------------------------------------
# 4. Demostración consolidada de Semana 11
# ------------------------------------------------------------
def semana11(interactivo=False):
    print("\n── SEMANA 11: Características de Python e Instrucciones Secuenciales ──")
    tipos = obtener_ficha_tipos_datos()
    print("1. Tipos de datos en CaféExpress:")
    for clave, info in tipos.items():
        print(f"   • {clave:<5} -> {info['variable']} = {info['valor']}  (type: {info['tipo']})")

    if interactivo:
        tomar_pedido_rapido_consola()
    else:
        print("\n2. Flujo secuencial de cálculo de boleta (operadores +, -, *, /, //, %, **, and/or/not):")
        boleta = calcular_boleta_secuencial(
            cliente="María",
            producto="Capuchino",
            precio_unitario=12.0,
            cantidad=3,
            es_cliente_frecuente=True,
            racha_visitas=2,
        )
        print("   " + boleta["mensaje"])
        print(
            f"   Subtotal: S/ {boleta['subtotal']:.2f} | Desc: -S/ {boleta['monto_descuento']:.2f} | "
            f"IGV: S/ {boleta['igv']:.2f} | Total: S/ {boleta['total_pagar']:.2f}"
        )
        print(
            f"   Operadores //, %, ** -> Puntos base (//5): {boleta['puntos_base_div_entera']}, "
            f"Residuo (%5): S/ {boleta['sobrante_modulo']:.2f}, "
            f"Bono racha (2**2): {boleta['bono_racha_exponente']} pts"
        )
        print(
            f"   Empaques de 2 uds -> Pares completos: {boleta['pares_empaque']}, "
            f"Unidades sueltas: {boleta['unidades_sueltas']}"
        )


if __name__ == "__main__":
    semana11(interactivo=False)
