package ar.edu.unsam.algo3.tp.model

import ar.edu.unsam.algo3.tp.model.exception.DistanciaExcepcion
import ar.edu.unsam.algo3.tp.model.exception.SinDineroExcepcion
import ar.edu.unsam.algo3.tp.model.utils.Validador
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Pokeparada implements Entidad {
	
	int id
	String nombre
	Point ubicacion
	List<Item> items = newArrayList()
	
	def distancia( Point otraUbicacion ){
		ubicacion.distance( otraUbicacion )
	}
	
	new(){
		
	}
	
	def comprar(Entrenador entrenador, Item item) {

		validarDistancia(entrenador)

		if (estaDisponible(item)) {
			if (entrenador.dinero < item.precio) {
				throw new SinDineroExcepcion("No tiene dinero para comprar el item, sale " + item.precio + " y tiene " + entrenador.dinero )
			}
		} else
			throw new SinItemDisponible

		entrenador.perderDinero(item.precio)
		entrenador.agregarItem(item)

	}

	def validarDistancia(Entrenador entrenador) {
		if (ubicacion.distance(entrenador.ubicacion) > 10) {
			throw new DistanciaExcepcion("Esta a mas de 10 metros de la pokeparada")
		}
	}

	def curacion(Entrenador entrenador) {

		validarDistancia(entrenador)
		entrenador.todosLosPokemones.forEach[pokemon|pokemon.puntosDeSalud = pokemon.puntosSaludMaximo]

	}

	def void cambioDeEquipo(Entrenador entrenador, Pokemon pokemon) {

		validarDistancia(entrenador)

		entrenador.cambioDeEquipo(pokemon)

	}

	override getId() {
		id
	}

	override setId(int id) {
		this.id = id
	}

	def agregarItem(Item item) {
		items.add(item)
	}

	def estaDisponible(Item item) {
		items.contains(item)
	}

	override validar() {
		Validador.validarStringRequerido(nombre, "Nombre")
		
		Validador.validarObjetoRequerido(ubicacion, "Ubicacion")
	}

}
