package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.IngredienteDecorator
import ar.edu.unsam.algo3.tp.model.IngredienteValorFijoDecorator
import ar.edu.unsam.algo3.tp.model.IngredienteValorPorcentualConEspeciesFuertesDecorator
import ar.edu.unsam.algo3.tp.model.IngredienteValorPorcentualDecorator
import ar.edu.unsam.algo3.tp.model.MaxPocion
import ar.edu.unsam.algo3.tp.model.Pocion
import ar.edu.unsam.algo3.tp.model.Pokemon
import ar.edu.unsam.algo3.tp.model.Tipo
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class ItemTest extends TestHelper {

	Pokemon pokemon

	Especie especie

	Pocion pocion = new Pocion(50,20,"Pocion")
	Pocion superPosion = new Pocion(100,50,"SuperPocion")
	MaxPocion maxPocion = new MaxPocion(150,"MaxPocion")
	
	IngredienteDecorator hierro = new IngredienteValorFijoDecorator(10,5)
	IngredienteDecorator calcio = new IngredienteValorFijoDecorator(15,10)
	
	IngredienteDecorator zinc = new IngredienteValorPorcentualDecorator(15,0.3)
	IngredienteDecorator proteina = new IngredienteValorPorcentualDecorator(20 , 0.45)
	
	IngredienteValorPorcentualConEspeciesFuertesDecorator fertilizante = new IngredienteValorPorcentualConEspeciesFuertesDecorator(40,0.2,0.5)
	IngredienteValorPorcentualConEspeciesFuertesDecorator purificador = new IngredienteValorPorcentualConEspeciesFuertesDecorator(35,0.15,0.4)
	IngredienteValorPorcentualConEspeciesFuertesDecorator combustible = new IngredienteValorPorcentualConEspeciesFuertesDecorator(35,0.2,0.45)
	IngredienteValorPorcentualConEspeciesFuertesDecorator cobre = new IngredienteValorPorcentualConEspeciesFuertesDecorator(35,0.2,0.5)
	
	Tipo hierba = tipoHierba
	Tipo agua = tipoAgua
	Tipo fuego = tipoFuego
	Tipo electrico = tipoElectrico
	
	@Before
	def void init(){
		
		especie = new Especie
		especie.puntosSalud = 100
		
		pokemon = crearPokemon(especie)
		pokemon.puntosDeSalud = 0
		
		initIngredientes()
	}
	
	def initIngredientes() {
		fertilizante.agregarTipoQueCuraMas( hierba )
		purificador.agregarTipoQueCuraMas( agua )
		combustible.agregarTipoQueCuraMas( fuego )
		cobre.agregarTipoQueCuraMas( electrico )
	}
	
	@Test
	def testPosion(){
		pocion.curar(pokemon)
		Assert.assertEquals( 20 , pokemon.puntosDeSalud , 0.0 )
	}
	
	@Test
	def testSuperPosion() {

		superPosion.curar(pokemon)

		Assert.assertEquals(50, pokemon.puntosDeSalud, 0.0)

	}
	
	@Test
	def testPosionPokemonConTodaLaSalud(){
		
		pokemon.puntosDeSalud = pokemon.puntosSaludMaximo
		
		pocion.curar(pokemon)
		
		Assert.assertEquals( pokemon.puntosSaludMaximo , pokemon.puntosDeSalud , 0.0 )
		
	}
	
	@Test
	def testMaxPosionCuraTodaLaSaludOk(){
		maxPocion.curar(pokemon)
		Assert.assertTrue( pokemon.tieneLaSaludAlMaximo )
	}
	
	@Test
	def testMaxPosionCuraTodaDeUnPokemonConTodaLaSaludOk(){
		pokemon.curarTodaLaSalud
		maxPocion.curar(pokemon)
		Assert.assertTrue( pokemon.tieneLaSaludAlMaximo )
	}
	
	
	/*
	 * Test de ingredientes
	 */
	 
	@Test
	def testCustomPosionCon1DecoratorOK(){
		hierro.pocion = pocion
		hierro.curar(pokemon)
		Assert.assertEquals( 25 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testCustomPosionCon2DecoratorOrdenadosOK(){
		hierro.pocion = pocion
		calcio.pocion = hierro
		
		calcio.curar(pokemon)
		
		Assert.assertEquals( 35 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testZincOK(){
		zinc.pocion = pocion
		zinc.curar(pokemon)
		
		Assert.assertEquals( 26 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testProteinaOK(){
		proteina.pocion = pocion
		proteina.curar(pokemon)
		
		Assert.assertEquals( 29 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testFertilizanteConTipoHierbaOK(){
		fertilizante.pocion = pocion
		pokemon.agregarTipo( hierba )
		
		fertilizante.curar(pokemon)
		
		Assert.assertEquals( 30 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testFertilizanteConOtroTipoOK(){
		fertilizante.pocion = pocion
		pokemon.agregarTipo( agua )
		
		fertilizante.curar(pokemon)
		
		Assert.assertEquals( 24 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testPurificadorConTipoAguaOK(){
		purificador.pocion = pocion
		pokemon.agregarTipo( agua )
		
		purificador.curar(pokemon)
		
		Assert.assertEquals( 28 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testPurificadorConOtroTipoOK(){
		purificador.pocion = pocion
		pokemon.agregarTipo( fuego )
		
		purificador.curar(pokemon)
		
		Assert.assertEquals( 23 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testCombustibleConTipoFuegoOK(){
		combustible.pocion = pocion
		pokemon.agregarTipo( fuego )
		
		combustible.curar(pokemon)
		
		Assert.assertEquals( 29 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testCombustibleConOtroTipoOK(){
		combustible.pocion = pocion
		pokemon.agregarTipo( agua )
		
		combustible.curar(pokemon)
		
		Assert.assertEquals( 24 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testCobreConTipoElectricoOK(){
		cobre.pocion = pocion
		pokemon.agregarTipo( electrico )
		
		cobre.curar(pokemon)
		
		Assert.assertEquals( 30 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testCobreConOtroTipoOK(){
		cobre.pocion = pocion
		pokemon.agregarTipo( tipoHielo )
		
		cobre.curar(pokemon)
		
		Assert.assertEquals( 24 , pokemon.puntosDeSalud )
	}
	
	/*
	 * Testea que si tenes 2 ingredientes(decorators) y 2 tipos que aplican una funcionalidad particlar, que se combinen bien.
	 */
	@Test
	def testCobreYCombutibleConFuegoYElectricoOK(){
		cobre.pocion = pocion
		combustible.pocion = cobre
		
		pokemon.agregarTipo( electrico )
		pokemon.agregarTipo( fuego )
		
		combustible.curar(pokemon)

		Assert.assertEquals( 43 , pokemon.puntosDeSalud )
	}
	
	@Test
	def testPrecioHierro(){
		Assert.assertEquals( 10 , hierro.precio)
	}
	 
	@Test
	def testPrecioCalcio(){
		Assert.assertEquals( 15 , calcio.precio)
	}
	
	@Test
	def testPrecioZinc(){
		Assert.assertEquals( 15 , zinc.precio)
	}
	
	@Test
	def testPrecioProteina(){
		Assert.assertEquals( 20 , proteina.precio)
	}
	
	@Test
	def testPrecioFertilizante(){
		Assert.assertEquals( 40 , fertilizante.precio)
	}
	
	@Test
	def testPrecioPurificador(){
		Assert.assertEquals( 35 , purificador.precio)
	}
	
	@Test
	def testPrecioCombustible(){
		Assert.assertEquals( 35 , combustible.precio)
	}
	
	@Test
	def testPrecioCobre(){
		Assert.assertEquals( 35 , cobre.precio)
	}
	
}