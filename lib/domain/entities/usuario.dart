class Usuario{
  String id;
  String linkFoto;
  String apellidos;
  String contrasenia;
  String nombres;
  String correo;
  String numeroTelefono;
  String metodoAutenticacion;
  String tipoUsuario;
  String ciudad;
  String nombreAgencia;
  String web;
  bool verificado;
  String fechaUltimoIngreso;
  String fechaPenultimoIngreso;
  bool estadoCuenta;
  int sumatoriaCalificacion;
  int cantidadInmueblesCalificados;
  int calificacion=0;
  Usuario({
    required this.id,
    required this.linkFoto,
    required this.apellidos,
    required this.contrasenia,
    required this.nombres,
    required this.correo,
    required this.numeroTelefono,
    required this.metodoAutenticacion,
    required this.fechaUltimoIngreso,
    required this.fechaPenultimoIngreso,
    required this.tipoUsuario,
    required this.ciudad,
    required this.nombreAgencia,
    required this.web,
    required this.verificado,
    required this.estadoCuenta,
    required this.sumatoriaCalificacion,
    required this.cantidadInmueblesCalificados,
    
  });
  get getId=>this.id;
  get getApellidos=>this.apellidos;
  get getContrasenia=>this.contrasenia;
  get getNombres=>this.nombres;
  get getCorreo=>this.correo;
  get getNumeroTelefono=>this.numeroTelefono;
  get getMetodoAutenticacion=>this.metodoAutenticacion;
  get getFechaUltimoIngreso=>this.fechaUltimoIngreso;
  get getTipoUsuario=>this.tipoUsuario;
  get getNombreAgencia=>this.nombreAgencia;
  get getWeb=>this.web;
  double get getCalificacion{
    if(this.cantidadInmueblesCalificados==0){
      this.cantidadInmueblesCalificados++;
    }
    double calificacion=double.parse((this.sumatoriaCalificacion/this.cantidadInmueblesCalificados).toStringAsPrecision(2));
    return calificacion;
  }
  bool get isEstadoCuenta=>this.estadoCuenta;
  bool get isVerificado=>this.verificado;
  void setId(String id)=>this.id=id;
  void setApellidos(String apellidos)=>this.apellidos=apellidos;
  void setContrasenia(String contrasenia)=>this.contrasenia=contrasenia;
  void setNombres(String nombres)=>this.nombres=nombres;
  void setCorreo(String correo)=>this.correo=correo;
  void setNumeroTelefono(String numeroTelefono)=>this.numeroTelefono=numeroTelefono;
  void setMetodoAutenticacion(String metodoAutenticacion)=>this.metodoAutenticacion=metodoAutenticacion;
  void setTipoUsuario(String tipoUsuario)=>this.tipoUsuario=tipoUsuario;
  void setNombreAgencia(String nombreAgencia)=>this.nombreAgencia;
  void setWeb(String web)=>this.web;
  void setVerificado(bool verificado)=>this.verificado=verificado;
  
  factory Usuario.fromMap(Map<String,dynamic> mapData){
    //print("mapdata ${mapData.toString()}");
    //String s=mapData["apellidos"]??"";
    //print("ssss ${s.toString()}");
    if(mapData.isEmpty){
      return Usuario.vacio();
    }
    return Usuario(id: mapData["id"]??"", 
      linkFoto: mapData["link_foto"]??"",
      apellidos: mapData["apellidos"]??"", 
      contrasenia: "", nombres: mapData["nombres"]??"", correo: mapData["email"]??"", 
      numeroTelefono: mapData["telefono"]??"", metodoAutenticacion: mapData["medio_registro"]??"",
      fechaUltimoIngreso: mapData["fecha_ultimo_ingreso"]??"",
      fechaPenultimoIngreso: mapData["fecha_penultimo_ingreso"]??"",
      tipoUsuario: mapData["tipo_usuario"]??"",
      ciudad: mapData["ciudad"]??"",
      nombreAgencia: mapData["nombre_agencia"]??"",
      web: mapData["web"]??"",
      verificado: mapData["verificado"]??false,
      estadoCuenta: mapData["estado_cuenta"]??true,
      sumatoriaCalificacion: mapData["sumatoria_calificacion"]!=null?mapData["sumatoria_calificacion"]:0,
      cantidadInmueblesCalificados: mapData["cantidad_calificados"]!=null?mapData["cantidad_calificados"]:0,
    );
    
  }
  factory Usuario.vacio(){
    return Usuario(id: "", linkFoto:"",apellidos: "", contrasenia: "", 
     nombres: "", correo: "", numeroTelefono: "", metodoAutenticacion: "",
     fechaUltimoIngreso: "",fechaPenultimoIngreso: "", tipoUsuario: "Común",ciudad: "",
     nombreAgencia: "",web: "",verificado: false,estadoCuenta: false,sumatoriaCalificacion: 0,cantidadInmueblesCalificados: 0);
  }
  factory Usuario.copyWith(Usuario u){
    return Usuario(
      id: u.id, linkFoto:u.linkFoto,apellidos: u.apellidos, contrasenia: u.contrasenia, 
      nombres: u.nombres, correo: u.correo, numeroTelefono: u.numeroTelefono, 
      metodoAutenticacion: u.metodoAutenticacion, fechaUltimoIngreso: u.fechaUltimoIngreso, fechaPenultimoIngreso: u.fechaPenultimoIngreso,
      tipoUsuario: u.tipoUsuario, ciudad: u.ciudad,nombreAgencia: u.nombreAgencia, web: u.web, 
      verificado: u.verificado, estadoCuenta: u.estadoCuenta, 
      sumatoriaCalificacion: u.sumatoriaCalificacion, 
      cantidadInmueblesCalificados: u.cantidadInmueblesCalificados
    );
  }
  void usuarioCopy(Usuario usuario){
     this.id=usuario.id;
     this.apellidos=usuario.apellidos;
     this.contrasenia=usuario.contrasenia;
     this.nombres=usuario.nombres;
     this.correo=usuario.correo;
     this.numeroTelefono=usuario.numeroTelefono;
     this.metodoAutenticacion=usuario.metodoAutenticacion;
     this.fechaUltimoIngreso=usuario.fechaUltimoIngreso;
     this.tipoUsuario=usuario.tipoUsuario;
     this.nombreAgencia=usuario.nombreAgencia;
     this.web=usuario.web;
     this.verificado=usuario.verificado;
     this.estadoCuenta=usuario.estadoCuenta;
     this.sumatoriaCalificacion=usuario.sumatoriaCalificacion;
     this.cantidadInmueblesCalificados=usuario.cantidadInmueblesCalificados;
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "email":this.correo,
      "link_foto":this.linkFoto,
      "apellidos":this.apellidos,
      "nombres":this.nombres,
      "password":this.contrasenia,
      "telefono":this.numeroTelefono,
      "medio_registro":this.metodoAutenticacion,
      "nombre_agencia":this.nombreAgencia,
      "web":this.web,
      "estado_cuenta":this.estadoCuenta
    };
  }
}