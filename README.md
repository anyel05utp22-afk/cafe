# CaféExpress — Proyecto Integrado Multiparadigma (Scala, Prolog y Python)

Este proyecto unifica la base de **CaféExpress** con los aportes académicos completos del curso **Lenguajes de Programación (UTP)**:
- **Semanas 1 a 3:** Programación Funcional en **Scala** (`src/main/scala/CafeExpress.scala`)
- **Semanas 6 a 9:** Programación Lógica en **Prolog** (`src/main/prolog/*.pl`, `main.pl`, `index.html`)
- **Semanas 11 a 16:** Programación Multiparadigma y Ciencia de Datos en **Python + NumPy** (`src/main/python/*.py`, `main.py`, `cafe_express_python.html`)

> **Integridad garantizada:** Todas las funcionalidades previas de Scala y Prolog (incluyendo `main.pl`, `index.html`, `src/main/prolog/` y `src/main/scala/`) se mantienen **100% intactas**, sin eliminar ni romper ningún archivo anterior.

---

## 🛒 1. Nuevas Opciones Visibles en la Página Web (`http://localhost:8080/`)

Al iniciar el servidor en Python (`python main.py`), la página principal ([`cafe_express_python.html`](cafe%20prolog%20copia/cafe_express_python.html)) conserva **todas** las opciones originales de CaféExpress (Menú de 12 productos, filtros, Carrito lateral, Recomendador por presupuesto, Alérgenos/Stock y Combos Especiales) y añade **6 nuevas opciones reales** para clientes y administración, todas ejecutadas por Python:

| Opción visible en la página | Sección / Ubicación en la web | Semana y Módulo Python que la impulsa |
|---|---|---|
| **🧾 Boleta Detallada, IGV y Puntos de Fidelidad** | `#boleta-fidelidad` + cálculo de puntos en el Carrito | **Semana 11** — `semana11_secuencial.py` (`POST /api/semana11/boleta`) |
| **🔎 Buscador Inteligente del Menú, Banner por Hora, Cupones y Etiqueta de Vaso** | Banner bajo el Hero, barra de búsqueda sobre el Menú, campo Cupón (`CAFE2026`, `CAFEVIP`, `POSTRE5`) y Nombre de vaso en el Carrito | **Semana 12** — `semana12_cadenas_condicionales.py` (`POST /api/semana12/analizar`) |
| **📋 Cola de Barra en Vivo y "Arma mi Pedido Automático"** | `#barra-vivo` (con botón "+ Pasar todo al Carrito") | **Semana 13** — `semana13_bucles_listas.py` (`POST /api/semana13/cola`) |
| **🛵 Cotizador de Delivery por Distrito y Editor de Precios del Día** | `#delivery-precios` (actualiza precios directo en el Menú) | **Semana 14** — `semana14_colecciones_funciones.py` + `utilidades_cafe.py` (`POST /api/semana14/colecciones`) |
| **👑 Club CaféExpress VIP, Personalizador y Monedero Digital** | `#club-vip` (tamaño, temperatura, sin lactosa, tipo de pan y pago con monedero recargable) | **Semana 15** — `semana15_poo_herencia.py` (`POST /api/semana15/poo`) |
| **📊 Panel de Analítica de Ventas y Simulador de Demanda** | `#analitica` (gráfico semanal, tabla 5×7, limpieza de registros faltantes y prueba de velocidad) | **Semana 16** — `semana16_ciencia_datos_numpy.py` (`POST /api/semana16/numpy`) |

---

## 🐍 2. Mapa Técnico en Python (Semanas 11 a 16) — Dónde Está Cada Tema

Todos los módulos nuevos de Python se ubican dentro de `cafe prolog copia/src/main/python/`, junto con los puntos de entrada `main.py` y la interfaz interactiva `cafe_express_python.html`.

### Resumen Rápido por Semana (Semanas 11 a 16)

