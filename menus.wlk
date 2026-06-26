import objetosWollokGame.*
import IA-Dificultades.*
object menuPrincipal {
    const property position = game.origin()
    method image(){
        return "menuPrincipal.png"
    }
    method iniciar(){
        game.clear()
        game.addVisual(self)
        keyboard.num1().onPressDo({modosDeJuego.iniciar()})
	    keyboard.num2().onPressDo({instrucciones.iniciar()})
	    keyboard.num3().onPressDo({creditos.iniciar()})
    }
}
object modosDeJuego {
    const property position = game.origin()
    method image(){
        return "modosDeJuego.png"
    }
    method iniciar(){
        game.clear()
        game.addVisual(self)
 

        keyboard.num1().onPressDo({modo1v1.iniciar()})
        keyboard.num2().onPressDo({modoIAestandar.iniciar()})
        keyboard.num3().onPressDo({modoIADificil.iniciar()})
        keyboard.num4().onPressDo({modoIAExtrema.iniciar()})
        
        keyboard.s().onPressDo({menuPrincipal.iniciar()})
        keyboard.r().onPressDo({tablero.iniciar()})
    }
}
object modo1v1 {
    method iniciar(){
        tablero.iniciar()
        tablero.setterIA(null)
    }
}
object modoIAestandar {
    method iniciar() {//AGREGADO TOMAS 25/06 22:24
        const ia = new IA(color="Verde", dificultad=extrema)
        tablero.setterIA(ia)
        tablero.iniciar()
    }
}
object modoIADificil {
    method iniciar(){//AGREGADO TOMAS 25/06 22:24
        // Se debe inicializar el modo de la IA
        const ia new IA(color="Verde", dificultad=dificil)
        tablero.setterIA(ia)
        tablero.iniciar()
    }
}

object modoIAExtrema {
    method iniciar(){//AGREGADO TOMAS 25/06 22:24
        // Se debe inicializar el modo de la IA
        const ia new IA(color="Verde", dificultad=extrema)
        tablero.setterIA(ia)
        tablero.iniciar()
    }
}
object instrucciones {
    const property position = game.origin()
    method image(){
        return "instrucciones.png"
    }
    method iniciar(){
        game.clear()
        game.addVisual(self)
        game.addVisual(botonDeVolver)
        keyboard.s().onPressDo({menuPrincipal.iniciar()})        
    }
}
object creditos {
    const property position = game.origin()
    method image(){
        return // Acá debe estar la imagen de modos de creditos
    }
    method iniciar(){
        game.removeVisual(menuPrincipal)
        game.addVisual(self)
        game.addVisual(botonDeVolver)
        keyboard.s().onPressDo({menuPrincipal.iniciar()})
    }
}
object botonDeVolver {
    const property position = game.at(6,2)  // Se puede modificar la posición
    method image(){
        return "botonVolver.png"
    }
    method iniciar(){
        game.clear()
    }
}