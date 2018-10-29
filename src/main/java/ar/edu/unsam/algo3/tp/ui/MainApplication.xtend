package ar.edu.unsam.algo3.tp.ui

import ar.edu.unsam.algo3.tp.viewModel.AdministracionModelo
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class MainApplication extends Application {
	
	new(ActualizacionBootstrap bootstrap) {
		super(bootstrap)
	}
	
	static def void main(String[] args) { 
		new MainApplication( new ActualizacionBootstrap).start()
	}

	override protected Window<?> createMainWindow() {
		return new AdministracionWindow(this, new AdministracionModelo())
	}
	
}
