
import 'package:inmobiliariaapp/domain/entities/banco.dart';

class Inmueble{
  int indice;
  String id, ciudad, direccion;
  int precio;
  List<dynamic> historialPrecios=[]; 
  String tipoInmueble;
  String tipoContrato, idInmobiliaria="";
  String estadoNegociacion;
  String nombreZona;
  bool mascotasPermitidas,sinHipoteca, construccionEstrenar,materialesPrimera;
  int superficieTerreno, superficieConstruccion,tamanioFrente,antiguedadConstruccion;
  bool proyectoPreventa,inmuebleCompartido;
  int numeroDuenios;
  bool serviciosBasicos,gasDomiciliario,wifi,medidorIndependiente,termotanque,
  calleAsfaltada,transporte,preparadoDiscapacidad,papelesOrden, habilitadoCredito;
  String detallesGenerales;
  Map<String,dynamic> mapImagenes;
  List<List<dynamic>> imagenesCategorias=[];
  List<String> categoriasImagen=[];
  List<String> categoriasKeys=[];
  List<dynamic> coordenadas;
  int numeroImagen=0;
  String fechaCreacion;
  String fechaPublicacion;
  String ultimaModificacion;
  String autorizacion;
  int calificacion;
  String categoria;
  int cantidadVistos;
  int cantidadDobleVistos;
  int cantidadFavoritos;
  //Inmueble({required this.id,rq});
  Inmueble({
    required this.indice,
    required this.id, required this.ciudad, 
    required this.direccion,
    required this.precio,
    required this.historialPrecios,
    required this.tipoInmueble,
    required this.estadoNegociacion,
    required this.tipoContrato, 
    required this.nombreZona,
    required this.mascotasPermitidas,required this.sinHipoteca,
    required this.construccionEstrenar,required this.materialesPrimera,
    required this.superficieTerreno,required this.superficieConstruccion,
    required this.tamanioFrente,
    required this.antiguedadConstruccion,required this.proyectoPreventa,
    required this.inmuebleCompartido,required this.numeroDuenios,
    required this.serviciosBasicos,required this.gasDomiciliario,
    required this.wifi,required this.medidorIndependiente,
    required this.termotanque,required this.calleAsfaltada,
    required this.transporte,required this.preparadoDiscapacidad,
    required this.papelesOrden,required this.habilitadoCredito,
    required this.detallesGenerales,
    required this.coordenadas,
    required this.fechaCreacion,
    required this.fechaPublicacion,
    required this.autorizacion,
    required this.calificacion,
    required this.categoria,
    required this.mapImagenes,
    required this.cantidadVistos,
    required this.cantidadDobleVistos,
    required this.cantidadFavoritos,
    required this.ultimaModificacion
    });
  int get getIndice=>this.indice;
  String get getId=>this.id;
  String get getCiudad=>this.ciudad;
  String get getNombreZona=>this.nombreZona;
  String get getDireccion=>this.direccion;
  int get getPrecio=>this.precio;
  List get getHistorialPrecios=>this.historialPrecios;
  String get getTipoInmueble=>this.tipoInmueble;
  String get getEstadoNegociacion=>this.estadoNegociacion;
  int get getSuperficieTerreno=>this.superficieTerreno;
  int get getSuperficieConstruccion=>this.superficieConstruccion;
  String get getTipoContrato=>tipoContrato;
  String get getIdInmobiliaria=>this.idInmobiliaria;
  bool get isPapelesOrden=>this.papelesOrden;
  bool get isConstruccionEstrenar=>this.construccionEstrenar;
  bool get isHabiliadoCredito=>this.habilitadoCredito;
  bool get isProyectoPreventa=>this.proyectoPreventa;
  int get getAntiguedadConstruccion=>this.antiguedadConstruccion;
  bool get isInmuebleCompartido=>this.inmuebleCompartido;
  int get getNumeroDuenios=>this.numeroDuenios;
  bool get isSinHipoteca=>this.sinHipoteca;
  String get getFechaCreacion=>this.fechaCreacion;
  String get getFechaPublicacion=>this.fechaPublicacion;
  String get getAutorizacion=>this.autorizacion;
  //List<List<dynamic>>get getImagenesCategorias=>this.imagenesCategorias;

