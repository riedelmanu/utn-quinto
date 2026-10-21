# Trabajo Práctico I - Espacios Métricos: funciones de distancia
# Gestión Avanzada de Datos - UTN FRCU
#
# Cálculos de los ejercicios 1, 2, 4 y 5. Se corre con: python3 tp4_distancias.py

import math
import random
import unicodedata


# ---------------------------------------------------------------------------
# Ejercicio 1: distancias de edición

NOMBRES = ["Horacio", "Mariel", "Raul", "Mirta", "Emanuel", "Sandra", "Agostina",
           "Kesia", "Yamila", "Belen", "Anastasia", "Agustín", "Luciano", "Irene",
           "Martin", "Manuel", "Nancy", "Kenny", "Marta", "Casandra", "Agustina",
           "Ayelen", "Yanina", "Jerónimo", "Juan", "Julián", "Cristian", "León"]


def preparar(cadena):
    # Se compara en minúscula y sin tildes, así "Martin" y "martín" no cuentan distinto
    sin_tildes = unicodedata.normalize("NFD", cadena)
    sin_tildes = "".join(c for c in sin_tildes if unicodedata.category(c) != "Mn")
    return sin_tildes.lower()


def levenshtein(a, b):
    # Matriz de programación dinámica: d[i][j] es la distancia entre a[:i] y b[:j]
    d = [[0] * (len(b) + 1) for _ in range(len(a) + 1)]
    for i in range(len(a) + 1):
        d[i][0] = i
    for j in range(len(b) + 1):
        d[0][j] = j
    for i in range(1, len(a) + 1):
        for j in range(1, len(b) + 1):
            costo = 0 if a[i - 1] == b[j - 1] else 1
            d[i][j] = min(d[i - 1][j] + 1,          # eliminación
                          d[i][j - 1] + 1,          # inserción
                          d[i - 1][j - 1] + costo)  # reemplazo
    return d[len(a)][len(b)]


def damerau_levenshtein(a, b):
    # Igual que Levenshtein, más la transposición de dos letras vecinas
    d = [[0] * (len(b) + 1) for _ in range(len(a) + 1)]
    for i in range(len(a) + 1):
        d[i][0] = i
    for j in range(len(b) + 1):
        d[0][j] = j
    for i in range(1, len(a) + 1):
        for j in range(1, len(b) + 1):
            costo = 0 if a[i - 1] == b[j - 1] else 1
            d[i][j] = min(d[i - 1][j] + 1,
                          d[i][j - 1] + 1,
                          d[i - 1][j - 1] + costo)
            if i > 1 and j > 1 and a[i - 1] == b[j - 2] and a[i - 2] == b[j - 1]:
                d[i][j] = min(d[i][j], d[i - 2][j - 2] + 1)  # transposición
    return d[len(a)][len(b)]


def matriz_de_distancias(objetos, funcion):
    n = len(objetos)
    m = [[0] * n for _ in range(n)]
    evaluaciones = 0
    for i in range(n):
        for j in range(i + 1, n):
            m[i][j] = m[j][i] = funcion(objetos[i], objetos[j])
            evaluaciones += 1
    return m, evaluaciones


def pares_extremos(nombres, m):
    pares = [(m[i][j], nombres[i], nombres[j])
             for i in range(len(nombres)) for j in range(i + 1, len(nombres))]
    minimo = min(p[0] for p in pares)
    maximo = max(p[0] for p in pares)
    return ([p for p in pares if p[0] == minimo], [p for p in pares if p[0] == maximo])


# ---------------------------------------------------------------------------
# Ejercicio 4: jugadores de handball

# (edad, estatura, color de pelo, color de piel, peso)
JUGADORES = [(30, 1.85, 2, 4, 83),
             (25, 1.60, 9, 6, 65),
             (20, 1.80, 3, 9, 78),
             (28, 2.05, 4, 2, 98),
             (23, 1.82, 6, 8, 87),
             (18, 1.76, 5, 7, 84),
             # los tres que agregamos
             (27, 1.90, 7, 5, 92),
             (28, 1.80, 5, 7, 75),
             (33, 1.78, 8, 10, 80)]

# Mínimos y máximos elegidos para normalizar cada atributo a la escala 0 a 100
MINIMOS = (15, 1.50, 1, 1, 55)
MAXIMOS = (40, 2.10, 10, 10, 110)


def normalizar(v, minimos, maximos):
    return tuple((x - mn) / (mx - mn) * 100 for x, mn, mx in zip(v, minimos, maximos))


def manhattan(x, y):
    return sum(abs(a - b) for a, b in zip(x, y))


def euclidiana(x, y):
    return math.sqrt(sum((a - b) ** 2 for a, b in zip(x, y)))


def maxima(x, y):
    return max(abs(a - b) for a, b in zip(x, y))


def coseno(x, y):
    # distancia coseno = 1 - similitud coseno
    producto = sum(a * b for a, b in zip(x, y))
    norma_x = math.sqrt(sum(a * a for a in x))
    norma_y = math.sqrt(sum(b * b for b in y))
    return 1 - producto / (norma_x * norma_y)


FUNCIONES = [("Manhattan", manhattan), ("Euclidiana", euclidiana),
             ("Máxima", maxima), ("Coseno", coseno)]


