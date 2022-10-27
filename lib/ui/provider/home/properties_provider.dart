import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/publicity.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/usecases/property/filter_properties.dart' as filter_properties;
import 'package:inmobiliariaapp/domain/usecases/property/generate_property_base.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_base.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publicities_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_widget_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_adminitrator_requests_provider.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_notification_user_requests_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_properties_searcheds.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/user_property_favorite.dart';
import '../user/user_provider.dart';
import 'filter_comunity_provider.dart';
import 'filter_general_provider.dart';
import 'filter_internal_provider.dart';
import 'filter_main_provider.dart';
import 'filter_others_provider.dart';
import 'filter_user_provider.dart';

class PropertiesProvider with ChangeNotifier{
  bool _loadingQueryDB=true;
  bool _errorQueryDB=false;
  PropertyTotal inmuebleTotal=PropertyTotal.empty();
  PropertyTotal inmuebleTotalCopia=PropertyTotal.empty();
  PropertyTotal inmuebleReportado=PropertyTotal.empty();
  
  List<PropertyTotal> _propertiesGeneral=[];
  List<PropertyTotal> _propertiesFilter=[];
  List<PropertyTotal> _propertiesStack=[];
  List<PropertyTotal> _propertiesNew=[];
  List<PropertyTotal> _propertiesSearcheds=[];
  List<PropertyTotal> _propertiesSimilars=[];

  List<Publicity> _publicities=[];
  List<Publicity> _publicitySquare=[];
  List<Publicity> _publicityRectangle=[];

  UseCaseProperty _useCaseProperty=UseCaseProperty();

  Future<void> init({required BuildContext context})async{
    await propertiesGeneralDB(context:context);
  }

  List<Zone> zonas=[];

  List<PropertyTotal> get propertiesGeneral => _propertiesGeneral;  

  void addPropertiesStack(PropertyTotal propertyTotal,{required BuildContext context}){
    _propertiesStack.add(propertyTotal);
    final sessionType=context.read<UserProvider>().sessionType;
    if(_propertiesStack.length==1){
      if(sessionType=="Administrar"){
        context.read<PropertyAdministratorRequestsProvider>().loadAdministratorsRequests(context: context);
      }
      if(sessionType=="Supervisar"){
        context.read<PropertyAdministratorRequestsProvider>().loadAdministratorsRequestsSuperUser(context: context);
      }
      if(sessionType=="Vender"){
        context.read<PropertyNotificationUserRequestsProvider>().loadNotificationUserRequestProperty(context: context);
      }
    }
    
    if(_propertiesStack.length>1){
      context.read<PropertiesWidgetProvider>().loadConfig(property: propertyTotal.property);
    }

    loadPropertiesSimilar(sessionType);
    notifyListeners();
  }

  void removePropertiesStack({required BuildContext context}){
    final sessionType=context.read<UserProvider>().sessionType;
    _propertiesStack.removeLast();
    if(_propertiesStack.length>0) {
      loadPropertiesSimilar(sessionType);
      context.read<PropertiesWidgetProvider>().loadConfig(property: propertyTotalLast.property);
      notifyListeners();
    }
    
  }

  List<PropertyTotal> get propertiesStack => _propertiesStack;

  void loadPropertiesSimilar(String sessionType){
    if(_propertiesStack.length>0){
      if(sessionType=="Comprar"){
        _propertiesSimilars=[];
        _propertiesSimilars.addAll(filter_properties.selectPropertiesSimilars(_propertiesGeneral, _propertiesStack[_propertiesStack.length-1]));
       // notifyListeners();
      }
    }
  }
  List<PropertyTotal> get propertiesSimilars => _propertiesSimilars;

  void deleteWherePropertiesGeneralLast({required BuildContext context}){
    _propertiesGeneral.removeWhere((element) => element.property.id==propertyTotalLast.property.id);
    filterProperties(context: context);
    notifyListeners();
  }

  void notify(){
    notifyListeners();
  }

  PropertyTotal get propertyTotalLast =>_propertiesStack.length>0?_propertiesStack[_propertiesStack.length-1]:PropertyTotal.empty();
  
