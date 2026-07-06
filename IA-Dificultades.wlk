import objetosWollokGame.*
class IA inherits Jugador{
    const property probocaciones = []
    const dificultad
    
    //method insultar() {
    //    return probocaciones.anyOne()
    //}

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
        var jugada = 00

        // 1. primero busca neutralizar enemigo
        tablero.columnas().forEach { col =>

            if(jugada == 00 && tablero.esJugadaGanadora(i, enemigo)) {
                jugada = i
            }

            i = i + 1
        }

        // 2. segunda prioridad es buscar la ganadora propia sino encuentra juega una columna aleatoria
        if(jugada == 00) {

            i = 0

            tablero.columnas().forEach { col =>

                if(jugada == 00 && tablero.esJugadaGanadora(i, ia)) {
                    jugada = i
                }

                i = i + 1
            }
        }

        if(jugada != 00) {
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
        var jugada = 00

        // lo primero que prioriza es ganar
        tablero.columnas().forEach { col =>

            if(jugada == 00 && tablero.esJugadaGanadora(i, ia)) {
                jugada = i
            }

            i = i + 1
        }

        // su segunda prioridad es bloquear al jugador
        if(jugada == 00) {

            i = 0

            tablero.columnas().forEach { col =>

                if(jugada == 00 && tablero.esJugadaGanadora(i, enemigo)) {
                    jugada = i
                }

                i = i + 1
            }
        }
        
        //Romper las bolas
        if(jugada == 00) {

            const ultima = tablero.ultimaColumnaJugada()//ultima jugada de persona

            if(ultima != 00) {
                
                //evalua si puede jugar del lado izquierdo de la ultima jugada
                if(ultima > 0 && not tablero.columnaLlena(ultima - 1)) {
                    jugada = ultima - 1
                }
                //evalua si puede jugar del lado derecho de la ultima jugada
                if(jugada == 00 && ultima < 6 && not tablero.columnaLlena(ultima + 1)) {
                    jugada = ultima + 1
                }
            }
        }

        // esto es algo que se me ocurrio para la mayor dificultad, podriamos decir que el centro es lo preferido en este tipo de juegos, entonces cree una lista con los mas centricos en el medio para que utilice
        if(jugada == 00) {

            const orden = [3,2,4,1,5,0,6]

            orden.forEach { c =>
                if(jugada == 00 &&
                    not tablero.columnaLlena(c)) {
                    jugada = c
                }
                }

            // Si no encontró ninguna columna útil,
            // juega la mejor disponible.
            if(jugada == 00) {
                orden.forEach { c =>
                if(jugada == 00 && not tablero.columnaLlena(c)) {
                    jugada = c
                    }
                }
            }
        }   
        tablero.realizarJugada(jugada)
    }
}