  List<List<dynamic>> get getImagenesCategorias{
    categoriasImagen=[];
    imagenesCategorias=[];
    if(mapImagenes["plantas"].length>0){
      categoriasImagen.add("Plantas");
      categoriasKeys.add("plantas");
      imagenesCategorias.add(mapImagenes["plantas"]);
    }
    if(mapImagenes["ambientes"].length>0){
      categoriasImagen.add("Ambientes");
      categoriasKeys.add("ambientes");
      imagenesCategorias.add(mapImagenes["ambientes"]);
    }
    if(mapImagenes["dormitorios"].length>0){
      categoriasImagen.add("Dormitorios");
      categoriasKeys.add("dormitorios");
      imagenesCategorias.add(mapImagenes["dormitorios"]);
    }
    if(mapImagenes["banios"].length>0){
      categoriasImagen.add("Baños");
      categoriasKeys.add("banios");
      imagenesCategorias.add(mapImagenes["banios"]);
    }
    if(mapImagenes["garaje"].length>0){
      categoriasImagen.add("Garaje");
      categoriasKeys.add("garaje");
      imagenesCategorias.add(mapImagenes["garaje"]);
    }
    if(mapImagenes["amoblado"].length>0){
      categoriasImagen.add("Amoblado");
      categoriasKeys.add("amoblado");
      imagenesCategorias.add(mapImagenes["amoblado"]);
    }
    if(mapImagenes["lavanderia"].length>0){
      categoriasImagen.add("Lavanderia");
      categoriasKeys.add("lavanderia");
      imagenesCategorias.add(mapImagenes["lavanderia"]);
    }
    if(mapImagenes["cuarto_lavado"].length>0){
      categoriasImagen.add("Cuarto de lavado");
      categoriasKeys.add("cuarto_lavado");
      imagenesCategorias.add(mapImagenes["cuarto_lavado"]);
    }
    if(mapImagenes["churrasquero"].length>0){
      categoriasImagen.add("Churrasquero");
      categoriasKeys.add("churrasquero");
      imagenesCategorias.add(mapImagenes["churrasquero"]);
    }
    if(mapImagenes["azotea"].length>0){
      categoriasImagen.add("Azotea");
      imagenesCategorias.add(mapImagenes["azotea"]);
    }
    if(mapImagenes["condominio_privado"].length>0){
      categoriasImagen.add("Condominio privado");
      imagenesCategorias.add(mapImagenes["condominio_privado"]);
    }
    if(mapImagenes["cancha"].length>0){
      categoriasImagen.add("Cancha de fútbol, tenis, etc.");
      imagenesCategorias.add(mapImagenes["cancha"]);
    }
    if(mapImagenes["piscina"].length>0){
      categoriasImagen.add("Piscina");
      imagenesCategorias.add(mapImagenes["piscina"]);
    }
    if(mapImagenes["sauna"].length>0){
      categoriasImagen.add("Sauna");
      imagenesCategorias.add(mapImagenes["sauna"]);
    }
    if(mapImagenes["jacuzzi"].length>0){
      categoriasImagen.add("Jacuzzi");
      imagenesCategorias.add(mapImagenes["jacuzzi"]);
    }
    if(mapImagenes["estudio"].length>0){
      categoriasImagen.add("Estudio");
      imagenesCategorias.add(mapImagenes["estudio"]);
    }
    if(mapImagenes["jardin"].length>0){
      categoriasImagen.add("Jardín");
      imagenesCategorias.add(mapImagenes["jardin"]);
    }
    if(mapImagenes["porton_electrico"].length>0){
      categoriasImagen.add("Portón eléctrico");
      imagenesCategorias.add(mapImagenes["porton_electrico"]);
    }
    if(mapImagenes["aire_acondicionado"].length>0){
      categoriasImagen.add("Aire acondicionado");
      imagenesCategorias.add(mapImagenes["aire_acondicionado"]);
    }
    if(mapImagenes["calefaccion"].length>0){
      categoriasImagen.add("Calefacción");
      imagenesCategorias.add(mapImagenes["calefaccion"]);
    }
    if(mapImagenes["ascensor"].length>0){
      categoriasImagen.add("Ascensor");
      imagenesCategorias.add(mapImagenes["ascensor"]);
    }
    if(mapImagenes["deposito"].length>0){
      categoriasImagen.add("Depósito");
      imagenesCategorias.add(mapImagenes["deposito"]);
    }
    if(mapImagenes["sotano"].length>0){
      categoriasImagen.add("Sótano");
      imagenesCategorias.add(mapImagenes["sotano"]);
    }
    if(mapImagenes["balcon"].length>0){
      categoriasImagen.add("Balcón");
      imagenesCategorias.add(mapImagenes["balcon"]);
    }
    if(mapImagenes["tienda"].length>0){
      categoriasImagen.add("Tienda");
      imagenesCategorias.add(mapImagenes["tienda"]);
    }
    if(mapImagenes["amurallado_terreno"].length>0){
      categoriasImagen.add("Amurallado terreno");
      imagenesCategorias.add(mapImagenes["amurallado_terreno"]);
    }
    categoriasKeys=[];
    //mapImagenes.removeWhere((key, value) => key=="__typename");
    mapImagenes.removeWhere((key, value) => key=="__typename"||key=="inmueble");
    categoriasKeys.addAll(mapImagenes.keys.where((element) => mapImagenes[element].length>0));
    categoriasKeys.removeWhere((element) => element=="__typename"||element=="principales");
    //print(categoriasKeys);
    return imagenesCategorias;
  }
  int get getCantidadImagenes{
    int cantidad=0;
    mapImagenes.removeWhere((key, value) => key=="__typename"||key=="inmueble");
    mapImagenes.forEach((key, value) { 
      if(key!="principales"){
        List imagenes=mapImagenes[key];
        cantidad+=imagenes.length;
      }
    });
    return cantidad;
  }
  int get getNumeroImagen=>this.numeroImagen;
  int get getDiasEntreFechas{
    DateTime dateCreado = DateTime.parse(fechaPublicacion);
    DateTime dateActual = DateTime.now();
    return (dateActual.difference(dateCreado).inHours/24).round();
  }
  bool get isRebajado{
    if(historialPrecios.length>1){
      if(historialPrecios[historialPrecios.length-1]<historialPrecios[historialPrecios.length-2]){
        return true;
      }
    }
    return false;
  }
  List<dynamic> get getCoordenadas=>this.coordenadas;
  void setId(String id)=>this.id;
  void setCiudad(String ciudad)=>this.ciudad=ciudad;
  void setNombreZona(String nombreZona)=>this.nombreZona=nombreZona;
  void setDireccion(String direccion)=>this.direccion=direccion;
  void setPrecio(int precio)=>this.precio=precio;
  void setTipoInmueble(String tipoInmueble)=>this.tipoInmueble=tipoInmueble;
  void setEstadoInmueble(String estadoNegociacion)=>this.estadoNegociacion=estadoNegociacion;
  void setTipoContrato(String tipoContrato)=>this.tipoContrato=tipoContrato;
  void setPapelesOrden(bool documentosDia)=>this.papelesOrden=papelesOrden;
  void setConstruccionEstrenar(bool construccionEstrenar)=>this.construccionEstrenar=construccionEstrenar;
  void setHabilitadoCredito(bool habilitadoCredito)=>this.habilitadoCredito=habilitadoCredito;
  void setSuperficieTerreno(int superficieTerreno)=>this.superficieTerreno=superficieTerreno;
  void setSuperficieConstruccion(int superficieConstruccion)=>this.superficieConstruccion=superficieConstruccion;
  void setPreoyectoPreventa(bool proyectoPreventa)=>this.proyectoPreventa=proyectoPreventa;
  void setAntiguedadConstruccion(int antiguedadConstruccion)=>this.antiguedadConstruccion=antiguedadConstruccion;
  void setInmuebleCompartido(bool inmuebleCompartido)=>this.inmuebleCompartido=inmuebleCompartido;
  void setNumeroDuenios(int numeroDuenios)=>this.numeroDuenios=numeroDuenios;
  void setSinHipoteca(bool sinHipoteca)=>this.sinHipoteca=sinHipoteca;
  void setIdInmobiliaria(String idInmobiliaria)=>this.idInmobiliaria=idInmobiliaria;
  
