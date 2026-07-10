import objetosWollokGame.*
object ia inherits Jugador(color="verde"){
    var property dificultad=estandar

    method jugarEn(unTablero) {
        dificultad.jugar(self, unTablero)
    }
}


object estandar {
    // es una criatura pobre, solo juega para ganar y sino juega cualquier cosa
    method jugar(ia, tablero) {
        var jugada = self.buscarGanadora(ia, tablero)

        if(not self.hayJugada(jugada)) {
            jugada =tablero.columnaAleatoria()
        }
        tablero.realizarJugada(jugada)
    }

    method buscarGanadora(jugador, tablero) {

        var i = 0
        var jugada = null

        tablero.columnas().forEach { col =>

            if(not self.hayJugada(jugada) && tablero.esJugadaGanadora(i, jugador)) {
                jugada = i
            }

            i = i + 1
        }

        return jugada
    }

    method hayJugada(unaJugada){
        return unaJugada!=null
    }
}

object dificil {

    method jugar(ia, tablero) {

        const enemigo = tablero.oponente(ia)
        var jugada = self.buscarGanadora(enemigo, tablero)

        if (not self.hayJugada(jugada)){
            jugada=self.buscarGanadora(ia, tablero)
        }

        if (not self.hayJugada(jugada)){
            jugada=tablero.columnaAleatoria()
        }

        tablero.realizarJugada(jugada)
    }

    method buscarGanadora(jugador, tablero) {

        var i = 0
        var jugada = null

        tablero.columnas().forEach { col =>

            if(not self.hayJugada(jugada) && tablero.esJugadaGanadora(i, jugador)) {
                jugada = i
            }

            i = i + 1
        }

        return jugada
    }

    method hayJugada(unaJugada){
        return unaJugada!=null
    }
}


object extrema {

    method jugar(ia, tablero) {

        var jugada = self.buscarGanadora(ia, tablero)

        if(not self.hayJugada(jugada)) {
            jugada = self.buscarBloqueo(ia, tablero)
        }

        if(not self.hayJugada(jugada)) {
            jugada = self.molestarJugador(tablero)
        }

        if(not self.hayJugada(jugada)) {
            jugada = self.buscarCentro(tablero)
        }

        tablero.realizarJugada(jugada)
    }

    method hayJugada(unaJugada){
        return unaJugada!=null
    }

    method buscarGanadora(jugador, tablero) {

        var i = 0
        var jugada = null

        tablero.columnas().forEach { col =>

            if(not self.hayJugada(jugada) && tablero.esJugadaGanadora(i, jugador)) {
                jugada = i
            }

            i = i + 1
        }

        return jugada
    }

    method buscarBloqueo(ia, tablero) {

        return self.buscarGanadora(tablero.oponente(ia), tablero)
    }

    method molestarJugador(tablero) {

        var ultima=null

        if ((tablero.ultimaColumnaJugada() == 0 or tablero.ultimaColumnaJugada() == 6) and tablero.columnaLlena(tablero.ultimaColumnaJugada())){
            ultima = tablero.ultimaColumnaJugada()
        }else{
            if(tablero.ultimaColumnaJugada() > 0 and self.puedoJugarAlaIzquierdaDe(tablero.ultimaColumnaJugada())){
                 ultima = tablero.ultimaColumnaJugada() - 1
            }else if(self.puedoJugarAlaDerechaDe(tablero.ultimaColumnaJugada())){
                ultima = tablero.ultimaColumnaJugada() + 1
            }
        }
        return ultima
    }

    method puedoJugarAlaIzquierdaDe(unaColumna){
        return not tablero.columnaLlena(unaColumna - 1)
    }

    method puedoJugarAlaDerechaDe(unaColumna){
        return not tablero.columnaLlena(unaColumna + 1)
    }

    method buscarCentro(tablero) {

        const orden = [3,2,4,1,5,0,6]

        var jugada = null

        orden.forEach { c =>
            if(not self.hayJugada(jugada) && not tablero.columnaLlena(c)) {
                jugada = c
            }
        }

        return jugada
    }
}