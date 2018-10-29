package ar.edu.unsam.algo3.tp.model.observer

import ar.edu.unsam.algo3.tp.model.mail.Mail

abstract class NotificarMail implements CustomObserver  {
	
	def void notificarMail(Mail email)
	
}