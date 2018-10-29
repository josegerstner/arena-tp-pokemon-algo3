
package ar.edu.unsam.algo3.tp.model

import ar.edu.unsam.algo3.tp.model.utils.NumberUtils
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Item implements Entidad{
	val int precio //= 80
	String nombre
	
	new( int precio ){
		this.precio = precio
	}
	
	new( int precio , String nombre){
		this.precio = precio
		this.nombre = nombre
	}
	
	override validar() {
	}
	
	override getId() {
	}
	
	override setId(int id) {
	}
	
	override toString() {
		nombre
	}
	
}

@Accessors
class Pokebola extends Item{
	double probabilidadExtraDeAtrapar
	
	new(int precio , double probabilidadExtraDeAtrapar, String nombre) {
		
		super(precio,nombre)
		this.probabilidadExtraDeAtrapar = probabilidadExtraDeAtrapar 
		
	}
	
}

interface PocionI{
	def void curar(Pokemon pokemon)
	def int calcularPuntosDeSaludQueCura(Pokemon pokemon)
}

@Accessors
class Pocion extends Item implements PocionI{
	int puntosDeSaludQueCura
	
	new( int precio,String nombre){
		super(precio,nombre)
	}
	
	new( int precio , int puntosDeSaludQueCura , String nombre){
		super(precio,nombre)
		this.puntosDeSaludQueCura = puntosDeSaludQueCura
	}
	
	override curar(Pokemon pokemon){
		pokemon.sumarPuntosDeSalud( puntosDeSaludQueCura )
	}
	
	override calcularPuntosDeSaludQueCura(Pokemon pokemon) {
		puntosDeSaludQueCura
	}
	
}

@Accessors
class MaxPocion extends Pocion{
	
	new( int precio ,String nombre){
		super(precio,nombre)
	}
	
	override curar(Pokemon pokemon){
		pokemon.curarTodaLaSalud
	}
	
}

@Accessors
abstract class IngredienteDecorator extends Item implements PocionI {
	
	PocionI pocion
	
	new( int precio ){
		super(precio)
	}
	
	new( int precio , PocionI pocion){
		super(precio)
		this.pocion = pocion
	}

	override curar(Pokemon pokemon){
		val int puntosDeSaludQueCura = calcularPuntosDeSaludQueCura(pokemon)
		pokemon.sumarPuntosDeSalud( puntosDeSaludQueCura )
	}
	
}

@Accessors
class IngredienteValorFijoDecorator extends IngredienteDecorator {
	
	val int valorFijoQueCura
	
	new(int precio , int valorFijoQueCura){
		super(precio)
		this.valorFijoQueCura = valorFijoQueCura
	}
	
	override int calcularPuntosDeSaludQueCura(Pokemon pokemon){
		pocion.calcularPuntosDeSaludQueCura(pokemon) + valorFijoQueCura
	}
	
}

@Accessors
class IngredienteValorPorcentualDecorator extends IngredienteDecorator {
	
	var double porcentajeQueCura
	
	new(int precio){
		super(precio)
	}
	
	new(int precio , double porcentajeQueCura){
		super(precio)
		this.porcentajeQueCura = porcentajeQueCura
	}
	
	override int calcularPuntosDeSaludQueCura(Pokemon pokemon){
		NumberUtils.calcularPorcentajeEntero( this.pocion.calcularPuntosDeSaludQueCura(pokemon) , porcentajeQueCura ) 
		+ 
		this.pocion.calcularPuntosDeSaludQueCura(pokemon)
	}
	
}

@Accessors
class IngredienteValorPorcentualConEspeciesFuertesDecorator extends IngredienteDecorator {
	
	var double porcentajeQueCura
	var double porcentajeQueCuraEspecieFuerte
	var List<Tipo> tiposQueCuraMas = newArrayList()
	
	new(int precio){
		super(precio)
	}
	
	new(int precio , double porcentajeQueCura, double porcentajeQueCuraEspecieFuerte){
		super(precio)
		this.porcentajeQueCura = porcentajeQueCura
		this.porcentajeQueCuraEspecieFuerte = porcentajeQueCuraEspecieFuerte
	}
	
	def agregarTipoQueCuraMas(Tipo tipo){
		tiposQueCuraMas.add(tipo)
	}
	
	override int calcularPuntosDeSaludQueCura(Pokemon pokemon){
		var puntosQueCura = 0
		if( pokemon.tieneAlgunTipo(tiposQueCuraMas) ){
			puntosQueCura = NumberUtils.calcularPorcentajeEntero( this.pocion.calcularPuntosDeSaludQueCura(pokemon) , porcentajeQueCuraEspecieFuerte )	
		} else {
			puntosQueCura = NumberUtils.calcularPorcentajeEntero( this.pocion.calcularPuntosDeSaludQueCura(pokemon) , porcentajeQueCura )
		}
		puntosQueCura
		+ 
		this.pocion.calcularPuntosDeSaludQueCura(pokemon)
	}
	
}
