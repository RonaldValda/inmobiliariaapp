
import 'dart:math';

import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_others_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';

List<PropertyTotal> updateListPropertyTotal(List<PropertyTotal> propertiesTotal,PropertyTotal propertyTotal,String action){
  List<PropertyTotal> propertiesTotalAux=[];
  propertiesTotalAux.addAll(propertiesTotal);
  if(propertiesTotalAux.length>0){
    if(action.toLowerCase()=="insertar"){
      propertiesTotalAux.add(propertyTotal);
    }else if(action.toLowerCase()=="modificar"){
      propertiesTotalAux.removeWhere((element) => element.property.index==propertyTotal.property.index);
      propertiesTotalAux.add(propertyTotal);
    }else if(action.toLowerCase()=="eliminar"){
      propertiesTotalAux.removeWhere((element) => element.property.index==propertyTotal.property.index);
    }
    
  }
  return propertiesTotalAux;
}

List<PropertyTotal> filterProperties(List<PropertyTotal> propertiesTotal,Map<String,dynamic> mapFilter){
  propertiesTotal.removeWhere((element) => element.property.mapImages["principales"].length<3);
  List<PropertyTotal> propertiesTotalAux=[];
  propertiesTotalAux.addAll(propertiesTotal);
  if(mapFilter["session_type"]!="Comprar"){
    if(mapFilter["start_date"]!=null&&mapFilter["start_date"]!=""){
      try{
        propertiesTotalAux.removeWhere((element) => (DateTime.parse(element.property.lastUpdate).difference(DateTime.parse(mapFilter["start_date"].toString())).inSeconds>0));
      }catch(e){}
    }
  }
  if(mapFilter["penultimate_entry_date"]!=null){
    propertiesTotalAux.removeWhere((element) => (DateTime.parse(element.property.publicationDate).difference(DateTime.parse(mapFilter["penultimate_entry_date"].toString())).inSeconds<0));
  }
  
  if(mapFilter["price_min"]!=null){
    if(mapFilter["price_min"]>0&&mapFilter["price_max"]>0&&propertiesTotalAux.length>0){
      propertiesTotalAux.removeWhere((element) => element.property.price<mapFilter["price_min"]);
    }
    if(mapFilter["price_min"]<mapFilter["price_max"]){
      propertiesTotalAux.removeWhere((element) => element.property.price>mapFilter["price_max"]);
    }
  }
  
  if(mapFilter["contract_type"]!=null&&mapFilter["contract_type"]!="Todos"&&propertiesTotalAux.length>0){
      propertiesTotalAux.removeWhere((element) => element.property.contractType!=mapFilter["contract_type"]);
  }
  if(mapFilter["property_type"]!=null&&mapFilter["property_type"]!="Todos"&&propertiesTotalAux.length>0){
      propertiesTotalAux.removeWhere((element) => element.property.propertyType!=mapFilter["property_type"]);
  }
  if(mapFilter["zone"]!=null&&mapFilter["zone"]!="Cualquiera"){
    propertiesTotalAux.removeWhere((element) => element.property.zoneName!=mapFilter["zone"]);
  }
  if(mapFilter["enable_pets"]!=null&&mapFilter["enable_pets"]){
    propertiesTotalAux.removeWhere((element) => !element.property.enablePets);
  }
  if(mapFilter["no_mortgage"]!=null&&mapFilter["no_mortgage"]){
    propertiesTotalAux.removeWhere((element) => !element.property.noMortgage);
  }
  if(mapFilter["new_construction"]!=null&&mapFilter["new_construction"]){
    propertiesTotalAux.removeWhere((element) => !element.property.newConstruction);
  }
  if(mapFilter["premium_materials"]!=null&&mapFilter["premium_materials"]){
    propertiesTotalAux.removeWhere((element) => !element.property.premiumMaterials);
  }
  if(mapFilter["land_surface_min"]!=null){
    if(mapFilter["land_surface_min"]>0&&mapFilter["land_surface_max"]>0){
      propertiesTotalAux.removeWhere((element) => element.property.landSurface<mapFilter["land_surface_min"]);
    }
    if(mapFilter["land_surface_min"]<mapFilter["land_surface_max"]){
      propertiesTotalAux.removeWhere((element) => element.property.landSurface>mapFilter["land_surface_max"]);
    }
  }
  if(mapFilter["construction_surface_min"]!=null){
    if(mapFilter["construction_surface_min"]>0&&mapFilter["construction_surface_max"]>0){
      propertiesTotalAux.removeWhere((element) => element.property.constructionSurface<mapFilter["construction_surface_min"]);
    }
    if(mapFilter["construction_surface_min"]<mapFilter["construction_surface_max"]){
      propertiesTotalAux.removeWhere((element) => element.property.constructionSurface>mapFilter["construction_surface_max"]);
    }
  }
  if(mapFilter["construction_antiquity_min"]!=null){
    if(mapFilter["construction_antiquity_min"]>0&&mapFilter["construction_antiquity_max"]>0){
      propertiesTotalAux.removeWhere((element) => element.property.constructionAntiquity<mapFilter["construction_antiquity_min"]);
    }
    if(mapFilter["construction_antiquity_min"]<mapFilter["construction_antiquity_max"]){
      propertiesTotalAux.removeWhere((element) => element.property.constructionAntiquity>mapFilter["construction_antiquity_max"]);
    }
  }
  if(mapFilter["front_size_min"]!=null){
    if(mapFilter["front_size_min"]>0&&mapFilter["front_size_max"]>0){
      propertiesTotalAux.removeWhere((element) => element.property.frontSize<mapFilter["front_size_min"]);
    }
    if(mapFilter["front_size_min"]<mapFilter["front_size_max"]){
      propertiesTotalAux.removeWhere((element) => element.property.frontSize>mapFilter["front_size_max"]);
    }
  }
  if(mapFilter["pre_sale_project"]!=null&&mapFilter["pre_sale_project"]){
    propertiesTotalAux.removeWhere((element) => !element.property.preSaleProject);
  }
  if(mapFilter["shared_property"]!=null){
    if(mapFilter["shared_property"]){
      propertiesTotalAux.removeWhere((element) => !element.property.sharedProperty);
      if(mapFilter["owners_number"]>0){
        propertiesTotalAux.removeWhere((element) => element.property.ownersNumber<mapFilter["owners_number"]);
      }
      if(mapFilter["owners_number"]<5){
        propertiesTotalAux.removeWhere((element) => element.property.ownersNumber>mapFilter["owners_number"]);
      }
    }
  }
  if(mapFilter["basic_services"]!=null&&mapFilter["basic_services"]){
    propertiesTotalAux.removeWhere((element) => !element.property.basicServices);
  }
  if(mapFilter["household_gas"]!=null&&mapFilter["household_gas"]){
    propertiesTotalAux.removeWhere((element) => !element.property.householdGas);
  }
  if(mapFilter["wifi"]!=null&&mapFilter["wifi"]){
    propertiesTotalAux.removeWhere((element) => !element.property.wifi);
  }
  if(mapFilter["independent_meter"]!=null&&mapFilter["independent_meter"]){
    propertiesTotalAux.removeWhere((element) => !element.property.independentMeter);
  }
  if(mapFilter["hot_water_tank"]!=null&&mapFilter["hot_water_tank"]){
    propertiesTotalAux.removeWhere((element) => !element.property.hotWaterTank);
  }
  if(mapFilter["paved_street"]!=null&&mapFilter["paved_street"]) {
    propertiesTotalAux.removeWhere((element) => !element.property.pavedStreet);
  }
  if(mapFilter["transport"]!=null&&mapFilter["transport"]){
    propertiesTotalAux.removeWhere((element) => !element.property.transport);
  }
  if(mapFilter["disability_prepared"]!=null&&mapFilter["disability_prepared"]){
    propertiesTotalAux.removeWhere((element) => !element.property.disabilityPrepared);
  }
  if(mapFilter["order_papers"]!=null&&mapFilter["order_papers"]) {
    propertiesTotalAux.removeWhere((element) => !element.property.orderPapers);
  }
  if(mapFilter["enabled_credit"]!=null&&mapFilter["enabled_credit"]){
    propertiesTotalAux.removeWhere((element) => !element.property.enabledCredit);
  }
  //-----------------------------------------------------------------------------
  //FILTRO INTERNAS
  if(mapFilter["floors_number"]!=null&&mapFilter["floors_number"]>0){
    propertiesTotalAux.removeWhere((element) => element.propertyInternal.floorsNumber<mapFilter["floors_number"]);
    if(mapFilter["floors_number"]<5){
      propertiesTotalAux.removeWhere((element) => element.propertyInternal.floorsNumber>mapFilter["floors_number"]);
    }
  }
  if(mapFilter["rooms_number"]!=null&&mapFilter["rooms_number"]>0){
    propertiesTotalAux.removeWhere((element) => element.propertyInternal.roomsNumber<mapFilter["rooms_number"]);
    if(mapFilter["rooms_number"]<5){
      propertiesTotalAux.removeWhere((element) => element.propertyInternal.roomsNumber>mapFilter["rooms_number"]);
    }
  }
  if(mapFilter["bedrooms_number"]!=null&&mapFilter["bedrooms_number"]>0){
    propertiesTotalAux.removeWhere((element) => element.propertyInternal.bedroomsNumber<mapFilter["bedrooms_number"]);
    if(mapFilter["bedrooms_number"]<5){
      propertiesTotalAux.removeWhere((element) => element.propertyInternal.bedroomsNumber>mapFilter["bedrooms_number"]);
    }
  }
  if(mapFilter["bathrooms_number"]!=null&&mapFilter["bathrooms_number"]>0){
    propertiesTotalAux.removeWhere((element) => element.propertyInternal.bathroomsNumber<mapFilter["bathrooms_number"]);
    if(mapFilter["bathrooms_number"]<5){
      propertiesTotalAux.removeWhere((element) => element.propertyInternal.bathroomsNumber>mapFilter["bathrooms_number"]);
    }
  }
  if(mapFilter["garages_number"]!=null&&mapFilter["garages_number"]>0){
    propertiesTotalAux.removeWhere((element) => element.propertyInternal.garagesNumber<mapFilter["garages_number"]);
    if(mapFilter["garages_number"]<5){
      propertiesTotalAux.removeWhere((element) => element.propertyInternal.garagesNumber>mapFilter["garages_number"]);
    }
  }
  if(mapFilter["furnished"]!=null&&mapFilter["furnished"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.furnished);
  }
  if(mapFilter["laundry"]!=null&&mapFilter["laundry"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.laundry);
  }
  if(mapFilter["laundry_room"]!=null&&mapFilter["laundry_room"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.laundryRoom); 
  }
  if(mapFilter["grill"]!=null&&mapFilter["grill"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.grill); 
  }
  if(mapFilter["rooftop"]!=null&&mapFilter["rooftop"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.rooftop); 
  }
  if(mapFilter["private_condominium"]!=null&&mapFilter["private_condominium"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.privateCondominium); 
  }
  if(mapFilter["court"]!=null&&mapFilter["court"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.court); 
  }
  if(mapFilter["pool"]!=null&&mapFilter["pool"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.pool); 
  }
  if(mapFilter["sauna"]!=null&&mapFilter["sauna"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.sauna); 
  }
  if(mapFilter["jacuzzi"]!=null&&mapFilter["jacuzzi"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.jacuzzi); 
  }
  if(mapFilter["studio"]!=null&&mapFilter["studio"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.studio); 
  }
  if(mapFilter["garden"]!=null&&mapFilter["garden"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.garden); 
  }
  if(mapFilter["electric_gate"]!=null&&mapFilter["electric_gate"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.electricGate); 
  }
  if(mapFilter["air_conditioning"]!=null&&mapFilter["air_conditioning"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.airConditioning); 
  }
  if(mapFilter["heating"]!=null&&mapFilter["heating"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.heating); 
  }
  if(mapFilter["elevator"]!=null&&mapFilter["elevator"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.elevator); 
  }
  if(mapFilter["warehouse"]!=null&&mapFilter["warehouse"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.warehouse);
  }
  if(mapFilter["basement"]!=null&&mapFilter["basement"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.basement);
  }
  if(mapFilter["balcony"]!=null&&mapFilter["balcony"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.balcony);
  }
  if(mapFilter["store"]!=null&&mapFilter["store"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.store);
  }
  if(mapFilter["land_walled"]!=null&&mapFilter["land_walled"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyInternal.landWalled);
  }
  if(mapFilter["church"]!=null&&mapFilter["church"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.church);
  }
  if(mapFilter["playground"]!=null&&mapFilter["playground"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.playground);
  }
  if(mapFilter["school"]!=null&&mapFilter["school"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.school);
  }
  if(mapFilter["university"]!=null&&mapFilter["university"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.university);
  }
  if(mapFilter["small_square"]!=null&&mapFilter["small_square"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.smallSquare);
  }
  if(mapFilter["police_module"]!=null&&mapFilter["police_module"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.policeModule);
  }
  if(mapFilter["public_sauna_pool"]!=null&&mapFilter["public_sauna_pool"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.publicSaunaPool);
  }
  if(mapFilter["public_gym"]!=null&&mapFilter["public_gym"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.publicGym);
  }
  if(mapFilter["sport_center"]!=null&&mapFilter["sport_center"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.sportCenter);
  }
  if(mapFilter["post_health"]!=null&&mapFilter["post_health"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.postHealth);
  }
  if(mapFilter["shooping_zone"]!=null&&mapFilter["shooping_zone"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyCommunity.shoopingZone);
  }
  if(mapFilter["lowereds"]!=null&&mapFilter["lowereds"]){
    propertiesTotalAux.removeWhere((element) => !element.property.isLowered);
  }
  if(mapFilter["viewed"]!=null&&mapFilter["viewed"]){
    propertiesTotalAux.removeWhere((element) => !element.userPropertyFavorite.viewed);
  }
  if(mapFilter["viewed_double"]!=null&&mapFilter["viewed_double"]){
    propertiesTotalAux.removeWhere((element) => !element.userPropertyFavorite.viewedDouble);
  }
  if(mapFilter["favorites"]!=null&&mapFilter["favorites"]){
    propertiesTotalAux.removeWhere((element) => !element.userPropertyFavorite.favorite);
  }
  if(mapFilter["contacteds"]!=null&&mapFilter["contacteds"]){
    propertiesTotalAux.removeWhere((element) => !element.userPropertyFavorite.contacted);
  }
  if(mapFilter["verifieds"]!=null&&mapFilter["verifieds"]){
    propertiesTotalAux.removeWhere((element) => !element.creator.verified);
  }
  if(mapFilter["judicial_auctions"]!=null&&mapFilter["judicial_auctions"]){
    propertiesTotalAux.removeWhere((element) => !element.propertyOthers.judicialAuctions);
  }
  if(mapFilter["days_P360_min"]!=null){
    if(mapFilter["days_P360_min"]>0&&mapFilter["days_P360_max"]>0){
      propertiesTotalAux.removeWhere((element) => element.property.getDaysBetweenDates<mapFilter["days_P360_min"]);
    }
    if(mapFilter["days_P360_min"]<mapFilter["days_P360_max"]){
      propertiesTotalAux.removeWhere((element) => element.property.getDaysBetweenDates>mapFilter["days_P360_max"]);
    }
  }
  if(mapFilter["initial_negotiated"]!=null&&mapFilter["initial_negotiated"]){
    propertiesTotalAux.removeWhere((element) => element.property.negotiationStatus.toLowerCase()!="negociado inicial");
  }
  if(mapFilter["avanced_negotiated"]!=null&&mapFilter["avanced_negotiated"]){
    propertiesTotalAux.removeWhere((element) => element.property.negotiationStatus.toLowerCase()!="negociado_avanzado");
  }
  if(mapFilter["video_2D"]!=null&&mapFilter["video_2D"]){
    propertiesTotalAux.removeWhere((element) => element.propertyOthers.video2DLink.length==0);
  }
  if(mapFilter["tour_virtual_360"]!=null&&mapFilter["tour_virtual_360"]){
    propertiesTotalAux.removeWhere((element) => element.propertyOthers.tourVirtual360Link.length==0);
  }
  if(mapFilter["video_tour_360"]!=null&&mapFilter["video_tour_360"]){
    propertiesTotalAux.removeWhere((element) => element.propertyOthers.videoTour360Link.length==0);
  }
  return propertiesTotalAux;
}

