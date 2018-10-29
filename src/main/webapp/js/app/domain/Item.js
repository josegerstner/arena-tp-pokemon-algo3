class Item {

	constructor() {
		this.nombre = "";
	}

	static asItem(jsonItem) {
		return angular.extend(new Item(), jsonItem)
	}

	getImgPath(){
		return "img/item/" + this.nombre.toLowerCase() + ".png"
	}

}