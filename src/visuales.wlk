import borde.*
import nivel.*
import elementos.*

import wollok.game.*

class Visual {
	var property image
	var property position = game.origin()
}

const inicioDelJuego = new Visual( image =  "pantallaInicio.png", position = game.origin())
const ganaste = new Visual( image = "pantallaGanaste.png", position = game.origin())
const perdiste = new Visual(image = "pantallaGameOver.png", position = game.origin())
const fondo = new Visual(image = "fondo.png", position = game.origin()) 
const pantallaOscura = new Visual(image = "pantallaOscura.png", position = game.origin()) 


object tinta inherits Visual(image = "tinta.png", position = pulpo.position()) {	
	method colisionadoPor(visual){
		 nivel.ubicarAleatoriamente(self)
	}
}