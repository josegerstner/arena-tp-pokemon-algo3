package ar.edu.unsam.algo3.tp.model;

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.geodds.Point

@Accessors
class Pokemon extends Entity implements Entidad{
	int experiencia = 0
	Especie especie
	Point ubicacion
	int puntosDeSalud
	String nombre
	Genero genero
	Entrenador entrenador
	String nombreFamilia
		
	def double getDistancia(Point otroPunto) {
		ubicacion.distance(otroPunto)
	}

	def initEspecie(Especie _especie) {
		especie = _especie
	}

	def double getPuntosAtaque() {
		return especie.puntosAtaque * nivel
	}

	def int getPuntosSaludMaximo() {
		return especie.puntosSalud * nivel
	}
	
	def sumarPuntosDeSalud(int puntosDeSaludGanados){
		
		if( puntosDeSalud + puntosDeSaludGanados > puntosSaludMaximo ){
			
			puntosDeSalud = puntosSaludMaximo
			
		} else {
			
			puntosDeSalud += puntosDeSaludGanados
			
		}
		
	}
	
	def getPuntosDeSaludFaltantes(){
		puntosSaludMaximo - puntosDeSalud
	}
	
	def curarTodaLaSalud(){
		sumarPuntosDeSalud( puntosDeSaludFaltantes )
	}
	
	def restarPuntosDeSalud(int puntosDeSaludPerdidos){
		puntosDeSalud = Math.max(0, (puntosDeSalud - puntosDeSaludPerdidos)) 
	}

	def int getNivel() {
		( (Math.sqrt(100 * (2 * experiencia + 25)) + 50) / 100 ).intValue
	}
	
	def int setNivel(int nivel) {
//		nivel = ( (Math.sqrt(100 * (2 * experiencia + 25)) + 50) / 100 ).intValue
//		nivel * 100 = Math.sqrt(100 * (2 * experiencia + 25)) + 50
//		( ( nivel * 100 ) - 50 ) = Math.sqrt(100 * (2 * experiencia + 25))
//		Math.pow( ( ( nivel * 100 ) - 50 ) , 2 ) = 100 * (2 * experiencia + 25)
//		( Math.pow( ( ( nivel * 100 ) - 50 ) , 2 ) / 100 ) = 2 * experiencia + 25
//		( Math.pow( ( ( nivel * 100 ) - 50 ) , 2 ) / 100 ) - 25 = 2 * experiencia
//		( ( Math.pow( ( ( nivel * 100 ) - 50 ) , 2 ) / 100 ) - 25 ) / 2 = experiencia
		
		experiencia = ( ( ( Math.pow( ( ( nivel * 100 ) - 50 ).intValue , 2 ) / 100 ) - 25 ) / 2 ).intValue
	}	
	
	def double getVelocidad(){
		return especie.velocidad
	}
	
	def double getChancesEscapar(){
		return nivel * (1 + velocidad / 10)
	}
	
	def sumarExperiencia(int experienciaSumada){
		this.experiencia += experienciaSumada
		evolucionarSiCorresponde()
	}
	
	/*
	 * Donde las chances de cada pokémon están definidas por sus puntos de ataque más:
	 * Un 25% (de sus puntos de ataque) adicional si es fuerte respecto al rival
	 * Un 15% (de sus puntos de ataque) adicional si es resistente respecto al rival
	 *
	 */
	def double calcularChancesCombate(Pokemon pokemon){
		
		var porcentaje = pokemon.puntosAtaque
		
		if ( pokemon.esFuerteContra(pokemon) ){
			
			porcentaje = porcentaje * 1.25
			
		} if ( pokemon.esResistente(pokemon) ){
			
			porcentaje = porcentaje * 1.15
			
		} 
		
		return porcentaje
		
	}
	
	def boolean esFuerteContra(Pokemon pokemon){
		return especie.esFuerteContra( pokemon.especie )
	}
	
	def boolean esResistente(Pokemon pokemon){
		return especie.esResistente( pokemon.especie )
	}
	
	def evolucionarSiCorresponde(){
		
		if ( especie.debeEvolucionar(this) ){
			
			this.especie = especie.especieEvolucion
			
			this.entrenador.accionPostEvolucionDePokemon(this)
			
		}
		
		
		
	}
	
	def boolean tieneLaSaludAlMaximo(){
		
		this.puntosDeSalud == puntosSaludMaximo
		
	}
	
	def boolean tieneTipo(Tipo tipo){
		especie.tieneTipo(tipo)
	}
	
	def boolean tieneAlgunTipo(List<Tipo> tipos){
		especie.tieneAlgunTipo(tipos)
	}
	
	def agregarTipo(Tipo tipo){
		especie.agregarTipo(tipo)
	}
	
	override validar() {
	}
	
//	override getId() {
//		return 0
//	}
	
	override setId(int id) {
	}
	
}
