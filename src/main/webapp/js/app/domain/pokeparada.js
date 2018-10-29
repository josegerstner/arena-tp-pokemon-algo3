class Pokeparada{
    constructor(){
        
    }
    static asPokeparada(jsonPokeparada) {
        return angular.extend(new Pokeparada(), jsonPokeparada)
  }
}