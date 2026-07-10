import objetosWollokGame.*
import IA-Dificultades.*
class Menu {
    const property position = game.origin()
    method image()
    method iniciar(){
        game.clear()
        game.addVisual(self)
        keyboard.m().onPressDo({controlDeVolumen.intercambiarMuteado()})
        keyboard.up().onPressDo({controlDeVolumen.aumentarVolumen()})
        keyboard.down().onPressDo({controlDeVolumen.bajarVolumen()})
        keyboard.s().onPressDo({menuPrincipal.iniciar()})
    }
}
class ModoIA {

    method iniciar() {
        ia.dificultad(self.dificultad())
        tablero.setterIA(ia)
        tablero.iniciar()
    }

    method dificultad()
}
class Victoria inherits Menu {
    const property color
    override method image(){
        return "pantallaGanaste" + color + ".png"
    }
    override method iniciar(){
        super()
        game.sound("congratulations.mp3").play()
        keyboard.r().onPressDo({tablero.iniciar()})
    }
}
object empate inherits Menu {
    override method image(){
        return "empate.png"
    }
    override method iniciar(){
        super()
        game.sound("youLose.mp3").play()
        keyboard.r().onPressDo({tablero.iniciar(); tablero.cambiarTurno()})
    }
}
object iaGanadora inherits Menu {
    override method image(){
        return "pantallaIaGano.png"
    }
    override method iniciar(){
        super()
        game.sound("youLose.mp3").play()
        keyboard.r().onPressDo({tablero.iniciar()})
    }
}
object menuPrincipal inherits Menu{
    override method image(){
        return "menuPrincipal.png"
    }
    override method iniciar(){
        super()
        keyboard.num1().onPressDo({modosDeJuego.iniciar()})
	    keyboard.num2().onPressDo({instrucciones.iniciar()})
	    keyboard.num3().onPressDo({creditos.iniciar()})
    }
}
object modosDeJuego inherits Menu{
    override method image(){
        return "modosDeJuego.png"
    }
    override method iniciar(){
        super()
        keyboard.num1().onPressDo({modo1v1.iniciar()})
        keyboard.num2().onPressDo({modoIAestandar.iniciar()})
        keyboard.num3().onPressDo({modoIADificil.iniciar()})
        keyboard.num4().onPressDo({modoIAExtrema.iniciar()})
    }
}
object instrucciones inherits Menu{
    override method image(){
        return "instrucciones.png"
    }
}
object creditos inherits Menu{
    override method image(){
        return "creditos.png"
    }
}
object modo1v1 {
    method iniciar(){
        tablero.iniciar()
        tablero.setterIA(null)
    }
}
object modoIAestandar inherits ModoIA {
    override method dificultad(){
        return estandar
    }
}
object modoIADificil inherits ModoIA {
    override method dificultad(){
        return dificil
    }
}
object modoIAExtrema inherits ModoIA {
    override method dificultad(){
        return extrema
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