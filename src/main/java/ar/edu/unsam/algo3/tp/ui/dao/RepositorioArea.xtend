package ar.edu.unsam.algo3.tp.ui.dao

import ar.edu.unsam.algo3.tp.model.command.Rectangulo
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepositorioArea {
	
	static var RepositorioArea instance

	private new() {
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioArea
		}
		return instance
	}
	
	List<Rectangulo> areas = newArrayList
	
	def agregarArea(Rectangulo area){
		areas.add(area)
	}
}