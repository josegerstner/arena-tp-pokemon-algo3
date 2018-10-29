package ar.edu.unsam.algo3.tp.ui

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.aop.windows.TransactionalDialog
import ar.edu.unsam.algo3.tp.viewModel.RepositoriosModelo
import org.uqbar.arena.widgets.tables.Table
import ar.edu.unsam.algo3.tp.model.Repositorio
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.bindings.PropertyAdapter

class ActualizacionWindow extends TransactionalDialog<RepositoriosModelo> {

	new(WindowOwner owner, RepositoriosModelo model) {
		super(owner, model)
	}

	override createFormPanel(Panel mainPanel) {
		this.title = "Actualizacion"
		mainPanel.layout = new VerticalLayout

		var Panel horiPanel = new Panel(mainPanel).layout = new HorizontalLayout

		new Label(horiPanel).text = "Descripción : "
		new TextBox(horiPanel) => [
			value <=> "actualizacion.nombreComando"
			width = 100
		]

		// /Agrego el panel de abajo
		var Panel bottomPanel = new Panel(mainPanel).layout = new HorizontalLayout()

		var Panel leftPanel = new Panel(bottomPanel).layout = new HorizontalLayout()

		new Label(leftPanel).text = "Repositorios: "
		var tablaRepos = new Table<Repositorio>(leftPanel, typeof(Repositorio)) => [
			items <=> "repositoriosCommando"
			numberVisibleRows = 10
			value <=> "repoSeleccionadoTabla"
		]

		new Column<Repositorio>(tablaRepos) => [
			fixedSize = 240
			title = "Repositorios"
			bindContentsToProperty("description")
		]

		var Panel rightPanel = new Panel(bottomPanel).layout = new VerticalLayout

		new Selector(rightPanel) => [
			allowNull = false
			width = 200
			val itemsProperty = items <=> "repositorios"
			itemsProperty.adapter = new PropertyAdapter(typeof(Repositorio), "description")
			value <=> "repoSeleccionado"
		]

		var Panel underRightPanel = new Panel(rightPanel).layout = new HorizontalLayout()
		new Button(underRightPanel) => [
			caption = "Agregar Repositorio"
			onClick(|this.modelObject.agregarRepositorio())
		]
		new Button(underRightPanel) => [
			caption = "Eliminar Repositorio"
			onClick[]
			onClick[|this.modelObject.eliminarRepositorio()]
		]

//		var Panel underPanel = new Panel(mainPanel).layout = new HorizontalLayout()
	}

	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [|this.modelObject.agregarComando this.accept]
			setAsDefault
			disableOnError
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [|this.cancel]
		]
	}
}
