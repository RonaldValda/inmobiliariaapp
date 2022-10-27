import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inmobiliariaapp/ui/pages/utils/constants.dart';

class UserPropertyFavorite{
  String id="";
  String userId="";
  String propertyId="";
  bool favorite=false;
  bool viewed=false;
  bool viewedDouble=false;
  bool contacted=false;
  UserPropertyFavorite({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.favorite,
    required this.viewed,
    required this.viewedDouble,
    required this.contacted
  });

  
  factory UserPropertyFavorite.fromFireStore(DocumentSnapshot snapshot){
    return UserPropertyFavorite(
      id: snapshot.id,
      userId: snapshot["id_usuario"],
      propertyId: snapshot["id_inmueble"],
      favorite: snapshot["favorito"],
      viewed: snapshot["visto"],
      viewedDouble: snapshot["doble_visto"],
      contacted: snapshot["contactado"]
    );
  }
  factory UserPropertyFavorite.fromMap(Map<String,dynamic> snapshot){
    return UserPropertyFavorite(
      id: snapshot["id"],
      userId: "",
      propertyId: "",
      favorite: snapshot["favorito"],
      viewed: snapshot["visto"],
      viewedDouble: snapshot["doble_visto"],
      contacted: snapshot["contactado"]
    );
  }
  factory UserPropertyFavorite.empty(){
    return UserPropertyFavorite(
      id: "", userId: "",
      propertyId: "",
      favorite: false,
      viewed: false,
      viewedDouble: false,
      contacted: false);
  }
  factory UserPropertyFavorite.copyWith(UserPropertyFavorite upf){
    return UserPropertyFavorite(
      id: upf.id, userId: upf.userId, propertyId: upf.propertyId, 
      favorite: upf.favorite, viewed: upf.viewed, viewedDouble: upf.viewedDouble, contacted: upf.contacted
    );
  }

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id_usuario":this.userId,
      "id_inmueble":this.propertyId,
      "visto":this.viewed,
      "doble_visto":this.viewedDouble,
      "favorito":this.favorite,
      "contactado":this.contacted
    };
  }

}
class UserPropertyBase{
  String id;
  String type;
  int priceMin, priceMax;
  int bedroomsMin, bedroomsMax;
  int bathroomsMin, bathroomsMax;
  int garagesMin, garagesMax;
  int landSurfaceMin, landSurfaceMax;
  int constructionSurfaceMin,constructionSurfaceMax;
  int constructionAntiquityMin,constructionAntiquityMax;
  int propertiesQuantity,furnished,laundry,laundryRoom,grill, rooftop;
  int privateCondominium,court,pool,sauna,jacuzzi,studio;
  int garden,electricGate,airConditioning,heating;
  int elevator,warehouse,basement,balcony,store,landWalled;
  String startDate;
  String endDateSaved;
  String cacheDate;
  UserPropertyBase({
    required this.id,
    required this.type,
    required this.priceMin,required this.priceMax,
    required this.bedroomsMin, required this.bedroomsMax,
    required this.bathroomsMin,required this.bathroomsMax,
    required this.garagesMin,required this.garagesMax,
    required this.landSurfaceMin,required this.landSurfaceMax,
    required this.constructionSurfaceMin,required this.constructionSurfaceMax,
    required this.constructionAntiquityMin,required this.constructionAntiquityMax,
    required this.propertiesQuantity,
    required this.furnished,required this.laundry,required this.laundryRoom,
    required this.grill,required this.rooftop,required this.privateCondominium,
    required this.court,required this.pool,required this.sauna,required this.jacuzzi,
    required this.studio,required this.garden,required this.electricGate,
    required this.airConditioning,required this.heating,
    required this.elevator,required this.warehouse,required this.basement,
    required this.balcony,required this.store,required this.landWalled,
    required this.startDate,
    required this.endDateSaved,
    required this.cacheDate
  });
  List<PropertyBaseParameter> getParameters(String contractType){
    List<PropertyBaseParameter> parameters=[];
    parameters.add(PropertyBaseParameter(min: priceMin, max: priceMax,parameter: "price"));
    parameters.add(PropertyBaseParameter(min: bedroomsMin, max: bedroomsMax,parameter: "bedrooms"));
    parameters.add(PropertyBaseParameter(min: bathroomsMin, max: bathroomsMax,parameter: "bathrooms"));
    parameters.add(PropertyBaseParameter(min: garagesMin, max: garagesMax,parameter: "garages"));
    parameters.add(PropertyBaseParameter(min: constructionSurfaceMin, max: constructionSurfaceMax,parameter: "construction_surface"));
    parameters.add(PropertyBaseParameter(min: landSurfaceMin, max: landSurfaceMax,parameter: "land_surface"));
    parameters.add(PropertyBaseParameter(min: constructionAntiquityMin, max: constructionAntiquityMax,parameter: "construction_antiquity"));
    parameters.sort((b,a)=>a.getAverage(contractType).compareTo(b.getAverage(contractType)),);
    return parameters;
  }
  factory UserPropertyBase.fromMap(Map<String,dynamic> map){
    return UserPropertyBase(id: map["id"], 
      type: map["tipo"],
      bedroomsMin: map["dormitorios_min"], bedroomsMax: map["dormitorios_max"], 
      bathroomsMin: map["banios_min"],bathroomsMax: map["banios_max"], 
      garagesMin: map["garaje_min"],garagesMax: map["garaje_max"],
      landSurfaceMin:map["superficie_terreno_min"],landSurfaceMax:map["superficie_terreno_max"],
      constructionSurfaceMin: map["superficie_construccion_min"],constructionSurfaceMax: map["superficie_construccion_max"],
      constructionAntiquityMin: map["antiguedad_construccion_min"],constructionAntiquityMax: map["antiguedad_construccion_max"],
      priceMin: map["precio_min"],priceMax: map["precio_max"],
      propertiesQuantity: map["cantidad_inmuebles"],
      furnished: map["amoblado"],
      laundry: map["lavanderia"],
      laundryRoom: map["cuarto_lavado"],
      grill: map["churrasquero"],
      rooftop: map["azotea"],
      privateCondominium: map["condominio_privado"],
      court: map["cancha"],
      pool: map["piscina"],
      sauna: map["sauna"],
      jacuzzi: map["jacuzzi"],
      studio: map["estudio"],
      garden: map["jardin"],
      electricGate: map["porton_electrico"],
      airConditioning: map["aire_acondicionado"],
      heating: map["calefaccion"],
      elevator: map["ascensor"],
      warehouse: map["deposito"],
      basement: map["sotano"],
      balcony: map["balcon"],
      store: map["tienda"],
      landWalled: map["amurallado_terreno"],
      startDate: map["fecha_inicio"],
      endDateSaved: map["fecha_ultimo_guardado"],
      cacheDate: map["fecha_cache"]
    );
  }
  factory UserPropertyBase.empty(){
    return UserPropertyBase(id: "", 
    type: "",
    bedroomsMin: 0,bedroomsMax:0, bathroomsMin: 0,bathroomsMax:0, 
    garagesMin: 0,garagesMax: 0, landSurfaceMin: 0,landSurfaceMax: 0,
    constructionSurfaceMin: 0,constructionSurfaceMax: 0,
    constructionAntiquityMin: 0,constructionAntiquityMax: 0,
    priceMin: 0, priceMax: 0,
    propertiesQuantity: 0,furnished: 0,laundry: 0,
    laundryRoom: 0,grill: 0,rooftop: 0,
    privateCondominium: 0,court: 0,pool: 0,
    sauna: 0,jacuzzi: 0,studio: 0,garden: 0,
    electricGate: 0,airConditioning: 0,heating: 0,
    elevator: 0,warehouse: 0,basement: 0,balcony: 0,
    store: 0,landWalled: 0,
    startDate: "",
    cacheDate: "",
    endDateSaved: ""
    );
  }
  Map<String,dynamic> userPropertyBaseToMap(){
    return {
      "tipo":this.type,
      "dormitorios_min":this.bedroomsMin,"dormitorios_max":this.bedroomsMax,
      "banios_min":this.bathroomsMin,"banios_max":this.bathroomsMax,
      "garaje_min":this.garagesMin,"garaje_max":this.garagesMax,
      "superficie_terreno_min":this.landSurfaceMin,"superficie_terreno_max":this.landSurfaceMax,
      "superficie_construccion_min":this.constructionSurfaceMin,"superficie_construccion_max":this.constructionSurfaceMax,
      "antiguedad_construccion_min":this.constructionAntiquityMin,"antiguedad_construccion_max":this.constructionAntiquityMax,
      "precio_min":this.priceMin,"precio_max":this.priceMax,
      "cantidad_inmuebles":this.propertiesQuantity,"amoblado":this.furnished,
      "lavanderia":this.laundry,"cuarto_lavado":this.laundryRoom,
      "condominio_privado":this.privateCondominium,"cancha":this.court,
      "piscina":this.pool,"sauna":this.sauna,"jacuzzi":this.jacuzzi,
      "estudio":this.studio,"jardin":this.garden,"porton_electrico":this.electricGate,
      "aire_acondicionado":this.airConditioning,"calefaccion":this.heating,
      "ascensor":this.elevator,"deposito":this.warehouse,"sotano":this.basement,
      "balcon":this.balcony,"tienda":this.store,"amurallado_terreno":this.landWalled
    };
  }
  Map<String,dynamic> toMapFilter(){
    return <String,dynamic>{
      "bedrooms_min":this.bedroomsMin,"bedrooms_max":this.bedroomsMax,
      "bathroom_min":this.bathroomsMin,"bathroom_max":this.bathroomsMax,
      "garages_min":this.garagesMin,"garages_max":this.garagesMax,
      "land_surface_min":this.landSurfaceMin,"land_surface_max":this.landSurfaceMax,
      "construction_surface_min":this.constructionSurfaceMin,"construction_surface_max":this.constructionSurfaceMax,
      "construction_antiquity_min":this.constructionAntiquityMin,"construction_antiquity_max":this.constructionAntiquityMax,
      "price_min":this.priceMin,"price_max":this.priceMax,"start_date":this.startDate
    };
  }
  String get toText{
    return this.id+" dormitorios: "+
     this.bedroomsMin.toString()+" baños: "+
      this.bathroomsMin.toString()+" garaje: "+this.garagesMin.toString();
  }
  Map<String,dynamic> getMapRegisterPropertyBase(String userId,UserPropertyBase viewed,UserPropertyBase viewedDouble,UserPropertyBase favorite){
    Map<String,dynamic> mapDatos={
      "id_usuario":userId,
      "dormitorios_min_v":viewed.bedroomsMin,
      "dormitorios_max_v":viewed.bedroomsMax,
      "banios_min_v":viewed.bathroomsMin,
      "banios_max_v":viewed.bathroomsMax,
      "garaje_min_v":viewed.garagesMin,
      "garaje_max_v":viewed.garagesMax,
      "superficie_terreno_min_v":viewed.landSurfaceMin,
      "superficie_terreno_max_v":viewed.landSurfaceMax,
      "superficie_construccion_min_v":viewed.constructionSurfaceMin,
      "superficie_construccion_max_v":viewed.constructionSurfaceMax,
      "antiguedad_construccion_min_v":viewed.constructionAntiquityMin,
      "antiguedad_construccion_max_v":viewed.constructionAntiquityMax,
      "precio_min_v":viewed.priceMin,
      "precio_max_v":viewed.priceMax,
      "cantidad_inmuebles_v":viewed.propertiesQuantity,
      "amoblado_v":viewed.furnished,
      "lavanderia_v":viewed.laundry,
      "cuarto_lavado_v":viewed.laundryRoom,
      "churrasquero_v":viewed.grill,
      "azotea_v":viewed.rooftop,
      "condominio_privado_v":viewed.privateCondominium,
      "cancha_v":viewed.court,
      "piscina_v":viewed.pool,
      "sauna_v":viewed.sauna,
      "jacuzzi_v":viewed.jacuzzi,
      "estudio_v":viewed.studio,
      "jardin_v":viewed.garden,
      "porton_electrico_v":viewed.electricGate,
      "aire_acondicionado_v":viewed.airConditioning,
      "calefaccion_v":viewed.heating,
      "ascensor_v":viewed.elevator,
      "deposito_v":viewed.warehouse,
      "sotano_v":viewed.basement,
      "balcon_v":viewed.balcony,
      "tienda_v":viewed.store,
      "amurallado_terreno_vd":viewed.landWalled,
      "dormitorios_min_dv":viewedDouble.bedroomsMin,
      "dormitorios_max_dv":viewedDouble.bedroomsMax,
      "banios_min_dv":viewedDouble.bathroomsMin,
      "banios_max_dv":viewedDouble.bathroomsMax,
      "garaje_min_dv":viewedDouble.garagesMin,
      "garaje_max_dv":viewedDouble.garagesMax,
      "superficie_terreno_min_dv":viewedDouble.landSurfaceMin,
      "superficie_terreno_max_dv":viewedDouble.landSurfaceMax,
      "superficie_construccion_min_dv":viewedDouble.constructionSurfaceMin,
      "superficie_construccion_max_dv":viewedDouble.constructionSurfaceMax,
      "antiguedad_construccion_min_dv":viewedDouble.constructionAntiquityMin,
      "antiguedad_construccion_max_dv":viewedDouble.constructionAntiquityMax,
      "precio_min_dv":viewedDouble.priceMin,
      "precio_max_dv":viewedDouble.priceMax,
      "cantidad_inmuebles_dv":viewedDouble.propertiesQuantity,
      "amoblado_dv":viewedDouble.furnished,
      "lavanderia_dv":viewedDouble.laundry,
      "cuarto_lavado_dv":viewedDouble.laundryRoom,
      "churrasquero_dv":viewedDouble.grill,
      "azotea_dv":viewedDouble.rooftop,
      "condominio_privado_dv":viewedDouble.privateCondominium,
      "cancha_dv":viewedDouble.court,
      "piscina_dv":viewedDouble.pool,
      "sauna_dv":viewedDouble.sauna,
      "jacuzzi_dv":viewedDouble.jacuzzi,
      "estudio_dv":viewedDouble.studio,
      "jardin_dv":viewedDouble.garden,
      "porton_electrico_dv":viewedDouble.electricGate,
      "aire_acondicionado_dv":viewedDouble.airConditioning,
      "calefaccion_dv":viewedDouble.heating,
      "ascensor_dv":viewedDouble.elevator,
      "deposito_dv":viewedDouble.warehouse,
      "sotano_dv":viewedDouble.basement,
      "balcon_dv":viewedDouble.balcony,
      "tienda_dv":viewedDouble.store,
      "amurallado_terreno_dv":viewedDouble.landWalled,
      "dormitorios_min_f":favorite.bedroomsMin,
      "dormitorios_max_f":favorite.bedroomsMax,
      "banios_min_f":favorite.bathroomsMin,
      "banios_max_f":favorite.bathroomsMax,
      "garaje_min_f":favorite.garagesMin,
      "garaje_max_f":favorite.garagesMax,
      "superficie_terreno_min_f":favorite.landSurfaceMin,
      "superficie_terreno_max_f":favorite.landSurfaceMax,
      "superficie_construccion_min_f":favorite.constructionSurfaceMin,
      "superficie_construccion_max_f":favorite.constructionSurfaceMax,
      "antiguedad_construccion_min_f":favorite.constructionAntiquityMin,
      "antiguedad_construccion_max_f":favorite.constructionAntiquityMax,
      "precio_min_f":favorite.priceMin,
      "precio_max_f":favorite.priceMax,
      "cantidad_inmuebles_f":favorite.propertiesQuantity,
      "amoblado_f":favorite.furnished,
      "lavanderia_f":favorite.laundry,
      "cuarto_lavado_f":favorite.laundryRoom,
      "churrasquero_f":favorite.grill,
      "azotea_f":favorite.rooftop,
      "condominio_privado_f":favorite.privateCondominium,
      "cancha_f":favorite.court,
      "piscina_f":favorite.pool,
      "sauna_f":favorite.sauna,
      "jacuzzi_f":favorite.jacuzzi,
      "estudio_f":favorite.studio,
      "jardin_f":favorite.garden,
      "porton_electrico_f":favorite.electricGate,
      "aire_acondicionado_f":favorite.airConditioning,
      "calefaccion_f":favorite.heating,
      "ascensor_f":favorite.elevator,
      "deposito_f":favorite.warehouse,
      "sotano_f":favorite.basement,
      "balcon_f":favorite.balcony,
      "tienda_f":favorite.store,
      "amurallado_terreno_f":favorite.landWalled,
    };
    return mapDatos;
  }
}
class PropertyBaseParameter{
  int min;
  int max;
  String parameter;
  PropertyBaseParameter({
    required this.min,required this.max,required this.parameter
  });
  double getAverage(String contractType){
    double average=0.0;
    switch (parameter) {
      case "price":
        if(contractType=="Alquiler"){
          average=(max-min)/1000;
        }else if(contractType=="Anticrético"){
          average=(max-min)/10000;
        }else{
          average=(max-min)/100000;
        }
        break;
      case "construction_surface":
        average=(max-min)/200;
        break;
      case "land_surface":
        average=(max-min)/100;
        break;
      case "construction_antiquity":
        average=(max-min)/10;
        break;
      default:
        average=(max-min)/20;
        break;
    }
    return average;
  }
}
class UserPropertySearched{
  String id;
  int foundQuantity;
  String configurationName,phoneNumber;
  String contractType,propertyType,city,zone;
  int priceMin, priceMax;
  int floorsNumber,roomsNumber,bedroomsNumber,bathroomsNumber,garagesNumber;
  int landSurfaceMin, landSurfaceMax;
  int constructionSurfaceMin,constructionSurfaceMax;
  int constructionAntiquityMin,constructionAntiquityMax;
  int frontSizeMin,frontSizeMax;
  bool enablePets,noMortgage,newConstruction,premiumMaterials;
  bool preSaleProject,sharedProperty;
  int ownersNumber;
  bool basicServices,householdGas,wifi,independentMeter,hotWaterTank,pavedStreet,transport,disabilityPrepared,orderPapers, enabledCredit;
  bool furnished,laundry,laundryRoom,grill,rooftop;
  bool privateCondominium,court,pool,sauna,jacuzzi,studio;
  bool garden,electricGate,airConditioning,heating;
  bool elevator,warehouse,basement,balcony,store,landWalled;
  bool church,playground,school,university,smallSquare,policeModule,publicSaunaPool,publicGym,sportCenter,postHeath,shoopingZone;
  bool judicialAuctions, video2DLink, tourVirtual360Link, videoTour360Link;

