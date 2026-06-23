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
  const property posicion
  const property color 
  method image() = "ficha" + color + ".png"
}
class Jugador {
  const property color
  const property jugadorSiguiente
  const property casillerosOcupados = []
  method image() = "jugador" + color + ".png"
  method ocuparCasillero(unCasillero){
    // Si dicha posición en el tablero está libre
    casillerosOcupados.add(unCasillero)
  }
}

object fichaRoja{
  var property image = "fichaRoja.png"
  var property position = game.at(3,3)
  //method chocarCon(unCharacter){}
}
object fichaVerde{
  var property image = "fichaVerde.png"
  var property position = game.center()
  //method chocarCon(unCharacter){}
}
object flechaSelectora {
  // Sería como una flecha que solo se debería mover horizontalmente en la parte superior, para así indicar
  // en que posición caería la próxima ficha. Su imagen debería cambiar entre rojo y verde dependiendo
  // del turno del jugador. ¿Creamos un objeto para cada jugador?
  var property image = "flechaSelectora.png"
  var property position = game.at(2,2) 
}
