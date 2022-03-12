class CuentaBanco{
  String id;
  String fechaHabilitacion;
  String fechaCierre;
  bool activo;
  String numeroCuenta;
  String titular;
  String nombreBanco;
  String linkImagenLogo;
  CuentaBanco({
    required this.id,
    required this.fechaHabilitacion,
    required this.fechaCierre,
    required this.activo,
    required this.numeroCuenta,
    required this.titular,
    required this.nombreBanco,
    required this.linkImagenLogo
  });
  void setFechaInicio(String fechaHabilitacion)=>this.fechaHabilitacion=fechaHabilitacion;
  void setFechaFin(String fechaCierre)=>this.fechaCierre=fechaCierre;
  void setActivo(bool activo)=>this.activo=activo;
  void setNumeroCuenta(String numeroCuenta)=>this.numeroCuenta=numeroCuenta;
  void setTitular(String titular)=>this.titular=titular;
  void setNombreBanco(String nombreBanco)=>this.nombreBanco=nombreBanco;
  void setLinkImagenLogo(String linkImagenLogo)=>this.linkImagenLogo=linkImagenLogo;
  factory CuentaBanco.vacio(){
    return CuentaBanco(
      id: "", 
      fechaHabilitacion: "", 
      fechaCierre: "", 
      activo: false, 
      numeroCuenta: "", 
      titular: "", 
      nombreBanco: "", 
      linkImagenLogo: ""
    );
  }
  factory CuentaBanco.fromMap(Map<String,dynamic> mapData){
    return CuentaBanco(
      id: mapData["id"]??"", 
      fechaHabilitacion: mapData["fecha_habilitacion"]??"", 
      fechaCierre: mapData["fecha_cierre"]??"", 
      activo: mapData["activo"]??false,
      numeroCuenta: mapData["numero_cuenta"]??"", 
      titular: mapData["titular"]??"", 
      nombreBanco: mapData["nombre_banco"]??"",
      linkImagenLogo: mapData["link_logo_banco"]??""
    );
  }
  void cuentaBancoCopy(CuentaBanco cuentaBanco) {
      this.id=cuentaBanco.id; 
      this.fechaHabilitacion=cuentaBanco.fechaHabilitacion; 
      this.fechaCierre=cuentaBanco.fechaCierre; 
      this.activo=cuentaBanco.activo; 
      this.numeroCuenta=cuentaBanco.numeroCuenta;
      this.titular=cuentaBanco.titular; 
      this.nombreBanco=cuentaBanco.nombreBanco; 
      this.linkImagenLogo=cuentaBanco.linkImagenLogo;
  }
  factory CuentaBanco.copyWith(CuentaBanco cb){
    return CuentaBanco(
      id: cb.id, fechaHabilitacion: cb.fechaHabilitacion, 
      fechaCierre: cb.fechaCierre, activo: cb.activo, 
      numeroCuenta: cb.numeroCuenta, titular: cb.titular, 
      nombreBanco: cb.nombreBanco, linkImagenLogo: cb.linkImagenLogo
    );  
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "fecha_habilitacion":this.fechaHabilitacion,
      "fecha_cierre":this.fechaCierre,
      "activo":this.activo,
      "numero_cuenta":this.numeroCuenta,
      "titular":this.titular,
      "nombre_banco":this.nombreBanco,
      "link_imagen_logo":this.linkImagenLogo
    };
  }
}
class Banco{
  String id;
  String nombreBanco;
  String linkLogoBanco;
  String app;
  String web;
  String preAprobacion;
  Banco({
    required this.id,
    required this.nombreBanco,
    required this.linkLogoBanco,
    required this.app,
    required this.web,
    required this.preAprobacion
  });
  factory Banco.vacio(){
    return Banco(
      id: "", nombreBanco: "", linkLogoBanco: "", 
      app: "", web: "", preAprobacion: ""
    );
  }
  factory Banco.copyWith(Banco b){
    return Banco(
      id: b.id, nombreBanco: b.nombreBanco, linkLogoBanco: b.linkLogoBanco, 
      app: b.app, web: b.web, preAprobacion: b.preAprobacion
    );
  }
  factory Banco.fromMap(Map<String,dynamic> data){
    return Banco(
      id: data["id"]??"", 
      nombreBanco: data["nombre_banco"], linkLogoBanco: data["link_logo_banco"]??"", app: data["app"]??"", 
      web: data["web"], preAprobacion: data["pre_aprobacion"]??""
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "nombre_banco":this.nombreBanco,
      "link_logo_banco":this.linkLogoBanco,
      "app":this.app,
      "web":this.web,
      "pre_aprobacion":this.preAprobacion
    };
  }
}