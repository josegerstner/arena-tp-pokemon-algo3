package ar.edu.unsam.algo3.tp.model.command

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ComandoMultiple extends Command {

	List<Command> comandos = newArrayList

	new() {
	}

	new(List<Command> comandos) {
		this.comandos = comandos
	}

	override execute() {
		comandos.forEach[execute]
	}

	def addComando(Command comando) {
		comandos.add(comando)
	}

	def quitarComando(Command comando) {
		comandos.remove(comando)
	}

	def addComandos(List<Command> comandos) {
		comandos.addAll(comandos)
	}

	def quitarComandos(List<Command> comandos) {
		comandos.removeAll(comandos)
	}
}
