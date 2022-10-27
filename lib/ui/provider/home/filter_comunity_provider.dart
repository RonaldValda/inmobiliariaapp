import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';

class FilterComunityProvider with ChangeNotifier{
  Map<String,dynamic> _mapFilter={
    "church":false,
    "playground":false,
    "school":false,
    "university":false,
    "small_square":false
  };
  Map<String,dynamic> _mapFilterPlus={
    "police_module":false,
    "public_sauna_pool":false,
    "public_gym":false,
    "sport_center":false,
    "post_health":false,
    "shooping_zone":false
  };
  Map<String,dynamic> get mapFilter => _mapFilter;

  void setMapFilterItem(String key,dynamic value,{required BuildContext context}){
    this._mapFilter[key]=value;
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  Map<String,dynamic> get mapFilterPlus => _mapFilterPlus;
  void setMapFilterPlusItem(String key,dynamic value,{required BuildContext context}){
    this._mapFilterPlus[key]=value;
    context.read<PropertiesProvider>().filterProperties(context: context);
    notifyListeners();
  }
  void init(){
    _mapFilter.forEach((key, value) { 
      _mapFilter[key]=false;
    });
    _mapFilterPlus.forEach((key, value) { 
      _mapFilterPlus[key]=false;
    });
  }
}