
import '../../entities/property_total.dart';
import '../../entities/user_property_favorite.dart';

List<UserPropertyBase> generatePropertyBase(String userId,List<PropertyTotal> propertiesTotal){
  List<UserPropertyBase> userPropertyBases=[];
  List<PropertyTotal> propertyTotalAux=[];
  propertyTotalAux.addAll(propertiesTotal);
  List<PropertyTotal> favoriteProperties=[];
  List<PropertyTotal> viewedProperties=[];
  List<PropertyTotal> viewedDoubleProperties=[];
  int priceMin=0, priceMax=0;
  int bedroomsMin=0, bedroomsMax=0;
  int bathroomsMin=0, bathroomsMax=0;
  int garagesMin=0, garagesMax=0;
  int landSurfaceMin=0,landSurfaceMax=0;
  int constructionSurfaceMin=0,constructionSurfaceMax=0;
  int constructionAntiquityMin=0, constructionAntiquityMax=0;
  int propertiesQuantity=0, furnished=0, laundry=0, laundryRoom=0,grill=0, rooftop=0;
  int privateCondominium=0, court=0, pool=0,sauna=0,jacuzzi=0, studio=0;
  int garden=0, electricGate=0,airConditioning=0, heating=0;
  int elevator=0, warehouse=0,basement=0,balcony=0,store=0,landWalled=0;
  favoriteProperties.addAll(propertyTotalAux.where((element) => element.userPropertyFavorite.favorite));
  //inmueblesAux.removeWhere((element) => element.getUsuarioFavorito.isFavorito);
  
    if(favoriteProperties.length>0){
      favoriteProperties.sort((a,b)=>a.property.price.compareTo(b.property.price));
      priceMin=favoriteProperties.elementAt(0).property.price;
      priceMax=favoriteProperties.elementAt(favoriteProperties.length-1).property.price;
      favoriteProperties.sort((a,b)=>a.property.constructionSurface.compareTo(b.property.constructionSurface));
      constructionSurfaceMin=favoriteProperties.elementAt(0).property.constructionSurface;
      constructionSurfaceMax=favoriteProperties.elementAt(favoriteProperties.length-1).property.constructionSurface;
      favoriteProperties.sort((a,b)=>a.property.landSurface.compareTo(b.property.landSurface));
      landSurfaceMin=favoriteProperties.elementAt(0).property.landSurface;
      landSurfaceMax=favoriteProperties.elementAt(favoriteProperties.length-1).property.landSurface;
      favoriteProperties.sort((a,b)=>a.property.constructionAntiquity.compareTo(b.property.constructionAntiquity));
      constructionAntiquityMin=favoriteProperties.elementAt(0).property.constructionAntiquity;
      constructionAntiquityMax=favoriteProperties.elementAt(favoriteProperties.length-1).property.constructionAntiquity;
      favoriteProperties.sort((a,b)=>a.propertyInternal.bedroomsNumber.compareTo(b.propertyInternal.bedroomsNumber));
      bedroomsMin=favoriteProperties.elementAt(0).propertyInternal.bedroomsNumber;
      bedroomsMax=favoriteProperties.elementAt(favoriteProperties.length-1).propertyInternal.bedroomsNumber;
      favoriteProperties.sort((a,b)=>a.propertyInternal.bathroomsNumber.compareTo(b.propertyInternal.bathroomsNumber));
      bathroomsMin=favoriteProperties.elementAt(0).propertyInternal.bathroomsNumber;
      bathroomsMax=favoriteProperties.elementAt(favoriteProperties.length-1).propertyInternal.bathroomsNumber;
      favoriteProperties.sort((a,b)=>a.propertyInternal.garagesNumber.compareTo(b.propertyInternal.garagesNumber));
      garagesMin=favoriteProperties.elementAt(0).propertyInternal.garagesNumber;
      garagesMax=favoriteProperties.elementAt(favoriteProperties.length-1).propertyInternal.garagesNumber;
      propertiesQuantity=favoriteProperties.length;
      favoriteProperties.sort((a,b)=>a.propertyInternal.furnished.toString().compareTo(b.propertyInternal.furnished.toString()));
      furnished=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.furnished);
      if(furnished>propertiesQuantity) furnished=0;//
      favoriteProperties.sort((a,b)=>a.propertyInternal.laundry.toString().compareTo(b.propertyInternal.laundry.toString()));
      laundry=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.laundry);
      if(laundry>propertiesQuantity) laundry=0;//Define si es mayor a la cantidad de la lista quiere decir que no hay elementos seleccionados como true
      favoriteProperties.sort((a,b)=>a.propertyInternal.laundryRoom.toString().compareTo(b.propertyInternal.laundryRoom.toString()));
      laundryRoom=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.laundryRoom);
      if(laundryRoom>propertiesQuantity) laundryRoom=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.grill.toString().compareTo(b.propertyInternal.grill.toString()));
      grill=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.grill); 
      if(grill>propertiesQuantity) grill=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.rooftop.toString().compareTo(b.propertyInternal.rooftop.toString()));
      rooftop=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.rooftop);
      if(rooftop>propertiesQuantity) rooftop=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.privateCondominium.toString().compareTo(b.propertyInternal.privateCondominium.toString()));
      privateCondominium=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.privateCondominium);
      if(privateCondominium>propertiesQuantity) privateCondominium=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.court.toString().compareTo(b.propertyInternal.court.toString()));
      court=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.court);
      if(court>propertiesQuantity) court=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.pool.toString().compareTo(b.propertyInternal.pool.toString()));
      pool=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.pool);
      if(pool>propertiesQuantity) pool=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.sauna.toString().compareTo(b.propertyInternal.sauna.toString()));
      sauna=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.sauna);
      if(sauna>propertiesQuantity) sauna=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.jacuzzi.toString().compareTo(b.propertyInternal.jacuzzi.toString()));
      jacuzzi=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.jacuzzi);
      if(jacuzzi>propertiesQuantity) jacuzzi=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.studio.toString().compareTo(b.propertyInternal.studio.toString()));
      studio=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.studio);
      if(studio>propertiesQuantity) studio=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.garden.toString().compareTo(b.propertyInternal.garden.toString()));
      garden=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.garden);
      if(garden>propertiesQuantity) garden=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.electricGate.toString().compareTo(b.propertyInternal.electricGate.toString()));
      electricGate=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.electricGate);
      if(electricGate>propertiesQuantity) electricGate=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.airConditioning.toString().compareTo(b.propertyInternal.airConditioning.toString()));
      airConditioning=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.airConditioning);
      if(airConditioning>propertiesQuantity) airConditioning=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.heating.toString().compareTo(b.propertyInternal.heating.toString()));
      heating=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.heating);
      if(heating>propertiesQuantity) heating=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.elevator.toString().compareTo(b.propertyInternal.elevator.toString()));
      elevator=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.elevator);
      if(elevator>propertiesQuantity) elevator=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.warehouse.toString().compareTo(b.propertyInternal.warehouse.toString()));
      warehouse=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.warehouse);
      if(warehouse>propertiesQuantity) warehouse=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.basement.toString().compareTo(b.propertyInternal.basement.toString()));
      basement=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.basement);
      if(basement>propertiesQuantity) basement=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.balcony.toString().compareTo(b.propertyInternal.balcony.toString()));
      balcony=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.balcony);
      if(balcony>propertiesQuantity) balcony=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.store.toString().compareTo(b.propertyInternal.store.toString()));
      store=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.store);
      if(store>propertiesQuantity) store=0;
      favoriteProperties.sort((a,b)=>a.propertyInternal.landWalled.toString().compareTo(b.propertyInternal.landWalled.toString()));
      landWalled=propertiesQuantity-favoriteProperties.indexWhere((element) => element.propertyInternal.landWalled);
      if(landWalled>propertiesQuantity) landWalled=0;
    }
    if(favoriteProperties.length>0){
      userPropertyBases.add(
        UserPropertyBase(
          id: userId,type: "favorito",bedroomsMin:bedroomsMin,bedroomsMax:bedroomsMax,
          bathroomsMin:bathroomsMin,bathroomsMax:bathroomsMax,garagesMin:garagesMin,garagesMax:garagesMax,
          landSurfaceMin: landSurfaceMin,landSurfaceMax:landSurfaceMax,
          constructionSurfaceMin:constructionSurfaceMin,constructionSurfaceMax: constructionSurfaceMax,
          constructionAntiquityMin:constructionAntiquityMin,constructionAntiquityMax:constructionAntiquityMax,
          priceMin:priceMin,priceMax:priceMax,propertiesQuantity: propertiesQuantity,furnished: furnished,
          laundry: laundry,laundryRoom: laundryRoom,grill: grill,rooftop: rooftop,
          privateCondominium: privateCondominium,court: court,pool: pool,sauna: sauna,jacuzzi: jacuzzi,
          studio: studio,garden: garden, electricGate: electricGate, airConditioning: airConditioning,
          heating: heating, elevator:elevator, warehouse: warehouse, basement: basement, balcony: balcony,
          store: store,landWalled: landWalled,
          startDate: "",cacheDate: "",endDateSaved: "")
        );
    }else{
      userPropertyBases.add(UserPropertyBase.empty());
      userPropertyBases[0].id=userId;
    }
    viewedDoubleProperties.addAll(propertyTotalAux.where((element) => element.userPropertyFavorite.viewedDouble));
    //inmueblesAux.removeWhere((element) => element.getUsuarioFavorito.dobleVisto);
    if(viewedDoubleProperties.length>0){
      viewedDoubleProperties.sort((a,b)=>a.property.price.compareTo(b.property.price));
      priceMin=viewedDoubleProperties.elementAt(0).property.price;
      priceMax=viewedDoubleProperties.elementAt(viewedDoubleProperties.length-1).property.price;
      viewedDoubleProperties.sort((a,b)=>a.property.constructionSurface.compareTo(b.property.constructionSurface));
      constructionSurfaceMin=viewedDoubleProperties.elementAt(0).property.constructionSurface;
      constructionSurfaceMax=viewedDoubleProperties.elementAt(viewedDoubleProperties.length-1).property.constructionSurface;
      viewedDoubleProperties.sort((a,b)=>a.property.landSurface.compareTo(b.property.landSurface));
      landSurfaceMin=viewedDoubleProperties.elementAt(0).property.landSurface;
      landSurfaceMax=viewedDoubleProperties.elementAt(viewedDoubleProperties.length-1).property.landSurface;
      viewedDoubleProperties.sort((a,b)=>a.property.constructionAntiquity.compareTo(b.property.constructionAntiquity));
      constructionAntiquityMin=viewedDoubleProperties.elementAt(0).property.constructionAntiquity;
      constructionAntiquityMax=viewedDoubleProperties.elementAt(viewedDoubleProperties.length-1).property.constructionAntiquity;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.bedroomsNumber.compareTo(b.propertyInternal.bedroomsNumber));
      bedroomsMin=viewedDoubleProperties.elementAt(0).propertyInternal.bedroomsNumber;
      bedroomsMax=viewedDoubleProperties.elementAt(viewedDoubleProperties.length-1).propertyInternal.bedroomsNumber;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.bathroomsNumber.compareTo(b.propertyInternal.bathroomsNumber));
      bathroomsMin=viewedDoubleProperties.elementAt(0).propertyInternal.bathroomsNumber;
      bathroomsMax=viewedDoubleProperties.elementAt(viewedDoubleProperties.length-1).propertyInternal.bathroomsNumber;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.garagesNumber.compareTo(b.propertyInternal.garagesNumber));
      garagesMin=viewedDoubleProperties.elementAt(0).propertyInternal.garagesNumber;
      garagesMax=viewedDoubleProperties.elementAt(viewedDoubleProperties.length-1).propertyInternal.garagesNumber;
      propertiesQuantity=viewedDoubleProperties.length;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.furnished.toString().compareTo(b.propertyInternal.furnished.toString()));
      furnished=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.furnished);
      if(furnished>propertiesQuantity) furnished=0;//
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.laundry.toString().compareTo(b.propertyInternal.laundry.toString()));
      laundry=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.laundry);
      if(laundry>propertiesQuantity) laundry=0;//Define si es mayor a la cantidad de la lista quiere decir que no hay elementos seleccionados como true
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.laundryRoom.toString().compareTo(b.propertyInternal.laundryRoom.toString()));
      laundryRoom=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.laundryRoom);
      if(laundryRoom>propertiesQuantity) laundryRoom=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.grill.toString().compareTo(b.propertyInternal.grill.toString()));
      grill=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.grill); 
      if(grill>propertiesQuantity) grill=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.rooftop.toString().compareTo(b.propertyInternal.rooftop.toString()));
      rooftop=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.rooftop);
      if(rooftop>propertiesQuantity) rooftop=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.privateCondominium.toString().compareTo(b.propertyInternal.privateCondominium.toString()));
      privateCondominium=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.privateCondominium);
      if(privateCondominium>propertiesQuantity) privateCondominium=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.court.toString().compareTo(b.propertyInternal.court.toString()));
      court=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.court);
      if(court>propertiesQuantity) court=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.pool.toString().compareTo(b.propertyInternal.pool.toString()));
      pool=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.pool);
      if(pool>propertiesQuantity) pool=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.sauna.toString().compareTo(b.propertyInternal.sauna.toString()));
      sauna=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.sauna);
      if(sauna>propertiesQuantity) sauna=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.jacuzzi.toString().compareTo(b.propertyInternal.jacuzzi.toString()));
      jacuzzi=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.jacuzzi);
      if(jacuzzi>propertiesQuantity) jacuzzi=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.studio.toString().compareTo(b.propertyInternal.studio.toString()));
      studio=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.studio);
      if(studio>propertiesQuantity) studio=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.garden.toString().compareTo(b.propertyInternal.garden.toString()));
      garden=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.garden);
      if(garden>propertiesQuantity) garden=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.electricGate.toString().compareTo(b.propertyInternal.electricGate.toString()));
      electricGate=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.electricGate);
      if(electricGate>propertiesQuantity) electricGate=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.airConditioning.toString().compareTo(b.propertyInternal.airConditioning.toString()));
      airConditioning=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.airConditioning);
      if(airConditioning>propertiesQuantity) airConditioning=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.heating.toString().compareTo(b.propertyInternal.heating.toString()));
      heating=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.heating);
      if(heating>propertiesQuantity) heating=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.elevator.toString().compareTo(b.propertyInternal.elevator.toString()));
      elevator=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.elevator);
      if(elevator>propertiesQuantity) elevator=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.warehouse.toString().compareTo(b.propertyInternal.warehouse.toString()));
      warehouse=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.warehouse);
      if(warehouse>propertiesQuantity) warehouse=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.basement.toString().compareTo(b.propertyInternal.basement.toString()));
      basement=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.basement);
      if(basement>propertiesQuantity) basement=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.balcony.toString().compareTo(b.propertyInternal.balcony.toString()));
      balcony=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.balcony);
      if(balcony>propertiesQuantity) balcony=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.store.toString().compareTo(b.propertyInternal.store.toString()));
      store=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.store);
      if(store>propertiesQuantity) store=0;
      viewedDoubleProperties.sort((a,b)=>a.propertyInternal.landWalled.toString().compareTo(b.propertyInternal.landWalled.toString()));
      landWalled=propertiesQuantity-viewedDoubleProperties.indexWhere((element) => element.propertyInternal.landWalled);
      if(landWalled>propertiesQuantity) landWalled=0;
    }
    if(viewedDoubleProperties.length>0){
      userPropertyBases.add(
        UserPropertyBase(
          id: userId,type: "doble_visto",bedroomsMin:bedroomsMin,bedroomsMax:bedroomsMax,
          bathroomsMin:bathroomsMin,bathroomsMax:bathroomsMax,garagesMin:garagesMin,garagesMax:garagesMax,
          landSurfaceMin: landSurfaceMin,landSurfaceMax:landSurfaceMax,
          constructionSurfaceMin:constructionSurfaceMin,constructionSurfaceMax: constructionSurfaceMax,
          constructionAntiquityMin:constructionAntiquityMin,constructionAntiquityMax:constructionAntiquityMax,
          priceMin:priceMin,priceMax:priceMax,propertiesQuantity: propertiesQuantity,furnished: furnished,
          laundry: laundry,laundryRoom: laundryRoom,grill: grill,rooftop: rooftop,
          privateCondominium: privateCondominium,court: court,pool: pool,sauna: sauna,jacuzzi: jacuzzi,
          studio: studio,garden: garden, electricGate: electricGate, airConditioning: airConditioning,
          heating: heating, elevator:elevator, warehouse: warehouse, basement: basement, balcony: balcony,
          store: store,landWalled: landWalled,
          startDate: "",cacheDate: "",endDateSaved: "")
        );
    }else{
      userPropertyBases.add(UserPropertyBase.empty(
      ));
      userPropertyBases[1].id=userId;
    }
   
    viewedProperties.addAll(propertyTotalAux.where((element) => element.userPropertyFavorite.viewed));
    //inmueblesAux.removeWhere((element) => element.getUsuarioFavorito.visto);
    if(viewedProperties.length>0){
      viewedProperties.sort((a,b)=>a.property.price.compareTo(b.property.price));
      priceMin=viewedProperties.elementAt(0).property.price;
      priceMax=viewedProperties.elementAt(viewedProperties.length-1).property.price;
      viewedProperties.sort((a,b)=>a.property.constructionSurface.compareTo(b.property.constructionSurface));
      constructionSurfaceMin=viewedProperties.elementAt(0).property.constructionSurface;
      constructionSurfaceMax=viewedProperties.elementAt(viewedProperties.length-1).property.constructionSurface;
      viewedProperties.sort((a,b)=>a.property.landSurface.compareTo(b.property.landSurface));
      landSurfaceMin=viewedProperties.elementAt(0).property.landSurface;
      landSurfaceMax=viewedProperties.elementAt(viewedProperties.length-1).property.landSurface;
      viewedProperties.sort((a,b)=>a.property.constructionAntiquity.compareTo(b.property.constructionAntiquity));
      constructionAntiquityMin=viewedProperties.elementAt(0).property.constructionAntiquity;
      constructionAntiquityMax=viewedProperties.elementAt(viewedProperties.length-1).property.constructionAntiquity;
      viewedProperties.sort((a,b)=>a.propertyInternal.bedroomsNumber.compareTo(b.propertyInternal.bedroomsNumber));
      bedroomsMin=viewedProperties.elementAt(0).propertyInternal.bedroomsNumber;
      bedroomsMax=viewedProperties.elementAt(viewedProperties.length-1).propertyInternal.bedroomsNumber;
      viewedProperties.sort((a,b)=>a.propertyInternal.bathroomsNumber.compareTo(b.propertyInternal.bathroomsNumber));
      bathroomsMin=viewedProperties.elementAt(0).propertyInternal.bathroomsNumber;
      bathroomsMax=viewedProperties.elementAt(viewedProperties.length-1).propertyInternal.bathroomsNumber;
      viewedProperties.sort((a,b)=>a.propertyInternal.garagesNumber.compareTo(b.propertyInternal.garagesNumber));
      garagesMin=viewedProperties.elementAt(0).propertyInternal.garagesNumber;
      garagesMax=viewedProperties.elementAt(viewedProperties.length-1).propertyInternal.garagesNumber;
      propertiesQuantity=favoriteProperties.length;
      viewedProperties.sort((a,b)=>a.propertyInternal.furnished.toString().compareTo(b.propertyInternal.furnished.toString()));
      furnished=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.furnished);
      if(furnished>propertiesQuantity) furnished=0;//
      viewedProperties.sort((a,b)=>a.propertyInternal.laundry.toString().compareTo(b.propertyInternal.laundry.toString()));
      laundry=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.laundry);
      if(laundry>propertiesQuantity) laundry=0;//Define si es mayor a la cantidad de la lista quiere decir que no hay elementos seleccionados como true
      viewedProperties.sort((a,b)=>a.propertyInternal.laundryRoom.toString().compareTo(b.propertyInternal.laundryRoom.toString()));
      laundryRoom=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.laundryRoom);
      if(laundryRoom>propertiesQuantity) laundryRoom=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.grill.toString().compareTo(b.propertyInternal.grill.toString()));
      grill=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.grill); 
      if(grill>propertiesQuantity) grill=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.rooftop.toString().compareTo(b.propertyInternal.rooftop.toString()));
      rooftop=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.rooftop);
      if(rooftop>propertiesQuantity) rooftop=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.privateCondominium.toString().compareTo(b.propertyInternal.privateCondominium.toString()));
      privateCondominium=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.privateCondominium);
      if(privateCondominium>propertiesQuantity) privateCondominium=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.court.toString().compareTo(b.propertyInternal.court.toString()));
      court=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.court);
      if(court>propertiesQuantity) court=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.pool.toString().compareTo(b.propertyInternal.pool.toString()));
      pool=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.pool);
      if(pool>propertiesQuantity) pool=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.sauna.toString().compareTo(b.propertyInternal.sauna.toString()));
      sauna=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.sauna);
      if(sauna>propertiesQuantity) sauna=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.jacuzzi.toString().compareTo(b.propertyInternal.jacuzzi.toString()));
      jacuzzi=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.jacuzzi);
      if(jacuzzi>propertiesQuantity) jacuzzi=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.studio.toString().compareTo(b.propertyInternal.studio.toString()));
      studio=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.studio);
      if(studio>propertiesQuantity) studio=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.garden.toString().compareTo(b.propertyInternal.garden.toString()));
      garden=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.garden);
      if(garden>propertiesQuantity) garden=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.electricGate.toString().compareTo(b.propertyInternal.electricGate.toString()));
      electricGate=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.electricGate);
      if(electricGate>propertiesQuantity) electricGate=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.airConditioning.toString().compareTo(b.propertyInternal.airConditioning.toString()));
      airConditioning=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.airConditioning);
      if(airConditioning>propertiesQuantity) airConditioning=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.heating.toString().compareTo(b.propertyInternal.heating.toString()));
      heating=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.heating);
      if(heating>propertiesQuantity) heating=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.elevator.toString().compareTo(b.propertyInternal.elevator.toString()));
      elevator=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.elevator);
      if(elevator>propertiesQuantity) elevator=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.warehouse.toString().compareTo(b.propertyInternal.warehouse.toString()));
      warehouse=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.warehouse);
      if(warehouse>propertiesQuantity) warehouse=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.basement.toString().compareTo(b.propertyInternal.basement.toString()));
      basement=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.basement);
      if(basement>propertiesQuantity) basement=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.balcony.toString().compareTo(b.propertyInternal.balcony.toString()));
      balcony=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.balcony);
      if(balcony>propertiesQuantity) balcony=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.store.toString().compareTo(b.propertyInternal.store.toString()));
      store=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.store);
      if(store>propertiesQuantity) store=0;
      viewedProperties.sort((a,b)=>a.propertyInternal.landWalled.toString().compareTo(b.propertyInternal.landWalled.toString()));
      landWalled=propertiesQuantity-viewedProperties.indexWhere((element) => element.propertyInternal.landWalled);
      if(landWalled>propertiesQuantity) landWalled=0;
    }
    if(viewedProperties.length>0){
      userPropertyBases.add(
        UserPropertyBase(
          id: userId,type: "vistro",bedroomsMin:bedroomsMin,bedroomsMax:bedroomsMax,
          bathroomsMin:bathroomsMin,bathroomsMax:bathroomsMax,garagesMin:garagesMin,garagesMax:garagesMax,
          landSurfaceMin: landSurfaceMin,landSurfaceMax:landSurfaceMax,
          constructionSurfaceMin:constructionSurfaceMin,constructionSurfaceMax: constructionSurfaceMax,
          constructionAntiquityMin:constructionAntiquityMin,constructionAntiquityMax:constructionAntiquityMax,
          priceMin:priceMin,priceMax:priceMax,propertiesQuantity: propertiesQuantity,furnished: furnished,
          laundry: laundry,laundryRoom: laundryRoom,grill: grill,rooftop: rooftop,
          privateCondominium: privateCondominium,court: court,pool: pool,sauna: sauna,jacuzzi: jacuzzi,
          studio: studio,garden: garden, electricGate: electricGate, airConditioning: airConditioning,
          heating: heating, elevator:elevator, warehouse: warehouse, basement: basement, balcony: balcony,
          store: store,landWalled: landWalled,
          startDate: "",cacheDate: "",endDateSaved: "")
        );
    }else{
      userPropertyBases.add(UserPropertyBase.empty(
      ));
      userPropertyBases[2].id=userId;
    }
    return userPropertyBases;
}