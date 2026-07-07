import wollok.game.*
import menus.*
import IA-Dificultades.*
object cuatroEnLinea{

  //Config Audio
  const music = game.sound("InideGame.mp3")
  method music(){
    return music
  }

  method iniciar(){

    //Set game properties
    game.title("CuatroEnLinea")
    game.width(7)
	  game.height(9)
    game.cellSize(200)
    
    //Set Background Audio
    music.shouldLoop(true)
    music.volume(controlDeVolumen.volumen())
    music.play()

    //Inicializar menu y teclado
    menuPrincipal.iniciar()
  }
}
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

object tablero {
  var ultimaColumnaJugada=null
  var ia=null
  var tecladoBloqueado = false
  const property image = "tablero.png"
  const property position = game.origin()
  const property columnas = [
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
  var marcador = new Turno(color = jugadorActual.color())
  
  method setterIA(unaIA){
    ia=unaIA
  }

  method ultimaColumnaJugada(){
    return ultimaColumnaJugada
  }

  method iniciar(){
    game.clear()
    tecladoBloqueado = false
    self.limpiarColumnas()
    game.addVisual(self)
    jugadorActual = jugadores.first()
    game.addVisual(marcador)
    (1..7).forEach({n => keyboard.num(n).onPressDo{self.realizarJugada(n - 1)} })
    keyboard.s().onPressDo({modosDeJuego.iniciar()})
    keyboard.m().onPressDo({controlDeVolumen.intercambiarMuteado()})
    keyboard.up().onPressDo({controlDeVolumen.aumentarVolumen()})
    keyboard.down().onPressDo({controlDeVolumen.bajarVolumen()})

  }
  method limpiarColumnas(){
    columnas.forEach({c=> c.clear()})
  }
  method verJugada(columna, color){
    game.addVisual(
      new Ficha(position = columnas.get(columna), color = color))
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
    return jugadores.find({j => j != jugador}) // Como la lista de jugadores es de 2 busca el que no sea el actual
  }

  method cambiarTurno() {
    jugadorActual = self.oponente(jugadorActual)
    marcador = new Turno(color = jugadorActual.color())
    game.addVisual(marcador) 
    if (self.estaJugandoLaIA()){
      tecladoBloqueado = true
      game.schedule(600, {
        tecladoBloqueado = false
        ia.jugarEn(self)
      })
    }
  }
  method estaJugandoLaIA(){
    return ia != null && jugadorActual.color() == "Verde"
  }
 
  method agregarFicha(columna) {
    if (columnas.get(columna).size() >= 6) {
      throw new Exception(message = "La columna está llena")
    }
    const fila = columnas.get(columna).size() // Consigo la fila para el position de la ficha
    const ficha = new Ficha(color = jugadorActual.color(),position=game.at(columna,fila))
    columnas.get(columna).add(ficha) // Agrego la ficha y el visual
    game.addVisual(ficha)
  }
  
  method realizarJugada(columna) {
    if (not tecladoBloqueado) {
      
      if(not self.estaJugandoLaIA()) {
        ultimaColumnaJugada = columna //para la dificultad extrema, lo guarda para que la IA rompa las bolas
      }

      self.agregarFicha(columna)
      game.sound("caida.mp3").play()
      const fila = columnas.get(columna).size() - 1 
      game.removeVisual(marcador)
    
      if(self.hayVictoria(columna,fila,jugadorActual.color())){
        if (self.estaJugandoLaIA()){
          iaGanadora.iniciar()
        }
        else {
          new victoria(color = jugadorActual.color()).iniciar()
        }
      }
      else if(self.esEmpate()){
        empate.iniciar()
      }
      else {
        self.cambiarTurno()
      }
    }
  }


  method hayVictoria(columna,fila,color) { // Verifica todas las posibles victorias
    return self.hayVictoriaHorizontal(columna,fila,color) || self.hayVictoriaDiagonalDerecha(columna,fila,color) || self.hayVictoriaDiagonalIzquierda(columna,fila,color) || self.hayVictoriaVertical(columna,fila,color)
  }
  
  method esEmpate(){
    return columnas.all { col => col.size() >= 6}
    
    
  }
  
  method fichaEn(columna,fila) {
    if(columna < 0 || columna >= columnas.size()) {
      return null // Si la columna está fuera de rango devuelve null
    }             // Pongo null para que si no es válido corte la recursividad en el método contar
    
    const col = columnas.get(columna)
    
    if (fila < 0 || fila >= col.size()) {
      return null // idem que en columna
    }
    return col.get(fila) // Si pasa los 2 if anteriores retorno la ficha
  }

  method contar(columna,fila,dx,dy,color) {  // Paso por parametro la columna, fila y color. Además dx y dy son números para poder ir buscando en
    const ficha = self.fichaEn(columna,fila)   // las casillas lindantes

    if (ficha == null || ficha.color() != color) { // Si en el método fichaEn retorno null retorna 0, cortando la recursividad
      return 0                                     // Lo mismo si encuentra una ficha de otro color
    }

    return 1 + self.contar(columna + dx,fila + dy, dx, dy, color) // Return recursivo para contar fichas
  }

  method hayVictoriaHorizontal(columna,fila,color) {
    return 1 + self.contar(columna + 1,fila,1,0,color) + self.contar(columna - 1,fila, -1, 0,color) >= 4
  }         // El primer self.contar cuenta hacia la derecha y el segundo hacia la izquierda, al ser horizontal dy vale 0, ya que hay que moverse en la misma fila

  method hayVictoriaDiagonalDerecha(columna,fila,color) {
    return 1 + self.contar(columna + 1, fila - 1 , 1 , -1 , color) + self.contar(columna - 1, fila + 1 , -1 , 1 , color) >= 4
  }                      //columna      fila       dx  dy   color, cada self.contar busca para cada lado de la diagonal, si encuentra 3 o más fichas devuelve true
                         //verificando que el jugador ganó
  method hayVictoriaDiagonalIzquierda(columna,fila,color) {
    return 1 + self.contar(columna + 1 , fila + 1 , 1 , 1 , color) + self.contar(columna - 1 , fila - 1 , -1 , -1 , color) >= 4
  }             // idem que el otro victoria diagonal, pero en sentido contrario

  method hayVictoriaVertical(columna,fila,color) {
    return 1 + self.contar(columna,fila - 1,0,-1,color) >= 4
  }           // este contar solo busca hacia abajo, ya que nunca podría haber una ficha arriba de una recién puesta
  
  method esJugadaGanadora(columna, unJugador) {
    //este metodo utiliza una ficha fantasma para detectar que pasa si una ficha real se coloca en la posicion, con esto asi se pueden reutilizar los metodos que detectan victorias
    var band=true
    if(self.columnaLlena(columna)) {
      band=false
    }else{
      self.agregarFichaTemporal(columna, unJugador.color())
      const fila = columnas.get(columna).size() - 1
      band = self.hayVictoria(columna,fila,unJugador.color())
      self.sacarFichaTemporal(columna)
    }
    return band
  }

  method columnaAleatoria() {

    const disponibles = []
    var i = 0

    columnas.forEach { col =>
        if(col.size() < 6) {
            disponibles.add(i)
        }
        i = i + 1
    }

    return disponibles.anyOne()
  }

  method columnaLlena(columna) { //Lo uso para detectar en jugada ganadora
    return columnas.get(columna).size() >= 6
  }

  method agregarFichaTemporal(columna, color) {//Lo uso para detectar en jugada ganadora
    columnas.get(columna).add(new Ficha(color = color, position = game.at(columna, columnas.get(columna).size())))
  }

  method sacarFichaTemporal(columna) {//Lo uso para detectar en jugada ganadora
    const col = columnas.get(columna)
    col.remove(col.last())
  }
  
  
}

class victoria {
  const property color
  const property position = game.origin()
  method image() = "pantallaGanaste" + color + ".png"
  method iniciar(){
    game.clear()
    game.sound("congratulations.mp3").play()
    game.addVisual(self)
    keyboard.s().onPressDo({menuPrincipal.iniciar()})
    keyboard.r().onPressDo({tablero.iniciar()})
  }
}
object iaGanadora {
  var property image = "pantallaIaGano.png"
  const property position = game.origin()
  method iniciar(){
    game.clear()
    game.sound("youLose.mp3").play()
    game.addVisual(self)
    keyboard.s().onPressDo({menuPrincipal.iniciar()})
    keyboard.r().onPressDo({tablero.iniciar()})
  }
}
object empate {
  var property image = "empate.png"
  const property position = game.origin()
  const music = game.sound("youLose.mp3")
  method iniciar(){
    game.clear()    
    music.play()
    game.addVisual(self)
    keyboard.s().onPressDo({menuPrincipal.iniciar()})
    keyboard.r().onPressDo({tablero.iniciar()})
  }
}
class Turno {
  const property color 
  method image(){
    if(not tablero.estaJugandoLaIA()){
      return "turno" + color + ".png"
    }
    return "turnoIA.png"
  }
  method position() = game.at(4.5,7)
}
