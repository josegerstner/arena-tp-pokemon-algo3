class Combate {
    constructor() {
        this.tablaNiveles = new TablaNiveles();
        this.experiencia = 1;
    }

    getNivel() {
		return this.tablaNiveles.obtenerNivelSegunExperiencia(this.experiencia);
	}
}