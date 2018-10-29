package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Coleccionista
import ar.edu.unsam.algo3.tp.model.Criador
import ar.edu.unsam.algo3.tp.model.Entrenador
import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Item
import ar.edu.unsam.algo3.tp.model.Luchador
import ar.edu.unsam.algo3.tp.model.Pocion
import ar.edu.unsam.algo3.tp.model.Pokebola
import ar.edu.unsam.algo3.tp.model.Pokemon
import ar.edu.unsam.algo3.tp.model.exception.CapturarExcepcion
import ar.edu.unsam.algo3.tp.model.mail.Mail
import ar.edu.unsam.algo3.tp.model.mail.MailSender
import ar.edu.unsam.algo3.tp.model.observer.NotificarNivelMasAltoObserver
import ar.edu.unsam.algo3.tp.model.observer.NotificarNivelMultiploDe5Observer
import ar.edu.unsam.algo3.tp.model.observer.NotificarSuperaNivelObserver
import ar.edu.unsam.algo3.tp.model.observer.RecompensaNivelDeterminadoObserver
import java.util.ArrayList
import java.util.HashMap
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

class EntrenadorTest extends TestHelper {
	
	Pocion pocion = new Pocion(50,20,"Pocion")
	
	Pokemon pokemon

	Entrenador entrenador
	Entrenador entrenador2 
	
	MailSender mockMailSender
	
	Item itemsTest

	NotificarNivelMultiploDe5Observer notificarNivelMultiploDe5Observer
	NotificarNivelMasAltoObserver notificarNivelMasAltoObserver
	RecompensaNivelDeterminadoObserver recompensaNivelDeterminadoObserver
	NotificarSuperaNivelObserver notificarSuperaNivelObserver

	@Before
	def void init() {

		var Especie especie = new Especie
		
		val superBallTest = new Pokebola(10, 30,"superbola")

		especie.velocidad = 10

		pokemon = crearPokemon(especie)
		
		itemsTest = new Item(60, "pokebola")
		
		mockMailSender = mock(typeof(MailSender))
		
		entrenador = crearEntrenador()
		entrenador2 = crearEntrenador2()
		
		entrenador.nombre = "Marce"
		entrenador2.nombre = "Facu"
		
		entrenador.items = new HashMap
				
		entrenador.casillaDeMail = "entrenador@gmail.com"
		entrenador2.casillaDeMail = "entrenador2@gmail.com"
		
		entrenador.notificaciones = newArrayList
		entrenador2.notificaciones = newArrayList
		
		entrenador.observers = newArrayList
		
		entrenador.amigos = new ArrayList
		entrenador2.amigos = new ArrayList
		
		entrenador.amigosPendientes = new ArrayList
		entrenador2.amigosPendientes = new ArrayList
		
		notificarNivelMultiploDe5Observer = new NotificarNivelMultiploDe5Observer
		notificarNivelMasAltoObserver = new NotificarNivelMasAltoObserver
		recompensaNivelDeterminadoObserver = new RecompensaNivelDeterminadoObserver
		notificarSuperaNivelObserver = new NotificarSuperaNivelObserver
		
		notificarNivelMasAltoObserver.mailSender = mockMailSender
		notificarSuperaNivelObserver.mailSender = mockMailSender
		}
		
	@Test
	def notificarNivelMultiploDe5NotificaATodosLosAmigos() {
		doNothing().when(mockMailSender).send(any(Mail))

		entrenador.agregarObserver(notificarNivelMultiploDe5Observer)
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(10009)

		Assert.assertTrue(entrenador2.notificaciones.contains("El entrenador" + entrenador.nombre + "alcanzo el nivel " + entrenador.nivel))
	}
	
	@Test
	def notificarNivelMultiplode5SeAgregaNotificacion(){
		entrenador.agregarObserver(notificarNivelMultiploDe5Observer)
		entrenador.sumarExperiencia(10000)
		Assert.assertTrue(entrenador.notificaciones.contains("El entrenador" + entrenador.nombre + "alcanzo el nivel " + entrenador.nivel))
	}
	
	@Test
	def notificarNivelMasAltoEnviarMail(){
		doNothing().when(mockMailSender).send(any(Mail))
		
		entrenador.observers.add(notificarNivelMasAltoObserver)
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(210000)
		
		verify(mockMailSender, times(1)).send(any(Mail))
	}
	
