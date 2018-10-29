package ar.edu.unsam.algo3.tp.viewModel

import ar.edu.unsam.algo3.tp.model.command.Command
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class AdministracionModelo {

	var Integer flagDependencies = 0
	var Command procesoSeleccionado

	new() {		
	}
	
	def getRepoProcesos() {
		RepositorioProcesos.instance
	}
	
	//FIXME Ver como arreglarlo
	@Dependencies("flagDependencies")
	def getProcesos() {
		repoProcesos.procesos
	}

	def void actualizaFlagDependencies() {
		flagDependencies++
	}
	
	/**
	 * Elimina el proceso seleccionado de la lsita de procesos
	 */
	def eliminarProcesoSeleccionado() {
		repoProcesos.eliminarProceso(procesoSeleccionado)
		procesoSeleccionado = null
		actualizaFlagDependencies
	}
	
	/**
	 * Ejecuta el proceso seleccionado
	 */
	 @Dependencies("procesoSeleccionado")
	def ejecutarProcesoSeleccionado(){
		procesoSeleccionado.execute
	}

}
