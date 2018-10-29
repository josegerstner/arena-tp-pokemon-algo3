package ar.edu.unsam.algo3.tp.model.json

import ar.edu.unsam.algo3.tp.model.Pokeparada
import ar.edu.unsam.algo3.tp.model.RepositorioPokeparada
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors class JsonParserPokeparada extends JsonParserRepo {
	
	new() {
	}
	
	def List<Pokeparada> parsearPokeparadas(String pokeparadasJson){
		var JsonArray array = Json.parse(pokeparadasJson).asArray();
		
		array.
		map[ pokeparadaJson | 
			val pokeparadaObject = pokeparadaJson.asObject	
			
			return new Pokeparada() => [
				ubicacion = new Point( pokeparadaObject.get("x").asDouble, pokeparadaObject.get("y").asDouble )
				nombre = pokeparadaObject.get("nombre").asString
				items = getItemsDisponibles(pokeparadaObject ) 
			]
		].
		toList
	}
	
	def getItemsDisponibles(JsonObject pokeparadaObject){
		pokeparadaObject.get("itemsDisponibles").
		asArray.
		map[ itemStr | RepositorioPokeparada.instance.getItemByNombre(itemStr.asString())].
		filter[ item | item != null ].
		toList
	}
	
}
