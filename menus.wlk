import objetosWollokGame.*
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
        game.addVisual(botonDeVolver)

        keyboard.num1().onPressDo({modo1v1.iniciar()})
        keyboard.num2().onPressDo({modoIANormal.iniciar()})
        keyboard.num3().onPressDo({modoIAImposible.iniciar()})
        
        keyboard.s().onPressDo({menuPrincipal.iniciar()})
        keyboard.r().onPressDo({tablero.iniciar()})
    }
}
object modo1v1 {
    method iniciar(){
        tablero.iniciar()
    }
}
object modoIANormal {
    method iniciar(){
        // Se debe inicializar el modo de la IA
    }
}
object modoIAImposible {
    method iniciar(){
        // Se debe inicializar el modo de la IA
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