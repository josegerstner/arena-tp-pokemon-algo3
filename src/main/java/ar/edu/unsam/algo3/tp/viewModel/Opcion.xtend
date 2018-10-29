package ar.edu.unsam.algo3.tp.viewModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.lacar.ui.model.Action

@Accessors
@Observable
@Deprecated
class Opcion {
	
	String descripcion
	Action action
	
	new(String descripcion, Action action) {
		this.descripcion = descripcion
		this.action = action
	}
	
}
