
class Oponente{
    constructor(nombre, pokemon, nivelpk, apuesta, imgEntrenador, imgPokemon){
        this.nombre = nombre;
        this.pokemon = pokemon;
        this.nivelpk = nivelpk;
        this.apuesta=apuesta;
        this.imagenEntrenador = imgEntrenador;
        this.imagenPokemon = imgPokemon ;
    }
}
class OponenteService{
    constructor(){
        this.oponentes = [
            new Oponente('Ash Ketchum','Pikachu', 'lvl 5','$50','img/entrenadores/ash.jpg','img/pokemones/pikachu.png'),
            new Oponente('Gary Oak','Snorlax', 'lvl 5','$100','img/entrenadores/garyOak.jpg','img/pokemones/snorlax.png'),
            new Oponente('Misty La Colo','Meowth', 'lvl 50','$30','img/entrenadores/misty.png','img/pokemones/meowth.png')
        ]
    }
}
