class PokemonSalvajeController {

  constructor(pokemonSalvajeService, $timeout) {
    this.pokemonesSalvaje = pokemonSalvajeService.pokemonesSalvaje;
    this.pokemonSalvajeService = pokemonSalvajeService
    this.$timeout = $timeout
    this.errors = []
    this.pokemon = null
    this.entrenadorLogeado = this.getEntrenadorLogeado()
    this.pokemonesEntrenador = this.getPokemonesEntrenadorLogeado();
    this.depositoEntrenador = this.getDepositoEntrenadorLogeado();
    this.items = this.getItems();
  }

  // TRAER POKEMON
  getPokemon(idPokemon) {
    this.pokemonSalvajeService.find(idPokemon, (response) => {
      this.pokemon = this.transformarAPokemon(response.data);
    }, (message) => {
      notificarError(this, message)
    })
  }

  getEntrenadorLogeado(){
    this.pokemonSalvajeService.getEntrenadorLogeado( (response) => {
      this.entrenadorLogeado = this.transformarAEntrenador(response.data);
    }, (message) => {
      console.log(message);
      //notificarError(this, message)
    })
  }

  getPokemonesEntrenadorLogeado(){
    this.pokemonSalvajeService.getPokemonesEntrenadorLogeado( (response) => {
      this.pokemonesEntrenador = _.map(response.data , this.transformarAPokemon);
    }, (message) => {
      console.log(message);
      //notificarError(this, message)
    })
  }

  getDepositoEntrenadorLogeado(){
    this.pokemonSalvajeService.getDepositoEntrenadorLogeado( (response) => {
      this.depositoEntrenador = _.map(response.data , this.transformarAPokemon);
    }, (message) => {
      console.log(message);
      //notificarError(this, message)
    })
  }

  getItems() {
    this.pokemonSalvajeService.getItems((response) => {
      this.items = _.map(response.data,this.transformarAItem);
    }, (message) => {
      notificarError(this, message)
    })
  }

  transformarAItem(jsonItem) {
    return Item.asItem(jsonItem)
  }

  transformarAPokemon(jsonPokemon) {
    return Pokemon.asPokemon(jsonPokemon)
  }

  transformarAEntrenador(jsonEntrenador) {
    return Entrenador.asEntrenador(jsonEntrenador)
  }

  getImgPath() {
    if ( this.pokemon != null ){
      return "img/pokemones/" + this.pokemon.nombre.toLowerCase() + ".png";
    }
  }

  pocaVida(){
    if (this.pokemon.getPorcentajeVida() < 25){
      return "list-group-item-danger";
    }
  }

  getTipo(){
    console.log("pasa");
    return this.pokemon.especie.tipos[0].nombre;
  }

}