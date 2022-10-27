

import 'package:inmobiliariaapp/domain/entities/membership_plan_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';

class MembershipPayment{
  String id;
  String requestDate;
  String paymentMedium;
  int paymentAmount;
  MembershipPlanPayment membershipPlanPayment;
  String transactionNumber;
  BankAccount bankAccount;
  String depositorName;
  dynamic depositImageLink;
  String authorization;
  String observations;
  bool deliveredResponse;
  String requestDateSuperUser;
  String responseDateSuperUser;
  String authorizationSuperUser;
  bool deliveredResponseSuperUser;
  String observationsSuperUser;
  String initialDate;
  String finalDate;
  bool active;
  String cancelDate;
  String cancelReason;
  User user;
  User administrator;
  User superUser;
  MembershipPayment({
    required this.id,
    required this.requestDate,
    required this.paymentMedium,required this.paymentAmount,
    required this.membershipPlanPayment,required this.transactionNumber,
    required this.bankAccount,required this.depositorName,
    required this.depositImageLink,required this.authorization,
    required this.observations,required this.deliveredResponse,
    required this.requestDateSuperUser,required this.responseDateSuperUser,
    required this.authorizationSuperUser, required this.deliveredResponseSuperUser,
    required this.observationsSuperUser,
    required this.initialDate,required this.finalDate, required this.active,
    required this.cancelDate,required this.cancelReason,
    required this.user,required this.administrator,required this.superUser
  });
  factory MembershipPayment.empty(){
    return MembershipPayment(
      id:"",
      requestDate: "",
      paymentMedium: "", paymentAmount: 0, 
      membershipPlanPayment: MembershipPlanPayment.empty(), transactionNumber: "",
      bankAccount: BankAccount.empty(),depositorName: "",
      depositImageLink: "",authorization: "",
      observations: "",deliveredResponse: false,
      requestDateSuperUser: "",responseDateSuperUser: "",
      authorizationSuperUser: "",observationsSuperUser: "",
      deliveredResponseSuperUser: false,
      initialDate: "",finalDate: "",active: false,
      cancelDate: "",cancelReason: "",
      user: User.empty(),administrator: User.empty(),
      superUser: User.empty()
    );
  }

  factory MembershipPayment.copyWith(MembershipPayment membershipPayment){
    return MembershipPayment(
      id: membershipPayment.id, requestDate: membershipPayment.requestDate, paymentMedium: membershipPayment.paymentMedium, 
      paymentAmount: membershipPayment.paymentAmount, membershipPlanPayment: membershipPayment.membershipPlanPayment, 
      transactionNumber: membershipPayment.transactionNumber, bankAccount: membershipPayment.bankAccount, 
      depositorName: membershipPayment.depositorName, depositImageLink: membershipPayment.depositImageLink, 
      authorization: membershipPayment.authorization, observations: membershipPayment.observations, 
      deliveredResponse: membershipPayment.deliveredResponse, requestDateSuperUser: membershipPayment.requestDateSuperUser, 
      responseDateSuperUser: membershipPayment.responseDateSuperUser, authorizationSuperUser: membershipPayment.authorizationSuperUser, 
      deliveredResponseSuperUser: membershipPayment.deliveredResponseSuperUser, observationsSuperUser: membershipPayment.observationsSuperUser, 
      initialDate: membershipPayment.initialDate, finalDate: membershipPayment.finalDate, active: membershipPayment.active, 
      cancelDate: membershipPayment.cancelDate, cancelReason: membershipPayment.cancelReason, user: membershipPayment.user, 
      administrator: membershipPayment.administrator, superUser: membershipPayment.superUser
    );
  }

  factory MembershipPayment.fromMap(Map<String,dynamic> map){
    return MembershipPayment(
      id: map["id"],
      requestDate: map["fecha_solicitud"],
      paymentMedium: map["medio_pago"],paymentAmount: map["monto_pago"],
      membershipPlanPayment: map["membresia_planes_pago"]!=null?MembershipPlanPayment.fromMap(map["membresia_planes_pago"]):MembershipPlanPayment.empty(),transactionNumber: map["numero_transaccion"],
      bankAccount: BankAccount.fromMap(map["cuenta_banco"]),depositorName: map["nombre_depositante"],
      depositImageLink: map["link_imagen_deposito"],authorization: map["autorizacion"],
      observations: map["observaciones"],deliveredResponse: map["respuesta_entregada"],
      requestDateSuperUser: map["fecha_solicitud_super_usuario"]??"",
      responseDateSuperUser: map["fecha_respuesta_super_usuario"]??"",
      authorizationSuperUser: map["autorizacion_super_usuario"]??"",
      observationsSuperUser: map["observaciones_super_usuario"]??"",
      deliveredResponseSuperUser: map["respuesta_entregada_super_usuario"]??false,
      initialDate: map["fecha_inicio"]!=null?map["fecha_inicio"]:"",
      finalDate: map["fecha_final"]!=null?map["fecha_final"]:"",
      active: map["activo"]??false,cancelDate: map["fecha_cancelacion"]!=null?map["fecha_cancelacion"]:"",
      cancelReason: map["motivo_cancelacion"]!=null?map["motivo_cancelacion"]:"",
      user: User.fromMap(map["usuario"]),
      administrator: map["administrador"]!=null?User.fromMap(map["administrador"]):User.empty(),
      superUser: map["super_usuario"]!=null?User.fromMap(map["super_usuario"]):User.empty(),
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "medio_pago":this.paymentMedium,
      "monto_pago":this.paymentAmount,
      "membresia_planes_pago":this.membershipPlanPayment.id,
      "numero_transaccion":this.transactionNumber,
      "cuenta_banco":this.bankAccount.id,
      "nombre_depositante":this.depositorName,
      "link_imagen_deposito":this.depositImageLink,
      "observaciones":this.observations,
      "usuario":this.user.id,
      "observaciones_super_usuario":this.observationsSuperUser,
      "autorizacion_super_usuario":this.authorizationSuperUser
    };
  }
}