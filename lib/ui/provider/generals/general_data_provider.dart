import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_zone.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/usecases/general/usecase_generals.dart';

class GeneralDataProvider with ChangeNotifier{
  List<City> _cities=[];
  
  List<Zone> _zonesAll=[];
  List<Zone> _zonesCity=[];
  List<Zone> _zonesFree=[];
  City _citySelected=City.empty();
 
  UseCaseGenerals _useCaseGenerals=UseCaseGenerals();

  Future<bool> init()async{
    bool completed=true;
    await _useCaseGenerals.getGeneralsPlaces()
    .then((response) {
      if(response["completed"]){
        _cities=response["cities"];
        _zonesAll=response["zones"];
      }else{
        completed=false;
      }
    });
    return completed;
  }
  
  

  void setCities(List<City> cities){
    this._cities=cities;
  }
  List<City> get cities => _cities;

  
  void setZones(List<Zone> zones){
    _zonesAll=zones;
    selectZonesCity(_cities[0].id);
  }
  List<Zone> get zonesAll => _zonesAll;
  
  void selectZonesCity(String cityId,{bool selector=true}){
    _zonesCity=[];
    if(selector){
      _zonesCity.add(Zone.empty());
      _zonesCity[0].zoneName="Cualquiera";
    }
    _zonesCity.addAll(_zonesAll.where((element) => element.cityId==cityId));
    notifyListeners();
  }

  List<Zone> get zonesCity => _zonesCity;

  List<Zone> zonesCityOrigin(String cityName){
    print(cityName);
    _cities.forEach((element) { 
      print(element.cityName);
    });
    String cityId=_cities.where((element) => element.cityName==cityName).first.id;
    return _zonesAll.where((element) => element.cityId==cityId).toList();
  }

  void setCity(c){
    this._citySelected=c;
  }

  void setCitySelected(City city){
    if(_citySelected.id!=city.id){
      _citySelected=City.copyWith(city);
      selectZonesCity(city.id,selector: false);
    }else{
      _citySelected=City.empty();
      _zonesCity=[];
    }
    notifyListeners();
  }

  City get citySelected => _citySelected;

  void selectZonesFrees(List<AdministratorZone> administratorZones){
    _zonesFree=[];
    for(int i=1;i<_zonesFree.length;i++){
      int contador=0;
      for(int j=0;j<administratorZones.length;j++){
        if(administratorZones[j].zone.id==_zonesFree[i].id){
          contador++;
          break;
        }
      }
      if(contador==0){
        _zonesFree.add(_zonesCity[i]);
      }
    }
    notifyListeners();
  }
  List<Zone> get zonesFree => _zonesFree;

  

}