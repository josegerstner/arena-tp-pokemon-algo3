class Tipo {
	constructor(nombre) {
        this.nombre = nombre;
        this.esResistente=[];
        this.esFuerte=[];
	}

	esResistenteContra(tipo){
		return this.esResistente.includes(tipo); 
	};

	esFuerteContra(tipo){
		return this.esFuerte.includes(tipo); 
	};

	agregarEsResistente(tipo) {
		this.esResistente.push(tipo);
	}

	agregarEsFuerte(tipo) {
		this.esFuerte.push(tipo);
	}

	esFuerteContraAlguno(tipos) {
       	return tipos.some(tipo => {return this.esFuerteContra(tipo)})
	}
	
	esResistenteContraAlguno(tipos) {
		return tipos.some(tipo => {return this.esResistenteContra(tipo)})
 	}
}