  UserPropertySearched({
    required this.id,
    required this.foundQuantity,
    required this.configurationName,required this.phoneNumber,
    required this.contractType,required this.propertyType,
    required this.city,required this.zone,
    required this.priceMin,required this.priceMax,
    required this.floorsNumber, required this.roomsNumber,
    required this.bedroomsNumber, required this.bathroomsNumber,
    required this.garagesNumber,
    required this.landSurfaceMin, required this.landSurfaceMax,
    required this.constructionSurfaceMin, required this.constructionSurfaceMax,
    required this.constructionAntiquityMin,required this.constructionAntiquityMax,
    required this.frontSizeMin,required this.frontSizeMax,
    required this.enablePets,required this.noMortgage,required this.newConstruction,
    required this.premiumMaterials, required this.preSaleProject,
    required this.sharedProperty,required this.ownersNumber,
    required this.basicServices, required this.householdGas,required this.wifi,
    required this.independentMeter,required this.hotWaterTank,
    required this.pavedStreet,required this.transport,
    required this.disabilityPrepared,required this.orderPapers,
    required this.enabledCredit,
    required this.furnished,required this.laundry,required this.laundryRoom,
    required this.grill,required this.rooftop,required this.privateCondominium,
    required this.court,required this.pool,required this.sauna,required this.jacuzzi,
    required this.studio,required this.garden,required this.electricGate,
    required this.airConditioning, required this.heating,
    required this.elevator, required this.warehouse, required this.basement,
    required this.balcony,required this.store,required this.landWalled,
    required this.church,required this.playground,required this.school,
    required this.university,required this.smallSquare,required this.policeModule,
    required this.publicSaunaPool, required this.publicGym,required this.sportCenter,
    required this.postHeath,required this.shoopingZone,
    required this.judicialAuctions,
    required this.video2DLink,required this.tourVirtual360Link,required this.videoTour360Link
  });

