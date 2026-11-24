# Aporte individual — Bloque 6 / Semana 6

## Qué contiene

Este aporte implementa **Programación Lógica en Prolog** aplicada al mismo caso de CafeExpress.

Cubre exactamente el bloque 6 del sílabo:

- términos;
- átomos;
- constantes;
- predicados;
- reglas y programas;
- extracción de respuestas.

## Decisión de integración

**No se modificó `CafeExpress.scala` ni el proyecto base.**

Esto sigue la indicación del grupo de trabajar cada aporte por separado para que luego el encargado de integración pueda unirlos sin romper lo que ya funciona.

El archivo a entregar/subir es:

`semana6_cafeexpress.pl`

La recomendación es que el integrador lo coloque después en una carpeta como:

`prolog/semana6_cafeexpress.pl`

Así, las semanas 7, 8 y 9 pueden continuar sobre la misma base lógica.

## Relación con CafeExpress

Se reutilizan los cinco productos que existen en el `menu` actual de `CafeExpress.scala`:

- Café Americano — S/ 8.0 — bebida
- Capuchino — S/ 12.0 — bebida
- Torta de Chocolate — S/ 15.0 — postre
- Galleta — S/ 5.0 — postre
- Jugo de Naranja — S/ 9.0 — bebida

La nueva parte lógica permite responder preguntas como:

- ¿Qué productos cuestan S/ 10 o menos?
- ¿Qué bebidas son económicas?
- ¿Qué bebida puedo recomendar para un presupuesto de S/ 10?

## Consultas principales

```prolog
?- dentro_presupuesto(Producto, 10).
?- bebida_economica(Producto).
?- recomendar(Producto, 10, bebida).
```

Resultados esperados:

```text
Productos dentro de S/ 10:
[cafe_americano, galleta, jugo_naranja]

Bebidas económicas:
[cafe_americano, jugo_naranja]

Recomendados (bebida, máximo S/ 10):
[cafe_americano, jugo_naranja]
```

## Qué NO debe hacer el integrador todavía

No reemplazar `CafeExpress.scala` con este archivo. Scala corresponde a la parte funcional de las primeras semanas; este archivo introduce la unidad de **Programación Lógica con Prolog** de forma separada.
