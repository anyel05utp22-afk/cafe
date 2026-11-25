# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 MÓDULO  : semana12_cadenas_condicionales.py
 TEMA    : SEMANA 12 — Cadenas de Texto e Instrucciones Condicionales

 Conceptos implementados (según temario Sesión 12):
   1. Cadenas de texto (str):
        - Concatenación (+)
        - Longitud con len()
        - Acceso por índice positivo [0], slicing [:3] y negativo [-1]
        - Inversión de cadena [::-1]
        - Operador 'in' para verificar subcadenas
        - Métodos: .upper(), .lower(), .replace(), .split(), .startswith(), .title()
        - Comparación de cadenas (==, !=)
   2. Instrucciones condicionales:
        - if / else (condicional simple)
        - if / elif / else (condicional múltiple)
============================================================
"""

try:
    from .catalogo_py import CATALOGO_PRODUCTOS
except ImportError:
    from catalogo_py import CATALOGO_PRODUCTOS


# ------------------------------------------------------------
# 1. Operaciones con Cadenas: Código de Pedido y Normalización
# ------------------------------------------------------------
def generar_codigo_y_etiqueta_cliente(nombre_cliente, producto_principal):
    """
    Aplica manipulación completa de cadenas vista en Sesión 12:
      - .title(): primera letra de cada palabra en mayúscula (Caso 4)
      - .upper() y .lower()
      - len(): longitud de la cadena
      - Indexación positiva [0], slicing [:3] (Caso 2) y negativa [-1]
      - Inversión [::-1] (Caso 3)
      - Concatenación (+) y .replace()
    """
    nombre_limpio = nombre_cliente.strip()
    if nombre_limpio == "":
        nombre_limpio = "Invitado"

    nombre_formateado = nombre_limpio.title()                  # Primera letra mayúscula
    producto_mayus = producto_principal.strip().upper()        # .upper()
    producto_minus = producto_principal.strip().lower()        # .lower()

    # Acceso a caracteres por índice positivo y negativo
    inicial = nombre_formateado[0]                             # Índice 0
    ultimo_caracter = nombre_formateado[-1]                    # Índice -1
    prefijo_3 = producto_mayus.replace(" ", "")[:3]            # Primeros 3 caracteres
    clave_invertida = prefijo_3[::-1]                          # Cadena invertida

    # Concatenación (+) y .replace()
    codigo_orden = "CE-" + prefijo_3 + "-" + inicial.upper() + ultimo_caracter.upper() + "-" + str(len(nombre_formateado))
    etiqueta_vaso = ("Pedido para " + nombre_formateado + ": " + producto_principal).replace("Café", "Café Artesanal")

    return {
        "nombre_formateado": nombre_formateado,
        "longitud_nombre": len(nombre_formateado),
        "inicial": inicial,
        "ultimo_caracter": ultimo_caracter,
        "prefijo_3_caracteres": prefijo_3,
        "prefijo_invertido": clave_invertida,
        "producto_mayusculas": producto_mayus,
        "producto_minusculas": producto_minus,
        "codigo_orden": codigo_orden,
        "etiqueta_vaso": etiqueta_vaso,
    }


# ------------------------------------------------------------
# 2. Condicional if / elif / else según la Hora del Día
# ------------------------------------------------------------
def recomendar_segun_hora(hora, nombre_cliente="Cliente"):
    """
    Inspirado directamente en el Ejemplo 2 de Sesión 12 (uso de if / elif / else):
    Saluda al cliente según la hora del día y recomienda un producto de CaféExpress.
    """
    hora_int = int(hora)
    nombre_titulo = nombre_cliente.strip().title() if nombre_cliente.strip() != "" else "Cliente"

    if hora_int < 0 or hora_int > 23:
        saludo = "Hora no válida"
        franja = "Fuera de rango (0-23)"
        recomendacion = "Ingresa una hora entre 0 y 23."
        producto_sugerido = None
    elif hora_int < 12:
        saludo = "Buenos días, " + nombre_titulo
        franja = "Mañana (Desayuno)"
        recomendacion = "Ideal para empezar con energía: Café Americano + Croissant."
        producto_sugerido = "Café Americano"
    elif hora_int < 18:
        saludo = "Buenas tardes, " + nombre_titulo
        franja = "Tarde (Merienda)"
        recomendacion = "Refresca tu tarde con un Café Frío y Cheesecake."
        producto_sugerido = "Café Frío"
    else:
        saludo = "Buenas noches, " + nombre_titulo
        franja = "Noche (Relajo)"
        recomendacion = "Cierra el día con un Chocolate Caliente y Galleta Artesanal."
        producto_sugerido = "Chocolate Caliente"

    return {
        "hora": hora_int,
        "saludo": saludo,
        "franja": franja,
        "producto_sugerido": producto_sugerido,
        "recomendacion": recomendacion,
    }


# ------------------------------------------------------------
# 3. Validación de Cupón con .startswith(), .upper() e if/elif/else
# ------------------------------------------------------------
def validar_cupon_promocional(codigo_cupon, monto_pedido):
    """
    Aplica .upper(), .startswith(), comparación de cadenas (==, !=)
    y condicionales if / elif / else para validar cupones en CaféExpress.
    """
    codigo = codigo_cupon.strip().upper()
    monto = float(monto_pedido)

    if codigo == "":
        valido = False
        descuento_pct = 0.0
        mensaje = "No se ingresó ningún cupón."
    elif codigo.startswith("CAFEVIP"):
        valido = True
        descuento_pct = 0.20
        mensaje = f"Cupón VIP '{codigo}' aceptado: 20% de descuento aplicado."
    elif codigo.startswith("CAFE"):
        valido = True
        descuento_pct = 0.10
        mensaje = f"Cupón '{codigo}' válido (comienza con 'CAFE'): 10% de descuento."
    elif codigo == "POSTRE5":
        valido = True
        descuento_pct = 0.05
        mensaje = "Cupón especial 'POSTRE5' aceptado: 5% de descuento."
    else:
        valido = False
        descuento_pct = 0.0
        mensaje = f"El cupón '{codigo}' no comienza con 'CAFE' ni corresponde a una promoción activa."

    ahorro = round(monto * descuento_pct, 2)
    total_final = round(monto - ahorro, 2)

    return {
        "codigo_normalizado": codigo,
        "empieza_con_cafe": codigo.startswith("CAFE"),
        "valido": valido,
        "porcentaje_descuento": int(descuento_pct * 100),
        "monto_original": round(monto, 2),
        "ahorro": ahorro,
        "total_final": total_final,
        "mensaje": mensaje,
    }


# ------------------------------------------------------------
# 4. Analizador de Búsqueda/Mensaje con .split(), .lower() y operador 'in'
# ------------------------------------------------------------
def buscar_productos_por_frase(frase_cliente):
    """
    Usa .lower(), .replace(), .split() y el operador 'in' (Caso 1 de práctica)
    para comprobar si alguna palabra de la frase del cliente está contenida
    en el nombre, descripción, categoría o ingredientes de los productos.
    """
    frase_limpia = (
        frase_cliente.lower()
        .replace("¿", "")
        .replace("?", "")
        .replace(",", "")
        .replace(".", "")
    )
    palabras = frase_limpia.split()

    # Clasificación rápida de intención con 'in' + if/elif/else
    if "sin leche" in frase_limpia or "veggie" in frase_limpia:
        etiqueta_intencion = "Preferencia alimentaria especial detectada"
    elif "frio" in frase_limpia or "frío" in frase_limpia or "jugo" in frase_limpia:
        etiqueta_intencion = "Cliente busca bebida refrescante"
    elif "chocolate" in frase_limpia or "postre" in frase_limpia or "torta" in frase_limpia:
        etiqueta_intencion = "Cliente interesado en postres o chocolate"
    else:
        etiqueta_intencion = "Búsqueda general en el catálogo"

    # Buscar coincidencias con operador 'in'
    coincidencias = []
    palabras_clave = [w for w in palabras if len(w) >= 3]
    for prod in CATALOGO_PRODUCTOS:
        texto_producto = (
            prod["nombre"]
            + " "
            + prod["categoria"]
            + " "
            + prod["desc"]
            + " "
            + " ".join(prod["ingredientes"])
        ).lower()
        # Normalización simple de tildes comunes para facilitar coincidencias
        texto_sin_tilde = (
            texto_producto.replace("é", "e")
            .replace("á", "a")
            .replace("í", "i")
            .replace("ó", "o")
            .replace("ú", "u")
        )
        for palabra in palabras_clave:
            p_norm = (
                palabra.replace("é", "e")
                .replace("á", "a")
                .replace("í", "i")
                .replace("ó", "o")
                .replace("ú", "u")
            )
            if p_norm in texto_sin_tilde:
                coincidencias.append(
                    {
                        "id": prod["id"],
                        "nombre": prod["nombre"],
                        "categoria": prod["categoria"],
                        "precio": prod["precio"],
                        "palabra_encontrada": palabra,
                    }
                )
                break

    return {
        "frase_original": frase_cliente,
        "palabras_split": palabras,
        "cantidad_palabras": len(palabras),
        "intencion": etiqueta_intencion,
        "coincidencias": coincidencias,
    }


# ------------------------------------------------------------
# 5. Demostración consolidada de Semana 12
# ------------------------------------------------------------
def semana12():
    print("\n── SEMANA 12: Cadenas de Texto e Instrucciones Condicionales ──")
    etiqueta = generar_codigo_y_etiqueta_cliente("ana maría lópez", "Café Americano")
    print(f"1. Cadenas (.title, .upper, len, [0], [-1], [:3], [::-1], .replace):")
    print(f"   Cliente formateado : {etiqueta['nombre_formateado']} (len={etiqueta['longitud_nombre']})")
    print(f"   Primeros 3 chars   : {etiqueta['prefijo_3_caracteres']} | Invertido: {etiqueta['prefijo_invertido']}")
    print(f"   Código generado    : {etiqueta['codigo_orden']}")
    print(f"   Etiqueta de vaso   : {etiqueta['etiqueta_vaso']}")

    saludo = recomendar_segun_hora(15, "ana maría")
    print(f"\n2. Condicional múltiple (if/elif/else por hora={saludo['hora']}):")
    print(f"   {saludo['saludo']} ({saludo['franja']}) -> {saludo['recomendacion']}")

    cupon = validar_cupon_promocional("cafe2026", 25.0)
    print(f"\n3. Validación de cupón (.startswith('CAFE')):")
    print(f"   {cupon['mensaje']} | Total final: S/ {cupon['total_final']:.2f}")

    busqueda = buscar_productos_por_frase("Quiero algo de chocolate o café frío")
    print(f"\n4. Búsqueda con .split() y operador 'in':")
    print(f"   Palabras: {busqueda['palabras_split']}")
    print(f"   Intención: {busqueda['intencion']}")
    nombres = [c["nombre"] for c in busqueda["coincidencias"]]
    print(f"   Coincidencias ({len(nombres)}): {nombres}")


if __name__ == "__main__":
    semana12()
