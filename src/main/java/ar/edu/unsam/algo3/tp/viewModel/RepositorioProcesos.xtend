package ar.edu.unsam.algo3.tp.viewModel

import ar.edu.unsam.algo3.tp.model.command.Command
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable

class RepositorioProcesos {

	static var RepositorioProcesos instance
	
	private new(){
		
	}
	
	public static def getInstance(){
		if( instance == null ){
			instance = new RepositorioProcesos
		}
		return instance
	}
	
	/*
	 * El valor de búsqueda debe coincidir parcialmente con su nombre 
	 * o exactamente con el nombre de alguno de sus ítems disponibles.
	 */
	
	@Accessors List <Command> procesos = new ArrayList()
	 
	def agregarProceso(Command proceso){
		procesos.add(proceso)
	}
	
	def editarProceso(Command proceso){
		procesos
	}
	
	def eliminarProceso(Command proceso){
		if (procesos.contains(proceso)){
			procesos.remove(proceso)
		}
	}
	
}