  void setNumeroImagen(int numeroImagen)=>this.numeroImagen=numeroImagen;
  void setCalificacion(int calificacion)=>this.calificacion=calificacion;
  factory Inmueble.fromMap(Map<String,dynamic> map){
    //Map inmuebleData=snapshot.data();
    return Inmueble(
      id:map["id"],
      indice:map["indice"]??0,
      direccion: map["direccion"]??"",
      precio: map["precio"]??0,
      historialPrecios: map["historial_precios"]??[],
      tipoInmueble: map["tipo_inmueble"]??"",
      tipoContrato: map["tipo_contrato"]??"",
      ciudad: map["ciudad"]??"",
      estadoNegociacion: map["estado_negociacion"],
      nombreZona: map["zona"],
      coordenadas: map["coordenadas"],
      mascotasPermitidas: map["mascotas_permitidas"],
      sinHipoteca:map["sin_hipoteca"],
      construccionEstrenar:map["construccion_estrenar"],
      materialesPrimera:map["materiales_primera"],
      superficieTerreno:map["superficie_terreno"],
      superficieConstruccion:map["superficie_construccion"],
      tamanioFrente:map["tamanio_frente"],
      antiguedadConstruccion:map["antiguedad_construccion"],
      proyectoPreventa:map["proyecto_preventa"],
      inmuebleCompartido:map["inmueble_compartido"],
      numeroDuenios: map["numero_duenios"],
      serviciosBasicos: map["servicios_basicos"],
      gasDomiciliario: map["gas_domiciliario"],
      wifi: map["wifi"],
      medidorIndependiente: map["medidor_independiente"],
      termotanque: map["termotanque"],
      calleAsfaltada: map["calle_asfaltada"],
      transporte: map["transporte"],
      preparadoDiscapacidad: map["preparado_discapacidad"],
      papelesOrden: map["papeles_orden"],
      habilitadoCredito: map["habilitado_credito"],
      detallesGenerales: map["detalles_generales"]??"",
      fechaCreacion: map["fecha_creacion"],
      fechaPublicacion: map["fecha_publicacion"],
      autorizacion: map["autorizacion"],
      calificacion: map["calificacion"]!=null?map["calificacion"]:0,
      categoria: map["categoria"],
      mapImagenes: map["imagenes"],
      cantidadVistos: map["cantidad_vistos"]!=null?map["cantidad_vistos"]:0,
      cantidadDobleVistos: map["cantidad_doble_vistos"]!=null?map["cantidad_doble_vistos"]:0,
      cantidadFavoritos: map["cantidad_favoritos"]!=null?map["cantidad_favoritos"]:0,
      ultimaModificacion: map["ultima_modificacion"]??""
    );
  }
  factory Inmueble.vacio(){
    return Inmueble(
      id:"",
      indice:0,
      direccion: "",
      precio: 0,
      historialPrecios: [],
      tipoInmueble: "",
      tipoContrato: "",
      ciudad: "",
      estadoNegociacion: "",
      nombreZona: "",
      coordenadas: [],
      mascotasPermitidas: false,
      sinHipoteca:false,
      construccionEstrenar:false,
      materialesPrimera:false,
      superficieTerreno:0,
      superficieConstruccion:0,
      tamanioFrente: 0,
      antiguedadConstruccion:0,
      proyectoPreventa:false,
      inmuebleCompartido:false,
      numeroDuenios: 1,
      serviciosBasicos: false,
      gasDomiciliario: false,
      wifi: false,
      medidorIndependiente: false,
      termotanque: false,
      calleAsfaltada: false,
      transporte: false,
      preparadoDiscapacidad: false,
      papelesOrden: false,
      habilitadoCredito: false,
      detallesGenerales: "",
      fechaCreacion: "",
      fechaPublicacion: "",
      autorizacion: "",
      calificacion: 0,
      categoria: "",
      cantidadVistos: 0,
      cantidadDobleVistos: 0,
      cantidadFavoritos: 0,
      ultimaModificacion: "",
      mapImagenes: {
        "principales":[],
        "plantas":[],
        "ambientes":[],
        "dormitorios":[],
        "banios":[],
        "garaje":[],
        "amoblado":[],
        "lavanderia":[],
        "cuarto_lavado":[],
        "churrasquero":[],
        "azotea":[],
        "condominio_privado":[],
        "cancha":[],
        "piscina":[],
        "sauna":[],
        "jacuzzi":[],
        "estudio":[],
        "jardin":[],
        "porton_electrico":[],
        "aire_acondicionado":[],
        "calefaccion":[],
        "ascensor":[],
        "deposito":[],
        "sotano":[],
        "balcon":[],
        "tienda":[],
        "amurallado_terreno":[]
      },
    );
  }
  factory Inmueble.copyWith(Inmueble i){
    return Inmueble(indice: i.indice, id: i.id, ciudad: i.ciudad, direccion: i.direccion, 
      precio: i.precio, historialPrecios: arrayCopyWith(i.historialPrecios), tipoInmueble: i.tipoInmueble, 
      estadoNegociacion: i.estadoNegociacion, tipoContrato: i.tipoContrato, nombreZona: i.nombreZona, 
      mascotasPermitidas: i.mascotasPermitidas, sinHipoteca: i.sinHipoteca, 
      construccionEstrenar: i.construccionEstrenar, materialesPrimera: i.materialesPrimera, 
      superficieTerreno: i.superficieTerreno, superficieConstruccion: i.superficieConstruccion, 
      tamanioFrente: i.tamanioFrente, antiguedadConstruccion: i.antiguedadConstruccion, 
      proyectoPreventa: i.proyectoPreventa, inmuebleCompartido: i.inmuebleCompartido, 
      numeroDuenios: i.numeroDuenios, serviciosBasicos: i.serviciosBasicos, 
      gasDomiciliario: i.gasDomiciliario, wifi: i.wifi, medidorIndependiente: i.medidorIndependiente, 
      termotanque: i.termotanque, calleAsfaltada: i.calleAsfaltada, transporte: i.transporte, 
      preparadoDiscapacidad: i.preparadoDiscapacidad, papelesOrden: i.papelesOrden, 
      habilitadoCredito: i.habilitadoCredito,detallesGenerales: i.detallesGenerales,
      coordenadas: arrayCopyWith(i.coordenadas), 
      fechaCreacion: i.fechaCreacion, fechaPublicacion: i.fechaPublicacion, 
      autorizacion: i.autorizacion, calificacion: i.calificacion, 
      categoria: i.categoria, mapImagenes:mapCopyWith(i.mapImagenes),cantidadVistos: i.cantidadVistos,
      cantidadDobleVistos: i.cantidadDobleVistos,cantidadFavoritos: i.cantidadFavoritos,ultimaModificacion: i.ultimaModificacion
    );
  }

  
  /*factory Inmueble.fromJSON(Map<String,dynamic> map){
       
  }*/
  /*Map<String,dynamic> inmuebleToMap(Inmueble inmueble){
    return <String,dynamic>{
      "id":inmueble.getId,
      "direccion":inmueble.getDireccion,
      "agencia":inmueble.getIdInmobiliaria,
      "zona":inmueble.getNombreZona,
      "ciudad":inmueble.getCiudad,
      "precio":inmueble.getPrecio,
      "tipo_inmueble":inmueble.getTipoInmueble,
      "tipo_contrato":inmueble.getTipoContrato,
      "documentos_dia":inmueble.isDocumentosDia,
      "construccion_estrenar":inmueble.isNuevaConstruccion,
      "incluye_credito":inmueble.isIncluyeCredito,
      "superficie_terreno":inmueble.getSuperficieTerreno,
      "superficie_construccion":inmueble.getSuperficieConstruccion,
      "sin_construir":inmueble.isSinConstruir,
      "tiempo_construccion":inmueble.getTiempoConstruccion,
      "inmueble_compartido":inmueble.isInmuebleCompartido,
      "numero_duenios":inmueble.getNumeroDuenios,
      "numero_pisos":inmueble.getNumeroPisos,
      "sin_hipoteca":inmueble.isSinHipoteca
    };
  }*/
  //Inmueble.empty();
}
List<dynamic> arrayCopyWith(List<dynamic> a){
  List<dynamic> array=[];
  array.addAll(a);
  
  return array;
}
Map<String,dynamic> mapCopyWith(Map<String,dynamic> m){
  Map<String,dynamic> map={};
  m.forEach((key, value) {
    map[key]=value;
  });
  return map;
}
class InmuebleComprobante{
  String id;
  String medioPago;
  int montoPago;
  int plan;
  String numeroTransaccion;
  CuentaBanco cuentaBanco;
  String nombreDepositante;
  dynamic linkImagenDeposito;
  InmuebleComprobante({
    required this.id,
    required this.medioPago,
    required this.montoPago,
    required this.plan,
    required this.numeroTransaccion,
    required this.cuentaBanco,
    required this.nombreDepositante,
    required this.linkImagenDeposito
  });
  factory InmuebleComprobante.vacio(){
    return InmuebleComprobante(
      id: "",
      medioPago: "",
      montoPago: 0,
      plan: 0,
      numeroTransaccion: "",
      cuentaBanco: CuentaBanco.vacio(),
      nombreDepositante: "",
      linkImagenDeposito: ""
    );
  }
  factory InmuebleComprobante.fromMap(Map<String,dynamic> map){
    return InmuebleComprobante(
      id: map["id"],
      medioPago: map["medio_pago"], 
      montoPago: map["monto_pago"], 
      plan: map["plan"], 
      numeroTransaccion: map["numero_transaccion"], 
      cuentaBanco: CuentaBanco.fromMap(map["cuenta_banco"]),
      nombreDepositante: map["nombre_depositante"], 
      linkImagenDeposito: map["link_imagen_deposito"]
    );
  }
  factory InmuebleComprobante.copyWith(InmuebleComprobante ic){
    return InmuebleComprobante(
      id: ic.id, medioPago: ic.medioPago, montoPago: ic.montoPago, 
      plan: ic.plan, numeroTransaccion: ic.numeroTransaccion, 
      cuentaBanco: CuentaBanco.copyWith(ic.cuentaBanco), 
      nombreDepositante: ic.nombreDepositante, 
      linkImagenDeposito: ic.linkImagenDeposito
    );
  }
}
class InmuebleInternas {
  String id;
  int plantas,ambientes,dormitorios,banios,garaje;
  bool amoblado,lavanderia,cuartoLavado,churrasquero, azotea;
  bool condominioPrivado,cancha,piscina,sauna,jacuzzi,estudio;
  bool jardin,portonElectrico,aireAcondicionado,calefaccion;
  bool ascensor,deposito,sotano,balcon,tienda,amuralladoTerreno;
  String detallesInternas;
  InmuebleInternas({
    required this.id,
    required this.plantas,required this.ambientes,
    required this.dormitorios,required this.banios,required this.garaje,
    required this.amoblado,required this.lavanderia,required this.cuartoLavado,
    required this.churrasquero,required this.azotea,required this.condominioPrivado,
    required this.cancha,required this.piscina,required this.sauna,required this.jacuzzi,
    required this.estudio,required this.jardin,required this.portonElectrico,
    required this.aireAcondicionado,required this.calefaccion,
    required this.ascensor,required this.deposito,required this.sotano,
    required this.balcon,required this.tienda,required this.amuralladoTerreno,
    required this.detallesInternas
  });