| Semana | Tema del Sílabo (PDF) | Archivo Principal | Funciones / Clases Clave |
|---|---|---|---|
| **Semana 11** | Características de Python e Instrucciones de Control Secuenciales | [`semana11_secuencial.py`](cafe%20prolog%20copia/src/main/python/semana11_secuencial.py) | `obtener_ficha_tipos_datos` (L27–L48), `calcular_boleta_secuencial` (L54–L135), `tomar_pedido_rapido_consola` (L141–L168), `semana11` (L174–L206) |
| **Semana 12** | Cadenas de Texto e Instrucciones Condicionales | [`semana12_cadenas_condicionales.py`](cafe%20prolog%20copia/src/main/python/semana12_cadenas_condicionales.py) | `generar_codigo_y_etiqueta_cliente` (L32–L71), `recomendar_segun_hora` (L77–L112), `validar_cupon_promocional` (L118–L159), `buscar_productos_por_frase` (L165–L231), `semana12` (L237–L259) |
| **Semana 13** | Instrucciones Repetitivas (`for`/`while`) y Arreglos (Listas) | [`semana13_bucles_listas.py`](cafe%20prolog%20copia/src/main/python/semana13_bucles_listas.py) | `simular_gestion_cola_barra` (L31–L125), `armar_pedido_con_while` (L131–L157), `contar_productos_por_categoria_for` (L163–L184), `semana13` (L190–L210) |
| **Semana 14** | Listas, Tuplas, Diccionarios, Funciones y Módulos | [`semana14_colecciones_funciones.py`](cafe%20prolog%20copia/src/main/python/semana14_colecciones_funciones.py) + [`utilidades_cafe.py`](cafe%20prolog%20copia/src/main/python/utilidades_cafe.py) | `contar_producto_en_tupla` (L66–L79), `actualizar_precio_producto` (L93–L110), `lista_tuplas_a_diccionario` (L116–L139), `cotizar_delivery_modular` (L145–L180) + módulo propio `utilidades_cafe.py` |
| **Semana 15** | POO: Clases, Objetos, Encapsulamiento, Herencia y Patrón Singleton | [`semana15_poo_herencia.py`](cafe%20prolog%20copia/src/main/python/semana15_poo_herencia.py) | `ConfiguracionCafeExpress` (L29–L53), `ProductoCafe` (L59–L90), `Bebida` (L93–L114), `Postre` (L117–L130), `Sandwich` (L133–L145), `Persona` (L151–L159), `ClienteVIP` (L162–L176), `Barista` (L179–L191), `MonederoCafeExpress` (L197–L230), `PedidoPOO` (L236–L262) |
| **Semana 16** | Introducción a la Ciencia de Datos con NumPy | [`semana16_ciencia_datos_numpy.py`](cafe%20prolog%20copia/src/main/python/semana16_ciencia_datos_numpy.py) | `analizar_ventas_estadisticas` (L57–L97), `calcular_ingresos_algebra_lineal` (L103–L132), `limpiar_datos_faltantes_pos` (L138–L160), `simular_demanda_aleatoria` (L166–L182), `explorar_slicing_matriz` (L188–L208), `benchmark_lista_vs_numpy` (L214–L244) |

---

### Detalle Exacto de Cada Subtema Implementado

#### 📘 Semana 11 — Características de Python e Instrucciones Secuenciales
* **Archivo:** `cafe prolog copia/src/main/python/semana11_secuencial.py`
* **Tipos de datos (`int`, `float`, `str`, `bool`, `list`, `tuple`, `dict`):** `obtener_ficha_tipos_datos()` (líneas 27–48).
* **Variables dinámicas, flujo secuencial y operadores:** `calcular_boleta_secuencial()` (líneas 54–135):
  * Operadores aritméticos (`+`, `-`, `*`, `/`, `//` para puntos base y pares de empaque, `%` para residuo y sueltas, `**` para bono por racha).
  * Operadores relacionales (`==`, `!=`, `<`, `>`, `<=`, `>=`) y lógicos (`and`, `or`, `not`).
  * Operadores de asignación (`=`, `+=`, `-=`, `*=`, `/=`).
  * Salida formateada con concatenación (`+`) y `f-string`.
* **Ingreso por teclado (`input()` con `int()` y `float()`) y `print()`:** `tomar_pedido_rapido_consola()` (líneas 141–168).

#### 📘 Semana 12 — Cadenas de Texto e Instrucciones Condicionales
* **Archivo:** `cafe prolog copia/src/main/python/semana12_cadenas_condicionales.py`
* **Operaciones con cadenas (`len()`, `[0]`, `[-1]`, `[:3]`, `[::-1]`, `+`, `.upper()`, `.lower()`, `.replace()`, `.title()`):** `generar_codigo_y_etiqueta_cliente()` (líneas 32–71).
* **Condicional múltiple `if / elif / else` según hora del día:** `recomendar_segun_hora()` (líneas 77–112).
* **Condicional con `.startswith("CAFE")`, `.upper()` y comparación `==`:** `validar_cupon_promocional()` (líneas 118–159).
* **Análisis de frases con `.split()`, `.lower()`, `.replace()` y operador `in`:** `buscar_productos_por_frase()` (líneas 165–231).

