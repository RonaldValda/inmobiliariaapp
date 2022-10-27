import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/domain/entities/publication_plan_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';

class Property{
  int index;
  String id, city, address;
  int price;
  List<dynamic> pricesHistory=[]; 
  String propertyType;
  String contractType, agencyId="";
  String negotiationStatus;
  String zoneName;
  bool enablePets,noMortgage, newConstruction,premiumMaterials;
  int landSurface, constructionSurface, frontSize,constructionAntiquity;
  bool preSaleProject,sharedProperty;
  int ownersNumber;
  bool basicServices,householdGas,wifi,independentMeter,hotWaterTank,
  pavedStreet,transport,disabilityPrepared,orderPapers, enabledCredit;
  String generalDetails;
  Map<String,dynamic> mapImages;
  List<List<dynamic>> imagesCategories=[];
  List<String> imageCategories=[];
  List<String> categoriesKeys=[];
  List<dynamic> coordinates;
  int imageNumber=0;
  String creationDate;
  String publicationDate;
  int allowedUpdate;
  int counterUpdate;
  String lastUpdate;
  String authorization;
  int qualification;
  String category;
  int viewedQuantity;
  int viewedDoubleQuantity;
  int favoritesQuantity;
  //Inmueble({required this.id,rq});
  Property({
    required this.index,
    required this.id, required this.city, 
    required this.address,
    required this.price,
    required this.pricesHistory,
    required this.propertyType,
    required this.negotiationStatus,
    required this.contractType, 
    required this.zoneName,
    required this.enablePets,required this.noMortgage,
    required this.newConstruction,required this.premiumMaterials,
    required this.landSurface,required this.constructionSurface,
    required this.frontSize,
    required this.constructionAntiquity,required this.preSaleProject,
    required this.sharedProperty,required this.ownersNumber,
    required this.basicServices,required this.householdGas,
    required this.wifi,required this.independentMeter,
    required this.hotWaterTank,required this.pavedStreet,
    required this.transport,required this.disabilityPrepared,
    required this.orderPapers,required this.enabledCredit,
    required this.generalDetails,
    required this.coordinates,
    required this.creationDate,
    required this.publicationDate,
    required this.authorization,
    required this.qualification,
    required this.category,
    required this.mapImages,
    required this.viewedQuantity,
    required this.viewedDoubleQuantity,
    required this.favoritesQuantity,
    required this.allowedUpdate,
    required this.counterUpdate,
    required this.lastUpdate
    });