  factory UserPropertySearched.fromMap(Map<String,dynamic> map){
    return UserPropertySearched(
      id:map["id"]??"",
      foundQuantity: 0,
      configurationName:map["nombre_configuracion"]??"",
      phoneNumber: map["numero_telefono"]??"",
      contractType: map["tipo_contrato"]??"",
      propertyType: map["tipo_inmueble"]??"",
      priceMin: map["precio_min"]??0,
      priceMax: map["precio_max"],
      city: map["ciudad"]??"",
      zone: map["zona"]??"",
      roomsNumber: map["ambientes"]??0,
      floorsNumber: map["plantas"]??0,
      bedroomsNumber: map["dormitorios"]??0,
      bathroomsNumber: map["banios"]??0,
      garagesNumber: map["garaje"]??0,
      landSurfaceMin: map["superficie_terreno_min"]??0,
      landSurfaceMax: map["superficie_terreno_max"]??0,
      constructionSurfaceMin: map["superficie_construccion_min"]??0,
      constructionSurfaceMax: map["superficie_construccion_max"]??0,
      constructionAntiquityMin: map["antiguedad_construccion_min"]??0,
      constructionAntiquityMax: map["antiguedad_construccion_max"]??0,
      frontSizeMin: map["tamanio_frente_min"]??0,
      frontSizeMax: map["tamanio_frente_max"]??0,
      enablePets: map["mascotas_permitidas"]??false,
      noMortgage: map["sin_hipoteca"]??false,
      newConstruction: map["construccion_estrenar"]??false,
      premiumMaterials: map["materiales_primera"]??false,
      preSaleProject: map["proyecto_preventa"]??false,
      sharedProperty: map["inmueble_compartido"]??false,
      ownersNumber: map["numero_duenios"]??1,
      basicServices: map["servicios_basicos"]??false,
      householdGas: map["gas_domiciliario"]??false,
      wifi: map["wifi"],
      independentMeter: map["medidor_independiente"]??false,
      hotWaterTank: map["termotanque"]??false,
      pavedStreet: map["calle_asfaltada"]??false,
      transport: map["transporte"]??false,
      disabilityPrepared: map["preparado_discapacidad"]??false,
      orderPapers: map["papeles_orden"]??false,
      enabledCredit: map["habilitado_credito"]??false,
      furnished: map["amoblado"]??false,
      laundry: map["lavanderia"]??false,
      laundryRoom: map["cuarto_lavado"]??false,
      grill: map["churrasquero"]??false,
      rooftop: map["azotea"]??false,
      privateCondominium: map["condominio_privado"]??false,
      court: map["cancha"]??false,
      pool: map["piscina"]??false,
      sauna: map["sauna"]??false,
      jacuzzi: map["jacuzzi"]??false,
      studio: map["estudio"]??false,
      garden: map["jardin"]??false,
      electricGate: map["porton_electrico"]??false,
      airConditioning: map["aire_acondicionado"]??false,
      heating: map["calefaccion"]??false,
      elevator: map["ascensor"]??false,
      warehouse: map["deposito"]??false,
      basement: map["sotano"]??false,
      balcony: map["balcon"]??false,
      store: map["tienda"]??false,
      landWalled: map["amurallado_terreno"]??false,
      church: map["iglesia"]??false,
      playground: map["parque_infantil"]??false,
      school: map["escuela"]??false,
      university: map["universidad"]??false,
      smallSquare: map["plazuela"]??false,
      policeModule: map["modulo_policial"]??false,
      publicSaunaPool: map["sauna_piscina_publica"]??false,
      publicGym: map["gym_publico"]??false,
      sportCenter: map["centro_deportivo"]??false,
      postHeath: map["puesto_salud"]??false,
      shoopingZone: map["zona_comercial"]??false,
      judicialAuctions: map["remates_judiciales"]??false,
      video2DLink: map["video_2D"]??false,
      tourVirtual360Link: map["tour_virtual_360"]??false,
      videoTour360Link: map["video_tour_360"]??false
    );
  }
  factory UserPropertySearched.fromMap2(UserPropertySearched searched,Map<String,dynamic> map){
    return UserPropertySearched(
      id:searched.id,
      foundQuantity: searched.foundQuantity,
      configurationName:searched.configurationName,
      phoneNumber: searched.phoneNumber,
      contractType: map["contract_type"],
      propertyType: map["property_type"],
      priceMin: map["price_min"],
      priceMax: map["price_max"],
      city: map["city"],
      zone: map["zone"],
      roomsNumber: map["rooms_number"],
      floorsNumber: map["floors_number"],
      bedroomsNumber: map["bedrooms_number"],
      bathroomsNumber: map["bathrooms_number"],
      garagesNumber: map["garages_number"],
      landSurfaceMin: map["land_surface_min"],
      landSurfaceMax: map["land_surface_max"],
      constructionSurfaceMin: map["construction_surface_min"],
      constructionSurfaceMax: map["construction_surface_max"],
      constructionAntiquityMin: map["construction_antiquity_min"],
      constructionAntiquityMax: map["construction_antiquity_max"],
      frontSizeMin: map["front_size_min"],
      frontSizeMax: map["front_size_max"],
      enablePets: map["enable_pets"],
      noMortgage: map["no_mortgage"],
      newConstruction: map["new_construction"],
      premiumMaterials: map["premium_materials"],
      preSaleProject: map["pre_sale_project"],
      sharedProperty: map["shared_property"],
      ownersNumber: map["owners_number"],
      basicServices: map["basic_services"],
      householdGas: map["household_gas"],
      wifi: map["wifi"],
      independentMeter: map["independent_meter"],
      hotWaterTank: map["hot_water_tank"],
      pavedStreet: map["paved_street"],
      transport: map["transport"],
      disabilityPrepared: map["disability_prepared"],
      orderPapers: map["order_papers"],
      enabledCredit: map["enabled_credit"],
      furnished: map["furnished"],
      laundry: map["laundry"],
      laundryRoom: map["laundry_room"],
      grill: map["grill"],
      rooftop: map["rooftop"],
      privateCondominium: map["private_condominium"],
      court: map["court"],
      pool: map["pool"],
      sauna: map["sauna"],
      jacuzzi: map["jacuzzi"],
      studio: map["studio"],
      garden: map["garden"],
      electricGate: map["electric_gate"],
      airConditioning: map["air_conditioning"],
      heating: map["heating"],
      elevator: map["elevator"],
      warehouse: map["warehouse"],
      basement: map["basement"],
      balcony: map["balcony"],
      store: map["store"],
      landWalled: map["land_walled"],
      church: map["church"],
      playground: map["playground"],
      school: map["school"],
      university: map["university"],
      smallSquare: map["small_square"],
      policeModule: map["police_module"],
      publicSaunaPool: map["public_sauna_pool"],
      publicGym: map["public_gym"],
      sportCenter: map["sport_center"],
      postHeath: map["post_health"],
      shoopingZone: map["shooping_zone"],
      judicialAuctions: map["judicial_auctions"],
      video2DLink: map["video_2D"],
      tourVirtual360Link: map["tour_virtual_360"],
      videoTour360Link: map["video_tour_360"]
    );
  }
  factory UserPropertySearched.empty(){
    return UserPropertySearched(
      id: "",foundQuantity: 0, 
      configurationName: "", phoneNumber: "",
      contractType: "",propertyType: "", 
      city: "", zone: "", priceMin: 0, priceMax: 0, 
      floorsNumber: 0, roomsNumber: 0, bedroomsNumber: 0, bathroomsNumber: 0, garagesNumber: 0, 
      landSurfaceMin: 0, landSurfaceMax: 0, 
      constructionSurfaceMin: 0, constructionSurfaceMax: 0, 
      constructionAntiquityMin: 0, constructionAntiquityMax: 0, 
      frontSizeMin: 0, frontSizeMax: 0, enablePets: false, 
      noMortgage: false, newConstruction: false, premiumMaterials: false,
      preSaleProject: false, sharedProperty: false, ownersNumber: 1, 
      basicServices: false, householdGas: false, wifi: false, 
      independentMeter: false, hotWaterTank: false, pavedStreet: false, 
      transport: false, disabilityPrepared: false, orderPapers: false, 
      enabledCredit: false, furnished: false, laundry: false, laundryRoom: false, 
      grill: false, rooftop: false, privateCondominium: false, court: false, 
      pool: false, sauna: false, jacuzzi: false, studio: false, garden: false, 
      electricGate: false, airConditioning: false, heating: false, 
      elevator: false, warehouse: false, basement: false, balcony: false, store: false, 
      landWalled: false, church: false, playground: false, school: false, 
      university: false, smallSquare: false, policeModule: false, 
      publicSaunaPool: false, publicGym: false, sportCenter: false, 
      postHeath: false, shoopingZone: false, judicialAuctions: false, 
      video2DLink: false, tourVirtual360Link: false, 
      videoTour360Link: false
    );
  }
  factory UserPropertySearched.copyWith(UserPropertySearched u){
    return UserPropertySearched(
      id: u.id, foundQuantity: u.foundQuantity,
      configurationName: u.configurationName, 
      phoneNumber: u.phoneNumber, contractType: u.contractType, 
      propertyType: u.propertyType, city: u.city, zone: u.zone, 
      priceMin: u.priceMin, priceMax: u.priceMax, floorsNumber: u.floorsNumber, 
      roomsNumber: u.roomsNumber, bedroomsNumber: u.bedroomsNumber, bathroomsNumber: u.bathroomsNumber, 
      garagesNumber: u.garagesNumber, landSurfaceMin: u.landSurfaceMin, 
      landSurfaceMax: u.landSurfaceMax, 
      constructionSurfaceMin: u.constructionSurfaceMin, 
      constructionSurfaceMax: u.constructionSurfaceMax, 
      constructionAntiquityMin: u.constructionAntiquityMin, 
      constructionAntiquityMax: u.constructionAntiquityMax, 
      frontSizeMin: u.frontSizeMin, frontSizeMax: u.frontSizeMax, 
      enablePets: u.enablePets, noMortgage: u.noMortgage, 
      newConstruction: u.newConstruction, 
      premiumMaterials: u.premiumMaterials, preSaleProject: u.preSaleProject, 
      sharedProperty: u.sharedProperty, ownersNumber: u.ownersNumber, 
      basicServices: u.basicServices, householdGas: u.householdGas, 
      wifi: u.wifi, independentMeter: u.independentMeter, 
      hotWaterTank: u.hotWaterTank, pavedStreet: u.pavedStreet, 
      transport: u.transport, disabilityPrepared: u.disabilityPrepared, 
      orderPapers: u.orderPapers, enabledCredit: u.enabledCredit, 
      furnished: u.furnished, laundry: u.laundry, laundryRoom: u.laundryRoom, 
      grill: u.grill, rooftop: u.rooftop, privateCondominium: u.privateCondominium, 
      court: u.court, pool: u.pool, sauna: u.sauna, jacuzzi: u.jacuzzi, 
      studio: u.studio, garden: u.garden, electricGate: u.electricGate, 
      airConditioning: u.airConditioning, heating: u.heating, elevator: u.elevator, 
      warehouse: u.warehouse, basement: u.basement, balcony: u.balcony, store: u.store, 
      landWalled: u.landWalled, church: u.church, 
      playground: u.playground, school: u.school, university: u.university, 
      smallSquare: u.smallSquare, policeModule: u.policeModule, 
      publicSaunaPool: u.publicSaunaPool, publicGym: u.publicGym, 
      sportCenter: u.sportCenter, postHeath: u.postHeath, 
      shoopingZone: u.shoopingZone, judicialAuctions: u.judicialAuctions, 
      video2DLink: u.video2DLink, tourVirtual360Link: u.tourVirtual360Link, 
      videoTour360Link: u.videoTour360Link
    );
  }



