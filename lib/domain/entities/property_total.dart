import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';

class PropertyTotal{
  Property property;
  PropertyInternal propertyInternal;
  PropertyCommunity propertyCommunity;
  PropertyOthers propertyOthers;
  User creator;
  User owner;
  AdministratorRequest administratorRequest;
  UserPropertyFavorite userPropertyFavorite;
  PropertyTotal({
    required this.property,
    required this.propertyInternal,
    required this.propertyCommunity,
    required this.propertyOthers,
    required this.owner,
    required this.creator,
    required this.userPropertyFavorite,
    required this.administratorRequest,
  });

  factory PropertyTotal.fromMap(String tipoSesion,Map<String,dynamic> mapData){
    //print("map c ${mapData["creador"].toString()}");
    
    if(tipoSesion=="Comprar"||tipoSesion=="Observar"){
      //print("aque ${mapData["usuarios_favorito"]}");
      return PropertyTotal(
        property: Property.fromMap(mapData), 
        propertyInternal: PropertyInternal.fromMap(mapData),
        propertyCommunity: PropertyCommunity.fromMap(mapData),
        propertyOthers: PropertyOthers.fromMap(mapData),
        owner: User.fromMap(mapData["propietario"]),
        creator: User.fromMap(mapData["creador"]),
        userPropertyFavorite: mapData["usuarios_favorito"].length>0?
        UserPropertyFavorite.fromMap(mapData["usuarios_favorito"][0]):
        UserPropertyFavorite.empty(),
        administratorRequest: AdministratorRequest.empty());
    }else if(tipoSesion=="Administrar"){
      return PropertyTotal(
        property: Property.fromMap(mapData["inmueble"]), 
        propertyInternal: PropertyInternal.fromMap(mapData["inmueble"]),
        propertyCommunity: PropertyCommunity.fromMap(mapData["inmueble"]),
        propertyOthers: PropertyOthers.fromMap(mapData["inmueble"]),
        owner: User.fromMap(mapData["inmueble"]["propietario"]),
        creator: User.fromMap(mapData["inmueble"]["creador"]),
        userPropertyFavorite: UserPropertyFavorite.empty(),
        administratorRequest: AdministratorRequest.fromMap(mapData));
    }else if(tipoSesion=="Vender"){
      //print(mapData["comprobante"]);
      return PropertyTotal(
        property: Property.fromMap(mapData), 
        propertyInternal: PropertyInternal.fromMap(mapData),
        propertyCommunity: PropertyCommunity.fromMap(mapData),
        propertyOthers: PropertyOthers.fromMap(mapData),
        owner: mapData["propietario"]!=null?User.fromMap(mapData["propietario"]):User.empty(),
        creator: User.fromMap(mapData["creador"]),
        userPropertyFavorite: UserPropertyFavorite.empty(),
        administratorRequest: AdministratorRequest.empty());
    }else if(tipoSesion=="Supervisar"){
      /*if(mapData["inmueble"]["precio"]==160000){
        print(mapData["inmueble"]["comprobante"]);
      }*/
      return PropertyTotal(
        property: Property.fromMap(mapData["inmueble"]), 
        propertyInternal: PropertyInternal.fromMap(mapData["inmueble"]),
        propertyCommunity: PropertyCommunity.fromMap(mapData["inmueble"]),
        propertyOthers: PropertyOthers.fromMap(mapData["inmueble"]),
        owner: mapData["inmueble"]["propietario"]!=null?User.fromMap(mapData["inmueble"]["propietario"]):User.empty(),
        creator: User.fromMap(mapData["inmueble"]["creador"]),
        userPropertyFavorite: UserPropertyFavorite.empty(),
        administratorRequest: AdministratorRequest.fromMap(mapData));
    }
    return PropertyTotal.empty();
  }
  factory PropertyTotal.empty(){
    return PropertyTotal(property: Property.empty(), propertyInternal: PropertyInternal.empty(), 
    propertyCommunity: PropertyCommunity.empty(), propertyOthers: PropertyOthers.empty(), 
    owner: User.empty(),
    creator: User.empty(), userPropertyFavorite: UserPropertyFavorite.empty(),
    administratorRequest: AdministratorRequest.empty());
  }
  
