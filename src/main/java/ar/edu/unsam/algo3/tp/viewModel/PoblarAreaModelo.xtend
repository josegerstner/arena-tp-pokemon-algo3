package ar.edu.unsam.algo3.tp.viewModel

import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.RepositorioEspecie
import ar.edu.unsam.algo3.tp.model.command.PoblarArea
import ar.edu.unsam.algo3.tp.ui.dao.RepositorioArea
import ar.edu.unsam.algo3.tp.ui.utils.ModelWithListAndSelect
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class PoblarAreaModelo extends ModelWithListAndSelect<Especie> {
	
	PoblarArea poblarAreaCommand
	
	new() {
		poblarAreaCommand = new PoblarArea
	}
	
	new(PoblarArea poblarArea) {
		poblarAreaCommand = poblarArea
	}
	
	override getSelect(){
		RepositorioEspecie.instance.especies
	}
	
	def getAreas(){
		RepositorioArea.instance.areas
	}
	
	override getList() {
		poblarAreaCommand.especies
	}
	
	def void agregar(){
		poblarAreaCommand.validar
		RepositorioProcesos.instance.agregarProceso(poblarAreaCommand)
	}
	
}
