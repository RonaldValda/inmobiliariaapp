
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';

class PropertyReported{
  String id;
  User userRequesting,userResponding;
  PropertyTotal propertyTotal;
  bool soldMultiplePlaces,fakeContentImage,fakeContentText,inappropriateContent,other;
  String requestObservations,requestDate,responseDate,responseObservations;
  String response;
  bool deliveredResponse;
  PropertyReported({
    required this.id,required this.userRequesting,required this.userResponding,
    required this.propertyTotal, required this.soldMultiplePlaces,required this.fakeContentImage,
    required this.fakeContentText,required this.inappropriateContent,required this.other,
    required this.requestObservations,required this.requestDate,
    required this.responseDate,required this.response,required this.responseObservations,
    required this.deliveredResponse
  });
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "id_solicitante":this.userRequesting.id,
      "id_respondedor":this.userResponding.id,
      "id_inmueble":this.propertyTotal.property.id,
      "vendido_multiples_lugares":this.soldMultiplePlaces,
      "contenido_falso_imagen":this.fakeContentImage,
      "contenido_falso_texto":this.fakeContentText,
      "contenido_inapropiado":this.inappropriateContent,
      "otro":this.other,
      "observaciones_solicitud":this.requestObservations,
      "fecha_solicitud":this.requestDate,
      "fecha_respuesta":this.responseDate,
      "respuesta":this.response,
      "observaciones_respuesta":this.responseObservations,
      "respuesta_entregada":this.deliveredResponse
    };
  }
  factory PropertyReported.empty(){
    return PropertyReported(
      id: "", 
      userRequesting: User.empty(), userResponding: User.empty(), 
      propertyTotal: PropertyTotal.empty(), 
      soldMultiplePlaces: false, fakeContentImage: false, 
      fakeContentText: false, inappropriateContent: false, other: false, 
      requestObservations: "", requestDate: "", responseDate: "", 
      response: "", responseObservations: "", deliveredResponse: false
    );
  }
  factory PropertyReported.fromMap(Map<String,dynamic> map,String sessionType){
    return PropertyReported(
      id: map["id"], userRequesting: map["usuario_solicitante"]!=null?User.fromMap(map["usuario_solicitante"]):User.empty(), 
      userResponding: map["usuario_respondedor"]!=null?User.fromMap(map["usuario_respondedor"]):User.empty(), 
      propertyTotal: map["inmueble"]!=null?PropertyTotal.fromMap(sessionType, map):PropertyTotal.empty(),
      soldMultiplePlaces: map["vendido_multiples_lugares"]??false,
      fakeContentImage: map["contenido_falso_imagen"]??false, 
      fakeContentText: map["contenido_falso_texto"]??false, 
      inappropriateContent: map["contenido_inapropiado"]??false, 
      other: map["otro"]??false, 
      requestObservations: map["observaciones_solicitud"]??"", 
      requestDate: map["fecha_solicitud"]??"", responseDate: map["fecha_respuesta"]??"", 
      response: map["respuesta"]??"", responseObservations: map["observaciones_respuesta"]??"", 
      deliveredResponse: map["respuesta_entregada"]??false
    );
  }
}
class PropertyComplaint{
  String id;
  User userResponding;
  PropertyTotal propertyTotal;
  bool noResponse;
  bool rejectedWithoutJustification;
  bool other;
  String requestObservations;
  String requestDate;
  String responseDate;
  String response;
  String responseObservations;
  bool deliveredResponse;
  PropertyComplaint({
    required this.id, required this.userResponding,
    required this.propertyTotal, required this.noResponse,
    required this.rejectedWithoutJustification, required this.other,
    required this.requestObservations, required this.requestDate,
    required this.responseDate, required this.response,
    required this.responseObservations, required this.deliveredResponse
  });
  factory PropertyComplaint.empty(){
    return PropertyComplaint(
      id: "", userResponding: User.empty(), 
      propertyTotal: PropertyTotal.empty(),
      noResponse: false, rejectedWithoutJustification: false, other: false, 
      requestObservations: "", requestDate: "", responseDate:"", 
      response: "", responseObservations: "", deliveredResponse: false
    );
  }
  factory PropertyComplaint.fromMap(Map<String,dynamic> map){
    return PropertyComplaint(
      id: map["id"]??"", 
      userResponding: map["usuario_respondedor"]!=null?User.fromMap(map["usuario_respondedor"]):User.empty(),
      propertyTotal: map["inmueble"]!=null?PropertyTotal.fromMap("Vender", map["inmueble"]):PropertyTotal.empty(), 
      noResponse: map["sin_respuesta"]??false, 
      rejectedWithoutJustification: map["rechazado_sin_justificacion"]??false, 
      other: map["otro"]??false, 
      requestObservations: map["observaciones_solicitud"]??"",
      requestDate: map["fecha_solicitud"]??"", 
      responseDate: map["fecha_respuesta"]??"", 
      response: map["respuesta"]??"", 
      responseObservations: map["observaciones_respuesta"]??"", 
      deliveredResponse: map["respuesta_entregada"]??false
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "usuario_respondedor":this.userResponding.id,
      "id_inmueble":this.propertyTotal.property.id,
      "sin_respuesta":this.noResponse,
      "rechazado_sin_justificacion":this.rejectedWithoutJustification,
      "otro":this.other,
      "observaciones_solicitud":this.requestObservations,
      "fecha_solicitud":this.requestDate,
      "fecha_respuesta":this.responseDate,
      "respuesta":this.response,
      "observaciones_respuesta":this.responseObservations,
      "respuesta_entregada":this.deliveredResponse
    };
  }
}