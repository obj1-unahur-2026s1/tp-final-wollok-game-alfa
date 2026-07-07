import objetosWollokGame.*
class IA inherits Jugador{
    const dificultad

    method jugarEn(unTablero) {
        dificultad.jugar(self, unTablero)
    }
}


object estandar {
    // es una criatura pobre, solo juega para ganar y sino juega cualquier cosa
    method jugar(ia, tablero) {

        var i = 0
        var jugada = 00

        tablero.columnas().forEach { col =>
            if(tablero.esJugadaGanadora(i, ia) && jugada == 00) {
                jugada = i
            }
            i = i + 1
        }

        if(jugada != 00) {
            tablero.realizarJugada(jugada)
        } else {
            tablero.realizarJugada(tablero.columnaAleatoria())
        }
    }
}

object dificil {

    method jugar(ia, tablero) {

        const enemigo = tablero.oponente(ia)

        var i = 0
        var jugada = null

        // 1. primero busca neutralizar enemigo
        tablero.columnas().forEach { col =>

            if(jugada == null && tablero.esJugadaGanadora(i, enemigo)) {
                jugada = i
            }

            i = i + 1
        }

        // 2. segunda prioridad es buscar la ganadora propia sino encuentra juega una columna aleatoria
        if(jugada == null) {

            i = 0

            tablero.columnas().forEach { col =>

                if(jugada == null && tablero.esJugadaGanadora(i, ia)) {
                    jugada = i
                }

                i = i + 1
            }
        }

        if(jugada != null) {
            tablero.realizarJugada(jugada)
        } else {
            tablero.realizarJugada(tablero.columnaAleatoria())
        }
    }
}


object extrema {

    method jugar(ia, tablero) {

        const enemigo = tablero.oponente(ia)

        var i = 0
        var jugada = null

        // lo primero que prioriza es ganar
        tablero.columnas().forEach { col =>

            if(jugada == null && tablero.esJugadaGanadora(i, ia)) {
                jugada = i
            }

            i = i + 1
        }

        // su segunda prioridad es bloquear al jugador
        if(jugada == null) {

            i = 0

            tablero.columnas().forEach { col =>

                if(jugada == null && tablero.esJugadaGanadora(i, enemigo)) {
                    jugada = i
                }

                i = i + 1
            }
        }
        
        //Evaluar si puede molestar al jugador
        if(jugada == null) {

            const ultima = tablero.ultimaColumnaJugada()//ultima jugada de persona

            if(ultima != null) {
                //evalua si la columna jugada fue la primera
                if(jugada == null && ultima == 0 && not tablero.columnaLlena(ultima)) {
                    jugada = ultima
                }
                //evalua si la columna jugada fue la ultima
                if(jugada == null && ultima == 6 && not tablero.columnaLlena(ultima)) {
                    jugada = ultima
                }
                //evalua si puede jugar del lado izquierdo de la ultima jugada
                if(ultima > 0 && not tablero.columnaLlena(ultima - 1)) {
                    jugada = ultima - 1
                }
                //evalua si puede jugar del lado derecho de la ultima jugada
                if(jugada == null && ultima < 6 && not tablero.columnaLlena(ultima + 1)) {
                    jugada = ultima + 1
                }
                
                
            }   
        }

        // esto es algo que se me ocurrio para la mayor dificultad, podriamos decir que el centro es lo preferido en este tipo de juegos, entonces cree una lista con los mas centricos en el medio para que utilice
        if(jugada == null) {

            const orden = [3,2,4,1,5,0,6]

            orden.forEach { c =>
                if(jugada == null &&
                    not tablero.columnaLlena(c)) {
                    jugada = c
                }
                }

            // Si no encontró ninguna columna útil,
            // juega la mejor disponible.
            if(jugada == null) {
                orden.forEach { c =>
                if(jugada == null && not tablero.columnaLlena(c)) {
                    jugada = c
                    }
                }
            }
        }   
        tablero.realizarJugada(jugada)
    }
}