  Map<String,dynamic> toMap(){
    return {
      "id":this.id,
      "nombre_configuracion":this.configurationName,"numero_telefono":this.phoneNumber,
      "tipo_contrato":this.contractType,"tipo_inmueble":this.propertyType,
      "ciudad":this.city,"zona":this.zone,
      "precio_min":this.priceMin,"precio_max":this.priceMax,
      "ambientes":this.roomsNumber,"plantas":this.floorsNumber,
      "dormitorios":this.bedroomsNumber,"banios":this.bathroomsNumber,
      "garaje":this.garagesNumber,
      "superficie_terreno_min":this.landSurfaceMin,"superficie_terreno_max":this.landSurfaceMax,
      "superficie_construccion_min":this.constructionSurfaceMin,"superficie_construccion_max":this.constructionSurfaceMax,
      "antiguedad_construccion_min":this.constructionAntiquityMin,"antiguedad_construccion_max":this.constructionAntiquityMax,
      "tamanio_frente_min":this.frontSizeMin,"tamanio_frente_max":this.frontSizeMax,
      "mascotas_permitidas":this.enablePets,"sin_hipoteca":this.noMortgage,
      "construccion_estrenar":this.newConstruction,"materiales_primera":this.premiumMaterials,
      "proyecto_preventa":this.preSaleProject,"inmueble_compartido":this.sharedProperty,
      "numero_duenios":this.ownersNumber,"servicios_basicos":this.basicServices,
      "gas_domiciliario":this.householdGas,"wifi":this.wifi,
      "medidor_independiente":this.independentMeter,"termotanque":this.hotWaterTank,
      "calle_asfaltada":this.pavedStreet,"transporte":this.transport,
      "preparado_discapacidad":this.disabilityPrepared,"papeles_orden":this.orderPapers,
      "habilitado_credito":this.enabledCredit,
      "amoblado":this.furnished,
      "lavanderia":this.laundry,"cuarto_lavado":this.laundryRoom,
      "churrasquero":this.grill,"azotea":this.rooftop,
      "condominio_privado":this.privateCondominium,"cancha":this.court,
      "piscina":this.pool,"sauna":this.sauna,"jacuzzi":this.jacuzzi,
      "estudio":this.studio,"jardin":this.garden,"porton_electrico":this.electricGate,
      "aire_acondicionado":this.airConditioning,"calefaccion":this.heating,
      "ascensor":this.elevator,"deposito":this.warehouse,"sotano":this.basement,
      "balcon":this.balcony,"tienda":this.store,"amurallado_terreno":this.landWalled,
      "iglesia":this.church,"parque_infantil":this.playground,"escuela":this.school,
      "universidad":this.university,"plazuela":this.smallSquare,"modulo_policial":this.policeModule,
      "sauna_piscina_publica":this.publicSaunaPool,"gym_publico":this.publicGym,
      "centro_deportivo":this.sportCenter,"puesto_salud":this.postHeath,
      "zona_comercial":this.shoopingZone,"remates_judiciales":this.judicialAuctions,
      "video_2D":this.video2DLink,"tour_virtual_360":this.tourVirtual360Link,
      "video_tour_360":this.videoTour360Link
    };
  }
  