  factory PropertyTotal.copyWith(PropertyTotal pt){
    return PropertyTotal(
      property: Property.copyWith(pt.property), 
      propertyInternal: PropertyInternal.copyWith(pt.propertyInternal), 
      propertyCommunity: PropertyCommunity.copyWith(pt.propertyCommunity), 
      propertyOthers: PropertyOthers.copyWith(pt.propertyOthers), 
      owner: User.copyWith(pt.owner), creator: User.copyWith(pt.creator), 
      userPropertyFavorite: UserPropertyFavorite.copyWith(pt.userPropertyFavorite), 
      administratorRequest: AdministratorRequest.copyWith(pt.administratorRequest)
    );
  }

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id_creador": this.creator.id,
      "id_propietario":this.owner.id,
      "id":this.property.id,
      "autorizacion":this.property.authorization,
      "ciudad":this.property.city,
      "zona":this.property.zoneName,
      "direccion":this.property.address,
      "coordenadas":this.property.coordinates,
      "precio":this.property.price,
      "tipo_inmueble":this.property.propertyType,
      "tipo_contrato":this.property.contractType,
      "estado_negociacion":this.property.negotiationStatus,
      "mascotas_permitidas":this.property.enablePets,
      "sin_hipoteca":this.property.noMortgage,
      "construccion_estrenar":this.property.newConstruction,
      "materiales_primera":this.property.premiumMaterials,
      "superficie_construccion":this.property.constructionSurface,
      "superficie_terreno":this.property.landSurface,
      "tamanio_frente":this.property.frontSize,
      "antiguedad_construccion":this.property.constructionAntiquity,
      "proyecto_preventa":this.property.preSaleProject,
      "inmueble_compartido":this.property.sharedProperty,
      "numero_duenios":this.property.ownersNumber,
      "servicios_basicos":this.property.basicServices,
      "gas_domiciliario":this.property.householdGas,
      "wifi":this.property.wifi,
      "medidor_independiente":this.property.independentMeter,
      "termotanque":this.property.hotWaterTank,
      "calle_asfaltada":this.property.pavedStreet,
      "transporte":this.property.transport,
      "preparado_discapacidad":this.property.disabilityPrepared,
      "papeles_orden":this.property.orderPapers,
      "habilitado_credito":this.property.enabledCredit,
      "detalles_generales":this.property.generalDetails,
      "modificaciones_permitidas":this.property.allowedUpdate,
      "contador_modificacion":this.property.counterUpdate,
      "plantas":this.propertyInternal.floorsNumber,
      "ambientes":this.propertyInternal.roomsNumber,
      "dormitorios":this.propertyInternal.bedroomsNumber,
      "banios":this.propertyInternal.bathroomsNumber,
      "garaje":this.propertyInternal.garagesNumber,
      "amoblado":this.propertyInternal.furnished,
      "lavanderia":this.propertyInternal.laundry,
      "cuarto_lavado":this.propertyInternal.laundryRoom,
      "churrasquero":this.propertyInternal.grill,
      "azotea":this.propertyInternal.rooftop,
      "condominio_privado":this.propertyInternal.privateCondominium,
      "cancha":this.propertyInternal.court,
      "piscina":this.propertyInternal.pool,
      "sauna":this.propertyInternal.sauna,
      "jacuzzi":this.propertyInternal.jacuzzi,
      "estudio":this.propertyInternal.studio,
      "jardin":this.propertyInternal.garden,
      "porton_electrico":this.propertyInternal.electricGate,
      "aire_acondicionado":this.propertyInternal.airConditioning,
      "calefaccion":this.propertyInternal.heating,
      "ascensor":this.propertyInternal.elevator,
      "deposito":this.propertyInternal.warehouse,
      "sotano":this.propertyInternal.basement,
      "balcon":this.propertyInternal.balcony,
      "tienda":this.propertyInternal.store,
      "amurallado_terreno":this.propertyInternal.landWalled,
      "detalles_internas":this.propertyInternal.internalDetails,
      "iglesia":this.propertyCommunity.church,
      "parque_infantil":this.propertyCommunity.playground,
      "escuela":this.propertyCommunity.school,
      "universidad":this.propertyCommunity.university,
      "plazuela":this.propertyCommunity.smallSquare,
      "modulo_policial":this.propertyCommunity.policeModule,
      "sauna_piscina_publica":this.propertyCommunity.publicSaunaPool,
      "gym_publico":this.propertyCommunity.publicGym,
      "centro_deportivo":this.propertyCommunity.sportCenter,
      "puesto_salud":this.propertyCommunity.postHealth,
      "zona_comercial":this.propertyCommunity.shoopingZone,
      "detalles_comunidad":this.propertyCommunity.communityDetails,
      "remates_judiciales":this.propertyOthers.judicialAuctions,
      "video_2D_link":this.propertyOthers.video2DLink,
      "tour_virtual_360_link":this.propertyOthers.tourVirtual360Link,
      "video_tour_360_link":this.propertyOthers.videoTour360Link,
      "contacto_numero":this.propertyOthers.contactNumber,
      "contacto_link":this.propertyOthers.contactLink,
      "plataforma_citas_link":this.propertyOthers.platformCitesLink,
      "detalles_otros":this.propertyOthers.othersDetails,
      "principales_imagenes":this.property.mapImages["principales"],
      "plantas_imagenes":this.property.mapImages["plantas"],
      "ambientes_imagenes":this.property.mapImages["ambientes"],
      "dormitorios_imagenes":this.property.mapImages["dormitorios"],
      "banios_imagenes":this.property.mapImages["banios"],
      "garaje_imagenes":this.property.mapImages["garaje"],
      "amoblado_imagenes":this.property.mapImages["amoblado"],
      "lavanderia_imagenes":this.property.mapImages["lavanderia"],
      "cuarto_lavado_imagenes":this.property.mapImages["cuarto_lavado"],
      "churrasquero_imagenes":this.property.mapImages["churrasquero"],
      "azotea_imagenes":this.property.mapImages["azotea"],
      "condominio_privado_imagenes":this.property.mapImages["condominio_privado"],
      "cancha_imagenes":this.property.mapImages["cancha"],
      "piscina_imagenes":this.property.mapImages["piscina"],
      "sauna_imagenes":this.property.mapImages["sauna"],
      "jacuzzi_imagenes":this.property.mapImages["jacuzzi"],
      "estudio_imagenes":this.property.mapImages["estudio"],
      "jardin_imagenes":this.property.mapImages["jardin"],
      "porton_electrico_imagenes":this.property.mapImages["porton_electrico"],
      "calefaccion_imagenes":this.property.mapImages["calefaccion"],
      "ascensor_imagenes":this.property.mapImages["ascensor"],
      "deposito_imagenes":this.property.mapImages["deposito"],
      "sotano_imagenes":this.property.mapImages["sotano"],
      "balcon_imagenes":this.property.mapImages["balcon"],
      "tienda_imagenes":this.property.mapImages["tienda"],
      "amurallado_terreno_imagenes":this.property.mapImages["amurallado_terreno"],
      "tipo_comprobante":this.administratorRequest.propertyVoucher.voucherType,
      "medio_pago":this.administratorRequest.propertyVoucher.paymentMedium,
      "monto_pago":this.administratorRequest.propertyVoucher.paymentAmount,
      "numero_transaccion":this.administratorRequest.propertyVoucher.transactionNumber,
      "id_cuenta_banco":this.administratorRequest.propertyVoucher.bankAccount.id,
      "nombre_depositante":this.administratorRequest.propertyVoucher.depositorName,
      "link_imagen_deposito":this.administratorRequest.propertyVoucher.depositImageLink,
      "link_imagen_documento_propiedad":this.administratorRequest.propertyVoucher.documentPropertyImageLink,
      "link_imagen_documento_venta":this.administratorRequest.propertyVoucher.documentSalesImageLink,
      "link_imagen_dni_propietario":this.administratorRequest.propertyVoucher.ownerDNIImageLink,
      "link_imagen_dni_agente":this.administratorRequest.propertyVoucher.agentDNIImageLink,
      "plan":this.administratorRequest.propertyVoucher.publicationPlanPayment.id
    };
  }
}