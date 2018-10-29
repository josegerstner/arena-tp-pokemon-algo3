package ar.edu.unsam.algo3.tp.model.observer

import ar.edu.unsam.algo3.tp.model.Entrenador
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class NotificarNivelMultiploDe5Observer implements CustomObserver{
	
	override notificar(Entrenador entrenador) {
		val nivelActual = entrenador.nivel % 5
		if(nivelActual == 0){
			entrenador.agregarNotificacion("El entrenador" + entrenador.nombre + "alcanzo el nivel " + entrenador.nivel)
			entrenador.amigos.
			forEach[ entrenadorRepo | entrenadorRepo.agregarNotificacion("El entrenador" + entrenador.nombre + "alcanzo el nivel " + entrenador.nivel)
			 ]
		}
	}
	
		override descripcion(){
		"Notificar nivel multiplo 5"
	}
	
}