
class User{
  String id;
  String photoLink;
  String surnames;
  String names;
  String password;
  String email;
  String phoneNumber;
  String authMethod;
  String userType;
  String city;
  String agencyName;
  String web;
  bool verified;
  String lastEntryDate;
  String penultimateEntryDate;
  bool accountStatus;
  int qualificationSummation;
  int quantityQualifiedsProperties;
  int qualification=0;
  User({
    required this.id,
    required this.photoLink,
    required this.surnames,
    required this.names,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.authMethod,
    required this.lastEntryDate,
    required this.penultimateEntryDate,
    required this.userType,
    required this.city,
    required this.agencyName,
    required this.web,
    required this.verified,
    required this.accountStatus,
    required this.qualificationSummation,
    required this.quantityQualifiedsProperties,
    
  });

  double get getQualification{
    if(this.quantityQualifiedsProperties==0){
      this.quantityQualifiedsProperties++;
    }
    double qualification=double.parse((this.qualificationSummation/this.quantityQualifiedsProperties).toStringAsPrecision(2));
    return qualification;
  }
  
  String get namesSurnames => "$names $surnames";
  
  factory User.fromMap(Map<String,dynamic> mapData){
    if(mapData.isEmpty){
      return User.empty();
    }
    return User(id: mapData["id"]??"", 
      photoLink: mapData["link_foto"]??"",
      surnames: mapData["apellidos"]??"", 
      password: "", names: mapData["nombres"]??"", email: mapData["email"]??"", 
      phoneNumber: mapData["telefono"]??"", authMethod: mapData["medio_registro"]??"",
      lastEntryDate: mapData["fecha_ultimo_ingreso"]??"",
      penultimateEntryDate: mapData["fecha_penultimo_ingreso"]??"",
      userType: mapData["tipo_usuario"]??"",
      city: mapData["ciudad"]??"",
      agencyName: mapData["nombre_agencia"]??"",
      web: mapData["web"]??"",
      verified: mapData["verificado"]??false,
      accountStatus: mapData["estado_cuenta"]??true,
      qualificationSummation: mapData["sumatoria_calificacion"]!=null?mapData["sumatoria_calificacion"]:0,
      quantityQualifiedsProperties: mapData["cantidad_calificados"]!=null?mapData["cantidad_calificados"]:0,
    );
    
  }
  factory User.empty(){
    return User(id: "", photoLink:"",surnames: "", password: "", 
     names: "", email: "", phoneNumber: "", authMethod: "",
     lastEntryDate: "",penultimateEntryDate: "", userType: "Común",city: "",
     agencyName: "",web: "",verified: false,accountStatus: false,qualificationSummation: 0,quantityQualifiedsProperties: 0);
  }
  factory User.copyWith(User u){
    return User(
      id: u.id, photoLink:u.photoLink,surnames: u.surnames, password: u.password, 
      names: u.names, email: u.email, phoneNumber: u.phoneNumber, 
      authMethod: u.authMethod, lastEntryDate: u.lastEntryDate, penultimateEntryDate: u.penultimateEntryDate,
      userType: u.userType, city: u.city,agencyName: u.agencyName, web: u.web, 
      verified: u.verified, accountStatus: u.accountStatus, 
      qualificationSummation: u.qualificationSummation, 
      quantityQualifiedsProperties: u.quantityQualifiedsProperties
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "email":this.email,
      "link_foto":this.photoLink,
      "apellidos":this.surnames,
      "nombres":this.names,
      "password":this.password,
      "telefono":this.phoneNumber,
      "medio_registro":this.authMethod,
      "nombre_agencia":this.agencyName,
      "web":this.web,
      "estado_cuenta":this.accountStatus
    };
  }
}