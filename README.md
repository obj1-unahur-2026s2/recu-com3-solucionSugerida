# 🎵 Música Libre — Recuperatorio
## Programación con Objetos 1 — UNAHUR · 2026C2

**APELLIDO, NOMBRE:**

**DNI:**

**COMISIÓN:**

## Música Libre: apoyando a los artistas independientes

Gran parte de la música que escuchamos llega a través de plataformas como Spotify o YouTube. Sin embargo, en estos modelos los artistas independientes pueden recibir una parte reducida de los ingresos que genera su música.

**Existen otras formas de escuchar música y apoyar a quienes la crean.** Plataformas como [Bandcamp](https://bandcamp.com) y [Mirlo](https://mirlo.space) permiten comprar música y contribuir más directamente al trabajo de los artistas.

Inspirados en estas alternativas, desarrollaremos **Música Libre**, una plataforma comunitaria donde los músicos publican sus álbumes y reciben directamente el dinero de sus ventas. **Las reglas y porcentajes de este ejercicio son ficticios y fueron simplificados para practicar programación orientada a objetos.**

## Álbumes

De cada álbum se conoce su **nombre**, **artista**, **precio base**, **cantidad de canciones** y **modalidad de venta**.

Cada álbum debe poder **informar su precio de descarga** según la modalidad de venta actual.

### Modalidades de venta
Los álbumes atraviesan distintas etapas de comercialización. Todos comienzan en preventa y avanzan automáticamente a medida que se venden copias.
- ***Preventa***: las primeras 50 ventas tienen un descuento del 50% sobre el precio base.
- ***Lanzamiento***: las siguientes 100 ventas tienen un descuento del 30% sobre el precio base.
- ***Precio regular***: a partir de la venta 151, el álbum se vende a su precio base y permanece en esta modalidad.

Por ejemplo, un álbum cuyo precio base es de $10.000 se vende a $5.000 durante la preventa, a $7.000 durante el lanzamiento y a $10.000 en su etapa regular.


Los albumes deben poder **registrar una venta**: En cada venta debe actualizar su cantidad de copias vendidas y cambiar automáticamente de modalidad si corresponde.


## Usuarios

Todo usuario tiene un **nombre**, un **saldo disponible** y conoce los **álbumes que compró** (al principio, ninguno).

Cualquier usuario debe poder:

- Saber **cuánto pagaría** por un álbum dado.
- Saber **si puede comprar** un álbum. En principio, puede hacerlo si le alcanza el saldo y **todavía no lo compró**.
- **Comprar un álbum**: al hacerlo se descuenta de su saldo el importe que le corresponde pagar e incorpora el álbum a sus compras. Si no puede, debe fallar con `"Compra no permitida"` y no modificar ningún estado.
- Conocer la **cantidad total de canciones** de sus álbumes comprados.
- Obtener una lista con los **nombres** de sus álbumes comprados.

### Tipos de usuarios Especiales

#### 🎓 Estudiante
Los estudiantes cuentan con un beneficio especial para fomentar el acceso a la cultura.
- Paga **20% menos** que el precio de descarga del álbum.
- No puede comprar álbumes con **más de 15 canciones** (además de las condiciones de todos los usuarios). 
- Cada vez que realiza una compra, registra un **beneficio estudiantil utilizado**. Inicialmente no utilizó ninguno.

#### ❤️ Mecenas
Los mecenas son personas que quieren apoyar económicamente a los músicos independientes.
Además de su saldo tienen un porcentaje de aporte adicional, que inicialmente es del 20%.

- Por cada álbum que compran, pagan su precio de descarga más **el porcentaje adicional** que desean aportar.
- Pueden **aumentar su porcentaje de aporte** en cualquier momento, sin superar el 100%.
- Solo pueden comprar un álbum si tienen saldo suficiente para pagar el precio **incluyendo su aporte** (además de las condiciones de todos los usuarios).

Por ejemplo, un mecenas con un aporte del 20% paga $12.000 por un álbum cuyo precio de descarga es $10.000. Si aumenta su aporte al 50%, pagaría $15.000.

## Artistas

De cada artista se conoce el **dinero recibido por ventas** (inicialmente $0) y los **álbumes publicados** (inicialmente ninguno).

Un artista debe poder:

- **Publicar un álbum dado**: incorporándolo a lista de publicados.
- Recibir **una venta de un album a un usuario dado**: acumula en sus ingresos el pago que realiza dicho usuario por el album. 
- Indicar si **es el autor** de un album dado

## La App MusicaLibre

La app dispone de todos los artistas y usuarios registrados en la plataforma.

Se encarga de:
- **Realizar Venta de un Album dado a un Usuario especifico**: si el usuario puede realizar la compra del album debe:
    - Hacer que el usuario compre el album
    - Hacer que el artista autor del album dado reciba la venta 
    - Regitrar la venta en el album 
- Indicar el **artista con más álbumes publicados**
- Listar los usuarios que tienen **mas de una Cantidad dada** de albumes comprados
- Regalar a todos los usuarios que compraron mas de 1000 albumes un **saldo dado**. Como los usuarios mecenas quieren apoyar la industria de la música, cada vez que reciben saldo de regalo **aumentan un 10% su aporte adicional**.

---

## 🧪 Tests mínimos a realizar

Para los tests se puede preparar un único escenario con **un artista, dos álbumes** (uno de 10 canciones y otro de 18) y **tres usuarios** (común, estudiante y mecenas).

1. **Compra en preventa:** un usuario común compra un álbum de precio base $10.000. Verificar que tiene 1 álbum comprado y que el precio de descarga es $5.000.
2. **Límite estudiantil:** una estudiante no puede comprar un álbum de 18 canciones.
3. **Fin de preventa:** un álbum con 49 ventas registra una nueva venta. Verificar que su precio de descarga pasa a $7.000.
4. **Descuento estudiantil:** para un álbum con precio de descarga de $5.000, una estudiante paga $4.000.
5. **Aporte del mecenas:** un mecenas inicialmente paga $6.000 por ese mismo álbum. Si aumenta su aporte en 30 puntos porcentuales, pasa a pagar $7.500.
6. **Compra duplicada:** después de comprar un álbum, un usuario ya no puede comprarlo otra vez y mantiene 1 álbum comprado.
7. **Ingresos del artista:** una artista publica un álbum y recibe el pago de una compra común en preventa. Verificar que tiene 1 álbum publicado y $5.000 recibidos.
8. **Regalo al mecenas:** al recibir $1.000 de regalo, el aporte del mecenas aumenta del 20% al 30%; por el álbum anterior pasa a pagar $6.500.