package ar.edu.unsam.algo3.tp.viewModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unsam.algo3.tp.model.command.Command
import ar.edu.unsam.algo3.tp.model.command.ComandoMultiple
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@Observable
class MultipleModelo {

	var ComandoMultiple multiple = new ComandoMultiple()
	new (){
		
	}
	new(ComandoMultiple _editar){
		multiple = _editar
	}
	RepositorioProcesos repoProcesos = RepositorioProcesos.instance
	var Command seleccionProceso
	var Command seleccionEliminar
	var int flagMultiple =0 
	def getProcesosExistentes() {
		repoProcesos.procesos
	}

	def addProceso() {
		multiple.addComando(seleccionProceso)
		actualizarFlag
	}

	def removeProceso() {
		multiple.quitarComando(seleccionEliminar)
		actualizarFlag
	}

	def agregar() {
		RepositorioProcesos.instance.agregarProceso(multiple)
	}
	
	@Dependencies("flagMultiple")
	def getValores(){
		multiple.comandos
	}
	
	def actualizarFlag(){
		flagMultiple = flagMultiple+1
	}
	
}
