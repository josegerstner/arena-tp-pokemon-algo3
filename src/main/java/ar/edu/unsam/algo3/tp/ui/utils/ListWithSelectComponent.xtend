package ar.edu.unsam.algo3.tp.ui.utils

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ListWithSelectComponent<T> {
	Panel panel
	String label
	String listName
	ModelWithListAndSelect<T> model
	
	new(Panel _panel , String _label , String _listName , ModelWithListAndSelect<T> _model){
		this.panel = _panel
		this.label = _label
		this.listName = _listName
		this.model = _model 
	}
	
	def render(){
		
		var Panel subPanel = new Panel(panel).layout = new HorizontalLayout
		
		var bottomLeftPanel = new Panel(subPanel).layout = new HorizontalLayout
		
		new Label(bottomLeftPanel).text = label
		new List(bottomLeftPanel) => [
			items <=> listName
			value <=> "itemToDelete"
			width = 220
			height = 220
		]

		var Panel bottomRightPanel = new Panel(subPanel).layout = new VerticalLayout()
		
		new Selector<T>(bottomRightPanel) => [
			allowNull = false
			items <=> "select"
			value <=> "itemToAdd"
		]
		
		var especieButtonsPanel = new Panel(bottomRightPanel)
		especieButtonsPanel.setLayout(new HorizontalLayout())
		
		new Button(especieButtonsPanel) => [
			caption = "Agregar " + label
			onClick(|this.model.addToList())
		]
		
		new Button(especieButtonsPanel) => [
			caption = "Eliminar " + label
			onClick(|this.model.removeFromList())
		]
		
	}
	
}