void sortList(List<PropertyTotal> propertiesTotalAux, Map<String,dynamic> mapFilterOrder){
     if(mapFilterOrder["parameter"]==GetParameterOrder.price.index){
      if(mapFilterOrder["order"]==GetOrder.desc.index){
        propertiesTotalAux.sort((b,a){
          if(b.property.index<0||a.property.index<0){
            return 0;
          }
         return a.property.price.compareTo(b.property.price);
      });
        //propertiesTotalAux.sort((b,a)=> a.property.price.compareTo(b.property.price));
      }else{
        propertiesTotalAux.sort((a,b){
          if(b.property.index<0||a.property.index<0){
            return 1;
          }
          return a.property.price.compareTo(b.property.price);
        });
        //propertiesTotalAux.sort((a,b)=> a.property.price.compareTo(b.property.price));
      }
    }
    if(mapFilterOrder["parameter"]==GetParameterOrder.landSurface.index){
      if(mapFilterOrder["order"]==GetOrder.desc.index){
        propertiesTotalAux.sort((b,a)=>a.property.landSurface.compareTo(b.property.landSurface),);
      }else{
        propertiesTotalAux.sort((a,b)=>a.property.landSurface.compareTo(b.property.landSurface),);
      }
    }
    if(mapFilterOrder["parameter"]==GetParameterOrder.constructionSurface.index){
      if(mapFilterOrder["order"]==GetOrder.desc.index){
        propertiesTotalAux.sort((b,a)=>a.property.constructionSurface.compareTo(b.property.constructionSurface),);
      }else{
        propertiesTotalAux.sort((a,b)=>a.property.constructionSurface.compareTo(b.property.constructionSurface),);
      }
    }
    if(mapFilterOrder["parameter"]==GetParameterOrder.constructionAntiquity.index){
      if(mapFilterOrder["order"]==GetOrder.desc.index){
        propertiesTotalAux.sort((b,a)=>a.property.constructionAntiquity.compareTo(b.property.constructionAntiquity),);
      }else{
        propertiesTotalAux.sort((a,b)=>a.property.constructionAntiquity.compareTo(b.property.constructionAntiquity),);
      }
    }
    if(mapFilterOrder["parameter"]==GetParameterOrder.bedrooms.index){
      if(mapFilterOrder["order"]==GetOrder.desc.index){
        propertiesTotalAux.sort((b,a)=>a.propertyInternal.bedroomsNumber.compareTo(b.propertyInternal.bedroomsNumber),);
      }else{
        propertiesTotalAux.sort((a,b)=>a.propertyInternal.bedroomsNumber.compareTo(b.propertyInternal.bedroomsNumber),);
      }
    }
    if(mapFilterOrder["parameter"]==GetParameterOrder.viewed.index){
      if(mapFilterOrder["order"]==GetOrder.desc.index){
        propertiesTotalAux.sort((b,a)=>a.property.viewedQuantity.compareTo(b.property.viewedQuantity),);
      }else{
        propertiesTotalAux.sort((a,b)=>a.property.viewedQuantity.compareTo(b.property.viewedQuantity),);
      }
    }
    if(mapFilterOrder["parameter"]==GetParameterOrder.viewed_double.index){
      if(mapFilterOrder["order"]==GetOrder.desc.index){
        propertiesTotalAux.sort((b,a)=>a.property.viewedDoubleQuantity.compareTo(b.property.viewedDoubleQuantity),);
      }else{
        propertiesTotalAux.sort((a,b)=>a.property.viewedDoubleQuantity.compareTo(b.property.viewedDoubleQuantity),);
      }
    }
    if(mapFilterOrder["parameter"]==GetParameterOrder.favorite.index){
      if(mapFilterOrder["order"]==GetOrder.desc.index){
        propertiesTotalAux.sort((b,a)=>a.property.favoritesQuantity.compareTo(b.property.favoritesQuantity),);
      }else{
        propertiesTotalAux.sort((a,b)=>a.property.favoritesQuantity.compareTo(b.property.favoritesQuantity),);
      }
    }
  }
  List<PropertyTotal> selectElementsList(List<PropertyTotal> propertiesTotalAux,PropertyBaseParameter parameter){
    List<PropertyTotal> propertiesTotalFilter=[];
    if(parameter.parameter=="price"){
      propertiesTotalFilter.addAll(propertiesTotalAux.where((element) =>  element.property.price>=parameter.min&&element.property.price<=parameter.max));
      propertiesTotalAux.removeWhere((element) => element.property.price>=parameter.min&&element.property.price<=parameter.max);
    }else if(parameter.parameter=="construction_surface"){
      propertiesTotalFilter.addAll(propertiesTotalAux.where((element) =>  element.property.constructionSurface>=parameter.min&&element.property.constructionSurface<=parameter.max));
      propertiesTotalAux.removeWhere((element) => element.property.constructionSurface>=parameter.min&&element.property.constructionSurface<=parameter.max);
    }else if(parameter.parameter=="land_surface"){
      propertiesTotalFilter.addAll(propertiesTotalAux.where((element) =>  element.property.landSurface>=parameter.min&&element.property.landSurface<=parameter.max));
      propertiesTotalAux.removeWhere((element) => element.property.landSurface>=parameter.min&&element.property.landSurface<=parameter.max);
    }else if(parameter.parameter=="construction_antiquity"){
      propertiesTotalFilter.addAll(propertiesTotalAux.where((element) =>  element.property.constructionAntiquity>=parameter.min&&element.property.constructionAntiquity<=parameter.max));
      propertiesTotalAux.removeWhere((element) => element.property.constructionAntiquity>=parameter.min&&element.property.constructionAntiquity<=parameter.max);
    }else if(parameter.parameter=="bedrooms"){
      propertiesTotalFilter.addAll(propertiesTotalAux.where((element) =>  element.propertyInternal.bedroomsNumber>=parameter.min&&element.propertyInternal.bedroomsNumber<=parameter.max));
      propertiesTotalAux.removeWhere((element) => element.propertyInternal.bedroomsNumber>=parameter.min&&element.propertyInternal.bedroomsNumber<=parameter.max);
    }else if(parameter.parameter=="bathrooms"){
      propertiesTotalFilter.addAll(propertiesTotalAux.where((element) =>  element.propertyInternal.bathroomsNumber>=parameter.min&&element.propertyInternal.bathroomsNumber<=parameter.max));
      propertiesTotalAux.removeWhere((element) => element.propertyInternal.bathroomsNumber>=parameter.min&&element.propertyInternal.bathroomsNumber<=parameter.max);
    }else if(parameter.parameter=="garages"){
      propertiesTotalFilter.addAll(propertiesTotalAux.where((element) =>  element.propertyInternal.garagesNumber>=parameter.min&&element.propertyInternal.garagesNumber<=parameter.max));
      propertiesTotalAux.removeWhere((element) => element.propertyInternal.garagesNumber>=parameter.min&&element.propertyInternal.garagesNumber<=parameter.max);
    }
    return propertiesTotalFilter;
  }
  Map<String,dynamic> sortListByInterests(
    List<PropertyTotal> propertiesTotal,
    FilterOthersProvider filterOthersProvider,
    UserPropertyBase userPropertyBase,
    String contractType
  ){
    List<PropertyTotal> propertiesOrganic=[];
    List<PropertyTotal> propertiesResidual=[];
    if(userPropertyBase.priceMax==0){
      sortList(propertiesTotal, filterOthersProvider.mapFilterOrder);
      return {"residual":propertiesTotal,"organic":propertiesOrganic};
    }
    List<List<PropertyTotal>> listPropertiesTotal=[];
    List<PropertyBaseParameter> parameters=[];
    parameters=userPropertyBase.getParameters(contractType);
    for(int i=0;i<parameters.length;i++){
      List<PropertyTotal> pt=[];
      listPropertiesTotal.add(pt);
    }
    listPropertiesTotal.elementAt(0).addAll(propertiesTotal);
    for(int i=0;i<parameters.length-1;i++){
      listPropertiesTotal.elementAt(i+1).addAll(selectElementsList(listPropertiesTotal.elementAt(i), parameters[i]));
    }
    for(int i=parameters.length-1;i>=0;i--){
      if(i==0){
        propertiesResidual.addAll(listPropertiesTotal.elementAt(i));
      }else{
        propertiesOrganic.addAll(listPropertiesTotal.elementAt(i));
      }
    }
    sortList(propertiesOrganic, filterOthersProvider.mapFilter);
    return {"residual":propertiesResidual,"organic":propertiesOrganic};
  }

  List<PropertyTotal> selectPro(List<PropertyTotal> propertiesTotalAux,FilterOthersProvider filterOthersProvider,UserPropertyBase userPropertyBase,String contractType){
    List<PropertyTotal> propertiesTotalFilter=[];
    propertiesTotalFilter.addAll(propertiesTotalAux.where((element) => element.property.category=="Pro"));
    propertiesTotalAux.removeWhere((element) => element.property.category=="Pro");
    Map<String,dynamic> im= sortListByInterests(propertiesTotalFilter,filterOthersProvider,userPropertyBase,contractType);
    propertiesTotalFilter=[];
    propertiesTotalFilter.addAll(im["organic"]);
    propertiesTotalFilter.addAll(im["residual"]);
    return propertiesTotalFilter;
  }

  List<PropertyTotal> selectPro360(List<PropertyTotal> propertiesTotalAux,FilterOthersProvider filterOthersProvider,UserPropertyBase userPropertyBase,String contractType){
    List<PropertyTotal> propertiesTotalFilter=[];
    propertiesTotalFilter.addAll(propertiesTotalAux.where((element) => element.property.category=="Pro360"));
    propertiesTotalAux.removeWhere((element) => element.property.category=="Pro360");
    Map<String,dynamic> im= sortListByInterests(propertiesTotalFilter,filterOthersProvider,userPropertyBase,contractType);
    propertiesTotalFilter=[];
    propertiesTotalFilter.addAll(im["organic"]);
    propertiesTotalFilter.addAll(im["residual"]);
    return propertiesTotalFilter;
  }

  List<PropertyTotal> selectLowered(List<PropertyTotal> propertiesTotalAux,FilterOthersProvider filterOthersProvider,UserPropertyBase userPropertyBase,String contractType){
    List<PropertyTotal> propertiesTotalFilter=[];
    propertiesTotalFilter.addAll(propertiesTotalAux.where((element) => element.property.isLowered));
    propertiesTotalAux.removeWhere((element)=>element.property.isLowered);
    Map<String,dynamic> im= sortListByInterests(propertiesTotalFilter,filterOthersProvider,userPropertyBase,contractType);
    propertiesTotalFilter=[];
    propertiesTotalFilter.addAll(im["organic"]);
    propertiesTotalFilter.addAll(im["residual"]);
    return propertiesTotalFilter;
  }

  List<PropertyTotal> selectPropertiesSimilars(List<PropertyTotal> propertiesTotalAux,PropertyTotal propertyTotal){
    print(propertiesTotalAux.length);
    UserPropertyBase base=UserPropertyBase(
      id: "", 
      type: propertyTotal.property.contractType, 
      priceMin: propertyTotal.property.price-1000,
      priceMax: propertyTotal.property.price+1000, 
      bedroomsMin: propertyTotal.propertyInternal.bedroomsNumber-1, 
      bedroomsMax: propertyTotal.propertyInternal.bedroomsNumber+1, 
      bathroomsMin: propertyTotal.propertyInternal.bathroomsNumber-1, 
      bathroomsMax: propertyTotal.propertyInternal.bathroomsNumber+1, 
      garagesMin: propertyTotal.propertyInternal.garagesNumber-1, 
      garagesMax: propertyTotal.propertyInternal.garagesNumber+1, 
      landSurfaceMin: propertyTotal.property.landSurface-20, 
      landSurfaceMax: propertyTotal.property.landSurface+20,
      constructionSurfaceMin: propertyTotal.property.constructionSurface-20, 
      constructionSurfaceMax: propertyTotal.property.constructionSurface+20,
      constructionAntiquityMin: propertyTotal.property.constructionAntiquity-2, 
      constructionAntiquityMax: propertyTotal.property.constructionAntiquity+2, 
      propertiesQuantity: 0, 
      furnished: 0, 
      laundry: 0, 
      laundryRoom: 0, 
      grill: 0, 
      rooftop: 0, privateCondominium: 0, 
      court: 0, pool: 0, sauna: 0,
      jacuzzi: 0, studio: 0, garden: 0, 
      electricGate: 0, airConditioning: 0, 
      heating: 0, elevator: 0, 
      warehouse: 0, basement: 0, balcony: 0, 
      store: 0, landWalled: 0, 
      startDate: "", endDateSaved: "", 
      cacheDate: ""
    );
    print(base.toMapFilter());
    List<List<PropertyTotal>> listPropertiesTotal=[];
    List<PropertyBaseParameter> parameters=[];
    parameters=base.getParameters(propertyTotal.property.contractType);
    for(int i=0;i<parameters.length;i++){
      List<PropertyTotal> it=[];
      listPropertiesTotal.add(it);
    }
    listPropertiesTotal.elementAt(0).addAll(propertiesTotalAux);
    for(int i=0;i<parameters.length-1;i++){
      if(i==0){
        
      }
      listPropertiesTotal.elementAt(i+1).addAll(selectElementsList(listPropertiesTotal.elementAt(i), parameters[i]));
    }
    
    List<PropertyTotal> propertiesTotalFilter=[];
    for(int i=parameters.length-1;i>=0;i--){
      if(i>0){
        propertiesTotalFilter.addAll(listPropertiesTotal.elementAt(i));
      }
    }
    propertiesTotalFilter.removeWhere((element) => element.property.id==propertyTotal.property.id);
    
    print(propertiesTotalFilter.length);
    return propertiesTotalFilter;
  }

