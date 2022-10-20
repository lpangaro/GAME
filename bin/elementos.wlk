import visuales.*
import teclado.*
import nivel.*
import wollok.game.*

object sheldon inherits Visual(image = "sheldon.png",position = new Position(x=1,y=1)){
	
	var property puntos = 0
		
	method sumaPuntos(cantidad) { puntos += cantidad }

	method comer(pez){
		self.sumaPuntos(pez.puntos())
		game.say(self, "Tengo " + self.puntos() + " puntos!!")		
	}
}

class Peces inherits Visual{
	const property puntos
	    
	method colisionadoPor(personaje) {
		personaje.comer(self)
 		nivel.ubicarAleatoriamente(self)
	}
}
const globo = new Peces( image = "globoM.png",puntos = -20) 
const pez10 = new Peces( image = "pez10R.png",puntos = 10) 
const pez15 = new Peces( image = "pez15C.png",puntos = 15) 
const pez20 = new Peces( image = "pez20V.png",puntos = 20) 
const pez30 = new Peces( image = "pez30.png", puntos = 30)

object pulpo inherits Peces(image= "pulpo.png",puntos=35) {
	override method colisionadoPor(personaje){ 
		super(personaje)
		game.removeVisual(self)
 		game.addVisual(tinta) 		 		
	}
}

object abisal inherits Peces(image= "abisal.png", puntos = -35) { 
	override method colisionadoPor(personaje){ 
		super(personaje)
		game.addVisual(pantallaOscura)
		game.sound("cortasteTodaLaLoz.mp3").play()
		
		game.schedule(4000, { game.removeVisual(pantallaOscura) })
	}
}

object medusa inherits Peces(image= "medusa.png", puntos = -15) {
	override method colisionadoPor(personaje) { 
		super(personaje)
		sheldon.image("sheldonSacaLaManoDeAhiCarajo.png") 										//https://www.youtube.com/watch?v=6UlasOF_ee0 
		game.sound("sacaLaManoDeAhi.mp3").play()
		
		movimiento.estado(electrocutado)
		game.schedule(4000, { sheldon.image("sheldon.png") movimiento.estado(normal)})
	}
}


object tiburon inherits Visual(
	image= "tiburon.png", 
	position = new Position(x=9,y=1)) {

	method nadar(posSheldon) {
		position = game.at(
			position.x()+(posSheldon.x()-position.x())/4,
			position.y()+(posSheldon.y()-position.y())/4
		)
	}
	method colisionadoPor(personaje) { 
		game.sound("comido.mp3").play()
		nivel.gameOver()
	}	
}

