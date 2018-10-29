package ar.edu.unsam.algo3.tp.ui.dao

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unsam.algo3.tp.model.Repositorio

@Accessors
class RepositorioRepositorio {
	static var RepositorioRepositorio instance

	private new() {
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioRepositorio
		}
		return instance
	}
	
	List<Repositorio> acciones = newArrayList
	
	def agregarRepos(Repositorio _R){
		acciones.add(_R)
	}
}