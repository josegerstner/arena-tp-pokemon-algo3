var myApp = angular.module("myApp",  ['ui.router']);
myApp.config(routes)

myApp.service('OponenteService', OponenteService)
myApp.service('EntrenadorService', EntrenadorService)
const pokemonSalvajeService = myApp.service('pokemonSalvajeService', PokemonSalvajeService)

myApp.controller("MundoController", MundoController )
myApp.controller("EntrenadoresController", EntrenadoresController)
myApp.controller('TodosLosPokemonesSalvajeControllers', PokemonSalvajeController)