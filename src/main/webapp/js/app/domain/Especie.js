class Especie{
    constructor(){
        this.tipo = [];
        this.puntosAtaque = 0;
    }
    
    agregarTipo(tipo){
        this.tipo.push(tipo);
    }

    esFuerteContra(pokemon){
        return this.tipo.some( tipo => {
            return tipo.esFuerteContraAlguno(pokemon.getTipos()) 
        })
    }

    esResistente(pokemon){
        return this.tipo.some( tipo => {
            return tipo.esResistenteContraAlguno(pokemon.getTipos()) 
        })
    }
};