import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';
class FilterUserProvider with ChangeNotifier{
   Map<String,dynamic> _mapFilter={
    "viewed":false,
    "viewed_double":false,
    "favorites":false,
  };
  Map<String,dynamic> _mapFilterPlus={
    "contacteds":false
  };
  Map<String,dynamic> get mapFilter => _mapFilter;
  /*void setMapaFiltro(Map<String,dynamic> mapaFiltro){
    this._mapaFiltro=mapaFiltro;
    notifyListeners();
  }*/
  void setMapFilterItem(String key,dynamic value,{required BuildContext context}){
    _mapFilter[key]=value;
    context.read<PropertiesProvider>().filterProperties(context: context);
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
  void init(){
    _mapFilter.forEach((key, value) { 
      _mapFilter[key]=false;
    });
    _mapFilterPlus["contacteds"]=false;
    notifyListeners();
  }
}