  Map<String,dynamic> toMapFilterGeneral(){
    return {
      "land_surface_min":this.landSurfaceMin,"land_surface_max":this.landSurfaceMax,
      "land_surface_sel":_selectValueSel(Constants.valuesLandSurfaces, Constants.landSurfaces, this.landSurfaceMin, this.landSurfaceMax),
      "construction_surface_min":this.constructionSurfaceMin,"construction_surface_max":this.constructionSurfaceMax,
      "construction_surface_sel":_selectValueSel(Constants.valuesConstructionSurfaces, Constants.constructionSurfaces, this.constructionSurfaceMin, this.constructionSurfaceMax),
      "front_size_min":this.frontSizeMin,"front_size_max":this.frontSizeMax,
      "front_size_sel":_selectValueSel(Constants.valuesFrontSizes, Constants.frontSizes, this.frontSizeMin, this.frontSizeMax),
      "construction_antiquity_min":this.constructionAntiquityMin,"construction_antiquity_max":this.constructionAntiquityMax,
      "construction_antiquity_sel":_selectValueSel(Constants.valuesConstructionAntiquitys, Constants.constructionAntiquitys, this.constructionAntiquityMin, this.constructionSurfaceMax),
    };
  }
  Map<String,dynamic> toMapFilterGeneralPlus(){
    return {
      "enable_pets":this.enablePets,"no_mortgage":this.noMortgage,"new_construction":this.newConstruction,"premium_materials":this.premiumMaterials,
      "pre_sale_project":this.preSaleProject,"shared_property":this.sharedProperty,"owners_number":this.ownersNumber,"basic_services":this.basicServices,
      "household_gas":this.householdGas,"wifi":this.wifi,"independent_meter":this.independentMeter,"hot_water_tank":this.hotWaterTank,"paved_street":this.pavedStreet,
      "transport":this.transport,"disability_prepared":this.disabilityPrepared,"order_papers":this.orderPapers,"enabled_credit":this.enabledCredit,
    };
  }

