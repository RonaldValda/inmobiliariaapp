import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_widget_provider.dart';

Map<String,dynamic> generateTextGeneral(Property property){
    double _sizeIcon=22*SizeDefault.scaleHeight;
    double _sizeIcon2=19*SizeDefault.scaleHeight;
    Map<String,dynamic> map={};
    List<Widget> icons=[];
    List<String> categories=[];
    
    categories.add("En ${property.contractType}");
    icons.add(Icon(Icons.document_scanner,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    categories.add("${property.propertyType}");
    icons.add(Icon(Icons.house_siding,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    categories.add("${property.price}"+r"$");
    icons.add(Icon(Icons.money,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    icons.add(Icon(Icons.public,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    categories.add("Ubicado en "+property.city+", "+property.zoneName+", "+property.address);
    
    categories.add("${property.landSurface.toString()}m2 de terreno");
    icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.vectorSquare,size: _sizeIcon2,color: ColorsDefault.colorIcon,));
    categories.add("${property.constructionSurface.toString()}m2 de construcción");
    icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.square,size: _sizeIcon2,color: ColorsDefault.colorIcon,));
    categories.add("${property.frontSize.toString()}m de frente");
    icons.add(Icon(Icons.house,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    if(!property.preSaleProject) {
      categories.add("${property.constructionAntiquity.toString()} años de antigüedad");
      icons.add(Icon(Icons.calendar_today,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(property.enablePets){ 
      categories.add("Mascota permitidas");
       icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.dog,size: _sizeIcon2,color: ColorsDefault.colorIcon,));
    }
    if(property.noMortgage){
      categories.add("Sin hipoteca");
      icons.add(Icon(Icons.check_box_outlined,size:_sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(property.newConstruction) {
      categories.add("Construcción a estrenar");
      icons.add(Icon(Icons.fiber_new,size:_sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(property.premiumMaterials) {
      categories.add("Materiales de primera");
      icons.add(Icon(Icons.construction,size:_sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(property.preSaleProject){
      categories.add("Proyecto preventa");
      icons.add(Icon(Icons.eight_mp,size:_sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(property.sharedProperty){
      categories.add("${property.ownersNumber.toString()} dueños");
      icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.userFriends,size:_sizeIcon2,color: ColorsDefault.colorIcon,));
    }else{
      icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.user,size:_sizeIcon2,color: ColorsDefault.colorIcon,));
      categories.add("Único dueño");
    }
    if(property.basicServices){
      categories.add("Servicios básicos (luz,agua,etc)");
      icons.add(Icon(Icons.light,size:_sizeIcon,color: ColorsDefault.colorIcon,));
    } 

    if(property.householdGas){
      categories.add("Gas domiciliario");
      icons.add(Icon(Icons.ac_unit,size:_sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(property.wifi) {
      categories.add("Wi-Fi");
      icons.add(Icon(Icons.wifi,size:_sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(property.independentMeter) {
      categories.add("Medidor independiente");
      icons.add(Icon(Icons.tab_unselected,size:_sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(property.hotWaterTank) {
      categories.add("Termotanques");
      icons.add(Icon(Icons.thermostat,size:_sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(property.pavedStreet) {
      categories.add("Calle asfaltada");
      icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.streetView,size:_sizeIcon2,color: ColorsDefault.colorIcon,));
    }
    if(property.transport) {
      categories.add("Transporte de 0 - 100m");
       icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.bus,size:_sizeIcon2,color: ColorsDefault.colorIcon,));
    }
    if(property.disabilityPrepared) {
      categories.add("Preparado para discapacidad");
       icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.wheelchair,size:_sizeIcon2,color: ColorsDefault.colorIcon,));
    }
    if(property.orderPapers){
      categories.add("Papeles en orden");
       icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.dochub,size:_sizeIcon2,color: ColorsDefault.colorIcon,));
    }
    if(property.enabledCredit){
      categories.add("Habilitado para crédito de vivienda social");
       icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.checkCircle,size:_sizeIcon2,color: ColorsDefault.colorIcon,));
    } 
    map["icons"]=icons;
    map["categories"]=categories;
    return map;
  }
  Map<String,dynamic> generateTextInternal(PropertyTotal propertyTotal,PropertiesWidgetProvider propertiesWidgetProvider){
    double _sizeIcon=22*SizeDefault.scaleHeight;
    double _sizeIcon2=19*SizeDefault.scaleHeight;
    final property=propertyTotal.property;
    final propertyInternal=propertyTotal.propertyInternal;
    Map<String,dynamic> map={};
    //map["ambientes"]=4;
    List<String> categories=[];
    List<String> keys=[];
    List<Widget> icons=[];
    //print(map);
    if(propertyInternal.floorsNumber>0){
      categories.add("Plantas: ${propertyInternal.floorsNumber}");
      keys.add("plantas");
      if(propertiesWidgetProvider.searchPositionCategory("plantas")<property.categoriesKeys.length){
        icons.add(Icon(Icons.horizontal_split_outlined,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.horizontal_split_outlined,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.roomsNumber>0){
      categories.add("Ambientes: ${propertyInternal.roomsNumber}");
      keys.add("ambientes");
      if(propertiesWidgetProvider.searchPositionCategory("ambientes")<property.categoriesKeys.length){
        icons.add(Icon(Icons.other_houses_rounded,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.other_houses_rounded,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.bedroomsNumber>0){
      categories.add("Dormitorios: ${propertyInternal.bedroomsNumber}");
      keys.add("dormitorios");
      if(propertiesWidgetProvider.searchPositionCategory("dormitorios")<property.categoriesKeys.length){
        icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.bed,size: _sizeIcon2,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.bed,size: _sizeIcon2,color: ColorsDefault.colorIcon,));
      }
      
    }
    if(propertyInternal.bathroomsNumber>0){
      categories.add("Baños: ${propertyInternal.bathroomsNumber}");
      keys.add("banios");
      if(propertiesWidgetProvider.searchPositionCategory("banios")<property.categoriesKeys.length){
        icons.add(Icon(Icons.bathroom,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.bathroom,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.garagesNumber>0){
      categories.add("Garaje: ${propertyInternal.garagesNumber}");
      keys.add("garaje");
      if(propertiesWidgetProvider.searchPositionCategory("garaje")<property.categoriesKeys.length){
        icons.add(Icon(Icons.garage,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.garage,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.furnished){
      categories.add("Amoblado");
      keys.add("amoblado");
      if(propertiesWidgetProvider.searchPositionCategory("amoblado")<property.categoriesKeys.length){
        icons.add(Icon(Icons.living,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.living,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.laundry){
      categories.add("Lavanderia");
      keys.add("lavanderia");
      if(propertiesWidgetProvider.searchPositionCategory("lavanderia")<property.categoriesKeys.length){
        icons.add(Icon(Icons.wash,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.wash,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.laundryRoom){
      categories.add("Cuarto de lavado");
      keys.add("cuarto_lavado");
      if(propertiesWidgetProvider.searchPositionCategory("cuarto_lavado")<property.categoriesKeys.length){
        icons.add(Icon(Icons.wash_sharp,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.wash_sharp,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.grill){
      categories.add("Churrasquero");
      keys.add("churrasquero");
      
      if(propertiesWidgetProvider.searchPositionCategory("churrasquero")<property.categoriesKeys.length){
        icons.add(Icon(Icons.outdoor_grill,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.outdoor_grill,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.rooftop){
      categories.add("Azotea");
      keys.add("azotea");
      if(propertiesWidgetProvider.searchPositionCategory("azotea")<property.categoriesKeys.length){
        icons.add(Icon(Icons.roofing,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.roofing,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.privateCondominium){
      categories.add("[Club house]-> Condominio privado");
      keys.add("condominio_privado");
      if(propertiesWidgetProvider.searchPositionCategory("condominio_privado")<property.categoriesKeys.length){
        icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.houseDamage,size: _sizeIcon2,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.houseDamage,size: _sizeIcon2,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.court){
      categories.add("Cancha de fútbol, tenis, etc. en inmueble");
      keys.add("cancha");
      if(propertiesWidgetProvider.searchPositionCategory("cancha")<property.categoriesKeys.length){
        icons.add(Icon(Icons.sports_baseball,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.sports_baseball,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.pool){
      categories.add("Piscina");
      keys.add("piscina");
      if(propertiesWidgetProvider.searchPositionCategory("piscina")<property.categoriesKeys.length){
        icons.add(Icon(Icons.pool,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.pool,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.sauna){
      categories.add("Sauna");
      keys.add("sauna");
      if(propertiesWidgetProvider.searchPositionCategory("sauna")<property.categoriesKeys.length){
        icons.add(Icon(Icons.water,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.water,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.jacuzzi){
      categories.add("Jacuzzi");
      keys.add("jacuzzi");
      if(propertiesWidgetProvider.searchPositionCategory("jacuzzi")<property.categoriesKeys.length){
        icons.add(Icon(Icons.bathtub,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.bathtub,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.studio){
      categories.add("Estudio");
      keys.add("estudio");
      if(propertiesWidgetProvider.searchPositionCategory("estudio")<property.categoriesKeys.length){
        icons.add(Icon(Icons.book,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.book,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.garden){
      categories.add("Jardín");
      keys.add("jardin");
      if(propertiesWidgetProvider.searchPositionCategory("jardin")<property.categoriesKeys.length){
        icons.add(Icon(Icons.yard,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.yard,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.electricGate){
      categories.add("Portón eléctrico");
      keys.add("porton_electrico");
      if(propertiesWidgetProvider.searchPositionCategory("porton_electrico")<property.categoriesKeys.length){
        icons.add(Icon(Icons.games_outlined,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.games_outlined,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.airConditioning){
      categories.add("Aire acondicionado");
      keys.add("aire_acondicionado");
      if(propertiesWidgetProvider.searchPositionCategory("aire_acondicionado")<property.categoriesKeys.length){
        icons.add(Icon(Icons.air,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.air,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.heating){
      categories.add("Calefacción");
      keys.add("calefaccion");
      if(propertiesWidgetProvider.searchPositionCategory("calefaccion")<property.categoriesKeys.length){
        icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.cube,size: _sizeIcon2,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.cube,size: _sizeIcon2,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.elevator){
      categories.add("Ascensor");
      keys.add("ascensor");
      if(propertiesWidgetProvider.searchPositionCategory("ascensor")<property.categoriesKeys.length){
        icons.add(Icon(Icons.arrow_circle_up_outlined,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.arrow_circle_up_outlined,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.warehouse){
      categories.add("Depósito");
      keys.add("deposito");
      if(propertiesWidgetProvider.searchPositionCategory("deposito")<property.categoriesKeys.length){
        icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.houzz,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.houzz,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.basement){
      categories.add("Sótano");
      keys.add("sotano");
      if(propertiesWidgetProvider.searchPositionCategory("sotano")<property.categoriesKeys.length){
        icons.add(Icon(Icons.arrow_circle_down_outlined,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.arrow_circle_down_outlined,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.balcony){
      categories.add("Balcón");
      keys.add("balcon");
      if(propertiesWidgetProvider.searchPositionCategory("balcon")<property.categoriesKeys.length){
        icons.add(Icon(Icons.house_siding,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.house_siding,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.store){
      categories.add("Tienda");
      keys.add("tienda");
      if(propertiesWidgetProvider.searchPositionCategory("tienda")<property.categoriesKeys.length){
        icons.add(Icon(Icons.shop,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.shop,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    if(propertyInternal.landWalled){
      categories.add("[Amurallado]-> Terreno");
      keys.add("amurallado_terreno");
      if(propertiesWidgetProvider.searchPositionCategory("amurallado_terreno")<property.categoriesKeys.length){
        icons.add(Icon(Icons.crop_square,size: _sizeIcon,color: ColorsDefault.colorPrimary,));
      }else{
        icons.add(Icon(Icons.crop_square,size: _sizeIcon,color: ColorsDefault.colorIcon,));
      }
    }
    /*if(texto.length>2){
      if(texto.substring(1,2)=="|") texto=texto.substring(2,texto.length);
    }*/
    map["categories"]=categories;
    map["keys"]=keys;
    map["icons"]=icons;
    return map;
  }
  Map<String,dynamic> generateTextCommunity(PropertyCommunity propertyCommunity){
    double _sizeIcon=22*SizeDefault.scaleHeight;
    double _sizeIcon2=19*SizeDefault.scaleHeight;
    Map<String,dynamic> map={};
    List<String> categories=[];
    List<Widget> icons=[];
    if(propertyCommunity.church){
      categories.add("Iglesia");
      icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.church,size:_sizeIcon2,color:ColorsDefault.colorIcon));
    }
    if(propertyCommunity.playground) {
      categories.add("Parque infantil");
      icons.add(Icon(Icons.park,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(propertyCommunity.school){
      categories.add("Escuela");
      icons.add(Icon(Icons.school,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(propertyCommunity.university){
      categories.add("Universidad");
      icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.university,size:_sizeIcon2,color:ColorsDefault.colorIcon));
    }
    if(propertyCommunity.smallSquare) {
      categories.add("Plazuela");
      icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.square,size:_sizeIcon2,color:ColorsDefault.colorIcon));
    }
    
    if(propertyCommunity.policeModule) {
      categories.add("Módulo policial");
      icons.add(Icon(Icons.policy,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(propertyCommunity.publicSaunaPool) {
      categories.add("Sauna / piscina pública");
      icons.add(Icon(Icons.pool,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(propertyCommunity.publicGym) {
      categories.add("Gym público");
      icons.add(Icon(Icons.cabin,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(propertyCommunity.sportCenter) {
      categories.add("Centro deportivo");
      icons.add(Icon(Icons.sports_basketball,size: _sizeIcon,color: ColorsDefault.colorIcon,));
    }
    if(propertyCommunity.postHealth) {
      categories.add("Puesto de salud");
      icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.hospitalUser,size:_sizeIcon2,color:ColorsDefault.colorIcon));
    }
    if(propertyCommunity.shoopingZone) {
      categories.add("Zona comercial");
      icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.shopware,size:_sizeIcon2,color:ColorsDefault.colorIcon));
    }
    
    map["categories"]=categories;
    map["icons"]=icons;
    return map;
  }
  Map<String,dynamic> generateTextOthers(PropertyOthers propertyOthers,Property property){
    Map<String,dynamic> map={};
    List<String> categories=[];
    List<Widget> icons=[];
    categories.add("${property.negotiationStatus}");
    icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.handHoldingUsd,size: 20));
    categories.add("${property.getDaysBetweenDates} días en P360");
    icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.calendarDay,size: 20));
    if(propertyOthers.judicialAuctions){
      categories.add("Remates judiciales");
      icons.add(iconc.FaIcon(iconc.FontAwesomeIcons.buffer,size: 20));
    }
    map["categories"]=categories;
    map["icons"]=icons;
    return map;
  }