#### 📘 Semana 13 — Instrucciones Repetitivas y Arreglos (Listas)
* **Archivo:** `cafe prolog copia/src/main/python/semana13_bucles_listas.py`
* **CRUD de listas + bucles `for` y `while`:** `simular_gestion_cola_barra()` (líneas 31–125):
  * Creación de lista `[]`, acceso al primero `[0]` y último `[-1]`.
  * Añadir al final con `.append()`, modificar por índice `cola[1] = ...`.
  * Eliminar elemento específico con `.remove()` y eliminar por posición con `del cola[0]`.
  * Recorrido con bucle `for` y recorrido con bucle `while indice < len(cola)`.
* **Bucle `while` con condición de parada (presupuesto):** `armar_pedido_con_while()` (líneas 131–157).
* **Clasificación con bucle `for`:** `contar_productos_por_categoria_for()` (líneas 163–184).

#### 📘 Semana 14 — Listas, Tuplas, Diccionarios, Funciones y Módulos
* **Archivo principal:** `cafe prolog copia/src/main/python/semana14_colecciones_funciones.py`
* **Módulo propio importado:** `cafe prolog copia/src/main/python/utilidades_cafe.py`
* **Tuplas inmutables** (`COORDENADAS_TIENDA`, `HORARIO_ATENCION`, `CATEGORIAS_OFICIALES`, `VENTAS_DEL_TURNO_TUPLA`) y conteo con `.count()`: líneas 44–79 (`contar_producto_en_tupla`).
* **Diccionarios (clave-valor) y actualización de precios:** `construir_diccionario_precios()` (líneas 85–90) y `actualizar_precio_producto()` (líneas 93–110).
* **Conversión lista de tuplas → diccionario:** `lista_tuplas_a_diccionario()` (líneas 116–139).
* **Funciones (`def`, `return`) e importación de módulos** (`import math`, `from math import ceil`, `import utilidades_cafe`, `from utilidades_cafe import ...`): `cotizar_delivery_modular()` (líneas 145–180) y `utilidades_cafe.py` (usa `math.sqrt`, `math.ceil`, `random.randint`, `os.path`).

#### 📘 Semana 15 — Clases, Objetos, Encapsulamiento, Herencia y Patrones
* **Archivo:** `cafe prolog copia/src/main/python/semana15_poo_herencia.py`
* **Patrón Singleton (`__new__`):** `ConfiguracionCafeExpress` (líneas 29–53).
* **Modelado de entidades, herencia y sobreescritura de métodos (`super().__init__`):**
  * Clase padre `ProductoCafe` (líneas 59–90) → clases hijas `Bebida` (L93–L114), `Postre` (L117–L130) y `Sandwich` (L133–L145) sobreescribiendo `describir()` y `calcular_precio_total()`.
  * Clase padre `Persona` (líneas 151–159) → clases hijas `ClienteVIP` (L162–L176) y `Barista` (L179–L191) sobreescribiendo `saludar()`.
* **Encapsulamiento con atributos privados (`self.__saldo`):** `MonederoCafeExpress` con métodos públicos `depositar()`, `retirar()`, `obtener_saldo()` (líneas 197–230).
* **Agrupación/modularización polimórfica:** `PedidoPOO` (líneas 236–262) y `simular_escenario_poo()` (líneas 268–318).

#### 📘 Semana 16 — Introducción a la Ciencia de Datos con NumPy
* **Archivo:** `cafe prolog copia/src/main/python/semana16_ciencia_datos_numpy.py`
* **Arreglos `ndarray` (1D y matriz 2D 5×7), operaciones vectorizadas y estadísticas (`np.sum`, `np.mean`, `np.median`, `np.std`, `np.argmin`, `np.argmax`):** `analizar_ventas_estadisticas()` (líneas 57–97).
* **Álgebra lineal (`np.dot` matriz-vector y matriz-matriz 2×2):** `calcular_ingresos_algebra_lineal()` (líneas 103–132).
* **Manejo de datos faltantes (`np.nan`, `np.isnan`, `np.nanmean`, `np.nan_to_num`):** `limpiar_datos_faltantes_pos()` (líneas 138–160).
* **Generación aleatoria (`random((3, 3))` y `integers(1, 101, size=10)` + `np.std`):** `simular_demanda_aleatoria()` (líneas 166–182).
* **Indexación (`matriz[0, 1]`), slicing (`matriz[1:, 4:]`) y `np.arange(1, 11)`:** `explorar_slicing_matriz()` (líneas 188–208).
* **Benchmark de optimización y velocidad (Lista Python vs NumPy `ndarray` con `time.perf_counter()`):** `benchmark_lista_vs_numpy()` (líneas 214–244).

