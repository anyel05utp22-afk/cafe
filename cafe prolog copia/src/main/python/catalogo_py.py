# -*- coding: utf-8 -*-
"""
============================================================
 PROYECTO: CaféExpress — Sistema de Pedidos (Python)
 Módulo  : catalogo_py.py
 Datos base compartidos del catálogo CaféExpress (fieles a
 catalogo.pl, consulta.pl e index.html).
============================================================
"""

# Catálogo completo de 12 productos de CaféExpress
CATALOGO_PRODUCTOS = [
    {
        "id": 1,
        "nombre": "Café Americano",
        "precio": 8.0,
        "categoria": "bebida",
        "img": "img/americano.png",
        "ingredientes": ["cafe"],
        "desc": "Espresso con agua caliente, sabor suave y reconfortante.",
    },
    {
        "id": 2,
        "nombre": "Capuchino",
        "precio": 12.0,
        "categoria": "bebida",
        "img": "img/capuchino.png",
        "ingredientes": ["cafe", "leche"],
        "desc": "Espresso con leche vaporizada y espuma cremosa.",
    },
    {
        "id": 3,
        "nombre": "Café Frío",
        "precio": 14.0,
        "categoria": "bebida",
        "img": "img/cafe_frio.png",
        "ingredientes": ["cafe", "hielo"],
        "desc": "Cold brew con hielo, suave y refrescante.",
    },
    {
        "id": 4,
        "nombre": "Chocolate Caliente",
        "precio": 10.0,
        "categoria": "bebida",
        "img": "img/chocolate.png",
        "ingredientes": ["chocolate", "leche"],
        "desc": "Chocolate artesanal con leche entera cremosa.",
    },
    {
        "id": 5,
        "nombre": "Torta de Chocolate",
        "precio": 15.0,
        "categoria": "postre",
        "img": "img/torta.png",
        "ingredientes": ["harina", "huevo", "chocolate", "leche"],
        "desc": "Tres capas de bizcocho con ganache de cacao puro.",
    },
    {
        "id": 6,
        "nombre": "Galleta Artesanal",
        "precio": 5.0,
        "categoria": "postre",
        "img": "img/galleta.png",
        "ingredientes": ["harina", "chocolate", "mantequilla"],
        "desc": "Galleta horneada al momento con chispas de cacao.",
    },
    {
        "id": 7,
        "nombre": "Cheesecake",
        "precio": 14.0,
        "categoria": "postre",
        "img": "img/cheesecake.png",
        "ingredientes": ["harina", "queso", "frutos_rojos"],
        "desc": "Base de galleta con crema de queso y coulis de frutos rojos.",
    },
    {
        "id": 8,
        "nombre": "Croissant",
        "precio": 9.0,
        "categoria": "postre",
        "img": "img/croissant.png",
        "ingredientes": ["harina", "mantequilla"],
        "desc": "Hojaldre mantecoso francés recién horneado.",
    },
    {
        "id": 9,
        "nombre": "Sándwich de Pollo",
        "precio": 16.0,
        "categoria": "sandwich",
        "img": "img/sandwich_pollo.png",
        "ingredientes": ["pan", "pollo", "lechuga", "tomate"],
        "desc": "Pan artesanal, pollo a la plancha, lechuga fresca y tomate.",
    },
    {
        "id": 10,
        "nombre": "Club Sándwich",
        "precio": 18.0,
        "categoria": "sandwich",
        "img": "img/club_sandwich.png",
        "ingredientes": ["pan", "jamon", "queso", "huevo", "lechuga"],
        "desc": "Triple piso con jamón, queso, huevo y vegetales.",
    },
    {
        "id": 11,
        "nombre": "Sándwich Veggie",
        "precio": 13.0,
        "categoria": "sandwich",
        "img": "img/veggie.png",
        "ingredientes": ["pan", "aguacate", "queso", "rucula", "tomate"],
        "desc": "Aguacate fresco, queso tierno, rúcula y tomate cherry.",
    },
    {
        "id": 12,
        "nombre": "Jugo de Naranja",
        "precio": 9.0,
        "categoria": "bebida",
        "img": "img/naranja.png",
        "ingredientes": ["naranja"],
        "desc": "Naranjas naturales exprimidas al momento.",
    },
]

# Stock de ingredientes (el pollo está agotado, consistente con Semana 7)
STOCK_INGREDIENTES = {
    "cafe": True,
    "leche": True,
    "te": True,
    "harina": True,
    "huevo": True,
    "chocolate": True,
    "mantequilla": True,
    "queso": True,
    "pan": True,
    "lechuga": True,
    "tomate": True,
    "jamon": True,
    "aguacate": True,
    "rucula": True,
    "naranja": True,
    "hielo": True,
    "frutos_rojos": True,
    "pollo": False,  # Agotado
}