	@Test
	def notificarNivelMasAltoAgregaNotificacion(){
		doNothing().when(mockMailSender).send(any(Mail))
		
		entrenador.agregarObserver(notificarNivelMasAltoObserver)
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(210009)
		Assert.assertTrue(entrenador.notificaciones.contains("Alcanzo el nivel maximo " + entrenador.nivel))
	}
	
	@Test
	def notificarNivelMasAltoAgregaNotificacionATtodosLosAmigos(){
		doNothing().when(mockMailSender).send(any(Mail))
		
		entrenador.agregarObserver(notificarNivelMasAltoObserver)
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(210009)
		Assert.assertTrue(entrenador2.notificaciones.contains("El entrenador " + entrenador.nombre + "alcanzo su nivel maximo " + entrenador.nivel))
	}
	
	@Test
	def recompensaPorSubirDenivelDinero(){
		entrenador.agregarObserver(recompensaNivelDeterminadoObserver)
		recompensaNivelDeterminadoObserver.dineroRecompensa = 500
		recompensaNivelDeterminadoObserver.nivel = 5
		
		entrenador.sumarExperiencia(10000)
		Assert.assertEquals(1500 ,entrenador.dinero, 0)
	}
	
	@Test
	def recompensaPorSubirDenivelItem(){
		entrenador.agregarObserver(recompensaNivelDeterminadoObserver)
		recompensaNivelDeterminadoObserver.recompensas.put(itemsTest, 5)
		recompensaNivelDeterminadoObserver.nivel = 5
		entrenador.sumarExperiencia(10009)
		Assert.assertTrue(entrenador.items.containsKey(itemsTest))
	}
	
	@Test
	def notificarSuperaNivel(){
		doNothing().when(mockMailSender).send(any(Mail))
		
		entrenador.agregarObserver(notificarSuperaNivelObserver)
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(10000)
		
		verify(mockMailSender, times(1)).send(any(Mail))
	}
	
	@Test
	def notificarSuperaNivelAgregaNotificacion(){
		doNothing().when(mockMailSender).send(any(Mail))
		
		entrenador.agregarObserver(notificarSuperaNivelObserver)
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(10009)
		Assert.assertTrue(entrenador.notificaciones.contains("Te paso de nivel"))
		}
		
		@Test
	def notificarSuperaNivelAgregaNotificacionATodosLosAmigos(){
		doNothing().when(mockMailSender).send(any(Mail))
		
		entrenador.agregarObserver(notificarSuperaNivelObserver)
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(10009)
		Assert.assertTrue(entrenador2.notificaciones.contains("El entrenador" + entrenador.nombre + "te paso de nivel" + entrenador.nivel))
		}
		
	@Test
	def subeNivelPeroNoMandaMail(){
		val observersTest = newArrayList(
			notificarSuperaNivelObserver,
			notificarNivelMasAltoObserver,
			recompensaNivelDeterminadoObserver,
			notificarSuperaNivelObserver
		)
		entrenador.agregarObservers(observersTest)
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(2)
		verify(mockMailSender, times(0)).send(any(Mail))
	}
		
	@Test
	def subeNivelEnvia2Mails(){
		doNothing().when(mockMailSender).send(any(Mail))	
//		val List<CustomObserver> observersTest = newArrayList(
//				notificarNivelMultiploDe5Observer, notificarNivelMasAltoObserver, recompensaNivelDeterminadoObserver, notificarSuperaNivelObserver
//			)
//		entrenador.agregarObservers(observersTest)
		entrenador.agregarObserver(notificarNivelMasAltoObserver)
		entrenador.agregarObserver(notificarSuperaNivelObserver)
		
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(210000)
		verify(mockMailSender, times(2)).send(any(Mail))
		}
		
	@Test
	def quitoObserverSumaExperienciaYNoMandaMail() {
		doNothing().when(mockMailSender).send(any(Mail))

		entrenador.agregarObserver(notificarNivelMultiploDe5Observer)
		entrenador.agregarObserver(notificarNivelMasAltoObserver)
		entrenador.quitarObserver(notificarNivelMultiploDe5Observer)
		
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(10009)
		verify(mockMailSender, times(0)).send(any(Mail))

	}
		
	@Test
	def subeDeNNivelPeroNoAgrenaNotificacion() {
		val observersTest = newArrayList(
			notificarNivelMultiploDe5Observer,
			notificarNivelMasAltoObserver,
			recompensaNivelDeterminadoObserver,
			notificarSuperaNivelObserver
		)
		entrenador.agregarObservers(observersTest)
		entrenador.amigos.add(entrenador2)
		entrenador.sumarExperiencia(2)
		Assert.assertEquals(0, entrenador.notificaciones.size)
	}

