class AgentPlanPayment{
  String id;
  String planName;
  int monthlyAmount;
  int plan;
  bool active;
  AgentPlanPayment({
    required this.id,
    required this.planName,
    required this.plan,
    required this.monthlyAmount,
    required this.active
  });
  factory AgentPlanPayment.empty(){
    return AgentPlanPayment(
      id: "", plan:0,planName: "", monthlyAmount: 0, active: false
    );
  }
  factory AgentPlanPayment.fromMap(Map<String,dynamic> map){
    return AgentPlanPayment(
      id: map["id"], planName: map["nombre_plan"],plan: map["plan"], monthlyAmount: map["monto_mensual"], active: map["activo"]
    );
  }
}