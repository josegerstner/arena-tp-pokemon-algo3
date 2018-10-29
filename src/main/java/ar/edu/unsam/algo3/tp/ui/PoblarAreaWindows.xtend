package ar.edu.unsam.algo3.tp.ui

import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.ui.utils.ComponentsUtils
import ar.edu.unsam.algo3.tp.ui.utils.ListWithSelectComponent
import ar.edu.unsam.algo3.tp.viewModel.PoblarAreaModelo
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

class PoblarAreaWindows extends TransactionalDialog<PoblarAreaModelo> {
	
	new(WindowOwner parent, PoblarAreaModelo model) {
		super(parent, model)
	}
	
	override createFormPanel(Panel mainPanel) {
		this.title = "Poblar Area"
		
		mainPanel.layout = new VerticalLayout
		
		var top = new Panel (mainPanel).layout = new HorizontalLayout
		
		var Panel topLeftPanel = new Panel(top).layout = new ColumnLayout(2)
		
		ComponentsUtils.buildTextBoxWithLabelHorizontal( topLeftPanel , "Descripción : " , "poblarAreaCommand.descripcion")
		ComponentsUtils.buildNumericFieldWithLabelHorizontal( topLeftPanel , "Nivel Max : " , "poblarAreaCommand.nivelMaximo")
		ComponentsUtils.buildNumericFieldWithLabelHorizontal( topLeftPanel , "Densidad : " , "poblarAreaCommand.densidad")
		
		var Panel topRightPanel = new Panel(top).layout = new ColumnLayout(2)
		
		ComponentsUtils.buildNumericFieldWithLabelHorizontal( topRightPanel , "Nivel Min : " , "poblarAreaCommand.nivelMinimo")
		ComponentsUtils.buildSelectWithLabelHorizontal(topRightPanel, "Area : " , "areas" , "poblarAreaCommand.rectangulo" )
		
		var ListWithSelectComponent<Especie> listWithSelectComponent = new ListWithSelectComponent<Especie>(mainPanel, "Especie" , "poblarAreaCommand.especies" , this.modelObject )				
		listWithSelectComponent.render()

	}
	
	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [| this.modelObject.agregar this.accept]
			setAsDefault
			disableOnError
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [|this.cancel]
		]
	}
	
}
