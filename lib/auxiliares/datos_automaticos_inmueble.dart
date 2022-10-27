import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'dart:math';

import 'package:inmobiliariaapp/domain/entities/user.dart';

class AutoDataProperty{
  Property property;
  PropertyInternal propertyInternal;
  PropertyCommunity propertyCommunity;
  PropertyOthers propertyOthers;
  User creator;
  User owner;
  AutoDataProperty({
    required this.property,
    required this.propertyInternal,
    required this.propertyCommunity,
    required this.propertyOthers,
    required this.creator,
    required this.owner
  });
  factory AutoDataProperty.empty(){
    return AutoDataProperty(
      property: Property.empty(), 
      propertyInternal: PropertyInternal.empty(), 
      propertyCommunity: PropertyCommunity.empty(), 
      propertyOthers: PropertyOthers.empty(), 
      creator: User.empty(), 
      owner: User.empty()
    );
  }
  void generateRandomData(
    TextEditingController? _controllerOwnerName,
    TextEditingController? _controllerZoneName,
    TextEditingController? _controllerAddress,
    TextEditingController? _controllerLandSurface,
    TextEditingController? _controllerConstructionSurface,
    TextEditingController? _controllerPrice,
    TextEditingController? _controllerConstructionAntiquity,
    TextEditingController? _controllerOwnersNumber,
    TextEditingController? _controllerFloorsNumber,
    TextEditingController? _controllerBedroomsNumber,
    TextEditingController? _controllerBathroomsNumber,
    TextEditingController? _controllerGaragesNumber,
    TextEditingController? _controllerImages2D,
    TextEditingController? _controllerVideo2D,
    TextEditingController? _controllerTourVirtual360,
    TextEditingController? _controllerVideoTour360,
    PropertyTotal propertyTotal,
  ){
    List<String> zones=["Zona 1","Zona 2","Zona 3","Zona 4","Zona 5","Zona 6","Zona 7","Zona 8","Zona ","Zona 10"];
    List<String> propertyTypes=["Casa","Departamento","Terreno"];
    List<String> contractTypes=["Venta","Alquiler","Anticrético"];
    List<String> video2D=["","www.linkvideo"];
    List<String> tourvirtual=["","www.linktourvirtual"];
    List<String> videoTour=["","www.linkvideotour"];
    List<bool> valuesBooleans=[true,false];
    


  var rng = new Random();
  
    propertyTotal.property.city="Sucre";
    int randomNumber=rng.nextInt(zones.length);
    propertyTotal.property.zoneName=zones[randomNumber];
    randomNumber=rng.nextInt(50);
    propertyTotal.property.address="Dirección "+randomNumber.toString();
    randomNumber=rng.nextInt(propertyTypes.length);
    propertyTotal.property.propertyType=propertyTypes[randomNumber];
    randomNumber=rng.nextInt(contractTypes.length);
    propertyTotal.property.contractType=contractTypes[randomNumber];
    randomNumber=20+rng.nextInt(400);
    propertyTotal.property.price=propertyTotal.property.contractType=="Alquiler"?randomNumber*10:propertyTotal.property.contractType=="Anticrético"?randomNumber*100:randomNumber*1000;
    propertyTotal.property.authorization="Pendiente";
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.property.orderPapers=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.property.newConstruction=propertyTotal.property.propertyType=="Terreno"?false:valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.property.enabledCredit=valuesBooleans[randomNumber];
    randomNumber=5+rng.nextInt(40);
    propertyTotal.property.landSurface=propertyTotal.property.propertyType=="Departamento"?randomNumber*2:randomNumber*10;
    randomNumber=5+rng.nextInt(40);
    propertyTotal.property.constructionSurface=propertyTotal.property.propertyType=="Departamento"?randomNumber*2:propertyTotal.property.propertyType=="Casa"?randomNumber*10:0;
    propertyTotal.property.preSaleProject=propertyTotal.property.propertyType=="Terreno"?true:false;
    randomNumber=0+rng.nextInt(20);
    propertyTotal.property.constructionAntiquity=randomNumber;
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.property.sharedProperty=valuesBooleans[randomNumber];
    randomNumber=2+rng.nextInt(10);
    propertyTotal.property.ownersNumber=propertyTotal.property.sharedProperty?randomNumber:1;
    randomNumber=1+rng.nextInt(15);
    propertyTotal.propertyInternal.floorsNumber=propertyTotal.property.propertyType=="Terreno"?0:randomNumber;
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.property.noMortgage=valuesBooleans[randomNumber];
    var longitude=-65.22562;
    var latitude=-18.98654;
    propertyTotal.property.coordinates=[];
    randomNumber=1+rng.nextInt(11);
    propertyTotal.property.coordinates.add(((latitude-1/randomNumber)*10000).floor()/10000);
    randomNumber=1+rng.nextInt(80);
    propertyTotal.property.coordinates.add(((longitude-1/randomNumber)*10000).floor()/10000);
    if(!(propertyTotal.property.propertyType=="Casa"||propertyTotal.property.propertyType=="Departamento")){
      randomNumber=1+rng.nextInt(15);
      propertyTotal.propertyInternal.bedroomsNumber=randomNumber;
      randomNumber=1+rng.nextInt(15);
      propertyTotal.propertyInternal.bathroomsNumber=randomNumber;
      randomNumber=1+rng.nextInt(15);
      propertyTotal.propertyInternal.garagesNumber=randomNumber;
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.laundry=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.laundryRoom=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.grill=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.rooftop=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.court=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.pool=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.sauna=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.store=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.studio=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.garden=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.balcony=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.elevator=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.basement=valuesBooleans[randomNumber];
      randomNumber=rng.nextInt(valuesBooleans.length);
      propertyTotal.propertyInternal.warehouse=valuesBooleans[randomNumber];
    }else{
      propertyTotal.propertyInternal=PropertyInternal.empty();
    }
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.propertyCommunity.church=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.propertyCommunity.playground=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.propertyCommunity.sportCenter=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.propertyCommunity.policeModule=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.propertyCommunity.publicSaunaPool=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.propertyCommunity.publicGym=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.propertyCommunity.school=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.propertyCommunity.shoopingZone=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(valuesBooleans.length);
    propertyTotal.propertyOthers.judicialAuctions=valuesBooleans[randomNumber];
    randomNumber=rng.nextInt(video2D.length);
    propertyTotal.propertyOthers.video2DLink=video2D[randomNumber];
    randomNumber=rng.nextInt(tourvirtual.length);
    propertyTotal.propertyOthers.tourVirtual360Link=tourvirtual[randomNumber];
    randomNumber=rng.nextInt(videoTour.length);
    propertyTotal.propertyOthers.videoTour360Link=videoTour[randomNumber];
    _controllerZoneName!.text=propertyTotal.property.zoneName;
    _controllerAddress!.text=propertyTotal.property.address;
    _controllerPrice!.text=propertyTotal.property.price.toString();
    _controllerLandSurface!.text=propertyTotal.property.landSurface.toString();
    _controllerConstructionSurface!.text=propertyTotal.property.constructionSurface.toString();
    _controllerConstructionAntiquity!.text=propertyTotal.property.constructionAntiquity.toString();
    _controllerOwnersNumber!.text=propertyTotal.property.ownersNumber.toString();
    _controllerFloorsNumber!.text=propertyTotal.propertyInternal.floorsNumber.toString();
    _controllerBedroomsNumber!.text=propertyTotal.propertyInternal.bathroomsNumber.toString();
    _controllerBathroomsNumber!.text=propertyTotal.propertyInternal.bathroomsNumber.toString();
    _controllerGaragesNumber!.text=propertyTotal.propertyInternal.garagesNumber.toString();
    _controllerVideo2D!.text=propertyTotal.propertyOthers.video2DLink;
    _controllerTourVirtual360!.text=propertyTotal.propertyOthers.tourVirtual360Link;
    _controllerVideoTour360!.text=propertyTotal.propertyOthers.videoTour360Link;
  }
}