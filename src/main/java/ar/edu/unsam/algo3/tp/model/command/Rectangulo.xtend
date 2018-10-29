package ar.edu.unsam.algo3.tp.model.command

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Rectangulo {
	String nombre
	Point punto1
	Point punto2
	
	def double getXMaximo(){
		return if (punto1.x > punto2.x) punto1.x else punto2.x
	}
	
	def double getXMinimo(){
		return if (punto1.x < punto2.x) punto1.x else punto2.x
	}
	
	def double getYMaximo(){
		return if (punto1.y > punto2.y) punto1.y else punto2.y
	}
	
	def double getYMinimo(){
		return if (punto1.y < punto2.y) punto1.y else punto2.y
	}
	
	def double getArea(){
		var double ancho = getYMaximo - getYMinimo
		var double alto = getXMaximo - getXMinimo
		
		ancho * alto
	}
	
	def Point getPuntoEnRectangulo(){
		
		var double yValue = RandomUtils.getDoubleInRange( getXMinimo , getXMaximo )
		var double xValue = RandomUtils.getDoubleInRange( getYMinimo , getYMaximo )
		
		return new Point( xValue , yValue )
	
	}
	
	def boolean estaDentroDelRectangulo(Point punto){
		return ( getXMinimo <= punto.x ) && ( punto.x <= getXMaximo ) && ( getYMinimo <= punto.y ) && ( punto.y <= getYMaximo )    
	}
	
	override toString() {
		nombre
	}
	
}
			