package ar.edu.unsam.algo3.tp.model.json

import ar.edu.unsam.algo3.tp.model.Especie
import ar.edu.unsam.algo3.tp.model.RepositorioEspecie
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import java.util.List

class JsonParserEspecie extends JsonParserRepo{

	new() {
	}

	def List<Especie> parsearEspecies(String especiesJson) {
		var JsonArray especiesJsonArray = Json.parse(especiesJson).asArray();
		val especies = generarEspecies(especiesJsonArray)
		setearEvoluciones(especiesJsonArray, especies)

		especies

	}

	protected def List<Especie> generarEspecies(JsonArray especiesJsonArray) {
		especiesJsonArray.
		map [ especieJson |
			val especieObject = especieJson.asObject

			return new Especie() => [
				numero = especieObject.get("numero").asInt
				nombre = especieObject.get("nombre").asString
				puntosAtaque = especieObject.get("puntosAtaqueBase").asInt
				puntosSalud = especieObject.get("puntosSaludBase").asInt
				descripcion = especieObject.get("descripcion").asString
				tipos = newArrayList(getTipos(especieObject))
				velocidad = especieObject.get("velocidad").asInt
			]
		].
		toList
	}

	protected def void setearEvoluciones(JsonArray especiesJsonArray, List<Especie> especies) {
		especiesJsonArray.forEach [ especieJson |
			
			if (especieJson.asObject.get("evolucion") != null) {
				
				var especie = especies.findFirst [ especieABuscar |
					especieABuscar.numero == especieJson.asObject.get("numero").asInt
				]
				
				var especieEvolucion = especies.findFirst [ especieABuscar |
					especieABuscar.numero == especieJson.asObject.get("evolucion").asInt
				]
				
				especie.especieEvolucion = especieEvolucion
			}
			
		]
	}

	def getTipos(JsonObject especieObject) {
		especieObject.get("tipos").
		asArray.
		map[tipoStr | RepositorioEspecie.instance.getTipoByNombre(tipoStr.asString())].
		filter[tipo|tipo != null].
		toList
	}

}
