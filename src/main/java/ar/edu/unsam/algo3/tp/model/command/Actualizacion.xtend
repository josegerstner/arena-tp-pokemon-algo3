package ar.edu.unsam.algo3.tp.model.command

import ar.edu.unsam.algo3.tp.model.Repositorio
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unsam.algo3.tp.model.json.JsonParserRepo

@Accessors
class Actualizacion extends Command{
	
	List<Repositorio> repositorios =  newArrayList
	
	new() {
			
	}
	
	new(List<Repositorio> lista) {
		repositorios=lista
	}
	
	override execute() {
		repositorios.forEach[ updateAll ]
	}
	
	def addRepositorio(Repositorio _R){
		repositorios.add(_R)
	}
	def removeRepositorio(Repositorio _R){
		if (repositorios.contains(_R))
			repositorios.remove(_R)
	}
} 