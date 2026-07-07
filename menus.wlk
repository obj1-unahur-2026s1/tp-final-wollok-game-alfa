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
        keyboard.m().onPressDo({controlDeVolumen.intercambiarMuteado()})
        keyboard.up().onPressDo({controlDeVolumen.aumentarVolumen()})
        keyboard.down().onPressDo({controlDeVolumen.bajarVolumen()})
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

        keyboard.m().onPressDo({controlDeVolumen.intercambiarMuteado()})
        keyboard.up().onPressDo({controlDeVolumen.aumentarVolumen()})
        keyboard.down().onPressDo({controlDeVolumen.bajarVolumen()})
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
    method iniciar() {
        const ia = new IA(color="Verde", dificultad=extrema)
        tablero.setterIA(ia)
        tablero.iniciar()
    }
}
object modoIADificil {
    method iniciar(){
        const ia = new IA(color="Verde", dificultad=dificil)
        tablero.setterIA(ia)
        tablero.iniciar()
    }
}

object modoIAExtrema {
    method iniciar(){
        const ia = new IA(color="Verde", dificultad=extrema)
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
        keyboard.s().onPressDo({menuPrincipal.iniciar()})
        keyboard.m().onPressDo({controlDeVolumen.intercambiarMuteado()})
        keyboard.up().onPressDo({controlDeVolumen.aumentarVolumen()})
        keyboard.down().onPressDo({controlDeVolumen.bajarVolumen()})        
    }
}
object creditos {
    const property position = game.origin()
    method image(){
        return "creditos.png"
    }
    method iniciar(){
        game.clear()
        game.addVisual(self)
        keyboard.s().onPressDo({menuPrincipal.iniciar()})
        keyboard.m().onPressDo({controlDeVolumen.intercambiarMuteado()})
        keyboard.up().onPressDo({controlDeVolumen.aumentarVolumen()})
        keyboard.down().onPressDo({controlDeVolumen.bajarVolumen()})
    }
}
object controlDeVolumen {
    var estaMuteado = false
    const musicaPrincipal = cuatroEnLinea.music()
    var volumen = 0.2
    method volumen(){
        return volumen
    }
    method intercambiarMuteado(){
        estaMuteado = not estaMuteado
        if(estaMuteado){
            musicaPrincipal.volume(0)
        }
        else{
            musicaPrincipal.volume(volumen)
        }
    } 
    method aumentarVolumen(){
        if (not estaMuteado){
            volumen = (volumen + 0.1).min(1)
            musicaPrincipal.volume(volumen)
        }
    }
    method bajarVolumen(){
        if (not estaMuteado){
            volumen = (volumen - 0.1).max(0.1)
            musicaPrincipal.volume(volumen)
        }
    }
}