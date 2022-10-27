class Publicity{
  String id;
  String city;
  int minPrice;
  int maxPrice;
  String propertyType;
  String contractType;
  String publicityType;
  String publicityDescription;
  String publicityImageLink;
  String publicityWebLink;
  String creationDate;
  String expirationDate;
  Publicity({
    required this.id,required this.city,required this.minPrice,required this.maxPrice,
    required this.propertyType,required this.contractType,
    required this.publicityType,required this.publicityDescription,
    required this.publicityImageLink,required this.publicityWebLink,
    required this.creationDate,required this.expirationDate
  });
  factory Publicity.empty(){
    return Publicity(
      id: "", city: "", minPrice: 0, maxPrice: -1000, 
      propertyType: "Todos", contractType: "Todos", publicityType: "Cuadrado", 
      publicityDescription: "", publicityImageLink: "", 
      publicityWebLink: "", creationDate: "", expirationDate: ""
    );
  }
  factory Publicity.fromMap(Map<String,dynamic> map){
    return Publicity(
      id: map["id"]??"", 
      city: map["ciudad"]??"",
      minPrice: map["precio_min"]??0, 
      maxPrice: map["precio_max"]??-1, 
      propertyType: map["tipo_inmueble"]??"", 
      contractType: map["tipo_contrato"]??"", 
      publicityType: map["tipo_publicidad"]??"", 
      publicityDescription: map["descripcion_publicidad"]??"", 
      publicityImageLink: map["link_imagen_publicidad"]??"", 
      publicityWebLink: map["link_web_publicidad"]??"", 
      creationDate: map["fecha_creacion"]??"", 
      expirationDate: map["fecha_vencimiento"]??""
    );
  }
  factory Publicity.copyWith(Publicity p){
    return Publicity(
      id: p.id, city:p.city,minPrice: p.minPrice, maxPrice: p.maxPrice, 
      propertyType: p.propertyType, contractType: p.contractType, 
      publicityType: p.publicityType, publicityDescription: p.publicityDescription, 
      publicityImageLink: p.publicityImageLink, publicityWebLink: p.publicityWebLink, 
      creationDate: p.creationDate, expirationDate: p.expirationDate
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "ciudad":this.city,
      "precio_min":this.minPrice,
      "precio_max":this.maxPrice,
      "tipo_inmueble":this.propertyType,
      "tipo_contrato":this.contractType,
      "tipo_publicidad":this.publicityType,
      "descripcion_publicidad":this.publicityDescription,
      "link_imagen_publicidad":this.publicityImageLink,
      "link_web_publicidad":this.publicityWebLink
    };
  }
}