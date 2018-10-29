package ar.edu.unsam.algo3.tp.model.observer

import ar.edu.unsam.algo3.tp.model.Entrenador

interface CustomObserver {

	
	def void notificar(Entrenador entrenador)
	
	def String descripcion()
	
}
