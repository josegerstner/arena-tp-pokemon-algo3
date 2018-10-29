package ar.edu.unsam.algo3.tp.ui

import org.uqbar.arena.windows.WindowOwner
import ar.edu.unsam.algo3.tp.viewModel.MultipleModelo
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button

class EditarMultipleWindow extends MultipleWindow {

	new(WindowOwner owner, MultipleModelo model) {
		super(owner, model)
	}

	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [|this.accept]
			setAsDefault
			disableOnError
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [|
				this.cancel
			]
		]
	}

}
