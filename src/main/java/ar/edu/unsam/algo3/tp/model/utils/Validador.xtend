package ar.edu.unsam.algo3.tp.model.utils

import ar.edu.unsam.algo3.tp.model.exception.ValidacionExcepcion
import java.util.List

class Validador {
	
	def static void validarStringRequerido(String stringAValidar, String descripcion){
		if ( stringAValidar == null || stringAValidar.trim.isEmpty ) {
			throw new ValidacionExcepcion( descripcion + " no debe ser " + stringAValidar)
		}
	}
	
	def static void validarListaRequerida(List<?> listaAValidar, String descripcion){
		if ( listaAValidar == null || listaAValidar.isEmpty ) {
			throw new ValidacionExcepcion( descripcion + " no debe ser " + listaAValidar)
		}
	}
	
	def static void validarEnteroRequerido(int enteroAValidar, String descripcion){
		if ( enteroAValidar == 0 ) {
			throw new ValidacionExcepcion( descripcion + " no debe ser " + enteroAValidar)
		}
	}
	
	def static void validarObjetoRequerido(Object objetoAValidar, String descripcion){
		if ( objetoAValidar == null ) {
			throw new ValidacionExcepcion( descripcion + " no debe ser nulo" )
		}
	}
	
}