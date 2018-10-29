package ar.edu.unsam.algo3.tp.model

import ar.edu.unsam.algo3.tp.model.exception.CombateExcepcion
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Combate {
	
	def random(){
		Math.random()
	}

	double apuesta
	Pokemon pokemon
	Pokemon pokemonRival
	Entrenador entrenador
	Entrenador entrenadorRival
	
	def combatir(){
		
		if( entrenador.getDistancia(entrenadorRival.ubicacion) > 5 ){
			throw new CombateExcepcion("Error combatiendo, esta a mas de 5 metros de distancia")
		}
			
		var gana = random <= chancesEntrenadorPropioCombate / (chancesEntrenadorPropioCombate + chancesEntrenadorRivalCombate)
		
		if( gana ){
			
			entrenador.aumentarCombatesGanados
			
			entrenador.ganarDinero(apuesta)
			
			entrenador.ganarExperiencia(300)
			
			entrenador.accionPostCombate(entrenadorRival)
			
			pokemon.sumarExperiencia( (pokemonRival.experiencia * 0.1).intValue )
			
			var danioRecibido = pokemon.puntosSaludMaximo * ( pokemon.puntosAtaque / ( pokemon.puntosAtaque + pokemonRival.puntosAtaque ))
			
			pokemon.restarPuntosDeSalud( danioRecibido.intValue )
			
		}else {
			
			entrenador.perderDinero(apuesta)
			
			pokemon.puntosDeSalud = 0
			
		}
		
	}
	
	def String combatirRespuesta(){
		
		if( entrenador.getDistancia(entrenadorRival.ubicacion) > 0.005 ){
			throw new CombateExcepcion("Error combatiendo, esta a mas de 5 metros de distancia")
		}
			
		var gana = random <= chancesEntrenadorPropioCombate / (chancesEntrenadorPropioCombate + chancesEntrenadorRivalCombate)
		
		if( gana ){
			
			entrenador.aumentarCombatesGanados
			
			entrenador.ganarDinero(apuesta)
			
			entrenador.ganarExperiencia(300)
			
			entrenador.accionPostCombate(entrenadorRival)
			
			pokemon.sumarExperiencia( (pokemonRival.experiencia * 0.1).intValue )
			
			var danioRecibido = pokemon.puntosSaludMaximo * ( pokemon.puntosAtaque / ( pokemon.puntosAtaque + pokemonRival.puntosAtaque ))
			
			pokemon.restarPuntosDeSalud( danioRecibido.intValue )
			
			"VICTORIA"
		}else {
			
			entrenador.perderDinero(apuesta)
			
			pokemon.puntosDeSalud = 0
			
			"DERROTA"
		}
		
	}
	
	def getChancesEntrenadorPropioCombate() {
		
		calcularChancesCombate(entrenador, pokemon , pokemonRival )
		
	}
	
	def getChancesEntrenadorRivalCombate() {
		
		calcularChancesCombate(entrenadorRival, pokemonRival , pokemon )
		
	}
	
	def calcularChancesCombate(Entrenador entrenador, Pokemon pokemon , Pokemon pokemonRival ) {
		
		var porcentaje = pokemon.calcularChancesCombate( pokemonRival  )
		
		if( entrenador.esExperto ){
			
			porcentaje += 0.2
			
		}
		
		return porcentaje
		
	}
	
}
						