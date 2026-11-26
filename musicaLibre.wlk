class Album {
  const property nombre
  const property artista
  const precioBase
  const property cantidadDeCanciones
  var cantidadDeVentas = 0
  var modalidadDeVenta = preventa

  method precioDeDescarga() = precioBase * modalidadDeVenta.descuento()
  method registrarUnaVenta() { 
    cantidadDeVentas += 1
    if (cantidadDeVentas == modalidadDeVenta.umbralDeCambio()) self.pasarASiguienteModalidad()
  }
  method pasarASiguienteModalidad() { modalidadDeVenta = modalidadDeVenta.siguienteModalidad() }
}

object preventa {
  method descuento() = 0.5 //50% de descuento
  method umbralDeCambio() = 50
  method siguienteModalidad() = lanzamiento
}

object lanzamiento {
  method descuento() = 0.7 //30% de descuento
  method umbralDeCambio() = 150
  method siguienteModalidad() = precioRegular
}

object precioRegular {
  method descuento() = 1 //0% de descuento
  //Devuelve 0: Nunca va a dar true la evaluación de condición en registrarUnaVenta(), para que no quiera reasignar innecesariamente
  method umbralDeCambio() = 0
  //Si nunca pasa la condición y no pasa a siguiente modalidad cuando ya está en precioRegular, modelando de esta manera este método nunca se ejecuta (se mantiene por polimorfismo)
  method siguienteModalidad() = self
}

class Usuario {
  const nombre //No tiene utilidad, pero el enunciado lo requiere
  var saldoDisponible
  const property albumsComprados = []

  method cantidadDeAlbumsComprados() = albumsComprados.size() //Útil para usuariosConMasAlbumsQueCantidad(cantidad) de musicaLibreApp
  method precioAPagarPorAlbum(album) = album.precioDeDescarga()
  method puedeComprarAlbum(album) = !albumsComprados.contains(album) and saldoDisponible >= album.precioDeDescarga()
  //Otra opción: Haciendo esta, no haría falta override en Mecena
  //method puedeComprarAlbum(album) = !albumsComprados.contains(album) and saldoDisponible >= self.precioAPagarPorAlbum(album) 
  method comprar(album) {
    if (!self.puedeComprarAlbum(album)) self.error("Compra no permitida.")
    saldoDisponible -= self.precioAPagarPorAlbum(album)
    albumsComprados.add(album)
  }
  method cantidadTotalDeCanciones() = albumsComprados.sum({ a => a.cantidadDeCanciones() })
  method nombresDeAlbumsComprados() = albumsComprados.map({ a => a.nombre() })
  method recibirRegalo(monto) { saldoDisponible += monto }
}

class Estudiante inherits Usuario {
  var cantidadDeBeneficiosUsados = 0

  override method precioAPagarPorAlbum(album) = super(album) * 0.8
  override method puedeComprarAlbum(album) = super(album) and album.cantidadDeCanciones() <= 15
  override method comprar(album) { super(album); cantidadDeBeneficiosUsados += 1 }
}

class Mecena inherits Usuario {
  var porcentajeDeAporteAdicional = 20

  override method precioAPagarPorAlbum(album) = super(album) * (porcentajeDeAporteAdicional / 100 + 1)
  method aumentarPorcentajeAdicional(aumento) { porcentajeDeAporteAdicional = 100.min(porcentajeDeAporteAdicional + aumento) }
  override method puedeComprarAlbum(album) = super(album) and saldoDisponible >= self.precioAPagarPorAlbum(album)
  override method recibirRegalo(monto) { super(monto); self.aumentarPorcentajeAdicional(10) }
}

class Artista {
  var dineroDeVentas = 0
  const property albumsPublicados = []

  method dineroDeVentas() = dineroDeVentas //Getter requerido para test 7
  method cantidadDeAlbumsPublicados() = self.albumsPublicados().size() //Útil para artistaConMasAlbumsPublicados() de musicaLibreApp
  method publicarAlbum(album) { albumsPublicados.add(album) }
  method recibirVentaDeAlbum(album, usuario) { dineroDeVentas += usuario.precioAPagarPorAlbum(album) }
  method esElAutorDeAlbum(album) = album.artista() == self
}

object musicaLibreApp {
  const artistas = []
  const usuarios = []

  method realizarVenta(album, usuario) {
    usuario.comprar(album)
    album.artista().recibirVentaDeAlbum(album, usuario)
    album.registrarUnaVenta()
  }

  method artistaConMasAlbumsPublicados() = artistas.max({ a => a.cantidadDeAlbumsPublicados() })
  method usuariosConMasAlbumsQueCantidad(cantidad) = usuarios.filter({ u => u.cantidadDeAlbumsComprados() > cantidad })
  method regalarSaldo(saldo) {
    self.usuariosConMasAlbumsQueCantidad(1000).forEach({ u => u.recibirRegalo(saldo) })
  }
}