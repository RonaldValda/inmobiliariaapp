class BankAccount{
  String id;
  String enableDate;
  String closingDate;
  bool active;
  String accountNumber;
  String owner;
  String bankName;
  String logoImageLink;
  BankAccount({
    required this.id,
    required this.enableDate,
    required this.closingDate,
    required this.active,
    required this.accountNumber,
    required this.owner,
    required this.bankName,
    required this.logoImageLink
  });
  void setEnableDate(String enableDate)=>this.enableDate=enableDate;
  void setClosingDate(String closingDate)=>this.closingDate=closingDate;
  void setActive(bool active)=>this.active=active;
  void setAccountNumber(String accountNumber)=>this.accountNumber=accountNumber;
  void setOwner(String owner)=>this.owner=owner;
  void setBankName(String bankName)=>this.bankName=bankName;
  void setLogoImageLink(String logoImageLink)=>this.logoImageLink=logoImageLink;
  factory BankAccount.empty(){
    return BankAccount(
      id: "", 
      enableDate: "", 
      closingDate: "", 
      active: false, 
      accountNumber: "", 
      owner: "", 
      bankName: "", 
      logoImageLink: ""
    );
  }
  factory BankAccount.fromMap(Map<String,dynamic> mapData){
    return BankAccount(
      id: mapData["id"]??"", 
      enableDate: mapData["fecha_habilitacion"]??"", 
      closingDate: mapData["fecha_cierre"]??"", 
      active: mapData["activo"]??false,
      accountNumber: mapData["numero_cuenta"]??"", 
      owner: mapData["titular"]??"", 
      bankName: mapData["nombre_banco"]??"",
      logoImageLink: mapData["link_logo_banco"]??""
    );
  }
  void cuentaBancoCopy(BankAccount accountBank) {
      this.id=accountBank.id; 
      this.enableDate=accountBank.enableDate; 
      this.closingDate=accountBank.closingDate; 
      this.active=accountBank.active; 
      this.accountNumber=accountBank.accountNumber;
      this.owner=accountBank.owner; 
      this.bankName=accountBank.bankName; 
      this.logoImageLink=accountBank.logoImageLink;
  }
  factory BankAccount.copyWith(BankAccount accountBank){
    return BankAccount(
      id: accountBank.id, enableDate: accountBank.enableDate, 
      closingDate: accountBank.closingDate, active: accountBank.active, 
      accountNumber: accountBank.accountNumber, owner: accountBank.owner, 
      bankName: accountBank.bankName, logoImageLink: accountBank.logoImageLink
    );  
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "fecha_habilitacion":this.enableDate,
      "fecha_cierre":this.closingDate,
      "activo":this.active,
      "numero_cuenta":this.accountNumber,
      "titular":this.owner,
      "nombre_banco":this.bankName,
      "link_logo_banco":this.logoImageLink
    };
  }
}
class Bank{
  String id;
  String bankName;
  String logoImageLink;
  String app;
  String web;
  String preApproval;
  Bank({
    required this.id,
    required this.bankName,
    required this.logoImageLink,
    required this.app,
    required this.web,
    required this.preApproval
  });
  factory Bank.empty(){
    return Bank(
      id: "", bankName: "", logoImageLink: "", 
      app: "", web: "", preApproval: ""
    );
  }
  factory Bank.copyWith(Bank b){
    return Bank(
      id: b.id, bankName: b.bankName, logoImageLink: b.logoImageLink, 
      app: b.app, web: b.web, preApproval: b.preApproval
    );
  }
  factory Bank.fromMap(Map<String,dynamic> data){
    return Bank(
      id: data["id"]??"", 
      bankName: data["nombre_banco"], logoImageLink: data["link_logo_banco"]??"", app: data["app"]??"", 
      web: data["web"], preApproval: data["pre_aprobacion"]??""
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "nombre_banco":this.bankName,
      "link_logo_banco":this.logoImageLink,
      "app":this.app,
      "web":this.web,
      "pre_aprobacion":this.preApproval
    };
  }
}