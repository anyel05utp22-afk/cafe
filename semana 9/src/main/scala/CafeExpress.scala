// ============================================================
//  PROYECTO: CaféExpress — Sistema de Pedidos
//  Curso: Lenguaje de Programación
//  Propuesta Semanas 1, 2 y 3 — Programación Funcional en Scala
// ============================================================

// Modelo de datos: producto del menú
case class Producto(nombre: String, precio: Double, categoria: String)

object CafeExpress extends App {

  println("╔══════════════════════════════════════════╗")
  println("║        SISTEMA CaféExpress v1.0          ║")
  println("║   Propuesta — Programación Funcional     ║")
  println("╚══════════════════════════════════════════╝")

  // ----------------------------------------------------------
  // SEMANA 1 — Funciones como programas / Valores inmutables
  // Problema: el dueño suma los precios del carrito a mano
  // y comete errores. calcularTotal lo hace automáticamente
  // usando una lista INMUTABLE (el carrito nunca se altera).
  // ----------------------------------------------------------

  val carrito: List[Double] = List(12.0, 8.0, 15.0)  // inmutable

  def calcularTotal(precios: List[Double]): Double =
    precios.foldLeft(0.0)((acc, p) => acc + p)

  println("\n── SEMANA 1: Total del pedido ──")
  println(s"Pedido recibido : $carrito")
  println(s"Total a cobrar  : S/ ${calcularTotal(carrito)}")

  // ----------------------------------------------------------
  // SEMANA 2 — Funciones definidas + anónimas + en listas
  // Problema: aplicar un descuento del 10% a cada producto
  // manualmente toma mucho tiempo en horas pico.
  // aplicarDescuento (función definida) + .map con función
  // anónima recorre toda la lista y genera nuevos precios.
  // ----------------------------------------------------------

  def aplicarDescuento(precio: Double): Double = precio * 0.9  // función definida

  val conDescuento: List[Double] = carrito.map(precio => precio * 0.9) // función anónima

  println("\n── SEMANA 2: Descuento del 10% ──")
  println(s"Precios originales : $carrito")
  println(s"Precios con -10%%  : $conDescuento")
  println(s"Nuevo total        : S/ ${calcularTotal(conDescuento)}")

  // ----------------------------------------------------------
  // SEMANA 3 — Funciones de orden superior
  // Problema: un cliente pide "algo de menos de S/10" y el
  // dueño revisa el menú completo a mano.
  // filtrarProductos recibe OTRA FUNCIÓN como parámetro
  // (condicion) → eso es una función de ORDEN SUPERIOR.
  // ----------------------------------------------------------

  val menu: List[Producto] = List(
    Producto("Café Americano",     8.0,  "bebida"),
    Producto("Capuchino",          12.0, "bebida"),
    Producto("Torta de Chocolate", 15.0, "postre"),
    Producto("Galleta",            5.0,  "postre"),
    Producto("Jugo de Naranja",    9.0,  "bebida")
  )

  // Función de orden superior: recibe otra función como parámetro
  def filtrarProductos(lista: List[Producto], condicion: Producto => Boolean): List[Producto] =
    lista.filter(condicion)

  println("\n── SEMANA 3: Filtrar productos ──")

  val baratos  = filtrarProductos(menu, p => p.precio < 10.0)
  val bebidas  = filtrarProductos(menu, p => p.categoria == "bebida")

  println("Productos menores a S/10:")
  baratos.foreach(p => println(s"  ✔ ${p.nombre} — S/ ${p.precio}"))

  println("Solo bebidas:")
  bebidas.foreach(p => println(s"  ✔ ${p.nombre} — S/ ${p.precio}"))

  println("\n✅ Sistema CaféExpress ejecutado correctamente.")
}
