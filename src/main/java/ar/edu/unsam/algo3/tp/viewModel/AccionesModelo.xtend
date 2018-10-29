package ar.edu.unsam.algo3.tp.viewModel

import ar.edu.unsam.algo3.tp.model.command.AdministacionDelSistema
import ar.edu.unsam.algo3.tp.model.command.AgregarAcciones
import ar.edu.unsam.algo3.tp.model.observer.CustomObserver
import ar.edu.unsam.algo3.tp.model.observer.NotificarNivelMasAltoObserver
import ar.edu.unsam.algo3.tp.model.observer.NotificarNivelMultiploDe5Observer
import ar.edu.unsam.algo3.tp.model.observer.NotificarSuperaNivelObserver
import ar.edu.unsam.algo3.tp.model.observer.RecompensaNivelDeterminadoObserver
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
//FIXME Ver si esto sirve de algo
@Deprecated
class AccionesModelo {

	var CustomObserver seleccionAccion
	var AgregarAcciones accionesNivel = new AgregarAcciones()
	var CustomObserver seleccionEliminar
	
	def getAcciones() {
		var notificarNivelmasAlto = new NotificarNivelMasAltoObserver()
		var notificarNivelMultiplo = new NotificarNivelMultiploDe5Observer()
		var notificarSuperaNivel = new NotificarSuperaNivelObserver()
		var recompensaNivelDeterminado = new RecompensaNivelDeterminadoObserver()
		#[notificarNivelmasAlto, notificarNivelMultiplo, notificarSuperaNivel, recompensaNivelDeterminado]
	}

	def void addAccion() {
		accionesNivel.agregarAccionIndividual(seleccionAccion)
	}

	def void removeAccion() {
		accionesNivel.eliminarAccionIndividual(seleccionEliminar)
	}
	
	def void AgregarComando(AdministacionDelSistema administrador){
		administrador.agregarComando(this.accionesNivel)
	}
	
	
}
