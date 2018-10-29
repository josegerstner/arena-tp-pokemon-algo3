package ar.edu.unsam.algo3.tp.model

import ar.edu.unsam.algo3.tp.model.json.JsonParserEspecie
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class RepositorioEspecie extends Repositorio<Especie> {

	JsonParserEspecie jsonParserEspecie

	static var RepositorioEspecie instance

	List<Tipo> tipos = new ArrayList()
	
	private new() {
		
		agregarTipo(new Tipo("Hierba"))
		agregarTipo(new Tipo("Veneno"))
		agregarTipo(new Tipo("Electricidad"))
		agregarTipo(new Tipo("Fuego"))
		agregarTipo(new Tipo("Normal"))
		
		create( new Especie() =>[
			numero = 1
			nombre = "Electrico"
			descripcion = "Electrico"
			puntosAtaque = 10
			puntosSalud = 100
			velocidad = 5
			it.tipos = newArrayList( getTipoByNombre("Electricidad") )
		])
		
		create( new Especie() =>[
			numero = 2
			nombre = "Fuego"
			descripcion = "Fuego"
			puntosAtaque = 20
			puntosSalud = 200
			velocidad = 5
			it.tipos = newArrayList( getTipoByNombre("Fuego") )
		])
		
		create( new Especie() =>[
			numero = 3
			nombre = "Normal"
			descripcion = "Normal"
			puntosAtaque = 30
			puntosSalud = 400
			velocidad = 5
			it.tipos = newArrayList( getTipoByNombre("Normal") )
		])
		
		
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioEspecie
		}
		return instance
	}

	/*
	 * El valor de búsqueda debe coincidir exactamente con su número o parcialmente con el nombre o descripción.
	 */
	override criterioDeBusquedaPorValor(Especie especie, String valor) {
//		valor.trim.replaceFirst("^0+(?!$)", "").equals(especie.id.toString) ||
			especie.nombre.toLowerCase.contains(valor.toLowerCase) ||
			especie.descripcion.toLowerCase.contains(valor.toLowerCase)
	}

	def searchByNumero(int numero) {
		objetos.findFirst[objeto|objeto.numero.equals(numero)]
	}

	override searchPorCriterioUnico(Especie especie) {
		searchByNumero(especie.numero)
	}

	def agregarTipo(Tipo tipo) {
		tipos.add(tipo)
	}
	
	def Tipo getTipoByNombre(String nombre) {
		tipos.findFirst[tipo|tipo.nombre.equals(nombre)]
	}

	override pisarObjetos(Especie objetoEncontrado, Especie objetoNuevo) {
		objetoEncontrado.nombre = objetoNuevo.nombre
		objetoEncontrado.numero = objetoNuevo.numero
		objetoEncontrado.descripcion = objetoNuevo.descripcion
		objetoEncontrado.puntosAtaque = objetoNuevo.puntosAtaque
		objetoEncontrado.puntosSalud = objetoNuevo.puntosSalud
		objetoEncontrado.numero = objetoNuevo.numero
		objetoEncontrado.velocidad = objetoNuevo.velocidad
		objetoEncontrado.especieEvolucion = objetoNuevo.especieEvolucion
		objetoEncontrado.nivelEnElQueSeEvoluciona = objetoNuevo.nivelEnElQueSeEvoluciona
		objetoEncontrado.tipos = objetoNuevo.tipos
	}

	override parsearObjetos(String json) {
		jsonParserEspecie.parsearEspecies(json)
	}

	override getJson() {
		return getJsonService.getJsonEspecie
	}
	
	def getEspecies(){
		objetos
	}

}
