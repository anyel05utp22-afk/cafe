# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 MÓDULO  : servidor_python.py
 Servidor HTTP en Python puro (http.server) que expone endpoints
 JSON reales para las Semanas 11 a 16 y sirve la interfaz web
 multiparadigma sin modificar ningún archivo previo de Prolog/Scala.
============================================================
"""

import json
import mimetypes
import os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse

try:
    from .catalogo_py import CATALOGO_PRODUCTOS, STOCK_INGREDIENTES
    from .semana11_secuencial import calcular_boleta_secuencial, obtener_ficha_tipos_datos
    from .semana12_cadenas_condicionales import (
        buscar_productos_por_frase,
        generar_codigo_y_etiqueta_cliente,
        recomendar_segun_hora,
        validar_cupon_promocional,
    )
    from .semana13_bucles_listas import (
        armar_pedido_con_while,
        contar_productos_por_categoria_for,
        simular_gestion_cola_barra,
    )
    from .semana14_colecciones_funciones import (
        actualizar_precio_producto,
        contar_producto_en_tupla,
        cotizar_delivery_modular,
        lista_tuplas_a_diccionario,
    )
    from .semana15_poo_herencia import simular_escenario_poo
    from .semana16_ciencia_datos_numpy import (
        analizar_ventas_estadisticas,
        benchmark_lista_vs_numpy,
        calcular_ingresos_algebra_lineal,
        explorar_slicing_matriz,
        limpiar_datos_faltantes_pos,
        simular_demanda_aleatoria,
    )
except ImportError:
    from catalogo_py import CATALOGO_PRODUCTOS, STOCK_INGREDIENTES
    from semana11_secuencial import calcular_boleta_secuencial, obtener_ficha_tipos_datos
    from semana12_cadenas_condicionales import (
        buscar_productos_por_frase,
        generar_codigo_y_etiqueta_cliente,
        recomendar_segun_hora,
        validar_cupon_promocional,
    )
    from semana13_bucles_listas import (
        armar_pedido_con_while,
        contar_productos_por_categoria_for,
        simular_gestion_cola_barra,
    )
    from semana14_colecciones_funciones import (
        actualizar_precio_producto,
        contar_producto_en_tupla,
        cotizar_delivery_modular,
        lista_tuplas_a_diccionario,
    )
    from semana15_poo_herencia import simular_escenario_poo
    from semana16_ciencia_datos_numpy import (
        analizar_ventas_estadisticas,
        benchmark_lista_vs_numpy,
        calcular_ingresos_algebra_lineal,
        explorar_slicing_matriz,
        limpiar_datos_faltantes_pos,
        simular_demanda_aleatoria,
    )


# Carpeta base del proyecto ("cafe prolog copia")
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
IMG_DIR = os.path.join(BASE_DIR, "img")
HTML_PYTHON = os.path.join(BASE_DIR, "cafe_express_python.html")
HTML_CLASICO = os.path.join(BASE_DIR, "index.html")


class CafeExpressPythonHandler(BaseHTTPRequestHandler):
    """Manejador HTTP con rutas estáticas y API JSON para Semanas 11 a 16."""

    def _enviar_json(self, datos, status=200):
        cuerpo = json.dumps(datos, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(cuerpo)))
        self.end_headers()
        self.wfile.write(cuerpo)

    def _enviar_archivo(self, ruta, content_type=None):
        if not os.path.isfile(ruta):
            self.send_error(404, "Archivo no encontrado")
            return
        with open(ruta, "rb") as f:
            contenido = f.read()
        if content_type is None:
            content_type, _ = mimetypes.guess_type(ruta)
            content_type = content_type or "application/octet-stream"
        self.send_response(200)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(contenido)))
        self.end_headers()
        self.wfile.write(contenido)

    def _leer_json_body(self):
        length = int(self.headers.get("Content-Length", 0))
        if length <= 0:
            return {}
        raw = self.rfile.read(length).decode("utf-8")
        try:
            return json.loads(raw)
        except json.JSONDecodeError:
            return {}

    def do_GET(self):
        parsed = urlparse(self.path)
        ruta = parsed.path

        if ruta in ("/", "/index.html", "/cafe_express_python.html"):
            self._enviar_archivo(HTML_PYTHON, "text/html; charset=utf-8")
        elif ruta == "/clasico":
            self._enviar_archivo(HTML_CLASICO, "text/html; charset=utf-8")
        elif ruta.startswith("/img/"):
            nombre = os.path.basename(ruta)
            self._enviar_archivo(os.path.join(IMG_DIR, nombre))
        elif ruta == "/api/catalogo":
            self._enviar_json({"catalogo": CATALOGO_PRODUCTOS, "stock": STOCK_INGREDIENTES})
        elif ruta == "/api/salud":
            self._enviar_json({"estado": "ok", "motor": "Python Multiparadigma (Semanas 11-16)"})
        else:
            self.send_error(404, "Ruta no encontrada")

    def do_POST(self):
        parsed = urlparse(self.path)
        ruta = parsed.path
        datos = self._leer_json_body()

        try:
            if ruta == "/api/semana11/boleta":
                boleta = calcular_boleta_secuencial(
                    cliente=datos.get("cliente", "María"),
                    producto=datos.get("producto", "Capuchino"),
                    precio_unitario=float(datos.get("precio_unitario", 12.0)),
                    cantidad=int(datos.get("cantidad", 3)),
                    es_cliente_frecuente=bool(datos.get("es_cliente_frecuente", True)),
                    racha_visitas=int(datos.get("racha_visitas", 2)),
                )
                self._enviar_json({"boleta": boleta, "tipos_datos": obtener_ficha_tipos_datos()})

            elif ruta == "/api/semana12/analizar":
                nombre = datos.get("nombre", "ana maría")
                producto = datos.get("producto", "Café Americano")
                hora = int(datos.get("hora", 15))
                cupon = datos.get("cupon", "CAFE2026")
                monto = float(datos.get("monto", 25.0))
                frase = datos.get("frase", "Quiero algo de chocolate o café frío")

                self._enviar_json(
                    {
                        "etiqueta": generar_codigo_y_etiqueta_cliente(nombre, producto),
                        "saludo_hora": recomendar_segun_hora(hora, nombre),
                        "cupon": validar_cupon_promocional(cupon, monto),
                        "busqueda": buscar_productos_por_frase(frase),
                    }
                )

            elif ruta == "/api/semana13/cola":
                cola_res = simular_gestion_cola_barra(
                    pedidos_iniciales=datos.get("pedidos_iniciales"),
                    nuevo_pedido=datos.get("nuevo_pedido", "Jugo de Naranja"),
                    pedido_cancelado=datos.get("pedido_cancelado", "Croissant"),
                    reemplazo_indice_1=datos.get("reemplazo_indice_1", "Café Frío"),
                )
                lote_while = armar_pedido_con_while(float(datos.get("presupuesto", 35.0)))
                categorias_for = contar_productos_por_categoria_for()
                self._enviar_json(
                    {
                        "gestion_cola": cola_res,
                        "lote_while": lote_while,
                        "categorias_for": categorias_for,
                    }
                )

            elif ruta == "/api/semana14/colecciones":
                producto_tupla = datos.get("producto_tupla", "Café Americano")
                producto_precio = datos.get("producto_precio", "Café Americano")
                nuevo_precio = float(datos.get("nuevo_precio", 8.5))
                cantidad_delivery = int(datos.get("cantidad", 2))
                lat = float(datos.get("lat", -12.0600))
                lon = float(datos.get("lon", -77.0350))

                self._enviar_json(
                    {
                        "tupla_conteo": contar_producto_en_tupla(producto_tupla),
                        "diccionario_actualizado": actualizar_precio_producto(producto_precio, nuevo_precio),
                        "lista_tuplas_a_dict": lista_tuplas_a_diccionario(),
                        "delivery_modular": cotizar_delivery_modular(producto_precio, cantidad_delivery, (lat, lon)),
                    }
                )

            elif ruta == "/api/semana15/poo":
                res = simular_escenario_poo(
                    nombre_cliente=datos.get("nombre_cliente", "Luis"),
                    edad_cliente=int(datos.get("edad_cliente", 22)),
                    saldo_inicial=float(datos.get("saldo_inicial", 50.0)),
                    recarga=float(datos.get("recarga", 20.0)),
                    tamano_bebida=datos.get("tamano_bebida", "grande"),
                    bebida_nombre=datos.get("bebida_nombre", "Capuchino"),
                    bebida_precio=float(datos.get("bebida_precio", 12.0)),
                    temperatura=datos.get("temperatura", "caliente"),
                    sin_lactosa=bool(datos.get("sin_lactosa", True)),
                    tipo_pan=datos.get("tipo_pan", "integral"),
                )
                self._enviar_json(res)

            elif ruta == "/api/semana16/numpy":
                descuento = float(datos.get("descuento_promo", 0.10))
                n_bench = int(datos.get("n_benchmark", 500_000))
                self._enviar_json(
                    {
                        "estadisticas": analizar_ventas_estadisticas(descuento_promo=descuento),
                        "algebra_lineal": calcular_ingresos_algebra_lineal(),
                        "datos_faltantes": limpiar_datos_faltantes_pos(),
                        "aleatorios": simular_demanda_aleatoria(),
                        "slicing": explorar_slicing_matriz(),
                        "benchmark": benchmark_lista_vs_numpy(n_elementos=n_bench),
                    }
                )
            else:
                self.send_error(404, "Endpoint API no encontrado")
        except Exception as exc:
            self._enviar_json({"error": str(exc)}, status=400)

    def log_message(self, format_str, *args):
        print(f"[CaféExpress Python] {self.address_string()} - {format_str % args}")


def iniciar_servidor_python(puerto=8080):
    servidor = ThreadingHTTPServer(("127.0.0.1", int(puerto)), CafeExpressPythonHandler)
    print(f"\n  CafeExpress Python en ejecucion: http://localhost:{puerto}")
    print(f"     - Interfaz Multiparadigma (Sem 11-16): http://localhost:{puerto}/")
    print(f"     - Interfaz Clasica Original intacta  : http://localhost:{puerto}/clasico")
    print("     (presiona Ctrl+C para detener el servidor)\n")
    try:
        servidor.serve_forever()
    except KeyboardInterrupt:
        print("\nServidor Python detenido correctamente.")
    finally:
        servidor.server_close()


if __name__ == "__main__":
    iniciar_servidor_python(8080)
