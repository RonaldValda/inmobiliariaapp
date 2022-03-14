class PlanesPagoAgente{
  String id;
  String nombrePlan;
  int montoMensual;
  int plan;
  bool activo;
  PlanesPagoAgente({
    required this.id,
    required this.nombrePlan,
    required this.plan,
    required this.montoMensual,
    required this.activo
  });
  factory PlanesPagoAgente.vacio(){
    return PlanesPagoAgente(
      id: "", plan:0,nombrePlan: "", montoMensual: 0, activo: false
    );
  }
  factory PlanesPagoAgente.fromMap(Map<String,dynamic> map){
    return PlanesPagoAgente(
      id: map["id"], nombrePlan: map["nombre_plan"],plan: map["plan"], montoMensual: map["monto_mensual"], activo: map["activo"]
    );
  }
}