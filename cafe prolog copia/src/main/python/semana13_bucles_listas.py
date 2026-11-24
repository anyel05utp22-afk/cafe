# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 MÓDULO  : semana13_bucles_listas.py
 TEMA    : SEMANA 13 — Instrucciones Repetitivas y Arreglos (Listas)

 Conceptos implementados (según temario Sesión 13):
   1. Instrucciones repetitivas:
        - Bucle for (recorrer listas y secuencias)
        - Bucle while (recorrer con índice y condición de parada)
   2. Arreglos (Listas en Python):
        - Creación de listas []
        - Acceso a elementos por índice (primero [0], último [-1])
        - Modificación de elementos por índice (lista[i] = valor)
        - Añadir elementos al final con .append()
        - Eliminar elementos específicos con .remove() y palabra clave del
        - Combinación de listas y bucles para gestión de cola de barra
============================================================
"""

try:
    from .catalogo_py import CATALOGO_PRODUCTOS
except ImportError:
    from catalogo_py import CATALOGO_PRODUCTOS


# ------------------------------------------------------------
# 1. Gestión de Cola de Preparación en Barra (Operaciones con Listas)
# ------------------------------------------------------------
def simular_gestion_cola_barra(
    pedidos_iniciales=None,
    nuevo_pedido="Jugo de Naranja",
    pedido_cancelado="Croissant",
    reemplazo_indice_1="Café Frío",
):
    """
    Demuestra todas las operaciones con arreglos (listas) de la Sesión 13
    sobre la cola de pedidos en barra de CaféExpress:
      - Creación de lista
      - Acceso al primer [0] y último [-1] elemento (Caso 3)
      - Modificación por índice (lista[1] = ...)
      - Adición al final con .append() (Caso 2)
      - Eliminación específica con .remove() (Caso 1)
      - Eliminación por índice con del
      - Recorrido con bucle for (Caso 4) y bucle while (Pregunta 2)
    """
    # 1. Creación de la lista (mutable)
    if pedidos_iniciales is None:
        cola = ["Café Americano", "Capuchino", "Croissant", "Torta de Chocolate"]
    else:
        cola = list(pedidos_iniciales)

    historial_pasos = []
    historial_pasos.append({"paso": "1. Lista inicial creada", "cola": list(cola)})

    # 2. Acceso al primer y último elemento
    primero = cola[0] if len(cola) > 0 else None
    ultimo = cola[-1] if len(cola) > 0 else None

    # 3. Añadir elemento al final con .append()
    if nuevo_pedido and nuevo_pedido.strip():
        cola.append(nuevo_pedido.strip())
        historial_pasos.append(
            {"paso": f"2. .append('{nuevo_pedido.strip()}')", "cola": list(cola)}
        )

    # 4. Modificación de lista por índice (lista[1] = ...)
    if len(cola) > 1 and reemplazo_indice_1 and reemplazo_indice_1.strip():
        anterior = cola[1]
        cola[1] = reemplazo_indice_1.strip()
        historial_pasos.append(
            {
                "paso": f"3. Modificación por índice cola[1]: '{anterior}' -> '{cola[1]}'",
                "cola": list(cola),
            }
        )

    # 5. Eliminar un elemento específico con .remove()
    eliminado_remove = False
    if pedido_cancelado and pedido_cancelado in cola:
        cola.remove(pedido_cancelado)
        eliminado_remove = True
        historial_pasos.append(
            {"paso": f"4. .remove('{pedido_cancelado}')", "cola": list(cola)}
        )
    else:
        historial_pasos.append(
            {
                "paso": f"4. .remove('{pedido_cancelado}') omitido (no presente en cola)",
                "cola": list(cola),
            }
        )

    # 6. Despachar el primer pedido usando la palabra clave del
    despachado_del = None
    if len(cola) > 0:
        despachado_del = cola[0]
        del cola[0]
        historial_pasos.append(
            {"paso": f"5. del cola[0] (despachado '{despachado_del}')", "cola": list(cola)}
        )

    # 7. Recorrer la lista restante usando bucle FOR
    recorrido_for = []
    for pedido in cola:
        recorrido_for.append(f"Preparando: {pedido}")

    # 8. Recorrer la lista restante usando bucle WHILE con índice (Pregunta 2 de la clase)
    recorrido_while = []
    indice = 0
    while indice < len(cola):
        recorrido_while.append(f"Turno #{indice + 1} (posición {indice}): {cola[indice]}")
        indice += 1

    return {
        "primer_elemento_inicial": primero,
        "ultimo_elemento_inicial": ultimo,
        "eliminado_con_remove": eliminado_remove,
        "despachado_con_del": despachado_del,
        "cola_final": cola,
        "recorrido_for": recorrido_for,
        "recorrido_while": recorrido_while,
        "historial_pasos": historial_pasos,
    }


# ------------------------------------------------------------
# 2. Lote de Compras con Bucle WHILE (hasta agotar presupuesto)
# ------------------------------------------------------------
def armar_pedido_con_while(presupuesto_maximo=35.0):
    """
    Usa un bucle while (cuando no sabemos de antemano cuántas iteraciones
    serán necesarias) para ir añadiendo productos del catálogo con .append()
    mientras alcance el presupuesto del cliente.
    """
    presupuesto = float(presupuesto_maximo)
    seleccionados = []
    gasto_acumulado = 0.0
    indice = 0

    while indice < len(CATALOGO_PRODUCTOS):
        prod = CATALOGO_PRODUCTOS[indice]
        if gasto_acumulado + prod["precio"] <= presupuesto:
            seleccionados.append(
                {"nombre": prod["nombre"], "precio": prod["precio"], "categoria": prod["categoria"]}
            )
            gasto_acumulado += prod["precio"]
        indice += 1

    return {
        "presupuesto_maximo": round(presupuesto, 2),
        "cantidad_productos": len(seleccionados),
        "gasto_total": round(gasto_acumulado, 2),
        "vuelto_restante": round(presupuesto - gasto_acumulado, 2),
        "productos": seleccionados,
    }


# ------------------------------------------------------------
# 3. Conteo por Categoría con Bucle FOR
# ------------------------------------------------------------
def contar_productos_por_categoria_for():
    """
    Recorre el catálogo con un bucle for para agrupar productos por categoría
    y calcular el precio promedio de cada una usando listas.
    """
    bebidas = []
    postres = []
    sandwiches = []

    for prod in CATALOGO_PRODUCTOS:
        if prod["categoria"] == "bebida":
            bebidas.append(prod["nombre"])
        elif prod["categoria"] == "postre":
            postres.append(prod["nombre"])
        else:
            sandwiches.append(prod["nombre"])

    return {
        "bebida": {"cantidad": len(bebidas), "productos": bebidas},
        "postre": {"cantidad": len(postres), "productos": postres},
        "sandwich": {"cantidad": len(sandwiches), "productos": sandwiches},
    }


# ------------------------------------------------------------
# 4. Demostración consolidada de Semana 13
# ------------------------------------------------------------
def semana13():
    print("\n── SEMANA 13: Instrucciones Repetitivas (for/while) y Arreglos (Listas) ──")
    res = simular_gestion_cola_barra()
    print(f"1. Acceso por índice -> Primero [0]: {res['primer_elemento_inicial']} | Último [-1]: {res['ultimo_elemento_inicial']}")
    for paso in res["historial_pasos"]:
        print(f"   • {paso['paso']}: {paso['cola']}")

    print("\n2. Recorrido con bucle FOR:")
    for linea in res["recorrido_for"]:
        print(f"   - {linea}")

    print("\n3. Recorrido con bucle WHILE (por índice):")
    for linea in res["recorrido_while"]:
        print(f"   - {linea}")

    lote = armar_pedido_con_while(35.0)
    print(f"\n4. Armado automático con bucle WHILE (presupuesto S/ {lote['presupuesto_maximo']:.2f}):")
    print(
        f"   {lote['cantidad_productos']} productos seleccionados | "
        f"Gasto: S/ {lote['gasto_total']:.2f} | Restante: S/ {lote['vuelto_restante']:.2f}"
    )


if __name__ == "__main__":
    semana13()
