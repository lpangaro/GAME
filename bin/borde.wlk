import visuales.*
import elementos.*
import wollok.game.*
import teclado.*

class Borde {
	const verticeInicial
	const verticeFinal
	const image
	
	method dibujar() {
		self.dibujarLineaVertical(verticeInicial.x(),verticeInicial.y(),verticeFinal.y(),derecha)
		self.dibujarLineaVertical(verticeFinal.x(),verticeInicial.y(),verticeFinal.y(),izquierda)
		self.dibujarLineaHorizontal(verticeInicial.y(),verticeInicial.x()+1,verticeFinal.x()-1,arriba)
		self.dibujarLineaHorizontal(verticeFinal.y(),verticeInicial.x()+1,verticeFinal.x()-1,abajo)

	}
	method dibujarElemento(columna,fila,direccion) {
		const elemento = new VisualSolido(
			image = image, 
			position = new Position(x=columna,y=fila), 
			direccionRebote = direccion
		)
		game.addVisual(elemento)
	}
	method dibujarLineaVertical(columna,filaDesde,filaHasta,direccion){
		(filaDesde..filaHasta).forEach{fila=>self.dibujarElemento(columna,fila,direccion)}
	}
	method dibujarLineaHorizontal(fila,columnaDesde,columnaHasta,direccion){
		(columnaDesde..columnaHasta).forEach{columna=>self.dibujarElemento(columna,fila,direccion)}
	}
}

class VisualSolido inherits Visual{
	
	var property direccionRebote 
	
	method colisionadoPor(elemento) {
		movimiento.estado().mover(direccionRebote,elemento)
	}
}