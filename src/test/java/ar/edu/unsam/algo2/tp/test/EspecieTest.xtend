package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.Tipo
import ar.edu.unsam.algo3.tp.model.exception.ValidacionExcepcion
import org.junit.Assert
import org.junit.Before
import org.junit.Test

import static org.mockito.Mockito.*

class EspecieTest {

	Tipo agua = new Tipo("Agua")
	Tipo fuego = new Tipo("Fuego")
	Tipo tierra = new Tipo("Tierra")
	Tipo roca = new Tipo("Roca")
	Tipo hielo = new Tipo("Hielo")
	Tipo acero = new Tipo("Acero")
	Tipo viento = new Tipo("Viento")
	Tipo hierba = new Tipo("Hierba")
	Tipo veneno = new Tipo("Veneno")
	Tipo electrico = new Tipo("Electrico")

	Especie bulbasaur = crearBulbasaur
	Especie especieA = new Especie
	Especie pikachu = crearPikachu
	Especie especieB = new Especie
	Especie especieC = new Especie
	
	def crearBulbasaur() {
		new Especie() => [
			numero = 1
			nombre = "Bulbasaur"
			puntosAtaque = 10
			puntosSalud = 15
			descripcion = "Este pokemon es un Bulbasaur es fácil verle echándose una siesta al sol."
			tipos = newArrayList(hierba, veneno)
			velocidad = 7
		]
	}
	
	def crearPikachu() {
		new Especie() => [
			numero = 25
			nombre = "Pikachu"
			puntosAtaque = 20
			puntosSalud = 25
			descripcion = "Es un pikachu que no esta en el repo"
			tipos = newArrayList(electrico)
			velocidad = 5
		]
	}
	
	@Before
	def void init() {

		agua.agregarTipoAlQueEsFuerte(fuego)
		agua.agregarTipoAlQueEsFuerte(tierra)
		agua.agregarTipoAlQueEsFuerte(roca)

		agua.agregarTipoAlQueEsResistente(fuego)
		agua.agregarTipoAlQueEsResistente(hielo)
		agua.agregarTipoAlQueEsResistente(acero)
		agua.agregarTipoAlQueEsResistente(agua)

		especieA.agregarTipo(agua)
		especieB.agregarTipo(fuego)
		especieC.agregarTipo(viento)


	}

	@Test
	def void testVelocidadCorrecta() {

		especieA.velocidad = 5

		Assert.assertEquals(5, especieA.velocidad)

	}
	
	@Test //mock con tipos con que es fuerte
	def void mockearEsfuerteContra(){
		val picachu = mock(typeof(Especie)) 
		when(picachu.esFuerteContra(especieB)).thenReturn(true)
		when(picachu.esFuerteContra(especieA)).thenReturn(false)
	}

	@Test
	def void testVelocidad0Correcta() {

		especieA.velocidad = 0

		Assert.assertEquals(0, especieA.velocidad)

	}

	@Test
	def void testVelocidad10Correcta() {

		especieA.velocidad = 10

		Assert.assertEquals(10, especieA.velocidad)

	}

	@Test(expected=IllegalArgumentException)
	def void testVelocidadMayorA10Incorrecta() {

		especieA.velocidad = 11

	}

	@Test(expected=IllegalArgumentException)
	def void testVelocidadMenorA0Incorrecta() {

		especieA.velocidad = -1

	}

	@Test
	def void testEspecieEsResistente() {

		Assert.assertEquals(true, especieA.esResistente(especieB))

	}

	@Test
	def void testEspecieNoEsResistente() {

		Assert.assertEquals(false, especieA.esResistente(especieC))

	}

	@Test
	def void testEspecieEsFuerte() {

		Assert.assertEquals(true, especieA.esFuerteContra(especieB))

	}

	@Test
	def void testEspecieNoEsFuerte() {

		Assert.assertEquals(false, especieA.esFuerteContra(especieC))

	}

	@Test
	def void testTipoEsResistente() {

		Assert.assertEquals(true, agua.esResistente(newArrayList(fuego)))

	}

	@Test
	def void testTipoNoEsResistente() {

		Assert.assertEquals(false, agua.esResistente(newArrayList(roca)))

	}

	@Test
	def void testTipoEsFuerte() {

		Assert.assertEquals(true, agua.esFuerteContra(newArrayList(fuego)))

	}

	@Test
	def void testTipoNoEsFuerte() {

		Assert.assertEquals(false, agua.esFuerteContra(newArrayList(acero)))

	}

	@Test
	def void testValidarOk() {
		bulbasaur.validar
	}

	@Test(expected=ValidacionExcepcion)
	def void testValidarEspecieSinPuntosDeAtaque() {
		pikachu.puntosAtaque = 0
		pikachu.validar
	}

	@Test(expected=ValidacionExcepcion)
	def void testValidarEspecieSinPuntosDeSalud() {
		pikachu.puntosSalud = 0
		pikachu.validar
	}

	@Test(expected=ValidacionExcepcion)
	def void testValidarEspecieSinNombre() {
		bulbasaur.nombre = null
		bulbasaur.validar
	}
	
	@Test(expected=ValidacionExcepcion)
	def void testValidarEspecieConNombreVacio() {
		bulbasaur.nombre = ""
		bulbasaur.validar
	}
	
	@Test(expected=ValidacionExcepcion)
	def void testValidarEspecieSinTipoEnNull() {
		bulbasaur.tipos = null
		bulbasaur.validar
	}
	
	   @Test(expected=ValidacionExcepcion)
	def void testValidarEspecieSinTipoVacio() {
		bulbasaur.tipos = newArrayList()
		bulbasaur.validar
	}

	@Test(expected=ValidacionExcepcion)
	def void testValidarEspecieSinDescripcion() {
		bulbasaur.descripcion = null
		bulbasaur.validar
	}
	
	@Test(expected=ValidacionExcepcion)
	def void testValidarEspecieConDescripcionVacia() {
		bulbasaur.descripcion = null
		bulbasaur.validar
	}

	@Test(expected=ValidacionExcepcion)
	def void testValidarEspecieSinVelocidad() {
		pikachu.velocidad = 0
		pikachu.validar
	}

}
