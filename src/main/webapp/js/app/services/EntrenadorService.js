class EntrenadorService{
    constructor($http){
        this.$http = $http
    
    }

    findEntrenador(callback){
        this.$http.get('http://localhost:9000/entrenador/logeado').then(callback)

    }
    getUbicacion(callback){
        this.$http.get('http://localhost:9000/entrenador/ubicacion').then(callback)
    }

    mover(direccion, callback){
        switch(direccion) {
            case "arriba":
                this.$http.put('http://localhost:9000/entrenador/moverseArriba').then(callback)
                break;
            case "abajo":
                this.$http.put('http://localhost:9000/entrenador/moverseAbajo').then(callback)
                break;
            case "izquierda":
                this.$http.put('http://localhost:9000/entrenador/moverseIzquierda').then(callback)
                break;
            case "derecha":
                this.$http.put('http://localhost:9000/entrenador/moverseDerecha').then(callback)
                break;
        } 
    }

    findOponentes(callback){
        this.$http.get('http://localhost:9000/entrenador/oponentes').then(callback)
    }
    findPokemonesSalvajes(callback){
        this.$http.get('http://localhost:9000/entrenador/pokemonSalvaje').then(callback)
    }
    findPokeparadas(callback){
        this.$http.get('http://localhost:9000/entrenador/pokeparadas').then(callback)
    }
    replaceAll(str, find, replace) {
       return str.replace(new RegExp(find, 'g'), replace);
   }
   seleccionarPokemon(pokemon,callback){
        this.$http.get('http://localhost:9000/elegirPokemon/' +this.replaceAll(pokemon.nombre, ' ', '_') ).then(callback)
   }
    pelear(oponente, callback){
        this.$http.get('http://localhost:9000/pelearHoy/' +this.replaceAll(oponente.nombre, ' ', '_'), oponente ).then(callback)
    }
    elegirPokemon(poke, callback){
        this.$http.get('http://localhost:9000/entrenador/poke').then(callback)
    }
    atrapar(pokemon,callback){
        this.$http.put('http://localhost:9000/entrenador/atrapar/' +this.replaceAll(pokemon.nombre, ' ', '_'), pokemon ).then(callback)
    }
    curar(pokeparada,callback){
        this.$http.put('http://localhost:9000/entrenador/curar/' +pokeparada.id, pokeparada ).then(callback)
    }
    


}