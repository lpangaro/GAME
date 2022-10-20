import visuales.*
import elementos.*
import wollok.game.*

/* ESTADOS DE SHELDON */
object normal{	
	method mover(direccion, personaje){
		personaje.position(direccion.siguiente(personaje.position()))
	}
}
object electrocutado{	
	method mover(direccion, personaje){
	}
}

/*CONFIGURACION DE TECLADO*/
object movimiento {
	var property estado = normal
	
	method configurarFlechas(visual){
		keyboard.up().onPressDo{ estado.mover(arriba,visual)}
		keyboard.down().onPressDo{ estado.mover(abajo,visual)}
		keyboard.left().onPressDo{ estado.mover(izquierda,visual) sheldon.image("sheldonTrosco.png")} //Sheldon que mira a la izquierda
		keyboard.right().onPressDo{ estado.mover(derecha,visual) sheldon.image("sheldon.png")}
   }
}

//direcciones
object izquierda { 
	method siguiente(position) = position.left(1) 
}

object derecha { 
	method siguiente(position) = position.right(1) 
}

object abajo { 
	method siguiente(position) = position.down(1) 
}

object arriba { 
	method siguiente(position) = position.up(1) 
}