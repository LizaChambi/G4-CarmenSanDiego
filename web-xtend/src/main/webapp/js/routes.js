carmenApp.config(function ($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise("/");

  $stateProvider

    .state('mapamundi', {
      url: "/",
      templateUrl: "partials/admMapamundi.html",
      controller: "MapamundiController as mapaCtrl"
    })
	
	.state('expediente', {
      url: "/villanos",
      templateUrl: "partials/admExpediente.html",
      controller: "ExpedienteController as expCtrl"
    })

});