describe('Tests de Tipo:', () => {
        const fuego = new Tipo("fuego");
        const hierba = new Tipo("hierba");
        const bicho = new Tipo("bicho");
    
        beforeEach( () => {
        })
    
        it('obtener tipos contra los que es resistente', () => {
            fuego.agregarEsResistente(hierba);
            expect(true).toBe( fuego.esResistenteContra(hierba) );
        })
    
    
        it('obtener tipos contra los que es fuerte', () => {
            fuego.agregarEsFuerte(bicho);
            expect(true).toBe( fuego.esFuerteContra(bicho) );
        })
    
    })