class MembershipPlanPayment{
  String id;
  String planName;
  String unitMeasureTime;
  int time;
  int cost;
  bool active;
  MembershipPlanPayment({
    required this.id,
    required this.planName,
    required this.unitMeasureTime,
    required this.time,
    required this.cost,
    required this.active
  });
  factory MembershipPlanPayment.empty(){
    return MembershipPlanPayment(
      id: "", planName: "", 
      unitMeasureTime: "Meses", 
      time: 1, cost: 0, active: false
    );
  }
  factory MembershipPlanPayment.fromMap(Map<String,dynamic> map){
    return MembershipPlanPayment(
      id: map["id"]??"", 
      planName: map["nombre_plan"]??"", 
      unitMeasureTime: map["unidad_medida_tiempo"]??"Meses", 
      time: map["tiempo"]??1, 
      cost: map["costo"]??0, 
      active: map["activo"]??false
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "nombre_plan":this.planName,
      "unidad_medida_tiempo":this.unitMeasureTime,
      "tiempo":this.time,
      "costo":this.cost,
      "activo":this.active
    };
  }
  factory MembershipPlanPayment.copyWith(MembershipPlanPayment memb){
    return MembershipPlanPayment(
      id: memb.id, 
      planName: memb.planName, 
      unitMeasureTime: memb.unitMeasureTime, 
      time: memb.time, cost: memb.cost, active: memb.active
    );
  }
}