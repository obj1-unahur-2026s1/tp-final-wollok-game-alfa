import wollok.game.*


object unCharacter{
  //var property position = game.origin()
  //var property image = "unaImagen.png"
  //var vidas = 3

  /*method resetPosition() {
		position = game.origin()
	}*/
}
class Ficha {
  var property posicion
  var property color 
  method image() = "ficha" + color + ".png"
}
object fichaRoja{
  var property image = "fichaRoja.png"
  var property position = game.center()
  //method chocarCon(unCharacter){}
}
object fichaVerde{
  var property image = "fichaVerde.png"
  var property position = game.center()
  //method chocarCon(unCharacter){}
}
