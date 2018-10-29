package ar.edu.unsam.algo3.tp.model.command

import java.util.List

interface AdministacionDelSistemaI {
	
	def void run(List<Command> comandos)
	def void runIndividual(Command comando)
}
