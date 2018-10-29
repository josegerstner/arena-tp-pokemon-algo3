package ar.edu.unsam.algo3.tp.viewModel

import ar.edu.unsam.algo3.tp.model.command.Actualizacion
import ar.edu.unsam.algo3.tp.ui.utils.ModelWithListAndSelect
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class ActualizacionModelo extends ModelWithListAndSelect<Actualizacion> {
	
	override getList() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}