  Map<String,dynamic> toMapFilterInternal(){
    return {
      "floors_number":this.floorsNumber,"rooms_number":this.roomsNumber,"bedrooms_number":this.bedroomsNumber,"bathrooms_number":this.bathroomsNumber,"garages_number":this.garagesNumber
    };
  }

  Map<String,dynamic> toMapFilterInternalPlus(){
    return {
      "furnished":this.furnished,"laundry":this.laundry,"laundry_room":this.laundryRoom,"grill":this.grill,"rooftop":this.rooftop,"private_condominium":this.privateCondominium,
      "court":this.court,"pool":this.pool,"sauna":this.sauna,"jacuzzi":this.jacuzzi,"studio":this.studio,"garden":this.garden,"electric_gate":this.electricGate,
      "air_conditioning":this.airConditioning,"heating":this.heating,"elevator":this.elevator,"warehouse":this.warehouse,"basement":this.basement,
      "balcony":this.balcony,"store":this.store,"land_walled":this.landWalled
    };
  }

  Map<String,dynamic> toMapFilterCommunity(){
    return {
      "church":this.church,"playground":this.playground,"school":this.school,"university":this.university,"small_square":this.smallSquare
    };
  }
  Map<String,dynamic> toMapFilterCommunityPlus(){
    return {
      "police_module":this.policeModule,"public_sauna_pool":this.publicSaunaPool,"public_gym":this.publicGym,
      "sport_center":this.sportCenter,"post_health":this.postHeath,"shooping_zone":this.shoopingZone
    };
  }

