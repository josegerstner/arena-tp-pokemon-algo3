describe('Tests para especie', () => {
    var poke1;
    var poke2;
    var poke3;
    var bulvasaur;
    var charmander;
    var squirtel;
    var fuego;
    var planta;
    var agua;
    
    beforeEach( () => {
        bulvasaur = new Especie();
        charmander = new Especie();
        squirtel = new Especie();
        fuego = new Tipo("Fuego");
        planta = new Tipo("Planta");
        agua = new Tipo("Agua");
        bulvasaur.agregarTipo(planta);
        charmander.agregarTipo(fuego);
        squirtel.agregarTipo(agua);
        fuego.agregarEsFuerte(planta);
        fuego.agregarEsResistente(planta);
        agua.agregarEsResistente(fuego);
        agua.agregarEsFuerte(fuego);
        planta.agregarEsFuerte(agua);
        planta.agregarEsResistente(agua);
    
        poke1 =  new Pokemon(charmander);
        poke2= new Pokemon(bulvasaur);
        poke3 = new Pokemon(squirtel);   
         
        });
    
        it('Charmander es fuerte contra vulvasaur',function() {
           expect(true).toBe( poke1.esFuerteContra(poke2) );
        });
 
        it('Squirtel es resistente contra Charmander', function() {
            expect(true).toBe( poke3.esResistente(poke1) );
        });
    })