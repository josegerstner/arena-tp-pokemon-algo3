package ar.edu.unsam.algo3.tp.model

import org.eclipse.xtend.lib.annotations.Accessors

abstract class Perfil {

	/*
	 * Si el entrenador es criador ganará 200 puntos más y un 20% de la experiencia del pokémon evolucionado.
	 */
	def void accionPorEvolucionarPokemon(Entrenador entrenador, Pokemon pokemonQueSubioDeNivel) {
	}

	/*
	 * Si el entrenador es coleccionista y el pokémon atrapado es nuevo (de una especie no atrapada anteriormente), gana 500 puntos de experiencia adicionales.
	 */
	def void accionPorCapturarPokemon(Entrenador entrenador, Pokemon pokemon) {
	}

	/*
	 * Si el jugador es luchador y el nivel del rival enfrentado supera el propio, suma 200 puntos de experiencia adicionales.
	 */
	def void accionPorGanarCombate(Entrenador entrenador, Entrenador entrenadorRival) {
	}
	
	/*
	 * Develve true si es experto o false si no lo es
	 */
	def boolean esExperto(Entrenador entrenador);

}
@Accessors
class Criador extends Perfil {
	
	val nombre = "Criador";
	
	override accionPorEvolucionarPokemon(Entrenador entrenador, Pokemon pokemonQueSubioDeNivel) {
		
		entrenador.sumarExperiencia(200 + ( pokemonQueSubioDeNivel.experiencia * 0.2 ).intValue )
		
	}
	
	/*
	 *  Es experto si ha evolucionado al menos a 15 pokémons y tiene en su haber más de 5 pokémons con nivel mayor a 20.
	 */
	override esExperto(Entrenador entrenador) {
		
		return entrenador.cantidadPokemonesEvolucionados > 15 && entrenador.cantidadPokemonesConNivelMayorA20 > 5		
		
	}

}
@Accessors
class Coleccionista extends Perfil {
	
	val nombre = "Coleccionista";
	
	override accionPorCapturarPokemon(Entrenador entrenador, Pokemon pokemon) {
		
		entrenador.sumarExperiencia(500)
		
	}
	
	/*
	 *  Es experto si; su nivel es mayor a 13, ha atrapado más de 20 especies distintas 
	 *  y tiene una colección balanceada respecto al género de los pokémons que la componen. 
	 *  Esto quiere decir ninguno de los dos géneros debe superar el 55% de su colección ni bajar del 45%
	 */
	override esExperto(Entrenador entrenador) {
		
		if ( entrenador.equipo.size() == 0 ){
			
			return false
			
		}
	
		return entrenador.nivel > 13 && entrenador.cantidadEspeciesDistintasAtrapadas > 20 && esColeccionBalanceada(entrenador) 

	}
	
	def esColeccionBalanceada(Entrenador entrenador) {
		
		var float cantidadPokemonesMasculinos = entrenador.equipo.filter[ pokemon | Genero.MASCULINO.equals( pokemon.genero ) ].size()
		
		var double proporcionGenero = cantidadPokemonesMasculinos / entrenador.equipo.size()

		proporcionGenero > 0.45 && proporcionGenero < 0.55

	}

}

@Accessors
class Luchador extends Perfil {
	
	val nombre = "Luchador";
	
	override accionPorGanarCombate(Entrenador entrenador, Entrenador entrenadorRival) {

		if (entrenadorRival.nivel > entrenador.nivel) {
			
			entrenador.sumarExperiencia(200)

		}

	}
	
	/*
	 * Es experto si tiene un nivel mayor a 18 o ha ganado más de 30 combates. 
	 */
	override esExperto(Entrenador entrenador) {
	
		return entrenador.nivel > 18 && entrenador.cantidadCombatesGanados > 30
		
	}

}
