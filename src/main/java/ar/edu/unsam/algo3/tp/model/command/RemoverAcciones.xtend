package ar.edu.unsam.algo3.tp.model.command

import ar.edu.unsam.algo3.tp.model.RepositorioEntrenador
import ar.edu.unsam.algo3.tp.model.observer.CustomObserver
import java.util.List

class RemoverAcciones extends Command{
	
	List<CustomObserver> customObservers
		
	RepositorioEntrenador repositorioEntrenador
	
	new( List<CustomObserver> customObservers ) {
		this.customObservers = customObservers
	}
	
	override execute() {
		repositorioEntrenador.entrenadores.forEach[ quitarObservers( customObservers ) ]
	}
	
}