  Map<String,dynamic> toMapFilterOthersPlus(){
    return {
      "judicial_auctions":this.judicialAuctions,
      "video_2D":this.video2DLink,
      "tour_virtual_360":this.tourVirtual360Link,
      "video_tour_360":this.videoTour360Link,
    };
  }

  Map<String,dynamic> toMapFilterMain(){
    return {
      "property_type":this.propertyType,
      "contract_type":this.contractType,
      "price_min":this.priceMin,
      "price_max":this.priceMax,
      "price_sel":this.contractType=="Venta"
      ?_selectValueSel(Constants.valuesSalePrices,Constants.salePrices,this.priceMin, this.priceMax)
      :this.contractType=="Alquiler"
      ?_selectValueSel(Constants.valuesRentalPrices,Constants.rentalPrices,this.priceMin, this.priceMax)
      :_selectValueSel(Constants.valuesAnticreticPrices,Constants.anticreticPrices,this.priceMin, this.priceMax)
    };
  }

  Map<String,dynamic> toMapFilterAll(){
    Map<String,dynamic> map={};
    map.addAll(toMapFilterGeneral());
    map.addAll(toMapFilterGeneralPlus());
    map.addAll(toMapFilterInternal());
    map.addAll(toMapFilterInternalPlus());
    map.addAll(toMapFilterCommunity());
    map.addAll(toMapFilterCommunityPlus());
    map.addAll(toMapFilterOthersPlus());
    map.addAll(toMapFilterMain());
    return map;
  }

