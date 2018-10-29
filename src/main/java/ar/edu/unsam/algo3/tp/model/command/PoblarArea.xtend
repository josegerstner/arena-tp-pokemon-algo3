package ar.edu.unsam.algo3.tp.model.command

import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Genero
import ar.edu.unsam.algo3.tp.model.Pokemon
import ar.edu.unsam.algo3.tp.model.RepositorioPokemon
import java.time.LocalDateTime
import java.util.HashSet
import java.util.List
import java.util.Random
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Accessors
@Observable
class PoblarArea extends Command {
 	val int MAX_LENGTH_DESCRIPTION = 20
 	val int MAX_LEVEL = 50
 	val int MIN_LEVEL = 0
 	val double MAX_DENSIDAD = 5.0
 	
	String descripcion
	Rectangulo rectangulo // Área geográfica: Área rectangular que representa la zona a poblar.
	Set<Especie> especies = new HashSet() // Especies: Determina de qué especies serán los pokémons creados.
	int nivelMinimo // Nivel mínimo y máximo: Los pokémons creados tendrán un nivel dentro de este rango.
	int nivelMaximo
	double densidad// Densidad: Cantidad de pokémons a crear por km2.
	
	new(){
		//FIXME SACAR ESTO ES SOLO PARA VER QUE BINDEE BIEN ESTO
		ultimaEjecucion = LocalDateTime.now
	}
	
	override execute() {
		super.execute
		var int cantidadPokemones = (rectangulo.area * densidad).intValue
		
		var List<Pokemon> pokemones = newArrayList
		
		for ( var i = 0 ; i < cantidadPokemones ; i++ ){
			
			RepositorioPokemon.instance.agregarPokemon( new Pokemon() => [

					ubicacion = rectangulo.puntoEnRectangulo
					especie = randomEspecie
					nivel = RandomUtils.getIntInRange( nivelMinimo , nivelMaximo )
					genero = generoAleatorio
					
					puntosDeSalud  = RandomUtils.getIntInRange( especie.puntosSalud )
					
				]
			);
		}

	}
	
	override getNombreComando() {
		descripcion
	}
	
	def getGeneroAleatorio() {
		
		val random = new Random()
		val nextDouble = random.nextDouble
		
		if( nextDouble < 0.5 ){
			return Genero.MASCULINO
		}

		Genero.FEMENINO
	}
	
	def Especie getRandomEspecie(){
		return RandomUtils.getRandomElementInSet( especies )
	}
	
	override toString() {
		nombreComando
	}
	
	def public void setDescripcion(String _descripcion){
		validarDescripcion(_descripcion)
		descripcion = _descripcion
	}
	
	def public void setNivelMaximo(int _nivelMaximo){
		validarNivelMaximo(_nivelMaximo)
		nivelMaximo = _nivelMaximo
	}
	
	def public void setNivelMinimo(int _nivelMinimo){
		validarNivelMinimo(_nivelMinimo)
		nivelMinimo = _nivelMinimo
	}
	
	def public void setDensidad(double _densidad){
		validarDensidad(_densidad)
		densidad = _densidad
	}
	
	/********************************************* VALIDACIONES *********************************************************************/
	
	def validarDescripcion(String _descripcion){
		if( _descripcion != null && _descripcion.length > MAX_LENGTH_DESCRIPTION ){
			throw new UserException( "El largo máximo de la descripcion es " + MAX_LENGTH_DESCRIPTION )
		}
	}
	
	def validarNivelMaximo(int _nivelMaximo){
		if( _nivelMaximo > MAX_LEVEL || _nivelMaximo < MIN_LEVEL ){
			throw new UserException( "El nivel maximo debe estar entre " + MAX_LEVEL + " y " + MIN_LEVEL)
		}
	}
	
	def validarNivelMinimo(int _nivelMinimo){
		if( _nivelMinimo > MAX_LEVEL || _nivelMinimo < MIN_LEVEL ){
			throw new UserException( "El nivel minimo debe estar entre " + MAX_LEVEL + " y " + MIN_LEVEL)
		}
	}
	
	def validarDensidad(double _densidad){
		if(  _densidad > MAX_DENSIDAD || _densidad < 0.0){
			throw new UserException( "La densidad debe estar entre 0.0 y " + MAX_DENSIDAD)
		}
	}
	
	def validarArea(){
		if( rectangulo == null ){
			throw new UserException( "Debe tener un area seleccionada")
		}
	}
	
	def validarEspecies(){
		if( especies == null || especies.isEmpty){
			throw new UserException( "Debe tener por lo menos una especie")
		}
	}
	
	def public void validar(){
		validarDescripcion(descripcion)
		validarNivelMaximo(nivelMaximo)
		validarNivelMinimo(nivelMinimo)
		validarDensidad(densidad)
		validarArea()
		validarEspecies()
	}
	
}
