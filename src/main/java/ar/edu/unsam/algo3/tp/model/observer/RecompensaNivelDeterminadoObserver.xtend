package ar.edu.unsam.algo3.tp.model.observer

import ar.edu.unsam.algo3.tp.model.Entrenador
import ar.edu.unsam.algo3.tp.model.Item
import java.util.HashMap
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class RecompensaNivelDeterminadoObserver implements CustomObserver{
	
	Map<Item,Integer> recompensas = new HashMap
	int nivel
	double dineroRecompensa
	
	override notificar(Entrenador entrenador) {
		if(entrenador.nivel == nivel){
			entrenador.ganarDinero(dineroRecompensa)
			
			for (Map.Entry<Item, Integer> entry : recompensas.entrySet()){
				
				for( var i = 0 ; i < entry.value ; i++ ){
					
					entrenador.agregarItem(entry.key)
				
				}
			
			}
			
		}
	}
	
		override descripcion(){
		"Recompensa"
	}
	
}