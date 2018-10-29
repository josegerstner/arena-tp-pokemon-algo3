
class EntrenadoresController{
    constructor(EntrenadorService){
        this.EntrenadorService = EntrenadorService
        this.entrenador = this.getEntrenador
    }


    getEntrenador(){
        this.EntrenadorService.findEntrenador((response)=>{
            this.entrenador = _.map(response.data, Entrenador.asEntrenador)
        })
    }
}