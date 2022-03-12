class Publicidad{
  String id;
  String ciudad;
  int precioMin;
  int precioMax;
  String tipoInmueble;
  String tipoContrato;
  String tipoPublicidad;
  String descripcionPublicidad;
  String linkImagenPublicidad;
  String linkWebPublicidad;
  String fechaCreacion;
  String fechaVencimiento;
  Publicidad({
    required this.id,required this.ciudad,required this.precioMin,required this.precioMax,
    required this.tipoInmueble,required this.tipoContrato,
    required this.tipoPublicidad,required this.descripcionPublicidad,
    required this.linkImagenPublicidad,required this.linkWebPublicidad,
    required this.fechaCreacion,required this.fechaVencimiento
  });
  factory Publicidad.vacio(){
    return Publicidad(
      id: "", ciudad: "", precioMin: 0, precioMax: -1000, 
      tipoInmueble: "Todos", tipoContrato: "Todos", tipoPublicidad: "Cuadrado", 
      descripcionPublicidad: "", linkImagenPublicidad: "", 
      linkWebPublicidad: "", fechaCreacion: "", fechaVencimiento: ""
    );
  }
  factory Publicidad.fromMap(Map<String,dynamic> map){
    return Publicidad(
      id: map["id"]??"", 
      ciudad: map["ciudad"]??"",
      precioMin: map["precio_min"]??0, 
      precioMax: map["precio_max"]??-1, 
      tipoInmueble: map["tipo_inmueble"]??"", 
      tipoContrato: map["tipo_contrato"]??"", 
      tipoPublicidad: map["tipo_publicidad"]??"", 
      descripcionPublicidad: map["descripcion_publicidad"]??"", 
      linkImagenPublicidad: map["link_imagen_publicidad"]??"", 
      linkWebPublicidad: map["link_web_publicidad"]??"", 
      fechaCreacion: map["fecha_creacion"]??"", 
      fechaVencimiento: map["fecha_vencimiento"]??""
    );
  }
  factory Publicidad.copyWith(Publicidad p){
    return Publicidad(
      id: p.id, ciudad:p.ciudad,precioMin: p.precioMin, precioMax: p.precioMax, 
      tipoInmueble: p.tipoInmueble, tipoContrato: p.tipoContrato, 
      tipoPublicidad: p.tipoPublicidad, descripcionPublicidad: p.descripcionPublicidad, 
      linkImagenPublicidad: p.linkImagenPublicidad, linkWebPublicidad: p.linkWebPublicidad, 
      fechaCreacion: p.fechaCreacion, fechaVencimiento: p.fechaVencimiento
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "ciudad":this.ciudad,
      "precio_min":this.precioMin,
      "precio_max":this.precioMax,
      "tipo_inmueble":this.tipoInmueble,
      "tipo_contrato":this.tipoContrato,
      "tipo_publicidad":this.tipoPublicidad,
      "descripcion_publicidad":this.descripcionPublicidad,
      "link_imagen_publicidad":this.linkImagenPublicidad,
      "link_web_publicidad":this.linkWebPublicidad
    };
  }
}