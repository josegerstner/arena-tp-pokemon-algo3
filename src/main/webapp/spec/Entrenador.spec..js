describe('Tests para el entrenador', () => {

    const entrenador = new Entrenador();

    beforeEach( () => {
    })

    it('obtener nivel 1', () => {
        expect(1).toBe( entrenador.getNivel() );
    })

	it('obtener nivel 10', () => {
    	entrenador.experiencia = 45000;
        expect(10).toBe( entrenador.getNivel() );
    })

    it('obtener nivel 20', () => {
    	entrenador.experiencia = 210000;
        expect(20).toBe( entrenador.getNivel() );
    })

    it('obtener nivel 20', () => {
    	entrenador.experiencia = 210001;
        expect(20).toBe( entrenador.getNivel() );
    })
})