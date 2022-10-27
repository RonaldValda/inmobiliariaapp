import 'package:flutter/cupertino.dart';

import '../../../domain/entities/generals.dart';
import '../../../domain/usecases/general/usecase_generals.dart';

class RegistrationPlacesProvider extends ChangeNotifier{
  TextEditingController _controllerLatitude1=TextEditingController(text:"");
  TextEditingController _controllerLongitude1=TextEditingController(text: "");
  TextEditingController _controllerLatitude2=TextEditingController(text: "");
  TextEditingController _controllerLongitude2=TextEditingController(text: "");
  TextEditingController _controllerZoneName=TextEditingController(text: "");
  List<Zone> _zonesNotSelected=[];
  List<Zone> _zonesCity=[];
  Zone _zoneSelected=Zone.empty();
  City _citySelected=City.empty();
  List<Departament> _departaments=[];
  List<City> _departamentCities=[];
  List<City> _cities=[];
  Departament _departamentSelected=Departament.empty();
  UseCaseGenerals _useCaseGenerals=UseCaseGenerals();
  bool _zoneModeList=true;
  @override
  void dispose() {
    _controllerLatitude1.dispose();
    _controllerLatitude2.dispose();
    _controllerLongitude1.dispose();
    _controllerLongitude2.dispose();
    _controllerZoneName.dispose();
    super.dispose();
  }

  TextEditingController get controllerLatitude1 => _controllerLatitude1;
  TextEditingController get controllerLongitude1 => _controllerLongitude1;
  TextEditingController get controllerLatitude2 => _controllerLatitude2;
  TextEditingController get controllerLongitude2 => _controllerLongitude2;
  TextEditingController get controllerZoneName => _controllerZoneName;

  void setZoneModeList(bool value){
    _zoneModeList=value;
    notifyListeners();
  }
  bool get zoneModeList => _zoneModeList;

  void loadDepartaments(){
    _useCaseGenerals.getDepartaments()
    .then((response) {
      if(response["completed"]){
        _departaments=response["departaments"];
        _departaments.sort((a,b)=>a.departamentName.compareTo(b.departamentName));
        notifyListeners();
      }
    });
  }
  void setDepartaments(List<Departament> departaments){
    this._departaments=departaments;
  }

  List<Departament> get departaments => _departaments;

  void selectZonesCity(String cityId,List<Zone> zones){
    _zonesCity=[];
    _zonesCity.addAll(zones.where((element) => element.cityId==cityId));
    notifyListeners();
  }
  List<Zone> get zonesCity => _zonesCity;

  void setCitySelected(City city,List<Zone> zones){
    if(_citySelected.id!=city.id){
      _citySelected=City.copyWith(city);
      selectZonesCity(city.id,zones);
    }else{
      _citySelected=City.empty();
      _zonesCity=[];
    }
    _zoneSelected=Zone.empty();
    notifyListeners();
  }

  City get citySelected => _citySelected;

  //* CRUD departamentos
  Future<bool> registerDepartament(Departament departament)async{
    bool responseOk=false;
    await _useCaseGenerals.registerDepartament(departament.departamentName)
    .then((response) {
      if(response["completed"]){
        responseOk=true;
        _departaments.add(Departament.copyWith(response["departament"]));
        _departaments.sort((a,b)=>a.departamentName.compareTo(b.departamentName));
        notifyListeners();
      }
    });
    return responseOk;
  }

  Future<bool> updateDepartament(Departament departament)async{
    bool responseOk=false;
    await _useCaseGenerals.updateDepartament(departament.id, departament.departamentName)
    .then((completed) {
      if(completed){
        responseOk=true;
        int index=_departaments.lastIndexWhere((element) => element.id==departament.id);
        _departaments[index].departamentName=departament.departamentName;
        notifyListeners();
      }
    });
    return responseOk;
  }

  Future<bool> deleteDepartament(Departament departament)async{
    bool responseOk=false;
    await _useCaseGenerals.deleteDepartament(departament.id)
    .then((completed) {
      if(completed){
        _departaments.removeWhere((element) => element.id==departament.id);
        _departamentSelected=Departament.empty();
        _departamentCities=[];
        notifyListeners();
      }
    });
    return responseOk;
  }

  void loadDepartamentCities(){

  }
  List<City> get departamentCities => _departamentCities;

  void setDepartamentSelected(Departament departament)async{
    if(_departamentSelected.id!=departament.id){
      _departamentSelected=Departament.copyWith(departament);
      await _useCaseGenerals.getCities(_departamentSelected.id)
      .then((response) {
        if(response["completed"]){
          _departamentCities=response["cities"];
          _cities.sort((a,b)=>a.cityName.compareTo(b.cityName));
        }
      });
    }else{
      _departamentSelected=Departament.empty();
      _departamentCities=[];
    }
    _citySelected=City.empty();
    notifyListeners();
  }

  Departament get departamentSelected => _departamentSelected;

  //* CRUD Ciudades
  Future<bool> registerCity(City city)async{
    bool responseOk=false;
    await _useCaseGenerals.registerCity(_departamentSelected.id,city.cityName)
    .then((response) {
      if(response["completed"]){
        responseOk=true;
        _departamentCities.add(City.copyWith(response["city"]));
        _departamentCities.sort((a,b)=>a.cityName.compareTo(b.cityName));
        notifyListeners();
      }
    });
    return responseOk;
  }

  Future<bool> updateCity(City city)async{
    bool responseOk=false;
    await _useCaseGenerals.updateCity(city.id, city.cityName)
    .then((completed) {
      if(completed){
        responseOk=true;
        int index=_departamentCities.lastIndexWhere((element) => element.id==city.id);
        _departamentCities[index].cityName=city.cityName;
        notifyListeners();
      }
    });
    return responseOk;
  }

  Future<bool> deleteCity(City city)async{
    bool responseOk=false;
    await _useCaseGenerals.deleteCity(city.id)
    .then((completed) {
      if(completed){
        _departamentCities.removeWhere((element) => element.id==city.id);
        _citySelected=City.empty();

        notifyListeners();
      }
    });
    return responseOk;
  }

  //* CRUD Zonas

  void setZoneSelected(Zone zone){
    if(_zoneSelected.id!=zone.id){
      _zoneSelected=Zone.copyWith(zone);
      _zonesNotSelected=[];
      _zonesNotSelected.addAll(_zonesCity.where((element) => element.zoneName!=_zoneSelected.zoneName&&element.area!=_zoneSelected.area));
    }else{
      _zoneSelected=Zone.empty();
      _zonesNotSelected=[];
      _zonesNotSelected.addAll(_zonesCity);
    }
    _controllerLatitude1.text=_zoneSelected.area[0][0].toString();
    _controllerLongitude1.text=_zoneSelected.area[0][1].toString();
    _controllerLatitude2.text=_zoneSelected.area[1][0].toString();
    _controllerLongitude2.text=_zoneSelected.area[1][1].toString();
    _controllerZoneName.text=_zoneSelected.zoneName;
    notifyListeners();
  }

  void setZoneSelectedAreaItem({required int pointNumber,required int index,required double coordinate}){
    _zoneSelected.area[pointNumber][index]=coordinate;
    notifyListeners();
  }

  void notify(){
    notifyListeners();
  }

  Zone get zoneSelected => _zoneSelected;
  
  List<Zone> get zonesNotSelected => _zonesNotSelected;

}