package ar.edu.unsam.algo3.tp.viewModel

import ar.edu.unsam.algo3.tp.model.command.AgregarAcciones
import ar.edu.unsam.algo3.tp.model.observer.CustomObserver
import ar.edu.unsam.algo3.tp.model.observer.NotificarNivelMasAltoObserver
import ar.edu.unsam.algo3.tp.model.observer.NotificarNivelMultiploDe5Observer
import ar.edu.unsam.algo3.tp.model.observer.NotificarSuperaNivelObserver
import ar.edu.unsam.algo3.tp.model.observer.RecompensaNivelDeterminadoObserver
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unsam.algo3.tp.ui.dao.RepositorioAcciones

@Accessors
@Observable
class AgregarAccionesModelo {

	var AgregarAcciones accion = new AgregarAcciones
	
	var String nombre
	
	var CustomObserver seleccionAccion
	var CustomObserver seleccionEliminar

	new() {
	}
	
	new(AgregarAcciones _agregarAcciones) {
		accion = _agregarAcciones
	}
	
	def getAcciones() {
		RepositorioAcciones.instance.acciones
	}
	
	def void addAccion() {
		accion.agregarAccionIndividual(seleccionAccion)
	}

	def void removeAccion() {
		accion.eliminarAccionIndividual(seleccionEliminar)
	}
	
	
	def agregar(){
		RepositorioProcesos.instance.agregarProceso(accion)
	}
	
}
