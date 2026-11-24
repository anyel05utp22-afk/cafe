# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 MÓDULO  : semana15_poo_herencia.py
 TEMA    : SEMANA 15 — Programación Orientada a Objetos (POO):
           Clases, Objetos, Encapsulamiento, Herencia,
           Sobreescritura de Métodos y Patrón Singleton

 Conceptos implementados (según temario Sesión 15):
   1. Clases y Objetos: class, constructor __init__, atributos, métodos
      (Modelar entidades del mundo real: ProductoCafe, Persona)
   2. Encapsulamiento: atributos privados (__saldo) y métodos públicos
      (CajaCafeExpress / MonederoCliente, análogo a CuentaBancaria)
   3. Herencia: class Hija(ClasePadre) y llamada a super().__init__(...)
      (Bebida, Postre, Sandwich heredan de ProductoCafe;
       ClienteVIP y Barista heredan de Persona)
   4. Sobreescritura de métodos: redefinición de describir(),
      calcular_precio_total() y saludar() en las clases hijas
   5. Agrupación y modularización: clase PedidoPOO que compone objetos
   6. Patrón de Diseño Singleton con __new__ (ConfiguracionCafeExpress)
============================================================
"""


# ------------------------------------------------------------
# 1. PATRÓN DE DISEÑO SINGLETON (Caso Práctico 6 de Sesión 15)
# ------------------------------------------------------------
class ConfiguracionCafeExpress:
    """
    Garantiza que exista una única instancia global de configuración
    de la cafetería usando __new__(cls).
    """

    __instancia = None

    def __new__(cls):
        if not cls.__instancia:
            cls.__instancia = super().__new__(cls)
            cls.__instancia.nombre_tienda = "CaféExpress"
            cls.__instancia.moneda = "S/"
            cls.__instancia.tasa_igv = 0.18
            cls.__instancia.descuento_vip = 0.15
        return cls.__instancia

    def a_diccionario(self):
        return {
            "nombre_tienda": self.nombre_tienda,
            "moneda": self.moneda,
            "tasa_igv": self.tasa_igv,
            "descuento_vip": self.descuento_vip,
            "id_memoria": id(self),
        }


# ------------------------------------------------------------
# 2. CLASE BASE Y HERENCIA DE PRODUCTOS (Modelar Entidades + Sobreescritura)
# ------------------------------------------------------------
class ProductoCafe:
    """Clase padre que modela un producto genérico de CaféExpress."""

    def __init__(self, nombre, precio, cantidad=1, categoria="general"):
        self.nombre = nombre
        self.precio = float(precio)
        self.cantidad = int(cantidad)
        self.categoria = categoria

    def calcular_precio_total(self):
        """Calcula el precio total (precio * cantidad)."""
        return round(self.precio * self.cantidad, 2)

    def aplicar_descuento(self, descuento):
        """Aplica un descuento decimal (ej. 0.10 para 10%) al precio unitario."""
        if 0 < descuento < 1:
            self.precio = round(self.precio * (1 - descuento), 2)

    def describir(self):
        """Método base que será sobreescrito por las clases hijas."""
        return f"{self.nombre} ({self.categoria}) — S/ {self.precio:.2f} x{self.cantidad}"

    def a_diccionario(self):
        return {
            "clase": self.__class__.__name__,
            "nombre": self.nombre,
            "categoria": self.categoria,
            "precio_unitario": self.precio,
            "cantidad": self.cantidad,
            "subtotal": self.calcular_precio_total(),
            "descripcion": self.describir(),
        }


class Bebida(ProductoCafe):
    """Clase hija que hereda de ProductoCafe y sobreescribe métodos."""

    RECARGOS_TAMANO = {"pequeno": 0.0, "mediano": 2.0, "grande": 4.0}

    def __init__(self, nombre, precio, cantidad=1, tamano="mediano", temperatura="caliente"):
        # Llamada al constructor de la clase padre con super().__init__()
        super().__init__(nombre, precio, cantidad, categoria="bebida")
        self.tamano = tamano.lower()
        self.temperatura = temperatura.lower()

    # Sobreescritura de método: incluye recargo por tamaño de vaso
    def calcular_precio_total(self):
        recargo = self.RECARGOS_TAMANO.get(self.tamano, 0.0)
        return round((self.precio + recargo) * self.cantidad, 2)

    # Sobreescritura de método: descripción especializada para bebidas
    def describir(self):
        return (
            f"Bebida {self.nombre} [{self.tamano.capitalize()}, {self.temperatura}] "
            f"x{self.cantidad} -> S/ {self.calcular_precio_total():.2f}"
        )


class Postre(ProductoCafe):
    """Clase hija para postres con atributo propio sin_lactosa y sobreescritura."""

    def __init__(self, nombre, precio, cantidad=1, sin_lactosa=False):
        super().__init__(nombre, precio, cantidad, categoria="postre")
        self.sin_lactosa = bool(sin_lactosa)

    # Sobreescritura de método
    def describir(self):
        etiqueta = "Sin lactosa" if self.sin_lactosa else "Receta tradicional"
        return (
            f"Postre {self.nombre} ({etiqueta}) "
            f"x{self.cantidad} -> S/ {self.calcular_precio_total():.2f}"
        )


class Sandwich(ProductoCafe):
    """Clase hija para sándwiches con tipo de pan y sobreescritura."""

    def __init__(self, nombre, precio, cantidad=1, tipo_pan="artesanal"):
        super().__init__(nombre, precio, cantidad, categoria="sandwich")
        self.tipo_pan = tipo_pan

    # Sobreescritura de método
    def describir(self):
        return (
            f"Sándwich {self.nombre} (Pan {self.tipo_pan}) "
            f"x{self.cantidad} -> S/ {self.calcular_precio_total():.2f}"
        )


# ------------------------------------------------------------
# 3. HERENCIA DE PERSONAS (Persona -> ClienteVIP y Barista)
# ------------------------------------------------------------
class Persona:
    """Clase padre Persona (basada en el ejemplo central de Sesión 15)."""

    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = int(edad)

    def saludar(self):
        return f"Hola, mi nombre es {self.nombre} y tengo {self.edad} años."


class ClienteVIP(Persona):
    """Clase hija que hereda de Persona y sobreescribe saludar()."""

    def __init__(self, nombre, edad, puntos=100):
        super().__init__(nombre, edad)
        self.puntos = int(puntos)

    # Sobreescritura de método saludar()
    def saludar(self):
        return f"Hola, soy {self.nombre} (Cliente VIP, {self.edad} años) y tengo {self.puntos} puntos CaféExpress."

    def acumular_puntos(self, monto_compra):
        ganados = int(monto_compra // 5)
        self.puntos += ganados
        return ganados


class Barista(Persona):
    """Clase hija Barista que hereda de Persona y añade método propio."""

    def __init__(self, nombre, edad, especialidad="Latte Art"):
        super().__init__(nombre, edad)
        self.especialidad = especialidad

    # Sobreescritura de método saludar()
    def saludar(self):
        return f"¡Bienvenido a CaféExpress! Soy {self.nombre}, barista especialista en {self.especialidad}."

    def preparar_bebida(self, bebida):
        return f"Barista {self.nombre} prepara {bebida.nombre} ({bebida.temperatura}, tamaño {bebida.tamano})."


# ------------------------------------------------------------
# 4. ENCAPSULAMIENTO CON ATRIBUTO PRIVADO (__saldo)
# ------------------------------------------------------------
class MonederoCafeExpress:
    """
    Caso Práctico 2 de Sesión 15 (Encapsulamiento):
    Oculta el saldo en el atributo privado self.__saldo y solo permite
    operar mediante los métodos públicos depositar(), pagar() y obtener_saldo().
    """

    def __init__(self, titular, saldo_inicial=0.0):
        self.titular = titular
        self.__saldo = float(saldo_inicial)   # Atributo privado (encapsulado)
        self.__movimientos = []               # Historial privado

    def depositar(self, monto):
        monto = float(monto)
        if monto > 0:
            self.__saldo = round(self.__saldo + monto, 2)
            self.__movimientos.append(f"+S/ {monto:.2f} (Recarga)")
            return True
        return False

    def retirar(self, monto):
        """Descuenta un pago del monedero solo si hay saldo suficiente."""
        monto = float(monto)
        if 0 < monto <= self.__saldo:
            self.__saldo = round(self.__saldo - monto, 2)
            self.__movimientos.append(f"-S/ {monto:.2f} (Pago pedido)")
            return True
        return False

    def obtener_saldo(self):
        return self.__saldo

    def obtener_movimientos(self):
        return list(self.__movimientos)


# ------------------------------------------------------------
# 5. AGRUPACIÓN Y MODULARIZACIÓN (PedidoPOO)
# ------------------------------------------------------------
class PedidoPOO:
    """Agrupa objetos ProductoCafe (Bebida, Postre, Sandwich) de forma polimórfica."""

    def __init__(self, cliente):
        self.cliente = cliente
        self.items = []
        self.config = ConfiguracionCafeExpress()  # Usa el Singleton

    def agregar_item(self, producto):
        self.items.append(producto)

    def calcular_total(self):
        total = sum(item.calcular_precio_total() for item in self.items)
        if isinstance(self.cliente, ClienteVIP):
            total = total * (1 - self.config.descuento_vip)
        return round(total, 2)

    def generar_resumen(self):
        return {
            "tienda": self.config.nombre_tienda,
            "cliente": self.cliente.nombre,
            "saludo_cliente": self.cliente.saludar(),
            "es_vip": isinstance(self.cliente, ClienteVIP),
            "descuento_vip_pct": int(self.config.descuento_vip * 100) if isinstance(self.cliente, ClienteVIP) else 0,
            "items": [item.a_diccionario() for item in self.items],
            "total_a_pagar": self.calcular_total(),
        }


# ------------------------------------------------------------
# 6. Simulador ejecutable (para consola y API web)
# ------------------------------------------------------------
def simular_escenario_poo(
    nombre_cliente="Luis",
    edad_cliente=22,
    saldo_inicial=50.0,
    recarga=20.0,
    tamano_bebida="grande",
    bebida_nombre="Capuchino",
    bebida_precio=12.0,
    temperatura="caliente",
    sin_lactosa=True,
    tipo_pan="integral",
):
    """Ejecuta un escenario completo demostrando todos los pilares de Sesión 15."""
    # Verificación del patrón Singleton
    cfg1 = ConfiguracionCafeExpress()
    cfg2 = ConfiguracionCafeExpress()
    misma_instancia_singleton = cfg1 is cfg2

    # Creación de objetos con Herencia y Sobreescritura
    cliente = ClienteVIP(nombre_cliente, edad_cliente, puntos=120)
    barista = Barista("Sofía", 27, especialidad="Cold Brew & Espresso")

    bebida = Bebida(
        bebida_nombre,
        float(bebida_precio),
        cantidad=1,
        tamano=tamano_bebida,
        temperatura=temperatura,
    )
    postre = Postre("Galleta Artesanal", 5.0, cantidad=2, sin_lactosa=bool(sin_lactosa))
    sandwich = Sandwich("Sándwich Veggie", 13.0, cantidad=1, tipo_pan=tipo_pan)

    pedido = PedidoPOO(cliente)
    pedido.agregar_item(bebida)
    pedido.agregar_item(postre)
    pedido.agregar_item(sandwich)

    resumen_pedido = pedido.generar_resumen()
    total = resumen_pedido["total_a_pagar"]

    # Encapsulamiento con MonederoCafeExpress (__saldo privado)
    monedero = MonederoCafeExpress(cliente.nombre, saldo_inicial=saldo_inicial)
    monedero.depositar(recarga)
    pago_exitoso = monedero.retirar(total)
    puntos_ganados = cliente.acumular_puntos(total) if pago_exitoso else 0

    return {
        "singleton_verificado": misma_instancia_singleton,
        "configuracion_singleton": cfg1.a_diccionario(),
        "barista_saludo": barista.saludar(),
        "accion_barista": barista.preparar_bebida(bebida),
        "pedido": resumen_pedido,
        "monedero_encapsulado": {
            "saldo_inicial": float(saldo_inicial),
            "recarga": float(recarga),
            "pago_realizado": pago_exitoso,
            "saldo_final": monedero.obtener_saldo(),
            "movimientos": monedero.obtener_movimientos(),
        },
        "puntos_ganados": puntos_ganados,
        "puntos_totales_vip": cliente.puntos,
    }


def semana15():
    print("\n── SEMANA 15: POO — Clases, Objetos, Encapsulamiento, Herencia y Singleton ──")
    res = simular_escenario_poo()
    print(f"1. Patrón Singleton (__new__): cfg1 is cfg2 -> {res['singleton_verificado']} (id={res['configuracion_singleton']['id_memoria']})")
    print(f"2. Herencia y sobreescritura (Persona -> ClienteVIP / Barista):")
    print(f"   • {res['pedido']['saludo_cliente']}")
    print(f"   • {res['barista_saludo']}")
    print(f"   • {res['accion_barista']}")
    print("3. Herencia de productos (ProductoCafe -> Bebida, Postre, Sandwich):")
    for item in res["pedido"]["items"]:
        print(f"   • [{item['clase']}] {item['descripcion']}")
    print(f"   Total con descuento VIP ({res['pedido']['descuento_vip_pct']}%): S/ {res['pedido']['total_a_pagar']:.2f}")
    m = res["monedero_encapsulado"]
    print(
        f"4. Encapsulamiento (__saldo privado): Inicio S/ {m['saldo_inicial']:.2f} + "
        f"Recarga S/ {m['recarga']:.2f} | Pago OK: {m['pago_realizado']} | "
        f"Saldo final: S/ {m['saldo_final']:.2f}"
    )


if __name__ == "__main__":
    semana15()
