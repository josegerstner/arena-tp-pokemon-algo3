class PokemonSalvaje{
    constructor(nombre, nivel, imagen){
        this.nombre = nombre;
        this.nivel=nivel;
        this.imagen = imagen ;
    }
}
class PokemonSalvajeService{
    constructor($http){
        this.$http = $http
        this.pokemonesSalvaje = [
            new PokemonSalvaje('Squirtle', '5','img/pokemones/squirtle.png'),
            new PokemonSalvaje('Charizard', '14','img/pokemones/charizard.png'),
            new PokemonSalvaje('Bulbasaur', '25','img/pokemones/bulbasaur.png'),
            new PokemonSalvaje('psyduck', '25','img/pokemones/psyduck.png')
        ]
    }

    find(namePokemon,callback, errorHandler) {
        this.$http.get('http://localhost:9000/entrenador/pokemon/'+namePokemon).then(callback, errorHandler)
    }

    getEntrenadorLogeado(callback, errorHandler) {
        this.$http.get('http://localhost:9000/entrenador/logeado').then(callback, errorHandler)
    }

    getPokemonesEntrenadorLogeado(callback, errorHandler) {
        this.$http.get('http://localhost:9000/entrenador/pokemones').then(callback, errorHandler)
    }

    getDepositoEntrenadorLogeado(callback, errorHandler) {
        this.$http.get('http://localhost:9000/entrenador/deposito').then(callback, errorHandler)
    }

    getItems(callback, errorHandler) {
        this.$http.get('http://localhost:9000/entrenador/inventario').then(callback, errorHandler)
    }

}