  List<List<dynamic>> get getCategoriesImages{
    imageCategories=[];
    imagesCategories=[];
    if(mapImages["plantas"].length>0){
      imageCategories.add("Plantas");
      categoriesKeys.add("plantas");
      imagesCategories.add(mapImages["plantas"]);
    }
    if(mapImages["ambientes"].length>0){
      imageCategories.add("Ambientes");
      categoriesKeys.add("ambientes");
      imagesCategories.add(mapImages["ambientes"]);
    }
    if(mapImages["dormitorios"].length>0){
      imageCategories.add("Dormitorios");
      categoriesKeys.add("dormitorios");
      imagesCategories.add(mapImages["dormitorios"]);
    }
    if(mapImages["banios"].length>0){
      imageCategories.add("Baños");
      categoriesKeys.add("banios");
      imagesCategories.add(mapImages["banios"]);
    }
    if(mapImages["garaje"].length>0){
      imageCategories.add("Garaje");
      categoriesKeys.add("garaje");
      imagesCategories.add(mapImages["garaje"]);
    }
    if(mapImages["amoblado"].length>0){
      imageCategories.add("Amoblado");
      categoriesKeys.add("amoblado");
      imagesCategories.add(mapImages["amoblado"]);
    }
    if(mapImages["lavanderia"].length>0){
      imageCategories.add("Lavanderia");
      categoriesKeys.add("lavanderia");
      imagesCategories.add(mapImages["lavanderia"]);
    }
    if(mapImages["cuarto_lavado"].length>0){
      imageCategories.add("Cuarto de lavado");
      categoriesKeys.add("cuarto_lavado");
      imagesCategories.add(mapImages["cuarto_lavado"]);
    }
    if(mapImages["churrasquero"].length>0){
      imageCategories.add("Churrasquero");
      categoriesKeys.add("churrasquero");
      imagesCategories.add(mapImages["churrasquero"]);
    }
    if(mapImages["azotea"].length>0){
      imageCategories.add("Azotea");
      imagesCategories.add(mapImages["azotea"]);
    }
    if(mapImages["condominio_privado"].length>0){
      imageCategories.add("Condominio privado");
      imagesCategories.add(mapImages["condominio_privado"]);
    }
    if(mapImages["cancha"].length>0){
      imageCategories.add("Cancha de fútbol, tenis, etc.");
      imagesCategories.add(mapImages["cancha"]);
    }
    if(mapImages["piscina"].length>0){
      imageCategories.add("Piscina");
      imagesCategories.add(mapImages["piscina"]);
    }
    if(mapImages["sauna"].length>0){
      imageCategories.add("Sauna");
      imagesCategories.add(mapImages["sauna"]);
    }
    if(mapImages["jacuzzi"].length>0){
      imageCategories.add("Jacuzzi");
      imagesCategories.add(mapImages["jacuzzi"]);
    }
    if(mapImages["estudio"].length>0){
      imageCategories.add("Estudio");
      imagesCategories.add(mapImages["estudio"]);
    }
    if(mapImages["jardin"].length>0){
      imageCategories.add("Jardín");
      imagesCategories.add(mapImages["jardin"]);
    }
    if(mapImages["porton_electrico"].length>0){
      imageCategories.add("Portón eléctrico");
      imagesCategories.add(mapImages["porton_electrico"]);
    }
    if(mapImages["aire_acondicionado"].length>0){
      imageCategories.add("Aire acondicionado");
      imagesCategories.add(mapImages["aire_acondicionado"]);
    }
    if(mapImages["calefaccion"].length>0){
      imageCategories.add("Calefacción");
      imagesCategories.add(mapImages["calefaccion"]);
    }
    if(mapImages["ascensor"].length>0){
      imageCategories.add("Ascensor");
      imagesCategories.add(mapImages["ascensor"]);
    }
    if(mapImages["deposito"].length>0){
      imageCategories.add("Depósito");
      imagesCategories.add(mapImages["deposito"]);
    }
    if(mapImages["sotano"].length>0){
      imageCategories.add("Sótano");
      imagesCategories.add(mapImages["sotano"]);
    }
    if(mapImages["balcon"].length>0){
      imageCategories.add("Balcón");
      imagesCategories.add(mapImages["balcon"]);
    }
    if(mapImages["tienda"].length>0){
      imageCategories.add("Tienda");
      imagesCategories.add(mapImages["tienda"]);
    }
    if(mapImages["amurallado_terreno"].length>0){
      imageCategories.add("Amurallado terreno");
      imagesCategories.add(mapImages["amurallado_terreno"]);
    }
    categoriesKeys=[];
    //mapImagenes.removeWhere((key, value) => key=="__typename");
    mapImages.removeWhere((key, value) => key=="__typename"||key=="inmueble");
    categoriesKeys.addAll(mapImages.keys.where((element) => mapImages[element].length>0));
    categoriesKeys.removeWhere((element) => element=="__typename"||element=="principales");
    //print(categoriasKeys);
    return imagesCategories;
  }
  int get getCantidadImagenes{
    int cantidad=0;
    mapImages.removeWhere((key, value) => key=="__typename"||key=="inmueble");
    mapImages.forEach((key, value) { 
      if(key!="principales"){
        List imagenes=mapImages[key];
        cantidad+=imagenes.length;
      }
    });
    return cantidad;
  }
  int get getImageNumber=>this.imageNumber;
  int get getDaysBetweenDates{
    if(publicationDate==""){
      return 0;
    }
    DateTime dateCreated = DateTime.parse(publicationDate);
    DateTime dateCurrent = DateTime.now();
    return (dateCurrent.difference(dateCreated).inHours/24).round();
  }
  bool get isLowered{
    if(pricesHistory.length>1){
      if(pricesHistory[pricesHistory.length-1]<pricesHistory[pricesHistory.length-2]){
        return true;
      }
    }
    return false;
  }
  factory Property.fromMap(Map<String,dynamic> map){
    //Map inmuebleData=snapshot.data();
    return Property(
      id:map["id"],
      index:map["indice"]??0,
      address: map["direccion"]??"",
      price: map["precio"]??0,
      pricesHistory: map["historial_precios"]??[],
      propertyType: map["tipo_inmueble"]??"",
      contractType: map["tipo_contrato"]??"",
      city: map["ciudad"]??"",
      negotiationStatus: map["estado_negociacion"],
      zoneName: map["zona"],
      coordinates: map["coordenadas"],
      enablePets: map["mascotas_permitidas"],
      noMortgage:map["sin_hipoteca"],
      newConstruction:map["construccion_estrenar"],
      premiumMaterials:map["materiales_primera"],
      landSurface:map["superficie_terreno"],
      constructionSurface:map["superficie_construccion"],
      frontSize:map["tamanio_frente"]??0,
      constructionAntiquity:map["antiguedad_construccion"],
      preSaleProject:map["proyecto_preventa"],
      sharedProperty:map["inmueble_compartido"],
      ownersNumber: map["numero_duenios"],
      basicServices: map["servicios_basicos"],
      householdGas: map["gas_domiciliario"],
      wifi: map["wifi"],
      independentMeter: map["medidor_independiente"],
      hotWaterTank: map["termotanque"],
      pavedStreet: map["calle_asfaltada"],
      transport: map["transporte"],
      disabilityPrepared: map["preparado_discapacidad"],
      orderPapers: map["papeles_orden"],
      enabledCredit: map["habilitado_credito"],
      generalDetails: map["detalles_generales"]??"",
      creationDate: map["fecha_creacion"]??"",
      publicationDate: map["fecha_publicacion"]??"",
      authorization: map["autorizacion"],
      qualification: map["calificacion"]!=null?map["calificacion"]:0,
      category: map["categoria"],
      mapImages: map["imagenes"],
      viewedQuantity: map["cantidad_vistos"]!=null?map["cantidad_vistos"]:0,
      viewedDoubleQuantity: map["cantidad_doble_vistos"]!=null?map["cantidad_doble_vistos"]:0,
      favoritesQuantity: map["cantidad_favoritos"]!=null?map["cantidad_favoritos"]:0,
      lastUpdate: map["ultima_modificacion"]??"",
      allowedUpdate: map["modificaciones_permitidas"]??0,
      counterUpdate: map["contador_modificacion"]??0
    );
  }
  factory Property.empty(){
    return Property(
      id:"",
      index:0,
      address: "",
      price: 0,
      pricesHistory: [],
      propertyType: "",
      contractType: "",
      city: "",
      negotiationStatus: "",
      zoneName: "",
      coordinates: [],
      enablePets: false,
      noMortgage:false,
      newConstruction:false,
      premiumMaterials:false,
      landSurface:0,
      constructionSurface:0,
      frontSize: 0,
      constructionAntiquity:0,
      preSaleProject:false,
      sharedProperty:false,
      ownersNumber: 1,
      basicServices: false,
      householdGas: false,
      wifi: false,
      independentMeter: false,
      hotWaterTank: false,
      pavedStreet: false,
      transport: false,
      disabilityPrepared: false,
      orderPapers: false,
      enabledCredit: false,
      generalDetails: "",
      creationDate: "",
      publicationDate: "",
      authorization: "",
      qualification: 0,
      category: "",
      viewedQuantity: 0,
      viewedDoubleQuantity: 0,
      favoritesQuantity: 0,
      lastUpdate: "",
      allowedUpdate:0,
      counterUpdate: 0,
      mapImages: {
        "principales":["","",""],
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
  factory Property.copyWith(Property i){
    return Property(index: i.index, id: i.id, city: i.city, address: i.address, 
      price: i.price, pricesHistory: arrayCopyWith(i.pricesHistory), propertyType: i.propertyType, 
      negotiationStatus: i.negotiationStatus, contractType: i.contractType, zoneName: i.zoneName, 
      enablePets: i.enablePets, noMortgage: i.noMortgage, 
      newConstruction: i.newConstruction, premiumMaterials: i.premiumMaterials, 
      landSurface: i.landSurface, constructionSurface: i.constructionSurface, 
      frontSize: i.frontSize, constructionAntiquity: i.constructionAntiquity, 
      preSaleProject: i.preSaleProject, sharedProperty: i.sharedProperty, 
      ownersNumber: i.ownersNumber, basicServices: i.basicServices, 
      householdGas: i.householdGas, wifi: i.wifi, independentMeter: i.independentMeter, 
      hotWaterTank: i.hotWaterTank, pavedStreet: i.pavedStreet, transport: i.transport, 
      disabilityPrepared: i.disabilityPrepared, orderPapers: i.orderPapers, 
      enabledCredit: i.enabledCredit,generalDetails: i.generalDetails,
      coordinates: arrayCopyWith(i.coordinates), 
      creationDate: i.creationDate, publicationDate: i.publicationDate, 
      authorization: i.authorization, qualification: i.qualification, 
      category: i.category, mapImages:mapCopyWith(i.mapImages),viewedQuantity: i.viewedQuantity,
      viewedDoubleQuantity: i.viewedDoubleQuantity,favoritesQuantity: i.favoritesQuantity,
      lastUpdate: i.lastUpdate,allowedUpdate: i.allowedUpdate,counterUpdate: i.counterUpdate
    );
  }
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

class PropertyVoucher{
  String id;
  String voucherType;
  String paymentMedium;
  int paymentAmount;
  String transactionNumber;
  BankAccount bankAccount;
  String depositorName;
  dynamic depositImageLink;
  dynamic documentPropertyImageLink;
  dynamic documentSalesImageLink;
  dynamic ownerDNIImageLink;
  dynamic agentDNIImageLink;
  bool contractLimit;
  bool contractCancel;
  String testimonyNumber;
  User userBuyer;
  PublicationPlanPayment publicationPlanPayment;
  PropertyVoucher({
    required this.id,
    required this.voucherType,
    required this.paymentMedium,
    required this.paymentAmount,
    required this.transactionNumber,
    required this.bankAccount,
    required this.depositorName,
    required this.depositImageLink,
    required this.documentPropertyImageLink,
    required this.documentSalesImageLink,
    required this.ownerDNIImageLink,
    required this.agentDNIImageLink,
    required this.contractLimit,
    required this.contractCancel,
    required this.testimonyNumber,
    required this.userBuyer,
    required this.publicationPlanPayment
  });
  factory PropertyVoucher.empty(){
    return PropertyVoucher(
      id: "",
      voucherType: "",
      paymentMedium: "",
      paymentAmount: 0,
      transactionNumber: "",
      bankAccount: BankAccount.empty(),
      depositorName: "",
      depositImageLink: "",
      documentPropertyImageLink:"",
      documentSalesImageLink: "",
      agentDNIImageLink: "",
      ownerDNIImageLink: "",
      contractCancel: true,
      contractLimit: false,
      testimonyNumber: "",
      userBuyer: User.empty(),
      publicationPlanPayment: PublicationPlanPayment.empty()
    );
  }
  factory PropertyVoucher.fromMap(Map<String,dynamic> map){
    return PropertyVoucher(
      id: map["id"],
      voucherType:map["tipo_comprobante"]??"",
      paymentMedium: map["medio_pago"]??"", 
      paymentAmount: map["monto_pago"]??0, 
      transactionNumber: map["numero_transaccion"]??"", 
      bankAccount: map["cuenta_banco"]!=null?BankAccount.fromMap(map["cuenta_banco"]):BankAccount.empty(),
      depositorName: map["nombre_depositante"]??"", 
      depositImageLink: map["link_imagen_deposito"]??"",
      documentPropertyImageLink: map["link_imagen_documento_propiedad"]??"",
      documentSalesImageLink: map["link_imagen_documento_venta"]??"",
      agentDNIImageLink: map["link_imagen_dni_agente"]??"",
      ownerDNIImageLink: map["link_imagen_dni_propietario"]??"",
      contractLimit: map["limite_contrato"]??false,
      contractCancel: map["cancelacion_contrato"]??true,
      testimonyNumber: map["numero_testimonio"]??"",
      userBuyer: map["usuario_comprador"]!=null?User.fromMap(map["usuario_comprador"]):User.empty(),
      publicationPlanPayment: map["plan"]!=null?PublicationPlanPayment.fromMap(map["plan"]):PublicationPlanPayment.empty()
    );
  }
  factory PropertyVoucher.copyWith(PropertyVoucher pv){
    return PropertyVoucher(
      id: pv.id, voucherType: pv.voucherType,paymentMedium: pv.paymentMedium, paymentAmount: pv.paymentAmount, 
      transactionNumber: pv.transactionNumber, 
      bankAccount: BankAccount.copyWith(pv.bankAccount), 
      depositorName: pv.depositorName, 
      depositImageLink: pv.depositImageLink,
      documentPropertyImageLink: pv.documentPropertyImageLink,
      documentSalesImageLink: pv.documentSalesImageLink,
      agentDNIImageLink: pv.agentDNIImageLink,
      ownerDNIImageLink: pv.ownerDNIImageLink,
      contractLimit: pv.contractLimit,
      contractCancel: pv.contractCancel,
      testimonyNumber: pv.testimonyNumber,
      userBuyer: User.copyWith(pv.userBuyer),
      publicationPlanPayment: PublicationPlanPayment.copyWith(pv.publicationPlanPayment)
    );
  }

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "tipo_comprobante":this.voucherType,
      "limite_contrato":this.contractLimit,
      "cancelacion_contrato":this.contractCancel,
      "numero_testimonio":this.testimonyNumber,
      "link_imagen_documento_propiedad":this.documentPropertyImageLink,
      "usuario_comprador":this.userBuyer.id
    };
  }
}
class PropertyInternal{
  String id;
  int floorsNumber,roomsNumber,bedroomsNumber,bathroomsNumber,garagesNumber;
  bool furnished,laundry,laundryRoom,grill,rooftop;
  bool privateCondominium,court,pool,sauna,jacuzzi,studio;
  bool garden,electricGate,airConditioning,heating;
  bool elevator,warehouse,basement,balcony,store,landWalled;
  String internalDetails;
  PropertyInternal({
    required this.id,
    required this.floorsNumber,required this.roomsNumber,
    required this.bedroomsNumber,required this.bathroomsNumber,required this.garagesNumber,
    required this.furnished,required this.laundry,required this.laundryRoom,
    required this.grill,required this.rooftop,required this.privateCondominium,
    required this.court,required this.pool,required this.sauna,required this.jacuzzi,
    required this.studio,required this.garden,required this.electricGate,
    required this.airConditioning,required this.heating,
    required this.elevator,required this.warehouse,required this.basement,
    required this.balcony,required this.store,required this.landWalled,
    required this.internalDetails
  });

  factory PropertyInternal.empty(){
    return PropertyInternal(
      id: "",
      floorsNumber: 0,roomsNumber: 0,bedroomsNumber: 0,
      bathroomsNumber: 0,garagesNumber: 0,
      furnished: false,laundry: false,laundryRoom: false,
      grill: false,rooftop: false, privateCondominium: false,
      court: false, pool: false,sauna: false,jacuzzi: false,
      studio: false,garden: false,electricGate: false,
      airConditioning: false,heating: false,elevator: false,
      warehouse: false,basement: false,balcony: false,
      store: false,landWalled: false,internalDetails:""
    );
  }
  factory PropertyInternal.copyWith(PropertyInternal pi){
    return PropertyInternal(
      id: pi.id, floorsNumber: pi.floorsNumber, roomsNumber: pi.roomsNumber, 
      bedroomsNumber: pi.bedroomsNumber, bathroomsNumber: pi.bathroomsNumber, garagesNumber: pi.garagesNumber, 
      furnished: pi.furnished, laundry: pi.laundry, laundryRoom: pi.laundryRoom, 
      grill: pi.grill, rooftop: pi.rooftop, privateCondominium: pi.privateCondominium, 
      court: pi.court, pool: pi.pool, sauna: pi.sauna, jacuzzi: pi.jacuzzi, 
      studio: pi.studio, garden: pi.garden, electricGate: pi.electricGate, 
      airConditioning: pi.airConditioning, heating: pi.heating, elevator: pi.elevator, 
      warehouse: pi.warehouse, basement: pi.basement, balcony: pi.balcony, store: pi.store, 
      landWalled: pi.landWalled,internalDetails: pi.internalDetails
    );
  }
  factory PropertyInternal.fromMap(Map<String,dynamic> mapData){
    return PropertyInternal(
      id: mapData["id"],
      floorsNumber: mapData["plantas"],
      roomsNumber: mapData["ambientes"],
      bedroomsNumber: mapData["dormitorios"]!=null?mapData["dormitorios"]:0,
      bathroomsNumber: mapData["banios"]!=null?mapData["banios"]:0,
      garagesNumber: mapData["garaje"]!=null?mapData["garaje"]:0,
      furnished: mapData["amoblado"],
      laundry: mapData["lavanderia"],
      laundryRoom: mapData["cuarto_lavado"],
      grill: mapData["churrasquero"],
      rooftop: mapData["azotea"],
      privateCondominium: mapData["condominio_privado"],
      court: mapData["cancha"],
      pool: mapData["piscina"],
      sauna: mapData["sauna"],
      jacuzzi: mapData["jacuzzi"],
      studio: mapData["estudio"],
      garden: mapData["jardin"],
      electricGate: mapData["porton_electrico"],
      airConditioning: mapData["aire_acondicionado"]??false,
      heating: mapData["calefaccion"],
      elevator: mapData["ascensor"],
      warehouse: mapData["deposito"],
      basement: mapData["sotano"],
      balcony: mapData["balcon"],
      store: mapData["tienda"],
      landWalled: mapData["amurallado_terreno"],
      internalDetails: mapData["detalles_internas"]??""
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
class PropertyOthers{
  String id;
  bool judicialAuctions;
  String video2DLink;
  String tourVirtual360Link;
  String videoTour360Link;
  String othersDetails;
  int contactNumber;
  String contactLink;
  String platformCitesLink;
  PropertyOthers({
    required this.id,
    required this.judicialAuctions,
    required this.video2DLink,
    required this.tourVirtual360Link,
    required this.videoTour360Link,
    required this.othersDetails,
    required this.contactNumber,
    required this.contactLink,
    required this.platformCitesLink
  }); 

  factory PropertyOthers.empty(){
    return PropertyOthers(
      id: "", 
      judicialAuctions: false, 
      video2DLink: "", 
      tourVirtual360Link: "", 
      videoTour360Link: "",
      othersDetails:"",
      contactNumber: 0,
      contactLink: "",
      platformCitesLink: ""
    );
  }
  factory PropertyOthers.fromMap(Map<String,dynamic> mapData){
    return PropertyOthers(
      id: mapData["id"]??"",
      judicialAuctions: mapData["remates_judiciales"]??"", 
      video2DLink: mapData["video_2D_link"]??"", 
      tourVirtual360Link: mapData["tour_virtual_360_link"]??"", 
      videoTour360Link: mapData["video_tour_360_link"]??"",
      othersDetails: mapData["detalles_otros"]??"",
      contactNumber: mapData["contacto_numero"]??0,
      contactLink: mapData["contacto_link"]??"",
      platformCitesLink: mapData["plataforma_citas_link"]??"",
    );
  }
  factory PropertyOthers.copyWith(PropertyOthers po){
    return PropertyOthers(
      id: po.id, judicialAuctions: po.judicialAuctions, 
      video2DLink: po.video2DLink, 
      tourVirtual360Link: po.tourVirtual360Link, videoTour360Link: po.videoTour360Link,
      othersDetails:po.othersDetails,contactNumber: po.contactNumber,contactLink: po.contactLink,
      platformCitesLink: po.platformCitesLink
    );
  }
  Map<String,dynamic> propertyOthersToMap(PropertyOthers propertyOthers){
    return <String,dynamic>{
      "id":propertyOthers.id,
      "remates_judiciales":propertyOthers.judicialAuctions,
      "video_2D":propertyOthers.videoTour360Link,
      "tour_virtual_360":propertyOthers.tourVirtual360Link,
      "video_tour_360":propertyOthers.videoTour360Link,
      "detalles_otros":propertyOthers.othersDetails,
      "contacto_numero":propertyOthers.contactNumber,
      "contacto_link":propertyOthers.contactLink,
      "plataforma_citas_link":propertyOthers.platformCitesLink
    };
  }
}
class PropertyCommunity{
  String id;
  bool church,playground,school,university,smallSquare,policeModule,
  publicSaunaPool,publicGym,sportCenter,postHealth,shoopingZone;
  String communityDetails;
  PropertyCommunity({
    required this.id,required this.church,required this.playground,
    required this.school,required this.university,
    required this.smallSquare,required this.policeModule,
    required this.publicSaunaPool,required this.publicGym,
    required this.sportCenter,required this.postHealth,
    required this.shoopingZone,
    required this.communityDetails
  });

  factory PropertyCommunity.empty(){
    return PropertyCommunity(
      id: "", church: false, playground: false,
      school:false,university: false,
      smallSquare: false,policeModule: false,
      publicSaunaPool: false,publicGym: false,
      sportCenter: false,postHealth: false,shoopingZone: false,
      communityDetails: ""
    );
  }
  factory PropertyCommunity.fromMap(Map<String,dynamic> mapData){
    return PropertyCommunity(
      id: mapData["id"],
      church: mapData["iglesia"], playground: mapData["parque_infantil"],
      school: mapData["escuela"],university: mapData["universidad"],
      smallSquare: mapData["plazuela"],policeModule: mapData["modulo_policial"],
      publicSaunaPool: mapData["sauna_piscina_publica"],publicGym: mapData["gym_publico"],
      sportCenter: mapData["centro_deportivo"],postHealth: mapData["puesto_salud"],
      shoopingZone: mapData["zona_comercial"],communityDetails: mapData["detalles_comunidad"]??""
    );
  }
  factory PropertyCommunity.copyWith(PropertyCommunity pc){
    return PropertyCommunity(
      id: pc.id, church: pc.church, playground: pc.playground, school: pc.school, 
      university: pc.university, smallSquare: pc.smallSquare, policeModule: pc.policeModule, 
      publicSaunaPool: pc.publicSaunaPool, publicGym: pc.publicGym, 
      sportCenter: pc.sportCenter, postHealth: pc.postHealth, shoopingZone: pc.shoopingZone,
      communityDetails: pc.communityDetails
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

class PropertyClientNote{
  String id;
  String note;
  String date;
  PropertyClientNote({
    required this.id,
    required this.note,
    required this.date,
  });
  factory PropertyClientNote.empty(){
    return PropertyClientNote(id: "", note: "",date: "");
  }
  factory PropertyClientNote.fromMap(Map<String,dynamic> data){
    return PropertyClientNote(
      id: data["id"]??"",
      note: data["nota"]??"",
      date: data["fecha"]??""
    );
  }
}