  int get getDormitorios=>this.dormitorios;
  int get getBanios=>this.banios;
  int get getGaraje=>this.garaje;
  bool get isLavanderia=>this.lavanderia;
  bool get isCuartoLavado=>this.cuartoLavado;
  bool get isChurrasquero=>this.churrasquero;
  bool get isAzotea=>this.azotea;
  bool get isCancha=>this.cancha;
  bool get isPiscina=>this.piscina;
  bool get isSauna=>this.sauna;
  bool get isTienda=>this.tienda;
  bool get isEstudio=>this.estudio;
  bool get isJardin=>this.jardin;
  bool get isBalcon=>this.balcon;
  bool get isAscensor=>this.ascensor;
  bool get isSotano=>this.sotano;
  bool get isDeposito=>this.deposito;
  void setDormitorios(int dormitorios)=>this.dormitorios=dormitorios;
  void setBanios(int banios)=>this.banios=banios;
  void setGaraje(int garaje)=>this.garaje=garaje;
  void setLavanderia(bool lavanderia)=>this.lavanderia=lavanderia;
  void setCuartoLavado(bool cuartoLavado)=>this.cuartoLavado=cuartoLavado;
  void setChurrasquero(bool churrasquero)=>this.churrasquero=churrasquero;
  void setAzotea(bool azotea)=>this.azotea=azotea;
  void setCancha(bool cancha)=>this.cancha=cancha;
  void setPiscina(bool piscina)=>this.piscina=piscina;
  void setSauna(bool sauna)=>this.sauna=sauna;
  void setTienda(bool tienda)=>this.tienda=tienda;
  void setEstudio(bool estudio)=>this.estudio=estudio;
  void setJardin(bool jardin)=>this.jardin=jardin;
  void setBalcon(bool balcon)=>this.balcon=balcon;
  void setAscensor(bool ascensor)=>this.ascensor=ascensor;
  void setSotano(bool sotano)=>this.sotano=sotano;
  void setDeposito(bool deposito)=>this.deposito=deposito;
  factory InmuebleInternas.vacio(){
    return InmuebleInternas(
      id: "",
      plantas: 0,
      ambientes: 0,
      dormitorios: 0,
      banios: 0,
      garaje: 0,
      amoblado: false,
      lavanderia: false,
      cuartoLavado: false,
      churrasquero: false,
      azotea: false,
      condominioPrivado: false,
      cancha: false,
      piscina: false,
      sauna: false,
      jacuzzi: false,
      estudio: false,
      jardin: false,
      portonElectrico: false,
      aireAcondicionado: false,
      calefaccion: false,
      ascensor: false,
      deposito: false,
      sotano: false,
      balcon: false,
      tienda: false,
      amuralladoTerreno: false,
      detallesInternas:""
    );
  }
  factory InmuebleInternas.copyWith(InmuebleInternas ii){
    return InmuebleInternas(
      id: ii.id, plantas: ii.plantas, ambientes: ii.ambientes, 
      dormitorios: ii.dormitorios, banios: ii.banios, garaje: ii.garaje, 
      amoblado: ii.amoblado, lavanderia: ii.lavanderia, cuartoLavado: ii.cuartoLavado, 
      churrasquero: ii.churrasquero, azotea: ii.azotea, condominioPrivado: ii.condominioPrivado, 
      cancha: ii.cancha, piscina: ii.piscina, sauna: ii.sauna, jacuzzi: ii.jacuzzi, 
      estudio: ii.estudio, jardin: ii.jardin, portonElectrico: ii.portonElectrico, 
      aireAcondicionado: ii.aireAcondicionado, calefaccion: ii.calefaccion, ascensor: ii.ascensor, 
      deposito: ii.deposito, sotano: ii.sotano, balcon: ii.balcon, tienda: ii.tienda, 
      amuralladoTerreno: ii.amuralladoTerreno,detallesInternas: ii.detallesInternas
    );
  }
  factory InmuebleInternas.fromMap(Map<String,dynamic> mapData){
    return InmuebleInternas(
      id: mapData["id"],
      plantas: mapData["plantas"],
      ambientes: mapData["ambientes"],
      dormitorios: mapData["dormitorios"]!=null?mapData["dormitorios"]:0,
      banios: mapData["banios"]!=null?mapData["banios"]:0,
      garaje: mapData["garaje"]!=null?mapData["garaje"]:0,
      amoblado: mapData["amoblado"],
      lavanderia: mapData["lavanderia"],
      cuartoLavado: mapData["cuarto_lavado"],
      churrasquero: mapData["churrasquero"],
      azotea: mapData["azotea"],
      condominioPrivado: mapData["condominio_privado"],
      cancha: mapData["cancha"],
      piscina: mapData["piscina"],
      sauna: mapData["sauna"],
      jacuzzi: mapData["jacuzzi"],
      estudio: mapData["estudio"],
      jardin: mapData["jardin"],
      portonElectrico: mapData["porton_electrico"],
      aireAcondicionado: mapData["aire_acondicionado"],
      calefaccion: mapData["calefaccion"],
      ascensor: mapData["ascensor"],
      deposito: mapData["deposito"],
      sotano: mapData["sotano"],
      balcon: mapData["balcon"],
      tienda: mapData["tienda"],
      amuralladoTerreno: mapData["amurallado_terreno"],
      detallesInternas: mapData["detalles_internas"]??""
    );
  }
  /*
  Map<String,dynamic> inmuebleInternasToMap(InmuebleInternas inmuebleInternas){
    return <String,dynamic>{
      "id":inmuebleInternas,
      "dormitorios":inmuebleInternas.getDormitorios,
      "banios":inmuebleInternas.getBanios,
      "garaje":inmuebleInternas.getGaraje,
      "mascotas_permitidas":inmuebleInternas.isMascotasPermitidas,
      "lavanderia":inmuebleInternas.isLavanderia,
      "zona_lavadora":inmuebleInternas.isZonaLavadora,
      "churrasquero":inmuebleInternas.isChurrasquero,
      "azotea":inmuebleInternas.isAzotea,
      "cancha":inmuebleInternas.isCancha,
      "piscina":inmuebleInternas.isPiscina,
      "sauna":inmuebleInternas.isSauna,
      "tienda":inmuebleInternas.isTienda,
      "estudio":inmuebleInternas.isEstudio,
      "jardin":inmuebleInternas.isJardin,
      "balcon":inmuebleInternas.isBalcon,
      "ascensor":inmuebleInternas.isAscensor,
      "sotano":inmuebleInternas.isSotano,
      "deposito":inmuebleInternas.isDeposito
    };
  }*/
}
class InmueblesOtros{
  String id;
  bool rematesJudiciales;
  String imagenes2DLink;
  String video2DLink;
  String tourVirtual360Link;
  String videoTour360Link;
  String detallesOtros;
  InmueblesOtros({
    required this.id,
    required this.rematesJudiciales,
    required this.imagenes2DLink,
    required this.video2DLink,
    required this.tourVirtual360Link,
    required this.videoTour360Link,
    required this.detallesOtros
  }); 
  String get getId=>this.id;
  bool get isRematesJudiciales=>this.rematesJudiciales;
  String get getImagenes2DLink=>this.imagenes2DLink;
  String get getVideo2DLink=>this.video2DLink;
  String get getTourVirtual360Link=>this.tourVirtual360Link;
  String get getVideoTour360Link=>this.videoTour360Link;

