import wollok.game.*
import visuales.*
import borde.*
import elementos.*
import teclado.*

object nivel {
	
	const anchoTablero = 11
	const altoTablero = 5
	
	method inicio() {
		game.clear()
		game.title("Sheldon Eats")
		game.width(12)
	  	game.height(6)
	  	game.cellSize(120)
	  	game.addVisual(inicioDelJuego)
	  		  	
	  	keyboard.s().onPressDo{self.configurate()	
	  	}
	}
	
	method configurate() {
		game.clear()
 		game.addVisual(fondo)
		
  		//Sheldon	
		game.addVisual(sheldon)
		movimiento.configurarFlechas(sheldon)		
		game.whenCollideDo(sheldon, {elemento => elemento.colisionadoPor(sheldon) self.puntosParaGanar()})
		
		//Borde
		new Borde(verticeInicial= game.origin(), verticeFinal = new Position(x=anchoTablero, y=altoTablero), image = "burbuja.png").dibujar()	    

		//Tiburon
		game.addVisual(tiburon)
		game.onTick(300, "nadar", {tiburon.nadar(sheldon.position())}) //el tiburon persigue a sheldon
		
		//Peces
		[globo,pez10,pez15,pez20,pez30, pulpo, abisal, medusa].forEach { pez =>  
			game.addVisual(pez)
			self.ubicarAleatoriamente(pez)}
	}
		
	method ubicarAleatoriamente(visual){
		var posicion = new Position (x=1.randomUpTo(anchoTablero),y=1.randomUpTo(altoTablero))
		if(game.getObjectsIn(posicion).isEmpty())
			visual.position(posicion)
		else
			self.ubicarAleatoriamente(visual)			
			
	}
		
	method puntosParaGanar(){
		if (sheldon.puntos() >= 150) {
			self.hasGanado()
		}
	}
		
	method hasGanado(){
		game.clear()
		game.width(12)
		game.height(6)
		game.addVisual(ganaste)
		
		sheldon.puntos(0)
		movimiento.estado(normal)
		keyboard.r().onPressDo{self.configurate()}
	}
	
	method gameOver(){
		game.clear()
		game.width(12)
		game.height(6)
        game.addVisual(perdiste)
        
        sheldon.puntos(0)
        movimiento.estado(normal)
        self.ubicarAleatoriamente(tiburon) // muevo el tiburon de lugar porque sino aparezco en la misma posicion y pierdo inmediatamente
        
		keyboard.r().onPressDo{self.configurate()}
	}
	 
}