  void setInmueblesTotal(PropertyTotal inmuebleTotal){
    this.inmuebleTotal=inmuebleTotal;
    this.inmuebleTotalCopia=PropertyTotal.copyWith(inmuebleTotal);
    notifyListeners();
  }
  void setInmuebleTotalCopia(PropertyTotal inmuebleTotal){
    this.inmuebleTotalCopia=inmuebleTotal;
    notifyListeners();
  }
  void setInmuebleReportado(PropertyTotal inmuebleTotal){
    this.inmuebleReportado=inmuebleTotal;
  }
  PropertyTotal get getInmuebleTotal{
    return this.inmuebleTotal;
  }
  PropertyTotal get getInmuebleTotalCopia{
    return this.inmuebleTotalCopia;
  }
  void setZonas(List<Zone> zonass){
    this.zonas=zonass;
    notifyListeners();
  }
  List<Zone> get getZonas{
    return this.zonas;
  }
  void setPropietario(User propietario){
    this.inmuebleTotal.owner=propietario;
    notifyListeners();
  }

  bool get loadingQueryDB => _loadingQueryDB;
  bool get errorQueryDB => _errorQueryDB;

  List<PropertyTotal> get propertiesFilter => _propertiesFilter;

  Map<String,dynamic> _mapFilterAll({required BuildContext context}){
    final filterGeneralProvider=context.read<FilterGeneralProvider>();
    final filterInternalProvider=context.read<FilterInternalProvider>();
    final filterComunityProvider=context.read<FilterComunityProvider>();
    final filterOthersProvider=context.read<FilterOthersProvider>();
    final filterUserProvider=context.read<FilterUserProvider>();
    final filterMainProvider=context.read<FilterMainProvider>();
    Map<String,dynamic> mapFilter={};
    mapFilter.addAll(filterMainProvider.mapFilter);
    mapFilter.addAll(filterGeneralProvider.mapFilter);
    mapFilter.addAll(filterGeneralProvider.mapFilterPlus);
    mapFilter.addAll(filterInternalProvider.mapFilter);
    mapFilter.addAll(filterInternalProvider.mapFilterPlus);
    mapFilter.addAll(filterComunityProvider.mapFilter);
    mapFilter.addAll(filterComunityProvider.mapFilterPlus);
    mapFilter.addAll(filterOthersProvider.mapFilter);
    mapFilter.addAll(filterOthersProvider.mapFilterPlus);
    mapFilter.addAll(filterUserProvider.mapFilter);
    mapFilter.addAll(filterUserProvider.mapFilterPlus);
    return mapFilter;
  }

  Future<void> propertiesGeneralDB({required BuildContext context})async{
    _loadingQueryDB=true;
    notifyListeners();
    final city=context.read<FilterMainProvider>().mapFilter["city"];
    final userProvider=context.read<UserProvider>();
    final userPropertiesSearcheds=context.read<UserPropertiesSearchedsProvider>().userPropertiesSearcheds;
    await _useCaseProperty.getProperties(userProvider.user, userProvider.sessionType, city)
    .then((response){
      if(response["completed"]){
        _propertiesGeneral=[];
        _propertiesGeneral.addAll(response["properties_total"]);
        _publicities=[];
        _publicities.addAll(response["publicities"]);
        _propertiesSearcheds=[];
        for(int i=0;i<userPropertiesSearcheds.length;i++){
          Map<String,dynamic> mapFilter={};
          mapFilter.addAll(userPropertiesSearcheds[i].toMap());
          mapFilter.addAll({"penultimate_entry_date":userProvider.user.penultimateEntryDate});
          _propertiesSearcheds.addAll(filter_properties.filterProperties(_propertiesGeneral, mapFilter));
        }
        _propertiesNew=[];
        UserPropertyBase base=userProvider.userPropertyBases.length>1?userProvider.userPropertyBases[1]:UserPropertyBase.empty();
        Map<String,dynamic> mapFilter={};
        mapFilter.addAll(base.toMapFilter());
        mapFilter.addAll({"session_type":userProvider.sessionType});
        _propertiesNew.addAll(filter_properties.filterProperties(_propertiesGeneral, mapFilter));
        filterProperties(context: context);
        _errorQueryDB=false;
      }else{
        _errorQueryDB=true;
      }
    });
    _loadingQueryDB=false;
    notifyListeners();
  }

  void addPropertiesGeneral({required PropertyTotal propertyTotal,required BuildContext context}){
    _propertiesGeneral.add(PropertyTotal.copyWith(propertyTotal));
    filterProperties(context: context);
    notifyListeners();
  }

  void updatePropertiesGeneral({required PropertyTotal propertyTotal,required BuildContext context}){
    //_propertiesStack[_propertiesStack.length-1]=propertyTotal;
    int index=_propertiesGeneral.lastIndexWhere((element) => element.property.id==propertyTotal.property.id);
    _propertiesStack[0]=PropertyTotal.copyWith(propertyTotal);
    _propertiesGeneral[index]=PropertyTotal.copyWith(propertyTotal);
    filterProperties(context: context);
    notifyListeners();
  }