#### 📘 Integración, Consola y Servidor Web en Python
* **Catálogo compartido Python:** `cafe prolog copia/src/main/python/catalogo_py.py`
* **Consola consolidada (Semanas 11 a 16):** `cafe prolog copia/src/main/python/cafe_express.py`
* **Servidor HTTP + API JSON (Semanas 11 a 16):** `cafe prolog copia/src/main/python/servidor_python.py`
  * `GET /` → Interfaz web multiparadigma (`cafe_express_python.html`)
  * `GET /clasico` → Interfaz original intacta (`index.html`)
  * `POST /api/semana11/boleta`, `/api/semana12/analizar`, `/api/semana13/cola`, `/api/semana14/colecciones`, `/api/semana15/poo`, `/api/semana16/numpy`
* **Puntos de entrada:** `main.py` (raíz) y `cafe prolog copia/main.py`

---

## 🚀 2. Formas de Ejecución (Python — Semanas 11 a 16)

> **Requisito para Semana 16:** Tener instalado `numpy` (`python -m pip install numpy`).

### Opción A: Consola Consolidada en Python (Semanas 11 a 16)
```bash
python main.py --consola
```
*(O directamente: `python "cafe prolog copia/src/main/python/cafe_express.py"`)*

### Opción B: Consola Interactiva con `input()` (incluye captura por teclado de Semana 11)
```bash
python main.py --interactivo
```

### Opción C: Servidor Web Interactivo en Python (`http://localhost:8080`)
```bash
python main.py
```
Luego abre en el navegador:
* **Panel Multiparadigma Python (Semanas 11 a 16):** http://localhost:8080/
* **Interfaz Clásica Original intacta (Semanas 6 a 9):** http://localhost:8080/clasico

> Python y Prolog usan el puerto 8080 de forma predeterminada; inicia solo uno a la vez. Para usar otro puerto con Python, ejecuta `python main.py --puerto 8001`.

---

## 📌 3. Funcionalidades Previas Conservadas (Semanas 1 a 9 — Scala y Prolog)

Toda la documentación y funcionalidad anterior se conserva exactamente igual:

### A. Ubicación de Cada Parte de la Diapositiva (Semana 7: Unificación y Resolución)
En el caso del cliente que escribe por WhatsApp:
> *"¿Tienen algo sin leche y de menos de S/10?"*

* **Hechos (Recuadro Morado):** `cafe prolog copia/src/main/prolog/consulta.pl` (líneas 33–58) — `producto/3`, `contiene/2`, `stock/1` (con `pollo` agotado).
* **Reglas:** `cafe prolog copia/src/main/prolog/consulta.pl` (líneas 63–80) — `disponible/1`, `opcion/3`, `combo/3`.
* **Consultas ejecutables (`semana7/0`):** `cafe prolog copia/src/main/prolog/consulta.pl` (líneas 123–149):
  * `?- opcion(P, 10, leche).` → `P = cafe_americano ; P = te_helado ; false.`
  * `?- disponible(sandwich_pollo).` → `false.`
  * `?- combo(cafe_americano, keke, T).` → `T = 11.7`

### B. Resumen de Aportes Previos por Semana (Semanas 1 a 9)

| Semana | Tema del Sílabo | Archivo Principal | Conceptos Implementados |
|---|---|---|---|
| **Semanas 1–3** | Programación funcional en Scala | `cafe prolog copia/src/main/scala/CafeExpress.scala` | Inmutabilidad (`foldLeft`), funciones anónimas (`map`), funciones de orden superior (`filtrarProductos`). |
| **Semana 6** | Programación lógica: términos, hechos, reglas y extracción de respuestas | `cafe prolog copia/src/main/prolog/semana6.pl` | Hechos `producto/3`, reglas `dentro_presupuesto/2`, `es_bebida/1`, `bebida_economica/1`, `recomendar/3`, extracción con `findall/3`. |
| **Semana 7** | Programación lógica: unificación y resolución | `cafe prolog copia/src/main/prolog/consulta.pl` y `vista_consulta.pl` | Unificación y resolución SLD, `disponible/1`, `opcion/3`, `combo/3`, vista `/consulta`. |
| **Semana 8** | Programación lógica: control de ejecución | `cafe prolog copia/src/main/prolog/control.pl` | Condicional `( -> ; )`, corte `!`, `forall/2`, `select/3`. |
| **Semana 9** | Programación lógica: listas e indeterminismo | `cafe prolog copia/src/main/prolog/logica.pl` (L105–L117) | Regla `sugerir_combo/4` con exploración por backtracking. |

### C. Ejecución de los Módulos Previos (Prolog / HTML)
* **Consola Prolog (Semanas 1 a 9):** `swipl "cafe prolog copia/src/main/prolog/cafe_express.pl"`
* **Servidor Web Prolog (puerto 8080):** `swipl "cafe prolog copia/main.pl"` → http://localhost:8080 y http://localhost:8080/consulta
* **Apertura directa en navegador:** Abrir `cafe prolog copia/index.html`
