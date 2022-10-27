class PublicationPlanPayment{
  String id;
  String planName;
  String planType;
  int cost;
  int modificationsAllowed;
  bool active;
  PublicationPlanPayment({
    required this.id,
    required this.planName,
    required this.planType,
    required this.cost,
    required this.modificationsAllowed,
    required this.active
  });
  factory PublicationPlanPayment.empty(){
    return PublicationPlanPayment(id: "", planName: "", planType:"Publicar", cost: 0, modificationsAllowed: 0, active: false);
  }
  factory PublicationPlanPayment.fromMap(Map<String,dynamic> map){
    return PublicationPlanPayment(
      id: map["id"]??"", 
      planName: map["nombre_plan"]??"", 
      planType: map["tipo_plan"]??"",
      cost: map["costo"]??0, 
      modificationsAllowed: map["modificaciones_permitidas"]??0,
      active: map["activo"]??false
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "nombre_plan":this.planName,
      "tipo_plan":this.planType,
      "costo":this.cost,
      "activo":this.active,
      "modificaciones_permitidas":this.modificationsAllowed
    };
  }
  factory PublicationPlanPayment.copyWith(PublicationPlanPayment p){
    return PublicationPlanPayment(id: p.id, planName: p.planName, planType: p.planType, cost: p.cost,modificationsAllowed: p.modificationsAllowed,active: p.active);
  }
}