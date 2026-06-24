import wollok.game.*

// object unCharacter{
//   //var property position = game.origin()
//   //var property image = "unaImagen.png"
//   //var vidas = 3

//   /*method resetPosition() {
// 		position = game.origin()
// 	}*/
// }
class Ficha {
  const property position
  const property color 
  method image() = "ficha" + color + ".png"
}
class Jugador {
  const property color
  const property casillerosOcupados = []
  method image() = "jugador" + color + ".png"
  method ocuparCasillero(unCasillero){
    casillerosOcupados.add(unCasillero)
  }
}

object flechaSelectora {
  // Sería como una flecha que solo se debería mover horizontalmente en la parte superior, para así indicar
  // en que posición caería la próxima ficha. Su imagen debería cambiar entre rojo y verde dependiendo
  // del turno del jugador. ¿Creamos un objeto para cada jugador?
  var property image = "flechaSelectora.png"
  var property position = game.at(2,2) 
}


object tablero {
  const property image = "tablero.png"
  const property position = game.origin()
  const columnas = [
	[],
  [],
  [],
  [],
  [],
  [],
  []
  ]

  const jugadores = [new Jugador(color="Roja"),new Jugador(color="Verde")]
  var jugadorActual = jugadores.first()

  

  method iniciar(){
    game.clear()
    // game.width(7)
	  // game.height(9)
    // game.cellSize(200)
    game.addVisual(self)
    (1..6).forEach({n => keyboard.num(n).onPressDo{self.realizarJugada(n)} })
  }
  method verJugada(columna, color){
    game.addVisual(
      new Ficha(position = columnas.get(columna), color = color))
  }
  method mensaje(resultado, columna){
    game.say(self.fichaEn(columna), resultado.mensaje())
  }
  method fichaEn(columna){
    return game.getObjectsIn(columnas.get(columna).last())
  }
  method mostrarFichas(fichas){
    game.addVisual(fichas.first())
    game.addVisual(fichas.last())
  }
  method mostrarJugadores(){
    game.addVisual(jugadores)
  }
  method vaciar(cols){
    columnas.forEach({c => game.removeVisual(self.fichaEn(c))})
  }

  method oponente(jugador) {
    return jugadores.find({j => j != jugadorActual})
  }

  method cambiarTurno() {
    jugadorActual = self.oponente(jugadorActual)
  }
  
  method agregarFicha(columna) {
    if (columnas.get(columna).size() >= 6) {
      throw new Exception(message = "La columna está llena")
    }
    var fila = columnas.get(columna).size()
    var ficha = new Ficha(color = jugadorActual.color(),position=game.at(columna,fila))
    columnas.get(columna).add(ficha)
    game.addVisual(ficha)
  }
  
  method realizarJugada(columna){
    self.agregarFicha(columna)
    var fila = columnas.get(columna).size() - 1
    
    if(self.hayVictoria(columna,fila,jugadorActual.color())){
      game.say(self.fichaEn(columna,fila),"Ganó " + jugadorActual.color())
    }
    else {
      self.cambiarTurno()
    }
  }

  method hayVictoria(columna,fila,color) {
    return self.hayVictoriaHorizontal(columna,fila,color) || self.hayVictoriaDiagonalDerecha(columna,fila,color) || self.hayVictoriaDiagonalIzquierda(columna,fila,color) || self.hayVictoriaVertical(columna,fila,color)
  }

  method fichaEn(columna,fila) {
    if(columna < 0 || columna >= columnas.size()) {
      return null // Pongo null para que si no es válido no rompa el programa al probarlo
    }
    var col = columnas.get(columna)
    
    if (fila < 0 || fila >= col.size()) {
      return null // idem que en columna
    }

    return col.get(fila)
  }

  method contar(columna,fila,dx,dy,color) {
    var ficha = self.fichaEn(columna,fila)

    if (ficha == null || ficha.color() != color) {
      return 0
    }

    return 1 + self.contar(columna + dx,fila + dy, dx, dy, color)
  }

  method hayVictoriaHorizontal(columna,fila,color) {
    return 1 + self.contar(columna + 1,fila,1,0,color) + self.contar(columna - 1,fila, -1, 0,color) >= 4
  }         // El primer self.contar cuenta hacia la derecha y el segundo hacia la izquierda

  method hayVictoriaDiagonalDerecha(columna,fila,color) {
    return 1 + self.contar(columna + 1,fila - 1,1,-1,color) + self.contar(columna - 1,fila + 1,-1,1,color) >= 4
  }
  method hayVictoriaDiagonalIzquierda(columna,fila,color) {
    return 1 + self.contar(columna + 1,fila + 1,1,1,color) + self.contar(columna - 1,fila - 1,-1,-1,color) >= 4
  }

  method hayVictoriaVertical(columna,fila,color) {
    return 1 + self.contar(columna,fila - 1,0,-1,color) >= 4
  }
}

