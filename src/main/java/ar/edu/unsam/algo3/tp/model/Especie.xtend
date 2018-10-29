package ar.edu.unsam.algo3.tp.model;

import ar.edu.unsam.algo3.tp.model.utils.Validador
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Especie implements Entidad {
	
	Integer id
	int numero
	String nombre
	String descripcion
	int puntosAtaque = 0
	int puntosSalud = 0
	int velocidad = 0
	Especie especieEvolucion
	int nivelEnElQueSeEvoluciona
	List<Tipo> tipos = newArrayList
	
	new (){
		super()
	}
	
	def boolean debeEvolucionar(Pokemon pokemon) {

		return pokemon.nivel > nivelEnElQueSeEvoluciona && especieEvolucion !== null

	}

	def boolean esFuerteContra(Especie otraEspecie) {

		return tipos.exists[tipo|tipo.esFuerteContra(otraEspecie.tipos)]

	}

	def boolean esResistente(Especie otraEspecie) {
		return tipos.exists[tipo|tipo.esResistente(otraEspecie.tipos)]
	}

	def agregarTipo(Tipo tipo) {

		tipos.add(tipo)

	}

	def void setVelocidad(int velocidad) {
		if (velocidad < 0 || velocidad > 10) {
			throw new IllegalArgumentException("La velocidad debe estar entre 0 y 10 pero fue de " + velocidad);
		}
		this.velocidad = velocidad
	}
	
	def boolean tieneTipo( Tipo tipoABuscar ){
		tipos.exists[ tipo | tipo.nombre.equals( tipoABuscar.nombre ) ]
	}
	
	def boolean tieneAlgunTipo(List<Tipo> tiposABuscar){
		tipos.exists[ tipo | tiposABuscar.contains( tipo ) ]
	}
	
	/*
	 * Valida que los atributos que son requeridos, no esten ni nulos ni vacios. En caso de estar alguno vacio o nulo lanzo una excepcion.
	 * Para las listas, valido adicionalmente, que no este nula ni vacia(isEmpty())
	 * Puntos de ataque base
	 * Puntos de salud base
	 * Nombre 
	 * Número
	 * Descripción 
	 * Tipos (debe tener al menos un tipo)
	 * Velocidad
	 *  
	 */
	override validar() {
		validarEnteros()
		validarStrings()
		Validador.validarListaRequerida(tipos, "Tipos")
	}
	
	def validarStrings() {
		Validador.validarStringRequerido(nombre , "Nombre")
		Validador.validarStringRequerido(descripcion , "Descripcion")
	}
	
	def validarEnteros() {
		Validador.validarEnteroRequerido(puntosAtaque , "Puntos de ataque")
		Validador.validarEnteroRequerido(puntosSalud , "Puntos de salud")
		Validador.validarEnteroRequerido(numero , "Numero")
		Validador.validarEnteroRequerido(velocidad , "Velocidad")
	}
	
	override toString() {
		nombre
	}
	
	override setId(int id) {
//		this.id = id
	}
	
}

@Accessors
class Tipo {
	String nombre
	List<Tipo> esResistente = newArrayList()
	List<Tipo> esFuerte = newArrayList()

	new(String nombre) {
		this.nombre = nombre
	}

	def void agregarTipoAlQueEsResistente(Tipo tipo) {
		this.esResistente.add(tipo)
	}

	def void agregarTipoAlQueEsFuerte(Tipo tipo) {
		this.esFuerte.add(tipo)
	}

	def boolean esFuerteContra(List<Tipo> tipos) {
		tipos.exists[tipo|esFuerte.contains(tipo)]
	}

	def boolean esResistente(List<Tipo> tipos) {
		tipos.exists[tipo|esResistente.contains(tipo)]
	}
	
}
