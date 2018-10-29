package ar.edu.unsam.algo3.tp.ui

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import ar.edu.unsam.algo3.tp.viewModel.MultipleModelo
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.layout.HorizontalLayout
import ar.edu.unsam.algo3.tp.model.command.Command
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.widgets.Button

class MultipleWindow extends TransactionalDialog<MultipleModelo> {

	new(WindowOwner parent, MultipleModelo model) {
		super(parent, model)

	}

	override protected createFormPanel(Panel mainPanel) {
		this.title = "Agregar Acciones"

		var Panel top = new Panel(mainPanel).layout = new HorizontalLayout

		new Label(top).text = "Descripcion : "
		new TextBox(top) => [
			value <=> "multiple.nombreComando"
			width = 100
		]

		val Panel panelInferior = new Panel(mainPanel)
		panelInferior.layout = new HorizontalLayout()

		val Panel panelInferiorIzquierdo = new Panel(panelInferior).layout = new HorizontalLayout

		new Label(panelInferiorIzquierdo).text = "Comandos"

		var tablaAcciones = new Table<Command>(panelInferiorIzquierdo, typeof(Command)) => [
			items <=> "valores"
			numberVisibleRows = 10
			value <=> "seleccionEliminar"
		]

		new Column<Command>(tablaAcciones) => [
			fixedSize = 240
			title = "Proceso"
			bindContentsToProperty("nombreComando")
		]

		val Panel panelInferiorDerecho = new Panel(panelInferior).layout = new VerticalLayout

		new Label(panelInferiorDerecho).text = "Acciones"
		new Selector<Command>(panelInferiorDerecho) => [
			allowNull = false
			width = 200
			val itemsProperty = items <=> "procesosExistentes"
			itemsProperty.adapter = new PropertyAdapter(typeof(Command), "nombreComando")
			value <=> "seleccionProceso"
		]

		var Panel panelInferioDerechoInterior = new Panel(panelInferiorDerecho)
		panelInferioDerechoInterior.layout = new HorizontalLayout()

		new Button(panelInferioDerechoInterior) => [
			caption = "Agregar Proceso"
			onClick(|this.modelObject.addProceso())
		]

		new Button(panelInferioDerechoInterior) => [
			caption = "Eliminar Accion"
			onClick(|this.modelObject.removeProceso())
		]

//		val Panel panelAceptarCancelar = new Panel(mainPanel)
//		panelAceptarCancelar.layout = new HorizontalLayout
//		panelAceptarCancelar.width = 400
	}

	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [|this.modelObject.agregar this.accept]
			setAsDefault
			disableOnError
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [|this.cancel]
		]

	}

}
