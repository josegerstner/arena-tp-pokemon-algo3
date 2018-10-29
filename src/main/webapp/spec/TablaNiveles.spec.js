describe('Tests para la tabla de niveles del entrenador', () => {

    const tablaNiveles = new TablaNiveles();

    beforeEach( () => {
    })

    it('obtener nivel 1', () => {
        expect(1).toBe( tablaNiveles.obtenerNivelSegunExperiencia(0));
    })

})