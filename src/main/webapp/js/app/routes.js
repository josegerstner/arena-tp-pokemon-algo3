const routes = ($stateProvider, $urlRouterProvider) => {
    
      $urlRouterProvider.otherwise("/mundo")
    
      $stateProvider
    
        .state('mundo', {
          url: "/mundo",
          templateUrl: "partials/mundo.html",
          controller: "MundoController as mundoCtrl"
        })
        .state('entrenador', {
          url: "/entrenador",
          templateUrl: "partials/entrenadores.html",
          controller: "EntrenadoresController as entrenadoresCtrl"
        })
    }
    