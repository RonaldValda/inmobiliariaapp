class PlanesPagoPublicacion{
  String id;
  String nombrePlan;
  int costo;
  bool activo;
  PlanesPagoPublicacion({
    required this.id,
    required this.nombrePlan,
    required this.costo,
    required this.activo
  });
  factory PlanesPagoPublicacion.vacio(){
    return PlanesPagoPublicacion(id: "", nombrePlan: "", costo: 0, activo: false);
  }
  factory PlanesPagoPublicacion.fromMap(Map<String,dynamic> map){
    return PlanesPagoPublicacion(
      id: map["id"]??"", 
      nombrePlan: map["nombre_plan"]??"", 
      costo: map["costo"]??0, 
      activo: map["activo"]??false
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "nombre_plan":this.nombrePlan,
      "costo":this.costo,
      "activo":this.activo
    };
  }
  factory PlanesPagoPublicacion.copyWith(PlanesPagoPublicacion p){
    return PlanesPagoPublicacion(id: p.id, nombrePlan: p.nombrePlan, costo: p.costo, activo: p.activo);
  }
}