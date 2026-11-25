# CaféExpress — Proyecto Integrado Multiparadigma (Scala, Prolog y Python)

Este proyecto unifica la base de **CaféExpress** con los aportes académicos completos de las **Semanas 1–3 (Scala)**, **Semanas 6–9 (Prolog)** y **Semanas 11–16 (Python + NumPy)**, conservando intactas todas las funcionalidades originales y su diseño.

---

## 🛒 1. Nuevas Opciones Visibles en la Página Web (`http://localhost:8080/`)

Al iniciar `python main.py`, la página principal ([`cafe_express_python.html`](cafe_express_python.html)) mantiene intactas todas las opciones previas (Menú, Carrito, Recomendados, Alérgenos y Combos) e incorpora **6 nuevas opciones interactivas** impulsadas por Python:

1. **🧾 Boleta, IGV y Puntos de Fidelidad (`#boleta-fidelidad`)** — Semana 11 (`semana11_secuencial.py`).
2. **🔎 Buscador Inteligente del Menú, Banner por Hora, Cupones en el Carrito y Etiqueta de Vaso (`#menu` y Carrito)** — Semana 12 (`semana12_cadenas_condicionales.py`).
3. **📋 Cola de Barra en Vivo y "Arma mi Pedido Automático" (`#barra-vivo`)** — Semana 13 (`semana13_bucles_listas.py`).
4. **🛵 Cotizador de Delivery por Distrito y Editor de Precios (`#delivery-precios`)** — Semana 14 (`semana14_colecciones_funciones.py` + `utilidades_cafe.py`).
5. **👑 Club VIP, Personalizador de Pedido y Monedero Digital (`#club-vip`)** — Semana 15 (`semana15_poo_herencia.py`).
6. **📊 Panel de Analítica de Ventas y Simulador de Demanda (`#analitica`)** — Semana 16 (`semana16_ciencia_datos_numpy.py`).

---

## 🐍 2. Mapa Técnico en Python (Semanas 11 a 16) — Dónde Está Cada Tema

| Semana | Tema del Sílabo | Archivo Principal | Funciones / Clases y Líneas |
|---|---|---|---|
| **Semana 11** | Características de Python e Instrucciones Secuenciales | [`src/main/python/semana11_secuencial.py`](src/main/python/semana11_secuencial.py) | `obtener_ficha_tipos_datos` (L27–L48), `calcular_boleta_secuencial` (L54–L135), `tomar_pedido_rapido_consola` (L141–L168), `semana11` (L174–L206) |
| **Semana 12** | Cadenas de Texto e Instrucciones Condicionales | [`src/main/python/semana12_cadenas_condicionales.py`](src/main/python/semana12_cadenas_condicionales.py) | `generar_codigo_y_etiqueta_cliente` (L32–L71), `recomendar_segun_hora` (L77–L112), `validar_cupon_promocional` (L118–L159), `buscar_productos_por_frase` (L165–L231), `semana12` (L237–L259) |
| **Semana 13** | Instrucciones Repetitivas (`for`/`while`) y Arreglos (Listas) | [`src/main/python/semana13_bucles_listas.py`](src/main/python/semana13_bucles_listas.py) | `simular_gestion_cola_barra` (L31–L125), `armar_pedido_con_while` (L131–L157), `contar_productos_por_categoria_for` (L163–L184), `semana13` (L190–L210) |
| **Semana 14** | Listas, Tuplas, Diccionarios, Funciones y Módulos | [`src/main/python/semana14_colecciones_funciones.py`](src/main/python/semana14_colecciones_funciones.py) + [`src/main/python/utilidades_cafe.py`](src/main/python/utilidades_cafe.py) | `contar_producto_en_tupla` (L66–L79), `actualizar_precio_producto` (L93–L110), `lista_tuplas_a_diccionario` (L116–L139), `cotizar_delivery_modular` (L145–L180) + módulo propio `utilidades_cafe.py` |
| **Semana 15** | Clases, Objetos, Encapsulamiento, Herencia y Singleton | [`src/main/python/semana15_poo_herencia.py`](src/main/python/semana15_poo_herencia.py) | `ConfiguracionCafeExpress` (L29–L53), `ProductoCafe` (L59–L90), `Bebida` (L93–L114), `Postre` (L117–L130), `Sandwich` (L133–L145), `Persona` (L151–L159), `ClienteVIP` (L162–L176), `Barista` (L179–L191), `MonederoCafeExpress` (L197–L230), `PedidoPOO` (L236–L262) |
| **Semana 16** | Introducción a la Ciencia de Datos con NumPy | [`src/main/python/semana16_ciencia_datos_numpy.py`](src/main/python/semana16_ciencia_datos_numpy.py) | `analizar_ventas_estadisticas` (L57–L97), `calcular_ingresos_algebra_lineal` (L103–L132), `limpiar_datos_faltantes_pos` (L138–L160), `simular_demanda_aleatoria` (L166–L182), `explorar_slicing_matriz` (L188–L208), `benchmark_lista_vs_numpy` (L214–L244) |
| **Integración** | Catálogo, Consola y Servidor Web Python | [`main.py`](main.py), [`src/main/python/cafe_express.py`](src/main/python/cafe_express.py), [`src/main/python/servidor_python.py`](src/main/python/servidor_python.py), [`cafe_express_python.html`](cafe_express_python.html) | Punto de entrada `main.py`, ejecución consolidada en consola y servidor HTTP en puerto 8080 con API JSON para cada semana. |