  String _selectValueSel(List<List<int>> itemsValues,List<String> items,int min,int max){
    int index=itemsValues.lastIndexWhere((element) => element[0]==min&&element[1]==max);
    return items[index<0?0:index];
  }

  Map<String,dynamic> toMapFilter(){
    return {
     // "id":this.id,
     // "configuration_name":this.configurationName,"phone_number":this.pavedStreet,
      "contract_type":this.contractType,"property_type":this.propertyType,
      "city":this.city,"zone":this.zone,
      "price_min":this.priceMin,"price_max":this.priceMax,
      "rooms_number":this.roomsNumber,"floors_number":this.floorsNumber,
      "bedrooms_number":this.bedroomsNumber,"bathrooms_number":this.bathroomsNumber,
      "garages":this.garagesNumber,
      "land_surface_min":this.landSurfaceMin,"land_surface_max":this.landSurfaceMax,
      "construction_surface_min":this.constructionSurfaceMin,"construction_surface_max":this.constructionSurfaceMax,
      "construction_antiquity_min":this.constructionAntiquityMin,"construction_antiquity_max":this.constructionAntiquityMax,
      "front_size_min":this.frontSizeMin,"front_size_max":this.frontSizeMax,
      "enable_pets":this.enablePets,"no_mortgage":this.noMortgage,
      "new_construction":this.newConstruction,"premium_materials":this.premiumMaterials,
      "pre_sale_project":this.preSaleProject,"shared_property":this.sharedProperty,
      "owners_number":this.ownersNumber,"basic_services":this.basicServices,
      "household_gas":this.householdGas,"wifi":this.wifi,
      "independent_meter":this.independentMeter,"hot_water_tank":this.hotWaterTank,
      "paved_street":this.pavedStreet,"transport":this.transport,
      "disability_prepared":this.disabilityPrepared,"order_papers":this.orderPapers,
      "enabled_credit":this.enabledCredit,
      "furnished":this.furnished,
      "laundry":this.laundry,"laundry_room":this.laundryRoom,
      "grill":this.grill,"rooftop":this.rooftop,
      "private_condominium":this.privateCondominium,"court":this.court,
      "pool":this.pool,"sauna":this.sauna,"jacuzzi":this.jacuzzi,
      "studio":this.studio,"garden":this.garden,"electric_gate":this.electricGate,
      "air_conditioning":this.airConditioning,"heating":this.heating,
      "elevator":this.elevator,"warehouse":this.warehouse,"basement":this.basement,
      "balcony":this.balcony,"store":this.store,"land_walled":this.landWalled,
      "church":this.church,"playground":this.playground,"school":this.school,
      "university":this.university,"small_square":this.smallSquare,"police_module":this.policeModule,
      "public_sauna_pool":this.publicSaunaPool,"public_gym":this.publicGym,
      "sport_center":this.sportCenter,"post_health":this.postHeath,
      "shooping_zone":this.shoopingZone,"juditial_auctions":this.judicialAuctions,
      "video_2D":this.video2DLink,"tour_virtual_360":this.tourVirtual360Link,
      "video_tour_360":this.videoTour360Link
    };
  }
}