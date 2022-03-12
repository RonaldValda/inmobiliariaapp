class MembresiaPlanesPago{
  String id;
  String nombrePlan;
  String unidadMedidaTiempo;
  int tiempo;
  int costo;
  bool activo;
  MembresiaPlanesPago({
    required this.id,
    required this.nombrePlan,
    required this.unidadMedidaTiempo,
    required this.tiempo,
    required this.costo,
    required this.activo
  });
  factory MembresiaPlanesPago.vacio(){
    return MembresiaPlanesPago(
      id: "", nombrePlan: "", 
      unidadMedidaTiempo: "Meses", 
      tiempo: 1, costo: 0, activo: false
    );
  }
  factory MembresiaPlanesPago.fromMap(Map<String,dynamic> map){
    return MembresiaPlanesPago(
      id: map["id"]??"", 
      nombrePlan: map["nombre_plan"]??"", 
      unidadMedidaTiempo: map["unidad_medida_tiempo"]??"Meses", 
      tiempo: map["tiempo"]??1, 
      costo: map["costo"]??0, 
      activo: map["activo"]??false
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "nombre_plan":this.nombrePlan,
      "unidad_medida_tiempo":this.unidadMedidaTiempo,
      "tiempo":this.tiempo,
      "costo":this.costo,
      "activo":this.activo
    };
  }
  factory MembresiaPlanesPago.copyWith(MembresiaPlanesPago memb){
    return MembresiaPlanesPago(
      id: memb.id, 
      nombrePlan: memb.nombrePlan, 
      unidadMedidaTiempo: memb.unidadMedidaTiempo, 
      tiempo: memb.tiempo, costo: memb.costo, activo: memb.activo
    );
  }
}