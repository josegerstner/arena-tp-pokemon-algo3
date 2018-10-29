package ar.edu.unsam.algo2.tp.test

import ar.edu.unsam.algo3.tp.model.TablaNiveles
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TablaNivelesTest {
	
	TablaNiveles tablaNiveles
	
	@Before
	def void init()	{

		tablaNiveles = new TablaNiveles()
				
	}
	
	@Test
	def testNivel1() {
		
		Assert.assertEquals( 1 , tablaNiveles.obtenerNivelSegunExperiencia(100) , 0.1 )
		
	}
	
	@Test
	def testNivel2() {
		
		Assert.assertEquals( 2 , tablaNiveles.obtenerNivelSegunExperiencia(1001) , 0.1 )
		
	}
	
	@Test
	def testNivel18() {
		
		Assert.assertEquals( 18 , tablaNiveles.obtenerNivelSegunExperiencia(160000) , 0.1 )
		
	}
	
	@Test
	def testNivelMaximo(){
		Assert.assertEquals(20 , tablaNiveles.nivelMaximmo())
	}
	
}