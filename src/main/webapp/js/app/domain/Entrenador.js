class Entrenador {
    constructor() {
        this.tablaNiveles = new TablaNiveles();
        this.niveles = new Map();
        this.experiencia = 1;
        this.esExperto = false;
        this.nombre = "";
        this.ubicacion = [];
    }

    getNivel() {
		return this.tablaNiveles.obtenerNivelSegunExperiencia(this.experiencia);
    }
    
    static asEntrenador(jsonEntrenador) {
		  return angular.extend(new Entrenador(), jsonEntrenador)
    }
    
}