List<PropertyTotal> filterPropertiesOrderBase(List<PropertyTotal> propertiesTotalAux,
                            FilterOthersProvider filterOthersProvider,
                            List<UserPropertyBase> userPropertyBases,
                            FilterMainProvider filterMainProvider
                            ){
  userPropertyBases.sort((a,b)=>a.type.compareTo(b.type));
  List<PropertyTotal> propertiesPro360=selectPro360(propertiesTotalAux,filterOthersProvider,userPropertyBases[2],filterMainProvider.mapFilter["contract_type"]);
  List<PropertyTotal> propertiesPro=selectPro(propertiesTotalAux,filterOthersProvider,userPropertyBases[0],filterMainProvider.mapFilter["contract_type"]);
  //List<InmuebleTotal> inmueblesRebajados=seleccionarRebajados(inmueblesAux,_mapaFiltroOtros,usuarioInmuebleBases[1],_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]);
  // print(usuarioInmuebleBases[1].usuarioInmuebleBaseToMap());
  Map<String,dynamic> interestsMap=sortListByInterests(propertiesTotalAux,filterOthersProvider,userPropertyBases[1],filterMainProvider.mapFilter["contract_type"]);
  List<PropertyTotal> propertiesOrganic=interestsMap["organic"];
  List<PropertyTotal> propertiesResidual=interestsMap["residual"];
  List<String> sequence=["pro360","pro","orgánico"];
  // ignore: unused_local_variable
  int counterPublicity=0;
  // ignore: unused_local_variable
  int positionPublicity=0;
  propertiesTotalAux=[];
  int i=0;
  while(true){
    if(propertiesPro.length==0&&propertiesPro360.length==0&&propertiesOrganic.length==0){
      break;
    }
    if(sequence[i]=="orgánico"){
      print("inmuebles organico ${propertiesOrganic.length}");
      if(propertiesOrganic.length>=5){
        List<PropertyTotal> propertiesTemporary=[];
        propertiesTemporary.addAll(propertiesOrganic.getRange(0, 5));
        if(counterPublicity<3){
          PropertyTotal propertyTotal=PropertyTotal.empty();
          propertyTotal.property.index=-1;
          propertyTotal.property.category="Cuadrado";
          propertiesTemporary.add(propertyTotal);
          positionPublicity=3;
          propertiesTotalAux.addAll(propertiesTemporary);
          propertiesOrganic.removeRange(0, 5);
          counterPublicity++;
        }else{
          break;
        }
      }else{
        propertiesResidual.addAll(propertiesOrganic);
        propertiesOrganic=[];
      }
    }else if(sequence[i]=="pro"){
      if(propertiesPro.length>=10){
        List<PropertyTotal> propertiesTemporary=[];
        propertiesTemporary.addAll(propertiesPro.getRange(0, 10));
        if(counterPublicity<3){
          PropertyTotal propertyTotal=PropertyTotal.empty();
          propertyTotal.property.index=-1;
          propertyTotal.property.category="Cuadrado";
          propertiesTemporary.add(propertyTotal);
          positionPublicity=3;
          propertiesTotalAux.addAll(propertiesTemporary);
          propertiesPro.removeRange(0, 10);
          counterPublicity++;
        }else{
          break;
        }
        
      }else{
        propertiesResidual.addAll(propertiesPro);
        propertiesPro=[];
      }
    }else if(sequence[i]=="pro360"){
      if(propertiesPro360.length>=10){
        List<PropertyTotal> propertiesTemporary=[];
        propertiesTemporary.addAll(propertiesPro360.getRange(0, 10));
        if(counterPublicity<3){
          PropertyTotal inmuebleTotal=PropertyTotal.empty();
          inmuebleTotal.property.index=-1;
          inmuebleTotal.property.category="Cuadrado";
          propertiesTemporary.add(inmuebleTotal);
          positionPublicity=3;
          propertiesTotalAux.addAll(propertiesTemporary);
          propertiesPro360.removeRange(0, 10);
          counterPublicity++;
        }else{
          break;
        }
      }else{
        propertiesResidual.addAll(propertiesPro360);
        propertiesPro360=[];
      }
    }
    if(i<sequence.length-1){
      i++;
    }else{
      i=0;
    }
  }
  propertiesResidual.addAll(propertiesPro360);
  propertiesResidual.addAll(propertiesPro);
  propertiesResidual.addAll(propertiesOrganic);
  sortList(propertiesResidual,filterOthersProvider.mapFilterOrder);
  int limit=propertiesResidual.length;
  
  for(int i=3;i<limit;i=i+3){
      PropertyTotal propertyTotal=PropertyTotal.empty();
      propertyTotal.property.index=-1;
      propertyTotal.property.category="Rectángulo";
      propertiesResidual.insertAll(i, [propertyTotal]);
      i++;
      limit++;
  }
  propertiesTotalAux.addAll(propertiesResidual);
  return propertiesTotalAux;
}

List<PropertyTotal> addPublicityProperties(List<PropertyTotal> propertiesTotal){
  var rng = new Random();
  
  final publicitiesType=["Cuadrado","Rectángulo"];
  int limit=propertiesTotal.length;
  for(int i=5;i<limit;i=i+5){
    PropertyTotal propertyTotal=PropertyTotal.empty();
    propertyTotal.property.index=-1;
    int randomNumber=rng.nextInt(2);
    propertyTotal.property.category=publicitiesType[randomNumber];
    propertiesTotal.insertAll(i, [propertyTotal]);
    i++;
    limit++;
  }
  return propertiesTotal;
}