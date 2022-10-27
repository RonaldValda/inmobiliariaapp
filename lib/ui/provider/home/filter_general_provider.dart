import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/ui/pages/utils/constants.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';

class FilterGeneralProvider with ChangeNotifier{
  Map<String,dynamic> _mapSelectableData={};
  Map<String,dynamic> _mapValuesSelectableData={};
  Map<String,dynamic> _mapFilter={
    "land_surface_min":0,
    "land_surface_max":-1,
    "land_surface_sel":"Cualquiera",
    "construction_surface_min":0,
    "construction_surface_max":-1,
    "construction_surface_sel":"Cualquiera",
    "front_size_min":0,
    "front_size_max":-1,
    "front_size_sel":"Cualquiera",
    "construction_antiquity_min":0,
    "construction_antiquity_max":-1,
    "construction_antiquity_sel":"Cualquiera",
  };
  bool _loading=false;
  Map<String,dynamic> _mapFilterPlus={
    "enable_pets":false,
    "no_mortgage":false,
    "new_construction":false,
    "premium_materials":false,
    "pre_sale_project":false,
    "shared_property":false,
    "owners_number":1,
    "basic_services":false,
    "household_gas":false,
    "wifi":false,
    "independent_meter":false,
    "hot_water_tank":false,
    "paved_street":false,
    "transport":false,
    "disability_prepared":false,
    "order_papers":false,
    "enabled_credit":false,
  };

  Map<String,dynamic> get mapSelectableData => _mapSelectableData;

  Map<String,dynamic> get mapFilter => _mapFilter;


  void setMapFilterItem(String key,dynamic value,{bool selectable=false,required BuildContext context}){
    if(selectable){
      int index=_mapSelectableData[key].lastIndexOf(value);
      _mapFilter[key+"_sel"]=value;
      _mapFilter[key+"_min"]=_mapValuesSelectableData[key][index][0];
      _mapFilter[key+"_max"]=_mapValuesSelectableData[key][index][1];
    }else{
      this._mapFilter[key]=value;
    }
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }

  
  void setMapFilterItemRange(String key,dynamic value,{required BuildContext context}){
    int index=_mapValuesSelectableData[key].lastIndexWhere((element) => value>=element[0]&&value<element[1]);
    if(index<0){
      index=_mapValuesSelectableData[key].length-1;
    }
    _mapFilter[key+"_sel"]=_mapSelectableData[key][index];
    _mapFilter[key+"_min"]=_mapValuesSelectableData[key][index][0];
    _mapFilter[key+"_max"]=_mapValuesSelectableData[key][index][1];
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }

  void setMapFilterItem2(String key1,dynamic value1,String key2,dynamic value2){
    this._mapFilter[key1]=value1;
    this._mapFilter[key2]=value2;
    notifyListeners();
  }
  Map<String,dynamic> get mapFilterPlus => _mapFilterPlus;
  /*void setMapaFiltroMas(Map<String,dynamic> mapaFiltro){
    this._mapaFiltroMas=mapaFiltro;
    notifyListeners();
  }*/
  void setMapFilterPlusItem(String key,dynamic value,{required BuildContext context}){
    this._mapFilterPlus[key]=value;
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  void setMapFilterPlusItem2(String key1,dynamic value1,String key2,dynamic value2){
    this._mapFilterPlus[key1]=value1;
    this._mapFilterPlus[key2]=value2;
    notifyListeners();
  }
  void setLoading(bool valor){
    this._loading=valor;
    notifyListeners();
  }
  bool get loading => _loading;

  void init(){
    _mapSelectableData={
      "land_surface":Constants.landSurfaces,
      "construction_surface":Constants.constructionSurfaces,
      "construction_antiquity":Constants.constructionAntiquitys,
      "front_size":Constants.frontSizes
    };
    _mapValuesSelectableData={
      "land_surface":Constants.valuesLandSurfaces,
      "construction_surface":Constants.valuesConstructionSurfaces,
      "construction_antiquity":Constants.valuesConstructionAntiquitys,
      "front_size":Constants.valuesFrontSizes
    };
    _mapFilter.forEach((key, value) { 
      if(value is int){
        if(key.substring(key.length-3,key.length)=="min"){
          _mapFilter[key]=0;
        }else{
          _mapFilter[key]=-1;
        }
      }else{
        _mapFilter[key]="Cualquiera";
      }
    });
    _mapFilterPlus.forEach((key, value) { 
      if(value is bool){
        _mapFilterPlus[key]=false;
      }
    });
  }
}