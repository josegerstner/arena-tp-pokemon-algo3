package ar.edu.unsam.algo3.tp.ui.dao

import ar.edu.unsam.algo3.tp.model.observer.CustomObserver
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepositorioAcciones {
	static var RepositorioAcciones instance

	private new() {
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioAcciones
		}
		return instance
	}
	
	List<CustomObserver> acciones = newArrayList
	
	def agregarAcciones(CustomObserver accion){
		acciones.add(accion)
	}
}