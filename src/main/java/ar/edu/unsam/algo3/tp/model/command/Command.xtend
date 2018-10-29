package ar.edu.unsam.algo3.tp.model.command

import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDateTime

@Observable
@Accessors
abstract class Command {
	
	var String nombreComando
	var LocalDateTime ultimaEjecucion
	
	def void execute() {
		println("Se ejecuta comando " + nombreComando)
		this.ultimaEjecucion = LocalDateTime.now
  	}
 	
 	
	def String getNombreComando(){
		nombreComando
	}
	
	
}
