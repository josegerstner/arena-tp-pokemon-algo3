package ar.edu.unsam.algo3.tp.model.observer

import ar.edu.unsam.algo3.tp.model.Entrenador
import ar.edu.unsam.algo3.tp.model.mail.Mail
import ar.edu.unsam.algo3.tp.model.mail.MailSender
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class NotificarNivelMasAltoObserver extends NotificarMail{

	MailSender mailSender
	
	
	
	override notificar(Entrenador entrenador) {
		if (entrenador.nivel.equals(entrenador.getNivelMaximo)) {
			entrenador.agregarNotificacion("Alcanzo el nivel maximo " + entrenador.nivel)
			entrenador.amigos.forEach[entrenadorRepo | 
				entrenadorRepo.agregarNotificacion("El entrenador " + entrenador.nombre + "alcanzo su nivel maximo " + entrenador.nivel)
			]
			entrenador.amigos.
				forEach[entrenadorRepo|notificarMail( new Mail() => [
				from = entrenador.casillaDeMail
				to = entrenadorRepo.casillaDeMail
				message = "El entrenador alcanzo su nivel maximo " + entrenador.nivel
				titulo = "Notificacion"
			])]
		}
	}

	override notificarMail(Mail email) {
		mailSender.send(email)	
	}
	
	override descripcion(){
		"Notificar nivel mas alto"
	}
}
