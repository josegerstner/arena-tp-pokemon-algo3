package ar.edu.unsam.algo3.tp.model

import java.util.HashMap
import java.util.Map
import java.io.Serializable

class TablaNiveles implements Serializable{
	
	var Map<Integer, Integer> niveles = new HashMap

	new() {

		niveles.put(0, 1)
		niveles.put(1000, 2)
		niveles.put(3000, 3)
		niveles.put(6000, 4)
		niveles.put(10000, 5)
		niveles.put(15000, 6)
		niveles.put(21000, 7)
		niveles.put(28000, 8)
		niveles.put(36000, 9)
		niveles.put(45000, 10)
		niveles.put(55000, 11)
		niveles.put(65000, 12)
		niveles.put(75000, 13)
		niveles.put(85000, 14)
		niveles.put(100000, 15)
		niveles.put(120000, 16)
		niveles.put(140000, 17)
		niveles.put(160000, 18)
		niveles.put(185000, 19)
		niveles.put(210000, 20)

	}
	
	def obtenerNivelSegunExperiencia(Integer experiencia){
		
		niveles.get( niveles.keySet.filter[key | key <= experiencia].sort.last )
		
	}
	
	def nivelMaximmo(){
		niveles.get(niveles.keySet().sort.last)
	}
}