  void setId(String id)=>this.id=id;
  void setRematesJudiciales(bool rematesJudiciales)=>this.rematesJudiciales=rematesJudiciales;
  void setImagenes2DLink(String imagenenes2D)=>this.imagenes2DLink=imagenenes2D;
  void setVideo2DLink(String video2D)=>this.video2DLink=video2D;
  void setTourVirtual360Link(String tourVirtual360)=>this.tourVirtual360Link=tourVirtual360;
  void setVideoTour360Link(String videoTour360)=>this.videoTour360Link=videoTour360;

  factory InmueblesOtros.vacio(){
    return InmueblesOtros(
      id: "", 
      rematesJudiciales: false, 
      imagenes2DLink: "", 
      video2DLink: "", 
      tourVirtual360Link: "", 
      videoTour360Link: "",
      detallesOtros:""
    );
  }
  factory InmueblesOtros.fromMap(Map<String,dynamic> mapData){
    return InmueblesOtros(
      id: mapData["id"]??"",
      rematesJudiciales: mapData["remates_judiciales"]??"", 
      imagenes2DLink: mapData["imagenes_2D_link"]??"", 
      video2DLink: mapData["video_2D_link"]??"", 
      tourVirtual360Link: mapData["tour_virtual_360_link"]??"", 
      videoTour360Link: mapData["video_tour_360_link"]??"",
      detallesOtros: mapData["detalles_otros"]??""
    );
  }
  factory InmueblesOtros.copyWith(InmueblesOtros io){
    return InmueblesOtros(
      id: io.id, rematesJudiciales: io.rematesJudiciales, 
      imagenes2DLink: io.imagenes2DLink, video2DLink: io.video2DLink, 
      tourVirtual360Link: io.tourVirtual360Link, videoTour360Link: io.videoTour360Link,
      detallesOtros:io.detallesOtros
    );
  }
  Map<String,dynamic> inmueblesOtrosToMap(InmueblesOtros inmueblesOtros){
    return <String,dynamic>{
      "id":inmueblesOtros,
      "remates_judiciales":inmueblesOtros.isRematesJudiciales,
      "imagenes_2D":inmueblesOtros.getImagenes2DLink,
      "video_2D":inmueblesOtros.getVideo2DLink,
      "tour_virtual_360":inmueblesOtros.getTourVirtual360Link,
      "video_tour_360":inmueblesOtros.getVideoTour360Link,
      "detalles_otros":inmueblesOtros.detallesOtros
    };
  }
}
class InmuebleComunidad{
  String id;
  bool iglesia,parqueInfantil,escuela,universidad,plazuela,moduloPolicial,
  saunaPiscinaPublica,gymPublico,centroDeportivo,puestoSalud,zonaComercial;
  String detallesComunidad;
  InmuebleComunidad({
    required this.id,required this.iglesia,required this.parqueInfantil,
    required this.escuela,required this.universidad,
    required this.plazuela,required this.moduloPolicial,
    required this.saunaPiscinaPublica,required this.gymPublico,
    required this.centroDeportivo,required this.puestoSalud,
    required this.zonaComercial,
    required this.detallesComunidad
  });
  String get getId=>this.id;
  bool get isIglesia=>this.iglesia;
  bool get isParqueInfantil=>this.parqueInfantil;
  bool get isCentroDeportivo=>this.centroDeportivo;
  bool get isModuloPolicial=>this.moduloPolicial;
  bool get isZonaComercial=>this.zonaComercial;
  void setId(String id)=>this.id=id;
  void setIglesia(bool iglesia)=>this.iglesia=iglesia;
  void setParqueInfantil(bool parqueInfantil)=>this.parqueInfantil=parqueInfantil;
  void setCentroDeportivo(bool centroDeportivo)=>this.centroDeportivo=centroDeportivo;
  void setModuloPolicial(bool moduloPolicial)=>this.moduloPolicial=moduloPolicial;
  void setZonaComercial(bool zonaComercial)=>this.zonaComercial=zonaComercial;

