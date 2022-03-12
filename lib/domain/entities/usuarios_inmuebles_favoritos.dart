import 'package:cloud_firestore/cloud_firestore.dart';

class UsuariosInmueblesFavoritos{
  String id="";
  String idUsuario="";
  String idInmueble="";
  bool favorito=false;
  bool visto=false;
  bool dobleVisto=false;
  bool contactado=false;
  UsuariosInmueblesFavoritos({
    required this.id,
    required this.idUsuario,
    required this.idInmueble,
    required this.favorito,
    required this.visto,
    required this.dobleVisto,
    required this.contactado
  });
  get getId=>this.id;
  get getIdUsuario=>this.idUsuario;
  get getIdInmueble=>this.idInmueble;
  get isFavorito=>this.favorito;
  get isVisto=>this.visto;
  get isDobleVisto=>this.dobleVisto;
  get isContactado=>this.contactado;
  void setId(String id)=>this.id;
  void setIdUsuario(String idUsuario)=>this.idUsuario=idUsuario;
  void setIdInmueble(String idInmueble)=>this.idInmueble=idInmueble;
  void setFavorito(bool favorito)=>this.favorito=favorito;
  void setVisto(bool visto)=>this.visto=visto;
  void setDobleVisto(bool dobleVisto)=>this.dobleVisto=dobleVisto;
  void setContactado(bool contactado)=>this.contactado=contactado;
  
