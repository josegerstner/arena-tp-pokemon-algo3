package ar.edu.unsam.algo3.tp.viewModel

import ar.edu.unsam.algo3.tp.model.Repositorio
import ar.edu.unsam.algo3.tp.model.RepositorioEspecie
import ar.edu.unsam.algo3.tp.model.RepositorioPokeparada
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unsam.algo3.tp.ui.utils.ModelWithListAndSelect
import ar.edu.unsam.algo3.tp.model.Entidad
import ar.edu.unsam.algo3.tp.model.command.Actualizacion
import ar.edu.unsam.algo3.tp.ui.dao.RepositorioRepositorio

@Accessors
@Observable
class RepositoriosModelo {
	var Repositorio<Entidad> repoSeleccionado
	var Actualizacion actualizacion = new Actualizacion()
	var Repositorio<Entidad> repoSeleccionadoTabla
	var int flagRepo = 0

	new(Actualizacion _A) {
		actualizacion = _A
	}

	new() {
	}

	@Dependencies("flagRepo")
	def getRepositoriosCommando() {
		actualizacion.repositorios
	}

	def getRepositorioSeleccionado() {
		repoSeleccionado
	}

	def agregarRepositorio() {
		actualizacion.addRepositorio(repoSeleccionado)
		actualizarFlag
	}

	def eliminarRepositorio() {
		actualizacion.removeRepositorio(repoSeleccionadoTabla)
		actualizarFlag
	}

	def getRepositorios() {
		RepositorioRepositorio.instance.acciones
	}

	def agregarComando(){
		RepositorioProcesos.instance.agregarProceso(actualizacion)
	}
	
	def actualizarFlag() {
		flagRepo = flagRepo + 1
	}
}
