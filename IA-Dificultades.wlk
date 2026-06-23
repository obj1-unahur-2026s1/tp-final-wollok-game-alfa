object ia{
    const property probocaiones = []
    var dificultad=estandar

    method cambiarDificultad(unaDificultad){dificultad=unaDificultad}

    method realizarMovimiento(unaPosicion){
        //ESTO SE DEFINE POR COMO SE UTILIZARA EL TABLERO
    }

    method insultar(){
        return probocaiones.anyOne()
    }

    method estudiarTablero(unaPosicion){
        dificultad.mejorMovimiento(self, unaPosicion) //ESTO LLAMA A realiazrMOVIEMIENTO POR LO QUE EL MOVIMIENTO A EJECUTAR LO DECIDE LA DIFICULTAD LLAMANDO AL METODO DE IA
    }

    method mejorMovimiento(){
        //ESTO DEBERIA DEVOLVER LA POSICION DONDE PONER UNA FICHA SIGNIFICA LA VICTORIA
    }

    method contratacar(unJugador){
        //ESTO DEBERIA DEVOLVER UNA POSICION DONDE CAGAR AL JUGADOR
    }

}


object estandar{
    method mejorMovimiento(unaIA, unaPosicion){
        if (self.puedeGanar(unaIA)){
            unaIA.realizarMovimiento(unaIA.mejorMovimiento())
        }else{
            unaIA.realizarMovimiento(unaPosicion)
        }
    }

    method puedeGanar(entidad){
        return true //ESTO SE CAMBIA CUANDO YA ESTE DEFINIDO COMO SE DETECTAN LAS VICTORIAS POSIBLES
    }
}

object dificil{
    method mejorMovimiento(unaIA, unaPosicion){
        if (self.puedeGanar(unJugador)){ //UN JUGADOR NO ESTA DEFINIDO TODAVIA POR ESO NO COMPLETO LO QUE FALTA
            unaIA.realizarMovimiento(unaIA.contratacar(unJugador))

        }else if(self.puedeGanar(unaIA)){
            unaIA.realizarMovimiento(unaIA.mejorMovimiento())
            
        }else{
            unaIA.realizarMovimiento(unaPosicion)
        }
    }

    method puedeGanar(entidad){
        return true //ESTO SE CAMBIA CUANDO YA ESTE DEFINIDO COMO SE DETECTAN LAS VICTORIAS POSIBLES, DEJO ENTIDAD PORQUE PODRIAMOS USAR EL METODO PARA JUGADOR TAMBIEN
    }
}


object extrema{
    method mejorMovimiento(unaIA, unaPosicion){
        if (not self.puedeGanar(unaIA)){
            if (self.puedeGanar(unJugador)){
                unaIA.realizarMovimiento(unaIA.contratacar(unJugador))
                unaIA.insultar()
            }else if(not self.puedeGanar(unJugador)){
                unaIA.realizarMovimiento(unaIA.contratacar(unJugador))
                unaIA.insultar()
            }
        }else{
            unaIA.realizarMovimiento(unaIA.mejorMovimiento())
        }
    }

    method puedeGanar(entidad){
        return true //ESTO SE CAMBIA CUANDO YA ESTE DEFINIDO COMO SE DETECTAN LAS VICTORIAS POSIBLES, DEJO ENTIDAD PORQUE PODRIAMOS USAR EL METODO PARA JUGADOR TAMBIEN
    }
}