  factory UsuariosInmueblesFavoritos.fromFireStore(DocumentSnapshot snapshot){
    return UsuariosInmueblesFavoritos(
      id: snapshot.id,
      idUsuario: snapshot["id_usuario"],
      idInmueble: snapshot["id_inmueble"],
      favorito: snapshot["favorito"],
      visto: snapshot["visto"],
      dobleVisto: snapshot["doble_visto"],
      contactado: snapshot["contactado"]
    );
  }
  factory UsuariosInmueblesFavoritos.fromMap(Map<String,dynamic> snapshot){
    return UsuariosInmueblesFavoritos(
      id: snapshot["id"],
      idUsuario: "",
      idInmueble: "",
      favorito: snapshot["favorito"],
      visto: snapshot["visto"],
      dobleVisto: snapshot["doble_visto"],
      contactado: snapshot["contactado"]
    );
  }
  factory UsuariosInmueblesFavoritos.vacio(){
    return UsuariosInmueblesFavoritos(
      id: "", idUsuario: "",
      idInmueble: "",
      favorito: false,
      visto: false,
      dobleVisto: false,
      contactado: false);
  }
  factory UsuariosInmueblesFavoritos.copyWith(UsuariosInmueblesFavoritos uif){
    return UsuariosInmueblesFavoritos(
      id: uif.id, idUsuario: uif.idUsuario, idInmueble: uif.idInmueble, 
      favorito: uif.favorito, visto: uif.visto, dobleVisto: uif.dobleVisto, contactado: uif.contactado
    );
  }
}
class UsuarioInmuebleBase{
  String id;
  String tipo;
  int precioMin, precioMax;
  int dormitoriosMin, dormitoriosMax;
  int baniosMin, baniosMax;
  int garajeMin, garajeMax;
  int superficieTerrenoMin, superficieTerrenoMax;
  int superficieConstruccionMin,superficieConstruccionMax;
  int antiguedadConstruccionMin,antiguedadConstruccionMax;
  int cantidadInmuebles,amoblado,lavanderia,cuartoLavado,churrasquero, azotea;
  int condominioPrivado,cancha,piscina,sauna,jacuzzi,estudio;
  int jardin,portonElectrico,aireAcondicionado,calefaccion;
  int ascensor,deposito,sotano,balcon,tienda,amuralladoTerreno;
  String fechaInicio;
  String fechaUltimoGuardado;
  String fechaCache;
  UsuarioInmuebleBase({
    required this.id,
    required this.tipo,
    required this.precioMin,required this.precioMax,
    required this.dormitoriosMin, required this.dormitoriosMax,
    required this.baniosMin,required this.baniosMax,
    required this.garajeMin,required this.garajeMax,
    required this.superficieTerrenoMin,required this.superficieTerrenoMax,
    required this.superficieConstruccionMin,required this.superficieConstruccionMax,
    required this.antiguedadConstruccionMin,required this.antiguedadConstruccionMax,
    required this.cantidadInmuebles,
    required this.amoblado,required this.lavanderia,required this.cuartoLavado,
    required this.churrasquero,required this.azotea,required this.condominioPrivado,
    required this.cancha,required this.piscina,required this.sauna,required this.jacuzzi,
    required this.estudio,required this.jardin,required this.portonElectrico,
    required this.aireAcondicionado,required this.calefaccion,
    required this.ascensor,required this.deposito,required this.sotano,
    required this.balcon,required this.tienda,required this.amuralladoTerreno,
    required this.fechaInicio,
    required this.fechaUltimoGuardado,
    required this.fechaCache
  });
  List<InmuebleBaseParametros> getParametros(String tipoContrato){
    List<InmuebleBaseParametros> parametros=[];
    parametros.add(InmuebleBaseParametros(min: precioMin, max: precioMax,parametro: "precio"));
    parametros.add(InmuebleBaseParametros(min: dormitoriosMin, max: dormitoriosMax,parametro: "dormitorios"));
    parametros.add(InmuebleBaseParametros(min: baniosMin, max: baniosMax,parametro: "banios"));
    parametros.add(InmuebleBaseParametros(min: garajeMin, max: garajeMax,parametro: "garaje"));
    parametros.add(InmuebleBaseParametros(min: superficieConstruccionMin, max: superficieConstruccionMax,parametro: "superficie_construccion"));
    parametros.add(InmuebleBaseParametros(min: superficieTerrenoMin, max: superficieTerrenoMax,parametro: "superficie_terreno"));
    parametros.add(InmuebleBaseParametros(min: antiguedadConstruccionMin, max: antiguedadConstruccionMax,parametro: "tiempo_construccion"));
    parametros.sort((b,a)=>a.getPromedio(tipoContrato).compareTo(b.getPromedio(tipoContrato)),);
    return parametros;
  }
  factory UsuarioInmuebleBase.fromMap(Map<String,dynamic> map){
    return UsuarioInmuebleBase(id: map["id"], 
      tipo: map["tipo"],
      dormitoriosMin: map["dormitorios_min"], dormitoriosMax: map["dormitorios_max"], 
      baniosMin: map["banios_min"],baniosMax: map["banios_max"], 
      garajeMin: map["garaje_min"],garajeMax: map["garaje_max"],
      superficieTerrenoMin:map["superficie_terreno_min"],superficieTerrenoMax:map["superficie_terreno_max"],
      superficieConstruccionMin: map["superficie_construccion_min"],superficieConstruccionMax: map["superficie_construccion_max"],
      antiguedadConstruccionMin: map["antiguedad_construccion_min"],antiguedadConstruccionMax: map["antiguedad_construccion_max"],
      precioMin: map["precio_min"],precioMax: map["precio_max"],
      cantidadInmuebles: map["cantidad_inmuebles"],
      amoblado: map["amoblado"],
      lavanderia: map["lavanderia"],
      cuartoLavado: map["cuarto_lavado"],
      churrasquero: map["churrasquero"],
      azotea: map["azotea"],
      condominioPrivado: map["condominio_privado"],
      cancha: map["cancha"],
      piscina: map["piscina"],
      sauna: map["sauna"],
      jacuzzi: map["jacuzzi"],
      estudio: map["estudio"],
      jardin: map["jardin"],
      portonElectrico: map["porton_electrico"],
      aireAcondicionado: map["aire_acondicionado"],
      calefaccion: map["calefaccion"],
      ascensor: map["ascensor"],
      deposito: map["deposito"],
      sotano: map["sotano"],
      balcon: map["balcon"],
      tienda: map["tienda"],
      amuralladoTerreno: map["amurallado_terreno"],
      fechaInicio: map["fecha_inicio"],
      fechaUltimoGuardado: map["fecha_ultimo_guardado"],
      fechaCache: map["fecha_cache"]
    );
  }
  factory UsuarioInmuebleBase.vacio(){
    return UsuarioInmuebleBase(id: "", 
    tipo: "",
    dormitoriosMin: 0,dormitoriosMax:0, baniosMin: 0,baniosMax:0, 
    garajeMin: 0,garajeMax: 0, superficieTerrenoMin: 0,superficieTerrenoMax: 0,
    superficieConstruccionMin: 0,superficieConstruccionMax: 0,
    antiguedadConstruccionMin: 0,antiguedadConstruccionMax: 0,
    precioMin: 0, precioMax: 0,
    cantidadInmuebles: 0,amoblado: 0,lavanderia: 0,
    cuartoLavado: 0,churrasquero: 0,azotea: 0,
    condominioPrivado: 0,cancha: 0,piscina: 0,
    sauna: 0,jacuzzi: 0,estudio: 0,jardin: 0,
    portonElectrico: 0,aireAcondicionado: 0,calefaccion: 0,
    ascensor: 0,deposito: 0,sotano: 0,balcon: 0,
    tienda: 0,amuralladoTerreno: 0,
    fechaInicio: "",
    fechaCache: "",
    fechaUltimoGuardado: ""
    );
  }
  Map<String,dynamic> usuarioInmuebleBaseToMap(){
    return {
      "tipo":this.tipo,
      "dormitorios_min":this.dormitoriosMin,"dormitorios_max":this.dormitoriosMax,
      "banios_min":this.baniosMin,"banios_max":this.baniosMax,
      "garaje_min":this.garajeMin,"garaje_max":this.garajeMax,
      "superficie_terreno_min":this.superficieTerrenoMin,"superficie_terreno_max":this.superficieTerrenoMax,
      "superficie_construccion_min":this.superficieConstruccionMin,"superficie_construccion_max":this.superficieConstruccionMax,
      "antiguedad_construccion_min":this.antiguedadConstruccionMin,"antiguedad_construccion_max":this.antiguedadConstruccionMax,
      "precio_min":this.precioMin,"precio_max":this.precioMax,
      "cantidad_inmuebles":this.cantidadInmuebles,"amoblado":this.amoblado,
      "lavanderia":this.lavanderia,"cuarto_lavado":this.cuartoLavado,
      "condominio_privado":this.condominioPrivado,"cancha":this.cancha,
      "piscina":this.piscina,"sauna":this.sauna,"jacuzzi":this.jacuzzi,
      "estudio":this.estudio,"jardin":this.jardin,"porton_electrico":this.portonElectrico,
      "aire_acondicionado":this.aireAcondicionado,"calefaccion":this.calefaccion,
      "ascensor":this.ascensor,"deposito":this.deposito,"sotano":this.sotano,
      "balcon":this.balcon,"tienda":this.tienda,"amurallado_terreno":this.amuralladoTerreno
    };
  }
  Map<String,dynamic> toMapFiltro(){
    return <String,dynamic>{
      "dormitorios_min":this.dormitoriosMin,"dormitorios_max":this.dormitoriosMax,
      "banios_min":this.baniosMin,"banios_max":this.baniosMax,
      "garaje_min":this.garajeMin,"garaje_max":this.garajeMax,
      "superficie_terreno_min":this.superficieTerrenoMin,"superficie_terreno_max":this.superficieTerrenoMax,
      "superficie_construccion_min":this.superficieConstruccionMin,"superficie_construccion_max":this.superficieConstruccionMax,
      "antiguedad_construccion_min":this.antiguedadConstruccionMin,"antiguedad_construccion_max":this.antiguedadConstruccionMax,
      "precio_min":this.precioMin,"precio_max":this.precioMax,"fecha_inicio":this.fechaInicio
    };
  }
  String get toText{
    return this.id+" dormitorios: "+
     this.dormitoriosMin.toString()+" baños: "+
      this.baniosMin.toString()+" garaje: "+this.garajeMin.toString();
  }
  Map<String,dynamic> getMapRegistroInmuebleBase(String idUsuario,UsuarioInmuebleBase visto,UsuarioInmuebleBase dobleVisto,UsuarioInmuebleBase favorito){
    Map<String,dynamic> mapDatos={
      "id_usuario":idUsuario,
      "dormitorios_min_v":visto.dormitoriosMin,
      "dormitorios_max_v":visto.dormitoriosMax,
      "banios_min_v":visto.baniosMin,
      "banios_max_v":visto.baniosMax,
      "garaje_min_v":visto.garajeMin,
      "garaje_max_v":visto.garajeMax,
      "superficie_terreno_min_v":visto.superficieTerrenoMin,
      "superficie_terreno_max_v":visto.superficieTerrenoMax,
      "superficie_construccion_min_v":visto.superficieConstruccionMin,
      "superficie_construccion_max_v":visto.superficieConstruccionMax,
      "antiguedad_construccion_min_v":visto.antiguedadConstruccionMin,
      "antiguedad_construccion_max_v":visto.antiguedadConstruccionMin,
      "precio_min_v":visto.precioMin,
      "precio_max_v":visto.precioMax,
      "cantidad_inmuebles_v":visto.cantidadInmuebles,
      "amoblado_v":visto.amoblado,
      "lavanderia_v":visto.lavanderia,
      "cuarto_lavado_v":visto.cuartoLavado,
      "churrasquero_v":visto.churrasquero,
      "azotea_v":visto.azotea,
      "condominio_privado_v":visto.condominioPrivado,
      "cancha_v":visto.cancha,
      "piscina_v":visto.piscina,
      "sauna_v":visto.sauna,
      "jacuzzi_v":visto.jacuzzi,
      "estudio_v":visto.estudio,
      "jardin_v":visto.jardin,
      "porton_electrico_v":visto.portonElectrico,
      "aire_acondicionado_v":visto.aireAcondicionado,
      "calefaccion_v":visto.calefaccion,
      "ascensor_v":visto.ascensor,
      "deposito_v":visto.deposito,
      "sotano_v":visto.sotano,
      "balcon_v":visto.balcon,
      "tienda_v":visto.tienda,
      "amurallado_terreno_v"
      "dormitorios_min_dv":dobleVisto.dormitoriosMin,
      "dormitorios_max_dv":dobleVisto.dormitoriosMax,
      "banios_min_dv":dobleVisto.baniosMin,
      "banios_max_dv":dobleVisto.baniosMax,
      "garaje_min_dv":dobleVisto.garajeMin,
      "garaje_max_dv":dobleVisto.garajeMax,
      "superficie_terreno_min_dv":dobleVisto.superficieTerrenoMin,
      "superficie_terreno_max_dv":dobleVisto.superficieTerrenoMax,
      "superficie_construccion_min_dv":dobleVisto.superficieConstruccionMin,
      "superficie_construccion_max_dv":dobleVisto.superficieConstruccionMax,
      "antiguedad_construccion_min_dv":dobleVisto.antiguedadConstruccionMin,
      "antiguedad_construccion_max_dv":dobleVisto.antiguedadConstruccionMax,
      "precio_min_dv":dobleVisto.precioMin,
      "precio_max_dv":dobleVisto.precioMax,
      "cantidad_inmuebles_dv":dobleVisto.cantidadInmuebles,
      "amoblado_dv":dobleVisto.amoblado,
      "lavanderia_dv":dobleVisto.lavanderia,
      "cuarto_lavado_dv":dobleVisto.cuartoLavado,
      "churrasquero_dv":dobleVisto.churrasquero,
      "azotea_dv":dobleVisto.azotea,
      "condominio_privado_dv":dobleVisto.condominioPrivado,
      "cancha_dv":dobleVisto.cancha,
      "piscina_dv":dobleVisto.piscina,
      "sauna_dv":dobleVisto.sauna,
      "jacuzzi_dv":dobleVisto.jacuzzi,
      "estudio_dv":dobleVisto.estudio,
      "jardin_dv":dobleVisto.jardin,
      "porton_electrico_dv":dobleVisto.portonElectrico,
      "aire_acondicionado_dv":dobleVisto.aireAcondicionado,
      "calefaccion_dv":dobleVisto.calefaccion,
      "ascensor_dv":dobleVisto.ascensor,
      "deposito_dv":dobleVisto.deposito,
      "sotano_dv":dobleVisto.sotano,
      "balcon_dv":dobleVisto.balcon,
      "tienda_dv":dobleVisto.tienda,
      "amurallado_terreno_dv":dobleVisto.amuralladoTerreno,
      "dormitorios_min_f":favorito.dormitoriosMin,
      "dormitorios_max_f":favorito.dormitoriosMax,
      "banios_min_f":favorito.baniosMin,
      "banios_max_f":favorito.baniosMax,
      "garaje_min_f":favorito.garajeMin,
      "garaje_max_f":favorito.garajeMax,
      "superficie_terreno_min_f":favorito.superficieTerrenoMin,
      "superficie_terreno_max_f":favorito.superficieTerrenoMax,
      "superficie_construccion_min_f":favorito.superficieConstruccionMin,
      "superficie_construccion_max_f":favorito.superficieConstruccionMax,
      "antiguedad_construccion_min_f":favorito.antiguedadConstruccionMin,
      "antiguedad_construccion_max_f":favorito.antiguedadConstruccionMax,
      "precio_min_f":favorito.precioMin,
      "precio_max_f":favorito.precioMax,
      "cantidad_inmuebles_f":favorito.cantidadInmuebles,
      "amoblado_f":favorito.amoblado,
      "lavanderia_f":favorito.lavanderia,
      "cuarto_lavado_f":favorito.cuartoLavado,
      "churrasquero_f":favorito.churrasquero,
      "azotea_f":favorito.azotea,
      "condominio_privado_f":favorito.condominioPrivado,
      "cancha_f":favorito.cancha,
      "piscina_f":favorito.piscina,
      "sauna_f":favorito.sauna,
      "jacuzzi_f":favorito.jacuzzi,
      "estudio_f":favorito.estudio,
      "jardin_f":favorito.jardin,
      "porton_electrico_f":favorito.portonElectrico,
      "aire_acondicionado_f":favorito.aireAcondicionado,
      "calefaccion_f":favorito.calefaccion,
      "ascensor_f":favorito.ascensor,
      "deposito_f":favorito.deposito,
      "sotano_f":favorito.sotano,
      "balcon_f":favorito.balcon,
      "tienda_f":favorito.tienda,
      "amurallado_terreno_f":favorito.amuralladoTerreno,
    };
    return mapDatos;
  }
}
class InmuebleBaseParametros{
  int min;
  int max;
  String parametro;
  InmuebleBaseParametros({
    required this.min,required this.max,required this.parametro
  });
  double getPromedio(String tipoContrato){
    double promedio=0.0;
    switch (parametro) {
      case "precio":
        if(tipoContrato=="Alquiler"){
          promedio=(max-min)/1000;
        }else if(tipoContrato=="Anticrético"){
          promedio=(max-min)/10000;
        }else{
          promedio=(max-min)/100000;
        }
        break;
      case "superficie_construccion":
        promedio=(max-min)/200;
        break;
      case "superficie_terreno":
        promedio=(max-min)/100;
        break;
      case "tiempo_construccion":
        promedio=(max-min)/10;
        break;
      default:
        promedio=(max-min)/20;
        break;
    }
    return promedio;
  }
}
class UsuarioInmuebleBuscado{
  String id;
  int cantidadEncontrados;
  String nombreConfiguracion,numeroTelefono;
  String tipoContrato,tipoInmueble,ciudad,zona;
  int precioMin, precioMax;
  int plantas,ambientes,dormitorios,banios,garaje;
  int superficieTerrenoMin, superficieTerrenoMax;
  int superficieConstruccionMin,superficieConstruccionMax;
  int antiguedadConstruccionMin,antiguedadConstruccionMax;
  int tamanioFrenteMin,tamanioFrenteMax;
  bool mascotasPermitidas,sinHipoteca,construccionEstrenar,materialesPrimera;
  bool proyectoPreventa,inmuebleCompartido;
  int numeroDuenios;
  bool serviciosBasicos,gasDomiciliario,wifi,medidorIndependiente,termotanque;
  bool calleAsfaltada,transporte,preparadoDiscapacidad,papelesOrden,habilitadoCredito;
  bool amoblado,lavanderia,cuartoLavado,churrasquero, azotea;
  bool condominioPrivado,cancha,piscina,sauna,jacuzzi,estudio;
  bool jardin,portonElectrico,aireAcondicionado,calefaccion;
  bool ascensor,deposito,sotano,balcon,tienda,amuralladoTerreno;
  bool iglesia,parqueInfantil,escuela,universidad,plazuela,moduloPolicial;
  bool saunaPiscinaPublica,gymPublico,centroDeportivo,puestoSalud,zonaComercial;
  bool rematesJudiciales,imagenes2D,video2D,tourVirtual360,videoTour360;
  UsuarioInmuebleBuscado({
    required this.id,
    required this.cantidadEncontrados,
    required this.nombreConfiguracion,required this.numeroTelefono,
    required this.tipoContrato,required this.tipoInmueble,
    required this.ciudad,required this.zona,
    required this.precioMin,required this.precioMax,
    required this.plantas, required this.ambientes,
    required this.dormitorios,required this.banios,
    required this.garaje,
    required this.superficieTerrenoMin,required this.superficieTerrenoMax,
    required this.superficieConstruccionMin,required this.superficieConstruccionMax,
    required this.antiguedadConstruccionMin,required this.antiguedadConstruccionMax,
    required this.tamanioFrenteMin,required this.tamanioFrenteMax,
    required this.mascotasPermitidas,required this.sinHipoteca,required this.construccionEstrenar,
    required this.materialesPrimera,required this.proyectoPreventa,
    required this.inmuebleCompartido,required this.numeroDuenios,
    required this.serviciosBasicos,required this.gasDomiciliario,required this.wifi,
    required this.medidorIndependiente,required this.termotanque,
    required this.calleAsfaltada,required this.transporte,
    required this.preparadoDiscapacidad,required this.papelesOrden,
    required this.habilitadoCredito,
    required this.amoblado,required this.lavanderia,required this.cuartoLavado,
    required this.churrasquero,required this.azotea,required this.condominioPrivado,
    required this.cancha,required this.piscina,required this.sauna,required this.jacuzzi,
    required this.estudio,required this.jardin,required this.portonElectrico,
    required this.aireAcondicionado,required this.calefaccion,
    required this.ascensor,required this.deposito,required this.sotano,
    required this.balcon,required this.tienda,required this.amuralladoTerreno,
    required this.iglesia,required this.parqueInfantil,required this.escuela,
    required this.universidad,required this.plazuela,required this.moduloPolicial,
    required this.saunaPiscinaPublica,required this.gymPublico,required this.centroDeportivo,
    required this.puestoSalud,required this.zonaComercial,
    required this.rematesJudiciales,required this.imagenes2D,
    required this.video2D,required this.tourVirtual360,required this.videoTour360
  });
  factory UsuarioInmuebleBuscado.fromMap(Map<String,dynamic> map){
    return UsuarioInmuebleBuscado(
      id:map["id"]??"",
      cantidadEncontrados: 0,
      nombreConfiguracion:map["nombre_configuracion"]??"",
      numeroTelefono: map["numero_telefono"]??"",
      tipoContrato: map["tipo_contrato"]??"",
      tipoInmueble: map["tipo_inmueble"]??"",
      precioMin: map["precio_min"]??0,
      precioMax: map["precio_max"],
      ciudad: map["ciudad"]??"",
      zona: map["zona"]??"",
      ambientes: map["ambientes"]??0,
      plantas: map["plantas"]??0,
      dormitorios: map["dormitorios"]??0,
      banios: map["banios"]??0,
      garaje: map["garaje"]??0,
      superficieTerrenoMin: map["superficie_terreno_min"]??0,
      superficieTerrenoMax: map["superficie_terreno_max"]??0,
      superficieConstruccionMin: map["superficie_construccion_min"]??0,
      superficieConstruccionMax: map["superficie_construccion_max"]??0,
      antiguedadConstruccionMin: map["antiguedad_construccion_min"]??0,
      antiguedadConstruccionMax: map["antiguedad_construccion_max"]??0,
      tamanioFrenteMin: map["tamanio_frente_min"]??0,
      tamanioFrenteMax: map["tamanio_frente_max"]??0,
      mascotasPermitidas: map["mascotas_permitidas"]??false,
      sinHipoteca: map["sin_hipoteca"]??false,
      construccionEstrenar: map["construccion_estrenar"]??false,
      materialesPrimera: map["materiales_primera"]??false,
      proyectoPreventa: map["proyecto_preventa"]??false,
      inmuebleCompartido: map["inmueble_compartido"]??false,
      numeroDuenios: map["numero_duenios"]??1,
      serviciosBasicos: map["servicios_basicos"]??false,
      gasDomiciliario: map["gas_domiciliario"]??false,
      wifi: map["wifi"],
      medidorIndependiente: map["medidor_independiente"]??false,
      termotanque: map["termotanque"]??false,
      calleAsfaltada: map["calle_asfaltada"]??false,
      transporte: map["transporte"]??false,
      preparadoDiscapacidad: map["preparado_discapacidad"]??false,
      papelesOrden: map["papeles_orden"]??false,
      habilitadoCredito: map["habilitado_credito"]??false,
      amoblado: map["amoblado"]??false,
      lavanderia: map["lavanderia"]??false,
      cuartoLavado: map["cuarto_lavado"]??false,
      churrasquero: map["churrasquero"]??false,
      azotea: map["azotea"]??false,
      condominioPrivado: map["condominio_privado"]??false,
      cancha: map["cancha"]??false,
      piscina: map["piscina"]??false,
      sauna: map["sauna"]??false,
      jacuzzi: map["jacuzzi"]??false,
      estudio: map["estudio"]??false,
      jardin: map["jardin"]??false,
      portonElectrico: map["porton_electrico"]??false,
      aireAcondicionado: map["aire_acondicionado"]??false,
      calefaccion: map["calefaccion"]??false,
      ascensor: map["ascensor"]??false,
      deposito: map["deposito"]??false,
      sotano: map["sotano"]??false,
      balcon: map["balcon"]??false,
      tienda: map["tienda"]??false,
      amuralladoTerreno: map["amurallado_terreno"]??false,
      iglesia: map["iglesia"]??false,
      parqueInfantil: map["parque_infantil"]??false,
      escuela: map["escuela"]??false,
      universidad: map["universidad"]??false,
      plazuela: map["plazuela"]??false,
      moduloPolicial: map["modulo_policial"]??false,
      saunaPiscinaPublica: map["sauna_piscina_publica"]??false,
      gymPublico: map["gym_publico"]??false,
      centroDeportivo: map["centro_deportivo"]??false,
      puestoSalud: map["puesto_salud"]??false,
      zonaComercial: map["zona_comercial"]??false,
      rematesJudiciales: map["remates_judiciales"]??false,
      imagenes2D: map["imagenes_2D"]??false,
      video2D: map["video_2D"]??false,
      tourVirtual360: map["tour_virtual_360"]??false,
      videoTour360: map["video_tour_360"]??false
    );
  }
  factory UsuarioInmuebleBuscado.vacio(){
    return UsuarioInmuebleBuscado(
      id: "",cantidadEncontrados: 0, 
      nombreConfiguracion: "", numeroTelefono: "",
      tipoContrato: "",tipoInmueble: "", 
      ciudad: "", zona: "", precioMin: 0, precioMax: 0, 
      plantas: 0, ambientes: 0, dormitorios: 0, banios: 0, garaje: 0, 
      superficieTerrenoMin: 0, superficieTerrenoMax: 0, 
      superficieConstruccionMin: 0, superficieConstruccionMax: 0, 
      antiguedadConstruccionMin: 0, antiguedadConstruccionMax: 0, 
      tamanioFrenteMin: 0, tamanioFrenteMax: 0, mascotasPermitidas: false, 
      sinHipoteca: false, construccionEstrenar: false, materialesPrimera: false,
      proyectoPreventa: false, inmuebleCompartido: false, numeroDuenios: 1, 
      serviciosBasicos: false, gasDomiciliario: false, wifi: false, 
      medidorIndependiente: false, termotanque: false, calleAsfaltada: false, 
      transporte: false, preparadoDiscapacidad: false, papelesOrden: false, 
      habilitadoCredito: false, amoblado: false, lavanderia: false, cuartoLavado: false, 
      churrasquero: false, azotea: false, condominioPrivado: false, cancha: false, 
      piscina: false, sauna: false, jacuzzi: false, estudio: false, jardin: false, 
      portonElectrico: false, aireAcondicionado: false, calefaccion: false, 
      ascensor: false, deposito: false, sotano: false, balcon: false, tienda: false, 
      amuralladoTerreno: false, iglesia: false, parqueInfantil: false, escuela: false, 
      universidad: false, plazuela: false, moduloPolicial: false, 
      saunaPiscinaPublica: false, gymPublico: false, centroDeportivo: false, 
      puestoSalud: false, zonaComercial: false, rematesJudiciales: false, 
      imagenes2D: false, video2D: false, tourVirtual360: false, 
      videoTour360: false
    );
  }
  factory UsuarioInmuebleBuscado.copyWith(UsuarioInmuebleBuscado u){
    return UsuarioInmuebleBuscado(
      id: u.id, cantidadEncontrados: u.cantidadEncontrados,
      nombreConfiguracion: u.nombreConfiguracion, 
      numeroTelefono: u.numeroTelefono, tipoContrato: u.tipoContrato, 
      tipoInmueble: u.tipoInmueble, ciudad: u.ciudad, zona: u.zona, 
      precioMin: u.precioMin, precioMax: u.precioMax, plantas: u.plantas, 
      ambientes: u.ambientes, dormitorios: u.dormitorios, banios: u.banios, 
      garaje: u.garaje, superficieTerrenoMin: u.superficieTerrenoMin, 
      superficieTerrenoMax: u.superficieTerrenoMax, 
      superficieConstruccionMin: u.superficieConstruccionMin, 
      superficieConstruccionMax: u.superficieConstruccionMax, 
      antiguedadConstruccionMin: u.antiguedadConstruccionMin, 
      antiguedadConstruccionMax: u.antiguedadConstruccionMax, 
      tamanioFrenteMin: u.tamanioFrenteMin, tamanioFrenteMax: u.tamanioFrenteMax, 
      mascotasPermitidas: u.mascotasPermitidas, sinHipoteca: u.sinHipoteca, 
      construccionEstrenar: u.construccionEstrenar, 
      materialesPrimera: u.materialesPrimera, proyectoPreventa: u.proyectoPreventa, 
      inmuebleCompartido: u.inmuebleCompartido, numeroDuenios: u.numeroDuenios, 
      serviciosBasicos: u.serviciosBasicos, gasDomiciliario: u.gasDomiciliario, 
      wifi: u.wifi, medidorIndependiente: u.medidorIndependiente, 
      termotanque: u.termotanque, calleAsfaltada: u.calleAsfaltada, 
      transporte: u.transporte, preparadoDiscapacidad: u.preparadoDiscapacidad, 
      papelesOrden: u.papelesOrden, habilitadoCredito: u.habilitadoCredito, 
      amoblado: u.amoblado, lavanderia: u.lavanderia, cuartoLavado: u.cuartoLavado, 
      churrasquero: u.churrasquero, azotea: u.azotea, condominioPrivado: u.condominioPrivado, 
      cancha: u.cancha, piscina: u.piscina, sauna: u.sauna, jacuzzi: u.jacuzzi, 
      estudio: u.estudio, jardin: u.jardin, portonElectrico: u.portonElectrico, 
      aireAcondicionado: u.aireAcondicionado, calefaccion: u.calefaccion, ascensor: u.ascensor, 
      deposito: u.deposito, sotano: u.sotano, balcon: u.balcon, tienda: u.tienda, 
      amuralladoTerreno: u.amuralladoTerreno, iglesia: u.iglesia, 
      parqueInfantil: u.parqueInfantil, escuela: u.escuela, universidad: u.universidad, 
      plazuela: u.plazuela, moduloPolicial: u.moduloPolicial, 
      saunaPiscinaPublica: u.saunaPiscinaPublica, gymPublico: u.gymPublico, 
      centroDeportivo: u.centroDeportivo, puestoSalud: u.puestoSalud, 
      zonaComercial: u.zonaComercial, rematesJudiciales: u.rematesJudiciales, 
      imagenes2D: u.imagenes2D, video2D: u.video2D, tourVirtual360: u.tourVirtual360, 
      videoTour360: u.videoTour360
    );
  }
  Map<String,dynamic> toMap(){
    return {
      "id":this.id,
      "nombre_configuracion":this.nombreConfiguracion,"numero_telefono":this.numeroTelefono,
      "tipo_contrato":this.tipoContrato,"tipo_inmueble":this.tipoInmueble,
      "ciudad":this.ciudad,"zona":this.zona,
      "precio_min":this.precioMin,"precio_max":this.precioMax,
      "ambientes":this.ambientes,"plantas":this.plantas,
      "dormitorios":this.dormitorios,"banios":this.banios,
      "garaje":this.garaje,
      "superficie_terreno_min":this.superficieTerrenoMin,"superficie_terreno_max":this.superficieTerrenoMax,
      "superficie_construccion_min":this.superficieConstruccionMin,"superficie_construccion_max":this.superficieConstruccionMax,
      "antiguedad_construccion_min":this.antiguedadConstruccionMin,"antiguedad_construccion_max":this.antiguedadConstruccionMax,
      "tamanio_frente_min":this.tamanioFrenteMin,"tamanio_frente_max":this.tamanioFrenteMax,
      "mascotas_permitidas":this.mascotasPermitidas,"sin_hipoteca":this.sinHipoteca,
      "construccion_estrenar":this.construccionEstrenar,"materiales_primera":this.materialesPrimera,
      "proyecto_preventa":this.proyectoPreventa,"inmueble_compartido":this.inmuebleCompartido,
      "numero_duenios":this.numeroDuenios,"servicios_basicos":this.serviciosBasicos,
      "gas_domiciliario":this.gasDomiciliario,"wifi":this.wifi,
      "medidor_independiente":this.medidorIndependiente,"termotanque":this.termotanque,
      "calle_asfaltada":this.calleAsfaltada,"transporte":this.calleAsfaltada,
      "preparado_discapacidad":this.preparadoDiscapacidad,"papeles_orden":this.papelesOrden,
      "habilitado_credito":this.habilitadoCredito,
      "amoblado":this.amoblado,
      "lavanderia":this.lavanderia,"cuarto_lavado":this.cuartoLavado,
      "churrasquero":this.churrasquero,"azotea":this.azotea,
      "condominio_privado":this.condominioPrivado,"cancha":this.cancha,
      "piscina":this.piscina,"sauna":this.sauna,"jacuzzi":this.jacuzzi,
      "estudio":this.estudio,"jardin":this.jardin,"porton_electrico":this.portonElectrico,
      "aire_acondicionado":this.aireAcondicionado,"calefaccion":this.calefaccion,
      "ascensor":this.ascensor,"deposito":this.deposito,"sotano":this.sotano,
      "balcon":this.balcon,"tienda":this.tienda,"amurallado_terreno":this.amuralladoTerreno,
      "iglesia":this.iglesia,"parque_infantil":this.parqueInfantil,"escuela":this.escuela,
      "universidad":this.universidad,"plazuela":this.plazuela,"modulo_policial":this.moduloPolicial,
      "sauna_piscina_publica":this.saunaPiscinaPublica,"gym_publico":this.saunaPiscinaPublica,
      "centro_deportivo":this.centroDeportivo,"puesto_salud":this.puestoSalud,
      "zona_comercial":this.zonaComercial,"remates_judiciales":this.rematesJudiciales,
      "imagenes_2D":this.imagenes2D,"video_2D":this.video2D,"tour_virtual_360":this.tourVirtual360,
      "video_tour_360":this.videoTour360
    };
  }
}