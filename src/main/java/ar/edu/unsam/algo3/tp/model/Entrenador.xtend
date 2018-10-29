package ar.edu.unsam.algo3.tp.model

import ar.edu.unsam.algo3.tp.model.exception.CapturarExcepcion
import ar.edu.unsam.algo3.tp.model.observer.CustomObserver
import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.ArrayList
import java.util.HashMap
import java.util.List
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Entrenador implements Entidad{

	def random(){
		return Math.random()
	} 
	int experiencia = 1
	double dinero = 1000
	Point ubicacion
	Perfil perfil
	Map<Item,Integer> items = new HashMap
	List<Pokemon> equipo = new ArrayList()
	List<Pokemon> deposito = new ArrayList()
	List<Especie> especiesAtrapadas = new ArrayList
	int cantidadCombatesGanados = 0
	int cantidadPokemonesEvolucionados = 0
	@JsonIgnore TablaNiveles tablaNiveles = new TablaNiveles
	String nombre
	String imagenEntrenador
	Pokemon pokemonElegido
	
	@Accessors List<Entrenador> amigos
	List<Entrenador> amigosPendientes
	
	List<CustomObserver> observers = newArrayList()
	List<String> notificaciones
	
	List recompensa = newArrayList(5, 15, 20)
 	
 	String casillaDeMail
 	
	def aumentarCombatesGanados(){
		this.cantidadCombatesGanados += 1
	}
	
	def double getDistancia(Point otroPunto) {
		ubicacion.distance(otroPunto)
	}
	
	def void moverse(Point point) {
		this.ubicacion = point
	}
	def void moverseArriba(){
		this.ubicacion = new Point(this.ubicacion.x, this.ubicacion.y + 0.001)
	}
	def void moverseAbajo(){
		this.ubicacion = new Point(this.ubicacion.x, this.ubicacion.y - 0.001)
	}
	def void moverseIzquerda(){
		this.ubicacion = new Point(this.ubicacion.x - 0.001, this.ubicacion.y)
	}
	def void moverseDerecha(){
		this.ubicacion = new Point(this.ubicacion.x + 0.001, this.ubicacion.y)
	}
	

	/*
	 * Captura
	 */
	def void capturar(Pokemon pokemon, Pokebola pokebola) {
		
		//Si esta a mas de 10 metros o no tiene pokebolas
		if( this.ubicacion.distance(pokemon.ubicacion) > 10 ){
			throw new CapturarExcepcion("Esta a mas de 10 metros")
		}
		if( !tieneItem(pokebola) ){
			throw new CapturarExcepcion("No tiene pokebolas")
		}
			
		quitarItem(pokebola)
		
		var loAtrapa = random <= getChancesDeAtrapar(pokebola) / (getChancesDeAtrapar(pokebola) + pokemon.chancesEscapar) 	
		
		if ( loAtrapa ){
			
			if( !especiesAtrapadas.contains(pokemon.especie) ){
				
				perfil.accionPorCapturarPokemon(this,pokemon)
			
			} else{
			
				especiesAtrapadas.add(pokemon.especie)	
			
			}
			
			agregarPokemon(pokemon)
			
			sumarExperiencia(100)
			
		} 
			
	}
	
	def String capturarRespuesta(Pokemon pokemon, Pokebola pokebola) {
		
		//Si esta a mas de 10 metros o no tiene pokebolas
		if( this.ubicacion.distance(pokemon.ubicacion) > 10 ){
			throw new CapturarExcepcion("Esta a mas de 10 metros")
		}
		if( !tieneItem(pokebola) ){
			throw new CapturarExcepcion("No tiene pokebolas")
		}
			
		quitarItem(pokebola)
		
		var loAtrapa = random <= getChancesDeAtrapar(pokebola) / (getChancesDeAtrapar(pokebola) + pokemon.chancesEscapar) 	
		
		if ( loAtrapa ){
			
			if( !especiesAtrapadas.contains(pokemon.especie) ){
				
				perfil.accionPorCapturarPokemon(this,pokemon)
			
			} else{
			
				especiesAtrapadas.add(pokemon.especie)	
			
			}
			
			agregarPokemon(pokemon)
			
			sumarExperiencia(100)
			
			"ATRAPADO"
		} else{
			"SE ESCAPO"
		}
			
	}
	
	def double getChancesDeAtrapar(Pokebola pokebola){
		
		var double chancesDeAtrapar = nivel 
		
		if( esExperto() ){
			chancesDeAtrapar = chancesDeAtrapar * 1.5
		}
		
		val chancePokebola = 1 + pokebola.probabilidadExtraDeAtrapar
		
		chancesDeAtrapar = chancesDeAtrapar * chancePokebola
		
		return chancesDeAtrapar
		
	}
	
	
	def int getNivel() {
		return tablaNiveles.obtenerNivelSegunExperiencia(experiencia)
	}
	
	def int getNivelMaximo(){
		return tablaNiveles.nivelMaximmo
	}
	
	 def recompensaPorNivel(){
	 	return recompensa.contains(nivel) 
	 }
	 
	 
	def boolean esExperto(){
		
		val boolean esExperto = perfil.esExperto(this);
		
		return esExperto
	}
	
	
	def getChancesCombate(Combate combate) {
		var porcentaje = combate.pokemon.calcularChancesCombate( combate.pokemonRival  )
		
		if( esExperto ){
			
			porcentaje += 0.2
			
		}
		
		return porcentaje
		
	}
	
	def void sumarExperiencia(int experienciaGanada){
		val nivelAnterior = nivel
		this.experiencia += experienciaGanada

		if ( nivelAnterior < nivel ){
			observers.forEach[ observer | observer.notificar(this) ] //TODO Ver de pasar la logica del nivel al observer
		}
		
	}
	
	/*
	 * Si tiene espacio en la lista de pokemones los agregar ahi, si no lo agrega al deposito.
	 */
	def agregarPokemon(Pokemon pokemon) {
		
		if( this.equipo.size() < 6 ){
			this.equipo.add(pokemon)
		} else {
			this.deposito.add(pokemon)
		}
		
		//pokemon.entrenador =  this
		
	}
	
	def seleccionarPokemon(Pokemon pokemon){
		if( this.equipo.contains(pokemon) && pokemon.especie.getPuntosSalud>0){
			pokemonElegido = pokemon
		}
	}
	
	def ganarDinero(double dineroGanado){
		
		this.dinero += dineroGanado
		
	}
	
	def perderDinero(double dineroPerdido){
		
		this.dinero -= dineroPerdido
		
	}
	
	def ganarExperiencia(int experienciaGanada){
		
		this.experiencia += experienciaGanada
		
	}
	
	def perderExperiencia(int experienciaPerdida){
		
		this.experiencia -= experienciaPerdida
		
	}
	
	def agregarItem(Item item) {
		
		if( this.items.containsKey(item) ){
			
			this.items.put( item , this.items.get(item) + 1 )

		} else {
			
			this.items.put( item , 1 )
			
		}
		
		
	}
	
	def quitarItem(Item item) {
		
		if( this.items.containsKey(item) && this.items.get(item) > 0 ){
			
			this.items.put( item , this.items.get(item) - 1 )

		}
		
	}
	
	def boolean tieneItem(Item item) {
		
		return this.items.containsKey(item) && this.items.get(item) > 0
	
	}
	
	
	def cambiarEquipo(Pokemon pokemon){
		
		if( equipo.contains(pokemon) ){
			deposito.add(pokemon)
			equipo.remove(pokemon)
			
		} else if( deposito.contains(pokemon) ) {
			
			if( equipo.size() < 6  ){
				equipo.add(pokemon)
				deposito.remove(pokemon)
				
			}
			
		}
		
	}
	
	def getTodasLasEspecies(){
		getTodosLosPokemones().map[ pokemon | pokemon.especie]
	}
	
	def getTodosLosPokemones(){
		equipo + deposito
	}
	
	def getCantidadEspeciesDistintasAtrapadas(){
		especiesAtrapadas.size()
	}
	
	def accionPostCombate(Entrenador entrenadorRival){
		perfil.accionPorGanarCombate(this,entrenadorRival)
	}
	
	def accionPostEvolucionDePokemon(Pokemon pokemonEvolucionado){
		
		perfil.accionPorEvolucionarPokemon(this,pokemonEvolucionado)
		
		cantidadPokemonesEvolucionados ++
		
	}
	
	def getCantidadItems(Item item){
		this.items.get(item)
	}
	
	def getCantidadPokemonesConNivelMayorA20(){
	
		equipo.filter[ pokemon | pokemon.nivel > 20 ].size
		
	}
	
	def aceptarAmigo(Entrenador entrenador){
		amigos.add(entrenador)
		entrenador.amigos.add(this)
		entrenador.amigosPendientes.remove(this)
	}
	
	def rechazarAmigo(Entrenador entrenador){
		amigosPendientes.remove(entrenador)
	}
	
	def solicitarAmistad(Entrenador entrenador){
		entrenador.amigosPendientes.add(this)
	}
	
	def eliminarAmigo(Entrenador entrenador){
		amigos.remove(entrenador)
	}

	def void agregarNotificacion(String notificacion){
		notificaciones.add(notificacion)
	}
	
	def void agregarObserver( CustomObserver observer ){
		observers.add(observer)
	}
	
	def void agregarObservers( List<CustomObserver> observersToAdd ){
		observers.addAll( observersToAdd )
	}
	
	def void quitarObserver( CustomObserver observer ){
		observers.remove(observer)
	}
	
	def void quitarObservers( List<CustomObserver> observers ){
		observers.removeAll( observers )
	}
	
	override validar() {
	}
	
	override getId() {
		return 0
	}
	
	override setId(int id) {
	}
	
	def cantidadObservers(){
		observers.size
	}
	
	def getPokemonPorNombre(String nombrePokemon){
		return (equipo+deposito).filter[p|p.nombre.equals(nombrePokemon)].toList.get(0)
	}

}