  void filterProperties({required BuildContext context}){
    final filterMainProvider=context.read<FilterMainProvider>();
    final filterOthersProvider=context.read<FilterOthersProvider>();
    final userProvider=context.read<UserProvider>();
    Map<String,dynamic> mapFilter=_mapFilterAll(context: context);
    filter_properties.filterProperties(_propertiesGeneral, mapFilter);
    List<PropertyTotal> propertiesAux=[];
    propertiesAux=filter_properties.filterProperties(_propertiesGeneral,mapFilter);
    if(userProvider.sessionType=="Comprar"){
      _propertiesFilter=[];
      if(filterOthersProvider.mapFilterOrder["parameter"]!=GetParameterOrder.defaults.index){
        propertiesFilter.addAll(propertiesAux);
        filter_properties.sortList(_propertiesFilter, filterOthersProvider.mapFilterOrder);
        filter_properties.addPublicityProperties(_propertiesFilter);
      }else{
        _propertiesFilter.addAll(filter_properties.filterPropertiesOrderBase(propertiesAux, filterOthersProvider, userProvider.userPropertyBases, filterMainProvider));
        
      }
    }else{
      filter_properties.sortList(propertiesAux, filterOthersProvider.mapFilterOrder);
      _propertiesFilter=[];
      _propertiesFilter.addAll(propertiesAux);
    }
    context.read<WidgetStatusProvider>().init();
    final datosGenerales=context.read<PublicitiesProvider>();
    _publicitySquare=[];
    _publicityRectangle=[];
    _publicitySquare.addAll(
      _publicities.where((element) => 
      element.publicityType=="Cuadrado"
      //element.minPrice==filterGeneralProvider.mapFilter["price_min"]&&
      //element.maxPrice==filterGeneralProvider.mapFilter["price_max"]&&
      //element.contractType==filterMainProvider.mapFilter["contract_type"]&&
      //element.propertyType==filterMainProvider.mapFilter["property_type"]
    ));
    _publicityRectangle.addAll(
      _publicities.where((element) => 
      element.publicityType!="Cuadrado"
      //element.minPrice==filterGeneralProvider.mapFilter["price_min"]&&
      //element.maxPrice==filterGeneralProvider.mapFilter["price_max"]&&
      //element.contractType==filterMainProvider.mapFilter["contract_type"]&&
      //element.propertyType==filterMainProvider.mapFilter["property_type"]
    ));
    datosGenerales.setPublicitiesSquare(_publicitySquare);
    datosGenerales.setPublicitiesRectangle(_publicityRectangle);
    notifyListeners();
  }

  void registerPropertyFavorite({
    required BuildContext context,required Future<SharedPreferences> prefs,required PropertyTotal propertyTotal,bool viewed=false,bool viewedDouble=false,bool favorite=false,bool contacted=false
  })async{
    PropertyTotal propertyTotalCopy=PropertyTotal.copyWith(propertyTotal);
    if(viewed){
      propertyTotal.userPropertyFavorite.viewed=true;
    }
    if(viewedDouble){
      propertyTotal.userPropertyFavorite.viewedDouble=true;
      propertyTotal.userPropertyFavorite.viewed=true;
    }
    if(favorite){
      propertyTotal.userPropertyFavorite.viewedDouble=true;
      propertyTotal.userPropertyFavorite.viewed=true;
      propertyTotal.userPropertyFavorite.favorite=!propertyTotal.userPropertyFavorite.favorite;
      if(propertyTotal.userPropertyFavorite.favorite){
        propertyTotal.property.favoritesQuantity++;
      }else{
        propertyTotal.property.favoritesQuantity--;
      }
    }
    if(contacted){
      propertyTotal.userPropertyFavorite.contacted=true;
    }
    notifyListeners();
    final userProvider=context.read<UserProvider>();

    await _useCaseProperty.registerPropertyFavorite(userProvider.user, propertyTotal)
    .then((completed) {
      if(!completed){
        int index=_propertiesGeneral.lastIndexWhere((element) => element.property.id==propertyTotal.property.id);
        _propertiesGeneral.replaceRange(index, index+1, [propertyTotalCopy]);
        notifyListeners();
      }else{
        print("ok");
        userProvider.setUserPropertyBases(generatePropertyBase(userProvider.user.id, _propertiesGeneral));
        UseCasePropertyBase useCasePropertyBase=UseCasePropertyBase();
        useCasePropertyBase.registerPropertyBase(userProvider.userPropertyBases, prefs).whenComplete(() {});
      }
    });
  }
}