  factory InmuebleComunidad.vacio(){
    return InmuebleComunidad(
      id: "", iglesia: false, parqueInfantil: false,
      escuela:false,universidad: false,
      plazuela: false,moduloPolicial: false,
      saunaPiscinaPublica: false,gymPublico: false,
      centroDeportivo: false,puestoSalud: false,zonaComercial: false,
      detallesComunidad: ""
    );
  }
  factory InmuebleComunidad.fromMap(Map<String,dynamic> mapData){
    return InmuebleComunidad(
      id: mapData["id"],
      iglesia: mapData["iglesia"], parqueInfantil: mapData["parque_infantil"],
      escuela: mapData["escuela"],universidad: mapData["universidad"],
      plazuela: mapData["plazuela"],moduloPolicial: mapData["modulo_policial"],
      saunaPiscinaPublica: mapData["sauna_piscina_publica"],gymPublico: mapData["gym_publico"],
      centroDeportivo: mapData["centro_deportivo"],puestoSalud: mapData["puesto_salud"],
      zonaComercial: mapData["zona_comercial"],detallesComunidad: mapData["detalles_comunidad"]??""
    );
  }
  factory InmuebleComunidad.copyWith(InmuebleComunidad ic){
    return InmuebleComunidad(
      id: ic.id, iglesia: ic.iglesia, parqueInfantil: ic.parqueInfantil, escuela: ic.escuela, 
      universidad: ic.universidad, plazuela: ic.plazuela, moduloPolicial: ic.moduloPolicial, 
      saunaPiscinaPublica: ic.saunaPiscinaPublica, gymPublico: ic.gymPublico, 
      centroDeportivo: ic.centroDeportivo, puestoSalud: ic.puestoSalud, zonaComercial: ic.zonaComercial,
      detallesComunidad: ic.detallesComunidad
    );
  } 
  /*Map<String,dynamic> inmuebleComunidadToMap(InmuebleComunidad inmuebleComunidad){
    return <String,dynamic>{
      "id":inmuebleComunidad,
      "iglesia":inmuebleComunidad.isIglesia,
      "parque":inmuebleComunidad.isParque,
      "deportiva":inmuebleComunidad.isDeportiva,
      "policial":inmuebleComunidad.isPolicial,
      "residencial":inmuebleComunidad.isResidencial,
    };
  }*/
}