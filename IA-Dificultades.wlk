import objetosWollokGame.*
object ia inherits Jugador(color = "Verde"){
    
    var property dificultad=estandar

    method jugarEn(unTablero) {
        dificultad.jugar(self, unTablero)
    }
}


object estandar {
    // es una criatura pobre, solo juega para ganar y sino juega cualquier cosa
    method jugar(ia, tablero) {
        var jugada = self.buscarGanadora(ia, tablero) //devuelve un número de columna ganadora si hay jugada ganadora, sino devuelve null

        if(not self.hayJugada(jugada)) {
            jugada =tablero.columnaAleatoria()
        }
        tablero.realizarJugada(jugada) // jugada en este caso es el número de la columna que se va a jugar
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
        //si no entra en ningún if va a buscar una jugada ganadora
        var jugada = self.buscarGanadora(ia, tablero)
        //si puede bloquear al jugador para que no gane
        if(not self.hayJugada(jugada)) {
            jugada = self.buscarBloqueo(ia, tablero)
        }
        //si pone una ficha a los costados o encima para molestar
        if(not self.hayJugada(jugada)) {
            jugada = self.molestarJugador(tablero)
        }
        //si puede buscar el centro
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
            // si es la columna 1 o la 7 le va a poner una ficha encima
        if ((tablero.ultimaColumnaJugada() == 0 or tablero.ultimaColumnaJugada() == 6) and not tablero.columnaLlena(tablero.ultimaColumnaJugada())){
            ultima = tablero.ultimaColumnaJugada()
        }else{
            //si no es la columna 1 o la 7  le va a poner una ficha del lado que pueda
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
            // orden de importancia de las columnas
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