	@Test
	def void testDecrementaLasPokebolas() {
		
		entrenador = stubearEntrenador(0.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)
		
		entrenador.perfil = new Coleccionista

		val pokebola = new Pokebola(0, 0,"pokebola")

		entrenador.agregarItem(pokebola)

		entrenador.capturar(pokemon, pokebola)

		Assert.assertEquals(0, entrenador.getCantidadItems(pokebola), 0.01)

	}
	

	@Test
	def void testAumentaElEquipo() {
	
		entrenador = stubearEntrenador(0.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)
		
		entrenador.perfil = new Coleccionista

		val pokebolas = new Pokebola(0, 0,"pokebola")

		entrenador.agregarItem((pokebolas))

		entrenador.capturar(pokemon, pokebolas)

		Assert.assertEquals(1, entrenador.equipo.size(), 0.01)

	}

	@Test
	def void testQuedaIgualElDeposito() {

		entrenador = stubearEntrenador(0.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)
		
		entrenador.perfil = new Coleccionista

		val pokebolas = new Pokebola(0, 0,"pokebola")

		entrenador.agregarItem((pokebolas))

		entrenador.capturar(pokemon, pokebolas)

		Assert.assertEquals(0, entrenador.deposito.size(), 0.01)

	}

	@Test
	def void testCapturarPokemonColeccionistaOK() {

		entrenador = stubearEntrenador(0.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)
		
		entrenador.perfil = new Coleccionista

		val pokebolas = new Pokebola(0, 0,"pokebola")

		entrenador.agregarItem((pokebolas))

		entrenador.capturar(pokemon, pokebolas)

		Assert.assertEquals(601, entrenador.experiencia, 0.01)

	}

	@Test
	def void testCapturarPokemonCriadorOK() {
	
		entrenador = stubearEntrenador(0.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)
		
		entrenador.perfil = new Criador

		val pokebolas = new Pokebola(0, 0,"pokebola")

		entrenador.agregarItem((pokebolas))

		entrenador.capturar(pokemon, pokebolas)

		Assert.assertEquals(101, entrenador.experiencia, 0.01)
	}

	@Test
	def void testCapturarPokemonLuchadorOK() {

		entrenador = stubearEntrenador(0.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)
		
		entrenador.perfil = new Luchador

		val pokebolas = new Pokebola(0, 0,"pokebola")

		entrenador.agregarItem((pokebolas))

		entrenador.capturar(pokemon, pokebolas)

		Assert.assertEquals(101, entrenador.experiencia, 0.01)
	}

	@Test
	def void testCapturarPokemonNOK() {

		entrenador = stubearEntrenador(1.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)
		
		entrenador.perfil = new Luchador

		val pokebolas = new Pokebola(0, 0,"pokebola")

		entrenador.agregarItem((pokebolas))

		entrenador.capturar(pokemon, pokebolas)

		Assert.assertEquals(1, entrenador.experiencia, 0.01)

	}

	@Test(expected=CapturarExcepcion)
	def void testCapturarPokemonSinPokebolas() {
		
		entrenador = stubearEntrenador(0.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)
		
		entrenador.perfil = new Luchador

		entrenador.capturar(pokemon, new Pokebola(0, 0,"pokebola"))

	}

	@Test(expected=CapturarExcepcion)
	def void testCapturarPokemonDemaciadoLejos() {

		pokemon.ubicacion = new Point(1, 1)

		entrenador.capturar(pokemon, new Pokebola(0, 0,"pokebola"))

	}

	@Test
	/*
	 * Testea el caso limite que hasta los 6 pokemones, ninguno se agrega al deposito
	 */
	def void testCapturar6Pokemones() {
	
		entrenador = stubearEntrenador(0.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)

		entrenador.perfil = new Coleccionista

		entrenador.deposito = new ArrayList

		for (var i = 0; i < 5; i++) {

			entrenador.agregarPokemon(new Pokemon())

		}
		
		val pokebolas = new Pokebola(0, 0,"pokebola")

		entrenador.agregarItem((pokebolas))

		entrenador.capturar(pokemon, pokebolas)

		Assert.assertEquals(0, entrenador.deposito.size(), 0.01)

	}