### Ejecución en Python (desde esta carpeta)
* **Consola consolidada (Semanas 11 a 16):** `python main.py --consola`
* **Consola interactiva con `input()`:** `python main.py --interactivo`
* **Servidor Web Python (puerto 8080):** `python main.py` → http://localhost:8080/ (y vista clásica intacta en http://localhost:8080/clasico)

---

## 📌 2. Ubicación de Cada Parte de la Imagen (Semana 7: Unificación y Resolución)

En el caso del cliente que escribe por WhatsApp:
> *"¿Tienen algo sin leche y de menos de S/10?"*

* **Hechos (Recuadro Morado):** [`src/main/prolog/consulta.pl`](src/main/prolog/consulta.pl#L33-L58) (líneas 33–58)
* **Reglas (`disponible/1`, `opcion/3`, `combo/3`):** [`src/main/prolog/consulta.pl`](src/main/prolog/consulta.pl#L63-L80) (líneas 63–80)
* **Consultas (`semana7/0`):** [`src/main/prolog/consulta.pl`](src/main/prolog/consulta.pl#L123-L149) (líneas 123–149)

---

## 📚 3. Resumen de Aportes Previos por Semana (Semanas 1 a 9 — Scala y Prolog)

| Semana | Tema del Sílabo | Archivo Principal | Conceptos Implementados |
|---|---|---|---|
| **Semanas 1–3** | Programación funcional en Scala | [`src/main/scala/CafeExpress.scala`](src/main/scala/CafeExpress.scala) | Inmutabilidad (`foldLeft`), funciones anónimas (`map`), funciones de orden superior (`filtrarProductos`). |
| **Semana 6** | Programación lógica: términos, hechos, reglas y extracción | [`src/main/prolog/semana6.pl`](src/main/prolog/semana6.pl) | Hechos `producto/3`, reglas `dentro_presupuesto/2`, `es_bebida/1`, `bebida_economica/1`, `recomendar/3`, `findall/3`. |
| **Semana 7** | Programación lógica: unificación y resolución | [`src/main/prolog/consulta.pl`](src/main/prolog/consulta.pl) y [`src/main/prolog/vista_consulta.pl`](src/main/prolog/vista_consulta.pl) | Unificación SLD, `disponible/1`, `opcion/3`, `combo/3`, interfaz `/consulta`. |
| **Semana 8** | Programación lógica: control de ejecución | [`src/main/prolog/control.pl`](src/main/prolog/control.pl) | `( -> ; )`, corte `!`, `forall/2`, `select/3`. |
| **Semana 9** | Programación lógica: listas e indeterminismo | [`src/main/prolog/logica.pl`](src/main/prolog/logica.pl#L108-L117) | Regla `sugerir_combo/4` con backtracking. |

---

## 🚀 4. Ejecución de los Módulos Previos (Prolog / HTML)

* **Consola Prolog (Semanas 1 a 9):** `swipl src/main/prolog/cafe_express.pl`
* **Servidor Web Prolog (puerto 8080):** `swipl main.pl` → http://localhost:8080 y http://localhost:8080/consulta. No puede ejecutarse simultáneamente con el servidor Python, ya que ambos usan el mismo puerto de forma predeterminada.
* **Interfaz Web Clásica:** Abrir [`index.html`](index.html)
