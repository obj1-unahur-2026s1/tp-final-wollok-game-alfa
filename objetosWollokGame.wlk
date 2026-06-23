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
  var property posicion
  var property color 
  method image() = "ficha" + color + ".png"
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