	@Test
	def void testCapturarPokemonQueVaAlDeposito() {
	
		entrenador = stubearEntrenador(0.0)
		entrenador.ubicacion = new Point(0.00001, 0.00001)
		
		entrenador.perfil = new Coleccionista

		entrenador.deposito = new ArrayList

		for (var i = 0; i < 6; i++) {

			entrenador.agregarPokemon(new Pokemon())

		}

		val pokebolas = new Pokebola(0, 0,"pokebola")

		entrenador.agregarItem((pokebolas))

		entrenador.capturar(pokemon, pokebolas)

		Assert.assertEquals(601, entrenador.experiencia, 0.01)

	}

	@Test
	def void testMoverseLatitud() {

		entrenador.moverse(new Point(0.1, 0.1))

		Assert.assertEquals(0.1, entrenador.ubicacion.latitude, 0.01)

	}

	@Test
	def void testMoverseLongitud() {

		entrenador.moverse(new Point(0.1, 0.1))

		Assert.assertEquals(0.1, entrenador.ubicacion.longitude, 0.01)

	}
	
	def stubearEntrenador(double valorRandom) {
		var entrenador = spy(typeof(Entrenador)) 
		when(entrenador.random).thenReturn(valorRandom)
		entrenador
	}
	
	/**
	 * Amistad
	 */
	@Test
	def testAgregarAmigoSuma1AmigoALaLista(){
		val cantidadAmigos = entrenador.amigos.size
		
		entrenador.aceptarAmigo(entrenador2)
		Assert.assertEquals(cantidadAmigos +1, entrenador.amigos.size)
	}
	
	@Test
	def testAgregarAmigoVerficaAmigoEnLaLista(){
		entrenador.aceptarAmigo(entrenador2)
		Assert.assertTrue(entrenador.amigos.contains(entrenador2))
	}
	
	@Test
	def testEliminarAmigoResta1AmigoALaListaMia(){
		entrenador.aceptarAmigo(entrenador2)
		val cantidadAmigos = entrenador.amigos.size
		
		entrenador.eliminarAmigo(entrenador2)
		Assert.assertEquals(cantidadAmigos -1, entrenador.amigos.size)
	}
	
	@Test
	def testEliminarAmigoResta1AmigoALaListaDelOtro(){
		entrenador2.aceptarAmigo(entrenador)
		val cantidadAmigos = entrenador2.amigos.size
		
		entrenador2.eliminarAmigo(entrenador)
		Assert.assertEquals(cantidadAmigos -1, entrenador2.amigos.size)		
	}
	
	@Test
	def testSolicitudDeAmistadSuma1ListaPendiente(){
		val cantidadSolicitudes = entrenador2.amigosPendientes.size
		entrenador.solicitarAmistad(entrenador2)
		Assert.assertEquals(cantidadSolicitudes +1, entrenador2.amigosPendientes.size)
	}
	
	@Test
	def testAceptarAmistadSuma1ListaAmigosMia(){
		val cantidadAmigos = entrenador2.amigos.size
		entrenador.aceptarAmigo(entrenador2)
		Assert.assertEquals(cantidadAmigos +1, entrenador.amigos.size)
	}
	
	@Test
	def testAceptarAmistadResta1ListaPendienteMia(){
		entrenador.solicitarAmistad(entrenador2)
		val cantidadSolicitudes = entrenador2.amigosPendientes.size
		entrenador.aceptarAmigo(entrenador2)
		Assert.assertEquals(cantidadSolicitudes -1, entrenador2.amigosPendientes.size)
	}
	
	@Test
	def testAceptarAmistadSuma1ListaAmigosDelOtro(){
		val cantidadAmigos = entrenador2.amigos.size
		entrenador.aceptarAmigo(entrenador2)
		Assert.assertEquals(cantidadAmigos +1, entrenador2.amigos.size)
	}
	
	@Test
	def testRechazarSolicitudDeAmistadResta1ListaPendiente(){
		entrenador2.solicitarAmistad(entrenador)
		val cantidadSolicitudes = entrenador.amigosPendientes.size
		entrenador.rechazarAmigo(entrenador2)
		Assert.assertEquals(cantidadSolicitudes -1, entrenador.amigosPendientes.size)
	}
	
	@Test
	def testSolicitaAmistadYAcepta(){
		entrenador.solicitarAmistad(entrenador2)
		entrenador2.aceptarAmigo(entrenador)
		Assert.assertTrue(entrenador.amigos.contains(entrenador2))
	}
	
}