def consulta_por_rango(base, q, r, funcion):
    # todos los objetos a distancia menor o igual que r de q
    return [(i, funcion(q, x)) for i, x in enumerate(base) if funcion(q, x) <= r]


def vecino_mas_cercano(base, q, funcion):
    distancias = [(funcion(q, x), i) for i, x in enumerate(base)]
    d, i = min(distancias)
    return i, d


# ---------------------------------------------------------------------------
# Ejercicio 5: mejores clientes

# (característica, peso, mínimo, máximo)
CARACTERISTICAS = [("Monto comprado en el año ($)", 0.30, 50000, 5000000),
                   ("Cantidad de compras en el año", 0.20, 1, 60),
                   ("Días promedio de atraso en el pago", 0.25, 0, 90),
                   ("Antigüedad como cliente (años)", 0.15, 0, 20),
                   ("Porcentaje de compras devueltas (%)", 0.10, 0, 15)]

# Vector consulta "mejor cliente" ya normalizado: lo máximo en lo que conviene que sea
# alto (monto, compras, antigüedad) y lo mínimo en lo que conviene que sea bajo
MEJOR_CLIENTE = (100, 100, 0, 100, 0)


def generar_clientes(cantidad, semilla=2026):
    random.seed(semilla)
    clientes = []
    for _ in range(cantidad):
        monto = random.randint(50000, 5000000)
        compras = random.randint(1, 60)
        atraso = random.randint(0, 90)
        antiguedad = random.randint(0, 20)
        devoluciones = round(random.uniform(0, 15), 1)
        clientes.append((monto, compras, atraso, antiguedad, devoluciones))
    return clientes


def euclidiana_con_pesos(x, y, pesos):
    return math.sqrt(sum(w * (a - b) ** 2 for a, b, w in zip(x, y, pesos)))


def vecinos_mas_cercanos(base, q, k, funcion):
    distancias = sorted((funcion(q, x), i) for i, x in enumerate(base))
    return [(i, d) for d, i in distancias[:k]]


# ---------------------------------------------------------------------------

def imprimir_matriz(etiquetas, m, decimales=0):
    print(" " * 10 + "".join(f"{e[:6]:>8}" for e in etiquetas))
    for e, fila in zip(etiquetas, m):
        print(f"{e[:10]:<10}" + "".join(f"{x:>8.{decimales}f}" for x in fila))


if __name__ == "__main__":
    nombres = [preparar(n) for n in NOMBRES]

    print("EJERCICIO 1 Y 2")
    for titulo, funcion in [("Levenshtein", levenshtein), ("Damerau-Levenshtein", damerau_levenshtein)]:
        m, evaluaciones = matriz_de_distancias(nombres, funcion)
        print(f"\n{titulo} ({evaluaciones} evaluaciones de la función)")
        imprimir_matriz(NOMBRES, m)
        cerca, lejos = pares_extremos(NOMBRES, m)
        print("Pares más parecidos:", cerca)
        print("Pares más distintos:", lejos)

    print("\nEJERCICIO 4")
    base = [normalizar(j, MINIMOS, MAXIMOS) for j in JUGADORES]
    etiquetas = [f"J{i + 1}" for i in range(len(base))]
    for j, v in zip(etiquetas, base):
        print(j, [round(x, 2) for x in v])
    for nombre, funcion in FUNCIONES:
        m, _ = matriz_de_distancias(base, funcion)
        print(f"\nDistancia {nombre}")
        imprimir_matriz(etiquetas, m, 3 if nombre == "Coseno" else 2)
        valores = [m[i][j] for i in range(len(base)) for j in range(i + 1, len(base))]
        print(f"Media: {sum(valores) / len(valores):.3f}")

    q1 = normalizar((26, 1.75, 4, 8, 72), MINIMOS, MAXIMOS)
    print("\nConsulta por rango", [round(x, 2) for x in q1], "radio 25")
    print("Euclidiana:", consulta_por_rango(base, q1, 25, euclidiana))
    print("Manhattan:", consulta_por_rango(base, q1, 25, manhattan))

    q2 = normalizar((23, 1.95, 3, 4, 97), MINIMOS, MAXIMOS)
    print("\nVecino más cercano de", [round(x, 2) for x in q2])
    for nombre, funcion in FUNCIONES:
        i, d = vecino_mas_cercano(base, q2, funcion)
        print(f"{nombre}: J{i + 1} a distancia {d:.3f}")

    print("\nEJERCICIO 5")
    clientes = generar_clientes(100)
    minimos = [c[2] for c in CARACTERISTICAS]
    maximos = [c[3] for c in CARACTERISTICAS]
    pesos = [c[1] for c in CARACTERISTICAS]
    normalizados = [normalizar(c, minimos, maximos) for c in clientes]
    for i, (c, n) in enumerate(zip(clientes, normalizados), start=1):
        print(i, c, [round(x, 2) for x in n])
    print("\nMejor cliente:", MEJOR_CLIENTE)
    for i, d in vecinos_mas_cercanos(normalizados, MEJOR_CLIENTE, 2,
                                     lambda x, y: euclidiana_con_pesos(x, y, pesos)):
        print(f"Cliente {i + 1}: {clientes[i]} normalizado {[round(x, 2) for x in normalizados[i]]} distancia {d:.2f}")
