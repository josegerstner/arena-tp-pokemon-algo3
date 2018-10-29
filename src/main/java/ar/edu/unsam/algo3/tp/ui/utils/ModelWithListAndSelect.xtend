package ar.edu.unsam.algo3.tp.ui.utils

import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
abstract class ModelWithListAndSelect<T> {
	
	T itemToAdd
	T itemToDelete
	protected List<T> select = newArrayList
	
	def addToList(){
		list.add(itemToAdd)
	}
	
	def removeFromList(){
		list.remove(itemToDelete)	
	}
	
	def public Set<T> getList()
	
}
