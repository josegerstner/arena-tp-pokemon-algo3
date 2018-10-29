package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Entrenador
import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Pocion
import ar.edu.unsam.algo3.tp.model.Pokebola
import ar.edu.unsam.algo3.tp.model.Pokeparada
import ar.edu.unsam.algo3.tp.model.exception.DistanciaExcepcion
import ar.edu.unsam.algo3.tp.model.exception.SinDineroExcepcion
import ar.edu.unsam.algo3.tp.model.exception.ValidacionExcepcion
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class PokeparadaTest extends TestHelper {

	Pokeparada pokeparada = new Pokeparada() =>[
		ubicacion = new Point(0.0, 0.0)
		nombre = "Pokeparada Obelisco"
	]
	
	Pokeparada pokeparadaInvalida = new Pokeparada

	Entrenador entrenador = new Entrenador

	Especie especie

	Pokebola superball = new Pokebola(0, 0,"pokebola")
	Pokebola pokebola = new Pokebola(0, 0,"pokebola")

	Pocion posion = new Pocion(50, 20,"Pocion")
	Pocion superPosion = new Pocion(100, 50,"SuperPosion")

	@Before
	def void init() {

		pokeparada.agregarItem(posion)
		pokeparada.agregarItem(pokebola)

		entrenador.dinero = 1000

		especie = new Especie

		especie.puntosSalud = 10

		for (var i = 0; i < 2; i++) {

			entrenador.agregarPokemon(crearPokemon(especie))

		}

		entrenador.ubicacion = new Point(0.0, 0.0)

	}

	@Test
	def void testComprarGastaDinero() {
		pokeparada.agregarItem(superPosion)
		pokeparada.comprar(entrenador, superPosion)

		Assert.assertEquals(900, entrenador.dinero, 0.0)

	}

	@Test
	def void testComprarAumentaItem() {
		pokeparada.comprar(entrenador, posion)

		Assert.assertEquals(1, entrenador.getCantidadItems(posion), 0.0)

	}

	@Test
	def void testCurar() {

		pokeparada.curacion(entrenador)

		Assert.assertFalse(entrenador.todosLosPokemones.exists[pokemon|! pokemon.tieneLaSaludAlMaximo])

	}
	
	@Test(expected=SinDineroExcepcion)
	def void NoCompraPorqueNoTieneDinero() {
		entrenador.dinero = 0 
		pokeparada.agregarItem(posion)
		pokeparada.comprar(entrenador,posion)
	}
	
	@Test(expected=DistanciaExcepcion)
	def void NoCompraPorqueEstaLejos() {
		entrenador.moverse(new Point(13.1, 15.1))
		pokeparada.ubicacion = new Point(0.0, 0.0)
		pokeparada.comprar(entrenador, posion)
	}

//testea que tenga disponible el item
	@Test
	def void estaDisponiblePosionEnPokeparada() {

		pokeparada.estaDisponible(posion)
		Assert.assertTrue(pokeparada.estaDisponible(posion))
	}

	@Test
	def void NoestaDisponiblePosionEnPokeparada() {
		pokeparada.estaDisponible(superPosion)
		Assert.assertFalse(pokeparada.estaDisponible(superPosion))
	}

	@Test
	def void EstaDisponiblePokebolaEnPokeparada() {
		pokeparada.estaDisponible(pokebola)
		Assert.assertTrue(pokeparada.estaDisponible(pokebola))
	}

	@Test
	def void NoEstaDisponiblePokebolaEnPokeparada() {
		pokeparada.estaDisponible(superball)
		Assert.assertFalse(pokeparada.estaDisponible(superball))
	}

	@Test
	def void validarPokeparada() {
		pokeparada.validar
	}

	 @Test(expected=ValidacionExcepcion)
	def void validarPokeparadaQueDaError(){
		pokeparadaInvalida.validar
	}
}
