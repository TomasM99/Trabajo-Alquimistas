//----Alquimista
object alquimista {
	var itemsDeCombate = []
	var itemsDeRecoleccion = []

//----Punto 1
  method tieneCriterio() {
    return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadDeItemsDeCombate() / 2
  }
  
  method cantidadDeItemsDeCombate() {
    return itemsDeCombate.size()
  }
  
  method cantidadDeItemsDeCombateEfectivos() {
    return itemsDeCombate.count({ itemDeCombate =>
      itemDeCombate.esEfectivo()
    })
  }
  
 //----Punto 2
 
  method esBuenExplorador() {
  	return self.cantidadItemsDeRecoleccion() >= 3
  }
 
  method cantidadItemsDeRecoleccion() {
  	return itemsDeRecoleccion.size()
  }
  
//----Punto 3
 
  method capacidadOfensiva() {
  	return itemsDeCombate.sum({capacidadItem => capacidadItem.capacidadOfensiva()})
  }

//----Punto 4

  method esProfesional(){
  	return self.esBuenExplorador() and self.todosSusItemsDeCombateSonEfectivos() and (self.calidadPromedioDeItems() > 50)
  }
    
  method todosSusItemsDeCombateSonEfectivos(){
  	return itemsDeCombate.all({itemDeCombate => itemDeCombate.esEfectivo()})
  }
  
    method calidadPromedioDeItems(){
  	return self.calidadDeItems() / self.cantidadDeItems()
  }
  
  method cantidadDeItems(){
  	return self.cantidadDeItemsDeCombate() + self.cantidadItemsDeRecoleccion()
  }

  method calidadDeItems(){
  	return itemsDeCombate.sum({calidadItem => calidadItem.calidad()}) + itemsDeRecoleccion.sum({calidadItem => calidadItem.calidad()})
  }
  
  //----Para el testeo
  
  method agregarItemDeCombate(unItemDeCombate){
  	itemsDeCombate.add(unItemDeCombate)
  }
  
  method agregarItemDeRecoleccion(unItemDeRecoleccion){
  	itemsDeRecoleccion.add(unItemDeRecoleccion)
  }
}

//----Bomba

object bomba {
	var materiales = []
  	var danio = 100
  
  method esEfectivo() {
    return danio > 100
  }
  
  method capacidadOfensiva() {
  	return danio/2
  }
  
  method calidad(){
  	return materiales.min({material => material.calidad()}).calidad()
  }
  
//----Para el testeo

  method cambiarDanio(nuevoDanio){
  	danio = nuevoDanio
  }
  
    method agregarMaterial(material){
  	materiales.add(material)
  }
}

//---- Pocion

object pocion {
  var materiales = []
  var poderCurativo = 0
  
  method esEfectivo() {
    return poderCurativo > 50 and self.fueCreadaConAlgunMaterialMistico()
  }
  
  method fueCreadaConAlgunMaterialMistico() {
    return materiales.any({ material => material.esMistico()})
  }
  
  method capacidadOfensiva() {
  	return poderCurativo + 10*self.cantidadDeMaterialesMisticos()
  }
  
  method cantidadDeMaterialesMisticos() {
  	return materiales.count({material => material.esMistico()})
  }
  
  method calidad(){
  	if(self.fueCreadaConAlgunMaterialMistico()){
  		return self.calidadPrimerMaterialMistico()
  	} else {
  	return self.calidadPrimerMaterial()
  }
 }
  
  method calidadPrimerMaterialMistico() {
  	return materiales.filter({material => material.esMistico()}).head().calidad()
  }
  
  method calidadPrimerMaterial(){
  	return materiales.head().calidad()
  }

//----Para el testeo

  method cambiarPoderCurativo(nuevoPoder){
  	poderCurativo = nuevoPoder
  }
  
  method agregarMaterial(material){
  	materiales.add(material)
  }
}

//----Debilitador

object debilitador {
  var materiales = []
  var potencia = 0
  
  method esEfectivo() {
    return potencia > 0 and self.fueCreadoPorAlgunMaterialMistico().negate()
  }
  
  method fueCreadoPorAlgunMaterialMistico() {
    return materiales.any({ material => material.esMistico() })
  }
  
 method capacidadOfensiva(){
 	if(self.fueCreadoPorAlgunMaterialMistico()){
 		return 12*self.cantidadDeMateriales()
 	}
 	return 5
 }
 
   method cantidadDeMateriales() {
  	return materiales.size()
  }
  
  method calidad(){
  	return self.calidadDeLosDosMejoresItems() / 2
  }
  
  method calidadDeLosDosMejoresItems(){
  	return materiales.sortedBy({material => material.calidad()}).take(2).sum({material=>material.calidad()})
  }
  
//----Para el testeo

method cambiarPotencia(nuevaPotencia){
	potencia = nuevaPotencia
}

  method agregarMaterial(material){
  	materiales.add(material)
  }

}

//----Items de recoleccion

object itemDeRecoleccion {
	var materiales = []
	
	method calidad(){
		return 30 + materiales.sum({material=>material.calidad()}) / 10
	}

}

//----Materiales misticos y normales

object materialMistico{
	var calidad = 50
	
	method esMistico(){
		return true
	}
	
	method calidad(){
		return calidad
	}
}

object materialNoMistico{
	var calidad = 40
	
	method esMistico(){
		return false
	}
	
	method calidad(){
		return calidad
	}
}

object materialConMejorCalidad{
	var calidad = 4000
	
	method esMistico(){
		return true
	}
	
	method calidad(){
		return calidad
	}
}