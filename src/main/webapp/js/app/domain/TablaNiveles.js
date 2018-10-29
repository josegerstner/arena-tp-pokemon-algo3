class TablaNiveles {
	constructor() {
		this.niveles = new Map();
        this.niveles.set(0, 1);
		this.niveles.set(1000, 2);
		this.niveles.set(3000, 3);
		this.niveles.set(6000, 4);
		this.niveles.set(10000, 5);
		this.niveles.set(15000, 6);
		this.niveles.set(21000, 7);
		this.niveles.set(28000, 8);
		this.niveles.set(36000, 9);
		this.niveles.set(45000, 10);
		this.niveles.set(55000, 11);
		this.niveles.set(65000, 12);
		this.niveles.set(75000, 13);
		this.niveles.set(85000, 14);
		this.niveles.set(100000, 15);
		this.niveles.set(120000, 16);
		this.niveles.set(140000, 17);
		this.niveles.set(160000, 18);
		this.niveles.set(185000, 19);
		this.niveles.set(210000, 20);
    }

    obtenerNivelSegunExperiencia(experiencia){
    	var nivel = (new Map([...this.niveles.entries()].filter(([k, v]) => k <= experiencia).reverse()) ).values().next().value ;
		return nivel;
	}
    
}