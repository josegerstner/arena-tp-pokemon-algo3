package ar.edu.unsam.algo3.tp.model.mail

import org.eclipse.xtend.lib.annotations.Accessors


@Accessors class Mail {
	
	String from
	String to
	String message
	String titulo
	
	new(){
		from = ""
		to = ""
		message = ""
		titulo = ""
	}
	

	override equals(Object objecto) {
		try {
			val Mail otro = objecto as Mail
			return otro.message.equals(message)
		} catch (ClassCastException e) {
			return false
		}
	}

	override hashCode() {
		message.hashCode
	}

}

